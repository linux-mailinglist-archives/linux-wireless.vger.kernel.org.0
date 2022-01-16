Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B45E48FCF2
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jan 2022 13:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbiAPMsG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jan 2022 07:48:06 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:22034 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbiAPMsF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jan 2022 07:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642337285; x=1673873285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ri+/yTuUiOlfA9reZMXIkbQGa45Fxja3Ry8gADx6kiE=;
  b=hDuGecSmqNTQefDjvIDPuiuCsMVWxCwZFCmEdZ8S55UJwzbl8bQpNhSA
   tkt76BrySMs3opHCj58JvKzWLVmXx9LWv9MfqmlLdZkcm4XHpTjdG5TDX
   3jVVvRkki1kI3oSZONpNYyXN6wzcWeab9dFHEfYEDOGeklmP2NXONTrUu
   A=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 16 Jan 2022 04:48:05 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 04:48:05 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 04:48:04 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 04:48:02 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v2 13/19] ath11k: Fix RX de-fragmentation issue on WCN6750
Date:   Sun, 16 Jan 2022 18:17:09 +0530
Message-ID: <1642337235-8618-14-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
References: <1642337235-8618-1-git-send-email-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The offset of REO register where the RX fragment destination ring
is configured is different in WCN6750 as compared to WCN6855.
Due to this differnce in offsets, on WCN6750, fragment destination
ring will be configured incorrectly, leading to RX fragments not
getting delivered to the driver. Fix this by defining HW specific
offset for the REO MISC CTL register.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/hal.h |  2 +-
 drivers/net/wireless/ath/ath11k/hw.c  | 10 ++++++++--
 drivers/net/wireless/ath/ath11k/hw.h  |  1 +
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 6fbda01..347d456 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -121,7 +121,7 @@ struct ath11k_base;
 #define HAL_REO1_DEST_RING_CTRL_IX_1		0x00000008
 #define HAL_REO1_DEST_RING_CTRL_IX_2		0x0000000c
 #define HAL_REO1_DEST_RING_CTRL_IX_3		0x00000010
-#define HAL_REO1_MISC_CTL			0x00000630
+#define HAL_REO1_MISC_CTL(ab)			ab->hw_params.regs->hal_reo1_misc_ctl
 #define HAL_REO1_RING_BASE_LSB(ab)		ab->hw_params.regs->hal_reo1_ring_base_lsb
 #define HAL_REO1_RING_BASE_MSB(ab)		ab->hw_params.regs->hal_reo1_ring_base_msb
 #define HAL_REO1_RING_ID(ab)			ab->hw_params.regs->hal_reo1_ring_id
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 2bc2232..c19f9101 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -771,10 +771,10 @@ static void ath11k_hw_wcn6855_reo_setup(struct ath11k_base *ab)
 		FIELD_PREP(HAL_REO1_GEN_ENABLE_AGING_FLUSH_ENABLE, 1);
 	ath11k_hif_write32(ab, reo_base + HAL_REO1_GEN_ENABLE, val);
 
-	val = ath11k_hif_read32(ab, reo_base + HAL_REO1_MISC_CTL);
+	val = ath11k_hif_read32(ab, reo_base + HAL_REO1_MISC_CTL(ab));
 	val &= ~HAL_REO1_MISC_CTL_FRAGMENT_DST_RING;
 	val |= FIELD_PREP(HAL_REO1_MISC_CTL_FRAGMENT_DST_RING, HAL_SRNG_RING_ID_REO2SW1);
-	ath11k_hif_write32(ab, reo_base + HAL_REO1_MISC_CTL, val);
+	ath11k_hif_write32(ab, reo_base + HAL_REO1_MISC_CTL(ab), val);
 
 	ath11k_hif_write32(ab, reo_base + HAL_REO1_AGING_THRESH_IX_0(ab),
 			   HAL_DEFAULT_REO_TIMEOUT_USEC);
@@ -2221,6 +2221,9 @@ const struct ath11k_hw_regs wcn6855_regs = {
 
 	/* Shadow register area */
 	.hal_shadow_base_addr = 0x000008fc,
+
+	/* REO MISC CTRL */
+	.hal_reo1_misc_ctl = 0x00000630,
 };
 
 const struct ath11k_hw_regs wcn6750_regs = {
@@ -2303,6 +2306,9 @@ const struct ath11k_hw_regs wcn6750_regs = {
 
 	/* Shadow register area */
 	.hal_shadow_base_addr = 0x00000504,
+
+	/* REO MISC CTRL */
+	.hal_reo1_misc_ctl = 0x000005d8,
 };
 
 const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq8074 = {
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index cb48d52..a220c9a 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -361,6 +361,7 @@ struct ath11k_hw_regs {
 	u32 pcie_pcs_osc_dtct_config_base;
 
 	u32 hal_shadow_base_addr;
+	u32 hal_reo1_misc_ctl;
 };
 
 extern const struct ath11k_hw_regs ipq8074_regs;
-- 
2.7.4

