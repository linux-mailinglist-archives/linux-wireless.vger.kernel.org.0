Return-Path: <linux-wireless+bounces-9227-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D5F90E237
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 06:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6589B1C220D3
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 04:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB5154662;
	Wed, 19 Jun 2024 04:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I3Au29is"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B8255897
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 04:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718770242; cv=none; b=HcqMFFaxVlX3v5cUK5wjV8bvMFLZ+wtU9lUPAuwicCr8lwadXCo+GUOU1R7bzCQ6YZ7cxf0PXrv/HP14wwBNS6osoGzoUWaE5jv35g05yNH24dRUl3QrYK7OHdsTXJYYsSFXX42HoRNBlVqotZK2gTVievHBG+qKjbl0Vuua76I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718770242; c=relaxed/simple;
	bh=Vkxg8/mB9CggHrwebi8BjVjVWGVv0NtbTTZ+RK4+XeI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oo5vDQxjGW5Vp/3SDs0ywU4FkqJd0Y1E28J2HTR2miij1+7CYGCBMs98Piomnp4CPu3P8ZeY1SB7PY/ae07AUClmljWeZcHfm7weiyxgt0IkV/GptL8MBukd/ftb95FZonod9Vv+6ft62U4mfQ5QcbigDP7ZVe2zInjNoPHXxJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I3Au29is; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILa58g009248;
	Wed, 19 Jun 2024 04:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Su2+vLT0tyrkwRP6GuRX+chmo9rqvmIXeonGX9xA3mg=; b=I3Au29is7HkE6EtM
	yMLa9aCmO5h2HZz0QkQWjMH3pWqJTYhKTpd6sQeMQ0Cc4iY3g11+P4Q3ympcTXEv
	WQ/1iJlinv6Xz4xXS+tPzkmmhVfrzAabzjwF9HmOmH4WxSxIscl19UwymxUPvemt
	QRvhzFWCtA3OwGVNmRpGsnb11R+0HsQPL6xiUigniWJu/3aPWdOUpprTg0WtZnsw
	rkXclSxzAKjaCJWr1u6imKN+54+WWqiZO5GjcYMmb7UohKHI8fgKzxo430TK1Tfa
	odHfVNIWn407YOxMvPTu40VLehwcbcMJQ8gosUEOk5uZKH7j+Co34dSrgXaeF13s
	AMHXIA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuj9tgkkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 04:10:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45J4AavP022867
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 04:10:36 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Jun 2024 21:10:33 -0700
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
Subject: [PATCH 5/9] wifi: cfg80211: handle DFS on per link
Date: Wed, 19 Jun 2024 09:39:55 +0530
Message-ID: <20240619040959.1457547-6-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619040959.1457547-1-quic_adisi@quicinc.com>
References: <20240619040959.1457547-1-quic_adisi@quicinc.com>
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
X-Proofpoint-GUID: 5R9cs6ku-cOjUVhp6sZC1quZto0oDSS7
X-Proofpoint-ORIG-GUID: 5R9cs6ku-cOjUVhp6sZC1quZto0oDSS7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_01,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406190029

Currently, during starting a radar detection, no link id information is
parsed and passed down. In order to support starting radar detection
during Multi Link Operation, it is required to pass link id as well.

Add changes to first parse and then pass link id in the start radar
detection path.

Additionally, update notification APIs to allow drivers/mac80211 to
pass the link ID.

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/marvell/mwifiex/11h.c    |  7 +++--
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  2 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  2 +-
 .../net/wireless/quantenna/qtnfmac/event.c    |  6 ++--
 include/net/cfg80211.h                        |  8 +++--
 net/mac80211/cfg.c                            |  6 ++--
 net/mac80211/iface.c                          |  2 +-
 net/mac80211/mlme.c                           |  2 +-
 net/mac80211/util.c                           |  2 +-
 net/wireless/mlme.c                           | 19 ++++++------
 net/wireless/nl80211.c                        | 22 +++++++------
 net/wireless/rdev-ops.h                       | 13 ++++----
 net/wireless/reg.c                            | 19 +++++++-----
 net/wireless/trace.h                          | 31 ++++++++++++-------
 14 files changed, 80 insertions(+), 61 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/11h.c b/drivers/net/wireless/marvell/mwifiex/11h.c
index fb2cad096758..032b93a41d99 100644
--- a/drivers/net/wireless/marvell/mwifiex/11h.c
+++ b/drivers/net/wireless/marvell/mwifiex/11h.c
@@ -122,7 +122,7 @@ void mwifiex_dfs_cac_work_queue(struct work_struct *work)
 			    "CAC timer finished; No radar detected\n");
 		cfg80211_cac_event(priv->netdev, &chandef,
 				   NL80211_RADAR_CAC_FINISHED,
-				   GFP_KERNEL);
+				   GFP_KERNEL, 0);
 	}
 }
 
@@ -182,7 +182,8 @@ void mwifiex_abort_cac(struct mwifiex_private *priv)
 			    "Aborting delayed work for CAC.\n");
 		cancel_delayed_work_sync(&priv->dfs_cac_work);
 		cfg80211_cac_event(priv->netdev, &priv->dfs_chandef,
-				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL);
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL,
+				   0);
 	}
 }
 
@@ -221,7 +222,7 @@ int mwifiex_11h_handle_chanrpt_ready(struct mwifiex_private *priv,
 				cfg80211_cac_event(priv->netdev,
 						   &priv->dfs_chandef,
 						   NL80211_RADAR_DETECTED,
-						   GFP_KERNEL);
+						   GFP_KERNEL, 0);
 			}
 			break;
 		default:
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 3880fe7384e1..46a83bdf4a81 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4145,7 +4145,7 @@ static int
 mwifiex_cfg80211_start_radar_detection(struct wiphy *wiphy,
 				       struct net_device *dev,
 				       struct cfg80211_chan_def *chandef,
-				       u32 cac_time_ms)
+				       u32 cac_time_ms, int link_id)
 {
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 	struct mwifiex_radar_params radar_params;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index 663d77770fce..8b97accf6638 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -837,7 +837,7 @@ static int qtnf_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 static int qtnf_start_radar_detection(struct wiphy *wiphy,
 				      struct net_device *ndev,
 				      struct cfg80211_chan_def *chandef,
-				      u32 cac_time_ms)
+				      u32 cac_time_ms, int link_id)
 {
 	struct qtnf_vif *vif = qtnf_netdev_get_priv(ndev);
 	int ret;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/event.c b/drivers/net/wireless/quantenna/qtnfmac/event.c
index 8bd1e14e5de9..71840f41b73c 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/event.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/event.c
@@ -524,14 +524,14 @@ static int qtnf_event_handle_radar(struct qtnf_vif *vif,
 			break;
 
 		cfg80211_cac_event(vif->netdev, &chandef,
-				   NL80211_RADAR_CAC_FINISHED, GFP_KERNEL);
+				   NL80211_RADAR_CAC_FINISHED, GFP_KERNEL, 0);
 		break;
 	case QLINK_RADAR_CAC_ABORTED:
 		if (!vif->wdev.links[0].cac_started)
 			break;
 
 		cfg80211_cac_event(vif->netdev, &chandef,
-				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL);
+				   NL80211_RADAR_CAC_ABORTED, GFP_KERNEL, 0);
 		break;
 	case QLINK_RADAR_CAC_STARTED:
 		if (vif->wdev.links[0].cac_started)
@@ -542,7 +542,7 @@ static int qtnf_event_handle_radar(struct qtnf_vif *vif,
 			break;
 
 		cfg80211_cac_event(vif->netdev, &chandef,
-				   NL80211_RADAR_CAC_STARTED, GFP_KERNEL);
+				   NL80211_RADAR_CAC_STARTED, GFP_KERNEL, 0);
 		break;
 	default:
 		pr_warn("%s: unhandled radar event %u\n",
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d03d525de4d3..f348e25ee9c9 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4833,9 +4833,9 @@ struct cfg80211_ops {
 	int	(*start_radar_detection)(struct wiphy *wiphy,
 					 struct net_device *dev,
 					 struct cfg80211_chan_def *chandef,
-					 u32 cac_time_ms);
+					 u32 cac_time_ms, int link_id);
 	void	(*end_cac)(struct wiphy *wiphy,
-				struct net_device *dev);
+			   struct net_device *dev, unsigned int link_id);
 	int	(*update_ft_ies)(struct wiphy *wiphy, struct net_device *dev,
 				 struct cfg80211_update_ft_ies_params *ftie);
 	int	(*crit_proto_start)(struct wiphy *wiphy,
@@ -8685,6 +8685,7 @@ void cfg80211_sta_opmode_change_notify(struct net_device *dev, const u8 *mac,
  * @chandef: chandef for the current channel
  * @event: type of event
  * @gfp: context flags
+ * @link_id: valid link_id for MLO operation or 0 otherwise.
  *
  * This function is called when a Channel availability check (CAC) is finished
  * or aborted. This must be called to notify the completion of a CAC process,
@@ -8692,7 +8693,8 @@ void cfg80211_sta_opmode_change_notify(struct net_device *dev, const u8 *mac,
  */
 void cfg80211_cac_event(struct net_device *netdev,
 			const struct cfg80211_chan_def *chandef,
-			enum nl80211_radar_event event, gfp_t gfp);
+			enum nl80211_radar_event event, gfp_t gfp,
+			unsigned int link_id);
 
 /**
  * cfg80211_background_cac_abort - Channel Availability Check offchan abort event
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index a75b11071373..c2af768add96 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1674,7 +1674,7 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 		wiphy_delayed_work_cancel(wiphy, &link->dfs_cac_timer_work);
 		cfg80211_cac_event(sdata->dev, &chandef,
 				   NL80211_RADAR_CAC_ABORTED,
-				   GFP_KERNEL);
+				   GFP_KERNEL, link_id);
 	}
 
 	drv_stop_ap(sdata->local, sdata, link_conf);
@@ -3466,7 +3466,7 @@ static int ieee80211_set_bitrate_mask(struct wiphy *wiphy,
 static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 					   struct net_device *dev,
 					   struct cfg80211_chan_def *chandef,
-					   u32 cac_time_ms)
+					   u32 cac_time_ms, int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_chan_req chanreq = { .oper = *chandef };
@@ -3497,7 +3497,7 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 }
 
 static void ieee80211_end_cac(struct wiphy *wiphy,
-			      struct net_device *dev)
+			      struct net_device *dev, unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 9d13425d923f..69cb94318823 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -562,7 +562,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		ieee80211_link_release_channel(&sdata->deflink);
 		cfg80211_cac_event(sdata->dev, &chandef,
 				   NL80211_RADAR_CAC_ABORTED,
-				   GFP_KERNEL);
+				   GFP_KERNEL, 0);
 	}
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP) {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f7c20b6962f7..96fea00b62fd 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3022,7 +3022,7 @@ void ieee80211_dfs_cac_timer_work(struct wiphy *wiphy, struct wiphy_work *work)
 		ieee80211_link_release_channel(link);
 		cfg80211_cac_event(sdata->dev, &chandef,
 				   NL80211_RADAR_CAC_FINISHED,
-				   GFP_KERNEL);
+				   GFP_KERNEL, link->link_id);
 	}
 }
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index b03d91dfdd35..1dfb61082a9c 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3466,7 +3466,7 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
 			cfg80211_cac_event(sdata->dev,
 					   &chandef,
 					   NL80211_RADAR_CAC_ABORTED,
-					   GFP_KERNEL);
+					   GFP_KERNEL, 0);
 		}
 	}
 }
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index fddd6a62b942..4dac81854721 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -1110,27 +1110,28 @@ EXPORT_SYMBOL(__cfg80211_radar_event);
 
 void cfg80211_cac_event(struct net_device *netdev,
 			const struct cfg80211_chan_def *chandef,
-			enum nl80211_radar_event event, gfp_t gfp)
+			enum nl80211_radar_event event, gfp_t gfp,
+			unsigned int link_id)
 {
 	struct wireless_dev *wdev = netdev->ieee80211_ptr;
 	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	unsigned long timeout;
 
-	/* not yet supported */
-	if (wdev->valid_links)
+	if (WARN_ON(wdev->valid_links &&
+		    !(wdev->valid_links & BIT(link_id))))
 		return;
 
-	trace_cfg80211_cac_event(netdev, event);
+	trace_cfg80211_cac_event(netdev, event, link_id);
 
-	if (WARN_ON(!wdev->links[0].cac_started &&
+	if (WARN_ON(!wdev->links[link_id].cac_started &&
 		    event != NL80211_RADAR_CAC_STARTED))
 		return;
 
 	switch (event) {
 	case NL80211_RADAR_CAC_FINISHED:
-		timeout = wdev->links[0].cac_start_time +
-			  msecs_to_jiffies(wdev->links[0].cac_time_ms);
+		timeout = wdev->links[link_id].cac_start_time +
+			  msecs_to_jiffies(wdev->links[link_id].cac_time_ms);
 		WARN_ON(!time_after_eq(jiffies, timeout));
 		cfg80211_set_dfs_state(wiphy, chandef, NL80211_DFS_AVAILABLE);
 		memcpy(&rdev->cac_done_chandef, chandef,
@@ -1139,10 +1140,10 @@ void cfg80211_cac_event(struct net_device *netdev,
 		cfg80211_sched_dfs_chan_update(rdev);
 		fallthrough;
 	case NL80211_RADAR_CAC_ABORTED:
-		wdev->links[0].cac_started = false;
+		wdev->links[link_id].cac_started = false;
 		break;
 	case NL80211_RADAR_CAC_STARTED:
-		wdev->links[0].cac_started = true;
+		wdev->links[link_id].cac_started = true;
 		break;
 	default:
 		WARN_ON(1);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7420a966997f..08c0d25924d6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9978,6 +9978,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_chan_def chandef;
+	int link_id = nl80211_link_id(info->attrs);
 	enum nl80211_dfs_regions dfs_region;
 	unsigned int cac_time_ms;
 	int err = -EINVAL;
@@ -10030,7 +10031,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 		 * can not already beacon
 		 */
 		if (wdev->valid_links &&
-		    !wdev->links[0].ap.beacon_interval) {
+		    !wdev->links[link_id].ap.beacon_interval) {
 			/* nothing */
 		} else {
 			err = -EBUSY;
@@ -10038,7 +10039,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 		}
 	}
 
-	if (wdev->links[0].cac_started) {
+	if (wdev->links[link_id].cac_started) {
 		err = -EBUSY;
 		goto unlock;
 	}
@@ -10058,12 +10059,13 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	if (WARN_ON(!cac_time_ms))
 		cac_time_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
 
-	err = rdev_start_radar_detection(rdev, dev, &chandef, cac_time_ms);
+	err = rdev_start_radar_detection(rdev, dev, &chandef, cac_time_ms,
+					 link_id);
 	if (!err) {
-		wdev->links[0].ap.chandef = chandef;
-		wdev->links[0].cac_started = true;
-		wdev->links[0].cac_start_time = jiffies;
-		wdev->links[0].cac_time_ms = cac_time_ms;
+		wdev->links[link_id].ap.chandef = chandef;
+		wdev->links[link_id].cac_started = true;
+		wdev->links[link_id].cac_start_time = jiffies;
+		wdev->links[link_id].cac_time_ms = cac_time_ms;
 	}
 unlock:
 	wiphy_unlock(wiphy);
@@ -16415,10 +16417,10 @@ nl80211_set_ttlm(struct sk_buff *skb, struct genl_info *info)
 	SELECTOR(__sel, NETDEV_UP_NOTMX,		\
 		 NL80211_FLAG_NEED_NETDEV_UP |		\
 		 NL80211_FLAG_NO_WIPHY_MTX)		\
-	SELECTOR(__sel, NETDEV_UP_NOTMX_NOMLO,		\
+	SELECTOR(__sel, NETDEV_UP_NOTMX_MLO,		\
 		 NL80211_FLAG_NEED_NETDEV_UP |		\
 		 NL80211_FLAG_NO_WIPHY_MTX |		\
-		 NL80211_FLAG_MLO_UNSUPPORTED)		\
+		 NL80211_FLAG_MLO_VALID_LINK_ID)	\
 	SELECTOR(__sel, NETDEV_UP_CLEAR,		\
 		 NL80211_FLAG_NEED_NETDEV_UP |		\
 		 NL80211_FLAG_CLEAR_SKB)		\
@@ -17313,7 +17315,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
 					 NL80211_FLAG_NO_WIPHY_MTX |
-					 NL80211_FLAG_MLO_UNSUPPORTED),
+					 NL80211_FLAG_MLO_VALID_LINK_ID),
 	},
 	{
 		.cmd = NL80211_CMD_GET_PROTOCOL_FEATURES,
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 755af47b88b9..cce5a21bcb0f 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1202,26 +1202,27 @@ static inline int
 rdev_start_radar_detection(struct cfg80211_registered_device *rdev,
 			   struct net_device *dev,
 			   struct cfg80211_chan_def *chandef,
-			   u32 cac_time_ms)
+			   u32 cac_time_ms, int link_id)
 {
 	int ret = -EOPNOTSUPP;
 
 	trace_rdev_start_radar_detection(&rdev->wiphy, dev, chandef,
-					 cac_time_ms);
+					 cac_time_ms, link_id);
 	if (rdev->ops->start_radar_detection)
 		ret = rdev->ops->start_radar_detection(&rdev->wiphy, dev,
-						       chandef, cac_time_ms);
+						       chandef, cac_time_ms,
+						       link_id);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
 
 static inline void
 rdev_end_cac(struct cfg80211_registered_device *rdev,
-	     struct net_device *dev)
+	     struct net_device *dev, unsigned int link_id)
 {
-	trace_rdev_end_cac(&rdev->wiphy, dev);
+	trace_rdev_end_cac(&rdev->wiphy, dev, link_id);
 	if (rdev->ops->end_cac)
-		rdev->ops->end_cac(&rdev->wiphy, dev);
+		rdev->ops->end_cac(&rdev->wiphy, dev, link_id);
 	trace_rdev_return_void(&rdev->wiphy);
 }
 
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 898abc6d0609..6489ba943a63 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -4229,6 +4229,8 @@ EXPORT_SYMBOL(regulatory_pre_cac_allowed);
 static void cfg80211_check_and_end_cac(struct cfg80211_registered_device *rdev)
 {
 	struct wireless_dev *wdev;
+	unsigned int link_id;
+
 	/* If we finished CAC or received radar, we should end any
 	 * CAC running on the same channels.
 	 * the check !cfg80211_chandef_dfs_usable contain 2 options:
@@ -4241,16 +4243,17 @@ static void cfg80211_check_and_end_cac(struct cfg80211_registered_device *rdev)
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 		struct cfg80211_chan_def *chandef;
 
-		if (!wdev->links[0].cac_started)
-			continue;
+		for_each_valid_link(wdev, link_id) {
+			if (!wdev->links[link_id].cac_started)
+				continue;
 
-		/* FIXME: radar detection is tied to link 0 for now */
-		chandef = wdev_chandef(wdev, 0);
-		if (!chandef)
-			continue;
+			chandef = wdev_chandef(wdev, link_id);
+			if (!chandef)
+				continue;
 
-		if (!cfg80211_chandef_dfs_usable(&rdev->wiphy, chandef))
-			rdev_end_cac(rdev, wdev->netdev);
+			if (!cfg80211_chandef_dfs_usable(&rdev->wiphy, chandef))
+				rdev_end_cac(rdev, wdev->netdev, link_id);
+		}
 	}
 }
 
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 7fc7de9bcc34..97c21b627791 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -806,17 +806,21 @@ DEFINE_EVENT(wiphy_netdev_evt, rdev_flush_pmksa,
 );
 
 TRACE_EVENT(rdev_end_cac,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev),
-	TP_ARGS(wiphy, netdev),
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 unsigned int link_id),
+	TP_ARGS(wiphy, netdev, link_id),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
+		__field(unsigned int, link_id)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		NETDEV_ASSIGN;
+		__entry->link_id = link_id;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT, WIPHY_PR_ARG, NETDEV_PR_ARG)
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %d",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->link_id)
 );
 
 DECLARE_EVENT_CLASS(station_add_change,
@@ -2661,24 +2665,26 @@ TRACE_EVENT(rdev_external_auth,
 TRACE_EVENT(rdev_start_radar_detection,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
 		 struct cfg80211_chan_def *chandef,
-		 u32 cac_time_ms),
-	TP_ARGS(wiphy, netdev, chandef, cac_time_ms),
+		 u32 cac_time_ms, int link_id),
+	TP_ARGS(wiphy, netdev, chandef, cac_time_ms, link_id),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
 		CHAN_DEF_ENTRY
 		__field(u32, cac_time_ms)
+		__field(int, link_id)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		NETDEV_ASSIGN;
 		CHAN_DEF_ASSIGN(chandef);
 		__entry->cac_time_ms = cac_time_ms;
+		__entry->link_id = link_id;
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " CHAN_DEF_PR_FMT
-		  ", cac_time_ms=%u",
+		  ", cac_time_ms=%u, link_id=%d",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, CHAN_DEF_PR_ARG,
-		  __entry->cac_time_ms)
+		  __entry->cac_time_ms, __entry->link_id)
 );
 
 TRACE_EVENT(rdev_set_mcast_rate,
@@ -3492,18 +3498,21 @@ TRACE_EVENT(cfg80211_radar_event,
 );
 
 TRACE_EVENT(cfg80211_cac_event,
-	TP_PROTO(struct net_device *netdev, enum nl80211_radar_event evt),
-	TP_ARGS(netdev, evt),
+	TP_PROTO(struct net_device *netdev, enum nl80211_radar_event evt,
+		 unsigned int link_id),
+	TP_ARGS(netdev, evt, link_id),
 	TP_STRUCT__entry(
 		NETDEV_ENTRY
 		__field(enum nl80211_radar_event, evt)
+		__field(unsigned int, link_id)
 	),
 	TP_fast_assign(
 		NETDEV_ASSIGN;
 		__entry->evt = evt;
+		__entry->link_id = link_id;
 	),
-	TP_printk(NETDEV_PR_FMT ",  event: %d",
-		  NETDEV_PR_ARG, __entry->evt)
+	TP_printk(NETDEV_PR_FMT ",  event: %d, link_id=%u",
+		  NETDEV_PR_ARG, __entry->evt, __entry->link_id)
 );
 
 DECLARE_EVENT_CLASS(cfg80211_rx_evt,
-- 
2.34.1


