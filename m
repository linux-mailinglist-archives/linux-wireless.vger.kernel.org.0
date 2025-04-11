Return-Path: <linux-wireless+bounces-21416-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DEFA853DF
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 08:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78C31B8231B
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 06:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7C827CCD4;
	Fri, 11 Apr 2025 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VhN8ugXH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEC027C875
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744351340; cv=none; b=L9JvInyHOcNtDy/7KHhwgeqhYaoWfiYQ+mi61aILZ9QTEHfwuvJse7JcEiSGDx1qTsKaguY7/UXvwACURv3v1sss+bakdypQxWIaU00XXY1sRnvAeJYOf7CeV8BBOtmLSHez4Tp064WlnF3c9Utjs9Xiy83E6w575cTDK53pqNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744351340; c=relaxed/simple;
	bh=MHaxQpJqyQvOZDbhRicrMY/Z8dQB8FRjcmv4v1wwXjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sr1oLIxJILWWZTAq33uqJCfl0kPBzcFd3P4yloDk3dI6CbbPnlVtv8u7iByjq5Nw/srgKBpwZEOglC61VUzgAzd9SjfxQMqExh+fP3qfDfAag3/45QuZQgNIFV7O+gdeFLb9TAXc+KM6zJ0wE8U3QkFJlt74Eq88/uldIPMlBdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VhN8ugXH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ALUDou022952
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HCtVp2/c4MZ
	UyEuyO+HVFhPJjUakW3UDCQt6LzIMjb4=; b=VhN8ugXHNibCBgQkrFoUffrpnPK
	ytR1HXOkRwBWhZWXslubiqAiufrYKhbj60PuYw3MQU+6sgbKGjgqJpvCVbEy2xV3
	gR0ZQVXgc7dq+gvEQgzn6kYOs/Cdpb9F/hriplZ+drlNs9DjgbcVos7zLK8Se+TQ
	+At7/D+ZgJvagbEt0EbKvS1GXprqgHEcZNfKitoHDjc2180holxnSvbRg5xpFt3t
	sp31ILG0cpSQ4qdbmyuZHlDANMA3dD53/LPSbiOu4BV2LMaXNLQPjYHcl5wawXuD
	ja5wdjuoTAiOAZPRMTZWQkzhV0rVZ8Q7R6mdww9ifpvXPI9QfOEP/iX5F7w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twtb9fj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:02:17 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-736d30d2570so1486030b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 23:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744351336; x=1744956136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HCtVp2/c4MZUyEuyO+HVFhPJjUakW3UDCQt6LzIMjb4=;
        b=Y2tc3XTwuvIxawW68FB/Lyn3FymsAg8ciKJXOiXXbmRWmL4ROmUznyW8xKWEkBGOoE
         nh6Zi4MjKYK3KUgB7lVL/foKSxlqf0w8HPpR+6VEpU+WSVFeELd6FpkuFvgLlw9C3zwz
         +YAexVDozjGwu3Fea9UGmYa4Ky7VlB4+guAjmOomoJsNtiTAn+7y82fL5jzrsb51B2MC
         Ltb7JL3guhk2UUUcy9xlAWu0xJK9Ck9bTNIqFLxcSoDF646GhJVr3BEtU4MR24zb4BC8
         26uYTN/dJgI/L3I0SPr+2l1GXcj+76cSIMY+bt/isSVCkKAz1o7CyY/1LeJ4gr7qZvlB
         4YJQ==
X-Gm-Message-State: AOJu0YyYTY5/7LruXiAcxXFrJ18TNtAX77tl1xlz9hxwCZCMgEcas6hC
	XIsfGUN8caGjzkMXiypwwl3bOq8/mcjgqMvob25V8Ic6VNCMCGzm6jaexI0uvmcHPwDfWOLxOhd
	COynrDWE+qFcHSEBt/+PU3Ut0TNOh7cfgNnTgdcZgeLUmd1LgoN5Kh+KgyeAwH8Dm4miltIgACw
	==
X-Gm-Gg: ASbGnctEmoAUXmdWM0tm6iDaIR44MARbXJkr1/BJL0xNHxqoKOqUEeI7Yu/ugsa3Jxj
	tI8Dl2jOSXC4/Rag9rQe/BMHeewI0N2h2ID95HOIHRgHSo8VriKb24drofIE+eH7LEv7mWyd/oV
	bN2vAUVkUFQFPRV5VD8m01z+4x4J4EKG6ryEY0aGOlkQCkpZrrHvsG1iNeLquS2/8tLmb9QX+t8
	8adHtkGv9+y/GUu3kaXp2G9UEL5lRB9HqxnrCEH8i0XzQJJ8QQRGTtkqib2zGTLWbyF/+ntMsSa
	Pa5T356ytAYcXVX8l40gZMZy23Beq14Nh8Pub0rAe99XGRMScM+iRnQbQxlIzdaC5I0Ix5NTzJI
	eZrS8KTysLzuUC4lr6M7WARU9cM+mOg==
X-Received: by 2002:aa7:8881:0:b0:739:4902:e364 with SMTP id d2e1a72fcca58-73bd127278amr2101020b3a.19.1744351336385;
        Thu, 10 Apr 2025 23:02:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFArQi+O/yuGejTqFKNVWiTmHtB/EvA/5NTK5V4pX4nn8svVwJWHVJu80ab1OW914dEPJGZbQ==
X-Received: by 2002:aa7:8881:0:b0:739:4902:e364 with SMTP id d2e1a72fcca58-73bd127278amr2100989b3a.19.1744351335907;
        Thu, 10 Apr 2025 23:02:15 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2328435sm624567b3a.157.2025.04.10.23.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 23:02:15 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next v3 2/4] wifi: ath12k: Refactor tx descriptor handling in tx completion handler
Date: Fri, 11 Apr 2025 11:31:52 +0530
Message-Id: <20250411060154.1388159-3-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250411060154.1388159-1-praneesh.p@oss.qualcomm.com>
References: <20250411060154.1388159-1-praneesh.p@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9IqvbCO5_e-VcFp1n-qvSaX4l5wItFkD
X-Authority-Analysis: v=2.4 cv=LLlmQIW9 c=1 sm=1 tr=0 ts=67f8b069 cx=c_pps a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=DEzRtGDzSFLe7Yuc7ZwA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 9IqvbCO5_e-VcFp1n-qvSaX4l5wItFkD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=980 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110042

Current code uses mac_id and msdu parameters in ath12k_dp_tx_free_txbuf()
and ath12k_dp_tx_process_htt_tx_complete(). Since these parameters are
already encapsulated by struct ath12k_dp_tx_desc, passing them individually
results in redundant arguments.

Introduce struct ath12k_tx_desc_params to capture the skb, mac_id, and pass
it to the corresponding functions. Refactor these functions to use struct
ath12k_tx_desc_params instead, reducing the number of arguments and improving
function argument handling efficiency. Additionally, use struct
ath12k_tx_desc_params in ath12k_dp_tx_htt_tx_complete_buf() and
ath12k_dp_tx_complete_msdu(), which will be utilized for fetching extended skb
in a future patch.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp.h    |  5 +++
 drivers/net/wireless/ath/ath12k/dp_tx.c | 42 ++++++++++++-------------
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 6ce5f853dcdb..241da2a3bd34 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -301,6 +301,11 @@ struct ath12k_tx_desc_info {
 	u8 pool_id;
 };
 
+struct ath12k_tx_desc_params {
+	struct sk_buff *skb;
+	u8 mac_id;
+};
+
 struct ath12k_spt_info {
 	dma_addr_t paddr;
 	u64 *vaddr;
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index 9d58a9a9cbff..a272d5b8a51c 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -513,12 +513,13 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
 }
 
 static void ath12k_dp_tx_free_txbuf(struct ath12k_base *ab,
-				    struct sk_buff *msdu, u8 mac_id,
-				    struct dp_tx_ring *tx_ring)
+				    struct dp_tx_ring *tx_ring,
+				    struct ath12k_tx_desc_params *desc_params)
 {
 	struct ath12k *ar;
+	struct sk_buff *msdu = desc_params->skb;
 	struct ath12k_skb_cb *skb_cb;
-	u8 pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, mac_id);
+	u8 pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, desc_params->mac_id);
 
 	skb_cb = ATH12K_SKB_CB(msdu);
 	ar = ab->pdevs[pdev_id].ar;
@@ -536,7 +537,7 @@ static void ath12k_dp_tx_free_txbuf(struct ath12k_base *ab,
 
 static void
 ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
-				 struct sk_buff *msdu,
+				 struct ath12k_tx_desc_params *desc_params,
 				 struct dp_tx_ring *tx_ring,
 				 struct ath12k_dp_htt_wbm_tx_status *ts)
 {
@@ -546,6 +547,7 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 	struct ieee80211_vif *vif;
 	struct ath12k_vif *ahvif;
 	struct ath12k *ar;
+	struct sk_buff *msdu = desc_params->skb;
 
 	skb_cb = ATH12K_SKB_CB(msdu);
 	info = IEEE80211_SKB_CB(msdu);
@@ -594,10 +596,9 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 }
 
 static void
-ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab,
-				     void *desc, u8 mac_id,
-				     struct sk_buff *msdu,
-				     struct dp_tx_ring *tx_ring)
+ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab, void *desc,
+				     struct dp_tx_ring *tx_ring,
+				     struct ath12k_tx_desc_params *desc_params)
 {
 	struct htt_tx_wbm_completion *status_desc;
 	struct ath12k_dp_htt_wbm_tx_status ts = {0};
@@ -613,14 +614,14 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab,
 		ts.acked = (wbm_status == HAL_WBM_REL_HTT_TX_COMP_STATUS_OK);
 		ts.ack_rssi = le32_get_bits(status_desc->info2,
 					    HTT_TX_WBM_COMP_INFO2_ACK_RSSI);
-		ath12k_dp_tx_htt_tx_complete_buf(ab, msdu, tx_ring, &ts);
+		ath12k_dp_tx_htt_tx_complete_buf(ab, desc_params, tx_ring, &ts);
 		break;
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_DROP:
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_TTL:
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_REINJ:
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_INSPECT:
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_VDEVID_MISMATCH:
-		ath12k_dp_tx_free_txbuf(ab, msdu, mac_id, tx_ring);
+		ath12k_dp_tx_free_txbuf(ab, tx_ring, desc_params);
 		break;
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_MEC_NOTIFY:
 		/* This event is to be handled only when the driver decides to
@@ -752,7 +753,7 @@ static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct hal_tx_status
 }
 
 static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
-				       struct sk_buff *msdu,
+				       struct ath12k_tx_desc_params *desc_params,
 				       struct hal_tx_status *ts)
 {
 	struct ath12k_base *ab = ar->ab;
@@ -762,6 +763,7 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	struct ath12k_skb_cb *skb_cb;
 	struct ieee80211_vif *vif;
 	struct ath12k_vif *ahvif;
+	struct sk_buff *msdu = desc_params->skb;
 
 	if (WARN_ON_ONCE(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)) {
 		/* Must not happen */
@@ -891,11 +893,11 @@ void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
 	int hal_ring_id = dp->tx_ring[ring_id].tcl_comp_ring.ring_id;
 	struct hal_srng *status_ring = &ab->hal.srng_list[hal_ring_id];
 	struct ath12k_tx_desc_info *tx_desc = NULL;
-	struct sk_buff *msdu;
 	struct hal_tx_status ts = { 0 };
+	struct ath12k_tx_desc_params desc_params;
 	struct dp_tx_ring *tx_ring = &dp->tx_ring[ring_id];
 	struct hal_wbm_release_ring *desc;
-	u8 mac_id, pdev_id;
+	u8 pdev_id;
 	u64 desc_va;
 
 	spin_lock_bh(&status_ring->lock);
@@ -949,28 +951,26 @@ void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
 			continue;
 		}
 
-		msdu = tx_desc->skb;
-		mac_id = tx_desc->mac_id;
+		desc_params.mac_id = tx_desc->mac_id;
+		desc_params.skb = tx_desc->skb;
 
 		/* Release descriptor as soon as extracting necessary info
 		 * to reduce contention
 		 */
 		ath12k_dp_tx_release_txbuf(dp, tx_desc, tx_desc->pool_id);
 		if (ts.buf_rel_source == HAL_WBM_REL_SRC_MODULE_FW) {
-			ath12k_dp_tx_process_htt_tx_complete(ab,
-							     (void *)tx_status,
-							     mac_id, msdu,
-							     tx_ring);
+			ath12k_dp_tx_process_htt_tx_complete(ab, (void *)tx_status,
+							     tx_ring, &desc_params);
 			continue;
 		}
 
-		pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, mac_id);
+		pdev_id = ath12k_hw_mac_id_to_pdev_id(ab->hw_params, desc_params.mac_id);
 		ar = ab->pdevs[pdev_id].ar;
 
 		if (atomic_dec_and_test(&ar->dp.num_tx_pending))
 			wake_up(&ar->dp.tx_empty_waitq);
 
-		ath12k_dp_tx_complete_msdu(ar, msdu, &ts);
+		ath12k_dp_tx_complete_msdu(ar, &desc_params, &ts);
 	}
 }
 
-- 
2.34.1


