Return-Path: <linux-wireless+bounces-12583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7852696EADF
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 08:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F051C21D6B
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 06:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFF214B08E;
	Fri,  6 Sep 2024 06:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Cx6nGxbY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA99B14A09C
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 06:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605102; cv=none; b=sD9RNoic7NBa4YB5LdPz5B87X87bGWpcE3tdKuBkallV7ag5emgXd6aWS5TuAxEh64XdjmJRjbRxoozilRprW2oy5z/G6hcll7q2ydjaw4FckPbxz325vw5TrC3jw3T36QTY0ounMUZb63+H+X8XjYeQ8sJ+XHiqCyKDmQ9wLAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605102; c=relaxed/simple;
	bh=Rl3BsC2VamQLXV6K3hj0spS48xCU6b7u9dd2Vo3GbjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcOQ/kPp2A2VKRLkABL/ChawHRyei3pFfnMHqIXf44LXulb3oX7ugoxJ4G8BGW6hVO3PdJWpI6aNlgxp6+oHu9tmLVhm/P2jg7FD8kTxVUVzCspzTJu2vfPa0mh7usCiBz6SupEnF/1PNn2Lup5lqDymOc+jRgFe667yjIbkM9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Cx6nGxbY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IQRdj027910;
	Fri, 6 Sep 2024 06:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5HxKWVKg6+EG7OQpCs47nnVQaEteeFcByD/oTl7xz+I=; b=Cx6nGxbYDKnz8Uvc
	m0p4902SoAe2daYfWpz5wUezekwrD3zUV8BfDIfJWSbXJC9vMvnwrI69POXIvyt9
	AVlifLrwSHn8zbZ6olspx7xCmGMSofAWRixjQPvlhs/7Y6VhKh0EnK2XFJeHOo6f
	wMqqAs8ZceVOSkZBLtRKQIgb3KYP895S7e9VSY6TYuwtUS+2zmcwAmgrFPYuEV4v
	WUTVn8wscnVawFtofuQp3HTlis+Uzc6326N4CCdtHTkWMpzoynl4ndAejFKGHNKn
	SJqNJMUJRGAV6eqGI/a3WDcVZcb9mq4RbGkSnuEKrjbINBdvGp/dN9ldJz/9hbpX
	b67yNw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhx1sbud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 06:44:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4866ipYq001298
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 06:44:51 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Sep 2024 23:44:49 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH v6 4/8] wifi: cfg80211: move DFS related members to links[] in wireless_dev
Date: Fri, 6 Sep 2024 12:14:22 +0530
Message-ID: <20240906064426.2101315-5-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906064426.2101315-1-quic_adisi@quicinc.com>
References: <20240906064426.2101315-1-quic_adisi@quicinc.com>
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
X-Proofpoint-ORIG-GUID: bdDPhgNH-xUKHabTDxKwfr3bu_59RPSE
X-Proofpoint-GUID: bdDPhgNH-xUKHabTDxKwfr3bu_59RPSE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409060047

A few members related to DFS handling are currently under per wireless
device data structure. However, in order to support DFS with MLO, there is
a need to have them on a per-link manner.

Hence, as a preliminary step, move members cac_started, cac_start_time
and cac_time_ms to be on a per-link basis.

Since currently, link ID is not known at all places, use default value of
0 for now.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/marvell/mwifiex/11h.c      |  4 ++--
 drivers/net/wireless/marvell/mwifiex/cfg80211.c |  4 ++--
 drivers/net/wireless/quantenna/qtnfmac/event.c  |  6 +++---
 include/net/cfg80211.h                          | 17 +++++++++--------
 net/mac80211/cfg.c                              |  8 ++++----
 net/mac80211/iface.c                            |  2 +-
 net/mac80211/mlme.c                             |  2 +-
 net/mac80211/scan.c                             |  2 +-
 net/mac80211/util.c                             |  2 +-
 net/wireless/ibss.c                             |  2 +-
 net/wireless/mesh.c                             |  2 +-
 net/wireless/mlme.c                             | 11 ++++++-----
 net/wireless/nl80211.c                          | 10 +++++-----
 net/wireless/reg.c                              |  2 +-
 14 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11h.c b/drivers/net/wireless/marvell/mwifiex/11h.c
index b90f922f1cdc..fb2cad096758 100644
--- a/drivers/net/wireless/marvell/mwifiex/11h.c
+++ b/drivers/net/wireless/marvell/mwifiex/11h.c
@@ -117,7 +117,7 @@ void mwifiex_dfs_cac_work_queue(struct work_struct *work)
 				     dfs_cac_work);
 
 	chandef = priv->dfs_chandef;
-	if (priv->wdev.cac_started) {
+	if (priv->wdev.links[0].cac_started) {
 		mwifiex_dbg(priv->adapter, MSG,
 			    "CAC timer finished; No radar detected\n");
 		cfg80211_cac_event(priv->netdev, &chandef,
@@ -174,7 +174,7 @@ int mwifiex_stop_radar_detection(struct mwifiex_private *priv,
  */
 void mwifiex_abort_cac(struct mwifiex_private *priv)
 {
-	if (priv->wdev.cac_started) {
+	if (priv->wdev.links[0].cac_started) {
 		if (mwifiex_stop_radar_detection(priv, &priv->dfs_chandef))
 			mwifiex_dbg(priv->adapter, ERROR,
 				    "failed to stop CAC in FW\n");
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 5209e1c7d2e7..9d154c42465e 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -1906,7 +1906,7 @@ mwifiex_cfg80211_del_station(struct wiphy *wiphy, struct net_device *dev,
 	struct mwifiex_sta_node *sta_node;
 	u8 deauth_mac[ETH_ALEN];
 
-	if (!priv->bss_started && priv->wdev.cac_started) {
+	if (!priv->bss_started && priv->wdev.links[0].cac_started) {
 		mwifiex_dbg(priv->adapter, INFO, "%s: abort CAC!\n", __func__);
 		mwifiex_abort_cac(priv);
 	}
@@ -4038,7 +4038,7 @@ mwifiex_cfg80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 		return -EBUSY;
 	}
 
-	if (priv->wdev.cac_started)
+	if (priv->wdev.links[0].cac_started)
 		return -EBUSY;
 
 	if (cfg80211_chandef_identical(&params->chandef,
diff --git a/drivers/net/wireless/quantenna/qtnfmac/event.c b/drivers/net/wireless/quantenna/qtnfmac/event.c
index 76b07db284f8..8bd1e14e5de9 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/event.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/event.c
@@ -520,21 +520,21 @@ static int qtnf_event_handle_radar(struct qtnf_vif *vif,
 		cfg80211_radar_event(wiphy, &chandef, GFP_KERNEL);
 		break;
 	case QLINK_RADAR_CAC_FINISHED:
-		if (!vif->wdev.cac_started)
+		if (!vif->wdev.links[0].cac_started)
 			break;
 
 		cfg80211_cac_event(vif->netdev, &chandef,
 				   NL80211_RADAR_CAC_FINISHED, GFP_KERNEL);
 		break;
 	case QLINK_RADAR_CAC_ABORTED:
-		if (!vif->wdev.cac_started)
+		if (!vif->wdev.links[0].cac_started)
 			break;
 
 		cfg80211_cac_event(vif->netdev, &chandef,
 				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL);
 		break;
 	case QLINK_RADAR_CAC_STARTED:
-		if (vif->wdev.cac_started)
+		if (vif->wdev.links[0].cac_started)
 			break;
 
 		if (!wiphy_ext_feature_isset(wiphy,
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 192d72c8b465..727a94a6b7c3 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6194,9 +6194,6 @@ enum ieee80211_ap_reg_power {
  * @address: The address for this device, valid only if @netdev is %NULL
  * @is_running: true if this is a non-netdev device that has been started, e.g.
  *	the P2P Device.
- * @cac_started: true if DFS channel availability check has been started
- * @cac_start_time: timestamp (jiffies) when the dfs state was entered.
- * @cac_time_ms: CAC time in ms
  * @ps: powersave mode is enabled
  * @ps_timeout: dynamic powersave timeout
  * @ap_unexpected_nlportid: (private) netlink port ID of application
@@ -6220,6 +6217,11 @@ enum ieee80211_ap_reg_power {
  *	unprotected beacon report
  * @links: array of %IEEE80211_MLD_MAX_NUM_LINKS elements containing @addr
  *	@ap and @client for each link
+ * @links[].cac_started: true if DFS channel availability check has been
+ *	started
+ * @links[].cac_start_time: timestamp (jiffies) when the dfs state was
+ *	entered.
+ * @links[].cac_time_ms: CAC time in ms
  * @valid_links: bitmap describing what elements of @links are valid
  */
 struct wireless_dev {
@@ -6261,11 +6263,6 @@ struct wireless_dev {
 	u32 owner_nlportid;
 	bool nl_owner_dead;
 
-	/* FIXME: need to rework radar detection for MLO */
-	bool cac_started;
-	unsigned long cac_start_time;
-	unsigned int cac_time_ms;
-
 #ifdef CONFIG_CFG80211_WEXT
 	/* wext data */
 	struct {
@@ -6332,6 +6329,10 @@ struct wireless_dev {
 				struct cfg80211_internal_bss *current_bss;
 			} client;
 		};
+
+		bool cac_started;
+		unsigned long cac_start_time;
+		unsigned int cac_time_ms;
 	} links[IEEE80211_MLD_MAX_NUM_LINKS];
 	u16 valid_links;
 };
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d3115be54997..5725ab6f495f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1662,7 +1662,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	ieee80211_link_info_change_notify(sdata, link,
 					  BSS_CHANGED_BEACON_ENABLED);
 
-	if (sdata->wdev.cac_started) {
+	if (sdata->wdev.links[0].cac_started) {
 		chandef = link_conf->chanreq.oper;
 		wiphy_delayed_work_cancel(wiphy, &link->dfs_cac_timer_work);
 		cfg80211_cac_event(sdata->dev, &chandef,
@@ -3501,9 +3501,9 @@ static void ieee80211_end_cac(struct wiphy *wiphy,
 		wiphy_delayed_work_cancel(wiphy,
 					  &sdata->deflink.dfs_cac_timer_work);
 
-		if (sdata->wdev.cac_started) {
+		if (sdata->wdev.links[0].cac_started) {
 			ieee80211_link_release_channel(&sdata->deflink);
-			sdata->wdev.cac_started = false;
+			sdata->wdev.links[0].cac_started = false;
 		}
 	}
 }
@@ -3958,7 +3958,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	if (!list_empty(&local->roc_list) || local->scanning)
 		return -EBUSY;
 
-	if (sdata->wdev.cac_started)
+	if (sdata->wdev.links[0].cac_started)
 		return -EBUSY;
 
 	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 7bb71ac52277..bdaf8e215965 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -552,7 +552,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	wiphy_delayed_work_cancel(local->hw.wiphy,
 				  &sdata->deflink.dfs_cac_timer_work);
 
-	if (sdata->wdev.cac_started) {
+	if (sdata->wdev.links[0].cac_started) {
 		chandef = sdata->vif.bss_conf.chanreq.oper;
 		WARN_ON(local->suspended);
 		ieee80211_link_release_channel(&sdata->deflink);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 85789c184949..79579c89e281 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3039,7 +3039,7 @@ void ieee80211_dfs_cac_timer_work(struct wiphy *wiphy, struct wiphy_work *work)
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	if (sdata->wdev.cac_started) {
+	if (sdata->wdev.links[0].cac_started) {
 		ieee80211_link_release_channel(link);
 		cfg80211_cac_event(sdata->dev, &chandef,
 				   NL80211_RADAR_CAC_FINISHED,
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 14e18fd9e919..6735620378f4 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -585,7 +585,7 @@ static bool __ieee80211_can_leave_ch(struct ieee80211_sub_if_data *sdata)
 		return false;
 
 	list_for_each_entry(sdata_iter, &local->interfaces, list) {
-		if (sdata_iter->wdev.cac_started)
+		if (sdata_iter->wdev.links[0].cac_started)
 			return false;
 	}
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 071cbb7929d9..ab17361dba97 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3478,7 +3478,7 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
 		wiphy_delayed_work_cancel(local->hw.wiphy,
 					  &sdata->deflink.dfs_cac_timer_work);
 
-		if (sdata->wdev.cac_started) {
+		if (sdata->wdev.links[0].cac_started) {
 			chandef = sdata->vif.bss_conf.chanreq.oper;
 			ieee80211_link_release_channel(&sdata->deflink);
 			cfg80211_cac_event(sdata->dev,
diff --git a/net/wireless/ibss.c b/net/wireless/ibss.c
index 34e5acff3935..1e3ed29f7cfc 100644
--- a/net/wireless/ibss.c
+++ b/net/wireless/ibss.c
@@ -94,7 +94,7 @@ int __cfg80211_join_ibss(struct cfg80211_registered_device *rdev,
 
 	lockdep_assert_held(&rdev->wiphy.mtx);
 
-	if (wdev->cac_started)
+	if (wdev->links[0].cac_started)
 		return -EBUSY;
 
 	if (wdev->u.ibss.ssid_len)
diff --git a/net/wireless/mesh.c b/net/wireless/mesh.c
index aaca65b66af4..2c6654075ca9 100644
--- a/net/wireless/mesh.c
+++ b/net/wireless/mesh.c
@@ -127,7 +127,7 @@ int __cfg80211_join_mesh(struct cfg80211_registered_device *rdev,
 	if (!rdev->ops->join_mesh)
 		return -EOPNOTSUPP;
 
-	if (wdev->cac_started)
+	if (wdev->links[0].cac_started)
 		return -EBUSY;
 
 	if (!setup->chandef.chan) {
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 4052041a19ea..fddd6a62b942 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -1123,13 +1123,14 @@ void cfg80211_cac_event(struct net_device *netdev,
 
 	trace_cfg80211_cac_event(netdev, event);
 
-	if (WARN_ON(!wdev->cac_started && event != NL80211_RADAR_CAC_STARTED))
+	if (WARN_ON(!wdev->links[0].cac_started &&
+		    event != NL80211_RADAR_CAC_STARTED))
 		return;
 
 	switch (event) {
 	case NL80211_RADAR_CAC_FINISHED:
-		timeout = wdev->cac_start_time +
-			  msecs_to_jiffies(wdev->cac_time_ms);
+		timeout = wdev->links[0].cac_start_time +
+			  msecs_to_jiffies(wdev->links[0].cac_time_ms);
 		WARN_ON(!time_after_eq(jiffies, timeout));
 		cfg80211_set_dfs_state(wiphy, chandef, NL80211_DFS_AVAILABLE);
 		memcpy(&rdev->cac_done_chandef, chandef,
@@ -1138,10 +1139,10 @@ void cfg80211_cac_event(struct net_device *netdev,
 		cfg80211_sched_dfs_chan_update(rdev);
 		fallthrough;
 	case NL80211_RADAR_CAC_ABORTED:
-		wdev->cac_started = false;
+		wdev->links[0].cac_started = false;
 		break;
 	case NL80211_RADAR_CAC_STARTED:
-		wdev->cac_started = true;
+		wdev->links[0].cac_started = true;
 		break;
 	default:
 		WARN_ON(1);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b368e23847dd..15c09af64aee 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6066,7 +6066,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	if (!rdev->ops->start_ap)
 		return -EOPNOTSUPP;
 
-	if (wdev->cac_started)
+	if (wdev->links[0].cac_started)
 		return -EBUSY;
 
 	if (wdev->links[link_id].ap.beacon_interval)
@@ -10121,7 +10121,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 		goto unlock;
 	}
 
-	if (cfg80211_beaconing_iface_active(wdev) || wdev->cac_started) {
+	if (cfg80211_beaconing_iface_active(wdev) || wdev->links[0].cac_started) {
 		err = -EBUSY;
 		goto unlock;
 	}
@@ -10157,9 +10157,9 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 		default:
 			break;
 		}
-		wdev->cac_started = true;
-		wdev->cac_start_time = jiffies;
-		wdev->cac_time_ms = cac_time_ms;
+		wdev->links[0].cac_started = true;
+		wdev->links[0].cac_start_time = jiffies;
+		wdev->links[0].cac_time_ms = cac_time_ms;
 	}
 unlock:
 	wiphy_unlock(wiphy);
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 4a27f3823e25..898abc6d0609 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -4241,7 +4241,7 @@ static void cfg80211_check_and_end_cac(struct cfg80211_registered_device *rdev)
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 		struct cfg80211_chan_def *chandef;
 
-		if (!wdev->cac_started)
+		if (!wdev->links[0].cac_started)
 			continue;
 
 		/* FIXME: radar detection is tied to link 0 for now */
-- 
2.34.1


