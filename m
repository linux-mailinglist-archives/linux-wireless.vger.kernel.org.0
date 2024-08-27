Return-Path: <linux-wireless+bounces-12098-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAC596190A
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 23:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EDEC1C20C0E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 21:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4B11D31BA;
	Tue, 27 Aug 2024 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="PnSPCpc5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BCC481CD;
	Tue, 27 Aug 2024 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793254; cv=none; b=JKlVuT7hQRFF60ASCJavmoxpWAIXo6OurUPVD1jL8wcOzmS5RusrIqBz0ot/N9ob1xpcau4CB2ZA644HHlg+OjSsNKP+Cgfc3Sq9WPqRaSakotItiQJGb0iXsK5xB+dGtv2kkMOPQu4ZN4uY5v1tYnlYe0UboO7hUq9GvV2d8mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793254; c=relaxed/simple;
	bh=ZSeBlgEKcx4s8dxVDlf3apmWDUm3zykf2lb3uVvl6iQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TloEAF/J4C6qNP01TWkQpSMCo1lhMUVX61z5zLt4eYjVMIbuYcxW6BRFLBukKVPl4/xvVkHxNXr8/VYkRHDmtblOBktHl7hQYuRXi5H2Hsr11CUFUAlJdEU+cg7cJRi85GbDLvz5zmpmeNUPhPFBFkxFTJno/zMc8Bhvi1xWCeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=PnSPCpc5; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1724793192; x=1725397992; i=spasswolf@web.de;
	bh=xfqXOZc+766507kklCUwhhyqL2MZM2kjb/gAvpx7HV4=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PnSPCpc5vFdtsbHk92t3rVA0tHpEvIh0ymfBnmtJKNImgWoTZJxgEzSWqz5s2Bo+
	 ZiR4ry2evesxZwKf9Vj5hjOyNCvjSeD3wVkcxOUaQvsHNPBXRRJYgzm/VQCgbVVlI
	 H10LlUoAkV4pOU/8hE7RZyetwIv0iYrQZdIcmRzJX+Ln3EETQ3ewx4my/S/wsullq
	 lvC7QJHzTTyRvGitxpM2Kp5WjoahXbLIrFozmF5BoOP45iZFQrDEdcXf/fdLa1J1H
	 FsP6z4buQn1JB6I2DOlevarm91V3rnFYHJEUzoU2pjEe80CLHp6VApqfhZHeyOoon
	 +VFco17WQc0WWtiSiA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2SL5-1rxbJ244fH-012twG; Tue, 27
 Aug 2024 23:13:12 +0200
Message-ID: <51e80bde6e3f3256ecdea2e5260463341e65578e.camel@web.de>
Subject: Re: [PATCH] wifi: mt76: mt7921: fix null pointer access in
 mt792x_mac_link_bss_remove
From: Bert Karwatzki <spasswolf@web.de>
To: Mike Lothian <mike@fireburn.co.uk>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, 
	sean.wang@kernel.org, nbd@nbd.name, lorenzo.bianconi@redhat.com, 
	sean.wang@mediatek.com, deren.wu@mediatek.com, mingyen.hsieh@mediatek.com, 
	linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	spasswolf@web.de
Date: Tue, 27 Aug 2024 23:13:10 +0200
In-Reply-To: <CAHbf0-EBHERbxPGakY4-1jTQWqGqua3F0OYZjxcakdemJ5Soqw@mail.gmail.com>
References: <20240718234633.12737-1-sean.wang@kernel.org>
	 <0124ff39-7d63-49f8-bacd-3a40ce37ec4d@leemhuis.info>
	 <CAHbf0-Hn=ZyYpk7bS1yLK7K3ZpfWKgt3-t=c9Nhdj3Ov3H84mQ@mail.gmail.com>
	 <f7197c55d059cc8ddbf6c3def16dc414c5ec0b42.camel@web.de>
	 <CAHbf0-EBHERbxPGakY4-1jTQWqGqua3F0OYZjxcakdemJ5Soqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kqpKExKkptcgwCeoH0RfHXQVHBIgSoraFMqhlrftXDuJxwCi6p2
 QxcVUgX+JOqboen9F0mJQ6mfr4XrICbPczwJLxZ5tzVh2FA6K3FAJj30UfAJLV8xC1bJRb6
 1kGpZCq3h1HjKq99N3F3O/Ewde4NpVXyJB6FoBEab+UykZjCiLeA12XlxPqYPuAkDJzmEb/
 ualTiaHRtu6JEtSlr8zMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:itHwOWHJ/RQ=;Bul3gZQlJXvufanW94AO28rOGQA
 f4+MZWkUx5YdZoYifN3KwOvTtNCyKtSYLi7eRR2DNvixcWRwxT2eFOzp1OIljC0Ueyxh/d4hb
 nsNtkuRj/dhYyt8FqfWjuBmHChz8ybHS3CFniRAG0G6UAsb/YAtpB8SPRhD5Fco5I9CS1Js0e
 +1KF0pO1MBtWfYQN5jkghSdUgYUGNHaILcE73qEXwTavMzbbNs6e58wiQbGz+s5d+Conhwo91
 kWijMyD5EmDm2ItI6gkXxOkqFlTVSk0hKqVZWVOpM35x5+NY762Q4feYQvAgqDde5K5lTOy9e
 or2EMExz9C3JCND6ZBM73ytukgusc7J7j31fXk3pJe0X/1PyA4ZDpzLlLxPsbtBh4ni2GFiNW
 TqMRdX9jh86J72C0k4JxLddddZybACpYim0lgWqymg8KMl+NuEO/DxNO15AjXhoMVKHV7bSpg
 CALpuvnG+cibn7VCpgfl/t7B1B9RxovqQ4zl0VCuG0Xt/BYxo5vLRFFtCyNeAGonAEMor9jn2
 wwLh4cRllKHW5VNifEaIXKndHXHeTnOmEIVK9BeQxy+RpjJNmcIy6ALE8nYAbjOHPb02B7vZh
 9p1UEIbL+gpRyGCFL1pJs5YQesgwX6mh36djIzAWdn2a4WzIgxS35Y158cER+Af6HtpUrm7EV
 mslRJnMAAzSPXgZw7qZ9NBH7nrW7sP+OpzKVR+fSywiMS6moZqEmDNNpgfd+BgHW0coEWxjoF
 S/WIuDGTXXH+PGvo2A3P6YViE7IpN3leKnGx3eIebV7N6Hj8WqOwg/+f/7PGwFvCC+ONsLUPS
 TowuWs+SYBUx6edF/HQl2klg==

Am Dienstag, dem 27.08.2024 um 17:30 +0100 schrieb Mike Lothian:
> Hi
>
> This fix hasn't made it upstream yet, has it fallen through the cracks?
>
> Cheers
>
> Mike
>
> On Thu, 1 Aug 2024 at 17:58, Bert Karwatzki <spasswolf@web.de> wrote:
> >
> > Am Donnerstag, dem 01.08.2024 um 13:38 +0100 schrieb Mike Lothian:
> > > I also saw the following after I restarted my router on two machines=
 -
> > > they both have this fix applied already:
> > >
> > > Aug 01 08:59:33 quark kernel: BUG: kernel NULL pointer dereference,
> > > address: 0000000000000008
> > > Aug 01 08:59:33 quark kernel: #PF: supervisor read access in kernel =
mode
> > > Aug 01 08:59:33 quark kernel: #PF: error_code(0x0000) - not-present =
page
> > > Aug 01 08:59:33 quark kernel: PGD 0 P4D 0
> > > Aug 01 08:59:33 quark kernel: Oops: Oops: 0000 [#1] PREEMPT SMP
> > > Aug 01 08:59:33 quark kernel: CPU: 13 UID: 0 PID: 468 Comm:
> > > NetworkManager Not tainted 6.11.0-rc1-tip+ #3200
> > > 9c927d6f3c59d826d15d8e39c195392d1d16b8a8
> > > Aug 01 08:59:33 quark kernel: Hardware name: Micro Computer (HK) Tec=
h
> > > Limited EliteMini Series/HPBSD, BIOS 1.02 03/28/2024
> > > Aug 01 08:59:33 quark kernel: RIP: 0010:mt7921_ipv6_addr_change
> > > Aug 01 08:59:33 quark kernel: Code: 41 57 41 56 41 54 53 48 83 e4 f0
> > > 48 83 ec 50 48 8b 86 70 09 00 00 0f b6 8e 90 04 00 00 4c 8d ba 68 02
> > > 00 00 49 89 d6 4c 89 ff <48> 8b 58 08 88 4c 24 04 66 c7 44 24 05 00 =
00
> > > c6 44 24 07 00 66 c7
> > > Aug 01 08:59:33 quark kernel: RSP: 0018:ffffc900069373b0 EFLAGS: 000=
10282
> > > Aug 01 08:59:33 quark kernel: RAX: 0000000000000000 RBX:
> > > ffff888106740920 RCX: 0000000000000000
> > > Aug 01 08:59:33 quark kernel: RDX: ffff888106854800 RSI:
> > > ffff88810bb35ca0 RDI: ffff888106854a68
> > > Aug 01 08:59:33 quark kernel: RBP: ffffc90006937420 R08:
> > > 0000000000000000 R09: ffff888104c98200
> > > Aug 01 08:59:33 quark kernel: R10: ffffffff7fff0000 R11:
> > > 0000000000000020 R12: 0000000000000002
> > > Aug 01 08:59:33 quark kernel: R13: 0000000000000000 R14:
> > > ffff888106854800 R15: ffff888106854a68
> > > Aug 01 08:59:33 quark kernel: FS:  00007f4265049400(0000)
> > > GS:ffff888c2df40000(0000) knlGS:0000000000000000
> > > Aug 01 08:59:33 quark kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000=
00080050033
> > > Aug 01 08:59:33 quark kernel: CR2: 0000000000000008 CR3:
> > > 0000000117250000 CR4: 0000000000350ef0
> > > Aug 01 08:59:33 quark kernel: Call Trace:
> > > Aug 01 08:59:33 quark kernel:  <TASK>
> > > Aug 01 08:59:33 quark kernel:  ? __die_body+0x66/0xb0
> > > Aug 01 08:59:33 quark kernel:  ? page_fault_oops+0x39a/0x410
> > > Aug 01 08:59:33 quark kernel:  ? exc_page_fault+0x59/0xa0
> > > Aug 01 08:59:33 quark kernel:  ? asm_exc_page_fault+0x22/0x30
> > > Aug 01 08:59:33 quark kernel:  ? mt7921_ipv6_addr_change
> > > Aug 01 08:59:33 quark kernel:  ? __try_to_del_timer_sync
> > > Aug 01 08:59:33 quark kernel:  ieee80211_ifa6_changed+0x68/0x120
> > > Aug 01 08:59:33 quark kernel:  atomic_notifier_call_chain+0x45/0xc0
> > > Aug 01 08:59:33 quark kernel:  addrconf_ifdown+0x521/0x7d0
> > > Aug 01 08:59:33 quark kernel:  addrconf_notify+0x1ed/0x4a0
> > > Aug 01 08:59:33 quark kernel:  raw_notifier_call_chain+0x45/0xb0
> > > Aug 01 08:59:33 quark kernel:  __dev_notify_flags+0xf4/0x200
> > > Aug 01 08:59:33 quark kernel:  dev_change_flags+0x49/0x50
> > > Aug 01 08:59:33 quark kernel:  do_setlink+0x49b/0x1300
> > > Aug 01 08:59:33 quark kernel:  ? terminate_walk+0x6b/0x100
> > > Aug 01 08:59:33 quark kernel:  ? __nla_validate_parse
> > > Aug 01 08:59:33 quark kernel:  ? filename_lookup+0xc7/0x1b0
> > > Aug 01 08:59:33 quark kernel:  rtnl_newlink+0xb6a/0xde0
> > > Aug 01 08:59:33 quark kernel:  ? __wake_up_sync_key+0x51/0x80
> > > Aug 01 08:59:33 quark kernel:  ? scm_destroy+0xc/0x30
> > > Aug 01 08:59:33 quark kernel:  ? security_capable+0x38/0x50
> > > Aug 01 08:59:33 quark kernel:  rtnetlink_rcv_msg+0x2dd/0x330
> > > Aug 01 08:59:33 quark kernel:  ? select_task_rq_fair
> > > Aug 01 08:59:33 quark kernel:  ? rtnetlink_bind+0x30/0x30
> > > Aug 01 08:59:33 quark kernel:  netlink_rcv_skb+0xb5/0xf0
> > > Aug 01 08:59:33 quark kernel:  netlink_unicast+0x230/0x330
> > > Aug 01 08:59:33 quark kernel:  netlink_sendmsg+0x3b1/0x460
> > > Aug 01 08:59:33 quark kernel:  ____sys_sendmsg
> > > Aug 01 08:59:33 quark kernel:  ? chacha_block_generic+0x6a/0x130
> > > Aug 01 08:59:33 quark kernel:  ___sys_sendmsg+0x282/0x2a0
> > > Aug 01 08:59:33 quark kernel:  ? __fget_files+0x95/0xb0
> > > Aug 01 08:59:33 quark kernel:  __se_sys_sendmsg+0xf4/0x120
> > > Aug 01 08:59:33 quark kernel:  do_syscall_64+0x7e/0x130
> > > Aug 01 08:59:33 quark kernel:  ? pollwake+0x52/0x60
> > > Aug 01 08:59:33 quark kernel:  ? do_task_dead+0x50/0x50
> > > Aug 01 08:59:33 quark kernel:  ? __wake_up_locked_key+0x48/0x70
> > > Aug 01 08:59:33 quark kernel:  ? eventfd_write+0x193/0x1b0
> > > Aug 01 08:59:33 quark kernel:  ? syscall_exit_to_user_mode+0x93/0xc0
> > > Aug 01 08:59:33 quark kernel:  ? vfs_write+0xfa/0x3d0
> > > Aug 01 08:59:33 quark kernel:  ? __fget_files+0x95/0xb0
> > > Aug 01 08:59:33 quark kernel:  ? __fget_files+0x95/0xb0
> > > Aug 01 08:59:33 quark kernel:  ? ksys_write+0x8f/0xb0
> > > Aug 01 08:59:33 quark kernel:  ? arch_exit_to_user_mode_prepare+0x11=
/0x50
> > > Aug 01 08:59:33 quark kernel:  ? syscall_exit_to_user_mode+0x93/0xc0
> > > Aug 01 08:59:33 quark kernel:  ? do_syscall_64+0x8a/0x130
> > > Aug 01 08:59:33 quark kernel:  ? syscall_exit_to_user_mode+0x93/0xc0
> > > Aug 01 08:59:33 quark kernel:  ? do_syscall_64+0x8a/0x130
> > > Aug 01 08:59:33 quark kernel:  ? do_syscall_64+0x8a/0x130
> > > Aug 01 08:59:33 quark kernel:  ? do_syscall_64+0x8a/0x130
> > > Aug 01 08:59:33 quark kernel:  ? arch_exit_to_user_mode_prepare+0x11=
/0x50
> > > Aug 01 08:59:33 quark kernel:  entry_SYSCALL_64_after_hwframe+0x4b/0=
x53
> > > Aug 01 08:59:33 quark kernel: RIP: 0033:0x7f4264d31fae
> > > Aug 01 08:59:33 quark kernel: Code: 20 89 54 24 1c 48 89 74 24 10 89
> > > 7c 24 08 e8 a9 75 f7 ff 41 89 c0 8b 54 24 1c 48 8b 74 24 10 b8 2e 00
> > > 00 00 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 3a 44 89 c7 48 89 44 =
24
> > > 08 e8 fd 75 f7 ff 48
> > > Aug 01 08:59:33 quark kernel: RSP: 002b:00007ffff4b1afa0 EFLAGS:
> > > 00000293 ORIG_RAX: 000000000000002e
> > > Aug 01 08:59:33 quark kernel: RAX: ffffffffffffffda RBX:
> > > 000055c35260c570 RCX: 00007f4264d31fae
> > > Aug 01 08:59:33 quark kernel: RDX: 0000000000000000 RSI:
> > > 00007ffff4b1afe0 RDI: 000000000000000d
> > > Aug 01 08:59:33 quark kernel: RBP: 00007ffff4b1b050 R08:
> > > 0000000000000000 R09: 0000000000000000
> > > Aug 01 08:59:33 quark kernel: R10: 000000000000009d R11:
> > > 0000000000000293 R12: 0000000000000004
> > > Aug 01 08:59:33 quark kernel: R13: 0000000000000000 R14:
> > > 0000000000000000 R15: 0000000000000000
> > > Aug 01 08:59:33 quark kernel:  </TASK>
> > > Aug 01 08:59:33 quark kernel: Modules linked in:
> > > Aug 01 08:59:33 quark kernel: CR2: 0000000000000008
> > > Aug 01 08:59:33 quark kernel: ---[ end trace 0000000000000000 ]---
> > > Aug 01 08:59:33 quark kernel: RIP: 0010:mt7921_ipv6_addr_change
> > > Aug 01 08:59:33 quark kernel: Code: 41 57 41 56 41 54 53 48 83 e4 f0
> > > 48 83 ec 50 48 8b 86 70 09 00 00 0f b6 8e 90 04 00 00 4c 8d ba 68 02
> > > 00 00 49 89 d6 4c 89 ff <48> 8b 58 08 88 4c 24 04 66 c7 44 24 05 00 =
00
> > > c6 44 24 07 00 66 c7
> > > Aug 01 08:59:33 quark kernel: RSP: 0018:ffffc900069373b0 EFLAGS: 000=
10282
> > > Aug 01 08:59:33 quark kernel: RAX: 0000000000000000 RBX:
> > > ffff888106740920 RCX: 0000000000000000
> > > Aug 01 08:59:33 quark kernel: RDX: ffff888106854800 RSI:
> > > ffff88810bb35ca0 RDI: ffff888106854a68
> > > Aug 01 08:59:33 quark kernel: RBP: ffffc90006937420 R08:
> > > 0000000000000000 R09: ffff888104c98200
> > > Aug 01 08:59:33 quark kernel: R10: ffffffff7fff0000 R11:
> > > 0000000000000020 R12: 0000000000000002
> > > Aug 01 08:59:33 quark kernel: R13: 0000000000000000 R14:
> > > ffff888106854800 R15: ffff888106854a68
> > > Aug 01 08:59:33 quark kernel: FS:  00007f4265049400(0000)
> > > GS:ffff888c2df40000(0000) knlGS:0000000000000000
> > > Aug 01 08:59:33 quark kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000=
00080050033
> > > Aug 01 08:59:33 quark kernel: CR2: 0000000000000008 CR3:
> > > 0000000117250000 CR4: 0000000000350ef0
> > >
> > > On Wed, 24 Jul 2024 at 10:36, Linux regression tracking (Thorsten
> > > Leemhuis) <regressions@leemhuis.info> wrote:
> > > >
> > > >
> > > >
> > > > On 19.07.24 01:46, sean.wang@kernel.org wrote:
> > > > > From: Sean Wang <sean.wang@mediatek.com>
> > > > >
> > > > > Fix null pointer access in mt792x_mac_link_bss_remove.
> > > > >
> > > > > To prevent null pointer access, we should assign the vif to bss_=
conf in
> > > > > mt7921_add_interface. This ensures that subsequent operations on=
 the BSS
> > > > > can properly reference the correct vif.
> > > > >
> > > > > [...]
> > > > > > Fixes: 1541d63c5fe2 ("wifi: mt76: mt7925: add
> > > > mt7925_mac_link_bss_remove to remove per-link BSS")
> > > > > Reported-by: Bert Karwatzki <spasswolf@web.de>
> > > > > Closes: https://lore.kernel.org/linux-wireless/2fee61f8c903d02a9=
00ca3188c3742c7effd102e.camel@web.de/#b
> > > > > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > > >
> > > > TWIMC, Mike (now CCed) ran into the problem and on bugzilla confir=
med
> > > > that this fixes the problem:
> > > >
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=3D219084
> > > > https://lore.kernel.org/all/CAHbf0-HOS-jdRGvJOBmEgaaox3PDbDSTgnnZk=
ZF9pz37Bmh2iw@mail.gmail.com/
> > > >
> > > > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker=
' hat)
> > > > --
> > > > Everything you wanna know about Linux kernel regression tracking:d
> > > > https://linux-regtracking.leemhuis.info/about/#tldr
> > > > If I did something stupid, please tell me, as explained on that pa=
ge.
> >
> > The fix to this issue has been posted here by Felix Fietkau:
> > > Am Mittwoch, dem 17.07.2024 um 17:25 +0200 schrieb Felix Fietkau:
> > >
> > > This change should fix it: https://nbd.name/p/0747f54f
> > > Please test.
> > >
> > > Thanks,
> > >
> > > - Felix
> >
> > Bert Karwatzki

It's in linux-6.11-rc4 and later:

commit 479ffee68d59c599f8aed8fa2dcc8e13e7bd13c3
Author: Bert Karwatzki <spasswolf@web.de>
Date:   Mon Aug 12 12:45:41 2024 +0200

    wifi: mt76: mt7921: fix NULL pointer access in mt7921_ipv6_addr_change

    When disabling wifi mt7921_ipv6_addr_change() is called as a notifier.
    At this point mvif->phy is already NULL so we cannot use it here.

    Signed-off-by: Bert Karwatzki <spasswolf@web.de>
    Signed-off-by: Felix Fietkau <nbd@nbd.name>
    Signed-off-by: Kalle Valo <kvalo@kernel.org>
    Link: https://patch.msgid.link/20240812104542.80760-1-spasswolf@web.de


Bert Karwatzki



