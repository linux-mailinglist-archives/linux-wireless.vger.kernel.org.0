Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E14255119
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 00:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgH0WdP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 18:33:15 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:50358 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727845AbgH0WdO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 18:33:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 9AA884F81FD;
        Thu, 27 Aug 2020 22:33:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YDvAv7K-EQwP; Thu, 27 Aug 2020 22:33:09 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 8152D4F808F;
        Thu, 27 Aug 2020 22:33:06 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 02/22] cfg80211: regulatory: pass min. bandwidth to regulatory rule extractor
Date:   Thu, 27 Aug 2020 15:32:44 -0700
Message-Id: <20200827223304.16155-3-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827223304.16155-1-thomas@adapt-ip.com>
References: <20200827223304.16155-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The regulatory code assumed 20Mhz is the minimum channel
bandwidth supported. Make this a parameter so S1G code can
pass smaller bandwidths.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 drivers/net/wireless/ath/regd.c                            | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c | 3 ++-
 drivers/net/wireless/realtek/rtlwifi/regd.c                | 7 ++++---
 include/net/cfg80211.h                                     | 3 ++-
 net/mac80211/util.c                                        | 2 +-
 net/wireless/nl80211.c                                     | 3 ++-
 net/wireless/reg.c                                         | 7 ++++---
 7 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/regd.c b/drivers/net/wireless/ath/regd.c
index bee9110b91f3..f9c9ac16d2da 100644
--- a/drivers/net/wireless/ath/regd.c
+++ b/drivers/net/wireless/ath/regd.c
@@ -268,7 +268,7 @@ static void ath_force_clear_no_ir_chan(struct wiphy *wiphy,
 {
 	const struct ieee80211_reg_rule *reg_rule;
 
-	reg_rule = freq_reg_info(wiphy, MHZ_TO_KHZ(ch->center_freq));
+	reg_rule = freq_reg_info(wiphy, MHZ_TO_KHZ(ch->center_freq), 20);
 	if (IS_ERR(reg_rule))
 		return;
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
index 5a6d9c86552a..d85b2707e2fa 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/channel.c
@@ -677,7 +677,8 @@ brcms_reg_apply_beaconing_flags(struct wiphy *wiphy,
 
 			if (initiator == NL80211_REGDOM_SET_BY_COUNTRY_IE) {
 				rule = freq_reg_info(wiphy,
-						     MHZ_TO_KHZ(ch->center_freq));
+						MHZ_TO_KHZ(ch->center_freq),
+						20);
 				if (IS_ERR(rule))
 					continue;
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/regd.c b/drivers/net/wireless/realtek/rtlwifi/regd.c
index 8be31e0ad878..3f9dd4941bb1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/regd.c
+++ b/drivers/net/wireless/realtek/rtlwifi/regd.c
@@ -151,7 +151,8 @@ static void _rtl_reg_apply_beaconing_flags(struct wiphy *wiphy,
 				continue;
 			if (initiator == NL80211_REGDOM_SET_BY_COUNTRY_IE) {
 				reg_rule = freq_reg_info(wiphy,
-							 ch->center_freq);
+							 ch->center_freq,
+							 20);
 				if (IS_ERR(reg_rule))
 					continue;
 				/*
@@ -213,7 +214,7 @@ static void _rtl_reg_apply_active_scan_flags(struct wiphy *wiphy,
 	 */
 
 	ch = &sband->channels[11];	/* CH 12 */
-	reg_rule = freq_reg_info(wiphy, ch->center_freq);
+	reg_rule = freq_reg_info(wiphy, ch->center_freq, 20);
 	if (!IS_ERR(reg_rule)) {
 		if (!(reg_rule->flags & NL80211_RRF_PASSIVE_SCAN))
 			if (ch->flags & IEEE80211_CHAN_PASSIVE_SCAN)
@@ -221,7 +222,7 @@ static void _rtl_reg_apply_active_scan_flags(struct wiphy *wiphy,
 	}
 
 	ch = &sband->channels[12];	/* CH 13 */
-	reg_rule = freq_reg_info(wiphy, ch->center_freq);
+	reg_rule = freq_reg_info(wiphy, ch->center_freq, 20);
 	if (!IS_ERR(reg_rule)) {
 		if (!(reg_rule->flags & NL80211_RRF_PASSIVE_SCAN))
 			if (ch->flags & IEEE80211_CHAN_PASSIVE_SCAN)
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 3db0444086e2..2c737d6be9a1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5862,6 +5862,7 @@ void wiphy_apply_custom_regulatory(struct wiphy *wiphy,
  * freq_reg_info - get regulatory information for the given frequency
  * @wiphy: the wiphy for which we want to process this rule for
  * @center_freq: Frequency in KHz for which we want regulatory information for
+ * @min_bw: Minimum channel bandwidth in MHz for which we want regulatory information for
  *
  * Use this function to get the regulatory rule for a specific frequency on
  * a given wireless device. If the device has a specific regulatory domain
@@ -5877,7 +5878,7 @@ void wiphy_apply_custom_regulatory(struct wiphy *wiphy,
  * purely subjective and right now it's 802.11 specific.
  */
 const struct ieee80211_reg_rule *freq_reg_info(struct wiphy *wiphy,
-					       u32 center_freq);
+					       u32 center_freq, u32 min_bw);
 
 /**
  * reg_initiator_name - map regulatory request initiator enum to name
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index c8504ffc71a1..9ba1afe4ba1f 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1453,7 +1453,7 @@ void ieee80211_regulatory_limit_wmm_params(struct ieee80211_sub_if_data *sdata,
 		return;
 	}
 
-	rrule = freq_reg_info(sdata->wdev.wiphy, MHZ_TO_KHZ(center_freq));
+	rrule = freq_reg_info(sdata->wdev.wiphy, MHZ_TO_KHZ(center_freq), 20);
 
 	if (IS_ERR_OR_NULL(rrule) || !rrule->has_wmm) {
 		rcu_read_unlock();
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 5aded5de35cd..dd0f62e942ed 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1013,7 +1013,8 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 
 	if (large) {
 		const struct ieee80211_reg_rule *rule =
-			freq_reg_info(wiphy, MHZ_TO_KHZ(chan->center_freq));
+			freq_reg_info(wiphy, MHZ_TO_KHZ(chan->center_freq),
+				      20);
 
 		if (!IS_ERR_OR_NULL(rule) && rule->has_wmm) {
 			if (nl80211_msg_put_wmm_rules(msg, rule))
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 35b8847a2f6d..6c130cec22c3 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1629,9 +1629,10 @@ __freq_reg_info(struct wiphy *wiphy, u32 center_freq, u32 min_bw)
 }
 
 const struct ieee80211_reg_rule *freq_reg_info(struct wiphy *wiphy,
-					       u32 center_freq)
+					       u32 center_freq,
+					       u32 min_bw)
 {
-	return __freq_reg_info(wiphy, center_freq, MHZ_TO_KHZ(20));
+	return __freq_reg_info(wiphy, center_freq, MHZ_TO_KHZ(min_bw));
 }
 EXPORT_SYMBOL(freq_reg_info);
 
@@ -1711,7 +1712,7 @@ static void handle_channel(struct wiphy *wiphy,
 
 	flags = chan->orig_flags;
 
-	reg_rule = freq_reg_info(wiphy, ieee80211_channel_to_khz(chan));
+	reg_rule = freq_reg_info(wiphy, ieee80211_channel_to_khz(chan), 20);
 	if (IS_ERR(reg_rule)) {
 		/*
 		 * We will disable all channels that do not match our
-- 
2.20.1

