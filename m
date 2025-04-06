Return-Path: <linux-wireless+bounces-21169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D7BA7CD74
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Apr 2025 11:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F733AC47C
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Apr 2025 09:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E598197A8E;
	Sun,  6 Apr 2025 09:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fAiyKyc8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97FC186E20
	for <linux-wireless@vger.kernel.org>; Sun,  6 Apr 2025 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743931347; cv=none; b=KdUpRcVYD2YHDZnhaeDGhSqDj+4/zHqr0bphbtD4m+BMYwUX7j7xQgOE2/LjFnURzhjulny5+yYiroB8IONq8RIqyjER4NJdB8I6PnH0Sh6u5sW06YKuLbAgKKBrJyzoePjzmkJFuwqa1znDHaDJTOvK4yw514dph6KI3GkG80w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743931347; c=relaxed/simple;
	bh=q5A8q0ZC4ZAOjyGCOgZyZ1lIsDviDHIOHUoQtjsr/Js=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AUP04MZbibH5NnMQcqx6ZGJqetqAP43zSBsmJFM/QNDb549D3cuZKJ3khSCI1iBSlGTVE5/W4Gsj2MIlq9piRMgdpPbv8id3HbDl/jB70X9Fn/M4SABhI3d8adX0rKgWDGNqswqI3pWa57zsAz7B22pyYFq200xlYpXzhqARRhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fAiyKyc8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5364mOWW008035
	for <linux-wireless@vger.kernel.org>; Sun, 6 Apr 2025 09:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Z0tM2DPre0L
	dp0/ZIlfrbOSXjpI6KyDpurJ2ZSWcWfE=; b=fAiyKyc85lwJ50mLjiStx46rkvT
	uWTpq+O4iF+xratR3s3/bv1bmHDBVt7hUXzL7f3440UY2qKcmtKtx5BQty0Q/AmZ
	u4N14q8Tgmmax/NylXQXcQw6AT0ZPdC4Xd0nNyTlE/dKLmjbovBoMb9ay7kpa5Lv
	FCGiLbctHIqD9pbWxKBH1j68uQ+xfoguc2BB6ZrPjPLod8C2I+0yNpQzAQwz9BR4
	aglNjFNhwNLJ9eFQeTgUFbkM5JsGJAb7oPQW2b7UjNOPckWwbKvQHSz/QrN/MPj0
	aHj6qnsN1vdg4qRE0YoBNqi0W8/vT8EWrLnnHcLWXQXHQXGbvZZJerFAG0A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbe1p5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 06 Apr 2025 09:22:24 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff798e8c3bso3142920a91.2
        for <linux-wireless@vger.kernel.org>; Sun, 06 Apr 2025 02:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743931344; x=1744536144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0tM2DPre0Ldp0/ZIlfrbOSXjpI6KyDpurJ2ZSWcWfE=;
        b=ofHsuv9h8emspVPC6Q3yoLn+JYR7kAZVPF8gXyHcaueVFgjSLYeQG1SxTu6RAphYa4
         lcZl+rred0USRXJIT5tjQjim++QCe4v/rj8sFNpRFpVKjzY+D3rg5EoDKAOqJ1CKbNEo
         PR4fHVD6xIzczprgQgKDS41DqUdAQ2QY3z2IDkj6DDWmLhFYh3h7Yu5wb6W+N3sopNjy
         +WjeZPBZWUzLRMjiEOftPzcwOo5E/4NuCmbjPKsNhTxfR0XBm4j+LPhxtDbMFS/ynd8r
         oxMw4W+kWrYqZJhSt9q/dr4OEgdZ52lx7iCGBUfrvRvxzOv6ge7qXAQZ4X0tHPt1xfqg
         aAQQ==
X-Gm-Message-State: AOJu0Yynz4VK2iw/q2cWpfFk87MrKqCZIiUARojRcJ0yCXZZvpuKX5bo
	y23SXcoyaJDBvNPrCbJqJng91nyUfC0knOAPHH/Hr/UXRE+YMeSz7Lfs+IVVPCkHRHwSaqFXIJB
	c/ZmWn4mO3TZijsVbzxbr6pYIblE+gJYQwtID1z5kMzZxdSm/a74KpGp4ewnpBGnaRg==
X-Gm-Gg: ASbGncs08DefKdlmVFmx120cPhjKRdlBBvdTjFblWOVsRfV+oZth/Qwrte2HMFXULlF
	djA1w/PJOI2TiJlvHmt41tmVywnpYNUkmNxnzshmP1Myejw3WewrJKTaJCo8wRaeUrblp+wGkpT
	iDYWyIhpDmSgB60GNq5PiNpfPq3jtfxUVyIlU8JxfLHXPy0zoDBqEi/mxmn2ZymlSsB1Hxqs+vq
	HYcGbIxAv/ulRr6x8euumrfKO/Nt8FVhVkvStVO0TgGhrccFc7hhGn7aXSiMgfITbBQNp94mzNt
	yypOEagTPpzXd+R0zCZwo+4qGnEV6brqQQYjwpTyCnvJj2Lf/F9RQEzrhK3GQpk1JG5oVaAMKDv
	4tntvBFANjpBkuOSiC7cXQxsCgQMXF92XT/bMfl4lcXuR
X-Received: by 2002:a17:90b:2d88:b0:2fe:7f40:420a with SMTP id 98e67ed59e1d1-306a61769e1mr14157798a91.17.1743931343767;
        Sun, 06 Apr 2025 02:22:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlO0hQvfZ/61O4+pLoAYz1LDgM30pfG851yk88I3n5V6Qq+28gqJ4KJIKZIbiMfGkiOWn1gw==
X-Received: by 2002:a17:90b:2d88:b0:2fe:7f40:420a with SMTP id 98e67ed59e1d1-306a61769e1mr14157772a91.17.1743931343422;
        Sun, 06 Apr 2025 02:22:23 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057cb5e75asm6857311a91.37.2025.04.06.02.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 02:22:23 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH ath-next 2/2] wifi: ath12k: avoid multiple skb_cb fetch in ath12k_mac_mgmt_tx_wmi()
Date: Sun,  6 Apr 2025 14:52:14 +0530
Message-Id: <20250406092214.3602182-3-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250406092214.3602182-1-rameshkumar.sundaram@oss.qualcomm.com>
References: <20250406092214.3602182-1-rameshkumar.sundaram@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TsgmJXeicG9wxFO6aDqZKsF4vO2rHoO2
X-Authority-Analysis: v=2.4 cv=T7OMT+KQ c=1 sm=1 tr=0 ts=67f247d0 cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=Lpz1UfvgpueRW3gVfIYA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: TsgmJXeicG9wxFO6aDqZKsF4vO2rHoO2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-06_02,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=914 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504060066

ath12k_mac_mgmt_tx_wmi() fetches ath12k's skb_cb space multiple times from
TX skb which is redundant operation. Save the skb_cb in a local pointer
and use the same instead.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index a1e5d94b400d..0fa5c9df19b2 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7095,6 +7095,7 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_link_vif *arv
 {
 	struct ath12k_base *ab = ar->ab;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ath12k_skb_cb *skb_cb = ATH12K_SKB_CB(skb);
 	struct ieee80211_tx_info *info;
 	enum hal_encrypt_type enctype;
 	unsigned int mic_len;
@@ -7104,7 +7105,7 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_link_vif *arv
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
-	ATH12K_SKB_CB(skb)->ar = ar;
+	skb_cb->ar = ar;
 	spin_lock_bh(&ar->txmgmt_idr_lock);
 	buf_id = idr_alloc(&ar->txmgmt_idr, skb, 0,
 			   ATH12K_TX_MGMT_NUM_PENDING_MAX, GFP_ATOMIC);
@@ -7113,14 +7114,13 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_link_vif *arv
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
@@ -7133,7 +7133,7 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_link_vif *arv
 		goto err_free_idr;
 	}
 
-	ATH12K_SKB_CB(skb)->paddr = paddr;
+	skb_cb->paddr = paddr;
 
 	ret = ath12k_wmi_mgmt_send(ar, arvif->vdev_id, buf_id, skb);
 	if (ret) {
@@ -7144,7 +7144,7 @@ static int ath12k_mac_mgmt_tx_wmi(struct ath12k *ar, struct ath12k_link_vif *arv
 	return 0;
 
 err_unmap_buf:
-	dma_unmap_single(ab->dev, ATH12K_SKB_CB(skb)->paddr,
+	dma_unmap_single(ab->dev, skb_cb->paddr,
 			 skb->len, DMA_TO_DEVICE);
 err_free_idr:
 	spin_lock_bh(&ar->txmgmt_idr_lock);
-- 
2.34.1


