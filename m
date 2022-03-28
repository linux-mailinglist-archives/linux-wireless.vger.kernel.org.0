Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72BB4E8DA5
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Mar 2022 07:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbiC1F7e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Mar 2022 01:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238192AbiC1F7c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Mar 2022 01:59:32 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FF951597
        for <linux-wireless@vger.kernel.org>; Sun, 27 Mar 2022 22:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648447070; x=1679983070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=amRIyXF0/Bv4AUdQFYap0bBKCa41f/bFsyNp9oz9pYw=;
  b=U1Mbb7dR2ly3jupY4MYmrFdiRoxBerbsExHOfUeQAszMcGKjnKh4tXkE
   7UYgxJ1cIS4oSf1Ty1UF1BwnBCnbofTIt73tefHiQT6i9itzHcUBcvJuP
   zTnLt+6/bKhPplGY2r4LXxBD2/2pAsh2AXQ0j+p+UpsyLeOigh/QuLnUY
   I=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Mar 2022 22:57:50 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 22:57:46 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 27 Mar 2022 22:57:46 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 27 Mar 2022 22:57:44 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v3 4/5] ath11k: Refactor MSI logic to support WCN6750
Date:   Mon, 28 Mar 2022 11:27:13 +0530
Message-ID: <20220328055714.6449-5-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328055714.6449-1-quic_mpubbise@quicinc.com>
References: <20220328055714.6449-1-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Refactor MSI logic in order to support hybrid bus devices
like WCN6750.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h | 22 ++++++++++++++
 drivers/net/wireless/ath/ath11k/mhi.c  |  3 +-
 drivers/net/wireless/ath/ath11k/pci.c  | 29 +++++++++++-------
 drivers/net/wireless/ath/ath11k/pci.h  | 16 ----------
 drivers/net/wireless/ath/ath11k/pcic.c | 41 +++++---------------------
 drivers/net/wireless/ath/ath11k/pcic.h |  5 +---
 6 files changed, 51 insertions(+), 65 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 41001ec174e2..64f119e6882f 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -761,6 +761,19 @@ struct ath11k_soc_dp_stats {
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
@@ -897,6 +910,15 @@ struct ath11k_base {
 		u32 subsystem_device;
 	} id;
 
+	struct {
+		struct {
+			const struct ath11k_msi_config *config;
+			u32 ep_base_data;
+			u32 addr_lo;
+			u32 addr_hi;
+		} msi;
+	} pci;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath11k/mhi.c b/drivers/net/wireless/ath/ath11k/mhi.c
index 3724eebba4a2..5de255969364 100644
--- a/drivers/net/wireless/ath/ath11k/mhi.c
+++ b/drivers/net/wireless/ath/ath11k/mhi.c
@@ -258,8 +258,7 @@ static int ath11k_mhi_get_msi(struct ath11k_pci *ab_pci)
 	int *irq;
 	unsigned int msi_data;
 
-	ret = ath11k_pcic_get_user_msi_assignment(ab_pci,
-						  "MHI", &num_vectors,
+	ret = ath11k_pcic_get_user_msi_assignment(ab, "MHI", &num_vectors,
 						  &user_base_data, &base_vector);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index ab6572b14937..fd5487d7045e 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -307,12 +307,13 @@ static void ath11k_pci_msi_disable(struct ath11k_pci *ab_pci)
 static int ath11k_pci_alloc_msi(struct ath11k_pci *ab_pci)
 {
 	struct ath11k_base *ab = ab_pci->ab;
-	const struct ath11k_msi_config *msi_config = ab_pci->msi_config;
+	const struct ath11k_msi_config *msi_config = ab->pci.msi.config;
+	struct pci_dev *pci_dev = ab_pci->pdev;
 	struct msi_desc *msi_desc;
 	int num_vectors;
 	int ret;
 
-	num_vectors = pci_alloc_irq_vectors(ab_pci->pdev,
+	num_vectors = pci_alloc_irq_vectors(pci_dev,
 					    msi_config->total_vectors,
 					    msi_config->total_vectors,
 					    PCI_IRQ_MSI);
@@ -329,7 +330,7 @@ static int ath11k_pci_alloc_msi(struct ath11k_pci *ab_pci)
 			goto reset_msi_config;
 		}
 		clear_bit(ATH11K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags);
-		ab_pci->msi_config = &msi_config_one_msi;
+		ab->pci.msi.config = &msi_config_one_msi;
 		ab_pci->irq_flags = IRQF_SHARED | IRQF_NOBALANCING;
 		ath11k_dbg(ab, ATH11K_DBG_PCI, "request MSI one vector\n");
 	}
@@ -344,11 +345,19 @@ static int ath11k_pci_alloc_msi(struct ath11k_pci *ab_pci)
 		goto free_msi_vector;
 	}
 
-	ab_pci->msi_ep_base_data = msi_desc->msg.data;
-	if (msi_desc->pci.msi_attrib.is_64)
-		set_bit(ATH11K_PCI_FLAG_IS_MSI_64, &ab_pci->flags);
+	ab->pci.msi.ep_base_data = msi_desc->msg.data;
+
+	pci_read_config_dword(pci_dev, pci_dev->msi_cap + PCI_MSI_ADDRESS_LO,
+			      &ab->pci.msi.addr_lo);
+
+	if (msi_desc->pci.msi_attrib.is_64) {
+		pci_read_config_dword(pci_dev, pci_dev->msi_cap + PCI_MSI_ADDRESS_HI,
+				      &ab->pci.msi.addr_hi);
+	} else {
+		ab->pci.msi.addr_hi = 0;
+	}
 
-	ath11k_dbg(ab, ATH11K_DBG_PCI, "msi base data is %d\n", ab_pci->msi_ep_base_data);
+	ath11k_dbg(ab, ATH11K_DBG_PCI, "msi base data is %d\n", ab->pci.msi.ep_base_data);
 
 	return 0;
 
@@ -375,10 +384,10 @@ static int ath11k_pci_config_msi_data(struct ath11k_pci *ab_pci)
 		return -EINVAL;
 	}
 
-	ab_pci->msi_ep_base_data = msi_desc->msg.data;
+	ab_pci->ab->pci.msi.ep_base_data = msi_desc->msg.data;
 
 	ath11k_dbg(ab_pci->ab, ATH11K_DBG_PCI, "pci after request_irq msi_ep_base_data %d\n",
-		   ab_pci->msi_ep_base_data);
+		   ab_pci->ab->pci.msi.ep_base_data);
 
 	return 0;
 }
@@ -562,7 +571,7 @@ static const struct ath11k_hif_ops ath11k_pci_hif_ops = {
 	.irq_enable = ath11k_pcic_ext_irq_enable,
 	.irq_disable = ath11k_pcic_ext_irq_disable,
 	.get_msi_address =  ath11k_pcic_get_msi_address,
-	.get_user_msi_vector = ath11k_get_user_msi_assignment,
+	.get_user_msi_vector = ath11k_pcic_get_user_msi_assignment,
 	.map_service_to_pipe = ath11k_pcic_map_service_to_pipe,
 	.ce_irq_enable = ath11k_pci_hif_ce_irq_enable,
 	.ce_irq_disable = ath11k_pci_hif_ce_irq_disable,
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index 7e225de6eb6e..c9cae48d784e 100644
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
 
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index eab153453106..c743095387f1 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -111,7 +111,6 @@ static const struct ath11k_msi_config ath11k_msi_config[] = {
 
 int ath11k_pcic_init_msi_config(struct ath11k_base *ab)
 {
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
 	const struct ath11k_msi_config *msi_config;
 	int i;
 
@@ -128,7 +127,7 @@ int ath11k_pcic_init_msi_config(struct ath11k_base *ab)
 		return -EINVAL;
 	}
 
-	ab_pci->msi_config = msi_config;
+	ab->pci.msi.config = msi_config;
 	return 0;
 }
 EXPORT_SYMBOL(ath11k_pcic_init_msi_config);
@@ -267,33 +266,22 @@ int ath11k_pcic_get_msi_irq(struct device *dev, unsigned int vector)
 void ath11k_pcic_get_msi_address(struct ath11k_base *ab, u32 *msi_addr_lo,
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
+	*msi_addr_lo = ab->pci.msi.addr_lo;
+	*msi_addr_hi = ab->pci.msi.addr_hi;
 }
 
-int ath11k_pcic_get_user_msi_assignment(struct ath11k_pci *ab_pci, char *user_name,
+int ath11k_pcic_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
 					int *num_vectors, u32 *user_base_data,
 					u32 *base_vector)
 {
-	struct ath11k_base *ab = ab_pci->ab;
-	const struct ath11k_msi_config *msi_config = ab_pci->msi_config;
+	const struct ath11k_msi_config *msi_config = ab->pci.msi.config;
 	int idx;
 
 	for (idx = 0; idx < msi_config->total_users; idx++) {
 		if (strcmp(user_name, msi_config->users[idx].name) == 0) {
 			*num_vectors = msi_config->users[idx].num_vectors;
 			*base_vector =  msi_config->users[idx].base_vector;
-			*user_base_data = *base_vector + ab_pci->msi_ep_base_data;
+			*user_base_data = *base_vector + ab->pci.msi.ep_base_data;
 
 			ath11k_dbg(ab, ATH11K_DBG_PCI,
 				   "Assign MSI to user: %s, num_vectors: %d, user_base_data: %u, base_vector: %u\n",
@@ -325,17 +313,6 @@ void ath11k_pcic_get_ce_msi_idx(struct ath11k_base *ab, u32 ce_id, u32 *msi_idx)
 	*msi_idx = msi_data_idx;
 }
 
-int ath11k_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
-				   int *num_vectors, u32 *user_base_data,
-				   u32 *base_vector)
-{
-	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
-
-	return ath11k_pcic_get_user_msi_assignment(ab_pci, user_name,
-						   num_vectors, user_base_data,
-						   base_vector);
-}
-
 static void ath11k_pcic_free_ext_irq(struct ath11k_base *ab)
 {
 	int i, j;
@@ -586,8 +563,7 @@ static int ath11k_pcic_ext_irq_config(struct ath11k_base *ab)
 	int i, j, ret, num_vectors = 0;
 	u32 user_base_data = 0, base_vector = 0;
 
-	ret = ath11k_pcic_get_user_msi_assignment(ath11k_pci_priv(ab), "DP",
-						  &num_vectors,
+	ret = ath11k_pcic_get_user_msi_assignment(ab, "DP", &num_vectors,
 						  &user_base_data,
 						  &base_vector);
 	if (ret < 0)
@@ -662,8 +638,7 @@ int ath11k_pcic_config_irq(struct ath11k_base *ab)
 	unsigned int msi_data;
 	int irq, i, ret, irq_idx;
 
-	ret = ath11k_pcic_get_user_msi_assignment(ath11k_pci_priv(ab),
-						  "CE", &msi_data_count,
+	ret = ath11k_pcic_get_user_msi_assignment(ab, "CE", &msi_data_count,
 						  &msi_data_start, &msi_irq_start);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/ath/ath11k/pcic.h b/drivers/net/wireless/ath/ath11k/pcic.h
index d5fe315ccc61..34e8c069d6e4 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.h
+++ b/drivers/net/wireless/ath/ath11k/pcic.h
@@ -25,7 +25,7 @@
  */
 #define ATH11K_PCI_ACCESS_ALWAYS_OFF 0xFE0
 
-int ath11k_pcic_get_user_msi_assignment(struct ath11k_pci *ar_pci, char *user_name,
+int ath11k_pcic_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
 					int *num_vectors, u32 *user_base_data,
 					u32 *base_vector);
 int ath11k_pcic_get_msi_irq(struct device *dev, unsigned int vector);
@@ -44,9 +44,6 @@ int ath11k_pcic_map_service_to_pipe(struct ath11k_base *ab, u16 service_id,
 				    u8 *ul_pipe, u8 *dl_pipe);
 void ath11k_pcic_ce_irqs_enable(struct ath11k_base *ab);
 void ath11k_pcic_ce_irq_disable_sync(struct ath11k_base *ab);
-int ath11k_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
-				   int *num_vectors, u32 *user_base_data,
-				   u32 *base_vector);
 void ath11k_pcic_aspm_restore(struct ath11k_pci *ab_pci);
 int ath11k_pcic_set_irq_affinity_hint(struct ath11k_pci *ab_pci,
 				      const struct cpumask *m);
-- 
2.35.1

