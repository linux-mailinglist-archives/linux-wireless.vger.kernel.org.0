Return-Path: <linux-wireless+bounces-11759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FF995A4C7
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 20:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2935B211DA
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 18:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882CD157E62;
	Wed, 21 Aug 2024 18:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="jvghUhcO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15C41D131A
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724265518; cv=none; b=EdE+vSO6YPhtmCc5tsrZzxEeCiv7ZH5Mi+DNFCjCwVeJjL72gu8Sz/XgQeYaAvA50I6HccwPkLMt8q2V0x96AYj5FMjLufMFY5iruKd38ORK649oAozlA9Uq6CWnho5TVaxJRyR3PamZNpae2SNsjl58b3HuDWC9eYeZSYk2jJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724265518; c=relaxed/simple;
	bh=9+tql3TKYaTKSp2O84b07sYSKD6NpesPzaFBAL844J0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BtQvdN5vNY+h5oor0WfoUaQd8MXmJO3b5wAr3n35L/p/1lSfIkeVeiKjfuI2fbzo9Xgk1PLgZ/zkgY6fnzVgaebF6p6CNpd1PvNL5/FYqYBlJ2jOUjw9RCH7Nt5D24CXzIdxglVtIoYthXF66VR0FtPtcbx1EQRHNPd4ZL3OysU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=jvghUhcO; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 8855188E3B;
	Wed, 21 Aug 2024 20:38:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724265514;
	bh=DevjczLzEH3kJ3/P1/A1T7rGoDnnjHLONE29dmMluUk=;
	h=From:To:Cc:Subject:Date:From;
	b=jvghUhcObQeBZiGxBWQTlDvFMeIP225vtmIuIIrJ/TuIiG6PFHe/PtP9cS8MkAYFh
	 3TI90R6qqzG4dYy2qTXApgPxELjgQkmZK5kkuP9j36WM7DOp/J1qtTeuZuBp7Hq/R1
	 cGbcYqsNLYiXnJWS3nSm8alvECzdROKnoTV6ovEAe1XkG24GbRqZRhxZywgI/WoyG9
	 X/1tHuUGGTOJJfddkE1TVJk231qJwaDTBaxDM31lq/3201e3l/K3ocEwuHcae9X8Jz
	 iOLeRuOcPs3va+EKMdY+WGQCH2NkxEEMd//AmspfK2PaHDy66wIkH8RJ8vS0GRQoPf
	 R7QHDgH63QLdQ==
From: Marek Vasut <marex@denx.de>
To: linux-wireless@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Ajay Singh <ajay.kathat@microchip.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kalle Valo <kvalo@kernel.org>
Subject: [PATCH] wifi: wilc1000: Keep slot powered on during suspend/resume
Date: Wed, 21 Aug 2024 20:37:36 +0200
Message-ID: <20240821183823.163268-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The WILC3000 can suspend and enter low power state. According to local
measurements, the WILC3000 consumes the same amount of power if the slot
is powered up and WILC3000 is suspended, and if the WILC3000 is powered
off. Use the former option, keep the WILC3000 powered up as that allows
for things like WoWlan to work.

Note that this is tested on WILC3000 only, not on WILC1000 .

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Ajay Singh <ajay.kathat@microchip.com>
Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 683a35c682a8f..41122199d51eb 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -973,7 +973,6 @@ static int wilc_sdio_suspend(struct device *dev)
 {
 	struct sdio_func *func = dev_to_sdio_func(dev);
 	struct wilc *wilc = sdio_get_drvdata(func);
-	int ret;
 
 	dev_info(dev, "sdio suspend\n");
 
@@ -987,13 +986,7 @@ static int wilc_sdio_suspend(struct device *dev)
 
 	wilc_sdio_disable_interrupt(wilc);
 
-	ret = wilc_sdio_reset(wilc);
-	if (ret) {
-		dev_err(&func->dev, "Fail reset sdio\n");
-		return ret;
-	}
-
-	return 0;
+	return sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);
 }
 
 static int wilc_sdio_resume(struct device *dev)
-- 
2.43.0


