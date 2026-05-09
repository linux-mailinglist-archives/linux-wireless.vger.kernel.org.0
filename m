Return-Path: <linux-wireless+bounces-36129-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGMhKW+j/ml9uQAAu9opvQ
	(envelope-from <linux-wireless+bounces-36129-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 05:01:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD254FDCA7
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 05:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF29B303F075
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2026 02:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1706837C11C;
	Sat,  9 May 2026 02:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZzZkJusr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ya8AzCrY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F19737CD32
	for <linux-wireless@vger.kernel.org>; Sat,  9 May 2026 02:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778295562; cv=none; b=G/7I/Pb5r50FPExzIq7R+b9LBr3xnn+nPvSydZjz1YkL0guQq/u2+upg7v0jH/QpfXR+mfIeazDxQFsPZv2Kmfsbj+W9Lb/5PHSCun+7ivo+Wxp2BstX6mUaqthxtmrUd8FjvmqJqUqBxCRd5ZKnvpZZ7QMyd18C8IFnurV8AbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778295562; c=relaxed/simple;
	bh=BdV0X3nZR8PCcjenjPa8imJgl1N26Nzy4KidKMtGhmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GrZBqU8UDXAgZy2K4cTle8zaKeIktSciayoHXn0b7VrKqIpOS7Yt3xScGdOOnPh6TE84bR66WqwYOXE4qoBQylUJr5omlhBwTkjaF0px7WmOUXfF3/b3PW71mnWaR00SYrm7dmVofeIN/Sr6MyS+na0J8CAX5NQdaV09sWC3qVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZzZkJusr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ya8AzCrY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6490gmJg2206695
	for <linux-wireless@vger.kernel.org>; Sat, 9 May 2026 02:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=AwM5k+UWfUT
	Ut59a3ABR2UlFzgDmzYoEve9ZdYQTTxU=; b=ZzZkJusr3zRgZqckksdkRkWZK4x
	yHRSOKtSxuREkWNS5Ox3w5y8XxyPZaWb+T5AyXeVXYcUo534BBHMf0GTSlmd6qS3
	fX70zAFLZ/0GxPBu5SaUdRlM9W6Y1YU1yyGMNBZGGsLY96/l0u2PN+9ocw15iyUj
	/ndcZTAit+TmeMO1pFTQqNXMw87+Ta/pNjPZOyLNrh8DhNoBrqjR7zPuUKTUL3e6
	89Utbz7KWhrQPz1OJVG7TGzmv1oF8HCrgjvcJR3CQecN/6YKk2WGrp5o4M20SvnB
	n5bSne9vhUBqDS3rTbFVrK9kDnGGZRclCHMjSF30eqV2U7lGpLbkcRgGG8Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1tmd09nq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 09 May 2026 02:59:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba054e0304so26605235ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 08 May 2026 19:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778295559; x=1778900359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwM5k+UWfUTUt59a3ABR2UlFzgDmzYoEve9ZdYQTTxU=;
        b=Ya8AzCrYJjJlWRjGXhHWutp0Hmq2NBpapLeQ9UyV3UekMHa5yXxsT27mvKJtvhS5ls
         F/goapwZDdPh83INeP4z8jEgaGAhRoNj7xdzmiqs8BVceg8UQjBm/Ka/1O4kMoE9DxoZ
         jTq0+YDFLWOEFp07jL5/x9MrtaFq5jJbFnTVBi5LNfiQPKaG1Y7LM88TTi49afDLlbSK
         h0fd5yjouJRgArrW6l/0vOMVFRkOlC6bM7vjzF/2cWlWObEL5BrC6fMWRtjRK4EF8eTp
         UfwtTIiYgJMjHqLYd5Vd3l4TLKyNAfNyURcoEXKFsIiQLGWxCFgXYjv5ZJBRq4HJlJca
         R8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778295559; x=1778900359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AwM5k+UWfUTUt59a3ABR2UlFzgDmzYoEve9ZdYQTTxU=;
        b=oB6YcZpm0ceDEiHW1uhJ5L3Q7vJwkDDaVPAL7eMZ/8Oz3+ki7YHN2QqlgL4aOJN4w9
         +wM85ZgaMxQAUP4kS9XvN0rJjoWhYFbdxv6Ngn9vNn8VJpYRBPi15mR4T/yu3nZpu/eh
         c8pdaGMJZF+D51IZsDzTxLmZ7RO9rBaJuYsis2K8bfM+Pf+0q8xrMDBvgkNceXzoWYVN
         fo0CiuJ4lY7m0VxcnV0ucyKNelCUR+bDDQ8Sy0np0ifd+aFqIi0V6dGkWkx8Mq06KFoE
         qbVJXDQXLQEAiUR7nYQzcAy6bocgjCRsLYLil97R6DAuiOdU25oJx/88lD8lEru+f5cp
         mGBA==
X-Forwarded-Encrypted: i=1; AFNElJ/rJw3KZINis0a8oxSgIGJ+B58NcWuTtzMAP9pgwftXCMMsOboJdsDYtcgu1BM1F6bwbyNi3S5kyopgGo5/Eg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoodTEOymW8yW15y88RcTezhGmHcYRzoXDgpvwHFdqXXMW/nHB
	pDmVGgyQUMKxIr0CLhbdQmNLA3rvodz45dZ5HCz5YZqFQ4mH7RnZT2q6jAHqiACUBQlnJTcc377
	iMft0hDN1PFKcYqZuezakaiQb0HE2jz9Q6UvV2Rjexb6AwojIYyDCIfJhM96xMgYv4o3DTQ==
X-Gm-Gg: Acq92OHubD1Rp7cBwSr4PGdmSVZbw7geV52TUig9vrJtRv66w0WkPnp20CgwON+LSus
	/QqPsDmUKxFhtXhcLqJV8oa1ynXHTMWG0UcHveO486ITMWemBrO7HvFUP5sLZ+Hw3S1cBvkqiTM
	B1+qZ6QsRAYiGRLgY57p+KJIXwiE78JE30RPRwHUJ/8yv55dnsT+7r7eBZxWiLRy1zPnJDZNj+c
	nfdZbM/1HXHp7g9ljLrEMnPbzYu5GaGyMKDhkKyEC9odp/UwjPSycZUyloy1fChAD2KwN7+g3fF
	PmFS0WJuEdfRBSSqrslM3xFb76MlXTCFGT7JfzX11TUebkjYUUxWZ0DKfM6k5QGcuTxr5FFk1uf
	rCUHND7kmRxS4J2/osAa/jNvMtA+yx6ldXXDd0dtnGt5dmXpvT6Wcq7QCdHP63sftJdWaKDEXnR
	Uj/Mm2ovwj+r16uyI=
X-Received: by 2002:a17:90b:2707:b0:35c:1d65:7867 with SMTP id 98e67ed59e1d1-36605a524admr9707139a91.15.1778295559119;
        Fri, 08 May 2026 19:59:19 -0700 (PDT)
X-Received: by 2002:a17:90b:2707:b0:35c:1d65:7867 with SMTP id 98e67ed59e1d1-36605a524admr9707110a91.15.1778295558548;
        Fri, 08 May 2026 19:59:18 -0700 (PDT)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367be8be938sm750899a91.4.2026.05.08.19.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:59:18 -0700 (PDT)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-next 3/5] wifi: ath12k: add HAL ops for monitor TLV header decode and alignment
Date: Sat,  9 May 2026 10:58:17 +0800
Message-Id: <20260509025819.1641630-4-miaoqing.pan@oss.qualcomm.com>
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
X-Proofpoint-GUID: vX9ZpeJk23s4JLK-hJj4Vi4hfpK3IZY-
X-Proofpoint-ORIG-GUID: vX9ZpeJk23s4JLK-hJj4Vi4hfpK3IZY-
X-Authority-Analysis: v=2.4 cv=aZlRWxot c=1 sm=1 tr=0 ts=69fea307 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=cBALExdzTAL-QLrJbW0A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDAyNyBTYWx0ZWRfXxIsmWSHakqqY
 qqBp6srMjalMAo+SRMmoIYnoI3fBtGVrpXtYg+WVQtiogn1gSSkZoUrW9r1h5s3oCJvUdXaYUbm
 kA89ewbKk9mLfmc2LU0rS9FHELWP/+CA6XL/vTRxFBaDhcyDAbctro/0XfXcNoClCkrm/VOnOD9
 Kd3TtDjNBmcE+4LnCHNhLfykDCUkH8PbtsK+eQTN4KNhUjrzohy5Pn6s5ms9Hvw9Wdjm7Vl7iZN
 cGlUX3FRnIQdO+qgKcX0CUAXfuH/jQhdGyWK8dkXXQCIow9ViD5gRhaZsh9NX3MKpQLe5bDG5MU
 +JY5czlue3yv80R1yq/uV3y6nLZEixIismApedMwouegLFqCSfAEMtKehmrcjkG5CMzx0NBL8ah
 U45l0bmaA491gWbEPoVU4RMf1dGinf3z4XAUUM6ahzdGxaG6xI0Rir8zFyC1lfB5lq1GAFss5vZ
 lsJ0KflQ7yWjHG3xufw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090027
X-Rspamd-Queue-Id: EFD254FDCA7
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
	TAGGED_FROM(0.00)[bounces-36129-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Wi-Fi 7 monitor RX status TLV parsing needs to decode TLV headers and
advance the pointer with the correct header alignment. Different targets
use different TLV header layouts (32-bit vs 64-bit), but the HAL ops for
dp_mon RX status header decode and header alignment were not populated
for all wifi7 targets.

Add dp_mon RX status TLV header decode callbacks and TLV header alignment
helpers to the wifi7 HAL ops for QCC2072, QCN9274 and WCN7850. Export
helpers to query the required TLV header alignment for 32-bit and 64-bit
TLV headers so the caller can align the TLV walk correctly across targets.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0.c2-00068-QCACOLSWPL_V1_TO_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/hal.c               | 12 ++++++++++++
 drivers/net/wireless/ath/ath12k/hal.h               |  4 ++++
 drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c |  2 ++
 drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c |  2 ++
 drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c |  2 ++
 5 files changed, 22 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index d940f83cd92f..c0c3d2f047ef 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -875,3 +875,15 @@ void *ath12k_hal_decode_tlv32_hdr(void *tlv, u16 *tag, u16 *len, u16 *usrid)
 	return tlv32->value;
 }
 EXPORT_SYMBOL(ath12k_hal_decode_tlv32_hdr);
+
+u32 ath12k_hal_get_tlv64_hdr_align(void)
+{
+	return HAL_TLV_64_ALIGN;
+}
+EXPORT_SYMBOL(ath12k_hal_get_tlv64_hdr_align);
+
+u32 ath12k_hal_get_tlv32_hdr_align(void)
+{
+	return HAL_TLV_ALIGN;
+}
+EXPORT_SYMBOL(ath12k_hal_get_tlv32_hdr_align);
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 3158c1881c76..312993d3d5d4 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1439,6 +1439,8 @@ struct hal_ops {
 					 u8 *rbm, u32 *msdu_cnt);
 	void *(*reo_cmd_enc_tlv_hdr)(void *tlv, u64 tag, u64 len);
 	u16 (*reo_status_dec_tlv_hdr)(void *tlv, void **desc);
+	void *(*mon_rx_status_dec_tlv_hdr)(void *tlv, u16 *tag, u16 *len, u16 *usrid);
+	u32 (*get_tlv_hdr_align)(void);
 };
 
 #define HAL_TLV_HDR_TAG		GENMASK(9, 1)
@@ -1553,4 +1555,6 @@ void *ath12k_hal_encode_tlv64_hdr(void *tlv, u64 tag, u64 len);
 void *ath12k_hal_encode_tlv32_hdr(void *tlv, u64 tag, u64 len);
 void *ath12k_hal_decode_tlv64_hdr(void *tlv, u16 *tag, u16 *len, u16 *usrid);
 void *ath12k_hal_decode_tlv32_hdr(void *tlv, u16 *tag, u16 *len, u16 *usrid);
+u32 ath12k_hal_get_tlv64_hdr_align(void);
+u32 ath12k_hal_get_tlv32_hdr_align(void);
 #endif
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
index c0583c3a2191..80ffadc47d48 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
@@ -490,6 +490,8 @@ const struct hal_ops hal_qcc2072_ops = {
 	.rx_reo_ent_buf_paddr_get = ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get,
 	.reo_cmd_enc_tlv_hdr = ath12k_hal_encode_tlv32_hdr,
 	.reo_status_dec_tlv_hdr = ath12k_hal_reo_status_dec_tlv_hdr_qcc2072,
+	.mon_rx_status_dec_tlv_hdr = ath12k_hal_decode_tlv32_hdr,
+	.get_tlv_hdr_align = ath12k_hal_get_tlv32_hdr_align,
 };
 
 u32 ath12k_hal_rx_desc_get_mpdu_start_offset_qcc2072(void)
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
index 8d8d1a9c05d3..129f6b1919e3 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcn9274.c
@@ -1132,4 +1132,6 @@ const struct hal_ops hal_qcn9274_ops = {
 	.rx_reo_ent_buf_paddr_get = ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get,
 	.reo_cmd_enc_tlv_hdr = ath12k_hal_encode_tlv64_hdr,
 	.reo_status_dec_tlv_hdr = ath12k_hal_reo_status_dec_tlv_hdr_qcn9274,
+	.mon_rx_status_dec_tlv_hdr = ath12k_hal_decode_tlv64_hdr,
+	.get_tlv_hdr_align = ath12k_hal_get_tlv64_hdr_align,
 };
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index 4bef64ac9150..881986075548 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -815,4 +815,6 @@ const struct hal_ops hal_wcn7850_ops = {
 	.rx_reo_ent_buf_paddr_get = ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get,
 	.reo_cmd_enc_tlv_hdr = ath12k_hal_encode_tlv64_hdr,
 	.reo_status_dec_tlv_hdr = ath12k_hal_reo_status_dec_tlv_hdr_wcn7850,
+	.mon_rx_status_dec_tlv_hdr = ath12k_hal_decode_tlv64_hdr,
+	.get_tlv_hdr_align = ath12k_hal_get_tlv64_hdr_align,
 };
-- 
2.34.1


