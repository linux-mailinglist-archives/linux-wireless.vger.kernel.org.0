Return-Path: <linux-wireless+bounces-8976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0CB9074A8
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 16:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3519D281AC2
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 14:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FF814535D;
	Thu, 13 Jun 2024 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="baV8suq5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBB11448D7;
	Thu, 13 Jun 2024 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287821; cv=none; b=CZ+6ypLyxU7aAONwd9KM+LQcLTNRe8mSQ1gDJhxhWxdeIPGMr5nchK7rnaVan1Sy9bMH5JvH4mGrx8vqcKRTvdMw2zszbp8Gt069x7NWyX+aYozmQ6+SsZFwvjNfQl8cCdQUC0gZgGnSan/GWcVYdUJ/h7c4o8a4fgVdIxK9K4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287821; c=relaxed/simple;
	bh=EunqTQzqUJ/F3JjE+G+C/6XlPd3N6vJCY/SP3DH8r0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WDhZRB3j4Be4X1Lr2v/0DBodIAUjhO4OL6DhI0gBim001MbUjfYQc+nokvJaRHRARu5yjq83kunjfWvGxTZvh1vtwDBVNkLWGk8jmHvNT6G/51n2tNjlopBb0AruI9wgyGVmxHVNjLKfoixAqHbnK+wICYc/72+vurS4us+UNOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=baV8suq5; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 432301BF213;
	Thu, 13 Jun 2024 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718287812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C+8CGh8peOxYqhyLXUs4A1Iy7daW4jSk3Jb9aFviGrI=;
	b=baV8suq5UfSJ8byMycRDYXiJEWCNgKschAdtStX9cmHOyVQ7go0km0aomrOqboJ9bO7Ctu
	X6Tb2HeB1RGCXsr5Kmo4rQvK3gH05XY8kXJ7sI/yLrLk2qPamtMJfWSQdQ85lrAH4ybNZ+
	Z+516AUehwZjqcNTpA8GR0Nmr6h4RTn6UbvJL1fed1hFYfN9gdBXIEIKnKCXokqpIhEOk3
	1c5UCwm5cNZAo6gzj36xwDUuCYzjYMITs6msoHSOYLFLMtAptAD6tWEYDrPYQhYYo84Ux2
	JhlvRM8OArrxFTvcpPzFrpRA756AqGxbeyyyGlLPjdFh6i9W1v3097K0yTxm3Q==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Thu, 13 Jun 2024 16:06:41 +0200
Subject: [PATCH 2/6] wifi: wilc1000: let host->chip suspend/resume
 notifications manage chip wake/sleep
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240613-wilc_suspend-v1-2-c2f766d0988c@bootlin.com>
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

host_wakeup_notify and host_sleep_notify are surrounded by chip_wakeup and
chip_allow_sleep calls, which theorically need to be protected with the
hif_cs lock. This lock protection is currently missing. Instead of adding
the lock where those two functions are called, move those in host->chip
suspend notifications to benefit from the lock already used there (in
bus_acquire/bus_release)

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 5 -----
 drivers/net/wireless/microchip/wilc1000/wlan.c | 8 ++++----
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 6461a3ec0120..4e478a2cd4cc 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -256,14 +256,12 @@ static int wilc_sdio_suspend(struct device *dev)
 	int ret;
 
 	dev_info(dev, "sdio suspend\n");
-	chip_wakeup(wilc);
 
 	if (!IS_ERR(wilc->rtc_clk))
 		clk_disable_unprepare(wilc->rtc_clk);
 
 	if (wilc->suspend_event) {
 		host_sleep_notify(wilc);
-		chip_allow_sleep(wilc);
 	}
 
 	ret = wilc_sdio_reset(wilc);
@@ -1003,14 +1001,11 @@ static int wilc_sdio_resume(struct device *dev)
 
 	dev_info(dev, "sdio resume\n");
 	sdio_release_host(func);
-	chip_wakeup(wilc);
 	wilc_sdio_init(wilc, true);
 
 	if (wilc->suspend_event)
 		host_wakeup_notify(wilc);
 
-	chip_allow_sleep(wilc);
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 41a5c0ed7480..533939e71534 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -678,17 +678,17 @@ EXPORT_SYMBOL_GPL(chip_wakeup);
 
 void host_wakeup_notify(struct wilc *wilc)
 {
-	acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
+	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
 	wilc->hif_func->hif_write_reg(wilc, WILC_CORTUS_INTERRUPT_2, 1);
-	release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
 }
 EXPORT_SYMBOL_GPL(host_wakeup_notify);
 
 void host_sleep_notify(struct wilc *wilc)
 {
-	acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
+	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
 	wilc->hif_func->hif_write_reg(wilc, WILC_CORTUS_INTERRUPT_1, 1);
-	release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
 }
 EXPORT_SYMBOL_GPL(host_sleep_notify);
 

-- 
2.45.2


