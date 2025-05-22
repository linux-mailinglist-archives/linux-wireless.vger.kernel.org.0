Return-Path: <linux-wireless+bounces-23323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E29AC139B
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 20:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B4E7B2123
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 18:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8251E2823;
	Thu, 22 May 2025 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j02/VRtt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18251DF970;
	Thu, 22 May 2025 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747939525; cv=none; b=bIxFcUDB71cvcsKl2XdBUVBXUHWSD/CPbP7V7DTIvUxbfjnff07562VlcO1J8N+aTAtqTiiZI7qZkGfDZu9Yz0d3a1lXxPz5N+iWxZk9o3DrXHpsd6ZvXiyg50ujRANZVW6BlxEjRloInJD5FqGtgHuz7Sc9rGTlRF+JQc8QOIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747939525; c=relaxed/simple;
	bh=ccCfA8m5eJ6z/PwmU4k0oQB2uN3f5nv9EhXdOmJHb94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O//9kUxeKfui4mQU20jtSKF0p88++YxBd2jGtgPd5QquJr96Bv2jAudZvzLEQOZcOUQuV+pKipliQ1Dso19Rc8thhyW1HJxzHpgP5zDAcLO0WwGwfbhq02JppOx8p7mACfaYPGFRyV5TwNh8mSkfBMMLMfrEduR2T7fOSjwMMfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j02/VRtt; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742b614581dso6859784b3a.3;
        Thu, 22 May 2025 11:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747939523; x=1748544323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sU8tu3ohL2q9KpxApk9MimwHPPZSghjSuXZGOqcOors=;
        b=j02/VRttAzvw3b7vY2Is3bDVkgtwa6u1CEoVcc53tp+0C591FfKYW6xmIjoLu6k2uf
         CRO0dytsdH/d1ph3XMV0XsDuQOT5677NkvvNBGkUTm65hMjnbCuAz6B/sUl3mKnx+rYo
         J9En/Pq8C5XDhhiAzUCVRc6voYWnoCXxy0KeaZGO+JzSyFLcsGtU+NV7gK0k8IxMfXlQ
         e2J5cZh13oZrXJF1iEioWO34qob8K985MoWHJuT7APA9ItjpOQGyqwx50LPGrqk96/J+
         k3ic++azCWPfloBRT8O5PyBVnhyvVVJ08F74Z7WbuKufMtfOdSQql4LwvNYn7gbiRy0O
         HWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747939523; x=1748544323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sU8tu3ohL2q9KpxApk9MimwHPPZSghjSuXZGOqcOors=;
        b=w8eshZIRKkBevpXmPKpUrD/bhnyAmucUtQo/PioTklNmoJogVWWPPpEgoT6A7UFICA
         OZIzWPzfOYU/FjxYoPVl3ipy4Ew1cr/4WGU9x2HqWZLuYTICcEhRQ9YA8BSWHGizrfRF
         IInn0qF5ycMxkweplhdDCDJrxZyXHysFnYIDvkoblDh6OK3Nf7XWN4vCBtRLwySJnHNX
         qdeFxQnmj44q2WO88jcFpn2wWk+5GRKKKyvjrkedXsd7G22zvhWmE1jjwgOGFlxBFmCQ
         Z9bDWrH+js3E5o+kkOwGbrdSBiPy+phIp5Yp99q7tNnAvk3jIHvnIA7FSDJBdOJqZjh5
         9+YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD4F0Ms3fTXODNBnDtR3/gPJCJPp3nbUD4CXfUfmyBSzwoG32gFnz3Cx8lDV6GbJbRlNC8CEKKX+OhwA==@vger.kernel.org, AJvYcCXGZl7elphPY7ysQreR/9ufnZKXYTi2GX1QvjIMDlVIlusM04WKv8mbF60nzJNfZWwDlwsVUFwymIUxhHPF@vger.kernel.org, AJvYcCXyzgq+l3nFoHkmEjwIooh4iZqFF5E+QWTJ7rniV1LBCPt/QQL0aG5L9EobE6wQJfXlDRcRyR6zPTGX@vger.kernel.org
X-Gm-Message-State: AOJu0YzeFKnIWcc7D8kItsFOffmdC9+qx+uSzWsdfBtLNa7JwanBq0j/
	OeYumyZ+eM8z4RMP425sc8ySbx7OigcjZztvo5W1D4rJngGHnvPcCgCNfaBNsQ==
X-Gm-Gg: ASbGncuVGu3HHJ82wrr2u2WeQVRa8aTEUyqTIrvx0kOxbneih0A/rKouf0NYadfhYIV
	l/u5ewXNsfz9eW/mYwvMZ7vCB2AoUy3mtgFXYkVTwAYh0bR8NQ2/OLKvC0K+nAGlSyPBU/9IxRW
	UGKqzuSWLEjVKfnGmhBZnoA2P+NNYxMdmZ3MU0nUaVjg4K10C+zFFY2XfLLbIb7o3AxtGBr+sG6
	FPuJ4BXkcyqbk/5Rtqfag6IL7vkaBT0SCvvQm5faP5YouueCU1n/xfgPVYVJw/aMlIQalXJsP/1
	HA8Z89KX+6FDareeninkSrchCMw=
X-Google-Smtp-Source: AGHT+IHTu9EdFGaO+yT2zuz4yvO2A6r84V8N0d0zIG8Zy07aeacEepaTAm4uLsAPtHSS42wUE31VqA==
X-Received: by 2002:a05:6a00:399e:b0:73e:235a:1fca with SMTP id d2e1a72fcca58-742acd7281amr35701740b3a.20.1747939522823;
        Thu, 22 May 2025 11:45:22 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf6fd3bsm11502424a12.23.2025.05.22.11.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 11:45:22 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS)
Subject: [PATCHv2 3/5] wifi: ath9k: ahb: replace id_table with of
Date: Thu, 22 May 2025 11:45:14 -0700
Message-ID: <20250522184516.13176-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522184516.13176-1-rosenp@gmail.com>
References: <20250522184516.13176-1-rosenp@gmail.com>
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
---
 drivers/net/wireless/ath/ath9k/ahb.c | 47 ++++++++--------------------
 1 file changed, 13 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index 1ffec827ed87..d8b13aa329ee 100644
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
+	{ .compatible = "qca,ar9130-wmac", .data = (void *)AR5416_AR9100_DEVID },
+	{ .compatible = "qca,ar9330-wmac", .data = (void *)AR9300_DEVID_AR9330 },
+	{ .compatible = "qca,ar9340-wmac", .data = (void *)AR9300_DEVID_AR9340 },
+	{ .compatible = "qca,qca9530-wmac", .data = (void *)AR9300_DEVID_AR953X },
+	{ .compatible = "qca,qca9550-wmac", .data = (void *)AR9300_DEVID_QCA955X },
+	{ .compatible = "qca,qca9560-wmac", .data = (void *)AR9300_DEVID_QCA956X },
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


