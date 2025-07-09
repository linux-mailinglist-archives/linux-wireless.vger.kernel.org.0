Return-Path: <linux-wireless+bounces-25018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 007D8AFDD82
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 04:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B3C3A8CBA
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 02:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098981E25E8;
	Wed,  9 Jul 2025 02:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NKy61/ff"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1071DE4CD
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 02:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752028542; cv=none; b=jU2r3RzLAxDyATgfXnzbfbuyh9fvFX/GBSDn0/hw+jzqCWZ5O5+FPmN7ZiIGVkNuPfRaxqqr/M6Rw5AUVu09do21YRBGhWR1csX2rPwlD/wB0Nh1ywGCl4k9jYPsF/6Iz8Dg4cqIFfOU4W8dlvdftEoq8t94r9C7Kyi9ANtUWLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752028542; c=relaxed/simple;
	bh=TdkwTNIzAwUJoAPXjj02yqITZherri+LDBhfwYcnBn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N5uWEkXf64CkQvhmZZ8ivQL6T8VsmpbgyJ/NqNAqjoh89kmT2atPdro7Mqir7xNquYnpGa8W9EPZ8aEtdGIWBqTROed5gJThJ4L+30rJgmNATy+goTM8v3q4ZO7bvb8E9YAWS5GncTPya5saEl+XJd/2WZwRAshEp39F71DXfvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NKy61/ff; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568JNqVu032668
	for <linux-wireless@vger.kernel.org>; Wed, 9 Jul 2025 02:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c/HxZsbEcLj6/NqQ7QRrp90LaiZ00WBbmS7LhVxRCbo=; b=NKy61/ffodXz8EMY
	vqgJm0nwXS44TdphYdA2zc+x12LwpfbBn3UsMVnMESocqYjb6QuwPLHIR5LCJ35J
	YYZTbPlHkTc6HeMKsj6g67Bw2NiJx131Ene7UOIHPLdv8fAHMcAe9kf0FxrHGz7y
	UWAIL8NSylflfZ0JXf+7uJ76Xom9A/YdMsoYAxyKJ81VJQZ1scyO1i1Ot4L+o2VQ
	glCvW57m7T2wRXaZrxm3AxY/iaR1XCo6X0vaJpECMWlztMYhf7tb116K50PCVGAt
	BW5MYPlHWSdE9rKPINmsUU3EBfEGhNblQ0ACPUbKi4YNngFe503Cru6wMbP2TXVI
	CSgzUQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psrktdhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 09 Jul 2025 02:35:33 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3132c8437ffso7020304a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 19:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752028533; x=1752633333;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/HxZsbEcLj6/NqQ7QRrp90LaiZ00WBbmS7LhVxRCbo=;
        b=kNKrRSEPuVuk+giudpsV31Mn74UWPzlh9u9ZDEpmmki92ePF6VtSPyNSckBIC7+7vX
         kglOnrHHyUx72dZ2/7aAoSQtGZmjgKaq5K68TToo6fNl83lpeyZrk7WGD3ojSjGhXv1h
         AQ/Pp0lY68GAlt+sSUe4Eh7iFMh770Pas8bSMXe6kT12KTuXwSIlQtKQUeNBrnChMKpk
         NOukaLfVCbwZfgE3OMNv3UfkNrxH5q/4VekEVoNSU46Ii6P7lQyfvN/mTuaNdLQwN7fL
         gUKtKeeOdS3WwjT14I52gA+w7CkANHfSmkWYBApyOhtHDcbcwBtiTYqARdeAyzLSZmVv
         Imrg==
X-Gm-Message-State: AOJu0Yxj49a6hLX/WN1slRfx4MEU3bQXnmO2y3TANiSsb2nebUw66WY6
	93JvLV/zsuQnou8ztkZ/x5PfBI90bJaUtH/t+W7QtdWo/BnJpcQoFL7H6rnzHLQ1MMrdES7/5+5
	4Y4RQeEYm2rEIQgmSBWtdOvzhMOc7SsKtHOJfLiQ4Aou74A6OPc6tW7853ZU+svf6xsncNQ==
X-Gm-Gg: ASbGncvI/u0LbieG2SWn5LijOCw3rW7/1VefH6JHy6YCv3rEIl1aiQxnDvAyJlomKKe
	V9yAWxu8IDiGtNZeOn1oBobWZvKeb0Zx+UK4el/JWjoZLrVsML+4NTw+fzWyDzPxJE7n7K8w/cc
	0HA5oBdMUmVo95ryRulOc7P2IlhtVMAp9TRcTYGbNj7YXkgNj6CqalnkYU4SLMt3cG2LcOvEkRN
	rgc3HThrPwBqNQW8DZoJk1AwpxBG4JndnTXS/KlOWOl6+StYDkqDyopuyiIRSfNcTBBzFG6Hv0b
	yjdUaaAZ0QnJHiqiuqgypS4l62hYvJX0ZqKvyPvV1pH1xd/1b0A5onrTD8mhAj4QI+mSBDfNuVL
	XNdCO1JJDc7HOQF3PgBMrhUIAE/XWtxb41M5NYiBjCoFKjkU=
X-Received: by 2002:a17:90b:3ec3:b0:311:e5b2:356b with SMTP id 98e67ed59e1d1-31c2fce1e72mr1527312a91.11.1752028532741;
        Tue, 08 Jul 2025 19:35:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF099tninrRE01bhqR4B5YPR57K8M4RtHfAmPQGM2zE5xavw2PxyYuLVylNvUkSK44dy67aHg==
X-Received: by 2002:a17:90b:3ec3:b0:311:e5b2:356b with SMTP id 98e67ed59e1d1-31c2fce1e72mr1527275a91.11.1752028532290;
        Tue, 08 Jul 2025 19:35:32 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431ef2bsm133169315ad.33.2025.07.08.19.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 19:35:32 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Wed, 09 Jul 2025 08:05:19 +0530
Subject: [PATCH wireless-next 2/2] wifi: mac80211: parse unsolicited
 broadcast probe response data
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-update_unsol_bcast_probe_resp-v1-2-d3323ce9a7b5@oss.qualcomm.com>
References: <20250709-update_unsol_bcast_probe_resp-v1-0-d3323ce9a7b5@oss.qualcomm.com>
In-Reply-To: <20250709-update_unsol_bcast_probe_resp-v1-0-d3323ce9a7b5@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuvarani V <quic_yuvarani@quicinc.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: ATraqDoi2EQ1DNhf3W4P0UdnAYPokob5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDAyMyBTYWx0ZWRfX0ZxNEpyUCMDy
 mXWmvLcMX0H5XpYeqv7CN6RowOg4MvxyF2G4raYUQSCixKbTRZNDhqpPkB5HkpJD4IEGL5V+G5W
 K0UiMFWXnQT3drpRWNU0kWTEcbtuP6Dms7UIk9dK7ospox6q1dh7GvuHcRYGJdnBxvqJrLOIaAS
 kS0SrwofFMnV1kE3UDx++k3MBf0I+W0Id1+L3nxgjUasKwBJKQlli441crCqtsQE1Nx6GIJMxg+
 93H8WqtiduuFQ/68slsA041srqKbX4U4fm0OC8b61uMjGQxEbj2vDWO8ACkcrHcOzgXSsayBqsT
 wdlwYOm1KkaMbHX9eEiDsZEspkow7gDS7WSQg7Z3zQxAFdTugshI519W3yGIpfpnWL922iYGLL8
 rSU5IJttel6DP2GZiUE3Z4V/t5QanTBOf4vKBotvOfIfJ/MUvFSdRjSo2IVdIG2Vi+rO+jTk
X-Proofpoint-GUID: ATraqDoi2EQ1DNhf3W4P0UdnAYPokob5
X-Authority-Analysis: v=2.4 cv=GtBC+l1C c=1 sm=1 tr=0 ts=686dd575 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=GDPEl8sVpxXbRvpnLXsA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_01,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507090023

From: Yuvarani V <quic_yuvarani@quicinc.com>

During commands like channel switch and color change, the updated
unsolicited broadcast probe response template may be provided. However,
this data is not parsed or acted upon in mac80211.

Add support to parse it and set the BSS changed flag
BSS_CHANGED_UNSOL_BCAST_PROBE_RESP so that drivers could take further
action.

Signed-off-by: Yuvarani V <quic_yuvarani@quicinc.com>
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 net/mac80211/cfg.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 56540c3701ed786c37f946f9c4af820c15b5922d..cdecda1bd07b31cb7d8bd76eed074ecc2a828eb1 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4173,6 +4173,12 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 	}
 
+	err = ieee80211_set_unsol_bcast_probe_resp(sdata,
+						   &params->unsol_bcast_probe_resp,
+						   link_data, link_conf, &changed);
+	if (err)
+		goto out;
+
 	chanctx = container_of(conf, struct ieee80211_chanctx, conf);
 
 	ch_switch.timestamp = 0;
@@ -5114,6 +5120,12 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 	}
 
+	err = ieee80211_set_unsol_bcast_probe_resp(sdata,
+						   &params->unsol_bcast_probe_resp,
+						   link, link_conf, &changed);
+	if (err)
+		goto out;
+
 	err = ieee80211_set_color_change_beacon(link, params, &changed);
 	if (err)
 		goto out;

-- 
2.34.1


