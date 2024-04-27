Return-Path: <linux-wireless+bounces-6937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6848B43E5
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Apr 2024 05:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFA88B21AA4
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Apr 2024 03:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8689A3BBD4;
	Sat, 27 Apr 2024 03:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Cx5WLS4p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141A83A1C7
	for <linux-wireless@vger.kernel.org>; Sat, 27 Apr 2024 03:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714187727; cv=none; b=X7EFwNEzY2nefrFVxBfVri/tK4aJw4xWbEJraq0ngy/fL9NxxvcCrrDxm/o+zYfRXHVx/vdinVMJBsTNnAq6h+Tu3quYSh09uwD/TTGLqNR21V6EpqO5OiJZLAry7tilxND/Hh/LQVLimap4WkJ+rOROARTV/oCBuT78G/b14Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714187727; c=relaxed/simple;
	bh=ZROl/9YYb/VYWt0LAw5oYl9w1+KbTFDoErtf68Kt6vs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t8nZyr4hZN4BOTTOtGI+P8dYw29QWYZ3h0pj/iDry2LnInzks9umI3gI5PDdZsrBfjcBSxZ/jP7mnGaxD90LHivFYmV9zLOmAfV+VnwzMyQZaBDUwZ7Ld06wI5u2fvfAKPAzVrvsKZ2AbM2GWWw4lqIvJwxqHHEmjMl5VsgpG88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Cx5WLS4p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43R20U6P028346;
	Sat, 27 Apr 2024 03:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=rrgm6r9
	ewyPNo5SS/R2/ky1/r1Mp0ByF2TB6hg9MR4A=; b=Cx5WLS4ppqT1y7Mer7SLwVe
	2DWWUa/gxrxpaCL+eblYxX1mL18pnDd3T6ZpuiXxgnSpIg2h6nZqTV1xbc/rBiU0
	EN48h1cflxsfRXgcgN5ft/XGpCaF5b+N5+xDe58DCLIDM1wtXIeud9iATjbVaPUg
	RjE6MmCyovYn4Ck+xOhz7RBHPUzVFMV58ttHD6/6q9D7xBC7H6l1xJDFwg82Tf8l
	ZhB2ngTYZxQEKVSNRuiJxIflqOPLx40CpboVt1Vj60zWDtV8d5Tl3HsD6W1gQzuF
	Age4nKzn53clSrV73frSq8M4yf4nHtzomYnsmosisGpQKElJwDfAonbR6x16w/g=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xr35eucjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Apr 2024 03:15:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43R3FIRr026559
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Apr 2024 03:15:19 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 26 Apr 2024 20:15:17 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH RFC] wifi: cfg80211: Refactor interface combination input parameter
Date: Sat, 27 Apr 2024 08:45:03 +0530
Message-ID: <20240427031503.22870-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: ISr7npBdfMhmpKeIvQC-IbaWu87cwYgf
X-Proofpoint-ORIG-GUID: ISr7npBdfMhmpKeIvQC-IbaWu87cwYgf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_22,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404270022

Currently, the interface combination input parameter num_different_channels
and iftype_num are directly filled in by the caller under the assumption
that all channels and interfaces belong to a single hardware device. This
assumption is incorrect for multi-device interface combinations because
each device supports a different set of channels and interfaces. As
discussed in [1], need to refactor the input parameters to encode enough
data to handle both single and multiple device interface combinations.
This can be achieved by encoding the frequency and interface type under
the interface entity itself. With this new input parameter structure, the
cfg80211 can classify and construct the device parameters, then verify them
against the device specific interface combinations.

[1]: https://lore.kernel.org/linux-wireless/ca70eeb3cdee1e8c3caee69db595bc8160eb4115.camel@sipsolutions.net/

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  44 +++++--
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  60 +++++++--
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  32 +++--
 include/net/cfg80211.h                        |  37 +++++-
 net/mac80211/util.c                           | 124 +++++++++++++++---
 net/wireless/util.c                           |  56 ++++++--
 6 files changed, 276 insertions(+), 77 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 8993028709ec..3f9f5f56bd19 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -625,17 +625,25 @@ static int wil_cfg80211_validate_add_iface(struct wil6210_priv *wil,
 {
 	int i;
 	struct wireless_dev *wdev;
-	struct iface_combination_params params = {
-		.num_different_channels = 1,
-	};
+	struct iface_combination_params params = { 0 };
+	struct iface_combination_interface ifaces[WIL_MAX_VIFS] = { 0 };
 
 	for (i = 0; i < GET_MAX_VIFS(wil); i++) {
 		if (wil->vifs[i]) {
 			wdev = vif_to_wdev(wil->vifs[i]);
-			params.iftype_num[wdev->iftype]++;
+			ifaces[params.num_iface].iftype = wdev->iftype;
+			ifaces[params.num_iface].num_link = 1;
+			params.num_iface++;
 		}
 	}
-	params.iftype_num[new_type]++;
+
+	if (params.num_iface < WIL_MAX_VIFS) {
+		ifaces[params.num_iface].iftype = new_type;
+		ifaces[params.num_iface].num_link = 1;
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
+	struct iface_combination_params params = { 0 };
+	struct iface_combination_interface ifaces[WIL_MAX_VIFS] = { 0 };
 	bool check_combos = false;
 
 	for (i = 0; i < GET_MAX_VIFS(wil); i++) {
@@ -655,16 +662,25 @@ static int wil_cfg80211_validate_change_iface(struct wil6210_priv *wil,
 
 		if (vif_pos && vif != vif_pos) {
 			wdev = vif_to_wdev(vif_pos);
-			params.iftype_num[wdev->iftype]++;
+			ifaces[params.num_iface].iftype = wdev->iftype;
+			ifaces[params.num_iface].num_link = 1;
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
+		ifaces[params.num_iface].num_link = 1;
+		params.num_iface++;
 	}
-	return ret;
+	params.ifaces = ifaces;
+
+	return cfg80211_check_combinations(wil->wiphy, &params);
 }
 
 static struct wireless_dev *
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 5fe0e671ecb3..66d07e35cc34 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -496,22 +496,38 @@ static int brcmf_vif_change_validate(struct brcmf_cfg80211_info *cfg,
 	struct brcmf_cfg80211_vif *pos;
 	bool check_combos = false;
 	int ret = 0;
-	struct iface_combination_params params = {
-		.num_different_channels = 1,
-	};
+	struct iface_combination_params params = { 0 };
+	struct iface_combination_interface *ifaces = NULL;
+	u16 total_iface = 0;
 
 	list_for_each_entry(pos, &cfg->vif_list, list)
+		total_iface++;
+
+	ifaces = kcalloc(total_iface, sizeof(*ifaces), GFP_KERNEL);
+	if (!ifaces)
+		return -ENOMEM;
+
+	list_for_each_entry(pos, &cfg->vif_list, list) {
+		if (params.num_iface >= total_iface)
+			continue;
+
 		if (pos == vif) {
-			params.iftype_num[new_type]++;
+			ifaces[params.num_iface].iftype = new_type;
+			ifaces[params.num_iface].num_link = 1;
 		} else {
 			/* concurrent interfaces so need check combinations */
 			check_combos = true;
-			params.iftype_num[pos->wdev.iftype]++;
+			ifaces[params.num_iface].iftype = pos->wdev.iftype;
+			ifaces[params.num_iface].num_link = 1;
 		}
+		params.num_iface++;
+	}
+	params.ifaces = ifaces;
 
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
+	struct iface_combination_params params = { 0 };
+	struct iface_combination_interface *ifaces = NULL;
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
+		ifaces[params.num_iface].num_link = 1;
+		params.num_iface++;
+	}
+
+	if (params.num_iface < total_iface) {
+		ifaces[params.num_iface].iftype = new_type;
+		ifaces[params.num_iface].num_link = 1;
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
index 663d77770fce..ad1079a23ea8 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -79,26 +79,38 @@ qtnf_validate_iface_combinations(struct wiphy *wiphy,
 	struct qtnf_vif *vif;
 	int i;
 	int ret = 0;
-	struct iface_combination_params params = {
-		.num_different_channels = 1,
-	};
+	struct iface_combination_params params = { 0 };
+	struct iface_combination_interface ifaces[QTNF_MAX_INTF] = { 0 };
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
+			ifaces[params.num_iface].num_link = 1;
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
+		ifaces[params.num_iface].num_link = 1;
+		params.num_iface++;
 	}
+	params.ifaces = ifaces;
 
 	ret = cfg80211_check_combinations(wiphy, &params);
 
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 0112d645a2b4..4e04001087d5 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1587,28 +1587,51 @@ struct cfg80211_color_change_settings {
 	u8 color;
 };
 
+/**
+ * struct iface_combination_iface_link - Interface combination link parameter
+ *
+ * Used to pass link specific interface combination parameters
+ *
+ * @freq: center frequency used for verification against the different channels
+ */
+struct iface_combination_iface_link {
+	u32 freq;
+};
+
+/**
+ * struct iface_combination_interface - Interface parameter for iface combination
+ *
+ * Used to pass interface specific parameter for iface combination
+ *
+ * @iftype: interface type as specified in &enum nl80211_iftype.
+ * @links: array with the number of link parameter used for verification
+ * @num_link: the length of the @links parameter used in this interface
+ */
+struct iface_combination_interface {
+	enum nl80211_iftype iftype;
+	struct iface_combination_iface_link links[IEEE80211_MLD_MAX_NUM_LINKS];
+	u8 num_link;
+};
+
 /**
  * struct iface_combination_params - input parameters for interface combinations
  *
  * Used to pass interface combination parameters
  *
- * @num_different_channels: the number of different channels we want
- *	to use for verification
  * @radar_detect: a bitmap where each bit corresponds to a channel
  *	width where radar detection is needed, as in the definition of
  *	&struct ieee80211_iface_combination.@radar_detect_widths
- * @iftype_num: array with the number of interfaces of each interface
- *	type.  The index is the interface type as specified in &enum
- *	nl80211_iftype.
  * @new_beacon_int: set this to the beacon interval of a new interface
  *	that's not operating yet, if such is to be checked as part of
  *	the verification
+ * @ifaces: array with the number of interface parameter use for verification
+ * @num_iface: the length of the @ifaces interface parameter
  */
 struct iface_combination_params {
-	int num_different_channels;
 	u8 radar_detect;
-	int iftype_num[NUM_NL80211_IFTYPES];
 	u32 new_beacon_int;
+	const struct iface_combination_interface *ifaces;
+	u16 num_iface;
 };
 
 /**
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0b893e958959..0478cbedf4a4 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3942,10 +3942,12 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_sub_if_data *sdata_iter;
 	enum nl80211_iftype iftype = sdata->wdev.iftype;
 	struct ieee80211_chanctx *ctx;
-	int total = 1;
+	struct iface_combination_interface *ifaces = NULL;
+	int total = 1, ret = 0;
 	struct iface_combination_params params = {
 		.radar_detect = radar_detect,
 	};
+	u16 total_iface = 0;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -3976,30 +3978,48 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 		return 0;
 	}
 
-	if (chandef)
-		params.num_different_channels = 1;
-
-	if (iftype != NL80211_IFTYPE_UNSPECIFIED)
-		params.iftype_num[iftype] = 1;
-
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
 		if (ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED)
 			continue;
 		params.radar_detect |=
 			ieee80211_chanctx_radar_detect(local, ctx);
-		if (ctx->mode == IEEE80211_CHANCTX_EXCLUSIVE) {
-			params.num_different_channels++;
-			continue;
+	}
+
+	if (iftype != NL80211_IFTYPE_UNSPECIFIED || chandef)
+		total_iface = 1;
+
+	list_for_each_entry_rcu(sdata_iter, &local->interfaces, list)
+		total_iface++;
+
+	if (!total_iface)
+		goto skip;
+
+	ifaces = kcalloc(total_iface, sizeof(*ifaces), GFP_KERNEL);
+	if (!ifaces)
+		return -ENOMEM;
+
+	if (iftype != NL80211_IFTYPE_UNSPECIFIED || chandef) {
+		struct iface_combination_interface *iface;
+
+		iface = &ifaces[params.num_iface];
+		iface->iftype = iftype;
+
+		if (chandef && cfg80211_chandef_valid(chandef)) {
+			iface->links[0].freq = chandef->chan->center_freq;
+			iface->num_link++;
 		}
-		if (chandef && chanmode == IEEE80211_CHANCTX_SHARED &&
-		    cfg80211_chandef_compatible(chandef,
-						&ctx->conf.def))
-			continue;
-		params.num_different_channels++;
+
+		params.num_iface++;
 	}
 
 	list_for_each_entry_rcu(sdata_iter, &local->interfaces, list) {
 		struct wireless_dev *wdev_iter;
+		struct iface_combination_interface *iface;
+		struct ieee80211_bss_conf *link_conf;
+		unsigned int link_id;
+
+		if (params.num_iface >= total_iface)
+			continue;
 
 		wdev_iter = &sdata_iter->wdev;
 
@@ -4009,14 +4029,37 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 					    wdev_iter->iftype, 0, 1))
 			continue;
 
-		params.iftype_num[wdev_iter->iftype]++;
+		iface = &ifaces[params.num_iface];
+		iface->iftype = wdev_iter->iftype;
+
+		rcu_read_lock();
+		for_each_vif_active_link(&sdata_iter->vif, link_conf, link_id) {
+			struct ieee80211_chanctx_conf *chanctx_conf;
+			struct iface_combination_iface_link *link;
+
+			chanctx_conf = rcu_dereference(link_conf->chanctx_conf);
+			if (chanctx_conf &&
+			    cfg80211_chandef_valid(&chanctx_conf->def)) {
+				link = &iface->links[iface->num_link];
+				link->freq = chanctx_conf->def.chan->center_freq;
+				iface->num_link++;
+			}
+		}
+		rcu_read_unlock();
+
+		params.num_iface++;
 		total++;
 	}
 
+	params.ifaces = ifaces;
+skip:
 	if (total == 1 && !params.radar_detect)
-		return 0;
+		goto out;
 
-	return cfg80211_check_combinations(local->hw.wiphy, &params);
+	ret = cfg80211_check_combinations(local->hw.wiphy, &params);
+out:
+	kfree(ifaces);
+	return ret;
 }
 
 static void
@@ -4036,6 +4079,10 @@ int ieee80211_max_num_channels(struct ieee80211_local *local)
 	u32 max_num_different_channels = 1;
 	int err;
 	struct iface_combination_params params = {0};
+	struct iface_combination_interface *ifaces = NULL;
+	struct ieee80211_bss_conf *link_conf;
+	unsigned int link_id;
+	u16 total_iface = 0;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -4043,18 +4090,53 @@ int ieee80211_max_num_channels(struct ieee80211_local *local)
 		if (ctx->replace_state == IEEE80211_CHANCTX_WILL_BE_REPLACED)
 			continue;
 
-		params.num_different_channels++;
-
 		params.radar_detect |=
 			ieee80211_chanctx_radar_detect(local, ctx);
 	}
 
 	list_for_each_entry_rcu(sdata, &local->interfaces, list)
-		params.iftype_num[sdata->wdev.iftype]++;
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
+		if (params.num_iface >= total_iface)
+			continue;
+
+		iface = &ifaces[params.num_iface];
+		iface->iftype = sdata->wdev.iftype;
+
+		rcu_read_lock();
+		for_each_vif_active_link(&sdata->vif, link_conf, link_id) {
+			struct ieee80211_chanctx_conf *chanctx_conf;
+			struct iface_combination_iface_link *link;
+
+			chanctx_conf = rcu_dereference(link_conf->chanctx_conf);
+			if (chanctx_conf &&
+			    cfg80211_chandef_valid(&chanctx_conf->def)) {
+				link = &iface->links[iface->num_link];
+				link->freq = chanctx_conf->def.chan->center_freq;
+				iface->num_link++;
+			}
+		}
+		rcu_read_unlock();
+
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
index 2bde8a354631..7dc8582beb1d 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2368,10 +2368,10 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 {
 	const struct ieee80211_regdomain *regdom;
 	enum nl80211_dfs_regions region = 0;
-	int i, j, iftype;
-	int num_interfaces = 0;
+	int i, j, k, iftype;
 	u32 used_iftypes = 0;
 	u32 beacon_int_gcd;
+	u32 *freqs, num_different_channels = 0;
 	bool beacon_int_different;
 
 	/*
@@ -2395,13 +2395,38 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 		rcu_read_unlock();
 	}
 
-	for (iftype = 0; iftype < NUM_NL80211_IFTYPES; iftype++) {
-		num_interfaces += params->iftype_num[iftype];
-		if (params->iftype_num[iftype] > 0 &&
-		    !cfg80211_iftype_allowed(wiphy, iftype, 0, 1))
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
+
+		iface = &params->ifaces[i];
+		iftype = iface->iftype;
+		if (!cfg80211_iftype_allowed(wiphy, iftype, 0, 1))
 			used_iftypes |= BIT(iftype);
+
+		for (j = 0; j < iface->num_link; j++) {
+			/* check this freq is already match or not */
+			for (k = 0; k < num_different_channels; k++)
+				if (freqs[k] == iface->links[j].freq)
+					break;
+
+			/* if not match then its a different channel freq */
+			if (k == num_different_channels) {
+				freqs[k] = iface->links[j].freq;
+				num_different_channels++;
+			}
+		}
 	}
 
+	kfree(freqs);
+skip:
 	for (i = 0; i < wiphy->n_iface_combinations; i++) {
 		const struct ieee80211_iface_combination *c;
 		struct ieee80211_iface_limit *limits;
@@ -2409,9 +2434,9 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 
 		c = &wiphy->iface_combinations[i];
 
-		if (num_interfaces > c->max_interfaces)
+		if (params->num_iface > c->max_interfaces)
 			continue;
-		if (params->num_different_channels > c->num_different_channels)
+		if (num_different_channels > c->num_different_channels)
 			continue;
 
 		limits = kmemdup(c->limits, sizeof(limits[0]) * c->n_limits,
@@ -2419,16 +2444,19 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
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
 

base-commit: cc1380dd188204ada05936b034e93dbca9b5f06a
-- 
2.34.1


