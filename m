Return-Path: <linux-wireless+bounces-26815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDC6B3A83F
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 19:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77CB7C6C02
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 17:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EB8337695;
	Thu, 28 Aug 2025 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g02Lng+T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3C732C301
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402585; cv=none; b=JEmCkhDkwSDi5WB+B24PK4lPdbLdC74fNxKyeDOM6DoMRh0txBrshgJWwkJ4ZW8WuRyeuGGs/xdkZ/4aSxf+kzqVUvun+PwfXUHqKae18p66jyI8GiC/DRqLE8po+f3ALmW4UWM8P7ET+HW+Eb+4ChtM2cj1WdqIgGTBZGggN1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402585; c=relaxed/simple;
	bh=iGdg0NVhq6JUNpkde2viVlECHWOP7/sOd9UpkZeb8Ik=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQRGkBXh0HRtN3SzubKqrx3OIeywTSO7agivxQoiCrEj+5oCpcdSxZ6/rdoKW8MdUyPRMEelDIno3vXzmJ+oUZE/E2y3zPLSnmnMQJIRED4buHTq4m9m20qAckaT51HFFwJr9Nq/1g9YG2/OksKBmc8PR9jO/yudtpLOWLbXUy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g02Lng+T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SESh0i008186;
	Thu, 28 Aug 2025 17:36:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZXp8YhLI4i3l5HIvF+1fR+SvCIw9yz0YJu/Mqq7opWY=; b=g02Lng+TQal1WUf/
	6sEuuVkH7IMGh+JWtnFefbz41UDKuYEZdcxQh4wgVBcx+C8ancN9NoeE+Hzy5vBN
	G7fs3dkArIjy554+j20hY7PwFznSqwlpGvb9SR9jpvXG1gU0eWXaleAsykZJVWR/
	V6Q+TFcCXvJL1qTPQtedhHvAGjTSMvXqYImq8BXHFlbMKCsT/BdEuxOkO0KW//PH
	C6QikNAwwdlcull8Q7/bH/iCCB+mvDMQKhd9JKnX1prxCEtA0sJqn1cT+fR+x7ik
	cjgGys3RM2UWnqEVgQrQ/SrR8s5ZQa3FDQv/G6hroYnK2kG6odb+B3kyepVUOd/5
	pXMFEw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48sh8aqcwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57SHaHKo013816
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 17:36:17 GMT
Received: from hu-rdeuri-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 28 Aug 2025 10:36:16 -0700
From: Ripan Deuri <quic_rdeuri@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath12k-ng 05/20] wifi: ath12k: Move Rx error related functions to wifi7 directory
Date: Thu, 28 Aug 2025 23:05:38 +0530
Message-ID: <20250828173553.3341351-6-quic_rdeuri@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
References: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=cLDgskeN c=1 sm=1 tr=0 ts=68b09392 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=lAj8jhxFeXQEYEgFjowA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDE1MyBTYWx0ZWRfX9dZ8Bou8iBjh
 0SUidDnR60SbG2TVWWFVUDcj3c3/LZGnzvWp52gIyUPqCiyfaUG2hyFFGyXNJXLCqqf/Fih3PrR
 +KZquYhjo1xwUjxSTAhTQNT/vx8OFK1rKv4+1e4iDdIYl/KymHVZnIg+Ub06vYr3Fr6avJ4wZ7P
 4Vu2UwtVzRjzbbp3MyIMlMikj2Fq/PXDJne64Y5FUl3LvPQJM7qGY6EisX8b7dKeUWxrl2aXgVo
 GESF7qTNRrvWvqYc7R0rp+7jXnqGzpe8cBBne1CEv+dL3hLy4OUTwqcXGZ0ua0kYyW5HvF8eyWv
 L3FXiS9E90fuZKmIAfv/zj+HKFXPfiB1SABs3WqxJoLrFJyIozSUocVIf8ofTiasgnHz60aGzN/
 +OWhb5qX
X-Proofpoint-GUID: 4vEUmjdxBEQ38Qp7dR3Dep-gjtaGZAj7
X-Proofpoint-ORIG-GUID: 4vEUmjdxBEQ38Qp7dR3Dep-gjtaGZAj7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508260153

From: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>

Move wifi7 architecture specific Rx error functions from dp_rx.c to
wifi7 directory.

The new wifi7-specific dp_rx.c file will continue to be part of ath12k.ko
temporarily until the corresponding infra for movement to the
ath12k_wifi7.ko arrives in upcoming patches.

Move following architecture specific APIs to wifi7 directory:

ath12k_dp_rx_h_tkip_mic_err
ath12k_dp_rx_h_rxdma_err
ath12k_dp_rx_h_reo_err
ath12k_dp_rx_wbm_err
ath12k_dp_rx_process_wbm_err

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Pavankumar Nandeshwar <quic_pnandesh@quicinc.com>
Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/Makefile      |   1 +
 drivers/net/wireless/ath/ath12k/dp.c          |   2 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c      |   4 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c       | 370 +-----------------
 drivers/net/wireless/ath/ath12k/dp_rx.h       |  18 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 350 +++++++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |  14 +
 7 files changed, 397 insertions(+), 362 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index b34cf83a24eb..d7628bb7af02 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -24,6 +24,7 @@ ath12k-$(CONFIG_ATH12K_AHB) += ahb.o
 
 ath12k-y += wifi7/hal_tx.o \
 	    wifi7/hal_rx.o \
+	    wifi7/dp_rx.o
 
 obj-$(CONFIG_ATH12K) += wifi7/
 
diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index a3170e02d4c7..1b4fab3073b0 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -10,7 +10,7 @@
 #include "wifi7/hal_tx.h"
 #include "hif.h"
 #include "debug.h"
-#include "dp_rx.h"
+#include "wifi7/dp_rx.h"
 #include "peer.h"
 #include "dp_mon.h"
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
index 8189e52ed007..b0a0e2a97e8f 100644
--- a/drivers/net/wireless/ath/ath12k/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include "dp_mon.h"
 #include "debug.h"
-#include "dp_rx.h"
+#include "wifi7/dp_rx.h"
 #include "dp_tx.h"
 #include "peer.h"
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index acd20417b650..453310080182 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2033,11 +2033,11 @@ static void ath12k_dp_rx_h_undecap_eth(struct ath12k *ar,
 	ether_addr_copy(ieee80211_get_SA(hdr), sa);
 }
 
-static void ath12k_dp_rx_h_undecap(struct ath12k *ar, struct sk_buff *msdu,
-				   struct hal_rx_desc *rx_desc,
-				   enum hal_encrypt_type enctype,
-				   struct ieee80211_rx_status *status,
-				   bool decrypted)
+void ath12k_dp_rx_h_undecap(struct ath12k *ar, struct sk_buff *msdu,
+			    struct hal_rx_desc *rx_desc,
+			    enum hal_encrypt_type enctype,
+			    struct ieee80211_rx_status *status,
+			    bool decrypted)
 {
 	struct ath12k_base *ab = ar->ab;
 	u8 decap;
@@ -2323,9 +2323,9 @@ void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct ath12k_dp_rx_info *rx_info)
 	ath12k_dp_rx_h_rate(ar, rx_info);
 }
 
-static void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *napi,
-				      struct sk_buff *msdu,
-				      struct ath12k_dp_rx_info *rx_info)
+void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *napi,
+			       struct sk_buff *msdu,
+			       struct ath12k_dp_rx_info *rx_info)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ieee80211_rx_status *rx_status;
@@ -2395,9 +2395,9 @@ static void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *nap
 	ieee80211_rx_napi(ath12k_ar_to_hw(ar), pubsta, msdu, napi);
 }
 
-static bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_base *ab,
-						   struct hal_rx_desc *rx_desc,
-						   struct sk_buff *msdu)
+bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_base *ab,
+					    struct hal_rx_desc *rx_desc,
+					    struct sk_buff *msdu)
 {
 	struct ieee80211_hdr *hdr;
 	u8 decap_type;
@@ -3584,9 +3584,9 @@ static void ath12k_dp_rx_null_q_desc_sg_drop(struct ath12k *ar,
 	}
 }
 
-static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
-				      struct ath12k_dp_rx_info *rx_info,
-				      struct sk_buff_head *msdu_list)
+int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
+			       struct ath12k_dp_rx_info *rx_info,
+			       struct sk_buff_head *msdu_list)
 {
 	struct ath12k_base *ab = ar->ab;
 	u16 msdu_len;
@@ -3654,348 +3654,6 @@ static int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
 	return 0;
 }
 
-static bool ath12k_dp_rx_h_reo_err(struct ath12k *ar, struct sk_buff *msdu,
-				   struct ath12k_dp_rx_info *rx_info,
-				   struct sk_buff_head *msdu_list)
-{
-	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
-	bool drop = false;
-
-	ar->ab->device_stats.reo_error[rxcb->err_code]++;
-
-	switch (rxcb->err_code) {
-	case HAL_REO_DEST_RING_ERROR_CODE_DESC_ADDR_ZERO:
-		if (ath12k_dp_rx_h_null_q_desc(ar, msdu, rx_info, msdu_list))
-			drop = true;
-		break;
-	case HAL_REO_DEST_RING_ERROR_CODE_PN_CHECK_FAILED:
-		/* TODO: Do not drop PN failed packets in the driver;
-		 * instead, it is good to drop such packets in mac80211
-		 * after incrementing the replay counters.
-		 */
-		fallthrough;
-	default:
-		/* TODO: Review other errors and process them to mac80211
-		 * as appropriate.
-		 */
-		drop = true;
-		break;
-	}
-
-	return drop;
-}
-
-static bool ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
-					struct ath12k_dp_rx_info *rx_info)
-{
-	struct ath12k_base *ab = ar->ab;
-	u16 msdu_len;
-	struct hal_rx_desc *desc = (struct hal_rx_desc *)msdu->data;
-	u8 l3pad_bytes;
-	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
-	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
-
-	rxcb->is_first_msdu = ath12k_dp_rx_h_first_msdu(ab, desc);
-	rxcb->is_last_msdu = ath12k_dp_rx_h_last_msdu(ab, desc);
-
-	l3pad_bytes = ath12k_dp_rx_h_l3pad(ab, desc);
-	msdu_len = ath12k_dp_rx_h_msdu_len(ab, desc);
-
-	if ((hal_rx_desc_sz + l3pad_bytes + msdu_len) > DP_RX_BUFFER_SIZE) {
-		ath12k_dbg(ab, ATH12K_DBG_DATA,
-			   "invalid msdu len in tkip mic err %u\n", msdu_len);
-		ath12k_dbg_dump(ab, ATH12K_DBG_DATA, NULL, "", desc,
-				sizeof(*desc));
-		return true;
-	}
-
-	skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
-	skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
-
-	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu)))
-		return true;
-
-	ath12k_dp_rx_h_ppdu(ar, rx_info);
-
-	rx_info->rx_status->flag |= (RX_FLAG_MMIC_STRIPPED | RX_FLAG_MMIC_ERROR |
-				     RX_FLAG_DECRYPTED);
-
-	ath12k_dp_rx_h_undecap(ar, msdu, desc,
-			       HAL_ENCRYPT_TYPE_TKIP_MIC, rx_info->rx_status, false);
-	return false;
-}
-
-static bool ath12k_dp_rx_h_rxdma_err(struct ath12k *ar,  struct sk_buff *msdu,
-				     struct ath12k_dp_rx_info *rx_info)
-{
-	struct ath12k_base *ab = ar->ab;
-	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
-	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)msdu->data;
-	bool drop = false;
-	u32 err_bitmap;
-
-	ar->ab->device_stats.rxdma_error[rxcb->err_code]++;
-
-	switch (rxcb->err_code) {
-	case HAL_REO_ENTR_RING_RXDMA_ECODE_DECRYPT_ERR:
-	case HAL_REO_ENTR_RING_RXDMA_ECODE_TKIP_MIC_ERR:
-		err_bitmap = ath12k_dp_rx_h_mpdu_err(ab, rx_desc);
-		if (err_bitmap & HAL_RX_MPDU_ERR_TKIP_MIC) {
-			ath12k_dp_rx_h_fetch_info(ab, rx_desc, rx_info);
-			drop = ath12k_dp_rx_h_tkip_mic_err(ar, msdu, rx_info);
-			break;
-		}
-		fallthrough;
-	default:
-		/* TODO: Review other rxdma error code to check if anything is
-		 * worth reporting to mac80211
-		 */
-		drop = true;
-		break;
-	}
-
-	return drop;
-}
-
-static void ath12k_dp_rx_wbm_err(struct ath12k *ar,
-				 struct napi_struct *napi,
-				 struct sk_buff *msdu,
-				 struct sk_buff_head *msdu_list)
-{
-	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
-	struct ieee80211_rx_status rxs = {};
-	struct ath12k_dp_rx_info rx_info;
-	bool drop = true;
-
-	rx_info.addr2_present = false;
-	rx_info.rx_status = &rxs;
-
-	switch (rxcb->err_rel_src) {
-	case HAL_WBM_REL_SRC_MODULE_REO:
-		drop = ath12k_dp_rx_h_reo_err(ar, msdu, &rx_info, msdu_list);
-		break;
-	case HAL_WBM_REL_SRC_MODULE_RXDMA:
-		drop = ath12k_dp_rx_h_rxdma_err(ar, msdu, &rx_info);
-		break;
-	default:
-		/* msdu will get freed */
-		break;
-	}
-
-	if (drop) {
-		dev_kfree_skb_any(msdu);
-		return;
-	}
-
-	rx_info.rx_status->flag |= RX_FLAG_SKIP_MONITOR;
-
-	ath12k_dp_rx_deliver_msdu(ar, napi, msdu, &rx_info);
-}
-
-int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
-				 struct napi_struct *napi, int budget)
-{
-	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
-	struct ath12k_hw_group *ag = ab->ag;
-	struct ath12k *ar;
-	struct ath12k_dp *dp = &ab->dp;
-	struct dp_rxdma_ring *rx_ring;
-	struct hal_rx_wbm_rel_info err_info;
-	struct hal_srng *srng;
-	struct sk_buff *msdu;
-	struct sk_buff_head msdu_list, scatter_msdu_list;
-	struct ath12k_skb_rxcb *rxcb;
-	void *rx_desc;
-	int num_buffs_reaped[ATH12K_MAX_DEVICES] = {};
-	int total_num_buffs_reaped = 0;
-	struct ath12k_rx_desc_info *desc_info;
-	struct ath12k_device_dp_stats *device_stats = &ab->device_stats;
-	struct ath12k_hw_link *hw_links = ag->hw_links;
-	struct ath12k_base *partner_ab;
-	u8 hw_link_id, device_id;
-	int ret, pdev_id;
-	struct hal_rx_desc *msdu_data;
-
-	__skb_queue_head_init(&msdu_list);
-	__skb_queue_head_init(&scatter_msdu_list);
-
-	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++)
-		INIT_LIST_HEAD(&rx_desc_used_list[device_id]);
-
-	srng = &ab->hal.srng_list[dp->rx_rel_ring.ring_id];
-	spin_lock_bh(&srng->lock);
-
-	ath12k_hal_srng_access_begin(ab, srng);
-
-	while (budget) {
-		rx_desc = ath12k_hal_srng_dst_get_next_entry(ab, srng);
-		if (!rx_desc)
-			break;
-
-		ret = ath12k_hal_wbm_desc_parse_err(ab, rx_desc, &err_info);
-		if (ret) {
-			ath12k_warn(ab,
-				    "failed to parse rx error in wbm_rel ring desc %d\n",
-				    ret);
-			continue;
-		}
-
-		desc_info = err_info.rx_desc;
-
-		/* retry manual desc retrieval if hw cc is not done */
-		if (!desc_info) {
-			desc_info = ath12k_dp_get_rx_desc(ab, err_info.cookie);
-			if (!desc_info) {
-				ath12k_warn(ab, "Invalid cookie in DP WBM rx error descriptor retrieval: 0x%x\n",
-					    err_info.cookie);
-				continue;
-			}
-		}
-
-		if (desc_info->magic != ATH12K_DP_RX_DESC_MAGIC)
-			ath12k_warn(ab, "WBM RX err, Check HW CC implementation");
-
-		msdu = desc_info->skb;
-		desc_info->skb = NULL;
-
-		device_id = desc_info->device_id;
-		partner_ab = ath12k_ag_to_ab(ag, device_id);
-		if (unlikely(!partner_ab)) {
-			dev_kfree_skb_any(msdu);
-
-			/* In any case continuation bit is set
-			 * in the previous record, cleanup scatter_msdu_list
-			 */
-			ath12k_dp_clean_up_skb_list(&scatter_msdu_list);
-			continue;
-		}
-
-		list_add_tail(&desc_info->list, &rx_desc_used_list[device_id]);
-
-		rxcb = ATH12K_SKB_RXCB(msdu);
-		dma_unmap_single(partner_ab->dev, rxcb->paddr,
-				 msdu->len + skb_tailroom(msdu),
-				 DMA_FROM_DEVICE);
-
-		num_buffs_reaped[device_id]++;
-		total_num_buffs_reaped++;
-
-		if (!err_info.continuation)
-			budget--;
-
-		if (err_info.push_reason !=
-		    HAL_REO_DEST_RING_PUSH_REASON_ERR_DETECTED) {
-			dev_kfree_skb_any(msdu);
-			continue;
-		}
-
-		msdu_data = (struct hal_rx_desc *)msdu->data;
-		rxcb->err_rel_src = err_info.err_rel_src;
-		rxcb->err_code = err_info.err_code;
-		rxcb->is_first_msdu = err_info.first_msdu;
-		rxcb->is_last_msdu = err_info.last_msdu;
-		rxcb->is_continuation = err_info.continuation;
-		rxcb->rx_desc = msdu_data;
-
-		if (err_info.continuation) {
-			__skb_queue_tail(&scatter_msdu_list, msdu);
-			continue;
-		}
-
-		hw_link_id = ath12k_dp_rx_get_msdu_src_link(partner_ab,
-							    msdu_data);
-		if (hw_link_id >= ATH12K_GROUP_MAX_RADIO) {
-			dev_kfree_skb_any(msdu);
-
-			/* In any case continuation bit is set
-			 * in the previous record, cleanup scatter_msdu_list
-			 */
-			ath12k_dp_clean_up_skb_list(&scatter_msdu_list);
-			continue;
-		}
-
-		if (!skb_queue_empty(&scatter_msdu_list)) {
-			struct sk_buff *msdu;
-
-			skb_queue_walk(&scatter_msdu_list, msdu) {
-				rxcb = ATH12K_SKB_RXCB(msdu);
-				rxcb->hw_link_id = hw_link_id;
-			}
-
-			skb_queue_splice_tail_init(&scatter_msdu_list,
-						   &msdu_list);
-		}
-
-		rxcb = ATH12K_SKB_RXCB(msdu);
-		rxcb->hw_link_id = hw_link_id;
-		__skb_queue_tail(&msdu_list, msdu);
-	}
-
-	/* In any case continuation bit is set in the
-	 * last record, cleanup scatter_msdu_list
-	 */
-	ath12k_dp_clean_up_skb_list(&scatter_msdu_list);
-
-	ath12k_hal_srng_access_end(ab, srng);
-
-	spin_unlock_bh(&srng->lock);
-
-	if (!total_num_buffs_reaped)
-		goto done;
-
-	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++) {
-		if (!num_buffs_reaped[device_id])
-			continue;
-
-		partner_ab = ath12k_ag_to_ab(ag, device_id);
-		rx_ring = &partner_ab->dp.rx_refill_buf_ring;
-
-		ath12k_dp_rx_bufs_replenish(ab, rx_ring,
-					    &rx_desc_used_list[device_id],
-					    num_buffs_reaped[device_id]);
-	}
-
-	rcu_read_lock();
-	while ((msdu = __skb_dequeue(&msdu_list))) {
-		rxcb = ATH12K_SKB_RXCB(msdu);
-		hw_link_id = rxcb->hw_link_id;
-
-		device_id = hw_links[hw_link_id].device_id;
-		partner_ab = ath12k_ag_to_ab(ag, device_id);
-		if (unlikely(!partner_ab)) {
-			ath12k_dbg(ab, ATH12K_DBG_DATA,
-				   "Unable to process WBM error msdu due to invalid hw link id %d device id %d\n",
-				   hw_link_id, device_id);
-			dev_kfree_skb_any(msdu);
-			continue;
-		}
-
-		pdev_id = ath12k_hw_mac_id_to_pdev_id(partner_ab->hw_params,
-						      hw_links[hw_link_id].pdev_idx);
-		ar = partner_ab->pdevs[pdev_id].ar;
-
-		if (!ar || !rcu_dereference(ar->ab->pdevs_active[pdev_id])) {
-			dev_kfree_skb_any(msdu);
-			continue;
-		}
-
-		if (test_bit(ATH12K_FLAG_CAC_RUNNING, &ar->dev_flags)) {
-			dev_kfree_skb_any(msdu);
-			continue;
-		}
-
-		if (rxcb->err_rel_src < HAL_WBM_REL_SRC_MODULE_MAX) {
-			device_id = ar->ab->device_id;
-			device_stats->rx_wbm_rel_source[rxcb->err_rel_src][device_id]++;
-		}
-
-		ath12k_dp_rx_wbm_err(ar, napi, msdu, &msdu_list);
-	}
-	rcu_read_unlock();
-done:
-	return total_num_buffs_reaped;
-}
-
 void ath12k_dp_rx_process_reo_status(struct ath12k_base *ab)
 {
 	struct ath12k_dp *dp = &ab->dp;
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
index 61861c63ecbf..1909f9070d46 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -340,6 +340,20 @@ static inline void ath12k_dp_clean_up_skb_list(struct sk_buff_head *skb_list)
 		dev_kfree_skb_any(skb);
 }
 
+void ath12k_dp_rx_h_undecap(struct ath12k *ar, struct sk_buff *msdu,
+			    struct hal_rx_desc *rx_desc,
+			    enum hal_encrypt_type enctype,
+			    struct ieee80211_rx_status *status,
+			    bool decrypted);
+void ath12k_dp_rx_deliver_msdu(struct ath12k *ar, struct napi_struct *napi,
+			       struct sk_buff *msdu,
+			       struct ath12k_dp_rx_info *rx_info);
+bool ath12k_dp_rx_check_nwifi_hdr_len_valid(struct ath12k_base *ab,
+					    struct hal_rx_desc *rx_desc,
+					    struct sk_buff *msdu);
+int ath12k_dp_rx_h_null_q_desc(struct ath12k *ar, struct sk_buff *msdu,
+			       struct ath12k_dp_rx_info *rx_info,
+			       struct sk_buff_head *msdu_list);
 int ath12k_dp_rx_ampdu_start(struct ath12k *ar,
 			     struct ieee80211_ampdu_params *params,
 			     u8 link_id);
@@ -367,8 +381,6 @@ int ath12k_dp_rx_pdev_alloc(struct ath12k_base *ab, int pdev_idx);
 void ath12k_dp_rx_pdev_free(struct ath12k_base *ab, int pdev_idx);
 void ath12k_dp_rx_reo_cmd_list_cleanup(struct ath12k_base *ab);
 void ath12k_dp_rx_process_reo_status(struct ath12k_base *ab);
-int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
-				 struct napi_struct *napi, int budget);
 int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 			     int budget);
 int ath12k_dp_rx_process(struct ath12k_base *ab, int mac_id,
@@ -390,7 +402,6 @@ u8 ath12k_dp_rx_h_decap_type(struct ath12k_base *ab,
 			     struct hal_rx_desc *desc);
 u32 ath12k_dp_rx_h_mpdu_err(struct ath12k_base *ab,
 			    struct hal_rx_desc *desc);
-void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct ath12k_dp_rx_info *rx_info);
 int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab);
 int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab);
 
@@ -411,4 +422,5 @@ int ath12k_dp_rx_link_desc_return(struct ath12k_base *ab,
 				  enum hal_wbm_rel_bm_act action);
 bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
 				 struct hal_rx_desc *rx_desc);
+void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct ath12k_dp_rx_info *rx_info);
 #endif /* ATH12K_DP_RX_H */
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
new file mode 100644
index 000000000000..26539a4d4b30
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include "dp_rx.h"
+#include "../dp_tx.h"
+
+static bool ath12k_dp_rx_h_tkip_mic_err(struct ath12k *ar, struct sk_buff *msdu,
+					struct ath12k_dp_rx_info *rx_info)
+{
+	struct ath12k_base *ab = ar->ab;
+	u16 msdu_len;
+	struct hal_rx_desc *desc = (struct hal_rx_desc *)msdu->data;
+	u8 l3pad_bytes;
+	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
+	u32 hal_rx_desc_sz = ar->ab->hal.hal_desc_sz;
+
+	rxcb->is_first_msdu = ath12k_dp_rx_h_first_msdu(ab, desc);
+	rxcb->is_last_msdu = ath12k_dp_rx_h_last_msdu(ab, desc);
+
+	l3pad_bytes = ath12k_dp_rx_h_l3pad(ab, desc);
+	msdu_len = ath12k_dp_rx_h_msdu_len(ab, desc);
+
+	if ((hal_rx_desc_sz + l3pad_bytes + msdu_len) > DP_RX_BUFFER_SIZE) {
+		ath12k_dbg(ab, ATH12K_DBG_DATA,
+			   "invalid msdu len in tkip mic err %u\n", msdu_len);
+		ath12k_dbg_dump(ab, ATH12K_DBG_DATA, NULL, "", desc,
+				sizeof(*desc));
+		return true;
+	}
+
+	skb_put(msdu, hal_rx_desc_sz + l3pad_bytes + msdu_len);
+	skb_pull(msdu, hal_rx_desc_sz + l3pad_bytes);
+
+	if (unlikely(!ath12k_dp_rx_check_nwifi_hdr_len_valid(ab, desc, msdu)))
+		return true;
+
+	ath12k_dp_rx_h_ppdu(ar, rx_info);
+
+	rx_info->rx_status->flag |= (RX_FLAG_MMIC_STRIPPED | RX_FLAG_MMIC_ERROR |
+				     RX_FLAG_DECRYPTED);
+
+	ath12k_dp_rx_h_undecap(ar, msdu, desc,
+			       HAL_ENCRYPT_TYPE_TKIP_MIC, rx_info->rx_status, false);
+	return false;
+}
+
+static bool ath12k_dp_rx_h_rxdma_err(struct ath12k *ar,  struct sk_buff *msdu,
+				     struct ath12k_dp_rx_info *rx_info)
+{
+	struct ath12k_base *ab = ar->ab;
+	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
+	struct hal_rx_desc *rx_desc = (struct hal_rx_desc *)msdu->data;
+	bool drop = false;
+	u32 err_bitmap;
+
+	ar->ab->device_stats.rxdma_error[rxcb->err_code]++;
+
+	switch (rxcb->err_code) {
+	case HAL_REO_ENTR_RING_RXDMA_ECODE_DECRYPT_ERR:
+	case HAL_REO_ENTR_RING_RXDMA_ECODE_TKIP_MIC_ERR:
+		err_bitmap = ath12k_dp_rx_h_mpdu_err(ab, rx_desc);
+		if (err_bitmap & HAL_RX_MPDU_ERR_TKIP_MIC) {
+			ath12k_dp_rx_h_fetch_info(ab, rx_desc, rx_info);
+			drop = ath12k_dp_rx_h_tkip_mic_err(ar, msdu, rx_info);
+			break;
+		}
+		fallthrough;
+	default:
+		/* TODO: Review other rxdma error code to check if anything is
+		 * worth reporting to mac80211
+		 */
+		drop = true;
+		break;
+	}
+
+	return drop;
+}
+
+static bool ath12k_dp_rx_h_reo_err(struct ath12k *ar, struct sk_buff *msdu,
+				   struct ath12k_dp_rx_info *rx_info,
+				   struct sk_buff_head *msdu_list)
+{
+	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
+	bool drop = false;
+
+	ar->ab->device_stats.reo_error[rxcb->err_code]++;
+
+	switch (rxcb->err_code) {
+	case HAL_REO_DEST_RING_ERROR_CODE_DESC_ADDR_ZERO:
+		if (ath12k_dp_rx_h_null_q_desc(ar, msdu, rx_info, msdu_list))
+			drop = true;
+		break;
+	case HAL_REO_DEST_RING_ERROR_CODE_PN_CHECK_FAILED:
+		/* TODO: Do not drop PN failed packets in the driver;
+		 * instead, it is good to drop such packets in mac80211
+		 * after incrementing the replay counters.
+		 */
+		fallthrough;
+	default:
+		/* TODO: Review other errors and process them to mac80211
+		 * as appropriate.
+		 */
+		drop = true;
+		break;
+	}
+
+	return drop;
+}
+
+static void ath12k_dp_rx_wbm_err(struct ath12k *ar,
+				 struct napi_struct *napi,
+				 struct sk_buff *msdu,
+				 struct sk_buff_head *msdu_list)
+{
+	struct ath12k_skb_rxcb *rxcb = ATH12K_SKB_RXCB(msdu);
+	struct ieee80211_rx_status rxs = {};
+	struct ath12k_dp_rx_info rx_info;
+	bool drop = true;
+
+	rx_info.addr2_present = false;
+	rx_info.rx_status = &rxs;
+
+	switch (rxcb->err_rel_src) {
+	case HAL_WBM_REL_SRC_MODULE_REO:
+		drop = ath12k_dp_rx_h_reo_err(ar, msdu, &rx_info, msdu_list);
+		break;
+	case HAL_WBM_REL_SRC_MODULE_RXDMA:
+		drop = ath12k_dp_rx_h_rxdma_err(ar, msdu, &rx_info);
+		break;
+	default:
+		/* msdu will get freed */
+		break;
+	}
+
+	if (drop) {
+		dev_kfree_skb_any(msdu);
+		return;
+	}
+
+	rx_info.rx_status->flag |= RX_FLAG_SKIP_MONITOR;
+
+	ath12k_dp_rx_deliver_msdu(ar, napi, msdu, &rx_info);
+}
+
+int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
+				 struct napi_struct *napi, int budget)
+{
+	struct list_head rx_desc_used_list[ATH12K_MAX_DEVICES];
+	struct ath12k_hw_group *ag = ab->ag;
+	struct ath12k *ar;
+	struct ath12k_dp *dp = &ab->dp;
+	struct dp_rxdma_ring *rx_ring;
+	struct hal_rx_wbm_rel_info err_info;
+	struct hal_srng *srng;
+	struct sk_buff *msdu;
+	struct sk_buff_head msdu_list, scatter_msdu_list;
+	struct ath12k_skb_rxcb *rxcb;
+	void *rx_desc;
+	int num_buffs_reaped[ATH12K_MAX_DEVICES] = {};
+	int total_num_buffs_reaped = 0;
+	struct ath12k_rx_desc_info *desc_info;
+	struct ath12k_device_dp_stats *device_stats = &ab->device_stats;
+	struct ath12k_hw_link *hw_links = ag->hw_links;
+	struct ath12k_base *partner_ab;
+	u8 hw_link_id, device_id;
+	int ret, pdev_id;
+	struct hal_rx_desc *msdu_data;
+
+	__skb_queue_head_init(&msdu_list);
+	__skb_queue_head_init(&scatter_msdu_list);
+
+	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++)
+		INIT_LIST_HEAD(&rx_desc_used_list[device_id]);
+
+	srng = &ab->hal.srng_list[dp->rx_rel_ring.ring_id];
+	spin_lock_bh(&srng->lock);
+
+	ath12k_hal_srng_access_begin(ab, srng);
+
+	while (budget) {
+		rx_desc = ath12k_hal_srng_dst_get_next_entry(ab, srng);
+		if (!rx_desc)
+			break;
+
+		ret = ath12k_hal_wbm_desc_parse_err(ab, rx_desc, &err_info);
+		if (ret) {
+			ath12k_warn(ab,
+				    "failed to parse rx error in wbm_rel ring desc %d\n",
+				    ret);
+			continue;
+		}
+
+		desc_info = err_info.rx_desc;
+
+		/* retry manual desc retrieval if hw cc is not done */
+		if (!desc_info) {
+			desc_info = ath12k_dp_get_rx_desc(ab, err_info.cookie);
+			if (!desc_info) {
+				ath12k_warn(ab, "Invalid cookie in DP WBM rx error descriptor retrieval: 0x%x\n",
+					    err_info.cookie);
+				continue;
+			}
+		}
+
+		if (desc_info->magic != ATH12K_DP_RX_DESC_MAGIC)
+			ath12k_warn(ab, "WBM RX err, Check HW CC implementation");
+
+		msdu = desc_info->skb;
+		desc_info->skb = NULL;
+
+		device_id = desc_info->device_id;
+		partner_ab = ath12k_ag_to_ab(ag, device_id);
+		if (unlikely(!partner_ab)) {
+			dev_kfree_skb_any(msdu);
+
+			/* In any case continuation bit is set
+			 * in the previous record, cleanup scatter_msdu_list
+			 */
+			ath12k_dp_clean_up_skb_list(&scatter_msdu_list);
+			continue;
+		}
+
+		list_add_tail(&desc_info->list, &rx_desc_used_list[device_id]);
+
+		rxcb = ATH12K_SKB_RXCB(msdu);
+		dma_unmap_single(partner_ab->dev, rxcb->paddr,
+				 msdu->len + skb_tailroom(msdu),
+				 DMA_FROM_DEVICE);
+
+		num_buffs_reaped[device_id]++;
+		total_num_buffs_reaped++;
+
+		if (!err_info.continuation)
+			budget--;
+
+		if (err_info.push_reason !=
+		    HAL_REO_DEST_RING_PUSH_REASON_ERR_DETECTED) {
+			dev_kfree_skb_any(msdu);
+			continue;
+		}
+
+		msdu_data = (struct hal_rx_desc *)msdu->data;
+		rxcb->err_rel_src = err_info.err_rel_src;
+		rxcb->err_code = err_info.err_code;
+		rxcb->is_first_msdu = err_info.first_msdu;
+		rxcb->is_last_msdu = err_info.last_msdu;
+		rxcb->is_continuation = err_info.continuation;
+		rxcb->rx_desc = msdu_data;
+
+		if (err_info.continuation) {
+			__skb_queue_tail(&scatter_msdu_list, msdu);
+			continue;
+		}
+
+		hw_link_id = ath12k_dp_rx_get_msdu_src_link(partner_ab,
+							    msdu_data);
+		if (hw_link_id >= ATH12K_GROUP_MAX_RADIO) {
+			dev_kfree_skb_any(msdu);
+
+			/* In any case continuation bit is set
+			 * in the previous record, cleanup scatter_msdu_list
+			 */
+			ath12k_dp_clean_up_skb_list(&scatter_msdu_list);
+			continue;
+		}
+
+		if (!skb_queue_empty(&scatter_msdu_list)) {
+			struct sk_buff *msdu;
+
+			skb_queue_walk(&scatter_msdu_list, msdu) {
+				rxcb = ATH12K_SKB_RXCB(msdu);
+				rxcb->hw_link_id = hw_link_id;
+			}
+
+			skb_queue_splice_tail_init(&scatter_msdu_list,
+						   &msdu_list);
+		}
+
+		rxcb = ATH12K_SKB_RXCB(msdu);
+		rxcb->hw_link_id = hw_link_id;
+		__skb_queue_tail(&msdu_list, msdu);
+	}
+
+	/* In any case continuation bit is set in the
+	 * last record, cleanup scatter_msdu_list
+	 */
+	ath12k_dp_clean_up_skb_list(&scatter_msdu_list);
+
+	ath12k_hal_srng_access_end(ab, srng);
+
+	spin_unlock_bh(&srng->lock);
+
+	if (!total_num_buffs_reaped)
+		goto done;
+
+	for (device_id = 0; device_id < ATH12K_MAX_DEVICES; device_id++) {
+		if (!num_buffs_reaped[device_id])
+			continue;
+
+		partner_ab = ath12k_ag_to_ab(ag, device_id);
+		rx_ring = &partner_ab->dp.rx_refill_buf_ring;
+
+		ath12k_dp_rx_bufs_replenish(ab, rx_ring,
+					    &rx_desc_used_list[device_id],
+					    num_buffs_reaped[device_id]);
+	}
+
+	rcu_read_lock();
+	while ((msdu = __skb_dequeue(&msdu_list))) {
+		rxcb = ATH12K_SKB_RXCB(msdu);
+		hw_link_id = rxcb->hw_link_id;
+
+		device_id = hw_links[hw_link_id].device_id;
+		partner_ab = ath12k_ag_to_ab(ag, device_id);
+		if (unlikely(!partner_ab)) {
+			ath12k_dbg(ab, ATH12K_DBG_DATA,
+				   "Unable to process WBM error msdu due to invalid hw link id %d device id %d\n",
+				   hw_link_id, device_id);
+			dev_kfree_skb_any(msdu);
+			continue;
+		}
+
+		pdev_id = ath12k_hw_mac_id_to_pdev_id(partner_ab->hw_params,
+						      hw_links[hw_link_id].pdev_idx);
+		ar = partner_ab->pdevs[pdev_id].ar;
+
+		if (!ar || !rcu_dereference(ar->ab->pdevs_active[pdev_id])) {
+			dev_kfree_skb_any(msdu);
+			continue;
+		}
+
+		if (test_bit(ATH12K_FLAG_CAC_RUNNING, &ar->dev_flags)) {
+			dev_kfree_skb_any(msdu);
+			continue;
+		}
+
+		if (rxcb->err_rel_src < HAL_WBM_REL_SRC_MODULE_MAX) {
+			device_id = ar->ab->device_id;
+			device_stats->rx_wbm_rel_source[rxcb->err_rel_src][device_id]++;
+		}
+
+		ath12k_dp_rx_wbm_err(ar, napi, msdu, &msdu_list);
+	}
+	rcu_read_unlock();
+done:
+	return total_num_buffs_reaped;
+}
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
new file mode 100644
index 000000000000..a6da98962345
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#ifndef ATH12K_DP_RX_WIFI7_H
+#define ATH12K_DP_RX_WIFI7_H
+
+#include "../core.h"
+#include "../dp_rx.h"
+
+int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
+				 struct napi_struct *napi, int budget);
+#endif
-- 
2.34.1


