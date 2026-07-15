Return-Path: <linux-wireless+bounces-39156-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NauGBIKeV2oCYAAAu9opvQ
	(envelope-from <linux-wireless+bounces-39156-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 16:51:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5D075F96B
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 16:51:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=invisiblethingslab.com header.s=fm2 header.b=tINHDqml;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="V PjVNyf";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39156-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39156-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=invisiblethingslab.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 077F8326A08E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2026 14:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B320388885;
	Wed, 15 Jul 2026 14:32:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3259539150D;
	Wed, 15 Jul 2026 14:32:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125967; cv=none; b=JyE1zZVETQ3phuLNszAAxSWyJCvy1vcNJQGp3XCU6Fu+Qg1PlHYz3Yi+QHtjb9qkCY2lDS4Sr9akt0WwYOlF1pT1rAs7b9LA4KcHv698L6lm3WpW+EGLdDHMQmgwDdZqHohgOI3ZK3n4n5DFPaHwwBPDAr5fP84XZ4Ci5HaetVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125967; c=relaxed/simple;
	bh=4xVmX6QIsVY0lLCEikNYl7wYED9Ktf2inLyh2LgMjAM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NaCmko8jG/kispdHenrEf1axULy/lwPjRyNHgitXUjiTHuEZaqXZNw5eXdf8DR4SRzABC89xYl9mgrNg6FGjHkMQJlu8LfAKuSsExsTLp7eU6o6/FrZj8EQobac5QzoUXVxSynTIaMZnb1imIjlyie9rXgXRLbDsVe6/cUVfqXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=tINHDqml; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VPjVNyfw; arc=none smtp.client-ip=202.12.124.144
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 6D83D1D000BC;
	Wed, 15 Jul 2026 10:32:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 15 Jul 2026 10:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1784125964; x=1784212364; bh=vv
	gXyYLryUPiu5akOCsrrdOpGdfX64D97cHUy71tVKc=; b=tINHDqmlCNOYTfKsp/
	yXafoBSxgJGw3iUneGr8E+lvMOseU5pJo0auljFtUct9BX8p56eIZXZ3wlxVNbGJ
	24ZTJ1vQiN5LQIFYvged/GCKXQJYMSfawNzUM3ebO9Gsz64K5BokMvMi0AjaMZg2
	h2N8Sc1PITMPnc7qsQqXeGlU0O6Rz954DolAvmunVr0/ZGqib1k9On3BGCgG3dOd
	IFKdLmBbUqCrTOYSpXEfsmdBxtftxrnZ+7UPblq6RpE3eCywGBsf5kqErnRa99Kf
	DU49lu+V9LjyB9ADR6jJa2TRM2kaYukufVfZeuLR8AET0UVCSNH7eoCNhOSU88Eq
	92QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784125964; x=
	1784212364; bh=vvgXyYLryUPiu5akOCsrrdOpGdfX64D97cHUy71tVKc=; b=V
	PjVNyfwUuhvPCpqdSSTVtPkY4Los8QJL0NHfu2WsPMdbkwSSpaxQR9LNHVBCWeOG
	RoWjfcfIkysg3DKFo0XtTodJDGs1F9oMp/Km/Cz/RpdoKs8OUFWRqT1DUdkOe1NW
	SvmxSjlJrxQtDRVRFYVkefU1tienGTrxBjtUbr4jOlu0NYpNjsgzr1wbf6vrmZix
	64lIwI/oGQRsOGXTE71DgBp5YvlnET5sTa2csrcFNQs85HSD9KuH9jVt6YVScKj5
	7chqT9qo9LeRSB48BEoFxiquNT4fd6ZjJfWzUqOoUNw0kvnPMoeXeCd/2XVWFC25
	mql13Cqp5uzHHroVskY4Q==
X-ME-Sender: <xms:DJpXamA5d5kCoMH0norB-t4Dns0kFAboTYr1IgttIJadJgL-LCKmug>
    <xme:DJpXanYpMQQwc0iT3y8z9xQTK3L1JVV1iMciEmU1OQgNAmCDt8iN35A6GcUcowynH
    TfNUyNyPKWUg5FbOZ1ygG9DlUVf1HVtiTooM_iefbE_UNrdNg>
X-ME-Received: <xmr:DJpXamgsiIsAmiUrwTnzh9YK4io4S7ARyGvZLXbvwvBvEFkoIq58RfcduSKJgDOe0ZidDHNEFlsFGkEt5Zp07W_QkqW8pY41aBU>
X-ME-Proxy-Cause: dmFkZTGNAmC8gjmLKWewWM+cvGHZtbwuwwMcvug2sxjoOuX7fYb9QQ/ViXB1dkqffvZho7
    mcIAVTrcBmg4frueBTGPvEDNwPoYFnc9Dn1fSQxQpSpImjI5x/oX9n/KIE5dWj3qns6gEC
    1F1whsoXa0+f3OfaSDwNoMAZ1BRI5y/ZoOzfgTxKHDyKqBfu7sNH1wz9cK88I7ZLfHdoNh
    uUbRyMAoAusWBhidAKg7Jv4P/wSfB4fEtKrhmaT8A8DP6oA2qtLLL9gY4r9uNfxMp1o61t
    iUP4KXgpovGpnhAKHr/axJtEwCt5LpSQvWQBBPG1QDqKCakUqUWCvWu1gVWpAa/k00/ItU
    QPrNuo0VxjRl8oJ13OEfv+fnuPphMRWPuCuFN1F8EGg8sA63QclUFpGhI++CbtyMR3Xgbz
    DqJ4d9hV3+pic77+KwPspya+DbB9PsdnsBCBPJbDL75OxPxzUF3VS+5NeUT3BisTYCmezX
    tpgToxCSmzKIkj00fhEGQECe0FRKn9V8CiIIH/PC2cBUVSz0GQAuX+sEW1sXidUpbc3fbn
    IAkUz0kx+bwuI8POpDbV7t8NGxpbwq7ywh0uEcniWEFpJLhwmCCU3nSFTGT0uYybL9Dtoe
    MSIN+Q89TwJk7P4OM8EoD+R5l3mEygaoEpa5IHywrwIpNdD6hboQQdzvENmA
X-ME-Proxy: <xmx:DJpXah5ik04M0j_acunAHgTKTlLX7U5SQ2QlE0azqKq9YXHTYF9UnA>
    <xmx:DJpXal57vrnEdJgISjMnnCjRMy0EFm0QzeszJKobTd0wahh11kAJJw>
    <xmx:DJpXatcIg-V0XbOgFgL4OI35kbhMokZKkrtTFNDewVca91nzZ5J8Sg>
    <xmx:DJpXapD7D-TCkqrO75MeyCet7We1awv037_cm1HAdmJYTw0rZJ-DKQ>
    <xmx:DJpXajILkpiWq_dHYnEcNJgwxVmZtQ1cYYBjibDzc2hE23kE-wiWWacO>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 10:32:43 -0400 (EDT)
Date: Wed, 15 Jul 2026 16:32:41 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: kernel BUG at mm/slub.c:634 (kfree) when unbinding device from
 iwlwifi
Message-ID: <aleaCWlvrmiUcLhT@mail-itl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IGhlwFXtCsy2Zsas"
Content-Disposition: inline
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[invisiblethingslab.com,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[invisiblethingslab.com:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-39156-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[marmarek@invisiblethingslab.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS(0.00)[m:miriam.rachel.korenblit@intel.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[invisiblethingslab.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marmarek@invisiblethingslab.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail-itl:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C5D075F96B
X-Rspamd-Action: no action


--IGhlwFXtCsy2Zsas
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 16:32:41 +0200
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: kernel BUG at mm/slub.c:634 (kfree) when unbinding device from
 iwlwifi

Hello,

I get a kernel panic when unbinding device (8086:0085) from the iwlwifi
driver (via writing to the "unbind" file in sysfs), while the wifi
connection is active. I can reproduce it on Thinkpad X230, but other
devices might be affected too. The specific crash is:

    [  286.908182] kernel BUG at mm/slub.c:634!
    [  286.908201] Oops: invalid opcode: 0000 [#1] SMP PTI
    [  286.908221] CPU: 1 UID: 0 PID: 1959 Comm: prepare-suspend Not tainte=
d 6.18.15-1.qubes.fc41.x86_64 #1 PREEMPT(full)=20
    [  286.908255] Hardware name: Xen HVM domU, BIOS 4.19.4 03/17/2026
    [  286.908275] RIP: 0010:kfree+0x3a8/0x470
    [  286.908292] Code: 5d 41 5e 41 5f 5d e9 67 bb ff ff 4d 89 f1 41 b8 01=
 00 00 00 48 89 d9 48 89 da 4c 89 ee 4c 89 e7 e8 ad 2c 00 00 e9 bd fd ff ff=
 <0f> 0b 89 c8 4c 8d 04 03 40 f6 c6 80 0f 84 41 ff ff ff 83 e6 08 0f
    [  286.908347] RSP: 0018:ffffcfce8280bb50 EFLAGS: 00010246
    [  286.908365] RAX: ffff8b2dcef2c800 RBX: ffff8b2dcef2c800 RCX: ffff8b2=
dcef2c830
    [  286.908389] RDX: 00000000000be001 RSI: 0000000000000000 RDI: ffff8b2=
dcef2c880
    [  286.908414] RBP: ffffcfce8280bba0 R08: ffff8b2dcef2c860 R09: 0000000=
000000000
    [  286.908438] R10: ffff8b2dcef2c860 R11: 0000000000000000 R12: ffff8b2=
dd2841600
    [  286.908462] R13: fffff077003bcb00 R14: ffffffffc093c480 R15: 0000000=
000000060
    [  286.908487] FS:  00007b10286cd740(0000) GS:ffff8b2e19c6c000(0000) kn=
lGS:0000000000000000
    [  286.908511] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [  286.908532] CR2: 00007fb93027bc70 CR3: 00000000034f0005 CR4: 0000000=
0001706f0
    [  286.908559] Call Trace:
    [  286.908570]  <TASK>
    [  286.908581]  ? _raw_spin_unlock_bh+0xe/0x20
    [  286.908599]  iwl_pcie_txq_free+0x130/0x170 [iwlwifi]
    [  286.908644]  iwl_pcie_tx_free+0x66/0xe0 [iwlwifi]
    [  286.908681]  iwl_trans_pcie_free+0x1df/0x250 [iwlwifi]
    [  286.908719]  pci_device_remove+0x42/0xb0
    [  286.908736]  device_release_driver_internal+0x19c/0x200
    [  286.908755]  unbind_store+0xa1/0xb0
    [  286.908771]  kernfs_fop_write_iter+0x150/0x200
    [  286.908790]  vfs_write+0x25d/0x450
    [  286.908806]  ksys_write+0x6b/0xe0
    [  286.908825]  do_syscall_64+0x84/0x800
    [  286.908842]  ? syscall_exit_work+0x108/0x140
    [  286.908861]  ? do_syscall_64+0xbb/0x800
    [  286.908876]  ? ksys_dup3+0x63/0xf0
    [  286.908892]  ? syscall_exit_work+0x108/0x140
    [  286.911388]  ? do_syscall_64+0xbb/0x800
    [  286.911408]  ? do_sys_openat2+0xa4/0xe0
    [  286.911423]  ? syscall_exit_work+0x108/0x140
    [  286.911443]  ? do_syscall_64+0xbb/0x800
    [  286.911458]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
    [  286.911477] RIP: 0033:0x7b102873ec5e
    [  286.911493] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 93 08 03=
 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05=
 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f3 0f 1e fa
    [  286.911549] RSP: 002b:00007ffd94bc3100 EFLAGS: 00000202 ORIG_RAX: 00=
00000000000001
    [  286.911575] RAX: ffffffffffffffda RBX: 00007b10288ba5c0 RCX: 00007b1=
02873ec5e
    [  286.911600] RDX: 000000000000000d RSI: 00006385db4f8020 RDI: 0000000=
000000001
    [  286.911625] RBP: 00007ffd94bc3110 R08: 0000000000000000 R09: 0000000=
000000000
    [  286.911650] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000=
00000000d
    [  286.911674] R13: 000000000000000d R14: 00006385db4f8020 R15: 0000638=
5db4f5b30
    [  286.911701]  </TASK>
    [  286.911711] Modules linked in: iwldvm iwlwifi mac80211 ehci_pci ehci=
_hcd nft_nat nft_flow_offload nf_flow_table_inet nf_flow_table qrtr nf_conn=
track_netlink nft_reject_ipv6 nf_reject_ipv6 nft_reject_ipv4 nf_reject_ipv4=
 nft_reject nft_ct nft_masq nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv=
6 nf_defrag_ipv4 nf_tables joydev libarc4 intel_rapl_msr intel_rapl_common =
polyval_clmulni ghash_clmulni_intel cfg80211 e1000e ata_generic rfkill i2c_=
piix4 pata_acpi i2c_smbus pcspkr floppy vfat fat serio_raw xen_scsiback tar=
get_core_mod xen_netback xen_privcmd xen_gntdev xen_gntalloc xen_blkback xe=
n_evtchn i2c_dev fuse loop nfnetlink overlay xen_blkfront [last unloaded: i=
wlwifi]
    [  286.911967] ---[ end trace 0000000000000000 ]---

This is running in a VM (HVM) under Xen, with relevant PCI device
attached, but I don't think it's relevant for this bug.

I've got reports about the issue in Linux 6.18.15 initially (after
updating from 6.12), but later tests identified it's a regression
somewhere between 6.15.11 and 6.16.8.

The crash still happen on 7.0.14, although it looks different there:

    [  106.379541] ------------[ cut here ]------------
    [  106.379572] kernel BUG at mm/slub.c:542!
    [  106.379596] Oops: invalid opcode: 0000 [#1] SMP PTI
    [  106.379618] CPU: 1 UID: 0 PID: 240 Comm: kworker/1:2 Not tainted 7.0=
=2E14-1.qubes.fc41.x86_64 #1 PREEMPT(full)=20
    [  106.379656] Hardware name: Xen HVM domU, BIOS 4.19.4 06/09/2026
    [  106.379680] Workqueue: slub_flushwq flush_cpu_sheaves
    [  106.379711] RIP: 0010:build_detached_freelist+0x1d0/0x210
    [  106.379733] Code: 41 5c 41 5d c3 cc cc cc cc 31 d2 4d 85 c0 0f 85 b2=
 fe ff ff 48 89 04 24 e8 7d fd ff ff 48 c7 03 00 00 00 00 48 8b 04 24 eb d0=
 <0f> 0b 48 85 d2 74 e3 48 89 13 4c 8b 42 08 e9 8c fe ff ff 0f 0b 31
    [  106.379795] RSP: 0000:ffffcebd804c3c88 EFLAGS: 00010246
    [  106.379815] RAX: 000000000000001d RBX: ffffcebd804c3cb8 RCX: ffff8e6=
240fcf000
    [  106.379843] RDX: ffff8e6240fcf000 RSI: 000000000000001d RDI: 0000000=
000000003
    [  106.379870] RBP: ffffffff80000000 R08: 0000000080000000 R09: ffff8e6=
240fcf030
    [  106.379898] R10: ffffcebd804c3d10 R11: 0000000000000000 R12: ffff8e6=
242a68b00
    [  106.379925] R13: ffff8e6242a68aff R14: 000000000000001c R15: 0000000=
000000000
    [  106.379953] FS:  0000000000000000(0000) GS:ffff8e62a837a000(0000) kn=
lGS:0000000000000000
    [  106.379981] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    [  106.380004] CR2: 0000767e599f2fd0 CR3: 000000000c1d2001 CR4: 0000000=
0001706f0
    [  106.380035] Call Trace:
    [  106.380047]  <TASK>
    [  106.380060]  __kmem_cache_free_bulk.part.0+0x60/0xe0
    [  106.380085]  __sheaf_flush_main_batch+0xa1/0xe0
    [  106.380110]  flush_cpu_sheaves+0xc3/0xe0
    [  106.380129]  process_one_work+0x198/0x390
    [  106.380149]  worker_thread+0x1af/0x320
    [  106.380168]  ? __pfx_worker_thread+0x10/0x10
    [  106.380190]  kthread+0xe3/0x120
    [  106.380207]  ? __pfx_kthread+0x10/0x10
    [  106.380223]  ret_from_fork+0x19e/0x260
    [  106.380241]  ? __pfx_kthread+0x10/0x10
    [  106.380257]  ret_from_fork_asm+0x1a/0x30
    [  106.380276]  </TASK>
    [  106.380287] Modules linked in: nft_nat nft_flow_offload nf_flow_tabl=
e_inet nf_flow_table nf_conntrack_netlink nft_reject_ipv6 nf_reject_ipv6 qr=
tr nft_reject_ipv4 nf_reject_ipv4 nft_reject nft_ct nft_masq nft_chain_nat =
nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables vfat fat intel_=
rapl_msr iwldvm intel_rapl_common ghash_clmulni_intel mac80211 libarc4 iwlw=
ifi joydev cfg80211 ehci_pci pcspkr e1000e ehci_hcd rfkill floppy ata_gener=
ic i2c_piix4 pata_acpi i2c_smbus serio_raw xen_scsiback target_core_mod xen=
_netback xen_privcmd xen_gntdev xen_gntalloc xen_blkback xen_evtchn i2c_dev=
 loop fuse nfnetlink zram lz4hc_compress lz4_compress overlay xen_blkfront
    [  106.381851] ---[ end trace 0000000000000000 ]---

This one doesn't have obvious relation to iwlwifi, but I suspect it's at
least related.

There are some more call traces at
https://github.com/QubesOS/qubes-issues/issues/10845 but they look
pretty similar.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--IGhlwFXtCsy2Zsas
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmpXmgkACgkQ24/THMrX
1yw1SAf/ffQj5UDP1L9XaBXVQeuqkyyKz63OV/0uvMQfK8P6l4OdhnWB5Vx1frSf
Wxkz4EoVdwrpn9A16Ntzbxy9iQxRgIEGzM6jnND7+WbclqGDY2H6lv5exrlY+C11
c5IMPSHRR9zYTF9r9rvHxBfJwudJ2OUZTIS6DUi307rmy9Xwu/lDTzRalvegNchL
AJtFWkQ0o3BCc0A2cvDCqgzqKOHDwdh/WkWrYuCc7uyJFfvVA3JgAXp44oXbZ2NX
BdiTKfE+XQ5OeimDa4fjMybbqOSz1acXi+1InFh2+hcCjNrjGwCySaSeKHt5bapP
RDv1+kr4prZYrkBFXyWlIF0oK4Rcuw==
=7VKC
-----END PGP SIGNATURE-----

--IGhlwFXtCsy2Zsas--

