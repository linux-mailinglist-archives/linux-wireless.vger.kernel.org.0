Return-Path: <linux-wireless+bounces-29864-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84493CCA02D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 02:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D55D3019BF3
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 01:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4ED26F2B8;
	Thu, 18 Dec 2025 01:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KprRR0R2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I3X2J4rc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE05C26E6F4
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022915; cv=none; b=cSsPddw/D1P5FzIjgdFsHQrbTrnb5HW6NaMcWCZpJJABG8ikS6z9gJ60xhyzIKbfVDA2qiH1ttiJaL43CDyuO9+KXPvDdzYDc8cfYSZ2hQX0Z1mzwVQAuqKc7+pliVSe/rvg7J0xDgIlR+0rzaJ1s9t8VDeIun76+RoTA9wHWAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022915; c=relaxed/simple;
	bh=oOYjLQ5+u4ui1H2sag+gIA6h0X8aCtfAGAj4TCL1230=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YufA3clmcX0TuCmSEpqCvZGnnLZ/JAZ1imR3a30MzLYDvC5OPM+LCZo4rDHnit7hhnWHRq7vFXZhZw2xoIKATDBJ7D5UQE5cyBTTL0I4gZgjI45krmqoCUnpyObh8Iwb64FQqg/D67yW/jRp6g2Imfcb1bAIIWy5L24hubpvcHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KprRR0R2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I3X2J4rc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1YbGB813789
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tJk3Q0+MS5u8Oi6Z4LN2M/8NwLLBO3cAu0s+bHFvby8=; b=KprRR0R20S3BXHy6
	0mk4EFZD8YIl35D6Vj+2oUfoC84SSolyFLcWTqCtnoHNNBKBuxenFGwqftmWRrEV
	9gwXeRun5AZqEAqH4RB3vxHm0xdLmwZ2kyLQhd3TXMAZMNK3OzzNCjVQa2OY6aGQ
	oQQn6RcJFE5+mkqV6xtPtbcl2Pj5j8StnqcWnS3L1Cvj+7AGAqwb1lJhC2zP4DrL
	lKXMUnFjzvEurkG366X2gtvhAqLmQrAeNxIp5s5H7gt/mzeIImmdxsfPbpOYU2Cg
	Ly5hToRbyAc2nNJPe1RdHxtqblSHn76v7mEPd8AFYIEXGR+00S0FllHedsfAv+oP
	XpUHZw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40v796u5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:12 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29e6b269686so3301905ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 17:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766022911; x=1766627711; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJk3Q0+MS5u8Oi6Z4LN2M/8NwLLBO3cAu0s+bHFvby8=;
        b=I3X2J4rcZLbhZ+ohHS2iF5I18boMtdqq8LjaRjuOZ93YGzOXEnswNme0q6YpbnnnPL
         H3Ok/F2dFpXK4epyxRgmolctOlZoQyR9bjfKEghYP8TS/TVVEBn3xVOSqQRvECW2lQgN
         HlTwRMSwt0Qw/MdjN+BACaeeP06s4/3c4g+WEWqYg/KGK5aWFUhxd0KmJgm/zymQ0YVK
         p0TXlxpm6qijWr2vuOLf013gy7PASHBATyMjOdDCHJv8/7uXuCfZcN/Fs1GnrCMjC/Yk
         rwLlFKrybcfFjIrSx6asUocEU2Q3bmK9f2npah2oxod6vhoSJNLUbJLYCKRXeaUjLMlD
         yvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766022911; x=1766627711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tJk3Q0+MS5u8Oi6Z4LN2M/8NwLLBO3cAu0s+bHFvby8=;
        b=lxRkHcnkGSzerIIEBjHMwkSoR2/zmE6RbYSSgeBzxgfGDKb9Zm63MFE+vG0cUuo7tp
         9AktDHtsX9mxFaec83wkEy23dYOaEMv6vKL2Wdh+UrlDZlUq34ljiulfCY4xrm+GyIyu
         polBip5NJ00mkrdy8/XAKiGTWcL6OJdcbeD+NtiS2PitwfMcCcSaFub9o/MVT07r8MMG
         DjTYsgb+miuJx7xxswQMcXGirWRAbQiG0kPzgLg0bz0E9lyWTQE6opCHwGtFTRvtn/I4
         9TsT9KLzxtHob/AfFe4xdovv+Z32gA2Y9hzndJM2wwAQoEi2r86+fjOum5Pe0som6akf
         Rf3Q==
X-Gm-Message-State: AOJu0YzC1hhfvgDdFp0DusUEC+9y9KWuvBnDuZhGJBvsKL1sPpacfyyN
	lHmCZiJi6IkMjedOu2GgUV7iFm6upyOpATgyKKut4/XBvKXa2tRbBaYQYLkQ4T4pFVl039ogRhr
	rND3I2DtEiOybtiviUVRMKOCPCPkPa6E3JnnwskprEDK6G+/cstfLjJS0cg8yNEmnZek0okXwUU
	Nb9MCb
X-Gm-Gg: AY/fxX5UeOot8ORd9lA9KXXJwi1ZYYkF9YJ2cW6w2H2ysikxV98oi7kX5QOCgPeKqF6
	0fTMh5jJ5Buc/CFcdlGJfnDN1DfTxIenK0jhw+bndULv2c2bhMa6URiCHeaOG57WsI0Wdk8Nw0c
	+d9b2UetH7GINOL2PAT14uHzImivpizNqoL2QzT6qJGLSm2B+Mkfo5sYUzPwTE9EzSg/iO660XE
	0KxN0nsXUbj8dutqLRuP4LpifKpeEMrmwJBCveAyz+gRqd02P1YoECyP1iWZINfNsnZYM9BNkiu
	JOVYMnVb9c/qvA2WrWV8P522UuYXDEUuC47KjrnHNWv+bAePAB6zu0HCOd/gBWDE0WSiCt1ZtCt
	VL4yLrHFJ6vxOyhKv8yrw4hYqrhnKLEpl01T2vMAsbKu4t7yF4yk8dw1hkOe7ooQ=
X-Received: by 2002:a17:902:f70a:b0:2a0:9d01:c3c1 with SMTP id d9443c01a7336-2a09d01d4a9mr144260795ad.1.1766022911088;
        Wed, 17 Dec 2025 17:55:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtEwZOODi5YePTeyR18dM99buf73OyxwH3M4KmZIvfMi2TAtXZlCwwuWKTxnTw0RTh+nmkcg==
X-Received: by 2002:a17:902:f70a:b0:2a0:9d01:c3c1 with SMTP id d9443c01a7336-2a09d01d4a9mr144260595ad.1.1766022910544;
        Wed, 17 Dec 2025 17:55:10 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c812sm6548175ad.15.2025.12.17.17.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:55:10 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 09:54:17 +0800
Subject: [PATCH ath-next 03/19] wifi: ath12k: refactor REO status ring
 handling
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-ath12k-support-qcc2072-v1-3-87928cf8e547@oss.qualcomm.com>
References: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
In-Reply-To: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        20251201-wlan_image_load_skip_512k-v3-1-bedb5498a58a@oss.qualcomm.com,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: H0UKLl-1gGVzEtfn85yr3jmOhIiMk9ch
X-Proofpoint-GUID: H0UKLl-1gGVzEtfn85yr3jmOhIiMk9ch
X-Authority-Analysis: v=2.4 cv=f8JFxeyM c=1 sm=1 tr=0 ts=69435f00 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=PMNv47187FcU-8MNZ6AA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDAxMyBTYWx0ZWRfXwBciPYU9oCeL
 pBGf/utImGegqzxrJFCh5tdnD8WDJul0eI0AWzoznyzglK3IiQHlIu4oGT8ydHmJsg+cEimkQ05
 1IoemFNDb1p5dW0dWIJDefnHvkojjZxwLbN3GEfUQlbulVtHufiFSB6ppRuC5l+hWKGm+CCFopg
 b4OVawhRE+FtILt3F9VgEdQRzc0ecTVlL7TlsbnKA9EVIUmthenaXYdbgUfOfO7BTwMuXikKOz3
 FxgOuzpNhQWhihAP/X+Nj5BmuYqLmIbAwCFXtqTg9uBgi6u1UM6Zx/qftC7CoaREDkaZ2cNhkJ6
 OdMGePfM3zFbLVrmUbw9JbgabMzg/buzy1efdqwZOX3gIHIs0eRSkITmzEjCVvmt7XSGyZ6e1KJ
 EH2jb4GV8OWR8lX/wKZlp+I/O+elIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180013

The entry of REO status ring of existing chips has a 64 bit TLV header,
hence below functions take a 64 bit TLV assumption by default

        ath12k_wifi7_dp_rx_process_reo_status()
        ath12k_wifi7_hal_reo_status_queue_stats()
        ath12k_wifi7_hal_reo_flush_queue_status()
        ath12k_wifi7_hal_reo_flush_cache_status()
        ath12k_wifi7_hal_reo_unblk_cache_status()
        ath12k_wifi7_hal_reo_flush_timeout_list_status()
        ath12k_wifi7_hal_reo_desc_thresh_reached_status()
        ath12k_wifi7_hal_reo_update_rx_reo_queue_status()

However this is not the case for QCC2072 of which the TLV is 32 bit.

Refactor above functions to prepare for QCC2072 support, this is done by
removing TLV length assumption and offloading TLV decoding work to a newly
added callback _reo_status_dec_tlv_hdr. This way each chip can register
its own handler hence can do the work accordingly.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/hal.c              | 12 ++++++++
 drivers/net/wireless/ath/ath12k/hal.h              |  5 ++++
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c      | 18 ++++++------
 drivers/net/wireless/ath/ath12k/wifi7/hal.h        |  3 --
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    |  1 +
 drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c     | 33 +++++-----------------
 drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h     | 24 ++++++++--------
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.c    |  1 +
 8 files changed, 48 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index b19bec8ea082..bafb49ab5475 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -834,3 +834,15 @@ void *ath12k_hal_encode_tlv64_hdr(void *tlv, u64 tag, u64 len)
 	return tlv64->value;
 }
 EXPORT_SYMBOL(ath12k_hal_encode_tlv64_hdr);
+
+u16 ath12k_hal_decode_tlv64_hdr(void *tlv, void **desc)
+{
+	struct hal_tlv_64_hdr *tlv64 = tlv;
+	u16 tag;
+
+	tag = le64_get_bits(tlv64->tl, HAL_SRNG_TLV_HDR_TAG);
+	*desc = tlv64->value;
+
+	return tag;
+}
+EXPORT_SYMBOL(ath12k_hal_decode_tlv64_hdr);
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 595e49046471..81b0cb002b38 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1427,6 +1427,7 @@ struct hal_ops {
 					 struct ath12k_buffer_addr **pp_buf_addr,
 					 u8 *rbm, u32 *msdu_cnt);
 	void *(*reo_cmd_enc_tlv_hdr)(void *tlv, u64 tag, u64 len);
+	u16 (*reo_status_dec_tlv_hdr)(void *tlv, void **desc);
 };
 
 #define HAL_TLV_HDR_TAG		GENMASK(9, 1)
@@ -1450,6 +1451,9 @@ struct hal_tlv_64_hdr {
 	u8 value[];
 } __packed;
 
+#define HAL_SRNG_TLV_HDR_TAG		GENMASK(9, 1)
+#define HAL_SRNG_TLV_HDR_LEN		GENMASK(25, 10)
+
 dma_addr_t ath12k_hal_srng_get_tp_addr(struct ath12k_base *ab,
 				       struct hal_srng *srng);
 dma_addr_t ath12k_hal_srng_get_hp_addr(struct ath12k_base *ab,
@@ -1538,4 +1542,5 @@ void ath12k_hal_rx_reo_ent_buf_paddr_get(struct ath12k_hal *hal, void *rx_desc,
 					 struct ath12k_buffer_addr **pp_buf_addr,
 					 u8 *rbm, u32 *msdu_cnt);
 void *ath12k_hal_encode_tlv64_hdr(void *tlv, u64 tag, u64 len);
+u16 ath12k_hal_decode_tlv64_hdr(void *tlv, void **desc);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
index a1ca55fe51c0..dc8d72aeca45 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
@@ -2114,12 +2114,12 @@ void ath12k_wifi7_dp_rx_process_reo_status(struct ath12k_dp *dp)
 {
 	struct ath12k_base *ab = dp->ab;
 	struct ath12k_hal *hal = dp->hal;
-	struct hal_tlv_64_hdr *hdr;
 	struct hal_srng *srng;
 	struct ath12k_dp_rx_reo_cmd *cmd, *tmp;
 	bool found = false;
 	u16 tag;
 	struct hal_reo_status reo_status;
+	void *hdr, *desc;
 
 	srng = &hal->srng_list[dp->reo_status_ring.ring_id];
 
@@ -2130,35 +2130,35 @@ void ath12k_wifi7_dp_rx_process_reo_status(struct ath12k_dp *dp)
 	ath12k_hal_srng_access_begin(ab, srng);
 
 	while ((hdr = ath12k_hal_srng_dst_get_next_entry(ab, srng))) {
-		tag = le64_get_bits(hdr->tl, HAL_SRNG_TLV_HDR_TAG);
+		tag = hal->ops->reo_status_dec_tlv_hdr(hdr, &desc);
 
 		switch (tag) {
 		case HAL_REO_GET_QUEUE_STATS_STATUS:
-			ath12k_wifi7_hal_reo_status_queue_stats(ab, hdr,
+			ath12k_wifi7_hal_reo_status_queue_stats(ab, desc,
 								&reo_status);
 			break;
 		case HAL_REO_FLUSH_QUEUE_STATUS:
-			ath12k_wifi7_hal_reo_flush_queue_status(ab, hdr,
+			ath12k_wifi7_hal_reo_flush_queue_status(ab, desc,
 								&reo_status);
 			break;
 		case HAL_REO_FLUSH_CACHE_STATUS:
-			ath12k_wifi7_hal_reo_flush_cache_status(ab, hdr,
+			ath12k_wifi7_hal_reo_flush_cache_status(ab, desc,
 								&reo_status);
 			break;
 		case HAL_REO_UNBLOCK_CACHE_STATUS:
-			ath12k_wifi7_hal_reo_unblk_cache_status(ab, hdr,
+			ath12k_wifi7_hal_reo_unblk_cache_status(ab, desc,
 								&reo_status);
 			break;
 		case HAL_REO_FLUSH_TIMEOUT_LIST_STATUS:
-			ath12k_wifi7_hal_reo_flush_timeout_list_status(ab, hdr,
+			ath12k_wifi7_hal_reo_flush_timeout_list_status(ab, desc,
 								       &reo_status);
 			break;
 		case HAL_REO_DESCRIPTOR_THRESHOLD_REACHED_STATUS:
-			ath12k_wifi7_hal_reo_desc_thresh_reached_status(ab, hdr,
+			ath12k_wifi7_hal_reo_desc_thresh_reached_status(ab, desc,
 									&reo_status);
 			break;
 		case HAL_REO_UPDATE_RX_REO_QUEUE_STATUS:
-			ath12k_wifi7_hal_reo_update_rx_reo_queue_status(ab, hdr,
+			ath12k_wifi7_hal_reo_update_rx_reo_queue_status(ab, desc,
 									&reo_status);
 			break;
 		default:
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.h b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
index 7d65b82c61f2..9337225a5253 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.h
@@ -369,9 +369,6 @@
 #define HAL_DEFAULT_BE_BK_VI_REO_TIMEOUT_USEC	(100 * 1000)
 #define HAL_DEFAULT_VO_REO_TIMEOUT_USEC		(40 * 1000)
 
-#define HAL_SRNG_TLV_HDR_TAG		GENMASK(9, 1)
-#define HAL_SRNG_TLV_HDR_LEN		GENMASK(25, 10)
-
 #define HAL_SRNG_DESC_LOOP_CNT		0xf0000000
 
 #define HAL_REO_CMD_FLG_NEED_STATUS		BIT(0)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index ff26e9684e9e..95850e6dc6c7 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -1030,4 +1030,5 @@ const struct hal_ops hal_qcn9274_ops = {
 	.rx_msdu_list_get = ath12k_wifi7_hal_rx_msdu_list_get,
 	.rx_reo_ent_buf_paddr_get = ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get,
 	.reo_cmd_enc_tlv_hdr = ath12k_hal_encode_tlv64_hdr,
+	.reo_status_dec_tlv_hdr = ath12k_hal_decode_tlv64_hdr,
 };
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
index 3b8710a3b6ad..a88ef126aada 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
@@ -543,12 +543,9 @@ ath12k_wifi7_hal_rx_msdu_link_desc_set(struct ath12k_base *ab,
 }
 
 void ath12k_wifi7_hal_reo_status_queue_stats(struct ath12k_base *ab,
-					     struct hal_tlv_64_hdr *tlv,
+					     struct hal_reo_get_queue_stats_status *desc,
 					     struct hal_reo_status *status)
 {
-	struct hal_reo_get_queue_stats_status *desc =
-		(struct hal_reo_get_queue_stats_status *)tlv->value;
-
 	status->uniform_hdr.cmd_num =
 				le32_get_bits(desc->hdr.info0,
 					      HAL_REO_STATUS_HDR_INFO0_STATUS_NUM);
@@ -607,12 +604,9 @@ void ath12k_wifi7_hal_reo_status_queue_stats(struct ath12k_base *ab,
 }
 
 void ath12k_wifi7_hal_reo_flush_queue_status(struct ath12k_base *ab,
-					     struct hal_tlv_64_hdr *tlv,
+					     struct hal_reo_flush_queue_status *desc,
 					     struct hal_reo_status *status)
 {
-	struct hal_reo_flush_queue_status *desc =
-		(struct hal_reo_flush_queue_status *)tlv->value;
-
 	status->uniform_hdr.cmd_num =
 			le32_get_bits(desc->hdr.info0,
 				      HAL_REO_STATUS_HDR_INFO0_STATUS_NUM);
@@ -626,12 +620,10 @@ void ath12k_wifi7_hal_reo_flush_queue_status(struct ath12k_base *ab,
 
 void
 ath12k_wifi7_hal_reo_flush_cache_status(struct ath12k_base *ab,
-					struct hal_tlv_64_hdr *tlv,
+					struct hal_reo_flush_cache_status *desc,
 					struct hal_reo_status *status)
 {
 	struct ath12k_hal *hal = &ab->hal;
-	struct hal_reo_flush_cache_status *desc =
-		(struct hal_reo_flush_cache_status *)tlv->value;
 
 	status->uniform_hdr.cmd_num =
 			le32_get_bits(desc->hdr.info0,
@@ -668,12 +660,10 @@ ath12k_wifi7_hal_reo_flush_cache_status(struct ath12k_base *ab,
 }
 
 void ath12k_wifi7_hal_reo_unblk_cache_status(struct ath12k_base *ab,
-					     struct hal_tlv_64_hdr *tlv,
+					     struct hal_reo_unblock_cache_status *desc,
 					     struct hal_reo_status *status)
 {
 	struct ath12k_hal *hal = &ab->hal;
-	struct hal_reo_unblock_cache_status *desc =
-		(struct hal_reo_unblock_cache_status *)tlv->value;
 
 	status->uniform_hdr.cmd_num =
 			le32_get_bits(desc->hdr.info0,
@@ -697,12 +687,9 @@ void ath12k_wifi7_hal_reo_unblk_cache_status(struct ath12k_base *ab,
 
 void
 ath12k_wifi7_hal_reo_flush_timeout_list_status(struct ath12k_base *ab,
-					       struct hal_tlv_64_hdr *tlv,
+					       struct hal_reo_flush_timeout_list_status *desc,
 					       struct hal_reo_status *status)
 {
-	struct hal_reo_flush_timeout_list_status *desc =
-		(struct hal_reo_flush_timeout_list_status *)tlv->value;
-
 	status->uniform_hdr.cmd_num =
 			le32_get_bits(desc->hdr.info0,
 				      HAL_REO_STATUS_HDR_INFO0_STATUS_NUM);
@@ -727,12 +714,9 @@ ath12k_wifi7_hal_reo_flush_timeout_list_status(struct ath12k_base *ab,
 
 void
 ath12k_wifi7_hal_reo_desc_thresh_reached_status(struct ath12k_base *ab,
-						struct hal_tlv_64_hdr *tlv,
+						struct hal_reo_desc_thresh_reached_status *desc,
 						struct hal_reo_status *status)
 {
-	struct hal_reo_desc_thresh_reached_status *desc =
-		(struct hal_reo_desc_thresh_reached_status *)tlv->value;
-
 	status->uniform_hdr.cmd_num =
 			le32_get_bits(desc->hdr.info0,
 				      HAL_REO_STATUS_HDR_INFO0_STATUS_NUM);
@@ -762,12 +746,9 @@ ath12k_wifi7_hal_reo_desc_thresh_reached_status(struct ath12k_base *ab,
 }
 
 void ath12k_wifi7_hal_reo_update_rx_reo_queue_status(struct ath12k_base *ab,
-						     struct hal_tlv_64_hdr *tlv,
+						     struct hal_reo_status_hdr *desc,
 						     struct hal_reo_status *status)
 {
-	struct hal_reo_status_hdr *desc =
-		(struct hal_reo_status_hdr *)tlv->value;
-
 	status->uniform_hdr.cmd_num =
 			le32_get_bits(desc->info0,
 				      HAL_REO_STATUS_HDR_INFO0_STATUS_NUM);
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
index aa1bca813955..95f5595b30ad 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
@@ -813,25 +813,27 @@ enum hal_mon_reception_type {
 			(HAL_RU(ru_per80, num_80mhz, ru_idx_per80mhz))
 
 void ath12k_wifi7_hal_reo_status_queue_stats(struct ath12k_base *ab,
-					     struct hal_tlv_64_hdr *tlv,
+					     struct hal_reo_get_queue_stats_status *desc,
 					     struct hal_reo_status *status);
 void ath12k_wifi7_hal_reo_flush_queue_status(struct ath12k_base *ab,
-					     struct hal_tlv_64_hdr *tlv,
+					     struct hal_reo_flush_queue_status *desc,
 					     struct hal_reo_status *status);
 void ath12k_wifi7_hal_reo_flush_cache_status(struct ath12k_base *ab,
-					     struct hal_tlv_64_hdr *tlv,
+					     struct hal_reo_flush_cache_status *desc,
 					     struct hal_reo_status *status);
 void ath12k_wifi7_hal_reo_unblk_cache_status(struct ath12k_base *ab,
-					     struct hal_tlv_64_hdr *tlv,
+					     struct hal_reo_unblock_cache_status *desc,
 					     struct hal_reo_status *status);
-void ath12k_wifi7_hal_reo_flush_timeout_list_status(struct ath12k_base *ab,
-						    struct hal_tlv_64_hdr *tlv,
-						    struct hal_reo_status *status);
-void ath12k_wifi7_hal_reo_desc_thresh_reached_status(struct ath12k_base *ab,
-						     struct hal_tlv_64_hdr *tlv,
-						     struct hal_reo_status *status);
+void
+ath12k_wifi7_hal_reo_flush_timeout_list_status(struct ath12k_base *ab,
+					       struct hal_reo_flush_timeout_list_status *desc,
+					       struct hal_reo_status *status);
+void
+ath12k_wifi7_hal_reo_desc_thresh_reached_status(struct ath12k_base *ab,
+						struct hal_reo_desc_thresh_reached_status *desc,
+						struct hal_reo_status *status);
 void ath12k_wifi7_hal_reo_update_rx_reo_queue_status(struct ath12k_base *ab,
-						     struct hal_tlv_64_hdr *tlv,
+						     struct hal_reo_status_hdr *desc,
 						     struct hal_reo_status *status);
 void ath12k_wifi7_hal_rx_msdu_link_info_get(struct hal_rx_msdu_link *link, u32 *num_msdus,
 					    u32 *msdu_cookies,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index 49c45431c0c7..c3093c01af87 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -803,4 +803,5 @@ const struct hal_ops hal_wcn7850_ops = {
 	.rx_msdu_list_get = ath12k_wifi7_hal_rx_msdu_list_get,
 	.rx_reo_ent_buf_paddr_get = ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get,
 	.reo_cmd_enc_tlv_hdr = ath12k_hal_encode_tlv64_hdr,
+	.reo_status_dec_tlv_hdr = ath12k_hal_decode_tlv64_hdr,
 };

-- 
2.25.1


