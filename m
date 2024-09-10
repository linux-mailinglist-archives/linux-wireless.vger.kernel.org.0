Return-Path: <linux-wireless+bounces-12774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1BC974440
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 22:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75BF32890C2
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 20:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C731A7058;
	Tue, 10 Sep 2024 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oG7N1btQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B8A17622D
	for <linux-wireless@vger.kernel.org>; Tue, 10 Sep 2024 20:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726001164; cv=none; b=rF8jL+A0YkUW8ZcN8pR9PNcrcy/Cd/gxhyjts9EUGUbeZt2U2Idq6ZzHTx0iycdxxgzQtK3Fqfe54/Vaga1Fnayj/XI5eQAEB0Go8shRpyKcAUrprwwhDom7TPJmIYv2Z0wZB1HF5LPpyrDKa/fenRHZmJ36t0msMf+CeVXR0pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726001164; c=relaxed/simple;
	bh=uVvLkI0wod8R7rRc/Vw7ucY8J5k3lVtfDnA3u1Op99w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7KdgJKq0WGCeL5Taki292sPqetEpKH3WZsZQsDOSB5LUHlPi+P6qgFjsCAgs8QucN+1z8VgJtoL4cngOVOg/530cuJIxV8NP5cxR8fTIfzADUvM/laayzq2DM/61YXqTXNGkrzUf0IGTdFJuENXejuH6Hr6YL3PyjPbWbnXFRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oG7N1btQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AFFBVA021353;
	Tue, 10 Sep 2024 20:45:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fqFeq//+Ssu3x72ThEiYZfbIXc6FCYVWWBhX0UioUMw=; b=oG7N1btQIt0wx2ME
	TVusKLtQ8WdCK4p6z1QlI6JSDh0JWa2nLpU79pDBMtZxyqPLZ0VdZu7tOHyHC8Lg
	r0Egj3L/AWqJLpjo29bzUoQ6cavHWOpfHInHTnhMgAsnwIH7NvOU4s2bZILZjw/q
	Y49arHyg94ftmafoUDUIMfWd54in6FMcfPYnZDs9fyQONZRk2vlIbt0n7qQ7T8Kt
	C9S2MjNcoHnHSzyPm1Gr7ytqbHLiz/QIKFhmDOfB9J9IphEcOZzUFe3+eYcB/ADB
	z2Yjk7DtbkAQgbzFUuTb3CvpT3kENunp+XDH4bY8Cy1mijmtsPx+7psPtPwnMwuA
	kXNcVw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gybpqb6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 20:45:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48AKjvxm023943
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 20:45:57 GMT
Received: from msinada-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 10 Sep 2024 13:45:56 -0700
From: Muna Sinada <quic_msinada@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Rameshkumar Sundaram
	<quic_ramess@quicinc.com>,
        Muna Sinada <quic_msinada@quicinc.com>
Subject: [PATCH 2/2] wifi: mac80211: restructure vif and link conf for mlo mbssid support
Date: Tue, 10 Sep 2024 13:45:38 -0700
Message-ID: <20240910204538.4077640-3-quic_msinada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910204538.4077640-1-quic_msinada@quicinc.com>
References: <20240910204538.4077640-1-quic_msinada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ws5cV8UrJIonLswbqfgriFml4l4xYX4V
X-Proofpoint-GUID: ws5cV8UrJIonLswbqfgriFml4l4xYX4V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409100154

From: Rameshkumar Sundaram <quic_ramess@quicinc.com>

For MLD, if transmitting interface is an MLD then Tx link inside that
MLD has to be saved inside non-Tx MLD's link. With MLO, there are
multiple links where each link can have its own transmitting vif.

Currently mbssid_tx_vif is inside vif structure which won't suffice for
finding Tx link for any non-Tx link since it is not link specific.

Move mbssid_tx_vif to ieee80211_bss_conf and add mbssid_tx_vif_linkid
to ieee80211_bss_conf as well. These two members are used to find Tx
vif and Tx link inside the Tx vif for any non-Tx link.

Modify CSA completion and BCCA event notifier routines to fetch
non-Tx BSS links based on mbssid_tx_vif and mbssid_tx_vif_linkid.

Update mbssid_tx_vif to be accessed from struct ieee80211_bss_conf
instead of struct ieee80211_vif in ATH drivers.

Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
Signed-off-by: Muna Sinada <quic_msinada@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c         | 20 ++--
 drivers/net/wireless/ath/ath12k/mac.c         | 18 ++--
 drivers/net/wireless/virtual/mac80211_hwsim.c |  2 +-
 include/net/mac80211.h                        |  7 +-
 net/mac80211/cfg.c                            | 86 ++++++++++++++---
 net/mac80211/ieee80211_i.h                    |  1 +
 net/mac80211/iface.c                          | 94 +++++++++++++++----
 net/wireless/sme.c                            |  4 +-
 8 files changed, 174 insertions(+), 58 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 7c0ef6916dd2..7f81fef2d8e7 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1538,7 +1538,7 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
 	u32 params = 0;
 	u8 i = 0;
 
-	tx_arvif = ath11k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
+	tx_arvif = ath11k_vif_to_arvif(arvif->vif->bss_conf.mbssid_tx_vif);
 
 	beacons = ieee80211_beacon_get_template_ema_list(tx_arvif->ar->hw,
 							 tx_arvif->vif, 0);
@@ -1596,8 +1596,8 @@ static int ath11k_mac_setup_bcn_tmpl_mbssid(struct ath11k_vif *arvif)
 	struct sk_buff *bcn;
 	int ret;
 
-	if (vif->mbssid_tx_vif) {
-		tx_arvif = ath11k_vif_to_arvif(vif->mbssid_tx_vif);
+	if (vif->bss_conf.mbssid_tx_vif) {
+		tx_arvif = ath11k_vif_to_arvif(vif->bss_conf.mbssid_tx_vif);
 		if (tx_arvif != arvif) {
 			ar = tx_arvif->ar;
 			ab = ar->ab;
@@ -1639,11 +1639,11 @@ static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
 	/* Target does not expect beacon templates for the already up
 	 * non-transmitting interfaces, and results in a crash if sent.
 	 */
-	if (vif->mbssid_tx_vif &&
-	    arvif != ath11k_vif_to_arvif(vif->mbssid_tx_vif) && arvif->is_up)
+	if (vif->bss_conf.mbssid_tx_vif &&
+	    arvif != ath11k_vif_to_arvif(vif->bss_conf.mbssid_tx_vif) && arvif->is_up)
 		return 0;
 
-	if (vif->bss_conf.ema_ap && vif->mbssid_tx_vif)
+	if (vif->bss_conf.ema_ap && vif->bss_conf.mbssid_tx_vif)
 		return ath11k_mac_setup_bcn_tmpl_ema(arvif);
 
 	return ath11k_mac_setup_bcn_tmpl_mbssid(arvif);
@@ -1703,8 +1703,8 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 
 	ether_addr_copy(arvif->bssid, info->bssid);
 
-	if (arvif->vif->mbssid_tx_vif)
-		tx_arvif = ath11k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
+	if (arvif->vif->bss_conf.mbssid_tx_vif)
+		tx_arvif = ath11k_vif_to_arvif(arvif->vif->bss_conf.mbssid_tx_vif);
 
 	ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
 				 arvif->bssid,
@@ -6334,7 +6334,7 @@ static int ath11k_mac_setup_vdev_params_mbssid(struct ath11k_vif *arvif,
 	struct ieee80211_vif *tx_vif;
 
 	*tx_vdev_id = 0;
-	tx_vif = arvif->vif->mbssid_tx_vif;
+	tx_vif = arvif->vif->bss_conf.mbssid_tx_vif;
 	if (!tx_vif) {
 		*flags = WMI_HOST_VDEV_FLAGS_NON_MBSSID_AP;
 		return 0;
@@ -7350,7 +7350,7 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 			ath11k_warn(ab, "failed to update bcn tmpl during csa: %d\n",
 				    ret);
 
-		mbssid_tx_vif = arvif->vif->mbssid_tx_vif;
+		mbssid_tx_vif = arvif->vif->bss_conf.mbssid_tx_vif;
 		if (mbssid_tx_vif)
 			tx_arvif = ath11k_vif_to_arvif(mbssid_tx_vif);
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index ce41c8153080..adbe95ff916d 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1480,7 +1480,7 @@ static int ath12k_mac_setup_bcn_tmpl_ema(struct ath12k_vif *arvif)
 	int ret = 0;
 	u8 i;
 
-	tx_arvif = ath12k_vif_to_arvif(arvif->vif->mbssid_tx_vif);
+	tx_arvif = ath12k_vif_to_arvif(arvif->vif->bss_conf.mbssid_tx_vif);
 	beacons = ieee80211_beacon_get_template_ema_list(ath12k_ar_to_hw(tx_arvif->ar),
 							 tx_arvif->vif, 0);
 	if (!beacons || !beacons->cnt) {
@@ -1534,8 +1534,8 @@ static int ath12k_mac_setup_bcn_tmpl(struct ath12k_vif *arvif)
 	if (arvif->vdev_type != WMI_VDEV_TYPE_AP)
 		return 0;
 
-	if (vif->mbssid_tx_vif) {
-		tx_arvif = ath12k_vif_to_arvif(vif->mbssid_tx_vif);
+	if (vif->bss_conf.mbssid_tx_vif) {
+		tx_arvif = ath12k_vif_to_arvif(vif->bss_conf.mbssid_tx_vif);
 		if (tx_arvif != arvif && arvif->is_up)
 			return 0;
 
@@ -1629,8 +1629,9 @@ static void ath12k_control_beaconing(struct ath12k_vif *arvif,
 	params.vdev_id = arvif->vdev_id;
 	params.aid = arvif->aid;
 	params.bssid = arvif->bssid;
-	if (arvif->vif->mbssid_tx_vif) {
-		params.tx_bssid = ath12k_vif_to_arvif(arvif->vif->mbssid_tx_vif)->bssid;
+	if (arvif->vif->bss_conf.mbssid_tx_vif) {
+		params.tx_bssid =
+			   ath12k_vif_to_arvif(arvif->vif->bss_conf.mbssid_tx_vif)->bssid;
 		params.nontx_profile_idx = info->bssid_index;
 		params.nontx_profile_cnt = 1 << info->bssid_indicator;
 	}
@@ -6225,7 +6226,7 @@ ath12k_mac_get_vdev_stats_id(struct ath12k_vif *arvif)
 static int ath12k_mac_setup_vdev_params_mbssid(struct ath12k_vif *arvif,
 					       u32 *flags, u32 *tx_vdev_id)
 {
-	struct ieee80211_vif *tx_vif = arvif->vif->mbssid_tx_vif;
+	struct ieee80211_vif *tx_vif = arvif->vif->bss_conf.mbssid_tx_vif;
 	struct ath12k *ar = arvif->ar;
 	struct ath12k_vif *tx_arvif;
 
@@ -7486,8 +7487,9 @@ ath12k_mac_update_vif_chan(struct ath12k *ar,
 		params.vdev_id = arvif->vdev_id;
 		params.aid = arvif->aid;
 		params.bssid = arvif->bssid;
-		if (vif->mbssid_tx_vif) {
-			params.tx_bssid = ath12k_vif_to_arvif(vif->mbssid_tx_vif)->bssid;
+		if (vif->bss_conf.mbssid_tx_vif) {
+			params.tx_bssid =
+				  ath12k_vif_to_arvif(vif->bss_conf.mbssid_tx_vif)->bssid;
 			params.nontx_profile_idx = vif->bss_conf.bssid_index;
 			params.nontx_profile_cnt = 1 << vif->bss_conf.bssid_indicator;
 		}
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index d86e6ff4523d..68cff96d9cb8 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2290,7 +2290,7 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
 	    vif->type != NL80211_IFTYPE_OCB)
 		return;
 
-	if (vif->mbssid_tx_vif && vif->mbssid_tx_vif != vif)
+	if (link_conf->mbssid_tx_vif && link_conf->mbssid_tx_vif != vif)
 		return;
 
 	if (vif->bss_conf.ema_ap) {
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 0a04eaf5343c..b605aa750c59 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -682,6 +682,8 @@ struct ieee80211_parsed_tpe {
  *	responder functionality.
  * @ftmr_params: configurable lci/civic parameter when enabling FTM responder.
  * @nontransmitted: this BSS is a nontransmitted BSS profile
+ * @mbssid_tx_vif: Pointer to the transmitting interface if MBSSID is enabled.
+ * @mbssid_tx_vif_linkid: Link id of Tx link for non-Tx link.
  * @transmitter_bssid: the address of transmitter AP
  * @bssid_index: index inside the multiple BSSID set
  * @bssid_indicator: 2^bssid_indicator is the maximum number of APs in set
@@ -790,6 +792,8 @@ struct ieee80211_bss_conf {
 	struct ieee80211_ftm_responder_params *ftmr_params;
 	/* Multiple BSSID data */
 	bool nontransmitted;
+	struct ieee80211_vif *mbssid_tx_vif;
+	int mbssid_tx_vif_linkid;
 	u8 transmitter_bssid[ETH_ALEN];
 	u8 bssid_index;
 	u8 bssid_indicator;
@@ -2004,7 +2008,6 @@ enum ieee80211_neg_ttlm_res {
  * @txq: the multicast data TX queue
  * @offload_flags: 802.3 -> 802.11 enapsulation offload flags, see
  *	&enum ieee80211_offload_flags.
- * @mbssid_tx_vif: Pointer to the transmitting interface if MBSSID is enabled.
  */
 struct ieee80211_vif {
 	enum nl80211_iftype type;
@@ -2032,8 +2035,6 @@ struct ieee80211_vif {
 	bool probe_req_reg;
 	bool rx_mcast_action_reg;
 
-	struct ieee80211_vif *mbssid_tx_vif;
-
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b02b84ce2130..729d1b88f9fc 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -142,8 +142,10 @@ static int ieee80211_set_ap_mbssid_options(struct ieee80211_sub_if_data *sdata,
 					   struct ieee80211_bss_conf *link_conf)
 {
 	struct ieee80211_sub_if_data *tx_sdata;
+	struct ieee80211_link_data *tx_link;
 
-	sdata->vif.mbssid_tx_vif = NULL;
+	link_conf->mbssid_tx_vif = NULL;
+	link_conf->mbssid_tx_vif_linkid = -1;
 	link_conf->bssid_index = 0;
 	link_conf->nontransmitted = false;
 	link_conf->ema_ap = false;
@@ -157,9 +159,25 @@ static int ieee80211_set_ap_mbssid_options(struct ieee80211_sub_if_data *sdata,
 		return -EINVAL;
 
 	if (tx_sdata == sdata) {
-		sdata->vif.mbssid_tx_vif = &sdata->vif;
+		link_conf->mbssid_tx_vif = &sdata->vif;
+		link_conf->mbssid_tx_vif_linkid = link_conf->link_id;
 	} else {
-		sdata->vif.mbssid_tx_vif = &tx_sdata->vif;
+		rcu_read_lock();
+		tx_link = rcu_dereference(tx_sdata->link[params.tx_link_id]);
+		if (!tx_link || !tx_link->conf) {
+			rcu_read_unlock();
+			return -ENOLINK;
+		}
+		/* Make sure input tx vif from user is really configured as a
+		 * transmitting vif as per our internal data before referring it.
+		 */
+		if (tx_link->conf->mbssid_tx_vif != &tx_sdata->vif) {
+			rcu_read_unlock();
+			return -EINVAL;
+		}
+		link_conf->mbssid_tx_vif = &tx_sdata->vif;
+		link_conf->mbssid_tx_vif_linkid = tx_link->link_id;
+		rcu_read_unlock();
 		link_conf->nontransmitted = true;
 		link_conf->bssid_index = params.index;
 	}
@@ -1641,7 +1659,6 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	kfree(link_conf->ftmr_params);
 	link_conf->ftmr_params = NULL;
 
-	sdata->vif.mbssid_tx_vif = NULL;
 	link_conf->bssid_index = 0;
 	link_conf->nontransmitted = false;
 	link_conf->ema_ap = false;
@@ -1655,6 +1672,9 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 		ieee80211_free_key_list(local, &keys);
 	}
 
+	ieee80211_stop_mbssid(sdata);
+	link_conf->mbssid_tx_vif = NULL;
+	link_conf->mbssid_tx_vif_linkid = -1;
 	link_conf->enable_beacon = false;
 	sdata->beacon_rate_set = false;
 	sdata->vif.cfg.ssid_len = 0;
@@ -3636,23 +3656,41 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id)
 		return;
 	}
 
-	/* TODO: MBSSID with MLO changes */
-	if (vif->mbssid_tx_vif == vif) {
+	if (link_data->conf->mbssid_tx_vif == vif &&
+	    link_data->conf->mbssid_tx_vif_linkid == link_data->conf->link_id) {
 		/* Trigger ieee80211_csa_finish() on the non-transmitting
 		 * interfaces when channel switch is received on
 		 * transmitting interface
 		 */
 		struct ieee80211_sub_if_data *iter;
+		struct ieee80211_link_data *link_iter;
+		unsigned int link_id_iter;
+		unsigned long valid_links;
 
 		list_for_each_entry_rcu(iter, &local->interfaces, list) {
 			if (!ieee80211_sdata_running(iter))
 				continue;
 
-			if (iter == sdata || iter->vif.mbssid_tx_vif != vif)
+			if (iter == sdata)
 				continue;
 
-			wiphy_work_queue(iter->local->hw.wiphy,
-					 &iter->deflink.csa.finalize_work);
+			/* check link 0 by default for Non-ML non-tx vif's deflinks */
+			valid_links = iter->vif.valid_links | BIT(0);
+			for_each_set_bit(link_id_iter, &valid_links,
+					 IEEE80211_MLD_MAX_NUM_LINKS) {
+				link_iter = rcu_dereference(iter->link[link_id_iter]);
+				if (!link_iter)
+					continue;
+				/* Check if any of link of iterator sdata belongs
+				 * to same mbssid group as the tx link
+				 */
+				if (link_iter->conf->mbssid_tx_vif != vif ||
+				    link_iter->conf->mbssid_tx_vif_linkid != link_data->link_id)
+					continue;
+
+				wiphy_work_queue(iter->local->hw.wiphy,
+						 &link_iter->csa.finalize_work);
+			}
 		}
 	}
 	wiphy_work_queue(local->hw.wiphy, &link_data->csa.finalize_work);
@@ -4757,15 +4795,35 @@ ieee80211_color_change_bss_config_notify(struct ieee80211_link_data *link,
 
 	ieee80211_link_info_change_notify(sdata, link, changed);
 
-	if (!sdata->vif.bss_conf.nontransmitted && sdata->vif.mbssid_tx_vif) {
+	if (!link->conf->nontransmitted && link->conf->mbssid_tx_vif) {
 		struct ieee80211_sub_if_data *child;
+		unsigned int link_id_iter;
+		unsigned long valid_links;
+		struct ieee80211_link_data *link_iter;
 
 		list_for_each_entry(child, &sdata->local->interfaces, list) {
-			if (child != sdata && child->vif.mbssid_tx_vif == &sdata->vif) {
-				child->vif.bss_conf.he_bss_color.color = color;
-				child->vif.bss_conf.he_bss_color.enabled = enable;
+			if (child == sdata)
+				continue;
+
+			/* check deflink by default */
+			valid_links = child->vif.valid_links | BIT(0);
+			for_each_set_bit(link_id_iter, &valid_links,
+					 IEEE80211_MLD_MAX_NUM_LINKS) {
+				link_iter = sdata_dereference(child->link[link_id_iter],
+							      child);
+				if (!link_iter)
+					continue;
+				/* Check if any of link of iterator sdata belongs
+				 * to same mbssid group as the tx link
+				 */
+				if (link_iter->conf->mbssid_tx_vif != &sdata->vif ||
+				    link_iter->conf->mbssid_tx_vif_linkid != link->link_id)
+					continue;
+
+				link_iter->conf->he_bss_color.color = color;
+				link_iter->conf->he_bss_color.enabled = enable;
 				ieee80211_link_info_change_notify(child,
-								  &child->deflink,
+								  link_iter,
 								  BSS_CHANGED_HE_BSS_COLOR);
 			}
 		}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a3485e4c6132..751f055a70af 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2708,6 +2708,7 @@ int ieee80211_req_neg_ttlm(struct ieee80211_sub_if_data *sdata,
 void ieee80211_check_wbrf_support(struct ieee80211_local *local);
 void ieee80211_add_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef);
 void ieee80211_remove_wbrf(struct ieee80211_local *local, struct cfg80211_chan_def *chandef);
+void ieee80211_stop_mbssid(struct ieee80211_sub_if_data *sdata);
 
 #if IS_ENABLED(CONFIG_MAC80211_KUNIT_TEST)
 #define EXPORT_SYMBOL_IF_MAC80211_KUNIT(sym) EXPORT_SYMBOL_IF_KUNIT(sym)
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index b4ad66af3af3..3378b89f71da 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -717,30 +717,80 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		ieee80211_add_virtual_monitor(local);
 }
 
-static void ieee80211_stop_mbssid(struct ieee80211_sub_if_data *sdata)
+void ieee80211_stop_mbssid(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_sub_if_data *tx_sdata, *non_tx_sdata, *tmp_sdata;
-	struct ieee80211_vif *tx_vif = sdata->vif.mbssid_tx_vif;
+	struct ieee80211_vif *tx_vif;
+	unsigned int link_id, tx_link_id, iter_link_id;
+	unsigned long iter_valid_links, valid_links;
+	struct ieee80211_link_data *link_iter, *link;
 
-	if (!tx_vif)
-		return;
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+	/* Check link 0 by default for non MLO. */
+	iter_valid_links = sdata->vif.valid_links | BIT(0);
+	/* Check if any of the links of current sdata is an MBSSID. */
+	for_each_set_bit(iter_link_id, &iter_valid_links,
+			 IEEE80211_MLD_MAX_NUM_LINKS) {
+		link_iter = sdata_dereference(sdata->link[iter_link_id], sdata);
+		if (!link_iter)
+			continue;
+
+		tx_link_id = link_iter->conf->mbssid_tx_vif_linkid;
+		tx_vif = link_iter->conf->mbssid_tx_vif;
+		if (!tx_vif)
+			continue;
 
-	tx_sdata = vif_to_sdata(tx_vif);
-	sdata->vif.mbssid_tx_vif = NULL;
+		tx_sdata = vif_to_sdata(tx_vif);
+		link_iter->conf->mbssid_tx_vif = NULL;
 
-	list_for_each_entry_safe(non_tx_sdata, tmp_sdata,
-				 &tx_sdata->local->interfaces, list) {
-		if (non_tx_sdata != sdata && non_tx_sdata != tx_sdata &&
-		    non_tx_sdata->vif.mbssid_tx_vif == tx_vif &&
-		    ieee80211_sdata_running(non_tx_sdata)) {
-			non_tx_sdata->vif.mbssid_tx_vif = NULL;
-			dev_close(non_tx_sdata->wdev.netdev);
+		/* If we are not tx sdata reset tx sdata's tx_vif to avoid recusrion while
+		 * closing tx sdata at the end of outer loop below.
+		 */
+		if (sdata != tx_sdata) {
+			link = sdata_dereference(tx_sdata->link[tx_link_id], tx_sdata);
+			if (!link)
+				continue;
+			link->conf->mbssid_tx_vif = NULL;
+		}
+
+		/* loop through sdatas to find if any of their links
+		 * belong to same mbssid group as the one getting deleted.
+		 */
+		list_for_each_entry_safe(non_tx_sdata, tmp_sdata,
+					 &tx_sdata->local->interfaces, list) {
+			if (non_tx_sdata != sdata && non_tx_sdata != tx_sdata &&
+			    ieee80211_sdata_running(non_tx_sdata)) {
+				valid_links = non_tx_sdata->vif.valid_links | BIT(0);
+				for_each_set_bit(link_id, &valid_links,
+						 IEEE80211_MLD_MAX_NUM_LINKS) {
+					link = sdata_dereference(non_tx_sdata->link[link_id],
+								 non_tx_sdata);
+					if (!link)
+						continue;
+
+					/* If both tx vif and tx linkid is matching then it belongs
+					 * to same MBSSID group.
+					 */
+					if (link->conf->mbssid_tx_vif != tx_vif ||
+					    link->conf->mbssid_tx_vif_linkid != tx_link_id)
+						continue;
+
+					link->conf->mbssid_tx_vif = NULL;
+
+					/* Remove all links of matching MLD until dynamic link
+					 * removal can be supported.
+					 */
+					cfg80211_stop_iface(non_tx_sdata->wdev.wiphy,
+							    &non_tx_sdata->wdev, GFP_KERNEL);
+				}
+			}
 		}
-	}
 
-	if (sdata != tx_sdata && ieee80211_sdata_running(tx_sdata)) {
-		tx_sdata->vif.mbssid_tx_vif = NULL;
-		dev_close(tx_sdata->wdev.netdev);
+		/* If we are not tx sdata, remove links of tx sdata and proceed.
+		 */
+		if (sdata != tx_sdata && ieee80211_sdata_running(tx_sdata))
+			cfg80211_stop_iface(tx_sdata->wdev.wiphy,
+					    &tx_sdata->wdev, GFP_KERNEL);
 	}
 }
 
@@ -748,20 +798,24 @@ static int ieee80211_stop(struct net_device *dev)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 
-	/* close dependent VLAN and MBSSID interfaces before locking wiphy */
+	/* close dependent VLAN interfaces before locking wiphy */
 	if (sdata->vif.type == NL80211_IFTYPE_AP) {
 		struct ieee80211_sub_if_data *vlan, *tmpsdata;
 
 		list_for_each_entry_safe(vlan, tmpsdata, &sdata->u.ap.vlans,
 					 u.vlan.list)
 			dev_close(vlan->dev);
-
-		ieee80211_stop_mbssid(sdata);
 	}
 
 	wiphy_lock(sdata->local->hw.wiphy);
 	wiphy_work_cancel(sdata->local->hw.wiphy, &sdata->activate_links_work);
 
+	/* Close the dependent MBSSID interfaces with wiphy lock as we may be terminating
+	 * its partner links too in case of MLD.
+	 */
+	if (sdata->vif.type == NL80211_IFTYPE_AP)
+		ieee80211_stop_mbssid(sdata);
+
 	ieee80211_do_stop(sdata, true);
 	wiphy_unlock(sdata->local->hw.wiphy);
 
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index d9d7bf8bb5c1..5d5abf2c3e91 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1581,7 +1581,7 @@ void cfg80211_autodisconnect_wk(struct work_struct *work)
 		container_of(work, struct wireless_dev, disconnect_wk);
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 
-	wiphy_lock(wdev->wiphy);
+	wiphy_lock(&rdev->wiphy);
 
 	if (wdev->conn_owner_nlportid) {
 		switch (wdev->iftype) {
@@ -1618,5 +1618,5 @@ void cfg80211_autodisconnect_wk(struct work_struct *work)
 		}
 	}
 
-	wiphy_unlock(wdev->wiphy);
+	wiphy_unlock(&rdev->wiphy);
 }
-- 
2.34.1


