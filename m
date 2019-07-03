Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED775E599
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2019 15:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfGCNia (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jul 2019 09:38:30 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:38374 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfGCNia (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jul 2019 09:38:30 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hifSv-0000Uu-7W; Wed, 03 Jul 2019 15:38:29 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/3] cfg80211: give all multi-BSSID BSS entries the same timestamp
Date:   Wed,  3 Jul 2019 15:38:23 +0200
Message-Id: <20190703133823.10530-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190703133823.10530-1-johannes@sipsolutions.net>
References: <20190703133823.10530-1-johannes@sipsolutions.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we just read jiffies over and over again, a non-transmitting
entry may have a newer timestamp than the transmitting one,
leading to possible confusion on expiry. Give them all the same
timestamp when creating them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/scan.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 186ae1bb510a..a98dabab557a 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1368,6 +1368,7 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 	struct cfg80211_internal_bss tmp = {}, *res;
 	int bss_type;
 	bool signal_valid;
+	unsigned long ts;
 
 	if (WARN_ON(!wiphy))
 		return NULL;
@@ -1390,8 +1391,11 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 	tmp.ts_boottime = data->boottime_ns;
 	if (non_tx_data) {
 		tmp.pub.transmitted_bss = non_tx_data->tx_bss;
+		ts = bss_from_pub(non_tx_data->tx_bss)->ts;
 		tmp.pub.bssid_index = non_tx_data->bssid_index;
 		tmp.pub.max_bssid_indicator = non_tx_data->max_bssid_indicator;
+	} else {
+		ts = jiffies;
 	}
 
 	/*
@@ -1425,8 +1429,7 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 
 	signal_valid = abs(data->chan->center_freq - channel->center_freq) <=
 		wiphy->max_adj_channel_rssi_comp;
-	res = cfg80211_bss_update(wiphy_to_rdev(wiphy), &tmp, signal_valid,
-				  jiffies);
+	res = cfg80211_bss_update(wiphy_to_rdev(wiphy), &tmp, signal_valid, ts);
 	if (!res)
 		return NULL;
 
-- 
2.17.2

