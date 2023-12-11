Return-Path: <linux-wireless+bounces-597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0896D80BACC
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 14:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1275280CA7
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 13:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D761C8C3;
	Sun, 10 Dec 2023 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABkn/3FE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D386DA6
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 05:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702213504; x=1733749504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jbVSLUdOMmnhS1XDp8R8PrG1FKSfLNGdJaaNfH+Fx3g=;
  b=ABkn/3FEWKqbN3QNghQQwd8fZpOPhxY7g1k8pzxAn6m4YyCd6ivL7VhV
   cDEDP6IbNcEjkfKNhThGDIWLRobUDxeGbWABo9/CX/kXT+O4t9viXSyBq
   XzZDYETZweNcgbncvWKb23eqrgRvr8RwMqLi2vgWo4Fnjwdgve+iS5jYz
   oGkzLvgbH9zrmpNJHTywNEpgSPB5P04xQZtUuPHu7YbV8y+rXjvg/N++V
   MGyDFSKit/IG2mbSfU9hIuDH6YGrjtMRhtyXVoO1s2ZFrIQjuzjtarCX2
   s87qoHe7UeI1sdPEksN02Ce5+S/YxubH6kFwJ6UsSim5uVyIHTTUlPnO8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="480745641"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="480745641"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:05:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="748925460"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="748925460"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2023 05:05:01 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>, Peer@web.codeaurora.org,
	Ilan <ilan.peer@intel.com>, Greenman@web.codeaurora.org,
	Gregory <gregory.greenman@intel.com>
Subject: [PATCH 02/14] wifi: cfg80211: add BSS usage reporting
Date: Mon, 11 Dec 2023 09:05:20 +0200
Message-Id: <20231211085121.0464f25e0b1d.I9f70ca9f1440565ad9a5207d0f4d00a20cca67e7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
References: <20231211070532.2458539-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Sometimes there may be reasons for which a BSS that's
actually found in scan cannot be used to connect to,
for example a nonprimary link of an NSTR mobile AP MLD
cannot be used for normal direct connections to it.

Not indicating these to userspace as we do now of course
avoids being able to connect to them, but it's better if
they're shown to userspace and it can make an appropriate
decision, without e.g. doing an additional ML probe.

Thus add an indication of what a BSS can be used for,
currently "normal" and "MLD link", including a reason
bitmap for it being not usable.

The latter can be extended later for certain BSSes if there
are other reasons they cannot be used.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Peer, Ilan <ilan.peer@intel.com>
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       | 60 +++++++++++++++++++++++++----
 include/uapi/linux/nl80211.h | 40 ++++++++++++++++++++
 net/wireless/core.h          |  3 ++
 net/wireless/nl80211.c       | 54 +++++++++++++++++++++-----
 net/wireless/scan.c          | 73 +++++++++++++++++++++++++++---------
 5 files changed, 195 insertions(+), 35 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d59669d86718..c0d16fbf4aba 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2819,6 +2819,13 @@ enum cfg80211_signal_type {
  *	the BSS that requested the scan in which the beacon/probe was received.
  * @chains: bitmask for filled values in @chain_signal.
  * @chain_signal: per-chain signal strength of last received BSS in dBm.
+ * @restrict_use: restrict usage, if not set, assume @use_for is
+ *	%NL80211_BSS_USE_FOR_NORMAL.
+ * @use_for: bitmap of possible usage for this BSS, see
+ *	&enum nl80211_bss_use_for
+ * @cannot_use_reasons: the reasons (bitmap) for not being able to connect,
+ *	if @restrict_use is set and @use_for is zero (empty); may be 0 for
+ *	unspecified reasons; see &enum nl80211_bss_cannot_use_reasons
  * @drv_data: Data to be passed through to @inform_bss
  */
 struct cfg80211_inform_bss {
@@ -2830,6 +2837,9 @@ struct cfg80211_inform_bss {
 	u8 chains;
 	s8 chain_signal[IEEE80211_MAX_CHAINS];
 
+	u8 restrict_use:1, use_for:7;
+	u8 cannot_use_reasons;
+
 	void *drv_data;
 };
 
@@ -2881,6 +2891,11 @@ struct cfg80211_bss_ies {
  * @chain_signal: per-chain signal strength of last received BSS in dBm.
  * @bssid_index: index in the multiple BSS set
  * @max_bssid_indicator: max number of members in the BSS set
+ * @use_for: bitmap of possible usage for this BSS, see
+ *	&enum nl80211_bss_use_for
+ * @cannot_use_reasons: the reasons (bitmap) for not being able to connect,
+ *	if @restrict_use is set and @use_for is zero (empty); may be 0 for
+ *	unspecified reasons; see &enum nl80211_bss_cannot_use_reasons
  * @priv: private area for driver use, has at least wiphy->bss_priv_size bytes
  */
 struct cfg80211_bss {
@@ -2906,6 +2921,9 @@ struct cfg80211_bss {
 	u8 bssid_index;
 	u8 max_bssid_indicator;
 
+	u8 use_for;
+	u8 cannot_use_reasons;
+
 	u8 priv[] __aligned(sizeof(void *));
 };
 
@@ -4913,6 +4931,8 @@ struct cfg80211_ops {
  *	NL80211_REGDOM_SET_BY_DRIVER.
  * @WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON: reg_call_notifier() is called if driver
  *	set this flag to update channels on beacon hints.
+ * @WIPHY_FLAG_SUPPORTS_NSTR_NONPRIMARY: support connection to non-primary link
+ *	of an NSTR mobile AP MLD.
  */
 enum wiphy_flags {
 	WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK		= BIT(0),
@@ -4926,7 +4946,7 @@ enum wiphy_flags {
 	WIPHY_FLAG_IBSS_RSN			= BIT(8),
 	WIPHY_FLAG_MESH_AUTH			= BIT(10),
 	WIPHY_FLAG_SUPPORTS_EXT_KCK_32          = BIT(11),
-	/* use hole at 12 */
+	WIPHY_FLAG_SUPPORTS_NSTR_NONPRIMARY	= BIT(12),
 	WIPHY_FLAG_SUPPORTS_FW_ROAM		= BIT(13),
 	WIPHY_FLAG_AP_UAPSD			= BIT(14),
 	WIPHY_FLAG_SUPPORTS_TDLS		= BIT(15),
@@ -7164,6 +7184,25 @@ cfg80211_inform_bss(struct wiphy *wiphy,
 					gfp);
 }
 
+/**
+ * __cfg80211_get_bss - get a BSS reference
+ * @wiphy: the wiphy this BSS struct belongs to
+ * @channel: the channel to search on (or %NULL)
+ * @bssid: the desired BSSID (or %NULL)
+ * @ssid: the desired SSID (or %NULL)
+ * @ssid_len: length of the SSID (or 0)
+ * @bss_type: type of BSS, see &enum ieee80211_bss_type
+ * @privacy: privacy filter, see &enum ieee80211_privacy
+ * @use_for: indicates which use is intended
+ */
+struct cfg80211_bss *__cfg80211_get_bss(struct wiphy *wiphy,
+					struct ieee80211_channel *channel,
+					const u8 *bssid,
+					const u8 *ssid, size_t ssid_len,
+					enum ieee80211_bss_type bss_type,
+					enum ieee80211_privacy privacy,
+					u32 use_for);
+
 /**
  * cfg80211_get_bss - get a BSS reference
  * @wiphy: the wiphy this BSS struct belongs to
@@ -7173,13 +7212,20 @@ cfg80211_inform_bss(struct wiphy *wiphy,
  * @ssid_len: length of the SSID (or 0)
  * @bss_type: type of BSS, see &enum ieee80211_bss_type
  * @privacy: privacy filter, see &enum ieee80211_privacy
+ *
+ * This version implies regular usage, %NL80211_BSS_USE_FOR_NORMAL.
  */
-struct cfg80211_bss *cfg80211_get_bss(struct wiphy *wiphy,
-				      struct ieee80211_channel *channel,
-				      const u8 *bssid,
-				      const u8 *ssid, size_t ssid_len,
-				      enum ieee80211_bss_type bss_type,
-				      enum ieee80211_privacy privacy);
+static inline struct cfg80211_bss *
+cfg80211_get_bss(struct wiphy *wiphy, struct ieee80211_channel *channel,
+		 const u8 *bssid, const u8 *ssid, size_t ssid_len,
+		 enum ieee80211_bss_type bss_type,
+		 enum ieee80211_privacy privacy)
+{
+	return __cfg80211_get_bss(wiphy, channel, bssid, ssid, ssid_len,
+				  bss_type, privacy,
+				  NL80211_BSS_USE_FOR_NORMAL);
+}
+
 static inline struct cfg80211_bss *
 cfg80211_get_ibss(struct wiphy *wiphy,
 		  struct ieee80211_channel *channel,
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 0cd1da2c2902..7d774f6b3454 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2830,6 +2830,10 @@ enum nl80211_commands {
  * @NL80211_ATTR_MLO_LINK_DISABLED: Flag attribute indicating that the link is
  *	disabled.
  *
+ * @NL80211_ATTR_BSS_DUMP_INCLUDE_USE_DATA: Include BSS usage data, i.e.
+ *	include BSSes that can only be used in restricted scenarios and/or
+ *	cannot be used at all.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3368,6 +3372,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_MLO_LINK_DISABLED,
 
+	NL80211_ATTR_BSS_DUMP_INCLUDE_USE_DATA,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -5031,6 +5037,30 @@ enum nl80211_bss_scan_width {
 	NL80211_BSS_CHAN_WIDTH_2,
 };
 
+/**
+ * enum nl80211_bss_use_for - bitmap indicating possible BSS use
+ * @NL80211_BSS_USE_FOR_NORMAL: Use this BSS for normal "connection",
+ *	including IBSS/MBSS depending on the type.
+ * @NL80211_BSS_USE_FOR_MLD_LINK: This BSS can be used as a link in an
+ *	MLO connection. Note that for an MLO connection, all links including
+ *	the assoc link must have this flag set, and the assoc link must
+ *	additionally have %NL80211_BSS_USE_FOR_NORMAL set.
+ */
+enum nl80211_bss_use_for {
+	NL80211_BSS_USE_FOR_NORMAL = 1 << 0,
+	NL80211_BSS_USE_FOR_MLD_LINK = 1 << 1,
+};
+
+/**
+ * enum nl80211_bss_cannot_use_reasons - reason(s) connection to a
+ *	BSS isn't possible
+ * @NL80211_BSS_CANNOT_USE_NSTR_NONPRIMARY: NSTR nonprimary links aren't
+ *	supported by the device, and this BSS entry represents one.
+ */
+enum nl80211_bss_cannot_use_reasons {
+	NL80211_BSS_CANNOT_USE_NSTR_NONPRIMARY	= 1 << 0,
+};
+
 /**
  * enum nl80211_bss - netlink attributes for a BSS
  *
@@ -5083,6 +5113,14 @@ enum nl80211_bss_scan_width {
  * @NL80211_BSS_FREQUENCY_OFFSET: frequency offset in KHz
  * @NL80211_BSS_MLO_LINK_ID: MLO link ID of the BSS (u8).
  * @NL80211_BSS_MLD_ADDR: MLD address of this BSS if connected to it.
+ * @NL80211_BSS_USE_FOR: u32 bitmap attribute indicating what the BSS can be
+ *	used for, see &enum nl80211_bss_use_for.
+ * @NL80211_BSS_CANNOT_USE_REASONS: Indicates the reason that this BSS cannot
+ *	be used for all or some of the possible uses by the device reporting it,
+ *	even though its presence was detected.
+ *	This is a u64 attribute containing a bitmap of values from
+ *	&enum nl80211_cannot_use_reasons, note that the attribute may be missing
+ *	if no reasons are specified.
  * @__NL80211_BSS_AFTER_LAST: internal
  * @NL80211_BSS_MAX: highest BSS attribute
  */
@@ -5110,6 +5148,8 @@ enum nl80211_bss {
 	NL80211_BSS_FREQUENCY_OFFSET,
 	NL80211_BSS_MLO_LINK_ID,
 	NL80211_BSS_MLD_ADDR,
+	NL80211_BSS_USE_FOR,
+	NL80211_BSS_CANNOT_USE_REASONS,
 
 	/* keep last */
 	__NL80211_BSS_AFTER_LAST,
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 4c692c7faf30..87c5889b15e3 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -457,6 +457,9 @@ int cfg80211_scan(struct cfg80211_registered_device *rdev);
 
 extern struct work_struct cfg80211_disconnect_work;
 
+#define NL80211_BSS_USE_FOR_ALL	(NL80211_BSS_USE_FOR_NORMAL | \
+				 NL80211_BSS_USE_FOR_MLD_LINK)
+
 void cfg80211_set_dfs_state(struct wiphy *wiphy,
 			    const struct cfg80211_chan_def *chandef,
 			    enum nl80211_dfs_state dfs_state);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 403a4a38966a..7dec0027daaa 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -818,6 +818,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_HW_TIMESTAMP_ENABLED] = { .type = NLA_FLAG },
 	[NL80211_ATTR_EMA_RNR_ELEMS] = { .type = NLA_NESTED },
 	[NL80211_ATTR_MLO_LINK_DISABLED] = { .type = NLA_FLAG },
+	[NL80211_ATTR_BSS_DUMP_INCLUDE_USE_DATA] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -10405,6 +10406,15 @@ static int nl80211_send_bss(struct sk_buff *msg, struct netlink_callback *cb,
 		break;
 	}
 
+	if (nla_put_u32(msg, NL80211_BSS_USE_FOR, res->use_for))
+		goto nla_put_failure;
+
+	if (res->cannot_use_reasons &&
+	    nla_put_u64_64bit(msg, NL80211_BSS_CANNOT_USE_REASONS,
+			      res->cannot_use_reasons,
+			      NL80211_BSS_PAD))
+		goto nla_put_failure;
+
 	nla_nest_end(msg, bss);
 
 	genlmsg_end(msg, hdr);
@@ -10422,15 +10432,27 @@ static int nl80211_dump_scan(struct sk_buff *skb, struct netlink_callback *cb)
 	struct cfg80211_registered_device *rdev;
 	struct cfg80211_internal_bss *scan;
 	struct wireless_dev *wdev;
+	struct nlattr **attrbuf;
 	int start = cb->args[2], idx = 0;
+	bool dump_include_use_data;
 	int err;
 
-	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev, NULL);
-	if (err)
+	attrbuf = kcalloc(NUM_NL80211_ATTR, sizeof(*attrbuf), GFP_KERNEL);
+	if (!attrbuf)
+		return -ENOMEM;
+
+	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev, attrbuf);
+	if (err) {
+		kfree(attrbuf);
 		return err;
+	}
 	/* nl80211_prepare_wdev_dump acquired it in the successful case */
 	__acquire(&rdev->wiphy.mtx);
 
+	dump_include_use_data =
+		attrbuf[NL80211_ATTR_BSS_DUMP_INCLUDE_USE_DATA];
+	kfree(attrbuf);
+
 	spin_lock_bh(&rdev->bss_lock);
 
 	/*
@@ -10447,6 +10469,9 @@ static int nl80211_dump_scan(struct sk_buff *skb, struct netlink_callback *cb)
 	list_for_each_entry(scan, &rdev->bss_list, list) {
 		if (++idx <= start)
 			continue;
+		if (!dump_include_use_data &&
+		    !(scan->pub.use_for & NL80211_BSS_USE_FOR_NORMAL))
+			continue;
 		if (nl80211_send_bss(skb, cb,
 				cb->nlh->nlmsg_seq, NLM_F_MULTI,
 				rdev, wdev, scan) < 0) {
@@ -10898,12 +10923,13 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
 
 static struct cfg80211_bss *nl80211_assoc_bss(struct cfg80211_registered_device *rdev,
 					      const u8 *ssid, int ssid_len,
-					      struct nlattr **attrs)
+					      struct nlattr **attrs,
+					      int assoc_link_id, int link_id)
 {
 	struct ieee80211_channel *chan;
 	struct cfg80211_bss *bss;
 	const u8 *bssid;
-	u32 freq;
+	u32 freq, use_for = 0;
 
 	if (!attrs[NL80211_ATTR_MAC] || !attrs[NL80211_ATTR_WIPHY_FREQ])
 		return ERR_PTR(-EINVAL);
@@ -10918,10 +10944,16 @@ static struct cfg80211_bss *nl80211_assoc_bss(struct cfg80211_registered_device
 	if (!chan)
 		return ERR_PTR(-EINVAL);
 
-	bss = cfg80211_get_bss(&rdev->wiphy, chan, bssid,
-			       ssid, ssid_len,
-			       IEEE80211_BSS_TYPE_ESS,
-			       IEEE80211_PRIVACY_ANY);
+	if (assoc_link_id >= 0)
+		use_for = NL80211_BSS_USE_FOR_MLD_LINK;
+	if (assoc_link_id == link_id)
+		use_for |= NL80211_BSS_USE_FOR_NORMAL;
+
+	bss = __cfg80211_get_bss(&rdev->wiphy, chan, bssid,
+				 ssid, ssid_len,
+				 IEEE80211_BSS_TYPE_ESS,
+				 IEEE80211_PRIVACY_ANY,
+				 use_for);
 	if (!bss)
 		return ERR_PTR(-ENOENT);
 
@@ -11100,7 +11132,8 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 				goto free;
 			}
 			req.links[link_id].bss =
-				nl80211_assoc_bss(rdev, ssid, ssid_len, attrs);
+				nl80211_assoc_bss(rdev, ssid, ssid_len, attrs,
+						  req.link_id, link_id);
 			if (IS_ERR(req.links[link_id].bss)) {
 				err = PTR_ERR(req.links[link_id].bss);
 				req.links[link_id].bss = NULL;
@@ -11165,7 +11198,8 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 		if (req.link_id >= 0)
 			return -EINVAL;
 
-		req.bss = nl80211_assoc_bss(rdev, ssid, ssid_len, info->attrs);
+		req.bss = nl80211_assoc_bss(rdev, ssid, ssid_len, info->attrs,
+					    -1, -1);
 		if (IS_ERR(req.bss))
 			return PTR_ERR(req.bss);
 		ap_addr = req.bss->bssid;
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 9e5ccffd6868..2f8c9b6f7ebc 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1535,12 +1535,13 @@ static bool cfg80211_bss_type_match(u16 capability,
 }
 
 /* Returned bss is reference counted and must be cleaned up appropriately. */
-struct cfg80211_bss *cfg80211_get_bss(struct wiphy *wiphy,
-				      struct ieee80211_channel *channel,
-				      const u8 *bssid,
-				      const u8 *ssid, size_t ssid_len,
-				      enum ieee80211_bss_type bss_type,
-				      enum ieee80211_privacy privacy)
+struct cfg80211_bss *__cfg80211_get_bss(struct wiphy *wiphy,
+					struct ieee80211_channel *channel,
+					const u8 *bssid,
+					const u8 *ssid, size_t ssid_len,
+					enum ieee80211_bss_type bss_type,
+					enum ieee80211_privacy privacy,
+					u32 use_for)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	struct cfg80211_internal_bss *bss, *res = NULL;
@@ -1565,6 +1566,8 @@ struct cfg80211_bss *cfg80211_get_bss(struct wiphy *wiphy,
 			continue;
 		if (!is_valid_ether_addr(bss->pub.bssid))
 			continue;
+		if ((bss->pub.use_for & use_for) != use_for)
+			continue;
 		/* Don't get expired BSS structs */
 		if (time_after(now, bss->ts + IEEE80211_SCAN_RESULT_EXPIRE) &&
 		    !atomic_read(&bss->hold))
@@ -1582,7 +1585,7 @@ struct cfg80211_bss *cfg80211_get_bss(struct wiphy *wiphy,
 	trace_cfg80211_return_bss(&res->pub);
 	return &res->pub;
 }
-EXPORT_SYMBOL(cfg80211_get_bss);
+EXPORT_SYMBOL(__cfg80211_get_bss);
 
 static void rb_insert_bss(struct cfg80211_registered_device *rdev,
 			  struct cfg80211_internal_bss *bss)
@@ -1800,6 +1803,8 @@ cfg80211_update_known_bss(struct cfg80211_registered_device *rdev,
 	ether_addr_copy(known->parent_bssid, new->parent_bssid);
 	known->pub.max_bssid_indicator = new->pub.max_bssid_indicator;
 	known->pub.bssid_index = new->pub.bssid_index;
+	known->pub.use_for &= new->pub.use_for;
+	known->pub.cannot_use_reasons = new->pub.cannot_use_reasons;
 
 	return true;
 }
@@ -2044,6 +2049,9 @@ struct cfg80211_inform_single_bss_data {
 	struct cfg80211_bss *source_bss;
 	u8 max_bssid_indicator;
 	u8 bssid_index;
+
+	u8 use_for;
+	u64 cannot_use_reasons;
 };
 
 /* Returned bss is reference counted and must be cleaned up appropriately. */
@@ -2089,6 +2097,8 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 	tmp.ts_boottime = drv_data->boottime_ns;
 	tmp.parent_tsf = drv_data->parent_tsf;
 	ether_addr_copy(tmp.parent_bssid, drv_data->parent_bssid);
+	tmp.pub.use_for = data->use_for;
+	tmp.pub.cannot_use_reasons = data->cannot_use_reasons;
 
 	if (data->bss_source != BSS_SOURCE_DIRECT) {
 		tmp.pub.transmitted_bss = data->source_bss;
@@ -2259,6 +2269,8 @@ cfg80211_parse_mbssid_data(struct wiphy *wiphy,
 		.beacon_interval = tx_data->beacon_interval,
 		.source_bss = source_bss,
 		.bss_source = BSS_SOURCE_MBSSID,
+		.use_for = tx_data->use_for,
+		.cannot_use_reasons = tx_data->cannot_use_reasons,
 	};
 	const u8 *mbssid_index_ie;
 	const struct element *elem, *sub;
@@ -2521,7 +2533,7 @@ cfg80211_defrag_mle(const struct element *mle, const u8 *ie, size_t ielen,
 	return NULL;
 }
 
-static bool
+static u8
 cfg80211_tbtt_info_for_mld_ap(const u8 *ie, size_t ielen, u8 mld_id, u8 link_id,
 			      const struct ieee80211_neighbor_ap_info **ap_info,
 			      const u8 **tbtt_info)
@@ -2540,6 +2552,7 @@ cfg80211_tbtt_info_for_mld_ap(const u8 *ie, size_t ielen, u8 mld_id, u8 link_id,
 			u16 params;
 			u8 length, i, count, mld_params_offset;
 			u8 type, lid;
+			u32 use_for;
 
 			info = (void *)pos;
 			count = u8_get_bits(info->tbtt_info_hdr,
@@ -2549,20 +2562,22 @@ cfg80211_tbtt_info_for_mld_ap(const u8 *ie, size_t ielen, u8 mld_id, u8 link_id,
 			pos += sizeof(*info);
 
 			if (count * length > end - pos)
-				return false;
+				return 0;
 
 			type = u8_get_bits(info->tbtt_info_hdr,
 					   IEEE80211_AP_INFO_TBTT_HDR_TYPE);
 
-			/* Only accept full TBTT information. NSTR mobile APs
-			 * use the shortened version, but we ignore them here.
-			 */
 			if (type == IEEE80211_TBTT_INFO_TYPE_TBTT &&
 			    length >=
 			    offsetofend(struct ieee80211_tbtt_info_ge_11,
 					mld_params)) {
 				mld_params_offset =
 					offsetof(struct ieee80211_tbtt_info_ge_11, mld_params);
+				use_for = NL80211_BSS_USE_FOR_ALL;
+			} else if (type == IEEE80211_TBTT_INFO_TYPE_MLD &&
+				   length >= sizeof(struct ieee80211_rnr_mld_params)) {
+				mld_params_offset = 0;
+				use_for = NL80211_BSS_USE_FOR_MLD_LINK;
 			} else {
 				pos += count * length;
 				continue;
@@ -2580,7 +2595,7 @@ cfg80211_tbtt_info_for_mld_ap(const u8 *ie, size_t ielen, u8 mld_id, u8 link_id,
 					*ap_info = info;
 					*tbtt_info = pos;
 
-					return true;
+					return use_for;
 				}
 
 				pos += length;
@@ -2588,7 +2603,7 @@ cfg80211_tbtt_info_for_mld_ap(const u8 *ie, size_t ielen, u8 mld_id, u8 link_id,
 		}
 	}
 
-	return false;
+	return 0;
 }
 
 static void cfg80211_parse_ml_sta_data(struct wiphy *wiphy,
@@ -2676,7 +2691,7 @@ static void cfg80211_parse_ml_sta_data(struct wiphy *wiphy,
 		const u8 *profile;
 		const u8 *tbtt_info;
 		ssize_t profile_len;
-		u8 link_id;
+		u8 link_id, use_for;
 
 		if (!ieee80211_mle_basic_sta_prof_size_ok((u8 *)mle->sta_prof[i],
 							  mle->sta_prof_len[i]))
@@ -2718,9 +2733,11 @@ static void cfg80211_parse_ml_sta_data(struct wiphy *wiphy,
 		profile_len -= 2;
 
 		/* Find in RNR to look up channel information */
-		if (!cfg80211_tbtt_info_for_mld_ap(tx_data->ie, tx_data->ielen,
-						   mld_id, link_id,
-						   &ap_info, &tbtt_info))
+		use_for = cfg80211_tbtt_info_for_mld_ap(tx_data->ie,
+							tx_data->ielen,
+							mld_id, link_id,
+							&ap_info, &tbtt_info);
+		if (!use_for)
 			continue;
 
 		/* We could sanity check the BSSID is included */
@@ -2732,6 +2749,14 @@ static void cfg80211_parse_ml_sta_data(struct wiphy *wiphy,
 		freq = ieee80211_channel_to_freq_khz(ap_info->channel, band);
 		data.channel = ieee80211_get_channel_khz(wiphy, freq);
 
+		if (use_for == NL80211_BSS_USE_FOR_MLD_LINK &&
+		    !(wiphy->flags & WIPHY_FLAG_SUPPORTS_NSTR_NONPRIMARY)) {
+			use_for = 0;
+			data.cannot_use_reasons =
+				NL80211_BSS_CANNOT_USE_NSTR_NONPRIMARY;
+		}
+		data.use_for = use_for;
+
 		/* Generate new elements */
 		memset(new_ie, 0, IEEE80211_MAX_DATA_LEN);
 		data.ie = new_ie;
@@ -2769,6 +2794,10 @@ cfg80211_inform_bss_data(struct wiphy *wiphy,
 		.beacon_interval = beacon_interval,
 		.ie = ie,
 		.ielen = ielen,
+		.use_for = data->restrict_use ?
+				data->use_for :
+				NL80211_BSS_USE_FOR_ALL,
+		.cannot_use_reasons = data->cannot_use_reasons,
 	};
 	struct cfg80211_bss *res;
 
@@ -2899,6 +2928,10 @@ cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
 	tmp.pub.chains = data->chains;
 	memcpy(tmp.pub.chain_signal, data->chain_signal, IEEE80211_MAX_CHAINS);
 	ether_addr_copy(tmp.parent_bssid, data->parent_bssid);
+	tmp.pub.use_for = data->restrict_use ?
+				data->use_for :
+				NL80211_BSS_USE_FOR_ALL;
+	tmp.pub.cannot_use_reasons = data->cannot_use_reasons;
 
 	signal_valid = data->chan == channel;
 	spin_lock_bh(&rdev->bss_lock);
@@ -2930,6 +2963,10 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 		.ie = mgmt->u.probe_resp.variable,
 		.ielen = len - offsetof(struct ieee80211_mgmt,
 					u.probe_resp.variable),
+		.use_for = data->restrict_use ?
+				data->use_for :
+				NL80211_BSS_USE_FOR_ALL,
+		.cannot_use_reasons = data->cannot_use_reasons,
 	};
 	struct cfg80211_bss *res;
 
-- 
2.34.1


