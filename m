Return-Path: <linux-wireless+bounces-25962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C491B0FE01
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 02:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741F216E357
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 00:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2245C156F5E;
	Thu, 24 Jul 2025 00:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4z885jU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF2F12BF24;
	Thu, 24 Jul 2025 00:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753315963; cv=none; b=QNfKfsrOhEGk9cRwnbXR4QKjBcUTqQH9mJYl9FeYKGKuWbOouimOr2pNzBMsMGbOz3/F0hgj0+JUIh6YoZFmRXXucUzQej/jkinVC3yamfUd14DlBL17yydG33afv4UqP0Wi2Id0peUVQ6HEUnOLkmAM+53bQe65FpxY1PAvEOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753315963; c=relaxed/simple;
	bh=xZTUvJOvOwvC+resGE5dbq7lv8Vg8Ac+Dc//Wlt/zdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsHmqNscXerDAQoUcqDTMHINkqldEtTtvBj/zOmtn5fqDVW2QmIyXxoZkC5v+IR4S0N178Zf2NTJSfrifi5/BIcpqC5xEcdSPxnsq300e8dc7J/YRzpYrEePso1aNWMfuNJfZc3hFm2b5FlN5SikO8/AHoKZ/nw49Mi1iI4e6SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4z885jU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-234b9dfb842so3195325ad.1;
        Wed, 23 Jul 2025 17:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753315960; x=1753920760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULGBrePaPl30E6kseruVigv7W/l7y1ICMo7iJ/DjQ0A=;
        b=S4z885jUt24GYEv+36qetE4HVOeImjPxPckkiV4SEjKHRBfYOz9gwnuOALJbLVSpXd
         XoAkId9hP1A0wPGXcAup66kHS5XQ48lx4N9bwlCaTRdNUSnonu7hyOgsBT7zMxtF8/dB
         a7mURqVJUUdtPi0ZWKL9Ten068DryVIL5dUQaWmVRTx+blf2GwBi/wZec0H6G9pJUyPM
         TbVqvrJm07svQiIsNmpxXGXHQ+bgRKMjaNKMcKFjW7+reHDiBs8rFB5bm+qdmDs1jt/f
         Zp7LCKa5pXNxbQFQz7vL+2xg8TCnTRfzIe53vy1u/nyleRyI48I3m16OfWUNY/wEz0Sq
         KDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753315960; x=1753920760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULGBrePaPl30E6kseruVigv7W/l7y1ICMo7iJ/DjQ0A=;
        b=QhhU7sVspXAAES3XffWsQ+1NaJ2Uf6T4JKXST775fU1YhGMwJGuQVmxBc9YeQDrRxh
         WZfilU1QPc0N0J+0fB6tmwTyQ3zRpk4PFJ2SNZEYRb7vu8NIEcosuJO/580xvz3jhWLT
         mcp6oX+m2lHA6/7wz7YztdIm4W3QmCT9EHWgE/ZNTDjfbd7STGgDFbptK7+50ROLZRAl
         oZ9coqvOnUhgSBr8PShJbiaXssYjHR2jLQFD0NX6JeNKv0/9cLoZ/fS1O67hCInw/s9M
         G6IAuzpChLFR0ZgnYi7DIORr7pEh1wuDbm5oj4rIz8I9wl+fADUI4oqjgi+ctDHwgFAL
         KnrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4jKtkCqNtFFVpO6U7XielftRHBRsnn4+3FI3dFXMbWQ6McUBVF1W8p6xLqDmG1v37Xs0K6qmXFx8liKYE@vger.kernel.org, AJvYcCVLNyGyFmImL0PRJo6rg7xliN4JDLvHOjT9t4dxzmuTNix57/JM2Lp2KjETJi20yY1YsCHRR81UxgCJzA==@vger.kernel.org, AJvYcCVcuvJU4ygzl4ynZ7S1Ntyn+ccsL7W0cPZdvQAz3B+y9VPujjh2QBRrHjeIzZovZQRMxzuDjrf3BDZj@vger.kernel.org
X-Gm-Message-State: AOJu0YwJAEV1ZkRGzRIGAwQFuklgoBy3tM5ER8HSUmR7k9dThp3n/xTJ
	WsOEZlD4XWHfCUnLz+zh9MXNmP53sudpceLvZArLEtIWcBE+z54ul1Ce8EXaNqGj
X-Gm-Gg: ASbGnctC0V7+uBDpq/e9LpzGJcjakIe/+1EFzMndFba9k9rR6ggK8Y5ynrjllY9JJ8n
	TqolgpXWQa14MYzRXJaqcMcfOloI0WSpT/F27odRYHo3LakQOJ/9RkQm9L4axDRWgG1TBHk1StY
	NDTd2u2mw6Wd/cGZcZXGkN6QG7EsuTHY1+SAgL8UnMwdgRI3nb+x75NQyC5TigFtzIDinutTsr/
	TeJjdASE3dqHe9u9NfpL//UFlYOzVqAQTfXVBoNXRdr2rqRB7/duNycwBULXbmDmJFMX+mP++rU
	qGvn7NrKQUcytvO5I4dU5zOgjb5WG7R93FR/DUglHxX/FCHZwSlJGvBW5WHgigryVbg0XvO++Ft
	ygcI=
X-Google-Smtp-Source: AGHT+IFNdYHqf63rqLYnG9pPv8FZ2a0dGD38GcTIoO9oYFC6DKFllYIrp1P+dYQvcTyrdApqnPUX7w==
X-Received: by 2002:a17:903:18a:b0:235:efbb:9539 with SMTP id d9443c01a7336-23f9814e312mr71621445ad.17.1753315960517;
        Wed, 23 Jul 2025 17:12:40 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa476c131sm1872265ad.45.2025.07.23.17.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 17:12:40 -0700 (PDT)
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
Subject: [PATCHv6 wireless-next 5/7] wifi: rt2x00: soc: modernize probe
Date: Wed, 23 Jul 2025 17:12:30 -0700
Message-ID: <20250724001232.2275-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250724001232.2275-1-rosenp@gmail.com>
References: <20250724001232.2275-1-rosenp@gmail.com>
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
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../net/wireless/ralink/rt2x00/rt2800soc.c    | 187 ++++++++----------
 1 file changed, 82 insertions(+), 105 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
index 4d06f49ec6d2..8f510a84e7f1 100644
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
@@ -355,11 +256,85 @@ static const struct rt2x00_ops rt2800soc_ops = {
 #endif /* CONFIG_RT2X00_LIB_DEBUGFS */
 };
 
+static int rt2x00soc_probe(struct platform_device *pdev, const struct rt2x00_ops *ops)
+{
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
 static int rt2800soc_probe(struct platform_device *pdev)
 {
 	return rt2x00soc_probe(pdev, &rt2800soc_ops);
 }
 
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
+}
+
 static const struct of_device_id rt2880_wmac_match[] = {
 	{ .compatible = "ralink,rt2880-wifi" },
 	{},
@@ -372,9 +347,11 @@ static struct platform_driver rt2800soc_driver = {
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
2.50.1


