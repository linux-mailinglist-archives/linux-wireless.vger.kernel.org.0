Return-Path: <linux-wireless+bounces-36130-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPJHN5qj/ml9uQAAu9opvQ
	(envelope-from <linux-wireless+bounces-36130-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 05:01:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB1E4FDCB6
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 05:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91340304F2E9
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2026 02:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742BC37C930;
	Sat,  9 May 2026 02:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HnvAIrt8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MlWV8yuz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36C637CD31
	for <linux-wireless@vger.kernel.org>; Sat,  9 May 2026 02:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778295565; cv=none; b=lqY+r+Zd1H9lNukl7I6s4a4XYUAheKDSXiFaDsG+BAGsR0dJHRWyZc+kmj/iAsoGLi8QlNEtKvSUQLZm7qUasggrJWq1ZW88mug3ca9nA70V7SHmouNDDCEhGswYH/2IV3ur/t1PeIgcoKqfY8QwbdM1s24k0TfHMYrDYiJlIoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778295565; c=relaxed/simple;
	bh=u63+KuXmPCim3hS/50nWwD4V8vIGSzhRIFi4PdleYL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e7rbZ1d+eeAggFFWAZejQS5jHCZJOI5hProPXRU5fuwEFTk4Le1nDl6bdEZ75V0kp52X8omJZiywEhdlfR+wSJOKjCYYDXIa2KzObJ9/6qdRTuw5ZaJfcHwbHdHB7ovDfoj/yotwaJoZdpT90B4EwWxelTEM5p7k9VxvXrTQoeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HnvAIrt8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MlWV8yuz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648L2XQI852373
	for <linux-wireless@vger.kernel.org>; Sat, 9 May 2026 02:59:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=SiDz0P/Mnp1
	qjre9Pw1n3xWLk8C6LBzQ/tAeEv9bMZw=; b=HnvAIrt8TH3Yjvc8U/knIwoABcf
	nTLhOx+6kjt41UC7OcTMJ3yHk8EDZoJU4jbFO3xHKoxUUZVS38+KSlGm7igmb4nk
	HNI1sk5jQBwnEDCE2yulS1RnUtmQddG6MgXGJUquBouJyXFyQ615w3u7TurSsq3L
	LjSgGnJIU2UZM4gdeyCtl3ye+IA6CHADwKgPCNuU3nkd9/dqIs45bPal40TF9jc/
	NUSD7D5vwOfbjNAJl+l47QS+U+oR6lq5uBy521ivNJLI8zWVZGsmPqsL7WEKKduO
	TbfABSfU5ns7VjYfx+yRqKlqO2J9/5hdMQLGPEjhf5ilEAFjAh+doK3xEtQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1fptjp7m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 09 May 2026 02:59:22 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-366ded5ab5fso2003796a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 08 May 2026 19:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778295561; x=1778900361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiDz0P/Mnp1qjre9Pw1n3xWLk8C6LBzQ/tAeEv9bMZw=;
        b=MlWV8yuzerBP+AP5mueMB/9HiS4UK6mezNDHPHHFt2ZeobVMT+2eNqcxGNZ+C6TwEo
         I83MiaY/mqT3WSOK5Pn8BmQ0lSssO2jXNXznWzrXqTBLgb0jKzatQAuf+vxkuDqSDu/p
         RhIHcPhzfE762O8b7QeRIpNqLuwLPa7b8PVASvbpmVIQnp9YCv9ibe94jwlo+Mn5Kv9N
         c62+l02w+4IqA1L/QFN3Acr+fpjgycRjL0dsaSIjMztz9ded0OvXlK/AAImRR63ST7o1
         Sbs3OLbXXybRk7zpqK8E67hVETXwAI/rFSK8KGwVbeAdrPPRovl864556mGlmj7yKaPb
         c7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778295561; x=1778900361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SiDz0P/Mnp1qjre9Pw1n3xWLk8C6LBzQ/tAeEv9bMZw=;
        b=gNCJPsVyjS3RcDx4oMczVfzRfetuWfxkW3AxC7/YWmxLb7Vodh2KDWV6MBozCVI1H/
         4Dn9ZNZDCE3WvKaCRDzMLltSl5il+jBY6YKCJw+GfDcOY6n8WWg1SOaH+N4ApeSBJSZ5
         LAMcKClRANePvJUATVMFppdforb5gDMGVSwEQiPBi65Yy4psGbptJT/QfKu1gtb4tJjI
         snHC1S+FeEZJPdLpHiSzhBV0A5NSZbiQMHQM/r5J529SHKlNXKfT+HIH8UcgN8HFxQHw
         Ae3gh46rwchZDwKggzdird6wf8OUe3Zur5KGTDkknmdZZE2Ih70oK9dnA36gZA1EilGq
         tTmg==
X-Forwarded-Encrypted: i=1; AFNElJ/rM5eUSVkoPk5D4w4VLcfDBiOR+FOxYs8If3M+OCZ2CZbQvX2ZP/LHhtByh96vK8NpXvqjdBt09KDY/oE0jA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUmiubO3uaQhRMrjwv207Huoc8WDKyFiQiqXmsgSAJl+nxm/oY
	1dv1wlAgLScJdYgnomAsGqvLJ3tPjcgIE3D3o7KTCobkvLKPmAAk4ChKlaaXPX5lADzLMUasHrY
	rqLZ9wkHHKugJ3XATAF/drwZ39E2hyhmIlL3Vx9VHAX/sfqy+o2BmVsX9liD8Ayx84o/RuslREd
	XB9r0g
X-Gm-Gg: Acq92OEqUvmIYs3xucz4e9s8E1KF+rqZUJs3J3VhEOUVvGYyccUr94VlQ8a2L5h0/Ej
	eJLbolEC08ZPbYr9HHUnW73/cl7Q5hjIliC8QZrIByS7JXbWaXJBm374d4wOe2AwS6N4ThbRoVw
	UBojsQcCqUKCPaOFTHtmV/vTw/dTpDtAlFEJQye70ryXCfUPm9wqt8Ir/zmX/PR3nwiYJXshRdc
	ULaidLPpQzZVZOdiUhc/pNEOjpZs1Zv0t2WAvIR1FlwlkhE4OX9HHh+/rmu3sY6EZv6SjU6xN92
	BDGHqxSAsMNpWuyKtsZgR0/hpsHnAy/jMaR1WNr+8+9jTRQ4n7EP/BEcrp+MVbW+Kq1t9s+8UI+
	A94bPAlvYR+gxKlUVqul8/zjOeIYU2E8lcKujqNQuMR4HSBpS4BsndSW1z7Z3QquPGYHVNPQE48
	9QzCbq
X-Received: by 2002:a17:90b:4a03:b0:35e:58d3:329f with SMTP id 98e67ed59e1d1-367d4845b95mr1127710a91.13.1778295561416;
        Fri, 08 May 2026 19:59:21 -0700 (PDT)
X-Received: by 2002:a17:90b:4a03:b0:35e:58d3:329f with SMTP id 98e67ed59e1d1-367d4845b95mr1127687a91.13.1778295560880;
        Fri, 08 May 2026 19:59:20 -0700 (PDT)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367be8be938sm750899a91.4.2026.05.08.19.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:59:20 -0700 (PDT)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-next 4/5] wifi: ath12k: add dp_mon support 32-bit TLV headers
Date: Sat,  9 May 2026 10:58:18 +0800
Message-Id: <20260509025819.1641630-5-miaoqing.pan@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: qL62HhGfbsw0oBVjnWvY9Va21TBCU99F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDAyNyBTYWx0ZWRfX96rXenqfqzIy
 akavgOyeD9Kgv0y7pGOaAygPy2fuKw7qJnviZ2x9QMOB2pv2oqzhDONfGBveKxIaGWV8NPEJ1yY
 FefBRZAe8s01u7ijQV6X9Nub8f13oE9D1ONFpRlXCGvtWGzndnLAsDzd0tMSI4T/sVvf1cdiQFQ
 cns56i6CRb4DBeEFPwG0A8wVGg8yi9iFXW8fQK4BiQR3q8kKRuzbqYm381/75JJqNo+KDz0LH2K
 mTP6mBQsOlcQ8c14oeFbcZE6CW1gKQYqSKd9XuqqpSLySAeiyHY330VEOzJASaBpIrsCKowEYMz
 rcisxoD0NTL5iEkOhE5bV+A2LdQBEk6bFBa4Y8M5mCBz351IfD75lKypM7pS+vYHtuQ8AbJYuNb
 ALcbvqvIjA7yjwcbLrNarDRTJXHL1LoS/9dAH44Mc2TOapsNheJ4QBAvs29utNCykLpHXpIQByt
 u3gu5JBAPO447JXgf9g==
X-Proofpoint-GUID: qL62HhGfbsw0oBVjnWvY9Va21TBCU99F
X-Authority-Analysis: v=2.4 cv=IYi3n2qa c=1 sm=1 tr=0 ts=69fea30a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=JST6KbR4yvz285-FHA0A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090027
X-Rspamd-Queue-Id: 5DB1E4FDCB6
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
	TAGGED_FROM(0.00)[bounces-36130-lists,linux-wireless=lfdr.de];
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

Wi-Fi 7 monitor status parsing in dp_mon currently assumes a 64-bit TLV
header and directly decodes tag/len/userid from struct hal_tlv_64_hdr.
On chips using a 32-bit TLV header (e.g. QCC2072), this causes monitor RX
status packets to be dropped during TLV parsing.

Introduce HAL helpers to decode TLV header fields (tag/len/userid/value)
for both 32-bit and 64-bit header layouts. Without changing the actual TLV
parsing logic.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0.c2-00068-QCACOLSWPL_V1_TO_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 .../net/wireless/ath/ath12k/wifi7/dp_mon.c    | 57 ++++++++++---------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
index 77f5d23be78d..4266bd1d0d3d 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
@@ -1565,16 +1565,17 @@ ath12k_wifi7_dp_mon_parse_status_msdu_end(struct ath12k_mon_data *pmon,
 static enum hal_rx_mon_status
 ath12k_wifi7_dp_mon_rx_parse_status_tlv(struct ath12k_pdev_dp *dp_pdev,
 					struct ath12k_mon_data *pmon,
-					const struct hal_tlv_64_hdr *tlv)
+					const void *tlv)
 {
 	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
-	const void *tlv_data = tlv->value;
-	u32 info[7], userid;
-	u16 tlv_tag, tlv_len;
+	struct ath12k *ar = ath12k_pdev_dp_to_ar(dp_pdev);
+	struct ath12k_hal *hal = &ar->ab->hal;
+	u16 tlv_tag, tlv_len, userid;
+	void *tlv_data;
+	u32 info[7];
 
-	tlv_tag = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_TAG);
-	tlv_len = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_LEN);
-	userid = le64_get_bits(tlv->tl, HAL_TLV_64_USR_ID);
+	tlv_data = hal->ops->mon_rx_status_dec_tlv_hdr((void *)tlv, &tlv_tag,
+						       &tlv_len, &userid);
 
 	if (ppdu_info->tlv_aggr.in_progress && ppdu_info->tlv_aggr.tlv_tag != tlv_tag) {
 		ath12k_wifi7_dp_mon_parse_eht_sig_hdr(ppdu_info,
@@ -2931,11 +2932,12 @@ static enum dp_mon_status_buf_state
 ath12k_wifi7_dp_rx_mon_buf_done(struct ath12k_base *ab, struct hal_srng *srng,
 				struct dp_rxdma_mon_ring *rx_ring)
 {
+	struct ath12k_hal *hal = &ab->hal;
 	struct ath12k_skb_rxcb *rxcb;
-	struct hal_tlv_64_hdr *tlv;
 	struct sk_buff *skb;
 	void *status_desc;
 	dma_addr_t paddr;
+	u16 tlv_tag;
 	u32 cookie;
 	int buf_id;
 	u8 rbm;
@@ -2960,8 +2962,8 @@ ath12k_wifi7_dp_rx_mon_buf_done(struct ath12k_base *ab, struct hal_srng *srng,
 				skb->len + skb_tailroom(skb),
 				DMA_FROM_DEVICE);
 
-	tlv = (struct hal_tlv_64_hdr *)skb->data;
-	if (le64_get_bits(tlv->tl, HAL_TLV_HDR_TAG) != HAL_RX_STATUS_BUFFER_DONE)
+	hal->ops->mon_rx_status_dec_tlv_hdr(skb->data, &tlv_tag, NULL, NULL);
+	if (tlv_tag != HAL_RX_STATUS_BUFFER_DONE)
 		return DP_MON_STATUS_NO_DMA;
 
 	return DP_MON_STATUS_REPLINISH;
@@ -2973,39 +2975,38 @@ ath12k_wifi7_dp_mon_parse_rx_dest(struct ath12k_pdev_dp *dp_pdev,
 				  struct sk_buff *skb)
 {
 	struct ath12k *ar = ath12k_pdev_dp_to_ar(dp_pdev);
-	struct hal_tlv_64_hdr *tlv;
+	struct ath12k_hal *hal = &ar->ab->hal;
+	u8 *tlv_value, *tlv = skb->data;
 	struct ath12k_skb_rxcb *rxcb;
 	enum hal_rx_mon_status hal_status;
 	u16 tlv_tag, tlv_len;
-	u8 *ptr = skb->data;
+	u32 tlv_hdr_len;
+
+	tlv_hdr_len = hal->ops->get_tlv_hdr_align();
 
 	do {
-		tlv = (struct hal_tlv_64_hdr *)ptr;
-		tlv_tag = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_TAG);
+		tlv_value = hal->ops->mon_rx_status_dec_tlv_hdr(tlv, &tlv_tag,
+								&tlv_len, NULL);
 
 		/* The actual length of PPDU_END is the combined length of many PHY
 		 * TLVs that follow. Skip the TLV header and
 		 * rx_rxpcu_classification_overview that follows the header to get to
 		 * next TLV.
 		 */
-
 		if (tlv_tag == HAL_RX_PPDU_END)
 			tlv_len = sizeof(struct hal_rx_rxpcu_classification_overview);
-		else
-			tlv_len = le64_get_bits(tlv->tl, HAL_TLV_64_HDR_LEN);
 
 		hal_status = ath12k_wifi7_dp_mon_rx_parse_status_tlv(dp_pdev, pmon,
 								     tlv);
 
 		if (ar->monitor_started && ar->ab->hw_params->rxdma1_enable &&
 		    ath12k_wifi7_dp_mon_parse_rx_dest_tlv(dp_pdev, pmon, hal_status,
-							  tlv->value))
+							  tlv_value))
 			return HAL_RX_MON_STATUS_PPDU_DONE;
 
-		ptr += sizeof(*tlv) + tlv_len;
-		ptr = PTR_ALIGN(ptr, HAL_TLV_64_ALIGN);
+		tlv = PTR_ALIGN(tlv + tlv_len + tlv_hdr_len, tlv_hdr_len);
 
-		if ((ptr - skb->data) > skb->len)
+		if ((tlv - skb->data) > skb->len)
 			break;
 
 	} while ((hal_status == HAL_RX_MON_STATUS_PPDU_NOT_DONE) ||
@@ -3057,15 +3058,16 @@ ath12k_wifi7_dp_rx_reap_mon_status_ring(struct ath12k_base *ab, int mac_id,
 	int buf_id, srng_id, num_buffs_reaped = 0;
 	enum dp_mon_status_buf_state reap_status;
 	struct dp_rxdma_mon_ring *rx_ring;
+	struct ath12k_hal *hal = &ab->hal;
 	struct ath12k_mon_data *pmon;
 	struct ath12k_skb_rxcb *rxcb;
-	struct hal_tlv_64_hdr *tlv;
 	void *rx_mon_status_desc;
 	struct hal_srng *srng;
 	struct ath12k_dp *dp;
 	struct sk_buff *skb;
 	struct ath12k *ar;
 	dma_addr_t paddr;
+	u16 tlv_tag;
 	u32 cookie;
 	u8 rbm;
 
@@ -3110,14 +3112,13 @@ ath12k_wifi7_dp_rx_reap_mon_status_ring(struct ath12k_base *ab, int mac_id,
 						skb->len + skb_tailroom(skb),
 						DMA_FROM_DEVICE);
 
-			tlv = (struct hal_tlv_64_hdr *)skb->data;
-			if (le64_get_bits(tlv->tl, HAL_TLV_HDR_TAG) !=
-					HAL_RX_STATUS_BUFFER_DONE) {
+			hal->ops->mon_rx_status_dec_tlv_hdr(skb->data, &tlv_tag,
+							    NULL, NULL);
+			if (tlv_tag != HAL_RX_STATUS_BUFFER_DONE) {
 				pmon->buf_state = DP_MON_STATUS_NO_DMA;
 				ath12k_warn(ab,
-					    "mon status DONE not set %llx, buf_id %d\n",
-					    le64_get_bits(tlv->tl, HAL_TLV_HDR_TAG),
-					    buf_id);
+					    "mon status DONE not set %x, buf_id %d\n",
+					    tlv_tag, buf_id);
 				/* RxDMA status done bit might not be set even
 				 * though tp is moved by HW.
 				 */
-- 
2.34.1


