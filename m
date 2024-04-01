Return-Path: <linux-wireless+bounces-5730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5902589453A
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 21:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F549282A74
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Apr 2024 19:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39C453E07;
	Mon,  1 Apr 2024 19:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bcQzzi3I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3C653E16
	for <linux-wireless@vger.kernel.org>; Mon,  1 Apr 2024 19:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998323; cv=none; b=tTw5M2eZUbRml+xsghDkrW5XWGNSAywdpGkvF/YerU1TabE96ndyUbdC72KXGalwNMpyUm/Zu7PCEiC9CYW2wdxP1r0NQe9u0ZLcwEtYC0sQWPtGVZnsHX0z+ZK5IqiwmiglxH0v5WBbXfQtRAISZk5OX4J/sOBjsZUlIru/P58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998323; c=relaxed/simple;
	bh=vOIECCEfMAm4odDxaOQcKs4huY1PIVYokXAtwZ6Gobw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ygrlz/NBau38Pq9YFadpRUXD/8/x3yMzf1cfiCOSk1Uiv+/DmhfIeq+I8Wj/jT17J4mdDyFMEdrV2vLXdQ+I2HmWKyLey3xXk4cKJZin/xzWRBPe/cbtCO7zvNuiLSSvnUJVR3ytPf677vsnkJPCMNFI61l0PjlqpJ9PpOCVz44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bcQzzi3I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 431CAqTl019796;
	Mon, 1 Apr 2024 19:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=qxCaxhl+zBiL2OiEvxpYopsk02DtSjK9tEDP+910Rvw=; b=bc
	Qzzi3I7Fr69bt8UckNfzNnBbu8PDT/t41LCan6eP8w8vpYaUwE0t2j3ssJlndD3s
	3S3kIp5srOp0Y/T9Yp2/L/tNa3SsRbh+BquxEciWJpl9HYV4UOmD1e9JdlLWGoCS
	VD3Hv+nhLZmtrtXaENq4RNJ4FPMAw1tMF6Cd1VJkMEX1gUTb2wAU2xu4mAKzLg+G
	wDN1rxcnVOC5d6pUhrBxt3Z8SGWTN9ov1qpvoqkRQI9bl19+IBQggp7ouWmIUQu3
	Ywp08x3ILnF/YVTfzASfyLYH1Z/NwPmwLfzUkr7mzaRfUUwuWe/Dl3zHmjfM2/lf
	/DB+aQ8XbZ3UgWM4IDIw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x7u7f9631-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Apr 2024 19:05:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 431J5H8Y000689
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Apr 2024 19:05:17 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Apr 2024 12:05:15 -0700
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>
Subject: [PATCH v6 09/12] wifi: ath12k: modify regulatory support for single wiphy architecture
Date: Tue, 2 Apr 2024 00:34:06 +0530
Message-ID: <20240401190409.2461819-10-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401190409.2461819-1-quic_ramess@quicinc.com>
References: <20240401190409.2461819-1-quic_ramess@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3sJa20MfEyjWMR6nya92dOmS1WHt8TpQ
X-Proofpoint-ORIG-GUID: 3sJa20MfEyjWMR6nya92dOmS1WHt8TpQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-01_13,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404010134

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
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h |  2 +
 drivers/net/wireless/ath/ath12k/mac.c  |  2 +
 drivers/net/wireless/ath/ath12k/reg.c  | 53 +++++++++++++++++++++-----
 3 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 4d71267bbb60..c45efeaaa433 100644
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
index ec592504f926..706e770e0eb9 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8103,6 +8103,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 {
 	struct ieee80211_supported_band *band;
 	struct ath12k_wmi_hal_reg_capabilities_ext_arg *reg_cap;
+	struct ath12k_hw *ah = ar->ah;
 	void *channels;
 	u32 phy_id;
 
@@ -8157,6 +8158,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 			ath12k_mac_update_ch_list(ar, band,
 						  reg_cap->low_5ghz_chan,
 						  reg_cap->high_5ghz_chan);
+			ah->use_6ghz_regd = true;
 		}
 
 		if (reg_cap->low_5ghz_chan < ATH12K_MIN_6G_FREQ) {
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index e73b716a2d80..fbf38044938c 100644
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
+	for_each_ar(ah, ar, i) {
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
+	for_each_ar(ah, ar, i) {
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


