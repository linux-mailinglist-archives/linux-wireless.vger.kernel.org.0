Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C095227AC6D
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Sep 2020 13:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgI1LHD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Sep 2020 07:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgI1LHD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Sep 2020 07:07:03 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A6BC061755
        for <linux-wireless@vger.kernel.org>; Mon, 28 Sep 2020 04:07:03 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kMqzl-00CRWo-Ih; Mon, 28 Sep 2020 13:07:01 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Martin Willi <martin@strongswan.org>
Subject: [PATCH] nl80211: reduce non-split wiphy dump size
Date:   Mon, 28 Sep 2020 13:06:56 +0200
Message-Id: <20200928130655.53bce7873164.I71f06c9a221cd0630429a1a56eeae68a13beca61@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When wiphy dumps cannot be split, such as in events or with
older userspace that doesn't support it, the size can today
be too big.

Reduce it, by doing two things:

 1) remove data that couldn't have been present before the
    split capability was introduced since it's new, such as
    HE capabilities

 2) as suggested by Martin Willi, remove management frame
    subtypes from the split dumps, as just (1) isn't even
    enough due to other new code capabilities. This is fine
    as old consumers (really just wpa_supplicant) didn't
    check this data before they got support for split dumps.

Reported-by: Martin Willi <martin@strongswan.org>
Suggested-by: Martin Willi <martin@strongswan.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 935ff973412a..9633b7af04c4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -926,6 +926,8 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 	if (!large && chan->flags &
 	    (IEEE80211_CHAN_NO_10MHZ | IEEE80211_CHAN_NO_20MHZ))
 		return 0;
+	if (!large && chan->freq_offset)
+		return 0;
 
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_FREQ,
 			chan->center_freq))
@@ -1603,7 +1605,8 @@ nl80211_send_iftype_data(struct sk_buff *msg,
 }
 
 static int nl80211_send_band_rateinfo(struct sk_buff *msg,
-				      struct ieee80211_supported_band *sband)
+				      struct ieee80211_supported_band *sband,
+				      bool large)
 {
 	struct nlattr *nl_rates, *nl_rate;
 	struct ieee80211_rate *rate;
@@ -1631,7 +1634,7 @@ static int nl80211_send_band_rateinfo(struct sk_buff *msg,
 			 sband->vht_cap.cap)))
 		return -ENOBUFS;
 
-	if (sband->n_iftype_data) {
+	if (large && sband->n_iftype_data) {
 		struct nlattr *nl_iftype_data =
 			nla_nest_start_noflag(msg,
 					      NL80211_BAND_ATTR_IFTYPE_DATA);
@@ -1659,7 +1662,7 @@ static int nl80211_send_band_rateinfo(struct sk_buff *msg,
 	}
 
 	/* add EDMG info */
-	if (sband->edmg_cap.channels &&
+	if (large && sband->edmg_cap.channels &&
 	    (nla_put_u8(msg, NL80211_BAND_ATTR_EDMG_CHANNELS,
 		       sband->edmg_cap.channels) ||
 	    nla_put_u8(msg, NL80211_BAND_ATTR_EDMG_BW_CONFIG,
@@ -2077,13 +2080,7 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		    nla_put_u16(msg, NL80211_ATTR_MAX_SCHED_SCAN_IE_LEN,
 				rdev->wiphy.max_sched_scan_ie_len) ||
 		    nla_put_u8(msg, NL80211_ATTR_MAX_MATCH_SETS,
-			       rdev->wiphy.max_match_sets) ||
-		    nla_put_u32(msg, NL80211_ATTR_MAX_NUM_SCHED_SCAN_PLANS,
-				rdev->wiphy.max_sched_scan_plans) ||
-		    nla_put_u32(msg, NL80211_ATTR_MAX_SCAN_PLAN_INTERVAL,
-				rdev->wiphy.max_sched_scan_plan_interval) ||
-		    nla_put_u32(msg, NL80211_ATTR_MAX_SCAN_PLAN_ITERATIONS,
-				rdev->wiphy.max_sched_scan_plan_iterations))
+			       rdev->wiphy.max_match_sets))
 			goto nla_put_failure;
 
 		if ((rdev->wiphy.flags & WIPHY_FLAG_IBSS_RSN) &&
@@ -2173,6 +2170,10 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		     band < NUM_NL80211_BANDS; band++) {
 			struct ieee80211_supported_band *sband;
 
+			/* omit higher bands for ancient software */
+			if (band > NL80211_BAND_5GHZ && !state->split)
+				break;
+
 			sband = rdev->wiphy.bands[band];
 
 			if (!sband)
@@ -2184,7 +2185,8 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 
 			switch (state->chan_start) {
 			case 0:
-				if (nl80211_send_band_rateinfo(msg, sband))
+				if (nl80211_send_band_rateinfo(msg, sband,
+							       state->split))
 					goto nla_put_failure;
 				state->chan_start++;
 				if (state->split)
@@ -2286,8 +2288,6 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 		    nla_put_flag(msg, NL80211_ATTR_OFFCHANNEL_TX_OK))
 			goto nla_put_failure;
 
-		if (nl80211_send_mgmt_stypes(msg, mgmt_stypes))
-			goto nla_put_failure;
 		state->split_start++;
 		if (state->split)
 			break;
@@ -2361,6 +2361,17 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 			state->split_start = 0;
 		break;
 	case 9:
+		if (nl80211_send_mgmt_stypes(msg, mgmt_stypes))
+			goto nla_put_failure;
+
+		if (nla_put_u32(msg, NL80211_ATTR_MAX_NUM_SCHED_SCAN_PLANS,
+				rdev->wiphy.max_sched_scan_plans) ||
+		    nla_put_u32(msg, NL80211_ATTR_MAX_SCAN_PLAN_INTERVAL,
+				rdev->wiphy.max_sched_scan_plan_interval) ||
+		    nla_put_u32(msg, NL80211_ATTR_MAX_SCAN_PLAN_ITERATIONS,
+				rdev->wiphy.max_sched_scan_plan_iterations))
+			goto nla_put_failure;
+
 		if (rdev->wiphy.extended_capabilities &&
 		    (nla_put(msg, NL80211_ATTR_EXT_CAPA,
 			     rdev->wiphy.extended_capabilities_len,
-- 
2.26.2

