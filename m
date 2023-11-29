Return-Path: <linux-wireless+bounces-185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B32E7FCC88
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 03:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E763B21639
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 02:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E145E3D64;
	Wed, 29 Nov 2023 02:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YYwr8XvZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD1419A4
	for <linux-wireless@vger.kernel.org>; Tue, 28 Nov 2023 18:04:41 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AT1u8oc012440;
	Wed, 29 Nov 2023 02:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=FLYNQkj8FvlppKlPPuRRVPtLHORqbWX61BhzXxljw/o=;
 b=YYwr8XvZqym/G3v3/Z4tR9PgU51PQD1yTfgu8KObIoyQ8d3tn2EvkqwlDtCWEq+o435/
 6Hn9WagCxhNXGnN4OoOAF8b3P8Ng/WBZ1eK4+f5/diZJptu3MgqEnAiNdofHAQyQlKWv
 672OyuQIcm6v+RGSFdleXcjq//hm4InebTlkKM8ugEldMth92OeJ0O+TAgdCAEzHDEHX
 myb7U31CYKobBTgAY+yPeb747aVbtAYfTFN3+hfzLLjJy11h2QwPhwEGoLV45C/Q6Fhm
 Sip4PhNbEfZs+GlM03z7398wVLYoQ5WmK7hYRAuyNuiM/axmFpyk/FpioIoArMbHqzo7 Ow== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3unmra8y8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 02:04:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AT24bS0025271
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Nov 2023 02:04:37 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 28 Nov 2023 18:04:35 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 2/3] wifi: ath12k: add support for BA1024
Date: Wed, 29 Nov 2023 10:04:13 +0800
Message-ID: <20231129020414.56425-3-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129020414.56425-1-quic_bqiang@quicinc.com>
References: <20231129020414.56425-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V983sTfUXftAxv-2l8e7odOWVWp1cR_j
X-Proofpoint-ORIG-GUID: V983sTfUXftAxv-2l8e7odOWVWp1cR_j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_27,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=923 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311290014

Currently the maximum block ACK window size supported is 256.
This results in that, when connected to an AP which supports
larger BA sizes like BA512 or BA1024, only BA256 is
established, leading to a lower peak throughput.

So add support for BA1024, this is done by allocating a larger
REO queue and advertising IEEE80211_MAX_AMPDU_BUF_EHT support
to MAC80211.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
v2:
 1. s/doen/done/
 2. update struct hal_rx_reo_queue_1k.

 drivers/net/wireless/ath/ath12k/dp.h       |  2 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h |  6 ++++++
 drivers/net/wireless/ath/ath12k/hal_rx.c   | 11 ++++++++---
 drivers/net/wireless/ath/ath12k/mac.c      |  2 +-
 4 files changed, 16 insertions(+), 5 deletions(-)

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
index ec204939e50c..63340256d3f6 100644
--- a/drivers/net/wireless/ath/ath12k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/hal_desc.h
@@ -2517,6 +2517,12 @@ struct hal_reo_update_rx_queue {
 	__le32 pn[4];
 } __packed;
 
+struct hal_rx_reo_queue_1k {
+	struct hal_desc_header desc_hdr;
+	__le32 rx_bitmap_1023_288[23];
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


