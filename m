Return-Path: <linux-wireless+bounces-16898-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992139FE288
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 05:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18703A1EA6
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 04:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2902817084F;
	Mon, 30 Dec 2024 04:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V9XIb1Q+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1394C13633F
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 04:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735534593; cv=none; b=rCK8tDUE55RJNkjarpg9z7nV5QNzPd47xlbtiRAE5nJgFa0Lyt3hHlRbu14ldBOjPsx0VagDy0WZe0XGAihrOk5/ECac4HtYn/o3gfKGvuUoYQcUhnE5r02pGYivQoVKk/IMBWX6KMKib3U/q9kUGfeI0LE59VcUqda6AEi5qoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735534593; c=relaxed/simple;
	bh=CLN60kgkUWQg3CcCIJAvad38P2K0Ef2rcFFtfQCtK6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F+wqdLDoyOmTytTEyWw7GNGxqsurO9ZZJ0Bm67iu4Z7MvX6/ZfaIkVS7lGBHKc5inX5pEHpsAexcbGXmjilvl+7EU73dOak7MJynzL5b5mP/w+KopTgklp/a0DMKaA99LyAme+xJwpUDAHY5QDSIg82cvkDmr7a94VOH2CfAhYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V9XIb1Q+; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735534591; x=1767070591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CLN60kgkUWQg3CcCIJAvad38P2K0Ef2rcFFtfQCtK6k=;
  b=V9XIb1Q+R9Duo/LODL08d2iBaBAhiryXUzpDnkhpt8rjHS4KHHG+NJf+
   QmF8xwG6HjPfAvDm+pFVT6H3jd5si0WBL0g1PKU3kCaZfQZphSTXUqTji
   iTO0P8F7F/8dHI53GoWS45FfRloWmweuSzcG9dEe7niZhfy2seqNmSDCk
   6I8pLrME2tZVdlbXr2QO0yhUogCeuuaeHziSG4SFdF0xD8dt1qf7ti1hc
   1ocEajjkCzQyf4wGRTCBA9d2Cq3R8lu9/0SgifcDm0pAocLKceDOpxLTH
   y3fWJ24urDF6wZwoz0+NTT1hKnpLnF1kcCigqJtveKs1SR3C1vbrCsMeQ
   w==;
X-CSE-ConnectionGUID: MvcupgiNReqMqflMtT8UtQ==
X-CSE-MsgGUID: T6M9WYCiTjO3f0956geyYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="46405037"
X-IronPort-AV: E=Sophos;i="6.12,275,1728975600"; 
   d="scan'208";a="46405037"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:31 -0800
X-CSE-ConnectionGUID: xS9trtzISA+oqcjYsuN/ug==
X-CSE-MsgGUID: W5ZCQaaMTJy0My4MkPX0qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104758933"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:29 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 15/15] wifi: cfg80211: Add support for dynamic addition/removal of links
Date: Mon, 30 Dec 2024 06:55:54 +0200
Message-Id: <20241230065327.f646f2c0aa08.I79c849974c494cb1cbf9e1b22a5d2d37395ff5ac@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
References: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
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
index 7790af534b7f..784705e514b7 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4584,6 +4584,15 @@ struct mgmt_frame_regs {
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
@@ -4947,6 +4956,9 @@ struct cfg80211_ops {
 	int	(*set_ttlm)(struct wiphy *wiphy, struct net_device *dev,
 			    struct cfg80211_ttlm_params *params);
 	u32	(*get_radio_mask)(struct wiphy *wiphy, struct net_device *dev);
+	int     (*assoc_ml_reconf)(struct wiphy *wiphy, struct net_device *dev,
+				   struct cfg80211_assoc_link *add_links,
+				   u16 rem_links);
 };
 
 /*
@@ -9704,6 +9716,39 @@ static inline int cfg80211_color_change_notify(struct net_device *dev,
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
index 6d11437596b9..b3ab74516e33 100644
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
@@ -2871,6 +2876,9 @@ enum nl80211_commands {
  * @NL80211_ATTR_VIF_RADIO_MASK: Bitmask of allowed radios (u32).
  *	A value of 0 means all radios.
  *
+ * @NL80211_ATTR_MLO_RECONF_REM_LINKS: (u16) A bitmask of the links requested
+ *      to be removed from the MLO association.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3421,6 +3429,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_VIF_RADIO_MASK,
 
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
index dd9340990ffe..9b4f2f887c23 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -830,6 +830,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_MLO_TTLM_ULINK] = NLA_POLICY_EXACT_LEN(sizeof(u16) * 8),
 	[NL80211_ATTR_ASSOC_SPP_AMSDU] = { .type = NLA_FLAG },
 	[NL80211_ATTR_VIF_RADIO_MASK] = { .type = NLA_U32 },
+	[NL80211_ATTR_MLO_RECONF_REM_LINKS] = { .type = NLA_U16 },
 };
 
 /* policy for the key attributes */
@@ -16443,6 +16444,66 @@ nl80211_set_ttlm(struct sk_buff *skb, struct genl_info *info)
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
@@ -17635,6 +17696,12 @@ static const struct genl_small_ops nl80211_small_ops[] = {
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
@@ -18531,6 +18598,23 @@ void cfg80211_links_removed(struct net_device *dev, u16 link_mask)
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


