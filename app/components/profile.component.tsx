import Link from "next/link"
import styles from "../styles/Home.module.scss"

import { Profile } from "../types"

const ProfileComponent = (profile: Profile) => {
  return (
    <div className = {styles.post} key = {profile.id}>
      <div>{profile.name}</div>
      <div>{profile.username}</div>
      <div>{profile.description}</div>
      <div>{profile.gender}</div>
      <Link href = {`/user/${profile.id}`}>
        <a>
          {profile.name} <small>@{profile.username}</small>
        </a>
      </Link>
    </div>
  )
}

export default ProfileComponent