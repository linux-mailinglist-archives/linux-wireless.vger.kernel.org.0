Return-Path: <linux-wireless+bounces-24593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9F7AEAC67
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 03:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D4C64A5B0D
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Jun 2025 01:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D589513C8FF;
	Fri, 27 Jun 2025 01:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="hBSzQWk8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j7Scsjj9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD0A4430;
	Fri, 27 Jun 2025 01:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750989084; cv=none; b=m8FlAhORovIptWbM0CC1v4gAX91RBFAuIYFRconzGW5E/Bf9g4WOapLMPidbuK3fs45/GlBId9S0/URxCAeZcdcRQmuOc1VVBxEB9Bte//DnJgMCKg/7B8nnYZJ/4Uj2NPH3Cphre58DIy5odoNUv0z2VXO5zKgaNUDsst5+7Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750989084; c=relaxed/simple;
	bh=+kIxTyoD8P+Y3Bubeg2Pd9Muw9lYCvlsJEVQu7aFq6U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kwCjXLlXvMbGHIpbfFtH2rQXM9W3ENUNvM51SgTis1z+bR9qOShOyNg4jfkcK9aCDvUOfrnv7D5ZK3r4RSRPf8yBr2pxJ9d7e5MyzMhd/o/kcN3ovkafAA7rZPwbzcWBAai2bYwICtv+jPZKkaKsfY4JiTYek8+l2aN+5Ik4YFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=hBSzQWk8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j7Scsjj9; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A67351400093;
	Thu, 26 Jun 2025 21:51:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 26 Jun 2025 21:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1750989081; x=1751075481; bh=HB
	t5CzuyTHnr8QkB1k7j7gtEH3+Tw2ksuHAAYflVK2E=; b=hBSzQWk8fmQmjxXxH+
	PWnLgN/EPC89GMrxlEa0Z3D7sDF5OW7kJc19bxBpFm4sSIDJGydZ33aNww6d/k0j
	B1GUpCbVJwn968ITORBPqHoy2Y8hsR1GhVpLTO79AMAutJRVqOBP/K50nmOsJ1Uc
	DHPddFCn7Lf5iyJRsGps9kpAjuylD5qiUXpudIu3YU1dRq5eXDSQtLZVWfY8dgo9
	i1tk+1F7S2VDsXPWLZhGLqUKsBvLlNZgB0Qtmr0z+8YUoCVOcJnm5wXFPhjENQLN
	tgmnLwI0ATjhpL817umaugImVWxF91MbLMi9SxZh5B/IMyd6DnRPWMtD3XZb11v8
	3Mhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750989081; x=
	1751075481; bh=HBt5CzuyTHnr8QkB1k7j7gtEH3+Tw2ksuHAAYflVK2E=; b=j
	7Scsjj96/Kuy4aOHalEPCNEk97rt9kAvyobI2EJ9g0Hu/+jI1QTLgIoGp0ZUxQPD
	aUHW0nE+UF6k9+rHHRuZ7Jo+vTaLAUm2sHXQyB2bgGsneEQu5LJD9dah5onur32t
	B0RgSBsG/AQbG5OSms5QqfhBRc+0s+WDr249MjCzCmw4q+08z3Po99Hd/e2EFAq1
	8611yYddyKpdkI7CjMSpeFWJJOunyKFNhnhFSDUd3j4lEZaGqhH14lZSf+bvYsLb
	qj5C6iOdhonZyYLvpOWE2iX3OQVxDhZE5ytCpThPHR8kyc+Vct4uVRDTlfowrr6t
	EoebOR14hdQ/rM6gprBQA==
X-ME-Sender: <xms:GfldaDopqQqHJwdJqMXx_stR8lfC4O8kRhfPXPrRoR7S4Cb9fgYoIA>
    <xme:GfldaNrFfhpksLLZJ2k3I1A7hckGYj-9-txm5auMDMsajo5QxRNXNdZR3JAnk3Ial
    qYePK6Mx_crXw>
X-ME-Received: <xmr:GfldaANyFJZ5biGqCikDBGWooB8jH05g1pzkKMrN1unwx9q7ZHZvnTtOOMI-sLir7JavmOuXU7W9fHVkbqsoGniUyAVMyUDwVvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkgggtugesghdtreertddtjeenucfhrhhomhepofgrrhgvkhcuofgrrhgt
    iiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinhhvihhsihgslh
    gvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepudfggfeileeuueek
    tdfhffelvdfhjeeffeehueeikefhleduleejjeelgeejudffnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghksehinhhvihhs
    ihgslhgvthhhihhnghhslhgrsgdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepmhhirhhirghmrdhrrggthhgvlhdrkhhorhgvnhgs
    lhhithesihhnthgvlhdrtghomhdprhgtphhtthhopegtohhlihhnrdhirdhkihhnghesgh
    hmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdifihhrvghlvghsshesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrvghgrhgvshhsihhonhhssehlihhs
    thhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:GfldaG6pyj5N0y2FyV1NPqj9jstF7tN0RYRA4tNxNy258NYquEnbCQ>
    <xmx:GfldaC68LqI8JentkzQW-sYc1ZRm47OcBQVJA9szHJE13VriwQtWFQ>
    <xmx:GfldaOgPRuqUFGruwQ_I9uFIycBIsbaa19uc4E32P0p4_yFVZdcv-g>
    <xmx:GfldaE7HnP59xZIYGVVwWQbFm8ofOog3TUK7LgEJ-ITb8_4C1XfCgQ>
    <xmx:GfldaFgKufYGPgxJ4qFJjiHoVUcXtd_sBNYBCWZ-xJDLp0ILlNjOFyRJ>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 21:51:20 -0400 (EDT)
Date: Fri, 27 Jun 2025 03:51:18 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: iwlwifi stopped working with AX200 (6.16-rc3 regression)
Message-ID: <aF35FqJAw63NSl63@mail-itl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tO0QPPHbufDN3hK1"
Content-Disposition: inline


--tO0QPPHbufDN3hK1
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Jun 2025 03:51:18 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: iwlwifi stopped working with AX200 (6.16-rc3 regression)

Hi,

With Linux 6.16-rc3 iwlwifi stopped working for me - device never
initializes fully. It was working fine with Linux 6.16-rc2. Log
includes:

    iwlwifi 0000:00:07.0: Registered PHC clock: iwlwifi-PTP, with index: 0
    ------------[ cut here ]------------
    WARNING: CPU: 0 PID: 516 at drivers/net/wireless/intel/iwlwifi/mvm/mld-=
mac.c:37 iwl_mvm_mld_mac_ctxt_cmd_common+0x17d/0x1d0 [iwlmvm]
    Modules linked in: nft_reject_ipv6 nf_reject_ipv6 nft_reject_ipv4 nf_re=
ject_ipv4 nft_reject qrtr nft_ct nft_masq nft_chain_nat nf_nat nf_conntrack=
 nf_defrag_ipv6 nf_defrag_ipv4 nf_tables iwlmvm mac80211 libarc4 joydev iwl=
wifi intel_rapl_msr intel_rapl_common cfg80211 polyval_clmulni ghash_clmuln=
i_intel sha512_ssse3 rfkill sha1_ssse3 r8169 pcspkr i2c_piix4 ehci_pci real=
tek ata_generic ehci_hcd i2c_smbus pata_acpi serio_raw xen_scsiback target_=
core_mod xen_netback xen_privcmd xen_gntdev xen_gntalloc xen_blkback xen_ev=
tchn i2c_dev fuse loop nfnetlink overlay xen_blkfront
    CPU: 0 UID: 0 PID: 516 Comm: NetworkManager Not tainted 6.16.0-0.rc3.1.=
qubes.1.fc41.x86_64 #1 PREEMPT(full)=20
    Hardware name: Xen HVM domU, BIOS 4.19.2 05/27/2025
    RIP: 0010:iwl_mvm_mld_mac_ctxt_cmd_common+0x17d/0x1d0 [iwlmvm]
    Code: eb a2 ba 01 00 00 00 66 41 89 55 18 eb 96 41 83 fe 02 74 25 41 c6=
 45 19 01 eb c8 b9 01 00 00 00 66 41 89 4d 1a e9 7a ff ff ff <0f> 0b 5b 5d =
41 5c 41 5d 41 5e e9 04 26 f5 ec bf 01 00 00 00 66 41
    RSP: 0018:ffffd45c807b3600 EFLAGS: 00010282
    RAX: 00000000ffffffff RBX: ffff8d334a68a008 RCX: ffff8d33428c3efc
    RDX: 00000000000000bf RSI: 0000000000000308 RDI: ffff8d33428c3efc
    RBP: 0000000000000001 R08: 0000000000000003 R09: 0000000000000000
    R10: 0000000000000000 R11: 0000000000000001 R12: ffff8d334a799c98
    R13: ffffd45c807b3634 R14: 0000000000000000 R15: ffff8d334a799c98
    FS:  00007b3ca8f0a800(0000) GS:ffff8d33a15db000(0000) knlGS:00000000000=
00000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 000072848666ab60 CR3: 000000000049f000 CR4: 0000000000350ef0
    Call Trace:
     <TASK>
     iwl_mvm_mld_mac_ctxt_cmd_sta+0x6b/0x1d0 [iwlmvm]
     iwl_mvm_mld_mac_ctxt_add+0x32/0xc0 [iwlmvm]
     iwl_mvm_mld_mac_add_interface+0x137/0x3b0 [iwlmvm]
     drv_add_interface+0x52/0x230 [mac80211]
     ieee80211_do_open+0x57b/0x720 [mac80211]
     ieee80211_open+0x8c/0xa0 [mac80211]
     __dev_open+0x114/0x2a0
     __dev_change_flags+0x1f6/0x240
     ? security_inode_post_setattr+0xf8/0x110
     netif_change_flags+0x26/0x70
     do_setlink.isra.0+0x326/0xcd0
     ? cred_has_capability.isra.0+0xa7/0x140
     ? __rtnl_newlink+0x1fe/0x3f0
     rtnl_newlink+0x4a4/0x8d0
     ? __pfx_rtnl_newlink+0x10/0x10
     rtnetlink_rcv_msg+0x37e/0x450
     ? avc_has_perm+0x5c/0xe0
     ? __pfx_rtnetlink_rcv_msg+0x10/0x10
     netlink_rcv_skb+0x52/0x100
     netlink_unicast+0x27d/0x3d0
     netlink_sendmsg+0x228/0x480
     ____sys_sendmsg+0x35e/0x390
     ___sys_sendmsg+0x99/0xe0
     __sys_sendmsg+0x88/0xf0
     do_syscall_64+0x84/0x2c0
     ? syscall_exit_work+0x108/0x140
     ? do_syscall_64+0x200/0x2c0
     ? syscall_exit_work+0x108/0x140
     ? do_syscall_64+0x200/0x2c0
     entry_SYSCALL_64_after_hwframe+0x76/0x7e
    RIP: 0033:0x7b3ca9e876c2
    Code: 08 0f 85 81 42 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2=
 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f =
1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
    RSP: 002b:00007ffed9f47ff8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
    RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007b3ca9e876c2
    RDX: 0000000000000000 RSI: 00007ffed9f48090 RDI: 000000000000000d
    RBP: 00007ffed9f48030 R08: 0000000000000000 R09: 0000000000000000
    R10: 0000000000000000 R11: 0000000000000246 R12: 0000642f470dd5a0
    R13: 000000000000001a R14: 0000000000000000 R15: 00007ffed9f4822c
     </TASK>
    ---[ end trace 0000000000000000 ]---
    iwlwifi 0000:00:07.0: Microcode SW error detected. Restarting 0x0.
    iwlwifi 0000:00:07.0: Start IWL Error Log Dump:
    iwlwifi 0000:00:07.0: Transport status: 0x0000004B, valid: 6
    iwlwifi 0000:00:0[2025-06-27 00:40:21] 7.0: Loaded firmware version: 77=
=2E864baa2e.0 cc-a0-77.ucode
    iwlwifi 0000:00:07.0: 0x00000071 | NMI_INTERRUPT_UMAC_FATAL   =20
    iwlwifi 0000:00:07.0: 0x00A0A2F0 | trm_hw_status0
    iwlwifi 0000:00:07.0: 0x00000000 | trm_hw_status1
    iwlwifi 0000:00:07.0: 0x004F8D82 | branchlink2
    iwlwifi 0000:00:07.0: 0x004EEDD2 | interruptlink1
    iwlwifi 0000:00:07.0: 0x004EEDD2 | interruptlink2
    iwlwifi 0000:00:07.0: 0x00015332 | data1
    iwlwifi 0000:00:07.0: 0x00001000 | data2
    iwlwifi 0000:00:07.0: 0x00000000 | data3
    iwlwifi 0000:00:07.0: 0x00000000 | beacon time
    iwlwifi 0000:00:07.0: 0x00062EC7 | tsf low
    iwlwifi 0000:00:07.0: 0x00000000 | tsf hi
    iwlwifi 0000:00:07.0: 0x00000000 | time gp1
    iwlwifi 0000:00:07.0: 0x00069534 | time gp2
    iwlwifi 0000:00:07.0: 0x00000001 | uCode revision type
    iwlwifi 0000:00:07.0: 0x0000004D | uCode version major
    iwlwifi 0000:00:07.0: 0x864BAA2E | uCode version minor
    iwlwifi 0000:00:07.0: 0x00000340 | hw version
    iwlwifi 0000:00:07.0: 0x00C89000 | board version
    iwlwifi 0000:00:07.0: 0x8032F500 | hcmd
    iwlwifi 0000:00:07.0: 0x20028000 | isr0
    iwlwifi 0000:00:07.0: 0x00000000 | isr1
    iwlwifi 0000:00:07.0: 0x08F04802 | isr2
    iwlwifi 0000:00:07.0: 0x00C3400C | isr3
    iwlwifi 0000:00:07.0: 0x00000000 | isr4
    iwlwifi 0000:00:07.0: 0x00110148 | last cmd Id
    iwlwifi 0000:00:07.0: 0x00015332 | wait_event
    iwlwifi 0000:00:07.0: 0x00000000 | l2p_control
    iwlwifi 0000:00:07.0: 0x00000000 | l2p_duration
    iwlwifi 0000:00:07.0: 0x00000000 | l2p_mhvalid
    iwlwifi 0000:00:07.0: 0x00000000 | l2p_addr_match
    iwlwifi 0000:00:07.0: 0x00000008 | lmpm_pmg_sel
    iwlwifi 0000:00:07.0: 0x00000000 | timestamp
    iwlwifi 0000:00:07.0: 0x0000084C | flow_handler
    iwlwifi 0000:00:07.0: Start IWL Error Log Dump:
    iwlwifi 0000:00:07.0: Transport status: 0x0000004B, valid: 7
    iwlwifi 0000:00:07.0: 0x20103126 | ADVANCED_SYSASSERT
    iwlwifi 0000:00:07.0: 0x00000000 | umac branchlink1
    iwlwifi 0000:00:07.0: 0x80455D7A | umac branchlink2
    iwlwifi 0000:00:07.0: 0xC0081228 | umac interruptlink1
    iwlwifi 0000:00:07.0: 0x00000000 | umac interruptlink2
    iwlwifi 0000:00:07.0: 0x00000000 | umac data1
    iwlwifi 0000:00:07.0: 0x00000000 | umac data2
    iwlwifi 0000:00:07.0: 0xDEADBEEF | umac data3
    iwlwifi 0000:00:07.0: 0x0000004D | umac major
    iwlwifi 0000:00:07.0: 0x864BAA2E | umac minor
    iwlwifi 0000:00:07.0: 0x0006952F | frame pointer
    iwlwifi 0000:00:07.0: 0xC0886C14 | stack pointer
    iwlwifi 0000:00:07.0: 0x00120308 | last host cmd
    iwlwifi 0000:00:07.0: 0x00000009 | isr status reg
    iwlwifi 0000:00:07.0: IML/ROM dump:
    iwlwifi 0000:00:07.0: 0x00000003 | IML/ROM error/state
    iwlwifi 0000:00:07.0: 0x000062FC | IML/ROM data1
    iwlwifi 0000:00:07.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
    iwlwifi 0000:00:07.0: Fseq Registers:
    iwlwifi 0000:00:07.0: 0x60000000 | FSEQ_ERROR_CODE
    iwlwifi 0000:00:07.0: 0x80290021 | FSEQ_TOP_INIT_VERSION
    iwlwifi 0000:00:07.0: 0x00050008 | FSEQ_CNVIO_INIT_VERSION
    iwlwifi 0000:00:07.0: 0x0000A503 | FSEQ_OTP_VERSION
    iwlwifi 0000:00:07.0: 0x80000003 | FSEQ_TOP_CONTENT_VERSION
    iwlwifi 0000:00:07.0: 0x4552414E | FSEQ_ALIVE_TOKEN
    iwlwifi 0000:00:07.0: 0x00100530 | FSEQ_CNVI_ID
    iwlwifi 0000:00:07.0: 0x00000532 | FSEQ_CNVR_ID
    iwlwifi 0000:00:07.0: 0x00100530 | CNVI_AUX_MISC_CHIP
    iwlwifi 0000:00:07.0: 0x00000532 | CNVR_AUX_MISC_CHIP
    iwlwifi 0000:00:07.0: 0x05B0905B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTR=
IM
    iwlwifi 0000:00:07.0: 0x0000025B | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_=
MIRROR
    iwlwifi 0000:00:07.0: 0x00050008 | FSEQ_PREV_CNVIO_INIT_VERSION
    iwlwifi 0000:00:07.0: 0x00290021 | FSEQ_WIFI_FSEQ_VERSION
    iwlwifi 0000:00:07.0: 0x00290021 | FSEQ_BT_FSEQ_VERSION
    iwlwifi 0000:00:07.0: 0x000000F0 | FSEQ_CLASS_TP_VERSION
    iwlwifi 0000:00:07.0: UMAC CURRENT PC: 0x80472b1c
    iwlwifi 0000:00:07.0: LMAC1 CURRENT PC: 0xd0
    iwlwifi 0000:00:07.0: FW error in SYNC CMD MAC_CONFIG_CMD
    CPU: 0 UID: 0 PID: 516 Comm: NetworkManager Tainted: G        W        =
   6.16.0-0.rc3.1.qubes.1.fc41.x86_64 #1 PREEMPT(full)=20
    Tainted: [W]=3DWARN
    Hardware name: Xen HVM domU, BIOS 4.19.2 05/27/2025
    Call Trace:
     <TASK>
     dump_stack_lvl+0x5d/0x80
     iwl_trans_pcie_send_hcmd_sync+0x355/0x360 [iwlwifi]
     ? __pfx_autoremove_wake_function+0x10/0x10
     iwl_trans_send_cmd+0x4f/0xe0 [iwlwifi]
     iwl_mvm_send_cmd_pdu+0x61/0xb0 [iwlmvm]
     iwl_mvm_mld_mac_ctxt_cmd_sta+0x10b/0x1d0 [iwlmvm]
     iwl_mvm_mld_mac_ctxt_add+0x32/0xc0 [iwlmvm]
     iwl_mvm_mld_mac_add_interface+0x137/0x3b0 [iwlmvm]
     drv_add_interface+0x52/0x230 [mac80211]
     ieee80211_do_open+0x57b/0x720 [mac80211]
     ieee80211_open+0x8c/0xa0 [mac80211]
     __dev_open+0x114/0x2a0
     __dev_change_flags+0x1f6/0x240
     ? security_inode_post_setattr+0xf8/0x110
     netif_change_flags+0x26/0x70
     do_setlink.isra.0+0x326/0xcd0
     ? cred_has_capability.isra.0+0xa7/0x140
     ? __rtnl_newlink+0x1fe/0x3f0
     rtnl_newlink+0x4a4/0x8d0
     ? __pfx_rtnl_newlink+0x10/0x10
     rtnetlink_rcv_msg+0x37e/0x450
     ? avc_has_perm+0x5c/0xe0
     ? __pfx_rtnetlink_rcv_msg+0x10/0x10
     netlink_rcv_skb+0x52/0x100
     netlink_unicast+0x27d/0x3d0
     netlink_sendmsg+0x228/0x480
     ____sys_sendmsg+0x35e/0x390
     ___sys_sendmsg+0x99/0xe0
     __sys_sendmsg+0x88/0xf0
     do_syscall_64+0x84/0x2c0
     ? syscall_exit_work+0x108/0x140
     ? do_syscall_64+0x200/0x2c0
     ? syscall_exit_work+0x108/0x140
     ? do_syscall_64+0x200/0x2c0
     entry_SYSCALL_64_after_hwframe+0x76/0x7e
    RIP: 0033:0x7b3ca9e876c2
    Code: 08 0f 85 81 42 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2=
 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 66 2e 0f =
1f 84 00 00 00 00 00 66 2e 0f 1f 84 00 00 00 00 00 66
    RSP: 002b:00007ffed9f47ff8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
    RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007b3ca9e876c2
    RDX: 0000000000000000 RSI: 00007ffed9f48090 RDI: 000000000000000d
    RBP: 00007ffed9f48030 R08: 0000000000000000 R09: 0000000000000000
    R10: 0000000000000000 R11: 0000000000000246 R12: 0000642f470dd5a0
    R13: 000000000000001a R14: 0000000000000000 R15: 00007ffed9f4822c
     </TASK>
    iwlwifi 0000:00:07.0: Failed to send MAC_CONFIG_CMD (action:0): -5

I see the only change there between rc2 and rc3 is fixing that WARN_ON
condition. Unfortunately, I don't know what cmd_ver value I have there,
but apparently it's outside of that range (and yet, the driver worked
fine before).

The device is:
02:00.0 Network controller [0280]: Intel Corporation Wi-Fi 6 AX200 [8086:27=
23] (rev 1a)
    Subsystem: Intel Corporation Wi-Fi 6 AX200NGW [8086:0084]

#regzbot introduced: v6.16-rc2..v6.16-rc3

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab


--tO0QPPHbufDN3hK1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmhd+RYACgkQ24/THMrX
1yyPoQf/UfZHu120Ug8NnZQv73XoWHvFie32nbkde8fZw62sxddCNEOYROawrf0r
HxRyTkKyBYYIE8G5hu+hTCj4i0YvrVFYBUpbOZ/lNkMEd4SzWhqx6aHaSUkJ5kNl
sWE6uJmV41w8BhGYpMy/rEMqtnJLImydfudBS9giTLcCCaBHF/W61OKBtYY/XQhc
4eBNssU/CTjzBnAZkPj3h8o2oW7tPgCpbqQFRyJQK2t/I/PmN6JGw2bOkVK1XlF3
ZaVuHjSyGd3irRnMda1I8XDDaZWqmi7qphtQ9OyzlCpgtZ93WuU2ZaVQo4JjOr56
lwiIipmpBIDEwhBcR940/WkRrCkuDA==
=W3LO
-----END PGP SIGNATURE-----

--tO0QPPHbufDN3hK1--

