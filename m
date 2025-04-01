Return-Path: <linux-wireless+bounces-21013-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6B8A77296
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 04:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1107E188E3A3
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 02:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5243B19007D;
	Tue,  1 Apr 2025 02:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZUZo40Ww"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B620417B4FF
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 02:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743473352; cv=none; b=cDOMErIfwtdw1Uvnf0PzW/a25bAmIZWyfSmq3OpAFawksQIEcx+Ye2QHixsXiNxjuFrhtfmXReZ6RFpWvv7N/mhhtP8TcwTPBPysUilQGkUoc82SUKtaX8kk95AMSx+zO30hG6XonEPnjAdXeK5DITi5iut3FjjkDia/rpIaB48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743473352; c=relaxed/simple;
	bh=nPuIuoDOVq3JE4e1leBipGoztQpxWogHkVcTnY3BKJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j8t+lEOvvdbrdiMHZIx3SkocmPU8PS/yuGDRsosdO413fSAcNUPW5+UbO3rupOTkYnXMNZ0HVcBI5TVQ29zSRwjpgpIBaK/nX5eiCxmqSj0PVowaOaWuQtqemX5BmLB/dxvIgzRUg+z+rve7kdTMcbKWocSp12DDG++04svrLg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZUZo40Ww; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VFD4ef003372;
	Tue, 1 Apr 2025 02:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QnKSgbAGspQgqnt05z5DB2B1BUpqnnKK13HOHSA8E+Q=; b=ZUZo40Ww9paZoITA
	GmS9iHDarqSiL1WKJ8wYJC9O1d673Dio4OlmB/d+ZJHxLbDkwYcNiH8lj3LYDNBd
	Dm2+zpmguOHxizFRzSZOPCT+dVXLjOB7Dpq9k5h3n2WylN4dv3oJSESITRo/sYYA
	OKxZqNTE1ytmiyD/RrK604VhlPUV6EL8eoOmjn80USCqGIkFdRY4fEPjbG5gy1RV
	SdS/Zn+/c06UeXl5/SRasSewieyFa9cZB70C6p2JwtnoUKzXnQ5VRfIZCLNvjLEq
	lPlTw7m2RbBhxYOt1fIrm4jSvYGL7FIRPDfHbBaM5xInrNttDL6ig5+PhFIpOjMN
	X2FIWw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45pa5bp2kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 02:09:07 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53129680014628
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Apr 2025 02:09:06 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 31 Mar 2025 19:09:05 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>, <quic_kangyang@quicinc.com>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH ath-next v15 2/4] wifi: ath12k: use correct WMI command to set country code for WCN7850
Date: Tue, 1 Apr 2025 10:08:38 +0800
Message-ID: <20250401020840.357-3-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20250401020840.357-1-quic_kangyang@quicinc.com>
References: <20250401020840.357-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: HSevOrCJNRrCzTgZ_W3w7PTJVCc-VpJ_
X-Authority-Analysis: v=2.4 cv=YqcPR5YX c=1 sm=1 tr=0 ts=67eb4ac3 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=a7P9Qv-cGzJDulBvf4UA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: HSevOrCJNRrCzTgZ_W3w7PTJVCc-VpJ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_01,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=977 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504010013

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
index 0ba6aedc8405..a041697f6b1a 100644
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


