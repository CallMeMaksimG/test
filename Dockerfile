# Используем Node.js LTS
FROM node:20-alpine

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json
COPY package*.json ./

# Устанавливаем зависимости (production)
RUN npm ci --omit=dev

# Копируем весь проект
COPY . .

# Строим админку Strapi 5
RUN npx strapi build

# Открываем порт Strapi
EXPOSE 1337

# Запускаем Strapi
CMD ["npx", "strapi", "start"]
