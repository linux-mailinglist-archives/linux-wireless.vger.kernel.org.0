Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 769DD43047
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 21:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfFLTfc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 15:35:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:65222 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbfFLTfc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 15:35:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 12:35:31 -0700
X-ExtLoop1: 1
Received: from jprestwo-test.jf.intel.com ([10.54.74.49])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jun 2019 12:35:31 -0700
From:   James Prestwood <james.prestwood@linux.intel.com>
To:     linux-wireless@vger.kernel.org
Cc:     James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 2/3] nl80211: send event when CMD_FRAME duration expires
Date:   Wed, 12 Jun 2019 12:35:09 -0700
Message-Id: <20190612193510.27680-2-james.prestwood@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190612193510.27680-1-james.prestwood@linux.intel.com>
References: <20190612193510.27680-1-james.prestwood@linux.intel.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

cfg80211_remain_on_channel_expired is used to notify userspace when
the remain on channel duration expired by sending an event. There is
no such equivalent to CMD_FRAME, where if offchannel and a duration
is provided, the card will go offchannel for that duration. Currently
there is no way for userspace to tell when that duration expired
apart from setting an independent timeout. This timeout is quite
erroneous as the kernel may not immediately send out the frame
because of scheduling or work queue delays. In testing, it was found
this timeout had to be quite large to accomidate any potential delays.

A better solution is to have the kernel send an event when this
duration has expired. There is already NL80211_CMD_FRAME_WAIT_CANCEL
which can be used to cancel a NL80211_CMD_FRAME offchannel. Using this
command matches perfectly to how NL80211_CMD_CANCEL_REMAIN_ON_CHANNEL
works, where its both used to cancel and notify if the duration has
expired.

Signed-off-by: James Prestwood <james.prestwood@linux.intel.com>
---
 include/net/cfg80211.h | 11 +++++++++++
 net/wireless/nl80211.c | 13 +++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 948139690a58..57f9774d8c90 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6492,6 +6492,17 @@ void cfg80211_remain_on_channel_expired(struct wireless_dev *wdev, u64 cookie,
 					struct ieee80211_channel *chan,
 					gfp_t gfp);
 
+/**
+ * cfg80211_tx_mgmt_expired - tx_mgmt duration expired
+ * @wdev: wireless device
+ * @cookie: the requested cookie
+ * @chan: The current channel (from tx_mgmt request)
+ * @gfp: allocation flags
+ */
+void cfg80211_tx_mgmt_expired(struct wireless_dev *wdev, u64 cookie,
+					struct ieee80211_channel *chan,
+					gfp_t gfp);
+
 /**
  * cfg80211_sinfo_alloc_tid_stats - allocate per-tid statistics.
  *
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e3c0805af415..74dbe6000fe3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -15375,6 +15375,19 @@ void cfg80211_remain_on_channel_expired(struct wireless_dev *wdev, u64 cookie,
 }
 EXPORT_SYMBOL(cfg80211_remain_on_channel_expired);
 
+void cfg80211_tx_mgmt_expired(struct wireless_dev *wdev, u64 cookie,
+					struct ieee80211_channel *chan,
+					gfp_t gfp)
+{
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+
+	trace_cfg80211_tx_mgmt_expired(wdev, cookie, chan);
+	nl80211_send_remain_on_chan_event(NL80211_CMD_FRAME_WAIT_CANCEL,
+					  rdev, wdev, cookie, chan, 0, gfp);
+}
+EXPORT_SYMBOL(cfg80211_tx_mgmt_expired);
+
 void cfg80211_new_sta(struct net_device *dev, const u8 *mac_addr,
 		      struct station_info *sinfo, gfp_t gfp)
 {
-- 
2.17.1

