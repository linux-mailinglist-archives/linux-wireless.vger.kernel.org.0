Return-Path: <linux-wireless+bounces-24999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A827AAFD828
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 22:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2C617A5657
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 20:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDA3248872;
	Tue,  8 Jul 2025 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJj4o3vf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1FA2472AE;
	Tue,  8 Jul 2025 20:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752005878; cv=none; b=Xp4nEHQJgtG5DCHjbLnBuMN6D4ERogD2OCBG1E3fnn42Qz1j+Zz8gEayS3yrCRHIc9s9fW4KqlfEZZDUUwadu1giHTmMELUQ76/t5m+ix0t6xZPU150lMnBgyMnHSNtAERNu5NZ0cbAaffnLV7SA7AXXdmGsFfx8K7FQO1qCljc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752005878; c=relaxed/simple;
	bh=NawY2Ti1znLP8eZf2BiRccoECYmelw8Ecx0dZiw0pRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mS8DjnDT8wdX5jbPACqKAyyRy08iTIglqZ4tx+LZm2m/f/6vPUFs8UPz87XcSRaGQgNegz3GJCw10mTF8dCNyJ+riHE9hprJShhmPClPywvrdDrQ94uxf5q6JWilC4yzW6P4H2VCxrbMjh3LHJ48oNzCuLyxU1IeHaTwDvAtomg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJj4o3vf; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-747e41d5469so5426939b3a.3;
        Tue, 08 Jul 2025 13:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752005874; x=1752610674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWDcW/kjZC4qhj4C//sbQ5nqQzgpn4vwd848BqxooNU=;
        b=GJj4o3vf6PmXpiWy6SFU9FpNkvTg9vJ0pQE6e8twShfh4oCCBFHRRH8y3EjNzYDNc0
         Gei16peMBOD0wcpYCjKhV2QMgJ4+wG2dfYiLRpgeUR0splJNetc/u4g/9xoemO7TG5Qo
         +QaeAY7uLL50eu02D3xkbWyg9VV2PWZMpL4snJhWOkJz1DqyUqnJvu63357wysuehigx
         4vEP5fQBATUsWCi2tbvhstXKzHnba2G5kaRsv9lNw0i2FQcHJXvzei6HaM5HlefuX+ZY
         u8ZC1wBBIFbgra0M7lHoQFciNsWdc088vWiVZj0/2XvsqEBc6PZUfJ5CZ6mu5M+FuTOf
         BsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752005874; x=1752610674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWDcW/kjZC4qhj4C//sbQ5nqQzgpn4vwd848BqxooNU=;
        b=k7QjzI0o/9Ul73T5K9vlQRzZqmPJ3IYdene6KONkHKvRiKB650rzGxRuQCO419D4Vn
         LZ34tlVGWxapK1sJCPCRDa/TVpaFAQT1QpS60YCDjLl2kKT72R/FmVE+7wIujmZVnPsZ
         Vgy2AKLBm7q1Ym3OmgwqkcdeCw+7VMhveBbxICmEDPhk+YJZSO94iIOh0z864BTc+RNM
         OeEm5RVHnwaokbLIIqme4hdY3mcI5qKR4FumZC6ivp/8MkDU2xkuJvBSzu4Hrny9ZXU7
         KdIqUoMt9aKOKAnsLhL0oFWvMyodSgbTJy1U+aMXIvYrbFmIwvua1lP0R8dd/Z1Tsqj+
         f3Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUo0RWLWXpraI0dY2NeS7DG0sNO8bK2Kkbq6jbyO33b1lMeva1uIfUqQsnV07lJnj9jOiJ8hmFgTtEN@vger.kernel.org, AJvYcCVg+t0YFssrTGKUw7KKTc/2QPnmFtZOMB4Ea0YsZCM9+k/J5pZOmucarXoxe2kEmqrOjJwkhPjw9MSis2i+@vger.kernel.org, AJvYcCXeVEkUHMA27ZyW7lIcgnonMVlTHH7u3p5YrB27U/JndaZ1LyCDLixgECQzcJi86i++wK5iH+8EKZqgoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Jjf3Egd7bZD11sWvE/qvZbxKiKt8BMDncawQdA4RDO3lbIrc
	W1k3pzh4lqJ8YK7x/N2T9C/V7eoatr9gWeaOM9XifDe4WawPMTNMlP6vYKeDCYKg+b8=
X-Gm-Gg: ASbGnctE3FpDAkIM96TWgv/yTo1YpIFn+YWhyxqwNXGtX4OtT9oh6vo1jjR1uBJ/LKt
	m4qgYGx/6eoeU1B08QPh5v36HaYla6bq4dK3CQXDOPTYypPRueQAD5lBQHz2Xtped1cJyvBappG
	F95eRS3wLO1RL5E5OZUsQeJcp07dP3SoVdzeyEZDokPYAp3x4xKCobeckaFciINCfCdPagXYsnK
	rv5hliWVXVTyfGqT84cDBWVyy8JIwyXmTeYScFE4TTC15WD2rdXd9zK3pJjWHPWZqZieMZJkewF
	EiqGobiRixcOs1jTpW5rARijwP6+Qejm0iBN7lqU57E=
X-Google-Smtp-Source: AGHT+IHesj1rvCWvnUYMskuhzoi+0SVmWfj4l3v7+KPmXKe4dlWKWWZNDElUOFSLMFlp8RtXpFwlrQ==
X-Received: by 2002:a05:6a20:918d:b0:215:dee4:4808 with SMTP id adf61e73a8af0-2260aa9f41bmr27971148637.18.1752005874105;
        Tue, 08 Jul 2025 13:17:54 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee5f5d8csm12289625a12.39.2025.07.08.13.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 13:17:53 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	linux-mips@vger.kernel.org (open list:MIPS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCHv2 wireless-next 5/7] wifi: rt2x00: soc: modernize probe
Date: Tue,  8 Jul 2025 13:17:43 -0700
Message-ID: <20250708201745.5900-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708201745.5900-1-rosenp@gmail.com>
References: <20250708201745.5900-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove a bunch of static memory management functions and simplify with
devm.

Also move allocation before ieee80211_alloc_hw to get rid of goto
statements and clarify the error handling a bit more.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../net/wireless/ralink/rt2x00/rt2800soc.c    | 175 ++++++++----------
 1 file changed, 73 insertions(+), 102 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
index a19906c35d0a..a238f7b9634a 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 
 #include "rt2x00.h"
@@ -130,106 +131,6 @@ static int rt2800soc_write_firmware(struct rt2x00_dev *rt2x00dev,
 	return 0;
 }
 
-static void rt2x00soc_free_reg(struct rt2x00_dev *rt2x00dev)
-{
-	kfree(rt2x00dev->rf);
-	rt2x00dev->rf = NULL;
-
-	kfree(rt2x00dev->eeprom);
-	rt2x00dev->eeprom = NULL;
-
-	iounmap(rt2x00dev->csr.base);
-}
-
-static int rt2x00soc_alloc_reg(struct rt2x00_dev *rt2x00dev)
-{
-	struct platform_device *pdev = to_platform_device(rt2x00dev->dev);
-	struct resource *res;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
-
-	rt2x00dev->csr.base = ioremap(res->start, resource_size(res));
-	if (!rt2x00dev->csr.base)
-		return -ENOMEM;
-
-	rt2x00dev->eeprom = kzalloc(rt2x00dev->ops->eeprom_size, GFP_KERNEL);
-	if (!rt2x00dev->eeprom)
-		goto exit;
-
-	rt2x00dev->rf = kzalloc(rt2x00dev->ops->rf_size, GFP_KERNEL);
-	if (!rt2x00dev->rf)
-		goto exit;
-
-	return 0;
-
-exit:
-	rt2x00_probe_err("Failed to allocate registers\n");
-	rt2x00soc_free_reg(rt2x00dev);
-
-	return -ENOMEM;
-}
-
-static int rt2x00soc_probe(struct platform_device *pdev, const struct rt2x00_ops *ops)
-{
-	struct ieee80211_hw *hw;
-	struct rt2x00_dev *rt2x00dev;
-	int retval;
-
-	hw = ieee80211_alloc_hw(sizeof(struct rt2x00_dev), ops->hw);
-	if (!hw) {
-		rt2x00_probe_err("Failed to allocate hardware\n");
-		return -ENOMEM;
-	}
-
-	platform_set_drvdata(pdev, hw);
-
-	rt2x00dev = hw->priv;
-	rt2x00dev->dev = &pdev->dev;
-	rt2x00dev->ops = ops;
-	rt2x00dev->hw = hw;
-	rt2x00dev->irq = platform_get_irq(pdev, 0);
-	rt2x00dev->name = pdev->dev.driver->name;
-
-	rt2x00dev->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR(rt2x00dev->clk))
-		rt2x00dev->clk = NULL;
-
-	rt2x00_set_chip_intf(rt2x00dev, RT2X00_CHIP_INTF_SOC);
-
-	retval = rt2x00soc_alloc_reg(rt2x00dev);
-	if (retval)
-		goto exit_free_device;
-
-	retval = rt2x00lib_probe_dev(rt2x00dev);
-	if (retval)
-		goto exit_free_reg;
-
-	return 0;
-
-exit_free_reg:
-	rt2x00soc_free_reg(rt2x00dev);
-
-exit_free_device:
-	ieee80211_free_hw(hw);
-
-	return retval;
-}
-
-static void rt2x00soc_remove(struct platform_device *pdev)
-{
-	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
-	struct rt2x00_dev *rt2x00dev = hw->priv;
-
-	/*
-	 * Free all allocated data.
-	 */
-	rt2x00lib_remove_dev(rt2x00dev);
-	rt2x00soc_free_reg(rt2x00dev);
-	ieee80211_free_hw(hw);
-}
-
 #ifdef CONFIG_PM
 static int rt2x00soc_suspend(struct platform_device *pdev, pm_message_t state)
 {
@@ -357,7 +258,77 @@ static const struct rt2x00_ops rt2800soc_ops = {
 
 static int rt2800soc_probe(struct platform_device *pdev)
 {
-	return rt2x00soc_probe(pdev, &rt2800soc_ops);
+	const struct rt2x00_ops *ops = of_device_get_match_data(&pdev->dev);
+	struct rt2x00_dev *rt2x00dev;
+	struct ieee80211_hw *hw;
+	void __iomem *mem;
+	struct clk *clk;
+	int retval;
+	int irq;
+
+	mem = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mem))
+		return PTR_ERR(mem);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	clk = devm_clk_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	hw = ieee80211_alloc_hw(sizeof(struct rt2x00_dev), ops->hw);
+	if (!hw)
+		return dev_err_probe(&pdev->dev, -ENOMEM, "Failed to allocate hardware");
+
+	platform_set_drvdata(pdev, hw);
+
+	rt2x00dev = hw->priv;
+	rt2x00dev->dev = &pdev->dev;
+	rt2x00dev->ops = ops;
+	rt2x00dev->hw = hw;
+	rt2x00dev->irq = irq;
+	rt2x00dev->clk = clk;
+	rt2x00dev->name = pdev->dev.driver->name;
+	rt2x00dev->csr.base = mem;
+
+	rt2x00_set_chip_intf(rt2x00dev, RT2X00_CHIP_INTF_SOC);
+
+	rt2x00dev->eeprom = devm_kzalloc(&pdev->dev, rt2x00dev->ops->eeprom_size, GFP_KERNEL);
+	if (!rt2x00dev->eeprom) {
+		retval = -ENOMEM;
+		goto exit_free_device;
+	}
+
+	rt2x00dev->rf = devm_kzalloc(&pdev->dev, rt2x00dev->ops->rf_size, GFP_KERNEL);
+	if (!rt2x00dev->rf) {
+		retval = -ENOMEM;
+		goto exit_free_device;
+	}
+
+	retval = rt2x00lib_probe_dev(rt2x00dev);
+	if (retval)
+		goto exit_free_device;
+
+	return 0;
+
+exit_free_device:
+	ieee80211_free_hw(hw);
+
+	return retval;
+}
+
+static void rt2800soc_remove(struct platform_device *pdev)
+{
+	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
+	struct rt2x00_dev *rt2x00dev = hw->priv;
+
+	/*
+	 * Free all allocated data.
+	 */
+	rt2x00lib_remove_dev(rt2x00dev);
+	ieee80211_free_hw(hw);
 }
 
 static const struct of_device_id rt2880_wmac_match[] = {
@@ -372,7 +343,7 @@ static struct platform_driver rt2800soc_driver = {
 		.of_match_table = rt2880_wmac_match,
 	},
 	.probe		= rt2800soc_probe,
-	.remove		= rt2x00soc_remove,
+	.remove		= rt2800soc_remove,
 	.suspend	= rt2x00soc_suspend,
 	.resume		= rt2x00soc_resume,
 };
-- 
2.50.0


