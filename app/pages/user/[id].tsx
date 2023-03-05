import type { NextPage } from 'next'
import { useRouter } from 'next/router'
import { useEffect, useState } from 'react'

import { useCeramicContext } from '../../context'
import { Author, Posts } from '../../types'

import Head from 'next/head'
import Post from '../../components/post.component'
import styles from "../../styles/Home.module.scss"
import userStyles from "../../styles/user.module.scss"

const UserProfile: NextPage = () => {
  const router = useRouter()
  const { id } = router.query

  const clients = useCeramicContext()
  const { ceramic, composeClient } = clients
  const [ profile, setProfile ] = useState<Author | {}>({})
  const [ payAmount, setPayAmount] = useState(0)
  const [ payInterval, setPayInterval] = useState(1)

  const getData = async () => {
    const data = await composeClient.executeQuery(`
      query {
        node (id: "${id}") {
          ... on BasicProfile {
            id
            username
            name
            emoji
            posts (last:300) {
              edges {
                node {
                  id
                  body
                  created
                }
              }
            }
          }
        }
      }
    `)
    console.log(data)
    setProfile({
      name: data.data.node.name,
      username: data.data.node.username,
      id: data.data.node.id,
      emoji: data.data.node.emoji
    })
  }

  useEffect(() => {
    getData()
  }, [])

  return (
    <>
      <Head>
        <title>{profile !== undefined ? `${profile?.username}'s Profile`: 'No profile'}</title>
      </Head>
      { profile !== undefined 
        ?
          <div className = "content">
            <div className={userStyles.details}>
              <p>
                {profile.emoji} ETH </p>
                <p>{profile.name} {" "} </p>
                <p>@{profile.username} </p>

            <div className="">
              <label className="">Payment</label>
              <input
                className=""
                type="number"
                defaultValue={1}
                onChange={(e) => {
                  setPayAmount(e.target.value)
                }}
              />
            </div>

            <div className="">
              <label className="">Number of pays</label>
              <input
                className=""
                type="string"
                defaultValue={1}
                onChange={(e) => {
                  setPayAmount(e.target.value)
                }}
              />
            </div>

            <button>Choose this builder</button>

            </div>
          </div>
        :
          <div className = "content"></div>
      }
    </>
  )
}

export default UserProfile