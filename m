Return-Path: <linux-wireless+bounces-29863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD011CCA02A
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 02:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21C3F301CE8F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 01:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACBE26E6F0;
	Thu, 18 Dec 2025 01:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jH0RBl1b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q0GAPmro"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13FE26ED59
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022912; cv=none; b=GudnhRw52oQJ4UZiPGPVmDopnG7BPV7Me7wCdIKSJ6VY9jCePK9hKjtzDsUOkBMYzobeR3QV3jeCiwpYXaAL9dLlzOAQ1rQu4sxWXoEbNP4KDoZRQ8UuUrCicW4Fek3Lz4gzM06t2T+kukYhOlcuZeI7CbiB6taal5H1p9NNhcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022912; c=relaxed/simple;
	bh=1b950sAUDfPiIfZ83dpfIEmqG9IF027rMf8yl64kq0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oRbhNHWM5irdg/4q18YfB/GkUwt4dzgdqaRYTW9I3rsKriH0EeNDWBW0SfhABFWBMQcN3zo+LCiuxoUidzshJsnV35m4A+H9Nl5+Tlb0exD9q22hPjgsZciLqSLeW66xuXtlMaXlYW/Xx83Hqvd6OtcpxYlOynw+Ab6/5fViop4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jH0RBl1b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q0GAPmro; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1Yim13717065
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xO/Z8OTWEryPFUqXFceT9Nx46ORhtkGydwhL3x4O9+Q=; b=jH0RBl1buQK0ans5
	5bglJZVts1Q4oGXYDHpkBTDc4aBKBzqfmsL5wVGM+kCGZYLfYQjnUOBcNpYsyPBL
	3n6pbf6p6Gt51Tyt765XEOZ2Y/UrNmFIZJ+vpaj/niqaylDi77VBgoJMkTUfwkQR
	H0QY/xSMZW/npeD3/DjcAv0U9W2IOXj/AezRT1HEDeB1cYvogQ0/H7BZxVa1TM08
	PLTGLubHMdt9ReoqTk8WvA5rPZhvUDvRprd0QRDfjQ2zyXexgOLmyNVTGehBORIu
	6ylb9ZcU/VTgDu0ZDBMin6LYMcEz9lPS5Ltx3C1guVsmznuwuyrPZPXz+zl/puy+
	cQyYIg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40n79arx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f1f69eec6so1817295ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 17:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766022909; x=1766627709; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xO/Z8OTWEryPFUqXFceT9Nx46ORhtkGydwhL3x4O9+Q=;
        b=Q0GAPmroZyXTlAWwal5NKW65/LvQ+kFGRetjY2Km7J7f049V+AOYU0aAZBX37UzjdI
         u7JDw+UVLy1q4tp7JG4BVepZ+1oDrqXliahyWmEAp8hekEWK+Y2X530GhFNdCx19tAu/
         oOoU8fj+dX/udMoxkYGv3m/QI+O6B5zIkak9nzqCeNFn7a+xWB5G/PoVmk8Q1iltW1cU
         95DPsDAgkjohgPh6Xn6AacMSCR5CL0CanUwvsM2WJPA1URQOZfjQyyUOcpnDZ3foYz35
         gamCZq6wsSrkddqg1OZVFbuKB/7G3Dn56Ug81NIvlgJP87pC5CDZ43QFKawvWWBWTYPI
         rLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766022909; x=1766627709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xO/Z8OTWEryPFUqXFceT9Nx46ORhtkGydwhL3x4O9+Q=;
        b=uaHjrFnuua8cWeRBW9EJ/ArLcRybzxcX0DKbjpmZrNR3xm+gTVhYUbOAXDTayW0E01
         NSUy60sl8K5sVm97CoXgDdZhKBH6T6B9O67r3Z6QmCEB6M0DB9rg3NgbesYLP+cdG7lw
         7PaL5MQErNtLnsVKpebiFZs6tGUKQBAtgdedF78A6Aut4Vaq5CctpDRySNYDm6KytT0N
         QbNzZughEwwjPUAeXq/UZfShe6INEYG3YyA8JwcHkIAlPLaLI/OEQSLEAGyR5rRHiqql
         zfYnjiWXoquOL1RPKSn4Hl2nZYI+gd3BV8T4CDkzn3ybhIlIvHHzQWCxYMPAyjI7a3VO
         MkUQ==
X-Gm-Message-State: AOJu0YyYhhtA8F/VybZPaHH1RdSvhmGGFjtPl25cLUrYRWxDFS/Hbl6f
	tnHKAae0hOifejlPwbco78PGddfllq6Pp3TFcuPAbHlKPrLFOOyRkn0hVDWfheEVuCsihgHyv6L
	Q9pY4KaEPx439CvDxp58YaEs3gky4K8mDScp8tBoipIHheIfoXueaXDwtBcLRqN5LoV2hBA==
X-Gm-Gg: AY/fxX7O78+8TW678FT935anB2lihcUyJiQTvVZnhC0XY3/mysXeAryZudV3E6BXQhJ
	ETLh0WrF/yHmiRE0IsB+v0jWF5Fvvx64n5xncHD5he8AleeJhimGC44Q+ql1WuJ8yfG8Jj6u/hH
	PWvEUufVy1KSxVYIv0oTTPTUTHkLKn2qMVOgHYhvh/WpXxXAiGR65gOOOEaE9HvHajdKZyx/WMk
	qfjE6SeQWWIM1Fsapg1WRGirDGY4ETboAmw1gXYEslQ4nEzL5zTq79S1Jpd1EPzxZHmLmUpq05/
	gFEvFMg/t0VCFxibyvuI+iySrWEo7LNxWssdcvYjTZJvlizCOwczEFe+uhkBvIuEuUNxihWiuwJ
	bF+tYv+9l5zBPn7HRem1VKbpViMZKPgqtynm12xyRdacfWMO9NDvzwF7XV+yTZSM=
X-Received: by 2002:a17:903:3843:b0:2a0:d629:903f with SMTP id d9443c01a7336-2a0d6299386mr110161055ad.9.1766022908995;
        Wed, 17 Dec 2025 17:55:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLFkPskK3UxU2NlNOh1xNwyPH5m6dKFSekMOkjDUjCPJgtW6g8xoDb/VwCMhtkGyOa7YlT8g==
X-Received: by 2002:a17:903:3843:b0:2a0:d629:903f with SMTP id d9443c01a7336-2a0d6299386mr110160875ad.9.1766022908433;
        Wed, 17 Dec 2025 17:55:08 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c812sm6548175ad.15.2025.12.17.17.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:55:08 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 09:54:16 +0800
Subject: [PATCH ath-next 02/19] wifi: ath12k: refactor REO CMD ring
 handling
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-ath12k-support-qcc2072-v1-2-87928cf8e547@oss.qualcomm.com>
References: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
In-Reply-To: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        20251201-wlan_image_load_skip_512k-v3-1-bedb5498a58a@oss.qualcomm.com,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: O7apzdyaiJ1DgMmcFoVA9KGREJLXZIzB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDAxMyBTYWx0ZWRfX+m9XhcmaWpBD
 U4mNbqiSKnt71r58pmSEjizFGhHzSGSyLbF5hoL6AG5Mj3qjwOuE11jshxSLjNJkgTwMR0JuEPX
 m6iVrseWwYmTWi+Gwqn3Uzo95vFMxumPzZHZEUMk30iB3aup+nB8sRZsbzEwwAi+cUo1EjjlXs3
 CAgHupME0b4vk49oRKQ30uv7f9N7lehE+J2b0+nMtuVVf+IvWqghWyEKy9WhL65hHKf3h5lpvCf
 GVNgY5VPuYoeiorZ1VO1f4ajHcckpNIHl3OdNZXWGyfVaUCxp3ZJSL7z/Z3SPVQmx+yyDkhhX6Z
 Tzoz8FQAEpQfqpPK2Zi6rhkKX8mM+4K7TPbnJQCip6sT/i/+ge8xjK5csmHY578uV6bSyNMTgkG
 uxw9lZfEprVTHKsF8BQsGxFdmPuNGA==
X-Authority-Analysis: v=2.4 cv=TZebdBQh c=1 sm=1 tr=0 ts=69435efd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=N_EWgtucFCvFHXU7mioA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: O7apzdyaiJ1DgMmcFoVA9KGREJLXZIzB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180013

The entry of REO CMD ring of existing chips has a 64 bit TLV header, hence
below functions take a 64 bit TLV assumption by default

        ath12k_wifi7_hal_reo_init_cmd_ring()
        ath12k_wifi7_hal_reo_cmd_queue_stats()
        ath12k_wifi7_hal_reo_cmd_flush_cache()
        ath12k_wifi7_hal_reo_cmd_update_rx_queue()

However this is not the case for QCC2072 of which the TLV is 32 bit,
meaning above functions don't work for it.

Rename/refactor above functions to prepare for QCC2072 support:

Rename the first one to ath12k_wifi7_hal_reo_init_cmd_ring_tlv64() to
better reflect what it is doing. There will be a 32 bit variant when
QCC2072 support is in place.

For the last ones, remove TLV length assumption and offload TLV encoding
work to a newly added callback _reo_cmd_enc_tlv_hdr. This way each chip
can register its own handler hence can do the work accordingly.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/hal.c              | 11 ++++++
 drivers/net/wireless/ath/ath12k/hal.h              | 23 +++++++++++++
 drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h   | 21 ------------
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    |  3 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c     | 39 +++++++++-------------
 drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h     |  4 +--
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.c    |  3 +-
 7 files changed, 56 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index c7a152490fa0..b19bec8ea082 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -823,3 +823,14 @@ void ath12k_hal_dump_srng_stats(struct ath12k_base *ab)
 				   jiffies_to_msecs(jiffies - srng->timestamp));
 	}
 }
+
+void *ath12k_hal_encode_tlv64_hdr(void *tlv, u64 tag, u64 len)
+{
+	struct hal_tlv_64_hdr *tlv64 = tlv;
+
+	tlv64->tl = le64_encode_bits(tag, HAL_TLV_HDR_TAG) |
+		    le64_encode_bits(len, HAL_TLV_HDR_LEN);
+
+	return tlv64->value;
+}
+EXPORT_SYMBOL(ath12k_hal_encode_tlv64_hdr);
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index f23ba1f9eaac..595e49046471 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1426,8 +1426,30 @@ struct hal_ops {
 					 u32 *sw_cookie,
 					 struct ath12k_buffer_addr **pp_buf_addr,
 					 u8 *rbm, u32 *msdu_cnt);
+	void *(*reo_cmd_enc_tlv_hdr)(void *tlv, u64 tag, u64 len);
 };
 
+#define HAL_TLV_HDR_TAG		GENMASK(9, 1)
+#define HAL_TLV_HDR_LEN		GENMASK(25, 10)
+#define HAL_TLV_USR_ID		GENMASK(31, 26)
+
+#define HAL_TLV_ALIGN	4
+
+struct hal_tlv_hdr {
+	__le32 tl;
+	u8 value[];
+} __packed;
+
+#define HAL_TLV_64_HDR_TAG		GENMASK(9, 1)
+#define HAL_TLV_64_HDR_LEN		GENMASK(21, 10)
+#define HAL_TLV_64_USR_ID		GENMASK(31, 26)
+#define HAL_TLV_64_ALIGN		8
+
+struct hal_tlv_64_hdr {
+	__le64 tl;
+	u8 value[];
+} __packed;
+
 dma_addr_t ath12k_hal_srng_get_tp_addr(struct ath12k_base *ab,
 				       struct hal_srng *srng);
 dma_addr_t ath12k_hal_srng_get_hp_addr(struct ath12k_base *ab,
@@ -1515,4 +1537,5 @@ void ath12k_hal_rx_reo_ent_buf_paddr_get(struct ath12k_hal *hal, void *rx_desc,
 					 dma_addr_t *paddr, u32 *sw_cookie,
 					 struct ath12k_buffer_addr **pp_buf_addr,
 					 u8 *rbm, u32 *msdu_cnt);
+void *ath12k_hal_encode_tlv64_hdr(void *tlv, u64 tag, u64 len);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
index 9dad8f7ca9f2..cdcf24b1d6eb 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
@@ -487,27 +487,6 @@ enum hal_tlv_tag {
 	HAL_TLV_BASE						= 511 /* 0x1ff */,
 };
 
-#define HAL_TLV_HDR_TAG		GENMASK(9, 1)
-#define HAL_TLV_HDR_LEN		GENMASK(25, 10)
-#define HAL_TLV_USR_ID          GENMASK(31, 26)
-
-#define HAL_TLV_ALIGN	4
-
-struct hal_tlv_hdr {
-	__le32 tl;
-	u8 value[];
-} __packed;
-
-#define HAL_TLV_64_HDR_TAG		GENMASK(9, 1)
-#define HAL_TLV_64_HDR_LEN		GENMASK(21, 10)
-#define HAL_TLV_64_USR_ID		GENMASK(31, 26)
-#define HAL_TLV_64_ALIGN		8
-
-struct hal_tlv_64_hdr {
-	__le64 tl;
-	u8 value[];
-} __packed;
-
 #define RX_MPDU_DESC_INFO0_MSDU_COUNT		GENMASK(7, 0)
 #define RX_MPDU_DESC_INFO0_FRAG_FLAG		BIT(8)
 #define RX_MPDU_DESC_INFO0_MPDU_RETRY		BIT(9)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index c129e937132b..ff26e9684e9e 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -1020,7 +1020,7 @@ const struct hal_ops hal_qcn9274_ops = {
 	.write_reoq_lut_addr = ath12k_wifi7_hal_write_reoq_lut_addr,
 	.write_ml_reoq_lut_addr = ath12k_wifi7_hal_write_ml_reoq_lut_addr,
 	.setup_link_idle_list = ath12k_wifi7_hal_setup_link_idle_list,
-	.reo_init_cmd_ring = ath12k_wifi7_hal_reo_init_cmd_ring,
+	.reo_init_cmd_ring = ath12k_wifi7_hal_reo_init_cmd_ring_tlv64,
 	.reo_hw_setup = ath12k_wifi7_hal_reo_hw_setup,
 	.reo_shared_qaddr_cache_clear = ath12k_wifi7_hal_reo_shared_qaddr_cache_clear,
 	.rx_buf_addr_info_set = ath12k_wifi7_hal_rx_buf_addr_info_set,
@@ -1029,4 +1029,5 @@ const struct hal_ops hal_qcn9274_ops = {
 	.get_idle_link_rbm = ath12k_wifi7_hal_get_idle_link_rbm,
 	.rx_msdu_list_get = ath12k_wifi7_hal_rx_msdu_list_get,
 	.rx_reo_ent_buf_paddr_get = ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get,
+	.reo_cmd_enc_tlv_hdr = ath12k_hal_encode_tlv64_hdr,
 };
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
index 903fb52a03bf..3b8710a3b6ad 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c
@@ -23,15 +23,13 @@ void ath12k_wifi7_hal_reo_set_desc_hdr(struct hal_desc_header *hdr,
 	hdr->info0 |= le32_encode_bits(magic, HAL_DESC_HDR_INFO0_DBG_RESERVED);
 }
 
-static int ath12k_wifi7_hal_reo_cmd_queue_stats(struct hal_tlv_64_hdr *tlv,
+static int ath12k_wifi7_hal_reo_cmd_queue_stats(struct ath12k_hal *hal, void *tlv,
 						struct ath12k_hal_reo_cmd *cmd)
 {
 	struct hal_reo_get_queue_stats *desc;
 
-	tlv->tl = le64_encode_bits(HAL_REO_GET_QUEUE_STATS, HAL_TLV_HDR_TAG) |
-		  le64_encode_bits(sizeof(*desc), HAL_TLV_HDR_LEN);
-
-	desc = (struct hal_reo_get_queue_stats *)tlv->value;
+	desc = hal->ops->reo_cmd_enc_tlv_hdr(tlv, HAL_REO_GET_QUEUE_STATS,
+					     sizeof(*desc));
 	memset_startat(desc, 0, queue_addr_lo);
 
 	desc->cmd.info0 &= ~cpu_to_le32(HAL_REO_CMD_HDR_INFO0_STATUS_REQUIRED);
@@ -47,8 +45,7 @@ static int ath12k_wifi7_hal_reo_cmd_queue_stats(struct hal_tlv_64_hdr *tlv,
 	return le32_get_bits(desc->cmd.info0, HAL_REO_CMD_HDR_INFO0_CMD_NUMBER);
 }
 
-static int ath12k_wifi7_hal_reo_cmd_flush_cache(struct ath12k_hal *hal,
-						struct hal_tlv_64_hdr *tlv,
+static int ath12k_wifi7_hal_reo_cmd_flush_cache(struct ath12k_hal *hal, void *tlv,
 						struct ath12k_hal_reo_cmd *cmd)
 {
 	struct hal_reo_flush_cache *desc;
@@ -61,10 +58,8 @@ static int ath12k_wifi7_hal_reo_cmd_flush_cache(struct ath12k_hal *hal,
 		hal->current_blk_index = avail_slot;
 	}
 
-	tlv->tl = le64_encode_bits(HAL_REO_FLUSH_CACHE, HAL_TLV_HDR_TAG) |
-		  le64_encode_bits(sizeof(*desc), HAL_TLV_HDR_LEN);
-
-	desc = (struct hal_reo_flush_cache *)tlv->value;
+	desc = hal->ops->reo_cmd_enc_tlv_hdr(tlv, HAL_REO_FLUSH_CACHE,
+					     sizeof(*desc));
 	memset_startat(desc, 0, cache_addr_lo);
 
 	desc->cmd.info0 &= ~cpu_to_le32(HAL_REO_CMD_HDR_INFO0_STATUS_REQUIRED);
@@ -98,15 +93,13 @@ static int ath12k_wifi7_hal_reo_cmd_flush_cache(struct ath12k_hal *hal,
 }
 
 static int
-ath12k_wifi7_hal_reo_cmd_update_rx_queue(struct hal_tlv_64_hdr *tlv,
+ath12k_wifi7_hal_reo_cmd_update_rx_queue(struct ath12k_hal *hal, void *tlv,
 					 struct ath12k_hal_reo_cmd *cmd)
 {
 	struct hal_reo_update_rx_queue *desc;
 
-	tlv->tl = le64_encode_bits(HAL_REO_UPDATE_RX_REO_QUEUE, HAL_TLV_HDR_TAG) |
-		  le64_encode_bits(sizeof(*desc), HAL_TLV_HDR_LEN);
-
-	desc = (struct hal_reo_update_rx_queue *)tlv->value;
+	desc = hal->ops->reo_cmd_enc_tlv_hdr(tlv, HAL_REO_UPDATE_RX_REO_QUEUE,
+					     sizeof(*desc));
 	memset_startat(desc, 0, queue_addr_lo);
 
 	desc->cmd.info0 &= ~cpu_to_le32(HAL_REO_CMD_HDR_INFO0_STATUS_REQUIRED);
@@ -227,7 +220,8 @@ int ath12k_wifi7_hal_reo_cmd_send(struct ath12k_base *ab, struct hal_srng *srng,
 				  enum hal_reo_cmd_type type,
 				  struct ath12k_hal_reo_cmd *cmd)
 {
-	struct hal_tlv_64_hdr *reo_desc;
+	struct ath12k_hal *hal = &ab->hal;
+	void *reo_desc;
 	int ret;
 
 	spin_lock_bh(&srng->lock);
@@ -241,14 +235,13 @@ int ath12k_wifi7_hal_reo_cmd_send(struct ath12k_base *ab, struct hal_srng *srng,
 
 	switch (type) {
 	case HAL_REO_CMD_GET_QUEUE_STATS:
-		ret = ath12k_wifi7_hal_reo_cmd_queue_stats(reo_desc, cmd);
+		ret = ath12k_wifi7_hal_reo_cmd_queue_stats(hal, reo_desc, cmd);
 		break;
 	case HAL_REO_CMD_FLUSH_CACHE:
-		ret = ath12k_wifi7_hal_reo_cmd_flush_cache(&ab->hal, reo_desc,
-							   cmd);
+		ret = ath12k_wifi7_hal_reo_cmd_flush_cache(hal, reo_desc, cmd);
 		break;
 	case HAL_REO_CMD_UPDATE_RX_QUEUE:
-		ret = ath12k_wifi7_hal_reo_cmd_update_rx_queue(reo_desc, cmd);
+		ret = ath12k_wifi7_hal_reo_cmd_update_rx_queue(hal, reo_desc, cmd);
 		break;
 	case HAL_REO_CMD_FLUSH_QUEUE:
 	case HAL_REO_CMD_UNBLOCK_CACHE:
@@ -891,8 +884,8 @@ void ath12k_wifi7_hal_reo_qdesc_setup(struct hal_rx_reo_queue *qdesc,
 					  REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_3);
 }
 
-void ath12k_wifi7_hal_reo_init_cmd_ring(struct ath12k_base *ab,
-					struct hal_srng *srng)
+void ath12k_wifi7_hal_reo_init_cmd_ring_tlv64(struct ath12k_base *ab,
+					      struct hal_srng *srng)
 {
 	struct hal_srng_params params;
 	struct hal_tlv_64_hdr *tlv;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
index 8a0f4a781d8a..aa1bca813955 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h
@@ -860,8 +860,8 @@ void ath12k_wifi7_hal_rx_msdu_list_get(struct ath12k *ar,
 				       void *link_desc,
 				       void *msdu_list_opaque,
 				       u16 *num_msdus);
-void ath12k_wifi7_hal_reo_init_cmd_ring(struct ath12k_base *ab,
-					struct hal_srng *srng);
+void ath12k_wifi7_hal_reo_init_cmd_ring_tlv64(struct ath12k_base *ab,
+					      struct hal_srng *srng);
 void ath12k_wifi7_hal_reo_shared_qaddr_cache_clear(struct ath12k_base *ab);
 void ath12k_wifi7_hal_reo_hw_setup(struct ath12k_base *ab, u32 ring_hash_map);
 void ath12k_wifi7_hal_reo_qdesc_setup(struct hal_rx_reo_queue *qdesc,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index 7108cc41536d..49c45431c0c7 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -793,7 +793,7 @@ const struct hal_ops hal_wcn7850_ops = {
 	.write_reoq_lut_addr = ath12k_wifi7_hal_write_reoq_lut_addr,
 	.write_ml_reoq_lut_addr = ath12k_wifi7_hal_write_ml_reoq_lut_addr,
 	.setup_link_idle_list = ath12k_wifi7_hal_setup_link_idle_list,
-	.reo_init_cmd_ring = ath12k_wifi7_hal_reo_init_cmd_ring,
+	.reo_init_cmd_ring = ath12k_wifi7_hal_reo_init_cmd_ring_tlv64,
 	.reo_shared_qaddr_cache_clear = ath12k_wifi7_hal_reo_shared_qaddr_cache_clear,
 	.reo_hw_setup = ath12k_wifi7_hal_reo_hw_setup,
 	.rx_buf_addr_info_set = ath12k_wifi7_hal_rx_buf_addr_info_set,
@@ -802,4 +802,5 @@ const struct hal_ops hal_wcn7850_ops = {
 	.get_idle_link_rbm = ath12k_wifi7_hal_get_idle_link_rbm,
 	.rx_msdu_list_get = ath12k_wifi7_hal_rx_msdu_list_get,
 	.rx_reo_ent_buf_paddr_get = ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get,
+	.reo_cmd_enc_tlv_hdr = ath12k_hal_encode_tlv64_hdr,
 };

-- 
2.25.1


