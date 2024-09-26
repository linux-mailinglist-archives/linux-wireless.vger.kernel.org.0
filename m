Return-Path: <linux-wireless+bounces-13235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5569879BE
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 21:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797D51C23194
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 19:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9753D15D5B9;
	Thu, 26 Sep 2024 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="a8P3B8eF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D5415C148
	for <linux-wireless@vger.kernel.org>; Thu, 26 Sep 2024 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380295; cv=none; b=M8gh/ZhJgpUQDt8SQ50rePWQ7HzkTYmCRddMCuxJpglX2PyVQIc4lWJGIQEzO2nvEvJ6pGxvod3BuToItf2n5WEzmqUSWlwjRk+KYyzv69F+9zTMbr0st4KilCuE0oYy3bZU/IXwDYd/SLbcb8JD0jdNgLKkDo45UIxXXkxr6m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380295; c=relaxed/simple;
	bh=SPd3zAZg19dXX6BsGCJjjIyr2Exanw7VZgft8ALOxGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RRxNM+ULpJhPx8UWn+O0Pwaz8er0aaVfvZ5w0cumFfRokzQZqf3FTvF0BUYiZW8HM8zlYwTYOhRqSO+6VLaMZmG81WRizIyPpauJz5c8GSuL6obEqPK+GuExtDue2/42RjchlbS1RGDuizcOKc+bEB73H5Ve/zIdLHhjXx3cUec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=a8P3B8eF; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id C66B388DB5;
	Thu, 26 Sep 2024 21:51:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727380284;
	bh=e5QDfThEcgcxvCWAUSCI4tqau1Fp8OpSk84LtgEjs+c=;
	h=From:To:Cc:Subject:Date:From;
	b=a8P3B8eF4iSfnp44fCkh/uL0V98f4bjvNp7h86uWJSjqB53lUdYz/fHUpBCN8a7Kr
	 fNIxDgYBKchOiSZz2aZEDJhKCdayq0tlqi8Qd2wZkd84aYWkPIZ3aIqpmytFk7LY0D
	 qZDPKF/80wSBOnmbgvag1FOpwlnL3tsobX+DlP5FDNam4z4RP1l7J7nlCSHnRQqKEs
	 fiA0aDMaEINO+bYVaK8Wb9q1yIvjWRqkDPy04NNKjupHcRtl+eGzlaZADoIR7fgYuE
	 iYxmOOrLaKkXs368YuC0FB/Mk+lruT6JTUr3B0Tsy1pI+FQu9MxKBKJ0DwC/b85BYX
	 Non6ZShPcoKFA==
From: Marek Vasut <marex@denx.de>
To: linux-wireless@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Ajay Singh <ajay.kathat@microchip.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kalle Valo <kvalo@kernel.org>
Subject: [PATCH v2] wifi: wilc1000: Keep slot powered on during suspend/resume
Date: Thu, 26 Sep 2024 21:50:55 +0200
Message-ID: <20240926195113.2823392-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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
V2: Rebase on next-20240926
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index b4da05d5a498a..d67662b6b2a1a 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -969,7 +969,6 @@ static int wilc_sdio_suspend(struct device *dev)
 {
 	struct sdio_func *func = dev_to_sdio_func(dev);
 	struct wilc *wilc = sdio_get_drvdata(func);
-	int ret;
 
 	dev_info(dev, "sdio suspend\n");
 
@@ -983,13 +982,7 @@ static int wilc_sdio_suspend(struct device *dev)
 
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
2.45.2


