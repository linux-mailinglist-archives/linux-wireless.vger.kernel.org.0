Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C92A2C79C2
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Nov 2020 16:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387408AbgK2Pbz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Nov 2020 10:31:55 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:33570 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728008AbgK2Pby (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Nov 2020 10:31:54 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kjOfK-0035ld-Ax; Sun, 29 Nov 2020 17:31:06 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 29 Nov 2020 17:30:55 +0200
Message-Id: <iwlwifi.20201129172929.8953ef22cc64.Ifee9cab337a4369938545920ba5590559e91327a@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129153055.1971298-1-luca@coelho.fi>
References: <20201129153055.1971298-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 13/13] cfg80211: include block-tx flag in channel switch started event
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In the NL80211_CMD_CH_SWITCH_STARTED_NOTIFY event, include the
NL80211_ATTR_CH_SWITCH_BLOCK_TX flag attribute if block-tx was
requested by the AP.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/cfg80211.h       |  3 ++-
 include/uapi/linux/nl80211.h |  3 ++-
 net/mac80211/cfg.c           |  2 +-
 net/mac80211/mlme.c          |  2 +-
 net/wireless/nl80211.c       | 17 +++++++++++------
 5 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4a5ae7fb7d59..23bc74d2523f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7531,6 +7531,7 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
  * @dev: the device on which the channel switch started
  * @chandef: the future channel definition
  * @count: the number of TBTTs until the channel switch happens
+ * @quiet: whether or not immediate quiet was requested by the AP
  *
  * Inform the userspace about the channel switch that has just
  * started, so that it can take appropriate actions (eg. starting
@@ -7538,7 +7539,7 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
  */
 void cfg80211_ch_switch_started_notify(struct net_device *dev,
 				       struct cfg80211_chan_def *chandef,
-				       u8 count);
+				       u8 count, bool quiet);
 
 /**
  * ieee80211_operating_class_to_band - convert operating class to band
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 3e0d4a038ab6..83c860395dd6 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2079,7 +2079,8 @@ enum nl80211_commands {
  *	until the channel switch event.
  * @NL80211_ATTR_CH_SWITCH_BLOCK_TX: flag attribute specifying that transmission
  *	must be blocked on the current channel (before the channel switch
- *	operation).
+ *	operation). Also included in the channel switch started event if quiet
+ *	was requested by the AP.
  * @NL80211_ATTR_CSA_IES: Nested set of attributes containing the IE information
  *	for the time while performing a channel switch.
  * @NL80211_ATTR_CNTDWN_OFFS_BEACON: An array of offsets (u16) to the channel
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 454432ced0c9..f9d8ebf96e92 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3448,7 +3448,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
 
 	cfg80211_ch_switch_started_notify(sdata->dev, &sdata->csa_chandef,
-					  params->count);
+					  params->count, params->block_tx);
 
 	if (changed) {
 		ieee80211_bss_info_change_notify(sdata, changed);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 67829667d394..d4da9822a111 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1509,7 +1509,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	mutex_unlock(&local->mtx);
 
 	cfg80211_ch_switch_started_notify(sdata->dev, &csa_ie.chandef,
-					  csa_ie.count);
+					  csa_ie.count, csa_ie.mode);
 
 	if (local->ops->channel_switch) {
 		/* use driver's channel switch callback */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 67c52f4b45fa..ff9b162259fb 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -17061,7 +17061,7 @@ static void nl80211_ch_switch_notify(struct cfg80211_registered_device *rdev,
 				     struct cfg80211_chan_def *chandef,
 				     gfp_t gfp,
 				     enum nl80211_commands notif,
-				     u8 count)
+				     u8 count, bool quiet)
 {
 	struct sk_buff *msg;
 	void *hdr;
@@ -17082,9 +17082,13 @@ static void nl80211_ch_switch_notify(struct cfg80211_registered_device *rdev,
 	if (nl80211_send_chandef(msg, chandef))
 		goto nla_put_failure;
 
-	if ((notif == NL80211_CMD_CH_SWITCH_STARTED_NOTIFY) &&
-	    (nla_put_u32(msg, NL80211_ATTR_CH_SWITCH_COUNT, count)))
+	if (notif == NL80211_CMD_CH_SWITCH_STARTED_NOTIFY) {
+		if (nla_put_u32(msg, NL80211_ATTR_CH_SWITCH_COUNT, count))
 			goto nla_put_failure;
+		if (quiet &&
+		    nla_put_flag(msg, NL80211_ATTR_CH_SWITCH_BLOCK_TX))
+			goto nla_put_failure;
+	}
 
 	genlmsg_end(msg, hdr);
 
@@ -17117,13 +17121,13 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 	cfg80211_sched_dfs_chan_update(rdev);
 
 	nl80211_ch_switch_notify(rdev, dev, chandef, GFP_KERNEL,
-				 NL80211_CMD_CH_SWITCH_NOTIFY, 0);
+				 NL80211_CMD_CH_SWITCH_NOTIFY, 0, false);
 }
 EXPORT_SYMBOL(cfg80211_ch_switch_notify);
 
 void cfg80211_ch_switch_started_notify(struct net_device *dev,
 				       struct cfg80211_chan_def *chandef,
-				       u8 count)
+				       u8 count, bool quiet)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct wiphy *wiphy = wdev->wiphy;
@@ -17132,7 +17136,8 @@ void cfg80211_ch_switch_started_notify(struct net_device *dev,
 	trace_cfg80211_ch_switch_started_notify(dev, chandef);
 
 	nl80211_ch_switch_notify(rdev, dev, chandef, GFP_KERNEL,
-				 NL80211_CMD_CH_SWITCH_STARTED_NOTIFY, count);
+				 NL80211_CMD_CH_SWITCH_STARTED_NOTIFY,
+				 count, quiet);
 }
 EXPORT_SYMBOL(cfg80211_ch_switch_started_notify);
 
-- 
2.29.2

