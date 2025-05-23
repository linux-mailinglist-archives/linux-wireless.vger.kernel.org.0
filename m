Return-Path: <linux-wireless+bounces-23346-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB33AC1D09
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 08:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC597A25BE6
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 06:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6263723236D;
	Fri, 23 May 2025 06:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPFEwNre"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD1122ACE3;
	Fri, 23 May 2025 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747981938; cv=none; b=jFju2gU85CCz1ur7ALZ7muR11Ml2HU4TqMUW6hooG9hAvDxp0y3brGLutSk4m1MszVjfG+HEu+D0QT6IPo9Ig957hDsDnCwXXExrkdI9YzyzpzczmTWhGnECU6hEWo+FgsrKN2l1DZJsWMz2ede2LY1A5Ctw8dlGTYaTO2xCLhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747981938; c=relaxed/simple;
	bh=i1i4lUjLydGHtHXlqa45gZX8A0N+/uuprgC+Wqn1VGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXISV5uNVWg8ujOaYKnNN7rKqGztyTAXesWohOOkQJfNthoV+vQnJeX0QCU9v3k8fd8XZ/iwjXMm8V1qs03QFYX8Ugx/X28ScPx1+PP1rw4D3DGE/GbaMq7aSSHWVyawbQLI5nID9EnKm/QPS7DlECvZ04pK3Czg+EUpcMn7kAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPFEwNre; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742c7a52e97so4938263b3a.3;
        Thu, 22 May 2025 23:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747981936; x=1748586736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZuJJhxcK7J+kxQGDdvcFFY2SCEPwvXY99+Aq8BxE7o=;
        b=GPFEwNrepqh3lnGNFetcs8cdwiN/J/Z7s0mphxNKlgzCu1P2SFZv5izzp/PBvD7vIc
         tvT8GxbBsRCkMWeWw/GCAMwFaiYpq34I2Y8EnntEG6J9DujMCvToWXGHGHCN2IF0hSCK
         EmHQkgVgA439l8z9R8XrhAW756tukaBsD5KkzhafvAkCDDiYWGW6BceodauVHx0B2PNb
         QlQKlbK6xBoXsgYQPXSK7ntXEIP9kZ3v1Hs69QCrRgFRtZ1Rordf1C2rREhc3TrbUg4N
         mK0k5AFq0WAfz1xzBiQ2TXinfXdwMbKcnVJ28XfYXFIoDLpIgTwLZXLggi+hHU+ZcSg5
         ZN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747981936; x=1748586736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZuJJhxcK7J+kxQGDdvcFFY2SCEPwvXY99+Aq8BxE7o=;
        b=GAT9DLIqoOHwO2mNaQjImYaeZevydT7YleS5RsraOH3MkXiATffWKTNWmRi3lF3o0l
         1ePbT21W1k0AQBk/ulaV+XkF1gKw+9uP2evnTSII+Cq9gA49V+CPcmCzLzUo2Qbk9GxM
         wvPP/0+kXIBcDVGemxbMyayV+ROCPGpDguEpPLHIC5e4uoZgHb5NS3zdfEpnbrvwwpiq
         9N37UM03ZEcNBUTD4Ox+dfpjDObosgNC8H094fylkEy21RGt+gNTHLBNsER2AD/HBox1
         XVNG0x8eSjXCv4NN1XkdGe5khpL4TZ114sBBuLyPyn2+n5CltseW//ZSmZ8XvMAqEkxz
         /8EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtujFNqqzhHH3TNny1EIurY/qKvFDisUvdQsCSxqZXffiLaXsJvpFrVKpubFuFOYpEa7jwtjL5fhdBJBYv@vger.kernel.org, AJvYcCV4fmQqHKsWTCrr5GoMfYYt9X2XFab8Ep45+2tMVTjmXn+VhhteUWaLcuSnzZzBUZVb99tcr+fhBKNA@vger.kernel.org, AJvYcCVauunm5Ztwrv+14TLiezt6fPBzIVC/bKrXB+nl3DeSirY85jHa6317yzRp/SaHs8y4Y3emO+sjApyTuQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8cT6I2iqf8zhy0xSPN4RS8VETwvdOuJa6/3toI9AIhQ4Mla7a
	de/cXJlunONoHR/y4nhqqxHR18Ljs1q8jA/Gyk7lk8vraCzriCqJqj2I+oqFzQ==
X-Gm-Gg: ASbGncv/Gt6JgnNgLuTvTrwD+cHKuvj2qinHuk03P8AFmTzxBHbWvA5NpDOw5ZfqVD/
	xmEAhP0HA36/lDDvxQ+sG8WHr3f6TwtwJES0mXOmXS5L4AwZeOzag64lIfN0AOYJFrgZms0nMbl
	pIVjVjvTaMyemLXQ6iMMCxpf9nXZwUy/xAVmT61gKGA1lsbNrKHcHJJpBB5qWiB0wlbRexjSnic
	y32B+TV2VqtjCD0hkV6yjTH8BgllRtNJCZBhOQ7WM/uk8M/f0GvAy+4JMihwv7X3sdW2Zlu9Ylu
	HcX3cePirCQKkDqd8bCTzAhZnXU=
X-Google-Smtp-Source: AGHT+IGB+VZX+R0fcyCXGYDjFfrjU0brwg3dtbtfYrgAm98FBMWMzMBYuesmehV/eqY14W47kHE7Og==
X-Received: by 2002:a05:6a00:6f27:b0:740:6630:633f with SMTP id d2e1a72fcca58-742accc555bmr40187255b3a.8.1747981935676;
        Thu, 22 May 2025 23:32:15 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97398f8sm12177783b3a.78.2025.05.22.23.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 23:32:15 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	nbd@ndb.name,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv3 4/5] wifi: ath9k: ahb: replace id_table with of
Date: Thu, 22 May 2025 23:32:06 -0700
Message-ID: <20250523063207.10040-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523063207.10040-1-rosenp@gmail.com>
References: <20250523063207.10040-1-rosenp@gmail.com>
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

Use qcom, prefix as done with the other ath wireless drivers.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/ahb.c | 47 ++++++++--------------------
 1 file changed, 13 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index 1ffec827ed87..c5e36f9e7390 100644
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
+	{ .compatible = "qcom,ar9130-wifi", .data = (void *)AR5416_AR9100_DEVID },
+	{ .compatible = "qcom,ar9330-wifi", .data = (void *)AR9300_DEVID_AR9330 },
+	{ .compatible = "qcom,ar9340-wifi", .data = (void *)AR9300_DEVID_AR9340 },
+	{ .compatible = "qcom,qca9530-wifi", .data = (void *)AR9300_DEVID_AR953X },
+	{ .compatible = "qcom,qca9550-wifi", .data = (void *)AR9300_DEVID_QCA955X },
+	{ .compatible = "qcom,qca9560-wifi", .data = (void *)AR9300_DEVID_QCA956X },
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


