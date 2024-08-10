import { defineConfig } from 'vite'
import elmPlug from 'vite-plugin-elm'

export default defineConfig({
    server: {
        proxy: {
            '/redoc':{
                target: 'http://127.0.0.1:8000',
                changeOrigin: true,
                rewrite: (path) => {
                    console.log('fetching ', path)
                    return path
                }
            },

            '/docs':{
                target: 'http://127.0.0.1:8000',
                changeOrigin: true,
                rewrite: (path) => {
                    console.log('fetching ', path)
                    return path
                }
            },

            '/openapi.json':{
                target: 'http://127.0.0.1:8000',
                changeOrigin: true,
                rewrite: (path) => {
                    console.log('fetching ', path)
                    return path
                }
            },
            '/api': {
                target: 'http://127.0.0.1:8000',
                changeOrigin: true,
                rewrite: (path) => {
                    console.log('running api', path)
                    return path
                }

            }
        }
    },
    plugins: [elmPlug()]
})
