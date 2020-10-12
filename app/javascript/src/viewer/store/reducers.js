import { combineReducers } from '@reduxjs/toolkit'
import viewerReducer from './slices/viewer'

const rootReducer = combineReducers({
  viewer: viewerReducer,
})

export default rootReducer
