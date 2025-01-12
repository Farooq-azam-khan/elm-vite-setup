import './tailwind.css'
import { Elm } from './src/Main.elm' 
import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
//import './index.css'
import RApp from './RApp.tsx'


const LOCAL_STORAGE_APP_NAME_PREFIX = 'webux'
const user_settings_key = `${LOCAL_STORAGE_APP_NAME_PREFIX}_user_settings`
const version_key = `${LOCAL_STORAGE_APP_NAME_PREFIX}_version`
document.addEventListener('DOMContentLoaded', () => {
    const root = document.getElementById('app')
    if (!root) { 
        console.log('root element not found') 
        return 
    }
    
    const local_version = JSON.parse(localStorage.getItem(version_key)) 
    const flags = {local_version, location:window.location.href}
    const app = Elm.Main.init({
          node: root, 
          flags
    })
    app.ports.save_version_to_local_storage?.subscribe((version: string) => {
        console.log('saving', version)
        localStorage.setItem(version_key, JSON.stringify(version));
    })

    app.ports.save_user_settings?.subscribe((message: any) => {
        localStorage.setItem(user_settings_key, message)
    })

    app.ports.hard_refresh?.subscribe(() => {
        console.log('hard refresh')
        location.reload(true)
    })

    // react 

createRoot(document.getElementById('react')!).render(
  <StrictMode>
    <RApp />
  </StrictMode>,
)

    
})

