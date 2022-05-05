Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E881151C273
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 16:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243206AbiEEO1g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 10:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241908AbiEEO1f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 10:27:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD565A5A8
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=4ibGFyV31rVUdTClPvA7AwY+ENpFPzPUY4ZV4uM9Lng=; t=1651760632; x=1652970232; 
        b=S543r/QTVde3lgsvKbINtl1CouXlFYN6AyLJU+yWBAUKiva71TNn26DdmurpvSXp9rO10tE2Vwx
        +iNcYHLLj9Z/gYdiPNUZaTkvCdvb41wtu/4ReYeTQEP0ZIeI6ubqFxf+qDCfInuqVfPoFrPzQ1ypv
        NXrQTmjdCSOaDkfSvlH38KbFTBtsms/PVkkBWKBqjEpXq59jTOGw/NwCV7mMpSAHM1BXLH0Gq87/f
        hDyGOYBMll05H4Wi13tiJspUCMCRhXRG86/NnzY8CFM8r2TGtCDEyL7zTIYm5RRz60uj+Jg3v0WCT
        JJx5PHSD0gP7f33ygEe3lMDkJTFuB87oiluQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nmcOT-002p7Q-QU;
        Thu, 05 May 2022 16:23:50 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        Jouni Malinen <j@w1.fi>
Subject: [RFC PATCH v2] cfg80211: do some rework towards MLO link APIs
Date:   Thu,  5 May 2022 16:23:46 +0200
Message-Id: <20220505162344.8a8564e88521.I023f35d382282691d7e2cbc607fb11691355cd63@changeid>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In order to support multi-link operation with multiple links,
start adding some APIs. The notable addition here is to have
the link ID in a new nl80211 attribute, that will be used to
differentiate the links in many nl80211 operations. The one I
mostly looked at so far was start_ap and friends, but that is
also still incomplete.

Mostly the idea of this is to give everyone an idea of what
such an API might look like and what it might result in at
the nl80211 level.

For now, I've decided to include only the over-the-air link
ID in the API. I know we discussed that we eventually need to
have to have other ways of identifying a link, but for local
AP mode and auth/assoc commands we'll need to use the OTA ID,
and for set_key and similar clearly we need only the OTA ID.

Also included in this patch is some refactoring of the data
structures in struct wireless_dev, splitting for the first
time the data into type dependent pieces, to make reasoning
about these things easier.

The next things with this would be:
 1) look at the auth/assoc APIs, at present I'm not even
    certain where we do what, I guess userspace would pick
    the BSS entries and send them in the LINKS attribute,
    per link, or so, and mac80211 builds the multi-link
    element(s) as appropriate?

 2) look at interface combinations advertisement and tie it
    into this patch where appropriate; Vasanth is looking
    at this.

 3) try to get to a point where we can at least start the
    beaconing process, i.e. look at mac80211 much more and
    refactor data structures there

I'll probably start with (3) since at least beaconing lets
me then test at least scanning for (1) and perhaps sending
the association request etc.

Cc: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
Cc: Jouni Malinen <j@w1.fi>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h    |   3 +
 include/net/cfg80211.h       |  83 ++++-
 include/uapi/linux/nl80211.h |  23 ++
 net/mac80211/cfg.c           |   8 +-
 net/mac80211/mlme.c          |   2 +-
 net/wireless/ap.c            |  46 ++-
 net/wireless/chan.c          | 193 +++++++----
 net/wireless/core.c          |  28 +-
 net/wireless/core.h          |  15 +-
 net/wireless/ibss.c          |  57 ++--
 net/wireless/mesh.c          |  31 +-
 net/wireless/mlme.c          |  74 +++--
 net/wireless/nl80211.c       | 614 +++++++++++++++++++++++++----------
 net/wireless/ocb.c           |   5 +-
 net/wireless/rdev-ops.h      |  32 +-
 net/wireless/reg.c           | 139 +++++---
 net/wireless/scan.c          |   8 +-
 net/wireless/sme.c           | 102 +++---
 net/wireless/trace.h         |  86 +++--
 net/wireless/util.c          |  44 ++-
 net/wireless/wext-compat.c   |  48 ++-
 net/wireless/wext-sme.c      |  27 +-
 22 files changed, 1173 insertions(+), 495 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 75d40acb60c1..5f66d5c9e3de 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4345,4 +4345,7 @@ enum ieee80211_range_params_max_total_ltf {
 	IEEE80211_RANGE_PARAMS_MAX_TOTAL_LTF_UNSPECIFIED,
 };
 
+/* multi-link device */
+#define IEEE80211_MLD_MAX_NUM_LINKS	15
+
 #endif /* LINUX_IEEE80211_H */
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6a3e3f0a8615..d9ed47e2c4c2 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1158,6 +1158,7 @@ struct cfg80211_mbssid_elems {
 
 /**
  * struct cfg80211_beacon_data - beacon data
+ * @link_id: the link ID for the AP MLD link sending this beacon
  * @head: head portion of beacon (before TIM IE)
  *	or %NULL if not changed
  * @tail: tail portion of beacon (after TIM IE)
@@ -1185,6 +1186,8 @@ struct cfg80211_mbssid_elems {
  * @civicloc_len: Civic location data length
  */
 struct cfg80211_beacon_data {
+	unsigned int link_id;
+
 	const u8 *head, *tail;
 	const u8 *beacon_ies;
 	const u8 *proberesp_ies;
@@ -4198,7 +4201,8 @@ struct cfg80211_ops {
 			    struct cfg80211_ap_settings *settings);
 	int	(*change_beacon)(struct wiphy *wiphy, struct net_device *dev,
 				 struct cfg80211_beacon_data *info);
-	int	(*stop_ap)(struct wiphy *wiphy, struct net_device *dev);
+	int	(*stop_ap)(struct wiphy *wiphy, struct net_device *dev,
+			   unsigned int link_id);
 
 
 	int	(*add_station)(struct wiphy *wiphy, struct net_device *dev,
@@ -4306,6 +4310,7 @@ struct cfg80211_ops {
 
 	int	(*set_bitrate_mask)(struct wiphy *wiphy,
 				    struct net_device *dev,
+				    unsigned int link_id,
 				    const u8 *peer,
 				    const struct cfg80211_bitrate_mask *mask);
 
@@ -4381,6 +4386,7 @@ struct cfg80211_ops {
 
 	int	(*get_channel)(struct wiphy *wiphy,
 			       struct wireless_dev *wdev,
+			       unsigned int link_id,
 			       struct cfg80211_chan_def *chandef);
 
 	int	(*start_p2p_device)(struct wiphy *wiphy,
@@ -4417,6 +4423,7 @@ struct cfg80211_ops {
 			       struct cfg80211_qos_map *qos_map);
 
 	int	(*set_ap_chanwidth)(struct wiphy *wiphy, struct net_device *dev,
+				    unsigned int link_id,
 				    struct cfg80211_chan_def *chandef);
 
 	int	(*add_tx_ts)(struct wiphy *wiphy, struct net_device *dev,
@@ -5502,6 +5509,8 @@ static inline void wiphy_unlock(struct wiphy *wiphy)
  * @netdev: (private) Used to reference back to the netdev, may be %NULL
  * @identifier: (private) Identifier used in nl80211 to identify this
  *	wireless device if it has no netdev
+ * @connected_addr: (private) BSSID or AP MLD address if connected
+ * @connected: indicates if connected or not (STA mode)
  * @current_bss: (private) Used by the internal configuration code
  * @chandef: (private) Used by the internal configuration code to track
  *	the user-set channel definition.
@@ -5582,8 +5591,6 @@ struct wireless_dev {
 	u8 address[ETH_ALEN] __aligned(sizeof(u16));
 
 	/* currently used for IBSS and SME - might be rearranged later */
-	u8 ssid[IEEE80211_MAX_SSID_LEN];
-	u8 ssid_len, mesh_id_len, mesh_id_up_len;
 	struct cfg80211_conn *conn;
 	struct cfg80211_cached_keys *connect_keys;
 	enum ieee80211_bss_type conn_bss_type;
@@ -5595,20 +5602,17 @@ struct wireless_dev {
 	struct list_head event_list;
 	spinlock_t event_lock;
 
-	struct cfg80211_internal_bss *current_bss; /* associated / joined */
-	struct cfg80211_chan_def preset_chandef;
-	struct cfg80211_chan_def chandef;
+	u8 connected:1;
 
 	bool ps;
 	int ps_timeout;
 
-	int beacon_interval;
-
 	u32 ap_unexpected_nlportid;
 
 	u32 owner_nlportid;
 	bool nl_owner_dead;
 
+	/* FIXME: need to rework radar detection for MLO */
 	bool cac_started;
 	unsigned long cac_start_time;
 	unsigned int cac_time_ms;
@@ -5636,6 +5640,50 @@ struct wireless_dev {
 	struct work_struct pmsr_free_wk;
 
 	unsigned long unprot_beacon_reported;
+
+	union {
+		struct {
+			u8 connected_addr[ETH_ALEN] __aligned(2);
+			u8 ssid[IEEE80211_MAX_SSID_LEN];
+			u8 ssid_len;
+		} client;
+		struct {
+			int beacon_interval;
+			struct cfg80211_chan_def preset_chandef;
+			struct cfg80211_chan_def chandef;
+			u8 id[IEEE80211_MAX_SSID_LEN];
+			u8 id_len, id_up_len;
+		} mesh;
+		struct {
+			struct cfg80211_chan_def preset_chandef;
+			u8 ssid[IEEE80211_MAX_SSID_LEN];
+			u8 ssid_len;
+		} ap;
+		struct {
+			struct cfg80211_internal_bss *current_bss;
+			struct cfg80211_chan_def chandef;
+			int beacon_interval;
+			u8 ssid[IEEE80211_MAX_SSID_LEN];
+			u8 ssid_len;
+		} ibss;
+		struct {
+			struct cfg80211_chan_def chandef;
+		} ocb;
+	} u;
+
+	struct {
+		u8 addr[ETH_ALEN] __aligned(2);
+		union {
+			struct {
+				unsigned int beacon_interval;
+				struct cfg80211_chan_def chandef;
+			} ap;
+			struct {
+				struct cfg80211_internal_bss *current_bss;
+			} client;
+		};
+	} links[IEEE80211_MLD_MAX_NUM_LINKS];
+	u16 valid_links;
 };
 
 static inline const u8 *wdev_address(struct wireless_dev *wdev)
@@ -5664,6 +5712,21 @@ static inline void *wdev_priv(struct wireless_dev *wdev)
 	return wiphy_priv(wdev->wiphy);
 }
 
+static inline void WARN_INVALID_LINK_ID(struct wireless_dev *wdev,
+					unsigned int link_id)
+{
+	WARN_ON(link_id && !wdev->valid_links);
+	WARN_ON(wdev->valid_links &&
+		!(wdev->valid_links & BIT(link_id)));
+}
+
+#define for_each_valid_link(wdev, link_id)					\
+	for (link_id = 0;							\
+	     link_id < ((wdev)->valid_links ? ARRAY_SIZE((wdev)->links) : 1);	\
+	     link_id++)								\
+		if (!(wdev)->valid_links ||					\
+		    ((wdev)->valid_links & BIT(link_id)))
+
 /**
  * DOC: Utility functions
  *
@@ -7879,12 +7942,14 @@ bool cfg80211_reg_can_beacon_relax(struct wiphy *wiphy,
  * cfg80211_ch_switch_notify - update wdev channel and notify userspace
  * @dev: the device which switched channels
  * @chandef: the new channel definition
+ * @link_id: the link ID for MLO, must be 0 for non-MLO
  *
  * Caller must acquire wdev_lock, therefore must only be called from sleepable
  * driver context!
  */
 void cfg80211_ch_switch_notify(struct net_device *dev,
-			       struct cfg80211_chan_def *chandef);
+			       struct cfg80211_chan_def *chandef,
+			       unsigned int link_id);
 
 /*
  * cfg80211_ch_switch_started_notify - notify channel switch start
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index d9490e3062a7..b8366ceb2639 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -323,6 +323,17 @@
  * Once the association is done, the driver cleans the FILS AAD data.
  */
 
+/**
+ * DOC: Multi-Link Operation
+ *
+ * In Multi-Link Operation, a connection between to MLDs utilizes multiple
+ * links. To use this in nl80211, various commands and responses now need
+ * to or will include the new %NL80211_ATTR_MLO_LINKS attribute.
+ * Additionally, various commands that need to operate on a specific link
+ * now need to be given the %NL80211_ATTR_MLO_LINK_ID attribute, e.g. to
+ * use %NL80211_CMD_START_AP or similar functions.
+ */
+
 /**
  * enum nl80211_commands - supported nl80211 commands
  *
@@ -1237,6 +1248,12 @@
  *      to describe the BSSID address of the AP and %NL80211_ATTR_TIMEOUT to
  *      specify the timeout value.
  *
+ * @NL80211_CMD_ADD_LINK: Add a new link to an interface. The
+ *	%NL80211_ATTR_MLO_LINK_ID attribute is used for the new link.
+ * @NL80211_CMD_REMOVE_LINK: Remove a link from an interface. This may come
+ *	without %NL80211_ATTR_MLO_LINK_ID as an easy way to remove all links
+ *	in preparation for e.g. roaming to a regular (non-MLO) AP.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1481,6 +1498,9 @@ enum nl80211_commands {
 
 	NL80211_CMD_ASSOC_COMEBACK,
 
+	NL80211_CMD_ADD_LINK,
+	NL80211_CMD_REMOVE_LINK,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -3177,6 +3197,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_DISABLE_EHT,
 
+	NL80211_ATTR_MLO_LINKS,
+	NL80211_ATTR_MLO_LINK_ID,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f1d211e61e49..5eb32d62acd0 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1339,7 +1339,8 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	return 0;
 }
 
-static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
+static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
+			     unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_sub_if_data *vlan;
@@ -3050,6 +3051,7 @@ static int ieee80211_set_cqm_rssi_range_config(struct wiphy *wiphy,
 
 static int ieee80211_set_bitrate_mask(struct wiphy *wiphy,
 				      struct net_device *dev,
+				      unsigned int link_id,
 				      const u8 *addr,
 				      const struct cfg80211_bitrate_mask *mask)
 {
@@ -3393,7 +3395,7 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 	if (err)
 		return err;
 
-	cfg80211_ch_switch_notify(sdata->dev, &sdata->csa_chandef);
+	cfg80211_ch_switch_notify(sdata->dev, &sdata->csa_chandef, 0);
 
 	return 0;
 }
@@ -3908,6 +3910,7 @@ static int ieee80211_probe_client(struct wiphy *wiphy, struct net_device *dev,
 
 static int ieee80211_cfg_get_channel(struct wiphy *wiphy,
 				     struct wireless_dev *wdev,
+				     unsigned int link_id,
 				     struct cfg80211_chan_def *chandef)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
@@ -3968,6 +3971,7 @@ static int ieee80211_set_qos_map(struct wiphy *wiphy,
 
 static int ieee80211_set_ap_chanwidth(struct wiphy *wiphy,
 				      struct net_device *dev,
+				      unsigned int link_id,
 				      struct cfg80211_chan_def *chandef)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f02137b4cb12..12c81ed39622 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1314,7 +1314,7 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_sub_if_data *sdata)
 		return;
 	}
 
-	cfg80211_ch_switch_notify(sdata->dev, &sdata->reserved_chandef);
+	cfg80211_ch_switch_notify(sdata->dev, &sdata->reserved_chandef, 0);
 }
 
 void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success)
diff --git a/net/wireless/ap.c b/net/wireless/ap.c
index 550ac9d827fe..aaf4660ec520 100644
--- a/net/wireless/ap.c
+++ b/net/wireless/ap.c
@@ -1,4 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * Parts of this file are
+ * Copyright (C) 2022 Intel Corporation
+ */
 #include <linux/ieee80211.h>
 #include <linux/export.h>
 #include <net/cfg80211.h>
@@ -7,8 +11,9 @@
 #include "rdev-ops.h"
 
 
-int __cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
-		       struct net_device *dev, bool notify)
+static int ___cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
+			       struct net_device *dev, unsigned int link_id,
+			       bool notify)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	int err;
@@ -22,15 +27,16 @@ int __cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
 	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
 		return -EOPNOTSUPP;
 
-	if (!wdev->beacon_interval)
+	if (!wdev->links[link_id].ap.beacon_interval)
 		return -ENOENT;
 
-	err = rdev_stop_ap(rdev, dev);
+	err = rdev_stop_ap(rdev, dev, link_id);
 	if (!err) {
 		wdev->conn_owner_nlportid = 0;
-		wdev->beacon_interval = 0;
-		memset(&wdev->chandef, 0, sizeof(wdev->chandef));
-		wdev->ssid_len = 0;
+		wdev->links[link_id].ap.beacon_interval = 0;
+		memset(&wdev->links[link_id].ap.chandef, 0,
+		       sizeof(wdev->links[link_id].ap.chandef));
+		wdev->u.ap.ssid_len = 0;
 		rdev_set_qos_map(rdev, dev, NULL);
 		if (notify)
 			nl80211_send_ap_stopped(wdev);
@@ -46,14 +52,36 @@ int __cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
 	return err;
 }
 
+int __cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
+		       struct net_device *dev, int link_id,
+		       bool notify)
+{
+	unsigned int link;
+	int ret;
+
+	if (link_id >= 0)
+		return ___cfg80211_stop_ap(rdev, dev, link_id, notify);
+
+	for_each_valid_link(dev->ieee80211_ptr, link) {
+		int ret1 = ___cfg80211_stop_ap(rdev, dev, link, notify);
+
+		if (ret1)
+			ret = ret1;
+		/* try the next one also if one errored */
+	}
+
+	return ret;
+}
+
 int cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
-		     struct net_device *dev, bool notify)
+		     struct net_device *dev, int link_id,
+		     bool notify)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	int err;
 
 	wdev_lock(wdev);
-	err = __cfg80211_stop_ap(rdev, dev, notify);
+	err = __cfg80211_stop_ap(rdev, dev, link_id, notify);
 	wdev_unlock(wdev);
 
 	return err;
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index f74f176e0d9d..947d841762e5 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -672,14 +672,21 @@ bool cfg80211_chandef_dfs_usable(struct wiphy *wiphy,
  * range of chandef.
  */
 bool cfg80211_is_sub_chan(struct cfg80211_chan_def *chandef,
-			  struct ieee80211_channel *chan)
+			  struct ieee80211_channel *chan,
+			  bool primary_only)
 {
 	int width;
 	u32 freq;
 
+	if (!chandef->chan)
+		return false;
+
 	if (chandef->chan->center_freq == chan->center_freq)
 		return true;
 
+	if (primary_only)
+		return false;
+
 	width = cfg80211_chandef_get_width(chandef);
 	if (width <= 20)
 		return false;
@@ -704,23 +711,25 @@ bool cfg80211_is_sub_chan(struct cfg80211_chan_def *chandef,
 
 bool cfg80211_beaconing_iface_active(struct wireless_dev *wdev)
 {
-	bool active = false;
+	unsigned int link;
 
 	ASSERT_WDEV_LOCK(wdev);
 
-	if (!wdev->chandef.chan)
-		return false;
-
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_P2P_GO:
-		active = wdev->beacon_interval != 0;
+		for_each_valid_link(wdev, link) {
+			if (wdev->links[link].ap.beacon_interval)
+				return true;
+		}
 		break;
 	case NL80211_IFTYPE_ADHOC:
-		active = wdev->ssid_len != 0;
+		if (wdev->u.ibss.ssid_len)
+			return true;
 		break;
 	case NL80211_IFTYPE_MESH_POINT:
-		active = wdev->mesh_id_len != 0;
+		if (wdev->u.mesh.id_len)
+			return true;
 		break;
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_OCB:
@@ -737,7 +746,35 @@ bool cfg80211_beaconing_iface_active(struct wireless_dev *wdev)
 		WARN_ON(1);
 	}
 
-	return active;
+	return false;
+}
+
+bool cfg80211_wdev_on_sub_chan(struct wireless_dev *wdev,
+			       struct ieee80211_channel *chan,
+			       bool primary_only)
+{
+	unsigned int link;
+
+	switch (wdev->iftype) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+		for_each_valid_link(wdev, link) {
+			if (cfg80211_is_sub_chan(&wdev->links[link].ap.chandef,
+						 chan, primary_only))
+				return true;
+		}
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		return cfg80211_is_sub_chan(&wdev->u.ibss.chandef, chan,
+					    primary_only);
+	case NL80211_IFTYPE_MESH_POINT:
+		return cfg80211_is_sub_chan(&wdev->u.mesh.chandef, chan,
+					    primary_only);
+	default:
+		break;
+	}
+
+	return false;
 }
 
 static bool cfg80211_is_wiphy_oper_chan(struct wiphy *wiphy,
@@ -752,7 +789,7 @@ static bool cfg80211_is_wiphy_oper_chan(struct wiphy *wiphy,
 			continue;
 		}
 
-		if (cfg80211_is_sub_chan(&wdev->chandef, chan)) {
+		if (cfg80211_wdev_on_sub_chan(wdev, chan, false)) {
 			wdev_unlock(wdev);
 			return true;
 		}
@@ -772,7 +809,8 @@ cfg80211_offchan_chain_is_active(struct cfg80211_registered_device *rdev,
 	if (!cfg80211_chandef_valid(&rdev->background_radar_chandef))
 		return false;
 
-	return cfg80211_is_sub_chan(&rdev->background_radar_chandef, channel);
+	return cfg80211_is_sub_chan(&rdev->background_radar_chandef, channel,
+				    false);
 }
 
 bool cfg80211_any_wiphy_oper_chan(struct wiphy *wiphy,
@@ -1176,6 +1214,68 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL(cfg80211_chandef_usable);
 
+static bool cfg80211_ir_permissive_check_wdev(enum nl80211_iftype iftype,
+					      struct wireless_dev *wdev,
+					      struct ieee80211_channel *chan)
+{
+	struct ieee80211_channel *other_chan = NULL;
+	unsigned int link_id;
+	int r1, r2;
+
+	for_each_valid_link(wdev, link_id) {
+		if (wdev->iftype == NL80211_IFTYPE_STATION &&
+		    wdev->links[link_id].client.current_bss)
+			other_chan = wdev->links[link_id].client.current_bss->pub.channel;
+
+		/*
+		 * If a GO already operates on the same GO_CONCURRENT channel,
+		 * this one (maybe the same one) can beacon as well. We allow
+		 * the operation even if the station we relied on with
+		 * GO_CONCURRENT is disconnected now. But then we must make sure
+		 * we're not outdoor on an indoor-only channel.
+		 */
+		if (iftype == NL80211_IFTYPE_P2P_GO &&
+		    wdev->iftype == NL80211_IFTYPE_P2P_GO &&
+		    wdev->links[link_id].ap.beacon_interval &&
+		    !(chan->flags & IEEE80211_CHAN_INDOOR_ONLY))
+			other_chan = wdev->links[link_id].ap.chandef.chan;
+
+		if (!other_chan)
+			continue;
+
+		if (chan == other_chan)
+			return true;
+
+		if (chan->band != NL80211_BAND_5GHZ &&
+		    chan->band != NL80211_BAND_6GHZ)
+			continue;
+
+		r1 = cfg80211_get_unii(chan->center_freq);
+		r2 = cfg80211_get_unii(other_chan->center_freq);
+
+		if (r1 != -EINVAL && r1 == r2) {
+			/*
+			 * At some locations channels 149-165 are considered a
+			 * bundle, but at other locations, e.g., Indonesia,
+			 * channels 149-161 are considered a bundle while
+			 * channel 165 is left out and considered to be in a
+			 * different bundle. Thus, in case that there is a
+			 * station interface connected to an AP on channel 165,
+			 * it is assumed that channels 149-161 are allowed for
+			 * GO operations. However, having a station interface
+			 * connected to an AP on channels 149-161, does not
+			 * allow GO operation on channel 165.
+			 */
+			if (chan->center_freq == 5825 &&
+			    other_chan->center_freq != 5825)
+				continue;
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /*
  * Check if the channel can be used under permissive conditions mandated by
  * some regulatory bodies, i.e., the channel is marked with
@@ -1219,59 +1319,14 @@ static bool cfg80211_ir_permissive_chan(struct wiphy *wiphy,
 	 * the current registered device.
 	 */
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
-		struct ieee80211_channel *other_chan = NULL;
-		int r1, r2;
+		bool ret;
 
 		wdev_lock(wdev);
-		if (wdev->iftype == NL80211_IFTYPE_STATION &&
-		    wdev->current_bss)
-			other_chan = wdev->current_bss->pub.channel;
-
-		/*
-		 * If a GO already operates on the same GO_CONCURRENT channel,
-		 * this one (maybe the same one) can beacon as well. We allow
-		 * the operation even if the station we relied on with
-		 * GO_CONCURRENT is disconnected now. But then we must make sure
-		 * we're not outdoor on an indoor-only channel.
-		 */
-		if (iftype == NL80211_IFTYPE_P2P_GO &&
-		    wdev->iftype == NL80211_IFTYPE_P2P_GO &&
-		    wdev->beacon_interval &&
-		    !(chan->flags & IEEE80211_CHAN_INDOOR_ONLY))
-			other_chan = wdev->chandef.chan;
+		ret = cfg80211_ir_permissive_check_wdev(iftype, wdev, chan);
 		wdev_unlock(wdev);
 
-		if (!other_chan)
-			continue;
-
-		if (chan == other_chan)
-			return true;
-
-		if (chan->band != NL80211_BAND_5GHZ &&
-		    chan->band != NL80211_BAND_6GHZ)
-			continue;
-
-		r1 = cfg80211_get_unii(chan->center_freq);
-		r2 = cfg80211_get_unii(other_chan->center_freq);
-
-		if (r1 != -EINVAL && r1 == r2) {
-			/*
-			 * At some locations channels 149-165 are considered a
-			 * bundle, but at other locations, e.g., Indonesia,
-			 * channels 149-161 are considered a bundle while
-			 * channel 165 is left out and considered to be in a
-			 * different bundle. Thus, in case that there is a
-			 * station interface connected to an AP on channel 165,
-			 * it is assumed that channels 149-161 are allowed for
-			 * GO operations. However, having a station interface
-			 * connected to an AP on channels 149-161, does not
-			 * allow GO operation on channel 165.
-			 */
-			if (chan->center_freq == 5825 &&
-			    other_chan->center_freq != 5825)
-				continue;
-			return true;
-		}
+		if (ret)
+			return ret;
 	}
 
 	return false;
@@ -1374,3 +1429,21 @@ bool cfg80211_any_usable_channels(struct wiphy *wiphy,
 	return false;
 }
 EXPORT_SYMBOL(cfg80211_any_usable_channels);
+
+struct cfg80211_chan_def *wdev_chandef(struct wireless_dev *wdev,
+				       unsigned int link_id)
+{
+	switch (wdev->iftype) {
+	case NL80211_IFTYPE_MESH_POINT:
+		return &wdev->u.mesh.chandef;
+	case NL80211_IFTYPE_ADHOC:
+		return &wdev->u.ibss.chandef;
+	case NL80211_IFTYPE_OCB:
+		return &wdev->u.ocb.chandef;
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+		return &wdev->links[link_id].ap.chandef;
+	default:
+		return NULL;
+	}
+}
diff --git a/net/wireless/core.c b/net/wireless/core.c
index f08d4b3bb148..3e5d12040726 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1118,6 +1118,7 @@ static void _cfg80211_unregister_wdev(struct wireless_dev *wdev,
 				      bool unregister_netdev)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
+	unsigned int link_id;
 
 	ASSERT_RTNL();
 	lockdep_assert_held(&rdev->wiphy.mtx);
@@ -1167,11 +1168,22 @@ static void _cfg80211_unregister_wdev(struct wireless_dev *wdev,
 	 */
 	cfg80211_process_wdev_events(wdev);
 
-	if (WARN_ON(wdev->current_bss)) {
-		cfg80211_unhold_bss(wdev->current_bss);
-		cfg80211_put_bss(wdev->wiphy, &wdev->current_bss->pub);
-		wdev->current_bss = NULL;
+	if (wdev->iftype == NL80211_IFTYPE_STATION ||
+	    wdev->iftype == NL80211_IFTYPE_P2P_CLIENT) {
+		for (link_id = 0; link_id < ARRAY_SIZE(wdev->links); link_id++) {
+			struct cfg80211_internal_bss *curbss;
+
+			curbss = wdev->links[link_id].client.current_bss;
+
+			if (WARN_ON(curbss)) {
+				cfg80211_unhold_bss(curbss);
+				cfg80211_put_bss(wdev->wiphy, &curbss->pub);
+				wdev->links[link_id].client.current_bss = NULL;
+			}
+		}
 	}
+
+	wdev->connected = false;
 }
 
 void cfg80211_unregister_wdev(struct wireless_dev *wdev)
@@ -1233,7 +1245,7 @@ void __cfg80211_leave(struct cfg80211_registered_device *rdev,
 		break;
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_P2P_GO:
-		__cfg80211_stop_ap(rdev, dev, true);
+		__cfg80211_stop_ap(rdev, dev, -1, true);
 		break;
 	case NL80211_IFTYPE_OCB:
 		__cfg80211_leave_ocb(rdev, dev);
@@ -1463,9 +1475,9 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 				memcpy(&setup, &default_mesh_setup,
 						sizeof(setup));
 				 /* back compat only needed for mesh_id */
-				setup.mesh_id = wdev->ssid;
-				setup.mesh_id_len = wdev->mesh_id_up_len;
-				if (wdev->mesh_id_up_len)
+				setup.mesh_id = wdev->u.mesh.id;
+				setup.mesh_id_len = wdev->u.mesh.id_up_len;
+				if (wdev->u.mesh.id_up_len)
 					__cfg80211_join_mesh(rdev, dev,
 							&setup,
 							&default_mesh_config);
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 5436ada91b1a..0e021cd0d035 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -307,6 +307,7 @@ void cfg80211_bss_expire(struct cfg80211_registered_device *rdev);
 void cfg80211_bss_age(struct cfg80211_registered_device *rdev,
                       unsigned long age_secs);
 void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
+				     unsigned int link,
 				     struct ieee80211_channel *channel);
 
 /* IBSS */
@@ -353,9 +354,11 @@ int cfg80211_leave_ocb(struct cfg80211_registered_device *rdev,
 
 /* AP */
 int __cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
-		       struct net_device *dev, bool notify);
+		       struct net_device *dev, int link,
+		       bool notify);
 int cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
-		     struct net_device *dev, bool notify);
+		     struct net_device *dev, int link,
+		     bool notify);
 
 /* MLME */
 int cfg80211_mlme_auth(struct cfg80211_registered_device *rdev,
@@ -507,7 +510,13 @@ bool cfg80211_any_wiphy_oper_chan(struct wiphy *wiphy,
 bool cfg80211_beaconing_iface_active(struct wireless_dev *wdev);
 
 bool cfg80211_is_sub_chan(struct cfg80211_chan_def *chandef,
-			  struct ieee80211_channel *chan);
+			  struct ieee80211_channel *chan,
+			  bool primary_only);
+bool cfg80211_wdev_on_sub_chan(struct wireless_dev *wdev,
+			       struct ieee80211_channel *chan,
+			       bool primary_only);
+struct cfg80211_chan_def *wdev_chandef(struct wireless_dev *wdev,
+				       unsigned int link_id);
 
 static inline unsigned int elapsed_jiffies_msecs(unsigned long start)
 {
diff --git a/net/wireless/ibss.c b/net/wireless/ibss.c
index 5d89eec2869a..4935f94d1acc 100644
--- a/net/wireless/ibss.c
+++ b/net/wireless/ibss.c
@@ -28,7 +28,7 @@ void __cfg80211_ibss_joined(struct net_device *dev, const u8 *bssid,
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_ADHOC))
 		return;
 
-	if (!wdev->ssid_len)
+	if (!wdev->u.ibss.ssid_len)
 		return;
 
 	bss = cfg80211_get_bss(wdev->wiphy, channel, bssid, NULL, 0,
@@ -37,13 +37,13 @@ void __cfg80211_ibss_joined(struct net_device *dev, const u8 *bssid,
 	if (WARN_ON(!bss))
 		return;
 
-	if (wdev->current_bss) {
-		cfg80211_unhold_bss(wdev->current_bss);
-		cfg80211_put_bss(wdev->wiphy, &wdev->current_bss->pub);
+	if (wdev->u.ibss.current_bss) {
+		cfg80211_unhold_bss(wdev->u.ibss.current_bss);
+		cfg80211_put_bss(wdev->wiphy, &wdev->u.ibss.current_bss->pub);
 	}
 
 	cfg80211_hold_bss(bss_from_pub(bss));
-	wdev->current_bss = bss_from_pub(bss);
+	wdev->u.ibss.current_bss = bss_from_pub(bss);
 
 	if (!(wdev->wiphy->flags & WIPHY_FLAG_HAS_STATIC_WEP))
 		cfg80211_upload_connect_keys(wdev);
@@ -96,7 +96,7 @@ int __cfg80211_join_ibss(struct cfg80211_registered_device *rdev,
 	lockdep_assert_held(&rdev->wiphy.mtx);
 	ASSERT_WDEV_LOCK(wdev);
 
-	if (wdev->ssid_len)
+	if (wdev->u.ibss.ssid_len)
 		return -EALREADY;
 
 	if (!params->basic_rates) {
@@ -131,7 +131,7 @@ int __cfg80211_join_ibss(struct cfg80211_registered_device *rdev,
 		kfree_sensitive(wdev->connect_keys);
 	wdev->connect_keys = connkeys;
 
-	wdev->chandef = params->chandef;
+	wdev->u.ibss.chandef = params->chandef;
 	if (connkeys) {
 		params->wep_keys = connkeys->params;
 		params->wep_tx_key = connkeys->def;
@@ -146,8 +146,8 @@ int __cfg80211_join_ibss(struct cfg80211_registered_device *rdev,
 		return err;
 	}
 
-	memcpy(wdev->ssid, params->ssid, params->ssid_len);
-	wdev->ssid_len = params->ssid_len;
+	memcpy(wdev->u.ibss.ssid, params->ssid, params->ssid_len);
+	wdev->u.ibss.ssid_len = params->ssid_len;
 
 	return 0;
 }
@@ -173,14 +173,14 @@ static void __cfg80211_clear_ibss(struct net_device *dev, bool nowext)
 		for (i = 0; i < 6; i++)
 			rdev_del_key(rdev, dev, i, false, NULL);
 
-	if (wdev->current_bss) {
-		cfg80211_unhold_bss(wdev->current_bss);
-		cfg80211_put_bss(wdev->wiphy, &wdev->current_bss->pub);
+	if (wdev->u.ibss.current_bss) {
+		cfg80211_unhold_bss(wdev->u.ibss.current_bss);
+		cfg80211_put_bss(wdev->wiphy, &wdev->u.ibss.current_bss->pub);
 	}
 
-	wdev->current_bss = NULL;
-	wdev->ssid_len = 0;
-	memset(&wdev->chandef, 0, sizeof(wdev->chandef));
+	wdev->u.ibss.current_bss = NULL;
+	wdev->u.ibss.ssid_len = 0;
+	memset(&wdev->u.ibss.chandef, 0, sizeof(wdev->u.ibss.chandef));
 #ifdef CONFIG_CFG80211_WEXT
 	if (!nowext)
 		wdev->wext.ibss.ssid_len = 0;
@@ -205,7 +205,7 @@ int __cfg80211_leave_ibss(struct cfg80211_registered_device *rdev,
 
 	ASSERT_WDEV_LOCK(wdev);
 
-	if (!wdev->ssid_len)
+	if (!wdev->u.ibss.ssid_len)
 		return -ENOLINK;
 
 	err = rdev_leave_ibss(rdev, dev);
@@ -339,7 +339,7 @@ int cfg80211_ibss_wext_siwfreq(struct net_device *dev,
 
 	wdev_lock(wdev);
 	err = 0;
-	if (wdev->ssid_len)
+	if (wdev->u.ibss.ssid_len)
 		err = __cfg80211_leave_ibss(rdev, dev, true);
 	wdev_unlock(wdev);
 
@@ -374,8 +374,8 @@ int cfg80211_ibss_wext_giwfreq(struct net_device *dev,
 		return -EINVAL;
 
 	wdev_lock(wdev);
-	if (wdev->current_bss)
-		chan = wdev->current_bss->pub.channel;
+	if (wdev->u.ibss.current_bss)
+		chan = wdev->u.ibss.current_bss->pub.channel;
 	else if (wdev->wext.ibss.chandef.chan)
 		chan = wdev->wext.ibss.chandef.chan;
 	wdev_unlock(wdev);
@@ -408,7 +408,7 @@ int cfg80211_ibss_wext_siwessid(struct net_device *dev,
 
 	wdev_lock(wdev);
 	err = 0;
-	if (wdev->ssid_len)
+	if (wdev->u.ibss.ssid_len)
 		err = __cfg80211_leave_ibss(rdev, dev, true);
 	wdev_unlock(wdev);
 
@@ -419,8 +419,8 @@ int cfg80211_ibss_wext_siwessid(struct net_device *dev,
 	if (len > 0 && ssid[len - 1] == '\0')
 		len--;
 
-	memcpy(wdev->ssid, ssid, len);
-	wdev->wext.ibss.ssid = wdev->ssid;
+	memcpy(wdev->u.ibss.ssid, ssid, len);
+	wdev->wext.ibss.ssid = wdev->u.ibss.ssid;
 	wdev->wext.ibss.ssid_len = len;
 
 	wdev_lock(wdev);
@@ -443,10 +443,10 @@ int cfg80211_ibss_wext_giwessid(struct net_device *dev,
 	data->flags = 0;
 
 	wdev_lock(wdev);
-	if (wdev->ssid_len) {
+	if (wdev->u.ibss.ssid_len) {
 		data->flags = 1;
-		data->length = wdev->ssid_len;
-		memcpy(ssid, wdev->ssid, data->length);
+		data->length = wdev->u.ibss.ssid_len;
+		memcpy(ssid, wdev->u.ibss.ssid, data->length);
 	} else if (wdev->wext.ibss.ssid && wdev->wext.ibss.ssid_len) {
 		data->flags = 1;
 		data->length = wdev->wext.ibss.ssid_len;
@@ -494,7 +494,7 @@ int cfg80211_ibss_wext_siwap(struct net_device *dev,
 
 	wdev_lock(wdev);
 	err = 0;
-	if (wdev->ssid_len)
+	if (wdev->u.ibss.ssid_len)
 		err = __cfg80211_leave_ibss(rdev, dev, true);
 	wdev_unlock(wdev);
 
@@ -527,8 +527,9 @@ int cfg80211_ibss_wext_giwap(struct net_device *dev,
 	ap_addr->sa_family = ARPHRD_ETHER;
 
 	wdev_lock(wdev);
-	if (wdev->current_bss)
-		memcpy(ap_addr->sa_data, wdev->current_bss->pub.bssid, ETH_ALEN);
+	if (wdev->u.ibss.current_bss)
+		memcpy(ap_addr->sa_data, wdev->u.ibss.current_bss->pub.bssid,
+		       ETH_ALEN);
 	else if (wdev->wext.ibss.bssid)
 		memcpy(ap_addr->sa_data, wdev->wext.ibss.bssid, ETH_ALEN);
 	else
diff --git a/net/wireless/mesh.c b/net/wireless/mesh.c
index e4e363138279..59a3c5c092b1 100644
--- a/net/wireless/mesh.c
+++ b/net/wireless/mesh.c
@@ -1,4 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * Portions
+ * Copyright (C) 2022 Intel Corporation
+ */
 #include <linux/ieee80211.h>
 #include <linux/export.h>
 #include <net/cfg80211.h>
@@ -114,7 +118,7 @@ int __cfg80211_join_mesh(struct cfg80211_registered_device *rdev,
 	      setup->is_secure)
 		return -EOPNOTSUPP;
 
-	if (wdev->mesh_id_len)
+	if (wdev->u.mesh.id_len)
 		return -EALREADY;
 
 	if (!setup->mesh_id_len)
@@ -125,7 +129,7 @@ int __cfg80211_join_mesh(struct cfg80211_registered_device *rdev,
 
 	if (!setup->chandef.chan) {
 		/* if no channel explicitly given, use preset channel */
-		setup->chandef = wdev->preset_chandef;
+		setup->chandef = wdev->u.mesh.preset_chandef;
 	}
 
 	if (!setup->chandef.chan) {
@@ -209,10 +213,10 @@ int __cfg80211_join_mesh(struct cfg80211_registered_device *rdev,
 
 	err = rdev_join_mesh(rdev, dev, conf, setup);
 	if (!err) {
-		memcpy(wdev->ssid, setup->mesh_id, setup->mesh_id_len);
-		wdev->mesh_id_len = setup->mesh_id_len;
-		wdev->chandef = setup->chandef;
-		wdev->beacon_interval = setup->beacon_interval;
+		memcpy(wdev->u.mesh.id, setup->mesh_id, setup->mesh_id_len);
+		wdev->u.mesh.id_len = setup->mesh_id_len;
+		wdev->u.mesh.chandef = setup->chandef;
+		wdev->u.mesh.beacon_interval = setup->beacon_interval;
 	}
 
 	return err;
@@ -241,15 +245,15 @@ int cfg80211_set_mesh_channel(struct cfg80211_registered_device *rdev,
 		err = rdev_libertas_set_mesh_channel(rdev, wdev->netdev,
 						     chandef->chan);
 		if (!err)
-			wdev->chandef = *chandef;
+			wdev->u.mesh.chandef = *chandef;
 
 		return err;
 	}
 
-	if (wdev->mesh_id_len)
+	if (wdev->u.mesh.id_len)
 		return -EBUSY;
 
-	wdev->preset_chandef = *chandef;
+	wdev->u.mesh.preset_chandef = *chandef;
 	return 0;
 }
 
@@ -267,15 +271,16 @@ int __cfg80211_leave_mesh(struct cfg80211_registered_device *rdev,
 	if (!rdev->ops->leave_mesh)
 		return -EOPNOTSUPP;
 
-	if (!wdev->mesh_id_len)
+	if (!wdev->u.mesh.id_len)
 		return -ENOTCONN;
 
 	err = rdev_leave_mesh(rdev, dev);
 	if (!err) {
 		wdev->conn_owner_nlportid = 0;
-		wdev->mesh_id_len = 0;
-		wdev->beacon_interval = 0;
-		memset(&wdev->chandef, 0, sizeof(wdev->chandef));
+		wdev->u.mesh.id_len = 0;
+		wdev->u.mesh.beacon_interval = 0;
+		memset(&wdev->u.mesh.chandef, 0,
+		       sizeof(wdev->u.mesh.chandef));
 		rdev_set_qos_map(rdev, dev, NULL);
 		cfg80211_sched_dfs_chan_update(rdev);
 	}
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index c8155a483ec2..fab2d6206cdd 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -92,8 +92,7 @@ static void cfg80211_process_deauth(struct wireless_dev *wdev,
 
 	nl80211_send_deauth(rdev, wdev->netdev, buf, len, reconnect, GFP_KERNEL);
 
-	if (!wdev->current_bss ||
-	    !ether_addr_equal(wdev->current_bss->pub.bssid, bssid))
+	if (!wdev->connected || !ether_addr_equal(wdev->u.client.connected_addr, bssid))
 		return;
 
 	__cfg80211_disconnected(wdev->netdev, NULL, 0, reason_code, from_ap);
@@ -113,8 +112,8 @@ static void cfg80211_process_disassoc(struct wireless_dev *wdev,
 	nl80211_send_disassoc(rdev, wdev->netdev, buf, len, reconnect,
 			      GFP_KERNEL);
 
-	if (WARN_ON(!wdev->current_bss ||
-		    !ether_addr_equal(wdev->current_bss->pub.bssid, bssid)))
+	if (WARN_ON(!wdev->connected ||
+		    !ether_addr_equal(wdev->u.client.connected_addr, bssid)))
 		return;
 
 	__cfg80211_disconnected(wdev->netdev, NULL, 0, reason_code, from_ap);
@@ -260,8 +259,8 @@ int cfg80211_mlme_auth(struct cfg80211_registered_device *rdev,
 		if (!key || !key_len || key_idx < 0 || key_idx > 3)
 			return -EINVAL;
 
-	if (wdev->current_bss &&
-	    ether_addr_equal(bssid, wdev->current_bss->pub.bssid))
+	if (wdev->connected &&
+	    ether_addr_equal(bssid, wdev->u.client.connected_addr))
 		return -EALREADY;
 
 	req.bss = cfg80211_get_bss(&rdev->wiphy, chan, bssid, ssid, ssid_len,
@@ -322,9 +321,9 @@ int cfg80211_mlme_assoc(struct cfg80211_registered_device *rdev,
 
 	ASSERT_WDEV_LOCK(wdev);
 
-	if (wdev->current_bss &&
-	    (!req->prev_bssid || !ether_addr_equal(wdev->current_bss->pub.bssid,
-						   req->prev_bssid)))
+	if (wdev->connected &&
+	    (!req->prev_bssid ||
+	     !ether_addr_equal(wdev->u.client.connected_addr, req->prev_bssid)))
 		return -EALREADY;
 
 	cfg80211_oper_and_ht_capa(&req->ht_capa_mask,
@@ -364,13 +363,13 @@ int cfg80211_mlme_deauth(struct cfg80211_registered_device *rdev,
 	ASSERT_WDEV_LOCK(wdev);
 
 	if (local_state_change &&
-	    (!wdev->current_bss ||
-	     !ether_addr_equal(wdev->current_bss->pub.bssid, bssid)))
+	    (!wdev->connected ||
+	     !ether_addr_equal(wdev->u.client.connected_addr, bssid)))
 		return 0;
 
 	if (ether_addr_equal(wdev->disconnect_bssid, bssid) ||
-	    (wdev->current_bss &&
-	     ether_addr_equal(wdev->current_bss->pub.bssid, bssid)))
+	    (wdev->connected &&
+	     ether_addr_equal(wdev->u.client.connected_addr, bssid)))
 		wdev->conn_owner_nlportid = 0;
 
 	return rdev_deauth(rdev, dev, &req);
@@ -392,11 +391,12 @@ int cfg80211_mlme_disassoc(struct cfg80211_registered_device *rdev,
 
 	ASSERT_WDEV_LOCK(wdev);
 
-	if (!wdev->current_bss)
+	if (!wdev->connected)
 		return -ENOTCONN;
 
-	if (ether_addr_equal(wdev->current_bss->pub.bssid, bssid))
-		req.bss = &wdev->current_bss->pub;
+	if (ether_addr_equal(wdev->links[0].client.current_bss->pub.bssid,
+			     bssid))
+		req.bss = &wdev->links[0].client.current_bss->pub;
 	else
 		return -ENOTCONN;
 
@@ -405,7 +405,7 @@ int cfg80211_mlme_disassoc(struct cfg80211_registered_device *rdev,
 		return err;
 
 	/* driver should have reported the disassoc */
-	WARN_ON(wdev->current_bss);
+	WARN_ON(wdev->connected);
 	return 0;
 }
 
@@ -420,10 +420,10 @@ void cfg80211_mlme_down(struct cfg80211_registered_device *rdev,
 	if (!rdev->ops->deauth)
 		return;
 
-	if (!wdev->current_bss)
+	if (!wdev->connected)
 		return;
 
-	memcpy(bssid, wdev->current_bss->pub.bssid, ETH_ALEN);
+	memcpy(bssid, wdev->u.client.connected_addr, ETH_ALEN);
 	cfg80211_mlme_deauth(rdev, dev, bssid, NULL, 0,
 			     WLAN_REASON_DEAUTH_LEAVING, false);
 }
@@ -676,28 +676,34 @@ int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 
 		switch (wdev->iftype) {
 		case NL80211_IFTYPE_ADHOC:
+			/*
+			 * check for IBSS DA must be done by driver as
+			 * cfg80211 doesn't track the stations
+			 */
+			if (!wdev->u.ibss.current_bss ||
+			    !ether_addr_equal(wdev->u.ibss.current_bss->pub.bssid,
+					      mgmt->bssid)) {
+				err = -ENOTCONN;
+				break;
+			}
+			break;
 		case NL80211_IFTYPE_STATION:
 		case NL80211_IFTYPE_P2P_CLIENT:
-			if (!wdev->current_bss) {
+			if (!wdev->connected) {
 				err = -ENOTCONN;
 				break;
 			}
 
-			if (!ether_addr_equal(wdev->current_bss->pub.bssid,
+			/* FIXME: MLD may address this differently */
+
+			if (!ether_addr_equal(wdev->u.client.connected_addr,
 					      mgmt->bssid)) {
 				err = -ENOTCONN;
 				break;
 			}
 
-			/*
-			 * check for IBSS DA must be done by driver as
-			 * cfg80211 doesn't track the stations
-			 */
-			if (wdev->iftype == NL80211_IFTYPE_ADHOC)
-				break;
-
 			/* for station, check that DA is the AP */
-			if (!ether_addr_equal(wdev->current_bss->pub.bssid,
+			if (!ether_addr_equal(wdev->u.client.connected_addr,
 					      mgmt->da)) {
 				err = -ENOTCONN;
 				break;
@@ -743,12 +749,12 @@ int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 		if (!ieee80211_is_action(mgmt->frame_control) ||
 		    mgmt->u.action.category != WLAN_CATEGORY_PUBLIC)
 			return -EINVAL;
-		if (!wdev->current_bss &&
+		if (!wdev->connected &&
 		    !wiphy_ext_feature_isset(
 			    &rdev->wiphy,
 			    NL80211_EXT_FEATURE_MGMT_TX_RANDOM_TA))
 			return -EINVAL;
-		if (wdev->current_bss &&
+		if (wdev->connected &&
 		    !wiphy_ext_feature_isset(
 			    &rdev->wiphy,
 			    NL80211_EXT_FEATURE_MGMT_TX_RANDOM_TA_CONNECTED))
@@ -940,12 +946,16 @@ void cfg80211_cac_event(struct net_device *netdev,
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	unsigned long timeout;
 
+	/* not yet supported */
+	if (wdev->valid_links)
+		return;
+
 	trace_cfg80211_cac_event(netdev, event);
 
 	if (WARN_ON(!wdev->cac_started && event != NL80211_RADAR_CAC_STARTED))
 		return;
 
-	if (WARN_ON(!wdev->chandef.chan))
+	if (WARN_ON(!wdev->links[0].ap.chandef.chan))
 		return;
 
 	switch (event) {
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2c64baae9863..936377fed140 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -792,6 +792,10 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 				 NL80211_EHT_MIN_CAPABILITY_LEN,
 				 NL80211_EHT_MAX_CAPABILITY_LEN),
 	[NL80211_ATTR_DISABLE_EHT] = { .type = NLA_FLAG },
+	[NL80211_ATTR_MLO_LINKS] =
+		NLA_POLICY_NESTED_ARRAY(nl80211_policy),
+	[NL80211_ATTR_MLO_LINK_ID] =
+		NLA_POLICY_RANGE(NLA_U8, 0, IEEE80211_MLD_MAX_NUM_LINKS),
 };
 
 /* policy for the key attributes */
@@ -1225,6 +1229,37 @@ static bool nl80211_put_txq_stats(struct sk_buff *msg,
 
 /* netlink command implementations */
 
+/**
+ * nl80211_link_id - return link ID
+ * @attrs: attributes to look at
+ *
+ * Returns: the link ID or 0 if not given
+ *
+ * Note this function doesn't do any validation of the link
+ * ID validity wrt. links that were actually added, so it must
+ * be called only from ops with %NL80211_FLAG_MLO_VALID_LINK_ID
+ * or if additional validation is done.
+ */
+static unsigned int nl80211_link_id(struct nlattr **attrs)
+{
+	struct nlattr *linkid = attrs[NL80211_ATTR_MLO_LINK_ID];
+
+	if (!linkid)
+		return 0;
+
+	return nla_get_u8(linkid);
+}
+
+static int nl80211_link_id_or_invalid(struct nlattr **attrs)
+{
+	struct nlattr *linkid = attrs[NL80211_ATTR_MLO_LINK_ID];
+
+	if (!linkid)
+		return -1;
+
+	return nla_get_u8(linkid);
+}
+
 struct key_parse {
 	struct key_params p;
 	int idx;
@@ -1496,11 +1531,15 @@ static int nl80211_key_allowed(struct wireless_dev *wdev)
 	case NL80211_IFTYPE_MESH_POINT:
 		break;
 	case NL80211_IFTYPE_ADHOC:
+		if (wdev->u.ibss.current_bss)
+			return 0;
+		return -ENOLINK;
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
-		if (!wdev->current_bss)
-			return -ENOLINK;
-		break;
+		/* for MLO, require driver validation of the link ID */
+		if (wdev->connected)
+			return 0;
+		return -ENOLINK;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_OCB:
 	case NL80211_IFTYPE_MONITOR:
@@ -3223,12 +3262,14 @@ int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 
 static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
 				 struct net_device *dev,
-				 struct genl_info *info)
+				 struct genl_info *info,
+				 int _link_id)
 {
 	struct cfg80211_chan_def chandef;
 	int result;
 	enum nl80211_iftype iftype = NL80211_IFTYPE_MONITOR;
 	struct wireless_dev *wdev = NULL;
+	int link_id = _link_id;
 
 	if (dev)
 		wdev = dev->ieee80211_ptr;
@@ -3237,6 +3278,12 @@ static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
 	if (wdev)
 		iftype = wdev->iftype;
 
+	if (link_id < 0) {
+		if (wdev && wdev->valid_links)
+			return -EINVAL;
+		link_id = 0;
+	}
+
 	result = nl80211_parse_chandef(rdev, info, &chandef);
 	if (result)
 		return result;
@@ -3245,49 +3292,52 @@ static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_P2P_GO:
 		if (!cfg80211_reg_can_beacon_relax(&rdev->wiphy, &chandef,
-						   iftype)) {
-			result = -EINVAL;
-			break;
-		}
-		if (wdev->beacon_interval) {
+						   iftype))
+			return -EINVAL;
+		if (wdev->links[link_id].ap.beacon_interval) {
+			struct ieee80211_channel *cur_chan;
+
 			if (!dev || !rdev->ops->set_ap_chanwidth ||
 			    !(rdev->wiphy.features &
-			      NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE)) {
-				result = -EBUSY;
-				break;
-			}
+			      NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE))
+				return -EBUSY;
 
 			/* Only allow dynamic channel width changes */
-			if (chandef.chan != wdev->preset_chandef.chan) {
-				result = -EBUSY;
-				break;
-			}
-			result = rdev_set_ap_chanwidth(rdev, dev, &chandef);
+			cur_chan = wdev->links[link_id].ap.chandef.chan;
+			if (chandef.chan != cur_chan)
+				return -EBUSY;
+
+			result = rdev_set_ap_chanwidth(rdev, dev, link_id,
+						       &chandef);
 			if (result)
-				break;
+				return result;
+			wdev->links[link_id].ap.chandef = chandef;
+			if (_link_id == -1)
+				wdev->u.ap.preset_chandef = chandef;
+		} else {
+			if (_link_id != -1)
+				return -EINVAL;
+			wdev->u.ap.preset_chandef = chandef;
 		}
-		wdev->preset_chandef = chandef;
-		result = 0;
-		break;
+		return 0;
 	case NL80211_IFTYPE_MESH_POINT:
-		result = cfg80211_set_mesh_channel(rdev, wdev, &chandef);
-		break;
+		return cfg80211_set_mesh_channel(rdev, wdev, &chandef);
 	case NL80211_IFTYPE_MONITOR:
-		result = cfg80211_set_monitor_channel(rdev, &chandef);
-		break;
+		return cfg80211_set_monitor_channel(rdev, &chandef);
 	default:
-		result = -EINVAL;
+		break;
 	}
 
-	return result;
+	return -EINVAL;
 }
 
 static int nl80211_set_channel(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	int link_id = nl80211_link_id_or_invalid(info->attrs);
 	struct net_device *netdev = info->user_ptr[1];
 
-	return __nl80211_set_channel(rdev, netdev, info);
+	return __nl80211_set_channel(rdev, netdev, info, link_id);
 }
 
 static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
@@ -3402,7 +3452,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 		result = __nl80211_set_channel(
 			rdev,
 			nl80211_can_set_dev_channel(wdev) ? netdev : NULL,
-			info);
+			info, -1);
 		if (result)
 			goto out;
 	}
@@ -3687,15 +3737,13 @@ static int nl80211_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flag
 	    nla_put_u8(msg, NL80211_ATTR_4ADDR, wdev->use_4addr))
 		goto nla_put_failure;
 
-	if (rdev->ops->get_channel) {
-		int ret;
+	if (rdev->ops->get_channel && !wdev->valid_links) {
 		struct cfg80211_chan_def chandef = {};
+		int ret;
 
-		ret = rdev_get_channel(rdev, wdev, &chandef);
-		if (ret == 0) {
-			if (nl80211_send_chandef(msg, &chandef))
-				goto nla_put_failure;
-		}
+		ret = rdev_get_channel(rdev, wdev, 0, &chandef);
+		if (ret == 0 && nl80211_send_chandef(msg, &chandef))
+			goto nla_put_failure;
 	}
 
 	if (rdev->ops->get_tx_power) {
@@ -3712,27 +3760,24 @@ static int nl80211_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flag
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_P2P_GO:
-		if (wdev->ssid_len &&
-		    nla_put(msg, NL80211_ATTR_SSID, wdev->ssid_len, wdev->ssid))
+		if (wdev->u.ap.ssid_len &&
+		    nla_put(msg, NL80211_ATTR_SSID, wdev->u.ap.ssid_len,
+			    wdev->u.ap.ssid))
 			goto nla_put_failure_locked;
 		break;
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
-	case NL80211_IFTYPE_ADHOC: {
-		const struct element *ssid_elem;
-
-		if (!wdev->current_bss)
-			break;
-		rcu_read_lock();
-		ssid_elem = ieee80211_bss_get_elem(&wdev->current_bss->pub,
-						   WLAN_EID_SSID);
-		if (ssid_elem &&
-		    nla_put(msg, NL80211_ATTR_SSID, ssid_elem->datalen,
-			    ssid_elem->data))
-			goto nla_put_failure_rcu_locked;
-		rcu_read_unlock();
+		if (wdev->u.client.ssid_len &&
+		    nla_put(msg, NL80211_ATTR_SSID, wdev->u.client.ssid_len,
+			    wdev->u.client.ssid))
+			goto nla_put_failure_locked;
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		if (wdev->u.ibss.ssid_len &&
+		    nla_put(msg, NL80211_ATTR_SSID, wdev->u.ibss.ssid_len,
+			    wdev->u.ibss.ssid))
+			goto nla_put_failure_locked;
 		break;
-		}
 	default:
 		/* nothing */
 		break;
@@ -3752,8 +3797,6 @@ static int nl80211_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flag
 	genlmsg_end(msg, hdr);
 	return 0;
 
- nla_put_failure_rcu_locked:
-	rcu_read_unlock();
  nla_put_failure_locked:
 	wdev_unlock(wdev);
  nla_put_failure:
@@ -4005,10 +4048,11 @@ static int nl80211_set_interface(struct sk_buff *skb, struct genl_info *info)
 		wdev_lock(wdev);
 		BUILD_BUG_ON(IEEE80211_MAX_SSID_LEN !=
 			     IEEE80211_MAX_MESH_ID_LEN);
-		wdev->mesh_id_up_len =
+		wdev->u.mesh.id_up_len =
 			nla_len(info->attrs[NL80211_ATTR_MESH_ID]);
-		memcpy(wdev->ssid, nla_data(info->attrs[NL80211_ATTR_MESH_ID]),
-		       wdev->mesh_id_up_len);
+		memcpy(wdev->u.mesh.id,
+		       nla_data(info->attrs[NL80211_ATTR_MESH_ID]),
+		       wdev->u.mesh.id_up_len);
 		wdev_unlock(wdev);
 	}
 
@@ -4113,10 +4157,11 @@ static int _nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 		wdev_lock(wdev);
 		BUILD_BUG_ON(IEEE80211_MAX_SSID_LEN !=
 			     IEEE80211_MAX_MESH_ID_LEN);
-		wdev->mesh_id_up_len =
+		wdev->u.mesh.id_up_len =
 			nla_len(info->attrs[NL80211_ATTR_MESH_ID]);
-		memcpy(wdev->ssid, nla_data(info->attrs[NL80211_ATTR_MESH_ID]),
-		       wdev->mesh_id_up_len);
+		memcpy(wdev->u.mesh.id,
+		       nla_data(info->attrs[NL80211_ATTR_MESH_ID]),
+		       wdev->u.mesh.id_up_len);
 		wdev_unlock(wdev);
 		break;
 	case NL80211_IFTYPE_NAN:
@@ -4653,7 +4698,7 @@ static int nl80211_set_mac_acl(struct sk_buff *skb, struct genl_info *info)
 	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
 		return -EOPNOTSUPP;
 
-	if (!dev->ieee80211_ptr->beacon_interval)
+	if (!dev->ieee80211_ptr->links[0].ap.beacon_interval)
 		return -EINVAL;
 
 	acl = parse_acl_data(&rdev->wiphy, info);
@@ -4809,14 +4854,24 @@ static void he_build_mcs_mask(u16 he_mcs_map,
 	}
 }
 
-static u16 he_get_txmcsmap(struct genl_info *info,
+static u16 he_get_txmcsmap(struct genl_info *info, unsigned int link_id,
 			   const struct ieee80211_sta_he_cap *he_cap)
 {
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	__le16	tx_mcs;
+	struct cfg80211_chan_def *chandef;
+	__le16 tx_mcs;
+
+	chandef = wdev_chandef(wdev, link_id);
+	if (!chandef) {
+		/*
+		 * This is probably broken, but we never maintained
+		 * a chandef in these cases, so it always was.
+		 */
+		return le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_80);
+	}
 
-	switch (wdev->chandef.width) {
+	switch (chandef->width) {
 	case NL80211_CHAN_WIDTH_80P80:
 		tx_mcs = he_cap->he_mcs_nss_supp.tx_mcs_80p80;
 		break;
@@ -4827,6 +4882,7 @@ static u16 he_get_txmcsmap(struct genl_info *info,
 		tx_mcs = he_cap->he_mcs_nss_supp.tx_mcs_80;
 		break;
 	}
+
 	return le16_to_cpu(tx_mcs);
 }
 
@@ -4834,7 +4890,8 @@ static bool he_set_mcs_mask(struct genl_info *info,
 			    struct wireless_dev *wdev,
 			    struct ieee80211_supported_band *sband,
 			    struct nl80211_txrate_he *txrate,
-			    u16 mcs[NL80211_HE_NSS_MAX])
+			    u16 mcs[NL80211_HE_NSS_MAX],
+			    unsigned int link_id)
 {
 	const struct ieee80211_sta_he_cap *he_cap;
 	u16 tx_mcs_mask[NL80211_HE_NSS_MAX] = {};
@@ -4847,7 +4904,7 @@ static bool he_set_mcs_mask(struct genl_info *info,
 
 	memset(mcs, 0, sizeof(u16) * NL80211_HE_NSS_MAX);
 
-	tx_mcs_map = he_get_txmcsmap(info, he_cap);
+	tx_mcs_map = he_get_txmcsmap(info, link_id, he_cap);
 
 	/* Build he_mcs_mask from HE capabilities */
 	he_build_mcs_mask(tx_mcs_map, tx_mcs_mask);
@@ -4867,7 +4924,8 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 					 enum nl80211_attrs attr,
 					 struct cfg80211_bitrate_mask *mask,
 					 struct net_device *dev,
-					 bool default_all_enabled)
+					 bool default_all_enabled,
+					 unsigned int link_id)
 {
 	struct nlattr *tb[NL80211_TXRATE_MAX + 1];
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
@@ -4904,7 +4962,7 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 		if (!he_cap)
 			continue;
 
-		he_tx_mcs_map = he_get_txmcsmap(info, he_cap);
+		he_tx_mcs_map = he_get_txmcsmap(info, link_id, he_cap);
 		he_build_mcs_mask(he_tx_mcs_map, mask->control[i].he_mcs);
 
 		mask->control[i].he_gi = 0xFF;
@@ -4969,7 +5027,8 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
 		if (tb[NL80211_TXRATE_HE] &&
 		    !he_set_mcs_mask(info, wdev, sband,
 				     nla_data(tb[NL80211_TXRATE_HE]),
-				     mask->control[band].he_mcs))
+				     mask->control[band].he_mcs,
+				     link_id))
 			return -EINVAL;
 
 		if (tb[NL80211_TXRATE_HE_GI])
@@ -5182,6 +5241,8 @@ static int nl80211_parse_beacon(struct cfg80211_registered_device *rdev,
 
 	memset(bcn, 0, sizeof(*bcn));
 
+	bcn->link_id = nl80211_link_id(attrs);
+
 	if (attrs[NL80211_ATTR_BEACON_HEAD]) {
 		bcn->head = nla_data(attrs[NL80211_ATTR_BEACON_HEAD]);
 		bcn->head_len = nla_len(attrs[NL80211_ATTR_BEACON_HEAD]);
@@ -5451,22 +5512,24 @@ static bool nl80211_get_ap_channel(struct cfg80211_registered_device *rdev,
 				   struct cfg80211_ap_settings *params)
 {
 	struct wireless_dev *wdev;
-	bool ret = false;
 
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 		if (wdev->iftype != NL80211_IFTYPE_AP &&
 		    wdev->iftype != NL80211_IFTYPE_P2P_GO)
 			continue;
 
-		if (!wdev->preset_chandef.chan)
+		/* let this method only work for non-MLD */
+		if (wdev->valid_links)
 			continue;
 
-		params->chandef = wdev->preset_chandef;
-		ret = true;
-		break;
+		if (!wdev->u.ap.preset_chandef.chan)
+			continue;
+
+		params->chandef = wdev->u.ap.preset_chandef;
+		return true;
 	}
 
-	return ret;
+	return false;
 }
 
 static bool nl80211_valid_auth_type(struct cfg80211_registered_device *rdev,
@@ -5524,6 +5587,7 @@ static bool nl80211_valid_auth_type(struct cfg80211_registered_device *rdev,
 static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	unsigned int link_id = nl80211_link_id(info->attrs);
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_ap_settings *params;
@@ -5536,7 +5600,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	if (!rdev->ops->start_ap)
 		return -EOPNOTSUPP;
 
-	if (wdev->beacon_interval)
+	if (wdev->links[link_id].ap.beacon_interval)
 		return -EALREADY;
 
 	/* these are required for START_AP */
@@ -5578,6 +5642,18 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			err = -EINVAL;
 			goto out;
 		}
+
+		if (wdev->u.ap.ssid_len &&
+		    (wdev->u.ap.ssid_len != params->ssid_len ||
+		     memcmp(wdev->u.ap.ssid, params->ssid, params->ssid_len))) {
+			/* require identical SSID for MLO */
+			err = -EINVAL;
+			goto out;
+		}
+	} else if (wdev->valid_links) {
+		/* require SSID for MLO */
+		err = -EINVAL;
+		goto out;
 	}
 
 	if (info->attrs[NL80211_ATTR_HIDDEN_SSID])
@@ -5645,8 +5721,8 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		err = nl80211_parse_chandef(rdev, info, &params->chandef);
 		if (err)
 			goto out;
-	} else if (wdev->preset_chandef.chan) {
-		params->chandef = wdev->preset_chandef;
+	} else if (wdev->u.ap.preset_chandef.chan) {
+		params->chandef = wdev->u.ap.preset_chandef;
 	} else if (!nl80211_get_ap_channel(rdev, params)) {
 		err = -EINVAL;
 		goto out;
@@ -5662,7 +5738,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
 						    NL80211_ATTR_TX_RATES,
 						    &params->beacon_rate,
-						    dev, false);
+						    dev, false, link_id);
 		if (err)
 			goto out;
 
@@ -5770,19 +5846,28 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		params->flags |= NL80211_AP_SETTINGS_EXTERNAL_AUTH_SUPPORT;
 
 	wdev_lock(wdev);
+	if (wdev->conn_owner_nlportid &&
+	    info->attrs[NL80211_ATTR_SOCKET_OWNER] &&
+	    wdev->conn_owner_nlportid != info->snd_portid) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
+
+	/* FIXME: validate MLO/link-id against driver capabilities */
+
 	err = rdev_start_ap(rdev, dev, params);
 	if (!err) {
-		wdev->preset_chandef = params->chandef;
-		wdev->beacon_interval = params->beacon_interval;
-		wdev->chandef = params->chandef;
-		wdev->ssid_len = params->ssid_len;
-		memcpy(wdev->ssid, params->ssid, wdev->ssid_len);
+		wdev->links[link_id].ap.beacon_interval = params->beacon_interval;
+		wdev->links[link_id].ap.chandef = params->chandef;
+		wdev->u.ap.ssid_len = params->ssid_len;
+		memcpy(wdev->u.ap.ssid, params->ssid,
+		       params->ssid_len);
 
 		if (info->attrs[NL80211_ATTR_SOCKET_OWNER])
 			wdev->conn_owner_nlportid = info->snd_portid;
 	}
+out_unlock:
 	wdev_unlock(wdev);
-
 out:
 	kfree(params->acl);
 	kfree(params->beacon.mbssid_ies);
@@ -5798,6 +5883,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	unsigned int link_id = nl80211_link_id(info->attrs);
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_beacon_data params;
@@ -5810,7 +5896,7 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 	if (!rdev->ops->change_beacon)
 		return -EOPNOTSUPP;
 
-	if (!wdev->beacon_interval)
+	if (!wdev->links[link_id].ap.beacon_interval)
 		return -EINVAL;
 
 	err = nl80211_parse_beacon(rdev, info->attrs, &params);
@@ -5829,9 +5915,10 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 static int nl80211_stop_ap(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	unsigned int link_id = nl80211_link_id(info->attrs);
 	struct net_device *dev = info->user_ptr[1];
 
-	return cfg80211_stop_ap(rdev, dev, false);
+	return cfg80211_stop_ap(rdev, dev, link_id, false);
 }
 
 static const struct nla_policy sta_flags_policy[NL80211_STA_FLAG_MAX + 1] = {
@@ -7581,7 +7668,7 @@ static int nl80211_get_mesh_config(struct sk_buff *skb,
 
 	wdev_lock(wdev);
 	/* If not connected, get default parameters */
-	if (!wdev->mesh_id_len)
+	if (!wdev->u.mesh.id_len)
 		memcpy(&cur_params, &default_mesh_config, sizeof(cur_params));
 	else
 		err = rdev_get_mesh_config(rdev, dev, &cur_params);
@@ -7962,7 +8049,7 @@ static int nl80211_update_mesh_config(struct sk_buff *skb,
 		return err;
 
 	wdev_lock(wdev);
-	if (!wdev->mesh_id_len)
+	if (!wdev->u.mesh.id_len)
 		err = -ENOLINK;
 
 	if (!err)
@@ -8454,14 +8541,44 @@ int nl80211_parse_random_mac(struct nlattr **attrs,
 	return 0;
 }
 
-static bool cfg80211_off_channel_oper_allowed(struct wireless_dev *wdev)
+static bool cfg80211_off_channel_oper_allowed(struct wireless_dev *wdev,
+					      struct ieee80211_channel *chan)
 {
+	unsigned int link_id;
+	bool all_ok = true;
+
 	ASSERT_WDEV_LOCK(wdev);
 
 	if (!cfg80211_beaconing_iface_active(wdev))
 		return true;
 
-	if (!(wdev->chandef.chan->flags & IEEE80211_CHAN_RADAR))
+	/*
+	 * FIXME: check if we have a free HW resource/link for chan
+	 *
+	 * This, as well as the FIXME below, requires knowing the link
+	 * capabilities of the hardware.
+	 */
+
+	/* we cannot leave radar channels */
+	for_each_valid_link(wdev, link_id) {
+		struct cfg80211_chan_def *chandef;
+
+		chandef = wdev_chandef(wdev, link_id);
+		if (!chandef)
+			continue;
+
+		/*
+		 * FIXME: don't require all_ok, but rather check only the
+		 *	  correct HW resource/link onto which 'chan' falls,
+		 *	  as only that link leaves the channel for doing
+		 *	  the off-channel operation.
+		 */
+
+		if (chandef->chan->flags & IEEE80211_CHAN_RADAR)
+			all_ok = false;
+	}
+
+	if (all_ok)
 		return true;
 
 	return regulatory_pre_cac_allowed(wdev->wiphy);
@@ -8544,7 +8661,7 @@ nl80211_check_scan_flags(struct wiphy *wiphy, struct wireless_dev *wdev,
 		int err;
 
 		if (!(wiphy->features & randomness_flag) ||
-		    (wdev && wdev->current_bss))
+		    (wdev && wdev->connected))
 			return -EOPNOTSUPP;
 
 		err = nl80211_parse_random_mac(attrs, mac_addr, mac_addr_mask);
@@ -8681,17 +8798,14 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 	request->n_channels = i;
 
 	wdev_lock(wdev);
-	if (!cfg80211_off_channel_oper_allowed(wdev)) {
-		struct ieee80211_channel *chan;
+	for (i = 0; i < request->n_channels; i++) {
+		struct ieee80211_channel *chan = request->channels[i];
 
-		if (request->n_channels != 1) {
-			wdev_unlock(wdev);
-			err = -EBUSY;
-			goto out_free;
-		}
+		/* if we can go off-channel to the target channel we're good */
+		if (cfg80211_off_channel_oper_allowed(wdev, chan))
+			continue;
 
-		chan = request->channels[0];
-		if (chan->center_freq != wdev->chandef.chan->center_freq) {
+		if (!cfg80211_wdev_on_sub_chan(wdev, chan, true)) {
 			wdev_unlock(wdev);
 			err = -EBUSY;
 			goto out_free;
@@ -9436,7 +9550,7 @@ static int nl80211_start_radar_detection(struct sk_buff *skb,
 
 	err = rdev_start_radar_detection(rdev, dev, &chandef, cac_time_ms);
 	if (!err) {
-		wdev->chandef = chandef;
+		wdev->links[0].ap.chandef = chandef;
 		wdev->cac_started = true;
 		wdev->cac_start_time = jiffies;
 		wdev->cac_time_ms = cac_time_ms;
@@ -9504,6 +9618,7 @@ static int nl80211_notify_radar_detection(struct sk_buff *skb,
 static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	unsigned int link_id = nl80211_link_id(info->attrs);
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_csa_settings params;
@@ -9530,15 +9645,15 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 		need_handle_dfs_flag = false;
 
 		/* useless if AP is not running */
-		if (!wdev->beacon_interval)
+		if (!wdev->links[link_id].ap.beacon_interval)
 			return -ENOTCONN;
 		break;
 	case NL80211_IFTYPE_ADHOC:
-		if (!wdev->ssid_len)
+		if (!wdev->u.ibss.ssid_len)
 			return -ENOTCONN;
 		break;
 	case NL80211_IFTYPE_MESH_POINT:
-		if (!wdev->mesh_id_len)
+		if (!wdev->u.mesh.id_len)
 			return -ENOTCONN;
 		break;
 	default:
@@ -9709,6 +9824,7 @@ static int nl80211_send_bss(struct sk_buff *msg, struct netlink_callback *cb,
 {
 	struct cfg80211_bss *res = &intbss->pub;
 	const struct cfg80211_bss_ies *ies;
+	unsigned int link_id;
 	void *hdr;
 	struct nlattr *bss;
 
@@ -9813,13 +9929,15 @@ static int nl80211_send_bss(struct sk_buff *msg, struct netlink_callback *cb,
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_P2P_CLIENT:
 	case NL80211_IFTYPE_STATION:
-		if (intbss == wdev->current_bss &&
-		    nla_put_u32(msg, NL80211_BSS_STATUS,
-				NL80211_BSS_STATUS_ASSOCIATED))
-			goto nla_put_failure;
+		for_each_valid_link(wdev, link_id) {
+			if (intbss == wdev->links[link_id].client.current_bss &&
+			    nla_put_u32(msg, NL80211_BSS_STATUS,
+					NL80211_BSS_STATUS_ASSOCIATED))
+				goto nla_put_failure;
+		}
 		break;
 	case NL80211_IFTYPE_ADHOC:
-		if (intbss == wdev->current_bss &&
+		if (intbss == wdev->u.ibss.current_bss &&
 		    nla_put_u32(msg, NL80211_BSS_STATUS,
 				NL80211_BSS_STATUS_IBSS_JOINED))
 			goto nla_put_failure;
@@ -11353,7 +11471,7 @@ static int nl80211_update_connect_params(struct sk_buff *skb,
 	}
 
 	wdev_lock(dev->ieee80211_ptr);
-	if (!wdev->current_bss)
+	if (!wdev->connected)
 		ret = -ENOLINK;
 	else
 		ret = rdev_update_connect_params(rdev, dev, &connect, changed);
@@ -11566,9 +11684,9 @@ static int nl80211_remain_on_channel(struct sk_buff *skb,
 				     struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	unsigned int link_id = nl80211_link_id(info->attrs);
 	struct wireless_dev *wdev = info->user_ptr[1];
 	struct cfg80211_chan_def chandef;
-	const struct cfg80211_chan_def *compat_chandef;
 	struct sk_buff *msg;
 	void *hdr;
 	u64 cookie;
@@ -11598,10 +11716,22 @@ static int nl80211_remain_on_channel(struct sk_buff *skb,
 		return err;
 
 	wdev_lock(wdev);
-	if (!cfg80211_off_channel_oper_allowed(wdev) &&
-	    !cfg80211_chandef_identical(&wdev->chandef, &chandef)) {
-		compat_chandef = cfg80211_chandef_compatible(&wdev->chandef,
-							     &chandef);
+	if (!cfg80211_off_channel_oper_allowed(wdev, chandef.chan)) {
+		const struct cfg80211_chan_def *oper_chandef, *compat_chandef;
+
+		oper_chandef = wdev_chandef(wdev, link_id);
+
+		if (WARN_ON(!oper_chandef)) {
+			/* cannot happen since we must beacon to get here */
+			WARN_ON(1);
+			wdev_unlock(wdev);
+			return -EBUSY;
+		}
+
+		/* note: returns first one if identical chandefs */
+		compat_chandef = cfg80211_chandef_compatible(&chandef,
+							     oper_chandef);
+
 		if (compat_chandef != &chandef) {
 			wdev_unlock(wdev);
 			return -EBUSY;
@@ -11663,6 +11793,7 @@ static int nl80211_set_tx_bitrate_mask(struct sk_buff *skb,
 				       struct genl_info *info)
 {
 	struct cfg80211_bitrate_mask mask;
+	unsigned int link_id = nl80211_link_id(info->attrs);
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	int err;
@@ -11672,11 +11803,11 @@ static int nl80211_set_tx_bitrate_mask(struct sk_buff *skb,
 
 	err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
 					    NL80211_ATTR_TX_RATES, &mask,
-					    dev, true);
+					    dev, true, link_id);
 	if (err)
 		return err;
 
-	return rdev_set_bitrate_mask(rdev, dev, NULL, &mask);
+	return rdev_set_bitrate_mask(rdev, dev, link_id, NULL, &mask);
 }
 
 static int nl80211_register_mgmt(struct sk_buff *skb, struct genl_info *info)
@@ -11798,7 +11929,8 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	wdev_lock(wdev);
-	if (params.offchan && !cfg80211_off_channel_oper_allowed(wdev)) {
+	if (params.offchan &&
+	    !cfg80211_off_channel_oper_allowed(wdev, chandef.chan)) {
 		wdev_unlock(wdev);
 		return -EBUSY;
 	}
@@ -12016,12 +12148,13 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 	 * connection is established and enough beacons received to calculate
 	 * the average.
 	 */
-	if (!wdev->cqm_config->last_rssi_event_value && wdev->current_bss &&
+	if (!wdev->cqm_config->last_rssi_event_value &&
+	    wdev->links[0].client.current_bss &&
 	    rdev->ops->get_station) {
 		struct station_info sinfo = {};
 		u8 *mac_addr;
 
-		mac_addr = wdev->current_bss->pub.bssid;
+		mac_addr = wdev->links[0].client.current_bss->pub.bssid;
 
 		err = rdev_get_station(rdev, dev, mac_addr, &sinfo);
 		if (err)
@@ -12284,7 +12417,7 @@ static int nl80211_join_mesh(struct sk_buff *skb, struct genl_info *info)
 		err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
 						    NL80211_ATTR_TX_RATES,
 						    &setup.beacon_rate,
-						    dev, false);
+						    dev, false, 0);
 		if (err)
 			return err;
 
@@ -13254,7 +13387,7 @@ static int nl80211_set_rekey_data(struct sk_buff *skb, struct genl_info *info)
 		rekey_data.akm = nla_get_u32(tb[NL80211_REKEY_DATA_AKM]);
 
 	wdev_lock(wdev);
-	if (!wdev->current_bss) {
+	if (!wdev->connected) {
 		err = -ENOTCONN;
 		goto out;
 	}
@@ -14523,7 +14656,7 @@ static int nl80211_add_tx_ts(struct sk_buff *skb, struct genl_info *info)
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
-		if (wdev->current_bss)
+		if (wdev->connected)
 			break;
 		err = -ENOTCONN;
 		goto out;
@@ -14696,13 +14829,13 @@ static int nl80211_set_pmk(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	wdev_lock(wdev);
-	if (!wdev->current_bss) {
+	if (!wdev->connected) {
 		ret = -ENOTCONN;
 		goto out;
 	}
 
 	pmk_conf.aa = nla_data(info->attrs[NL80211_ATTR_MAC]);
-	if (memcmp(pmk_conf.aa, wdev->current_bss->pub.bssid, ETH_ALEN)) {
+	if (memcmp(pmk_conf.aa, wdev->u.client.connected_addr, ETH_ALEN)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -14830,9 +14963,13 @@ static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 	case NL80211_IFTYPE_MESH_POINT:
 		break;
 	case NL80211_IFTYPE_ADHOC:
+		if (wdev->u.ibss.current_bss)
+			break;
+		err = -ENOTCONN;
+		goto out;
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
-		if (wdev->current_bss)
+		if (wdev->connected)
 			break;
 		err = -ENOTCONN;
 		goto out;
@@ -14868,12 +15005,14 @@ static int nl80211_get_ftm_responder_stats(struct sk_buff *skb,
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_ftm_responder_stats ftm_stats = {};
+	unsigned int link_id = nl80211_link_id(info->attrs);
 	struct sk_buff *msg;
 	void *hdr;
 	struct nlattr *ftm_stats_attr;
 	int err;
 
-	if (wdev->iftype != NL80211_IFTYPE_AP || !wdev->beacon_interval)
+	if (wdev->iftype != NL80211_IFTYPE_AP ||
+	    !wdev->links[link_id].ap.beacon_interval)
 		return -EOPNOTSUPP;
 
 	err = rdev_get_ftm_responder_stats(rdev, dev, &ftm_stats);
@@ -15003,7 +15142,8 @@ static int nl80211_probe_mesh_link(struct sk_buff *skb, struct genl_info *info)
 static int parse_tid_conf(struct cfg80211_registered_device *rdev,
 			  struct nlattr *attrs[], struct net_device *dev,
 			  struct cfg80211_tid_cfg *tid_conf,
-			  struct genl_info *info, const u8 *peer)
+			  struct genl_info *info, const u8 *peer,
+			  unsigned int link_id)
 {
 	struct netlink_ext_ack *extack = info->extack;
 	u64 mask;
@@ -15078,7 +15218,7 @@ static int parse_tid_conf(struct cfg80211_registered_device *rdev,
 			attr = NL80211_TID_CONFIG_ATTR_TX_RATE;
 			err = nl80211_parse_tx_bitrate_mask(info, attrs, attr,
 						    &tid_conf->txrate_mask, dev,
-						    true);
+						    true, link_id);
 			if (err)
 				return err;
 
@@ -15105,6 +15245,7 @@ static int nl80211_set_tid_config(struct sk_buff *skb,
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct nlattr *attrs[NL80211_TID_CONFIG_ATTR_MAX + 1];
+	unsigned int link_id = nl80211_link_id(info->attrs);
 	struct net_device *dev = info->user_ptr[1];
 	struct cfg80211_tid_config *tid_config;
 	struct nlattr *tid;
@@ -15142,7 +15283,7 @@ static int nl80211_set_tid_config(struct sk_buff *skb,
 
 		ret = parse_tid_conf(rdev, attrs, dev,
 				     &tid_config->tid_conf[conf_idx],
-				     info, tid_config->peer);
+				     info, tid_config->peer, link_id);
 		if (ret)
 			goto bad_tid_conf;
 
@@ -15281,6 +15422,49 @@ static int nl80211_set_fils_aad(struct sk_buff *skb,
 	return rdev_set_fils_aad(rdev, dev, &fils_aad);
 }
 
+static int nl80211_add_link(struct sk_buff *skb, struct genl_info *info)
+{
+	unsigned int link_id = nl80211_link_id(info->attrs);
+	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+
+	/* FIXME: validate at least a bit against driver capabilities */
+
+	switch (wdev->iftype) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_STATION:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!info->attrs[NL80211_ATTR_MAC] ||
+	    !is_valid_ether_addr(nla_data(info->attrs[NL80211_ATTR_MAC])))
+		return -EINVAL;
+
+	wdev->valid_links |= BIT(link_id);
+	ether_addr_copy(wdev->links[link_id].addr,
+			nla_data(info->attrs[NL80211_ATTR_MAC]));
+
+	return 0;
+}
+
+static int nl80211_remove_link(struct sk_buff *skb, struct genl_info *info)
+{
+	unsigned int link_id = nl80211_link_id(info->attrs);
+	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+
+	/* cannot remove if there's no link */
+	if (!info->attrs[NL80211_ATTR_MLO_LINK_ID])
+		return -EINVAL;
+
+	wdev->valid_links &= ~BIT(link_id);
+	eth_zero_addr(wdev->links[link_id].addr);
+
+	return 0;
+}
+
 #define NL80211_FLAG_NEED_WIPHY		0x01
 #define NL80211_FLAG_NEED_NETDEV	0x02
 #define NL80211_FLAG_NEED_RTNL		0x04
@@ -15293,6 +15477,8 @@ static int nl80211_set_fils_aad(struct sk_buff *skb,
 					 NL80211_FLAG_CHECK_NETDEV_UP)
 #define NL80211_FLAG_CLEAR_SKB		0x20
 #define NL80211_FLAG_NO_WIPHY_MTX	0x40
+#define NL80211_FLAG_MLO_VALID_LINK_ID	0x80
+#define NL80211_FLAG_MLO_UNSUPPORTED	0x100
 
 #define INTERNAL_FLAG_SELECTORS(__sel)			\
 	SELECTOR(__sel, NONE, 0) /* must be first */	\
@@ -15302,6 +15488,12 @@ static int nl80211_set_fils_aad(struct sk_buff *skb,
 		 NL80211_FLAG_NEED_WDEV)		\
 	SELECTOR(__sel, NETDEV,				\
 		 NL80211_FLAG_NEED_NETDEV)		\
+	SELECTOR(__sel, NETDEV_LINK,			\
+		 NL80211_FLAG_NEED_NETDEV |		\
+		 NL80211_FLAG_MLO_VALID_LINK_ID)	\
+	SELECTOR(__sel, NETDEV_NO_MLO,			\
+		 NL80211_FLAG_NEED_NETDEV |		\
+		 NL80211_FLAG_MLO_UNSUPPORTED)	\
 	SELECTOR(__sel, WIPHY_RTNL,			\
 		 NL80211_FLAG_NEED_WIPHY |		\
 		 NL80211_FLAG_NEED_RTNL)		\
@@ -15317,14 +15509,31 @@ static int nl80211_set_fils_aad(struct sk_buff *skb,
 		 NL80211_FLAG_NEED_RTNL)		\
 	SELECTOR(__sel, NETDEV_UP,			\
 		 NL80211_FLAG_NEED_NETDEV_UP)		\
+	SELECTOR(__sel, NETDEV_UP_LINK,			\
+		 NL80211_FLAG_NEED_NETDEV_UP |		\
+		 NL80211_FLAG_MLO_VALID_LINK_ID)	\
+	SELECTOR(__sel, NETDEV_UP_NO_MLO,		\
+		 NL80211_FLAG_NEED_NETDEV_UP |		\
+		 NL80211_FLAG_MLO_UNSUPPORTED)		\
+	SELECTOR(__sel, NETDEV_UP_NO_MLO_CLEAR,		\
+		 NL80211_FLAG_NEED_NETDEV_UP |		\
+		 NL80211_FLAG_CLEAR_SKB |		\
+		 NL80211_FLAG_MLO_UNSUPPORTED)		\
 	SELECTOR(__sel, NETDEV_UP_NOTMX,		\
 		 NL80211_FLAG_NEED_NETDEV_UP |		\
 		 NL80211_FLAG_NO_WIPHY_MTX)		\
+	SELECTOR(__sel, NETDEV_UP_NOTMX_NOMLO,		\
+		 NL80211_FLAG_NEED_NETDEV_UP |		\
+		 NL80211_FLAG_NO_WIPHY_MTX |		\
+		 NL80211_FLAG_MLO_UNSUPPORTED)		\
 	SELECTOR(__sel, NETDEV_UP_CLEAR,		\
 		 NL80211_FLAG_NEED_NETDEV_UP |		\
 		 NL80211_FLAG_CLEAR_SKB)		\
 	SELECTOR(__sel, WDEV_UP,			\
 		 NL80211_FLAG_NEED_WDEV_UP)		\
+	SELECTOR(__sel, WDEV_UP_LINK,			\
+		 NL80211_FLAG_NEED_WDEV_UP |		\
+		 NL80211_FLAG_MLO_VALID_LINK_ID)	\
 	SELECTOR(__sel, WDEV_UP_RTNL,			\
 		 NL80211_FLAG_NEED_WDEV_UP |		\
 		 NL80211_FLAG_NEED_RTNL)		\
@@ -15348,9 +15557,10 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 			    struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = NULL;
-	struct wireless_dev *wdev;
-	struct net_device *dev;
+	struct wireless_dev *wdev = NULL;
+	struct net_device *dev = NULL;
 	u32 internal_flags;
+	int err;
 
 	if (WARN_ON(ops->internal_flags >= ARRAY_SIZE(nl80211_internal_flags)))
 		return -EINVAL;
@@ -15361,8 +15571,8 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 	if (internal_flags & NL80211_FLAG_NEED_WIPHY) {
 		rdev = cfg80211_get_dev_from_info(genl_info_net(info), info);
 		if (IS_ERR(rdev)) {
-			rtnl_unlock();
-			return PTR_ERR(rdev);
+			err = PTR_ERR(rdev);
+			goto out_unlock;
 		}
 		info->user_ptr[0] = rdev;
 	} else if (internal_flags & NL80211_FLAG_NEED_NETDEV ||
@@ -15370,17 +15580,18 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 		wdev = __cfg80211_wdev_from_attrs(NULL, genl_info_net(info),
 						  info->attrs);
 		if (IS_ERR(wdev)) {
-			rtnl_unlock();
-			return PTR_ERR(wdev);
+			err = PTR_ERR(wdev);
+			goto out_unlock;
 		}
 
 		dev = wdev->netdev;
+		dev_hold(dev);
 		rdev = wiphy_to_rdev(wdev->wiphy);
 
 		if (internal_flags & NL80211_FLAG_NEED_NETDEV) {
 			if (!dev) {
-				rtnl_unlock();
-				return -EINVAL;
+				err = -EINVAL;
+				goto out_unlock;
 			}
 
 			info->user_ptr[1] = dev;
@@ -15390,14 +15601,44 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 
 		if (internal_flags & NL80211_FLAG_CHECK_NETDEV_UP &&
 		    !wdev_running(wdev)) {
-			rtnl_unlock();
-			return -ENETDOWN;
+			err = -ENETDOWN;
+			goto out_unlock;
 		}
 
-		dev_hold(dev);
 		info->user_ptr[0] = rdev;
 	}
 
+	if (internal_flags & NL80211_FLAG_MLO_VALID_LINK_ID) {
+		struct nlattr *link_id = info->attrs[NL80211_ATTR_MLO_LINK_ID];
+
+		if (!wdev) {
+			err = -EINVAL;
+			goto out_unlock;
+		}
+
+		/* MLO -> require valid link ID */
+		if (wdev->valid_links &&
+		    (!link_id ||
+		     !(wdev->valid_links & BIT(nla_get_u16(link_id))))) {
+			err = -EINVAL;
+			goto out_unlock;
+		}
+
+		/* non-MLO -> no link ID attribute accepted */
+		if (!wdev->valid_links && link_id) {
+			err = -EINVAL;
+			goto out_unlock;
+		}
+	}
+
+	if (internal_flags & NL80211_FLAG_MLO_UNSUPPORTED) {
+		if (info->attrs[NL80211_ATTR_MLO_LINK_ID])
+			return -EINVAL;
+
+		if (wdev->valid_links)
+			return -EINVAL;
+	}
+
 	if (rdev && !(internal_flags & NL80211_FLAG_NO_WIPHY_MTX)) {
 		wiphy_lock(&rdev->wiphy);
 		/* we keep the mutex locked until post_doit */
@@ -15407,6 +15648,10 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 		rtnl_unlock();
 
 	return 0;
+out_unlock:
+	rtnl_unlock();
+	dev_put(dev);
+	return err;
 }
 
 static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
@@ -15622,6 +15867,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_key,
 		.flags = GENL_UNS_ADMIN_PERM,
+		/* cannot use NL80211_FLAG_MLO_VALID_LINK_ID, depends on key */
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
 					 NL80211_FLAG_CLEAR_SKB),
 	},
@@ -15645,21 +15891,24 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.doit = nl80211_set_beacon,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_MLO_VALID_LINK_ID),
 	},
 	{
 		.cmd = NL80211_CMD_START_AP,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.doit = nl80211_start_ap,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_MLO_VALID_LINK_ID),
 	},
 	{
 		.cmd = NL80211_CMD_STOP_AP,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.doit = nl80211_stop_ap,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_MLO_VALID_LINK_ID),
 	},
 	{
 		.cmd = NL80211_CMD_GET_STATION,
@@ -15925,7 +16174,9 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_remain_on_channel,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
+		/* FIXME: requiring a link ID here is probably not good */
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP |
+					 NL80211_FLAG_MLO_VALID_LINK_ID),
 	},
 	{
 		.cmd = NL80211_CMD_CANCEL_REMAIN_ON_CHANNEL,
@@ -15939,7 +16190,8 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_tx_bitrate_mask,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV |
+					 NL80211_FLAG_MLO_VALID_LINK_ID),
 	},
 	{
 		.cmd = NL80211_CMD_REGISTER_FRAME,
@@ -15988,7 +16240,8 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_channel,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV |
+					 NL80211_FLAG_MLO_VALID_LINK_ID),
 	},
 	{
 		.cmd = NL80211_CMD_JOIN_MESH,
@@ -16149,7 +16402,8 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_mac_acl,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV |
+					 NL80211_FLAG_MLO_UNSUPPORTED),
 	},
 	{
 		.cmd = NL80211_CMD_RADAR_DETECT,
@@ -16157,7 +16411,8 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_start_radar_detection,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
-					 NL80211_FLAG_NO_WIPHY_MTX),
+					 NL80211_FLAG_NO_WIPHY_MTX |
+					 NL80211_FLAG_MLO_UNSUPPORTED),
 	},
 	{
 		.cmd = NL80211_CMD_GET_PROTOCOL_FEATURES,
@@ -16203,7 +16458,8 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_channel_switch,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_MLO_VALID_LINK_ID),
 	},
 	{
 		.cmd = NL80211_CMD_VENDOR,
@@ -16226,7 +16482,8 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_add_tx_ts,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_MLO_UNSUPPORTED),
 	},
 	{
 		.cmd = NL80211_CMD_DEL_TX_TS,
@@ -16287,7 +16544,8 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.cmd = NL80211_CMD_GET_FTM_RESPONDER_STATS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_get_ftm_responder_stats,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV |
+					 NL80211_FLAG_MLO_VALID_LINK_ID),
 	},
 	{
 		.cmd = NL80211_CMD_PEER_MEASUREMENT_START,
@@ -16319,7 +16577,8 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.cmd = NL80211_CMD_SET_TID_CONFIG,
 		.doit = nl80211_set_tid_config,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV |
+					 NL80211_FLAG_MLO_VALID_LINK_ID),
 	},
 	{
 		.cmd = NL80211_CMD_SET_SAR_SPECS,
@@ -16343,6 +16602,19 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
+	{
+		.cmd = NL80211_CMD_ADD_LINK,
+		.doit = nl80211_add_link,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
+	},
+	{
+		.cmd = NL80211_CMD_REMOVE_LINK,
+		.doit = nl80211_remove_link,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+					 NL80211_FLAG_MLO_VALID_LINK_ID),
+	},
 };
 
 static struct genl_family nl80211_fam __ro_after_init = {
@@ -17970,23 +18242,37 @@ static void nl80211_ch_switch_notify(struct cfg80211_registered_device *rdev,
 }
 
 void cfg80211_ch_switch_notify(struct net_device *dev,
-			       struct cfg80211_chan_def *chandef)
+			       struct cfg80211_chan_def *chandef,
+			       unsigned int link_id)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
 	ASSERT_WDEV_LOCK(wdev);
+	WARN_INVALID_LINK_ID(wdev, link_id);
 
-	trace_cfg80211_ch_switch_notify(dev, chandef);
+	trace_cfg80211_ch_switch_notify(dev, chandef, link_id);
 
-	wdev->chandef = *chandef;
-	wdev->preset_chandef = *chandef;
-
-	if ((wdev->iftype == NL80211_IFTYPE_STATION ||
-	     wdev->iftype == NL80211_IFTYPE_P2P_CLIENT) &&
-	    !WARN_ON(!wdev->current_bss))
-		cfg80211_update_assoc_bss_entry(wdev, chandef->chan);
+	switch (wdev->iftype) {
+	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_P2P_CLIENT:
+		if (!WARN_ON(!wdev->links[link_id].client.current_bss))
+			cfg80211_update_assoc_bss_entry(wdev, link_id,
+							chandef->chan);
+		break;
+	case NL80211_IFTYPE_MESH_POINT:
+		wdev->u.mesh.chandef = *chandef;
+		wdev->u.mesh.preset_chandef = *chandef;
+		break;
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+		wdev->links[link_id].ap.chandef = *chandef;
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
 
 	cfg80211_sched_dfs_chan_update(rdev);
 
diff --git a/net/wireless/ocb.c b/net/wireless/ocb.c
index 2d26a6d980bf..27a1732264f9 100644
--- a/net/wireless/ocb.c
+++ b/net/wireless/ocb.c
@@ -4,6 +4,7 @@
  *
  * Copyright: (c) 2014 Czech Technical University in Prague
  *            (c) 2014 Volkswagen Group Research
+ * Copyright (C) 2022 Intel Corporation
  * Author:    Rostislav Lisovy <rostislav.lisovy@fel.cvut.cz>
  * Funded by: Volkswagen Group Research
  */
@@ -34,7 +35,7 @@ int __cfg80211_join_ocb(struct cfg80211_registered_device *rdev,
 
 	err = rdev_join_ocb(rdev, dev, setup);
 	if (!err)
-		wdev->chandef = setup->chandef;
+		wdev->u.ocb.chandef = setup->chandef;
 
 	return err;
 }
@@ -69,7 +70,7 @@ int __cfg80211_leave_ocb(struct cfg80211_registered_device *rdev,
 
 	err = rdev_leave_ocb(rdev, dev);
 	if (!err)
-		memset(&wdev->chandef, 0, sizeof(wdev->chandef));
+		memset(&wdev->u.ocb.chandef, 0, sizeof(wdev->u.ocb.chandef));
 
 	return err;
 }
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 439bcf52369c..d2300eff03ae 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1,4 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Portions of this file
+ * Copyright(c) 2016-2017 Intel Deutschland GmbH
+ * Copyright (C) 2018, 2021-2022 Intel Corporation
+ */
 #ifndef __CFG80211_RDEV_OPS
 #define __CFG80211_RDEV_OPS
 
@@ -172,11 +177,11 @@ static inline int rdev_change_beacon(struct cfg80211_registered_device *rdev,
 }
 
 static inline int rdev_stop_ap(struct cfg80211_registered_device *rdev,
-			       struct net_device *dev)
+			       struct net_device *dev, unsigned int link_id)
 {
 	int ret;
-	trace_rdev_stop_ap(&rdev->wiphy, dev);
-	ret = rdev->ops->stop_ap(&rdev->wiphy, dev);
+	trace_rdev_stop_ap(&rdev->wiphy, dev, link_id);
+	ret = rdev->ops->stop_ap(&rdev->wiphy, dev, link_id);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
@@ -651,12 +656,14 @@ static inline int rdev_testmode_dump(struct cfg80211_registered_device *rdev,
 
 static inline int
 rdev_set_bitrate_mask(struct cfg80211_registered_device *rdev,
-		      struct net_device *dev, const u8 *peer,
+		      struct net_device *dev, unsigned int link_id,
+		      const u8 *peer,
 		      const struct cfg80211_bitrate_mask *mask)
 {
 	int ret;
-	trace_rdev_set_bitrate_mask(&rdev->wiphy, dev, peer, mask);
-	ret = rdev->ops->set_bitrate_mask(&rdev->wiphy, dev, peer, mask);
+	trace_rdev_set_bitrate_mask(&rdev->wiphy, dev, link_id, peer, mask);
+	ret = rdev->ops->set_bitrate_mask(&rdev->wiphy, dev, link_id,
+					  peer, mask);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
@@ -944,12 +951,13 @@ static inline int rdev_set_noack_map(struct cfg80211_registered_device *rdev,
 static inline int
 rdev_get_channel(struct cfg80211_registered_device *rdev,
 		 struct wireless_dev *wdev,
+		 unsigned int link_id,
 		 struct cfg80211_chan_def *chandef)
 {
 	int ret;
 
-	trace_rdev_get_channel(&rdev->wiphy, wdev);
-	ret = rdev->ops->get_channel(&rdev->wiphy, wdev, chandef);
+	trace_rdev_get_channel(&rdev->wiphy, wdev, link_id);
+	ret = rdev->ops->get_channel(&rdev->wiphy, wdev, link_id, chandef);
 	trace_rdev_return_chandef(&rdev->wiphy, ret, chandef);
 
 	return ret;
@@ -1107,12 +1115,14 @@ static inline int rdev_set_qos_map(struct cfg80211_registered_device *rdev,
 
 static inline int
 rdev_set_ap_chanwidth(struct cfg80211_registered_device *rdev,
-		      struct net_device *dev, struct cfg80211_chan_def *chandef)
+		      struct net_device *dev,
+		      unsigned int link_id,
+		      struct cfg80211_chan_def *chandef)
 {
 	int ret;
 
-	trace_rdev_set_ap_chanwidth(&rdev->wiphy, dev, chandef);
-	ret = rdev->ops->set_ap_chanwidth(&rdev->wiphy, dev, chandef);
+	trace_rdev_set_ap_chanwidth(&rdev->wiphy, dev, link_id, chandef);
+	ret = rdev->ops->set_ap_chanwidth(&rdev->wiphy, dev, link_id, chandef);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 
 	return ret;
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 58e83ce642ad..c7383ede794f 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -5,7 +5,7 @@
  * Copyright 2008-2011	Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright      2017  Intel Deutschland GmbH
- * Copyright (C) 2018 - 2021 Intel Corporation
+ * Copyright (C) 2018 - 2022 Intel Corporation
  *
  * Permission to use, copy, modify, and/or distribute this software for any
  * purpose with or without fee is hereby granted, provided that the above
@@ -2370,6 +2370,7 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	enum nl80211_iftype iftype;
 	bool ret;
+	int link;
 
 	wdev_lock(wdev);
 	iftype = wdev->iftype;
@@ -2378,62 +2379,83 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 	if (!wdev->netdev || !netif_running(wdev->netdev))
 		goto wdev_inactive_unlock;
 
-	switch (iftype) {
-	case NL80211_IFTYPE_AP:
-	case NL80211_IFTYPE_P2P_GO:
-	case NL80211_IFTYPE_MESH_POINT:
-		if (!wdev->beacon_interval)
-			goto wdev_inactive_unlock;
-		chandef = wdev->chandef;
-		break;
-	case NL80211_IFTYPE_ADHOC:
-		if (!wdev->ssid_len)
-			goto wdev_inactive_unlock;
-		chandef = wdev->chandef;
-		break;
-	case NL80211_IFTYPE_STATION:
-	case NL80211_IFTYPE_P2P_CLIENT:
-		if (!wdev->current_bss ||
-		    !wdev->current_bss->pub.channel)
-			goto wdev_inactive_unlock;
-
-		if (!rdev->ops->get_channel ||
-		    rdev_get_channel(rdev, wdev, &chandef))
-			cfg80211_chandef_create(&chandef,
-						wdev->current_bss->pub.channel,
-						NL80211_CHAN_NO_HT);
-		break;
-	case NL80211_IFTYPE_MONITOR:
-	case NL80211_IFTYPE_AP_VLAN:
-	case NL80211_IFTYPE_P2P_DEVICE:
-		/* no enforcement required */
-		break;
-	default:
-		/* others not implemented for now */
-		WARN_ON(1);
-		break;
-	}
+	for (link = 0; link < ARRAY_SIZE(wdev->links); link++) {
+		struct ieee80211_channel *chan;
 
-	wdev_unlock(wdev);
+		if (!wdev->valid_links && link > 0)
+			break;
+		if (!(wdev->valid_links & BIT(link)))
+			continue;
+		switch (iftype) {
+		case NL80211_IFTYPE_AP:
+		case NL80211_IFTYPE_P2P_GO:
+		case NL80211_IFTYPE_MESH_POINT:
+			if (!wdev->u.mesh.beacon_interval)
+				continue;
+			chandef = wdev->u.mesh.chandef;
+			break;
+		case NL80211_IFTYPE_ADHOC:
+			if (!wdev->u.ibss.ssid_len)
+				continue;
+			chandef = wdev->u.ibss.chandef;
+			break;
+		case NL80211_IFTYPE_STATION:
+		case NL80211_IFTYPE_P2P_CLIENT:
+			/* Maybe we could consider disabling that link only? */
+			if (!wdev->links[link].client.current_bss)
+				continue;
 
-	switch (iftype) {
-	case NL80211_IFTYPE_AP:
-	case NL80211_IFTYPE_P2P_GO:
-	case NL80211_IFTYPE_ADHOC:
-	case NL80211_IFTYPE_MESH_POINT:
-		wiphy_lock(wiphy);
-		ret = cfg80211_reg_can_beacon_relax(wiphy, &chandef, iftype);
-		wiphy_unlock(wiphy);
+			chan = wdev->links[link].client.current_bss->pub.channel;
+			if (!chan)
+				continue;
 
-		return ret;
-	case NL80211_IFTYPE_STATION:
-	case NL80211_IFTYPE_P2P_CLIENT:
-		return cfg80211_chandef_usable(wiphy, &chandef,
-					       IEEE80211_CHAN_DISABLED);
-	default:
-		break;
+			if (!rdev->ops->get_channel ||
+			    rdev_get_channel(rdev, wdev, link, &chandef))
+				cfg80211_chandef_create(&chandef, chan,
+							NL80211_CHAN_NO_HT);
+			break;
+		case NL80211_IFTYPE_MONITOR:
+		case NL80211_IFTYPE_AP_VLAN:
+		case NL80211_IFTYPE_P2P_DEVICE:
+			/* no enforcement required */
+			break;
+		default:
+			/* others not implemented for now */
+			WARN_ON(1);
+			break;
+		}
+
+		wdev_unlock(wdev);
+
+		switch (iftype) {
+		case NL80211_IFTYPE_AP:
+		case NL80211_IFTYPE_P2P_GO:
+		case NL80211_IFTYPE_ADHOC:
+		case NL80211_IFTYPE_MESH_POINT:
+			wiphy_lock(wiphy);
+			ret = cfg80211_reg_can_beacon_relax(wiphy, &chandef,
+							    iftype);
+			wiphy_unlock(wiphy);
+
+			if (!ret)
+				return ret;
+			break;
+		case NL80211_IFTYPE_STATION:
+		case NL80211_IFTYPE_P2P_CLIENT:
+			ret = cfg80211_chandef_usable(wiphy, &chandef,
+						      IEEE80211_CHAN_DISABLED);
+			if (!ret)
+				return ret;
+			break;
+		default:
+			break;
+		}
+
+		wdev_lock(wdev);
 	}
 
+	wdev_unlock(wdev);
+
 	return true;
 
 wdev_inactive_unlock:
@@ -4215,8 +4237,17 @@ static void cfg80211_check_and_end_cac(struct cfg80211_registered_device *rdev)
 	 * In both cases we should end the CAC on the wdev.
 	 */
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
-		if (wdev->cac_started &&
-		    !cfg80211_chandef_dfs_usable(&rdev->wiphy, &wdev->chandef))
+		struct cfg80211_chan_def *chandef;
+
+		if (!wdev->cac_started)
+			continue;
+
+		/* FIXME: radar detection is tied to link 0 for now */
+		chandef = wdev_chandef(wdev, 0);
+		if (!chandef)
+			continue;
+
+		if (!cfg80211_chandef_dfs_usable(&rdev->wiphy, chandef))
 			rdev_end_cac(rdev, wdev->netdev);
 	}
 }
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 4a6d86432910..b9678801d848 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -5,7 +5,7 @@
  * Copyright 2008 Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2016	Intel Deutschland GmbH
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -2617,7 +2617,8 @@ void cfg80211_bss_iter(struct wiphy *wiphy,
 	spin_lock_bh(&rdev->bss_lock);
 
 	list_for_each_entry(bss, &rdev->bss_list, list) {
-		if (!chandef || cfg80211_is_sub_chan(chandef, bss->pub.channel))
+		if (!chandef || cfg80211_is_sub_chan(chandef, bss->pub.channel,
+						     false))
 			iter(wiphy, &bss->pub, iter_data);
 	}
 
@@ -2626,11 +2627,12 @@ void cfg80211_bss_iter(struct wiphy *wiphy,
 EXPORT_SYMBOL(cfg80211_bss_iter);
 
 void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
+				     unsigned int link_id,
 				     struct ieee80211_channel *chan)
 {
 	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
-	struct cfg80211_internal_bss *cbss = wdev->current_bss;
+	struct cfg80211_internal_bss *cbss = wdev->links[link_id].client.current_bss;
 	struct cfg80211_internal_bss *new = NULL;
 	struct cfg80211_internal_bss *bss;
 	struct cfg80211_bss *nontrans_bss;
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index ff4d48fcbfb2..35602201057b 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -5,7 +5,7 @@
  * (for nl80211's connect() and wext)
  *
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2009, 2020 Intel Corporation. All rights reserved.
+ * Copyright (C) 2009, 2020, 2022 Intel Corporation. All rights reserved.
  * Copyright 2017	Intel Deutschland GmbH
  */
 
@@ -454,6 +454,20 @@ void cfg80211_sme_abandon_assoc(struct wireless_dev *wdev)
 	schedule_work(&rdev->conn_work);
 }
 
+static void cfg80211_wdev_release_bsses(struct wireless_dev *wdev)
+{
+	unsigned int link;
+
+	for_each_valid_link(wdev, link) {
+		if (!wdev->links[link].client.current_bss)
+			continue;
+		cfg80211_unhold_bss(wdev->links[link].client.current_bss);
+		cfg80211_put_bss(wdev->wiphy,
+				 &wdev->links[link].client.current_bss->pub);
+		wdev->links[link].client.current_bss = NULL;
+	}
+}
+
 static int cfg80211_sme_get_conn_ies(struct wireless_dev *wdev,
 				     const u8 *ies, size_t ies_len,
 				     const u8 **out_ies, size_t *out_ies_len)
@@ -521,12 +535,11 @@ static int cfg80211_sme_connect(struct wireless_dev *wdev,
 	if (!rdev->ops->auth || !rdev->ops->assoc)
 		return -EOPNOTSUPP;
 
-	if (wdev->current_bss) {
-		cfg80211_unhold_bss(wdev->current_bss);
-		cfg80211_put_bss(wdev->wiphy, &wdev->current_bss->pub);
-		wdev->current_bss = NULL;
+	cfg80211_wdev_release_bsses(wdev);
 
+	if (wdev->connected) {
 		cfg80211_sme_free(wdev);
+		wdev->connected = false;
 	}
 
 	if (wdev->conn)
@@ -563,8 +576,8 @@ static int cfg80211_sme_connect(struct wireless_dev *wdev,
 		wdev->conn->auto_auth = false;
 	}
 
-	wdev->conn->params.ssid = wdev->ssid;
-	wdev->conn->params.ssid_len = wdev->ssid_len;
+	wdev->conn->params.ssid = wdev->u.client.ssid;
+	wdev->conn->params.ssid_len = wdev->u.client.ssid_len;
 
 	/* see if we have the bss already */
 	bss = cfg80211_get_conn_bss(wdev);
@@ -648,7 +661,7 @@ static bool cfg80211_is_all_idle(void)
 	list_for_each_entry(rdev, &cfg80211_rdev_list, list) {
 		list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 			wdev_lock(wdev);
-			if (wdev->conn || wdev->current_bss ||
+			if (wdev->conn || wdev->connected ||
 			    cfg80211_beaconing_iface_active(wdev))
 				is_all_idle = false;
 			wdev_unlock(wdev);
@@ -668,7 +681,6 @@ static void disconnect_work(struct work_struct *work)
 
 DECLARE_WORK(cfg80211_disconnect_work, disconnect_work);
 
-
 /*
  * API calls for drivers implementing connect/disconnect and
  * SME event handling
@@ -729,23 +741,19 @@ void __cfg80211_connect_result(struct net_device *dev,
 	if (!cr->bss && (cr->status == WLAN_STATUS_SUCCESS)) {
 		WARN_ON_ONCE(!wiphy_to_rdev(wdev->wiphy)->ops->connect);
 		cr->bss = cfg80211_get_bss(wdev->wiphy, NULL, cr->bssid,
-					   wdev->ssid, wdev->ssid_len,
+					   wdev->u.client.ssid, wdev->u.client.ssid_len,
 					   wdev->conn_bss_type,
 					   IEEE80211_PRIVACY_ANY);
 		if (cr->bss)
 			cfg80211_hold_bss(bss_from_pub(cr->bss));
 	}
 
-	if (wdev->current_bss) {
-		cfg80211_unhold_bss(wdev->current_bss);
-		cfg80211_put_bss(wdev->wiphy, &wdev->current_bss->pub);
-		wdev->current_bss = NULL;
-	}
+	cfg80211_wdev_release_bsses(wdev);
 
 	if (cr->status != WLAN_STATUS_SUCCESS) {
 		kfree_sensitive(wdev->connect_keys);
 		wdev->connect_keys = NULL;
-		wdev->ssid_len = 0;
+		wdev->u.client.ssid_len = 0;
 		wdev->conn_owner_nlportid = 0;
 		if (cr->bss) {
 			cfg80211_unhold_bss(bss_from_pub(cr->bss));
@@ -758,7 +766,9 @@ void __cfg80211_connect_result(struct net_device *dev,
 	if (WARN_ON(!cr->bss))
 		return;
 
-	wdev->current_bss = bss_from_pub(cr->bss);
+	wdev->links[0].client.current_bss = bss_from_pub(cr->bss);
+	wdev->connected = true;
+	ether_addr_copy(wdev->u.client.connected_addr, cr->bss->bssid);
 
 	if (!(wdev->wiphy->flags & WIPHY_FLAG_HAS_STATIC_WEP))
 		cfg80211_upload_connect_keys(wdev);
@@ -801,7 +811,7 @@ void cfg80211_connect_done(struct net_device *dev,
 
 			found = cfg80211_get_bss(wdev->wiphy, NULL,
 						 params->bss->bssid,
-						 wdev->ssid, wdev->ssid_len,
+						 wdev->u.client.ssid, wdev->u.client.ssid_len,
 						 wdev->conn_bss_type,
 						 IEEE80211_PRIVACY_ANY);
 			if (found) {
@@ -906,18 +916,17 @@ void __cfg80211_roamed(struct wireless_dev *wdev,
 		    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT))
 		goto out;
 
-	if (WARN_ON(!wdev->current_bss))
+	if (WARN_ON(!wdev->connected))
 		goto out;
 
-	cfg80211_unhold_bss(wdev->current_bss);
-	cfg80211_put_bss(wdev->wiphy, &wdev->current_bss->pub);
-	wdev->current_bss = NULL;
+	cfg80211_wdev_release_bsses(wdev);
 
 	if (WARN_ON(!info->bss))
 		return;
 
 	cfg80211_hold_bss(bss_from_pub(info->bss));
-	wdev->current_bss = bss_from_pub(info->bss);
+	wdev->links[0].client.current_bss = bss_from_pub(info->bss);
+	ether_addr_copy(wdev->u.client.connected_addr, info->bss->bssid);
 
 	wdev->unprot_beacon_reported = 0;
 	nl80211_send_roamed(wiphy_to_rdev(wdev->wiphy),
@@ -963,8 +972,8 @@ void cfg80211_roamed(struct net_device *dev, struct cfg80211_roam_info *info,
 
 	if (!info->bss) {
 		info->bss = cfg80211_get_bss(wdev->wiphy, info->channel,
-					     info->bssid, wdev->ssid,
-					     wdev->ssid_len,
+					     info->bssid, wdev->u.client.ssid,
+					     wdev->u.client.ssid_len,
 					     wdev->conn_bss_type,
 					     IEEE80211_PRIVACY_ANY);
 	}
@@ -1034,8 +1043,8 @@ void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid)
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_STATION))
 		return;
 
-	if (WARN_ON(!wdev->current_bss) ||
-	    WARN_ON(!ether_addr_equal(wdev->current_bss->pub.bssid, bssid)))
+	if (WARN_ON(!wdev->connected) ||
+	    WARN_ON(!ether_addr_equal(wdev->u.client.connected_addr, bssid)))
 		return;
 
 	nl80211_send_port_authorized(wiphy_to_rdev(wdev->wiphy), wdev->netdev,
@@ -1087,13 +1096,9 @@ void __cfg80211_disconnected(struct net_device *dev, const u8 *ie,
 		    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT))
 		return;
 
-	if (wdev->current_bss) {
-		cfg80211_unhold_bss(wdev->current_bss);
-		cfg80211_put_bss(wdev->wiphy, &wdev->current_bss->pub);
-	}
-
-	wdev->current_bss = NULL;
-	wdev->ssid_len = 0;
+	cfg80211_wdev_release_bsses(wdev);
+	wdev->connected = false;
+	wdev->u.client.ssid_len = 0;
 	wdev->conn_owner_nlportid = 0;
 	kfree_sensitive(wdev->connect_keys);
 	wdev->connect_keys = NULL;
@@ -1182,19 +1187,20 @@ int cfg80211_connect(struct cfg80211_registered_device *rdev,
 	 * already connected, so reject a new SSID unless it's the
 	 * same (which is the case for re-association.)
 	 */
-	if (wdev->ssid_len &&
-	    (wdev->ssid_len != connect->ssid_len ||
-	     memcmp(wdev->ssid, connect->ssid, wdev->ssid_len)))
+	if (wdev->u.client.ssid_len &&
+	    (wdev->u.client.ssid_len != connect->ssid_len ||
+	     memcmp(wdev->u.client.ssid, connect->ssid, wdev->u.client.ssid_len)))
 		return -EALREADY;
 
 	/*
 	 * If connected, reject (re-)association unless prev_bssid
 	 * matches the current BSSID.
 	 */
-	if (wdev->current_bss) {
+	if (wdev->connected) {
 		if (!prev_bssid)
 			return -EALREADY;
-		if (!ether_addr_equal(prev_bssid, wdev->current_bss->pub.bssid))
+		if (!ether_addr_equal(prev_bssid,
+				      wdev->u.client.connected_addr))
 			return -ENOTCONN;
 	}
 
@@ -1245,8 +1251,8 @@ int cfg80211_connect(struct cfg80211_registered_device *rdev,
 	}
 
 	wdev->connect_keys = connkeys;
-	memcpy(wdev->ssid, connect->ssid, connect->ssid_len);
-	wdev->ssid_len = connect->ssid_len;
+	memcpy(wdev->u.client.ssid, connect->ssid, connect->ssid_len);
+	wdev->u.client.ssid_len = connect->ssid_len;
 
 	wdev->conn_bss_type = connect->pbss ? IEEE80211_BSS_TYPE_PBSS :
 					      IEEE80211_BSS_TYPE_ESS;
@@ -1262,8 +1268,8 @@ int cfg80211_connect(struct cfg80211_registered_device *rdev,
 		 * This could be reassoc getting refused, don't clear
 		 * ssid_len in that case.
 		 */
-		if (!wdev->current_bss)
-			wdev->ssid_len = 0;
+		if (!wdev->connected)
+			wdev->u.client.ssid_len = 0;
 		return err;
 	}
 
@@ -1287,7 +1293,7 @@ int cfg80211_disconnect(struct cfg80211_registered_device *rdev,
 		err = cfg80211_sme_disconnect(wdev, reason);
 	else if (!rdev->ops->disconnect)
 		cfg80211_mlme_down(rdev, dev);
-	else if (wdev->ssid_len)
+	else if (wdev->u.client.ssid_len)
 		err = rdev_disconnect(rdev, dev, reason);
 
 	/*
@@ -1295,8 +1301,8 @@ int cfg80211_disconnect(struct cfg80211_registered_device *rdev,
 	 * in which case cfg80211_disconnected() will take care of
 	 * this later.
 	 */
-	if (!wdev->current_bss)
-		wdev->ssid_len = 0;
+	if (!wdev->connected)
+		wdev->u.client.ssid_len = 0;
 
 	return err;
 }
@@ -1320,7 +1326,7 @@ void cfg80211_autodisconnect_wk(struct work_struct *work)
 			break;
 		case NL80211_IFTYPE_AP:
 		case NL80211_IFTYPE_P2P_GO:
-			__cfg80211_stop_ap(rdev, wdev->netdev, false);
+			__cfg80211_stop_ap(rdev, wdev->netdev, -1, false);
 			break;
 		case NL80211_IFTYPE_MESH_POINT:
 			__cfg80211_leave_mesh(rdev, wdev->netdev);
@@ -1332,7 +1338,7 @@ void cfg80211_autodisconnect_wk(struct work_struct *work)
 			 * ops->disconnect not implemented.  Otherwise we can
 			 * use cfg80211_disconnect.
 			 */
-			if (rdev->ops->disconnect || wdev->current_bss)
+			if (rdev->ops->disconnect || wdev->connected)
 				cfg80211_disconnect(rdev, wdev->netdev,
 						    WLAN_REASON_DEAUTH_LEAVING,
 						    true);
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 228079d7690a..3b2c956b8d78 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -569,6 +569,7 @@ TRACE_EVENT(rdev_start_ap,
 		__field(bool, privacy)
 		__field(enum nl80211_auth_type, auth_type)
 		__field(int, inactivity_timeout)
+		__field(unsigned int, link_id)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
@@ -583,16 +584,17 @@ TRACE_EVENT(rdev_start_ap,
 		__entry->inactivity_timeout = settings->inactivity_timeout;
 		memset(__entry->ssid, 0, IEEE80211_MAX_SSID_LEN + 1);
 		memcpy(__entry->ssid, settings->ssid, settings->ssid_len);
+		__entry->link_id = settings->beacon.link_id;
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", AP settings - ssid: %s, "
 		  CHAN_DEF_PR_FMT ", beacon interval: %d, dtim period: %d, "
 		  "hidden ssid: %d, wpa versions: %u, privacy: %s, "
-		  "auth type: %d, inactivity timeout: %d",
+		  "auth type: %d, inactivity timeout: %d, link_id: %d",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->ssid, CHAN_DEF_PR_ARG,
 		  __entry->beacon_interval, __entry->dtim_period,
 		  __entry->hidden_ssid, __entry->wpa_ver,
 		  BOOL_TO_STR(__entry->privacy), __entry->auth_type,
-		  __entry->inactivity_timeout)
+		  __entry->inactivity_timeout, __entry->link_id)
 );
 
 TRACE_EVENT(rdev_change_beacon,
@@ -602,6 +604,7 @@ TRACE_EVENT(rdev_change_beacon,
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
+		__field(int, link_id)
 		__dynamic_array(u8, head, info ? info->head_len : 0)
 		__dynamic_array(u8, tail, info ? info->tail_len : 0)
 		__dynamic_array(u8, beacon_ies, info ? info->beacon_ies_len : 0)
@@ -615,6 +618,7 @@ TRACE_EVENT(rdev_change_beacon,
 		WIPHY_ASSIGN;
 		NETDEV_ASSIGN;
 		if (info) {
+			__entry->link_id = info->link_id;
 			if (info->head)
 				memcpy(__get_dynamic_array(head), info->head,
 				       info->head_len);
@@ -635,9 +639,30 @@ TRACE_EVENT(rdev_change_beacon,
 			if (info->probe_resp)
 				memcpy(__get_dynamic_array(probe_resp),
 				       info->probe_resp, info->probe_resp_len);
+		} else {
+			__entry->link_id = -1;
 		}
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT, WIPHY_PR_ARG, NETDEV_PR_ARG)
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id:%d",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->link_id)
+);
+
+TRACE_EVENT(rdev_stop_ap,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 unsigned int link_id),
+	TP_ARGS(wiphy, netdev, link_id),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		NETDEV_ENTRY
+		__field(unsigned int, link_id)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
+		__entry->link_id = link_id;
+	),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %d",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->link_id)
 );
 
 DECLARE_EVENT_CLASS(wiphy_netdev_evt,
@@ -654,11 +679,6 @@ DECLARE_EVENT_CLASS(wiphy_netdev_evt,
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT, WIPHY_PR_ARG, NETDEV_PR_ARG)
 );
 
-DEFINE_EVENT(wiphy_netdev_evt, rdev_stop_ap,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev),
-	TP_ARGS(wiphy, netdev)
-);
-
 DEFINE_EVENT(wiphy_netdev_evt, rdev_set_rekey_data,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev),
 	TP_ARGS(wiphy, netdev)
@@ -1619,20 +1639,24 @@ TRACE_EVENT(rdev_testmode_dump,
 
 TRACE_EVENT(rdev_set_bitrate_mask,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 unsigned int link_id,
 		 const u8 *peer, const struct cfg80211_bitrate_mask *mask),
-	TP_ARGS(wiphy, netdev, peer, mask),
+	TP_ARGS(wiphy, netdev, link_id, peer, mask),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
+		__field(unsigned int, link_id)
 		MAC_ENTRY(peer)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		NETDEV_ASSIGN;
+		__entry->link_id = link_id;
 		MAC_ASSIGN(peer, peer);
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", peer: " MAC_PR_FMT,
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer))
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %d, peer: " MAC_PR_FMT,
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->link_id,
+		  MAC_PR_ARG(peer))
 );
 
 TRACE_EVENT(rdev_update_mgmt_frame_registrations,
@@ -2040,9 +2064,22 @@ TRACE_EVENT(rdev_set_noack_map,
 		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->noack_map)
 );
 
-DEFINE_EVENT(wiphy_wdev_evt, rdev_get_channel,
-	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev),
-	TP_ARGS(wiphy, wdev)
+TRACE_EVENT(rdev_get_channel,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
+		 unsigned int link_id),
+	TP_ARGS(wiphy, wdev, link_id),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		WDEV_ENTRY
+		__field(unsigned int, link_id)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		WDEV_ASSIGN;
+		__entry->link_id = link_id;
+	),
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", link_id: %u",
+		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->link_id)
 );
 
 TRACE_EVENT(rdev_return_chandef,
@@ -2296,20 +2333,24 @@ TRACE_EVENT(rdev_set_qos_map,
 
 TRACE_EVENT(rdev_set_ap_chanwidth,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 unsigned int link_id,
 		 struct cfg80211_chan_def *chandef),
-	TP_ARGS(wiphy, netdev, chandef),
+	TP_ARGS(wiphy, netdev, link_id, chandef),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
 		CHAN_DEF_ENTRY
+		__field(unsigned int, link_id)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		NETDEV_ASSIGN;
 		CHAN_DEF_ASSIGN(chandef);
+		__entry->link_id = link_id;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " CHAN_DEF_PR_FMT,
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, CHAN_DEF_PR_ARG)
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " CHAN_DEF_PR_FMT ", link:%d",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, CHAN_DEF_PR_ARG,
+		  __entry->link_id)
 );
 
 TRACE_EVENT(rdev_add_tx_ts,
@@ -3022,18 +3063,21 @@ TRACE_EVENT(cfg80211_chandef_dfs_required,
 
 TRACE_EVENT(cfg80211_ch_switch_notify,
 	TP_PROTO(struct net_device *netdev,
-		 struct cfg80211_chan_def *chandef),
-	TP_ARGS(netdev, chandef),
+		 struct cfg80211_chan_def *chandef,
+		 unsigned int link_id),
+	TP_ARGS(netdev, chandef, link_id),
 	TP_STRUCT__entry(
 		NETDEV_ENTRY
 		CHAN_DEF_ENTRY
+		__field(unsigned int, link_id)
 	),
 	TP_fast_assign(
 		NETDEV_ASSIGN;
 		CHAN_DEF_ASSIGN(chandef);
+		__entry->link_id = link_id;
 	),
-	TP_printk(NETDEV_PR_FMT ", " CHAN_DEF_PR_FMT,
-		  NETDEV_PR_ARG, CHAN_DEF_PR_ARG)
+	TP_printk(NETDEV_PR_FMT ", " CHAN_DEF_PR_FMT ", link:%d",
+		  NETDEV_PR_ARG, CHAN_DEF_PR_ARG, __entry->link_id)
 );
 
 TRACE_EVENT(cfg80211_ch_switch_started_notify,
diff --git a/net/wireless/util.c b/net/wireless/util.c
index a60d7d638e72..b7257862e0fe 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -5,7 +5,7 @@
  * Copyright 2007-2009	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 #include <linux/export.h>
 #include <linux/bitops.h>
@@ -1041,7 +1041,6 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 			return -EBUSY;
 
 		dev->ieee80211_ptr->use_4addr = false;
-		dev->ieee80211_ptr->mesh_id_up_len = 0;
 		wdev_lock(dev->ieee80211_ptr);
 		rdev_set_qos_map(rdev, dev, NULL);
 		wdev_unlock(dev->ieee80211_ptr);
@@ -1049,7 +1048,7 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 		switch (otype) {
 		case NL80211_IFTYPE_AP:
 		case NL80211_IFTYPE_P2P_GO:
-			cfg80211_stop_ap(rdev, dev, true);
+			cfg80211_stop_ap(rdev, dev, -1, true);
 			break;
 		case NL80211_IFTYPE_ADHOC:
 			cfg80211_leave_ibss(rdev, dev, false);
@@ -1073,6 +1072,11 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 
 		cfg80211_process_rdev_events(rdev);
 		cfg80211_mlme_purge_registrations(dev->ieee80211_ptr);
+
+		memset(&dev->ieee80211_ptr->u, 0,
+		       sizeof(dev->ieee80211_ptr->u));
+		memset(&dev->ieee80211_ptr->links, 0,
+		       sizeof(dev->ieee80211_ptr->links));
 	}
 
 	err = rdev_change_virtual_intf(rdev, dev, ntype, params);
@@ -1930,6 +1934,24 @@ bool ieee80211_chandef_to_operating_class(struct cfg80211_chan_def *chandef,
 }
 EXPORT_SYMBOL(ieee80211_chandef_to_operating_class);
 
+static int cfg80211_wdev_bi(struct wireless_dev *wdev)
+{
+	switch (wdev->iftype) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+		WARN_ON(wdev->valid_links);
+		return wdev->links[0].ap.beacon_interval;
+	case NL80211_IFTYPE_MESH_POINT:
+		return wdev->u.mesh.beacon_interval;
+	case NL80211_IFTYPE_ADHOC:
+		return wdev->u.ibss.beacon_interval;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static void cfg80211_calculate_bi_data(struct wiphy *wiphy, u32 new_beacon_int,
 				       u32 *beacon_int_gcd,
 				       bool *beacon_int_different)
@@ -1940,19 +1962,27 @@ static void cfg80211_calculate_bi_data(struct wiphy *wiphy, u32 new_beacon_int,
 	*beacon_int_different = false;
 
 	list_for_each_entry(wdev, &wiphy->wdev_list, list) {
-		if (!wdev->beacon_interval)
+		int wdev_bi;
+
+		/* this feature isn't supported with MLO */
+		if (wdev->valid_links)
+			continue;
+
+		wdev_bi = cfg80211_wdev_bi(wdev);
+
+		if (!wdev_bi)
 			continue;
 
 		if (!*beacon_int_gcd) {
-			*beacon_int_gcd = wdev->beacon_interval;
+			*beacon_int_gcd = wdev_bi;
 			continue;
 		}
 
-		if (wdev->beacon_interval == *beacon_int_gcd)
+		if (wdev_bi == *beacon_int_gcd)
 			continue;
 
 		*beacon_int_different = true;
-		*beacon_int_gcd = gcd(*beacon_int_gcd, wdev->beacon_interval);
+		*beacon_int_gcd = gcd(*beacon_int_gcd, wdev_bi);
 	}
 
 	if (new_beacon_int && *beacon_int_gcd != new_beacon_int) {
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index a32065d600a1..a9767bfe7330 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -7,7 +7,7 @@
  * we directly assign the wireless handlers of wireless interfaces.
  *
  * Copyright 2008-2009	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2019-2021 Intel Corporation
+ * Copyright (C) 2019-2022 Intel Corporation
  */
 
 #include <linux/export.h>
@@ -415,6 +415,9 @@ static int __cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 	int err, i;
 	bool rejoin = false;
 
+	if (wdev->valid_links)
+		return -EINVAL;
+
 	if (pairwise && !addr)
 		return -EINVAL;
 
@@ -437,7 +440,7 @@ static int __cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 		return -EOPNOTSUPP;
 
 	if (params->cipher == WLAN_CIPHER_SUITE_AES_CMAC) {
-		if (!wdev->current_bss)
+		if (!wdev->connected)
 			return -ENOLINK;
 
 		if (!rdev->ops->set_default_mgmt_key)
@@ -450,7 +453,9 @@ static int __cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 
 	if (remove) {
 		err = 0;
-		if (wdev->current_bss) {
+		if (wdev->connected ||
+		    (wdev->iftype == NL80211_IFTYPE_ADHOC &&
+		     wdev->u.ibss.current_bss)) {
 			/*
 			 * If removing the current TX key, we will need to
 			 * join a new IBSS without the privacy bit clear.
@@ -501,7 +506,9 @@ static int __cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
 
 	err = 0;
-	if (wdev->current_bss)
+	if (wdev->connected ||
+	    (wdev->iftype == NL80211_IFTYPE_ADHOC &&
+	     wdev->u.ibss.current_bss))
 		err = rdev_add_key(rdev, dev, idx, pairwise, addr, params);
 	else if (params->cipher != WLAN_CIPHER_SUITE_WEP40 &&
 		 params->cipher != WLAN_CIPHER_SUITE_WEP104)
@@ -526,7 +533,9 @@ static int __cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 	if ((params->cipher == WLAN_CIPHER_SUITE_WEP40 ||
 	     params->cipher == WLAN_CIPHER_SUITE_WEP104) &&
 	    (tx_key || (!addr && wdev->wext.default_key == -1))) {
-		if (wdev->current_bss) {
+		if (wdev->connected ||
+		    (wdev->iftype == NL80211_IFTYPE_ADHOC &&
+		     wdev->u.ibss.current_bss)) {
 			/*
 			 * If we are getting a new TX key from not having
 			 * had one before we need to join a new IBSS with
@@ -549,7 +558,9 @@ static int __cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 
 	if (params->cipher == WLAN_CIPHER_SUITE_AES_CMAC &&
 	    (tx_key || (!addr && wdev->wext.default_mgmt_key == -1))) {
-		if (wdev->current_bss)
+		if (wdev->connected ||
+		    (wdev->iftype == NL80211_IFTYPE_ADHOC &&
+		     wdev->u.ibss.current_bss))
 			err = rdev_set_default_mgmt_key(rdev, dev, idx);
 		if (!err)
 			wdev->wext.default_mgmt_key = idx;
@@ -595,6 +606,11 @@ static int cfg80211_wext_siwencode(struct net_device *dev,
 		return -EOPNOTSUPP;
 
 	wiphy_lock(&rdev->wiphy);
+	if (wdev->valid_links) {
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
 	idx = erq->flags & IW_ENCODE_INDEX;
 	if (idx == 0) {
 		idx = wdev->wext.default_key;
@@ -613,7 +629,9 @@ static int cfg80211_wext_siwencode(struct net_device *dev,
 		/* No key data - just set the default TX key index */
 		err = 0;
 		wdev_lock(wdev);
-		if (wdev->current_bss)
+		if (wdev->connected ||
+		    (wdev->iftype == NL80211_IFTYPE_ADHOC &&
+		     wdev->u.ibss.current_bss))
 			err = rdev_set_default_key(rdev, dev, idx, true,
 						   true);
 		if (!err)
@@ -865,7 +883,7 @@ static int cfg80211_wext_giwfreq(struct net_device *dev,
 			break;
 		}
 
-		ret = rdev_get_channel(rdev, wdev, &chandef);
+		ret = rdev_get_channel(rdev, wdev, 0, &chandef);
 		if (ret)
 			break;
 		freq->m = chandef.chan->center_freq;
@@ -1270,7 +1288,10 @@ static int cfg80211_wext_siwrate(struct net_device *dev,
 		return -EINVAL;
 
 	wiphy_lock(&rdev->wiphy);
-	ret = rdev_set_bitrate_mask(rdev, dev, NULL, &mask);
+	if (dev->ieee80211_ptr->valid_links)
+		ret = -EOPNOTSUPP;
+	else
+		ret = rdev_set_bitrate_mask(rdev, dev, 0, NULL, &mask);
 	wiphy_unlock(&rdev->wiphy);
 
 	return ret;
@@ -1294,8 +1315,9 @@ static int cfg80211_wext_giwrate(struct net_device *dev,
 
 	err = 0;
 	wdev_lock(wdev);
-	if (wdev->current_bss)
-		memcpy(addr, wdev->current_bss->pub.bssid, ETH_ALEN);
+	if (!wdev->valid_links && wdev->links[0].client.current_bss)
+		memcpy(addr, wdev->links[0].client.current_bss->pub.bssid,
+		       ETH_ALEN);
 	else
 		err = -EOPNOTSUPP;
 	wdev_unlock(wdev);
@@ -1339,11 +1361,11 @@ static struct iw_statistics *cfg80211_wireless_stats(struct net_device *dev)
 
 	/* Grab BSSID of current BSS, if any */
 	wdev_lock(wdev);
-	if (!wdev->current_bss) {
+	if (wdev->valid_links || !wdev->links[0].client.current_bss) {
 		wdev_unlock(wdev);
 		return NULL;
 	}
-	memcpy(bssid, wdev->current_bss->pub.bssid, ETH_ALEN);
+	memcpy(bssid, wdev->links[0].client.current_bss->pub.bssid, ETH_ALEN);
 	wdev_unlock(wdev);
 
 	memset(&sinfo, 0, sizeof(sinfo));
diff --git a/net/wireless/wext-sme.c b/net/wireless/wext-sme.c
index cd09a9042261..565f249f1dd6 100644
--- a/net/wireless/wext-sme.c
+++ b/net/wireless/wext-sme.c
@@ -124,9 +124,12 @@ int cfg80211_mgd_wext_giwfreq(struct net_device *dev,
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_STATION))
 		return -EINVAL;
 
+	if (wdev->valid_links)
+		return -EOPNOTSUPP;
+
 	wdev_lock(wdev);
-	if (wdev->current_bss)
-		chan = wdev->current_bss->pub.channel;
+	if (wdev->links[0].client.current_bss)
+		chan = wdev->links[0].client.current_bss->pub.channel;
 	else if (wdev->wext.connect.channel)
 		chan = wdev->wext.connect.channel;
 	wdev_unlock(wdev);
@@ -208,15 +211,19 @@ int cfg80211_mgd_wext_giwessid(struct net_device *dev,
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_STATION))
 		return -EINVAL;
 
+	if (wdev->valid_links)
+		return -EINVAL;
+
 	data->flags = 0;
 
 	wdev_lock(wdev);
-	if (wdev->current_bss) {
+	if (wdev->links[0].client.current_bss) {
 		const struct element *ssid_elem;
 
 		rcu_read_lock();
-		ssid_elem = ieee80211_bss_get_elem(&wdev->current_bss->pub,
-						   WLAN_EID_SSID);
+		ssid_elem = ieee80211_bss_get_elem(
+				&wdev->links[0].client.current_bss->pub,
+				WLAN_EID_SSID);
 		if (ssid_elem) {
 			data->flags = 1;
 			data->length = ssid_elem->datalen;
@@ -300,8 +307,14 @@ int cfg80211_mgd_wext_giwap(struct net_device *dev,
 	ap_addr->sa_family = ARPHRD_ETHER;
 
 	wdev_lock(wdev);
-	if (wdev->current_bss)
-		memcpy(ap_addr->sa_data, wdev->current_bss->pub.bssid, ETH_ALEN);
+	if (wdev->valid_links) {
+		wdev_unlock(wdev);
+		return -EOPNOTSUPP;
+	}
+	if (wdev->links[0].client.current_bss)
+		memcpy(ap_addr->sa_data,
+		       wdev->links[0].client.current_bss->pub.bssid,
+		       ETH_ALEN);
 	else
 		eth_zero_addr(ap_addr->sa_data);
 	wdev_unlock(wdev);
-- 
2.35.1

