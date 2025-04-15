Return-Path: <linux-wireless+bounces-21566-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6095BA8A8AA
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 21:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEFB3BC12B
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 19:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDB725178B;
	Tue, 15 Apr 2025 19:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IY7eDxtO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172072356A6
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 19:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744747132; cv=none; b=VK5GV+cGEui2hGnJ1QTya/k3OAQAgGGw8yaz+bs3QaAqbkC4mw39GjATTSa+3JzowkvZitWVyFsyN8IrIyCR7meNCSUPHSmuLtdyWsTh/E5Yre8LbxdMQrfspdYCeahAtFTu1zi0IsW1MKPlc2I3KIC68R0TXAur73ykNux+M9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744747132; c=relaxed/simple;
	bh=2JE+5ECqNuwFM1DevMA+QzGBI36iAkhsRiOfxMx8VsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NkWR5n+epcDqkT53z9dxtIRCokEMki7e4ZK/frXaPcQ2AbvRgCclt5V7q6iw92QdlcsGvq61rY6W0pemeSuUTZWf+EQ7jzVRvH/TgbM51/Q9vD7/ClIrt0TIjZhDRvzmyOt37EorB7Mrnz/MEApWTXs5d/XWxlK/LH+xcKZEcbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IY7eDxtO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FF74r7011411
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 19:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qcm3mTXhNgF
	IzDf8ONFOx3CSHaqCCKtUmgO29xy/9hQ=; b=IY7eDxtOG7WtubByim9840yByMD
	n2/Bemn4g/ZKRrTnLvWen6JDCaNgc3la++V66RFbW2eWAsnocAGvc7gkPP1ch6PY
	8ofXuHzzOCk16Y/ibuTSKqZkEH32DzTn+ME3hFwZ9ktNGaVUF2RVpGYPo8cJ1CUY
	6riGABV3HUh7A5PgKv198me+womIETXRt/AhDPnSWG6gvwfWp4nD/Wfwktxb3zL9
	YX36I91M68jLozHXOABQExxfnngvXdYegVA9eFA5LG46Km75sF4MTQa6q09kigiU
	putfCfdXcd45cxHEQJL+Vy5ZiEO3zLWb3dEuf4tO0w7Zh0eUCf98YkY/utw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygxk15gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 19:58:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-30828f9af10so8956884a91.3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 12:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744747129; x=1745351929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcm3mTXhNgFIzDf8ONFOx3CSHaqCCKtUmgO29xy/9hQ=;
        b=qjgDiAvvtpBS5yAg/k5v+yCTSSdCf70hMGOx3o/H1jRfLbqvD7a8+QGhkQRoQwBOei
         dEpYuNCeYWwgqz9gP4uLr5PTuyVibelXm0LTnpCGxfGJjR2lMuMAKJJH2RLf9BP4qiS8
         f+j1CV8Udqp0LuXclDJ2S1eL/A0k1TjLIKPZKppA2SLzG9jiRsM2kiTqbUWTkDseg0K0
         U8ub8rvm0nMCOPKzH42Zu9/gRs7jHeVEsRs/pYKv9TcUKDP7ZDRi5t6+Qe46TZlLcDdH
         gf4xQYyJ5eQ9VtnZxVW40qy8qcDxu6a7Jm3L7iBmgWcurxejGPwSHbrOqB/I5UuZkiml
         u5+Q==
X-Gm-Message-State: AOJu0YxLDD32hQNTyjcbi9IW/3gUuUznQIkA/963UE/Gz6K4sN2qjApD
	1f3o4ia1tlVDEW/d546+qN7ibX1uGJdRSukP0dSVPp5JrR3GK5IfJcLi0gSYb+Nk8GnlZoEd8I8
	q4d2Kh8Pcp+A/3lZ4AUpXnC9nBAHhkUqOlKWCDVflnfLWQqQv+ixK8ebl9bqHO78YrA==
X-Gm-Gg: ASbGncvMwwknDIpQivXtypKpqT3hpkiPNRhrxJn1kqSEQjOF1gPu6+MRdD7EytpqIHr
	S73AXKI9wKVkC2kX1RKrWkddTF0KbPra6nueNjXJc49aehYgaiSYXQTKum6MuJ0hjU8ZamH/2hX
	TzKPxtBruxGCr0KXrU5yGIpxMT40FXqDXohWwzeV9p3pBPTif7iImm8HwJbU8JLaXPdI1TKUyyr
	8O7/0Kx1CjK8UR4fSRvQNiMrEUMuqNt3UNXzq+DvpwH2b2uT2zpKif4lRgkFrBFiLMGjJsYCW7R
	3CZRIYMcKqmxnxNU6SR0LV5wv9zAh956ASK8EOhWCb1LU6iTR2O9f6idDB+oHO0FXfTqVc6ni1u
	BPU7oa5L3Uj81vZlVjzmAGR8I47mcLnOakSLmXdGI
X-Received: by 2002:a17:90b:540d:b0:2ff:6aa6:47a3 with SMTP id 98e67ed59e1d1-3085ef52d0bmr664193a91.25.1744747128684;
        Tue, 15 Apr 2025 12:58:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdWdsmzjjjGnJ6hmwUqpmMBFwW4DMydzBiW9SemD5tAw57uItaXtXTFitggGXHXy4unOBTKw==
X-Received: by 2002:a17:90b:540d:b0:2ff:6aa6:47a3 with SMTP id 98e67ed59e1d1-3085ef52d0bmr664160a91.25.1744747128301;
        Tue, 15 Apr 2025 12:58:48 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8ea61sm121626265ad.103.2025.04.15.12.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 12:58:48 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Subject: [PATCH ath-next v2 2/2] wifi: ath12k: avoid multiple skb_cb fetch in ath12k_mac_mgmt_tx_wmi()
Date: Wed, 16 Apr 2025 01:28:12 +0530
Message-Id: <20250415195812.2633923-3-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415195812.2633923-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20250415195812.2633923-1-rameshkumar.sundaram@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=67feba79 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=Lpz1UfvgpueRW3gVfIYA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: FQDdNV_Y6Rrzza5haocAEdcV-C2-aZ4g
X-Proofpoint-ORIG-GUID: FQDdNV_Y6Rrzza5haocAEdcV-C2-aZ4g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_07,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=911 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150140

ath12k_mac_mgmt_tx_wmi() fetches ath12k's skb_cb space multiple times from
TX skb which is redundant operation. Save the skb_cb in a local pointer
and use the same instead.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index aaa02d3d0f95..43497ed12190 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7150,6 +7150,7 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_link_vif *arv
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ath12k_skb_cb *skb_cb = ATH12K_SKB_CB(skb);
 	struct ieee80211_tx_info *info;
 	enum hal_encrypt_type enctype;
 	unsigned int mic_len;
@@ -7159,7 +7160,7 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_link_vif *arv
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
-	ATH12K_SKB_CB(skb)->ar = ar;
+	skb_cb->ar = ar;
 	spin_lock_bh(&ar->txmgmt_idr_lock);
 	buf_id = idr_alloc(&ar->txmgmt_idr, skb, 0,
 			   ATH12K_TX_MGMT_NUM_PENDING_MAX, GFP_ATOMIC);
@@ -7168,14 +7169,13 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_link_vif *arv
 		return -ENOSPC;
 
 	info = IEEE80211_SKB_CB(skb);
-	if ((ATH12K_SKB_CB(skb)->flags & ATH12K_SKB_CIPHER_SET) &&
+	if ((skb_cb->flags & ATH12K_SKB_CIPHER_SET) &&
 	    !(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP)) {
 		if ((ieee80211_is_action(hdr->frame_control) ||
 		     ieee80211_is_deauth(hdr->frame_control) ||
 		     ieee80211_is_disassoc(hdr->frame_control)) &&
 		     ieee80211_has_protected(hdr->frame_control)) {
-			enctype =
-			    ath12k_dp_tx_get_encrypt_type(ATH12K_SKB_CB(skb)->cipher);
+			enctype = ath12k_dp_tx_get_encrypt_type(skb_cb->cipher);
 			mic_len = ath12k_dp_rx_crypto_mic_len(ar, enctype);
 			skb_put(skb, mic_len);
 		}
@@ -7188,7 +7188,7 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_link_vif *arv
 		goto err_free_idr;
 	}
 
-	ATH12K_SKB_CB(skb)->paddr = paddr;
+	skb_cb->paddr = paddr;
 
 	ret = ath12k_wmi_mgmt_send(ar, arvif->vdev_id, buf_id, skb);
 	if (ret) {
@@ -7199,7 +7199,7 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_link_vif *arv
 	return 0;
 
 err_unmap_buf:
-	dma_unmap_single(ab->dev, ATH12K_SKB_CB(skb)->paddr,
+	dma_unmap_single(ab->dev, skb_cb->paddr,
 			 skb->len, DMA_TO_DEVICE);
 err_free_idr:
 	spin_lock_bh(&ar->txmgmt_idr_lock);
-- 
2.34.1


