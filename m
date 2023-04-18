Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DDC6E672B
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 16:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjDROax (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 10:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjDROaw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 10:30:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E20CA270
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 07:30:51 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33I6rPKt008340;
        Tue, 18 Apr 2023 14:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=bnqCcVyU6byDsmG3N8iGkp+riudWnl1oo+ZaxyG4jr4=;
 b=KoSpeF/f66tWsXlZ57VRLx6Mq2oe8vxmKC/0x9epsxdcICdw3+JxP8YWEwZpywvoFetf
 K8fwUYlbL41kC/3jf92AB2earbhieOLvz7oKCYBLm2Bn3Ep4qPTQi0XUPQhCbr6yXzi4
 ZK5jcuoZfzuMLuRPnlz9JhBfwMBuPcfSKlsa3qoaE4kaxKIdoDP58iIlzWsUSIMo2xk3
 OKy7hhvhUMmGyNQI6okqRWCaGW5EWxhgfo8M236g85+9q2HOjruKQ2HQp1wt0R3ngHlC
 yqUhEDztVDfnVL6Fgdu9x4DgBYq/fDouSLcGx7HUFvgLvp8g3nHgLCR/verT8gFj9aIJ gA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q19kg2ffr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 14:30:45 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33IEUj1F002743
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Apr 2023 14:30:45 GMT
Received: from karm-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Tue, 18 Apr 2023 07:30:43 -0700
From:   Karthik M <quic_karm@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthik M <quic_karm@quicinc.com>,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Subject: [PATCH v3] wifi: ath11k: add support for htt stats rx_ext_stats (30) support
Date:   Tue, 18 Apr 2023 20:00:32 +0530
Message-ID: <20230418143032.4814-1-quic_karm@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Qzk7i-Wbe_kJMcQ-5A3DT-pFPbtpvlKa
X-Proofpoint-ORIG-GUID: Qzk7i-Wbe_kJMcQ-5A3DT-pFPbtpvlKa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-18_11,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=870
 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304180125
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

HTT stats, HTT_RX_PDEV_RATE_EXT_STATS has the rx stats info of
the extended 80MHz, mainly 80+80 and 160MHz modes.

Usage: echo 30 > /sys/kernel/debug/ieee80211/phyx/ath11k/htt_stats_type
       cat /sys/kernel/debug/ieee80211/phyx/ath11k/htt_stats

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.9.0.1-01184-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Signed-off-by: Karthik M <quic_karm@quicinc.com>
---
---
v2:
  - Integrated the patch already raised.
---
v3:
  - Addressed jeff's comments to remove unnecssary MACRO
  - Removed scnprintf check
  - Removed inline in function definition.
---
 drivers/net/wireless/ath/ath11k/debugfs.h     |  1 +
 .../wireless/ath/ath11k/debugfs_htt_stats.c   | 91 +++++++++++++++++++
 .../wireless/ath/ath11k/debugfs_htt_stats.h   | 40 ++++++++
 3 files changed, 132 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs.h b/drivers/net/wireless/ath/ath11k/debugfs.h
index 3af0169f6cf2..00da0c06b4a0 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -39,6 +39,7 @@ enum ath11k_dbg_htt_ext_stats_type {
 	ATH11K_DBG_HTT_EXT_STATS_PDEV_OBSS_PD_STATS	    =  23,
 	ATH11K_DBG_HTT_EXT_STATS_RING_BACKPRESSURE_STATS    =  24,
 	ATH11K_DBG_HTT_EXT_STATS_PEER_CTRL_PATH_TXRX_STATS  =  29,
+	ATH11K_DBG_HTT_EXT_STATS_PDEV_RX_RATE_EXT           =  30,
 	ATH11K_DBG_HTT_EXT_STATS_PDEV_TX_RATE_TXBF_STATS    =  31,
 	ATH11K_DBG_HTT_EXT_STATS_TXBF_OFDMA		    =  32,
 	ATH11K_DBG_HTT_EXT_PHY_COUNTERS_AND_PHY_STATS	    =  37,
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
index b3efca6bd7dd..ee094197c70e 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
@@ -2879,6 +2879,94 @@ static inline void htt_print_tx_pdev_rate_stats_tlv(const void *tag_buf,
 	stats_req->buf_len = len;
 }
 
+static void htt_print_rx_pdev_rate_ext_stats_tlv(const void *tag_buf,
+						 struct debug_htt_stats_req *stats_req)
+{
+	const struct htt_rx_pdev_rate_ext_stats_tlv *htt_stats_buf = tag_buf;
+	u8 *buf = stats_req->buf;
+	u32 len = stats_req->buf_len;
+	u32 buf_len = ATH11K_HTT_STATS_BUF_SIZE;
+	u8 i, j;
+
+	len += scnprintf(buf + len, buf_len - len,
+			 "HTT_RX_PDEV_RATE_EXT_STATS_TLV:\n");
+	len += scnprintf(buf + len, buf_len - len, "rssi_mcast = %d\n",
+			 htt_stats_buf->rssi_mcast);
+	len += scnprintf(buf + len, buf_len - len, "rssi_mgmt = %d\n",
+			 htt_stats_buf->rssi_mgmt);
+
+	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "\nrssi_chain_ext[%u] = ", j);
+		PRINT_ARRAY_TO_BUF(buf, len,
+				   htt_stats_buf->rssi_chain_ext[j],
+				   NULL,
+				   HTT_RX_PDEV_STATS_NUM_BW_EXT_COUNTERS,
+				   "\n");
+	}
+
+	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS; j++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "\nrx_per_chain_rssi_ext_in_dbm[%u] = ", j);
+		for (i = 0; i < HTT_RX_PDEV_STATS_NUM_BW_EXT_COUNTERS; i++)
+			len += scnprintf(buf + len,
+					 ATH11K_HTT_STATS_BUF_SIZE - len,
+					 " %u:%d,",
+					 i,
+					 htt_stats_buf->rx_per_chain_rssi_ext_in_dbm[j][i]);
+		len += scnprintf(buf + len,
+				 ATH11K_HTT_STATS_BUF_SIZE - len,
+				 "\n");
+	}
+
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_mcs_ext,
+			   "\nrx_mcs_ext",
+			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT, "\n");
+
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_stbc_ext,
+			   "\nrx_stbc_ext",
+			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT, "\n");
+
+	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "\nrx_gi_ext[%u] = ", j);
+		PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_gi_ext[j],
+				   NULL,
+				   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT,
+				   "\n");
+	}
+
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->ul_ofdma_rx_mcs_ext,
+			   "\nul_ofdma_rx_mcs_ext",
+			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT, "\n");
+
+	for (j = 0; j < HTT_RX_PDEV_STATS_NUM_GI_COUNTERS; j++) {
+		len += scnprintf(buf + len, buf_len - len,
+				 "\nul_ofdma_rx_gi_ext[%u] = ", j);
+		PRINT_ARRAY_TO_BUF(buf, len,
+				   htt_stats_buf->ul_ofdma_rx_gi_ext[j],
+				   NULL,
+				   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT,
+				   "\n");
+	}
+
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_11ax_su_txbf_mcs_ext,
+			   "\nrx_11ax_su_txbf_mcs_ext",
+			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT, "\n");
+
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_11ax_mu_txbf_mcs_ext,
+			   "\nrx_11ax_mu_txbf_mcs_ext",
+			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT, "\n");
+
+	PRINT_ARRAY_TO_BUF(buf, len, htt_stats_buf->rx_11ax_dl_ofdma_mcs_ext,
+			   "\nrx_11ax_dl_ofdma_mcs_ext",
+			   HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT, "\n");
+
+	len += scnprintf(buf + len, buf_len - len, "\n");
+
+	stats_req->buf_len = len;
+}
+
 static inline void htt_print_rx_pdev_rate_stats_tlv(const void *tag_buf,
 						    struct debug_htt_stats_req *stats_req)
 {
@@ -4428,6 +4516,9 @@ static int ath11k_dbg_htt_ext_stats_parse(struct ath11k_base *ab,
 	case HTT_STATS_PEER_CTRL_PATH_TXRX_STATS_TAG:
 		htt_print_peer_ctrl_path_txrx_stats_tlv(tag_buf, stats_req);
 		break;
+	case HTT_STATS_RX_PDEV_RATE_EXT_STATS_TAG:
+		htt_print_rx_pdev_rate_ext_stats_tlv(tag_buf, stats_req);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
index 2b97cbbd28cb..ce692fb3f357 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.h
@@ -104,6 +104,7 @@ enum htt_tlv_tag_t {
 	HTT_STATS_HW_WAR_TAG				    = 89,
 	HTT_STATS_RING_BACKPRESSURE_STATS_TAG		    = 90,
 	HTT_STATS_PEER_CTRL_PATH_TXRX_STATS_TAG		    = 101,
+	HTT_STATS_RX_PDEV_RATE_EXT_STATS_TAG                = 103,
 	HTT_STATS_PDEV_TX_RATE_TXBF_STATS_TAG		    = 108,
 	HTT_STATS_TXBF_OFDMA_NDPA_STATS_TAG		    = 113,
 	HTT_STATS_TXBF_OFDMA_NDP_STATS_TAG		    = 114,
@@ -442,6 +443,12 @@ enum htt_stats_param_type {
 #define HTT_TX_PEER_STATS_NUM_MCS_COUNTERS        12
 #define HTT_TX_PEER_STATS_NUM_GI_COUNTERS          4
 #define HTT_TX_PEER_STATS_NUM_DCM_COUNTERS         5
+/* HTT_TX_PEER_STATS_NUM_BW_COUNTERS:
+ * bw index 0: rssi_pri20_chain0
+ * bw index 1: rssi_ext20_chain0
+ * bw index 2: rssi_ext40_low20_chain0
+ * bw index 3: rssi_ext40_high20_chain0
+ */
 #define HTT_TX_PEER_STATS_NUM_BW_COUNTERS          4
 #define HTT_TX_PEER_STATS_NUM_SPATIAL_STREAMS      8
 #define HTT_TX_PEER_STATS_NUM_PREAMBLE_TYPES       HTT_STATS_PREAM_COUNT
@@ -1986,4 +1993,37 @@ static inline int ath11k_debugfs_htt_stats_req(struct ath11k *ar)
 
 #endif /* CONFIG_ATH11K_DEBUGFS */
 
+/* == PDEV RX RATE EXT STATS == */
+#define HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT 14
+/* HTT_RX_PEER_STATS_NUM_BW_EXT_COUNTERS:
+ * bw index 4 (bw ext index 0): rssi_ext80_low20_chain0
+ * bw index 5 (bw ext index 1): rssi_ext80_low_high20_chain0
+ * bw index 6 (bw ext index 2): rssi_ext80_high_low20_chain0
+ * bw index 7 (bw ext index 3): rssi_ext80_high20_chain0
+ */
+#define HTT_RX_PEER_STATS_NUM_BW_EXT_COUNTERS 4
+#define HTT_RX_PDEV_STATS_NUM_BW_EXT_COUNTERS 4
+
+struct htt_rx_pdev_rate_ext_stats_tlv {
+	u8 rssi_chain_ext[HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS]
+			 [HTT_RX_PDEV_STATS_NUM_BW_EXT_COUNTERS];
+	/* units = dB above noise floor */
+	s8 rx_per_chain_rssi_ext_in_dbm[HTT_RX_PDEV_STATS_NUM_SPATIAL_STREAMS]
+				       [HTT_RX_PDEV_STATS_NUM_BW_EXT_COUNTERS];
+	/* rx mcast signal strength value in dBm unit */
+	s32 rssi_mcast;
+	/* rx mgmt packet signal strength value in dBm unit */
+	s32 rssi_mgmt;
+	u32 rx_mcs_ext[HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT];
+	u32 rx_stbc_ext[HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT];
+	u32 rx_gi_ext[HTT_RX_PDEV_STATS_NUM_GI_COUNTERS]
+		     [HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT];
+	u32 ul_ofdma_rx_mcs_ext[HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT];
+	u32 ul_ofdma_rx_gi_ext[HTT_TX_PDEV_STATS_NUM_GI_COUNTERS]
+			      [HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT];
+	u32 rx_11ax_su_txbf_mcs_ext[HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT];
+	u32 rx_11ax_mu_txbf_mcs_ext[HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT];
+	u32 rx_11ax_dl_ofdma_mcs_ext[HTT_RX_PDEV_STATS_NUM_MCS_COUNTERS_EXT];
+};
+
 #endif
-- 
2.17.1

