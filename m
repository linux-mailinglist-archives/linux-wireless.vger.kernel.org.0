Return-Path: <linux-wireless+bounces-2487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBFF83C328
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 14:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4DA1F2242B
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 13:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E616A5914E;
	Thu, 25 Jan 2024 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y2OGx8CP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A585914C
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 13:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187878; cv=none; b=LO8P4XqmyzVpjBlukOxnI774jeY0NQPsXpqZUn1RUAvLMaLCzHhm+n64ta6Cw1R04kOgfurd9IPlwSEUMo3w3++xomgu3/eD2lJv2NssankO96uqduXK3tUiGDA+srIPam4KA6EUb2aH1d7bjoe05AekW0JQ64L3+qCpYrSPD+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187878; c=relaxed/simple;
	bh=PKN/ScPN+W7G/axnFSV5hDvyykhSqYcdI1+p3x6hFk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6g9TwlWjvPJavO96RuLZdBKkPMenUIc/lLJMqlVIG3LxS5QHZf0mjDD8EYOeuZzbXzu0bHWTH+gK0iwDRROZuM+ZIFJRRjyWeejQzqmlIf5IPGdSQH/eJl47oCIjDhHIEbAZts1xmKXWz1/0QYhq6/67AXzeNauivFL4fei2HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y2OGx8CP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PCXCp5008603;
	Thu, 25 Jan 2024 13:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=yBCQo6aK3u2uPjVBe+biCRlvr4Vc/MLTAiuWKWglpAc=; b=Y2
	OGx8CPULZeo1BekjDBUgtWV7Je68o5OGqNzqgQOcUUMkTMAxRieJcTfJ5i+/3CF5
	aDPWLNNGMfDoxkkdo75qs57Rb23ODX855uA7DwYmgerqGv56HVurPqeWmPdUnO2Z
	TSKvS8yPHm1TcWACMgW/xw4A/gBcbephAysiJlTIU4A+d4hFv6GWqFxY+MP/VhDv
	oyzzJTF3MNjapmJffKuR4Df/X0d10rt4ysA0HiyrfiDDobiXPQuxGU4aLeaATbJr
	GzQfu0NYQOYOqjSSsk6V8pwMbcZClSJ19tsmUxQdzBMkaqX3CLN9bv8v+0ivgy9g
	LtSiXadlYsLr6ib0Z57w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vuqra03mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 13:04:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PD4X6Z020457
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 13:04:33 GMT
Received: from cdcwlex322514-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 25 Jan 2024 05:04:31 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v5 3/3] wifi: mac80211: update beacon counters per link basis
Date: Thu, 25 Jan 2024 18:34:10 +0530
Message-ID: <20240125130410.827701-4-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125130410.827701-1-quic_adisi@quicinc.com>
References: <20240125130410.827701-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: x38iAiLDIxh3XH4HRBpGluQbAwKAs3Ug
X-Proofpoint-ORIG-GUID: x38iAiLDIxh3XH4HRBpGluQbAwKAs3Ug
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_08,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=738 phishscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250091

Currently, function to update beacon counter uses deflink to fetch
the beacon and then update the counter. However, with MLO, there is
a need to update the counter for the beacon in a particular link.

Add support to use link_id in order to fetch the beacon from a particular
link data during beacon update counter.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/mac.c             |  2 +-
 drivers/net/wireless/ath/ath11k/mac.c             |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  2 +-
 include/net/mac80211.h                            |  4 +++-
 net/mac80211/tx.c                                 | 14 +++++++++++---
 5 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 07c5c51ff7b2..8847cfc6030e 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -2035,7 +2035,7 @@ static void ath10k_mac_vif_ap_csa_count_down(struct ath10k_vif *arvif)
 		return;
 
 	if (!ieee80211_beacon_cntdwn_is_complete(vif)) {
-		ieee80211_beacon_update_cntdwn(vif);
+		ieee80211_beacon_update_cntdwn(vif, 0);
 
 		ret = ath10k_mac_setup_bcn_tmpl(arvif);
 		if (ret)
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index db241589424d..74e114140343 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1589,7 +1589,7 @@ void ath11k_mac_bcn_tx_event(struct ath11k_vif *arvif)
 	arvif->bcca_zero_sent = false;
 
 	if (vif->bss_conf.color_change_active)
-		ieee80211_beacon_update_cntdwn(vif);
+		ieee80211_beacon_update_cntdwn(vif, 0);
 	ath11k_mac_setup_bcn_tmpl(arvif);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index 3b6819f75430..57a94ffb12d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1467,7 +1467,7 @@ static void iwl_mvm_csa_count_down(struct iwl_mvm *mvm,
 	mvmvif->csa_countdown = true;
 
 	if (!ieee80211_beacon_cntdwn_is_complete(csa_vif)) {
-		int c = ieee80211_beacon_update_cntdwn(csa_vif);
+		int c = ieee80211_beacon_update_cntdwn(csa_vif, 0);
 
 		iwl_mvm_mac_ctxt_beacon_changed(mvm, csa_vif,
 						&csa_vif->bss_conf);
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 850053ed2366..d8e2b5efbba9 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5455,6 +5455,7 @@ static inline struct sk_buff *ieee80211_beacon_get(struct ieee80211_hw *hw,
 /**
  * ieee80211_beacon_update_cntdwn - request mac80211 to decrement the beacon countdown
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @link_id: valid link_id during MLO or 0 for non-MLO
  *
  * The beacon counter should be updated after each beacon transmission.
  * This function is called implicitly when
@@ -5464,7 +5465,8 @@ static inline struct sk_buff *ieee80211_beacon_get(struct ieee80211_hw *hw,
  *
  * Return: new countdown value
  */
-u8 ieee80211_beacon_update_cntdwn(struct ieee80211_vif *vif);
+u8 ieee80211_beacon_update_cntdwn(struct ieee80211_vif *vif,
+				  unsigned int link_id);
 
 /**
  * ieee80211_beacon_set_cntdwn - request mac80211 to set beacon countdown
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 314998fdb1a5..aab3fd9895fe 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5030,16 +5030,24 @@ static u8 __ieee80211_beacon_update_cntdwn(struct beacon_data *beacon)
 	return beacon->cntdwn_current_counter;
 }
 
-u8 ieee80211_beacon_update_cntdwn(struct ieee80211_vif *vif)
+u8 ieee80211_beacon_update_cntdwn(struct ieee80211_vif *vif, unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_link_data *link;
 	struct beacon_data *beacon = NULL;
 	u8 count = 0;
 
+	if (WARN_ON(link_id > IEEE80211_MLD_MAX_NUM_LINKS))
+		return 0;
+
 	rcu_read_lock();
 
+	link = rcu_dereference(sdata->link[link_id]);
+	if (!link)
+		goto unlock;
+
 	if (sdata->vif.type == NL80211_IFTYPE_AP)
-		beacon = rcu_dereference(sdata->deflink.u.ap.beacon);
+		beacon = rcu_dereference(link->u.ap.beacon);
 	else if (sdata->vif.type == NL80211_IFTYPE_ADHOC)
 		beacon = rcu_dereference(sdata->u.ibss.presp);
 	else if (ieee80211_vif_is_mesh(&sdata->vif))
@@ -5280,7 +5288,7 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 
 	if (beacon->cntdwn_counter_offsets[0]) {
 		if (!is_template)
-			ieee80211_beacon_update_cntdwn(vif);
+			ieee80211_beacon_update_cntdwn(vif, link->link_id);
 
 		ieee80211_set_beacon_cntdwn(sdata, beacon, link);
 	}
-- 
2.25.1


