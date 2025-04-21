Return-Path: <linux-wireless+bounces-21770-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4FBA94B09
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 04:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECDF23AF3FF
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Apr 2025 02:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03A4256C81;
	Mon, 21 Apr 2025 02:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="goMqR1ro"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0402512B63
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745202938; cv=none; b=b8ii5uuADvtAXVjDHt0qxX5p7WjIlijjkQ396tPfsIHgCO9eteGxY1f/1cmt3NxoC5ISOMpllymn+1LNztXKizOI9rymzF2b+m2sutpMRB9adVBofkfs5ZSZWd0ooZSQQLQhucLmoQdcUb9hIrNCuHuiGlmdRXoPFzyNevlfHJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745202938; c=relaxed/simple;
	bh=Q9ALV2ZhoUIZFk5Rp3rX89i8dOXK0MprLVK8phD9gas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hAV9S9xIURBGm+harslvkBzIryAN99gtWDsFIlBAn1gQ+gWyHjjh6Rd6yNBKpp9yGDGQSLM9iAweDMFZOa+tvyEwkOy943aAQIPLoWy8Tc1XoYvoe17fVUpL97iGUwVVPYSX6QMpsA1u90OKFUts7l+Z1WWIPSK9kEBLZkyRuQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=goMqR1ro; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KNUEIE021028
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8hZqULHZjm1
	SplECvDuI++vRjWXBgF16wtK/q2Pk1SE=; b=goMqR1roX2JDaxZ3tGaSNEkTY6M
	hgf0FoxHoxqIbRVSaFg0z1Hks2oe8MQE/949VbolabSnvaZAjaE3g7bL5/TWh+UP
	BcohIUyCr+dDHksqwZh43tRWU+PW5WA4m0wjGj39/BsqvMIeAQGLuh2QXb9uLoAz
	l35WfOAx7+VXp2mXaV9/56TUJ6OSLu09mO2zoiEQ/XgSKKLwdEj4/icC7wlnCTWr
	pZS+JlQmGlA0eALVqF7Zu0ZlIywbeRggwJUz/BMHRWs4JH2YmwucQbgrPFCo0mGj
	f6IHHfQTLuChXVvgwzC4XjCrl12X5jSyaFhMSpl191GsV26RTUVLwQYdzZQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 464426jqvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 21 Apr 2025 02:35:34 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2242ade807fso61348195ad.2
        for <linux-wireless@vger.kernel.org>; Sun, 20 Apr 2025 19:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745202933; x=1745807733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8hZqULHZjm1SplECvDuI++vRjWXBgF16wtK/q2Pk1SE=;
        b=bt6nNuT4zGJ7Z+zByRL8Hj+UkFrxWTc9ShphN4PX6I4/czv5fgQTqtl38WatgCXbKB
         yCvlz7CyYf07VUEgUZ5obab0k+mxL3a7+f82V/Q1SGElrmDxWF7vEYT0wN9NC4xuBGlC
         AmAgevKz6px6y3pIF7/YJRsE9SjqoU35VV98qJa5QzNxh04eT+pW05G+t8mUfi/8h44G
         eXBDeWCMCOBk2oo9h41lZWWbj5NmkuCM1zo1iXUkkUMlPH0FXrthbaX6QHkEpvNLpRs7
         pCOE1cfC+/fN4qpQZG2tZCqjf6vOMEOjHN7ywLuRC2aWdtal7KRNKY58aJde2+bTUWg0
         /skQ==
X-Gm-Message-State: AOJu0YyQAYRl7aYYRiSQVWtVeQw/ci9/W6ELslQMTFCPG6e9+959wl37
	g7FdO41B1sl1NWYNs+/SgTtE4pi5vWHjjdbvNHJuBBIwd0G/wvu8iFeflzfMkCOm5nLboPM1ycj
	vVYCbTjco3vDqc7Bfa3c+1WkrULavlTK3z1+1FkSwbLU9LgBhVmpXR3QQCR44OSV5Tw==
X-Gm-Gg: ASbGncvVgcNe4ZJlZee5FAAJaKPQxgR8k4PeoIYbA4zRYKGEe+x/YRuwU5gFlYV+2do
	IACDiCPFcA3x7x17hXKAF7vpIJ2wuf5uc5z/e5PpZqQJmcs906jilf4lASMgb1UYnRPxLPHAjMU
	dNtBYVBX+wBFhpguSFocgBRqxIbIJR5yyeZpacHnqcRyZcHcc312Zw55Xl0+vBUI3jFoYL8f3y0
	rhGRfswjC/5Cb6UQbkWETi38xDPZVQRWSAxm+JRG9pAq1Sz0B3a6Ce+NHbaiFHUwRi5wHJ1eJEr
	rdQLeVzl7ejQYAyIhHPJ76ndKlKRAw3oKIQm1ZP7yc/i2CVvKFQOtwuuq1jIuyp3yrHtoBZYZVG
	CG88jzvoeXVA=
X-Received: by 2002:a17:902:f54c:b0:224:1074:63a2 with SMTP id d9443c01a7336-22c5361c436mr159845315ad.43.1745202933544;
        Sun, 20 Apr 2025 19:35:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsWmmltyrsFvtZ+zV7ulHOBb3JA17xX4Ll7gxpRrPdYgMCim5NBNOpMKFVjPILnn7BK5pVfw==
X-Received: by 2002:a17:902:f54c:b0:224:1074:63a2 with SMTP id d9443c01a7336-22c5361c436mr159845115ad.43.1745202933184;
        Sun, 20 Apr 2025 19:35:33 -0700 (PDT)
Received: from kangyang.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4287sm54631685ad.130.2025.04.20.19.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Apr 2025 19:35:32 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath12k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next 09/13] wifi: ath12k: use ath12k_buffer_addr in ath12k_dp_rx_link_desc_return()
Date: Mon, 21 Apr 2025 10:34:40 +0800
Message-Id: <20250421023444.1778-10-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
References: <20250421023444.1778-1-kang.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: M4WwdERxSLSF_L1_20MsPIPmADan63EV
X-Proofpoint-GUID: M4WwdERxSLSF_L1_20MsPIPmADan63EV
X-Authority-Analysis: v=2.4 cv=IP8CChvG c=1 sm=1 tr=0 ts=6805aef6 cx=c_pps a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=vwqPoxeLtJ6jty5K6VgA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_01,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210018

Currently, ath12k_dp_rx_link_desc_return() takes struct
hal_reo_dest_ring as its second input. This struct is converted to
struct hal_wbm_release_ring and passed into
ath12k_hal_rx_msdu_link_desc_set(), where it is converted again.

This double conversion is both strange and inefficient.

In ath12k_hal_rx_msdu_link_desc_set(), only buf_addr_info is actually
used. To simplify the code and improve readability, directly passes
buf_addr_info when calling ath12k_dp_rx_link_desc_return().

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 26 ++++++++++++------------
 drivers/net/wireless/ath/ath12k/hal_rx.c | 16 +++++++--------
 drivers/net/wireless/ath/ath12k/hal_rx.h |  4 ++--
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 6bbae10f7389..382d364fb3ff 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -843,15 +843,10 @@ void ath12k_dp_rx_peer_tid_delete(struct ath12k *ar,
 	rx_tid->active = false;
 }
 
-/* TODO: it's strange (and ugly) that struct hal_reo_dest_ring is converted
- * to struct hal_wbm_release_ring, I couldn't figure out the logic behind
- * that.
- */
 static int ath12k_dp_rx_link_desc_return(struct ath12k_base *ab,
-					 struct hal_reo_dest_ring *ring,
+					 struct ath12k_buffer_addr *buf_addr_info,
 					 enum hal_wbm_rel_bm_act action)
 {
-	struct hal_wbm_release_ring *link_desc = (struct hal_wbm_release_ring *)ring;
 	struct hal_wbm_release_ring *desc;
 	struct ath12k_dp *dp = &ab->dp;
 	struct hal_srng *srng;
@@ -869,7 +864,7 @@ static int ath12k_dp_rx_link_desc_return(struct ath12k_base *ab,
 		goto exit;
 	}
 
-	ath12k_hal_rx_msdu_link_desc_set(ab, desc, link_desc, action);
+	ath12k_hal_rx_msdu_link_desc_set(ab, desc, buf_addr_info, action);
 
 exit:
 	ath12k_hal_srng_access_end(ab, srng);
@@ -882,14 +877,17 @@ static int ath12k_dp_rx_link_desc_return(struct ath12k_base *ab,
 static void ath12k_dp_rx_frags_cleanup(struct ath12k_dp_rx_tid *rx_tid,
 				       bool rel_link_desc)
 {
+	struct ath12k_buffer_addr *buf_addr_info;
 	struct ath12k_base *ab = rx_tid->ab;
 
 	lockdep_assert_held(&ab->base_lock);
 
 	if (rx_tid->dst_ring_desc) {
-		if (rel_link_desc)
-			ath12k_dp_rx_link_desc_return(ab, rx_tid->dst_ring_desc,
+		if (rel_link_desc) {
+			buf_addr_info = &rx_tid->dst_ring_desc->buf_addr_info;
+			ath12k_dp_rx_link_desc_return(ab, buf_addr_info,
 						      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
+		}
 		kfree(rx_tid->dst_ring_desc);
 		rx_tid->dst_ring_desc = NULL;
 	}
@@ -3507,7 +3505,7 @@ static int ath12k_dp_rx_frag_h_mpdu(struct ath12k *ar,
 			goto out_unlock;
 		}
 	} else {
-		ath12k_dp_rx_link_desc_return(ab, ring_desc,
+		ath12k_dp_rx_link_desc_return(ab, &ring_desc->buf_addr_info,
 					      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
 	}
 
@@ -3620,7 +3618,7 @@ ath12k_dp_process_rx_err_buf(struct ath12k *ar, struct hal_reo_dest_ring *desc,
 
 	if (ath12k_dp_rx_frag_h_mpdu(ar, msdu, desc)) {
 		dev_kfree_skb_any(msdu);
-		ath12k_dp_rx_link_desc_return(ar->ab, desc,
+		ath12k_dp_rx_link_desc_return(ar->ab, &desc->buf_addr_info,
 					      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
 	}
 exit:
@@ -3699,7 +3697,8 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 		    rbm != partner_ab->hw_params->hal_params->rx_buf_rbm) {
 			ab->soc_stats.invalid_rbm++;
 			ath12k_warn(ab, "invalid return buffer manager %d\n", rbm);
-			ath12k_dp_rx_link_desc_return(partner_ab, reo_desc,
+			ath12k_dp_rx_link_desc_return(partner_ab,
+						      &reo_desc->buf_addr_info,
 						      HAL_WBM_REL_BM_ACT_REL_MSDU);
 			continue;
 		}
@@ -3717,7 +3716,8 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
 			drop = true;
 
 			/* Return the link desc back to wbm idle list */
-			ath12k_dp_rx_link_desc_return(partner_ab, reo_desc,
+			ath12k_dp_rx_link_desc_return(partner_ab,
+						      &reo_desc->buf_addr_info,
 						      HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
 		}
 
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.c b/drivers/net/wireless/ath/ath12k/hal_rx.c
index 98eeccc68fcd..837284992cd9 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.c
@@ -447,16 +447,16 @@ void ath12k_hal_rx_reo_ent_paddr_get(struct ath12k_base *ab,
 }
 
 void ath12k_hal_rx_msdu_link_desc_set(struct ath12k_base *ab,
-				      struct hal_wbm_release_ring *dst_desc,
-				      struct hal_wbm_release_ring *src_desc,
+				      struct hal_wbm_release_ring *desc,
+				      struct ath12k_buffer_addr *buf_addr_info,
 				      enum hal_wbm_rel_bm_act action)
 {
-	dst_desc->buf_addr_info = src_desc->buf_addr_info;
-	dst_desc->info0 |= le32_encode_bits(HAL_WBM_REL_SRC_MODULE_SW,
-					    HAL_WBM_RELEASE_INFO0_REL_SRC_MODULE) |
-			   le32_encode_bits(action, HAL_WBM_RELEASE_INFO0_BM_ACTION) |
-			   le32_encode_bits(HAL_WBM_REL_DESC_TYPE_MSDU_LINK,
-					    HAL_WBM_RELEASE_INFO0_DESC_TYPE);
+	desc->buf_addr_info = *buf_addr_info;
+	desc->info0 |= le32_encode_bits(HAL_WBM_REL_SRC_MODULE_SW,
+					HAL_WBM_RELEASE_INFO0_REL_SRC_MODULE) |
+		    le32_encode_bits(action, HAL_WBM_RELEASE_INFO0_BM_ACTION) |
+		    le32_encode_bits(HAL_WBM_REL_DESC_TYPE_MSDU_LINK,
+				     HAL_WBM_RELEASE_INFO0_DESC_TYPE);
 }
 
 void ath12k_hal_reo_status_queue_stats(struct ath12k_base *ab, struct hal_tlv_64_hdr *tlv,
diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
index c753eb2a03ad..ef8bda3c0fc2 100644
--- a/drivers/net/wireless/ath/ath12k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
@@ -1141,8 +1141,8 @@ void ath12k_hal_rx_msdu_link_info_get(struct hal_rx_msdu_link *link, u32 *num_ms
 				      u32 *msdu_cookies,
 				      enum hal_rx_buf_return_buf_manager *rbm);
 void ath12k_hal_rx_msdu_link_desc_set(struct ath12k_base *ab,
-				      struct hal_wbm_release_ring *dst_desc,
-				      struct hal_wbm_release_ring *src_desc,
+				      struct hal_wbm_release_ring *desc,
+				      struct ath12k_buffer_addr *buf_addr_info,
 				      enum hal_wbm_rel_bm_act action);
 void ath12k_hal_rx_buf_addr_info_set(struct ath12k_buffer_addr *binfo,
 				     dma_addr_t paddr, u32 cookie, u8 manager);
-- 
2.34.1


