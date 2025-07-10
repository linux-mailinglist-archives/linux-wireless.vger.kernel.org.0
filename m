Return-Path: <linux-wireless+bounces-25226-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57476B00CCB
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 22:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7052856559B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 20:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225CC3271A0;
	Thu, 10 Jul 2025 20:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRPj3+V9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBB7326A75;
	Thu, 10 Jul 2025 20:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752178111; cv=none; b=LqBVUJivJ1yR1f8EUv6blGdODjr4vT7KMYr5utvFB/Y/uHfqWEJ1XeuxHSDuWvQ3CMDKT2OURuHqR8nwfJKztEI7/xmGyaMyxKWKy4tqncfgzXjcuv1g4cb/jCd8sqtIhK/8rRBwSvBb+tvKqi1/WjsQNxi6MgqDDlwhXOzprfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752178111; c=relaxed/simple;
	bh=e2s6j15/ubQ52TJJo3zelpG1pLiP3501QYrRDoZTWkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKnONOvlSOwwcA3s3PcUfROnyWBxPYdOHw6e5NRlClfzsYXoeK4TJY7d0b2jOfujwPLFMM7H1XYRcP3Fh0SBUMfJ0TVjbYZY915GQILSDDsso/eskDPuhsZb7h5Fz58OCB6ZmDnlJt0zOCO7lLJg23js1xmbS3ktu/fpGJPQMiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRPj3+V9; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-748e378ba4fso1728558b3a.1;
        Thu, 10 Jul 2025 13:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752178108; x=1752782908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwYe3xupMTSG2+11zL2c0yQ7oBVvIn5KSYLqAXZibDs=;
        b=DRPj3+V9jOHyKQmpc8qP7QglvAg/Ucf7fz+ryf/YRUXA5yln+7BPyuo2+PoT8i8q8S
         7U+Wu2gEL6HhlULO847T7v7TdR2moL/WXYYXyMSv/2LYzseHhPZ/lgkudj5krF+cQIky
         1t8XDK21lFnFC6EEPcnLqdvGE5MTht9dgAv9pSyqKDLROghCLBi8+f9jw0QbM6rGmG7x
         KAv8xSwZOQQIGB5DvpOHr/OBjHs0ofP4QhzxpsKBQMKiq0v0nPvJkjxDHuRzGON1tjPI
         hY5I+k9OdPEHUgFz1rWXmImXxJaYdBBK9mYR++E3cBL6nA+h1MXtMznNh4v/XatyBHpV
         Wcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752178108; x=1752782908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwYe3xupMTSG2+11zL2c0yQ7oBVvIn5KSYLqAXZibDs=;
        b=PcnVtDXyBYKvdMJvIOqpUVHxBC2Hbo2zEa0CmiyOzYpqcE1cJ+6MRTR/g+Se+u2nmv
         g6HT0GDfjUfIMttofcknTWwvXIaGQ8uQcVt5OwZtiS1ldebAtTHPLWn7Uzq0HHXo5vjD
         qhVk6/Ycpo09IVw+W5uwRy/yPP6np+kE5uwZfwUN3Op8GwrLiLgfaDC1XjI8SlhvbXeh
         LUXZPurK8eYUrD6aMH2MmjS17wbgmJZmBTg6dB/I42CeFVRcJ0mPw2CfrxpjaOlaG3Yu
         tCYbKyYmRW46kG4/5HN1CaZ0njtuqBhjLJpJgvQXrOOjvU7bMokwqoS3GjdQLbfOcZP0
         7D1A==
X-Forwarded-Encrypted: i=1; AJvYcCUQtJPg+p23j/yNRBN5+Zhf/T22rCP4T6WoNIpHqJBxS2i7wJh0+y0t5aizErrOKhjMIBQxBGzH/yI0T30e@vger.kernel.org, AJvYcCUiD/vyeRGeWcBTctNuiROndyh66aCIpJ3XO1ukLo5UCMkKZMUL2JdeuFVQV5uyVbel6d0YLIWrtbx3@vger.kernel.org, AJvYcCV7OUwro6PO9S2t3LtHpRh7iAjR0dmNCFtKxjvyx6YhgWRBCLYjsfSbhvryFCKBPww47iUVx/2EqQsBYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXhTo2UmhFJBwBukIwCcw67T8EnOQD+NMFFMKpDX7EHud8zuOp
	Sxzot6LNlbXOG8KLJvqEiHen/wra4yRJcmCxaNTtKANRuELb2nsDa2hJXm07W3R1
X-Gm-Gg: ASbGncvNDGpNQf8mvctmy8lOLQKvJg8LEVGDTj9fCxSMJopPDxgmpAWR9sEvDkr7TfZ
	suZeFlANTrFMxGwe26lZkfPINHYQvxenFyMYqleO0Ud60TQ/JJ+PGWTl1AsU2rWpGRLb5CA/V5P
	NmsKwNcsO6EfIFNMWk6CxTwnQdlrYhmTsiS+n5IXW0k+WbQO2fDpsRBiwwyKJbou3YaIdvbTuXr
	NfOrkkVdUI6eGCO+4nXVuj4hnXsgX+Dnh87ULn9TxqGoiDYEoV/JnnVeBEeTxIKD9yu9/buP7Nm
	9415+u3B/Zn9A3MwbhRLHMnGvxT9xtY0gu0j8gic36c=
X-Google-Smtp-Source: AGHT+IFGENkAdv+V/dfx5FamicrJ6jx64xFv4YqiFq5sarFKCvXAwSk4KPlooZcc+d8/G07famlB5A==
X-Received: by 2002:a05:6a00:1945:b0:746:3040:4da2 with SMTP id d2e1a72fcca58-74ee109a194mr529659b3a.8.1752178108233;
        Thu, 10 Jul 2025 13:08:28 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b29asm2729453b3a.87.2025.07.10.13.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 13:08:27 -0700 (PDT)
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
Subject: [PATCHv3 wireless-next 5/7] wifi: rt2x00: soc: modernize probe
Date: Thu, 10 Jul 2025 13:08:18 -0700
Message-ID: <20250710200820.262295-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710200820.262295-1-rosenp@gmail.com>
References: <20250710200820.262295-1-rosenp@gmail.com>
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
 .../net/wireless/ralink/rt2x00/rt2800soc.c    | 185 ++++++++----------
 1 file changed, 79 insertions(+), 106 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
index a19906c35d0a..6f148dec2469 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 
 #include "rt2x00.h"
@@ -130,108 +131,8 @@ static int rt2800soc_write_firmware(struct rt2x00_dev *rt2x00dev,
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
-static int rt2x00soc_suspend(struct platform_device *pdev, pm_message_t state)
+static int rt2800soc_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
 	struct rt2x00_dev *rt2x00dev = hw->priv;
@@ -239,7 +140,7 @@ static int rt2x00soc_suspend(struct platform_device *pdev, pm_message_t state)
 	return rt2x00lib_suspend(rt2x00dev);
 }
 
-static int rt2x00soc_resume(struct platform_device *pdev)
+static int rt2800soc_resume(struct platform_device *pdev)
 {
 	struct ieee80211_hw *hw = platform_get_drvdata(pdev);
 	struct rt2x00_dev *rt2x00dev = hw->priv;
@@ -357,7 +258,77 @@ static const struct rt2x00_ops rt2800soc_ops = {
 
 static int rt2800soc_probe(struct platform_device *pdev)
 {
-	return rt2x00soc_probe(pdev, &rt2800soc_ops);
+	const struct rt2x00_ops *ops = of_device_get_match_data(&pdev->dev);
+	struct rt2x00_dev *rt2x00dev;
+	struct ieee80211_hw *hw;
+	void __iomem *mem;
+	struct clk *clk;
+	__le16 *eeprom;
+	int retval;
+	u32 *rf;
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
+	eeprom = devm_kzalloc(&pdev->dev, ops->eeprom_size, GFP_KERNEL);
+	if (!eeprom)
+		return -ENOMEM;
+
+	rf = devm_kzalloc(&pdev->dev, ops->rf_size, GFP_KERNEL);
+	if (!rf)
+		return -ENOMEM;
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
+	rt2x00dev->eeprom = eeprom;
+	rt2x00dev->rf = rf;
+	rt2x00dev->name = pdev->dev.driver->name;
+	rt2x00dev->csr.base = mem;
+
+	rt2x00_set_chip_intf(rt2x00dev, RT2X00_CHIP_INTF_SOC);
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
@@ -372,9 +343,11 @@ static struct platform_driver rt2800soc_driver = {
 		.of_match_table = rt2880_wmac_match,
 	},
 	.probe		= rt2800soc_probe,
-	.remove		= rt2x00soc_remove,
-	.suspend	= rt2x00soc_suspend,
-	.resume		= rt2x00soc_resume,
+	.remove		= rt2800soc_remove,
+#ifdef CONFIG_PM
+	.suspend	= rt2800soc_suspend,
+	.resume		= rt2800soc_resume,
+#endif
 };
 
 module_platform_driver(rt2800soc_driver);
-- 
2.50.0


