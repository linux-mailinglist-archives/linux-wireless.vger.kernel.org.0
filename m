Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CADE438290
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Oct 2021 11:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhJWJNu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Oct 2021 05:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230155AbhJWJNr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Oct 2021 05:13:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79BE16101C;
        Sat, 23 Oct 2021 09:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634980288;
        bh=spQ/rYK9aZUyEj9M0hTazS9Pozgs/LMtrd+wLm7zhzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AN79ND1o/i5kBUozZBDOubR9tJ6ubYe79retJHarZxfg5M6IC4lExqAmVmLA/BTHV
         EdaTdG6KPypuhypJBbsAin0siLZIj/aiXWwi0E/T24JL1/37JkRG72D7rPIanC8516
         8TY7yzH6nhsVBIwxAUPe1LIDBd+VvLTck7KlljHFoCEWYDNEP+0knWHVQDzgO6LJ7t
         Z573cLSejySeCfqtErHaq28qLSxflurUNwl2j6JcN3ZWuRWDQeHv9BFjZYhOrxl2EN
         2czMThxSLpMmP9k8hBnkxJ8rykBfAURDEmqPBVhjSloqLCDVO1oZFGu5q31Tz9QE7e
         DHIQKGQiPhcQQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        evelyn.tsai@mediatek.com
Subject: [PATCH v2 mac80211-next 3/6] cfg80211: introduce the capability to configure offchannel CAC detection
Date:   Sat, 23 Oct 2021 11:10:52 +0200
Message-Id: <1e60e60fef00e14401adae81c3d49f3e5f307537.1634979655.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634979655.git.lorenzo@kernel.org>
References: <cover.1634979655.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce NL80211_ATTR_RADAR_OFFCHAN netlink attribute in order to
configure a offchannel radar chain if supported by the underlay driver.
Since the offchannel chain is commonly shared between multiple wireless
devices, offchan_radar_wdev pointer refers to the current owner of the
chain. Offchannel can't be used by multiple wdev at the same time.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/uapi/linux/nl80211.h |  9 ++++++++
 net/wireless/ap.c            |  2 ++
 net/wireless/core.c          |  1 +
 net/wireless/core.h          | 11 ++++++++++
 net/wireless/mlme.c          | 40 ++++++++++++++++++++++++++++++++++++
 net/wireless/nl80211.c       | 17 +++++++++------
 6 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 61cab81e920d..87ece3e68b8b 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2639,6 +2639,13 @@ enum nl80211_commands {
  *	Mandatory parameter for the transmitting interface to enable MBSSID.
  *	Optional for the non-transmitting interfaces.
  *
+ * @NL80211_ATTR_RADAR_OFFCHAN: Configure dedicated offchannel chain available for
+ *	radar/CAC detection on some hw. This chain can't be used to transmit
+ *	or receive frames and it is bounded to a running wdev.
+ *	Offchannel radar/CAC detection allows to avoid the CAC downtime
+ *	switching on a different channel during CAC detection on the selected
+ *	radar channel.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3145,6 +3152,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_MBSSID_CONFIG,
 	NL80211_ATTR_MBSSID_ELEMS,
 
+	NL80211_ATTR_RADAR_OFFCHAN,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/ap.c b/net/wireless/ap.c
index 550ac9d827fe..608fe3447158 100644
--- a/net/wireless/ap.c
+++ b/net/wireless/ap.c
@@ -25,6 +25,8 @@ int __cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
 	if (!wdev->beacon_interval)
 		return -ENOENT;
 
+	cfg80211_stop_offchan_radar_detection(rdev);
+
 	err = rdev_stop_ap(rdev, dev);
 	if (!err) {
 		wdev->conn_owner_nlportid = 0;
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 45be124a98f1..385c3654b385 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -498,6 +498,7 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 	}
 
 	mutex_init(&rdev->wiphy.mtx);
+	mutex_init(&rdev->offchan_mutex);
 	INIT_LIST_HEAD(&rdev->wiphy.wdev_list);
 	INIT_LIST_HEAD(&rdev->beacon_registrations);
 	spin_lock_init(&rdev->beacon_registrations_lock);
diff --git a/net/wireless/core.h b/net/wireless/core.h
index b35d0db12f1d..6e4d18fb93b1 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -84,6 +84,9 @@ struct cfg80211_registered_device {
 
 	struct delayed_work dfs_update_channels_wk;
 
+	struct mutex offchan_mutex; /* protect offchan_radar_wdev */
+	struct wireless_dev *offchan_radar_wdev;
+
 	/* netlink port which started critical protocol (0 means not started) */
 	u32 crit_proto_nlportid;
 
@@ -489,6 +492,14 @@ cfg80211_chandef_dfs_cac_time(struct wiphy *wiphy,
 
 void cfg80211_sched_dfs_chan_update(struct cfg80211_registered_device *rdev);
 
+int
+cfg80211_start_offchan_radar_detection(struct cfg80211_registered_device *rdev,
+				       struct wireless_dev *wdev,
+				       struct cfg80211_chan_def *chandef);
+
+int
+cfg80211_stop_offchan_radar_detection(struct cfg80211_registered_device *rdev);
+
 bool cfg80211_any_wiphy_oper_chan(struct wiphy *wiphy,
 				  struct ieee80211_channel *chan);
 
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 3aa69b375a10..053293f51188 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -968,3 +968,43 @@ void cfg80211_cac_event(struct net_device *netdev,
 	nl80211_radar_notify(rdev, chandef, event, netdev, gfp);
 }
 EXPORT_SYMBOL(cfg80211_cac_event);
+
+int
+cfg80211_start_offchan_radar_detection(struct cfg80211_registered_device *rdev,
+				       struct wireless_dev *wdev,
+				       struct cfg80211_chan_def *chandef)
+{
+	int err = -EBUSY;
+
+	mutex_lock(&rdev->offchan_mutex);
+	if (rdev->offchan_radar_wdev)
+		goto out;
+
+	err = rdev_set_radar_offchan(rdev, chandef);
+	if (err)
+		goto out;
+
+	rdev->offchan_radar_wdev = wdev;
+out:
+	mutex_unlock(&rdev->offchan_mutex);
+	return err;
+}
+
+int
+cfg80211_stop_offchan_radar_detection(struct cfg80211_registered_device *rdev)
+{
+	int err = 0;
+
+	mutex_lock(&rdev->offchan_mutex);
+	if (!rdev->offchan_radar_wdev)
+		goto out;
+
+	err = rdev_set_radar_offchan(rdev, NULL);
+	if (err)
+		goto out;
+
+	rdev->offchan_radar_wdev = NULL;
+out:
+	mutex_unlock(&rdev->offchan_mutex);
+	return err;
+}
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 81232b73df8f..25ee16558dfa 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -776,6 +776,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MBSSID_CONFIG] =
 			NLA_POLICY_NESTED(nl80211_mbssid_config_policy),
 	[NL80211_ATTR_MBSSID_ELEMS] = { .type = NLA_NESTED },
+	[NL80211_ATTR_RADAR_OFFCHAN] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -9280,12 +9281,6 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	if (err)
 		return err;
 
-	if (netif_carrier_ok(dev))
-		return -EBUSY;
-
-	if (wdev->cac_started)
-		return -EBUSY;
-
 	err = cfg80211_chandef_dfs_required(wiphy, &chandef, wdev->iftype);
 	if (err < 0)
 		return err;
@@ -9296,6 +9291,16 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 	if (!cfg80211_chandef_dfs_usable(wiphy, &chandef))
 		return -EINVAL;
 
+	if (nla_get_flag(info->attrs[NL80211_ATTR_RADAR_OFFCHAN]))
+		return cfg80211_start_offchan_radar_detection(rdev, wdev,
+							      &chandef);
+
+	if (netif_carrier_ok(dev))
+		return -EBUSY;
+
+	if (wdev->cac_started)
+		return -EBUSY;
+
 	/* CAC start is offloaded to HW and can't be started manually */
 	if (wiphy_ext_feature_isset(wiphy, NL80211_EXT_FEATURE_DFS_OFFLOAD))
 		return -EOPNOTSUPP;
-- 
2.31.1

