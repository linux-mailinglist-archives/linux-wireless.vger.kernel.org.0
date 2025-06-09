Return-Path: <linux-wireless+bounces-23838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C00DAD174A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 05:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3C1188BB59
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 03:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB05247290;
	Mon,  9 Jun 2025 03:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRQnotzT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737F0246765;
	Mon,  9 Jun 2025 03:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749438543; cv=none; b=Ee+94EuMqLUi9E4RfIeG+GecJkdP6t/axsu+cdtKYS9G73Idlja5ngdmW+lenGzT9KM3QcNHOj9wQO6cwcoTigT+uOH+NIVLjQF/7xN/vI7LaIe+LPbFwzuGWKN/rdACs+5oD7ZY1UIQp3IzQacNn2DmVHttRZRuOdGOOoRed+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749438543; c=relaxed/simple;
	bh=QsYZkT/NbQsL3tasQL6lLwOTE0/4vXL9e4kC6kIln/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgMdOVge7cUvaL3dSLxo7c4sSsJsfBGQRTp2nejgM/nxrd6BMClq5+YPwbLJAJdv0ho40dOzegr2FSN8foh6Ngg1RsFQmjw+YwdR9fYfprLzTM+S2Spu5G1nA3d3+OdIBVAlKCJFg7dhDp7mFE7l/RxHcVCeJxtOkaxiQ17QJPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRQnotzT; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3138e64b42aso309690a91.0;
        Sun, 08 Jun 2025 20:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749438540; x=1750043340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sD7kyhvx97jf4d7yhLX2hM1NJeiVdpq+a6+cEtdaCGg=;
        b=XRQnotzTR5ZyXbXvSbgCOaYxQTCkgwyMtSDP0zdPFNQnkgteBaVfNPaFKKqR4eXPfF
         IvIbcS4sVM/jI9fyUNglI9qJnjMNdx78y7ELf0bFJ9pFN7P3vMDIAsQKyestPg7AiBU/
         FdFD0GIp3wiSdw1d5X2IHp5yPPsinyC7P3SV+0Gr+JW9fS0v5aZnAy2jE/6+AIs9tVKB
         vuTeP2xHFhvrJy2OUVQPwrizKbJPolBaoaAkHfEqMQrWYuIr8UIsYziZw8SAsdJk/zrq
         KHWFP7Q2Llu1KV2z9tAo/KAsqn0yUpFEhJ9nMFgvAumpfbGp4KMAhOl/RfQWyOgs3VXv
         RIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749438540; x=1750043340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sD7kyhvx97jf4d7yhLX2hM1NJeiVdpq+a6+cEtdaCGg=;
        b=Su0Km6KXLrt9CR1CG7S0IdgFpuVKZPgdhFVlRBhbWmNxA7cDauTJLyGvyvI7/K7XA3
         om3JCnqVqcAEJbg6YxVrqJXyJ835k3/0Kxjabnk0Wgf6wGvigUhqTPIQK8AqdrNtesZX
         aCgwS7vjsmBDdLRyTVHCp/pibtoqPZR/NbRCDfw3e7gh+F+Rpf0Y3nqk9k5YIIVRICwF
         9TnN3azmNcgjQKs9Hf7orB69vAr7y+WxNpWKvYRXjnYCrmrqID2R38p/CGc6AgLQnMPw
         WAVXOjCpq6o4QznyieduRXSKudHdgpUgZqAnpaI+7K6MEtcf2mzcsK1fU/Y6VEAyOwfh
         I9/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDKPI2o1w3R2k8yyKMwomASlBLQnWCMcvIv0AyvOKlw/cvmMwvzwqZ7p8Na7KYFoxjt7Oq5kTXiLPxMw==@vger.kernel.org, AJvYcCUGvuYNcuywFC3bXnLSMdrWm//2A/2YhyPAiAOymKYDXxC5PqDcOibtvpX/2g+VWqIaRnBKO9lYT3sg@vger.kernel.org, AJvYcCX8vF5ARwWhOgli85YYrUAGVXWmd1Rw51sUfF2t8Ky4B4qbCXEoxjDYDj+625rOhrlBxPrH3djwNQNBs+yr@vger.kernel.org
X-Gm-Message-State: AOJu0YwGFFDCh+sVWZGPzkwdatNyg1/4CbcDFVM61rxa6Rq/pusw8442
	0uOVtBmzChhEre6Rd51zZFgCDVZ5Ld3vaVP7ljUDjmO93FrjjbQO7GAUWK2CXw==
X-Gm-Gg: ASbGncsPviTHYEOkID1BMfFBBLBFXvU95HE/vLxYW6mSlaz+WYrM1ScDDlov2GdqZbA
	Cp/3nb184iLecxFKhbJyGv65fTD1x1qchyEYQAbY08jgIOE8O8M6aOpY3lNsxdACavecSRw3phk
	5I3mRBz3WPo8fNj/6fQFyiSf2i6kLAYoDUrd0CBRzPBDhedfrpnE2y10lZS8+GPhh7z44/WXK8T
	mxgHcuvSJ3/goYIE2y/j5h+5ZVt+2BmHN2wPGB/hSYdk+drYCW1OFGiMlvuJUKh6poYmE6wbW1/
	3QHMHPdsg7GXSm3K7wA/S4iJvt4YMRBKJIehmQ==
X-Google-Smtp-Source: AGHT+IHjaI1XLorECs6VXf6ayoaN8Xki0c8Wan6ZX/tIInJGY/wysg8mihDMBTvYt/Z/zwaln/jyOQ==
X-Received: by 2002:a17:90b:47:b0:312:e90b:419c with SMTP id 98e67ed59e1d1-31347057cb5mr13488189a91.26.1749438540496;
        Sun, 08 Jun 2025 20:09:00 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032fccd6sm45310125ad.134.2025.06.08.20.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 20:09:00 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	nbd@nbd.name,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv5 4/5] wifi: ath9k: ahb: replace id_table with of
Date: Sun,  8 Jun 2025 20:08:50 -0700
Message-ID: <20250609030851.17739-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609030851.17739-1-rosenp@gmail.com>
References: <20250609030851.17739-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 2b0996c7646 , all of this platform code became no-op with no OF
replacement. Not only that, there are no users of AHB here. Add an OF
match table that mostly mirrors the original platform device id table.
Use a qca prefix as is done for the only other property: qca,no-eeprom.
Also used qca prefix for ar9530 as the latter seems to be a mistake.

This will be used to add ath9k support for the various ath79 devices
here.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/wireless/ath/ath9k/ahb.c | 47 ++++++++--------------------
 1 file changed, 13 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index 1ffec827ed87..802e6596a6a8 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -19,35 +19,18 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/nl80211.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 
 #include "ath9k.h"
 
-static const struct platform_device_id ath9k_platform_id_table[] = {
-	{
-		.name = "ath9k",
-		.driver_data = AR5416_AR9100_DEVID,
-	},
-	{
-		.name = "ar933x_wmac",
-		.driver_data = AR9300_DEVID_AR9330,
-	},
-	{
-		.name = "ar934x_wmac",
-		.driver_data = AR9300_DEVID_AR9340,
-	},
-	{
-		.name = "qca955x_wmac",
-		.driver_data = AR9300_DEVID_QCA955X,
-	},
-	{
-		.name = "qca953x_wmac",
-		.driver_data = AR9300_DEVID_AR953X,
-	},
-	{
-		.name = "qca956x_wmac",
-		.driver_data = AR9300_DEVID_QCA956X,
-	},
+static const struct of_device_id ath9k_of_match_table[] = {
+	{ .compatible = "qca,ar9130-wifi", .data = (void *)AR5416_AR9100_DEVID },
+	{ .compatible = "qca,ar9330-wifi", .data = (void *)AR9300_DEVID_AR9330 },
+	{ .compatible = "qca,ar9340-wifi", .data = (void *)AR9300_DEVID_AR9340 },
+	{ .compatible = "qca,qca9530-wifi", .data = (void *)AR9300_DEVID_AR953X },
+	{ .compatible = "qca,qca9550-wifi", .data = (void *)AR9300_DEVID_QCA955X },
+	{ .compatible = "qca,qca9560-wifi", .data = (void *)AR9300_DEVID_QCA956X },
 	{},
 };
 
@@ -72,20 +55,15 @@ static const struct ath_bus_ops ath_ahb_bus_ops  = {
 
 static int ath_ahb_probe(struct platform_device *pdev)
 {
-	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct ieee80211_hw *hw;
 	struct ath_softc *sc;
 	struct ath_hw *ah;
 	void __iomem *mem;
 	char hw_name[64];
+	u16 dev_id;
 	int irq;
 	int ret;
 
-	if (!dev_get_platdata(&pdev->dev)) {
-		dev_err(&pdev->dev, "no platform data specified\n");
-		return -EINVAL;
-	}
-
 	mem = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mem)) {
 		dev_err(&pdev->dev, "ioremap failed\n");
@@ -118,7 +96,8 @@ static int ath_ahb_probe(struct platform_device *pdev)
 		goto err_free_hw;
 	}
 
-	ret = ath9k_init_device(id->driver_data, sc, &ath_ahb_bus_ops);
+	dev_id = (u16)(kernel_ulong_t)of_device_get_match_data(&pdev->dev);
+	ret = ath9k_init_device(dev_id, sc, &ath_ahb_bus_ops);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to initialize device\n");
 		goto err_irq;
@@ -156,11 +135,11 @@ static struct platform_driver ath_ahb_driver = {
 	.remove = ath_ahb_remove,
 	.driver = {
 		.name = "ath9k",
+		.of_match_table = ath9k_of_match_table,
 	},
-	.id_table = ath9k_platform_id_table,
 };
 
-MODULE_DEVICE_TABLE(platform, ath9k_platform_id_table);
+MODULE_DEVICE_TABLE(of, ath9k_of_match_table);
 
 int ath_ahb_init(void)
 {
-- 
2.49.0


