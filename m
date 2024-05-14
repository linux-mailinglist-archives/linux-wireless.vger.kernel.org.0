Return-Path: <linux-wireless+bounces-7637-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C078C5631
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 14:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEE6AB21C2E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 12:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103F347F5D;
	Tue, 14 May 2024 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c12DlqAG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1DD1879
	for <linux-wireless@vger.kernel.org>; Tue, 14 May 2024 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715691019; cv=none; b=SOcGHdnmAo6W4cznKyfPYJH3QGoi0znYno1Krts+R5+Qb9jL/ka/PQFVm+1u/wbTEm7krnEj0b82PZ+jzt6ree2jqfluyCzTgV/0zKN75W5dqbdKPM9C87nL47x/VjDS4kK++33rK4NNJ4oRBJaLIKSNrm/fZhQxCc4aLqkXzNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715691019; c=relaxed/simple;
	bh=+tHBIIzmTCTWm0UmLugkmh7RfsXv1ibeBsIMia2zGdo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sxHFmLGkRJO5X9z1y2Uy07lf8AhxjmhuzcnKund9OWbljlrqcxI4c69Nu5GO1eoL8QgIBNAKSSg5qUGzbHWHr4HMklNQPVosgJe3RZhFbP88kKhrojGkUDej1929kvDW2wDPUjCHOzuGW4HeR1mK4d2Hfivu3nnJlszvoVIcZm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c12DlqAG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44E8PXIU017496;
	Tue, 14 May 2024 12:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=MOVpGdQ
	8FxzcRFJ8lhvgSsrZNmMtP5un52qVGsr3Vb8=; b=c12DlqAGnClRNI/x3mgVuwb
	Xgyr0FBfsOByOQc9wifophPhFCdc9o4oxNmnvDaKFxYYfZVJ8WsShVW+d7O3w4J6
	zvTGkLepHyhrtod3Ggw7dx4I8/bPm86ABFxXlOq5Iyo+i8tcdj1LJ0wca5Q1Omir
	uE4SBhFheeltUFVUYCyhkbKTxbXK+pm5k1sFyXODAUbLkykIPmfEygOjPpTvib4J
	GoQwXHF2oVW2IZfAcsDz00iMuyb5SV8mEnvlYAFGiXaSb8AhafGOjifm3p33O+U+
	m6gkJ3Bk7TaeivFhfNrh1GHUmVHphukDUEFlit1/CC+OJ7mZB+hCWQ8pT3J23ig=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y20w1x8b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 12:50:12 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44ECoB9u024298
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 12:50:11 GMT
Received: from hu-ssreeela-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 14 May 2024 05:50:09 -0700
From: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sivashankari Madhavan
	<quic_sivamadh@quicinc.com>,
        Sowmiya Sree Elavalagan
	<quic_ssreeela@quicinc.com>
Subject: [PATCH] wifi: ath12k: support average ack rssi in station dump
Date: Tue, 14 May 2024 18:19:49 +0530
Message-ID: <20240514124949.2197384-1-quic_ssreeela@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Hw5dxXIoZJdZTKzL9i3rw7XkReZgQ5Ox
X-Proofpoint-GUID: Hw5dxXIoZJdZTKzL9i3rw7XkReZgQ5Ox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_06,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405140091

From: Sivashankari Madhavan <quic_sivamadh@quicinc.com>

Currently, the ACK RSSI value is not shown in station dump. Enable WMI
resource flag for ACK RSSI in WMI INIT command to add ACK RSSI value in
management TX completion event from WMI. Update ACK RSSI value obtained
in management and data frame completion path to ieee80211_tx_info. Also
advertise NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT flag during hardware
register to mac80211 layer so that ACK RSSI is added to station dump
message.

Example output :
Station 00:03:7f:12:cc:cc (on wlo1)
        inactive time:  600 ms
        rx bytes:       288106
        rx packets:     1446
        tx bytes:       41818
        tx packets:     342
        tx retries:     64
        tx failed:      0
        beacon loss:    0
        beacon rx:      602
        rx drop misc:   51
        signal:         0 dBm
        beacon signal avg:      -44 dBm
        tx duration:    0 us
        rx bitrate:     1441.1 MBit/s 80MHz HE-MCS 9 HE-NSS 3 HE-GI 0 HE-DCM 0
        rx duration:    0 us
        last ack signal:-51 dBm
        avg ack signal: -50 dBm
        authorized:     yes
        .......

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sivashankari Madhavan <quic_sivamadh@quicinc.com>
Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>

Depends-On: wifi: ath12k: fix the issue that calculation of ack signal strength
 https://patchwork.kernel.org/project/linux-wireless/patch/20240511030917.65811-1-quic_lingbok@quicinc.com/
---
 drivers/net/wireless/ath/ath12k/dp_tx.c |  2 ++
 drivers/net/wireless/ath/ath12k/mac.c   |  1 +
 drivers/net/wireless/ath/ath12k/wmi.c   | 15 +++++++++++----
 drivers/net/wireless/ath/ath12k/wmi.h   |  3 +++
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 32496015cf9a..43bdb49d08e2 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -541,6 +541,8 @@ static void ath12k_dp_tx_status_parse(struct ath12k_base *ab,
 
 	ts->ppdu_id = le32_get_bits(desc->info1,
 				    HAL_WBM_COMPL_TX_INFO1_TQM_STATUS_NUMBER);
+	ts->ack_rssi = le32_get_bits(desc->info2,
+				     HAL_WBM_COMPL_TX_INFO2_ACK_FRAME_RSSI);
 	if (le32_to_cpu(desc->rate_stats.info0) & HAL_TX_RATE_STATS_INFO0_VALID)
 		ts->rate_stats = le32_to_cpu(desc->rate_stats.info0);
 	else
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 96dc5c2e096f..1f4739269544 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8733,6 +8733,7 @@ static int ath12k_mac_hw_register(struct ath12k_hw *ah)
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_STA_TX_PWR);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT);
 
 	wiphy->cipher_suites = cipher_suites;
 	wiphy->n_cipher_suites = ARRAY_SIZE(cipher_suites);
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 3004c7463be9..fe909d866539 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -3468,7 +3468,8 @@ ath12k_wmi_copy_resource_config(struct ath12k_wmi_resource_config_params *wmi_cf
 	wmi_cfg->max_bssid_rx_filters = cpu_to_le32(tg_cfg->max_bssid_rx_filters);
 	wmi_cfg->use_pdev_id = cpu_to_le32(tg_cfg->use_pdev_id);
 	wmi_cfg->flag1 = cpu_to_le32(tg_cfg->atf_config |
-				     WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64);
+				     WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64 |
+				     WMI_RSRC_CFG_FLAG1_ACK_RSSI);
 	wmi_cfg->peer_map_unmap_version = cpu_to_le32(tg_cfg->peer_map_unmap_version);
 	wmi_cfg->sched_params = cpu_to_le32(tg_cfg->sched_params);
 	wmi_cfg->twt_ap_pdev_count = cpu_to_le32(tg_cfg->twt_ap_pdev_count);
@@ -5134,7 +5135,7 @@ static int ath12k_pull_mgmt_rx_params_tlv(struct ath12k_base *ab,
 }
 
 static int wmi_process_mgmt_tx_comp(struct ath12k *ar, u32 desc_id,
-				    u32 status)
+				    u32 status, u32 ack_rssi)
 {
 	struct sk_buff *msdu;
 	struct ieee80211_tx_info *info;
@@ -5158,8 +5159,11 @@ static int wmi_process_mgmt_tx_comp(struct ath12k *ar, u32 desc_id,
 	dma_unmap_single(ar->ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
 
 	info = IEEE80211_SKB_CB(msdu);
-	if ((!(info->flags & IEEE80211_TX_CTL_NO_ACK)) && !status)
+	if ((!(info->flags & IEEE80211_TX_CTL_NO_ACK)) && !status) {
 		info->flags |= IEEE80211_TX_STAT_ACK;
+		info->status.ack_signal = ack_rssi;
+		info->status.flags |= IEEE80211_TX_STATUS_ACK_SIGNAL_VALID;
+	}
 
 	ieee80211_tx_status_irqsafe(ath12k_ar_to_hw(ar), msdu);
 
@@ -5200,6 +5204,8 @@ static int ath12k_pull_mgmt_tx_compl_param_tlv(struct ath12k_base *ab,
 	param->pdev_id = ev->pdev_id;
 	param->desc_id = ev->desc_id;
 	param->status = ev->status;
+	param->ppdu_id = ev->ppdu_id;
+	param->ack_rssi = ev->ack_rssi;
 
 	kfree(tb);
 	return 0;
@@ -6110,7 +6116,8 @@ static void ath12k_mgmt_tx_compl_event(struct ath12k_base *ab, struct sk_buff *s
 	}
 
 	wmi_process_mgmt_tx_comp(ar, le32_to_cpu(tx_compl_param.desc_id),
-				 le32_to_cpu(tx_compl_param.status));
+				 le32_to_cpu(tx_compl_param.status),
+				 le32_to_cpu(tx_compl_param.ack_rssi));
 
 	ath12k_dbg(ab, ATH12K_DBG_MGMT,
 		   "mgmt tx compl ev pdev_id %d, desc_id %d, status %d",
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 496866673aea..7ebd52a7ebb8 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -2410,6 +2410,7 @@ struct wmi_init_cmd {
 #define WMI_RSRC_CFG_HOST_SVC_FLAG_REG_CC_EXT_SUPPORT_BIT 4
 #define WMI_RSRC_CFG_FLAGS2_RX_PEER_METADATA_VERSION		GENMASK(5, 4)
 #define WMI_RSRC_CFG_FLAG1_BSS_CHANNEL_INFO_64	BIT(5)
+#define WMI_RSRC_CFG_FLAG1_ACK_RSSI BIT(18)
 
 struct ath12k_wmi_resource_config_params {
 	__le32 tlv_header;
@@ -4180,6 +4181,8 @@ struct wmi_mgmt_tx_compl_event {
 	__le32 desc_id;
 	__le32 status;
 	__le32 pdev_id;
+	__le32 ppdu_id;
+	__le32 ack_rssi;
 } __packed;
 
 struct wmi_scan_event {
-- 
2.34.1


