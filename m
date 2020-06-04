Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DD21EDDB0
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 09:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgFDHKK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jun 2020 03:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgFDHKC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jun 2020 03:10:02 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAA9C08C5C0
        for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2020 00:10:02 -0700 (PDT)
Received: from [46.59.202.224] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jgk0k-0001P3-PN; Thu, 04 Jun 2020 09:09:58 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH 02/12] nl80211: add attributes for multiple bssid related settings
Date:   Thu,  4 Jun 2020 09:09:42 +0200
Message-Id: <20200604070952.15481-3-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200604070952.15481-1-john@phrozen.org>
References: <20200604070952.15481-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When we start a multiple bssid AP we need to pass the index and number of
peers aswell to the kernel. This info needs to be propagated to the
driver.

Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/cfg80211.h       | 12 ++++++++++++
 include/uapi/linux/nl80211.h |  7 +++++++
 net/wireless/nl80211.c       | 15 +++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index f0fc65f900b4..77cd2f780c6a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -448,6 +448,17 @@ struct ieee80211_supported_band {
 	const struct ieee80211_sband_iftype_data *iftype_data;
 };
 
+/**
+ * struct ieee80211_multi_bssid - AP settings for multi bssid
+ *
+ * @index: the index of this AP in the multi bssid group.
+ * @count: the total number of multi bssid peer APs.
+ */
+struct ieee80211_multi_bssid {
+	u32 index;
+	u32 count;
+};
+
 /**
  * ieee80211_get_sband_iftype_data - return sband data for a given iftype
  * @sband: the sband to search for the STA on
@@ -1113,6 +1124,7 @@ struct cfg80211_ap_settings {
 	u32 flags;
 	struct ieee80211_he_obss_pd he_obss_pd;
 	struct cfg80211_he_bss_color he_bss_color;
+	struct ieee80211_multi_bssid multi_bssid;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index a586567f18ea..f18f681796ed 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2476,6 +2476,11 @@ enum nl80211_commands {
  * @NL80211_ATTR_MULTI_BSSID_PARENT: If this is a Non-Transmitted BSSID, define
  *	the parent interface.
  *
+ * @NL80211_ATTR_MULTI_BSSID_INDEX: The index of this BSS inside the multi bssid
+ *	IE.
+ *
+ * @NL80211_ATTR_MULTI_BSSID_COUNT: The number of BSSs inside the multi bssid IE.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2953,6 +2958,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_MULTI_BSSID_MODE,
 	NL80211_ATTR_MULTI_BSSID_PARENT,
+	NL80211_ATTR_MULTI_BSSID_INDEX,
+	NL80211_ATTR_MULTI_BSSID_COUNT,
 
 	/* add attributes here, update the policy in nl80211.c */
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3b502514944c..58ce67bc31da 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -667,6 +667,8 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 					NL80211_MULTIPLE_BSSID_LEGACY,
 					NL80211_MULTIPLE_BSSID_NON_TRANSMITTED),
 	[NL80211_ATTR_MULTI_BSSID_PARENT] = { .type = NLA_U32 },
+	[NL80211_ATTR_MULTI_BSSID_INDEX] = { .type = NLA_U32 },
+	[NL80211_ATTR_MULTI_BSSID_COUNT] = { .type = NLA_U32 },
 };
 
 /* policy for the key attributes */
@@ -4996,6 +4998,11 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	    !info->attrs[NL80211_ATTR_BEACON_HEAD])
 		return -EINVAL;
 
+	if (wdev->multi_bssid_mode == NL80211_MULTIPLE_BSSID_NON_TRANSMITTED &&
+	    (!info->attrs[NL80211_ATTR_MULTI_BSSID_INDEX] ||
+	     !info->attrs[NL80211_ATTR_MULTI_BSSID_COUNT]))
+		return -EINVAL;
+
 	err = nl80211_parse_beacon(rdev, info->attrs, &params.beacon);
 	if (err)
 		return err;
@@ -5150,6 +5157,14 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			return err;
 	}
 
+	if (info->attrs[NL80211_ATTR_MULTI_BSSID_INDEX])
+		params.multi_bssid.index = nla_get_u32(
+				info->attrs[NL80211_ATTR_MULTI_BSSID_INDEX]);
+
+	if (info->attrs[NL80211_ATTR_MULTI_BSSID_COUNT])
+		params.multi_bssid.count = nla_get_u32(
+				info->attrs[NL80211_ATTR_MULTI_BSSID_COUNT]);
+
 	nl80211_calculate_ap_params(&params);
 
 	if (info->attrs[NL80211_ATTR_EXTERNAL_AUTH_SUPPORT])
-- 
2.20.1

