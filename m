Return-Path: <linux-wireless+bounces-38095-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GWfULwU3PWrXzAgAu9opvQ
	(envelope-from <linux-wireless+bounces-38095-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 16:11:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3750A6C66EB
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 16:11:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=Dfg3lqIS;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38095-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38095-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79CBA30711D1
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2026 14:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCF235C1BD;
	Thu, 25 Jun 2026 14:10:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECC133A9C1;
	Thu, 25 Jun 2026 14:10:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396631; cv=none; b=SsM5iswd06nAfYa6KcZeKMGMXMClYrynQBtEplqfKSuNC1X/OsGRGHLLxb4hVlKiapFsbHZAd4I4/7Tqu8GMPjZ95kq9bh2Wg7ftmQvgdSCmB/vlTHssIdh+44CdbmIaB8r3uY2fBBACMQCCnfqHxicWnH9dX4zjomeWSz4VrNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396631; c=relaxed/simple;
	bh=ycC+GQix4zQ36UL1Ou2055qToVbPC0zOEtny3bFYU/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R007zCAsRtkl8nSh9m+HkqAeuLzSbJEJaP1CEdK/yK4fQjJ8fzdWcuWr1nZ4g0UILiFkkNYvcyDPdgKBCH2HbJUIpeYTf2D2JYmTEezapGaAPHQkAvUjooc02gBT3db6ljUkNWrBYJcM20OIrSpMtsb+w6xJGLaVAvV82bppIN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dfg3lqIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F51FC2BCF4;
	Thu, 25 Jun 2026 14:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782396631;
	bh=ycC+GQix4zQ36UL1Ou2055qToVbPC0zOEtny3bFYU/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Dfg3lqISRYsdB1QuAap/8IMQhqIk6dy4vFYBtJJRdUNINYPRItDtIWsmqMjS2VP5L
	 egt9PpUiXqYddeFnD7hQveFHF4wQmg5xrRjuyuIRMej006U1UCQlCWTUKeWa+VJ1jR
	 cdaz4xA3t2VXmqWEN7Og/s6kZCmk74hSs6Nx9pSA/I2FD6u3NvJfbO8H27hxlCxD8i
	 0GJtyIGldKfhBHF+/qq3SZo4xztTay1QM+ZQSVxuGsO6Y0qTMrkMyLKptdCjiPNWAA
	 CbYtz9lp5e5Cd9VCvTacFnw4oyRA3iXtFXjonT2CUFoGwroh0xtr4uwX2sNtMDXA7d
	 dfnzTsvhzRlUA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3625CDB479;
	Thu, 25 Jun 2026 14:10:30 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Thu, 25 Jun 2026 18:10:06 +0400
Subject: [PATCH 2/6] remoteproc: qcom: Add M0 BTSS secure PIL driver
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-ipq5018-bluetooth-v1-2-d999be0e04f7@outlook.com>
References: <20260625-ipq5018-bluetooth-v1-0-d999be0e04f7@outlook.com>
In-Reply-To: <20260625-ipq5018-bluetooth-v1-0-d999be0e04f7@outlook.com>
To: Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulfh@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
 Rocky Liao <quic_rjliao@quicinc.com>, 
 Saravana Kannan <saravanak@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782396628; l=8999;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=DZrXVK9colzil8YwnbWNpyUvIkVtTOuT3yHRPJJIldk=;
 b=n725LM65DoAVovuOcG8uKJk15Whq6Z31EW4GDb8U1hdzvtIw+Rlvj/+vEjRLDxtR9pzzg8iGn
 ntT1YRZwizbBdtz2xFBuXctxI3hwoJr0TEoXJuGlQva41nCV38yXvIu
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38095-lists,linux-wireless=lfdr.de,george.moussalem.outlook.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:axboe@kernel.dk,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:saravanak@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mathieu.poirier@linaro.org,m:p.zabel@pengutronix.de,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-arm-msm@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-remoteproc@vger.kernel.org,m:george.moussalem@outlook.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[devnull@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.dk,kernel.org,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,pengutronix.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,outlook.com:replyto,outlook.com:email,outlook.com:mid];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	HAS_REPLYTO(0.00)[george.moussalem@outlook.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,outlook.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3750A6C66EB

From: George Moussalem <george.moussalem@outlook.com>

Add support to bring up the M0 core of the bluetooth subsystem found in
the IPQ5018 SoC.

The signed firmware loaded is authenticated by TrustZone. If successful,
the M0 core boots the firmware and the peripheral is taken out of reset
using a Secure Channel Manager call to TrustZone.

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 drivers/remoteproc/Kconfig            |  12 ++
 drivers/remoteproc/Makefile           |   1 +
 drivers/remoteproc/qcom_m0_btss_pil.c | 261 ++++++++++++++++++++++++++++++++++
 3 files changed, 274 insertions(+)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index c521c744e7db..6b52f78f1427 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -163,6 +163,18 @@ config PRU_REMOTEPROC
 	  processors on various TI SoCs. It's safe to say N here if you're
 	  not interested in the PRU or if you are unsure.
 
+config QCOM_M0_BTSS_PIL
+	tristate "Qualcomm M0 BTSS Peripheral Image Loader"
+	depends on OF && ARCH_QCOM
+	select QCOM_MDT_LOADER
+	select QCOM_RPROC_COMMON
+	select QCOM_SCM
+	help
+	  Say y here to support the Secure Peripheral Imager Loader for the
+	  Qualcomm Bluetooth Subsystem running on the M0 remote processor found
+	  in the IPQ5018 SoC. The M0 core is started and stopped using a
+	  Secure Channel Manager call to TrustZone.
+
 config QCOM_PIL_INFO
 	tristate
 
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 1c7598b8475d..df80faf8d0df 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
 obj-$(CONFIG_KEYSTONE_REMOTEPROC)	+= keystone_remoteproc.o
 obj-$(CONFIG_MESON_MX_AO_ARC_REMOTEPROC)+= meson_mx_ao_arc.o
 obj-$(CONFIG_PRU_REMOTEPROC)		+= pru_rproc.o
+obj-$(CONFIG_QCOM_M0_BTSS_PIL)		+= qcom_m0_btss_pil.o
 obj-$(CONFIG_QCOM_PIL_INFO)		+= qcom_pil_info.o
 obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
 obj-$(CONFIG_QCOM_Q6V5_COMMON)		+= qcom_q6v5.o
diff --git a/drivers/remoteproc/qcom_m0_btss_pil.c b/drivers/remoteproc/qcom_m0_btss_pil.c
new file mode 100644
index 000000000000..7168e270e4d4
--- /dev/null
+++ b/drivers/remoteproc/qcom_m0_btss_pil.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/elf.h>
+#include <linux/firmware/qcom/qcom_scm.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/soc/qcom/mdt_loader.h>
+
+#include "qcom_common.h"
+
+#define BTSS_PAS_ID	0xc
+
+struct m0_btss {
+	struct device *dev;
+	phys_addr_t mem_phys;
+	phys_addr_t mem_reloc;
+	void __iomem *mem_region;
+	size_t mem_size;
+	struct reset_control *btss_reset;
+};
+
+static int m0_btss_start(struct rproc *rproc)
+{
+	int ret;
+
+	if (!qcom_scm_pas_supported(BTSS_PAS_ID)) {
+		dev_err(rproc->dev.parent,
+			"PAS is not available for peripheral: 0x%x\n",
+			BTSS_PAS_ID);
+		return -ENODEV;
+	}
+
+	ret = qcom_scm_pas_auth_and_reset(BTSS_PAS_ID);
+	if (ret) {
+		dev_err(rproc->dev.parent, "Failed to start rproc: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int m0_btss_stop(struct rproc *rproc)
+{
+	int ret;
+
+	if (rproc->state == RPROC_RUNNING || rproc->state == RPROC_CRASHED) {
+		ret = qcom_scm_pas_shutdown(BTSS_PAS_ID);
+		if (ret) {
+			dev_err(rproc->dev.parent, "Failed to stop rproc: %d\n",
+				ret);
+			return ret;
+		}
+
+		dev_info(rproc->dev.parent, "Successfully stopped rproc\n");
+	}
+
+	return 0;
+}
+
+static int m0_btss_load(struct rproc *rproc, const struct firmware *fw)
+{
+	struct m0_btss *desc = rproc->priv;
+	const struct elf32_phdr *phdrs;
+	const struct firmware *seg_fw;
+	const struct elf32_phdr *phdr;
+	const struct elf32_hdr *ehdr;
+	void __iomem *metadata;
+	size_t metadata_size;
+	int i, ret;
+
+	ehdr = (const struct elf32_hdr *)fw->data;
+	phdrs = (const struct elf32_phdr *)(ehdr + 1);
+
+	ret = request_firmware(&fw, rproc->firmware, rproc->dev.parent);
+	if (ret) {
+		dev_err(rproc->dev.parent, "Failed to request firmware: %d\n",
+			ret);
+		return ret;
+	}
+
+	metadata = qcom_mdt_read_metadata(fw, &metadata_size, rproc->firmware,
+					  rproc->dev.parent);
+	if (IS_ERR(metadata)) {
+		ret = PTR_ERR(metadata);
+		dev_err(rproc->dev.parent,
+			"Failed to read firmware metadata: %d\n", ret);
+		goto release_fw;
+	}
+
+	ret = qcom_scm_pas_init_image(BTSS_PAS_ID, metadata,
+				      metadata_size, NULL);
+	if (ret) {
+		dev_err(rproc->dev.parent, "PAS init image failed: %d\n", ret);
+		goto free_metadata;
+	}
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		char *seg_name __free(kfree) = kstrdup(rproc->firmware,
+						       GFP_KERNEL);
+		if (!seg_name)
+			return -ENOMEM;
+
+		phdr = &phdrs[i];
+
+		/* Only process valid loadable data segments */
+		if (phdr->p_type != PT_LOAD || !phdr->p_memsz)
+			continue;
+
+		if (phdr->p_vaddr + phdr->p_filesz > desc->mem_size) {
+			dev_err(rproc->dev.parent,
+				"Segment data exceeds the reserved memory area!\n");
+			goto free_metadata;
+		}
+
+		/* Check if firmware is split across multiple segment files */
+		if (phdr->p_offset > fw->size ||
+		    phdr->p_offset + phdr->p_filesz > fw->size) {
+			sprintf(seg_name + strlen(seg_name) - 3, "b%02d", i);
+			ret = request_firmware(&seg_fw, seg_name,
+					       rproc->dev.parent);
+			if (ret) {
+				dev_err(rproc->dev.parent,
+					"Could not find split segment binary: %s\n",
+					seg_name);
+				goto free_metadata;
+			}
+
+			/*
+			 * Use the virtual instead of the physical address as
+			 * the offset
+			 */
+			memcpy_toio(desc->mem_region + phdr->p_vaddr,
+				    seg_fw->data, phdr->p_filesz);
+
+			release_firmware(seg_fw);
+		} else {
+			memcpy_toio(desc->mem_region + phdr->p_vaddr,
+				    fw->data + phdr->p_offset, phdr->p_filesz);
+		}
+	}
+
+	return 0;
+
+free_metadata:
+	kfree(metadata);
+release_fw:
+	release_firmware(fw);
+	return ret;
+}
+
+static const struct rproc_ops m0_btss_ops = {
+	.start = m0_btss_start,
+	.stop = m0_btss_stop,
+	.load = m0_btss_load,
+	.get_boot_addr = rproc_elf_get_boot_addr,
+};
+
+static int m0_btss_alloc_memory_region(struct m0_btss *desc)
+{
+	struct device *dev = desc->dev;
+	struct resource res;
+	int ret;
+
+	ret = of_reserved_mem_region_to_resource(dev->of_node, 0, &res);
+	if (ret) {
+		dev_err(dev, "unable to acquire memory-region resource\n");
+		return ret;
+	}
+
+	desc->mem_phys = res.start;
+	desc->mem_reloc = res.start;
+	desc->mem_size = resource_size(&res);
+	desc->mem_region = devm_ioremap(dev, desc->mem_phys, desc->mem_size);
+	if (!desc->mem_region) {
+		dev_err(dev, "unable to map memory region: %pR\n", &res);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int m0_btss_pil_probe(struct platform_device *pdev)
+{
+	// struct reset_control *btss_reset;
+	struct device *dev = &pdev->dev;
+	const char *fw_name = NULL;
+	struct m0_btss *desc;
+	struct clk *lpo_clk;
+	struct rproc *rproc;
+	int ret;
+
+	ret = of_property_read_string(dev->of_node, "firmware-name",
+				      &fw_name);
+	if (ret < 0)
+		return ret;
+
+	rproc = devm_rproc_alloc(dev, "m0btss", &m0_btss_ops,
+				 fw_name, sizeof(*desc));
+	if (!rproc) {
+		dev_err(dev, "failed to allocate rproc\n");
+		return -ENOMEM;
+	}
+
+	desc = rproc->priv;
+	desc->dev = dev;
+
+	ret = m0_btss_alloc_memory_region(desc);
+	if (ret)
+		return ret;
+
+	lpo_clk = devm_clk_get_enabled(dev, "btss_lpo_clk");
+	if (IS_ERR(lpo_clk))
+		return dev_err_probe(dev, PTR_ERR(lpo_clk),
+				     "Failed to get lpo clock\n");
+
+	desc->btss_reset = devm_reset_control_get(dev, "btss_reset");
+	if (IS_ERR_OR_NULL(desc->btss_reset))
+		return dev_err_probe(dev, PTR_ERR(desc->btss_reset),
+				     "unable to acquire btss_reset\n");
+
+	ret = reset_control_deassert(desc->btss_reset);
+	if (ret)
+		return dev_err_probe(rproc->dev.parent, ret,
+				     "Failed to deassert reset\n");
+
+	rproc->auto_boot = false;
+	ret = devm_rproc_add(dev, rproc);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, rproc);
+
+	return 0;
+}
+
+static const struct of_device_id m0_btss_of_match[] = {
+	{ .compatible = "qcom,ipq5018-btss-pil" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, m0_btss_of_match);
+
+static struct platform_driver m0_btss_pil_driver = {
+	.probe = m0_btss_pil_probe,
+	.driver = {
+		.name = "qcom-m0-btss-pil",
+		.of_match_table = m0_btss_of_match,
+	},
+};
+
+module_platform_driver(m0_btss_pil_driver);
+
+MODULE_DESCRIPTION("Qualcomm M0 Bluetooth Subsystem Peripheral Image Loader");
+MODULE_LICENSE("GPL");

-- 
2.53.0



