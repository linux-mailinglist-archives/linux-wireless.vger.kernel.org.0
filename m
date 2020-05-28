Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4B41E6B1A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 21:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406641AbgE1TfG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 15:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406627AbgE1Te5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 15:34:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0341C08C5CB
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 12:34:55 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeOIo-0054OL-3W; Thu, 28 May 2020 21:34:54 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH v2 06/24] cfg80211: handle 6 GHz capability of new station
Date:   Thu, 28 May 2020 21:34:29 +0200
Message-Id: <20200528213443.b6b711fd4312.Ic9b97d57b6c4f2b28d4b2d23d2849d8bc20bd8cc@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528213443.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
References: <20200528213443.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rajkumar Manoharan <rmanohar@codeaurora.org>

Handle 6 GHz HE capability while adding new station. It will be used
later in mac80211 station processing.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
Link: https://lore.kernel.org/r/1589399105-25472-2-git-send-email-rmanohar@codeaurora.org
[handle nl80211_set_station, require WME,
 remove NL80211_HE_6GHZ_CAPABILITY_LEN]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h       |  2 ++
 include/uapi/linux/nl80211.h |  5 +++++
 net/wireless/nl80211.c       | 18 +++++++++++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a38653358885..da734ea71b5a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1238,6 +1238,7 @@ struct sta_txpwr {
  * @he_capa_len: the length of the HE capabilities
  * @airtime_weight: airtime scheduler weight for this station
  * @txpwr: transmit power for an associated station
+ * @he_6ghz_capa: HE 6 GHz Band capabilities of station
  */
 struct station_parameters {
 	const u8 *supported_rates;
@@ -1270,6 +1271,7 @@ struct station_parameters {
 	u8 he_capa_len;
 	u16 airtime_weight;
 	struct sta_txpwr txpwr;
+	const struct ieee80211_he_6ghz_capa *he_6ghz_capa;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c14666b75e57..e42ae429383e 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2502,6 +2502,9 @@ enum nl80211_commands {
  *	first channel segment specified in %NL80211_ATTR_CENTER_FREQ1.
  * @NL80211_ATTR_SCAN_FREQ_KHZ: nested attribute with KHz frequencies
  *
+ * @NL80211_ATTR_HE_6GHZ_CAPABILITY: HE 6 GHz Band Capability element (from
+ *	association request when used with NL80211_CMD_NEW_STATION).
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2982,6 +2985,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_CENTER_FREQ1_OFFSET,
 	NL80211_ATTR_SCAN_FREQ_KHZ,
 
+	NL80211_ATTR_HE_6GHZ_CAPABILITY,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 22c4d13e28cb..bf8bd8268cb7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -654,6 +654,10 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_RECEIVE_MULTICAST] = { .type = NLA_FLAG },
 	[NL80211_ATTR_WIPHY_FREQ_OFFSET] = NLA_POLICY_RANGE(NLA_U32, 0, 999),
 	[NL80211_ATTR_SCAN_FREQ_KHZ] = { .type = NLA_NESTED },
+	[NL80211_ATTR_HE_6GHZ_CAPABILITY] = {
+		.type = NLA_EXACT_LEN,
+		.len = sizeof(struct ieee80211_he_6ghz_capa),
+	},
 };
 
 /* policy for the key attributes */
@@ -5989,6 +5993,10 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 			nla_get_u8(info->attrs[NL80211_ATTR_OPMODE_NOTIF]);
 	}
 
+	if (info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY])
+		params.he_6ghz_capa =
+			nla_data(info->attrs[NL80211_ATTR_HE_CAPABILITY]);
+
 	if (info->attrs[NL80211_ATTR_AIRTIME_WEIGHT])
 		params.airtime_weight =
 			nla_get_u16(info->attrs[NL80211_ATTR_AIRTIME_WEIGHT]);
@@ -6123,6 +6131,10 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 			return -EINVAL;
 	}
 
+	if (info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY])
+		params.he_6ghz_capa =
+			nla_data(info->attrs[NL80211_ATTR_HE_6GHZ_CAPABILITY]);
+
 	if (info->attrs[NL80211_ATTR_OPMODE_NOTIF]) {
 		params.opmode_notif_used = true;
 		params.opmode_notif =
@@ -6167,10 +6179,14 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 		params.vht_capa = NULL;
 
 		/* HE requires WME */
-		if (params.he_capa_len)
+		if (params.he_capa_len || params.he_6ghz_capa)
 			return -EINVAL;
 	}
 
+	/* Ensure that HT/VHT capabilities are not set for 6 GHz HE STA */
+	if (params.he_6ghz_capa && (params.ht_capa || params.vht_capa))
+		return -EINVAL;
+
 	/* When you run into this, adjust the code below for the new flag */
 	BUILD_BUG_ON(NL80211_STA_FLAG_MAX != 7);
 
-- 
2.26.2

