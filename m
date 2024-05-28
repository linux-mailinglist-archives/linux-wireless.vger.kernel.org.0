Return-Path: <linux-wireless+bounces-8233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8DE8D2445
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 21:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85B7289CB2
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 19:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA21187320;
	Tue, 28 May 2024 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wgjUatO9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A019E181BA6
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716923055; cv=none; b=bAKUbcu5ZpgsJG2bI+FLRuyVXT8iB0f1AplETLon8uzT8BCBtkq4p7fIIHUmT8yumF0+FZXOnhLJAEA2AiNEpyOblTDKu0VAqCB3+qXYUCuaQeLTtvIYyKhfl9uNsUkFwalGb5ujh4QfcY4/Swi0Xu7VOjEn0psmPY4wWSQf8Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716923055; c=relaxed/simple;
	bh=l9r01IsI4gMVvMOKHlpBm3/TS5dnpcNCrmig6K6kzuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F54TpBsc8OYkiIfNn1sEmCv03NPjitcQvjwRKHmjLnurVf3ycejX1/cr8/Y9hvyVKc955tuEJhaPk9BEK5YZX9ZBNr2siI3MSZw/E8Hm3VpU4UMteJYHTxIm2hbUNXZ4IjDxQUMUypcsCEmL1fCp+Qh5WxvhAGs+0B9JQfTc22A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wgjUatO9; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42011507a54so765925e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 12:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716923049; x=1717527849; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TT+uWe2JSf2jDh7U3q7jv7WoGknuA8VG1gE51Kt2FBY=;
        b=wgjUatO9vZE3z7sr0dlT35nZrpmZSq+ETuNrvrMNSc5j2Hzh4qwIaDOjYi6iXOHi8v
         7xBdUziH4N8ps9/UMk7YcoJ9xwHAsI6Tw+V0KEsIvylY4hR15NTn0wEv6jLWB25k+JS4
         WIlmj8imxTmr7t1d/XM91cgVF2s1vIzBmRPFHmEhpPvauDcDku4UfqjyfTEq4TxGw/kB
         PikAgsvrUTUeKNRSig2rMfqUgZIO5I33vFevXExBrU1appmv6ibQESSmbiT19XUNuMEm
         t7T0AmcJUvpZdC/R1w7RSFPl6CftC6FTm6lF4xfAB8URYI1/adr0SwyTCldlOjdcRJ3D
         +mzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716923049; x=1717527849;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TT+uWe2JSf2jDh7U3q7jv7WoGknuA8VG1gE51Kt2FBY=;
        b=KTh8Fkvy1UklPZN9vLLG7XRhbr0ypj7JI6OqgODqIIYZucBEGKSzKCVfdhVqnzLZOa
         ju/lr7Q6+pyiNUak6aCGmVure7bEK5W+Y9I4agydQHabfr17VbXThohMoLbxH2woXSV7
         b/besxeiy9uIx0CLvFSbrgAz4s0AA7Gxc9KQmtuzp7cfJF/0jgSJWiZYlwAKLyDfJwtO
         Cmw4mfxoocpOZCbFNw9kmfiqfwSvhOMLIAqO8XMnOz2sRHQnFSQnSTpC+Io/l7862Ck2
         yinHafLDqHOQkHZag+3LClYFZbg0olIRyYwJhWDHOaxkfCofxRMR9e7oEMb2bOicRZvm
         FtCw==
X-Forwarded-Encrypted: i=1; AJvYcCUU9RHFHmq95xSl3Rp5SCYUEPVFJPWxvdJQjDmKv4b7T4tBfPoiBrT6lfWj0OCznl4r3ayDaam/HqWwSN23fWca+GbD+c8QtIrKujuQy5w=
X-Gm-Message-State: AOJu0YwBjV3y6+fw20B+1q5jc9rgHcppGp29GU5Udknzd8LwEKJfPPaX
	NoDyxBJ/+bSB7b33w2rPhvHh40zpADTes98urn/SiGNkDA/85SmMPOPEnA3a4g0=
X-Google-Smtp-Source: AGHT+IHZAqsOQal0J9Cr46AF9k6zMSRPrWM7uUzT+zddHO+P5fTGOXJqx/oaki60jDPLL5cf6QeUOw==
X-Received: by 2002:a05:600c:4709:b0:415:ff48:59fc with SMTP id 5b1f17b1804b1-421015af252mr145485905e9.8.1716923049605;
        Tue, 28 May 2024 12:04:09 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:75a:e000:93eb:927a:e851:8a2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100ee954bsm183895415e9.4.2024.05.28.12.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 12:04:09 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 May 2024 21:03:24 +0200
Subject: [PATCH v8 16/17] PCI/pwrctl: add a PCI power control driver for
 power sequenced devices
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-pwrseq-v8-16-d354d52b763c@linaro.org>
References: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>
In-Reply-To: <20240528-pwrseq-v8-0-d354d52b763c@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, Kalle Valo <kvalo@kernel.org>, 
 Jeff Johnson <jjohnson@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Alex Elder <elder@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath11k@lists.infradead.org, Jeff Johnson <quic_jjohnson@quicinc.com>, 
 ath12k@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel@quicinc.com, 
 Amit Pundir <amit.pundir@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4088;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=2MLzc6c94GqxaZsUS9P5vO/f6xerHLjxxvVJICQ4DFM=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBmViqRs1SHioyT+3SUrNfYoCq3PulngfwHuEowz
 BEq+6sj74WJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZlYqkQAKCRARpy6gFHHX
 clM/EADRsKVMvFXfHzmUW1gtOVQ8PwZr3BWTnd242bUKh6TM+9CvCcerx32jHFo4/zX2AxT+MH8
 Ibiq9XEZNdRl9Qo+z1DDe3JIQqRZDO22dEQd5/jYWabfmodwbpaAQzRbjX5L4xrbPBQuUhEizgw
 slr0jxkvmWsU8Pq1qVwtNxjch9F0E7hJgVKtMLy4sQ0fFOda8fx7jWCCrqvzMajIKlVuZ5yGS28
 M9FUuCar2PNLY/68XOVdx6+nybSXzb3vjx5rN+O4fkWh0V2hLXn+ewVzTvFaDqAlAu70TBcBT8W
 E6UcViV3sRHm1GxvwN8XQ3oJNrZhQJ4dmMen3wyfkL0cwAube7jVh7lkjc3yitJV5Uohm/sQQlV
 bkMOuxoj0PYb/W156YmXeiSwVU5n0C9bdmUjM7hhttUHLrWA2ECjVa2PvNlETqG6VUaVNXRJqCa
 XKKLlV6vjqJdGwVUqOSO4x43gxnflacfRGi/BEAlHyTbc3qBGmti8LXwoOSzzjdirnr7M70HCUL
 tyZKPJyzu7D9F1q3wvCWmBGLyWoAA//IQ5wpHMcMDGcxxq8ncDluexPdY/5pF9Gr84LMjr1hLET
 QawiupaZH+YCpMU3qqq5CnxyjA/+TrdvHfuP+PEQT7G1acN7TjEgfv9ZxFP9o6dgFDiZZgSvV7q
 1q0HuiQ2cC7nWsw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a PCI power control driver that's capable of correctly powering up
devices using the power sequencing subsystem. The first users of this
driver are the ath11k module on QCA6390 and ath12k on WCN7850.

Tested-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pci/pwrctl/Kconfig             |  9 ++++
 drivers/pci/pwrctl/Makefile            |  2 +
 drivers/pci/pwrctl/pci-pwrctl-pwrseq.c | 89 ++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)

diff --git a/drivers/pci/pwrctl/Kconfig b/drivers/pci/pwrctl/Kconfig
index 96195395af69..f1b824955d4b 100644
--- a/drivers/pci/pwrctl/Kconfig
+++ b/drivers/pci/pwrctl/Kconfig
@@ -5,4 +5,13 @@ menu "PCI Power control drivers"
 config PCI_PWRCTL
 	tristate
 
+config PCI_PWRCTL_PWRSEQ
+	tristate "PCI Power Control driver using the Power Sequencing subsystem"
+	select POWER_SEQUENCING
+	select PCI_PWRCTL
+	default m if ((ATH11K_PCI || ATH12K) && ARCH_QCOM)
+	help
+	  Enable support for the PCI power control driver for device
+	  drivers using the Power Sequencing subsystem.
+
 endmenu
diff --git a/drivers/pci/pwrctl/Makefile b/drivers/pci/pwrctl/Makefile
index 52ae0640ef7b..d308aae4800c 100644
--- a/drivers/pci/pwrctl/Makefile
+++ b/drivers/pci/pwrctl/Makefile
@@ -2,3 +2,5 @@
 
 obj-$(CONFIG_PCI_PWRCTL)		+= pci-pwrctl-core.o
 pci-pwrctl-core-y			:= core.o
+
+obj-$(CONFIG_PCI_PWRCTL_PWRSEQ)		+= pci-pwrctl-pwrseq.o
diff --git a/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
new file mode 100644
index 000000000000..c7a113a76c0c
--- /dev/null
+++ b/drivers/pci/pwrctl/pci-pwrctl-pwrseq.c
@@ -0,0 +1,89 @@
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
+	{
+		/* ATH12K in WCN7850 package. */
+		.compatible = "pci17cb,1107",
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
2.43.0


