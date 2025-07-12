Return-Path: <linux-wireless+bounces-25326-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A140B02D1C
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 23:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BB437AEE98
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jul 2025 21:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29865233733;
	Sat, 12 Jul 2025 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M93MK3k4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6C923184F;
	Sat, 12 Jul 2025 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752354299; cv=none; b=gkpBlPzAo7midYasc2Xmf5IsRFdzMWkBoCqc336lerhex+A9cvRt6xQe7g/D56Qpf/RLOUaHZ4ZNY2W+ablrKMpe+NHqb0+xVv+qkvLGsOdp851SHNtELJblhWW8OcVyhxNhSrFhC14KJWZjtilAJ5TKQlurLZ06lF9C1lwEdUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752354299; c=relaxed/simple;
	bh=e2s6j15/ubQ52TJJo3zelpG1pLiP3501QYrRDoZTWkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FU+I1w7A41rCcorb1pRwMDXUrwKf1wET5I66lV6gMWiUIasbp30ep5QLNO7W1JT2DP/mK6pJJl7pwgDJ+NQmz5vmahqMqe7j2hQpJuwObJw+dLYxUJ9QqBMh+MqOIJpR24WI1WGXX0v6knW8+okVcERi4TldPM2Uf9LakN9kDnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M93MK3k4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-742c3d06de3so3741491b3a.0;
        Sat, 12 Jul 2025 14:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752354296; x=1752959096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwYe3xupMTSG2+11zL2c0yQ7oBVvIn5KSYLqAXZibDs=;
        b=M93MK3k4Vuve/CTw36X6btqTEVGIUV6sGxkLLROQ4WQ1SOsjs6G/DJPQzVulK3XIoA
         /eRRgnYuDVjQQ68odomgiL6v06oavH96EhrAxYXQPp+bp5Y0EtktRaqnYySKVNzbui2p
         tJoxtzuDYHScV0SXa13LIMvvCjGiFgWrcSCRouHeKwPywRN5dI+d3kBAmrx7ElaEMiAt
         GzZY48n2335Hx5zQoApmeJ0c2U2NGUdGOqjai/WTE0aZ7/ysDcCC1arzu1qOT1ouqkzm
         i99uoiU/rX8xHEN2y4C8OhIcZjB0xCATU9L+oEsdy+20aot8tmqI4qr1qcbR2juh2Njl
         PiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752354296; x=1752959096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwYe3xupMTSG2+11zL2c0yQ7oBVvIn5KSYLqAXZibDs=;
        b=iKiIzEMFNmr13TTAs6GQxV/uhvmkD7MJMiYa2r09SYR/BX0Sbs+JApsM7UtKwt2xma
         cAnY9ps4Ur0qlLrIdsWXbHaWlgWW9S0dQg2tZQN7DC8GYXWmFZDYyWXXZHNDqLI4cwJn
         DQOHHy9QW3/9/7dUSY7wub4Qhz0u/m+dw2WjQ8265qBKM6HlayD9eTMfXH6CJLi9uSJk
         ADfto8H6DfKkxoRWSWOWVqtzcVyjffXxWgtdalrcYa3RTDS9nIsjf50Vtol43Z1L6NZq
         WZp+nEJ8REfugohI2F6KHrXQM59t6hTEnD46Ht1Zbdi9kpplvMpFw5usYsmx+DV6OoIg
         oQzg==
X-Forwarded-Encrypted: i=1; AJvYcCUX9Mp1giVq6mvl6x9rwW8kw+EqqEwl3etQO/zd3zCrZsHcDhq/0nAJeQhjDmEJxQV1Zk91XQM9mx3tgXaQ@vger.kernel.org, AJvYcCVD4rsdyz3wcJozoLbdI0cBTu9M5pnLc93CrXl/x1PACW/VwmDDlWHyTW8FRZRf9zpVbB5CgPCwv/FQoQ==@vger.kernel.org, AJvYcCVYrfhWeVOjLE1ZVgzVSk5/rS/GXyr+YesPWog6tiBtr6998C6UdFD7x/toR7USOi3xWoBW0WwO9ixU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3hJhWCX6PKz6a+pNcsgPktJzOWc8vVOJODXp5CE8TszS0U+/h
	HWE16h8s/YdpM1n7oT/sORXdnqu6uVqfmOgejN2W/kTVf1ehfnPYTLgsDjMwDtpk
X-Gm-Gg: ASbGnctk51PPd8Kox4U682MYHNOLNAGPmtj2mXRgzKPsHeiWztIyIgIJh7XC8J5cLEi
	M2iHAvUVATrw/3U4wO/nlVVQqQab2X1mRRjrj7S8qxW2BcMaC559W6N7btZj+URVZWXGPibROot
	4O9lrxHoUOmzXfvGgI10GxkWcWJSO7/BEGB7UyN/uEXMScKSwyk7YKoyfyDVTMujH2wXGLuj8zs
	6OKVLVZ3z5mcaBTYkr7gq1ccuDe1xXdl2+FkWxGTQw8a77hOZVyW2WP3wJQi8dQhFkvtmFd2UQt
	0/O78yLQvhNTMpV48Fia0eURR0Mo11ugfKu1pLViZY2CySfb5Owj0Rab5wwhRiqGMRaTcmJNwSX
	v1WE=
X-Google-Smtp-Source: AGHT+IHp+4vRGmtHjwxY8FW/NYytoDXTyUlPwF2CvDej80EQyUMi/NGMO5fZoBR1D/mvT+6sM/SoRg==
X-Received: by 2002:a05:6a00:1304:b0:747:bd28:1ca1 with SMTP id d2e1a72fcca58-74ee04ae627mr11998624b3a.3.1752354296424;
        Sat, 12 Jul 2025 14:04:56 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5d30sm7988645b3a.5.2025.07.12.14.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 14:04:56 -0700 (PDT)
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
Subject: [PATCHv4 wireless-next 5/7] wifi: rt2x00: soc: modernize probe
Date: Sat, 12 Jul 2025 14:04:46 -0700
Message-ID: <20250712210448.429318-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250712210448.429318-1-rosenp@gmail.com>
References: <20250712210448.429318-1-rosenp@gmail.com>
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


