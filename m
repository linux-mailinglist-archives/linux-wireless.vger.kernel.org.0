Return-Path: <linux-wireless+bounces-28000-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF20BE60EE
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 03:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E335F19A16EF
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 01:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0B322B5AD;
	Fri, 17 Oct 2025 01:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JZL4V6P+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A80F1758B
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 01:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760665764; cv=none; b=Y0hYEdoJSh68FaBO+Gf0rRUet2ku72GbVFFDS88gKwZyQCI/Sgxs2JbzBW6q1ZnT3hs+NAIkcT7F5Bm/b4aYiVBSDv2HBBpCxrlNQgdU+igbyvTDyR8rn/IkM5nfz+L64/F2VdPmcJ4K9m8yziOYu5WuqeFEalLjUbu0PhWwl1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760665764; c=relaxed/simple;
	bh=pfUXRD75jYSTpcxomAOJa4jQXcNlKPvh2/Mqi2gRp3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uuMS+3qH7cjE9rGURpoLvSX3SHp3pGHJ46J1kwD4BR+ultCtlDPX4xqKiyQ/z4ffiMqU7dCpxEZRdjHBWm4SGuXEx9lutMNN1srG2X16It85QY5Uob4Z15qgVP+X8pb9VIFSbrZpVRyBdz4NR+bWoL1qq+0W4OhuFpQ6FjYrFY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JZL4V6P+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLNu4008872
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 01:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/XYpuQ1JyyKMbADlZznx3xZ+aiP62NyD/ZiYuDoLwtI=; b=JZL4V6P+71iR2ups
	tjyL3CUCinCOCBDv6uchptYcWQo+XB3Rf9DlFYSkp6lsvGBYLMIahz5gtpArrXQ4
	51Nep1IzQZ6yBxbacRGNY9KaFd23mMlmV3nyGKZI1hb1YZTHs9zgK5SjVabOoroN
	oJSWp+ZHfph+RwPSTdLXpRiyBPpOMEbbhazHnDf5JkCfGV3nZW0KAdwSddKNhFTU
	nGvIrKaB0nqFk35uFgH0BsMrJS6KGRmBFy0ofpdyRrovwhfigiCykSXIxjCG4qs4
	Vt5NfMj1umBQ81TuZMFHWv05MYjrSLYhGPEWXNFM2H/rD5Q3XXpXbwhK0Bpmcv5m
	SXtUMA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1appa3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 01:49:20 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b5527f0d39bso2104768a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 16 Oct 2025 18:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760665759; x=1761270559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XYpuQ1JyyKMbADlZznx3xZ+aiP62NyD/ZiYuDoLwtI=;
        b=M2iGmb9Ih5t1HH32jTqFPv7IXaYOBB7Atywi7go/T3pN28A7OAq596VxN+AND3vTCI
         0n9ZVGwd3A8xDpalGmMSDGDHQ+0az7U6Kg3Q2hErjMYPFiwvVxmtO3RgZzYsSwfe+wc0
         ZTnwdLwQeQml4JT8d5U8wYTXGNqucy8YyBwzKSqBITWuHFrDbe8YWYA4JmEVe8D3j0Wf
         SvK1Un52GR43GsgO3Ugi3PyaPPeROeiqXuNVmSZumCg04772mRN/sunc1JKdVvRZOxYu
         we5LBk/tviEB27V0hnWnhUgAU5/eHw2VhDB255T/BHd/tos5jMPeR+eEtFJjHlxb099+
         dLAQ==
X-Gm-Message-State: AOJu0YyD1wop7u89o8GfqPNpdVtVR0K8unErP9ZQQ5xyq60kZdNFja2n
	j2J2UrslFIm4D0Ni7mGXsQOsaGUw38K5Trrc2K0mSkOLqxl1qjftCIemQwox1qAjwK4uSzKsNu8
	fBor9ahiwk1JvyiCCEqt4s16gUdawtmqWAEyrLxx6Op0HF2NwArAnhwp+JBldZcd/Opx6afSxb5
	brEKys
X-Gm-Gg: ASbGncub1H38htnfF0CQjiHKD6aDahrGjxMfjwTqf//ePPGedtFhj6ITIFwvMFLu3YN
	vVHhdN2zRlpnFCkEkaoCcTqqytdlg44DmIYmxAWIfh4qvOsBWxmwzulwrukX9Ge6MpLZyfu1OVV
	RlF1m7C155oKuojCUWrbTcSYngZcDTCYE8TOQ7qAzSPxNs6xL3UiJ4SXhuhrduIEL6N11yIRhU2
	t1Bp5PU0gfaIYD5ngUY3RaKqA8Yx7sUYk+7S6pmbunTXg4OfQpK3MdVBcdk1ovZp23wKC4IqH+d
	VQXwuEIbJFdc6hWbg8tzKvWlTI0QyFzexZHMAuNox4oyEDTA/ImLdHwtu0zBZ4Muq5f33izHQpF
	vmQ+bqbYpJtzT9fOEfFihMja3mRh1DI303d9gAXP0OJ74I63zLCf5
X-Received: by 2002:a05:6a20:72a4:b0:2f9:48ac:c8ed with SMTP id adf61e73a8af0-334a8534251mr2473340637.1.1760665759099;
        Thu, 16 Oct 2025 18:49:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSzREb57ve0N4OIyy8PIY7kbejAbHE5mVGSJSmEG4tBw33N64kIgs+Iph5yhu2Sgh1O4SsVw==
X-Received: by 2002:a05:6a20:72a4:b0:2f9:48ac:c8ed with SMTP id adf61e73a8af0-334a8534251mr2473304637.1.1760665758634;
        Thu, 16 Oct 2025 18:49:18 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a22bbe7a0sm4181475a12.38.2025.10.16.18.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 18:49:18 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 09:48:59 +0800
Subject: [PATCH ath-next 1/2] wifi: ath11k: fix VHT MCS assignment
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-ath11k-mcs-assignment-v1-1-da40825c1783@oss.qualcomm.com>
References: <20251017-ath11k-mcs-assignment-v1-0-da40825c1783@oss.qualcomm.com>
In-Reply-To: <20251017-ath11k-mcs-assignment-v1-0-da40825c1783@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68f1a0a0 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=W8IGfRwF5v3UHo10cv0A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: EP7hU2Dxr6OWexNFpCNDfY38jXgP60hx
X-Proofpoint-ORIG-GUID: EP7hU2Dxr6OWexNFpCNDfY38jXgP60hx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX52F3Ag4I6uEX
 mzLfvFN6ZU3qNZpcIrIHjQNJ/t3cYbRvAEY6RV0PdzpnEd5HoLkCkO4DljGbvMhh/9Wq1hb5Uic
 CN1540edkKZ8N87ZD4qD7KXo9ex7t8kcMpKAodSIZYuRCE68TDeqw3MNH2hB12gIf5ZVGfgXN3g
 smmkPZqzak9a51ORTR9cVNaagYkbdLHm0HwzVwlXQSGxPPKAzW7coY+VFA2xnGs6x3wRXz+LI4S
 FBbvDeaqmPBSm9rjiFbUoF0RqPXlEZXKAZmiuRiJQs2ffm6CNLnChMozL7Ebv4cDriPqd4SDLRD
 OgWA7HDh+tTgnakGBpZB7P1u2iSuDxuWNPWvejPLwoWk3Byy1MelYzWxZhvKIwgxNGvef7mI06j
 jGk/C9zT3fAE3q6mSC1+Oqn6lt1DgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035

While associating, firmware needs to know peer's receive capability to
calculate its own VHT transmit MCS, currently host sends this information
to firmware via mcs->rx_mcs_set field, this is wrong as firmware actually
takes it from mcs->tx_mcs_set field. Till now there is no failure seen
due to this, most likely because almost all peers are advertising the
same capability for both transmit and receive. Swap the assignment to
fix it.

Besides, rate control mask is meant to limit our own transmit MCS, hence
need to go via mcs->tx_mcs_set field. With the aforementioned swapping
done, change is needed as well to apply it to the peer's receive
capability rather than transmit capability.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/mac.c |  4 ++--
 drivers/net/wireless/ath/ath11k/wmi.c | 13 ++++++++-----
 drivers/net/wireless/ath/ath11k/wmi.h |  2 ++
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 0e41b5a91d66da872c2520a95c3d4af379a504da..49c639d73d58d46f869aec40f6439268526ea1bb 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2235,9 +2235,9 @@ static void ath11k_peer_assoc_h_vht(struct ath11k *ar,
 	arg->peer_nss = min(sta->deflink.rx_nss, max_nss);
 	arg->rx_max_rate = __le16_to_cpu(vht_cap->vht_mcs.rx_highest);
 	arg->rx_mcs_set = __le16_to_cpu(vht_cap->vht_mcs.rx_mcs_map);
+	arg->rx_mcs_set = ath11k_peer_assoc_h_vht_limit(arg->rx_mcs_set, vht_mcs_mask);
 	arg->tx_max_rate = __le16_to_cpu(vht_cap->vht_mcs.tx_highest);
-	arg->tx_mcs_set = ath11k_peer_assoc_h_vht_limit(
-		__le16_to_cpu(vht_cap->vht_mcs.tx_mcs_map), vht_mcs_mask);
+	arg->tx_mcs_set = __le16_to_cpu(vht_cap->vht_mcs.tx_mcs_map);
 
 	/* In IPQ8074 platform, VHT mcs rate 10 and 11 is enabled by default.
 	 * VHT mcs rate 10 and 11 is not supported in 11ac standard.
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 0491e3fd6b5e16d464bd3e3c3933b9102641204b..942dfeb8b1af8553d1c872ac1444bfacf11f44cd 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 #include <linux/skbuff.h>
 #include <linux/ctype.h>
@@ -2061,10 +2061,13 @@ int ath11k_wmi_send_peer_assoc_cmd(struct ath11k *ar,
 	cmd->peer_bw_rxnss_override |= param->peer_bw_rxnss_override;
 
 	if (param->vht_capable) {
-		mcs->rx_max_rate = param->rx_max_rate;
-		mcs->rx_mcs_set = param->rx_mcs_set;
-		mcs->tx_max_rate = param->tx_max_rate;
-		mcs->tx_mcs_set = param->tx_mcs_set;
+		/* firmware interprets mcs->tx_mcs_set field as peer's
+		 * RX capability
+		 */
+		mcs->tx_max_rate = param->rx_max_rate;
+		mcs->tx_mcs_set = param->rx_mcs_set;
+		mcs->rx_max_rate = param->tx_max_rate;
+		mcs->rx_mcs_set = param->tx_mcs_set;
 	}
 
 	/* HE Rates */
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 3c4885a12855ba87dd815b44c71d619612596d5e..0f0de24a384089c1d36722a115aa007c042916c2 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4119,8 +4119,10 @@ struct wmi_rate_set {
 struct wmi_vht_rate_set {
 	u32 tlv_header;
 	u32 rx_max_rate;
+	/* MCS at which the peer can transmit */
 	u32 rx_mcs_set;
 	u32 tx_max_rate;
+	/* MCS at which the peer can receive */
 	u32 tx_mcs_set;
 	u32 tx_max_mcs_nss;
 } __packed;

-- 
2.25.1


