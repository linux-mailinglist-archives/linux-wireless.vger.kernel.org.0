Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FD1752F7D
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jul 2023 04:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjGNCie (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jul 2023 22:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjGNCib (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jul 2023 22:38:31 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBEE2D72
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jul 2023 19:38:26 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E146M7026248;
        Fri, 14 Jul 2023 02:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=QiyuoIqh+QRoZ5aN0WxU+N2QCplPylpSYJ64Qc1keqE=;
 b=LTAx0hSAv+xtaTV0ABZHFRNf2GBdwzb9Qdf3Oxgjc4c4ufz9A7HGQpIvBlTnLI3BuBXz
 lhUrA68489cEjgymHDJYnw0cgGBPSU8uBNhuGzEPHcSBTqsadmIlKPYynSWGS+8CCRPX
 ex3BQSaqgO4iCpwP0LO/YcuJsK++02YGa83928DM4pb8kMEPrx1JDMgU8kNQVBPC5KXO
 l3uJkFdbQil9PbjsfQNJF9qYIWnHvgqz4bySesld5R8+kND0nrLFnrsj4+F6YT/xCbMx
 UEm5rnDRkh1C26i+KAHQYajcESW3+jzqLUuvgshEu36TaYdGqD0IXyCIuDQABLhsTE4B Zw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtptw0nte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 02:38:19 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36E2cITK005496
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 02:38:18 GMT
Received: from cjhuang2-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 19:38:16 -0700
From:   Carl Huang <quic_cjhuang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_cjhuang@quicinc.com>
Subject: [PATCH 1/2] wifi: ath11k: supports 2 station interfaces
Date:   Fri, 14 Jul 2023 10:38:00 +0800
Message-ID: <20230714023801.2621802-2-quic_cjhuang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230714023801.2621802-1-quic_cjhuang@quicinc.com>
References: <20230714023801.2621802-1-quic_cjhuang@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: feUHgteZ3Ct9fdDJsqj_1K4GGvey-Rno
X-Proofpoint-GUID: feUHgteZ3Ct9fdDJsqj_1K4GGvey-Rno
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_12,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140021
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add hardware parameter support_dual_stations to indicate
whether 2 station interfaces are supported. For chips which
support this feature, limit total number of AP interface and
mesh point to 1. The max interfaces are 3 for such chips.

The chips affected are:
 QCA6390 hw2.0
 WCN6855 hw2.0
 WCN6855 hw2.1
Other chips are not affected.

For affected chips, remove radar_detect_widths because now
num_different_channels is set to 2. radar_detect_widths can
be set only when num_different_channels is 1. See mac80211
function wiphy_verify_combinations for details.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Signed-off-by: Carl Huang <quic_cjhuang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 14 ++++--
 drivers/net/wireless/ath/ath11k/hw.c   |  2 +-
 drivers/net/wireless/ath/ath11k/hw.h   |  1 +
 drivers/net/wireless/ath/ath11k/mac.c  | 62 +++++++++++++++++---------
 4 files changed, 53 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index bebfd342e28b..739a8d13d57d 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -120,6 +120,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tcl_ring_retry = true,
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 		.smp2p_wow_exit = false,
+		.support_dual_stations = false,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ6018_HW10,
@@ -202,6 +203,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = false,
+		.support_dual_stations = false,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -251,7 +253,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.cold_boot_calib = false,
 		.cbcal_restart_fw = false,
 		.fw_mem_mode = 0,
-		.num_vdevs = 16 + 1,
+		.num_vdevs = 2 + 1,
 		.num_peers = 512,
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
@@ -286,6 +288,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = true,
+		.support_dual_stations = true,
 	},
 	{
 		.name = "qcn9074 hw1.0",
@@ -367,6 +370,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = false,
+		.support_dual_stations = false,
 	},
 	{
 		.name = "wcn6855 hw2.0",
@@ -416,7 +420,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.cold_boot_calib = false,
 		.cbcal_restart_fw = false,
 		.fw_mem_mode = 0,
-		.num_vdevs = 16 + 1,
+		.num_vdevs = 2 + 1,
 		.num_peers = 512,
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
@@ -451,6 +455,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = true,
+		.support_dual_stations = true,
 	},
 	{
 		.name = "wcn6855 hw2.1",
@@ -498,7 +503,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.cold_boot_calib = false,
 		.cbcal_restart_fw = false,
 		.fw_mem_mode = 0,
-		.num_vdevs = 16 + 1,
+		.num_vdevs = 2 + 1,
 		.num_peers = 512,
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
@@ -533,6 +538,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = true,
+		.support_dual_stations = true,
 	},
 	{
 		.name = "wcn6750 hw1.0",
@@ -613,6 +619,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE_WCN6750,
 		.smp2p_wow_exit = true,
 		.support_fw_mac_sequence = true,
+		.support_dual_stations = false,
 	},
 	{
 		.hw_rev = ATH11K_HW_IPQ5018_HW10,
@@ -693,6 +700,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.tx_ring_size = DP_TCL_DATA_RING_SIZE,
 		.smp2p_wow_exit = false,
 		.support_fw_mac_sequence = false,
+		.support_dual_stations = false,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index d7b5ec6e6904..3b56ba1b8534 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -58,7 +58,7 @@ static void ath11k_hw_wcn6855_tx_mesh_enable(struct ath11k_base *ab,
 static void ath11k_init_wmi_config_qca6390(struct ath11k_base *ab,
 					   struct target_resource_config *config)
 {
-	config->num_vdevs = 4;
+	config->num_vdevs = ab->hw_params.num_vdevs;
 	config->num_peers = 16;
 	config->num_tids = 32;
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index f5533630a7f9..40ed5608fe81 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -225,6 +225,7 @@ struct ath11k_hw_params {
 	u32 tx_ring_size;
 	bool smp2p_wow_exit;
 	bool support_fw_mac_sequence;
+	bool support_dual_stations;
 };
 
 struct ath11k_hw_ops {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 8c77ade49437..3a9494bc944c 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9287,28 +9287,46 @@ static int ath11k_mac_setup_iface_combinations(struct ath11k *ar)
 		return -ENOMEM;
 	}
 
-	limits[0].max = 1;
-	limits[0].types |= BIT(NL80211_IFTYPE_STATION);
-
-	limits[1].max = 16;
-	limits[1].types |= BIT(NL80211_IFTYPE_AP);
-
-	if (IS_ENABLED(CONFIG_MAC80211_MESH) &&
-	    ab->hw_params.interface_modes & BIT(NL80211_IFTYPE_MESH_POINT))
-		limits[1].types |= BIT(NL80211_IFTYPE_MESH_POINT);
-
-	combinations[0].limits = limits;
-	combinations[0].n_limits = n_limits;
-	combinations[0].max_interfaces = 16;
-	combinations[0].num_different_channels = 1;
-	combinations[0].beacon_int_infra_match = true;
-	combinations[0].beacon_int_min_gcd = 100;
-	combinations[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
-						BIT(NL80211_CHAN_WIDTH_20) |
-						BIT(NL80211_CHAN_WIDTH_40) |
-						BIT(NL80211_CHAN_WIDTH_80) |
-						BIT(NL80211_CHAN_WIDTH_80P80) |
-						BIT(NL80211_CHAN_WIDTH_160);
+	if (ab->hw_params.support_dual_stations) {
+		limits[0].max = 2;
+		limits[0].types |= BIT(NL80211_IFTYPE_STATION);
+
+		limits[1].max = 1;
+		limits[1].types |= BIT(NL80211_IFTYPE_AP);
+		if (IS_ENABLED(CONFIG_MAC80211_MESH) &&
+		    ab->hw_params.interface_modes & BIT(NL80211_IFTYPE_MESH_POINT))
+			limits[1].types |= BIT(NL80211_IFTYPE_MESH_POINT);
+
+		combinations[0].limits = limits;
+		combinations[0].n_limits = 2;
+		combinations[0].max_interfaces = ab->hw_params.num_vdevs;
+		combinations[0].num_different_channels = 2;
+		combinations[0].beacon_int_infra_match = true;
+		combinations[0].beacon_int_min_gcd = 100;
+	} else {
+		limits[0].max = 1;
+		limits[0].types |= BIT(NL80211_IFTYPE_STATION);
+
+		limits[1].max = 16;
+		limits[1].types |= BIT(NL80211_IFTYPE_AP);
+
+		if (IS_ENABLED(CONFIG_MAC80211_MESH) &&
+		    ab->hw_params.interface_modes & BIT(NL80211_IFTYPE_MESH_POINT))
+			limits[1].types |= BIT(NL80211_IFTYPE_MESH_POINT);
+
+		combinations[0].limits = limits;
+		combinations[0].n_limits = 2;
+		combinations[0].max_interfaces = 16;
+		combinations[0].num_different_channels = 1;
+		combinations[0].beacon_int_infra_match = true;
+		combinations[0].beacon_int_min_gcd = 100;
+		combinations[0].radar_detect_widths = BIT(NL80211_CHAN_WIDTH_20_NOHT) |
+							BIT(NL80211_CHAN_WIDTH_20) |
+							BIT(NL80211_CHAN_WIDTH_40) |
+							BIT(NL80211_CHAN_WIDTH_80) |
+							BIT(NL80211_CHAN_WIDTH_80P80) |
+							BIT(NL80211_CHAN_WIDTH_160);
+	}
 
 	ar->hw->wiphy->iface_combinations = combinations;
 	ar->hw->wiphy->n_iface_combinations = 1;
-- 
2.34.1

