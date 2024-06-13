Return-Path: <linux-wireless+bounces-8977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D549074A9
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 16:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B861C22BD4
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 14:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0621459E8;
	Thu, 13 Jun 2024 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VmFJEbaV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA7B142E73;
	Thu, 13 Jun 2024 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287821; cv=none; b=KN+07GmtVFm29AuBp40XgkEd5NXf8ZAVjMZKruG7XAbzldIicZK0nLHfNvYxQHQYoaCD4reUZx6pGrenNHi4g+v4W/iEbPjdCRZGQT81g0RUoRjJtGPyCwEX2Bm4hGu1T4z2Uo4dszuGGt6/sKXup51F5Ofm79Kw4IeXXiXJyQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287821; c=relaxed/simple;
	bh=kfbDOTov0/7uKDAmdCfshJARzEdStSiJq1qjZfUJEvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WnsgQHBcBx71HbpysGHC/eHICsdLvqo+Mua5t8NP/b8bYS0Y5sgPz1oXCbM/lTUnNnKP6Km2I05f8ymeU/NH5RZkdYGQXTSlLCIHBhpv+Iu6xZW1EkbZqR3shbW40dTbBnh35xSDxaXs1EfazXYcZ6Nme0wS//UszJdaZ4xJ6G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VmFJEbaV; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D9AE41BF211;
	Thu, 13 Jun 2024 14:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718287812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJ/8Ln8PiAlnF/RNZphdxqw6/7DeJ5l7lzf3rL7r59s=;
	b=VmFJEbaVkjgUtVGCNpij8d+BhEpJDDRps6/9iul5OKTCS1fcbH4sothWfZK6PcpnOx27A9
	9ogIujCO5q7tzcLvNqo0PKQ2Zkz9n1cVLotxehykx/yl1TOMb+Anwj6bVwe2F0Lxi9/CCF
	sUMFT8AEKN7tFSHuQML/05WmHr6kiHBmE3nWF7eFQPG5eZwIzWmxaQI+zu1AMlsJKnupio
	TvlnobClnh0lUHAcIrn1k54sLYuljWw9F2aMfJBMValmBZ5WQV+doh/TR0QPFETaYYiPUW
	RCzRLomv5cTJf+jAKR0zTHh2aJUS5oyE3tmXxSYp154ae7PQi+Ut4YSdbOXt6Q==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Thu, 13 Jun 2024 16:06:40 +0200
Subject: [PATCH 1/6] wifi: wilc1000: disable power sequencer
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240613-wilc_suspend-v1-1-c2f766d0988c@bootlin.com>
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

From: Ajay Singh <ajay.kathat@microchip.com>

Driver systematically disables some power mechanism each time it starts the
chip firmware (so mostly when interface is brought up). This has a negative
impact on some specific scenarios when the chip is exposed as a
hotpluggable SDIO card (eg: WILC1000 SD):
- when executing suspend/resume sequence while interface has been brought
  up
- rebooting the platform while module is plugged and interface has been
  brought up
Those scenarios lead to mmc core trying to initialize again the chip which
is now unresponsive (because of the power sequencer setting), so it fails
in mmc_rescan->mmc_attach_sdio and enter a failure loop while trying to
send CMD5:
mmc0: error -110 whilst initialising SDIO card
mmc0: error -110 whilst initialising SDIO card
mmc0: error -110 whilst initialising SDIO card
[...]

Preventing the driver from disabling this "power sequencer" fixes those
enumeration issues without affecting nominal operations.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 15 ---------------
 drivers/net/wireless/microchip/wilc1000/wlan.h |  1 -
 2 files changed, 16 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index e6e20c86b791..6461a3ec0120 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -907,27 +907,12 @@ static int wilc_sdio_sync_ext(struct wilc *wilc, int nint)
 {
 	struct sdio_func *func = dev_to_sdio_func(wilc->dev);
 	struct wilc_sdio *sdio_priv = wilc->bus_data;
-	u32 reg;
 
 	if (nint > MAX_NUM_INT) {
 		dev_err(&func->dev, "Too many interrupts (%d)...\n", nint);
 		return -EINVAL;
 	}
 
-	/**
-	 *      Disable power sequencer
-	 **/
-	if (wilc_sdio_read_reg(wilc, WILC_MISC, &reg)) {
-		dev_err(&func->dev, "Failed read misc reg...\n");
-		return -EINVAL;
-	}
-
-	reg &= ~BIT(8);
-	if (wilc_sdio_write_reg(wilc, WILC_MISC, reg)) {
-		dev_err(&func->dev, "Failed write misc reg...\n");
-		return -EINVAL;
-	}
-
 	if (sdio_priv->irq_gpio) {
 		u32 reg;
 		int ret, i;
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/wireless/microchip/wilc1000/wlan.h
index d72a0a81bbda..dd2fb3c2f06a 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -56,7 +56,6 @@
 #define WILC_HOST_RX_CTRL		(WILC_PERIPH_REG_BASE + 0x80)
 #define WILC_HOST_RX_EXTRA_SIZE		(WILC_PERIPH_REG_BASE + 0x84)
 #define WILC_HOST_TX_CTRL_1		(WILC_PERIPH_REG_BASE + 0x88)
-#define WILC_MISC			(WILC_PERIPH_REG_BASE + 0x428)
 #define WILC_INTR_REG_BASE		(WILC_PERIPH_REG_BASE + 0xa00)
 #define WILC_INTR_ENABLE		WILC_INTR_REG_BASE
 #define WILC_INTR2_ENABLE		(WILC_INTR_REG_BASE + 4)

-- 
2.45.2


