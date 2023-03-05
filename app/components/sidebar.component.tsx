import Image from 'next/image'
import Link from 'next/link'
import Logo from "../public/Logo.png"

import { FaHome, FaUserEdit, FaCoins } from "react-icons/fa";
import { SidebarProps } from '../types';



export const Sidebar = ({name, username, id}: SidebarProps) => {

  return (
    <div className="sidebar">
      <div className="top">
        <div className="logoContainer">
          <Image
            src={Logo}
          />
        </div>
        <Link href = {`/profile`}>
          <a>
            <FaUserEdit /> Edit Profile
          </a>
        </Link>
        <Link href = "/">
          <a>
            <FaHome /> Talent Board
          </a>
        </Link>
        <Link href = "/explore">
          <a>
            <FaCoins /> Token Swaps
          </a>
        </Link>
      </div>
      <div className="bottom">
        {name !== undefined ? (
          <div className="you">
            <b>{name}</b> <br />
            <Link href = {`user/${id}`}>
              <a>
              @{username}
              </a>
            </Link>
          </div>
        ) : (
          <></>
        )}
      </div>
    </div>
  );
};
