Return-Path: <linux-wireless+bounces-139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B3F7FB03D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 03:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A6D3B20DFD
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 02:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2A6569D;
	Tue, 28 Nov 2023 02:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TvFAwpHq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE311B4
	for <linux-wireless@vger.kernel.org>; Mon, 27 Nov 2023 18:55:02 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AS0Lvp6018767;
	Tue, 28 Nov 2023 02:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=jFfxbUKDNZR0heLrwBzO6lF1GFRgVK6qkg+YMCfKunk=;
 b=TvFAwpHqYS2KX9mqxLAPStr09mYpJgQdtDB+K7/Ht8k+aXFIZ+Pfajv0GbtPczzF2fwW
 iXntegD5EetHM0qEW+H7xOVXC5Ud4Z0NYXVZmlfoksPYsO0uW86aniM6ewNj/+8Sf4Bo
 UVEevT4xB1apCwWieZSC7pt3fmsUJvdfeFel/20eXXUdX5ceMNOz5icczdHtOhfzVFQb
 RtCP96cncJmeogVIIssRiG3T86OBeuxCXA1/ewNYJuRzTtfnRn01BNacveNI7ZZ53lVx
 RBOas+TQZorHDBQYF6ZPZwLnuDkOmTOK7mewjjJAtbnMGS/nsO2EAgoj3BV8cLiv698e Fg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3umt9c24mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 02:54:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AS2swvu019621
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Nov 2023 02:54:58 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 27 Nov 2023 18:54:57 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/3] wifi: ath12k: add support for BA1024
Date: Tue, 28 Nov 2023 10:54:39 +0800
Message-ID: <20231128025440.46988-3-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231128025440.46988-1-quic_bqiang@quicinc.com>
References: <20231128025440.46988-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XTVDYWS1nINOuXMUVGZUrqizg-fJHXpz
X-Proofpoint-ORIG-GUID: XTVDYWS1nINOuXMUVGZUrqizg-fJHXpz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_01,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 impostorscore=0 mlxlogscore=921
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311280021

Currently the maximum block ACK window size supported is 256.
This results in that, when connected to an AP which supports
larger BA sizes like BA512 or BA1024, only BA256 is
established, leading to a lower peak throughput.

So add support for BA1024, this is doen by allocating a larger
REO queue and advertising IEEE80211_MAX_AMPDU_BUF_EHT support
to MAC80211.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.h       |  2 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h | 28 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/hal_rx.c   | 11 ++++++---
 drivers/net/wireless/ath/ath12k/mac.c      |  2 +-
 4 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 61f765432516..50db1403ebce 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -145,7 +145,7 @@ struct ath12k_pdev_dp {
 
 #define DP_RX_HASH_ENABLE	1 /* Enable hash based Rx steering */
 
-#define DP_BA_WIN_SZ_MAX	256
+#define DP_BA_WIN_SZ_MAX	1024
 
 #define DP_TCL_NUM_RING_MAX	4
 
diff --git a/drivers/net/wireless/ath/ath12k/hal_desc.h b/drivers/net/wireless/ath/ath12k/hal_desc.h
index ec204939e50c..f12977aa6afe 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -2517,6 +2517,34 @@ struct hal_reo_update_rx_queue {
 	__le32 pn[4];
 } __packed;
 
+struct hal_rx_reo_queue_1k {
+	struct hal_desc_header desc_hdr;
+	__le32 rx_bitmap_319_288;
+	__le32 rx_bitmap_351_320;
+	__le32 rx_bitmap_383_352;
+	__le32 rx_bitmap_415_384;
+	__le32 rx_bitmap_447_416;
+	__le32 rx_bitmap_479_448;
+	__le32 rx_bitmap_511_480;
+	__le32 rx_bitmap_543_512;
+	__le32 rx_bitmap_575_544;
+	__le32 rx_bitmap_607_576;
+	__le32 rx_bitmap_639_608;
+	__le32 rx_bitmap_671_640;
+	__le32 rx_bitmap_703_672;
+	__le32 rx_bitmap_735_704;
+	__le32 rx_bitmap_767_736;
+	__le32 rx_bitmap_799_768;
+	__le32 rx_bitmap_831_800;
+	__le32 rx_bitmap_863_832;
+	__le32 rx_bitmap_895_864;
+	__le32 rx_bitmap_927_896;
+	__le32 rx_bitmap_959_928;
+	__le32 rx_bitmap_991_960;
+	__le32 rx_bitmap_1023_992;
+	__le32 reserved[8];
+} __packed;
+
 #define HAL_REO_UNBLOCK_CACHE_INFO0_UNBLK_CACHE		BIT(0)
 #define HAL_REO_UNBLOCK_CACHE_INFO0_RESOURCE_IDX	GENMASK(2, 1)
 
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.c b/drivers/net/wireless/ath/ath12k/hal_rx.c
index f6afbd8196bf..6fa874a93d3a 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.c
@@ -688,23 +688,28 @@ void ath12k_hal_reo_update_rx_reo_queue_status(struct ath12k_base *ab,
 
 u32 ath12k_hal_reo_qdesc_size(u32 ba_window_size, u8 tid)
 {
-	u32 num_ext_desc;
+	u32 num_ext_desc, num_1k_desc = 0;
 
 	if (ba_window_size <= 1) {
 		if (tid != HAL_DESC_REO_NON_QOS_TID)
 			num_ext_desc = 1;
 		else
 			num_ext_desc = 0;
+
 	} else if (ba_window_size <= 105) {
 		num_ext_desc = 1;
 	} else if (ba_window_size <= 210) {
 		num_ext_desc = 2;
-	} else {
+	} else if (ba_window_size <= 256) {
 		num_ext_desc = 3;
+	} else {
+		num_ext_desc = 10;
+		num_1k_desc = 1;
 	}
 
 	return sizeof(struct hal_rx_reo_queue) +
-		(num_ext_desc * sizeof(struct hal_rx_reo_queue_ext));
+		(num_ext_desc * sizeof(struct hal_rx_reo_queue_ext)) +
+		(num_1k_desc * sizeof(struct hal_rx_reo_queue_1k));
 }
 
 void ath12k_hal_reo_qdesc_setup(struct hal_rx_reo_queue *qdesc,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index fc0d14ea328e..3cfb17f71aa6 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7474,7 +7474,7 @@ static int __ath12k_mac_register(struct ath12k *ar)
 	ar->hw->queues = ATH12K_HW_MAX_QUEUES;
 	ar->hw->wiphy->tx_queue_len = ATH12K_QUEUE_LEN;
 	ar->hw->offchannel_tx_hw_queue = ATH12K_HW_MAX_QUEUES - 1;
-	ar->hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
+	ar->hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_EHT;
 
 	ar->hw->vif_data_size = sizeof(struct ath12k_vif);
 	ar->hw->sta_data_size = sizeof(struct ath12k_sta);
-- 
2.25.1


