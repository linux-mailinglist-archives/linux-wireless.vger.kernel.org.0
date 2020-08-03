Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E1323A8BF
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 16:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgHCOn6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 10:43:58 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:51354 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgHCOn6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 10:43:58 -0400
Received: from legolas.prakinf.tu-ilmenau.de (unknown [141.24.207.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 2D79A58005E;
        Mon,  3 Aug 2020 16:43:55 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v3 1/2] cfg80211: add helper fn for single rule channels
Date:   Mon,  3 Aug 2020 16:43:52 +0200
Message-Id: <20200803144353.305538-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As a preparation to handle adjacent rule channels,
factor out handling channels located in a single
regulatory rule.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
v3: style fixes

 net/wireless/reg.c | 106 +++++++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 47 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 35b8847a2f6d..3dff817a9559 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1691,57 +1691,18 @@ static uint32_t reg_rule_to_chan_bw_flags(const struct ieee80211_regdomain *regd
 	return bw_flags;
 }
 
-/*
- * Note that right now we assume the desired channel bandwidth
- * is always 20 MHz for each individual channel (HT40 uses 20 MHz
- * per channel, the primary and the extension channel).
- */
-static void handle_channel(struct wiphy *wiphy,
-			   enum nl80211_reg_initiator initiator,
-			   struct ieee80211_channel *chan)
+static void handle_channel_single_rule(struct wiphy *wiphy,
+				       enum nl80211_reg_initiator initiator,
+				       struct ieee80211_channel *chan,
+				       u32 flags,
+				       struct regulatory_request *lr,
+				       struct wiphy *request_wiphy,
+				       const struct ieee80211_reg_rule *reg_rule)
 {
-	u32 flags, bw_flags = 0;
-	const struct ieee80211_reg_rule *reg_rule = NULL;
+	u32 bw_flags = 0;
 	const struct ieee80211_power_rule *power_rule = NULL;
-	struct wiphy *request_wiphy = NULL;
-	struct regulatory_request *lr = get_last_request();
 	const struct ieee80211_regdomain *regd;
 
-	request_wiphy = wiphy_idx_to_wiphy(lr->wiphy_idx);
-
-	flags = chan->orig_flags;
-
-	reg_rule = freq_reg_info(wiphy, ieee80211_channel_to_khz(chan));
-	if (IS_ERR(reg_rule)) {
-		/*
-		 * We will disable all channels that do not match our
-		 * received regulatory rule unless the hint is coming
-		 * from a Country IE and the Country IE had no information
-		 * about a band. The IEEE 802.11 spec allows for an AP
-		 * to send only a subset of the regulatory rules allowed,
-		 * so an AP in the US that only supports 2.4 GHz may only send
-		 * a country IE with information for the 2.4 GHz band
-		 * while 5 GHz is still supported.
-		 */
-		if (initiator == NL80211_REGDOM_SET_BY_COUNTRY_IE &&
-		    PTR_ERR(reg_rule) == -ERANGE)
-			return;
-
-		if (lr->initiator == NL80211_REGDOM_SET_BY_DRIVER &&
-		    request_wiphy && request_wiphy == wiphy &&
-		    request_wiphy->regulatory_flags & REGULATORY_STRICT_REG) {
-			pr_debug("Disabling freq %d.%03d MHz for good\n",
-				 chan->center_freq, chan->freq_offset);
-			chan->orig_flags |= IEEE80211_CHAN_DISABLED;
-			chan->flags = chan->orig_flags;
-		} else {
-			pr_debug("Disabling freq %d.%03d MHz\n",
-				 chan->center_freq, chan->freq_offset);
-			chan->flags |= IEEE80211_CHAN_DISABLED;
-		}
-		return;
-	}
-
 	regd = reg_get_regdomain(wiphy);
 
 	power_rule = &reg_rule->power_rule;
@@ -1803,6 +1764,57 @@ static void handle_channel(struct wiphy *wiphy,
 		chan->max_power = chan->max_reg_power;
 }
 
+/* Note that right now we assume the desired channel bandwidth
+ * is always 20 MHz for each individual channel (HT40 uses 20 MHz
+ * per channel, the primary and the extension channel).
+ */
+static void handle_channel(struct wiphy *wiphy,
+			   enum nl80211_reg_initiator initiator,
+			   struct ieee80211_channel *chan)
+{
+	u32 flags = 0;
+	const struct ieee80211_reg_rule *reg_rule = NULL;
+	struct wiphy *request_wiphy = NULL;
+	struct regulatory_request *lr = get_last_request();
+
+	request_wiphy = wiphy_idx_to_wiphy(lr->wiphy_idx);
+
+	flags = chan->orig_flags;
+
+	reg_rule = freq_reg_info(wiphy, ieee80211_channel_to_khz(chan));
+	if (IS_ERR(reg_rule)) {
+		/* We will disable all channels that do not match our
+		 * received regulatory rule unless the hint is coming
+		 * from a Country IE and the Country IE had no information
+		 * about a band. The IEEE 802.11 spec allows for an AP
+		 * to send only a subset of the regulatory rules allowed,
+		 * so an AP in the US that only supports 2.4 GHz may only send
+		 * a country IE with information for the 2.4 GHz band
+		 * while 5 GHz is still supported.
+		 */
+		if (initiator == NL80211_REGDOM_SET_BY_COUNTRY_IE &&
+		    PTR_ERR(reg_rule) == -ERANGE)
+			return;
+
+		if (lr->initiator == NL80211_REGDOM_SET_BY_DRIVER &&
+		    request_wiphy && request_wiphy == wiphy &&
+		    request_wiphy->regulatory_flags & REGULATORY_STRICT_REG) {
+			pr_debug("Disabling freq %d.%03d MHz for good\n",
+				 chan->center_freq, chan->freq_offset);
+			chan->orig_flags |= IEEE80211_CHAN_DISABLED;
+			chan->flags = chan->orig_flags;
+		} else {
+			pr_debug("Disabling freq %d.%03d MHz\n",
+				 chan->center_freq, chan->freq_offset);
+			chan->flags |= IEEE80211_CHAN_DISABLED;
+		}
+		return;
+	}
+
+	handle_channel_single_rule(wiphy, initiator, chan, flags, lr,
+				   request_wiphy, reg_rule);
+}
+
 static void handle_band(struct wiphy *wiphy,
 			enum nl80211_reg_initiator initiator,
 			struct ieee80211_supported_band *sband)
-- 
2.28.0

