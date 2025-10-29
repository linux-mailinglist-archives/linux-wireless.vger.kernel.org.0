Return-Path: <linux-wireless+bounces-28362-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717DAC1B8F8
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 16:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56997625324
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 14:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EBC2D12ED;
	Wed, 29 Oct 2025 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmK7uQDz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42B52BF01D;
	Wed, 29 Oct 2025 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748000; cv=none; b=LaZb+AFqhr6QhkKwMBdQ/Lusi5IHMQNZ6SB2tMeUNrlEW52lfVBcJcthKHCN1mR9OMPeRwDsVKjnhtCParpYEgBAOkryPE1aOQzXK/NfDK7mkolknj08DoqHwQeYWsUOtpcZd6vED/r5Edr+pCEeqKayDXLsJjbkyqIthUMXkuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748000; c=relaxed/simple;
	bh=W5IhVZX+lFdfsONd0QZSdbYGapL1pgYTOaMok8jmlw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L/WMq9ConJPcoc/7QmNkkJKdy9vwmfvlfMBJl7kzGA2KHSmP81BaBvsKRx5nCS4ZlYILd0cKjgiliYEtKGkkehgN8aS5W91mgwdq3rcLAX6wrxH07BOBuoSTVH40dNke/GJOpZPnNBFpiBT66GTqwDy726oupY4jpxrkq2fuYa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmK7uQDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88C4CC4CEF8;
	Wed, 29 Oct 2025 14:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761748000;
	bh=W5IhVZX+lFdfsONd0QZSdbYGapL1pgYTOaMok8jmlw0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qmK7uQDzoNsK7Rid9yt+MNp4gI0D1XYki7p/mbLxrXqfYFfWs5yxj2UXcgF4VBaU0
	 dvF+axJdf5Vwqhl79iyEM4gGc5QR571+vYFixZd3jaYCGlB3mR3adsY2r9J9IKRuT0
	 5AilOHdiyoEqYRzmHVZ05qGPG12Xpc/imeclSvTI3GzKbuvU59+bPqjVHyaWxcJ/ii
	 2yVzUCqTuw5xXzOzTYyU/SAyAXUgajcZVvN40bGqUjQFXOw6Bf5i2r9ZEpIfqdL712
	 +n9qLF2GmSKz0P7Ccct/n+mQlqY9NghcM+pVWeOKIMb+ZRKp4QOusITDBp5ArVujDe
	 Psq6YyDkbODvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8F0CCF9F0;
	Wed, 29 Oct 2025 14:26:40 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 29 Oct 2025 18:26:25 +0400
Subject: [PATCH 4/6] wifi: ath11k: update hif and pci ops for QCN6122
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-ath11k-qcn6122-v1-4-58ed68eba333@outlook.com>
References: <20251029-ath11k-qcn6122-v1-0-58ed68eba333@outlook.com>
In-Reply-To: <20251029-ath11k-qcn6122-v1-0-58ed68eba333@outlook.com>
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
 ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761747997; l=4454;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=VlBalx5CHHfhBt2bUbYow2vSFYMGLxLRZDITHsN4nSw=;
 b=hbNtn/9yXJydn9STDqZjWFGK9LIN/4TraKsdaQFpvjGtqWG6nGdSndOMZF/hd+JPmLHcByl9p
 +33Pyd4TvNNBF44Fcm6EsPHsMxzADK0wItvC2l7wiaNlrgPlhcZszG1
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

Add HIF and PCI ops for QCN6122. QCN6122 by default uses DP window 3.
However, this is configurable, so let's introduce a function to do that
and follow the existing register access code for (hybrid) AHB devices
and use DP window 1.

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hif.h |  9 +++++++++
 drivers/net/wireless/ath/ath11k/qmi.c |  2 ++
 3 files changed, 45 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 8dfe9b40c12626649639fc1dd9da0e5e0c2dcaf1..7b267dd62e964b2c4d6c3bbe016abd1ad0297219 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -762,6 +762,18 @@ static int ath11k_ahb_hif_resume(struct ath11k_base *ab)
 	return 0;
 }
 
+static void ath11k_ahb_config_static_window_qcn6122(struct ath11k_base *ab)
+{
+	u32 umac_window = FIELD_GET(ATH11K_PCI_WINDOW_VALUE_MASK, HAL_SEQ_WCSS_UMAC_OFFSET);
+	u32 ce_window = FIELD_GET(ATH11K_PCI_WINDOW_VALUE_MASK, HAL_CE_WFSS_CE_REG_BASE);
+	u32 window;
+
+	window = (umac_window) | (ce_window << 6);
+
+	iowrite32(ATH11K_PCI_WINDOW_ENABLE_BIT | window,
+		  ab->mem + ATH11K_PCI_WINDOW_REG_ADDRESS);
+}
+
 static const struct ath11k_hif_ops ath11k_ahb_hif_ops_ipq8074 = {
 	.start = ath11k_ahb_start,
 	.stop = ath11k_ahb_stop,
@@ -794,6 +806,24 @@ static const struct ath11k_hif_ops ath11k_ahb_hif_ops_wcn6750 = {
 	.ce_irq_disable = ath11k_pci_disable_ce_irqs_except_wake_irq,
 };
 
+static const struct ath11k_hif_ops ath11k_ahb_hif_ops_qcn6122 = {
+	.start = ath11k_pcic_start,
+	.stop = ath11k_pcic_stop,
+	.read32 = ath11k_pcic_read32,
+	.write32 = ath11k_pcic_write32,
+	.read = NULL,
+	.irq_enable = ath11k_pcic_ext_irq_enable,
+	.irq_disable = ath11k_pcic_ext_irq_disable,
+	.get_msi_address =  ath11k_pcic_get_msi_address,
+	.get_user_msi_vector = ath11k_pcic_get_user_msi_assignment,
+	.map_service_to_pipe = ath11k_pcic_map_service_to_pipe,
+	.power_down = ath11k_ahb_power_down,
+	.power_up = ath11k_ahb_power_up,
+	.ce_irq_enable = ath11k_pci_enable_ce_irqs_except_wake_irq,
+	.ce_irq_disable = ath11k_pci_disable_ce_irqs_except_wake_irq,
+	.config_static_window = ath11k_ahb_config_static_window_qcn6122,
+};
+
 static int ath11k_core_get_rproc(struct ath11k_base *ab)
 {
 	struct ath11k_ahb *ab_ahb = ath11k_ahb_priv(ab);
@@ -1127,6 +1157,10 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 		hif_ops = &ath11k_ahb_hif_ops_wcn6750;
 		pci_ops = &ath11k_ahb_pci_ops_wcn6750;
 		break;
+	case ATH11K_HW_QCN6122_HW10:
+		hif_ops = &ath11k_ahb_hif_ops_qcn6122;
+		pci_ops = &ath11k_ahb_pci_ops_wcn6750;
+		break;
 	default:
 		dev_err(&pdev->dev, "unsupported device type %d\n", hw_rev);
 		return -EOPNOTSUPP;
diff --git a/drivers/net/wireless/ath/ath11k/hif.h b/drivers/net/wireless/ath/ath11k/hif.h
index cd9c4b838246815ecb2a10784732c009a5423b6e..e4c1ad4d8ffc7627f6b3c384d64cb71b82451639 100644
--- a/drivers/net/wireless/ath/ath11k/hif.h
+++ b/drivers/net/wireless/ath/ath11k/hif.h
@@ -32,6 +32,7 @@ struct ath11k_hif_ops {
 	void (*ce_irq_disable)(struct ath11k_base *ab);
 	void (*get_ce_msi_idx)(struct ath11k_base *ab, u32 ce_id, u32 *msi_idx);
 	void (*coredump_download)(struct ath11k_base *ab);
+	void (*config_static_window)(struct ath11k_base *ab);
 };
 
 static inline void ath11k_hif_ce_irq_enable(struct ath11k_base *ab)
@@ -159,4 +160,12 @@ static inline void ath11k_hif_coredump_download(struct ath11k_base *ab)
 		ab->hif.ops->coredump_download(ab);
 }
 
+static inline void ath11k_hif_config_static_window(struct ath11k_base *ab)
+{
+	if (!ab->hw_params.static_window_map || !ab->hif.ops->config_static_window)
+		return;
+
+	ab->hif.ops->config_static_window(ab);
+}
+
 #endif /* _HIF_H_ */
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index aea56c38bf8f38982532fc90de25582c26ba4393..613e8c56978fe5af8f9b1b24c1b46efbc0bf2cb7 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2190,6 +2190,8 @@ static int ath11k_qmi_request_device_info(struct ath11k_base *ab)
 	if (!ab->hw_params.ce_remap)
 		ab->mem_ce = ab->mem;
 
+	ath11k_hif_config_static_window(ab);
+
 	return 0;
 out:
 	return ret;

-- 
2.51.1



