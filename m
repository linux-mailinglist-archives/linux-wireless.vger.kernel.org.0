Return-Path: <linux-wireless+bounces-8285-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2B18D43E2
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 04:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDFB28440D
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 02:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249288F4A;
	Thu, 30 May 2024 02:53:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E7D1B299
	for <linux-wireless@vger.kernel.org>; Thu, 30 May 2024 02:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717037599; cv=none; b=Sr4lTs/ISwMz7M0Jo6N+4quvaLx19CiaAtMW4kz3FMgZ+fwXNWx/X0s6UR1+XECIH18atIZXnd24R318WpsVWzrEbALsIj76hfYxizx/lTANEpKFCNX5Yji879wKINbiz1Mc9vAvMv0g4X4NThd37JKkALDznSq2rJEwf3t9hx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717037599; c=relaxed/simple;
	bh=Ft0g3Oq5EKPiuBteFk3lyfusfvaHu6xJmJifCPf+6WA=;
	h=From:To:CC:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Message-ID:Date; b=iTL0qCfqFWkKH9M3nn8wBC/xBaqZij5U1VfWETtl8AvEAwtUUwGeMQtEPKWjfGaqV1ygblScPgIpr99i8NnFG/9QgeFQI+UlwxcVYblHexDCUnymWqAeOTaELRA61vRUG8tgAUq6Z4MtpFVlinc3WVnH+0oo1zmxh6NDvq+Ew6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44U2rBU71211793, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44U2rBU71211793
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 10:53:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 10:53:12 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 30 May
 2024 10:53:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
CC: <shichaorai@gmail.com>
Subject: Re: [PATCH] wifi: rtlwifi: handle return value of usb init TX/RX
In-Reply-To: <20240524003248.5952-1-pkshih@realtek.com>
References: <20240524003248.5952-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <6c92777d-1f82-40de-97ef-38516ac9e9ce@RTEXMBS04.realtek.com.tw>
Date: Thu, 30 May 2024 10:53:11 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Handle error code to cause failed to USB probe result from unexpected
> USB EP number, otherwise when USB disconnect skb_dequeue() an uninitialized
> skb list and cause warnings below.
> 
> usb 2-1: USB disconnect, device number 76
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> CPU: 0 PID: 54060 Comm: kworker/0:1 Not tainted 6.9.0-rc7 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:114
>  assign_lock_key kernel/locking/lockdep.c:976 [inline]
>  register_lock_class+0xc18/0xfa0 kernel/locking/lockdep.c:1289
>  __lock_acquire+0x108/0x3bc0 kernel/locking/lockdep.c:5014
>  lock_acquire kernel/locking/lockdep.c:5754 [inline]
>  lock_acquire+0x1b0/0x550 kernel/locking/lockdep.c:5719
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
>  skb_dequeue+0x20/0x180 net/core/skbuff.c:3846
>  rtl_usb_cleanup drivers/net/wireless/realtek/rtlwifi/usb.c:706 [inline]
>  rtl_usb_deinit drivers/net/wireless/realtek/rtlwifi/usb.c:721 [inline]
>  rtl_usb_disconnect+0x4a4/0x850 drivers/net/wireless/realtek/rtlwifi/usb.c:1051
>  usb_unbind_interface+0x1e8/0x980 drivers/usb/core/driver.c:461
>  device_remove drivers/base/dd.c:568 [inline]
>  device_remove+0x122/0x170 drivers/base/dd.c:560
>  __device_release_driver drivers/base/dd.c:1270 [inline]
>  device_release_driver_internal+0x443/0x620 drivers/base/dd.c:1293
>  bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
>  device_del+0x395/0x9f0 drivers/base/core.c:3909
>  usb_disable_device+0x360/0x7b0 drivers/usb/core/message.c:1418
>  usb_disconnect+0x2db/0x930 drivers/usb/core/hub.c:2305
>  hub_port_connect drivers/usb/core/hub.c:5362 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5662 [inline]
>  port_event drivers/usb/core/hub.c:5822 [inline]
>  hub_event+0x1e39/0x4ce0 drivers/usb/core/hub.c:5904
>  process_one_work+0x97b/0x1a90 kernel/workqueue.c:3267
>  process_scheduled_works kernel/workqueue.c:3348 [inline]
>  worker_thread+0x680/0xf00 kernel/workqueue.c:3429
>  kthread+0x2c7/0x3b0 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> 
> Reported-by: Shichao Lai <shichaorai@gmail.com>
> Closes: https://lore.kernel.org/linux-wireless/CAEk6kZuuezkH1dVRJf3EAVZK-83=OpTz62qCugkpTkswj8JF6w@mail.gmail.com/T/#u
> Tested-by: Shichao Lai <shichaorai@gmail.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

1 patch(es) applied to rtw-next branch of rtw.git, thanks.

9c4fde42cce0 wifi: rtlwifi: handle return value of usb init TX/RX

---
https://github.com/pkshih/rtw.git


