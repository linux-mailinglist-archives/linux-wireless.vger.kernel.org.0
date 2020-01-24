Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34F5B14887F
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2020 15:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405146AbgAXOU6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jan 2020 09:20:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:42358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405131AbgAXOU6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jan 2020 09:20:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8271222464;
        Fri, 24 Jan 2020 14:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875657;
        bh=ZVlZjfT7uxqvlaLefrNjEKSQOfSOJheRLI7fIirDXJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x58TxjzIY6bz8x/nZwUa7VyVQTPp/up/j9zdP1nqbEJL927OvFTV/hs8/UUDPIBj0
         WsgFBNp9CWkTJ2cUlXHrqw8FIpd5sHHlD4hbVjGlqh3hPG0zuQUlOBooYWTEQK/AJV
         o5AKXKUab/fqvhjsYXX0w5uBU+xrvVteKDFoGaCg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Orr Mazor <orr.mazor@tandemg.com>,
        Orr Mazor <Orr.Mazor@tandemg.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 38/56] cfg80211: Fix radar event during another phy CAC
Date:   Fri, 24 Jan 2020 09:19:54 -0500
Message-Id: <20200124142012.29752-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124142012.29752-1-sashal@kernel.org>
References: <20200124142012.29752-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Orr Mazor <orr.mazor@tandemg.com>

[ Upstream commit 26ec17a1dc5ecdd8d91aba63ead6f8b5ad5dea0d ]

In case a radar event of CAC_FINISHED or RADAR_DETECTED
happens during another phy is during CAC we might need
to cancel that CAC.

If we got a radar in a channel that another phy is now
doing CAC on then the CAC should be canceled there.

If, for example, 2 phys doing CAC on the same channels,
or on comptable channels, once on of them will finish his
CAC the other might need to cancel his CAC, since it is no
longer relevant.

To fix that the commit adds an callback and implement it in
mac80211 to end CAC.
This commit also adds a call to said callback if after a radar
event we see the CAC is no longer relevant

Signed-off-by: Orr Mazor <Orr.Mazor@tandemg.com>
Reviewed-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Link: https://lore.kernel.org/r/20191222145449.15792-1-Orr.Mazor@tandemg.com
[slightly reformat/reword commit message]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/cfg80211.h  |  5 +++++
 net/mac80211/cfg.c      | 23 +++++++++++++++++++++++
 net/wireless/rdev-ops.h | 10 ++++++++++
 net/wireless/reg.c      | 23 ++++++++++++++++++++++-
 net/wireless/trace.h    |  5 +++++
 5 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 1fa2e72ff7a6a..ae936cd5567e0 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3050,6 +3050,9 @@ struct cfg80211_external_auth_params {
  *
  * @start_radar_detection: Start radar detection in the driver.
  *
+ * @end_cac: End running CAC, probably because a related CAC
+ *	was finished on another phy.
+ *
  * @update_ft_ies: Provide updated Fast BSS Transition information to the
  *	driver. If the SME is in the driver/firmware, this information can be
  *	used in building Authentication and Reassociation Request frames.
@@ -3364,6 +3367,8 @@ struct cfg80211_ops {
 					 struct net_device *dev,
 					 struct cfg80211_chan_def *chandef,
 					 u32 cac_time_ms);
+	void	(*end_cac)(struct wiphy *wiphy,
+				struct net_device *dev);
 	int	(*update_ft_ies)(struct wiphy *wiphy, struct net_device *dev,
 				 struct cfg80211_update_ft_ies_params *ftie);
 	int	(*crit_proto_start)(struct wiphy *wiphy,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e46944500cfa1..cb7076d9a7698 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2825,6 +2825,28 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
 	return err;
 }
 
+static void ieee80211_end_cac(struct wiphy *wiphy,
+			      struct net_device *dev)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_local *local = sdata->local;
+
+	mutex_lock(&local->mtx);
+	list_for_each_entry(sdata, &local->interfaces, list) {
+		/* it might be waiting for the local->mtx, but then
+		 * by the time it gets it, sdata->wdev.cac_started
+		 * will no longer be true
+		 */
+		cancel_delayed_work(&sdata->dfs_cac_timer_work);
+
+		if (sdata->wdev.cac_started) {
+			ieee80211_vif_release_channel(sdata);
+			sdata->wdev.cac_started = false;
+		}
+	}
+	mutex_unlock(&local->mtx);
+}
+
 static struct cfg80211_beacon_data *
 cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 {
@@ -3848,6 +3870,7 @@ const struct cfg80211_ops mac80211_config_ops = {
 #endif
 	.get_channel = ieee80211_cfg_get_channel,
 	.start_radar_detection = ieee80211_start_radar_detection,
+	.end_cac = ieee80211_end_cac,
 	.channel_switch = ieee80211_channel_switch,
 	.set_qos_map = ieee80211_set_qos_map,
 	.set_ap_chanwidth = ieee80211_set_ap_chanwidth,
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 364f5d67f05b3..16dad14aabd7c 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1166,6 +1166,16 @@ rdev_start_radar_detection(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
+static inline void
+rdev_end_cac(struct cfg80211_registered_device *rdev,
+	     struct net_device *dev)
+{
+	trace_rdev_end_cac(&rdev->wiphy, dev);
+	if (rdev->ops->end_cac)
+		rdev->ops->end_cac(&rdev->wiphy, dev);
+	trace_rdev_return_void(&rdev->wiphy);
+}
+
 static inline int
 rdev_set_mcast_rate(struct cfg80211_registered_device *rdev,
 		    struct net_device *dev,
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 417a5c64c7789..5639d4a8ac9cc 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -3840,6 +3840,25 @@ bool regulatory_pre_cac_allowed(struct wiphy *wiphy)
 	return pre_cac_allowed;
 }
 
+static void cfg80211_check_and_end_cac(struct cfg80211_registered_device *rdev)
+{
+	struct wireless_dev *wdev;
+	/* If we finished CAC or received radar, we should end any
+	 * CAC running on the same channels.
+	 * the check !cfg80211_chandef_dfs_usable contain 2 options:
+	 * either all channels are available - those the CAC_FINISHED
+	 * event has effected another wdev state, or there is a channel
+	 * in unavailable state in wdev chandef - those the RADAR_DETECTED
+	 * event has effected another wdev state.
+	 * In both cases we should end the CAC on the wdev.
+	 */
+	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
+		if (wdev->cac_started &&
+		    !cfg80211_chandef_dfs_usable(&rdev->wiphy, &wdev->chandef))
+			rdev_end_cac(rdev, wdev->netdev);
+	}
+}
+
 void regulatory_propagate_dfs_state(struct wiphy *wiphy,
 				    struct cfg80211_chan_def *chandef,
 				    enum nl80211_dfs_state dfs_state,
@@ -3866,8 +3885,10 @@ void regulatory_propagate_dfs_state(struct wiphy *wiphy,
 		cfg80211_set_dfs_state(&rdev->wiphy, chandef, dfs_state);
 
 		if (event == NL80211_RADAR_DETECTED ||
-		    event == NL80211_RADAR_CAC_FINISHED)
+		    event == NL80211_RADAR_CAC_FINISHED) {
 			cfg80211_sched_dfs_chan_update(rdev);
+			cfg80211_check_and_end_cac(rdev);
+		}
 
 		nl80211_radar_notify(rdev, chandef, event, NULL, GFP_KERNEL);
 	}
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 7c73510b161f3..54b0bb344cf93 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -607,6 +607,11 @@ DEFINE_EVENT(wiphy_netdev_evt, rdev_flush_pmksa,
 	TP_ARGS(wiphy, netdev)
 );
 
+DEFINE_EVENT(wiphy_netdev_evt, rdev_end_cac,
+	     TP_PROTO(struct wiphy *wiphy, struct net_device *netdev),
+	     TP_ARGS(wiphy, netdev)
+);
+
 DECLARE_EVENT_CLASS(station_add_change,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, u8 *mac,
 		 struct station_parameters *params),
-- 
2.20.1

