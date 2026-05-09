Return-Path: <linux-wireless+bounces-36127-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QK/nFCOj/ml9uQAAu9opvQ
	(envelope-from <linux-wireless+bounces-36127-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 04:59:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C71524FDC89
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 04:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11D343021B29
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2026 02:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3795C37CD2D;
	Sat,  9 May 2026 02:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pGb1IPo6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="geD8GEls"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFACD37C909
	for <linux-wireless@vger.kernel.org>; Sat,  9 May 2026 02:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778295557; cv=none; b=kYqBedHaGKEhIDwliEb9Q5boo7iRF2N23JOD1UHSh4mAhzpkCdtwYVmv0xd89rPEHznu24/BXgQhddKatC+skkVeFKHcmcoqOe56QBMAXsvgluRbIu8Ktw+EsxIdv962cnHMQ6DX2iOyZeKMTo/rTyq1reh7tchm1xT4yZdyF2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778295557; c=relaxed/simple;
	bh=UHaA3B0jh+nvgq1/LHaBWTAGcWv9PRMNVGESqVddsP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LHPbMxwWwVUluPPngjZYZuR1c5XPHMmIULzDZB0EHMkm8JNcli0kjRINkCAp1CQnV84dOMDVkmDffBOEuMkmUv5vY3alB+oAE2AH7DueTZ/+wJFUZUVG/tcv5AhLfO+bNPtQLRvZhm8DfWVgp6Rm6A73zP1M6TumOo4aKb5nJKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pGb1IPo6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=geD8GEls; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6492Xhtm2769465
	for <linux-wireless@vger.kernel.org>; Sat, 9 May 2026 02:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=y7PQ7mMFj09
	RBEC6R19QFDNhjCRnQR0cfi6POVI/210=; b=pGb1IPo6bfOm0gu+mHpxhaTKbi9
	UjKoBXxQdtVgUN9kISSTTOtU+w3bOpxuQjyXAaEqz+r6X5ms+GMg436bjjvC7VpL
	xviUwWERJx1TAyEVTaLLr5+TIFpE7zWhOwgfXWiUWMc3GhrkwvhlwrMHHPO8Se2t
	ILg3mEkFq5GNL7ogx9PRDO3uuKB1jX5xxRdlkTsWqsVRirG4RLOoiGXznnSWyezw
	cMhFFoC0wzBUXsqZiJCUYIBY0MiRLjmDHnh/x7lBQh/urZ8gP/wD9d3+dZWVuAbl
	XGlrxEsBSEkJiYbRuwy2APe0bGJbZfN933qH2SsB4LH45aGKkMzrkKa3h8A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1v8gr194-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 09 May 2026 02:59:14 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36781927b4dso1526507a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 08 May 2026 19:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778295554; x=1778900354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7PQ7mMFj09RBEC6R19QFDNhjCRnQR0cfi6POVI/210=;
        b=geD8GElscXFjIKio5QprYd7qDeJsMiSbRrJULAMb9+6i1L4IV+2CAHZfqsYzEI2fir
         wzQwttlUOdDcQByuCkl85mvwz64UyTcaEJhouW1Dr0CDYgEAvdYQmFs62hY7m/sbne0y
         ejW0mx5SF4mt2qAgLuwiA3oIgvs9xBDd1FDsoFMYf8CgJa8UjYlLu9B+1UXk6AwEE/Tj
         NTtMhwgR2TSpQyXZmHVF1nDDWBw/AKNWMcmDqpAp/vG9Yy35oRvWiIBhTDxOxX9NJCTG
         /BLOJzT8RhxJXEgnfO6uPCERzCPe5S9j7NS3KTB98N7pCCyhnKQYSOZQz8LFUYfQjipm
         RZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778295554; x=1778900354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y7PQ7mMFj09RBEC6R19QFDNhjCRnQR0cfi6POVI/210=;
        b=lGke7OMSk6bN0xb3dSDcCB2agthdbrVFPuwqwripWc6p2+Vo2IhPvBg8xwIa8nO68f
         igCQbjmWObyeZgVRaNZR+lwWpB3g9Gno0lhgwTj9dM/IcnRKIKjd9zsf5fCD+VRUIODe
         hD1e648P6pm3C25LUcvO8cKwBVQ+n23avJlFJaZUbpqq8+64wvegcpKSmyfbBug97c9l
         UxircZ0PmIBpadmjWo43dpT6c5Q3RmqLl5BKeFiwA2wtuTe9eH2pPXxiTsoR3ywDilm6
         ur63dQ3HsXbrsy30DBS8hRcBLNDMMdywSgXRI7lnkTsToGyAKD7Vdy04RmYR22CTGzaz
         crRg==
X-Forwarded-Encrypted: i=1; AFNElJ9cDcZoFNrNc44w+cy8ofsDDRgTZToPQun0ktjUBrRYtK59Y7azolc1sFX5Fs7135RHd7rfYtDALco1PCpD3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLkl0t77npG1GMSU7zgPP3pYs5WUDQmDhmk36Y/zvdXNqyGrDK
	dpIpUvHUdPIRdcE7OoujPx5MwYmpnYK8bOBp6e8R2i4+BAsHELvvTM6m8Kakhy0Gxh5RvZLuQ9S
	GZwOVMHnq6OT9dHiqGpjzn1eFy5jjDjZCDhYM1ygoTG4vwOa6r7SLxZ2I3l4oW+2WIoidcg==
X-Gm-Gg: Acq92OGhbUICGhaqQlErdVd8TV+hdWiq6oPmY5w31DxGEi7EQAdRSZ7hoNnXo7k3Uc/
	vSexZSzSZWj239vXzT1wcDT9BTxW498w9rHISp0Ic3kzz2Tw6M/YGbqbWe36TuspDcrUlSCcnGc
	NnA8F+yQIXPXdvt7LefzSa1T2BxiAHBdCNhHoxqoFtBQbcg7TYWsyrvvGasQUAnT9lx+MIEyKTS
	x/4KGj7TErVQTJtJk2xHT+8uclgq2elALk+U4frjjXaQQAcfPxLjr2gCJpqI3buSBUJY1Nfm0zm
	oR6nX4CBAf+nNrFGIQeNcmKmY+UspINmqnEqtftnJ5VEIlrp4gaKStwxzIUmYWUlkzGDE0DdvGe
	tx7G/VzWu9FhJq0z9R8J+PNCS/tFGPYmy63/meO9+Dv1I9Kehw3CkBVNQDwJ8kjERPI5t+UKmuc
	TLZSf/
X-Received: by 2002:a17:90b:2691:b0:359:fe72:3559 with SMTP id 98e67ed59e1d1-365ac46dc62mr16763812a91.21.1778295553645;
        Fri, 08 May 2026 19:59:13 -0700 (PDT)
X-Received: by 2002:a17:90b:2691:b0:359:fe72:3559 with SMTP id 98e67ed59e1d1-365ac46dc62mr16763787a91.21.1778295553087;
        Fri, 08 May 2026 19:59:13 -0700 (PDT)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367be8be938sm750899a91.4.2026.05.08.19.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:59:12 -0700 (PDT)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-next 1/5] wifi: ath12k: fix TLV32 length mask
Date: Sat,  9 May 2026 10:58:15 +0800
Message-Id: <20260509025819.1641630-2-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509025819.1641630-1-miaoqing.pan@oss.qualcomm.com>
References: <20260509025819.1641630-1-miaoqing.pan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ibdpk2oRTD9R9ouN3l9p631C4Qb7iSLq
X-Proofpoint-ORIG-GUID: Ibdpk2oRTD9R9ouN3l9p631C4Qb7iSLq
X-Authority-Analysis: v=2.4 cv=RMCD2Yi+ c=1 sm=1 tr=0 ts=69fea302 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=oTESD8Iu_DoklxnQOhcA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDAyNyBTYWx0ZWRfX9C1TbLTjVR4n
 jwuL3a63QHMT+nvMfssWSVpBM/d4PVRKBqhWOcnmqt0k+3DWdrG12kQPYS5H3hTBFFKiKaZA2UT
 l2nfaAmDKz7dPsZ4TvpX8x6Fy/m2avfpQj2bz5MlNAmvK4TlDs7RyW5a1iz9gsZWljkRaFcjQfb
 SO34g4ZeWdpHXtExa05Tr6s0c1W7k5qGx8zTM2KT7zQ1OVqg+wv4rBo30pYC1ewCFEypv5vmYd8
 Cg6C9Sk/CPAdcfL6WXPXIq5zQzI4VIVOgNdtbVy/A4BZyiWAHaZol92SaXxZ2MsWkV1nf2i7ATs
 KtRZjvBc5qq7HBOvp/cK3l4WF4vBUdKvCG/uroJhxiCDbrJSqRSCw60Lh9tR9b6j3x0xdmIdTDk
 gLzR1U5LnuNjJ306G49k9y6ot5GjxgAkFUzCuw6VvsvsFBHa1giUAAKTAIOugrkqFV1kr/jEe6C
 RGmHgJiv7XmHVd6APSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090027
X-Rspamd-Queue-Id: C71524FDC89
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36127-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[miaoqing.pan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

HAL_TLV_HDR_LEN was using the wrong bitmask; fix it to cover
bits [21:10]. Also drop HAL_SRNG_TLV_HDR_{TAG,LEN} and use the
generic TLV header bit definitions for TLV32/TLV64 encode/decode
to avoid redundant macros.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0.c2-00068-QCACOLSWPL_V1_TO_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/hal.c | 8 ++++----
 drivers/net/wireless/ath/ath12k/hal.h | 5 +----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index a164563fff28..f03817b2fbc5 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -828,8 +828,8 @@ void *ath12k_hal_encode_tlv64_hdr(void *tlv, u64 tag, u64 len)
 {
 	struct hal_tlv_64_hdr *tlv64 = tlv;
 
-	tlv64->tl = le64_encode_bits(tag, HAL_TLV_HDR_TAG) |
-		    le64_encode_bits(len, HAL_TLV_HDR_LEN);
+	tlv64->tl = le64_encode_bits(tag, HAL_TLV_64_HDR_TAG) |
+		    le64_encode_bits(len, HAL_TLV_64_HDR_LEN);
 
 	return tlv64->value;
 }
@@ -851,7 +851,7 @@ u16 ath12k_hal_decode_tlv64_hdr(void *tlv, void **desc)
 	struct hal_tlv_64_hdr *tlv64 = tlv;
 	u16 tag;
 
-	tag = le64_get_bits(tlv64->tl, HAL_SRNG_TLV_HDR_TAG);
+	tag = le64_get_bits(tlv64->tl, HAL_TLV_64_HDR_TAG);
 	*desc = tlv64->value;
 
 	return tag;
@@ -863,7 +863,7 @@ u16 ath12k_hal_decode_tlv32_hdr(void *tlv, void **desc)
 	struct hal_tlv_hdr *tlv32 = tlv;
 	u16 tag;
 
-	tag = le32_get_bits(tlv32->tl, HAL_SRNG_TLV_HDR_TAG);
+	tag = le32_get_bits(tlv32->tl, HAL_TLV_HDR_TAG);
 	*desc = tlv32->value;
 
 	return tag;
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index bf4f7dbae866..b3a89ace5a97 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1442,7 +1442,7 @@ struct hal_ops {
 };
 
 #define HAL_TLV_HDR_TAG		GENMASK(9, 1)
-#define HAL_TLV_HDR_LEN		GENMASK(25, 10)
+#define HAL_TLV_HDR_LEN		GENMASK(21, 10)
 #define HAL_TLV_USR_ID		GENMASK(31, 26)
 
 #define HAL_TLV_ALIGN	4
@@ -1462,9 +1462,6 @@ struct hal_tlv_64_hdr {
 	u8 value[];
 } __packed;
 
-#define HAL_SRNG_TLV_HDR_TAG		GENMASK(9, 1)
-#define HAL_SRNG_TLV_HDR_LEN		GENMASK(25, 10)
-
 dma_addr_t ath12k_hal_srng_get_tp_addr(struct ath12k_base *ab,
 				       struct hal_srng *srng);
 dma_addr_t ath12k_hal_srng_get_hp_addr(struct ath12k_base *ab,
-- 
2.34.1


