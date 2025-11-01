# --- Этап 1: Build stage ---
FROM node:20 AS build

WORKDIR /app

# Копируем зависимости
COPY package*.json ./

# Устанавливаем все зависимости (включая dev)
RUN npm install

# Копируем остальной проект
COPY . .

# Собираем админку Strapi
RUN npm run build

# --- Этап 2: Production stage ---
FROM node:20-alpine

WORKDIR /app

# Копируем только нужные файлы для продакшена
COPY package*.json ./

# Устанавливаем только прод-зависимости
RUN npm install --omit=dev

# Копируем билд и исходники из первого этапа
COPY --from=build /app ./

# Открываем порт Strapi
EXPOSE 1337

# Запускаем Strapi
CMD ["npm", "run", "start"]
