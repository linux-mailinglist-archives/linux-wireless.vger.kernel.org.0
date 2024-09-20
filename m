Return-Path: <linux-wireless+bounces-13040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4A297D136
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 08:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11FF284A35
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 06:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EA933F6;
	Fri, 20 Sep 2024 06:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="vcWdOnVr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3D938DD6
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 06:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726814034; cv=none; b=TmrgkM/zdZKdie3mjvKSyEpqfJzDItDf2psvajLQqTHOQHaE7LFsVfHHwlj+KAZdhcNdNDuit/WsNL7W16Ydaj7XsSpl3Cs4iTR01rmnf5IzONP/MXGKeEoOBl7EFgYlTL//plWKUsTXgWDXS1G2ONev5qC6nus5Siws83ZCQfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726814034; c=relaxed/simple;
	bh=vodtjqn831i4raR8AxBdSCKR3xC22nUfuepQU/d+d1w=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=forcCoxe7+HsdzQYO6LXS6c6dzY47HZAZv/eFEO8u96ejU9rq/nkzToINbRLQzg03It1txHKTznpe4gVkvpGY1hf/+X4WLxYLZDYr99kI5ha9vYPMHmqV5az7tdq30Z7+9IdUG54QOMpWzVLYSh51KHB5rOGvqoOPmZ/ADAXYRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=vcWdOnVr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48K6XgojE673534, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726814022; bh=vodtjqn831i4raR8AxBdSCKR3xC22nUfuepQU/d+d1w=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=vcWdOnVrEyaZiW9tEPL0ULznrZ1v/g8TR8V+gIBDdjme8mZrxDTbuzSbpFwi1LhRz
	 81xKsifAv5pvbnMoAtO+w1kQJ/kOAtV0NV9iJE7blfoFSwRvXgQlXlCI6BrZr1en8r
	 gp0jMWCezW9hsagE+NJxG/Atf0jJ4tqldVTH53M54KSG4bVgiwHcWAqm5TI8MGe3Hm
	 UkBm/q40WhdkBytToZAbRJ9Gg/zEcGHeid+kj/njo6ldJv9QdUkw/ySFeTtsodiXCX
	 UEs6Kd4tOOxrXOn87UVm2AsQaQxPId/gfi9hlJdtFIYeY1hEf561VoK5x4UCTHyQhp
	 uct1FlgL6gMhQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48K6XgojE673534
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 14:33:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 20 Sep 2024 14:33:42 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 20 Sep
 2024 14:33:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC: <pbrobinson@gmail.com>
Subject: Re: [PATCH v2 2/2] wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX skb
In-Reply-To: <20240822014255.10211-2-pkshih@realtek.com>
References: <20240822014255.10211-1-pkshih@realtek.com> <20240822014255.10211-2-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <c0f73bb2-45e7-4caf-b9e5-21ee064635bf@RTEXMBS04.realtek.com.tw>
Date: Fri, 20 Sep 2024 14:33:42 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> When removing kernel modules by:
>    rmmod rtw88_8723cs rtw88_8703b rtw88_8723x rtw88_sdio rtw88_core
> 
> Driver uses skb_queue_purge() to purge TX skb, but not report tx status
> causing "Have pending ack frames!" warning. Use ieee80211_purge_tx_queue()
> to correct this.
> 
> Since ieee80211_purge_tx_queue() doesn't take locks, to prevent racing
> between TX work and purge TX queue, flush and destroy TX work in advance.
> 
>    wlan0: deauthenticating from aa:f5:fd:60:4c:a8 by local
>      choice (Reason: 3=DEAUTH_LEAVING)
>    ------------[ cut here ]------------
>    Have pending ack frames!
>    WARNING: CPU: 3 PID: 9232 at net/mac80211/main.c:1691
>        ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
>    CPU: 3 PID: 9232 Comm: rmmod Tainted: G         C
>        6.10.1-200.fc40.aarch64 #1
>    Hardware name: pine64 Pine64 PinePhone Braveheart
>       (1.1)/Pine64 PinePhone Braveheart (1.1), BIOS 2024.01 01/01/2024
>    pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>    pc : ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
>    lr : ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
>    sp : ffff80008c1b37b0
>    x29: ffff80008c1b37b0 x28: ffff000003be8000 x27: 0000000000000000
>    x26: 0000000000000000 x25: ffff000003dc14b8 x24: ffff80008c1b37d0
>    x23: ffff000000ff9f80 x22: 0000000000000000 x21: 000000007fffffff
>    x20: ffff80007c7e93d8 x19: ffff00006e66f400 x18: 0000000000000000
>    x17: ffff7ffffd2b3000 x16: ffff800083fc0000 x15: 0000000000000000
>    x14: 0000000000000000 x13: 2173656d61726620 x12: 6b636120676e6964
>    x11: 0000000000000000 x10: 000000000000005d x9 : ffff8000802af2b0
>    x8 : ffff80008c1b3430 x7 : 0000000000000001 x6 : 0000000000000001
>    x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
>    x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000003be8000
>    Call trace:
>     ieee80211_free_ack_frame+0x5c/0x90 [mac80211]
>     idr_for_each+0x74/0x110
>     ieee80211_free_hw+0x44/0xe8 [mac80211]
>     rtw_sdio_remove+0x9c/0xc0 [rtw88_sdio]
>     sdio_bus_remove+0x44/0x180
>     device_remove+0x54/0x90
>     device_release_driver_internal+0x1d4/0x238
>     driver_detach+0x54/0xc0
>     bus_remove_driver+0x78/0x108
>     driver_unregister+0x38/0x78
>     sdio_unregister_driver+0x2c/0x40
>     rtw_8723cs_driver_exit+0x18/0x1000 [rtw88_8723cs]
>     __do_sys_delete_module.isra.0+0x190/0x338
>     __arm64_sys_delete_module+0x1c/0x30
>     invoke_syscall+0x74/0x100
>     el0_svc_common.constprop.0+0x48/0xf0
>     do_el0_svc+0x24/0x38
>     el0_svc+0x3c/0x158
>     el0t_64_sync_handler+0x120/0x138
>     el0t_64_sync+0x194/0x198
>    ---[ end trace 0000000000000000 ]---
> 
> Reported-by: Peter Robinson <pbrobinson@gmail.com>
> Closes: https://lore.kernel.org/linux-wireless/CALeDE9OAa56KMzgknaCD3quOgYuEHFx9_hcT=OFgmMAb+8MPyA@mail.gmail.com/
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Ping-Ke Shih <pkshih@realtek.com> # 8723DU

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

3e5e4a801aaf wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX skb

---
https://github.com/pkshih/rtw.git


