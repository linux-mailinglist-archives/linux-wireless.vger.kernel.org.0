Return-Path: <linux-wireless+bounces-21105-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73291A794E3
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 20:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F0516D40C
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 18:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DA01AAA0D;
	Wed,  2 Apr 2025 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hd0acpFb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFD91D61A3
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617711; cv=none; b=YYt++BxToPC3t7bQA7fFxvaflIFJsr9wXBH5U0PpSec5vLnU/o5GnhCKBcAQJpVbJ27PWVd3evXeSnbuKj5A/9FpZdXfiCF05w2tFRuXKzzZ7IIiUVDpsATU9Bs2P40qEBl2tAOZpVK8H584Tm8MdehuyejJlMip/hRVkPPR2VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617711; c=relaxed/simple;
	bh=2hUDyVA+wcbHwjNLQ/GHWZKE6K7qK9TSrjIKrFrGwk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BNw5aAda2aFbPxuKMZQgo0ApyFEw9Ny5y5uCe4pfT6jmX0we9XuA/n0umQ+2pjGZBp6Dewi+9CFRSU1q+iZ3HVwgojd4JAKXe4jkgTqpSWmtKHZ3j8YmRSCLFdz5V1aJB8VsPHRNPGT7nPh2+inJmJiVD+5+bLatkAMZIhf5Go4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hd0acpFb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5329TtAc031204
	for <linux-wireless@vger.kernel.org>; Wed, 2 Apr 2025 18:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=iDxpFyWVw/N
	SmbzY19vvGJFrlSTyAN/GVhMSHA7vtdI=; b=hd0acpFbvTNNWwsY2ThgglSRN1w
	QD2llnuTDdteOkoUqv4Yw9wTM4h/u0Q8eqvfgchnBlgjiqS3u1eNZbvW76FjOcn9
	sd+UkP7cnC7ffwpu8CautwMjTwV+Zbb+1FKQu9Lhkv5Bu1wQhQKpF3kkZ/jcXdK7
	Bo+vRS689lsN25KCJ5KHclKEVYdmw9Du8qmnUJTbvvNwxik1oOac4vJ8cmJxI0cc
	8EfJAMbNiQRFHYRsP53TTr1eXX4AOk/D+8i3hOjAKK1EEwu/5XL/LgAovp3A9olL
	Ch87hX4eQBlwrbwKz4wYAzwkm97NqMRn9ZdWFOruo374T/2hvRphjqvF1uQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45recpmqkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 18:15:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-223fd6e9408so12649665ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 11:15:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743617707; x=1744222507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDxpFyWVw/NSmbzY19vvGJFrlSTyAN/GVhMSHA7vtdI=;
        b=iCkXt3enknXRv32/IfZ2dFqGXf1G3MZO7MfIBb6RSu0IpAqbdBeabpOUxIzWeN7lbn
         V1o8RMgHWZZm4xJbcrUa3J4YRTlmedw/hjS8koGG1tRjDTF590HVrAuM7WGSPCTn+1GD
         HsL297U2rPQTOVJpRfgdFGLmz4KNcMJnMKIOFTiDxwwID/oNiKYOwd1qzHmMn5+Zcgl8
         Wi1McUL3Rvzo0T+Oh//WiVS13HfFhHq3gZNQ9BoCLtfBLJv6NfAxGUzBnL76UclBy5rV
         NACaZAfK8pLgp9Pdoh1gPfuLpFhAG6R7wKpVpfva4Ejsmf8MKJgXEfWcBKYVa7fJRM5V
         s6jw==
X-Gm-Message-State: AOJu0YzAt1NhCW0TtLtvfZ0zbNfY4+BE+JAmM3Gy6TUHbjQw2wIRtE75
	hqrTRjhgxXaNQ4KIx8MdsF/7wgdJXtJbKwWwBEZ55JNyrZVnd9+z4pFYUPZYI6dAUzzmhy+ghfe
	AO7Cp7rQcCEmNmKVcxsR2353+3jJIPjUA+o9JpgTsK82Oh9FPcEKJ2uG0WjMw6dAE4s9E0A60eg
	==
X-Gm-Gg: ASbGncsnzcRMV9t38lsPvgeJqA2RYs4psdj/dXIGP1sBxIa5Wi9AZdinR/f4Yc1+IIt
	9wuwdCGwInBKvgzvvxVDNrmz5ZAvFoUlZ6roGcWq+wbNvyiEwve5ZodeQ+7YsM0WS2MEUcp6zpy
	OQJrwNvwTHszg2aOTplfJGSMzAOBubL7cFZ6nMaFtGTfEmprkmbQ04YB+G50plbTwKbzuK8AhFU
	qnA49ktMQuZPcN04vehRAm/6VJhjoq/8yfcQhmMtRgte7ka3b7sUL0AXICj/wuFsGYyVdWx+iik
	AeFQ/rcUiK+A8ZzARe+XM2I2RoSZ8NowiesW+SvpTvcm/Fotm2Muy9h59XnqsnQxhbcvtjIGrvS
	Zy5NiyPbQmMEbNcsvhzPA/igl1HF6ZXNy/A==
X-Received: by 2002:a17:903:2444:b0:21f:6f33:f96 with SMTP id d9443c01a7336-229765bd1b1mr6413705ad.6.1743617707232;
        Wed, 02 Apr 2025 11:15:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGznKDbtnf0J5Z0Fs0/PJUPpOEL9O7Pr+bGPa/xvJXbXPkVZWz3ruNM9q0leoRIs1sXRUiJtA==
X-Received: by 2002:a17:903:2444:b0:21f:6f33:f96 with SMTP id d9443c01a7336-229765bd1b1mr6413355ad.6.1743617706761;
        Wed, 02 Apr 2025 11:15:06 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf14csm111689675ad.137.2025.04.02.11.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 11:15:06 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 2/4] wifi: ath12k: Refactor tx descriptor handling in tx completion handler
Date: Wed,  2 Apr 2025 23:44:52 +0530
Message-Id: <20250402181454.2699777-3-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250402181454.2699777-1-praneesh.p@oss.qualcomm.com>
References: <20250402181454.2699777-1-praneesh.p@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: b0kZKjPRJmFWRkTH5r1F_PM9DqtRjQwV
X-Proofpoint-ORIG-GUID: b0kZKjPRJmFWRkTH5r1F_PM9DqtRjQwV
X-Authority-Analysis: v=2.4 cv=J4Sq7BnS c=1 sm=1 tr=0 ts=67ed7ead cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=DEzRtGDzSFLe7Yuc7ZwA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_08,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 bulkscore=0 mlxlogscore=987 malwarescore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020116

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
index 427a87b63dec..e26a9c3477d9 100644
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
index 03c79becd59a..45f4c8bd78e6 100644
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
@@ -580,13 +581,13 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab,
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
-		ath12k_dp_tx_free_txbuf(ab, msdu, mac_id, tx_ring);
+		ath12k_dp_tx_free_txbuf(ab, tx_ring, desc_params);
 		break;
 	case HAL_WBM_REL_HTT_TX_COMP_STATUS_MEC_NOTIFY:
 		/* This event is to be handled only when the driver decides to
@@ -718,13 +719,14 @@ static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct hal_tx_status
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
@@ -843,11 +845,11 @@ void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
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
@@ -901,28 +903,26 @@ void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
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


