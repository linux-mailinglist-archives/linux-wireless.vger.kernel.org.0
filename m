Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 397D3168F19
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2020 14:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgBVN1b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Feb 2020 08:27:31 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:52818 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726839AbgBVN1b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Feb 2020 08:27:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582378050; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=RyU/NOeegB27txSh4G8hKwIhzuyY2GuGxncyK8mvlJU=; b=K6VqTkorBKhw0aQODxllxBq59ZzRz+ew8sSq7bWVdFF9j5ahB/hwtX3i3hDSDV0nvdhLXopB
 1LK1JDkYDLo6uu0YXbFyftaYdYP7PkgJZRIscJ8E4ON225zSHXsMuQCxpMWRcTvbxFNlaLnn
 YomRbeTzn/b9qErE+W2OHdFV3OI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e512c2e.7f0e2b1423e8-smtp-out-n03;
 Sat, 22 Feb 2020 13:27:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D5008C43383; Sat, 22 Feb 2020 13:27:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (176-93-35-56.bb.dnainternet.fi [176.93.35.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 859F3C4479D;
        Sat, 22 Feb 2020 13:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 859F3C4479D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 2/7] cfg80211: Support key configuration for Beacon protection (BIGTK)
Date:   Sat, 22 Feb 2020 15:25:43 +0200
Message-Id: <20200222132548.20835-2-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200222132548.20835-1-jouni@codeaurora.org>
References: <20200222132548.20835-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

IEEE P802.11-REVmd/D3.0 adds support for protecting Beacon frames using
a new set of keys (BIGTK; key index 6..7) similarly to the way
group-addressed Robust Management frames are protected (IGTK; key index
4..5). Extend cfg80211 and nl80211 to allow the new BIGTK to be
configured. Add an extended feature flag to indicate driver support for
the new key index values to avoid array overflows in driver
implementations and also to indicate to user space when this
functionality is available.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 include/net/cfg80211.h       |  5 ++++
 include/uapi/linux/nl80211.h |  6 ++++
 net/wireless/nl80211.c       | 56 +++++++++++++++++++++++++++++-------
 net/wireless/rdev-ops.h      | 13 +++++++++
 net/wireless/sme.c           | 11 +++++--
 net/wireless/trace.h         | 17 +++++++++++
 net/wireless/util.c          |  7 ++++-
 7 files changed, 101 insertions(+), 14 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7ea23caa7301..4bb3b3811ebe 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3369,6 +3369,8 @@ struct cfg80211_update_owe_info {
  * @set_default_key: set the default key on an interface
  *
  * @set_default_mgmt_key: set the default management frame key on an interface
+
+ * @set_default_beacon_key: set the default Beacon frame key on an interface
  *
  * @set_rekey_data: give the data necessary for GTK rekeying to the driver
  *
@@ -3702,6 +3704,9 @@ struct cfg80211_ops {
 	int	(*set_default_mgmt_key)(struct wiphy *wiphy,
 					struct net_device *netdev,
 					u8 key_index);
+	int	(*set_default_beacon_key)(struct wiphy *wiphy,
+					  struct net_device *netdev,
+					  u8 key_index);
 
 	int	(*start_ap)(struct wiphy *wiphy, struct net_device *dev,
 			    struct cfg80211_ap_settings *settings);
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 158bccb4a47b..e331038d114b 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4559,6 +4559,7 @@ enum nl80211_key_default_types {
  *	See &enum nl80211_key_default_types.
  * @NL80211_KEY_MODE: the mode from enum nl80211_key_mode.
  *	Defaults to @NL80211_KEY_RX_TX.
+ * @NL80211_KEY_DEFAULT_BEACON: flag indicating default Beacon frame key
  *
  * @__NL80211_KEY_AFTER_LAST: internal
  * @NL80211_KEY_MAX: highest key attribute
@@ -4574,6 +4575,7 @@ enum nl80211_key_attributes {
 	NL80211_KEY_TYPE,
 	NL80211_KEY_DEFAULT_TYPES,
 	NL80211_KEY_MODE,
+	NL80211_KEY_DEFAULT_BEACON,
 
 	/* keep last */
 	__NL80211_KEY_AFTER_LAST,
@@ -5552,6 +5554,9 @@ enum nl80211_feature_flags {
  *	can use src and dst MAC addresses with control port over nl80211 rx
  *	and tx operations.
  *
+ * @NL80211_EXT_FEATURE_BEACON_PROTECTION: The driver supports Beacon protection
+ *	and can receive key configuration for BIGTK using key indexes 6 and 7.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5600,6 +5605,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_VLAN_OFFLOAD,
 	NL80211_EXT_FEATURE_AQL,
 	NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_MAC_ADDRS,
+	NL80211_EXT_FEATURE_BEACON_PROTECTION,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 447c388b5905..fac699731417 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -368,7 +368,7 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_KEY] = { .type = NLA_NESTED, },
 	[NL80211_ATTR_KEY_DATA] = { .type = NLA_BINARY,
 				    .len = WLAN_MAX_KEY_LEN },
-	[NL80211_ATTR_KEY_IDX] = NLA_POLICY_MAX(NLA_U8, 5),
+	[NL80211_ATTR_KEY_IDX] = NLA_POLICY_MAX(NLA_U8, 7),
 	[NL80211_ATTR_KEY_CIPHER] = { .type = NLA_U32 },
 	[NL80211_ATTR_KEY_DEFAULT] = { .type = NLA_FLAG },
 	[NL80211_ATTR_KEY_SEQ] = { .type = NLA_BINARY, .len = 16 },
@@ -1039,7 +1039,7 @@ struct key_parse {
 	struct key_params p;
 	int idx;
 	int type;
-	bool def, defmgmt;
+	bool def, defmgmt, defbeacon;
 	bool def_uni, def_multi;
 };
 
@@ -1055,12 +1055,13 @@ static int nl80211_parse_key_new(struct genl_info *info, struct nlattr *key,
 
 	k->def = !!tb[NL80211_KEY_DEFAULT];
 	k->defmgmt = !!tb[NL80211_KEY_DEFAULT_MGMT];
+	k->defbeacon = !!tb[NL80211_KEY_DEFAULT_BEACON];
 
 	if (k->def) {
 		k->def_uni = true;
 		k->def_multi = true;
 	}
-	if (k->defmgmt)
+	if (k->defmgmt || k->defbeacon)
 		k->def_multi = true;
 
 	if (tb[NL80211_KEY_IDX])
@@ -1167,14 +1168,17 @@ static int nl80211_parse_key(struct genl_info *info, struct key_parse *k)
 	if (err)
 		return err;
 
-	if (k->def && k->defmgmt) {
-		GENL_SET_ERR_MSG(info, "key with def && defmgmt is invalid");
+	if ((k->def ? 1 : 0) + (k->defmgmt ? 1 : 0) +
+	    (k->defbeacon ? 1 : 0) > 1) {
+		GENL_SET_ERR_MSG(info,
+				 "key with multiple default flags is invalid");
 		return -EINVAL;
 	}
 
-	if (k->defmgmt) {
+	if (k->defmgmt || k->defbeacon) {
 		if (k->def_uni || !k->def_multi) {
-			GENL_SET_ERR_MSG(info, "defmgmt key must be mcast");
+			GENL_SET_ERR_MSG(info,
+					 "defmgmt/defbeacon key must be mcast");
 			return -EINVAL;
 		}
 	}
@@ -1186,14 +1190,20 @@ static int nl80211_parse_key(struct genl_info *info, struct key_parse *k)
 						 "defmgmt key idx not 4 or 5");
 				return -EINVAL;
 			}
+		} else if (k->defbeacon) {
+			if (k->idx < 6 || k->idx > 7) {
+				GENL_SET_ERR_MSG(info,
+						 "defbeacon key idx not 6 or 7");
+				return -EINVAL;
+			}
 		} else if (k->def) {
 			if (k->idx < 0 || k->idx > 3) {
 				GENL_SET_ERR_MSG(info, "def key idx not 0-3");
 				return -EINVAL;
 			}
 		} else {
-			if (k->idx < 0 || k->idx > 5) {
-				GENL_SET_ERR_MSG(info, "key idx not 0-5");
+			if (k->idx < 0 || k->idx > 7) {
+				GENL_SET_ERR_MSG(info, "key idx not 0-7");
 				return -EINVAL;
 			}
 		}
@@ -3819,8 +3829,14 @@ static int nl80211_get_key(struct sk_buff *skb, struct genl_info *info)
 	void *hdr;
 	struct sk_buff *msg;
 
-	if (info->attrs[NL80211_ATTR_KEY_IDX])
+	if (info->attrs[NL80211_ATTR_KEY_IDX]) {
 		key_idx = nla_get_u8(info->attrs[NL80211_ATTR_KEY_IDX]);
+		if (key_idx > 5 &&
+		    !wiphy_ext_feature_isset(
+			    &rdev->wiphy,
+			    NL80211_EXT_FEATURE_BEACON_PROTECTION))
+			return -EINVAL;
+	}
 
 	if (info->attrs[NL80211_ATTR_MAC])
 		mac_addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
@@ -3896,7 +3912,7 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 	/* Only support setting default key and
 	 * Extended Key ID action NL80211_KEY_SET_TX.
 	 */
-	if (!key.def && !key.defmgmt &&
+	if (!key.def && !key.defmgmt && !key.defbeacon &&
 	    !(key.p.mode == NL80211_KEY_SET_TX))
 		return -EINVAL;
 
@@ -3943,6 +3959,24 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 #ifdef CONFIG_CFG80211_WEXT
 		dev->ieee80211_ptr->wext.default_mgmt_key = key.idx;
 #endif
+	} else if (key.defbeacon) {
+		if (key.def_uni || !key.def_multi) {
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (!rdev->ops->set_default_beacon_key) {
+			err = -EOPNOTSUPP;
+			goto out;
+		}
+
+		err = nl80211_key_allowed(dev->ieee80211_ptr);
+		if (err)
+			goto out;
+
+		err = rdev_set_default_beacon_key(rdev, dev, key.idx);
+		if (err)
+			goto out;
 	} else if (key.p.mode == NL80211_KEY_SET_TX &&
 		   wiphy_ext_feature_isset(&rdev->wiphy,
 					   NL80211_EXT_FEATURE_EXT_KEY_ID)) {
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 5ea34c1b60fe..9063035b2902 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -136,6 +136,19 @@ rdev_set_default_mgmt_key(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
+static inline int
+rdev_set_default_beacon_key(struct cfg80211_registered_device *rdev,
+			    struct net_device *netdev, u8 key_index)
+{
+	int ret;
+
+	trace_rdev_set_default_beacon_key(&rdev->wiphy, netdev, key_index);
+	ret = rdev->ops->set_default_beacon_key(&rdev->wiphy, netdev,
+						key_index);
+	trace_rdev_return_int(&rdev->wiphy, ret);
+	return ret;
+}
+
 static inline int rdev_start_ap(struct cfg80211_registered_device *rdev,
 				struct net_device *dev,
 				struct cfg80211_ap_settings *settings)
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index d32a2ec4d96a..ac3e60aa1fc8 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1111,9 +1111,16 @@ void __cfg80211_disconnected(struct net_device *dev, const u8 *ie,
 	 * Delete all the keys ... pairwise keys can't really
 	 * exist any more anyway, but default keys might.
 	 */
-	if (rdev->ops->del_key)
-		for (i = 0; i < 6; i++)
+	if (rdev->ops->del_key) {
+		int max_key_idx = 5;
+
+		if (wiphy_ext_feature_isset(
+			    wdev->wiphy,
+			    NL80211_EXT_FEATURE_BEACON_PROTECTION))
+			max_key_idx = 7;
+		for (i = 0; i <= max_key_idx; i++)
 			rdev_del_key(rdev, dev, i, false, NULL);
+	}
 
 	rdev_set_qos_map(rdev, dev, NULL);
 
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index b6b60e3aea41..63754c528a62 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -510,6 +510,23 @@ TRACE_EVENT(rdev_set_default_mgmt_key,
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->key_index)
 );
 
+TRACE_EVENT(rdev_set_default_beacon_key,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, u8 key_index),
+	TP_ARGS(wiphy, netdev, key_index),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		NETDEV_ENTRY
+		__field(u8, key_index)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
+		__entry->key_index = key_index;
+	),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", key index: %u",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->key_index)
+);
+
 TRACE_EVENT(rdev_start_ap,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
 		 struct cfg80211_ap_settings *settings),
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 8481e9ac33da..72926f87c913 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -231,7 +231,12 @@ int cfg80211_validate_key_settings(struct cfg80211_registered_device *rdev,
 				   struct key_params *params, int key_idx,
 				   bool pairwise, const u8 *mac_addr)
 {
-	if (key_idx < 0 || key_idx > 5)
+	int max_key_idx = 5;
+
+	if (wiphy_ext_feature_isset(&rdev->wiphy,
+				    NL80211_EXT_FEATURE_BEACON_PROTECTION))
+		max_key_idx = 7;
+	if (key_idx < 0 || key_idx > max_key_idx)
 		return -EINVAL;
 
 	if (!pairwise && mac_addr && !(rdev->wiphy.flags & WIPHY_FLAG_IBSS_RSN))
-- 
2.20.1
