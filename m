Return-Path: <linux-wireless+bounces-4603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E621879055
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 10:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827EE1C219D6
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Mar 2024 09:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA197827E;
	Tue, 12 Mar 2024 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bv7lr5Ny"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0399477F2E
	for <linux-wireless@vger.kernel.org>; Tue, 12 Mar 2024 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710234287; cv=none; b=t/lfKpCYRcKHKrC/Cx0Em+lkgHaD0WsrZFHafFCUu1/ZE7ybmfgO4EipaN9ywsNlmPCQx4hj9G4/YJqCfHCOLzn6r+JdTvNRlFdJMWqQ+49HVxq4UkRgq/S3/jxcmMHd8mxxdWDtC7Z9qQCru+Uw5pfgNRvuqlon9GghM5TVjYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710234287; c=relaxed/simple;
	bh=CFehbzwUWjaZL4eXZmDgqDQv6Aux3l3fBhy3SjsYXGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXYf+nS+pbyFoYAEWnoDG8Zsq4uIB8R4saM2ogTSPkznA6M+T/oMWeHZHnZ4FDbHaWzNqCwsNyTt7vK+tJHf6KSlsVaAybXO9KnuUTU/g/OaYJAu6ilc1sO6iAHkFAJnGNjgwu7/5a2vXftG1vFJNRxCA6A8Zi2STPyDzT8xcRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Bv7lr5Ny; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42C6Kjqc027909;
	Tue, 12 Mar 2024 09:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=jhL5TS9Y9Jnm6Jg31fXGPXECQU5yMZjwsxANcPIuhhI=; b=Bv
	7lr5Ny/Z/73xARd8Cbz2x9MHjKSNjaU8KA8G7u8YeEPnzXhJDPRq1cPWPAAme+Au
	XY16cgnBVK4jKCsZbm472e8ZG3Og26J8MgPLJLPnVjCITge3lZuFbNDtXsdzOQ1q
	JZ66PUm+NyhlLQO2KBOn0VCfhnwkP+JXmEs5C5kjarlrPsZJQB5CM1mkdEQhws1i
	pOEf7RBxtDMhnkK/uWpK2HN24WhMRUgDkbaOeLtDpCIx/cD94RFzABP1UcWR569b
	osRhKYb4n3QzfGoRVC4pJoKkNZ3axty4vAjH0JvTHcxMrAVajquPDmqTvXcwGlXx
	LhjnaX3/RZO7EV9Ew8Nw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtgc3gej7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 09:04:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42C94b2W013556
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 09:04:37 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Mar 2024 02:04:35 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v3 09/12] wifi: ath12k: modify regulatory support for single wiphy architecture
Date: Tue, 12 Mar 2024 14:33:48 +0530
Message-ID: <20240312090351.1620218-10-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312090351.1620218-1-quic_ramess@quicinc.com>
References: <20240312090351.1620218-1-quic_ramess@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 98-o3sqgcL26Yug6tlLmkmQZE_MATSpO
X-Proofpoint-GUID: 98-o3sqgcL26Yug6tlLmkmQZE_MATSpO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_08,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120070

From: Sriram R <quic_srirrama@quicinc.com>

With all the radios being combined and registered as a single
mac80211 hw/wiphy, separate regd built from firmware rules need
not be updated to cfg80211. Rather we can pick one of the regd
built from the rules to update to cfg80211 for the whole
registered device. We prefer 6 GHz pdev based rules since it has
the rules for all bands. If the hw doesn't support 6 GHz, then update
rules from one of the pdevs.

Also, when regulatory notification is received, update to all the
underlying radios/ar so that it becomes aware of the change and as
well us it updates its local regd with the new country rules. Later
pick the appropriate pdev's regd(6 GHz if available) and apply to
cfg80211.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  2 +
 drivers/net/wireless/ath/ath12k/mac.c  |  2 +
 drivers/net/wireless/ath/ath12k/reg.c  | 53 +++++++++++++++++++++-----
 3 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 4b21e7bcec3f..85e897357441 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -626,6 +626,8 @@ struct ath12k {
 
 struct ath12k_hw {
 	struct ieee80211_hw *hw;
+	bool regd_updated;
+	bool use_6ghz_regd;
 
 	u8 num_radio;
 	struct ath12k radio[] __aligned(sizeof(void *));
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index a77d6dbaea46..29c68aa2d30a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8076,6 +8076,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 {
 	struct ieee80211_supported_band *band;
 	struct ath12k_wmi_hal_reg_capabilities_ext_arg *reg_cap;
+	struct ath12k_hw *ah = ar->ah;
 	void *channels;
 	u32 phy_id;
 
@@ -8130,6 +8131,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 			ath12k_mac_update_ch_list(ar, band,
 						  reg_cap->low_5ghz_chan,
 						  reg_cap->high_5ghz_chan);
+			ah->use_6ghz_regd = true;
 		}
 
 		if (reg_cap->low_5ghz_chan < ATH12K_MIN_6G_FREQ) {
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index e73b716a2d80..aa809a6bc50a 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -50,7 +50,7 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	struct ath12k_wmi_init_country_arg arg;
 	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
 	struct ath12k *ar = ath12k_ah_to_ar(ah, 0);
-	int ret;
+	int ret, i;
 
 	ath12k_dbg(ar->ab, ATH12K_DBG_REG,
 		   "Regulatory Notification received for %s\n", wiphy_name(wiphy));
@@ -85,10 +85,16 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	memcpy(&arg.cc_info.alpha2, request->alpha2, 2);
 	arg.cc_info.alpha2[2] = 0;
 
-	ret = ath12k_wmi_send_init_country_cmd(ar, &arg);
-	if (ret)
-		ath12k_warn(ar->ab,
-			    "INIT Country code set to fw failed : %d\n", ret);
+	/* Allow fresh updates to wiphy regd */
+	ah->regd_updated = false;
+
+	/* Send the reg change request to all the radios */
+	for_each_ar(i, ah, ar) {
+		ret = ath12k_wmi_send_init_country_cmd(ar, &arg);
+		if (ret)
+			ath12k_warn(ar->ab,
+				    "INIT Country code set to fw failed : %d\n", ret);
+	}
 }
 
 int ath12k_reg_update_chan_list(struct ath12k *ar)
@@ -202,10 +208,32 @@ int ath12k_regd_update(struct ath12k *ar, bool init)
 {
 	struct ieee80211_hw *hw = ath12k_ar_to_hw(ar);
 	struct ieee80211_regdomain *regd, *regd_copy = NULL;
+	struct ath12k_hw *ah = ar->ah;
 	int ret, regd_len, pdev_id;
 	struct ath12k_base *ab;
+	int i;
 
 	ab = ar->ab;
+
+	/* If one of the radios within ah has already updated the regd for
+	 * the wiphy, then avoid setting regd again
+	 */
+	if (ah->regd_updated)
+		return 0;
+
+	/* firmware provides reg rules which are similar for 2 GHz and 5 GHz
+	 * pdev but 6 GHz pdev has superset of all rules including rules for
+	 * all bands, we prefer 6 GHz pdev's rules to be used for setup of
+	 * the wiphy regd.
+	 * If 6 GHz pdev was part of the ath12k_hw, wait for the 6 GHz pdev,
+	 * else pick the first pdev which calls this function and use its
+	 * regd to update global hw regd.
+	 * The regd_updated flag set at the end will not allow any further
+	 * updates.
+	 */
+	if (ah->use_6ghz_regd && !ar->supports_6ghz)
+		return 0;
+
 	pdev_id = ar->pdev_idx;
 
 	spin_lock_bh(&ab->base_lock);
@@ -258,10 +286,17 @@ int ath12k_regd_update(struct ath12k *ar, bool init)
 	if (ret)
 		goto err;
 
-	if (ar->state == ATH12K_STATE_ON) {
-		ret = ath12k_reg_update_chan_list(ar);
-		if (ret)
-			goto err;
+	ah->regd_updated = true;
+	/* Apply the new regd to all the radios, this is expected to be received only once
+	 * since we check for ah->regd_updated and allow here only once.
+	 */
+	for_each_ar(i, ah, ar) {
+		if (ar->state == ATH12K_STATE_ON) {
+			ab = ar->ab;
+			ret = ath12k_reg_update_chan_list(ar);
+			if (ret)
+				goto err;
+		}
 	}
 
 	return 0;
-- 
2.25.1


