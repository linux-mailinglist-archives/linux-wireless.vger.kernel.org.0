Return-Path: <linux-wireless+bounces-30675-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BE0D10E82
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 08:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADA23300910F
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 07:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EC32652B0;
	Mon, 12 Jan 2026 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WKRbMb2M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HmK+K5vy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD6C30CD82
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203420; cv=none; b=ZZX6b39hdwUevXcCAFGPgLi5o0z8sIM+K1khwTAl0ETxuM8pCcUmHSiIJn9Dy7xKRQwQNyKP7KImE12VoT+1jyY9jC4FAn9VXiNBtF+bgi3Q65pM4GFJo1Ur1IqG1QnFgQn+BCMajnrDTT9Sx7ZJQSX6/f9QhQdLER/gI3ahLNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203420; c=relaxed/simple;
	bh=1b950sAUDfPiIfZ83dpfIEmqG9IF027rMf8yl64kq0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nRCcmzT9vCq9HwiV//edzSyqXL0wgKT9anPeH4iN5qRsjblphWNw805MZNjkxANSP2yecABIHFUivG20UaHXsfpSTcFAj0KfPGliu6b6xsJqPgnEDCw8yAm6Q7bVHFBPhV4EJLW7fehfl2oZR310D7fDCNLxl+gz46tVyj33Fyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WKRbMb2M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HmK+K5vy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60C7OtH5556393
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xO/Z8OTWEryPFUqXFceT9Nx46ORhtkGydwhL3x4O9+Q=; b=WKRbMb2MnJCxbESN
	E7NyV5p0tT0qYQrSHDZAew8PZ1jxbYYL0O5oHWQGG0BRJXmEIv3rXVfM9fFpwNGu
	1GcNtt8UoeaWEDYxR9sbyapWqcuGywovE3yA58nnFIa+kpabUsIK56Jc8YadoerD
	783JdRxH0pqofxbOsKH8GMR716OoPZFszzGSFpj8psIHCYkp8eQ1NAIB2/2ZOuLz
	Tj/mS0PlLQ16PYdzUMa+tJilU1W+tvFFVouv4ZobDppXvHojqSsT/q+CoOqfRdbU
	6behUaT+a0bfyAlNY25Fh9ZQJDhH7Jd3S+4HtneEfiHtx74mSWnGz3FOaqmJ49o2
	fITPsw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bmvhw013y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:36:58 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c503d6be76fso7059666a12.0
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 23:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768203417; x=1768808217; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xO/Z8OTWEryPFUqXFceT9Nx46ORhtkGydwhL3x4O9+Q=;
        b=HmK+K5vy2guoXwd+E3xXjkzrrmDXQ4bKmIbeoOOT6a1ulNXzJBnHuNVRdUjzK0UfJe
         GRw5eJsrOz3hfb/09nqqrHxRRnFI6tNN5B4tQmaBBWh31crTHjn2JnnqSvGkND50z+E4
         x6+oKG5KogvhzXpN/j5alMZu8n54YuSIzWIjVSZsXYw84z93sHmZG/VDIjsnPab+wbMn
         mIAh+IdJoq28JZYkEmusZM1+Z80cxZLlz1lJfgYp07CaenbkbT7dqn71wauMRDgznN5M
         vuy5cxWYMx+QBMB24pS7ViUxUwqI2eFuRrudbSBWAX2BC8jtFpdPidvEeShb7ym7UOJl
         VVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203417; x=1768808217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xO/Z8OTWEryPFUqXFceT9Nx46ORhtkGydwhL3x4O9+Q=;
        b=b/N17WtQflGTP3aI85mFPKoh4V1bZmkzM6bkVcrbaaZwiTs5NHJIenoGv2BcOvBNMF
         N4HXPOhjIex4mpbv9nMuFRh1m8omt7v/HXMiofPW/MSZzuNnxaUTfx2H5CVfUPu6D7Yb
         8PrGdYLddrCdTVPZnnp3QTarqd9OgIZdp4q9YrnCK+TE4P5aISXYMn02f4+a4cof9wuP
         8OILSwE6wflHoT8FO4tRA+2VyEQKiUoWzm29i0BivBHia3c8UUesAY6dl8knHmCktK/J
         z2ovV5L4UgOH8sTPxkj4em45gy3gPtSpKyrgPOpWgZ853UUuXewJZppFj2xwGj4LQQBB
         Vdgg==
X-Gm-Message-State: AOJu0Ywy3NYUabFifJBfsbjmqXDtmvCGRGQYWIq/pHRTbkG0F4C+D/V7
	R7Bmz03uiYgCR2LXHy4X/mNhdkdWf+9s7J9dT9CXgdC1NsB+muPl7qXfQ3XOcZwv+jjw2FA1XGJ
	v4Goeb2SY1n0GvSgNJYtS3EqpGv/kXWjb9LLmaLOJN23uDaRrMpcGnafGGiFto2vnJrDF5Q==
X-Gm-Gg: AY/fxX6ljZwE9actAQRmNqzdiGcMtSFGGAmAxr+gqSPy/RLYkFUmC7jnDG4cf3LcMn8
	01CMvbPt+5oQoMwoEpwUQ4pv09uJStBadls3IzQfKvemgudoc1JXxBklNX6Ly4bdViED0DUW0UN
	sdgOVpbkVj1pYq2hbDsMaHy1wO64vH8KXcl1wSDhKrL5B/Sw3KFFNGftybEf1Kyyl2rJ1FKG25F
	NrU2MjSKQsnFGvQqhoG9iN5hAExGnChj4T3DK+BPirFiw4mRrdY3ObiLUGSvQXWbO0jRPceDj3n
	NTE/Da6RMB4+6yaZf6nshmi/biwfVaNDBiTyOZhUzIgwbqJcRpfr2eS8lWUdGvxllJc54szsA0Y
	6qmVbYnWZ20jxZ3DQPygz8BtrqAYhFUAeKyyDpU40/2FHFn/6V9sJgGLyqrtdNvk=
X-Received: by 2002:a05:6a20:a110:b0:355:1add:c298 with SMTP id adf61e73a8af0-3898f8ddd35mr17042274637.21.1768203417420;
        Sun, 11 Jan 2026 23:36:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmURWcIwclguCQQW+VUWnPdXpDHgIRNoQdJxV+WFucZMw0ZwvAsoc6R+z9GkJYybe4YnfvHA==
X-Received: by 2002:a05:6a20:a110:b0:355:1add:c298 with SMTP id adf61e73a8af0-3898f8ddd35mr17042255637.21.1768203416951;
        Sun, 11 Jan 2026 23:36:56 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28faa9sm16548684a12.2.2026.01.11.23.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 23:36:56 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 15:36:22 +0800
Subject: [PATCH ath-next v2 02/18] wifi: ath12k: refactor REO CMD ring
 handling
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-ath12k-support-qcc2072-v2-2-fc8ce1e43969@oss.qualcomm.com>
References: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
In-Reply-To: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1OCBTYWx0ZWRfXyiVWeE1PPDiA
 9o4YmZYN3ORLO+A0PWOcpS0X29u/Z3BlLEW1eFB4NpZBZLKRoDxxkbYWU4Sq5d5LlLL8qd1ZISS
 fiAHGswyfopXIuM5D4TxEUUY2MKHrZtTsd4uuJk1Gmn/bU+yYGgfBaSJy0HVtmhjwvDnrSlzigi
 27z+BC1mnMmVNBLmsjTA7HcbHZuanP39P4F9DGns4eJ7D/T/a3q0+tsRcbRmlgyZKSQ7RZ/usDA
 JguoSMBf5+EspUwEnhIpi/hzHY6aKEXfa40ZGWNukqRzeVauULB8fF9arcExSwfFJT4YtPPc3xe
 QbZmCuK/UkSDoeKeisl8qJe85XgLnHNTK+ldqAO6IvC3t7MhsNogDIJob+Q4c01AYqU5u5IYx8t
 OQKo6Xy39fVG6WVGgcsb1vX9UR/vF/FYgTMNbZMoZZDclGDbnueTUN3qRCKM5Z94TBMySIircC6
 +R2KfUmMOwjSIo7ML6A==
X-Authority-Analysis: v=2.4 cv=JP02csKb c=1 sm=1 tr=0 ts=6964a49a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=N_EWgtucFCvFHXU7mioA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: NYq4P7wBST5wkb8C5Y6gahXZ4N7W_PFU
X-Proofpoint-ORIG-GUID: NYq4P7wBST5wkb8C5Y6gahXZ4N7W_PFU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601120058

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


