Return-Path: <linux-wireless+bounces-30688-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4DDD10E97
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 08:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 49B8830090C0
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 07:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5704533064E;
	Mon, 12 Jan 2026 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fj1IPvvd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TYMLiMfu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1077B30CD82
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203445; cv=none; b=nI+P2pTHdI2kDiIFxSZ0ja3FuUPJYg0k/vXqlRvqel3QUpaqJrl0Lipwb7DGOh1tjU67WhyRDfV9Lbi9B6ZMRXR+zMz9eS3RfSScjQHYYKvgYoIENdVXwBIl2U5xmRTUi99jVB56Pjax4tiLq4spuFguElViij6msVzzlVIlXw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203445; c=relaxed/simple;
	bh=EOF1rFJOFyX/LNuGNJS5NNSrYKaKBeMXfSG2QCSO8NE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EL7x8VUij5q8hVWh8/Bn6QmyCNBDOrOsw1hTu0Vn1HO5zsEsZNzROuVok8zmJzbS5uyp7PfWevRx/cU7HroGBxnSOhdUOqQXSvvWJYfaNA4q9vkon6JSNRVOKlTCjy/E1MWTSn1DRaw+Bj5glEsPJ1H338htIZ70rz/zbRJEw/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fj1IPvvd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TYMLiMfu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60BLHOfg3014049
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TjqgNR4qIsXaQ0uW1recCcAkzD+y0LuolDPXsNIQTjQ=; b=fj1IPvvdnyN4hRS1
	Z8oCCUGlc83LYGl2+1S0t+/4ineiLQTV5jeY45TL8n2HIsjtPCflWfmRwGOXzxVB
	0xubD2+8HLOx90A/CNz6Lh/V/DyOn4yllgQv9Im1DSNOoaGtMllChrwHsjWyFJZp
	ubmNj/csjjZ//aBNiAMfDiPS6M24/GELn8HGvrzEC/YF78dTowmkst3sf9onoiBG
	Oo9oc+S0CjmyJm4pk4JuDOUMYQ4zMBgJUC/13Vq4cB+DWul7bs+PJgOLC0J4srEh
	RnrCQOZP9+8WC5ZgVjK2HECSO3ghXJbcu2A8Iu/CPAr8P3pzPGtWud+QhLymmNje
	pf2t8A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bkntukden-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 07:37:21 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b62da7602a0so4453262a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 23:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768203441; x=1768808241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjqgNR4qIsXaQ0uW1recCcAkzD+y0LuolDPXsNIQTjQ=;
        b=TYMLiMfu9b+N4kK1Ke4lSWlASxVt+9ynMKcbOozobWwb2jSY03YNxnvXxp0tgd8GX/
         G+iR892rD1q6GXmZVkQXd53tfYtvSUaKv1QRgCX5n/muR+WBlA1/0/dnyb+RwleORWTu
         ulmRLlPMR9FPGVbTd+Mxyw8Ik2QJdnSxpN+R/oNU1QVy5Nu0oxqpDpMvjHlnCaFGwl68
         KaOtvK39tLUTKoMrq/tb9K1xonTCDqufwma6MMTIChXdGdDVgUHfvwpfobxp8mNzKVGt
         zYp23PrcMzAuxMqBQJ5/SdMopcyyIafuHMA5vzNApvA/UNoS5ig5ge1+lNjQpTkcKtrL
         Q6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768203441; x=1768808241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TjqgNR4qIsXaQ0uW1recCcAkzD+y0LuolDPXsNIQTjQ=;
        b=Midex6hpYrEMpM3W0rTKmi2jzfRbcaH0uvAaN66bZ71DRXmpPhtBjmhYsH455lkNob
         mPQ1uBxzuKM5Qmmcn5r5Fn7/rS44q3zcE5hlniV9FlP5mdF8XN4ZoFyNkE0pgz6rW4iU
         XtmDh8zka/uocZh9HEsyhwZLmyKzcyrCd+TtJmxw+j+OsU13zsoUUm6VtUCOAYoO+J8x
         XY42GT5NqB4eQhmFL7Lh5b/wnINIa3A0feWNaj+5UJzcjUhocFSpk8wVLIkGKF0wFOP5
         1FvXaYTv1+FlaJ9XP/KHTHT79V4A6kLFf7kLBh7LvKxmm/xy5XgnCccc1FlO+Kun0+n0
         qruw==
X-Gm-Message-State: AOJu0YySlCQN5lNhGGuHJjLdM6wMi6F8s1nuutFucCX2XBTsHL0VTcVe
	jJH0vdT2eod8bvrTDU3zu5NS07x2HhifwGmMkaaRalhf+n+xoouZhlU5LCnUanEnvDp36EkJrn9
	muWvFORRSApgNuPVdXVW8EEKfugJWiLQn9VAhksRw4qnyir/WaL+IHfpcnXHap7USqKQS9Q==
X-Gm-Gg: AY/fxX5ellTLfNLoCzVH7+aN2Admf16mfaLO+bAcoVbY7XhPG7j36JaaATXrv+xQTqC
	MTT0XqQ6rxYYy+Rzh9wo6o6Nr38OZj1MPXn9IPNBdmRjmn9ikDQKjBMueGosD9vF+calNFfxEqk
	PYrVmwieGnOzMumWZUqEX6u4wy2JIBvzgauphYPGOZoQ+KM5q/3S+Z2In74blWVPCLQxY2u8Vef
	9AQbmB6KmuHpRH95BrfopswX0naMlyP25fq9xw50tPR+/pDSC6gV3vCuMxZuieor8cBQvyraqyA
	LopXTvKrI8NCQcqHVCnTVr7JLaBpyBJEvCn6RfgEOl2uUHQYevg7nTsIQSCcsfC59sELwg7e8T0
	SAH7JhbjJAaTqHH5FF26QiFT0XRrkdeezEMEC2CKhCehw7t7czEdCwagoFAK4IRU=
X-Received: by 2002:a05:6a20:9154:b0:352:220d:e5fe with SMTP id adf61e73a8af0-3898f952f52mr14903135637.50.1768203440886;
        Sun, 11 Jan 2026 23:37:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJaQj/rvVI+Zh/H0A906IIIjJAjKK9ohDcirHhoZwBGcLyWdB3bv+oKOqMp+1X5rMvz1UFYg==
X-Received: by 2002:a05:6a20:9154:b0:352:220d:e5fe with SMTP id adf61e73a8af0-3898f952f52mr14903124637.50.1768203440411;
        Sun, 11 Jan 2026 23:37:20 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28faa9sm16548684a12.2.2026.01.11.23.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 23:37:20 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Mon, 12 Jan 2026 15:36:35 +0800
Subject: [PATCH ath-next v2 15/18] wifi: ath12k: limit number of channels
 per WMI command
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-ath12k-support-qcc2072-v2-15-fc8ce1e43969@oss.qualcomm.com>
References: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
In-Reply-To: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA1OCBTYWx0ZWRfX+hCWLb89Aej1
 j56tQ9SF1WeFdjlCWwvsJ+rv6TxXMnAtbBTxwdIksa9wu+dWu3gCDHIKjXeEJTn53AWdYMWfr3b
 V3lQ3gse8jinVxuPt9ieUQY9yh1owDbqPKSC+YkHZYUvAohc1UOoRS/L+AgWdkF3UXpTYYHbJGh
 qFI4lYuHGoOIXS3c6yOIUAsnYYbA+wzzdf0o1P2leuvpeiLixEOasyV6EaZ4Hc8F4MkciV1VJw9
 j0ICqOucw1FygD3kEODIFI3FOhkTnV1JBFQdWpcRKt4rq8RurxDAchU7GoIBqzLDEyt/VtmE5Ui
 JNqRjj8NRQp1UK2zKMLw61wqLVGdco8TZ35aA8goTjf0irWGctDNBU6lrMtD95axHCNiyfBtpBt
 HqecKNz4T6sX3XnoU5LWcBeWqPkVmQkC6pW1+ar/R8VI1vDNMEsaOH6n4VT/u38CE0Za2Bi7HcK
 pupw/dS3olALACeO/Pg==
X-Authority-Analysis: v=2.4 cv=R6AO2NRX c=1 sm=1 tr=0 ts=6964a4b1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=3KhbVLdr_5p6mxRQPsQA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: YsAEzR1GaYvCayHJxUTruWjlfJWyS9sk
X-Proofpoint-GUID: YsAEzR1GaYvCayHJxUTruWjlfJWyS9sk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601120058

Currently the number of channels can be sent in a single WMI command is
calculated based on the maximum message length of the target, this results
in WMI exchange hang for QCC2072 as its firmware can not support those
many channels in a single command.

Add a limit to avoid this issue.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0-01560-QCACOLSWPL_V1_TO_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 3 ++-
 drivers/net/wireless/ath/ath12k/wmi.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 79a26203afad..0e1e6853ab85 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -2806,7 +2806,8 @@ int ath12k_wmi_send_scan_chan_list_cmd(struct ath12k *ar,
 		max_chan_limit = (wmi->wmi_ab->max_msg_len[ar->pdev_idx] - len) /
 			sizeof(*chan_info);
 
-		num_send_chans = min(arg->nallchans, max_chan_limit);
+		num_send_chans = min3(arg->nallchans, max_chan_limit,
+				      ATH12K_WMI_MAX_NUM_CHAN_PER_CMD);
 
 		arg->nallchans -= num_send_chans;
 		len += sizeof(*chan_info) * num_send_chans;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 65f0d7ed4178..daee2787cdfd 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -6322,6 +6322,9 @@ struct ath12k_wmi_rssi_dbm_conv_info_arg {
 	s8 min_nf_dbm;
 };
 
+/* each WMI cmd can hold 58 channel entries at most */
+#define ATH12K_WMI_MAX_NUM_CHAN_PER_CMD	58
+
 int ath12k_wmi_cmd_send(struct ath12k_wmi_pdev *wmi, struct sk_buff *skb,
 			u32 cmd_id);
 struct sk_buff *ath12k_wmi_alloc_skb(struct ath12k_wmi_base *wmi_sc, u32 len);

-- 
2.25.1


