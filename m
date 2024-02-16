Return-Path: <linux-wireless+bounces-3712-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBA7858757
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 21:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01ABCB2680A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 20:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F75115698C;
	Fri, 16 Feb 2024 20:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="AbkrsG4h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2541552FD
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115625; cv=none; b=gNfM+fgiYYczx/RY2EkXJkBeDBue/CNw/PEsRn/hLpoqFRA4yKdaJtfuRBXgQPv+mghOowZEAdRo+FZopqNLmjTW88m/6cTKWdV4sxHi3y0TutvET8pbrz8zc08kwexKIiZk4KnnRiXOplrrsWwNTkaU8AYxmLKq0C5LVfsl+9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115625; c=relaxed/simple;
	bh=l7BCMdtK460/NfNyVFkhn6WxPhHDN9NJk1dX5OE3xb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YINu9WBoFv3lvIuxJMpTpnmR57tnLEA77gdsfcVHzJCqW9z7+XFzTnvY27hHHn4A8feYm7JBq3NW2G7ob42xRU+/jtIai3hY68jAsbNYzQ5HCePty+T2z5lnFlfmpyi63qcmNJZFq9Q9bN/HMZ+LRQAp9ol2oBDL50bF5hRP3yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=AbkrsG4h; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41258904302so175475e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 12:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708115620; x=1708720420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+W//dfF0n/wy1LXmbmCGBv/0bG6tpfv/t9YAFDF8dg=;
        b=AbkrsG4hQozdqZIAuPuUwi6rboShfc+IbD8ZzU38JoHYU54EYvu5+IRAI/AZBtmGjF
         SNyCVX/wbfv8KwFnh8dOXq2QGD/byWIq5EppoOcTAwrDUh08EJhd9k4mY32qdpRG1iz7
         5AQDmIaLXQhGVN6SBIdVseU09vRy9eC+p6+jhBkIh1HdEVKi88hs2PtCWDwsiitjqqoi
         0BDFFaGoteZUSskckF+knIUgD68zDIH1lx7Cv0E1OkBocylB2h9+ojBklqMqLbacBIPS
         PCEoyccHC2UFBLUaMm6qRdnmijMTz1b4r0zzDudQD+P2fs9+BsV7letxEFv+BSlarZxE
         /3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115620; x=1708720420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+W//dfF0n/wy1LXmbmCGBv/0bG6tpfv/t9YAFDF8dg=;
        b=GDJCScsdf/xf2P8ohls0YlqdEikGD5LrqNWofIuVbSSVGpvgSaDYgNTMRX5DygVcLt
         gyxGRc2NGu/DHEJ5aA4n+BLkOocO723TvvgwC/3O7F3Os8jc2yAAPVOXlAeKg1K8M94f
         +OdfZRh2NOPiA5Orj+C3tcigrM4LON7/Pzms4PtG610CiU70zTgGHlLtvcJyCi+LxpPn
         t4z3Jy7gUoPey6y56r1mvkGOZLJt1qNKCK/b5dfW1pkwhsi2qvzH4adUivYUDXRbPoCe
         qkwREEdahV5Lt6F6ljCW9dTjJ+yr8HLkfw6K/zZFEaqwXpPtJcD0MPDJT0AdkidSvlX1
         Llwg==
X-Forwarded-Encrypted: i=1; AJvYcCVh3ndl+QbQ69Qcc7PIQx7Kcf3Raf8lHzuY7GbO8TxNx5ury7Ry/Vsrbc2gHL0c4MrYZzScIfSHePAndybhCNYD1JVh5VV51P8Q2nmn9SA=
X-Gm-Message-State: AOJu0YzSEb5f28PxVGXERN2D4hJleQWJKCtAjoPTFIBSbcIGZZjHaR3r
	cG7rA2leBxQptCAXSrcUUsb0LbkZVqRr3RAxrX/oUp50qbBNXAbvGE89nb6Nvzk=
X-Google-Smtp-Source: AGHT+IGBibCllNh8ll1Vx+GOheKaOUkavu0vOY90FybjEbw07Iwz+LAx2+7vA1a+b5lW/0606M1yCA==
X-Received: by 2002:a05:600c:444b:b0:40f:e806:2f26 with SMTP id v11-20020a05600c444b00b0040fe8062f26mr4798554wmn.12.1708115619950;
        Fri, 16 Feb 2024 12:33:39 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041253d0acd6sm1420528wmq.47.2024.02.16.12.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:39 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 18/18] PCI/pwrctl: add a PCI power control driver for power sequenced devices
Date: Fri, 16 Feb 2024 21:32:15 +0100
Message-Id: <20240216203215.40870-19-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240216203215.40870-1-brgl@bgdev.pl>
References: <20240216203215.40870-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a PCI power control driver that's capable of correctly powering up
devices using the power sequencing subsystem. The first user of this
driver is the ath11k module on QCA6390.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/pwrctl/Kconfig             |  9 +++
 drivers/pci/pwrctl/Makefile            |  1 +
 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c | 84 ++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c

diff --git a/drivers/pci/pwrctl/Kconfig b/drivers/pci/pwrctl/Kconfig
index b91170ebfb49..3880a88aa73b 100644
--- a/drivers/pci/pwrctl/Kconfig
+++ b/drivers/pci/pwrctl/Kconfig
@@ -5,6 +5,15 @@ menu "PCI Power control drivers"
 config PCI_PWRCTL
 	tristate
 
+config PCI_PWRCTL_PWRSEQ
+	tristate "PCI Power Control driver using the Power Sequencing subsystem"
+	select POWER_SEQUENCING
+	select PCI_PWRCTL
+	default m if (ATH11K_PCI && ARCH_QCOM)
+	help
+	  Enable support for the PCI power control driver for device
+	  drivers using the Power Sequencing subsystem.
+
 config PCI_PWRCTL_WCN7850
 	tristate "PCI Power Control driver for WCN7850"
 	select PCI_PWRCTL
diff --git a/drivers/pci/pwrctl/Makefile b/drivers/pci/pwrctl/Makefile
index de20c3af1b78..47ab9db1fb42 100644
--- a/drivers/pci/pwrctl/Makefile
+++ b/drivers/pci/pwrctl/Makefile
@@ -3,4 +3,5 @@
 obj-$(CONFIG_PCI_PWRCTL)		+= pci-pwrctl-core.o
 pci-pwrctl-core-y			:= core.o
 
+obj-$(CONFIG_PCI_PWRCTL_PWRSEQ)		+= pci-pwrctl-pwrseq.o
 obj-$(CONFIG_PCI_PWRCTL_WCN7850)	+= pci-pwrctl-wcn7850.o
diff --git a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
new file mode 100644
index 000000000000..43820a727b3f
--- /dev/null
+++ b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Linaro Ltd.
+ */
+
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pci-pwrctl.h>
+#include <linux/platform_device.h>
+#include <linux/pwrseq/consumer.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+struct pci_pwrctl_pwrseq_data {
+	struct pci_pwrctl ctx;
+	struct pwrseq_desc *pwrseq;
+};
+
+static void devm_pci_pwrctl_pwrseq_power_off(void *data)
+{
+	struct pwrseq_desc *pwrseq = data;
+
+	pwrseq_power_off(pwrseq);
+}
+
+static int pci_pwrctl_pwrseq_probe(struct platform_device *pdev)
+{
+	struct pci_pwrctl_pwrseq_data *data;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->pwrseq = devm_pwrseq_get(dev, of_device_get_match_data(dev));
+	if (IS_ERR(data->pwrseq))
+		return dev_err_probe(dev, PTR_ERR(data->pwrseq),
+				     "Failed to get the power sequencer\n");
+
+	ret = pwrseq_power_on(data->pwrseq);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to power-on the device\n");
+
+	ret = devm_add_action_or_reset(dev, devm_pci_pwrctl_pwrseq_power_off,
+				       data->pwrseq);
+	if (ret)
+		return ret;
+
+	data->ctx.dev = dev;
+
+	ret = devm_pci_pwrctl_device_set_ready(dev, &data->ctx);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register the pwrctl wrapper\n");
+
+	return 0;
+}
+
+static const struct of_device_id pci_pwrctl_pwrseq_of_match[] = {
+	{
+		/* ATH11K in QCA6390 package. */
+		.compatible = "pci17cb,1101",
+		.data = "wlan",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pci_pwrctl_pwrseq_of_match);
+
+static struct platform_driver pci_pwrctl_pwrseq_driver = {
+	.driver = {
+		.name = "pci-pwrctl-pwrseq",
+		.of_match_table = pci_pwrctl_pwrseq_of_match,
+	},
+	.probe = pci_pwrctl_pwrseq_probe,
+};
+module_platform_driver(pci_pwrctl_pwrseq_driver);
+
+MODULE_AUTHOR("Bartosz Golaszewski <bartosz.golaszewski@linaro.org>");
+MODULE_DESCRIPTION("Generic PCI Power Control module for power sequenced devices");
+MODULE_LICENSE("GPL");
-- 
2.40.1


