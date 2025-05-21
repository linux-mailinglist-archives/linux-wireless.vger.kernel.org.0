Return-Path: <linux-wireless+bounces-23196-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D19E3ABE9B0
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 04:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B5B1891691
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 02:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB5522F3B1;
	Wed, 21 May 2025 02:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZE2cHUR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DE722DF9E;
	Wed, 21 May 2025 02:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747793766; cv=none; b=F6iEzFtsBk+8gaQstrI+umduNV5YAWH67gEsdUVU/hpun9BQ61hiNm07aqclAwSKvab5DufMMReTnhVmPKYedXUaiJaDpbMiDFwjtc/yqdx9z3B9opeXH9Gc2oTTIDh7gkubEA+on/4xj1BIAoIrcLIiH0s1PX8E5N5VmNqUPa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747793766; c=relaxed/simple;
	bh=SlSOcQgN7YP8cHQxy2ZIWkw1Hglxii84ZTx3i9OY9dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NP6kPx/tDSG4c1iH3YykRAnszAVMqchcHKsRiPwvAjecVju0uOmFHzVduNNYNWgcqWGsEeoaScK6Zy33YqqSbPu5szyrgzk3IdLcX8Gxucq+4ZjBzTWm/tb0So7Akk8YCBGp5lQs8n8fZSH+P5a87oYoaImewsl8mdX6DaaJjZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZE2cHUR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-73972a54919so5903386b3a.3;
        Tue, 20 May 2025 19:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747793764; x=1748398564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SL0XUb+xwVI+XVguaPnavzoxmyDhD/LnbyyWdtPy0bs=;
        b=YZE2cHURP2haz24hJGfGP9Fa7iec3ezbbwrOg+0o+coKejdTv2suZgF7TOoKAq8jY4
         1FCh77JMEzmc/ugyaqsDoPJ97CVIUlLWLBP+Cmp7BhquwLXxF0pnc28J+6pKY7Gg2ee2
         cOuwp+Hzy90vTnICZcqEvg82alftZ/hjBDp7sRm74kQzsKZrulDitXp0EQOSzN2YRimM
         64NzmFr2zHxJm9giw9tZG0A99OxFm9hPoNO989fGmnpa1KvHKZJV89Qguo76c4iMxX4I
         qnTKr/AS7TQ+o6ooVs0jfkx+Goq6AWEe1ax0n4xYe4CFdXXL+DGFotqZcwE7l1l/Nwnm
         5rzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747793764; x=1748398564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SL0XUb+xwVI+XVguaPnavzoxmyDhD/LnbyyWdtPy0bs=;
        b=EAHc114elY9C3ubKgE70NYTpi6s6w+s8KjUDRAZP2rVkhCrdivKH9uAen8eSR3fI9O
         D7nY2clMZmdFDBHuIxnmQGr+XcCTVmeFUt+eLzgVkEu8yC9S7HWzZc0xcOzHugpOUl78
         cmdvcy2kufKO1qc5YrKIs0EnpOW1LKsS6sHGN5rC4sEsMbf2rAXLzEBBc8elEGoCK9rz
         7xVkTbnLUrHpZdsXtLv7zToLl1LTHTkGFQrdk5fsTbpzhM5W/tOWtrm9Epezd1eG3CNO
         f/TY3gRycCFWA2NXa8ssDcoPf8+1dkLek5+10DbwKeAF1Stj04D0INAFnSnMMoof5CCi
         PgDg==
X-Forwarded-Encrypted: i=1; AJvYcCVWh4e5jKXyo0JA3kJMXLrMfeOnqdO/vB/a1xJr83FiuGorlRwP7FX/0NnMI1MGn8XAICTuk3WNLZZZ3A==@vger.kernel.org, AJvYcCW7bNWZFVWOHYWZk5zr2siWfGOjSFeIacKBKn1vBsRJWLhKVUiSQD/ykYf1mPonH/zjf6pKvNy4eU/G@vger.kernel.org, AJvYcCXdd2ttPDLUPbae7qDlDiq0H8g6ixT+yXhCnILwkFXEnGjSBx766z15IdaI3Zdf4+o1JRO10vuu5lU4MTbp@vger.kernel.org
X-Gm-Message-State: AOJu0YyNhqwE/YhMjlJ9onmL2gTFb/T099Xbux3GlXqqs3Pa1nVZp+oY
	TS25oVPkmz4gTC8e63+zWDVHbsJ+NzM9azapadROkQ5wZlKGBt/G1DCkCOjVvQ==
X-Gm-Gg: ASbGncu62H9dN96Trpwwtx1+y8oA6feXtkHogNC2dXZoF2a3hD6QVP13iTnT4irqz+0
	Fzfhb5AT9RGQUc9Se+cAiZGCLw6iBPFBzPCtX6K3fpfki4agsJQT4zc2+W5kakwnix48h3SzpbC
	BacB8etXacRr+ypxTqlMlA+zkdmXYMjy0eqLf7hEis+d2BEsTI30GWmh6jgGqaBx2VPIm7FqPo6
	DEP0yXB8g0VAYR4ZWy7l7j7Nh0CprYc01EgA+bmjuxRRSDdb5W6YLuKpvPaKqlCdeBF4Z2sON4I
	4t9tTvPDdqxHFOYixkUnilGzcYA=
X-Google-Smtp-Source: AGHT+IGoIdFbWQ3RWjgWKSxSDRCvGnxaBnEgnG8YXNPLNpCHoZ3pFGfHEuEit+gjOeYkwv5j9mNjoQ==
X-Received: by 2002:a17:90b:1dd1:b0:2fe:80cb:ac05 with SMTP id 98e67ed59e1d1-30e7d51fa18mr34101971a91.9.1747793764294;
        Tue, 20 May 2025 19:16:04 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0843d1sm8758473a12.49.2025.05.20.19.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 19:16:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-mips@vger.kernel.org (open list:MIPS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/4] wifi: ath9k: ahb: replace id_table with of
Date: Tue, 20 May 2025 19:15:56 -0700
Message-ID: <20250521021557.666611-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521021557.666611-1-rosenp@gmail.com>
References: <20250521021557.666611-1-rosenp@gmail.com>
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
 drivers/net/wireless/ath/ath9k/ahb.c | 49 +++++++++-------------------
 1 file changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index 1ffec827ed87..27eaad8c96a4 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -19,35 +19,18 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/nl80211.h>
+#include <linux/of_device.h>
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
 
@@ -72,20 +55,16 @@ static const struct ath_bus_ops ath_ahb_bus_ops  = {
 
 static int ath_ahb_probe(struct platform_device *pdev)
 {
-	const struct platform_device_id *id = platform_get_device_id(pdev);
+	const struct of_device_id *match;
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
@@ -118,7 +97,9 @@ static int ath_ahb_probe(struct platform_device *pdev)
 		goto err_free_hw;
 	}
 
-	ret = ath9k_init_device(id->driver_data, sc, &ath_ahb_bus_ops);
+	match = of_match_device(ath9k_of_match_table, &pdev->dev);
+	dev_id = (uintptr_t)match->data;
+	ret = ath9k_init_device(dev_id, sc, &ath_ahb_bus_ops);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to initialize device\n");
 		goto err_irq;
@@ -156,11 +137,11 @@ static struct platform_driver ath_ahb_driver = {
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


