Return-Path: <linux-wireless+bounces-11757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C3095A4C3
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 20:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8BDE2839F8
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 18:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CE2157E62;
	Wed, 21 Aug 2024 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="kbE50hXJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80051D131A
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 18:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724265414; cv=none; b=bofj7G6JYvIb8mSvFXEDcIafgrtnQ4uw+obGt1w3X8y8XQtsw/x5Ri2ZWshT2hRgnMTPIJ88vCXzsJh1rVjpGzWAhBAhLwp9Aj6TjGySwwYpxE6fFZMIyFmOdwX7CHiUtVljiEBnxDfOho5xqmfpCbRFY2Vek8ZnapJBFwHVK4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724265414; c=relaxed/simple;
	bh=YKuMBpI8V9fEFg+mlneD/HBmHkzVxEWiuaWqwB+u2v8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=msDj293WOa1uWp6//WZOaChbjwxfnKmvUCvUNRfUcX7vThIuLCaTuf9j1NnmEKIVdzWU8NzotYK0pU0nmBgEhmvMq/d0PqegVQixtUh6+AOIuzxjotJX1wS2DYbB/Z70y5y3iDJbZ5kR5RRVXC+8Km2GmfIJpqbGtwyW5SL/VQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=kbE50hXJ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 82B6B889A2;
	Wed, 21 Aug 2024 20:36:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724265410;
	bh=o1TROq3mbV8qt/hzdea04m5+rDQ9W/d8owom/XeNIRM=;
	h=From:To:Cc:Subject:Date:From;
	b=kbE50hXJk9Nv7Mf+Qu9AA74NVhxO7WuM26WSSua25/gkKBS/axELZGLJuCMML4zMQ
	 ElPN0TwgdAZ9xZQocZaF3w7RvYKib3XdnsvaqC1Om2m/Nv/otdTeH02oEYF6GQA4nX
	 7mVWYwqJv2PWUNLu8HCXAbjvOGm2xnBfbguxACp9QCs1jxextzyCH17PkymTH39vVd
	 JvFj047GHquaao2RJ/zNHS7cI+blaog3FIz0rTMopvd3W1xt24WaXm1Xc/V1Qk5PH9
	 3zEsuJhd9a+WVwi9Ny6bU7ChNDBTaLsFrQ8V7ofZykrnwRaZ/znzTZ18b15BlCiObq
	 CFFzksH2cxPbA==
From: Marek Vasut <marex@denx.de>
To: linux-wireless@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Ajay Singh <ajay.kathat@microchip.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kalle Valo <kvalo@kernel.org>
Subject: [PATCH] wifi: wilc1000: Do not operate uninitialized hardware during suspend/resume
Date: Wed, 21 Aug 2024 20:36:03 +0200
Message-ID: <20240821183639.163187-1-marex@denx.de>
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

In case the hardware is not initialized, do not operate it during
suspend/resume cycle, the hardware is already off so there is no
reason to access it.

In fact, wilc_sdio_enable_interrupt() in the resume callback does
interfere with the same call when initializing the hardware after
resume and makes such initialization after resume fail. Fix this
by not operating uninitialized hardware during suspend/resume.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Ajay Singh <ajay.kathat@microchip.com>
Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Marek Vasut <marex@denx.de>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index 0043f7a0fdf97..7999aeb76901f 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -977,6 +977,9 @@ static int wilc_sdio_suspend(struct device *dev)
 
 	dev_info(dev, "sdio suspend\n");
 
+	if (!wilc->initialized)
+		return 0;
+
 	if (!IS_ERR(wilc->rtc_clk))
 		clk_disable_unprepare(wilc->rtc_clk);
 
@@ -999,6 +1002,10 @@ static int wilc_sdio_resume(struct device *dev)
 	struct wilc *wilc = sdio_get_drvdata(func);
 
 	dev_info(dev, "sdio resume\n");
+
+	if (!wilc->initialized)
+		return 0;
+
 	wilc_sdio_init(wilc, true);
 	wilc_sdio_enable_interrupt(wilc);
 
-- 
2.43.0


