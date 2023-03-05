import Post from '../components/post.component'
import styles from "../styles/Home.module.scss"

import type { NextPage } from 'next'

import { useEffect, useState } from 'react'
import { useCeramicContext } from '../context'
import { PostProps } from '../types'

const ExplorePage: NextPage = () => {
    
  return (
    <div className = "content">
      <h1> Swap any tokens to USDC </h1>
    </div>
  )
}

export default ExplorePage