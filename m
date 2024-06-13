Return-Path: <linux-wireless+bounces-8979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCBF9074AD
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 16:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64FE11C23278
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 14:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5226A145B01;
	Thu, 13 Jun 2024 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="obA6lYP1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42725144D28;
	Thu, 13 Jun 2024 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287822; cv=none; b=IsrRFxS20GNZUbttzQVgwv0OlrImZvCO1ioTrqjR+qYDfDmhoodWe/SUTKEln+AN4k/KnRYMB0shmDw5xvra8zWpoc5BtJsZBH2TGdxftmO7lZiYsiKP2eQeg8o5ckDcmsOqBjOcyrguMSja9l14Xg5dt3XVINlIwTJb/FxFUIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287822; c=relaxed/simple;
	bh=/3/RjwKiLLAAqUv9PGd3NtY0FMHGe7Zhcncw6CpFJDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fvx6M/UshU1ORLMFP4br1orO3lBbEGeDsZzCJ3791/vHsFHPHlWmSCJiFT0hiEnOsgJnJko4hRwk636FjjmwlZf3nySfGyN4QD91H6WNfx6bsvO6m8lN4844YkvOYRxDD81zXSCjv4q/hITxZzbMuN4yipdc59CtjTvkY+6FAlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=obA6lYP1; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 094581BF20B;
	Thu, 13 Jun 2024 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718287813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EiSm/eUhJPdOIyUa5VFuIncGFB6F3tSxO/MVBLvrj6o=;
	b=obA6lYP1b5MFxeoJiVqPP5phg75NGILqBqn3OQSWn7qDIUS0GFj5JWpWoxJeMc+0JKVPmI
	3ecr7Kcv+LbogiiGP4XXyjxBAPp3EjXYRVTxn1tFLR0mt8w3Ut9Bwonq4IITdVW2v91GEL
	6+1n+ZWiqMjGbdCVT/+LvdXWJ1t7xk2HDFme3CnJ8uMOAC3zd5lvwB6BH4eD8LkX98fzUD
	5pnHnK9lu7DbQaToC4ZqCWqQ38sH4lf3zt1I6tImB2PyFYJIJj5R9/F1u01BO35+wTCEgO
	aHnSSEIZiXX4XJ0C2fZWoT9iOPoIC78oZM+5WjFxZNuW/gP3VVpX+MkwaWvjtg==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Thu, 13 Jun 2024 16:06:43 +0200
Subject: [PATCH 4/6] wifi: wilc1000: move sdio suspend method next to
 resume and pm ops definition
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240613-wilc_suspend-v1-4-c2f766d0988c@bootlin.com>
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

Just move the suspend method next to the resume method in the sdio part

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 47 +++++++++++++-------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index fb4de3de1140..21398a3c600b 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -249,30 +249,6 @@ static bool wilc_sdio_is_init(struct wilc *wilc)
 	return sdio_priv->isinit;
 }
 
-static int wilc_sdio_suspend(struct device *dev)
-{
-	struct sdio_func *func = dev_to_sdio_func(dev);
-	struct wilc *wilc = sdio_get_drvdata(func);
-	int ret;
-
-	dev_info(dev, "sdio suspend\n");
-
-	if (!IS_ERR(wilc->rtc_clk))
-		clk_disable_unprepare(wilc->rtc_clk);
-
-	if (wilc->suspend_event) {
-		host_sleep_notify(wilc);
-	}
-
-	ret = wilc_sdio_reset(wilc);
-	if (ret) {
-		dev_err(&func->dev, "Fail reset sdio\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 static int wilc_sdio_enable_interrupt(struct wilc *dev)
 {
 	struct sdio_func *func = container_of(dev->dev, struct sdio_func, dev);
@@ -993,6 +969,29 @@ static const struct wilc_hif_func wilc_hif_sdio = {
 	.hif_is_init = wilc_sdio_is_init,
 };
 
+static int wilc_sdio_suspend(struct device *dev)
+{
+	struct sdio_func *func = dev_to_sdio_func(dev);
+	struct wilc *wilc = sdio_get_drvdata(func);
+	int ret;
+
+	dev_info(dev, "sdio suspend\n");
+
+	if (!IS_ERR(wilc->rtc_clk))
+		clk_disable_unprepare(wilc->rtc_clk);
+
+	if (wilc->suspend_event)
+		host_sleep_notify(wilc);
+
+	ret = wilc_sdio_reset(wilc);
+	if (ret) {
+		dev_err(&func->dev, "Fail reset sdio\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static int wilc_sdio_resume(struct device *dev)
 {
 	struct sdio_func *func = dev_to_sdio_func(dev);

-- 
2.45.2


