Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CED2156B9
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2020 13:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgGFLwd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jul 2020 07:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgGFLwc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jul 2020 07:52:32 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4E6C061794
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2020 04:52:32 -0700 (PDT)
Received: from [134.101.131.141] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jsPfh-000600-5r; Mon, 06 Jul 2020 13:52:29 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V2 01/10] nl80211: add basic multiple bssid support
Date:   Mon,  6 Jul 2020 13:52:10 +0200
Message-Id: <20200706115219.663650-1-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds support for passing the multiple bssid config to the
kernel when adding an interface. A bss can be legacy, transmitting or
non-transmitting. A non-transmitting BSSID will have a parent interface,
which needs to be transmitting.

Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/cfg80211.h       |  9 +++++++++
 include/uapi/linux/nl80211.h | 25 +++++++++++++++++++++++++
 net/wireless/nl80211.c       | 14 ++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fc7e8807838d..ba8f3c8df0ca 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -604,6 +604,8 @@ struct vif_params {
 	u8 macaddr[ETH_ALEN];
 	const u8 *vht_mumimo_groups;
 	const u8 *vht_mumimo_follow_addr;
+	enum nl80211_multi_bssid_mode multi_bssid_mode;
+	u32 multi_bssid_parent;
 };
 
 /**
@@ -5109,6 +5111,9 @@ struct cfg80211_cqm_config;
  * @pmsr_free_wk: (private) peer measurements cleanup work
  * @unprot_beacon_reported: (private) timestamp of last
  *	unprotected beacon report
+ * @multi_bssid_mode: Is this a legacy, transmitted or non-transmitted bssid
+ * @multi_bssid_parent: a non-transmitted bssid has a transmitted parent
+ * @multi_bssid_list: linked list for tracking parent - child relations.
  */
 struct wireless_dev {
 	struct wiphy *wiphy;
@@ -5188,6 +5193,10 @@ struct wireless_dev {
 	struct work_struct pmsr_free_wk;
 
 	unsigned long unprot_beacon_reported;
+
+	enum nl80211_multi_bssid_mode multi_bssid_mode;
+	struct wireless_dev *multi_bssid_parent;
+	struct list_head multi_bssid_list;
 };
 
 static inline u8 *wdev_address(struct wireless_dev *wdev)
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 4e6339ab1fce..b7a5d1de7aff 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2505,6 +2505,12 @@ enum nl80211_commands {
  * @NL80211_ATTR_HE_6GHZ_CAPABILITY: HE 6 GHz Band Capability element (from
  *	association request when used with NL80211_CMD_NEW_STATION).
  *
+ * @NL80211_ATTR_MULTI_BSSID_MODE: Set the (Non-)Transmitted flag for this
+ *	BSSIDs beacon.
+ *
+ * @NL80211_ATTR_MULTI_BSSID_PARENT: If this is a Non-Transmitted BSSID, define
+ *	the parent interface.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2987,6 +2993,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_HE_6GHZ_CAPABILITY,
 
+	NL80211_ATTR_MULTI_BSSID_MODE,
+	NL80211_ATTR_MULTI_BSSID_PARENT,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -6769,6 +6778,22 @@ enum nl80211_peer_measurement_ftm_failure_reasons {
 	NL80211_PMSR_FTM_FAILURE_BAD_CHANGED_PARAMS,
 };
 
+/**
+ * enum nl80211_multi_bssid_mode - Multiple BSSID beacon type
+ *
+ * Used by cfg80211_ap_settings
+ *
+ * @MULTIPLE_BSSID_LEGACY: This BSS is not part of a multiple BSSID group
+ * @MULTIPLE_BSSID_TRANSMITTED: This BSS is broadcasting a multiple BSSID
+ *                                    beacon
+ * @MULTIPLE_BSSID_NON_TRANSMITTED: This BSS is not broadcasting a beacon
+ */
+enum nl80211_multi_bssid_mode {
+	NL80211_MULTIPLE_BSSID_LEGACY = 0,
+	NL80211_MULTIPLE_BSSID_TRANSMITTED,
+	NL80211_MULTIPLE_BSSID_NON_TRANSMITTED,
+};
+
 /**
  * enum nl80211_peer_measurement_ftm_resp - FTM response attributes
  * @__NL80211_PMSR_FTM_RESP_ATTR_INVALID: invalid
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 263ae395ad44..e29f834f8d12 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -658,6 +658,10 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		.type = NLA_EXACT_LEN,
 		.len = sizeof(struct ieee80211_he_6ghz_capa),
 	},
+	[NL80211_ATTR_MULTI_BSSID_MODE] = NLA_POLICY_RANGE(NLA_U8,
+					NL80211_MULTIPLE_BSSID_LEGACY,
+					NL80211_MULTIPLE_BSSID_NON_TRANSMITTED),
+	[NL80211_ATTR_MULTI_BSSID_PARENT] = { .type = NLA_U32 },
 };
 
 /* policy for the key attributes */
@@ -3761,6 +3765,16 @@ static int nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 	if (err < 0)
 		return err;
 
+	if (info->attrs[NL80211_ATTR_MULTI_BSSID_MODE])
+		params.multi_bssid_mode =
+			nla_get_u8(info->attrs[NL80211_ATTR_MULTI_BSSID_MODE]);
+	if (info->attrs[NL80211_ATTR_MULTI_BSSID_PARENT])
+		params.multi_bssid_parent =
+			nla_get_u8(info->attrs[NL80211_ATTR_MULTI_BSSID_PARENT]);
+	if (params.multi_bssid_mode == NL80211_MULTIPLE_BSSID_NON_TRANSMITTED &&
+	    !params.multi_bssid_parent)
+		return -EOPNOTSUPP;
+
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;
-- 
2.25.1

