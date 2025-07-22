Return-Path: <linux-wireless+bounces-25883-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F78B0E587
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 23:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19101188EB5E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 21:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC4328B7E7;
	Tue, 22 Jul 2025 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkqEk97p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8D328A73A;
	Tue, 22 Jul 2025 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753219749; cv=none; b=OqVjrdTyVprKDSwQpCpVHJmbN27/HsEoZBDIxo83laT/SRpztXSAajQ1xjfoUAdZlLj/wPUh9FWrUaiDGf6LfqSbNMLLnNI2pQ4kUcscFv/7yUyzQCcN+Qq07RB3qEHS7KU8O8sg+YVCIFcGgnxhUM0I0sNaf7yp4msWkFB7Ntk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753219749; c=relaxed/simple;
	bh=xUKCz6s+zSZ2u20w6AfXsi4ro4q82g6oJSpkAcj8XUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amoPRCxtu1baAMmcj67c/GSELVNMLBXnK2/ujhkpSnc4YLVUgLV0I6pGCpslzX0qBmba93h/0cfM4cr6EtuLEcEX8bv+ewtaNEd6vid59ao8i6SzUzmpCk/aN7N9rC4PdevP0uCcko+mmX4Y1wwA8eKtxFL+vxG6WxdHbquT6Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkqEk97p; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso4842547a12.3;
        Tue, 22 Jul 2025 14:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753219746; x=1753824546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPV81AlONYtTEX391sJmYZIjF/VDHDvhGEKKxh4sMlY=;
        b=KkqEk97pNt1ydadEMImm89MtItvWqMvMhGYJiT5FvwkRCFvqZoC600koCVDw7wy+vu
         hrTulQUbfL3B5qhZvePtkbqbOAwzumFHVR+vpMvQ9tU6yG44zZ8y6kNxl+kGar71D55l
         AD/wBdTgOlA3dlKKwmrcMf9t7hyYVpAtCSSkaE3j8NPWw1la7Dku4cUq/FBmZpoliD0u
         D7V/uu5146ZlIZI1uI+iWD6EfFcB9iVWhS4AKjaegE95i69EgOYVfmRdn8P989wyDmzr
         8Ge1SsnORDri4NDEFTLyG80Pku9vwulyf8TYS259FVN+U0C9lIaU1SaW5uCG9wIVoCmK
         MmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753219746; x=1753824546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPV81AlONYtTEX391sJmYZIjF/VDHDvhGEKKxh4sMlY=;
        b=h2lbeCTaAbzxe7T/wGjOMj0Yu533klMibHZPs5zRq/U21dqIGqh2wMu/S/+Lj+k5aw
         OMngkfkLRuMF9QSmkKH9I4S029Knu9XvLj8aRig9u205kvXL9WA/Hxm9QIHXr/2cgUlP
         x9rZARjGduTFyWV/+Ykz2xlVaFcz9B4S4TsTdujzw0L7AZLiGsOgBplRLaRuPDhxan9E
         dMLKhkfEYjBhBoMDwRn1prvRgISiHSE9BrpdBy/c4BonLyNrMoTZqRLfIef3dn7hRMug
         aFQU7EgRw1yfj8FAD1UyC/v48NuqxaeJFNej/8NTsL9koExsgFl0/s5diJW5Qu8jx+WX
         xuag==
X-Forwarded-Encrypted: i=1; AJvYcCWVE9bDYPBYuisYzDZCaTgP5l9ZHhTUoGcgv5ys3H6quYEnW5HI3C9zgxOn2oycyz4c4vcvS3mWtTyMM2Ng@vger.kernel.org, AJvYcCWoOlffzY4bzrumFtJ0VTn+a4FMfNKkzHfarQujHsip8+J8iCi0cSNSEf/S7CVsIrDyQRdTSN70wj/nPw==@vger.kernel.org, AJvYcCXxUc5Ep12gXdXsp3btywCd1z9JfHPBOO5LHUZB2WfK3IDLK06k6BpBA0LzqYVsPv1kMyqyfeyH3xtP@vger.kernel.org
X-Gm-Message-State: AOJu0YzIdA5CrBnI8zVAYQ/dIUF34gIiPR1lsvSEziXPGxl+SzuOp2pM
	K2B4ao5VJ2i8L2DDvm44CHEcQjeEKFTRDydh0ygO76HgCZL0ITuG5YuW68WcZTU1
X-Gm-Gg: ASbGncsaQix/zgiWmm4akUEWTtELWF+CIYkXg1owi9nZmdGwKJtAiOYMDPh4z+iQd96
	832Ptt2jxHigDEFLt7YVXymzeP5Cu99wE0q2plW+kMmgXDFJ1K6BhLqC2iAe6JkBRQqubab9tbM
	1mUbiCbm1zE71V/aeN+4khnYVkXfZvdGFsIKu6d/sF4ZMOnUCSx5g+syK9YggbEgMpXX26d/nbm
	NmdLZjqP3s1eCsfrOMdNyThJcuJRiuRCRwMk+jI74s4BulKNF87Upz9yjpAsh0Bnz/dhNuFa7/G
	Ntl8Zpkfxbb407AHM3c57INFmJXEYtFcZml6Uu+5+gvMFQ2wjns7aR6nKrgtHfxzrBdQK7y8+7q
	zKVM=
X-Google-Smtp-Source: AGHT+IFrXERZmxVR5cGpCCvdM73eimb0RuQ25NqpOVWFg7vgN1A2Wg3f1NmQlNRve33bigcGv+d1/w==
X-Received: by 2002:a17:90b:254d:b0:313:f6fa:5bc6 with SMTP id 98e67ed59e1d1-31e507c491cmr1239853a91.20.1753219746011;
        Tue, 22 Jul 2025 14:29:06 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e519ce384sm94942a91.2.2025.07.22.14.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 14:29:05 -0700 (PDT)
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
Subject: [PATCHv5 wireless-next 5/7] wifi: rt2x00: soc: modernize probe
Date: Tue, 22 Jul 2025 14:28:54 -0700
Message-ID: <20250722212856.11343-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250722212856.11343-1-rosenp@gmail.com>
References: <20250722212856.11343-1-rosenp@gmail.com>
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
2.50.0


