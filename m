Return-Path: <linux-wireless+bounces-8982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5019074B3
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 16:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DC41F2173E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 14:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4605C146588;
	Thu, 13 Jun 2024 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j/sw2DNo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B5F144D0B;
	Thu, 13 Jun 2024 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287823; cv=none; b=gM58BlYwNupmwO822rpPTA+9AqJsEt0JUrqFDdkXG80MzP374wHQFUZ/gSuGCH44H1QeYKXWYNk9rGqInIka3/1nKvX81hJjhU2KrGlTr4qkzI5juLgTFvHAW+wXkFUTQhTf/jclrRTSRD1oHcTV7DgQkCt2Olr/PcBB2vgwmb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287823; c=relaxed/simple;
	bh=efT8/7km08T7pBrO07ujSxmypsAf8sMdycVHcxqyE5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eehYYU25sVoWgnZySgxuHID9JReQaRC8cLn7fcwC6+C2sidYaJxS2eRys8jjDzj/v7W8dMhPfHRqFAiZj90pW25stVvMyeeyBTODmg9a6rxQLN3eyzBDvNJw+qks5VRltp0IyD978KOKbLwgRDX9tWLBoUbegHhwrackRrduaSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j/sw2DNo; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C669B1BF217;
	Thu, 13 Jun 2024 14:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718287814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjx+jpjANBXkWfNXv0n4w9Dw5J7tAkEhzVptEspIDqs=;
	b=j/sw2DNo4scE93+h+/6YT6j5G8ntNQmY3MY1vSjbswlG5tTcqpWWpcaTXq1zEw/Ri4e+r4
	Y/14xT/tqSpncGGuvTdGeuDAbSuGq6OKh+i2yUXd1X/Rxm5k90RzP+31Xkko/KcvFc9T1j
	c1DsUqCsObAaooXmSJyWmWNXEZSMWICn7LBqGUwRUohunwbSNgKK41PZPWBt88QTwchlxN
	1Kz27eYuCP3Ap3cJP3lGy2X7zcRGRMtI54GiFNOHJQ4fQ7SZe2APBxlR/I+43fNLTtiwW9
	V31Z0aqHI2XLtDh1ijQrUK1tkdwiwuK3efmRS7x5B/4MWBJTAcsDeBKfO4duqA==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Thu, 13 Jun 2024 16:06:45 +0200
Subject: [PATCH 6/6] wifi: wilc1000: disable SDIO func IRQ before suspend
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240613-wilc_suspend-v1-6-c2f766d0988c@bootlin.com>
References: <20240613-wilc_suspend-v1-0-c2f766d0988c@bootlin.com>
In-Reply-To: <20240613-wilc_suspend-v1-0-c2f766d0988c@bootlin.com>
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

Issuing a system suspend command raises the following warning:
WARNING: CPU: 0 PID: 15 at drivers/mmc/core/sdio.c:1042 mmc_sdio_suspend+0xd4/0x19c
CPU: 0 PID: 15 Comm: kworker/u2:1 Not tainted 6.7.0-rc1-wt+ #710
Hardware name: Atmel SAMA5
Workqueue: events_unbound async_run_entry_fn
 unwind_backtrace from show_stack+0x18/0x1c
 show_stack from dump_stack_lvl+0x34/0x48
 dump_stack_lvl from __warn+0x98/0x160
 __warn from warn_slowpath_fmt+0xcc/0x140
 warn_slowpath_fmt from mmc_sdio_suspend+0xd4/0x19c
 mmc_sdio_suspend from mmc_bus_suspend+0x50/0x70
 mmc_bus_suspend from dpm_run_callback+0xe4/0x248
 dpm_run_callback from __device_suspend+0x234/0x91c
 __device_suspend from async_suspend+0x24/0x9c
 async_suspend from async_run_entry_fn+0x6c/0x210
 async_run_entry_fn from process_one_work+0x3a0/0x870
[...]

This warning is due to a check in SDIO core ensuring that interrupts do not
remain enabled for cards being powered down during suspend. WILC driver
currently does not set the MMC_PM_KEEP_POWER flag, so disable interrupt
when entering resume.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 4e7014670945..0043f7a0fdf9 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -982,6 +982,8 @@ static int wilc_sdio_suspend(struct device *dev)
 
 	host_sleep_notify(wilc);
 
+	wilc_sdio_disable_interrupt(wilc);
+
 	ret = wilc_sdio_reset(wilc);
 	if (ret) {
 		dev_err(&func->dev, "Fail reset sdio\n");
@@ -998,6 +1000,7 @@ static int wilc_sdio_resume(struct device *dev)
 
 	dev_info(dev, "sdio resume\n");
 	wilc_sdio_init(wilc, true);
+	wilc_sdio_enable_interrupt(wilc);
 
 	host_wakeup_notify(wilc);
 

-- 
2.45.2


