Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB1845ABB0
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 19:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhKWSye (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 13:54:34 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:14975 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234945AbhKWSyd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 13:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637693485; x=1669229485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=1RGGbVZs52LjJ0RqBdeOPodHGXwHW8aIFGnGwVCjCu0=;
  b=ttiQb0xK6lSePdjAGiZiecQmxu6okgMzC3qZm/mze83D2J2L5YrEA7mt
   QnfjElDKHAKn8D1iRYCXApPVSBYccWe+zWp4oNKdziiS7zqIvkiaJcFPO
   kfGcqp70UWx5yRGGeJ5jxY90DXDX0WrWJbJVnN4jfayoujJJBrA2WjChc
   U=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Nov 2021 10:51:24 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 10:51:24 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 10:51:23 -0800
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 23 Nov 2021 10:51:21 -0800
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH 03/19] ath11k: Choose MSI config based on HW revision
Date:   Wed, 24 Nov 2021 00:20:18 +0530
Message-ID: <1637693434-15462-4-git-send-email-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637693434-15462-1-git-send-email-quic_mpubbise@quicinc.com>
References: <1637693434-15462-1-git-send-email-quic_mpubbise@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Instead of selecting MSI config based on magic numbers, make
the assignment based on HW revision. The logic is similar to
the selection of HW params. This improves readability of the
code and also simplifies new additions.

Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00573-QCAMSLSWPLZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1

Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/pci.c     | 31 ++++-------------
 drivers/net/wireless/ath/ath11k/pci.h     |  1 +
 drivers/net/wireless/ath/ath11k/pci_cmn.c | 58 +++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/pci_cmn.h |  1 +
 4 files changed, 66 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index d1f62cf..a53de6c 100644
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
@@ -659,10 +637,8 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
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
@@ -680,7 +656,6 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 			ret = -EOPNOTSUPP;
 			goto err_pci_free_region;
 		}
-		ab_pci->msi_config = &ath11k_msi_config[0];
 		break;
 	default:
 		dev_err(&pdev->dev, "Unknown PCI device found: 0x%x\n",
@@ -689,6 +664,12 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		goto err_pci_free_region;
 	}
 
+	ret = ath11k_pci_get_msi_config(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to fetch msi config: %d\n", ret);
+		goto err_pci_free_region;
+	}
+
 	ret = ath11k_pci_alloc_msi(ab_pci);
 	if (ret) {
 		ath11k_err(ab, "failed to enable msi: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index 35c8152..03868f3f 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -63,6 +63,7 @@ struct ath11k_msi_config {
 	int total_vectors;
 	int total_users;
 	struct ath11k_msi_user *users;
+	u16 hw_rev;
 };
 
 enum ath11k_pci_flags {
diff --git a/drivers/net/wireless/ath/ath11k/pci_cmn.c b/drivers/net/wireless/ath/ath11k/pci_cmn.c
index 976b676..5c32322 100644
--- a/drivers/net/wireless/ath/ath11k/pci_cmn.c
+++ b/drivers/net/wireless/ath/ath11k/pci_cmn.c
@@ -63,6 +63,64 @@ static const char *irq_name[ATH11K_IRQ_NUM_MAX] = {
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
+};
+
+int ath11k_pci_get_msi_config(struct ath11k_base *ab)
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
+
 void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci)
 {
 	if (test_and_clear_bit(ATH11K_PCI_ASPM_RESTORE, &ab_pci->flags))
diff --git a/drivers/net/wireless/ath/ath11k/pci_cmn.h b/drivers/net/wireless/ath/ath11k/pci_cmn.h
index 5fb1cf1..f5916da 100644
--- a/drivers/net/wireless/ath/ath11k/pci_cmn.h
+++ b/drivers/net/wireless/ath/ath11k/pci_cmn.h
@@ -50,4 +50,5 @@ int ath11k_get_user_msi_assignment(struct ath11k_base *ab, char *user_name,
 void ath11k_pci_aspm_restore(struct ath11k_pci *ab_pci);
 int ath11k_pci_set_irq_affinity_hint(struct ath11k_pci *ab_pci,
 				     const struct cpumask *m);
+int ath11k_pci_get_msi_config(struct ath11k_base *ab);
 #endif
-- 
2.7.4

