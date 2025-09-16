Return-Path: <linux-wireless+bounces-27355-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8549B7D840
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E621F16B241
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E5C329506;
	Tue, 16 Sep 2025 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="jggLwJZP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE73E2F9DAF
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061201; cv=none; b=ZrUk8x1V+e0yV3ujx324wgJNvTqg83gkQ/+jeKxi3sUTYgysUNMMdKpervsBYqc3p3PykgUWGfS3cgMboFXvkUqf1wAAE88Aj+1oOHYJLod/ul5WSWGf0eYscpJpoiwmIOZPW7BynQfK0+Zk1tdPvjSbQ9Iv/FKbYF7UN2aXdRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061201; c=relaxed/simple;
	bh=pDw/UXo+B6azJZKjz74Lbo3wv6fcTQPvILuWNzEHwwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMe+lxOVC6bh8N5STVroJI5JG6Hgc5ZySbfnc2AKYSrBAJU01D4pO+nxrTXm8hC/daNqbFwS4qK0M9uP4G2zXfQ2eUZzmjFrOy8Tm5RIH4ZWDYDXmfpF/p3R83vn0mntTrYkmVpeynPIGKChV8votcYhjgeC/Njyg5lJ6jNtk6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=jggLwJZP; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061199; x=1789597199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pDw/UXo+B6azJZKjz74Lbo3wv6fcTQPvILuWNzEHwwM=;
  b=jggLwJZPpwvFaf9zqGr+H0mc8S+whDmF9O1c8rN7y9uVNI0UrAMHD0MZ
   ejgqgqDVmtkE4/z97sMwWZBSfCWRbxDo43btZepMhrykDI5p6kx6VDxNB
   oUONUSp/QZOw1RfkKvm6a0qGysHFdRpy1oM+pIb9l3i0uty21c9AMi1Wv
   s=;
X-CSE-ConnectionGUID: 5C59Y9ygQrK+K3ykrRN2bw==
X-CSE-MsgGUID: kqPB3bbNTvyZWJuguDf41g==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="64783232"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="64783232"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:18:48 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:18:47 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:18:44 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 01/57] wifi: nl80211/cfg80211: introduce new iface type for WLAN Sensing operation
Date: Wed, 17 Sep 2025 03:47:16 +0530
Message-ID: <20250916221821.4387-2-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE806.infineon.com (172.23.29.32) To
 MUCSE827.infineon.com (172.23.29.20)

WLAN sensing operation uses signal processing on the Wi-Fi signals received
by a station device to detect physical obstructions and interpret movements
with the help of Channel State Information (CSI), defined in IEEE 802.11bf.

Introduce a new wdev (non-netdev) interface type WLAN SENSE for 802.11bf,
similar to a NAN or P2P Discovery interface. This new wdev interface helps
in separating WLAN Sensing operation and the normal WLAN traffic. Also this
new interface is used for any 802.11 frame exchanges to be done as part of
the WLAN Sensing Measurement operation. Also add new WLAN SENSE Start and
Stop nl80211 commends to allow the userspace to control this interface.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 include/net/cfg80211.h       |  7 ++++
 include/uapi/linux/nl80211.h | 11 +++++++
 net/mac80211/cfg.c           |  1 +
 net/mac80211/chan.c          |  2 ++
 net/mac80211/iface.c         |  2 ++
 net/mac80211/util.c          |  1 +
 net/wireless/chan.c          |  2 ++
 net/wireless/core.c          | 26 +++++++++++++++
 net/wireless/nl80211.c       | 63 ++++++++++++++++++++++++++++++++++++
 net/wireless/rdev-ops.h      | 19 +++++++++++
 net/wireless/trace.h         | 10 ++++++
 net/wireless/util.c          |  1 +
 12 files changed, 145 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4072a67c9cc9..d6145556fcf4 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4762,6 +4762,8 @@ struct mgmt_frame_regs {
  *	links by calling cfg80211_mlo_reconf_add_done(). When calling
  *	cfg80211_mlo_reconf_add_done() the bss pointer must be given for each
  *	link for which MLO reconfiguration 'add' operation was requested.
+ * @start_wlan_sense: Start the wlan sense device.
+ * @stop_wlan_sense: Stop the given wlan sense device.
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -5133,6 +5135,11 @@ struct cfg80211_ops {
 				   struct cfg80211_ml_reconf_req *req);
 	int	(*set_epcs)(struct wiphy *wiphy, struct net_device *dev,
 			    bool val);
+
+	int	(*start_wlan_sense)(struct wiphy *wiphy,
+				    struct wireless_dev *wdev);
+	void	(*stop_wlan_sense)(struct wiphy *wiphy,
+				   struct wireless_dev *wdev);
 };
 
 /*
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index aed0b4c5d5e8..5599fb9d2f08 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1344,6 +1344,12 @@
  *	control EPCS configuration. Used to notify userland on the current state
  *	of EPCS.
  *
+ * @NL80211_CMD_START_WLAN_SENSE: Start WLAN SENSE operation, identified
+ *	by its %NL80211_ATTR_WDEV interface. This interface must have been
+ *	previously created with %NL80211_CMD_NEW_INTERFACE.
+ * @NL80211_CMD_STOP_WLAN_SENSE: Stop WLAN SENSE operation, identified by
+ *	its %NL80211_ATTR_WDEV interface.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1604,6 +1610,9 @@ enum nl80211_commands {
 	NL80211_CMD_ASSOC_MLO_RECONF,
 	NL80211_CMD_EPCS_CFG,
 
+	NL80211_CMD_START_WLAN_SENSE,
+	NL80211_CMD_STOP_WLAN_SENSE,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -3592,6 +3601,7 @@ enum nl80211_attrs {
  * @NL80211_IFTYPE_OCB: Outside Context of a BSS
  *	This mode corresponds to the MIB variable dot11OCBActivated=true
  * @NL80211_IFTYPE_NAN: NAN device interface type (not a netdev)
+ * @NL80211_IFTYPE_WLAN_SENSE: WLAN Sensing device interface type (not a netdev)
  * @NL80211_IFTYPE_MAX: highest interface type number currently defined
  * @NUM_NL80211_IFTYPES: number of defined interface types
  *
@@ -3613,6 +3623,7 @@ enum nl80211_iftype {
 	NL80211_IFTYPE_P2P_DEVICE,
 	NL80211_IFTYPE_OCB,
 	NL80211_IFTYPE_NAN,
+	NL80211_IFTYPE_WLAN_SENSE,
 
 	/* keep last */
 	NUM_NL80211_IFTYPES,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b26f61f13605..9f62f30a842c 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -592,6 +592,7 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_WLAN_SENSE:
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NUM_NL80211_IFTYPES:
 	case NL80211_IFTYPE_P2P_CLIENT:
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 57065714cf8c..5b304988e712 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -353,6 +353,7 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 			break;
 		case NL80211_IFTYPE_P2P_DEVICE:
 		case NL80211_IFTYPE_NAN:
+		case NL80211_IFTYPE_WLAN_SENSE:
 			continue;
 		case NL80211_IFTYPE_MONITOR:
 			WARN_ON_ONCE(!ieee80211_hw_check(&local->hw,
@@ -1301,6 +1302,7 @@ ieee80211_link_chanctx_reservation_complete(struct ieee80211_link_data *link)
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_WLAN_SENSE:
 	case NUM_NL80211_IFTYPES:
 		WARN_ON(1);
 		break;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 07ba68f7cd81..2537c4255efc 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1320,6 +1320,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_OCB:
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_WLAN_SENSE:
 		/* no special treatment */
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
@@ -1888,6 +1889,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	case NL80211_IFTYPE_P2P_DEVICE:
 		sdata->vif.bss_conf.bssid = sdata->vif.addr;
 		break;
+	case NL80211_IFTYPE_WLAN_SENSE:
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_WDS:
 	case NUM_NL80211_IFTYPES:
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 9eb35e3b9e52..3a6c2536f338 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2064,6 +2064,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		case NL80211_IFTYPE_AP_VLAN:
 		case NL80211_IFTYPE_MONITOR:
 		case NL80211_IFTYPE_P2P_DEVICE:
+		case NL80211_IFTYPE_WLAN_SENSE:
 			/* nothing to do */
 			break;
 		case NL80211_IFTYPE_UNSPECIFIED:
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 193734b7f9dc..3593a48f9a15 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -769,6 +769,7 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_WLAN_SENSE:
 		break;
 	case NL80211_IFTYPE_WDS:
 	case NL80211_IFTYPE_UNSPECIFIED:
@@ -892,6 +893,7 @@ bool cfg80211_beaconing_iface_active(struct wireless_dev *wdev)
 	case NL80211_IFTYPE_P2P_DEVICE:
 	/* Can NAN type be considered as beaconing interface? */
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_WLAN_SENSE:
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_WDS:
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 797f9f2004a6..a8e982ae8628 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -265,6 +265,23 @@ void cfg80211_stop_nan(struct cfg80211_registered_device *rdev,
 	rdev->opencount--;
 }
 
+void cfg80211_stop_wlan_sense(struct cfg80211_registered_device *rdev,
+			      struct wireless_dev *wdev)
+{
+	lockdep_assert_held(&rdev->wiphy.mtx);
+
+	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_WLAN_SENSE))
+		return;
+
+	if (!wdev_running(wdev))
+		return;
+
+	rdev_stop_wlan_sense(rdev, wdev);
+	wdev->is_running = false;
+
+	rdev->opencount--;
+}
+
 void cfg80211_shutdown_all_interfaces(struct wiphy *wiphy)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
@@ -667,6 +684,11 @@ int wiphy_verify_iface_combinations(struct wiphy *wiphy,
 				    c->limits[j].max > 1))
 				return -EINVAL;
 
+			/* Only a single WLAN Sense interface can be allowed */
+			if (WARN_ON(types & BIT(NL80211_IFTYPE_WLAN_SENSE) &&
+				    c->limits[j].max > 1))
+				return -EINVAL;
+
 			/*
 			 * This isn't well-defined right now. If you have an
 			 * IBSS interface, then its beacon interval may change
@@ -1297,6 +1319,9 @@ static void _cfg80211_unregister_wdev(struct wireless_dev *wdev,
 	case NL80211_IFTYPE_NAN:
 		cfg80211_stop_nan(rdev, wdev);
 		break;
+	case NL80211_IFTYPE_WLAN_SENSE:
+		cfg80211_stop_wlan_sense(rdev, wdev);
+		break;
 	default:
 		break;
 	}
@@ -1400,6 +1425,7 @@ void cfg80211_leave(struct cfg80211_registered_device *rdev,
 		break;
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_WLAN_SENSE:
 		/* cannot happen, has no netdev */
 		break;
 	case NL80211_IFTYPE_AP_VLAN:
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b7bc7e5e81dd..70717af1fbcd 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1642,6 +1642,7 @@ static int nl80211_key_allowed(struct wireless_dev *wdev)
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_WDS:
+	case NL80211_IFTYPE_WLAN_SENSE:
 	case NUM_NL80211_IFTYPES:
 		return -EINVAL;
 	}
@@ -4642,6 +4643,7 @@ static int _nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 		       wdev->u.mesh.id_up_len);
 		break;
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_WLAN_SENSE:
 	case NL80211_IFTYPE_P2P_DEVICE:
 		/*
 		 * P2P Device and NAN do not have a netdev, so don't go
@@ -13687,6 +13689,7 @@ static int nl80211_register_mgmt(struct sk_buff *skb, struct genl_info *info)
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_P2P_DEVICE:
+	case NL80211_IFTYPE_WLAN_SENSE:
 		break;
 	case NL80211_IFTYPE_NAN:
 		if (!wiphy_ext_feature_isset(wdev->wiphy,
@@ -13748,6 +13751,7 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_P2P_GO:
+	case NL80211_IFTYPE_WLAN_SENSE:
 		break;
 	case NL80211_IFTYPE_NAN:
 		if (!wiphy_ext_feature_isset(wdev->wiphy,
@@ -13872,6 +13876,7 @@ static int nl80211_tx_mgmt_cancel_wait(struct sk_buff *skb, struct genl_info *in
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_P2P_DEVICE:
+	case NL80211_IFTYPE_WLAN_SENSE:
 		break;
 	case NL80211_IFTYPE_NAN:
 		if (!wiphy_ext_feature_isset(wdev->wiphy,
@@ -15455,6 +15460,50 @@ static int nl80211_stop_nan(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+static int nl80211_start_wlan_sense(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct wireless_dev *wdev = info->user_ptr[1];
+	int err;
+
+	if (wdev->iftype != NL80211_IFTYPE_WLAN_SENSE)
+		return -EOPNOTSUPP;
+
+	if (!rdev->ops->start_wlan_sense)
+		return -EOPNOTSUPP;
+
+	if (wdev_running(wdev))
+		return -EEXIST;
+
+	if (rfkill_blocked(rdev->wiphy.rfkill))
+		return -ERFKILL;
+
+	err = rdev_start_wlan_sense(rdev, wdev);
+	if (err)
+		return err;
+
+	wdev->is_running = true;
+	rdev->opencount++;
+
+	return 0;
+}
+
+static int nl80211_stop_wlan_sense(struct sk_buff *skb, struct genl_info *info)
+{
+	struct cfg80211_registered_device *rdev = info->user_ptr[0];
+	struct wireless_dev *wdev = info->user_ptr[1];
+
+	if (wdev->iftype != NL80211_IFTYPE_WLAN_SENSE)
+		return -EOPNOTSUPP;
+
+	if (!rdev->ops->stop_wlan_sense)
+		return -EOPNOTSUPP;
+
+	cfg80211_stop_wlan_sense(rdev, wdev);
+
+	return 0;
+}
+
 static int validate_nan_filter(struct nlattr *filter_attr)
 {
 	struct nlattr *attr;
@@ -18755,6 +18804,20 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
+	{
+		.cmd = NL80211_CMD_START_WLAN_SENSE,
+		.doit = nl80211_start_wlan_sense,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV |
+					 NL80211_FLAG_NEED_RTNL),
+	},
+	{
+		.cmd = NL80211_CMD_STOP_WLAN_SENSE,
+		.doit = nl80211_stop_wlan_sense,
+		.flags = GENL_UNS_ADMIN_PERM,
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP |
+					 NL80211_FLAG_NEED_RTNL),
+	},
 };
 
 static struct genl_family nl80211_fam __ro_after_init = {
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index ac6884bacf3f..eb599b9f33d1 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1060,6 +1060,25 @@ rdev_nan_change_conf(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
+static inline int rdev_start_wlan_sense(struct cfg80211_registered_device *rdev,
+					struct wireless_dev *wdev)
+{
+	int ret;
+
+	trace_rdev_start_wlan_sense(&rdev->wiphy, wdev);
+	ret = rdev->ops->start_wlan_sense(&rdev->wiphy, wdev);
+	trace_rdev_return_int(&rdev->wiphy, ret);
+	return ret;
+}
+
+static inline void rdev_stop_wlan_sense(struct cfg80211_registered_device *rdev,
+					struct wireless_dev *wdev)
+{
+	trace_rdev_stop_wlan_sense(&rdev->wiphy, wdev);
+	rdev->ops->stop_wlan_sense(&rdev->wiphy, wdev);
+	trace_rdev_return_void(&rdev->wiphy);
+}
+
 static inline int rdev_set_mac_acl(struct cfg80211_registered_device *rdev,
 				   struct net_device *dev,
 				   struct cfg80211_acl_data *params)
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 9b6074155d59..91109c27e7a6 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2372,6 +2372,16 @@ TRACE_EVENT(rdev_del_nan_func,
 		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->cookie)
 );
 
+DEFINE_EVENT(wiphy_wdev_evt, rdev_start_wlan_sense,
+	     TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev),
+	     TP_ARGS(wiphy, wdev)
+);
+
+DEFINE_EVENT(wiphy_wdev_evt, rdev_stop_wlan_sense,
+	     TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev),
+	     TP_ARGS(wiphy, wdev)
+);
+
 TRACE_EVENT(rdev_set_mac_acl,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
 		 struct cfg80211_acl_data *params),
diff --git a/net/wireless/util.c b/net/wireless/util.c
index d12d49134c88..6cffd01c4668 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1297,6 +1297,7 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 		case NL80211_IFTYPE_P2P_DEVICE:
 		case NL80211_IFTYPE_WDS:
 		case NL80211_IFTYPE_NAN:
+		case NL80211_IFTYPE_WLAN_SENSE:
 			WARN_ON(1);
 			break;
 		}
-- 
2.25.1


