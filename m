Return-Path: <linux-wireless+bounces-24857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E349EAFA7FD
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jul 2025 23:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650213B7564
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Jul 2025 21:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7552BE7B3;
	Sun,  6 Jul 2025 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVqUjF2s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B822BE035;
	Sun,  6 Jul 2025 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838083; cv=none; b=RFKjdjXUDBDzu+ubi7+4+haL1B1C7hWKliZwZFceVMn8fl4ONPCxNj/kYv8prA/k/2IqylrnFfLv5Pgn0nCjw5krJ6DQltZi4NlWkqLpzytRyW9r5JJWFRi0SwBEuCPyPUUAiHyjjVpyxiUPywzXgTfAhlv5f4eNIJCCbUKfjno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838083; c=relaxed/simple;
	bh=cKFUB3fcfogVv4nS3uoMT9JStbO37J3Ecty0niFdrcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtegnQD3Lo+N63iqwHNdOUQOcFnx/FI/WrPOBSrSdgvlrL9l+UjgAbnsAQB/RrYlGUuNkS+mPN+SYhGIm9a9PLJPwom3o+KLKeBximbnJTPXehzeiAX7gBHtUQjrJ78oQND948y5EDt9dgzP+7xIQvCV/sJqesIZfCnqiRaKGtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVqUjF2s; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-747fba9f962so1852296b3a.0;
        Sun, 06 Jul 2025 14:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838079; x=1752442879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWkIKGkA990tICWBb/AzCkdqkS98YDkqouTWupGfwu8=;
        b=BVqUjF2ssjt0EcmdT5HCLtVKqhInOkVFBz/RjoqsC+4upOa9VVnBjAGI4Cc9TS7C4t
         ZR2aHWr/ENsyuLdDO4iH9dLDC7QpWJPIKM5AyD3DIeMhYBCI390v8o61EsUcVsyTF5g7
         wmfaF6ADVsSkEWSmvyDVn7Qoqu3Q/nY19RppHDv0p/69ayECFfTqM3+6KKMdGb/BBeWL
         t3wOvSc3AMydRb1/TTq8QMeX0EZ4v3MrKVvo7mZPs7Q0tcDIoQWMfa/GUxWFDENntX5L
         fzb5LpVU/iwQCnEupX5tbccjBd31nRe8Gxis0q2tOdLUok05xs2ZD1ONIqvw/XO36iYG
         v9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838079; x=1752442879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWkIKGkA990tICWBb/AzCkdqkS98YDkqouTWupGfwu8=;
        b=nkAcRtLlPjKjlzY5cpWWQammEHo2uMU5+HrquhLmW5MKIF15h0QOmTS3JovBvPIVq+
         v9CMoHBOziKFNJUbMsqjnVCVHp9XWTO22yUnPDV3enahcxgsGDjzIQ5CZ+21CZiOvlpA
         D1AA/b0gpwRKGok7FijMuBtRBgPNHtJBS2FcuqTuk5dWh5e8+gNnRYZMx4DKOIFGoSTo
         yVcr32r5DLHC8rmSA0CAxzo4iUtJGs0JVBnPBmbTrT9bTpLZp++zXcZc+SHxVVDdqEYs
         os0w2/9N5vY0gbxW/PxwZ2MDiRAGjxFI9Un19pfp6+S/DaSzoQ3STAnfuo+wY7acJvUm
         gmag==
X-Forwarded-Encrypted: i=1; AJvYcCUrU5339vloDppg1jitUUXabEmFO0Nl9lJKKSM6ICWmfm2cQohmAsftHUcOVzDaBXDgZOIlW/Ao7K7H3g==@vger.kernel.org, AJvYcCV1/wFnaujTzjsCWujAOfFUg01cU1bqwNsa95SnQM0NcTDzSwn7W2gh/d0EU4l2EPPPlS7V4nZw/OYe@vger.kernel.org, AJvYcCWDQ3wHedrmZvcMYkG8W2C+Z3hiunqpTmWRYgob4nInaDyyNacyoDWWnHiRSMb5ZeD7WquigWAHGDg4XbUQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3nqWXjsOYvtNpJHx9nTM4yJDl47KLm+U5OCKvPWT+AYS1jfjD
	cMmMvRAzaw+WMjESsnwcd6HjYIdVFn15T4dZ6IexIXLSsZs6kNFQvmyX9utMqV4cIYA=
X-Gm-Gg: ASbGncvws5s24urobyr1nwkgKF0BYEfEUH2iS1lHWQVqqce24Gghn1T5NbsNY8ocABD
	R3vjPLbx/YaFOoaKOaxinaObsE7RXvgL8PGnH6ACkVKPB1N2qwxKyO6NGQwZ9JXE5rbfrlHO+MK
	bkiiXDNeKhOtt6XkIQw+8lsDV/5al0HR/3NFG4XTncQVuhGJaMD0qjwhVm9u8epLP8T3keyBPj3
	Fd6A6im3uJcnUq7oPqGQfl0b0YqW1PE65blq2nhXstkcshsUHSBpdWfKwCwSs6WePwTnzdD6NU7
	GxVRmfCQCqn6QVXw1vafaa6u9yuR/gbKnbNmg6krm7RDQDcQDfriQw==
X-Google-Smtp-Source: AGHT+IHHOmTsiBLo3z6UMMswYtFY9ObAPDGTYpD1AOLGuigpAPh9rfOATyQ8i/rlbaFuXtxZ+xyf4w==
X-Received: by 2002:a05:6a00:240d:b0:742:ae7e:7da1 with SMTP id d2e1a72fcca58-74ce5de7884mr14558457b3a.0.1751838078711;
        Sun, 06 Jul 2025 14:41:18 -0700 (PDT)
Received: from archlinux.lan ([2601:644:8200:dab8::1f6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74cfad75020sm4126416b3a.109.2025.07.06.14.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:41:18 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	yangshiji66@qq.com,
	ansuelsmth@gmail.com,
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
Subject: [PATCH 4/6] wifi: rt2x00: soc: move and modernize probe
Date: Sun,  6 Jul 2025 14:41:09 -0700
Message-ID: <20250706214111.45687-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250706214111.45687-1-rosenp@gmail.com>
References: <20250706214111.45687-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By moving functions from rt2x00soc to rt2800soc, the driver benefits
with potentially smaller compiled size. It also becomes much easier to
remove a bunch of manual memory management and use devm.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../net/wireless/ralink/rt2x00/rt2800soc.c    |  67 +++++++++++-
 .../net/wireless/ralink/rt2x00/rt2x00soc.c    | 102 ------------------
 2 files changed, 65 insertions(+), 104 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
index db8d01f0cdc3..e2c05ead9b25 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800soc.c
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 
 #include "rt2x00.h"
@@ -240,7 +241,69 @@ static const struct rt2x00_ops rt2800soc_ops = {
 
 static int rt2800soc_probe(struct platform_device *pdev)
 {
-	return rt2x00soc_probe(pdev, &rt2800soc_ops);
+	const struct rt2x00_ops *ops = of_device_get_match_data(&pdev->dev);
+	struct rt2x00_dev *rt2x00dev;
+	struct ieee80211_hw *hw;
+	int retval;
+
+	hw = ieee80211_alloc_hw(sizeof(struct rt2x00_dev), ops->hw);
+	if (!hw) {
+		rt2x00_probe_err("Failed to allocate hardware\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(pdev, hw);
+
+	rt2x00dev = hw->priv;
+	rt2x00dev->dev = &pdev->dev;
+	rt2x00dev->ops = ops;
+	rt2x00dev->hw = hw;
+	rt2x00dev->irq = platform_get_irq(pdev, 0);
+	rt2x00dev->name = pdev->dev.driver->name;
+	rt2x00dev->clk = devm_clk_get_optional(&pdev->dev, NULL);
+
+	rt2x00_set_chip_intf(rt2x00dev, RT2X00_CHIP_INTF_SOC);
+
+	rt2x00dev->csr.base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rt2x00dev->csr.base)) {
+		retval = PTR_ERR(rt2x00dev->csr.base);
+		goto exit_free_device;
+	}
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
@@ -255,7 +318,7 @@ static struct platform_driver rt2800soc_driver = {
 		.of_match_table = rt2880_wmac_match,
 	},
 	.probe		= rt2800soc_probe,
-	.remove		= rt2x00soc_remove,
+	.remove		= rt2800soc_remove,
 	.suspend	= rt2x00soc_suspend,
 	.resume		= rt2x00soc_resume,
 };
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00soc.c b/drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
index f7f3a2340c39..9fd763f2fcde 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00soc.c
@@ -20,108 +20,6 @@
 #include "rt2x00.h"
 #include "rt2x00soc.h"
 
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
-int rt2x00soc_probe(struct platform_device *pdev, const struct rt2x00_ops *ops)
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
-EXPORT_SYMBOL_GPL(rt2x00soc_probe);
-
-void rt2x00soc_remove(struct platform_device *pdev)
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
-EXPORT_SYMBOL_GPL(rt2x00soc_remove);
-
 #ifdef CONFIG_PM
 int rt2x00soc_suspend(struct platform_device *pdev, pm_message_t state)
 {
-- 
2.50.0


