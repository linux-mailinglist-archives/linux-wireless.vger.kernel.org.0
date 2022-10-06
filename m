Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E115F64B5
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Oct 2022 13:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiJFLAr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Oct 2022 07:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiJFLAV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Oct 2022 07:00:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951C36C77E
        for <linux-wireless@vger.kernel.org>; Thu,  6 Oct 2022 04:00:19 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296AKRWS013917;
        Thu, 6 Oct 2022 11:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=ETdcSBW4nAz82/L6KPEskK8FHFmp77bmiNYrc3//jMo=;
 b=mten4J07gqpcfJ+r1SPQgLJHDvApyv323P9cqoBhxdu/lfY5KoISkFdkrkc6WoPITAnC
 54eJWO2z4z2RpHUkGkhOLPVn1Acn5ANCC1XTg3GhJw9UTw7lHiixzBpTwYhSVngmK+1L
 BHdXvZuj/fMPMckcZ4krYeJccbGkdpT6I7VsCRmmJHL0xwfhtXk+z2fsnzXHzW6eQIPs
 CiW3Q/WCKQ8ylkRFH6NbBu0TFf2yRoqMOqBuWHGooetHAKAgCf8vUPgyqEv3EeTSFckF
 E85n4C73iscn1SYnNsXz2Z1FCfDST3XuRZtLiRB8XWNMk/cP61seCwEhzp3OwAU1Z6La /g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0m88n7jh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Oct 2022 11:00:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 296B0GSs026262
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Oct 2022 11:00:16 GMT
Received: from kathirve-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 6 Oct 2022 04:00:14 -0700
From:   Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH 2/8] wifi: ath11k: update hw params for IPQ5018
Date:   Thu, 6 Oct 2022 16:29:07 +0530
Message-ID: <20221006105913.18356-3-quic_kathirve@quicinc.com>
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
X-Proofpoint-GUID: 1G44Ae02ZUaL7o1cTTuRywPeV4VT9a06
X-Proofpoint-ORIG-GUID: 1G44Ae02ZUaL7o1cTTuRywPeV4VT9a06
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210060066
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add new compatible string for IPQ5018 and add
required hw params for IPQ5018. The hw descriptors size and
datapath ops are similar to QCN9074, hence reuse the same.

Tested-on : IPQ5018 hw1.0 AHB WLAN.HK.2.5.0.1-01192-QCAHKSWPL_SILICONZ-1 v1

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-developed-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 70 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h |  8 +++
 2 files changed, 78 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 9894f908cc35..60ff6b72bc20 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -591,6 +591,76 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE_WCN6750,
 		.smp2p_wow_exit = true,
 	},
+	{
+		.hw_rev = ATH11K_HW_IPQ5018_HW10,
+		.name = "ipq5018 hw1.0",
+		.fw = {
+			.dir = "IPQ5018/hw1.0",
+			.board_size = 256 * 1024,
+			.cal_offset = 128 * 1024,
+		},
+		.max_radios = MAX_RADIOS_5018,
+		.bdf_addr = 0x4BA00000,
+		/* hal_desc_sz and hw ops are similar to qcn9074 */
+		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),
+		.qmi_service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ8074,
+		.ring_mask = &ath11k_hw_ring_mask_ipq8074,
+		.credit_flow = false,
+		.max_tx_ring = 1,
+		.spectral = {
+			.fft_sz = 2,
+			.fft_pad_sz = 0,
+			.summary_pad_sz = 16,
+			.fft_hdr_len = 24,
+			.max_fft_bins = 1024,
+		},
+		.internal_sleep_clock = false,
+		.host_ce_config = ath11k_host_ce_config_qcn9074,
+		.ce_count = CE_CNT_5018,
+		.rxdma1_enable = true,
+		.num_rxmda_per_pdev = RXDMA_PER_PDEV_5018,
+		.rx_mac_buf_ring = false,
+		.vdev_start_delay = false,
+		.htt_peer_map_v2 = true,
+		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
+			BIT(NL80211_IFTYPE_AP) |
+			BIT(NL80211_IFTYPE_MESH_POINT),
+		.supports_monitor = false,
+		.supports_sta_ps = false,
+		.supports_shadow_regs = false,
+		.fw_mem_mode = 0,
+		.num_vdevs = 16 + 1,
+		.num_peers = 512,
+		.supports_regdb = false,
+		.idle_ps = false,
+		.supports_suspend = false,
+		.hal_params = &ath11k_hw_hal_params_ipq8074,
+		.single_pdev_only = false,
+		.cold_boot_calib = true,
+		.fix_l1ss = true,
+		.supports_dynamic_smps_6ghz = false,
+		.alloc_cacheable_memory = true,
+		.supports_rssi_stats = false,
+		.fw_wmi_diag_event = false,
+		.current_cc_support = false,
+		.dbr_debug_support = true,
+		.global_reset = false,
+		.bios_sar_capa = NULL,
+		.m3_fw_support = false,
+		.fixed_bdf_addr = true,
+		.fixed_mem_region = true,
+		.static_window_map = false,
+		.hybrid_bus_type = false,
+		.fixed_fw_mem = false,
+		.support_off_channel_tx = false,
+		.supports_multi_bssid = false,
+
+		.sram_dump = {},
+
+		.tcl_ring_retry = true,
+		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
+		.smp2p_wow_exit = false,
+	},
 };
 
 static inline struct ath11k_pdev *ath11k_core_get_single_pdev(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index b6246a2f2496..fe1055a23948 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -142,6 +142,7 @@ enum ath11k_hw_rev {
 	ATH11K_HW_WCN6855_HW20,
 	ATH11K_HW_WCN6855_HW21,
 	ATH11K_HW_WCN6750_HW10,
+	ATH11K_HW_IPQ5018_HW10,
 };
 
 enum ath11k_firmware_mode {
@@ -230,6 +231,13 @@ struct ath11k_he {
 
 #define MAX_RADIOS 3
 
+/* ipq5018 hw param macros */
+#define MAX_RADIOS_5018	1
+#define CE_CNT_5018	6
+#define TARGET_CE_CNT_5018	9
+#define SVC_CE_MAP_LEN_5018	17
+#define RXDMA_PER_PDEV_5018	1
+
 enum {
 	WMI_HOST_TP_SCALE_MAX   = 0,
 	WMI_HOST_TP_SCALE_50    = 1,
-- 
2.38.0

