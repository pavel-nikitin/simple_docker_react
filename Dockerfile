FROM node:21-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#Second FROM also means second fase
#--from=builder means copy form builder fase
#/app/build - folder path from builder fase (copy from)
#/usr/share/nginx/html - folder path nginx fase image (copy to)
#/usr/share/nginx/html - default folder for nginx to serve static content
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html