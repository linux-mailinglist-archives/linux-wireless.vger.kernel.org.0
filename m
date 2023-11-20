Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354407F1012
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Nov 2023 11:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjKTKQS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 05:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbjKTKQP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 05:16:15 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AC2BA
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 02:16:11 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK9pjUq031180;
        Mon, 20 Nov 2023 10:16:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=zmuLYR7XU4q8B5/Ln7gzr65vRBEdvEqWyRLkKYCaNn4=;
 b=SDTyf9mgOSHJdROs/i0Ivd7NkAX/8WnVMDO+LkYg0dcn4pcqXIq5qDlzA5X9KxX4iCV8
 C7nZ97R1CLy/7itphfJma5+HWhmNdnxUTQnfjG0EZVVh5SEU6sZtqJG/aEe5DaLkCLnt
 R5fFXWAHyQJ3wNmj2FK7rEjcEhCoG2mEUL0P5HGgioCcvW97TTovYfkmMrMddSoqhYmm
 /dLZErbkWX5nLQHVo7nZYL/Rzu33Q1zdm44vb6p9aMEcyUPvTLgrlai1MPmmE1233+/z
 7kgfN6zVsAj8s+X2mkkbDxzwE43CRhLSU/6rQNTyhzA+A+Hvix/hI1YnA0lI9rU10kno ig== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uejmuuvsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 10:16:05 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AKAG4nS023650
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Nov 2023 10:16:04 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 20 Nov 2023 02:16:02 -0800
From:   Kang Yang <quic_kangyang@quicinc.com>
To:     <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 4/7] wifi: ath12k: refactor multiple MSI vector implementation
Date:   Mon, 20 Nov 2023 18:15:40 +0800
Message-ID: <20231120101543.4369-5-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120101543.4369-1-quic_kangyang@quicinc.com>
References: <20231120101543.4369-1-quic_kangyang@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Rvz6hl8YCJjhwah_tscytVY3P15RYY-K
X-Proofpoint-ORIG-GUID: Rvz6hl8YCJjhwah_tscytVY3P15RYY-K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_08,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200068
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is to prepare for one MSI vector support. IRQ enable and disable
of CE and DP are done only in case of multiple MSI vectors.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/pci.c | 48 ++++++++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/pci.h |  2 ++
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 4b872eff087c..3bb2d622dc52 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -356,16 +356,30 @@ static void ath12k_pci_free_irq(struct ath12k_base *ab)
 
 static void ath12k_pci_ce_irq_enable(struct ath12k_base *ab, u16 ce_id)
 {
+	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
 	u32 irq_idx;
 
+	/* In case of one MSI vector, we handle irq enable/disable in a
+	 * uniform way since we only have one irq
+	 */
+	if (!test_bit(ATH12K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+		return;
+
 	irq_idx = ATH12K_PCI_IRQ_CE0_OFFSET + ce_id;
 	enable_irq(ab->irq_num[irq_idx]);
 }
 
 static void ath12k_pci_ce_irq_disable(struct ath12k_base *ab, u16 ce_id)
 {
+	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
 	u32 irq_idx;
 
+	/* In case of one MSI vector, we handle irq enable/disable in a
+	 * uniform way since we only have one irq
+	 */
+	if (!test_bit(ATH12K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+		return;
+
 	irq_idx = ATH12K_PCI_IRQ_CE0_OFFSET + ce_id;
 	disable_irq_nosync(ab->irq_num[irq_idx]);
 }
@@ -425,8 +439,15 @@ static irqreturn_t ath12k_pci_ce_interrupt_handler(int irq, void *arg)
 
 static void ath12k_pci_ext_grp_disable(struct ath12k_ext_irq_grp *irq_grp)
 {
+	struct ath12k_pci *ab_pci = ath12k_pci_priv(irq_grp->ab);
 	int i;
 
+	/* In case of one MSI vector, we handle irq enable/disable
+	 * in a uniform way since we only have one irq
+	 */
+	if (!test_bit(ATH12K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+		return;
+
 	for (i = 0; i < irq_grp->num_irq; i++)
 		disable_irq_nosync(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
 }
@@ -449,8 +470,15 @@ static void __ath12k_pci_ext_irq_disable(struct ath12k_base *ab)
 
 static void ath12k_pci_ext_grp_enable(struct ath12k_ext_irq_grp *irq_grp)
 {
+	struct ath12k_pci *ab_pci = ath12k_pci_priv(irq_grp->ab);
 	int i;
 
+	/* In case of one MSI vector, we handle irq enable/disable in a
+	 * uniform way since we only have one irq
+	 */
+	if (!test_bit(ATH12K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags))
+		return;
+
 	for (i = 0; i < irq_grp->num_irq; i++)
 		enable_irq(irq_grp->ab->irq_num[irq_grp->irqs[i]]);
 }
@@ -511,6 +539,7 @@ static irqreturn_t ath12k_pci_ext_interrupt_handler(int irq, void *arg)
 
 static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
 {
+	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
 	int i, j, ret, num_vectors = 0;
 	u32 user_base_data = 0, base_vector = 0;
 
@@ -556,16 +585,15 @@ static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
 
 			irq_set_status_flags(irq, IRQ_DISABLE_UNLAZY);
 			ret = request_irq(irq, ath12k_pci_ext_interrupt_handler,
-					  IRQF_SHARED,
+					  ab_pci->irq_flags,
 					  "DP_EXT_IRQ", irq_grp);
 			if (ret) {
 				ath12k_err(ab, "failed request irq %d: %d\n",
 					   vector, ret);
 				return ret;
 			}
-
-			disable_irq_nosync(ab->irq_num[irq_idx]);
 		}
+		ath12k_pci_ext_grp_disable(irq_grp);
 	}
 
 	return 0;
@@ -573,6 +601,7 @@ static int ath12k_pci_ext_irq_config(struct ath12k_base *ab)
 
 static int ath12k_pci_config_irq(struct ath12k_base *ab)
 {
+	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
 	struct ath12k_ce_pipe *ce_pipe;
 	u32 msi_data_start;
 	u32 msi_data_count, msi_data_idx;
@@ -601,7 +630,7 @@ static int ath12k_pci_config_irq(struct ath12k_base *ab)
 		tasklet_setup(&ce_pipe->intr_tq, ath12k_pci_ce_tasklet);
 
 		ret = request_irq(irq, ath12k_pci_ce_interrupt_handler,
-				  IRQF_SHARED, irq_name[irq_idx],
+				  ab_pci->irq_flags, irq_name[irq_idx],
 				  ce_pipe);
 		if (ret) {
 			ath12k_err(ab, "failed to request irq %d: %d\n",
@@ -692,6 +721,9 @@ static int ath12k_pci_msi_alloc(struct ath12k_pci *ab_pci)
 			return -EINVAL;
 		else
 			return num_vectors;
+	} else {
+		set_bit(ATH12K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags);
+		ab_pci->irq_flags = IRQF_SHARED;
 	}
 
 	ath12k_pci_msi_disable(ab_pci);
@@ -924,11 +956,11 @@ int ath12k_pci_get_user_msi_assignment(struct ath12k_base *ab, char *user_name,
 	for (idx = 0; idx < msi_config->total_users; idx++) {
 		if (strcmp(user_name, msi_config->users[idx].name) == 0) {
 			*num_vectors = msi_config->users[idx].num_vectors;
-			*user_base_data = msi_config->users[idx].base_vector
-				+ ab_pci->msi_ep_base_data;
-			*base_vector = msi_config->users[idx].base_vector;
+			*base_vector =  msi_config->users[idx].base_vector;
+			*user_base_data = *base_vector + ab_pci->msi_ep_base_data;
 
-			ath12k_dbg(ab, ATH12K_DBG_PCI, "Assign MSI to user: %s, num_vectors: %d, user_base_data: %u, base_vector: %u\n",
+			ath12k_dbg(ab, ATH12K_DBG_PCI,
+				   "Assign MSI to user: %s, num_vectors: %d, user_base_data: %u, base_vector: %u\n",
 				   user_name, *num_vectors, *user_base_data,
 				   *base_vector);
 
diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
index 0f24fd9395cd..db32676fec50 100644
--- a/drivers/net/wireless/ath/ath12k/pci.h
+++ b/drivers/net/wireless/ath/ath12k/pci.h
@@ -84,6 +84,7 @@ enum ath12k_pci_flags {
 	ATH12K_PCI_FLAG_INIT_DONE,
 	ATH12K_PCI_FLAG_IS_MSI_64,
 	ATH12K_PCI_ASPM_RESTORE,
+	ATH12K_PCI_FLAG_MULTI_MSI_VECTORS,
 };
 
 struct ath12k_pci_ops {
@@ -108,6 +109,7 @@ struct ath12k_pci {
 	/* enum ath12k_pci_flags */
 	unsigned long flags;
 	u16 link_ctl;
+	unsigned long irq_flags;
 	const struct ath12k_pci_ops *pci_ops;
 };
 
-- 
2.34.1

