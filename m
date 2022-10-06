Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2425F64B8
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Oct 2022 13:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiJFLAu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Oct 2022 07:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiJFLA3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Oct 2022 07:00:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B564B87F
        for <linux-wireless@vger.kernel.org>; Thu,  6 Oct 2022 04:00:27 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296AoNIT023226;
        Thu, 6 Oct 2022 11:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=IWS00yMq7XwvVSnsAIGBCQCIWyANxhERAPJMxYFRQC0=;
 b=K8wL8xIYzhcajEBsVTfY/gca2po/MPYJ4xkRLIF0OCIVDbukdhHIwjOuyfBFaAmsRjZC
 WC3Jc3aM0onhEqKIy7ZVxjio4dwLuIvgncTJOdSBHuythT3aQcgcHpW5a/xJ7dkevraI
 VgV1zKygH/2nGFN3TJzOLY0Xtw2+icikL5uSNyYQ3U7OE8MtNPHjeWL+B2PoY65rSHqh
 e5qPzUTg7gueDW5BjML3WdG8Evy5Zrm7GEdBUh0i1s2ICFI7tvV07vxH3Vxer6V0EgQV
 PQXvKJc4eJlcgHl+q9lgpLeWXQ7w8JxzVLlYuQeUUgfmaQlSUQ7ODJQSW6MyBLne8lmg Ug== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k1wm400fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 11:00:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 296B0Lq6023649
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Oct 2022 11:00:21 GMT
Received: from kathirve-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 6 Oct 2022 04:00:19 -0700
From:   Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH 4/8] wifi: ath11k: remap ce register space for IPQ5018
Date:   Thu, 6 Oct 2022 16:29:09 +0530
Message-ID: <20221006105913.18356-5-quic_kathirve@quicinc.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221006105913.18356-1-quic_kathirve@quicinc.com>
References: <20221006105913.18356-1-quic_kathirve@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qlNyORq6sxTDdWczOG4s1JzaIvExGMcf
X-Proofpoint-GUID: qlNyORq6sxTDdWczOG4s1JzaIvExGMcf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060066
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In IPQ5018 ce register space is moved out of wcss unlike
ipq8074 or ipq6018 and the space is not contiguous,
hence remap the CE registers to a new space to access them.

Register read/write is modified to check if the register to be written
falls in the CE register space and corresponding register is written.
Also adjust the interrupt register address to ce irq enable/disable.

Tested-on : IPQ5018 hw1.0 AHB WLAN.HK.2.5.0.1-01192-QCAHKSWPL_SILICONZ-1 v1

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-developed-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c  | 44 ++++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/ce.h   | 16 ++++++++++
 drivers/net/wireless/ath/ath11k/core.c |  8 +++++
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/hal.c  | 17 ++++++----
 drivers/net/wireless/ath/ath11k/hal.h  |  5 +++
 drivers/net/wireless/ath/ath11k/hw.c   | 17 ++++++++++
 drivers/net/wireless/ath/ath11k/hw.h   |  9 ++++++
 8 files changed, 105 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 84bf679da9eb..231414e677b1 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -267,30 +267,42 @@ static void ath11k_ahb_clearbit32(struct ath11k_base *ab, u8 bit, u32 offset)
 static void ath11k_ahb_ce_irq_enable(struct ath11k_base *ab, u16 ce_id)
 {
 	const struct ce_attr *ce_attr;
+	const struct ce_ie_addr *ce_ie_addr = ab->hw_params.ce_ie_addr;
+	u32 ie1_reg_addr, ie2_reg_addr, ie3_reg_addr;
+
+	ie1_reg_addr = ce_ie_addr->ie1_reg_addr + ATH11K_CE_OFFSET(ab);
+	ie2_reg_addr = ce_ie_addr->ie2_reg_addr + ATH11K_CE_OFFSET(ab);
+	ie3_reg_addr = ce_ie_addr->ie3_reg_addr + ATH11K_CE_OFFSET(ab);
 
 	ce_attr = &ab->hw_params.host_ce_config[ce_id];
 	if (ce_attr->src_nentries)
-		ath11k_ahb_setbit32(ab, ce_id, CE_HOST_IE_ADDRESS);
+		ath11k_ahb_setbit32(ab, ce_id, ie1_reg_addr);
 
 	if (ce_attr->dest_nentries) {
-		ath11k_ahb_setbit32(ab, ce_id, CE_HOST_IE_2_ADDRESS);
+		ath11k_ahb_setbit32(ab, ce_id, ie2_reg_addr);
 		ath11k_ahb_setbit32(ab, ce_id + CE_HOST_IE_3_SHIFT,
-				    CE_HOST_IE_3_ADDRESS);
+				ie3_reg_addr);
 	}
 }
 
 static void ath11k_ahb_ce_irq_disable(struct ath11k_base *ab, u16 ce_id)
 {
 	const struct ce_attr *ce_attr;
+	const struct ce_ie_addr *ce_ie_addr = ab->hw_params.ce_ie_addr;
+	u32 ie1_reg_addr, ie2_reg_addr, ie3_reg_addr;
+
+	ie1_reg_addr = ce_ie_addr->ie1_reg_addr + ATH11K_CE_OFFSET(ab);
+	ie2_reg_addr = ce_ie_addr->ie2_reg_addr + ATH11K_CE_OFFSET(ab);
+	ie3_reg_addr = ce_ie_addr->ie3_reg_addr + ATH11K_CE_OFFSET(ab);
 
 	ce_attr = &ab->hw_params.host_ce_config[ce_id];
 	if (ce_attr->src_nentries)
-		ath11k_ahb_clearbit32(ab, ce_id, CE_HOST_IE_ADDRESS);
+		ath11k_ahb_clearbit32(ab, ce_id, ie1_reg_addr);
 
 	if (ce_attr->dest_nentries) {
-		ath11k_ahb_clearbit32(ab, ce_id, CE_HOST_IE_2_ADDRESS);
+		ath11k_ahb_clearbit32(ab, ce_id, ie2_reg_addr);
 		ath11k_ahb_clearbit32(ab, ce_id + CE_HOST_IE_3_SHIFT,
-				      CE_HOST_IE_3_ADDRESS);
+				      ie3_reg_addr);
 	}
 }
 
@@ -1142,10 +1154,26 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 		goto err_core_free;
 	}
 
+	ab->mem_ce = ab->mem;
+
 	ret = ath11k_core_pre_init(ab);
 	if (ret)
 		goto err_core_free;
 
+	if (ab->hw_params.ce_remap) {
+		const struct ce_remap *ce_remap = ab->hw_params.ce_remap;
+		/* ce register space is moved out of wcss unlike ipq8074 or ipq6018
+		 * and the space is not contiguous, hence remapping the CE registers
+		 * to a new space for accessing them.
+		 */
+		ab->mem_ce = ioremap(ce_remap->base, ce_remap->size);
+		if (IS_ERR(ab->mem_ce)) {
+			dev_err(&pdev->dev, "ce ioremap error\n");
+			ret = -ENOMEM;
+			goto err_core_free;
+		}
+	}
+
 	ret = ath11k_ahb_setup_resources(ab);
 	if (ret)
 		goto err_core_free;
@@ -1236,6 +1264,10 @@ static void ath11k_ahb_free_resources(struct ath11k_base *ab)
 	ath11k_ahb_release_smp2p_handle(ab);
 	ath11k_ahb_fw_resource_deinit(ab);
 	ath11k_ce_free_pipes(ab);
+
+	if (ab->hw_params.ce_remap)
+		iounmap(ab->mem_ce);
+
 	ath11k_core_free(ab);
 	platform_set_drvdata(pdev, NULL);
 }
diff --git a/drivers/net/wireless/ath/ath11k/ce.h b/drivers/net/wireless/ath/ath11k/ce.h
index 9644ff909502..1fc6360e7f01 100644
--- a/drivers/net/wireless/ath/ath11k/ce.h
+++ b/drivers/net/wireless/ath/ath11k/ce.h
@@ -49,6 +49,11 @@ void ath11k_ce_byte_swap(void *mem, u32 len);
 #define CE_HOST_IE_2_ADDRESS	0x00A18040
 #define CE_HOST_IE_3_ADDRESS	CE_HOST_IE_ADDRESS
 
+/* CE IE registers are different for IPQ5018 */
+#define CE_HOST_IPQ5018_IE_ADDRESS		0x0841804C
+#define CE_HOST_IPQ5018_IE_2_ADDRESS		0x08418050
+#define CE_HOST_IPQ5018_IE_3_ADDRESS		CE_HOST_IPQ5018_IE_ADDRESS
+
 #define CE_HOST_IE_3_SHIFT	0xC
 
 #define CE_RING_IDX_INCR(nentries_mask, idx) (((idx) + 1) & (nentries_mask))
@@ -84,6 +89,17 @@ struct ce_pipe_config {
 	__le32 reserved;
 };
 
+struct ce_ie_addr {
+	u32 ie1_reg_addr;
+	u32 ie2_reg_addr;
+	u32 ie3_reg_addr;
+};
+
+struct ce_remap {
+	u32 base;
+	u32 size;
+};
+
 struct ce_attr {
 	/* CE_ATTR_* values */
 	unsigned int flags;
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index e45f1c20fef9..08ffd0c654a6 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -54,6 +54,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 11,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_ipq8074,
 		.svc_to_ce_map_len = 21,
+		.ce_ie_addr = &ath11k_ce_ie_addr_ipq8074,
 		.single_pdev_only = false,
 		.rxdma1_enable = true,
 		.num_rxmda_per_pdev = 1,
@@ -136,6 +137,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 11,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_ipq6018,
 		.svc_to_ce_map_len = 19,
+		.ce_ie_addr = &ath11k_ce_ie_addr_ipq8074,
 		.single_pdev_only = false,
 		.rxdma1_enable = true,
 		.num_rxmda_per_pdev = 1,
@@ -215,6 +217,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 9,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qca6390,
 		.svc_to_ce_map_len = 14,
+		.ce_ie_addr = &ath11k_ce_ie_addr_ipq8074,
 		.single_pdev_only = true,
 		.rxdma1_enable = false,
 		.num_rxmda_per_pdev = 2,
@@ -296,6 +299,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 9,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qcn9074,
 		.svc_to_ce_map_len = 18,
+		.ce_ie_addr = &ath11k_ce_ie_addr_ipq8074,
 		.rxdma1_enable = true,
 		.num_rxmda_per_pdev = 1,
 		.rx_mac_buf_ring = false,
@@ -374,6 +378,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 9,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qca6390,
 		.svc_to_ce_map_len = 14,
+		.ce_ie_addr = &ath11k_ce_ie_addr_ipq8074,
 		.single_pdev_only = true,
 		.rxdma1_enable = false,
 		.num_rxmda_per_pdev = 2,
@@ -535,6 +540,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = 9,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_qca6390,
 		.svc_to_ce_map_len = 14,
+		.ce_ie_addr = &ath11k_ce_ie_addr_ipq8074,
 		.single_pdev_only = true,
 		.rxdma1_enable = false,
 		.num_rxmda_per_pdev = 1,
@@ -621,6 +627,8 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.target_ce_count = TARGET_CE_CNT_5018,
 		.svc_to_ce_map = ath11k_target_service_to_ce_map_wlan_ipq5018,
 		.svc_to_ce_map_len = SVC_CE_MAP_LEN_5018,
+		.ce_ie_addr = &ath11k_ce_ie_addr_ipq5018,
+		.ce_remap = &ath11k_ce_remap_ipq5018,
 		.rxdma1_enable = true,
 		.num_rxmda_per_pdev = RXDMA_PER_PDEV_5018,
 		.rx_mac_buf_ring = false,
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index af6cc9fbf181..2f7022e791b3 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -838,6 +838,7 @@ struct ath11k_base {
 	struct ath11k_dp dp;
 
 	void __iomem *mem;
+	void __iomem *mem_ce;
 	unsigned long mem_len;
 
 	struct {
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 2fd224480d45..22422237500c 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -1220,16 +1220,20 @@ static int ath11k_hal_srng_create_config(struct ath11k_base *ab)
 	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_TCL_REG + HAL_TCL_STATUS_RING_HP;
 
 	s = &hal->srng_config[HAL_CE_SRC];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_HP;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_BASE_LSB +
+		ATH11K_CE_OFFSET(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab) + HAL_CE_DST_RING_HP +
+		ATH11K_CE_OFFSET(ab);
 	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
 		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
 	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_SRC_REG(ab) -
 		HAL_SEQ_WCSS_UMAC_CE0_SRC_REG(ab);
 
 	s = &hal->srng_config[HAL_CE_DST];
-	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_HP;
+	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_BASE_LSB +
+		ATH11K_CE_OFFSET(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_RING_HP +
+		ATH11K_CE_OFFSET(ab);
 	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
 		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
 	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
@@ -1237,8 +1241,9 @@ static int ath11k_hal_srng_create_config(struct ath11k_base *ab)
 
 	s = &hal->srng_config[HAL_CE_DST_STATUS];
 	s->reg_start[0] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) +
-		HAL_CE_DST_STATUS_RING_BASE_LSB;
-	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_STATUS_RING_HP;
+		HAL_CE_DST_STATUS_RING_BASE_LSB + ATH11K_CE_OFFSET(ab);
+	s->reg_start[1] = HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab) + HAL_CE_DST_STATUS_RING_HP +
+		ATH11K_CE_OFFSET(ab);
 	s->reg_size[0] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
 		HAL_SEQ_WCSS_UMAC_CE0_DST_REG(ab);
 	s->reg_size[1] = HAL_SEQ_WCSS_UMAC_CE1_DST_REG(ab) -
diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 6a1f78ee6eb6..1942d41d6de5 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -321,6 +321,10 @@ struct ath11k_base;
 #define HAL_WBM2SW_RELEASE_RING_BASE_MSB_RING_SIZE	0x000fffff
 #define HAL_RXDMA_RING_MAX_SIZE				0x0000ffff
 
+/* IPQ5018 ce registers */
+#define HAL_IPQ5018_CE_WFSS_REG_BASE		0x08400000
+#define HAL_IPQ5018_CE_SIZE			0x200000
+
 /* Add any other errors here and return them in
  * ath11k_hal_rx_desc_get_err().
  */
@@ -519,6 +523,7 @@ enum hal_srng_dir {
 #define HAL_SRNG_FLAGS_MSI_INTR			0x00020000
 #define HAL_SRNG_FLAGS_CACHED                   0x20000000
 #define HAL_SRNG_FLAGS_LMAC_RING		0x80000000
+#define HAL_SRNG_FLAGS_REMAP_CE_RING        0x10000000
 
 #define HAL_SRNG_TLV_HDR_TAG		GENMASK(9, 1)
 #define HAL_SRNG_TLV_HDR_LEN		GENMASK(25, 10)
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index fa722b6a71d0..e6aef0fad537 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -2163,6 +2163,23 @@ const struct service_to_pipe ath11k_target_service_to_ce_map_wlan_ipq5018[] = {
 	{ /* terminator entry */ }
 };
 
+const struct ce_ie_addr ath11k_ce_ie_addr_ipq8074 = {
+	.ie1_reg_addr = CE_HOST_IE_ADDRESS,
+	.ie2_reg_addr = CE_HOST_IE_2_ADDRESS,
+	.ie3_reg_addr = CE_HOST_IE_3_ADDRESS,
+};
+
+const struct ce_ie_addr ath11k_ce_ie_addr_ipq5018 = {
+	.ie1_reg_addr = CE_HOST_IPQ5018_IE_ADDRESS - HAL_IPQ5018_CE_WFSS_REG_BASE,
+	.ie2_reg_addr = CE_HOST_IPQ5018_IE_2_ADDRESS - HAL_IPQ5018_CE_WFSS_REG_BASE,
+	.ie3_reg_addr = CE_HOST_IPQ5018_IE_3_ADDRESS - HAL_IPQ5018_CE_WFSS_REG_BASE,
+};
+
+const struct ce_remap ath11k_ce_remap_ipq5018 = {
+	.base = HAL_IPQ5018_CE_WFSS_REG_BASE,
+	.size = HAL_IPQ5018_CE_SIZE,
+};
+
 const struct ath11k_hw_regs ipq8074_regs = {
 	/* SW2TCL(x) R0 ring configuration address */
 	.hal_tcl1_ring_base_lsb = 0x00000510,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index f4a30835a5f6..57b9dd3a9917 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -80,6 +80,8 @@
 #define ATH11K_M3_FILE			"m3.bin"
 #define ATH11K_REGDB_FILE_NAME		"regdb.bin"
 
+#define ATH11K_CE_OFFSET(ab)	(ab->mem_ce - ab->mem)
+
 enum ath11k_hw_rate_cck {
 	ATH11K_HW_RATE_CCK_LP_11M = 0,
 	ATH11K_HW_RATE_CCK_LP_5_5M,
@@ -158,6 +160,8 @@ struct ath11k_hw_params {
 	u32 target_ce_count;
 	const struct service_to_pipe *svc_to_ce_map;
 	u32 svc_to_ce_map_len;
+	const struct ce_ie_addr *ce_ie_addr;
+	const struct ce_remap *ce_remap;
 
 	bool single_pdev_only;
 
@@ -275,6 +279,11 @@ extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qca6390;
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_qcn9074;
 extern const struct ath11k_hw_ring_mask ath11k_hw_ring_mask_wcn6750;
 
+extern const struct ce_ie_addr ath11k_ce_ie_addr_ipq8074;
+extern const struct ce_ie_addr ath11k_ce_ie_addr_ipq5018;
+
+extern const struct ce_remap ath11k_ce_remap_ipq5018;
+
 extern const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq8074;
 extern const struct ath11k_hw_hal_params ath11k_hw_hal_params_qca6390;
 extern const struct ath11k_hw_hal_params ath11k_hw_hal_params_wcn6750;
-- 
2.38.0

