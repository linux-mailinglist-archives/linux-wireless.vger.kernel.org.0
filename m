Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15F8B15F95B
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 23:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgBNWXu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 17:23:50 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:57606 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgBNWXt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 17:23:49 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j2jND-00CrIQ-BN; Fri, 14 Feb 2020 23:23:47 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH] cfg80211: remove support for adjacent channel compensation
Date:   Fri, 14 Feb 2020 23:23:38 +0100
Message-Id: <20200214232336.a530de38e511.I393bc395f6037c8cca6421ed550e3072dc248aed@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The only driver that used that was iwlwifi and it removed
support for this. Remove the feature here as well.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 7 -------
 net/mac80211/scan.c    | 3 +--
 net/wireless/scan.c    | 6 ++----
 3 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 992bf0de6b9b..6a07d2b19c8c 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4572,12 +4572,6 @@ struct wiphy_iftype_akm_suites {
  *	and probe responses.  This value should be set if the driver
  *	wishes to limit the number of csa counters. Default (0) means
  *	infinite.
- * @max_adj_channel_rssi_comp: max offset of between the channel on which the
- *	frame was sent and the channel on which the frame was heard for which
- *	the reported rssi is still valid. If a driver is able to compensate the
- *	low rssi when a frame is heard on different channel, then it should set
- *	this variable to the maximal offset for which it can compensate.
- *	This value should be set in MHz.
  * @bss_select_support: bitmask indicating the BSS selection criteria supported
  *	by the driver in the .connect() callback. The bit position maps to the
  *	attribute indices defined in &enum nl80211_bss_select_attr.
@@ -4729,7 +4723,6 @@ struct wiphy {
 	u16 max_ap_assoc_sta;
 
 	u8 max_num_csa_counters;
-	u8 max_adj_channel_rssi_comp;
 
 	u32 bss_select_support;
 
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 4d31d9688dc2..fdac8192a519 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -201,8 +201,7 @@ ieee80211_bss_info_update(struct ieee80211_local *local,
 			       mgmt->bssid, cbss->bssid);
 
 	/* In case the signal is invalid update the status */
-	signal_valid = abs(channel->center_freq - cbss->channel->center_freq)
-		<= local->hw.wiphy->max_adj_channel_rssi_comp;
+	signal_valid = channel == cbss->channel;
 	if (!signal_valid)
 		rx_status->flag |= RX_FLAG_NO_SIGNAL_VAL;
 
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index aef240fdf8df..1fdb4118ea9a 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1434,8 +1434,7 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 	}
 	rcu_assign_pointer(tmp.pub.ies, ies);
 
-	signal_valid = abs(data->chan->center_freq - channel->center_freq) <=
-		wiphy->max_adj_channel_rssi_comp;
+	signal_valid = data->chan == channel->center_freq;
 	res = cfg80211_bss_update(wiphy_to_rdev(wiphy), &tmp, signal_valid, ts);
 	if (!res)
 		return NULL;
@@ -1852,8 +1851,7 @@ cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
 	memcpy(tmp.pub.chain_signal, data->chain_signal, IEEE80211_MAX_CHAINS);
 	ether_addr_copy(tmp.parent_bssid, data->parent_bssid);
 
-	signal_valid = abs(data->chan->center_freq - channel->center_freq) <=
-		wiphy->max_adj_channel_rssi_comp;
+	signal_valid = data->chan == channel;
 	res = cfg80211_bss_update(wiphy_to_rdev(wiphy), &tmp, signal_valid,
 				  jiffies);
 	if (!res)
-- 
2.24.1

