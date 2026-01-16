Return-Path: <linux-wireless+bounces-30855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E46BD29646
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B93A300B9EF
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 00:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9437D2C0285;
	Fri, 16 Jan 2026 00:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijzmveNy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C562BEFF6
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 00:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768522540; cv=none; b=ewqd9Fp38/G6wPb+DDEzRtdrLkZ1P/ZjadXAKycku/qIL7QbFVrnUtr9vsuuw+sePkKMFgIPsZ6A+ZGuW/RuSITPPwIV4neqI8QoEo2oudnnzhHjoniZ7q5JJl+aT7gB9iNug5kP3A7crpYJhfHvhPDmdvm3pLKb7GYxSt5vHo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768522540; c=relaxed/simple;
	bh=Qoom8EAk5s0vkxGTfEBdvDe4EU7HeMhX2lS+/4o9kAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtU9eDdN0G+RDT4FvcfFObY7HxN1S8VmPCPf0mvAnPDAxBgRFu8mzpA9wN4NNdJHsYLL6tKbfheYjcK3teYbTJs5hGtsT1PIQmV41dLYudjCRf70JZ1mhG3I6ht3evStODuQ+ZI017CGNa1OAQm91KXLtYHDvUpK98xk6GZ5VAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijzmveNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A12C19422
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 00:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768522540;
	bh=Qoom8EAk5s0vkxGTfEBdvDe4EU7HeMhX2lS+/4o9kAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ijzmveNyZ7QPjXsJcU5OWUr81CR+GZukeX+7bvyT5/AwiMJk0ZPpvmn5dh+SABkS6
	 UUQRiNJp6DdLBBLXiftzXWAO97GEu8XQMbNAlTaDP5nkkj7VOI1qnTRuMWffclu7cH
	 PoNZesxScpHe0h0jQkxlq4So39Z4p8R9wh65ivEoj+ZZymG2QOX73OvJgv0V5HGmmg
	 DLh6ar1/VDx2guhGHWDmoTYgEA8Gdy2tvZ70eHju/TjtBXLokdO6vBVn/XJzB/iIUK
	 E3Fx0pMLGHYC1uHBoDSGaI48HsV92JGYGMdVp3DnlrUbbmho6+Mu9wzfM+ffVieeAl
	 TQkP/mTWd12wQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59b79451206so1440143e87.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 16:15:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1zWqzSqlbDnnhrgnHUjTqH52YPRQW+FeIao42jHsGy/LIqAUc6W0HEt/R85BHFK8RVVi55Z/QGGCGsRPqYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcs4mK4sjkiNCnOZwHNbvStUTpMghi6YajNT50SNKoADTnLnSo
	1/3FzYwtWTELbzFiO79Qb2BpDkL2iXEVbset6MJ0aIBjhcj0Yh9xElOhbJJZrla4zHLkAZ0z/VT
	4X9wqx0kj5lxKDoqBJPQhHwUqIcsJMN4=
X-Received: by 2002:a05:6512:32c7:b0:598:f96f:af0 with SMTP id
 2adb3069b0e04-59baeeb1d50mr421415e87.7.1768522538465; Thu, 15 Jan 2026
 16:15:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102200524.290779-1-zbowling@gmail.com> <20260105002638.668723-1-zbowling@gmail.com>
In-Reply-To: <20260105002638.668723-1-zbowling@gmail.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 15 Jan 2026 18:15:27 -0600
X-Gmail-Original-Message-ID: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
X-Gm-Features: AZwV_QhmDGd0M2K2vGL98TrIqrM2dp7k_Pf6AakMzhTFC_0fKZSjjllodzG9UHY
Message-ID: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] wifi: mt76: mt7925/mt792x: comprehensive
 stability fixes
To: Zac Bowling <zbowling@gmail.com>
Cc: deren.wu@mediatek.com, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
	lorenzo@kernel.org, nbd@nbd.name, ryder.lee@mediatek.com, 
	sean.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zac,

Thanks for sharing this series. Overall the patches look good to me,
and I=E2=80=99m continuing more testing to ensure there are no regressions =
on
mt7925 and mt7921 further
But today I do hit a kernel WARN in the disconnect path (mac80211 BA
session teardown) while testing v3 of the series

[ 3373.120224] Hardware name: HP HP EliteBook 830 G6/854A, BIOS R70
Ver. 01.22.00 10/14/2022
[ 3373.120228] Workqueue: events_unbound cfg80211_wiphy_work [cfg80211]
[ 3373.120367] RIP: 0010:__ieee80211_stop_tx_ba_session+0x295/0x350 [mac802=
11]
[ 3373.120570] Code: 11 0f 83 a3 00 00 00 48 c7 80 90 03 00 00 00 00
00 00 48 8b 7d 98 e8 4a 26 f3 fa 4c 89 ee 4c 89 ef e8 6f 16 0b fa 31
c0 eb 93 <0f> 0b 31 c0 eb 8d b8 8e ff ff ff eb 86 48 8b 7d 98 e8 25 26
f3 fa
[ 3373.120576] RSP: 0018:ffffd00902ed7ba0 EFLAGS: 00010206
[ 3373.120583] RAX: 0000000000010003 RBX: 0000000000000003 RCX: 00000000000=
00000
[ 3373.120587] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00000
[ 3373.120591] RBP: ffffd00902ed7c10 R08: 0000000000000000 R09: 00000000000=
00000
[ 3373.120596] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000
[ 3373.120599] R13: ffff8a8433717540 R14: ffff8a83e0b20960 R15: ffff8a834d4=
2c000
[ 3373.120604] FS:  0000000000000000(0000) GS:ffff8a8477b03000(0000)
knlGS:0000000000000000
[ 3373.120608] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3373.120626] CR2: 00007b9e0a8ba0d0 CR3: 000000009a440005 CR4: 00000000003=
726f0
[ 3373.120631] Call Trace:
[ 3373.120656]  <TASK>
[ 3373.120664]  ieee80211_sta_tear_down_BA_sessions+0x53/0xe0 [mac80211]
[ 3373.120836]  __sta_info_destroy_part1+0x48/0x550 [mac80211]
[ 3373.120994]  __sta_info_flush+0x10e/0x230 [mac80211]
[ 3373.121150]  ieee80211_set_disassoc+0x6b3/0x900 [mac80211]
[ 3373.121293]  ? _printk+0x5f/0x90
[ 3373.121330]  __ieee80211_disconnect+0xd6/0x1a0 [mac80211]
[ 3373.121446]  ieee80211_beacon_connection_loss_work+0x6d/0xc0 [mac80211]
[ 3373.121573]  cfg80211_wiphy_work+0xb4/0x190 [cfg80211]
[ 3373.121779]  process_one_work+0x191/0x3e0
[ 3373.121789]  worker_thread+0x2e3/0x420
[ 3373.121796]  ? __pfx_worker_thread+0x10/0x10
[ 3373.121802]  kthread+0x10d/0x230
[ 3373.121810]  ? __pfx_kthread+0x10/0x10
[ 3373.121818]  ret_from_fork+0x205/0x230
[ 3373.121826]  ? __pfx_kthread+0x10/0x10
[ 3373.121832]  ret_from_fork_asm+0x1a/0x30
[ 3373.121842]  </TASK>
[ 3373.121844] ---[ end trace 0000000000000000 ]---
[ 3373.128750] ------------[ cut here ]------------
[ 3373.128757] WARNING: CPU: 1 PID: 14854 at net/mac80211/agg-tx.c:398
__ieee80211_stop_tx_ba_session+0x295/0x350 [mac80211]

I=E2=80=99m currently bisecting the series to identify which patch triggers=
 it
and will follow up once I have clearer results.
Thanks again for the work and the DKMS setup.

                 Sean

On Sun, Jan 4, 2026 at 6:27=E2=80=AFPM Zac Bowling <zbowling@gmail.com> wro=
te:
>
> From: Zac Bowling <zac@zacbowling.com>
>
> This patch series addresses kernel panics, system deadlocks, and various
> stability issues in the MT7925 WiFi driver. The issues were discovered on
> kernel 6.17 (Ubuntu 25.10) and fixes were developed and tested on 6.18.2.
>
> These patches are based on the wireless tree (nbd168/wireless.git) as
> requested by Sean Wang.
>
> =3D=3D Problem Description =3D=3D
>
> The MT7925 driver has several bugs that cause:
> - Kernel NULL pointer dereferences during BSSID roaming
> - System-wide deadlocks requiring hard reboot
> - Firmware reload failures after suspend/resume
> - Key removal errors during MLO roaming
>
> These issues manifest approximately every 5 minutes when the adapter
> tries to switch to a better BSSID, particularly in enterprise environment=
s
> with multiple access points.
>
> =3D=3D Root Causes =3D=3D
>
> 1. Missing mutex protection around ieee80211_iterate_active_interfaces()
>    when the callback invokes MCU functions (patches 2, 3, 16)
>
> 2. NULL pointer dereferences where mt792x_vif_to_bss_conf(),
>    mt792x_sta_to_link(), and similar functions return NULL during
>    MLO state transitions but results are not checked (patches 1, 4, 5,
>    9, 10, 14, 17)
>
> 3. Ignored MCU return values hiding firmware errors (patches 6, 7, 8)
>
> 4. WARN_ON_ONCE used where NULL is expected during normal MLO AP
>    setup (patch 13)
>
> 5. Firmware semaphore not released after failed load attempts (patch 15)
>
> 6. Key removal returning error when link is already torn down (patch 12)
>
> =3D=3D Testing =3D=3D
>
> Stress tested by hammering the driver with custom test script.
>
> Tested on:
> - Framework Desktop (AMD Ryzen AI Max 300 Series) with MT7925 (RZ717)
> - This whole patch series was tested on Kernel 6.18.2 and 6.17.12 (Ubuntu=
 25.10)
> - Enterprise WiFi environment with multiple WIFI 7 APs with MLO enabled
>
> Before patches: System hangs/panics every 5-15 minutes during BSSID roami=
ng
> After patches: Stable for 24+ hours under continuous stress testing
>
> =3D=3D Crash Traces Fixed =3D=3D
>
> Primary NULL pointer dereference:
>   BUG: kernel NULL pointer dereference, address: 0000000000000010
>   Workqueue: mt76 mt7925_mac_reset_work [mt7925_common]
>   RIP: 0010:mt76_connac_mcu_uni_add_dev+0x9c/0x780 [mt76_connac_lib]
>   Call Trace:
>    mt7925_vif_connect_iter+0xcb/0x240 [mt7925_common]
>    __iterate_interfaces+0x92/0x130 [mac80211]
>    ieee80211_iterate_interfaces+0x3d/0x60 [mac80211]
>    mt7925_mac_reset_work+0x105/0x190 [mt7925_common]
>
> Deadlock trace:
>   INFO: task kworker/u128:0:48737 blocked for more than 122 seconds.
>   Workqueue: mt76 mt7925_mac_reset_work [mt7925_common]
>   Call Trace:
>    __mutex_lock.constprop.0+0x3d0/0x6d0
>    mt7925_mac_reset_work+0x85/0x170 [mt7925_common]
>
> =3D=3D Related Links =3D=3D
>
> Framework Community discussion:
> https://community.frame.work/t/kernel-panic-from-wifi-mediatek-mt7925-nul=
lptr-dereference/79301
>
> OpenWrt GitHub issues:
> https://github.com/openwrt/mt76/issues/1014
> https://github.com/openwrt/mt76/issues/1036
>
> GitHub repository with additional analysis:
> https://github.com/zbowling/mt7925
>
> Zac Bowling (17):
>   wifi: mt76: mt7925: fix NULL pointer dereference in vif iteration
>   wifi: mt76: mt7925: fix missing mutex protection in reset and ROC abort
>   wifi: mt76: mt7925: fix missing mutex protection in runtime PM and MLO =
PM
>   wifi: mt76: mt7925: add NULL checks in MCU STA TLV functions
>   wifi: mt76: mt7925: add NULL checks for link_conf and mlink in main.c
>   wifi: mt76: mt7925: add error handling for AMPDU MCU commands
>   wifi: mt76: mt7925: add error handling for BSS info MCU command in sta_=
add
>   wifi: mt76: mt7925: add error handling for BSS info in key setup
>   wifi: mt76: mt7925: add NULL checks in MLO link and chanctx functions
>   wifi: mt76: mt792x: fix NULL pointer dereference in TX path
>   wifi: mt76: mt7925: add lockdep assertions for mutex verification
>   wifi: mt76: mt7925: fix key removal failure during MLO roaming
>   wifi: mt76: mt7925: fix kernel warning in MLO ROC setup
>   wifi: mt76: mt7925: add NULL checks for MLO link pointers in MCU functi=
ons
>   wifi: mt76: mt792x: fix firmware reload failure after previous load cra=
sh
>   wifi: mt76: mt7925: add mutex protection in resume path
>   wifi: mt76: mt7925: add NULL checks in link station and TX queue setup
>
>  drivers/net/wireless/mediatek/mt76/mt792x_core.c | 27 +++++++++++++++-
>  drivers/net/wireless/mediatek/mt76/mt7925/mac.c  |  8 +++++
>  drivers/net/wireless/mediatek/mt76/mt7925/main.c | 95 ++++++++++++++++++=
+++---
>  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  | 52 ++++++++++++++---
>  drivers/net/wireless/mediatek/mt76/mt7925/pci.c  |  6 +++
>  5 files changed, 170 insertions(+), 18 deletions(-)
>
> --
> 2.51.0
>

