import { defineConfig } from 'vite'
import elmPlug from 'vite-plugin-elm'

export default defineConfig({
    server: {
        proxy: {
            '/api': {
                target: 'http://127.0.0.1:8000',
                changeOrigin: true,
                rewrite: (path) => {
                    console.log('running path2', path)
                    return path// .replace(/^\/api/, '')
                }

            }
        }
    },
    plugins: [elmPlug()]
})
