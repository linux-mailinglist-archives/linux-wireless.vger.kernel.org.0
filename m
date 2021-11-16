Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8253A453395
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Nov 2021 15:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237013AbhKPOGy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Nov 2021 09:06:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237069AbhKPOGu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Nov 2021 09:06:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F1F5610A8;
        Tue, 16 Nov 2021 14:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637071434;
        bh=+epf0iXgH1YkGgq1TMTqAHuIib9A/mXbSWxH9+518uU=;
        h=From:To:Cc:Subject:Date:From;
        b=LpTxrGmHX7dNus6Fvi3UtnKF7QicmdcR0fLIg0Z/PqlN5KBtE2RPG8HifpE4OQEM5
         VoISOsn1zJcaqwjDbHqzzpgEHIVVDMwJ1ChfKu54YWGCAUbOVpJSozf7Y5C1d3Uu0P
         oSiFJSddoh9MH56DQ5JM6ijGc9BaNHmGFNH3rsWr79GM97Fx5/ibtlu5Z51um9Fh1J
         uscus64tywWKZRoazqd//P02cDx3Y9/zCK3mhpty+MHlm+ZdMObMvyJ4bSLKAFJrxo
         aBfpt0AyqaI3UkE7NdRoGTwEm0RyobWrsoixa9d+WhcPKkSwijtxa/2aqs1FtHV4HH
         GHje1mv5pl5GQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        evelyn.tsai@mediatek.com, owen.peng@mediatek.com
Subject: [PATCH mac80211-next] cfg80211: allow continuous radar monitoring on offchannel chain
Date:   Tue, 16 Nov 2021 15:03:36 +0100
Message-Id: <d46217310a49b14ff0e9c002f0a6e0547d70fd2c.1637071350.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allow continuous radar detection on the offchannel chain in order
to switch to the monitored channel whenever the underlay driver
reports a radar pattern on the main channel.

Tested-by: Owen Peng <owen.peng@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/wireless/chan.c    | 16 +++++++++++
 net/wireless/mlme.c    | 20 +++++++++-----
 net/wireless/nl80211.c | 62 ++++++++++++++++++++++++++++--------------
 3 files changed, 71 insertions(+), 27 deletions(-)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 869c43d4414c..00fc7b78063c 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -712,6 +712,19 @@ static bool cfg80211_is_wiphy_oper_chan(struct wiphy *wiphy,
 	return false;
 }
 
+static bool
+cfg80211_offchan_chain_is_active(struct cfg80211_registered_device *rdev,
+				 struct ieee80211_channel *channel)
+{
+	if (!rdev->offchan_radar_wdev)
+		return false;
+
+	if (!cfg80211_chandef_valid(&rdev->offchan_radar_chandef))
+		return false;
+
+	return cfg80211_is_sub_chan(&rdev->offchan_radar_chandef, channel);
+}
+
 bool cfg80211_any_wiphy_oper_chan(struct wiphy *wiphy,
 				  struct ieee80211_channel *chan)
 {
@@ -728,6 +741,9 @@ bool cfg80211_any_wiphy_oper_chan(struct wiphy *wiphy,
 
 		if (cfg80211_is_wiphy_oper_chan(&rdev->wiphy, chan))
 			return true;
+
+		if (cfg80211_offchan_chain_is_active(rdev, chan))
+			return true;
 	}
 
 	return false;
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 450be1ec70b8..e970076e1098 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -988,7 +988,7 @@ __cfg80211_offchan_cac_event(struct cfg80211_registered_device *rdev,
 	if (!cfg80211_chandef_valid(chandef))
 		return;
 
-	if (event != NL80211_RADAR_CAC_STARTED && !rdev->offchan_radar_wdev)
+	if (!rdev->offchan_radar_wdev)
 		return;
 
 	switch (event) {
@@ -998,17 +998,13 @@ __cfg80211_offchan_cac_event(struct cfg80211_registered_device *rdev,
 		queue_work(cfg80211_wq, &rdev->propagate_cac_done_wk);
 		cfg80211_sched_dfs_chan_update(rdev);
 		wdev = rdev->offchan_radar_wdev;
-		rdev->offchan_radar_wdev = NULL;
 		break;
 	case NL80211_RADAR_CAC_ABORTED:
 		if (!cancel_delayed_work(&rdev->offchan_cac_done_wk))
 			return;
 		wdev = rdev->offchan_radar_wdev;
-		rdev->offchan_radar_wdev = NULL;
 		break;
 	case NL80211_RADAR_CAC_STARTED:
-		WARN_ON(!wdev);
-		rdev->offchan_radar_wdev = wdev;
 		break;
 	default:
 		return;
@@ -1024,7 +1020,8 @@ cfg80211_offchan_cac_event(struct cfg80211_registered_device *rdev,
 			   enum nl80211_radar_event event)
 {
 	wiphy_lock(&rdev->wiphy);
-	__cfg80211_offchan_cac_event(rdev, NULL, chandef, event);
+	__cfg80211_offchan_cac_event(rdev, rdev->offchan_radar_wdev,
+				     chandef, event);
 	wiphy_unlock(&rdev->wiphy);
 }
 
@@ -1071,7 +1068,13 @@ cfg80211_start_offchan_radar_detection(struct cfg80211_registered_device *rdev,
 				     NL80211_EXT_FEATURE_RADAR_OFFCHAN))
 		return -EOPNOTSUPP;
 
-	if (rdev->offchan_radar_wdev)
+	/* Offchannel chain already locked by another wdev */
+	if (rdev->offchan_radar_wdev && rdev->offchan_radar_wdev != wdev)
+		return -EBUSY;
+
+	/* CAC already in progress on the offchannel chain */
+	if (rdev->offchan_radar_wdev == wdev &&
+	    delayed_work_pending(&rdev->offchan_cac_done_wk))
 		return -EBUSY;
 
 	err = rdev_set_radar_offchan(rdev, chandef);
@@ -1083,6 +1086,8 @@ cfg80211_start_offchan_radar_detection(struct cfg80211_registered_device *rdev,
 		cac_time_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
 
 	rdev->offchan_radar_chandef = *chandef;
+	rdev->offchan_radar_wdev = wdev; /* Get offchain ownership */
+
 	__cfg80211_offchan_cac_event(rdev, wdev, chandef,
 				     NL80211_RADAR_CAC_STARTED);
 	queue_delayed_work(cfg80211_wq, &rdev->offchan_cac_done_wk,
@@ -1102,6 +1107,7 @@ void cfg80211_stop_offchan_radar_detection(struct wireless_dev *wdev)
 		return;
 
 	rdev_set_radar_offchan(rdev, NULL);
+	rdev->offchan_radar_wdev = NULL; /* Release offchain ownership */
 
 	__cfg80211_offchan_cac_event(rdev, wdev, &rdev->offchan_radar_chandef,
 				     NL80211_RADAR_CAC_ABORTED);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 25ee16558dfa..5ef1a374f7f1 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9271,42 +9271,60 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	struct cfg80211_chan_def chandef;
 	enum nl80211_dfs_regions dfs_region;
 	unsigned int cac_time_ms;
-	int err;
+	int err = -EINVAL;
+
+	flush_delayed_work(&rdev->dfs_update_channels_wk);
+
+	wiphy_lock(wiphy);
 
 	dfs_region = reg_get_dfs_region(wiphy);
 	if (dfs_region == NL80211_DFS_UNSET)
-		return -EINVAL;
+		goto unlock;
 
 	err = nl80211_parse_chandef(rdev, info, &chandef);
 	if (err)
-		return err;
+		goto unlock;
 
 	err = cfg80211_chandef_dfs_required(wiphy, &chandef, wdev->iftype);
 	if (err < 0)
-		return err;
+		goto unlock;
 
-	if (err == 0)
-		return -EINVAL;
+	if (err == 0) {
+		err = -EINVAL;
+		goto unlock;
+	}
 
-	if (!cfg80211_chandef_dfs_usable(wiphy, &chandef))
-		return -EINVAL;
+	if (!cfg80211_chandef_dfs_usable(wiphy, &chandef)) {
+		err = -EINVAL;
+		goto unlock;
+	}
 
-	if (nla_get_flag(info->attrs[NL80211_ATTR_RADAR_OFFCHAN]))
-		return cfg80211_start_offchan_radar_detection(rdev, wdev,
-							      &chandef);
+	if (nla_get_flag(info->attrs[NL80211_ATTR_RADAR_OFFCHAN])) {
+		err = cfg80211_start_offchan_radar_detection(rdev, wdev,
+							     &chandef);
+		goto unlock;
+	}
 
-	if (netif_carrier_ok(dev))
-		return -EBUSY;
+	if (netif_carrier_ok(dev)) {
+		err = -EBUSY;
+		goto unlock;
+	}
 
-	if (wdev->cac_started)
-		return -EBUSY;
+	if (wdev->cac_started) {
+		err = -EBUSY;
+		goto unlock;
+	}
 
 	/* CAC start is offloaded to HW and can't be started manually */
-	if (wiphy_ext_feature_isset(wiphy, NL80211_EXT_FEATURE_DFS_OFFLOAD))
-		return -EOPNOTSUPP;
+	if (wiphy_ext_feature_isset(wiphy, NL80211_EXT_FEATURE_DFS_OFFLOAD)) {
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
 
-	if (!rdev->ops->start_radar_detection)
-		return -EOPNOTSUPP;
+	if (!rdev->ops->start_radar_detection) {
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
 
 	cac_time_ms = cfg80211_chandef_dfs_cac_time(&rdev->wiphy, &chandef);
 	if (WARN_ON(!cac_time_ms))
@@ -9319,6 +9337,9 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 		wdev->cac_start_time = jiffies;
 		wdev->cac_time_ms = cac_time_ms;
 	}
+unlock:
+	wiphy_unlock(wiphy);
+
 	return err;
 }
 
@@ -15955,7 +15976,8 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_start_radar_detection,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+				  NL80211_FLAG_NO_WIPHY_MTX,
 	},
 	{
 		.cmd = NL80211_CMD_GET_PROTOCOL_FEATURES,
-- 
2.31.1

