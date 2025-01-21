Return-Path: <linux-wireless+bounces-17781-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEB5A17A07
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 10:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E12167EC0
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 09:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D971C07E2;
	Tue, 21 Jan 2025 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WJXjJ1/n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C771BF7E8
	for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737451160; cv=none; b=CrLLWhNBd+LLnGSV6UyPK33KtGxtd17YgORl2xcGBfyi3Il0owCuwREXonrDVae8HgDjWx75zczW+ui1J6im6e5VbZn3CRNvaFPLnNCK8PgHHGol4Uf59NQudK+5vr2N4H+9NIawKkusLjRDyJM9Ky7F62moevG5xtq17KzaiJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737451160; c=relaxed/simple;
	bh=3vCxESQE5Cq2A8xt7Qh6LPOAKLIYSEAADsV8+CpOoUA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3HRpHyx9eli6MD2f1Lo8wwUFYnbCq4cNM8C65TxWPSmPfLbKqpClMExc4oCT3QPYONZ4c96cniFjtJdDM0dBrLsJn2rcD5O7Ja/r6bE7bl56Z4uVSF8tSWj2ytj3aE0adH42uEOD0m4EJnCIu/3ok9rtaPfprgRfyNb7vaVx1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WJXjJ1/n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50L8Yv0R001671;
	Tue, 21 Jan 2025 09:19:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7n+wY55W5+gPQo5ttFtrDZ7JQZFqZ2z68ygZHULIQ28=; b=WJXjJ1/naIUn5BuE
	RtHIvu0i9d26olBlytQZKUkiSRp19YF3Lsadq0ZR4dELL/avzK1pK2MwhdNOcM3W
	ykT8SGBHCEZCAp49nnkDQUPOnuqRWqogn6QmptIOsnUFcc2cssXoUWKecTS0y5UO
	Z8XIuukM330eaWh4uugBX7EBnCRrV0XWOqbwoHRGdKDwD+i/AgKeGSkoqEaOl4w9
	uA6hojRObWAu6xZCCUpxZ6q0dJlqKL+yHQY8MA//YwcJxRHHDZAgG5OZkmMcb2FJ
	S6GsXbUKN8TIzQ3HLRe/sTYEFKitZRTkhWsIyUPxI5i2jbh1y0w1PuyhfdgGbiFd
	oP632g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44a866r5ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 09:19:15 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50L9JE8l026437
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 09:19:14 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 21 Jan 2025 01:19:13 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v8 3/4] wifi: ath12k: use correct WMI command to set country code for WCN7850
Date: Tue, 21 Jan 2025 17:18:43 +0800
Message-ID: <20250121091844.1987-4-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20250121091844.1987-1-quic_kangyang@quicinc.com>
References: <20250121091844.1987-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: S_71uFrGO0Ba_dxCgY2nESnaLs8cKC6r
X-Proofpoint-ORIG-GUID: S_71uFrGO0Ba_dxCgY2nESnaLs8cKC6r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_04,2025-01-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501210076

From: Wen Gong <quic_wgong@quicinc.com>

When userspace try to set country code by NL80211_REGDOM_SET_BY_USER
hint(like iw reg set XX), it will pass new country code to ath12k.
Then ath12k will set this new country code to firmware by
WMI_SET_INIT_COUNTRY_CMDID. But for WCN7850, this WMI command won't
take effect.

For AP based chips(QCN92xx), WMI_SET_INIT_COUNTRY_CMDID is the correct
command. However, for STATION based chips(WCN7850), it need to use
WMI_SET_CURRENT_COUNTRY_CMDID.

Add flag current_cc_support in hardware parameters. It is used to
distinguish AP/STA platform. After that, the firmware will work
normal and the regulatory feature works well for WCN7850.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c  |  6 ++++++
 drivers/net/wireless/ath/ath12k/hw.h  |  1 +
 drivers/net/wireless/ath/ath12k/reg.c | 29 ++++++++++++++++-----------
 3 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index b7b583fadb5a..65c52e3217c5 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -928,6 +928,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.iova_mask = 0,
 
 		.supports_aspm = false,
+
+		.current_cc_support = false,
 	},
 	{
 		.name = "wcn7850 hw2.0",
@@ -1008,6 +1010,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.iova_mask = ATH12K_PCIE_MAX_PAYLOAD_SIZE - 1,
 
 		.supports_aspm = true,
+
+		.current_cc_support = true,
 	},
 	{
 		.name = "qcn9274 hw2.0",
@@ -1084,6 +1088,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.iova_mask = 0,
 
 		.supports_aspm = false,
+
+		.current_cc_support = false,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath12k/hw.h b/drivers/net/wireless/ath/ath12k/hw.h
index 8d52182e28ae..8067b103e266 100644
--- a/drivers/net/wireless/ath/ath12k/hw.h
+++ b/drivers/net/wireless/ath/ath12k/hw.h
@@ -190,6 +190,7 @@ struct ath12k_hw_params {
 	bool reoq_lut_support:1;
 	bool supports_shadow_regs:1;
 	bool supports_aspm:1;
+	bool current_cc_support:1;
 
 	u32 num_tcl_banks;
 	u32 max_tx_ring;
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index aecfd55aef59..c7b0d66f4874 100644
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
 
 		wiphy_lock(wiphy);
 		ath12k_mac_11d_scan_stop(ar);
-- 
2.34.1


