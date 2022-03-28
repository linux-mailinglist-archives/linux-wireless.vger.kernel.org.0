Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628594E8DA3
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Mar 2022 07:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238194AbiC1F70 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Mar 2022 01:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiC1F7Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Mar 2022 01:59:24 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B47151584
        for <linux-wireless@vger.kernel.org>; Sun, 27 Mar 2022 22:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648447065; x=1679983065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=93Bkt8yN2Yi4EfTLh9I87JFjQSNdnYmuUNO/BJ0pbiw=;
  b=oeBVVUnuD07KWxwbl19EQjmLdKun43A4O3WaxhcPo/+meY6K2JzI1Jti
   8ZnPp2ITIfuMjQEf2R+zFhOHFgeA0zSyR2VSUe8jb/IkHQREec+Ggf1Zw
   TC/g6VonN5+QKNjCRMLh3RBOjqsUTfqWJ08r6SnB/m/w37kKd2/IylZnL
   s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 27 Mar 2022 22:57:45 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 22:57:45 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 27 Mar 2022 22:57:44 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 27 Mar 2022 22:57:42 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v3 3/5] ath11k: Choose MSI config based on HW revision
Date:   Mon, 28 Mar 2022 11:27:12 +0530
Message-ID: <20220328055714.6449-4-quic_mpubbise@quicinc.com>
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

Instead of selecting MSI config based on magic numbers, make
the assignment based on HW revision. The logic is similar to
the selection of HW params. This improves readability of the
code and also simplifies new additions.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/pci.c  | 31 +++---------
 drivers/net/wireless/ath/ath11k/pci.h  |  1 +
 drivers/net/wireless/ath/ath11k/pcic.c | 70 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/pcic.h |  1 +
 4 files changed, 78 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index bffbcace63ae..ab6572b14937 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -43,28 +43,6 @@ static const struct ath11k_bus_params ath11k_pci_bus_params = {
 	.fixed_mem_region = false,
 };
 
-static const struct ath11k_msi_config ath11k_msi_config[] = {
-	{
-		.total_vectors = 32,
-		.total_users = 4,
-		.users = (struct ath11k_msi_user[]) {
-			{ .name = "MHI", .num_vectors = 3, .base_vector = 0 },
-			{ .name = "CE", .num_vectors = 10, .base_vector = 3 },
-			{ .name = "WAKE", .num_vectors = 1, .base_vector = 13 },
-			{ .name = "DP", .num_vectors = 18, .base_vector = 14 },
-		},
-	},
-	{
-		.total_vectors = 16,
-		.total_users = 3,
-		.users = (struct ath11k_msi_user[]) {
-			{ .name = "MHI", .num_vectors = 3, .base_vector = 0 },
-			{ .name = "CE", .num_vectors = 5, .base_vector = 3 },
-			{ .name = "DP", .num_vectors = 8, .base_vector = 8 },
-		},
-	},
-};
-
 static const struct ath11k_msi_config msi_config_one_msi = {
 	.total_vectors = 1,
 	.total_users = 4,
@@ -667,10 +645,8 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 			ret = -EOPNOTSUPP;
 			goto err_pci_free_region;
 		}
-		ab_pci->msi_config = &ath11k_msi_config[0];
 		break;
 	case QCN9074_DEVICE_ID:
-		ab_pci->msi_config = &ath11k_msi_config[1];
 		ab->bus_params.static_window_map = true;
 		ab->hw_rev = ATH11K_HW_QCN9074_HW10;
 		break;
@@ -700,7 +676,6 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 			ret = -EOPNOTSUPP;
 			goto err_pci_free_region;
 		}
-		ab_pci->msi_config = &ath11k_msi_config[0];
 		break;
 	default:
 		dev_err(&pdev->dev, "Unknown PCI device found: 0x%x\n",
@@ -709,6 +684,12 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		goto err_pci_free_region;
 	}
 
+	ret = ath11k_pcic_init_msi_config(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to init msi config: %d\n", ret);
+		goto err_pci_free_region;
+	}
+
 	ret = ath11k_pci_alloc_msi(ab_pci);
 	if (ret) {
 		ath11k_err(ab, "failed to enable msi: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index 038e4152987c..7e225de6eb6e 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -63,6 +63,7 @@ struct ath11k_msi_config {
 	int total_vectors;
 	int total_users;
 	struct ath11k_msi_user *users;
+	u16 hw_rev;
 };
 
 enum ath11k_pci_flags {
diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
index 391c308455e5..eab153453106 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.c
+++ b/drivers/net/wireless/ath/ath11k/pcic.c
@@ -63,6 +63,76 @@ static const char *irq_name[ATH11K_IRQ_NUM_MAX] = {
 	"tcl2host-status-ring",
 };
 
+static const struct ath11k_msi_config ath11k_msi_config[] = {
+	{
+		.total_vectors = 32,
+		.total_users = 4,
+		.users = (struct ath11k_msi_user[]) {
+			{ .name = "MHI", .num_vectors = 3, .base_vector = 0 },
+			{ .name = "CE", .num_vectors = 10, .base_vector = 3 },
+			{ .name = "WAKE", .num_vectors = 1, .base_vector = 13 },
+			{ .name = "DP", .num_vectors = 18, .base_vector = 14 },
+		},
+		.hw_rev = ATH11K_HW_QCA6390_HW20,
+	},
+	{
+		.total_vectors = 16,
+		.total_users = 3,
+		.users = (struct ath11k_msi_user[]) {
+			{ .name = "MHI", .num_vectors = 3, .base_vector = 0 },
+			{ .name = "CE", .num_vectors = 5, .base_vector = 3 },
+			{ .name = "DP", .num_vectors = 8, .base_vector = 8 },
+		},
+		.hw_rev = ATH11K_HW_QCN9074_HW10,
+	},
+	{
+		.total_vectors = 32,
+		.total_users = 4,
+		.users = (struct ath11k_msi_user[]) {
+			{ .name = "MHI", .num_vectors = 3, .base_vector = 0 },
+			{ .name = "CE", .num_vectors = 10, .base_vector = 3 },
+			{ .name = "WAKE", .num_vectors = 1, .base_vector = 13 },
+			{ .name = "DP", .num_vectors = 18, .base_vector = 14 },
+		},
+		.hw_rev = ATH11K_HW_WCN6855_HW20,
+	},
+	{
+		.total_vectors = 32,
+		.total_users = 4,
+		.users = (struct ath11k_msi_user[]) {
+			{ .name = "MHI", .num_vectors = 3, .base_vector = 0 },
+			{ .name = "CE", .num_vectors = 10, .base_vector = 3 },
+			{ .name = "WAKE", .num_vectors = 1, .base_vector = 13 },
+			{ .name = "DP", .num_vectors = 18, .base_vector = 14 },
+		},
+		.hw_rev = ATH11K_HW_WCN6855_HW21,
+	},
+};
+
+int ath11k_pcic_init_msi_config(struct ath11k_base *ab)
+{
+	struct ath11k_pci *ab_pci = ath11k_pci_priv(ab);
+	const struct ath11k_msi_config *msi_config;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ath11k_msi_config); i++) {
+		msi_config = &ath11k_msi_config[i];
+
+		if (msi_config->hw_rev == ab->hw_rev)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(ath11k_msi_config)) {
+		ath11k_err(ab, "failed to fetch msi config, unsupported hw version: 0x%x\n",
+			   ab->hw_rev);
+		return -EINVAL;
+	}
+
+	ab_pci->msi_config = msi_config;
+	return 0;
+}
+EXPORT_SYMBOL(ath11k_pcic_init_msi_config);
+
 void ath11k_pcic_aspm_restore(struct ath11k_pci *ab_pci)
 {
 	if (test_and_clear_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags))
diff --git a/drivers/net/wireless/ath/ath11k/pcic.h b/drivers/net/wireless/ath/ath11k/pcic.h
index 6780f7e8bc64..d5fe315ccc61 100644
--- a/drivers/net/wireless/ath/ath11k/pcic.h
+++ b/drivers/net/wireless/ath/ath11k/pcic.h
@@ -50,4 +50,5 @@ int ath11k_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
 void ath11k_pcic_aspm_restore(struct ath11k_pci *ab_pci);
 int ath11k_pcic_set_irq_affinity_hint(struct ath11k_pci *ab_pci,
 				      const struct cpumask *m);
+int ath11k_pcic_init_msi_config(struct ath11k_base *ab);
 #endif
-- 
2.35.1

