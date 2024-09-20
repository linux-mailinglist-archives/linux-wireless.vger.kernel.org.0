Return-Path: <linux-wireless+bounces-13057-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F90B97D604
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 15:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FB61F22E60
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 13:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00A9170A1B;
	Fri, 20 Sep 2024 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="XyI/JxRE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057CF1607AA
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726837886; cv=none; b=DrC5TTWFDGvNZ3tPxQN7Bm6b9/fKWur8ettXybWw25ozZ0UH3YgNQmHRWJaASSJyAosWdlybSMA/LQNabdg2YZj7zmXJbcHwD4dGhFg0H85q1IwvIIBlFg1hZrfCptuu+2mJWRvqyyDBUJv7JSLoOrtKi2TLHej10o3aH/BFTNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726837886; c=relaxed/simple;
	bh=3zVCsN34lWH3Y22vIqtaMc+sXa5AQBURCHgPhdiToOs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eSxHlm9YrL0AsvAV5foBfdryTdNrBsy2O7Ycgyg7GF4EA7OzVfWybTu7Y9ciCcbRVzSHApFrwoys2XvJSvy4H2fpXa+vpKRB4NmdAkPpRO6KYJaI9G7+AiljUVRYe81nuNh6nOdcGdNtuinVJJBS1WKT6Fmai9GmB2uFNGQM3qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=XyI/JxRE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48KDBA7X01141639, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726837870; bh=3zVCsN34lWH3Y22vIqtaMc+sXa5AQBURCHgPhdiToOs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=XyI/JxREVUszDfBtm8FBJaAtt8EwpmHL7JfdtDkb8+5GTmiVdJXSRwu2vztcpN2Yw
	 Y8fky3o86MVz3RbIOlJoyXKnwshzdW3mCdiPVJvsggh37ZMZrA1jb9+6RnyHZdZkEu
	 eRjEEuXQZz2eJKRjx/qQBI9G84v1gGwLUm+oC2CW+gGSqK2pLmXytCZpjgrs0/hLEi
	 aBxdAG4AT/F/DM4F/RvSkdKFaVNgFFdhU6IOStmvYDUxRStgpUbdqtMMElVm6oGHKB
	 DcsjnL1p3fRh8LD69U029HK9MWrrDxT11SUG16GcetS6o3hr7jABRlp4yXKkcgd57x
	 uoqgej2g2IQDQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48KDBA7X01141639
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 21:11:10 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 21:11:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 20 Sep 2024 21:11:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 20 Sep 2024 21:11:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "pbrobinson@gmail.com" <pbrobinson@gmail.com>
Subject: Re: [PATCH v2 2/2] wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX skb
Thread-Topic: [PATCH v2 2/2] wifi: rtw88: use ieee80211_purge_tx_queue() to
 purge TX skb
Thread-Index: AQHa9DSxPPAHrjHHCkiWzpTbPs2zeLJf34wAgABrcYCAAIiR4g==
Date: Fri, 20 Sep 2024 13:11:10 +0000
Message-ID: <857b5b8036134b50bed5c2a0455f7c03@realtek.com>
References: <20240822014255.10211-1-pkshih@realtek.com>
 <20240822014255.10211-2-pkshih@realtek.com>
 <c0f73bb2-45e7-4caf-b9e5-21ee064635bf@RTEXMBS04.realtek.com.tw>,<6725980b-adbc-4f2e-a3a8-b03b5c0aab3a@gmail.com>
In-Reply-To: <6725980b-adbc-4f2e-a3a8-b03b5c0aab3a@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
> On 20/09/2024 09:33, Ping-Ke Shih wrote:
> > Ping-Ke Shih <pkshih@realtek.com> wrote:
> >
> >> When removing kernel modules by:
> >>    rmmod rtw88_8723cs rtw88_8703b rtw88_8723x rtw88_sdio rtw88_core
> >>
> >> Driver uses skb_queue_purge() to purge TX skb, but not report tx statu=
s
> >> causing "Have pending ack frames!" warning. Use ieee80211_purge_tx_que=
ue()
> >> to correct this.
> >>
> >> Since ieee80211_purge_tx_queue() doesn't take locks, to prevent racing
> >> between TX work and purge TX queue, flush and destroy TX work in advan=
ce.
> >>
> >>    wlan0: deauthenticating from aa:f5:fd:60:4c:a8 by local
> >>      choice (Reason: 3=3DDEAUTH_LEAVING)
> >>    ------------[ cut here ]------------
> >>    Have pending ack frames!
> >>    WARNING: CPU: 3 PID: 9232 at net/mac80211/main.c:1691
> >>        ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
> >>    CPU: 3 PID: 9232 Comm: rmmod Tainted: G         C
> >>        6.10.1-200.fc40.aarch64 #1
> >>    Hardware name: pine64 Pine64 PinePhone Braveheart
> >>       (1.1)/Pine64 PinePhone Braveheart (1.1), BIOS 2024.01 01/01/2024
> >>    pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> >>    pc : ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
> >>    lr : ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
> >>    sp : ffff80008c1b37b0
> >>    x29: ffff80008c1b37b0 x28: ffff000003be8000 x27: 0000000000000000
> >>    x26: 0000000000000000 x25: ffff000003dc14b8 x24: ffff80008c1b37d0
> >>    x23: ffff000000ff9f80 x22: 0000000000000000 x21: 000000007fffffff
> >>    x20: ffff80007c7e93d8 x19: ffff00006e66f400 x18: 0000000000000000
> >>    x17: ffff7ffffd2b3000 x16: ffff800083fc0000 x15: 0000000000000000
> >>    x14: 0000000000000000 x13: 2173656d61726620 x12: 6b636120676e6964
> >>    x11: 0000000000000000 x10: 000000000000005d x9 : ffff8000802af2b0
> >>    x8 : ffff80008c1b3430 x7 : 0000000000000001 x6 : 0000000000000001
> >>    x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> >>    x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000003be8000
> >>    Call trace:
> >>     ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
> >>     idr_for_each+0x74/0x110
> >>     ieee80211_free_hw+0x44/0xe8 [mac80211]
> >>     rtw_sdio_remove+0x9c/0xc0 [rtw88_sdio]
> >>     sdio_bus_remove+0x44/0x180
> >>     device_remove+0x54/0x90
> >>     device_release_driver_internal+0x1d4/0x238
> >>     driver_detach+0x54/0xc0
> >>     bus_remove_driver+0x78/0x108
> >>     driver_unregister+0x38/0x78
> >>     sdio_unregister_driver+0x2c/0x40
> >>     rtw_8723cs_driver_exit+0x18/0x1000 [rtw88_8723cs]
> >>     __do_sys_delete_module.isra.0+0x190/0x338
> >>     __arm64_sys_delete_module+0x1c/0x30
> >>     invoke_syscall+0x74/0x100
> >>     el0_svc_common.constprop.0+0x48/0xf0
> >>     do_el0_svc+0x24/0x38
> >>     el0_svc+0x3c/0x158
> >>     el0t_64_sync_handler+0x120/0x138
> >>     el0t_64_sync+0x194/0x198
> >>    ---[ end trace 0000000000000000 ]---
> >>
> >> Reported-by: Peter Robinson <pbrobinson@gmail.com>
> >> Closes: https://lore.kernel.org/linux-wireless/CALeDE9OAa56KMzgknaCD3q=
uOgYuEHFx9_hcT=3DOFgmMAb+8MPyA@mail.gmail.com/
> >> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> >> Tested-by: Ping-Ke Shih <pkshih@realtek.com> # 8723DU
> >
> > 1 patch(es) applied to rtw-next branch of rtw.git, thanks.
> >
> > 3e5e4a801aaf wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX sk=
b
> >
> > ---
> > https://github.com/pkshih/rtw.git
> >
> >
>=20
> A small problem: patch 1/2 is not applied yet:
>=20
> linux/drivers/net/wireless/realtek/rtw88/usb.c:430:17: error: implicit de=
claration of function =91ieee80211_purge_tx_queue=92; did you mean =91ieee8=
0211_wake_queue=92? [-Wimplicit-function-declaration]
>   430 |                 ieee80211_purge_tx_queue(rtwdev->hw, &rtwusb->tx_=
queue[i]);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~
>       |                 ieee80211_wake_queue
>=20

Patch 1/2 is merged [1]. Have you update kernel from rtw tree?

[1] 53bc1b73b678 ("wifi: mac80211: export ieee80211_purge_tx_queue() for dr=
ivers")



