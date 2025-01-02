Return-Path: <linux-wireless+bounces-16981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2689FFA5C
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 15:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B2D1603B4
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 14:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24E71B4155;
	Thu,  2 Jan 2025 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SGnlfKE+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5C11B413C
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 14:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827629; cv=none; b=dCkKdeOXcUIy10XPFuVai8eDEKhX710ddJn9rSvPSIGiy1ZZVxxhX/lTgcZY4QEvowyOVQFSRS/V/d9W1KJPU6JHxq+UMshRfyHyUcvU7V61OYAwKNDsLKoqXl4O/gyo7Qz/J7Q2NpkbZ/8cF4mErCJoriiv/syU3YBiENdl30w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827629; c=relaxed/simple;
	bh=CrLh/jyYsi7aC8AolFESjybslFWGt6k+GdAxKTLK/e0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mapdwQhDLoBxzlqnTK/ds/KR6B9vYYaboOB4FGi+51Kc8HSUDWm4fDZAV586ZUgfTup5QfkK3bnugakOvl2K1AxsF1cgzeXVJnmcbFJ1iHZrGtZevRtr/qfZg8ZfnTzMzN2pY8/hnhSg7wP8AK4eCZNZ8lOM4eP8fOoGLZBopF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SGnlfKE+; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735827628; x=1767363628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CrLh/jyYsi7aC8AolFESjybslFWGt6k+GdAxKTLK/e0=;
  b=SGnlfKE+Kf5GcmDmOtQSC4SRFCl0EDl8BjKyfwzrCH93inSR1WF0ueAr
   HmubRKFZxSu0sw/oBnZUWhu+7Wh1EhurYuMalY11SRNHv182ooyg2AzJv
   2qAitPtt1GyquEe1fasC+zk9/TIqrC4ATE0dFDpHYapxGqVN/CTeD4fV6
   j1tK8H7z6R/X1GvheZENI7kFcZZUBjQgOHkOjEO3+lFLdaXPXuMdId/fd
   Ic5vANlP6Ac3A3u5Lte0LfzoXWFP8fSXw/9KN5lwd/KUdUVYWiJfqRsJf
   JTXhEWTlKa+9KGVNJw52CXIvY7GssqDSmPmiy9ZEx0s6HaOzEYKoMeIdj
   g==;
X-CSE-ConnectionGUID: qqUjBsgMQxuutyU8WDmRfw==
X-CSE-MsgGUID: Q+BYqruaRV6rjX+hcnA5Xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="46735100"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="46735100"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:28 -0800
X-CSE-ConnectionGUID: LPjYiVMjTqWEMVaqBTjSQg==
X-CSE-MsgGUID: ntR8Qcu4SK23O+UnWb3bag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="132357374"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:26 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 03/17] wifi: cfg80211: Add support for dynamic addition/removal of links
Date: Thu,  2 Jan 2025 16:19:55 +0200
Message-Id: <20250102161730.cef23352f2a2.I79c849974c494cb1cbf9e1b22a5d2d37395ff5ac@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
References: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Add support for requesting dynamic addition/removal of links to the
current MLO association.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       | 45 +++++++++++++++++++
 include/uapi/linux/nl80211.h | 10 +++++
 net/wireless/core.h          |  4 ++
 net/wireless/mlme.c          | 77 +++++++++++++++++++++++++++++++++
 net/wireless/nl80211.c       | 84 ++++++++++++++++++++++++++++++++++++
 net/wireless/nl80211.h       |  3 ++
 net/wireless/rdev-ops.h      | 19 ++++++++
 net/wireless/trace.h         | 44 +++++++++++++++++++
 8 files changed, 286 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8a38d66be2c9..d4b4cabac029 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4596,6 +4596,15 @@ struct mgmt_frame_regs {
  * @set_ttlm: set the TID to link mapping.
  * @get_radio_mask: get bitmask of radios in use.
  *	(invoked with the wiphy mutex held)
+ * @assoc_ml_reconf: Request a non-AP MLO connection to perform ML
+ *	reconfiguration, i.e., add and/or remove links to/from the
+ *	association using ML reconfiguration action frames. Successfully added
+ *	links will be added to the set of valid links. Successfully removed
+ *	links will be removed from the set of valid links. The driver must
+ *	indicate removed links by calling cfg80211_links_removed() and added
+ *	links by calling cfg80211_mlo_reconf_add_done(). When calling
+ *	cfg80211_mlo_reconf_add_done() the bss pointer must be given for each
+ *	link for which MLO reconfiguration 'add' operation was requested.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -4959,6 +4968,9 @@ struct cfg80211_ops {
 	int	(*set_ttlm)(struct wiphy *wiphy, struct net_device *dev,
 			    struct cfg80211_ttlm_params *params);
 	u32	(*get_radio_mask)(struct wiphy *wiphy, struct net_device *dev);
+	int     (*assoc_ml_reconf)(struct wiphy *wiphy, struct net_device *dev,
+				   struct cfg80211_assoc_link *add_links,
+				   u16 rem_links);
 };
 
 /*
@@ -9716,6 +9728,39 @@ static inline int cfg80211_color_change_notify(struct net_device *dev,
  */
 void cfg80211_links_removed(struct net_device *dev, u16 link_mask);
 
+/**
+ * struct cfg80211_mlo_reconf_done_data - MLO reconfiguration data
+ * @buf: MLO Reconfiguration Response frame (header + body)
+ * @len: length of the frame data
+ * @added_links: BIT mask of links successfully added to the association
+ * @links: per-link information indexed by link ID
+ * @links.bss: the BSS that MLO reconfiguration was requested for, ownership of
+ *      the pointer moves to cfg80211 in the call to
+ *      cfg80211_mlo_reconf_add_done().
+ *
+ * The BSS pointer must be set for each link for which 'add' operation was
+ * requested in the assoc_ml_reconf callback.
+ */
+struct cfg80211_mlo_reconf_done_data {
+	const u8 *buf;
+	size_t len;
+	u16 added_links;
+	struct {
+		struct cfg80211_bss *bss;
+	} links[IEEE80211_MLD_MAX_NUM_LINKS];
+};
+
+/**
+ * cfg80211_mlo_reconf_add_done - Notify about MLO reconfiguration result
+ * @dev: network device.
+ * @data: MLO reconfiguration done data, &struct cfg80211_mlo_reconf_done_data
+ *
+ * Inform cfg80211 and the userspace that processing of ML reconfiguration
+ * request to add links to the association is done.
+ */
+void cfg80211_mlo_reconf_add_done(struct net_device *dev,
+				  struct cfg80211_mlo_reconf_done_data *data);
+
 /**
  * cfg80211_schedule_channels_check - schedule regulatory check if needed
  * @wdev: the wireless device to check
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index ee1cf19803ea..f900d7cc42bc 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1329,6 +1329,9 @@
  *      %NL80211_ATTR_MLO_TTLM_ULINK attributes are used to specify the
  *      TID to Link mapping for downlink/uplink traffic.
  *
+ * @NL80211_CMD_ASSOC_MLO_RECONF: For a non-AP MLD station, request to
+ *      add/remove links to/from the association.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1586,6 +1589,8 @@ enum nl80211_commands {
 
 	NL80211_CMD_SET_TID_TO_LINK_MAPPING,
 
+	NL80211_CMD_ASSOC_MLO_RECONF,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2877,6 +2882,9 @@ enum nl80211_commands {
  *	This can be used to provide a list of selectors that are implemented
  *	by the supplicant. If not given, support for SAE_H2E is assumed.
  *
+ * @NL80211_ATTR_MLO_RECONF_REM_LINKS: (u16) A bitmask of the links requested
+ *      to be removed from the MLO association.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3429,6 +3437,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_SUPPORTED_SELECTORS,
 
+	NL80211_ATTR_MLO_RECONF_REM_LINKS,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 4c45f994a8c0..826299f3d781 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -567,6 +567,10 @@ int cfg80211_remove_virtual_intf(struct cfg80211_registered_device *rdev,
 				 struct wireless_dev *wdev);
 void cfg80211_wdev_release_link_bsses(struct wireless_dev *wdev, u16 link_mask);
 
+int cfg80211_assoc_ml_reconf(struct cfg80211_registered_device *rdev,
+			     struct net_device *dev,
+			     struct cfg80211_assoc_link *links,
+			     u16 rem_links);
 /**
  * struct cfg80211_colocated_ap - colocated AP information
  *
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 5c09bf4cdc2e..e10f2b3b4b7f 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -1294,3 +1294,80 @@ void cfg80211_stop_background_radar_detection(struct wireless_dev *wdev)
 					&rdev->background_radar_chandef,
 					NL80211_RADAR_CAC_ABORTED);
 }
+
+int cfg80211_assoc_ml_reconf(struct cfg80211_registered_device *rdev,
+			     struct net_device *dev,
+			     struct cfg80211_assoc_link *links,
+			     u16 rem_links)
+{
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	int err;
+
+	lockdep_assert_wiphy(wdev->wiphy);
+
+	err = rdev_assoc_ml_reconf(rdev, dev, links, rem_links);
+	if (!err) {
+		int link_id;
+
+		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
+		     link_id++) {
+			if (!links[link_id].bss)
+				continue;
+
+			cfg80211_ref_bss(&rdev->wiphy, links[link_id].bss);
+			cfg80211_hold_bss(bss_from_pub(links[link_id].bss));
+		}
+	}
+
+	return err;
+}
+
+void cfg80211_mlo_reconf_add_done(struct net_device *dev,
+				  struct cfg80211_mlo_reconf_done_data *data)
+{
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct wiphy *wiphy = wdev->wiphy;
+	int link_id;
+
+	lockdep_assert_wiphy(wiphy);
+
+	trace_cfg80211_mlo_reconf_add_done(dev, data->added_links,
+					   data->buf, data->len);
+
+	if (WARN_ON(!wdev->valid_links))
+		return;
+
+	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_STATION &&
+		    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT))
+		return;
+
+	/* validate that a BSS is given for each added link */
+	for (link_id = 0; link_id < ARRAY_SIZE(data->links); link_id++) {
+		struct cfg80211_bss *bss = data->links[link_id].bss;
+
+		if (!(data->added_links & BIT(link_id)))
+			continue;
+
+		if (WARN_ON(!bss))
+			return;
+	}
+
+	for (link_id = 0; link_id < ARRAY_SIZE(data->links); link_id++) {
+		struct cfg80211_bss *bss = data->links[link_id].bss;
+
+		if (!bss)
+			continue;
+
+		if (data->added_links & BIT(link_id)) {
+			wdev->links[link_id].client.current_bss =
+				bss_from_pub(bss);
+		} else {
+			cfg80211_unhold_bss(bss_from_pub(bss));
+			cfg80211_put_bss(wiphy, bss);
+		}
+	}
+
+	wdev->valid_links |= data->added_links;
+	nl80211_mlo_reconf_add_done(dev, data);
+}
+EXPORT_SYMBOL(cfg80211_mlo_reconf_add_done);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 9a9e61421c47..ea7eda9feabb 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -848,6 +848,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_SUPPORTED_SELECTORS] =
 		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_supported_selectors,
 				       NL80211_MAX_SUPP_SELECTORS),
+	[NL80211_ATTR_MLO_RECONF_REM_LINKS] = { .type = NLA_U16 },
 };
 
 /* policy for the key attributes */
@@ -16475,6 +16476,66 @@ nl80211_set_ttlm(struct sk_buff *skb, struct genl_info *info)
 	return rdev_set_ttlm(rdev, dev, &params);
 }
 
+static int nl80211_assoc_ml_reconf(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct cfg80211_assoc_link links[IEEE80211_MLD_MAX_NUM_LINKS] = {};
+	unsigned int link_id;
+	u16 add_links, rem_links;
+	int err;
+
+	if (!wdev->valid_links)
+		return -EINVAL;
+
+	if (dev->ieee80211_ptr->conn_owner_nlportid &&
+	    dev->ieee80211_ptr->conn_owner_nlportid != info->snd_portid)
+		return -EPERM;
+
+	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_STATION &&
+	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_CLIENT)
+		return -EOPNOTSUPP;
+
+	add_links = 0;
+	if (info->attrs[NL80211_ATTR_MLO_LINKS]) {
+		err = nl80211_process_links(rdev, links, NULL, 0, info);
+		if (err)
+			return err;
+
+		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
+		     link_id++) {
+			if (!links[link_id].bss)
+				continue;
+			add_links |= BIT(link_id);
+		}
+	}
+
+	if (info->attrs[NL80211_ATTR_MLO_RECONF_REM_LINKS])
+		rem_links =
+			nla_get_u16(info->attrs[NL80211_ATTR_MLO_RECONF_REM_LINKS]);
+	else
+		rem_links = 0;
+
+	/* Validate that existing links are not added, removed links are valid
+	 * and don't allow adding and removing the same links
+	 */
+	if ((add_links & rem_links) || !(add_links | rem_links) ||
+	    (wdev->valid_links & add_links) ||
+	    ((wdev->valid_links & rem_links) != rem_links)) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	err = cfg80211_assoc_ml_reconf(rdev, dev, links, rem_links);
+
+out:
+	for (link_id = 0; link_id < ARRAY_SIZE(links); link_id++)
+		cfg80211_put_bss(&rdev->wiphy, links[link_id].bss);
+
+	return err;
+}
+
 #define NL80211_FLAG_NEED_WIPHY		0x01
 #define NL80211_FLAG_NEED_NETDEV	0x02
 #define NL80211_FLAG_NEED_RTNL		0x04
@@ -17667,6 +17728,12 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
+	{
+		.cmd = NL80211_CMD_ASSOC_MLO_RECONF,
+		.doit = nl80211_assoc_ml_reconf,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
+	},
 };
 
 static struct genl_family nl80211_fam __ro_after_init = {
@@ -18563,6 +18630,23 @@ void cfg80211_links_removed(struct net_device *dev, u16 link_mask)
 }
 EXPORT_SYMBOL(cfg80211_links_removed);
 
+void nl80211_mlo_reconf_add_done(struct net_device *dev,
+				 struct cfg80211_mlo_reconf_done_data *data)
+{
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct nl80211_mlme_event event = {
+		.cmd = NL80211_CMD_ASSOC_MLO_RECONF,
+		.buf = data->buf,
+		.buf_len = data->len,
+		.uapsd_queues = -1,
+	};
+
+	nl80211_send_mlme_event(rdev, dev, &event, GFP_KERNEL);
+}
+EXPORT_SYMBOL(nl80211_mlo_reconf_add_done);
+
 void nl80211_send_ibss_bssid(struct cfg80211_registered_device *rdev,
 			     struct net_device *netdev, const u8 *bssid,
 			     gfp_t gfp)
diff --git a/net/wireless/nl80211.h b/net/wireless/nl80211.h
index ffaab9a92e5b..5e25782af1e0 100644
--- a/net/wireless/nl80211.h
+++ b/net/wireless/nl80211.h
@@ -124,4 +124,7 @@ void cfg80211_free_coalesce(struct cfg80211_coalesce *coalesce);
 /* peer measurement */
 int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info);
 
+void nl80211_mlo_reconf_add_done(struct net_device *dev,
+				 struct cfg80211_mlo_reconf_done_data *data);
+
 #endif /* __NET_WIRELESS_NL80211_H */
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 8f2aa7e76c0a..2393a25577ad 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1547,4 +1547,23 @@ rdev_get_radio_mask(struct cfg80211_registered_device *rdev,
 
 	return rdev->ops->get_radio_mask(wiphy, dev);
 }
+
+static inline int
+rdev_assoc_ml_reconf(struct cfg80211_registered_device *rdev,
+		     struct net_device *dev,
+		     struct cfg80211_assoc_link *add_links,
+		     u16 rem_links)
+{
+	struct wiphy *wiphy = &rdev->wiphy;
+	int ret = -EOPNOTSUPP;
+
+	trace_rdev_assoc_ml_reconf(wiphy, dev, add_links, rem_links);
+	if (rdev->ops->assoc_ml_reconf)
+		ret = rdev->ops->assoc_ml_reconf(wiphy, dev, add_links,
+						 rem_links);
+	trace_rdev_return_int(wiphy, ret);
+
+	return ret;
+}
+
 #endif /* __CFG80211_RDEV_OPS */
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 41a9f52e1f97..d57e676cb5af 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -4104,6 +4104,50 @@ TRACE_EVENT(cfg80211_links_removed,
 		  __entry->link_mask)
 );
 
+TRACE_EVENT(cfg80211_mlo_reconf_add_done,
+	TP_PROTO(struct net_device *netdev, u16 link_mask,
+		 const u8 *buf, size_t len),
+	TP_ARGS(netdev, link_mask, buf, len),
+	TP_STRUCT__entry(
+		NETDEV_ENTRY
+		__field(u16, link_mask)
+		__dynamic_array(u8, buf, len)
+	),
+	TP_fast_assign(
+		NETDEV_ASSIGN;
+		__entry->link_mask = link_mask;
+		memcpy(__get_dynamic_array(buf), buf, len);
+	),
+	TP_printk(NETDEV_PR_FMT ", link_mask:0x%x",
+		  NETDEV_PR_ARG, __entry->link_mask)
+);
+
+TRACE_EVENT(rdev_assoc_ml_reconf,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		 struct cfg80211_assoc_link *add_links,
+		 u16 rem_links),
+	TP_ARGS(wiphy, netdev, add_links, rem_links),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		NETDEV_ENTRY
+		__field(u16, add_links)
+		__field(u16, rem_links)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
+		u32 i;
+
+		__entry->add_links = 0;
+		__entry->rem_links = rem_links;
+		for (i = 0; add_links && i < IEEE80211_MLD_MAX_NUM_LINKS; i++)
+			if (add_links[i].bss)
+				__entry->add_links |= BIT(i);
+	),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", add_links=0x%x, rem_links=0x%x",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG,
+		  __entry->add_links, __entry->rem_links)
+);
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.34.1


