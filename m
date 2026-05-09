Return-Path: <linux-wireless+bounces-36128-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKZEJUqj/ml9uQAAu9opvQ
	(envelope-from <linux-wireless+bounces-36128-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 05:00:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E59F94FDC9F
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 05:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 915F2303265B
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2026 02:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9E037C92C;
	Sat,  9 May 2026 02:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R57fLsvC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TxxQljZ2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D1537D10E
	for <linux-wireless@vger.kernel.org>; Sat,  9 May 2026 02:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778295560; cv=none; b=vFdXVrv4roNItq+j8UGVvWu7rLPiaZgkjof07Ux0JVxfuteDCGNN7++2iM9N+w58ulHb18VgLC9h/tKHBeFNkVrXHg7XLhPbLZKfLSV307m8CUiDo7s8tDkaPYWT/7rq7q9geo0nsGoh8Jdc7uCfn8CE0AQiTMlhHyppTmTXm0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778295560; c=relaxed/simple;
	bh=ZtS3oUHytkQB2SyNuDBB3t6ZYhXdyb2sbd8HXPllvoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mIzh5zsLevaVPBYtn4a5q7IyYqHe2DhF7j6lBDo6xXVg+Mgfo8uVQOYRtJaakPkQq8S2zTPr2HPrFium6ZwRNzXj6wH9arsqAqJQJeY4D/s4Xa3pqQV38/nu9lefSD3K58UNcKAyiXZQUcLXGVLqQshtR6cDzcG2ZbPfUnHDoag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R57fLsvC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TxxQljZ2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6490JhJT1767958
	for <linux-wireless@vger.kernel.org>; Sat, 9 May 2026 02:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=50H5oNb0zAg
	UgWNo0Pb+zr76atRJ4QpFRMqVAVEcQGA=; b=R57fLsvC6VYbYI4+r/5guUpNZB3
	icSJvR29RuDLbIC89fMRBQaEL9VuoJ3cLchhnzGX1RKXBB+631DtNfUBFlnGXFo0
	evvasNmM+3tZvLRAtkD38KWswGsczpn1XRV0lYQ6a131YYfFkOHIDFcbSc4k60KR
	7nJuovowP/rpywz4tEzPkgS3wRoyyAOns1lD9TkkMj30Q8b+J0JRoOii4tKzrkRC
	ecjTptfkZ8g5aOMyEV50bvOvdRmlB/86yIrd09n/rQLjtYHkbB39IPfmFGOFoI+m
	3v6eAG4UHBJKZbs71tGjiy9ZfXKBalk/sR3x5tAUvveL10f6JSsbSQL9Elw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1t9q095s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 09 May 2026 02:59:17 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-367d73504f0so302735a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 08 May 2026 19:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778295556; x=1778900356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50H5oNb0zAgUgWNo0Pb+zr76atRJ4QpFRMqVAVEcQGA=;
        b=TxxQljZ2wC4QMsVQTR/v2n5onHtA36O0AFRPHuKiqNZMF46jLEK+qqir14kdSDPfXF
         kfg8792+ul8WfVLLNfVfSwG5d2SSg71OfCgXke8LQDa+MuyT2I8IK/nH9AYRL51kTYi6
         BbB2F2PcyGeot7/OCiRKO3ZMZedkEC4ZkP48DUPDZXtnCpYadkGOfD/OTkZkJgrq3WUX
         NCbKyll776d/tbqBiT4utZVGZSwMUUjgrIKCfNu2OPJDLyemXNqgCgm0TZcQ7/DGXzYh
         NFZcXluD1eX6O2Y61dmEy8yKIrdhHwNkdg9rvqxUujoQQGElGrgu8hVmokF2MW21tiLr
         UpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778295556; x=1778900356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=50H5oNb0zAgUgWNo0Pb+zr76atRJ4QpFRMqVAVEcQGA=;
        b=Qhawp85mBgrsAnKubUvLbmZRrTkypd5ELOoQ3EItJQ4TDD2+oeWeao9KaAEAdeOS8P
         uO/zY2MdMpflqwAK8tYFynpf2uS2Twry+BO4RkLSIxGhybb60seg37u+nSZCvHou6aLL
         18aZjQPzIAZkE7561zD2hWzp2jJDFUgUztwq2Q6qfdlkWIapm3nVcCpIA4MzojY9d79Q
         ldVMzKuugeynY+9vr7btS9ZENl60sUdscpXHt8qPx6Z5CqCV6yqP0SA+PIf7IsCYktRj
         O6YetGt6nz7yk4uDac6T6ptCnpYYf8xtozAyXNGnHhGx+Vf3pAAWrNv67ZMMYMQNJnsn
         E4Vg==
X-Forwarded-Encrypted: i=1; AFNElJ8pbRuKrgufHpK9+ZS2e7ka/7VyeoAfb6Yiu+n7I7YfOPSUgxpV8dya8WUnPEEf1XrsqZ8kmroF+YY+w45ZRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ0NUT6zEs87+6RD5ZJEqehUx52NT7kWWPva2otiFi1WempQRH
	n4ZStFxJuBrx5D60kp8oG9otoNQs/pZUr6fmudGDpki7yYxC5Gk4Gbn1mgaeIfWa4513hx+6KCX
	3QNhuxiFug2zKu2hd4Ojrtt2heOeArJIeX+y6dYJr92cMQFlYIh1HUnY+sKhfU97qu7H+lg==
X-Gm-Gg: Acq92OFr+8+L3DcAKp3bbaqrAwXIaNPjfxoH957voV9l+nziTRRGiGsR66C0PmQXdmH
	+HRfgTiA0+PESazeeYhZSSC/M4UYnayjWBjQXCRmKg4M0U0rnpgJWB4aoFhcUi+PIAZL7RtolvK
	3NzU7A485a9yttBwyJqvEcreQ3Eu/r3W0r3BNu01PXVc1I2hXD8L5vkwcobEGw8iAsIru2yT592
	Ij1OKleWNRE4gHZFkR40AfZDdu3dV83XN3TT/7Bo3ustUbyZk87DpqFgkzDcKeyAe/fZKGD2QES
	Udt+hyMkSj4VOdIkaiu1QmttF8+QKtxB+AkY5V4XFkcb7DZd9403tjYWC3jJJ6Caza6ngGAeaZJ
	RLoSZjtqTxryBLyFq2vjrzlypnPmMydqmSdeHdw2TCKpZGrDmmMVIWFq3lj1BrGFjFlLoSxU5Ey
	uo7R+W
X-Received: by 2002:a17:90b:45:b0:366:159a:c228 with SMTP id 98e67ed59e1d1-367d468cf75mr1169875a91.6.1778295556340;
        Fri, 08 May 2026 19:59:16 -0700 (PDT)
X-Received: by 2002:a17:90b:45:b0:366:159a:c228 with SMTP id 98e67ed59e1d1-367d468cf75mr1169852a91.6.1778295555804;
        Fri, 08 May 2026 19:59:15 -0700 (PDT)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367be8be938sm750899a91.4.2026.05.08.19.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:59:15 -0700 (PDT)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-next 2/5] wifi: ath12k: refactor HAL TLV32/64 decode helpers
Date: Sat,  9 May 2026 10:58:16 +0800
Message-Id: <20260509025819.1641630-3-miaoqing.pan@oss.qualcomm.com>
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
X-Proofpoint-GUID: uXSZJXxz2ceSvdAqVEu7JrwlVSBhww4I
X-Proofpoint-ORIG-GUID: uXSZJXxz2ceSvdAqVEu7JrwlVSBhww4I
X-Authority-Analysis: v=2.4 cv=J7yaKgnS c=1 sm=1 tr=0 ts=69fea305 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=R17iYGmNITDVIwCHYO4A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDAyNyBTYWx0ZWRfX7moXXX6yYgTu
 jHwA+sQeAcGdUjYxYzyJjcvYLg/LK/tKlnqlB7mQFuzRWLuJ7q09lnCvIAxRceuOFbnAO4rPYm0
 Svt64Qk8mC7MkVQIn2BOZ8sx6MdhqpNyyaL58x0U/1aY/IpHnhsHvPpGlurifUcLc810/8Sk/07
 b8kcDVECadmLw6oQ6WWU4vMPOPaxTGVTPLoUsnYeAg4b1dwNsPnFHTXAQSS3TDCOhOtZqQHK7Oz
 EaZbwwqb6x1aI7WNSZnH2MFFWAC1LhY15hDBVuTQYRBuckXxvlY70IcRJckopgeaF8tKX3HozIg
 XKkPbFaGndEi1rb/ur/0pbp1zBZEmOiW7tgcx2Nuxmin9TnwHMQac9PI5ZuM+nhr7LBeRIl0PWN
 62SNNgGXdvFTLN9u7Q5G4ysWZjy9nlzXXJUH1RGLXMMyFgC1N8EcNAXtU0Vnn7Wwju17jCPboF+
 HYG+Q+SSstXd+cW3Z+A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090027
X-Rspamd-Queue-Id: E59F94FDC9F
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
	TAGGED_FROM(0.00)[bounces-36128-lists,linux-wireless=lfdr.de];
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

Change TLV decode helpers to return the TLV value pointer and optionally
decode tag/len/usrid via out parameters. This allows reusing the helpers
for DP monitor RX status header TLV parsing and avoids duplicated header
decoding in callers.

No functional change intended.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0.c2-00068-QCACOLSWPL_V1_TO_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/hal.c         | 26 ++++++++++++-------
 drivers/net/wireless/ath/ath12k/hal.h         |  4 +--
 .../wireless/ath/ath12k/wifi7/hal_qcc2072.c   |  2 +-
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   | 11 +++++++-
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   | 11 +++++++-
 5 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index f03817b2fbc5..d940f83cd92f 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -846,26 +846,32 @@ void *ath12k_hal_encode_tlv32_hdr(void *tlv, u64 tag, u64 len)
 }
 EXPORT_SYMBOL(ath12k_hal_encode_tlv32_hdr);
 
-u16 ath12k_hal_decode_tlv64_hdr(void *tlv, void **desc)
+void *ath12k_hal_decode_tlv64_hdr(void *tlv, u16 *tag, u16 *len, u16 *usrid)
 {
 	struct hal_tlv_64_hdr *tlv64 = tlv;
-	u16 tag;
 
-	tag = le64_get_bits(tlv64->tl, HAL_TLV_64_HDR_TAG);
-	*desc = tlv64->value;
+	if (tag)
+		*tag = le64_get_bits(tlv64->tl, HAL_TLV_64_HDR_TAG);
+	if (len)
+		*len = le64_get_bits(tlv64->tl, HAL_TLV_64_HDR_LEN);
+	if (usrid)
+		*usrid = le64_get_bits(tlv64->tl, HAL_TLV_64_USR_ID);
 
-	return tag;
+	return tlv64->value;
 }
 EXPORT_SYMBOL(ath12k_hal_decode_tlv64_hdr);
 
-u16 ath12k_hal_decode_tlv32_hdr(void *tlv, void **desc)
+void *ath12k_hal_decode_tlv32_hdr(void *tlv, u16 *tag, u16 *len, u16 *usrid)
 {
 	struct hal_tlv_hdr *tlv32 = tlv;
-	u16 tag;
 
-	tag = le32_get_bits(tlv32->tl, HAL_TLV_HDR_TAG);
-	*desc = tlv32->value;
+	if (tag)
+		*tag = le32_get_bits(tlv32->tl, HAL_TLV_HDR_TAG);
+	if (len)
+		*len = le32_get_bits(tlv32->tl, HAL_TLV_HDR_LEN);
+	if (usrid)
+		*usrid = le32_get_bits(tlv32->tl, HAL_TLV_USR_ID);
 
-	return tag;
+	return tlv32->value;
 }
 EXPORT_SYMBOL(ath12k_hal_decode_tlv32_hdr);
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index b3a89ace5a97..3158c1881c76 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1551,6 +1551,6 @@ void ath12k_hal_rx_reo_ent_buf_paddr_get(struct ath12k_hal *hal, void *rx_desc,
 					 u8 *rbm, u32 *msdu_cnt);
 void *ath12k_hal_encode_tlv64_hdr(void *tlv, u64 tag, u64 len);
 void *ath12k_hal_encode_tlv32_hdr(void *tlv, u64 tag, u64 len);
-u16 ath12k_hal_decode_tlv64_hdr(void *tlv, void **desc);
-u16 ath12k_hal_decode_tlv32_hdr(void *tlv, void **desc);
+void *ath12k_hal_decode_tlv64_hdr(void *tlv, u16 *tag, u16 *len, u16 *usrid);
+void *ath12k_hal_decode_tlv32_hdr(void *tlv, u16 *tag, u16 *len, u16 *usrid);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
index 1eefb931a853..c0583c3a2191 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
@@ -439,7 +439,7 @@ static u16 ath12k_hal_reo_status_dec_tlv_hdr_qcc2072(void *tlv, void **desc)
 	struct hal_reo_get_queue_stats_status_qcc2072 *status_tlv;
 	u16 tag;
 
-	tag = ath12k_hal_decode_tlv32_hdr(tlv, (void **)&status_tlv);
+	status_tlv = ath12k_hal_decode_tlv32_hdr(tlv, &tag, NULL, NULL);
 	/*
 	 * actual desc of REO status entry starts after tlv32_padding,
 	 * see hal_reo_get_queue_stats_status_qcc2072
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index ba9ce1e718e8..8d8d1a9c05d3 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -934,6 +934,15 @@ void ath12k_hal_extract_rx_desc_data_qcn9274(struct hal_rx_desc_data *rx_desc_da
 	rx_desc_data->err_bitmap = ath12k_hal_rx_h_mpdu_err_qcn9274(rx_desc);
 }
 
+static u16 ath12k_hal_reo_status_dec_tlv_hdr_qcn9274(void *tlv, void **desc)
+{
+	u16 tag;
+
+	*desc = ath12k_hal_decode_tlv64_hdr(tlv, &tag, NULL, NULL);
+
+	return tag;
+}
+
 const struct ath12k_hw_hal_params ath12k_hw_hal_params_qcn9274 = {
 	.rx_buf_rbm = HAL_RX_BUF_RBM_SW3_BM,
 	.wbm2sw_cc_enable = HAL_WBM_SW_COOKIE_CONV_CFG_WBM2SW0_EN |
@@ -1122,5 +1131,5 @@ const struct hal_ops hal_qcn9274_ops = {
 	.rx_msdu_list_get = ath12k_wifi7_hal_rx_msdu_list_get,
 	.rx_reo_ent_buf_paddr_get = ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get,
 	.reo_cmd_enc_tlv_hdr = ath12k_hal_encode_tlv64_hdr,
-	.reo_status_dec_tlv_hdr = ath12k_hal_decode_tlv64_hdr,
+	.reo_status_dec_tlv_hdr = ath12k_hal_reo_status_dec_tlv_hdr_qcn9274,
 };
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index e64e512cac7d..4bef64ac9150 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -740,6 +740,15 @@ int ath12k_hal_srng_create_config_wcn7850(struct ath12k_hal *hal)
 	return 0;
 }
 
+static u16 ath12k_hal_reo_status_dec_tlv_hdr_wcn7850(void *tlv, void **desc)
+{
+	u16 tag;
+
+	*desc = ath12k_hal_decode_tlv64_hdr(tlv, &tag, NULL, NULL);
+
+	return tag;
+}
+
 const struct ath12k_hal_tcl_to_wbm_rbm_map
 ath12k_hal_tcl_to_wbm_rbm_map_wcn7850[DP_TCL_NUM_RING_MAX] = {
 	{
@@ -805,5 +814,5 @@ const struct hal_ops hal_wcn7850_ops = {
 	.rx_msdu_list_get = ath12k_wifi7_hal_rx_msdu_list_get,
 	.rx_reo_ent_buf_paddr_get = ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get,
 	.reo_cmd_enc_tlv_hdr = ath12k_hal_encode_tlv64_hdr,
-	.reo_status_dec_tlv_hdr = ath12k_hal_decode_tlv64_hdr,
+	.reo_status_dec_tlv_hdr = ath12k_hal_reo_status_dec_tlv_hdr_wcn7850,
 };
-- 
2.34.1


