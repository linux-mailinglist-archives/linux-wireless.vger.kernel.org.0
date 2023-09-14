Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4287A0270
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Sep 2023 13:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbjINLV5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Sep 2023 07:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjINLV4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Sep 2023 07:21:56 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBCFE3
        for <linux-wireless@vger.kernel.org>; Thu, 14 Sep 2023 04:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Tp8nDQfH96rjRi+kMTellp6mO3lgXDF9ptFaWDcQkGo=; b=BIRFCSfXMtK97jJkGp3jC+Hbxg
        ioaJjXbz6ULBu/3gwBfyxcEg37VUsB5BfnGMAN7pB6pvriN01G070xkn1467+YvFElgqsxB/VaU4j
        j2ReuxwN97vR6Tm6vhYSTn9CB8D95YAzyTSr8Kpxhn+0BofgabDe28dqMwKydpyow9X8=;
Received: from p4ff13705.dip0.t-ipconnect.de ([79.241.55.5] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1qgkPs-001jKI-AP; Thu, 14 Sep 2023 13:21:48 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH wireless] cfg80211: allow grace period for DFS available after beacon shutdown
Date:   Thu, 14 Sep 2023 13:21:47 +0200
Message-ID: <20230914112147.26985-1-nbd@nbd.name>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes reconfiguring an AP on a DFS channel in non-ETSI regdomain

Fixes: b35a51c7dd25 ("cfg80211: Make pre-CAC results valid only for ETSI domain")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/cfg80211.h |  3 +++
 net/wireless/ap.c      |  6 +++---
 net/wireless/chan.c    | 45 ++++++++++++++++++++++++++++++++++++++++++
 net/wireless/core.h    |  2 ++
 net/wireless/mlme.c    |  7 ++++---
 5 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8fcfe1869424..dbb1c85ccc58 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -170,6 +170,8 @@ enum ieee80211_channel_flags {
  * @dfs_state: current state of this channel. Only relevant if radar is required
  *	on this channel.
  * @dfs_state_entered: timestamp (jiffies) when the dfs state was entered.
+ * @dfs_state_last_available: timestamp (jiffies) of the last time when the
+ *	channel was available.
  * @dfs_cac_ms: DFS CAC time in milliseconds, this is valid for DFS channels.
  */
 struct ieee80211_channel {
@@ -186,6 +188,7 @@ struct ieee80211_channel {
 	int orig_mag, orig_mpwr;
 	enum nl80211_dfs_state dfs_state;
 	unsigned long dfs_state_entered;
+	unsigned long dfs_state_last_available;
 	unsigned int dfs_cac_ms;
 };
 
diff --git a/net/wireless/ap.c b/net/wireless/ap.c
index 9a9a870806f5..9cd0ab4dbf69 100644
--- a/net/wireless/ap.c
+++ b/net/wireless/ap.c
@@ -30,6 +30,9 @@ static int ___cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
 	if (!wdev->links[link_id].ap.beacon_interval)
 		return -ENOENT;
 
+	cfg80211_update_last_available(wdev->wiphy,
+				       &wdev->links[link_id].ap.chandef);
+
 	err = rdev_stop_ap(rdev, dev, link_id);
 	if (!err) {
 		wdev->conn_owner_nlportid = 0;
@@ -41,9 +44,6 @@ static int ___cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
 		if (notify)
 			nl80211_send_ap_stopped(wdev, link_id);
 
-		/* Should we apply the grace period during beaconing interface
-		 * shutdown also?
-		 */
 		cfg80211_sched_dfs_chan_update(rdev);
 	}
 
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 2d21e423abdb..0ce0b4ae8375 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -461,6 +461,8 @@ static void cfg80211_set_chans_dfs_state(struct wiphy *wiphy, u32 center_freq,
 
 		c->dfs_state = dfs_state;
 		c->dfs_state_entered = jiffies;
+		if (dfs_state == NL80211_DFS_AVAILABLE)
+			c->dfs_state_last_available = jiffies;
 	}
 }
 
@@ -874,6 +876,49 @@ static bool cfg80211_get_chans_dfs_available(struct wiphy *wiphy,
 	return true;
 }
 
+static void
+__cfg80211_update_last_available(struct wiphy *wiphy,
+					 u32 center_freq,
+					 u32 bandwidth)
+{
+	struct ieee80211_channel *c;
+	u32 freq, start_freq, end_freq;
+
+	start_freq = cfg80211_get_start_freq(center_freq, bandwidth);
+	end_freq = cfg80211_get_end_freq(center_freq, bandwidth);
+
+	/*
+	 * Check entire range of channels for the bandwidth.
+	 * If any channel in between is disabled or has not
+	 * had gone through CAC return false
+	 */
+	for (freq = start_freq; freq <= end_freq; freq += MHZ_TO_KHZ(20)) {
+		c = ieee80211_get_channel_khz(wiphy, freq);
+		if (!c)
+			return;
+
+		c->dfs_state_last_available = jiffies;
+	}
+}
+
+void cfg80211_update_last_available(struct wiphy *wiphy,
+				    const struct cfg80211_chan_def *chandef)
+{
+	int width;
+
+	width = cfg80211_chandef_get_width(chandef);
+	if (width < 0)
+		return;
+
+	__cfg80211_update_last_available(wiphy, MHZ_TO_KHZ(chandef->center_freq1),
+						 width);
+	if (chandef->width != NL80211_CHAN_WIDTH_80P80)
+	    return;
+
+	__cfg80211_update_last_available(wiphy, MHZ_TO_KHZ(chandef->center_freq2),
+						 width);
+}
+
 static bool cfg80211_chandef_dfs_available(struct wiphy *wiphy,
 				const struct cfg80211_chan_def *chandef)
 {
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 866f0a6934e6..bc68c204b1c4 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -457,6 +457,8 @@ void cfg80211_set_dfs_state(struct wiphy *wiphy,
 			    enum nl80211_dfs_state dfs_state);
 
 void cfg80211_dfs_channels_update_work(struct work_struct *work);
+void cfg80211_update_last_available(struct wiphy *wiphy,
+				    const struct cfg80211_chan_def *chandef);
 
 void cfg80211_sched_dfs_chan_update(struct cfg80211_registered_device *rdev);
 
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index cc7ae9ea84ea..43a93791dcfd 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -927,6 +927,8 @@ void cfg80211_dfs_channels_update_work(struct work_struct *work)
 			if (c->dfs_state == NL80211_DFS_UNAVAILABLE) {
 				time_dfs_update = IEEE80211_DFS_MIN_NOP_TIME_MS;
 				radar_event = NL80211_RADAR_NOP_FINISHED;
+				timeout = c->dfs_state_entered +
+					  msecs_to_jiffies(time_dfs_update);
 			} else {
 				if (regulatory_pre_cac_allowed(wiphy) ||
 				    cfg80211_any_wiphy_oper_chan(wiphy, c))
@@ -934,11 +936,10 @@ void cfg80211_dfs_channels_update_work(struct work_struct *work)
 
 				time_dfs_update = REG_PRE_CAC_EXPIRY_GRACE_MS;
 				radar_event = NL80211_RADAR_PRE_CAC_EXPIRED;
+				timeout = c->dfs_state_last_available +
+					  msecs_to_jiffies(time_dfs_update);
 			}
 
-			timeout = c->dfs_state_entered +
-				  msecs_to_jiffies(time_dfs_update);
-
 			if (time_after_eq(jiffies, timeout)) {
 				c->dfs_state = NL80211_DFS_USABLE;
 				c->dfs_state_entered = jiffies;
-- 
2.41.0

