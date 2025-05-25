Return-Path: <linux-wireless+bounces-23388-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A904AC370E
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 23:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0213B6395
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 21:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D630A1DE8AF;
	Sun, 25 May 2025 21:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4xQZxBy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4A21D63C0;
	Sun, 25 May 2025 21:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748209386; cv=none; b=PUhs+gSjNap4aHK5PIab4Ek+Mr0Tojv5Hh0OyrP1ViWG/aJAA39mf9q/1zqJ+J5dN3ieqK/otfYFJDjW4xMT1dXXeYwEEdlTCqmS2oztZx8WjfWSgYBNqxkmwGHmqeDQfjntd6V/xij1BUcpKmIdxrWL5gUGXvnl8aPdAGxmT7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748209386; c=relaxed/simple;
	bh=xXYJZa6djdzra6KuG486HyIlMt0+yAuf8QPiZ6/oVJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wp8h0SZezojidH8jaOKAr60U1mtmclNiTROohWwVT167+q23MkpE8KWme9TxGL0J5QZr17vQ2I/+AK5QiWhL6aXNSacYMyT/m+BYuLeHAR+XmgXz6QZITVz5Na/bksDTGqLuC4ejgAsCY1aC7vVHAATXQrbtdi/+gsLPfyC6yLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4xQZxBy; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234549aed3cso3397625ad.1;
        Sun, 25 May 2025 14:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748209384; x=1748814184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSLUPkGTtkO5bJKFjSRG2EsUIbkTzOUNIX1Qd+hd/9c=;
        b=h4xQZxByELTFxqzaAaFVT+dh+xBzXBdEK7ClHzUEgFWNrkDzVKgZsusedOSTvTXfWg
         f3lsAJDTTZncAFKCl29j8htEoc2PkWj9WNhG8ZyFRIVQn69f3yuHEQ+XTUgMMHPNDg3X
         678jbQ+rPo1TiRBDJE9RbFaRs5IiRUuJqx2HGiENA0A4YAe3txyETsapnwq1rZC1VNlx
         xkJ7VGfRKoo2lVQysPTWi8PBgOqPhQ2ZEPD8ecYFKzfIvVHkBc5OFhtP4YathCUhJv+1
         xGKjnasRSE92m0TWW466m0x3j6R+wSPnoHPZ1u8VPggTr3Fvo+uYviKsMEyHHL/8wa29
         TTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748209384; x=1748814184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSLUPkGTtkO5bJKFjSRG2EsUIbkTzOUNIX1Qd+hd/9c=;
        b=qbqCgXTtBYi3wgaRkKJf47MKyT3PydQiJN44CKBaWbsbZ85NxzSpMl4lnPmOcDH6+e
         rpB6LEs/Tt40WqCqZL+8FU8Feaw9B8kJpPfdTX+yZLvEI5GX0Z/LxYl2lkyNcab05jY+
         f3Dl833DRy2rk4kC5L7CZCy8giT08rb5VsXGLwqJiUHXPRyCuA3ZzJPIMbFbw+f62EIT
         +tbA+jd8aHn45L603I4/TlilO9sm/fZQ3/gxffghw81sz16niYakObspUgnMv+hI1Tu6
         8Os+fKztzKMc/ux1215WVBn//JCIobSQa6UHieoI3PMdE+bZfmdNfH80r/hGQLcph3YU
         3T1g==
X-Forwarded-Encrypted: i=1; AJvYcCV+Npc4iu+LktwLJ8pGMvld//pX9mTdf9/pFCQZ9FwTJt7yMv/XVeJpgD9h94m5+YCb2G80zeOuUWElRByM@vger.kernel.org, AJvYcCV6/5ABzxOXNyE9ZBdf3HG4PG8sLiXwxhVhDeGFSbs8GVzrKGsUQDcAlOSMP3AQ7tdRD6j06qyv8bg6qg==@vger.kernel.org, AJvYcCXgpqepDSuGsY6MzOo2hnxURYv4+IZRdYsUfG71UEcFzQnKA7WaxrAT3b8QuLabhRDFC1yxi3k1esw8@vger.kernel.org
X-Gm-Message-State: AOJu0YxZXb5zBUBl0kIuThp+z3QWTkMVZnmTYHIwY3ZOTrV9DP0gATG7
	U9gowWye/bkCy6NpodPe9NaLIuJgdz0kLyV2H/x3JNeGSfBdpay6kN8N60rZ3A==
X-Gm-Gg: ASbGncsXo+gdiWGj3xvnQWm9VA+PJC8eZL3sODpU6Qjmu/oVRbyGhwFKCa2ES/iRPXR
	QtfOeFD5I3Eb0lmHwee1YJP9tAJsuTRgN+BeIbcpZEjl94MPEQ0sFbo2a3/27qa1OjxA82wYiPL
	KJXuhlLirejTsGPpXqq9bXWETpWOHzZds8XO1ojtg2+c5CiYbeDUO0xJiSLhfoRgDq7HMQU0BPw
	aM2qhSGD8JO1pqjta1EmCdcgaqYJDb1OUe0anHEjtURcn8nM6dw2cgiNRLmngMrnPVVs5BWjrla
	pmkDd3OLnXetCsADAwJyFYIYomk=
X-Google-Smtp-Source: AGHT+IF9Q+GLeIaqs42Kqzx//dYC/Cv4WVB3aWHvrJmbmsewdxyM5nPAwmiT9yolYBNGS+Q0JaqV2g==
X-Received: by 2002:a17:903:4b0c:b0:231:bc6f:7c69 with SMTP id d9443c01a7336-23414fbcf33mr116363645ad.35.1748209384379;
        Sun, 25 May 2025 14:43:04 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2340934d91asm35083115ad.166.2025.05.25.14.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 14:43:03 -0700 (PDT)
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
Subject: [PATCHv4 4/5] wifi: ath9k: ahb: replace id_table with of
Date: Sun, 25 May 2025 14:42:55 -0700
Message-ID: <20250525214256.8637-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250525214256.8637-1-rosenp@gmail.com>
References: <20250525214256.8637-1-rosenp@gmail.com>
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


