Return-Path: <linux-wireless+bounces-7818-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3938C8FBD
	for <lists+linux-wireless@lfdr.de>; Sat, 18 May 2024 07:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1DCE1C21266
	for <lists+linux-wireless@lfdr.de>; Sat, 18 May 2024 05:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD6E1A2C0A;
	Sat, 18 May 2024 05:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dHs7oWPc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C384B2F43
	for <linux-wireless@vger.kernel.org>; Sat, 18 May 2024 05:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716011621; cv=none; b=imO0hOKbH2mkZBz/1s8uZVAr5Dw2Zqppw+LizJEtcMXQkhhKhZo0O+qVQT3KCO3VoggQOMROIsnHQkHg/RtB7nPScdj02IQAM/13hwePEJYb9LokQDVqMhqHOH22u+efpHVWdX4DfcsvKgLLiJJSnmLxqW797dxT7IJyJ98bpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716011621; c=relaxed/simple;
	bh=pdCNEDtOr/ZIdWAAe19mapdyRB6avgkelXGUV0irm8I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tcoc2T20m5LAmo6aE2SKUYB/HNh4wU0/bMDX0sz36Q0g4Zo4AoqFJ/cPDOEWGVI2RT7XpmsgxIOpZxTSEjarUkB9AHsZDwa5eqHwyAGjh75MgXl0pKmIxiIxqYZOcvZQ3I1HYweEnHBrpUyo2qkP2twr6vNJmbLiH/X5KqM/Dqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dHs7oWPc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44I4CN44023546;
	Sat, 18 May 2024 05:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=WpkFPFI
	RqCHcVuqVvIV+ubGpwwbikLwZJUEEMspR2sI=; b=dHs7oWPciWFzJIp2c4ao9xS
	7t9yQaFtdqHXIOpheHrTra2XIIjtosDINThCfUZgcDOUQYIE/QnQW/7s5CuQV8mm
	Ybhr+ybho4TYs6CZdlXL+UQkKEB/5gXfZrRhKnMz/w+EfByXCnfAIdqKenq0sbgP
	tHiK8E8TXvK+PWZlpLRhOm11mHMk+pdamjV0bMEieYGDqm8+OadCSBdJ3L32RU7+
	QKbBJcvVYzynLrolD8/tt2sZLVgKOpMyIFgtAllA2yvBkm2NGCTl8e1PJmDH3AsO
	C+14foJdki8keOKGp+QjLwLMRHwWM0PDPBfBo1C33ZV2FrdZ0muWRVRtwFBpkQw=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n3eg2tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 May 2024 05:53:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44I5rW1M016760
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 May 2024 05:53:32 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 17 May 2024 22:53:30 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 RFC] wifi: cfg80211: Refactor interface combination input parameter
Date: Sat, 18 May 2024 11:23:16 +0530
Message-ID: <20240518055316.3102746-1-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: ZqR9MP41sJ4pEFbFruaIyBpd4WPYW2wy
X-Proofpoint-ORIG-GUID: ZqR9MP41sJ4pEFbFruaIyBpd4WPYW2wy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_13,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 mlxscore=0 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405180030

Currently, the interface combination input parameter num_different_channels
and iftype_num are directly filled in by the caller under the assumption
that all channels and interfaces belong to a single hardware device. This
assumption is incorrect for multi-device interface combinations because
each device supports a different set of channels and interfaces. As
discussed in [1], need to refactor the input parameters to encode enough
data to handle both single and multiple device interface combinations.
This can be achieved by encoding the frequency parameter under the link
entity and interface type parameter under the interface entity, which can
hold an array of link entities. This is because, in the MLO scenario, a
single interface can support multiple links. With this new input parameter
structure, the cfg80211 can classify and construct the device parameters,
then verify them against the device specific interface combinations.

[1]: https://lore.kernel.org/linux-wireless/ca70eeb3cdee1e8c3caee69db595bc8160eb4115.camel@sipsolutions.net/

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 v2:
  - changed the argument of ieee80211_check_combinations()
  - changed the iface_combination_interface::num_link into
    iface_combination_interface::valid_links
  - Moved the new_beacon_int, radar_detect under the iface link param
  - Moved the ieee80211_link_or_deflink() helper under the util
  - Moved the ieee80211_link_get_chanctx() helper under the ieee80211_i.h
  - Removed ieee80211_chanctx_radar_detect()

 drivers/net/wireless/ath/wil6210/cfg80211.c   |  44 ++-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  60 +++-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  32 +-
 include/net/cfg80211.h                        |  51 +++-
 net/mac80211/cfg.c                            |  40 +--
 net/mac80211/chan.c                           |  16 +-
 net/mac80211/ibss.c                           |   7 +-
 net/mac80211/ieee80211_i.h                    |  20 +-
 net/mac80211/iface.c                          |   7 +-
 net/mac80211/util.c                           | 280 +++++++++++++-----
 net/wireless/util.c                           |  90 ++++--
 11 files changed, 464 insertions(+), 183 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index e8f1d30a8d73..04750696a48e 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -625,17 +625,25 @@ static int wil_cfg80211_validate_add_iface(struct wil6210_priv *wil,
 {
 	int i;
 	struct wireless_dev *wdev;
-	struct iface_combination_params params = {
-		.num_different_channels = 1,
-	};
+	struct iface_combination_params params = { };
+	struct iface_combination_interface ifaces[WIL_MAX_VIFS] = { };
 
 	for (i = 0; i < GET_MAX_VIFS(wil); i++) {
 		if (wil->vifs[i]) {
 			wdev = vif_to_wdev(wil->vifs[i]);
-			params.iftype_num[wdev->iftype]++;
+			ifaces[params.num_iface].iftype = wdev->iftype;
+			ifaces[params.num_iface].valid_links = BIT(0);
+			params.num_iface++;
 		}
 	}
-	params.iftype_num[new_type]++;
+
+	if (params.num_iface < WIL_MAX_VIFS) {
+		ifaces[params.num_iface].iftype = new_type;
+		ifaces[params.num_iface].valid_links = BIT(0);
+		params.num_iface++;
+	}
+	params.ifaces = ifaces;
+
 	return cfg80211_check_combinations(wil->wiphy, &params);
 }
 
@@ -643,11 +651,10 @@ static int wil_cfg80211_validate_change_iface(struct wil6210_priv *wil,
 					      struct wil6210_vif *vif,
 					      enum nl80211_iftype new_type)
 {
-	int i, ret = 0;
+	int i;
 	struct wireless_dev *wdev;
-	struct iface_combination_params params = {
-		.num_different_channels = 1,
-	};
+	struct iface_combination_params params = { };
+	struct iface_combination_interface ifaces[WIL_MAX_VIFS] = { };
 	bool check_combos = false;
 
 	for (i = 0; i < GET_MAX_VIFS(wil); i++) {
@@ -655,16 +662,25 @@ static int wil_cfg80211_validate_change_iface(struct wil6210_priv *wil,
 
 		if (vif_pos && vif != vif_pos) {
 			wdev = vif_to_wdev(vif_pos);
-			params.iftype_num[wdev->iftype]++;
+			ifaces[params.num_iface].iftype = wdev->iftype;
+			ifaces[params.num_iface].valid_links = BIT(0);
+			params.num_iface++;
+
 			check_combos = true;
 		}
 	}
 
-	if (check_combos) {
-		params.iftype_num[new_type]++;
-		ret = cfg80211_check_combinations(wil->wiphy, &params);
+	if (!check_combos)
+		return 0;
+
+	if (params.num_iface < WIL_MAX_VIFS) {
+		ifaces[params.num_iface].iftype = new_type;
+		ifaces[params.num_iface].valid_links = BIT(0);
+		params.num_iface++;
 	}
-	return ret;
+	params.ifaces = ifaces;
+
+	return cfg80211_check_combinations(wil->wiphy, &params);
 }
 
 static struct wireless_dev *
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 5fe0e671ecb3..a2eec398ad9a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -496,22 +496,38 @@ static int brcmf_vif_change_validate(struct brcmf_cfg80211_info *cfg,
 	struct brcmf_cfg80211_vif *pos;
 	bool check_combos = false;
 	int ret = 0;
-	struct iface_combination_params params = {
-		.num_different_channels = 1,
-	};
+	struct iface_combination_params params = { };
+	struct iface_combination_interface *ifaces;
+	u16 total_iface = 0;
 
 	list_for_each_entry(pos, &cfg->vif_list, list)
+		total_iface++;
+
+	ifaces = kcalloc(total_iface, sizeof(*ifaces), GFP_KERNEL);
+	if (!ifaces)
+		return -ENOMEM;
+
+	list_for_each_entry(pos, &cfg->vif_list, list) {
+		if (WARN_ON(params.num_iface >= total_iface))
+			continue;
+
 		if (pos == vif) {
-			params.iftype_num[new_type]++;
+			ifaces[params.num_iface].iftype = new_type;
 		} else {
 			/* concurrent interfaces so need check combinations */
 			check_combos = true;
-			params.iftype_num[pos->wdev.iftype]++;
+			ifaces[params.num_iface].iftype = pos->wdev.iftype;
 		}
 
+		ifaces[params.num_iface].valid_links = BIT(0);
+		params.num_iface++;
+	}
+	params.ifaces = ifaces;
+
 	if (check_combos)
 		ret = cfg80211_check_combinations(cfg->wiphy, &params);
 
+	kfree(ifaces);
 	return ret;
 }
 
@@ -519,15 +535,37 @@ static int brcmf_vif_add_validate(struct brcmf_cfg80211_info *cfg,
 				  enum nl80211_iftype new_type)
 {
 	struct brcmf_cfg80211_vif *pos;
-	struct iface_combination_params params = {
-		.num_different_channels = 1,
-	};
+	struct iface_combination_params params = { };
+	struct iface_combination_interface *ifaces;
+	u16 total_iface = 0;
+	int ret;
 
 	list_for_each_entry(pos, &cfg->vif_list, list)
-		params.iftype_num[pos->wdev.iftype]++;
+		total_iface++;
 
-	params.iftype_num[new_type]++;
-	return cfg80211_check_combinations(cfg->wiphy, &params);
+	ifaces = kcalloc(total_iface, sizeof(*ifaces), GFP_KERNEL);
+	if (!ifaces)
+		return -ENOMEM;
+
+	list_for_each_entry(pos, &cfg->vif_list, list) {
+		if (params.num_iface >= total_iface)
+			continue;
+
+		ifaces[params.num_iface].iftype = pos->wdev.iftype;
+		ifaces[params.num_iface].valid_links = BIT(0);
+		params.num_iface++;
+	}
+
+	if (params.num_iface < total_iface) {
+		ifaces[params.num_iface].iftype = new_type;
+		ifaces[params.num_iface].valid_links = BIT(0);
+		params.num_iface++;
+	}
+
+	ret = cfg80211_check_combinations(cfg->wiphy, &params);
+
+	kfree(ifaces);
+	return ret;
 }
 
 static void convert_key_from_CPU(struct brcmf_wsec_key *key,
diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index 663d77770fce..b10ea0a5e294 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -79,26 +79,38 @@ qtnf_validate_iface_combinations(struct wiphy *wiphy,
 	struct qtnf_vif *vif;
 	int i;
 	int ret = 0;
-	struct iface_combination_params params = {
-		.num_different_channels = 1,
-	};
+	struct iface_combination_params params = { };
+	struct iface_combination_interface ifaces[QTNF_MAX_INTF] = { };
+	bool change_vif_need = false;
 
 	mac = wiphy_priv(wiphy);
 	if (!mac)
 		return -EFAULT;
 
+	if (change_vif)
+		change_vif_need = true;
+
 	for (i = 0; i < QTNF_MAX_INTF; i++) {
 		vif = &mac->iflist[i];
-		if (vif->wdev.iftype != NL80211_IFTYPE_UNSPECIFIED)
-			params.iftype_num[vif->wdev.iftype]++;
+		if (vif->wdev.iftype != NL80211_IFTYPE_UNSPECIFIED) {
+			if (change_vif_need &&
+			    change_vif->wdev.iftype == vif->wdev.iftype) {
+				change_vif_need = false;
+				continue;
+			}
+
+			ifaces[params.num_iface].iftype = vif->wdev.iftype;
+			ifaces[params.num_iface].valid_links = BIT(0);
+			params.num_iface++;
+		}
 	}
 
-	if (change_vif) {
-		params.iftype_num[new_type]++;
-		params.iftype_num[change_vif->wdev.iftype]--;
-	} else {
-		params.iftype_num[new_type]++;
+	if (params.num_iface < QTNF_MAX_INTF) {
+		ifaces[params.num_iface].iftype = new_type;
+		ifaces[params.num_iface].valid_links = BIT(0);
+		params.num_iface++;
 	}
+	params.ifaces = ifaces;
 
 	ret = cfg80211_check_combinations(wiphy, &params);
 
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index cbf1664dc569..3d2c385a0344 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1591,27 +1591,50 @@ struct cfg80211_color_change_settings {
 };
 
 /**
- * struct iface_combination_params - input parameters for interface combinations
+ * struct iface_combination_iface_link - Interface combination link parameter
  *
- * Used to pass interface combination parameters
+ * Used to pass link specific interface combination parameters
  *
- * @num_different_channels: the number of different channels we want
- *	to use for verification
- * @radar_detect: a bitmap where each bit corresponds to a channel
- *	width where radar detection is needed, as in the definition of
- *	&struct ieee80211_iface_combination.@radar_detect_widths
- * @iftype_num: array with the number of interfaces of each interface
- *	type.  The index is the interface type as specified in &enum
- *	nl80211_iftype.
+ * @freq: center frequency used for verification against the different channels
  * @new_beacon_int: set this to the beacon interval of a new interface
  *	that's not operating yet, if such is to be checked as part of
  *	the verification
+ * @radar_detect: a bitmap where each bit corresponds to a channel
+ *	width where radar detection is needed, as in the definition of
+ *	&struct ieee80211_iface_combination.@radar_detect_widths
  */
-struct iface_combination_params {
-	int num_different_channels;
-	u8 radar_detect;
-	int iftype_num[NUM_NL80211_IFTYPES];
+struct iface_combination_iface_link {
+	u32 freq;
 	u32 new_beacon_int;
+	u8 radar_detect;
+};
+
+/**
+ * struct iface_combination_interface - Interface parameter for iface combination
+ *
+ * Used to pass interface specific parameter for iface combination
+ *
+ * @iftype: interface type as specified in &enum nl80211_iftype.
+ * @links: array with the number of link parameter used for verification
+ * @valid_links: bitmap of valid links, or 0 for non-MLO.
+ */
+struct iface_combination_interface {
+	enum nl80211_iftype iftype;
+	struct iface_combination_iface_link links[IEEE80211_MLD_MAX_NUM_LINKS];
+	u16 valid_links;
+};
+
+/**
+ * struct iface_combination_params - input parameters for interface combinations
+ *
+ * Used to pass interface combination parameters
+ *
+ * @ifaces: array with the number of interface parameter use for verification
+ * @num_iface: the length of the @ifaces interface parameter
+ */
+struct iface_combination_params {
+	const struct iface_combination_interface *ifaces;
+	u16 num_iface;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b08e5d7687e3..77de926d56f9 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -23,30 +23,6 @@
 #include "mesh.h"
 #include "wme.h"
 
-static struct ieee80211_link_data *
-ieee80211_link_or_deflink(struct ieee80211_sub_if_data *sdata, int link_id,
-			  bool require_valid)
-{
-	struct ieee80211_link_data *link;
-
-	if (link_id < 0) {
-		/*
-		 * For keys, if sdata is not an MLD, we might not use
-		 * the return value at all (if it's not a pairwise key),
-		 * so in that case (require_valid==false) don't error.
-		 */
-		if (require_valid && ieee80211_vif_is_mld(&sdata->vif))
-			return ERR_PTR(-EINVAL);
-
-		return &sdata->deflink;
-	}
-
-	link = sdata_dereference(sdata->link[link_id], sdata);
-	if (!link)
-		return ERR_PTR(-ENOLINK);
-	return link;
-}
-
 static void ieee80211_set_mu_mimo_follow(struct ieee80211_sub_if_data *sdata,
 					 struct vif_params *params)
 {
@@ -259,11 +235,16 @@ static int ieee80211_start_p2p_device(struct wiphy *wiphy,
 				      struct wireless_dev *wdev)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
+	struct ieee80211_link_data *link;
 	int ret;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	ret = ieee80211_check_combinations(sdata, NULL, 0, 0);
+	link = ieee80211_link_or_deflink(sdata, -1, false);
+	if (IS_ERR(link))
+		return PTR_ERR(link);
+
+	ret = ieee80211_check_combinations(link, NULL, 0, 0);
 	if (ret < 0)
 		return ret;
 
@@ -281,11 +262,16 @@ static int ieee80211_start_nan(struct wiphy *wiphy,
 			       struct cfg80211_nan_conf *conf)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
+	struct ieee80211_link_data *link;
 	int ret;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	ret = ieee80211_check_combinations(sdata, NULL, 0, 0);
+	link = ieee80211_link_or_deflink(sdata, -1, false);
+	if (IS_ERR(link))
+		return PTR_ERR(link);
+
+	ret = ieee80211_check_combinations(link, NULL, 0, 0);
 	if (ret < 0)
 		return ret;
 
@@ -4000,7 +3986,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		goto out;
 
 	/* if reservation is invalid then this will fail */
-	err = ieee80211_check_combinations(sdata, NULL, chanctx->mode, 0);
+	err = ieee80211_check_combinations(link_data, NULL, chanctx->mode, 0);
 	if (err) {
 		ieee80211_link_unreserve_chanctx(link_data);
 		goto out;
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 380695fdc32f..b604e092fa99 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -67,20 +67,6 @@ static bool ieee80211_can_create_new_chanctx(struct ieee80211_local *local)
 	return ieee80211_num_chanctx(local) < ieee80211_max_num_channels(local);
 }
 
-static struct ieee80211_chanctx *
-ieee80211_link_get_chanctx(struct ieee80211_link_data *link)
-{
-	struct ieee80211_local *local __maybe_unused = link->sdata->local;
-	struct ieee80211_chanctx_conf *conf;
-
-	conf = rcu_dereference_protected(link->conf->chanctx_conf,
-					 lockdep_is_held(&local->hw.wiphy->mtx));
-	if (!conf)
-		return NULL;
-
-	return container_of(conf, struct ieee80211_chanctx, conf);
-}
-
 bool ieee80211_chanreq_identical(const struct ieee80211_chan_req *a,
 				 const struct ieee80211_chan_req *b)
 {
@@ -1764,7 +1750,7 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 
 	link->radar_required = ret;
 
-	ret = ieee80211_check_combinations(sdata, &chanreq->oper, mode,
+	ret = ieee80211_check_combinations(link, &chanreq->oper, mode,
 					   radar_detect_width);
 	if (ret < 0)
 		goto out;
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 7ace5cdc6c26..64da7109c5ab 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1718,6 +1718,7 @@ int ieee80211_ibss_join(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_supported_band *sband;
 	enum ieee80211_chanctx_mode chanmode;
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_link_data *link;
 	int radar_detect_width = 0;
 	int i;
 	int ret;
@@ -1744,7 +1745,11 @@ int ieee80211_ibss_join(struct ieee80211_sub_if_data *sdata,
 	chanmode = (params->channel_fixed && !ret) ?
 		IEEE80211_CHANCTX_SHARED : IEEE80211_CHANCTX_EXCLUSIVE;
 
-	ret = ieee80211_check_combinations(sdata, &params->chandef, chanmode,
+	link = ieee80211_link_or_deflink(sdata, -1, false);
+	if (IS_ERR(link))
+		return PTR_ERR(link);
+
+	ret = ieee80211_check_combinations(link, &params->chandef, chanmode,
 					   radar_detect_width);
 	if (ret < 0)
 		return ret;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index eb62b7d4b4f7..f72d0a8593ea 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1659,6 +1659,20 @@ ieee80211_get_link_sband(struct ieee80211_link_data *link)
 	return local->hw.wiphy->bands[band];
 }
 
+static inline struct ieee80211_chanctx *
+ieee80211_link_get_chanctx(struct ieee80211_link_data *link)
+{
+	struct ieee80211_local *local __maybe_unused = link->sdata->local;
+	struct ieee80211_chanctx_conf *conf;
+
+	conf = rcu_dereference_protected(link->conf->chanctx_conf,
+					 lockdep_is_held(&local->hw.wiphy->mtx));
+	if (!conf)
+		return NULL;
+
+	return container_of(conf, struct ieee80211_chanctx, conf);
+}
+
 /* this struct holds the value parsing from channel switch IE  */
 struct ieee80211_csa_ie {
 	struct ieee80211_chan_req chanreq;
@@ -2042,6 +2056,10 @@ static inline void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata
 	ieee80211_vif_set_links(sdata, 0, 0);
 }
 
+struct ieee80211_link_data *
+ieee80211_link_or_deflink(struct ieee80211_sub_if_data *sdata, int link_id,
+			  bool require_valid);
+
 /* tx handling */
 void ieee80211_clear_tx_pending(struct ieee80211_local *local);
 void ieee80211_tx_pending(struct tasklet_struct *t);
@@ -2605,7 +2623,7 @@ int ieee80211_send_action_csa(struct ieee80211_sub_if_data *sdata,
 
 void ieee80211_recalc_dtim(struct ieee80211_local *local,
 			   struct ieee80211_sub_if_data *sdata);
-int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
+int ieee80211_check_combinations(struct ieee80211_link_data *link,
 				 const struct cfg80211_chan_def *chandef,
 				 enum ieee80211_chanctx_mode chanmode,
 				 u8 radar_detect);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index dc42902e2693..0341dc344eb3 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -330,10 +330,15 @@ static int ieee80211_check_concurrent_iface(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_sub_if_data *nsdata;
+	struct ieee80211_link_data *link;
 
 	ASSERT_RTNL();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	link = ieee80211_link_or_deflink(sdata, -1, false);
+	if (IS_ERR(link))
+		return PTR_ERR(link);
+
 	/* we hold the RTNL here so can safely walk the list */
 	list_for_each_entry(nsdata, &local->interfaces, list) {
 		if (nsdata != sdata && ieee80211_sdata_running(nsdata)) {
@@ -397,7 +402,7 @@ static int ieee80211_check_concurrent_iface(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	return ieee80211_check_combinations(sdata, NULL, 0, 0);
+	return ieee80211_check_combinations(link, NULL, 0, 0);
 }
 
 static int ieee80211_check_queues(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0b893e958959..9479f097a390 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -51,6 +51,29 @@ const struct ieee80211_conn_settings ieee80211_conn_settings_unlimited = {
 	.bw_limit = IEEE80211_CONN_BW_LIMIT_320,
 };
 
+struct ieee80211_link_data *
+ieee80211_link_or_deflink(struct ieee80211_sub_if_data *sdata, int link_id,
+			  bool require_valid)
+{
+	struct ieee80211_link_data *link;
+
+	if (link_id < 0) {
+		/* For keys, if sdata is not an MLD, we might not use
+		 * the return value at all (if it's not a pairwise key),
+		 * so in that case (require_valid==false) don't error.
+		 */
+		if (require_valid && ieee80211_vif_is_mld(&sdata->vif))
+			return ERR_PTR(-EINVAL);
+
+		return &sdata->deflink;
+	}
+
+	link = sdata_dereference(sdata->link[link_id], sdata);
+	if (!link)
+		return ERR_PTR(-ENOLINK);
+	return link;
+}
+
 u8 *ieee80211_get_bssid(struct ieee80211_hdr *hdr, size_t len,
 			enum nl80211_iftype type)
 {
@@ -3900,52 +3923,100 @@ void ieee80211_recalc_dtim(struct ieee80211_local *local,
 	ps->dtim_count = dtim_count;
 }
 
-static u8 ieee80211_chanctx_radar_detect(struct ieee80211_local *local,
-					 struct ieee80211_chanctx *ctx)
+static int ieee80211_link_get_new_chanctx(struct ieee80211_link_data *link,
+					  struct ieee80211_chanctx **chanctx,
+					  bool *radar_required)
+{
+	struct ieee80211_chanctx *ctx;
+
+	if (!radar_required || !chanctx)
+		return -EINVAL;
+
+	ctx = ieee80211_link_get_chanctx(link);
+	if (!ctx)
+		return -ENOENT;
+
+	if (ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED) {
+		if (!link->reserved_chanctx)
+			return -ENOENT;
+
+		*chanctx = link->reserved_chanctx;
+		*radar_required = link->reserved_radar_required;
+	} else {
+		*chanctx = ctx;
+		*radar_required = link->radar_required;
+	}
+
+	return 0;
+}
+
+static
+u8 ieee80211_fill_combination_link(struct ieee80211_sub_if_data *sdata,
+				   const struct cfg80211_chan_def *chandef,
+				   enum ieee80211_chanctx_mode chanmode,
+				   struct iface_combination_interface *iface)
 {
+	struct iface_combination_iface_link *link_comb;
 	struct ieee80211_link_data *link;
-	u8 radar_detect = 0;
+	unsigned int link_id;
+	u8 links_radar_detect = 0;
 
-	lockdep_assert_wiphy(local->hw.wiphy);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	if (WARN_ON(ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED))
-		return 0;
+	rcu_read_lock();
+
+	for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
+		struct ieee80211_chanctx *ctx;
+		const struct cfg80211_chan_def *chandef_iter;
+		bool radar_required = false;
 
-	list_for_each_entry(link, &ctx->reserved_links, reserved_chanctx_list)
-		if (link->reserved_radar_required)
-			radar_detect |= BIT(link->reserved.oper.width);
+		link = sdata_dereference(sdata->link[link_id], sdata);
+		if (!link)
+			continue;
 
-	/*
-	 * An in-place reservation context should not have any assigned vifs
-	 * until it replaces the other context.
-	 */
-	WARN_ON(ctx->replace_state == IEEE80211_CHANCTX_REPLACES_OTHER &&
-		!list_empty(&ctx->assigned_links));
+		if (ieee80211_link_get_new_chanctx(link, &ctx, &radar_required))
+			continue;
 
-	list_for_each_entry(link, &ctx->assigned_links, assigned_chanctx_list) {
-		if (!link->radar_required)
+		if (ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED)
 			continue;
 
-		radar_detect |=
-			BIT(link->conf->chanreq.oper.width);
+		chandef_iter = &ctx->conf.def;
+		link_comb = &iface->links[link_id];
+
+		if (chandef && chanmode == IEEE80211_CHANCTX_SHARED &&
+		    ctx->mode == IEEE80211_CHANCTX_SHARED &&
+		    cfg80211_chandef_compatible(chandef, &ctx->conf.def))
+			chandef_iter = chandef;
+
+		link_comb->freq = chandef_iter->chan->center_freq;
+
+		if (radar_required) {
+			link_comb->radar_detect = BIT(chandef_iter->width);
+			links_radar_detect |= BIT(chandef_iter->width);
+		}
+
+		iface->valid_links |= BIT(link_id);
 	}
 
-	return radar_detect;
+	rcu_read_unlock();
+
+	return links_radar_detect;
 }
 
-int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
+int ieee80211_check_combinations(struct ieee80211_link_data *link,
 				 const struct cfg80211_chan_def *chandef,
 				 enum ieee80211_chanctx_mode chanmode,
 				 u8 radar_detect)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_sub_if_data *sdata_iter;
 	enum nl80211_iftype iftype = sdata->wdev.iftype;
-	struct ieee80211_chanctx *ctx;
-	int total = 1;
-	struct iface_combination_params params = {
-		.radar_detect = radar_detect,
-	};
+	struct iface_combination_interface *ifaces = NULL;
+	int total = 1, ret = 0;
+	struct iface_combination_params params = { };
+	u16 total_iface = 0;
+	u8 links_radar_detect = 0;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -3959,16 +4030,6 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 	if (WARN_ON(iftype >= NUM_NL80211_IFTYPES))
 		return -EINVAL;
 
-	if (sdata->vif.type == NL80211_IFTYPE_AP ||
-	    sdata->vif.type == NL80211_IFTYPE_MESH_POINT) {
-		/*
-		 * always passing this is harmless, since it'll be the
-		 * same value that cfg80211 finds if it finds the same
-		 * interface ... and that's always allowed
-		 */
-		params.new_beacon_int = sdata->vif.bss_conf.beacon_int;
-	}
-
 	/* Always allow software iftypes */
 	if (cfg80211_iftype_allowed(local->hw.wiphy, iftype, 0, 1)) {
 		if (radar_detect)
@@ -3976,30 +4037,87 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 		return 0;
 	}
 
-	if (chandef)
-		params.num_different_channels = 1;
-
 	if (iftype != NL80211_IFTYPE_UNSPECIFIED)
-		params.iftype_num[iftype] = 1;
+		total_iface = 1;
 
-	list_for_each_entry(ctx, &local->chanctx_list, list) {
-		if (ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED)
-			continue;
-		params.radar_detect |=
-			ieee80211_chanctx_radar_detect(local, ctx);
-		if (ctx->mode == IEEE80211_CHANCTX_EXCLUSIVE) {
-			params.num_different_channels++;
+	list_for_each_entry_rcu(sdata_iter, &local->interfaces, list) {
+		if (sdata_iter == sdata)
 			continue;
+
+		total_iface++;
+	}
+
+	if (!total_iface)
+		goto skip;
+
+	ifaces = kcalloc(total_iface, sizeof(*ifaces), GFP_KERNEL);
+	if (!ifaces)
+		return -ENOMEM;
+
+	if (iftype != NL80211_IFTYPE_UNSPECIFIED) {
+		struct iface_combination_interface *iface;
+		unsigned int link_id;
+		bool ap_or_mesh = false;
+
+		iface = &ifaces[params.num_iface];
+		iface->iftype = iftype;
+
+		if (sdata->vif.type == NL80211_IFTYPE_AP ||
+		    sdata->vif.type == NL80211_IFTYPE_MESH_POINT)
+			ap_or_mesh = true;
+
+		rcu_read_lock();
+		for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
+			struct ieee80211_link_data *link_iter;
+			struct iface_combination_iface_link *iface_link;
+			struct ieee80211_chanctx *ctx;
+			bool radar_required = false;
+
+			link_iter = sdata_dereference(sdata->link[link_id], sdata);
+			if (!link_iter)
+				continue;
+
+			iface_link = &iface->links[link_id];
+
+			if (link_iter->link_id == link->link_id &&
+			    chandef) {
+				iface_link->freq = chandef->chan->center_freq;
+				iface_link->radar_detect = radar_detect;
+			} else {
+				if (ieee80211_link_get_new_chanctx(link_iter,
+								   &ctx,
+								   &radar_required))
+					continue;
+
+				if (ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED)
+					continue;
+
+				iface_link->freq = ctx->conf.def.chan->center_freq;
+
+				if (radar_required)
+					iface_link->radar_detect = BIT(ctx->conf.def.width);
+			}
+
+			links_radar_detect |= iface_link->radar_detect;
+
+			if (ap_or_mesh) {
+				/* always passing this is harmless, since it'll be the
+				 * same value that cfg80211 finds if it finds the same
+				 * interface ... and that's always allowed
+				 */
+				iface_link->new_beacon_int = link_iter->conf->beacon_int;
+			}
+
+			iface->valid_links = BIT(link_id);
 		}
-		if (chandef && chanmode == IEEE80211_CHANCTX_SHARED &&
-		    cfg80211_chandef_compatible(chandef,
-						&ctx->conf.def))
-			continue;
-		params.num_different_channels++;
+		rcu_read_unlock();
+
+		params.num_iface++;
 	}
 
 	list_for_each_entry_rcu(sdata_iter, &local->interfaces, list) {
 		struct wireless_dev *wdev_iter;
+		struct iface_combination_interface *iface;
 
 		wdev_iter = &sdata_iter->wdev;
 
@@ -4009,14 +4127,29 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 					    wdev_iter->iftype, 0, 1))
 			continue;
 
-		params.iftype_num[wdev_iter->iftype]++;
+		if (WARN_ON(params.num_iface >= total_iface))
+			continue;
+
+		iface = &ifaces[params.num_iface];
+		iface->iftype = wdev_iter->iftype;
+
+		links_radar_detect |= ieee80211_fill_combination_link(sdata_iter,
+								      chandef,
+								      chanmode,
+								      iface);
+		params.num_iface++;
 		total++;
 	}
 
-	if (total == 1 && !params.radar_detect)
-		return 0;
+	params.ifaces = ifaces;
+skip:
+	if (total == 1 && !links_radar_detect)
+		goto out;
 
-	return cfg80211_check_combinations(local->hw.wiphy, &params);
+	ret = cfg80211_check_combinations(local->hw.wiphy, &params);
+out:
+	kfree(ifaces);
+	return ret;
 }
 
 static void
@@ -4032,29 +4165,44 @@ ieee80211_iter_max_chans(const struct ieee80211_iface_combination *c,
 int ieee80211_max_num_channels(struct ieee80211_local *local)
 {
 	struct ieee80211_sub_if_data *sdata;
-	struct ieee80211_chanctx *ctx;
+	struct iface_combination_params params = {0};
+	struct iface_combination_interface *ifaces = NULL;
 	u32 max_num_different_channels = 1;
 	int err;
-	struct iface_combination_params params = {0};
+	u16 total_iface = 0;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	list_for_each_entry(ctx, &local->chanctx_list, list) {
-		if (ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED)
+	list_for_each_entry_rcu(sdata, &local->interfaces, list)
+		total_iface++;
+
+	if (!total_iface)
+		goto skip;
+
+	ifaces = kcalloc(total_iface, sizeof(*ifaces), GFP_KERNEL);
+	if (!ifaces)
+		return -ENOMEM;
+
+	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
+		struct iface_combination_interface *iface;
+
+		if (WARN_ON(params.num_iface >= total_iface))
 			continue;
 
-		params.num_different_channels++;
+		iface = &ifaces[params.num_iface];
+		iface->iftype = sdata->wdev.iftype;
 
-		params.radar_detect |=
-			ieee80211_chanctx_radar_detect(local, ctx);
-	}
+		ieee80211_fill_combination_link(sdata, NULL, 0, iface);
 
-	list_for_each_entry_rcu(sdata, &local->interfaces, list)
-		params.iftype_num[sdata->wdev.iftype]++;
+		params.num_iface++;
+	}
 
+	params.ifaces = ifaces;
+skip:
 	err = cfg80211_iter_combinations(local->hw.wiphy, &params,
 					 ieee80211_iter_max_chans,
 					 &max_num_different_channels);
+	kfree(ifaces);
 	if (err < 0)
 		return err;
 
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 2bde8a354631..f10b6af1d268 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2368,11 +2368,58 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 {
 	const struct ieee80211_regdomain *regdom;
 	enum nl80211_dfs_regions region = 0;
-	int i, j, iftype;
-	int num_interfaces = 0;
+	int i, j, k, iftype;
 	u32 used_iftypes = 0;
-	u32 beacon_int_gcd;
+	u32 beacon_int_gcd, link_beacon_int_gcd = 0;
+	u32 *freqs, num_different_channels = 0;
 	bool beacon_int_different;
+	u8 radar_detect = 0, link_id;
+
+	if (!params->num_iface)
+		goto skip;
+
+	freqs = kcalloc(params->num_iface * sizeof(params->ifaces->links),
+			sizeof(*freqs), GFP_KERNEL);
+	if (!freqs)
+		return -ENOMEM;
+
+	for (i = 0; i < params->num_iface; i++) {
+		const struct iface_combination_interface *iface;
+		u32 link_bi;
+
+		iface = &params->ifaces[i];
+		iftype = iface->iftype;
+		if (!cfg80211_iftype_allowed(wiphy, iftype, 0, 1))
+			used_iftypes |= BIT(iftype);
+
+		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
+		     link_id++) {
+			if (!(iface->valid_links & BIT(link_id)))
+				continue;
+
+			link_bi = iface->links[link_id].new_beacon_int;
+			if (link_bi && link_beacon_int_gcd != link_bi) {
+				link_beacon_int_gcd = gcd(link_beacon_int_gcd,
+							  link_bi);
+				beacon_int_different = true;
+			}
+
+			radar_detect |= iface->links[link_id].radar_detect;
+
+			/* check this freq is already match or not */
+			for (j = 0; j < num_different_channels; j++)
+				if (freqs[j] == iface->links[link_id].freq)
+					break;
+
+			/* if not match then its a different channel freq */
+			if (j == num_different_channels) {
+				freqs[j] = iface->links[link_id].freq;
+				num_different_channels++;
+			}
+		}
+	}
+
+	kfree(freqs);
 
 	/*
 	 * This is a bit strange, since the iteration used to rely only on
@@ -2384,10 +2431,10 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 	 * cfg80211 already - the only thing not would appear to be any new
 	 * interfaces (while being brought up) and channel/radar data.
 	 */
-	cfg80211_calculate_bi_data(wiphy, params->new_beacon_int,
+	cfg80211_calculate_bi_data(wiphy, link_beacon_int_gcd,
 				   &beacon_int_gcd, &beacon_int_different);
 
-	if (params->radar_detect) {
+	if (radar_detect) {
 		rcu_read_lock();
 		regdom = rcu_dereference(cfg80211_regdomain);
 		if (regdom)
@@ -2395,13 +2442,7 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 		rcu_read_unlock();
 	}
 
-	for (iftype = 0; iftype < NUM_NL80211_IFTYPES; iftype++) {
-		num_interfaces += params->iftype_num[iftype];
-		if (params->iftype_num[iftype] > 0 &&
-		    !cfg80211_iftype_allowed(wiphy, iftype, 0, 1))
-			used_iftypes |= BIT(iftype);
-	}
-
+skip:
 	for (i = 0; i < wiphy->n_iface_combinations; i++) {
 		const struct ieee80211_iface_combination *c;
 		struct ieee80211_iface_limit *limits;
@@ -2409,9 +2450,10 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 
 		c = &wiphy->iface_combinations[i];
 
-		if (num_interfaces > c->max_interfaces)
+		if (params->num_iface > c->max_interfaces)
 			continue;
-		if (params->num_different_channels > c->num_different_channels)
+
+		if (num_different_channels > c->num_different_channels)
 			continue;
 
 		limits = kmemdup(c->limits, sizeof(limits[0]) * c->n_limits,
@@ -2419,24 +2461,26 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 		if (!limits)
 			return -ENOMEM;
 
-		for (iftype = 0; iftype < NUM_NL80211_IFTYPES; iftype++) {
+		for (j = 0; j < params->num_iface; j++) {
+			iftype = params->ifaces[j].iftype;
+
 			if (cfg80211_iftype_allowed(wiphy, iftype, 0, 1))
 				continue;
-			for (j = 0; j < c->n_limits; j++) {
-				all_iftypes |= limits[j].types;
-				if (!(limits[j].types & BIT(iftype)))
+
+			for (k = 0; k < c->n_limits; k++) {
+				all_iftypes |= limits[k].types;
+				if (!(limits[k].types & BIT(iftype)))
 					continue;
-				if (limits[j].max < params->iftype_num[iftype])
+				if (!limits[k].max)
 					goto cont;
-				limits[j].max -= params->iftype_num[iftype];
+				limits[k].max--;
 			}
 		}
 
-		if (params->radar_detect !=
-			(c->radar_detect_widths & params->radar_detect))
+		if (radar_detect != (c->radar_detect_widths & radar_detect))
 			goto cont;
 
-		if (params->radar_detect && c->radar_detect_regions &&
+		if (radar_detect && c->radar_detect_regions &&
 		    !(c->radar_detect_regions & BIT(region)))
 			goto cont;
 

base-commit: a17b9f590f6ec2b9f1b12b1db3bf1d181de6b272
-- 
2.34.1


