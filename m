Return-Path: <linux-wireless+bounces-7653-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CF58C5916
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 17:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C1F284299
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 15:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1EC1802DD;
	Tue, 14 May 2024 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OJfG5WYE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5863817EBAE;
	Tue, 14 May 2024 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715701893; cv=none; b=A2Ad4hfzgiG8IjcJuB3pLwEUAcPxjeGH+iL8pvZZ8T9KI2njGBvNocZcuSW+cBtSXXgIJSxRozEyHHMHVJGCZn03qd22E+I/E5uPsV+AD59lPZuw9+s3ko/MHz447Z9LKNGdZW4g+DWRj61sKQM5DdQjNha6KL1UKDQBeFGA3Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715701893; c=relaxed/simple;
	bh=eGHupbbAXrOuVkyU7yVyj7B+fR4iB6zqnc40QsMfo1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RjuGFVc5Y5JG9Jy3qKXnw8Yq5kaG+yUvtOa1wZE92y2jDk7AAyY8Pzj8zAcggwg/LCl369efqiE/m0GLnC3CEGqRQqJYnZmLah8Dq67Sz65rZzuqM/rkXm5/mkHGMuVRhqUT/VqjY1jPoi+HlLS8RAteSZ6P/4rsmbLWaN0ytKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OJfG5WYE; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BC1831C0010;
	Tue, 14 May 2024 15:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715701889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HWaDtQEb7dwOp/Q7435hr2efY4FLjjZYmFKQ/nPyw3U=;
	b=OJfG5WYEF9X2t6WBDV8uTU8sjG863kpJu0Wt3suMxzZ67oDjjQzwR3zzbL5/TNDIdXcY/X
	tbjtuXpnZcoF9jVyDfX4Sij3YRO4QIWJcXko9y84w0nGcZadc3/MrcXvPsqcLc3FLufD3U
	UE4FDHHgawUiuFcWx3tnVTN9jziy0JpJoN8/eE4asqmVXC3wSxWSCWQI1wUd1nI1xzDRlw
	WsI1SN8IoRR/I0U1+G5SZ/O3h/UP3glxG3NLIcGZL/ihaANauYZ7DNEPAvH1NP3oYHr/5d
	jAMXCeMHkrb6U5678trEYaB0VBaiT5RK9NWS35zOiqD0WL7Cahr0nZ5y6paXcw==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Tue, 14 May 2024 17:51:23 +0200
Subject: [PATCH v2 5/6] wifi: wilc1000: make sdio deinit function really
 deinit the sdio card
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240514-mac_addr_at_probe-v2-5-afef09f1cd10@bootlin.com>
References: <20240514-mac_addr_at_probe-v2-0-afef09f1cd10@bootlin.com>
In-Reply-To: <20240514-mac_addr_at_probe-v2-0-afef09f1cd10@bootlin.com>
To: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Heiko Thiery <Heiko.Thiery@kontron.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

In order to be able to read raw registers (eg the nv mac address) in
wilc1000 during probe before the firmware is loaded and running, we need to
run the basic sdio functions initialization, but then we also need to
properly deinitialize those right after, to preserve the current driver
behavior (keeping the chip idle/unconfigured until the corresponding
interface is brought up). Calling wilc_sdio_deinit in its current form is
not enough because it merely resets an internal flag.

Implement a deinit sequence which symmetrically reset all steps performed
in wilc_sdio_init (only for parts activating/deactivating features, for the
sake of simplicity, let's ignore blocks size configuration reset)

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 45 ++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/wireless/microchip/wilc1000/sdio.c
index a841dad08410..04d6565df2cb 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -627,7 +627,52 @@ static int wilc_sdio_read(struct wilc *wilc, u32 addr, u8 *buf, u32 size)
 
 static int wilc_sdio_deinit(struct wilc *wilc)
 {
+	struct sdio_func *func = dev_to_sdio_func(wilc->dev);
 	struct wilc_sdio *sdio_priv = wilc->bus_data;
+	struct sdio_cmd52 cmd;
+	int ret;
+
+	cmd.read_write = 1;
+	cmd.function = 0;
+	cmd.raw = 1;
+
+	/* Disable all functions interrupts */
+	cmd.address = SDIO_CCCR_IENx;
+	cmd.data = 0;
+	ret = wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->dev, "Failed to disable functions interrupts\n");
+		return ret;
+	}
+
+	/* Disable all functions */
+	cmd.address = SDIO_CCCR_IOEx;
+	cmd.data = 0;
+	ret = wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->dev,
+			"Failed to reset all functions\n");
+		return ret;
+	}
+
+	/* Disable CSA */
+	cmd.read_write = 0;
+	cmd.address = SDIO_FBR_BASE(1);
+	ret = wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->dev,
+			"Failed to read CSA for function 1\n");
+		return ret;
+	}
+	cmd.read_write = 1;
+	cmd.address = SDIO_FBR_BASE(1);
+	cmd.data &= ~SDIO_FBR_ENABLE_CSA;
+	ret = wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->dev,
+			"Failed to disable CSA for function 1\n");
+		return ret;
+	}
 
 	sdio_priv->isinit = false;
 	return 0;

-- 
2.44.0


