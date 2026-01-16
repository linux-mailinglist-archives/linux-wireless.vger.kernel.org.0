Return-Path: <linux-wireless+bounces-30857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0FAD29709
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CEE5302D890
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 00:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B00A92E;
	Fri, 16 Jan 2026 00:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7Wlo2jC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA56B306B3B
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 00:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768524207; cv=pass; b=Qr0vs1lCsLoN6CrSeS7jyMzWZC6LJOqb3ybNFWGK7Bvyv3dwOZ8WAEzfAolDSRz/iFd3rRoqKS599aZwTxDUjapFQLAO0PK92DBH5g8V9yclzgV9Z74FpotubzHxi9KXDGEkqen2UhpNye3fT72bZAsvVSLSNcl037uyHaVPlW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768524207; c=relaxed/simple;
	bh=MVEcc8bcCTsJ2FYMqTnWDN+azjbr86PKhVCApls9re4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcZuYW+ZxwUiQ4sC4vqeSL4SFtOrZ7c1ZpQJIi+BkmRDWTYZMoWCSYPLqzJlYzAA3o1FDSPh+8EjssnmhaEL0+fEp0pUBvDbNPW335RronxjMwjwla+Lza0LlQDFklmwcm0nncxnHEnB3lmZtTFKDpmNIEVqJUZG/O7ghJ1SOfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7Wlo2jC; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-655afbca977so23780a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 16:43:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768524204; cv=none;
        d=google.com; s=arc-20240605;
        b=dYSvb8Fx3xQ2XaD4+bT0Uf7HWY8nVHVahydRLU1Db+JIEJ3S5tfaoeQoKpnHuRgU2s
         x+GUF3izCHZC2tHmNFWrWrHGu6Jf3BXUjXWoBVj4CsXTuuCHz/56TZiyKL06LMZOG0Zi
         xVnt0OeY7etRBiRsEHueohMyPUjT+CkN+z1INXy+PMXo05IAckCQnZKbeKihb7ZwEz9i
         UN4TOSEUs3il9fDFq6zW0wLZsDkayyPukXxluIrfz9qWsH+OxL7rdHUA/kd1K2EvPFnN
         c6ag2LjVtAvg6UYowfOLKYTf+j/pKz82KHMO4KA80kiZr4dO+NNd5+pABRydkRpsEDcS
         eN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cwuVL82iUU8a0W2Xk5/sFQ1jVLVdV7Er1Z8kUcIS808=;
        fh=7ay40FZ8ITucXeCZLLk2r+tbtIijGMBeE/123QSFsi8=;
        b=ObF/zIFVO+SxkYm6ZMik5Rswj4PLZANOtzNg0G11TSf5xX+f/5wNX16N885IoRLuLQ
         1Hv2QGIgYL+hVCivIutByuqlHNOqQ31JxqG39atcRoiDWmorRVrnI+nZWRMc+vVs7W0K
         jNi9RbOb2leEgX3SINXsoVyfJC9Dhb+yQvAP2s4eViouvOc2QsgBD7/EEml5na8iO5hB
         BPtY/MfobCaKUxvR6qA4zPAZc2xVntP7mNJpN+W2vL1YM2TF+Ldkgy7b2+onbVSu9XI3
         xLCBHzN4/vmrq8xGiC9dy7n5UVQ81ZVhr2qcxzLGnnA4Epq2mD8z39QDl1HUceKwtMSQ
         S29g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768524204; x=1769129004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwuVL82iUU8a0W2Xk5/sFQ1jVLVdV7Er1Z8kUcIS808=;
        b=C7Wlo2jCUIqiUEYia03Go1PJxBQKr8uWWkV1M5ra1EPpdiU0y5Rq4FkV8W1lgEx3Jk
         JiGrOOMAr/cdbFD43fUYmSOQdfr0lAl4hfQdwRD7o6NiMnghH3ohJ8tzjrd9aDEPmq0P
         f4VFRef4Z/FG7yk0LWOVlKsVAT4vt1K+2a2fp/FQt2yFOJxlVYqWUU71ilkmPD3Cvu5r
         QGotW2faY96WzjL+x+yEAY50lWdkPjkvqlqgot5cGGdNeJtHb3fCPaRUdgzlNiiMPQTR
         fwXsWCBHsczySRSuXOrRLZ7JpUlAyWRsJsz/ZgJewwKuuOXPoq7riTXLWm6opoqJMODq
         51xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768524204; x=1769129004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cwuVL82iUU8a0W2Xk5/sFQ1jVLVdV7Er1Z8kUcIS808=;
        b=uXjY02OARXJbE5IVKnGtWa/Sf0P1AmU4GJOhWxBO0f81pg2g1n5X6v2qIoN2WS0PsF
         pRP3RBA7mYD6YGQFhSp/NSlWsJhWcJkakayg7fKtI6V10mYI4rY6B2wfSYwZiYepkxnQ
         S4hajr8wAuw7riSrxOVCcU35YnjSM32YFZLfcwMvLQ2SBBMELrBtDkcPbXy1MR1OjG8D
         2NWvrsidLY63qQVc98aWcJyTPUIeFnHCUQSFMJVKdSchIIsgMknVhm9elnyxnl2bBhrO
         Ph5vNHoEBjDYYBDd60zMqCbBY8r/7MnpCeIH84q+2ee1/UgiEmULi+Jf9Dfec03WZjVr
         ARXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF9Ur/ax3glB7cGO82fJTDpjhLy+6Eos95tmOHOtsXqn4iocSHAjDRyY7fNPejcD7MH5WwyNK4PD7DOATgig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdJUG4duEtB4a7kqJ1eTpI5H85on5MQg2QQ8/bHF0b3UFCqsIU
	FaTlcUP62K3KPfn181qpeuY2rT9zNyXAhSAJCzuBeMqkfmUiC4tIy44Grh3sZyFR10Ywtxm2Vt6
	N+6Kduw4bhFadkwG1jFKxXGUb7BGXo1A=
X-Gm-Gg: AY/fxX4+XZ0GB0pwnlUADCV4qlfyqs6lDDKgmmoSL0YYtXLoq4ZxPR9GYxqDfaEsY+v
	hSRIxN/hYu9G/HXoVtvx7tD8PLRLQWhZIr//WedePOzmMcgNWTSKNxs/FRnLEeSNP8W/Ekb6YHX
	CZZTlauPJ2S+2iTDrRA1Mi9qw6JQR3gzXRjkm6qXU2foivsZiYOA20GoCr4Jg+GBRm90sxxwqPn
	ePo++o1euNhhOvlVDjG0mx5qMBEzIwJMMxh/Ye2hvvPS+8N1+BLrJUP/NJkf0gPi6G1RklsO2Va
	4mug9G0xokQ8UpRltg8J0wGL27Uiv0Aalwd8dXKW9hG/vPCOHpzyFx1f7Q==
X-Received: by 2002:a05:6402:34d5:b0:653:b83b:a68c with SMTP id
 4fb4d7f45d1cf-654525cc828mr938649a12.12.1768524203776; Thu, 15 Jan 2026
 16:43:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102200524.290779-1-zbowling@gmail.com> <20260105002638.668723-1-zbowling@gmail.com>
 <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
In-Reply-To: <CAGp9LzpuyXRDa=TxqY+Xd5ZhDVvNayWbpMGDD1T0g7apkn7P0A@mail.gmail.com>
From: Zac Bowling <zbowling@gmail.com>
Date: Thu, 15 Jan 2026 16:43:12 -0800
X-Gm-Features: AZwV_QiQWd0l4pFMtboY8pSmZFwEXDJk9keC02GmxFPhpGPTVl1AFiYmqrG3qsc
Message-ID: <CAOFcj8SLxv7qX5_i5DJ0YScG0EVkWFO5Qj-eMfzo_xpW5ziwQg@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] wifi: mt76: mt7925/mt792x: comprehensive
 stability fixes
To: Sean Wang <sean.wang@kernel.org>
Cc: deren.wu@mediatek.com, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
	lorenzo@kernel.org, nbd@nbd.name, ryder.lee@mediatek.com, 
	sean.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean,

Thanks for testing this and catching that WARN. Good catch. Yeah, that
was my bug. One of my attempts to handle all error returns that my
static analyzer said was unhandled meant I didn't actually hit a
required callback because I early returned too soon. Patched it
locally already and it's my repo. Will send in just a sec after my
poor-mans stress finishes running tests. I found another bug this
morning too, I need to send with device resets coming out of suspend
and corrupted list from the past initialization.

Zac Bowling

On Thu, Jan 15, 2026 at 4:15=E2=80=AFPM Sean Wang <sean.wang@kernel.org> wr=
ote:
>
> Hi Zac,
>
> Thanks for sharing this series. Overall the patches look good to me,
> and I=E2=80=99m continuing more testing to ensure there are no regression=
s on
> mt7925 and mt7921 further
> But today I do hit a kernel WARN in the disconnect path (mac80211 BA
> session teardown) while testing v3 of the series
>
> [ 3373.120224] Hardware name: HP HP EliteBook 830 G6/854A, BIOS R70
> Ver. 01.22.00 10/14/2022
> [ 3373.120228] Workqueue: events_unbound cfg80211_wiphy_work [cfg80211]
> [ 3373.120367] RIP: 0010:__ieee80211_stop_tx_ba_session+0x295/0x350 [mac8=
0211]
> [ 3373.120570] Code: 11 0f 83 a3 00 00 00 48 c7 80 90 03 00 00 00 00
> 00 00 48 8b 7d 98 e8 4a 26 f3 fa 4c 89 ee 4c 89 ef e8 6f 16 0b fa 31
> c0 eb 93 <0f> 0b 31 c0 eb 8d b8 8e ff ff ff eb 86 48 8b 7d 98 e8 25 26
> f3 fa
> [ 3373.120576] RSP: 0018:ffffd00902ed7ba0 EFLAGS: 00010206
> [ 3373.120583] RAX: 0000000000010003 RBX: 0000000000000003 RCX: 000000000=
0000000
> [ 3373.120587] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [ 3373.120591] RBP: ffffd00902ed7c10 R08: 0000000000000000 R09: 000000000=
0000000
> [ 3373.120596] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
> [ 3373.120599] R13: ffff8a8433717540 R14: ffff8a83e0b20960 R15: ffff8a834=
d42c000
> [ 3373.120604] FS:  0000000000000000(0000) GS:ffff8a8477b03000(0000)
> knlGS:0000000000000000
> [ 3373.120608] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3373.120626] CR2: 00007b9e0a8ba0d0 CR3: 000000009a440005 CR4: 000000000=
03726f0
> [ 3373.120631] Call Trace:
> [ 3373.120656]  <TASK>
> [ 3373.120664]  ieee80211_sta_tear_down_BA_sessions+0x53/0xe0 [mac80211]
> [ 3373.120836]  __sta_info_destroy_part1+0x48/0x550 [mac80211]
> [ 3373.120994]  __sta_info_flush+0x10e/0x230 [mac80211]
> [ 3373.121150]  ieee80211_set_disassoc+0x6b3/0x900 [mac80211]
> [ 3373.121293]  ? _printk+0x5f/0x90
> [ 3373.121330]  __ieee80211_disconnect+0xd6/0x1a0 [mac80211]
> [ 3373.121446]  ieee80211_beacon_connection_loss_work+0x6d/0xc0 [mac80211=
]
> [ 3373.121573]  cfg80211_wiphy_work+0xb4/0x190 [cfg80211]
> [ 3373.121779]  process_one_work+0x191/0x3e0
> [ 3373.121789]  worker_thread+0x2e3/0x420
> [ 3373.121796]  ? __pfx_worker_thread+0x10/0x10
> [ 3373.121802]  kthread+0x10d/0x230
> [ 3373.121810]  ? __pfx_kthread+0x10/0x10
> [ 3373.121818]  ret_from_fork+0x205/0x230
> [ 3373.121826]  ? __pfx_kthread+0x10/0x10
> [ 3373.121832]  ret_from_fork_asm+0x1a/0x30
> [ 3373.121842]  </TASK>
> [ 3373.121844] ---[ end trace 0000000000000000 ]---
> [ 3373.128750] ------------[ cut here ]------------
> [ 3373.128757] WARNING: CPU: 1 PID: 14854 at net/mac80211/agg-tx.c:398
> __ieee80211_stop_tx_ba_session+0x295/0x350 [mac80211]
>
> I=E2=80=99m currently bisecting the series to identify which patch trigge=
rs it
> and will follow up once I have clearer results.
> Thanks again for the work and the DKMS setup.
>
>                  Sean
>
> On Sun, Jan 4, 2026 at 6:27=E2=80=AFPM Zac Bowling <zbowling@gmail.com> w=
rote:
> >
> > From: Zac Bowling <zac@zacbowling.com>
> >
> > This patch series addresses kernel panics, system deadlocks, and variou=
s
> > stability issues in the MT7925 WiFi driver. The issues were discovered =
on
> > kernel 6.17 (Ubuntu 25.10) and fixes were developed and tested on 6.18.=
2.
> >
> > These patches are based on the wireless tree (nbd168/wireless.git) as
> > requested by Sean Wang.
> >
> > =3D=3D Problem Description =3D=3D
> >
> > The MT7925 driver has several bugs that cause:
> > - Kernel NULL pointer dereferences during BSSID roaming
> > - System-wide deadlocks requiring hard reboot
> > - Firmware reload failures after suspend/resume
> > - Key removal errors during MLO roaming
> >
> > These issues manifest approximately every 5 minutes when the adapter
> > tries to switch to a better BSSID, particularly in enterprise environme=
nts
> > with multiple access points.
> >
> > =3D=3D Root Causes =3D=3D
> >
> > 1. Missing mutex protection around ieee80211_iterate_active_interfaces(=
)
> >    when the callback invokes MCU functions (patches 2, 3, 16)
> >
> > 2. NULL pointer dereferences where mt792x_vif_to_bss_conf(),
> >    mt792x_sta_to_link(), and similar functions return NULL during
> >    MLO state transitions but results are not checked (patches 1, 4, 5,
> >    9, 10, 14, 17)
> >
> > 3. Ignored MCU return values hiding firmware errors (patches 6, 7, 8)
> >
> > 4. WARN_ON_ONCE used where NULL is expected during normal MLO AP
> >    setup (patch 13)
> >
> > 5. Firmware semaphore not released after failed load attempts (patch 15=
)
> >
> > 6. Key removal returning error when link is already torn down (patch 12=
)
> >
> > =3D=3D Testing =3D=3D
> >
> > Stress tested by hammering the driver with custom test script.
> >
> > Tested on:
> > - Framework Desktop (AMD Ryzen AI Max 300 Series) with MT7925 (RZ717)
> > - This whole patch series was tested on Kernel 6.18.2 and 6.17.12 (Ubun=
tu 25.10)
> > - Enterprise WiFi environment with multiple WIFI 7 APs with MLO enabled
> >
> > Before patches: System hangs/panics every 5-15 minutes during BSSID roa=
ming
> > After patches: Stable for 24+ hours under continuous stress testing
> >
> > =3D=3D Crash Traces Fixed =3D=3D
> >
> > Primary NULL pointer dereference:
> >   BUG: kernel NULL pointer dereference, address: 0000000000000010
> >   Workqueue: mt76 mt7925_mac_reset_work [mt7925_common]
> >   RIP: 0010:mt76_connac_mcu_uni_add_dev+0x9c/0x780 [mt76_connac_lib]
> >   Call Trace:
> >    mt7925_vif_connect_iter+0xcb/0x240 [mt7925_common]
> >    __iterate_interfaces+0x92/0x130 [mac80211]
> >    ieee80211_iterate_interfaces+0x3d/0x60 [mac80211]
> >    mt7925_mac_reset_work+0x105/0x190 [mt7925_common]
> >
> > Deadlock trace:
> >   INFO: task kworker/u128:0:48737 blocked for more than 122 seconds.
> >   Workqueue: mt76 mt7925_mac_reset_work [mt7925_common]
> >   Call Trace:
> >    __mutex_lock.constprop.0+0x3d0/0x6d0
> >    mt7925_mac_reset_work+0x85/0x170 [mt7925_common]
> >
> > =3D=3D Related Links =3D=3D
> >
> > Framework Community discussion:
> > https://community.frame.work/t/kernel-panic-from-wifi-mediatek-mt7925-n=
ullptr-dereference/79301
> >
> > OpenWrt GitHub issues:
> > https://github.com/openwrt/mt76/issues/1014
> > https://github.com/openwrt/mt76/issues/1036
> >
> > GitHub repository with additional analysis:
> > https://github.com/zbowling/mt7925
> >
> > Zac Bowling (17):
> >   wifi: mt76: mt7925: fix NULL pointer dereference in vif iteration
> >   wifi: mt76: mt7925: fix missing mutex protection in reset and ROC abo=
rt
> >   wifi: mt76: mt7925: fix missing mutex protection in runtime PM and ML=
O PM
> >   wifi: mt76: mt7925: add NULL checks in MCU STA TLV functions
> >   wifi: mt76: mt7925: add NULL checks for link_conf and mlink in main.c
> >   wifi: mt76: mt7925: add error handling for AMPDU MCU commands
> >   wifi: mt76: mt7925: add error handling for BSS info MCU command in st=
a_add
> >   wifi: mt76: mt7925: add error handling for BSS info in key setup
> >   wifi: mt76: mt7925: add NULL checks in MLO link and chanctx functions
> >   wifi: mt76: mt792x: fix NULL pointer dereference in TX path
> >   wifi: mt76: mt7925: add lockdep assertions for mutex verification
> >   wifi: mt76: mt7925: fix key removal failure during MLO roaming
> >   wifi: mt76: mt7925: fix kernel warning in MLO ROC setup
> >   wifi: mt76: mt7925: add NULL checks for MLO link pointers in MCU func=
tions
> >   wifi: mt76: mt792x: fix firmware reload failure after previous load c=
rash
> >   wifi: mt76: mt7925: add mutex protection in resume path
> >   wifi: mt76: mt7925: add NULL checks in link station and TX queue setu=
p
> >
> >  drivers/net/wireless/mediatek/mt76/mt792x_core.c | 27 +++++++++++++++-
> >  drivers/net/wireless/mediatek/mt76/mt7925/mac.c  |  8 +++++
> >  drivers/net/wireless/mediatek/mt76/mt7925/main.c | 95 ++++++++++++++++=
+++++---
> >  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  | 52 ++++++++++++++--=
-
> >  drivers/net/wireless/mediatek/mt76/mt7925/pci.c  |  6 +++
> >  5 files changed, 170 insertions(+), 18 deletions(-)
> >
> > --
> > 2.51.0
> >

