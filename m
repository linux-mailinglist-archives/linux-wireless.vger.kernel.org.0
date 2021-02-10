Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486FB316161
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 09:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhBJIrZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 03:47:25 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:20734 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230183AbhBJIng (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 03:43:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612946587; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=YUn6KtQ82cRAjlKMDiN/DPP0R7XPEesCuLrFOeliG/Q=; b=QWVa6x3DZka9PszhuAKsiZhfX7/uBciAbEGLbFNgMosDA3ExgexU3qUEMeDgjCOzKQSwvuia
 4Nfln3kfyHKhkRirRtprCS7pyq/Xm33RiZ3zybR2HsT2jBbyKgR2k1gb2JrYDg1wjAGPM/4j
 fUWG//HpGEWWyBnJT7swohNHQCQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60239c7bd5a7a3baae3cdd86 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Feb 2021 08:42:35
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CF774C43463; Wed, 10 Feb 2021 08:42:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A81CCC433ED;
        Wed, 10 Feb 2021 08:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A81CCC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: [PATCH 06/11] ath11k: add static window support for register access
Date:   Wed, 10 Feb 2021 14:12:05 +0530
Message-Id: <1612946530-28504-7-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
References: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Karthikeyan Periyasamy <periyasa@codeaurora.org>

Three window slots can be configure. First window slot
dedicate for dynamic selection and remaining two slots
dedicate for static selection. To optimise the window
selection, frequent registers (UMAC, CE) are configure
in static window slot. so that we minimise the window
selection. Other registers are configure in dynamic window
slot. Get the window start address from the respective
offset and access the read/write register.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/hal.h  |  4 ++
 drivers/net/wireless/ath/ath11k/pci.c  | 72 +++++++++++++++++++++++++++++-----
 3 files changed, 68 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 9a8fb23577b0..912294f7657c 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -608,6 +608,7 @@ struct ath11k_bus_params {
 	bool m3_fw_support;
 	bool fixed_bdf_addr;
 	bool fixed_mem_region;
+	bool static_window_map;
 };
 
 /* IPQ8074 HW channel counters frequency value in hertz */
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 1f1b29cd0aa3..3f5687ebe1fc 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -39,6 +39,7 @@ struct ath11k_base;
 #define HAL_SHADOW_REG(x) (HAL_SHADOW_BASE_ADDR + (4 * (x)))
 
 /* WCSS Relative address */
+#define HAL_SEQ_WCSS_UMAC_OFFSET		0x00a00000
 #define HAL_SEQ_WCSS_UMAC_REO_REG		0x00a38000
 #define HAL_SEQ_WCSS_UMAC_TCL_REG		0x00a44000
 #define HAL_SEQ_WCSS_UMAC_CE0_SRC_REG		0x00a00000
@@ -47,6 +48,9 @@ struct ath11k_base;
 #define HAL_SEQ_WCSS_UMAC_CE1_DST_REG		0x00a03000
 #define HAL_SEQ_WCSS_UMAC_WBM_REG		0x00a34000
 
+#define HAL_CE_WFSS_CE_REG_BASE			0x01b80000
+#define HAL_WLAON_REG_BASE			0x01f80000
+
 /* SW2TCL(x) R0 ring configuration address */
 #define HAL_TCL1_RING_CMN_CTRL_REG		0x00000014
 #define HAL_TCL1_RING_DSCP_TID_MAP		0x0000002c
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 5edcb1ef9523..f112ebd9d98b 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -133,9 +133,38 @@ static inline void ath11k_pci_select_window(struct ath11k_pci *ab_pci, u32 offse
 	}
 }
 
+static inline void ath11k_pci_select_static_window(struct ath11k_pci *ab_pci)
+{
+	u32 umac_window = FIELD_GET(WINDOW_VALUE_MASK, HAL_SEQ_WCSS_UMAC_OFFSET);
+	u32 ce_window = FIELD_GET(WINDOW_VALUE_MASK, HAL_CE_WFSS_CE_REG_BASE);
+	u32 window;
+
+	window = (umac_window << 12) | (ce_window << 6);
+
+	iowrite32(WINDOW_ENABLE_BIT | window, ab_pci->ab->mem + WINDOW_REG_ADDRESS);
+}
+
+static inline u32 ath11k_pci_get_window_start(struct ath11k_base *ab,
+					      u32 offset)
+{
+	u32 window_start;
+
+	/* If offset lies within DP register range, use 3rd window */
+	if ((offset ^ HAL_SEQ_WCSS_UMAC_OFFSET) < WINDOW_RANGE_MASK)
+		window_start = 3 * WINDOW_START;
+	/* If offset lies within CE register range, use 2nd window */
+	else if ((offset ^ HAL_CE_WFSS_CE_REG_BASE) < WINDOW_RANGE_MASK)
+		window_start = 2 * WINDOW_START;
+	else
+		window_start = WINDOW_START;
+
+	return window_start;
+}
+
 void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	u32 window_start;
 
 	/* for offset beyond BAR + 4K - 32, may
 	 * need to wakeup MHI to access.
@@ -147,10 +176,21 @@ void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value)
 	if (offset < WINDOW_START) {
 		iowrite32(value, ab->mem  + offset);
 	} else {
-		spin_lock_bh(&ab_pci->window_lock);
-		ath11k_pci_select_window(ab_pci, offset);
-		iowrite32(value, ab->mem + WINDOW_START + (offset & WINDOW_RANGE_MASK));
-		spin_unlock_bh(&ab_pci->window_lock);
+		if (ab->bus_params.static_window_map)
+			window_start = ath11k_pci_get_window_start(ab, offset);
+		else
+			window_start = WINDOW_START;
+
+		if (window_start == WINDOW_START) {
+			spin_lock_bh(&ab_pci->window_lock);
+			ath11k_pci_select_window(ab_pci, offset);
+			iowrite32(value, ab->mem + window_start +
+				  (offset & WINDOW_RANGE_MASK));
+			spin_unlock_bh(&ab_pci->window_lock);
+		} else {
+			iowrite32(value, ab->mem + window_start +
+				  (offset & WINDOW_RANGE_MASK));
+		}
 	}
 
 	if (test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
@@ -161,7 +201,7 @@ void ath11k_pci_write32(struct ath11k_base *ab, u32 offset, u32 value)
 u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
 {
 	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
-	u32 val;
+	u32 val, window_start;
 
 	/* for offset beyond BAR + 4K - 32, may
 	 * need to wakeup MHI to access.
@@ -173,10 +213,21 @@ u32 ath11k_pci_read32(struct ath11k_base *ab, u32 offset)
 	if (offset < WINDOW_START) {
 		val = ioread32(ab->mem + offset);
 	} else {
-		spin_lock_bh(&ab_pci->window_lock);
-		ath11k_pci_select_window(ab_pci, offset);
-		val = ioread32(ab->mem + WINDOW_START + (offset & WINDOW_RANGE_MASK));
-		spin_unlock_bh(&ab_pci->window_lock);
+		if (ab->bus_params.static_window_map)
+			window_start = ath11k_pci_get_window_start(ab, offset);
+		else
+			window_start = WINDOW_START;
+
+		if (window_start == WINDOW_START) {
+			spin_lock_bh(&ab_pci->window_lock);
+			ath11k_pci_select_window(ab_pci, offset);
+			val = ioread32(ab->mem + window_start +
+				       (offset & WINDOW_RANGE_MASK));
+			spin_unlock_bh(&ab_pci->window_lock);
+		} else {
+			val = ioread32(ab->mem + window_start +
+				       (offset & WINDOW_RANGE_MASK));
+		}
 	}
 
 	if (test_bit(ATH11K_PCI_FLAG_INIT_DONE, &ab_pci->flags) &&
@@ -936,6 +987,9 @@ static int ath11k_pci_power_up(struct ath11k_base *ab)
 		return ret;
 	}
 
+	if (ab->bus_params.static_window_map)
+		ath11k_pci_select_static_window(ab_pci);
+
 	return 0;
 }
 
-- 
2.7.4

