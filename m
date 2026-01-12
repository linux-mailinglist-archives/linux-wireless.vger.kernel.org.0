Return-Path: <linux-wireless+bounces-30676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C09D10E88
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 08:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 971D83009F0F
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 07:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9946D311587;
	Mon, 12 Jan 2026 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aXI1suS3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nx5hiSIO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2EB30CD82
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203423; cv=none; b=Xz66nxs5E7v5WEZtWJHaNRjVNpkM+ICque50OWcpVfCDGoJpBm4QA4v9DeU6FMoa5Ab6Kw3Alpf2ay1QyjQMYEza3AEgi9Tn9nMAwzj3nlKqHT5r1sDzDQUR0sPHon/sj7EvvX/fxAtaR5r9tNoCMvr1Ab47oHNBUpK/YwgklZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203423; c=relaxed/simple;
	bh=oOYjLQ5+u4ui1H2sag+gIA6h0X8aCtfAGAj4TCL1230=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=enpvZ6+Q+VuwIyPAc9KotRwTkF28Drg2Ocu3MmQmXAatYUDFUKCEhTFL9w4JSf8X/J1ikR3Oeu4uyQx7zrI/tVZdkP8mBCJd/YZSTQ6HO5MFP+25iSDDUAb69W3Qzae4LDRE9oiqoY0Svti99W/zcCgGv9ez3QKBh1pxDdnXU6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aXI1suS3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nx5hiSIO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60C7BkUg2788278
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tJk3Q0+MS5u8Oi6Z4LN2M/8NwLLBO3cAu0s+bHFvby8=; b=aXI1suS3+VpNjHTm
	I472u9KF3HGPbvKi/oZcfYxkla/2OJ3TBI1CRjA/EbvwpEzjmXwFI/zJN4DcETrK
	N40ZUOlDC5oqqpF5pdbyxKhAGEpOb2M9JKinIPsDtGfDfvLEDz75PCau/+I86bMj
	u6kLV9wweikrvIKpMLeWB7G8EdZ+pPbJeV82CytyIckBkd7e5SITztFs6NlxlrX5
	+g2mvFER136bzoTBsPLPjMBpgLdg00XEDban86sc9bfH2qKLVtf6SWiaq7hMhXw3
	GgiVxTij3/21u2rZNbEJ278AKcBVnSpzCEg4ZqKS8xr4sYXvBvtAeiBgPwL/mgLX
	1/v7NA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bke3e416y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:00 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c5539b9adbcso4485502a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 23:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768203419; x=1768808219; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJk3Q0+MS5u8Oi6Z4LN2M/8NwLLBO3cAu0s+bHFvby8=;
        b=Nx5hiSIOX8X4aTKnR110gJe5wHBobpb2mGHuIzQiowtyO3cK0DAtLWGCT2G/q93mn0
         0Q6wXWrizAvGe03gEo3NjCnGLKknH7WTpoIFnVqgThQuyf1+eOuJRNygUUvM4boIIOUX
         kW0jL9X14hR2GkzxivQiBwL+iKUBIeAWa3BBDSwNy1uA110ZvSz3Jd7n47/aORdMF0JM
         6c/0YyGZ7wwxIusBbrBPWICNmSpTyB2rKph2JxJ37pRaaN2jkn4SEXrQu6tGPO01wFRc
         wvBlK4CPOm7jwPVdUVZCSxQFpDrRNMiJiF7diYGfuUH/nSp2K2f1ZM0n2AgU9VHKqACs
         T/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203419; x=1768808219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tJk3Q0+MS5u8Oi6Z4LN2M/8NwLLBO3cAu0s+bHFvby8=;
        b=swctbku01JGA16f+XWDYZRXjdD+oGtv8JTjzo0Lpkq8qGJVq9FotkmwgapCw23dhTG
         YUmo6vhFF+tIKFhvLfxCcLTrL5KdaYcUfVQsnimvtoZn2Pp21W3MYY/7G6+5QZ951dTb
         qXCGJdajut8E5Kiuz/PbhAbr2ocaXqPbtW4PcEt+rSEzXiVNGjJYMREhLi3le4C97w32
         +HmpNQ30tu/YH8Q/u6G2lzR1l6Hdy7KMy/dX3GjGJVgAFCQV05c5H4wZ5ymR0TBsVZCa
         sp5XjGg7+ZzpL9JpwdJFM9DbQHhDlja/TYMpAm8/wQoyaFbj76qRt97OXzHsFYmqpoaY
         SQbw==
X-Gm-Message-State: AOJu0Yyixpklq6tJDDCwVZf+NJotgkrLArXH9x6aI3OKax15zIpxQmCa
	sYTFqsKxT1yngb1V7cvxBvfDOic3vALeaH5B+Et9MHq5X3/RX8TSYJoh59nN61lP8VHwV16DBSz
	idILSsaPImCrKW4dCKWfmnbd95DgajFgUfAQzlt7Il2M9vCIpZxDGZXmnKGCIJyUcqsAD5Q==
X-Gm-Gg: AY/fxX74Nq1oZYnPMr55KYR1j0R15rkKixu0FXUGTTD8+bWyb3E53FVwimFBpf3395+
	IdJyEnDequ6GOOgGpbgrYLCOveX603afVmxwadEXez+IERfCTv5K+2nGOFl3+R5VOy+bRAC1nq9
	v5Nhl9FVvAYayvylM/nJFhEk/gBJWSRaqwhkOv/T34hDbaMPiUNilPwA9WVxVlDDHxIetlJ0xx/
	0n0hDnWOJES6qnRnaiFq1mSIi2f1QzqSjRssqbNn4q7lZsV0IOUa+dZvQmSykluRT9mt1i3brW6
	CQ7i3TIHEBpAIIs9P6Ww6AUA46Zpq62kfwj42dC3c34n2qWDd9nySbeltSyftMIekUSSZtOKVCi
	Ey7OfKyntL+78PsMSs2eSo06e0Ks8X6WYPSuuSztsMEHhbuY4sOICdLZOpFULftU=
X-Received: by 2002:a05:6a20:3d90:b0:35e:da63:4e7f with SMTP id adf61e73a8af0-3898f9975a6mr15360795637.39.1768203419405;
        Sun, 11 Jan 2026 23:36:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGP5jYn+9Av4NgJqkmkfm1gmPLeZYt/TOJKi71XIM/9W3h8BuZDLRy6HP6GbvSHmFhuxRHEOQ==
X-Received: by 2002:a05:6a20:3d90:b0:35e:da63:4e7f with SMTP id adf61e73a8af0-3898f9975a6mr15360782637.39.1768203418882;
        Sun, 11 Jan 2026 23:36:58 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28faa9sm16548684a12.2.2026.01.11.23.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 23:36:58 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 15:36:23 +0800
Subject: [PATCH ath-next v2 03/18] wifi: ath12k: refactor REO status ring
 handling
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-ath12k-support-qcc2072-v2-3-fc8ce1e43969@oss.qualcomm.com>
References: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
In-Reply-To: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 0efecwPJBh79tv5_na2fGb-NMDYXwbAZ
X-Proofpoint-ORIG-GUID: 0efecwPJBh79tv5_na2fGb-NMDYXwbAZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1OCBTYWx0ZWRfX+6+V+30QBuym
 2gycnQ1NWq+9k8uBiLhLayoEqaJSQYKDfv1Qn2vgfRZcVKabIARUSYB5Nb+hxPiamI/sTdZqr79
 diG37lmqZsxNpf9oV3fpYr9EKlQLKXaNO66cdyZ4FOJy0rtgbcScG/GFtQpcFvXzpbZmbZygvZM
 BsRDRAxIOoHRqtFI1SAEAnKnTQXJsa0XBc6RJqHYz72+Vma9mlgiBabr8Gn+asCp6fvGpJQQ612
 EMkZd0T3ZXMwanKqAQO2KOl33rCEu2aq320TCHFX+c0UQGolnZJA3DQkNbzSZV5zwPo0aIv2ORo
 6LpbnXHnNAVoXB8v3sNadcfIQkWc5qoWpq4fjjj7SLSCn8xqsTiNE5W+vi+cw9z80AAypoIlI/v
 9p/2CXktWec4CBNE9mUakDkgmJB9o6ebusFGHxMwxEGBWjRxaqDllsxYlV8PH0LzcE7HW54kRUD
 goLCV5an7Y2y6R5pV/A==
X-Authority-Analysis: v=2.4 cv=Dckaa/tW c=1 sm=1 tr=0 ts=6964a49c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=PMNv47187FcU-8MNZ6AA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601120058

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


