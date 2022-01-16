Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EEE48FCE1
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jan 2022 13:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235113AbiAPMry (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jan 2022 07:47:54 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:6149 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbiAPMrv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jan 2022 07:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642337271; x=1673873271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=4E9AI9fR/82YUd3ofL8+CuzxoupnFw4BI27GeF3eOvk=;
  b=BJzRj9QC3KWh7l4vnskDXMfuKjceKAMEYvHbgr9ZcNdv/jgLbuNfYB0G
   2eRTyYbtDZX8W/7TvuzXq14+kSy6aVnyvWClIYfOaGk7Hwot8M5CblTlu
   OENXxFVtccVslVFUq8r6S07hGNmoOWlSx9c4MHjOqgZP3Wn/3/a+jO9b4
   A=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 16 Jan 2022 04:47:49 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 04:47:49 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 04:47:40 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 16 Jan 2022 04:47:37 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v2 04/19] ath11k: Refactor MSI logic
Date:   Sun, 16 Jan 2022 18:17:00 +0530
Message-ID: <1642337235-8618-5-git-send-email-quic_mpubbise@quicinc.com>
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

Refactor MSI logic in order to support hybrid bus devices
like WCN6750.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h    | 21 ++++++++++++++++
 drivers/net/wireless/ath/ath11k/mhi.c     |  3 +--
 drivers/net/wireless/ath/ath11k/pci.c     | 29 ++++++++++++++--------
 drivers/net/wireless/ath/ath11k/pci.h     | 16 ------------
 drivers/net/wireless/ath/ath11k/pci_cmn.c | 41 ++++++-------------------------
 drivers/net/wireless/ath/ath11k/pci_cmn.h |  5 +---
 6 files changed, 50 insertions(+), 65 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 9e88ccc..bfa2a3a 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH11K_CORE_H
@@ -693,6 +694,19 @@ struct ath11k_soc_dp_stats {
 	struct ath11k_dp_ring_bp_stats bp_stats;
 };
 
+struct ath11k_msi_user {
+	char *name;
+	int num_vectors;
+	u32 base_vector;
+};
+
+struct ath11k_msi_config {
+	int total_vectors;
+	int total_users;
+	struct ath11k_msi_user *users;
+	u16 hw_rev;
+};
+
 /* Master structure to hold the hw data which may be used in core module */
 struct ath11k_base {
 	enum ath11k_hw_rev hw_rev;
@@ -805,6 +819,13 @@ struct ath11k_base {
 		u32 subsystem_device;
 	} id;
 
+	struct {
+		const struct ath11k_msi_config *msi_config;
+		u32 msi_ep_base_data;
+		u32 msi_addr_lo;
+		u32 msi_addr_hi;
+	} msi;
+
 	/* must be last */
 	u8 drv_priv[0] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 21b8cfd..302b303 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -257,8 +257,7 @@ static int ath11k_mhi_get_msi(struct ath11k_pci *ab_pci)
 	int *irq;
 	unsigned int msi_data;
 
-	ret = ath11k_pci_get_user_msi_assignment(ab_pci,
-						 "MHI", &num_vectors,
+	ret = ath11k_pci_get_user_msi_assignment(ab, "MHI", &num_vectors,
 						 &user_base_data, &base_vector);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index f8548f5..a2f3be0 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -309,12 +309,13 @@ static void ath11k_pci_msi_disable(struct ath11k_pci *ab_pci)
 static int ath11k_pci_alloc_msi(struct ath11k_pci *ab_pci)
 {
 	struct ath11k_base *ab = ab_pci->ab;
-	const struct ath11k_msi_config *msi_config = ab_pci->msi_config;
+	const struct ath11k_msi_config *msi_config = ab->msi.msi_config;
+	struct pci_dev *pci_dev = ab_pci->pdev;
 	struct msi_desc *msi_desc;
 	int num_vectors;
 	int ret;
 
-	num_vectors = pci_alloc_irq_vectors(ab_pci->pdev,
+	num_vectors = pci_alloc_irq_vectors(pci_dev,
 					    msi_config->total_vectors,
 					    msi_config->total_vectors,
 					    PCI_IRQ_MSI);
@@ -331,7 +332,7 @@ static int ath11k_pci_alloc_msi(struct ath11k_pci *ab_pci)
 			goto reset_msi_config;
 		}
 		clear_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags);
-		ab_pci->msi_config = &msi_config_one_msi;
+		ab->msi.msi_config = &msi_config_one_msi;
 		ab_pci->irq_flags = IRQF_SHARED | IRQF_NOBALANCING;
 		ath11k_dbg(ab, ATH11K_DBG_PCI, "request MSI one vector\n");
 	}
@@ -346,11 +347,19 @@ static int ath11k_pci_alloc_msi(struct ath11k_pci *ab_pci)
 		goto free_msi_vector;
 	}
 
-	ab_pci->msi_ep_base_data = msi_desc->msg.data;
-	if (msi_desc->msi_attrib.is_64)
-		set_bit(ATH11K_PCI_FLAG_IS_MSI_64, &ab_pci->flags);
+	ab->msi.msi_ep_base_data = msi_desc->msg.data;
+
+	pci_read_config_dword(pci_dev, pci_dev->msi_cap + PCI_MSI_ADDRESS_LO,
+			      &ab->msi.msi_addr_lo);
+
+	if (msi_desc->msi_attrib.is_64) {
+		pci_read_config_dword(pci_dev, pci_dev->msi_cap + PCI_MSI_ADDRESS_HI,
+				      &ab->msi.msi_addr_hi);
+	} else {
+		ab->msi.msi_addr_hi = 0;
+	}
 
-	ath11k_dbg(ab, ATH11K_DBG_PCI, "msi base data is %d\n", ab_pci->msi_ep_base_data);
+	ath11k_dbg(ab, ATH11K_DBG_PCI, "msi base data is %d\n", ab->msi.msi_ep_base_data);
 
 	return 0;
 
@@ -377,10 +386,10 @@ static int ath11k_pci_config_msi_data(struct ath11k_pci *ab_pci)
 		return -EINVAL;
 	}
 
-	ab_pci->msi_ep_base_data = msi_desc->msg.data;
+	ab_pci->ab->msi.msi_ep_base_data = msi_desc->msg.data;
 
 	ath11k_dbg(ab_pci->ab, ATH11K_DBG_PCI, "pci after request_irq msi_ep_base_data %d\n",
-		   ab_pci->msi_ep_base_data);
+		   ab_pci->ab->msi.msi_ep_base_data);
 
 	return 0;
 }
@@ -564,7 +573,7 @@ static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.irq_enable = ath11k_pci_ext_irq_enable,
 	.irq_disable = ath11k_pci_ext_irq_disable,
 	.get_msi_address =  ath11k_pci_get_msi_address,
-	.get_user_msi_vector = ath11k_get_user_msi_assignment,
+	.get_user_msi_vector = ath11k_pci_get_user_msi_assignment,
 	.map_service_to_pipe = ath11k_pci_map_service_to_pipe,
 	.ce_irq_enable = ath11k_pci_hif_ce_irq_enable,
 	.ce_irq_disable = ath11k_pci_hif_ce_irq_disable,
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index 03868f3f..694fcb4 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -53,22 +53,8 @@
 #define WLAON_QFPROM_PWR_CTRL_REG		0x01f8031c
 #define QFPROM_PWR_CTRL_VDD4BLOW_MASK		0x4
 
-struct ath11k_msi_user {
-	char *name;
-	int num_vectors;
-	u32 base_vector;
-};
-
-struct ath11k_msi_config {
-	int total_vectors;
-	int total_users;
-	struct ath11k_msi_user *users;
-	u16 hw_rev;
-};
-
 enum ath11k_pci_flags {
 	ATH11K_PCI_FLAG_INIT_DONE,
-	ATH11K_PCI_FLAG_IS_MSI_64,
 	ATH11K_PCI_ASPM_RESTORE,
 	ATH11K_PCI_FLAG_MULTI_MSI_VECTORS,
 };
@@ -78,9 +64,7 @@ struct ath11k_pci {
 	struct ath11k_base *ab;
 	u16 dev_id;
 	char amss_path[100];
-	u32 msi_ep_base_data;
 	struct mhi_controller *mhi_ctrl;
-	const struct ath11k_msi_config *msi_config;
 	unsigned long mhi_state;
 	u32 register_window;
 
diff --git a/drivers/net/wireless/ath/ath11k/pci_cmn.c b/drivers/net/wireless/ath/ath11k/pci_cmn.c
index b5eca2d..f3142b1 100644
--- a/drivers/net/wireless/ath/ath11k/pci_cmn.c
+++ b/drivers/net/wireless/ath/ath11k/pci_cmn.c
@@ -100,7 +100,6 @@ static const struct ath11k_msi_config ath11k_msi_config[] = {
 
 int ath11k_pci_get_msi_config(struct ath11k_base *ab)
 {
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 	const struct ath11k_msi_config *msi_config;
 	int i;
 
@@ -117,7 +116,7 @@ int ath11k_pci_get_msi_config(struct ath11k_base *ab)
 		return -EINVAL;
 	}
 
-	ab_pci->msi_config = msi_config;
+	ab->msi.msi_config = msi_config;
 	return 0;
 }
 
@@ -251,33 +250,22 @@ int ath11k_pci_get_msi_irq(struct device *dev, unsigned int vector)
 void ath11k_pci_get_msi_address(struct ath11k_base *ab, u32 *msi_addr_lo,
 				u32 *msi_addr_hi)
 {
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
-	struct pci_dev *pci_dev = to_pci_dev(ab->dev);
-
-	pci_read_config_dword(pci_dev, pci_dev->msi_cap + PCI_MSI_ADDRESS_LO,
-			      msi_addr_lo);
-
-	if (test_bit(ATH11K_PCI_FLAG_IS_MSI_64, &ab_pci->flags)) {
-		pci_read_config_dword(pci_dev, pci_dev->msi_cap + PCI_MSI_ADDRESS_HI,
-				      msi_addr_hi);
-	} else {
-		*msi_addr_hi = 0;
-	}
+	*msi_addr_lo = ab->msi.msi_addr_lo;
+	*msi_addr_hi = ab->msi.msi_addr_hi;
 }
 
-int ath11k_pci_get_user_msi_assignment(struct ath11k_pci *ab_pci, char *user_name,
+int ath11k_pci_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
 				       int *num_vectors, u32 *user_base_data,
 				       u32 *base_vector)
 {
-	struct ath11k_base *ab = ab_pci->ab;
-	const struct ath11k_msi_config *msi_config = ab_pci->msi_config;
+	const struct ath11k_msi_config *msi_config = ab->msi.msi_config;
 	int idx;
 
 	for (idx = 0; idx < msi_config->total_users; idx++) {
 		if (strcmp(user_name, msi_config->users[idx].name) == 0) {
 			*num_vectors = msi_config->users[idx].num_vectors;
 			*base_vector =  msi_config->users[idx].base_vector;
-			*user_base_data = *base_vector + ab_pci->msi_ep_base_data;
+			*user_base_data = *base_vector + ab->msi.msi_ep_base_data;
 
 			ath11k_dbg(ab, ATH11K_DBG_PCI,
 				   "Assign MSI to user: %s, num_vectors: %d, user_base_data: %u, base_vector: %u\n",
@@ -309,17 +297,6 @@ void ath11k_pci_get_ce_msi_idx(struct ath11k_base *ab, u32 ce_id, u32 *msi_idx)
 	*msi_idx = msi_data_idx;
 }
 
-int ath11k_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
-				   int *num_vectors, u32 *user_base_data,
-				   u32 *base_vector)
-{
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
-
-	return ath11k_pci_get_user_msi_assignment(ab_pci, user_name,
-						  num_vectors, user_base_data,
-						  base_vector);
-}
-
 static void ath11k_pci_free_ext_irq(struct ath11k_base *ab)
 {
 	int i, j;
@@ -570,8 +547,7 @@ static int ath11k_pci_ext_irq_config(struct ath11k_base *ab)
 	int i, j, ret, num_vectors = 0;
 	u32 user_base_data = 0, base_vector = 0;
 
-	ret = ath11k_pci_get_user_msi_assignment(ath11k_pci_priv(ab), "DP",
-						 &num_vectors,
+	ret = ath11k_pci_get_user_msi_assignment(ab, "DP", &num_vectors,
 						 &user_base_data,
 						 &base_vector);
 	if (ret < 0)
@@ -646,8 +622,7 @@ int ath11k_pci_config_irq(struct ath11k_base *ab)
 	unsigned int msi_data;
 	int irq, i, ret, irq_idx;
 
-	ret = ath11k_pci_get_user_msi_assignment(ath11k_pci_priv(ab),
-						 "CE", &msi_data_count,
+	ret = ath11k_pci_get_user_msi_assignment(ab, "CE", &msi_data_count,
 						 &msi_data_start, &msi_irq_start);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/ath/ath11k/pci_cmn.h b/drivers/net/wireless/ath/ath11k/pci_cmn.h
index f5916da..cc78c23 100644
--- a/drivers/net/wireless/ath/ath11k/pci_cmn.h
+++ b/drivers/net/wireless/ath/ath11k/pci_cmn.h
@@ -25,7 +25,7 @@
  */
 #define ATH11K_PCI_ACCESS_ALWAYS_OFF 0xFE0
 
-int ath11k_pci_get_user_msi_assignment(struct ath11k_pci *ar_pci, char *user_name,
+int ath11k_pci_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
 				       int *num_vectors, u32 *user_base_data,
 				       u32 *base_vector);
 int ath11k_pci_get_msi_irq(struct device *dev, unsigned int vector);
@@ -44,9 +44,6 @@ int ath11k_pci_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
 				   u8 *ul_pipe, u8 *dl_pipe);
 void ath11k_pci_ce_irqs_enable(struct ath11k_base *ab);
 void ath11k_pci_ce_irq_disable_sync(struct ath11k_base *ab);
-int ath11k_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
-				   int *num_vectors, u32 *user_base_data,
-				   u32 *base_vector);
 void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci);
 int ath11k_pci_set_irq_affinity_hint(struct ath11k_pci *ab_pci,
 				     const struct cpumask *m);
-- 
2.7.4

