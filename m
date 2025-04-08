Return-Path: <linux-wireless+bounces-21251-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B36A7F4D2
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 08:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D297216BAAF
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 06:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B3B25F972;
	Tue,  8 Apr 2025 06:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CNBj4GXa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9837E217F5D
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092843; cv=none; b=fy5HZGWKFqeNKIAfnwF8wDc8q7dIWauEvQcWCRKv5dCZKjYRzcoklJVW0Ng2BOSnrgBjn2Z2tkepKvWEMFZxQSfk/gatNUGt/NpMZx8ss8nFu6+L1Rw+HCsijkQLlAsOyTxmBFfRBGGWnYxvowUgRYoOfKz7D46KqvIE3SOgRZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092843; c=relaxed/simple;
	bh=VbVjg8+0hsc+aCiZec4xTFA9kO1/KR9bxxNNKUi1q80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e+6xBkGHQffUBo1v0/pj7kp7rSHXYZgUkFUV4rM8whgNKKQMov2s4T+QgcDxi3rjhTNcFHIVqxD6fMad5PaL9hK8qgzgtttP06ffKoIGZEPI1OPSbzNpBPGDAby0I+5XhZiOW8zomoJsWezYMaWvHL5vGqtdJjYZ7PW4lug9bj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CNBj4GXa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GPui010539
	for <linux-wireless@vger.kernel.org>; Tue, 8 Apr 2025 06:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kEFyTTEuNUu
	SbnwQFNWQYErdU/hJQYQmJmQ0atVTp0E=; b=CNBj4GXanKn1RbEiCmChmrYHrZx
	zbXq4XyVGHsrkzULSn3pgEp4+048ka9Hw2QUFcDRJ6Fh4q1HI3TOokxRjayuEgdo
	IlRTUucGOmJhwuk9P1P+IndYSIsQ2uT24QFzEYlJpU/Oa8IgFQ+4YnpiASw4cSll
	omY2HvSziA4G089rvTi4gsKNNAHrjmjxGPB8ct8Yx7HtJSrCRbqCx7e/F/ibhrUm
	zUA57gg8Z6T+MNVKAp7/ZccYWi5OGYvKMmk93Y7fGE1kiyKQCmp0/qfVwyW9sIEf
	VohDzsBfbuk2FkGhKDXJw4zlna1xQqE+5KKC5zooWBd36hg8daaxd1PavVA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twc1ekef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 06:14:00 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff5296726fso8010238a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 23:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744092839; x=1744697639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEFyTTEuNUuSbnwQFNWQYErdU/hJQYQmJmQ0atVTp0E=;
        b=lTS3OPYLFzEwjbSel8zle+kfMilP54YK3yOxIB9i3CdmEWJ/SkErt5aFSwzxhvxzEc
         Q6vYPde7/hRpjA1d+vIYrQVT94s7KeGtuRgomBOHW0NOtiL/PX7xhgDhV/0kZtiWdgrm
         xMcZXBEwIh9VcGCI5vP06LP6YOtfe01o7Nh3ewC6cMi+fDftRbsnBUFkTjai66SwLUhN
         uKoSQnXImW/WoUrRnKHVeTmPiIMO+SfFPbkfg7vezhv071CD/n3ia3fbLV+ihLxfpaIc
         mlJLN71tRaC6e5l5DN6tam6PN7tsS2YqMXwx6EsKMGP8F9yv+s7X8hW62QHXaWw61JbA
         7isA==
X-Gm-Message-State: AOJu0YzLbHnKloCD+FWNXFpzs/zlPhrbHjxuvMRTOvsnz77OeEoWAjqM
	qu9ecnsIiq53XuTuDeFdUPH5LZcDee1wPlWObwTrKglj88z81Y4zjQHFtBCI8fH/wOhFJcyu6Cg
	+ROF0IBcCn5cW+f3AHF4xGHuSRcJiVx4NRAJSmaclICMRLcnJbB/B/7R6hO5+MaBS6L0ZgpaUgQ
	==
X-Gm-Gg: ASbGncsJqHd6grnTc2IVsIsq3v0vPtaNmQrm417nnO30A5hl3E0f2lwWV5a2wJZ4xBd
	KLuFaPw7FpMZjlGDInKArzrO/to1diO0Vzjz96x/CdtGFQbQjjDZzkWh28yMI+gqznv2agntN3h
	jthbAIHnZ/CKxbSkqhtM56GJgWD7sFEgSrZ4qdV+FsH05/5PGntiH28i6iQjOeSLHXIt47IU0hH
	dNW8AV6THJlv39a3bs4sLU4u9lwA9OEdPtfxf0bExlhXi+a0c8hUmIVmgfzlh+i69teo0GmBrI1
	AHkthOYHrOAiZa994Z7qhttEGuluFjfWK5X7JwiP8BNbcutM5YQZ9RQaLFVvXZu35nNxubklTzb
	ImjlVMaDVW+n8YQN/A6XWwugWbFT/1YjYmA==
X-Received: by 2002:a17:90b:2390:b0:306:b65e:13a8 with SMTP id 98e67ed59e1d1-306b65e13fcmr10168966a91.8.1744092838672;
        Mon, 07 Apr 2025 23:13:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoBBnXJXCkSl1D6taAVfDLW9Ne+0IIgh+f9kGprM0pNZnCYkxkVhjhirD7WUC8hFYjuNwEww==
X-Received: by 2002:a17:90b:2390:b0:306:b65e:13a8 with SMTP id 98e67ed59e1d1-306b65e13fcmr10168940a91.8.1744092838111;
        Mon, 07 Apr 2025 23:13:58 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057cb94f4esm10258444a91.46.2025.04.07.23.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 23:13:57 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next v2 2/4] wifi: ath12k: Refactor tx descriptor handling in tx completion handler
Date: Tue,  8 Apr 2025 11:43:41 +0530
Message-Id: <20250408061343.2774345-3-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408061343.2774345-1-praneesh.p@oss.qualcomm.com>
References: <20250408061343.2774345-1-praneesh.p@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TMHSn-s8S3J74bAhTBd8REgIK7gYlvP_
X-Authority-Analysis: v=2.4 cv=KtdN2XWN c=1 sm=1 tr=0 ts=67f4bea8 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=DEzRtGDzSFLe7Yuc7ZwA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: TMHSn-s8S3J74bAhTBd8REgIK7gYlvP_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_02,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=982 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080043

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
index e8dbba0c3bb7..d982e9638517 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -300,6 +300,11 @@ struct ath12k_tx_desc_info {
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
index 6b394534e3a2..08af7edd3f25 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -496,12 +496,13 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_link_vif *arvif,
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
@@ -519,11 +520,12 @@ static void ath12k_dp_tx_free_txbuf(struct ath12k_base *ab,
 
 static void
 ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
-				 struct sk_buff *msdu,
+				 struct ath12k_tx_desc_params *desc_params,
 				 struct dp_tx_ring *tx_ring,
 				 struct ath12k_dp_htt_wbm_tx_status *ts)
 {
 	struct ieee80211_tx_info *info;
+	struct sk_buff *msdu = desc_params->skb;
 	struct ath12k_skb_cb *skb_cb;
 	struct ath12k *ar;
 
@@ -561,10 +563,9 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
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
@@ -580,14 +581,14 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab,
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
@@ -719,13 +720,14 @@ static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct hal_tx_status
 }
 
 static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
-				       struct sk_buff *msdu,
+				       struct ath12k_tx_desc_params *desc_params,
 				       struct hal_tx_status *ts)
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ath12k_hw *ah = ar->ah;
 	struct ieee80211_tx_info *info;
 	struct ath12k_skb_cb *skb_cb;
+	struct sk_buff *msdu = desc_params->skb;
 
 	if (WARN_ON_ONCE(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)) {
 		/* Must not happen */
@@ -844,11 +846,11 @@ void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
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
@@ -902,28 +904,26 @@ void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
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


