Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7C31EDDAC
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 09:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgFDHKE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jun 2020 03:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgFDHKC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jun 2020 03:10:02 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B6FC08C5C1
        for <linux-wireless@vger.kernel.org>; Thu,  4 Jun 2020 00:10:02 -0700 (PDT)
Received: from [46.59.202.224] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jgk0k-0001P3-Ep; Thu, 04 Jun 2020 09:09:58 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH 01/12] nl80211: add basic multiple bssid support
Date:   Thu,  4 Jun 2020 09:09:41 +0200
Message-Id: <20200604070952.15481-2-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200604070952.15481-1-john@phrozen.org>
References: <20200604070952.15481-1-john@phrozen.org>
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
 include/net/cfg80211.h       |  8 ++++++++
 include/uapi/linux/nl80211.h | 25 +++++++++++++++++++++++++
 net/wireless/nl80211.c       | 14 ++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index deaa3668d47a..f0fc65f900b4 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -601,6 +601,8 @@ struct vif_params {
 	u8 macaddr[ETH_ALEN];
 	const u8 *vht_mumimo_groups;
 	const u8 *vht_mumimo_follow_addr;
+	enum nl80211_multi_bssid_mode multi_bssid_mode;
+	u32 multi_bssid_parent;
 };
 
 /**
@@ -5060,6 +5062,9 @@ struct cfg80211_cqm_config;
  * @pmsr_list: (private) peer measurement requests
  * @pmsr_lock: (private) peer measurements requests/results lock
  * @pmsr_free_wk: (private) peer measurements cleanup work
+ * @multi_bssid_mode: Is this a legacy, transmitted or non-transmitted bssid
+ * @multi_bssid_parent: a non-transmitted bssid has a transmitted parent
+ * @multi_bssid_list: linked list for tracking parent - child relations.
  */
 struct wireless_dev {
 	struct wiphy *wiphy;
@@ -5136,6 +5141,9 @@ struct wireless_dev {
 	struct list_head pmsr_list;
 	spinlock_t pmsr_lock;
 	struct work_struct pmsr_free_wk;
+	enum nl80211_multi_bssid_mode multi_bssid_mode;
+	struct wireless_dev *multi_bssid_parent;
+	struct list_head multi_bssid_list;
 };
 
 static inline u8 *wdev_address(struct wireless_dev *wdev)
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 966887bd654c..a586567f18ea 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2470,6 +2470,12 @@ enum nl80211_commands {
  *	no roaming occurs between the reauth threshold and PMK expiration,
  *	disassociation is still forced.
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
@@ -2945,6 +2951,9 @@ enum nl80211_attrs {
 	NL80211_ATTR_PMK_LIFETIME,
 	NL80211_ATTR_PMK_REAUTH_THRESHOLD,
 
+	NL80211_ATTR_MULTI_BSSID_MODE,
+	NL80211_ATTR_MULTI_BSSID_PARENT,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -6700,6 +6709,22 @@ enum nl80211_peer_measurement_ftm_failure_reasons {
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
index ed545b2a958d..3b502514944c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -663,6 +663,10 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_CONTROL_PORT_NO_PREAUTH] = { .type = NLA_FLAG },
 	[NL80211_ATTR_PMK_LIFETIME] = NLA_POLICY_MIN(NLA_U32, 1),
 	[NL80211_ATTR_PMK_REAUTH_THRESHOLD] = NLA_POLICY_RANGE(NLA_U8, 1, 100),
+	[NL80211_ATTR_MULTI_BSSID_MODE] = NLA_POLICY_RANGE(NLA_U8,
+					NL80211_MULTIPLE_BSSID_LEGACY,
+					NL80211_MULTIPLE_BSSID_NON_TRANSMITTED),
+	[NL80211_ATTR_MULTI_BSSID_PARENT] = { .type = NLA_U32 },
 };
 
 /* policy for the key attributes */
@@ -3756,6 +3760,16 @@ static int nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
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
2.20.1

