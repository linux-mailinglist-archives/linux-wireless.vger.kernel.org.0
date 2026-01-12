Return-Path: <linux-wireless+bounces-30687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E950D10EB6
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 08:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B55630BEA6F
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 07:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0D0311587;
	Mon, 12 Jan 2026 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="inTx+tu6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BwGt6x0z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C2B331A4B
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203442; cv=none; b=jmNEeMeACIBy0876jTUSNwgBeuyynCSOn1hx0z6WNNBr4bVAcbCyPeMds+7keZWopguQVkKYIMFeWcy1Q0HhZVlxcdKXRFWZU1/YOeFLy0yyBi2okZQHxkmUjLqpnyxKYXKwylvnpOv5Q/5ZbEauQ2PyG2HXAEzni6XGqmdPpO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203442; c=relaxed/simple;
	bh=7mTvMhkFhO2X7+DVV+/tKSoDtreydHi3IoZQV47YXvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HE5YB+nMpxd666OVV+Qp5GHoFtHDe+X5tsqYpeC6ckvx38pECkL2ERfr5I3yZRNC6x28QD7RTCChtbhGYe6SiwjlTxYPdy0TnQgr7MpMSCf6Fg2Sa8KXz1f4v8o7imYjAgIzLnP+blji4ANOnn0IlEki80xEU2PZQTsdR5+d9gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=inTx+tu6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BwGt6x0z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BNDW8s3633351
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jZvo/PgqxxzPt/YAqJn18tnE7p169uzy9Tl+w5hbSkY=; b=inTx+tu6QOU8rP0l
	SZv4hgopu7iTPwuTmFzXuhvia2uIMmxLtj+1VdWWjKh30VisXSe3xRIc8zq0KO17
	wOsz6crVc2Q3OpdgieFUu8CIHYdMrDAFUuf/9WdI9bMKgJomX1dH3k5Zs9kiRNY8
	nj71on+qepZwYrAKxO3jqrpkLEgefnDKFMdk6A13xi4qrTqZIKNUdex46vNUrcFr
	i0fthT1NApzQ9d7MoMD7w0yTBVtjtXulyVaYcvJcpZIGtmz0UeKwYaUsH9+WInt9
	MVqtOcsrUrCsQwnxzZKv361tJm1yaa8WoJtiJ2KkfjhJLX86sIo8BhxT8Qo4zRlO
	g5EFxg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkjvxumjy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:19 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-bce224720d8so4620544a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 23:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768203439; x=1768808239; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jZvo/PgqxxzPt/YAqJn18tnE7p169uzy9Tl+w5hbSkY=;
        b=BwGt6x0zuYlGW3JBNL15ayaTlUXTRpebNunVhTudvJrBpMhWnbLToa3+p8OH6FxRci
         f4NmwD3g9EgafeUwZUISpfnSqoDRwb8Z81GNmF8YBMtxtDW2J5B9R410mlfrG0YayoHd
         UeR4Mw+IJW4ryLgfOAlhRlacj77on+862o86Vo2zkj0c63IuYKUuyGNXp8cbbPh1x0ip
         hHIJPa5xdd5mSRhk8VNvS1JEG69kX0Pky4tK3Ltlu/1OwvXbAiut7aBWIpCbj8+8Zf7p
         3FW8GvhzHljW55a7uq9VAgeaugxLZ7Xbx+syvmZkpWQckK+jEEoMh2Omvclh57cZccOo
         Mthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203439; x=1768808239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jZvo/PgqxxzPt/YAqJn18tnE7p169uzy9Tl+w5hbSkY=;
        b=wg//PfuU/W1oNekA8ymQtksCTeivMVGWMs1bk3WlLgQRP1RyX6hKnkRiwQaKzyhdrx
         X48s6vVPoUZR7hdVVZBVHV6dXqPlScjsbEAblVBo6J30WW/93X+bs72AJ2gqEtI+ASGz
         CcTJBnc1V+RtGzop0O20lFqhzDndFNjNDSJhWxwJENhYBXvotvaUqiWfsD5kgEVrQX6I
         ox2OGx0Ca/RANWj+Yf3iVQMxYgmQqgeijo6hC6XI7eLFW+XM/5zy12gO55w5s/IMr5E4
         2JIGuSy310EbzQlQ4R3b28C7OSwQNR0frCU2W7TpnVasE4Jux+st6Df1z5V+C/IdrZHT
         EFZg==
X-Gm-Message-State: AOJu0YxvI8w6uTNIjDmdM988OQXhA3YUQHpFT558kVJ5A5VWW0m5h/hX
	Zk8fS91PEpRVT8szJiSqtJ3C3dH2qe45ryrV9WwHvY6HieBkdr6/AwyUh3TlMIAXSz4s616Lk7j
	+FziwCR+COWXobvpBaAsSi9oGololRuET9msdKQTUN+8tOBiWS2fIqhIZV4j3ET2QeSl5EQ==
X-Gm-Gg: AY/fxX5I2PJ7Ng2OqXkdGH4uQWD8XwsaTUJo6GsQDuh/a+qpPGSKqzlFRhBDRG1mRgM
	HiRqJlYk9+FI+ugBD41MmfbQyFzM31x/Iwc9gO+XUEY8zwHD3VzsbE4U6IdLGqdb+JyBCVeHl+x
	bMm6HOdH7Qk651jR0ZVMMeca0qd4B0jAh2so2xHHN7zBhJ2NPG/DBI4JlJaIWOT/RVqeHWAOvrB
	iit29s0jSloavMsazbyRqHAKwg6qbLiHfb6v4d7yM3zuNQwazn65+Rr2QKTdfGOn5OS4rcoU+/d
	nrSdBc1pE5yCjblPlf5n8mgqpZKanJLIjYERXPZ3FsFIhsst1i7n8bHHKpIT3waHDgUCSZk+DJ3
	cSxwYCWjzdyZM8HvDc+Sgni11RxF44jdz0xWKRylZg4kYWst+yEDOitAVW+cTw+Y=
X-Received: by 2002:a05:6a20:a128:b0:35d:c68e:1b07 with SMTP id adf61e73a8af0-3898f9dd184mr15945308637.54.1768203439173;
        Sun, 11 Jan 2026 23:37:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1/rxOfJLekMUNQmzp5KOfgKmR2v3CCDboTRVLPoF1uWR609h4DZwWU4FFaQhRysawiCRfzg==
X-Received: by 2002:a05:6a20:a128:b0:35d:c68e:1b07 with SMTP id adf61e73a8af0-3898f9dd184mr15945291637.54.1768203438675;
        Sun, 11 Jan 2026 23:37:18 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28faa9sm16548684a12.2.2026.01.11.23.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 23:37:18 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 15:36:34 +0800
Subject: [PATCH ath-next v2 14/18] wifi: ath12k: handle REO status ring for
 QCC2072
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-ath12k-support-qcc2072-v2-14-fc8ce1e43969@oss.qualcomm.com>
References: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
In-Reply-To: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Wrsm8Nfv c=1 sm=1 tr=0 ts=6964a4af cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=gK-fc3CfFqufNovLaDoA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: vmWnTQEyn6CugkLS5Y-nhcwQPQJTThmU
X-Proofpoint-ORIG-GUID: vmWnTQEyn6CugkLS5Y-nhcwQPQJTThmU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1OCBTYWx0ZWRfXxMJ7njZOva7u
 ukB5fRzxF1XXRXyCsyv0YPweOOK0eu+mwGXv8ZoSa895PhyaN0DW+opXC64ygCFzs/v+RwXfyCY
 bmj1bZbflaYT6cUrQfexnIrrxg3mblyNSwEdj37r8tENdk8azOUNj5IDl8/XVktfFfuQsyNCSUA
 +oY/VrLVkvPHcT9hjct0x/MigNffdcbebE9i0wrjF6IMclMkSt1+p8iF0MrKdDjv1Q/LSFAx8+E
 SlR4WLVzFYbKCYalsMwLKZoCC9zFCAH1sZ6mUtsGt7iV3CCo6EPGf8IbEtbH/XR6Yd0TtTeLlCi
 yiiMHh0xVcyX7QAg0EsJvG6qQybywitWK77dYicKV4iwCTz/EutHrBeIiEwaw0BqGDOM+iDL0w7
 hWwnfgHHTt/CqykXUgAjanjiAGLxNMjI4yGF+kL5/BpCB5oJKg9X+GQlZLl1WMgBXG7Nh0nTzMI
 /T8M5IDiTYNh+jRc4sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120058

For QCC2072 below REO status descriptors are different compared with
QCN9274/WCN7850:

        hal_reo_get_queue_stats_status
        hal_reo_flush_queue_status
        hal_reo_flush_cache_status
        hal_reo_unblock_cache_status
        hal_reo_flush_timeout_list_status
        hal_reo_desc_thresh_reached_status

Take hal_reo_get_queue_stats_status as an example:

QCC2072:
struct hal_reo_get_queue_stats_status_qcc2072 {
        __le32 tlv32_padding;
        struct hal_reo_get_queue_stats_status status;
} __packed;

QCN9274/WCN7850:
struct hal_reo_get_queue_stats_status;

Besides, QCC2072 has a 32 bits TLV header while QCN9274/WCN7850 has 64.

This means that there is no difference between these 3 devices in layout
of actual fields, because they all start after a 8 bytes offset

QCC2072:
	{
		struct hal_tlv_hdr tlv;
		__le32 tlv32_padding;
		struct hal_reo_get_queue_stats_status status;
	}

QCN9274/WCN7850:
	{
		struct hal_tlv_64_hdr tlv;
		struct hal_reo_get_queue_stats_status status;
	}

Therefore current implementation luckily works for QCC2072 as well.
However it leads to misunderstanding, which should be avoided.

So add individual REO status ring handling for QCC2072.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0-01560-QCACOLSWPL_V1_TO_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/hal.c               | 12 ++++++++++++
 drivers/net/wireless/ath/ath12k/hal.h               |  1 +
 drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h    |  5 +++++
 drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c | 21 ++++++++++++++++++++-
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 5ce5e0f89ca8..a164563fff28 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -857,3 +857,15 @@ u16 ath12k_hal_decode_tlv64_hdr(void *tlv, void **desc)
 	return tag;
 }
 EXPORT_SYMBOL(ath12k_hal_decode_tlv64_hdr);
+
+u16 ath12k_hal_decode_tlv32_hdr(void *tlv, void **desc)
+{
+	struct hal_tlv_hdr *tlv32 = tlv;
+	u16 tag;
+
+	tag = le32_get_bits(tlv32->tl, HAL_SRNG_TLV_HDR_TAG);
+	*desc = tlv32->value;
+
+	return tag;
+}
+EXPORT_SYMBOL(ath12k_hal_decode_tlv32_hdr);
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index f322000e8ac9..520587305dfa 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1546,4 +1546,5 @@ void ath12k_hal_rx_reo_ent_buf_paddr_get(struct ath12k_hal *hal, void *rx_desc,
 void *ath12k_hal_encode_tlv64_hdr(void *tlv, u64 tag, u64 len);
 void *ath12k_hal_encode_tlv32_hdr(void *tlv, u64 tag, u64 len);
 u16 ath12k_hal_decode_tlv64_hdr(void *tlv, void **desc);
+u16 ath12k_hal_decode_tlv32_hdr(void *tlv, void **desc);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
index c4c7ca9ee827..e1ab47b44433 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h
@@ -2439,6 +2439,11 @@ struct hal_reo_get_queue_stats_status {
  *		entries into this Ring has looped around the ring.
  */
 
+struct hal_reo_get_queue_stats_status_qcc2072 {
+	__le32 tlv32_padding;
+	struct hal_reo_get_queue_stats_status status;
+} __packed;
+
 #define HAL_REO_STATUS_LOOP_CNT			GENMASK(31, 28)
 
 #define HAL_REO_FLUSH_QUEUE_INFO0_ERR_DETECTED	BIT(0)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
index 0ae5b073287a..ee2427fadfc1 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
@@ -425,9 +425,28 @@ static int ath12k_hal_srng_create_config_qcc2072(struct ath12k_hal *hal)
 	s->entry_size = (sizeof(struct hal_tlv_hdr) +
 			 sizeof(struct hal_reo_get_queue_stats_qcc2072)) >> 2;
 
+	s = &hal->srng_config[HAL_REO_STATUS];
+	s->entry_size = (sizeof(struct hal_tlv_hdr) +
+			 sizeof(struct hal_reo_get_queue_stats_status_qcc2072)) >> 2;
+
 	return 0;
 }
 
+static u16 ath12k_hal_reo_status_dec_tlv_hdr_qcc2072(void *tlv, void **desc)
+{
+	struct hal_reo_get_queue_stats_status_qcc2072 *status_tlv;
+	u16 tag;
+
+	tag = ath12k_hal_decode_tlv32_hdr(tlv, (void **)&status_tlv);
+	/*
+	 * actual desc of REO status entry starts after tlv32_padding,
+	 * see hal_reo_get_queue_stats_status_qcc2072
+	 */
+	*desc = &status_tlv->status;
+
+	return tag;
+}
+
 const struct hal_ops hal_qcc2072_ops = {
 	.create_srng_config = ath12k_hal_srng_create_config_qcc2072,
 	.rx_desc_set_msdu_len = ath12k_hal_rx_desc_set_msdu_len_qcc2072,
@@ -468,7 +487,7 @@ const struct hal_ops hal_qcc2072_ops = {
 	.rx_msdu_list_get = ath12k_wifi7_hal_rx_msdu_list_get,
 	.rx_reo_ent_buf_paddr_get = ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get,
 	.reo_cmd_enc_tlv_hdr = ath12k_hal_encode_tlv32_hdr,
-	.reo_status_dec_tlv_hdr = ath12k_hal_decode_tlv64_hdr,
+	.reo_status_dec_tlv_hdr = ath12k_hal_reo_status_dec_tlv_hdr_qcc2072,
 };
 
 u32 ath12k_hal_rx_desc_get_mpdu_start_offset_qcc2072(void)

-- 
2.25.1


