Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4183E1ADB44
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 12:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgDQKkU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 06:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726469AbgDQKkT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 06:40:19 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5ECC061A0C
        for <linux-wireless@vger.kernel.org>; Fri, 17 Apr 2020 03:40:19 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jPOPx-0072Uj-Co; Fri, 17 Apr 2020 12:40:17 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     j@w1.fi, Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH] cfg80211: support multicast RX registration
Date:   Fri, 17 Apr 2020 12:40:15 +0200
Message-Id: <20200417124013.c46238801048.Ib041d437ce0bff28a0c6d5dc915f68f1d8591002@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

For DPP, there's a need to receive multicast action frames,
but many drivers need a special filter configuration for this.

Support announcing from userspace in the management registration
that multicast RX is required, with an extended feature flag if
the driver handles this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h       |  4 ++++
 include/uapi/linux/nl80211.h | 13 ++++++++++++
 net/wireless/core.h          |  3 ++-
 net/wireless/mlme.c          | 38 ++++++++++++++++++++++++++++--------
 net/wireless/nl80211.c       | 10 ++++++++++
 5 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9d9dae104e89..d64b770c2a40 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3390,9 +3390,13 @@ struct cfg80211_update_owe_info {
  *	for the entire device
  * @interface_stypes: bitmap of management frame subtypes registered
  *	for the given interface
+ * @global_mcast_rx: mcast RX is needed globally for these subtypes
+ * @interface_mcast_stypes: mcast RX is needed on this interface
+ *	for these subtypes
  */
 struct mgmt_frame_regs {
 	u32 global_stypes, interface_stypes;
+	u32 global_mcast_stypes, interface_mcast_stypes;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 2b691161830f..a8b139da09cb 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -687,6 +687,10 @@
  *	four bytes for vendor frames including the OUI. The registration
  *	cannot be dropped, but is removed automatically when the netlink
  *	socket is closed. Multiple registrations can be made.
+ *	The %NL80211_ATTR_RECEIVE_MULTICAST flag attribute can be given if
+ *	%NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS is available, in which
+ *	case the registration can also be modified to include/exclude the
+ *	flag, rather than requiring unregistration to change it.
  * @NL80211_CMD_REGISTER_ACTION: Alias for @NL80211_CMD_REGISTER_FRAME for
  *	backward compatibility
  * @NL80211_CMD_FRAME: Management frame TX request and RX notification. This
@@ -2470,6 +2474,9 @@ enum nl80211_commands {
  *	no roaming occurs between the reauth threshold and PMK expiration,
  *	disassociation is still forced.
  *
+ * @NL80211_ATTR_RECEIVE_MULTICAST: multicast flag for the
+ *	%NL80211_CMD_REGISTER_FRAME command, see the description there.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2945,6 +2952,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_PMK_LIFETIME,
 	NL80211_ATTR_PMK_REAUTH_THRESHOLD,
 
+	NL80211_ATTR_RECEIVE_MULTICAST,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -5684,6 +5693,9 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_DEL_IBSS_STA: The driver supports removing stations
  *      in IBSS mode, essentially by dropping their state.
  *
+ * @NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS: management frame registrations
+ *	are possible for multicast frames and those will be reported properly.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5735,6 +5747,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_CONTROL_PORT_NO_PREAUTH,
 	NL80211_EXT_FEATURE_PROTECTED_TWT,
 	NL80211_EXT_FEATURE_DEL_IBSS_STA,
+	NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 30fb2c35ae43..639d41896573 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -381,7 +381,8 @@ void cfg80211_mlme_down(struct cfg80211_registered_device *rdev,
 			struct net_device *dev);
 int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_pid,
 				u16 frame_type, const u8 *match_data,
-				int match_len, struct netlink_ext_ack *extack);
+				int match_len, bool multicast_rx,
+				struct netlink_ext_ack *extack);
 void cfg80211_mgmt_registrations_update_wk(struct work_struct *wk);
 void cfg80211_mlme_unregister_socket(struct wireless_dev *wdev, u32 nlpid);
 void cfg80211_mlme_purge_registrations(struct wireless_dev *wdev);
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 2e1a21e90b83..409497a3527d 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -426,6 +426,8 @@ struct cfg80211_mgmt_registration {
 
 	__le16 frame_type;
 
+	bool multicast_rx;
+
 	u8 match[];
 };
 
@@ -442,10 +444,18 @@ static void cfg80211_mgmt_registrations_update(struct wireless_dev *wdev)
 	list_for_each_entry_rcu(tmp, &rdev->wiphy.wdev_list, list) {
 		list_for_each_entry_rcu(reg, &tmp->mgmt_registrations, list) {
 			u32 mask = BIT(le16_to_cpu(reg->frame_type) >> 4);
+			u32 mcast_mask = 0;
+
+			if (reg->multicast_rx)
+				mcast_mask = mask;
 
 			upd.global_stypes |= mask;
-			if (tmp == wdev)
+			upd.global_mcast_stypes |= mcast_mask;
+
+			if (tmp == wdev) {
 				upd.interface_stypes |= mask;
+				upd.interface_mcast_stypes |= mcast_mask;
+			}
 		}
 	}
 	rcu_read_unlock();
@@ -465,11 +475,13 @@ void cfg80211_mgmt_registrations_update_wk(struct work_struct *wk)
 
 int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
 				u16 frame_type, const u8 *match_data,
-				int match_len, struct netlink_ext_ack *extack)
+				int match_len, bool multicast_rx,
+				struct netlink_ext_ack *extack)
 {
 	struct cfg80211_mgmt_registration *reg, *nreg;
 	int err = 0;
 	u16 mgmt_type;
+	bool update_multicast = false;
 
 	if (!wdev->wiphy->mgmt_stypes)
 		return -EOPNOTSUPP;
@@ -520,6 +532,11 @@ int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
 			continue;
 
 		if (memcmp(reg->match, match_data, mlen) == 0) {
+			if (reg->multicast_rx != multicast_rx) {
+				update_multicast = true;
+				reg->multicast_rx = multicast_rx;
+				break;
+			}
 			NL_SET_ERR_MSG(extack, "Match already configured");
 			err = -EALREADY;
 			break;
@@ -529,12 +546,17 @@ int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
 	if (err)
 		goto out;
 
-	memcpy(nreg->match, match_data, match_len);
-	nreg->match_len = match_len;
-	nreg->nlportid = snd_portid;
-	nreg->frame_type = cpu_to_le16(frame_type);
-	nreg->wdev = wdev;
-	list_add(&nreg->list, &wdev->mgmt_registrations);
+	if (update_multicast) {
+		kfree(nreg);
+	} else {
+		memcpy(nreg->match, match_data, match_len);
+		nreg->match_len = match_len;
+		nreg->nlportid = snd_portid;
+		nreg->frame_type = cpu_to_le16(frame_type);
+		nreg->wdev = wdev;
+		nreg->multicast_rx = multicast_rx;
+		list_add(&nreg->list, &wdev->mgmt_registrations);
+	}
 	spin_unlock_bh(&wdev->mgmt_registrations_lock);
 
 	cfg80211_mgmt_registrations_update(wdev);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 692bcd35f809..8b502fdffe09 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -661,6 +661,7 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_CONTROL_PORT_NO_PREAUTH] = { .type = NLA_FLAG },
 	[NL80211_ATTR_PMK_LIFETIME] = NLA_POLICY_MIN(NLA_U32, 1),
 	[NL80211_ATTR_PMK_REAUTH_THRESHOLD] = NLA_POLICY_RANGE(NLA_U8, 1, 100),
+	[NL80211_ATTR_RECEIVE_MULTICAST] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -10773,9 +10774,18 @@ static int nl80211_register_mgmt(struct sk_buff *skb, struct genl_info *info)
 	if (!rdev->ops->mgmt_tx)
 		return -EOPNOTSUPP;
 
+	if (info->attrs[NL80211_ATTR_RECEIVE_MULTICAST] &&
+	    !wiphy_ext_feature_isset(&rdev->wiphy,
+				     NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS)) {
+		GENL_SET_ERR_MSG(info,
+				 "multicast RX registrations are not supported");
+		return -EOPNOTSUPP;
+	}
+
 	return cfg80211_mlme_register_mgmt(wdev, info->snd_portid, frame_type,
 					   nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
 					   nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]),
+					   info->attrs[NL80211_ATTR_RECEIVE_MULTICAST],
 					   info->extack);
 }
 
-- 
2.25.1

