Return-Path: <linux-wireless+bounces-28206-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 389E2C03F22
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 02:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 582233B34B4
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 00:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A18678F51;
	Fri, 24 Oct 2025 00:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MyL6RLHb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756E72E63C
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 00:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761265180; cv=none; b=FHtZjwwnwc1DqctERXCwQz/eoxw4i2m29jsnAJxuEkQ9RXavNifaKGR/x5xC9LxaOM5dDkTJFJppT5QcR8/b1inAhGFxef9RdmieYGI6Z4OqD8dR6/d+DpH1y7ty/hUQeRXqLaf6nHNTgSeL2U5MCdnFf6HJ2RSLS9rTCNFlX3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761265180; c=relaxed/simple;
	bh=Q81miY0OYp/c/8w55AqN+duj4mxjQf3i70dcTCfgfBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DZdVPbXM362uzlQNAHDr+TsPim5xWFwwFMCM4oqfrcHFKr4hmzD9GXsy0D6+zBlPq1M/6RcElrIychufJEoJv7MW9/V60x4tTzoVIHCNTKAzjY2/2pupZEso1hBx1udwyaBvAHqTWYGhNSUX501iBxAI/Gw9vNaO4/Zc9ndcBYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MyL6RLHb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NF53XW022452
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 00:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=cimsIyyYXBm
	nXwZwQUw2yhM/mZ0nyhp+xX2NvUPnJN0=; b=MyL6RLHbW/ya9CPnxX2TH2NgpY/
	rpE5nWb+DXUd2qBBSEXxfw+Pznjg1gwwH0QMq8HNrCXccJG8L+u6PPvvHd22CuAk
	urJORCfg4+4jdcoeq9hewT1RL2jyl5Gg3HZsgXbsGXM4M3zlVWQDN7lunILMsgnB
	ATPM/7l+uQwmTlW/dBdqqZsJQve1YI0FUtj7hqaGN71tDhHBppWKmIn6ZWmjul/F
	FjdsHaSKkvYXF/kBizDTb1L+CsCDzowqO40IUjPx23MNIWlWaILwlaTXlHkUf91s
	dahQGGwZaQHkqjC82rzIEfLg/v+VI7u0tpN+6my5cGvmF6rbBm4akAYkwnA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v1w8a9a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 24 Oct 2025 00:19:37 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6cdfcb112bso2686534a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 23 Oct 2025 17:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761265176; x=1761869976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cimsIyyYXBmnXwZwQUw2yhM/mZ0nyhp+xX2NvUPnJN0=;
        b=ZWLms99db7tHXAaMRr5+4eDtvzltEJw+aVQkqx1lL5uY2eW/FsP/3mvJXMkTxRkZvd
         6/w7q1qFZi+s01+BKuVGaLNIsma9ONwL0xoPa1OQzRA+jHy044wGOqVQKQVIasTJu9E7
         +fTfKqgeTXSkZDDNkCTKXwndliCpLAlL3WkVWpLIxd/nH86MPzYMwI260JCL2C3RKyAN
         Xu6BQRPAAczWniQT5IdbSdQL2gTh/VX5SfJ7C5eDielAghLzJ0y5Twb43bpI9oyR175E
         82LX4IawPje8UpjXBWhXItCtIE/vo5lhf6Vd1NUVtMxUz+NoI5EOKP3peOxPOLWz9ei7
         XTNw==
X-Gm-Message-State: AOJu0YxKlstvbEr43FxHh9zysOrJPD+Y5BzmhCeXXHA72C4WbnFKRdCw
	1GZ6NjFxMh6g/Nq/YYwBS/xeWyxitgtxLHXZBBzrC0vPzu8I+juuS5bPRAP/0UJNoTHaunH+hZe
	xmO8P/Um7pTkbVU7TO9usmmrRjjMj0rL0Y9wfdxP0lcSlEsM9KT5Ya6hCE44K9wd9iJE9g4HcWY
	niPA==
X-Gm-Gg: ASbGncsEPFy5A2lIApw6te6e7VixXMxD9LlkcI9PuY2TwM65hq61B/D+kIMzGXzKkvH
	5W2tAvxXgumXSJrqpT4ctb5gmTq8yyOlRHVDzT1O+8QKN/QAAlwkhTeAZHtsXvYr2hQXRGJHPZY
	NiU41IkDEXvICb2G2Mn7ZGT/MZB2C9K/Eg6wBzYegAEGebMSl6S4W0PnzJX8dbdRlK9zB7VYjOo
	BSymkPCjwmyIu6S2epOKMnypk7Mf7+cub1Ggn54BlgpEv9FbQ+TrxZ3Vz/gO125d/GXhMqE7ixd
	26CLbV02pUwfbukNTznPbq5HaApP5hsvNh4UsBNn1y/BSvBqF1/yv+OChhMAx79wZNNHuYtO2oa
	UGACWcXqBqDWT5ZSM5GxnBrFx8B9NBtYvV5wA1VIIOmkHUsLrOCiZyFo=
X-Received: by 2002:a05:6a21:3397:b0:33d:7c46:c4ed with SMTP id adf61e73a8af0-33d7c46c5bemr2159433637.53.1761265175538;
        Thu, 23 Oct 2025 17:19:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmXxr/9MA2sTRhVUBKY7trMwmIeVyL70IQbWUGvwfl3KeT2SpD/BHggDjAMI06M8uizDfeVg==
X-Received: by 2002:a05:6a21:3397:b0:33d:7c46:c4ed with SMTP id adf61e73a8af0-33d7c46c5bemr2159404637.53.1761265175021;
        Thu, 23 Oct 2025 17:19:35 -0700 (PDT)
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4bb65b3sm3296264a12.8.2025.10.23.17.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 17:19:34 -0700 (PDT)
From: Muna Sinada <muna.sinada@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Muna Sinada <muna.sinada@oss.qualcomm.com>
Subject: [PATCH ath-next 1/6] wifi: ath12k: generalize GI and LTF fixed rate functions
Date: Thu, 23 Oct 2025 17:19:23 -0700
Message-Id: <20251024001928.257356-2-muna.sinada@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251024001928.257356-1-muna.sinada@oss.qualcomm.com>
References: <20251024001928.257356-1-muna.sinada@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxNSBTYWx0ZWRfX6uy8y7ifQmom
 Oz2iMMxDl5UQxSPo/QXOG2zN0MeGrLn9c1J7PGG0ogLHN2h6c6fwttGv/ww6J0J+CssmDpRSSOr
 ewK4HdksLy6mmnS3s+X0rAkggog/6NkxEwa9Z8Vih06ONOPIMFZfW/aZk4Vwfl3WfGT9jqJlclP
 Ehx3nVTx5rJ3hSYZb6OzSvXv83RVNp2UQTb4s5ZmQ23vTkapfSBS1g0osodm67oCkUxytDyCg1C
 UIiK+kBXT8mXBpyK9bqnZkLXZoLpaU1EVEJfpYjDXMURIgpPnIa4SOYzFiMp5iIzgraRhFF2KbI
 eBUQ7FqEZmWGvv272pNXrZg0pbqmgBGrKmvF1TXZkfRj9DapUKY58AXn9J81BtE68/MIDh3L8ct
 Z3cxqFFRxw7hAYmnHBRa8k0UF1BckA==
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=68fac619 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=X7-uiFLsf3CQ3n4UTk4A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: Nxoz5BG22cXNNqvVij6w9xrKQIqqVB-E
X-Proofpoint-ORIG-GUID: Nxoz5BG22cXNNqvVij6w9xrKQIqqVB-E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180015

Currently, functions in mac.c for setting GI and LTF rates are
specifically for HE rates.

Remove any mention of "HE" in such functions in order to allow for
other modes to utilize the functions. The intention is to prepare for
the addition of EHT GI and LTF fixed rate settings.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 77 ++++++++++++++-------------
 drivers/net/wireless/ath/ath12k/mac.h | 14 ++++-
 drivers/net/wireless/ath/ath12k/wmi.h | 12 ++---
 3 files changed, 60 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index d7bc19cea2a6..fd49a0953470 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -12043,55 +12043,57 @@ ath12k_mac_get_single_legacy_rate(struct ath12k *ar,
 }
 
 static int
-ath12k_mac_set_fixed_rate_gi_ltf(struct ath12k_link_vif *arvif, u8 he_gi, u8 he_ltf)
+ath12k_mac_set_fixed_rate_gi_ltf(struct ath12k_link_vif *arvif, u8 gi, u8 ltf)
 {
 	struct ath12k *ar = arvif->ar;
-	int ret;
+	int param, ret;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
 	/* 0.8 = 0, 1.6 = 2 and 3.2 = 3. */
-	if (he_gi && he_gi != 0xFF)
-		he_gi += 1;
+	if (gi && gi != 0xFF)
+		gi += 1;
 
 	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
-					    WMI_VDEV_PARAM_SGI, he_gi);
+					    WMI_VDEV_PARAM_SGI, gi);
 	if (ret) {
-		ath12k_warn(ar->ab, "failed to set HE GI:%d, error:%d\n",
-			    he_gi, ret);
+		ath12k_warn(ar->ab, "failed to set GI:%d, error:%d\n",
+			    gi, ret);
 		return ret;
 	}
 	/* start from 1 */
-	if (he_ltf != 0xFF)
-		he_ltf += 1;
+	if (ltf != 0xFF)
+		ltf += 1;
+
+	param = WMI_VDEV_PARAM_HE_LTF;
 
 	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
-					    WMI_VDEV_PARAM_HE_LTF, he_ltf);
+					    param, ltf);
 	if (ret) {
-		ath12k_warn(ar->ab, "failed to set HE LTF:%d, error:%d\n",
-			    he_ltf, ret);
+		ath12k_warn(ar->ab, "failed to set LTF:%d, error:%d\n",
+			    ltf, ret);
 		return ret;
 	}
 	return 0;
 }
 
 static int
-ath12k_mac_set_auto_rate_gi_ltf(struct ath12k_link_vif *arvif, u16 he_gi, u8 he_ltf)
+ath12k_mac_set_auto_rate_gi_ltf(struct ath12k_link_vif *arvif, u16 gi, u8 ltf)
 {
 	struct ath12k *ar = arvif->ar;
 	int ret;
-	u32 he_ar_gi_ltf;
+	u32 ar_gi_ltf;
 
-	if (he_gi != 0xFF) {
-		switch (he_gi) {
-		case NL80211_RATE_INFO_HE_GI_0_8:
-			he_gi = WMI_AUTORATE_800NS_GI;
+	if (gi != 0xFF) {
+		switch (gi) {
+		case ATH12K_RATE_INFO_GI_0_8:
+			gi = WMI_AUTORATE_800NS_GI;
 			break;
-		case NL80211_RATE_INFO_HE_GI_1_6:
-			he_gi = WMI_AUTORATE_1600NS_GI;
+		case ATH12K_RATE_INFO_GI_1_6:
+			gi = WMI_AUTORATE_1600NS_GI;
 			break;
-		case NL80211_RATE_INFO_HE_GI_3_2:
-			he_gi = WMI_AUTORATE_3200NS_GI;
+		case ATH12K_RATE_INFO_GI_3_2:
+			gi = WMI_AUTORATE_3200NS_GI;
 			break;
 		default:
 			ath12k_warn(ar->ab, "Invalid GI\n");
@@ -12099,16 +12101,16 @@ ath12k_mac_set_auto_rate_gi_ltf(struct ath12k_link_vif *arvif, u16 he_gi, u8 he_
 		}
 	}
 
-	if (he_ltf != 0xFF) {
-		switch (he_ltf) {
-		case NL80211_RATE_INFO_HE_1XLTF:
-			he_ltf = WMI_HE_AUTORATE_LTF_1X;
+	if (ltf != 0xFF) {
+		switch (ltf) {
+		case ATH12K_RATE_INFO_1XLTF:
+			ltf = WMI_AUTORATE_LTF_1X;
 			break;
-		case NL80211_RATE_INFO_HE_2XLTF:
-			he_ltf = WMI_HE_AUTORATE_LTF_2X;
+		case ATH12K_RATE_INFO_2XLTF:
+			ltf = WMI_AUTORATE_LTF_2X;
 			break;
-		case NL80211_RATE_INFO_HE_4XLTF:
-			he_ltf = WMI_HE_AUTORATE_LTF_4X;
+		case ATH12K_RATE_INFO_4XLTF:
+			ltf = WMI_AUTORATE_LTF_4X;
 			break;
 		default:
 			ath12k_warn(ar->ab, "Invalid LTF\n");
@@ -12116,15 +12118,15 @@ ath12k_mac_set_auto_rate_gi_ltf(struct ath12k_link_vif *arvif, u16 he_gi, u8 he_
 		}
 	}
 
-	he_ar_gi_ltf = he_gi | he_ltf;
+	ar_gi_ltf = gi | ltf;
 
 	ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
 					    WMI_VDEV_PARAM_AUTORATE_MISC_CFG,
-					    he_ar_gi_ltf);
+					    ar_gi_ltf);
 	if (ret) {
 		ath12k_warn(ar->ab,
-			    "failed to set HE autorate GI:%u, LTF:%u params, error:%d\n",
-			    he_gi, he_ltf, ret);
+			    "failed to set autorate GI:%u, LTF:%u params, error:%d\n",
+			    gi, ltf, ret);
 		return ret;
 	}
 
@@ -12149,10 +12151,10 @@ static int ath12k_mac_set_rate_params(struct ath12k_link_vif *arvif,
 {
 	struct ieee80211_bss_conf *link_conf;
 	struct ath12k *ar = arvif->ar;
+	bool he_support, gi_ltf_set = false;
 	u32 vdev_param;
 	u32 param_value;
 	int ret;
-	bool he_support;
 
 	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
 
@@ -12206,7 +12208,10 @@ static int ath12k_mac_set_rate_params(struct ath12k_link_vif *arvif,
 			ret = ath12k_mac_set_auto_rate_gi_ltf(arvif, he_gi, he_ltf);
 		if (ret)
 			return ret;
-	} else {
+		gi_ltf_set = true;
+	}
+
+	if (!gi_ltf_set) {
 		vdev_param = WMI_VDEV_PARAM_SGI;
 		param_value = ath12k_mac_nlgi_to_wmigi(sgi);
 		ret = ath12k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index c05af40bd7a2..1f689e367c8a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_MAC_H
@@ -84,6 +84,18 @@ enum ath12k_supported_bw {
 	ATH12K_BW_320   = 4,
 };
 
+enum ath12k_gi {
+	ATH12K_RATE_INFO_GI_0_8,
+	ATH12K_RATE_INFO_GI_1_6,
+	ATH12K_RATE_INFO_GI_3_2,
+};
+
+enum ath12k_ltf {
+	ATH12K_RATE_INFO_1XLTF,
+	ATH12K_RATE_INFO_2XLTF,
+	ATH12K_RATE_INFO_4XLTF,
+};
+
 struct ath12k_mac_get_any_chanctx_conf_arg {
 	struct ath12k *ar;
 	struct ieee80211_chanctx_conf *chanctx_conf;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 64bd968989c8..01b2a865f103 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -223,15 +223,15 @@ enum WMI_HOST_WLAN_BAND {
 };
 
 /* Parameters used for WMI_VDEV_PARAM_AUTORATE_MISC_CFG command.
- * Used only for HE auto rate mode.
+ * Used for HE and EHT auto rate mode.
  */
 enum {
-	/* HE LTF related configuration */
-	WMI_HE_AUTORATE_LTF_1X = BIT(0),
-	WMI_HE_AUTORATE_LTF_2X = BIT(1),
-	WMI_HE_AUTORATE_LTF_4X = BIT(2),
+	/* LTF related configuration */
+	WMI_AUTORATE_LTF_1X = BIT(0),
+	WMI_AUTORATE_LTF_2X = BIT(1),
+	WMI_AUTORATE_LTF_4X = BIT(2),
 
-	/* HE GI related configuration */
+	/* GI related configuration */
 	WMI_AUTORATE_400NS_GI = BIT(8),
 	WMI_AUTORATE_800NS_GI = BIT(9),
 	WMI_AUTORATE_1600NS_GI = BIT(10),
-- 
2.34.1


