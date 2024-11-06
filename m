Return-Path: <linux-wireless+bounces-14961-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B1E9BDEE9
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 07:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C0F1C22AD3
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 06:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A2118FDC2;
	Wed,  6 Nov 2024 06:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="jMt3Jere"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB83191494;
	Wed,  6 Nov 2024 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730874903; cv=none; b=HKhKJ5YF7ugK6m2/qhKNFQe2HdoOYitPnSC6FeuJ+g6AvR612CuEakf1vSaWyRoYHOUoMFEm9XRTFP0t5pDjf+AS4HMVnQSkhWYKRDZNPZAjKWoG0Dev3+nWvW88qA78zk3v8OyqHEg4sV1FO2Ox3u6nopcKbi5+6DJG+v7Ef00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730874903; c=relaxed/simple;
	bh=BzN2knYSgbHzfeWdJ+ZbB9Ms4i/Hh9lzx9vsSMJpDYs=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=gR3oWoduYv4h/fqoUAy2QA5rq/bssqhoQlF3mwPNPEYTdqSPwu4oBdDy0yS1g0uMV0ZVDqPSlzrlLJy/Z6RleMxRRfFrbv+YTgCGorLjWBJN+cEPIuvCIh2vinafxN4TIi73jKSikPKpwac5XKsDgXsK4Eyko7Kt6PlYJh4pzyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=jMt3Jere; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A66YWOS02316527, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730874872; bh=BzN2knYSgbHzfeWdJ+ZbB9Ms4i/Hh9lzx9vsSMJpDYs=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date;
	b=jMt3JereZu0/HVpz0Ncw4fDMoE+qxuF7dMaJsLoidQdxC3CeoJvPyCjf2cYfiAdRE
	 EjrLUyUCcia4T2RDeuqvJIl2aviF630WWjGF1vWi8UP+I0SwE0+eOoU44dOnaNd2UI
	 VbVwts63aaDqC0FhsiEBfodOSg02vGHN6/Ij3rzdn7vjMuw3S1uS6+YRVot6k9CoJ5
	 D+Hm+DFpaB33QnU09XejO64x5YcQFsoxxZeDVJsEahE/kteB1Fmrti2Xyrmw3LE4+/
	 AQUzPauWhtpepB1OtgJ4xjn4vS/6NJ3OpWlJpbMqZpEAuVHaa3D63hF/l4Pz+/i6G3
	 olncdaAqFtmhA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A66YWOS02316527
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Nov 2024 14:34:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 14:34:32 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Nov
 2024 14:34:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, <pkshih@realtek.com>,
        <linux-wireless@vger.kernel.org>
CC: <kvalo@kernel.org>, <linux-kernel@vger.kernel.org>, <kernel@gpiccoli.net>,
        <kernel-dev@igalia.com>, <rtl8821cerfe2@gmail.com>,
        "Guilherme G. Piccoli"
	<gpiccoli@igalia.com>,
        <stable@vger.kernel.org>,
        <syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com>
Subject: Re: [PATCH V4] wifi: rtlwifi: Drastically reduce the attempts to read efuse in case of failures
In-Reply-To: <20241101193412.1390391-1-gpiccoli@igalia.com>
References: <20241101193412.1390391-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <bcd236f2-ba8b-4515-8dca-b4b803ee91d2@RTEXMBS04.realtek.com.tw>
Date: Wed, 6 Nov 2024 14:34:32 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

"Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

> Syzkaller reported a hung task with uevent_show() on stack trace. That
> specific issue was addressed by another commit [0], but even with that
> fix applied (for example, running v6.12-rc5) we face another type of hung
> task that comes from the same reproducer [1]. By investigating that, we
> could narrow it to the following path:
> 
> (a) Syzkaller emulates a Realtek USB WiFi adapter using raw-gadget and
> dummy_hcd infrastructure.
> 
> (b) During the probe of rtl8192cu, the driver ends-up performing an efuse
> read procedure (which is related to EEPROM load IIUC), and here lies the
> issue: the function read_efuse() calls read_efuse_byte() many times, as
> loop iterations depending on the efuse size (in our example, 512 in total).
> 
> This procedure for reading efuse bytes relies in a loop that performs an
> I/O read up to *10k* times in case of failures. We measured the time of
> the loop inside read_efuse_byte() alone, and in this reproducer (which
> involves the dummy_hcd emulation layer), it takes 15 seconds each. As a
> consequence, we have the driver stuck in its probe routine for big time,
> exposing a stack trace like below if we attempt to reboot the system, for
> example:
> 
> task:kworker/0:3 state:D stack:0 pid:662 tgid:662 ppid:2 flags:0x00004000
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  __schedule+0xe22/0xeb6
>  schedule_timeout+0xe7/0x132
>  __wait_for_common+0xb5/0x12e
>  usb_start_wait_urb+0xc5/0x1ef
>  ? usb_alloc_urb+0x95/0xa4
>  usb_control_msg+0xff/0x184
>  _usbctrl_vendorreq_sync+0xa0/0x161
>  _usb_read_sync+0xb3/0xc5
>  read_efuse_byte+0x13c/0x146
>  read_efuse+0x351/0x5f0
>  efuse_read_all_map+0x42/0x52
>  rtl_efuse_shadow_map_update+0x60/0xef
>  rtl_get_hwinfo+0x5d/0x1c2
>  rtl92cu_read_eeprom_info+0x10a/0x8d5
>  ? rtl92c_read_chip_version+0x14f/0x17e
>  rtl_usb_probe+0x323/0x851
>  usb_probe_interface+0x278/0x34b
>  really_probe+0x202/0x4a4
>  __driver_probe_device+0x166/0x1b2
>  driver_probe_device+0x2f/0xd8
>  [...]
> 
> We propose hereby to drastically reduce the attempts of doing the I/O
> reads in case of failures, restricted to USB devices (given that
> they're inherently slower than PCIe ones). By retrying up to 10 times
> (instead of 10000), we got reponsiveness in the reproducer, while seems
> reasonable to believe that there's no sane USB device implementation in
> the field requiring this amount of retries at every I/O read in order
> to properly work. Based on that assumption, it'd be good to have it
> backported to stable but maybe not since driver implementation (the 10k
> number comes from day 0), perhaps up to 6.x series makes sense.
> 
> [0] Commit 15fffc6a5624 ("driver core: Fix uevent_show() vs driver detach race")
> 
> [1] A note about that: this syzkaller report presents multiple reproducers
> that differs by the type of emulated USB device. For this specific case,
> check the entry from 2024/08/08 06:23 in the list of crashes; the C repro
> is available at https://syzkaller.appspot.com/text?tag=ReproC&x=1521fc83980000.
> 
> Cc: stable@vger.kernel.org # v6.1+
> Reported-by: syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com
> Tested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

5c1b54456300 wifi: rtlwifi: Drastically reduce the attempts to read efuse in case of failures

---
https://github.com/pkshih/rtw.git


