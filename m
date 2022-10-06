Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9A15F64B9
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Oct 2022 13:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiJFLAv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Oct 2022 07:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiJFLA3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Oct 2022 07:00:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6AF13FA3
        for <linux-wireless@vger.kernel.org>; Thu,  6 Oct 2022 04:00:28 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2968oZYE029547;
        Thu, 6 Oct 2022 11:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=y/6OHWfU30exkjt7sVo3uoBSYoM0slm3yfMzVx8JRwI=;
 b=QFJL1Lndz5OIZKGij0LMl5PFIa2iAXiZFAGhdfHz4BPmOQvK2H8aOGjlkjYU6jeyDe62
 lbI7Y0lmc3qjcSc4SL86S/aYx0gt8qXdgJ3H9uq1lwfUH8ES36pXPf07rDbrisGkfpkV
 QxqYmio/BqqfDqxRbIh2vpbkUTcROGAHurYdDU2ydh8Z2VfOcFvbRL/3q6ASsX3trxkd
 082vKi+Bp0C5CCd5UxLG6L3/VAldtGo8VLzxvNGV5RCnMZn/P/H8kn0B3Y1ICBVP9FHO
 bvhJwMLgI545amm1bKK22srDYYK4q3N3l2CjWHBatahNMKNoxdNPw4ogGZe7qb5zOnXC UQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0hxpwdu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 11:00:24 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 296B0O6T026355
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Oct 2022 11:00:24 GMT
Received: from kathirve-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 6 Oct 2022 04:00:22 -0700
From:   Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH 5/8] wifi: ath11k: update hal srng regs for IPQ5018
Date:   Thu, 6 Oct 2022 16:29:10 +0530
Message-ID: <20221006105913.18356-6-quic_kathirve@quicinc.com>
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
X-Proofpoint-GUID: X9GAfQiySZbuuusDXpfgviPV3WJ92k6r
X-Proofpoint-ORIG-GUID: X9GAfQiySZbuuusDXpfgviPV3WJ92k6r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060066
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

IPQ5018 hal srng register address & offsets are not
similar to IPQ8074/IPQ6018/QCN9074, hence define a
new set of srng register group data for IPQ5018.

Tested-on : IPQ5018 hw1.0 AHB WLAN.HK.2.5.0.1-01192-QCAHKSWPL_SILICONZ-1 v1

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-developed-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c |  1 +
 drivers/net/wireless/ath/ath11k/hw.c   | 79 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h   |  1 +
 3 files changed, 81 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 08ffd0c654a6..1d45313f4f9f 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -621,6 +621,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 			.max_fft_bins = 1024,
 		},
 		.internal_sleep_clock = false,
+		.regs = &ipq5018_regs,
 		.host_ce_config = ath11k_host_ce_config_qcn9074,
 		.ce_count = CE_CNT_5018,
 		.target_ce_config = ath11k_target_ce_config_wlan_ipq5018,
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index e6aef0fad537..ca7ec356f41f 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -2645,6 +2645,85 @@ static const struct ath11k_hw_tcl2wbm_rbm_map ath11k_hw_tcl2wbm_rbm_map_wcn6750[
 	},
 };
 
+const struct ath11k_hw_regs ipq5018_regs = {
+	/* SW2TCL(x) R0 ring configuration address */
+	.hal_tcl1_ring_base_lsb = 0x00000694,
+	.hal_tcl1_ring_base_msb = 0x00000698,
+	.hal_tcl1_ring_id =	0x0000069c,
+	.hal_tcl1_ring_misc = 0x000006a4,
+	.hal_tcl1_ring_tp_addr_lsb = 0x000006b0,
+	.hal_tcl1_ring_tp_addr_msb = 0x000006b4,
+	.hal_tcl1_ring_consumer_int_setup_ix0 = 0x000006c4,
+	.hal_tcl1_ring_consumer_int_setup_ix1 = 0x000006c8,
+	.hal_tcl1_ring_msi1_base_lsb = 0x000006dc,
+	.hal_tcl1_ring_msi1_base_msb = 0x000006e0,
+	.hal_tcl1_ring_msi1_data = 0x000006e4,
+	.hal_tcl2_ring_base_lsb = 0x000006ec,
+	.hal_tcl_ring_base_lsb = 0x0000079c,
+
+	/* TCL STATUS ring address */
+	.hal_tcl_status_ring_base_lsb = 0x000008a4,
+
+	/* REO2SW(x) R0 ring configuration address */
+	.hal_reo1_ring_base_lsb = 0x000001ec,
+	.hal_reo1_ring_base_msb = 0x000001f0,
+	.hal_reo1_ring_id = 0x000001f4,
+	.hal_reo1_ring_misc = 0x000001fc,
+	.hal_reo1_ring_hp_addr_lsb = 0x00000200,
+	.hal_reo1_ring_hp_addr_msb = 0x00000204,
+	.hal_reo1_ring_producer_int_setup = 0x00000210,
+	.hal_reo1_ring_msi1_base_lsb = 0x00000234,
+	.hal_reo1_ring_msi1_base_msb = 0x00000238,
+	.hal_reo1_ring_msi1_data = 0x0000023c,
+	.hal_reo2_ring_base_lsb = 0x00000244,
+	.hal_reo1_aging_thresh_ix_0 = 0x00000564,
+	.hal_reo1_aging_thresh_ix_1 = 0x00000568,
+	.hal_reo1_aging_thresh_ix_2 = 0x0000056c,
+	.hal_reo1_aging_thresh_ix_3 = 0x00000570,
+
+	/* REO2SW(x) R2 ring pointers (head/tail) address */
+	.hal_reo1_ring_hp = 0x00003028,
+	.hal_reo1_ring_tp = 0x0000302c,
+	.hal_reo2_ring_hp = 0x00003030,
+
+	/* REO2TCL R0 ring configuration address */
+	.hal_reo_tcl_ring_base_lsb = 0x000003fc,
+	.hal_reo_tcl_ring_hp = 0x00003058,
+
+	/* SW2REO ring address */
+	.hal_sw2reo_ring_base_lsb = 0x0000013c,
+	.hal_sw2reo_ring_hp = 0x00003018,
+
+	/* REO CMD ring address */
+	.hal_reo_cmd_ring_base_lsb = 0x000000e4,
+	.hal_reo_cmd_ring_hp = 0x00003010,
+
+	/* REO status address */
+	.hal_reo_status_ring_base_lsb = 0x00000504,
+	.hal_reo_status_hp = 0x00003070,
+
+	/* WCSS relative address */
+	.hal_seq_wcss_umac_ce0_src_reg = 0x08400000
+		- HAL_IPQ5018_CE_WFSS_REG_BASE,
+	.hal_seq_wcss_umac_ce0_dst_reg = 0x08401000
+		- HAL_IPQ5018_CE_WFSS_REG_BASE,
+	.hal_seq_wcss_umac_ce1_src_reg = 0x08402000
+		- HAL_IPQ5018_CE_WFSS_REG_BASE,
+	.hal_seq_wcss_umac_ce1_dst_reg = 0x08403000
+		- HAL_IPQ5018_CE_WFSS_REG_BASE,
+
+	/* WBM Idle address */
+	.hal_wbm_idle_link_ring_base_lsb = 0x00000874,
+	.hal_wbm_idle_link_ring_misc = 0x00000884,
+
+	/* SW2WBM release address */
+	.hal_wbm_release_ring_base_lsb = 0x000001ec,
+
+	/* WBM2SW release address */
+	.hal_wbm0_release_ring_base_lsb = 0x00000924,
+	.hal_wbm1_release_ring_base_lsb = 0x0000097c,
+};
+
 const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq8074 = {
 	.rx_buf_rbm = HAL_RX_BUF_RBM_SW3_BM,
 	.tcl2wbm_rbm_map = ath11k_hw_tcl2wbm_rbm_map_ipq8074,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 57b9dd3a9917..5584ef170c65 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -413,6 +413,7 @@ extern const struct ath11k_hw_regs qca6390_regs;
 extern const struct ath11k_hw_regs qcn9074_regs;
 extern const struct ath11k_hw_regs wcn6855_regs;
 extern const struct ath11k_hw_regs wcn6750_regs;
+extern const struct ath11k_hw_regs ipq5018_regs;
 
 static inline const char *ath11k_bd_ie_type_str(enum ath11k_bd_ie_type type)
 {
-- 
2.38.0

