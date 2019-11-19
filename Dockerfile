# Using 'as' to tag the phase and allowing it to be referenced back by other process
# only results of this phase would be 'returned'

FROM node:alpine as builder
WORKDIR /app

COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build <--- contains al the generated static files to used by nginx
# Run Phase starts
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

# there is no need to start nginx manually,
# when imported, it automaticaaly starts listening



