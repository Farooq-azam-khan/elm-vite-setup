import './tailwind.css'
import { Elm } from './src/Main.elm' 

const LOCAL_STORAGE_APP_NAME_PREFIX = 'webux'
const user_settings_key = `${LOCAL_STORAGE_APP_NAME_PREFIX}_user_settings`

document.addEventListener('DOMContentLoaded', () => {
    const root = document.getElementById('app')
    if (!root) { 
        console.log('root element not found') 
        return 
    } 
    const app = Elm.Main.init({
          node: root 
    })

    app.ports.save_user_settings((message: any) => {
        localStorage.setItem(user_settings_key, JSON.stringify(message))
    })
    
})

