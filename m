Return-Path: <linux-wireless+bounces-2113-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72DA830AA5
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 17:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB7A28B1F3
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 16:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61E228694;
	Wed, 17 Jan 2024 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CKTeIh6F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942A52554F
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705507724; cv=none; b=dWQSpDE2uWPeliaMMVWYzSjF0FylnlWJNB1BJ69c8J6VvRoaKWxALsrPReQrVdusfAUeIQiYAlGOunfqxsCnvxffa53I8wzYMUJBSKTKXF5LyRUqmMcKojfofuPU3G6FRCgSQPEFqZBMkInQnHAoKzcVti/o46a1XXk6I22if8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705507724; c=relaxed/simple;
	bh=WFyrJs1id+9YZIOtZ6FpABayALnwskaiuM+TVLg1sSM=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=a6X2tISEbS66MYyWQjmq+Ya9yRjKG4Zg/Zdd1kau57pSFztQWv3TilCKfAyQ2MKPFIeWnxvq3Ta3q1op3DucFF2ijswbgvWi04VIvhbc3oP3glZjOCwt1zLdVr8k6xuaKt/c4ucBc81HOB7fSXKDkcNL52tZeKOc1LI8RP4R/So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CKTeIh6F; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-336c5b5c163so6704604f8f.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 08:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705507721; x=1706112521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csdPOquKgbyta51Uec8uuMPVMGRbxtZFd+25sTlPk8k=;
        b=CKTeIh6FgfS8dDceOOxEBjqu3PRAv17lJIOP54BEuwvcxXccpqnOLWxOdzt+YDtDG8
         wWuTkW1p5J/6jBLzu3E2d1gvi2+C1RwvW/DPuCOW/9gUGW1Wyvz3gJ8N+o3x1yV5OCjf
         jRUcdN4kfjKmjFz+l+B80tyaLZ4A4rVOy2o35bDf0udWi1E5GAa6ePzCNwI0IIDxdlyJ
         4V2Wf0+mH5BWdGsyDnHKFalAGUWCh0Xr9km5ZzV64RP6uwr4kmpB0ORuSRmrW+MEYzLn
         feTz4qru4FCDL5M9Em21tWR+fPqH6J7pmHvwQiHbz2GHR4rD6qEWg4+lBlhPhoZ+ILEl
         PpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705507721; x=1706112521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csdPOquKgbyta51Uec8uuMPVMGRbxtZFd+25sTlPk8k=;
        b=REiTw1XMfe32waG6RIIElwp/togTlnRDKK0ih41SKgyBKg68wHW2WR9k3ffqDv1+B5
         k16XqVDgEdf6d7546iZTKFAOnOaYJu/5LY4rxVe82nay8al5gNS1gGG8vYfoGEpGfonP
         zfxTwRcpj7ad4XXf3oQFcktPEI2L8DbE+qo8wJVzaPDKJRazBuTli2R5OnXZMOQvZqx9
         XJpzdw2wjLrq7OznYeMzTSjZZpK0PrClR7fsS9ljqIVNnb8of8EPjht//4jo9zjnLu+l
         N2Aa9hlgGhVh7x30x2PSvEd8Q9G0tCJpPd+yp8+Aiche68whejemrRui7e4JxbCHdAm4
         Eszw==
X-Gm-Message-State: AOJu0Yx/aTCDCfhemmgfs8gm/1h3gvkEkIc3TGFEkUVH8vuDtdYXDZOL
	Ij0ytwSKwM6uOBpOcq35qY4D4FTzCypWqxqScM6kbBh1hsyfITMIoNT1SgjPfuA=
X-Google-Smtp-Source: AGHT+IE8hEEtpTYbJU01ZoUcCZSKPg5Q30PyVE7OMBk7WjjvUlXJokzoqSuozUEKiQC6pE+bjmyMZA==
X-Received: by 2002:adf:ab09:0:b0:337:7b7a:6540 with SMTP id q9-20020adfab09000000b003377b7a6540mr591631wrc.5.1705507721046;
        Wed, 17 Jan 2024 08:08:41 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d0b5:43ec:48:baad])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d6a4a000000b00337b0374a3dsm1972092wrw.57.2024.01.17.08.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 08:08:40 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Kalle Valo <kvalo@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Peng Fan <peng.fan@nxp.com>,
	Robert Richter <rrichter@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Lukas Wunner <lukas@wunner.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 9/9] PCI/pwrseq: add a pwrseq driver for QCA6390
Date: Wed, 17 Jan 2024 17:07:48 +0100
Message-Id: <20240117160748.37682-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117160748.37682-1-brgl@bgdev.pl>
References: <20240117160748.37682-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a PCI power sequencing driver that's capable of correctly powering
up the ath11k module on QCA6390 and WCN7850 using the PCI pwrseq
functionality.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
[Neil: add support for WCN7850]
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/pci/pwrseq/Kconfig              |   8 +
 drivers/pci/pwrseq/Makefile             |   1 +
 drivers/pci/pwrseq/pci-pwrseq-qca6390.c | 267 ++++++++++++++++++++++++
 3 files changed, 276 insertions(+)
 create mode 100644 drivers/pci/pwrseq/pci-pwrseq-qca6390.c

diff --git a/drivers/pci/pwrseq/Kconfig b/drivers/pci/pwrseq/Kconfig
index a721a8a955c3..667c9c121f34 100644
--- a/drivers/pci/pwrseq/Kconfig
+++ b/drivers/pci/pwrseq/Kconfig
@@ -5,4 +5,12 @@ menu "PCI Power sequencing drivers"
 config PCI_PWRSEQ
 	bool
 
+config PCI_PWRSEQ_QCA6390
+	tristate "PCI Power Sequencing driver for QCA6390"
+	select PCI_PWRSEQ
+	default (ATH11K_PCI && ARCH_QCOM)
+	help
+	  Enable support for the PCI power sequencing driver for the
+	  ath11k module of the QCA6390 WLAN/BT chip.
+
 endmenu
diff --git a/drivers/pci/pwrseq/Makefile b/drivers/pci/pwrseq/Makefile
index 4052b6bb5aa5..5cf8cce01e82 100644
--- a/drivers/pci/pwrseq/Makefile
+++ b/drivers/pci/pwrseq/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_PCI_PWRSEQ)		+= pwrseq.o
+obj-$(CONFIG_PCI_PWRSEQ_QCA6390)	+= pci-pwrseq-qca6390.o
diff --git a/drivers/pci/pwrseq/pci-pwrseq-qca6390.c b/drivers/pci/pwrseq/pci-pwrseq-qca6390.c
new file mode 100644
index 000000000000..cdf3639ea29f
--- /dev/null
+++ b/drivers/pci/pwrseq/pci-pwrseq-qca6390.c
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2023 Linaro Ltd.
+ */
+
+#include <linux/bitmap.h>
+#include <linux/clk.h>
+#include <linux/gpio/consumer.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pci-pwrseq.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+struct pci_pwrseq_qca6390_vreg {
+	const char *name;
+	unsigned int load_uA;
+};
+
+struct pci_pwrseq_qca6390_pdata {
+	struct pci_pwrseq_qca6390_vreg *vregs;
+	size_t num_vregs;
+	unsigned int delay_msec;
+};
+
+struct pci_pwrseq_qca6390_ctx {
+	struct pci_pwrseq pwrseq;
+	const struct pci_pwrseq_qca6390_pdata *pdata;
+	struct regulator_bulk_data *regs;
+	struct gpio_descs *en_gpios;
+	unsigned long *en_gpios_values;
+	struct clk *clk;
+};
+
+static struct pci_pwrseq_qca6390_vreg pci_pwrseq_qca6390_vregs[] = {
+	{
+		.name = "vddio",
+		.load_uA = 20000,
+	},
+	{
+		.name = "vddaon",
+		.load_uA = 100000,
+	},
+	{
+		.name = "vddpmu",
+		.load_uA = 1250000,
+	},
+	{
+		.name = "vddpcie1",
+		.load_uA = 35000,
+	},
+	{
+		.name = "vddpcie2",
+		.load_uA = 15000,
+	},
+	{
+		.name = "vddrfa1",
+		.load_uA = 200000,
+	},
+	{
+		.name = "vddrfa2",
+		.load_uA = 400000,
+	},
+	{
+		.name = "vddrfa3",
+		.load_uA = 400000,
+	},
+};
+
+static struct pci_pwrseq_qca6390_pdata pci_pwrseq_qca6390_of_data = {
+	.vregs = pci_pwrseq_qca6390_vregs,
+	.num_vregs = ARRAY_SIZE(pci_pwrseq_qca6390_vregs),
+	.delay_msec = 16,
+};
+
+static struct pci_pwrseq_qca6390_vreg pci_pwrseq_wcn7850_vregs[] = {
+	{
+		.name = "vdd",
+	},
+	{
+		.name = "vddio",
+	},
+	{
+		.name = "vddio12",
+	},
+	{
+		.name = "vddaon",
+	},
+	{
+		.name = "vdddig",
+	},
+	{
+		.name = "vddrfa1",
+	},
+	{
+		.name = "vddrfa2",
+	},
+};
+
+static struct pci_pwrseq_qca6390_pdata pci_pwrseq_wcn7850_of_data = {
+	.vregs = pci_pwrseq_wcn7850_vregs,
+	.num_vregs = ARRAY_SIZE(pci_pwrseq_wcn7850_vregs),
+	.delay_msec = 50,
+};
+
+static int pci_pwrseq_qca6390_power_on(struct pci_pwrseq_qca6390_ctx *ctx)
+{
+	int ret;
+
+	ret = regulator_bulk_enable(ctx->pdata->num_vregs, ctx->regs);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(ctx->clk);
+	if (ret)
+		return ret;
+
+	bitmap_fill(ctx->en_gpios_values, ctx->en_gpios->ndescs);
+
+	ret = gpiod_set_array_value_cansleep(ctx->en_gpios->ndescs,
+					     ctx->en_gpios->desc,
+					     ctx->en_gpios->info,
+					     ctx->en_gpios_values);
+	if (ret) {
+		regulator_bulk_disable(ctx->pdata->num_vregs, ctx->regs);
+		return ret;
+	}
+
+	if (ctx->pdata->delay_msec)
+		msleep(ctx->pdata->delay_msec);
+
+	return 0;
+}
+
+static int pci_pwrseq_qca6390_power_off(struct pci_pwrseq_qca6390_ctx *ctx)
+{
+	int ret;
+
+	bitmap_zero(ctx->en_gpios_values, ctx->en_gpios->ndescs);
+
+	ret = gpiod_set_array_value_cansleep(ctx->en_gpios->ndescs,
+					     ctx->en_gpios->desc,
+					     ctx->en_gpios->info,
+					     ctx->en_gpios_values);
+	if (ret)
+		return ret;
+
+	clk_disable_unprepare(ctx->clk);
+
+	return regulator_bulk_disable(ctx->pdata->num_vregs, ctx->regs);
+}
+
+static void devm_pci_pwrseq_qca6390_power_off(void *data)
+{
+	struct pci_pwrseq_qca6390_ctx *ctx = data;
+
+	pci_pwrseq_qca6390_power_off(ctx);
+}
+
+static int pci_pwrseq_qca6390_probe(struct platform_device *pdev)
+{
+	struct pci_pwrseq_qca6390_ctx *ctx;
+	struct device *dev = &pdev->dev;
+	int ret, i;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->pdata = of_device_get_match_data(dev);
+	if (!ctx->pdata)
+		return dev_err_probe(dev, -ENODEV,
+				     "Failed to obtain platform data\n");
+
+	if (ctx->pdata->vregs) {
+		ctx->regs = devm_kcalloc(dev, ctx->pdata->num_vregs,
+					 sizeof(*ctx->regs), GFP_KERNEL);
+		if (!ctx->regs)
+			return -ENOMEM;
+
+		for (i = 0; i < ctx->pdata->num_vregs; i++)
+			ctx->regs[i].supply = ctx->pdata->vregs[i].name;
+
+		ret = devm_regulator_bulk_get(dev, ctx->pdata->num_vregs,
+					      ctx->regs);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "Failed to get all regulators\n");
+
+		for (i = 0; i < ctx->pdata->num_vregs; i++) {
+			if (!ctx->pdata->vregs[1].load_uA)
+				continue;
+
+			ret = regulator_set_load(ctx->regs[i].consumer,
+						 ctx->pdata->vregs[i].load_uA);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "Failed to set vreg load\n");
+		}
+	}
+
+	ctx->clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(ctx->clk))
+		return dev_err_probe(dev, PTR_ERR(ctx->clk),
+				     "Failed to get clock\n");
+
+	ctx->en_gpios = devm_gpiod_get_array_optional(dev, "enable",
+						      GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->en_gpios))
+		return dev_err_probe(dev, PTR_ERR(ctx->en_gpios),
+				     "Failed to get enable GPIOs\n");
+
+	ctx->en_gpios_values = devm_bitmap_zalloc(dev, ctx->en_gpios->ndescs,
+						  GFP_KERNEL);
+	if (!ctx->en_gpios_values)
+		return -ENOMEM;
+
+	ret = pci_pwrseq_qca6390_power_on(ctx);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to power on the device\n");
+
+	ret = devm_add_action_or_reset(dev, devm_pci_pwrseq_qca6390_power_off,
+				       ctx);
+	if (ret)
+		return ret;
+
+	ctx->pwrseq.dev = dev;
+
+	ret = devm_pci_pwrseq_device_enable(dev, &ctx->pwrseq);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register the pwrseq wrapper\n");
+
+	return 0;
+}
+
+static const struct of_device_id pci_pwrseq_qca6390_of_match[] = {
+	{
+		.compatible = "pci17cb,1101",
+		.data = &pci_pwrseq_qca6390_of_data,
+	},
+	{
+		.compatible = "pci17cb,1107",
+		.data = &pci_pwrseq_wcn7850_of_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pci_pwrseq_qca6390_of_match);
+
+static struct platform_driver pci_pwrseq_qca6390_driver = {
+	.driver = {
+		.name = "pci-pwrseq-qca6390",
+		.of_match_table = pci_pwrseq_qca6390_of_match,
+	},
+	.probe = pci_pwrseq_qca6390_probe,
+};
+module_platform_driver(pci_pwrseq_qca6390_driver);
+
+MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
+MODULE_DESCRIPTION("PCI Power Sequencing module for QCA6390");
+MODULE_LICENSE("GPL");
-- 
2.40.1


