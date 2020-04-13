Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB69A1A6C6B
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2020 21:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgDMTXp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Apr 2020 15:23:45 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:53529 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727849AbgDMTXo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Apr 2020 15:23:44 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id E691F8E8;
        Mon, 13 Apr 2020 15:23:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 13 Apr 2020 15:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=Bz4sb+dJNFH90cgiWOuY1iveZlWn1
        c8PqK8M2Hx0kYY=; b=aI9Ne7bDuKoZLvBCi++qRNZyk7U8dcscl0NPpXmrWSaIl
        5HhM+JyWMKRKDVC9YN4ieH8G7XDJRcm7Vs5GNGBF0qGyrnME28ut9NkjQ/LQUKWw
        nsFz810lvNSjBZPIsmVjxhsCz7zuCw+QYLDc4N70axPslE69W4wGLV/bFKDeNMcn
        7S18KzTPD7fRSrau7xsuowQz1DeGzs0Vufxa2qQ01tFLGmurd2UNPVcBwAfJXH09
        pUUvTZodSLN5CTpOg+9i6UvYDQrNhkH4WxD73WRKOWNKEZcikcHeMoCHhVG+bd2v
        abUoZue9fPOeTtKsOfqhEMDkoAg9tfgWbCc0DUJIw==
X-ME-Sender: <xms:PryUXpF6tecEFOS7VZ7MYNmdzvsrYEBmwP24ADMlum1dsqyJvUipuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrvdelgddufeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepvffhuffkffgfgggtsehg
    tderofdtfeejnecuhfhrohhmpefrrgifvghlpgforghrtgiivgifshhkihcuoehprgifvg
    hlsehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuffhomhgrihhnpehg
    ihhthhhusgdrtghomhdpghhoohhglhgvrdgtohhmnecukfhppeekledrieegrdejkedrud
    eljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    rgifvghlsehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:PryUXuf2oHpj0u5SwIecXZqhI2gbbLs4l1CDt0oZIXdJE_SCVbjOUg>
    <xmx:PryUXjG0IzGcZiQQ0JXdLVPex1qH7-sDmhlRyM9M-KBOoi0rFTC3JQ>
    <xmx:PryUXnV_cv4QrtBX5F_-CHixkBJPj-Xu7hlGnHl8_OeWyZA_Pz0yGQ>
    <xmx:PryUXslmhlqsITliY3jFf6IkhaPguLRnCT03TTu9SCXx1SZDqHtHeg>
Received: from [10.137.0.16] (89-64-78-197.dynamic.chello.pl [89.64.78.197])
        by mail.messagingengine.com (Postfix) with ESMTPA id 67A8D3060066;
        Mon, 13 Apr 2020 15:23:41 -0400 (EDT)
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?= 
        <marmarek@invisiblethingslab.com>
From:   =?UTF-8?Q?Pawe=c5=82_Marczewski?= <pawel@invisiblethingslab.com>
Subject: Intel AC 9462 driver fails to load under Xen (Failed to configure RX
 queues)
Message-ID: <3cab5072-17a2-4d9a-2077-93788971c6c4@invisiblethingslab.com>
Date:   Mon, 13 Apr 2020 21:23:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="guj0pO3JBa79OFllJdA9nS0X4OiHBWgOv"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--guj0pO3JBa79OFllJdA9nS0X4OiHBWgOv
Content-Type: multipart/mixed; boundary="eRESL2xn4yuQWdBsKuISxtMy1YednB2iZ";
 protected-headers="v1"
From: =?UTF-8?Q?Pawe=c5=82_Marczewski?= <pawel@invisiblethingslab.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?=
 <marmarek@invisiblethingslab.com>
Message-ID: <3cab5072-17a2-4d9a-2077-93788971c6c4@invisiblethingslab.com>
Subject: Intel AC 9462 driver fails to load under Xen (Failed to configure RX
 queues)

--eRESL2xn4yuQWdBsKuISxtMy1YednB2iZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,
I have an Intel Wireless-AC 9462 and I'm trying to get it working under
Qubes OS (in a Xen HVM domain). The driver fails when I try to bring the
network up:

[   26.012784] iwlwifi 0000:00:07.0: FW error in SYNC CMD
RFH_QUEUE_CONFIG_CMD
[   26.012817] CPU: 0 PID: 1187 Comm: ip Not tainted 5.6.3-1.qubes.x86_64=
 #1
[   26.012833] Hardware name: Xen HVM domU, BIOS 4.13.0 03/11/2020
[   26.012848] Call Trace:
[   26.012860]  dump_stack+0x66/0x90
[   26.012884]  iwl_trans_pcie_gen2_send_hcmd+0x405/0x410 [iwlwifi]
[   26.012902]  ? finish_wait+0x80/0x80
[   26.012918]  iwl_trans_send_cmd+0x51/0xb0 [iwlwifi]
[   26.012938]  iwl_mvm_send_cmd+0x1b/0x40 [iwlmvm]
[   26.012955]  iwl_configure_rxq+0x141/0x1b0 [iwlmvm]
[   26.012972]  iwl_mvm_up+0x422/0x960 [iwlmvm]
[   26.012989]  __iwl_mvm_mac_start+0x26/0x1d0 [iwlmvm]
[   26.013006]  iwl_mvm_mac_start+0x24/0x40 [iwlmvm]
[   26.013035]  drv_start+0x43/0xf0 [mac80211]
[   26.013058]  ieee80211_do_open+0x219/0x8e0 [mac80211]
[   26.013082]  ? ieee80211_check_concurrent_iface+0x14f/0x1c0 [mac80211]=

[   26.013102]  __dev_open+0xe0/0x170
[   26.013112]  __dev_change_flags+0x1a1/0x200
[   26.013124]  dev_change_flags+0x21/0x60
[   26.013135]  do_setlink+0x861/0x9b0
[   26.013148]  __rtnl_newlink+0x5d1/0x9a0
[   26.013163]  rtnl_newlink+0x44/0x70
[   26.013172]  rtnetlink_rcv_msg+0x2cb/0x380
[   26.013184]  ? rtnl_calcit.isra.0+0x110/0x110
[   26.013197]  netlink_rcv_skb+0x75/0x140
[   26.013208]  netlink_unicast+0x199/0x240
[   26.013219]  netlink_sendmsg+0x243/0x480
[   26.013231]  sock_sendmsg+0x5e/0x60
[   26.013243]  ____sys_sendmsg+0x21b/0x290
[   26.013253]  ? copy_msghdr_from_user+0xe1/0x160
[   26.013267]  ___sys_sendmsg+0x9e/0xe0
[   26.013280]  __sys_sendmsg+0x81/0xd0
[   26.013291]  do_syscall_64+0x5b/0x1c0
[   26.013304]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   26.013317] RIP: 0033:0x7d18f2170b87
[   26.013331] Code: 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00
00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f
05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[   26.211994] RSP: 002b:00007fff536402c8 EFLAGS: 00000246 ORIG_RAX:
000000000000002e
[   26.212016] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007d18f2170b87
[   26.212035] RDX: 0000000000000000 RSI: 00007fff53640340 RDI:
0000000000000003
[   26.212055] RBP: 000000005e943910 R08: 0000000000000001 R09:
0000000000000230
[   26.212074] R10: 0000000000000040 R11: 0000000000000246 R12:
0000000000000001
[   26.212092] R13: 00007fff53640b10 R14: 00007fff53640410 R15:
00005c5e4aef8020
[   26.212170] iwlwifi 0000:00:07.0: Failed to configure RX queues: -5
[   26.212193] iwlwifi 0000:00:07.0: Hardware error detected.  Restarting=
=2E
[   26.212231] iwlwifi 0000:00:07.0: Firmware not running - cannot dump
error

This is on a 5.6.3 kernel, I also tried 5.4.24 and 5.5.9.

The firmware version is: 48.4fa0041f.0 QuZ-a0-jf-b0-48.u

I can provide full dmesg.log, and a trace (output of 'trace-cmd record
-e iwlwifi -e mac80211 -e cfg80211 -e iwlwifi_msg'). I'm not sure if I
am allowed to send attachments to this list?

As a workaround, I tried to remove the call that was apparently causing
the crash (iwl_configure_rxq), see patch below. This actually worked,
and I can use wifi now.

I'm not sure if it's related, but Qubes OS users report similar crashes
when trying to run Intel AX200 [1] [2].

[1] https://github.com/QubesOS/qubes-issues/issues/5615
[2] https://groups.google.com/forum/#!topic/qubes-users/7VcN8kkKop0

The workaround:

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 98263cd37944..943831c9b685 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1111,15 +1111,6 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 		goto error;

 	/* Init RSS configuration */
-	if (mvm->trans->trans_cfg->device_family >=3D IWL_DEVICE_FAMILY_22000) =
{
-		ret =3D iwl_configure_rxq(mvm);
-		if (ret) {
-			IWL_ERR(mvm, "Failed to configure RX queues: %d\n",
-				ret);
-			goto error;
-		}
-	}
-
 	if (iwl_mvm_has_new_rx_api(mvm)) {
 		ret =3D iwl_send_rss_cfg_cmd(mvm);
 		if (ret) {

P.S. My apologies if you're seeing this message for the second time - I
tried to send it before and I think it was dropped because I cannot see
it in any of the archives.

--=20
Pawe=C5=82 Marczewski
Invisible Things Lab


--eRESL2xn4yuQWdBsKuISxtMy1YednB2iZ--

--guj0pO3JBa79OFllJdA9nS0X4OiHBWgOv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE/lXHjcDA2QUg95RNrRTL02Efx6sFAl6UvDoACgkQrRTL02Ef
x6tDGg//awJZSGM9nBRKBwok/361wmo2KhaqfE3o2xR9sqpvSAVDBpLCDdXUpkVy
ENjyh4IKgHIguSwZEwT/USZ1cRiJKS2BRs7NOzDbrlWhLYaxOBkm1GXJLQWOtkUL
pXfZML3Z5GPol+2tCXxscvJet56F0IXvCbF+yDIn+x4Ba2XPzoGmbaOlfFp3HqZz
fmjlzf+DTuNaOjRy/OOnEt0c6eiD8SAVs0xaACDa80SattSpmyZvqGyrpGuPaML3
Ir+ucz1s6MPwUGgiAvBVRxUCHaznSk0NnBC7l563kNuXINup/Qt3TqsidBQTrkU9
64yT/AFSBGJad728Z32INWYcFG+rZkDowrnhuixHVXZledE+twS0+DkZQVON2xY3
gi1KLXZF7tR/e+sVHWP7ZItMmz8ZIfkQufm3jLFKtfw8P0ldFs69i/1R9Mdo89lE
NxCIpUoTgn7e2So54K+NVvupAdUAl3K0IZKvD9MQ8bBIE1QCzrR2lx2+Vc+kq1vy
9ACZ0TcaIv/q+9iZ3TA4/uujc/1yLBCq+UyY5T4ZfKUEbeP98OERCBmOtEks07V9
UGVj2a5FN1Ig//5hqKMd81JtHxEoOQKTdTwqy95QWGaiiU6a/WkZeqsqFvTuCJhV
bmFXsmMvyXFnyFiQ5N/cuhC56LElI1k0yvkcNslzCZFa9LssXCs=
=mbQA
-----END PGP SIGNATURE-----

--guj0pO3JBa79OFllJdA9nS0X4OiHBWgOv--
