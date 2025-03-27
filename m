Return-Path: <linux-wireless+bounces-20880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A75ECA7289A
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 03:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB8977A56DF
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Mar 2025 02:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0931805B;
	Thu, 27 Mar 2025 02:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R2VD2iew"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBAF40849
	for <linux-wireless@vger.kernel.org>; Thu, 27 Mar 2025 02:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743041164; cv=none; b=J3612ehns9dwy+DiKG2F4/ghtqR24GQYCkpMmtOHgLMz7cC92rC9c7/vPxS5ZevvMIVeo0dJ/jaxEr8z9EGzqvi8moQEjQd+kh6vGMuizkAXPoM+09kLFmZ8aQP/vVzlPsFazFLt8uG9bq2FA2+w3maBwidFcbuMjI+hA77INxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743041164; c=relaxed/simple;
	bh=6xS1FeeGeeQKh6+VXwDE/2O2VEAQDNeIfPrCA+0oqBQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UiG1L1syBj2wfxVKn//mFsA20OO3yy8hypwolkTgQjz7iA0iBu4cAegyKopNwli2IUuFaIubSX8Zb3KShsfls/9aVgYBZglPvZ28nUfiCqYoiQIUz0KOPKeMfSorLgTKppNHmqn3KoFoj8O9Qu0UDM4/HZQMCH0FvRjLv+lzeRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R2VD2iew; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QG9WC2011684;
	Thu, 27 Mar 2025 02:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c34QASMpTbB54/1wwwNAH6D2Xtqx9Lg//+MGcYSGP9s=; b=R2VD2iewU05rhW4G
	ldjGjRXpYx/HBj357Jr+6hPYNZtU9sTiD80qcpucv++4GyYtT+3FCF5iH740yq7n
	n4F6jkUaHxQfHPzFjQjxR+aPZ9g/39hTWxtnbotGNmFonvE+Y0eikR1OSnuvPoeO
	RayQujaOiqbO3Eb9i3lvyV8+0XjddJA0kUMImTFzjGJwsbjLKV0EjiuPeR5EamZg
	fiJXcqEP8OO15B/ywnO5Fu+s0KICg+ytTbUFUHzQB4MOYk8F8IsWxKYacNMCvOBb
	AX/BiF9b14iU0n+RuNtmGzfMTmZ0qV0i27GSCoK1ldu257LP68GINfemm7gYbAGc
	J0dzJg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45mmuthc6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 02:06:01 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52R260EQ007310
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 02:06:00 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Mar 2025 19:05:59 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>, <quic_kangyang@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath-next v14 2/4] wifi: ath12k: use correct WMI command to set country code for WCN7850
Date: Thu, 27 Mar 2025 10:05:25 +0800
Message-ID: <20250327020527.1527-3-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20250327020527.1527-1-quic_kangyang@quicinc.com>
References: <20250327020527.1527-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rIyUvanM_vY7SnU9aHzlDkSGvCUH0thJ
X-Authority-Analysis: v=2.4 cv=MqlS63ae c=1 sm=1 tr=0 ts=67e4b289 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=a7P9Qv-cGzJDulBvf4UA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: rIyUvanM_vY7SnU9aHzlDkSGvCUH0thJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxlogscore=987 mlxscore=0 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270013

From: Wen Gong <quic_wgong@quicinc.com>

When userspace tries to set country code by NL80211_REGDOM_SET_BY_USER
hint(like iw reg set XX), it will pass new country code to ath12k.
Then ath12k will set this new country code to firmware by
WMI_SET_INIT_COUNTRY_CMDID.

For AP based chips(QCN92xx), WMI_SET_INIT_COUNTRY_CMDID is the correct
command. However, for STATION based chips(WCN7850), it need to use
WMI_SET_CURRENT_COUNTRY_CMDID.

Add flag current_cc_support in hardware parameters. It is used to
distinguish AP/STA platform. After that, the firmware will work
normally and the regulatory feature works well for WCN7850.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/hw.c  |  6 ++++++
 drivers/net/wireless/ath/ath12k/hw.h  |  1 +
 drivers/net/wireless/ath/ath12k/reg.c | 29 ++++++++++++++++-----------
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index b4d5651973b7..98da5ab16366 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1323,6 +1323,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.ce_ie_addr = NULL,
 		.ce_remap = NULL,
 		.bdf_addr_offset = 0,
+
+		.current_cc_support = false,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -1408,6 +1410,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.ce_ie_addr = NULL,
 		.ce_remap = NULL,
 		.bdf_addr_offset = 0,
+
+		.current_cc_support = true,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1489,6 +1493,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.ce_ie_addr = NULL,
 		.ce_remap = NULL,
 		.bdf_addr_offset = 0,
+
+		.current_cc_support = false,
 	},
 	{
 		.name = "ipq5332 hw1.0",
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index d4a2e47169d9..774679f33406 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -198,6 +198,7 @@ struct ath12k_hw_params {
 	bool reoq_lut_support:1;
 	bool supports_shadow_regs:1;
 	bool supports_aspm:1;
+	bool current_cc_support:1;
 
 	u32 num_tcl_banks;
 	u32 max_tx_ring;
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 439d61f284d8..1904f7b44ee8 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -48,6 +48,7 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 {
 	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
 	struct ath12k_wmi_init_country_arg arg;
+	struct wmi_set_current_country_arg current_arg = {};
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
 	int ret, i;
@@ -77,23 +78,27 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 		return;
 	}
 
-	/* Set the country code to the firmware and wait for
-	 * the WMI_REG_CHAN_LIST_CC EVENT for updating the
-	 * reg info
-	 */
-	arg.flags = ALPHA_IS_SET;
-	memcpy(&arg.cc_info.alpha2, request->alpha2, 2);
-	arg.cc_info.alpha2[2] = 0;
-
 	/* Allow fresh updates to wiphy regd */
 	ah->regd_updated = false;
 
 	/* Send the reg change request to all the radios */
 	for_each_ar(ah, ar, i) {
-		ret = ath12k_wmi_send_init_country_cmd(ar, &arg);
-		if (ret)
-			ath12k_warn(ar->ab,
-				    "INIT Country code set to fw failed : %d\n", ret);
+		if (ar->ab->hw_params->current_cc_support) {
+			memcpy(&current_arg.alpha2, request->alpha2, 2);
+			ret = ath12k_wmi_send_set_current_country_cmd(ar, &current_arg);
+			if (ret)
+				ath12k_warn(ar->ab,
+					    "failed set current country code: %d\n", ret);
+		} else {
+			arg.flags = ALPHA_IS_SET;
+			memcpy(&arg.cc_info.alpha2, request->alpha2, 2);
+			arg.cc_info.alpha2[2] = 0;
+
+			ret = ath12k_wmi_send_init_country_cmd(ar, &arg);
+			if (ret)
+				ath12k_warn(ar->ab,
+					    "failed set INIT Country code: %d\n", ret);
+		}
 	}
 }
 
-- 
2.34.1


