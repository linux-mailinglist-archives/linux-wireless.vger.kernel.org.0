Return-Path: <linux-wireless+bounces-24053-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF181AD6F59
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 13:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2DF171208
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 11:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9941442F4;
	Thu, 12 Jun 2025 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ALhpjvX0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14580C13D
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 11:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728813; cv=none; b=rvV4ZdrWokppXlJ8GxzprRBpEXugjj5egdQbnxEZLCwtRbRw0sbF7N7Ps10RDvoXpMI1L73uTUuE5udE5JejKSLx36qPlTPupaWUju/f4EzVuq8siCGMEh6eVVSDhiMFLV5ojJmA6ZwmUAlF2qdZXJ6qFilWX28rIWC29q6DckU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728813; c=relaxed/simple;
	bh=ESInumtKtHuQhvo1aP7n/YNSylSFwU7pK9A7yfLKRu8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r5fDpiH7kSsVqkXdN0lJP/FfN4P8FxwJ86ZLT774xuXPQ2ZrdP8cfR+YsTf/TxhhpusWEYR4JOr8w31joPTj4zt71Fmj8aDRM0eoLOWL8qvqAgsHatrCmhvBf+6upbt2QPKIqXje2TxB6EDyqefOuJd4lzC2w6SAcibZ2+W2nZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ALhpjvX0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C8DjTr013459;
	Thu, 12 Jun 2025 11:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=tRlSqXWvhEswQjV14frkTW
	dUGfsegC+OB/RG0k7MWyE=; b=ALhpjvX00RNejqzOWvMlMB89bActYjXItDzaDv
	Z8IaYEEo3benw5Jqd8H/JpcWlC/eEbxoJNUJmhwY0ygj2IVoZdcmA3YLuzWDek7y
	rl3I/I46ux6x7emQo2RJlwKVI3J9NKUUxzj/R0X1ukCC69M4gjDKh6CgvFUsGov7
	Cf5/X7wbLcmym9LYvaCSjPw5QczlNuZwWvhWDOcZKFLdEigeHL0z+DiYzyLQbsLO
	EPY8Cp7l4ZmCtleUSyxN7CeRBcaN8NPpJ16vHc2O2uWCTdyX7TCiZAZ7lPxrtWKa
	WkmxU90uMgEuSg6usdLxlciD/kUoWGjebT0sRvLMXUUO4Rrw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 476fmng0aq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 11:46:48 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55CBkcOt025976
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 11:46:38 GMT
Received: from hu-ssreeela-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 12 Jun 2025 04:46:36 -0700
From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sivashankari Madhavan
	<quic_sivamadh@quicinc.com>,
        Sowmiya Sree Elavalagan
	<quic_ssreeela@quicinc.com>
Subject: [PATCH ath-next v2] wifi: ath12k: support average ack rssi in station dump
Date: Thu, 12 Jun 2025 17:16:20 +0530
Message-ID: <20250612114620.1055840-1-quic_ssreeela@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -V-jY0sGEMaTeZ4XrwNJf6rSfVNDbVXI
X-Proofpoint-GUID: -V-jY0sGEMaTeZ4XrwNJf6rSfVNDbVXI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA4OSBTYWx0ZWRfX3mAOCRiXcQaG
 ZBTxrCw22W7+zhK2LRdfP+dpn8ZHbBfgQ2/HWp9NJHX37XiTiHckCdu5KDkQBD4TKL+FVwMifQU
 Rb3/qiwXcQi+fepvKElY1GKaDwlIFhver1KvSYqix/whvCDGKGyJlGKcU6VSOyFNC6sEWEEyKFG
 iqt6F5nd0Z74RW3/YNnaUbgFQJxULoaawBTG6099uWIdKCdQzg7Qw/0fTUzKaxOImxWrr+4V4WM
 MV2aWA0HPqhuBKhE4Si+j8k2+d7DbFiXiO0kKV8Saol9KVvYFLNH0Zt18uAF/3mkNBHqeD68zRy
 7Pn/RLNDDUYy8zGkZ51FVbQhmuds1LfgWge7MG0JOe9L/jpAjBtlVfKczvTI3frfQqW9Rp4W5Sv
 W5EComm3PQPhaoe2MmZ5kwVyfDVDFBcegKBlI6jC9aB3RwCgqZMsQX+rgXDem5Josua3hZ9Y
X-Authority-Analysis: v=2.4 cv=K8wiHzWI c=1 sm=1 tr=0 ts=684abe29 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=cKTmG8GoOr_ubyX9ojwA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506120089

From: Sivashankari Madhavan <quic_sivamadh@quicinc.com>

Currently, the ACK RSSI value is not shown in station dump. Enable WMI
resource flag for ACK RSSI in WMI INIT command to add ACK RSSI value in
management TX completion event from WMI. Update ACK RSSI value obtained
in management and data frame completion path to ieee80211_tx_info. Also
advertise NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT flag during hardware
register to mac80211 layer so that ACK RSSI is added to station dump
message.

Example output :
Station 00:03:7f:01:5c:4b (on wlp88s0)
        inactive time:  46584 ms
        rx bytes:       955
        rx packets:     10
        tx bytes:       769
        tx packets:     6
        tx retries:     81
        tx failed:      0
        rx drop misc:   0
        signal:         -39 dBm
        signal avg:     -40 dBm
        tx bitrate:     6.0 MBit/s
        tx duration:    1185 us
        rx bitrate:     309.7 MBit/s 40MHz HE-MCS 6 HE-NSS 2 HE-GI 0 HE-DCM 0
        rx duration:    0 us
        last ack signal:-41 dBm
        avg ack signal: -40 dBm
        authorized:     yes
        authenticated:  yes
	.......

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sivashankari Madhavan <quic_sivamadh@quicinc.com>
Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
---
v2:- Rebased

---
 drivers/net/wireless/ath/ath12k/dp_tx.c |  3 +++
 drivers/net/wireless/ath/ath12k/mac.c   |  1 +
 drivers/net/wireless/ath/ath12k/wmi.c   | 15 +++++++++++----
 drivers/net/wireless/ath/ath12k/wmi.h   |  3 +++
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index b6816b6c2c04..f65814deebf7 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -890,6 +890,9 @@ static void ath12k_dp_tx_status_parse(struct ath12k_base *ab,
 
 	ts->peer_id = le32_get_bits(desc->info3, HAL_WBM_COMPL_TX_INFO3_PEER_ID);
 
+	ts->ack_rssi = le32_get_bits(desc->info2,
+				     HAL_WBM_COMPL_TX_INFO2_ACK_FRAME_RSSI);
+
 	if (info0 & HAL_TX_RATE_STATS_INFO0_VALID) {
 		ts->pkt_type = u32_get_bits(info0, HAL_TX_RATE_STATS_INFO0_PKT_TYPE);
 		ts->mcs = u32_get_bits(info0, HAL_TX_RATE_STATS_INFO0_MCS);
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 88b59f3ff87a..c307d6fe5e80 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -12071,6 +12071,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_STA_TX_PWR);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT);
 
 	wiphy->cipher_suites = cipher_suites;
 	wiphy->n_cipher_suites = ARRAY_SIZE(cipher_suites);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 60e2444fe08c..1a238ef36a72 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -3875,7 +3875,8 @@ ath12k_wmi_copy_resource_config(struct ath12k_base *ab,
 	wmi_cfg->max_bssid_rx_filters = cpu_to_le32(tg_cfg->max_bssid_rx_filters);
 	wmi_cfg->use_pdev_id = cpu_to_le32(tg_cfg->use_pdev_id);
 	wmi_cfg->flag1 = cpu_to_le32(tg_cfg->atf_config |
-				     WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64);
+				     WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64 |
+				     WMI_RSRC_CFG_FLAG1_ACK_RSSI);
 	wmi_cfg->peer_map_unmap_version = cpu_to_le32(tg_cfg->peer_map_unmap_version);
 	wmi_cfg->sched_params = cpu_to_le32(tg_cfg->sched_params);
 	wmi_cfg->twt_ap_pdev_count = cpu_to_le32(tg_cfg->twt_ap_pdev_count);
@@ -5582,7 +5583,7 @@ static int ath12k_pull_mgmt_rx_params_tlv(struct ath12k_base *ab,
 }
 
 static int wmi_process_mgmt_tx_comp(struct ath12k *ar, u32 desc_id,
-				    u32 status)
+				    u32 status, u32 ack_rssi)
 {
 	struct sk_buff *msdu;
 	struct ieee80211_tx_info *info;
@@ -5606,8 +5607,11 @@ static int wmi_process_mgmt_tx_comp(struct ath12k *ar, u32 desc_id,
 	dma_unmap_single(ar->ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 
 	info = IEEE80211_SKB_CB(msdu);
-	if ((!(info->flags & IEEE80211_TX_CTL_NO_ACK)) && !status)
+	if ((!(info->flags & IEEE80211_TX_CTL_NO_ACK)) && !status) {
 		info->flags |= IEEE80211_TX_STAT_ACK;
+		info->status.ack_signal = ack_rssi;
+		info->status.flags |= IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
+	}
 
 	if ((info->flags & IEEE80211_TX_CTL_NO_ACK) && !status)
 		info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
@@ -5651,6 +5655,8 @@ static int ath12k_pull_mgmt_tx_compl_param_tlv(struct ath12k_base *ab,
 	param->pdev_id = ev->pdev_id;
 	param->desc_id = ev->desc_id;
 	param->status = ev->status;
+	param->ppdu_id = ev->ppdu_id;
+	param->ack_rssi = ev->ack_rssi;
 
 	kfree(tb);
 	return 0;
@@ -6552,7 +6558,8 @@ static void ath12k_mgmt_tx_compl_event(struct ath12k_base *ab, struct sk_buff *s
 	}
 
 	wmi_process_mgmt_tx_comp(ar, le32_to_cpu(tx_compl_param.desc_id),
-				 le32_to_cpu(tx_compl_param.status));
+				 le32_to_cpu(tx_compl_param.status),
+				 le32_to_cpu(tx_compl_param.ack_rssi));
 
 	ath12k_dbg(ab, ATH12K_DBG_MGMT,
 		   "mgmt tx compl ev pdev_id %d, desc_id %d, status %d",
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index ac18f75e0449..49010367dc06 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2486,6 +2486,7 @@ struct wmi_init_cmd {
 #define WMI_RSRC_CFG_FLAGS2_RX_PEER_METADATA_VERSION		GENMASK(5, 4)
 #define WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64	BIT(5)
 #define WMI_RSRC_CFG_FLAGS2_CALC_NEXT_DTIM_COUNT_SET      BIT(9)
+#define WMI_RSRC_CFG_FLAG1_ACK_RSSI	BIT(18)
 
 struct ath12k_wmi_resource_config_params {
 	__le32 tlv_header;
@@ -4445,6 +4446,8 @@ struct wmi_mgmt_tx_compl_event {
 	__le32 desc_id;
 	__le32 status;
 	__le32 pdev_id;
+	__le32 ppdu_id;
+	__le32 ack_rssi;
 } __packed;
 
 struct wmi_scan_event {

base-commit: 9f92c4a01c5268f57fa19dd7cbcb1f59b0e66da6
-- 
2.25.1


