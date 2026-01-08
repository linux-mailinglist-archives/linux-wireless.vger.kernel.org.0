Return-Path: <linux-wireless+bounces-30529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 487E7D03D80
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10AB13042045
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B9B36E495;
	Thu,  8 Jan 2026 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VN5LfZnT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F51228151C
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861387; cv=none; b=UOPAGfexL2AyhkmukNvFy7A08VhdCNgU/b2Ir23emm9QK/mnq287HbT2M55xZqFyvI8aY/YPbY7YxCNhYZ1gjgkyhsp8CQPplBCdfZwUuaE7PZk7eidTq42uECvcBi2hQiZsTJ8YYHIiMFda+eN1dLIbfdWZrXMe+CIfj4IUVAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861387; c=relaxed/simple;
	bh=vAC04KiAfGYGmPdvij4UMz1orlY0HM5Yhi7sB+R0wWs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OjN7RdsGRNIMMA5he+JaFQ8CQWjSt2RAS/r0A0zE6DlOh98aD3AuzNPx1GNtJ1nu4Ti0y4oezPCCUn2G7Qk5JHt2NQSOPFv9OtjG4jss9Ou+Q0Th65ODdIx9hFJCRGKTQN1NBhLSGjPeXvwQ4Tnpezze/F3ev9/B1I3PpBVChqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VN5LfZnT; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767861378; x=1799397378;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=vAC04KiAfGYGmPdvij4UMz1orlY0HM5Yhi7sB+R0wWs=;
  b=VN5LfZnTzc238qOso4RfivX9ytV9i75IYVj/vaWDxOLp3XySwE3f8zM2
   hZvu8K0cEme1UkjyWfekqfEq/1pXIwCRzYBF0qgGfFrTRRv7kRGNEqycI
   /IAcOTdIjtFrYWfzhkdACXc7b0m9RPOTz+Peum7ohG5hWQE7Aa9C8GCH8
   OMsH4yOOEQYikfxdSsYEvzmNyMDWzlB+o0EX7Onv0z+Aoc8DInGnQExbh
   NDjQj0W+N3iUPcQMe76WD/UUlNyCyIhWKmOHoYo1wwimkuniAecxc3tRj
   /axCgyLxkDZCk6xTSByO19SxRbSw2LEky1YsWUbySuXz85xkbeauu4ciL
   g==;
X-CSE-ConnectionGUID: ZNVpsKx1R6W1b1P7Y04bRA==
X-CSE-MsgGUID: 5AyGT4dbS1+stWkG/ek0jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="73084794"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="73084794"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:36:03 -0800
X-CSE-ConnectionGUID: RRqHlh5USN+OYqGA4PjDtw==
X-CSE-MsgGUID: tC5GbZcnTmGkw/yiD/y+JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="233847497"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:36:01 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next v2 09/14] wifi: cfg80211: add support for NAN data interface
Date: Thu,  8 Jan 2026 10:35:35 +0200
Message-Id: <20260108102921.80e3465da9d1.I92973483e927820ae2297853c141842fdb262747@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108083540.3129471-1-miriam.rachel.korenblit@intel.com>
References: <20260108083540.3129471-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This new interface type represents a NAN data interface (NDI).
It is used for data communication with NAN peers.

Note that the existing NL80211_IFTYPE_NAN interface, which is the NAN
Management Interface (NMI), is used for management communication.

An NDI interface is started when a new NAN data path is about to
be established, and is stopped after the NAN data path is terminated.

- An NDI interface can only be started if the NMI is running, and NAN is
  started.
- Before the NMI is stopped, the NDI interfaces will be stopped.

Add the new interface type, handle add/remove operations for it,
and makes sure of the conditions above.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       | 21 +++++++++++
 include/uapi/linux/nl80211.h |  4 ++
 net/mac80211/cfg.c           |  1 +
 net/mac80211/chan.c          |  2 +
 net/mac80211/iface.c         |  3 ++
 net/mac80211/rx.c            |  2 +
 net/mac80211/util.c          |  1 +
 net/wireless/chan.c          |  2 +
 net/wireless/core.c          | 73 ++++++++++++++++++++++++++++++++----
 net/wireless/core.h          |  5 +++
 net/wireless/nl80211.c       | 14 ++++++-
 net/wireless/reg.c           | 12 ++++--
 net/wireless/sysfs.c         | 27 ++++++-------
 net/wireless/util.c          | 19 +++++++++-
 14 files changed, 159 insertions(+), 27 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7b8e408528a4..bae0d3f27315 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3926,6 +3926,27 @@ struct cfg80211_qos_map {
 	struct cfg80211_dscp_range up[8];
 };
 
+/**
+ * DOC: Neighbor Awareness Networking (NAN)
+ *
+ * NAN uses two interface types:
+ *
+ * - %NL80211_IFTYPE_NAN: a non-netdev interface. This has two roles: (1) holds
+ *   the configuration of all NAN activities (DE parameters, synchronisation
+ *   parameters, local schedule, etc.), and (2) uses as the NAN Management
+ *   Interface (NMI), which is used for NAN management communication.
+ *
+ * - %NL80211_IFTYPE_NAN_DATA: The NAN Data Interface (NDI), used for data
+ *   communication with NAN peers.
+ *
+ * An NDI interface can only be started (IFF_UP) if the NMI one is running and
+ * NAN is started. Before NAN is stopped, all associated NDI interfaces
+ * must be stopped first.
+ *
+ * The local schedule specifies which channels the device is available on and
+ * when. Must be cancelled before NAN is stopped.
+ */
+
 /**
  * struct cfg80211_nan_band_config - NAN band specific configuration
  *
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 005521d22d29..27fabbdab8c6 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3672,6 +3672,9 @@ enum nl80211_attrs {
  * @NL80211_IFTYPE_OCB: Outside Context of a BSS
  *	This mode corresponds to the MIB variable dot11OCBActivated=true
  * @NL80211_IFTYPE_NAN: NAN device interface type (not a netdev)
+ * @NL80211_IFTYPE_NAN_DATA: NAN data interface type (netdev); NAN data
+ *	interfaces can only be brought up (IFF_UP) when a NAN interface
+ *	already exists and NAN has been started (using %NL80211_CMD_START_NAN).
  * @NL80211_IFTYPE_MAX: highest interface type number currently defined
  * @NUM_NL80211_IFTYPES: number of defined interface types
  *
@@ -3693,6 +3696,7 @@ enum nl80211_iftype {
 	NL80211_IFTYPE_P2P_DEVICE,
 	NL80211_IFTYPE_OCB,
 	NL80211_IFTYPE_NAN,
+	NL80211_IFTYPE_NAN_DATA,
 
 	/* keep last */
 	NUM_NL80211_IFTYPES,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 1af00ce89a3f..f034dcc4bdaa 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -718,6 +718,7 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 	case NL80211_IFTYPE_P2P_CLIENT:
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_OCB:
+	case NL80211_IFTYPE_NAN_DATA:
 		/* shouldn't happen */
 		WARN_ON_ONCE(1);
 		break;
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index d0bfb1216401..b9f1b336609c 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -485,6 +485,7 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 		case NUM_NL80211_IFTYPES:
 		case NL80211_IFTYPE_P2P_CLIENT:
 		case NL80211_IFTYPE_P2P_GO:
+		case NL80211_IFTYPE_NAN_DATA:
 			WARN_ON_ONCE(1);
 		}
 
@@ -1411,6 +1412,7 @@ ieee80211_link_chanctx_reservation_complete(struct ieee80211_link_data *link)
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
 	case NUM_NL80211_IFTYPES:
 		WARN_ON(1);
 		break;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 7b0aa24c1f97..88a47272cffc 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1365,6 +1365,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_OCB:
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
 		/* no special treatment */
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
@@ -1925,6 +1926,8 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	case NL80211_IFTYPE_P2P_DEVICE:
 		sdata->vif.bss_conf.bssid = sdata->vif.addr;
 		break;
+	case NL80211_IFTYPE_NAN_DATA:
+		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_WDS:
 	case NUM_NL80211_IFTYPES:
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index e0ccd9749853..84888927496b 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4603,6 +4603,8 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			(ieee80211_is_public_action(hdr, skb->len) ||
 			 (ieee80211_is_auth(hdr->frame_control) &&
 			  ether_addr_equal(sdata->vif.addr, hdr->addr1)));
+	case NL80211_IFTYPE_NAN_DATA:
+		return false;
 	default:
 		break;
 	}
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0c46009a3d63..7060269a2f4f 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2061,6 +2061,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 				return res;
 			}
 			break;
+		case NL80211_IFTYPE_NAN_DATA:
 		case NL80211_IFTYPE_AP_VLAN:
 		case NL80211_IFTYPE_MONITOR:
 		case NL80211_IFTYPE_P2P_DEVICE:
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 0dde8f3007f0..6f8386e14043 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -769,6 +769,7 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_P2P_DEVICE:
+	case NL80211_IFTYPE_NAN_DATA:
 		break;
 	case NL80211_IFTYPE_WDS:
 	case NL80211_IFTYPE_UNSPECIFIED:
@@ -892,6 +893,7 @@ bool cfg80211_beaconing_iface_active(struct wireless_dev *wdev)
 	case NL80211_IFTYPE_P2P_DEVICE:
 	/* Can NAN type be considered as beaconing interface? */
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_WDS:
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 0429ee8237e1..6c55f1d7bcdc 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -316,16 +316,21 @@ void cfg80211_shutdown_all_interfaces(struct wiphy *wiphy)
 
 	ASSERT_RTNL();
 
+	/*
+	 * Some netdev interfaces need to be closed before some non-netdev
+	 * ones, i.e. NAN_DATA interfaces need to be closed before the NAN
+	 * interface
+	 */
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 		if (wdev->netdev) {
 			dev_close(wdev->netdev);
 			continue;
 		}
+	}
 
-		/* otherwise, check iftype */
-
-		guard(wiphy)(wiphy);
+	guard(wiphy)(wiphy);
 
+	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 		switch (wdev->iftype) {
 		case NL80211_IFTYPE_P2P_DEVICE:
 			cfg80211_stop_p2p_device(rdev, wdev);
@@ -393,6 +398,21 @@ void cfg80211_destroy_ifaces(struct cfg80211_registered_device *rdev)
 	}
 }
 
+void cfg80211_close_dependents(struct cfg80211_registered_device *rdev,
+			       struct wireless_dev *wdev)
+{
+	ASSERT_RTNL();
+
+	if (wdev->iftype != NL80211_IFTYPE_NAN)
+		return;
+
+	/* Close all NAN DATA interfaces */
+	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
+		if (wdev->iftype == NL80211_IFTYPE_NAN_DATA)
+			dev_close(wdev->netdev);
+	}
+}
+
 static void cfg80211_destroy_iface_wk(struct work_struct *work)
 {
 	struct cfg80211_registered_device *rdev;
@@ -804,6 +824,10 @@ int wiphy_register(struct wiphy *wiphy)
 		     !(wiphy->nan_supported_bands & BIT(NL80211_BAND_2GHZ)))))
 		return -EINVAL;
 
+	if (WARN_ON((wiphy->interface_modes & BIT(NL80211_IFTYPE_NAN_DATA)) &&
+		    wiphy->n_radio > 1))
+		return -EINVAL;
+
 	if (WARN_ON(wiphy->interface_modes & BIT(NL80211_IFTYPE_WDS)))
 		return -EINVAL;
 
@@ -1410,8 +1434,8 @@ void cfg80211_update_iface_num(struct cfg80211_registered_device *rdev,
 		rdev->num_running_monitor_ifaces += num;
 }
 
-void cfg80211_leave(struct cfg80211_registered_device *rdev,
-		    struct wireless_dev *wdev)
+void cfg80211_leave_locked(struct cfg80211_registered_device *rdev,
+			   struct wireless_dev *wdev)
 {
 	struct net_device *dev = wdev->netdev;
 	struct cfg80211_sched_scan_request *pos, *tmp;
@@ -1460,6 +1484,7 @@ void cfg80211_leave(struct cfg80211_registered_device *rdev,
 		break;
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_MONITOR:
+	case NL80211_IFTYPE_NAN_DATA:
 		/* nothing to do */
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
@@ -1470,6 +1495,19 @@ void cfg80211_leave(struct cfg80211_registered_device *rdev,
 	}
 }
 
+void cfg80211_leave(struct cfg80211_registered_device *rdev,
+		    struct wireless_dev *wdev)
+{
+	ASSERT_RTNL();
+
+	/* NAN_DATA interfaces must be closed before stopping NAN */
+	cfg80211_close_dependents(rdev, wdev);
+
+	guard(wiphy)(&rdev->wiphy);
+
+	cfg80211_leave_locked(rdev, wdev);
+}
+
 void cfg80211_stop_iface(struct wiphy *wiphy, struct wireless_dev *wdev,
 			 gfp_t gfp)
 {
@@ -1479,6 +1517,9 @@ void cfg80211_stop_iface(struct wiphy *wiphy, struct wireless_dev *wdev,
 
 	trace_cfg80211_stop_iface(wiphy, wdev);
 
+	if (wdev->iftype == NL80211_IFTYPE_NAN)
+		return;
+
 	ev = kzalloc(sizeof(*ev), gfp);
 	if (!ev)
 		return;
@@ -1628,10 +1669,9 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		}
 		break;
 	case NETDEV_GOING_DOWN:
-		scoped_guard(wiphy, &rdev->wiphy) {
-			cfg80211_leave(rdev, wdev);
+		cfg80211_leave(rdev, wdev);
+		scoped_guard(wiphy, &rdev->wiphy)
 			cfg80211_remove_links(wdev);
-		}
 		/* since we just did cfg80211_leave() nothing to do there */
 		cancel_work_sync(&wdev->disconnect_wk);
 		cancel_work_sync(&wdev->pmsr_free_wk);
@@ -1712,6 +1752,23 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 
 		if (rfkill_blocked(rdev->wiphy.rfkill))
 			return notifier_from_errno(-ERFKILL);
+
+		/* NAN_DATA interfaces require a running NAN interface */
+		if (wdev->iftype == NL80211_IFTYPE_NAN_DATA) {
+			struct wireless_dev *iter;
+			bool nan_started = false;
+
+			list_for_each_entry(iter, &rdev->wiphy.wdev_list, list) {
+				if (iter->iftype == NL80211_IFTYPE_NAN &&
+				    wdev_running(iter)) {
+					nan_started = true;
+					break;
+				}
+			}
+
+			if (!nan_started)
+				return notifier_from_errno(-ENOLINK);
+		}
 		break;
 	default:
 		return NOTIFY_DONE;
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 463fbcefca49..2ab52fb15584 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -317,6 +317,9 @@ void cfg80211_cqm_rssi_notify_work(struct wiphy *wiphy,
 
 void cfg80211_destroy_ifaces(struct cfg80211_registered_device *rdev);
 
+void cfg80211_close_dependents(struct cfg80211_registered_device *rdev,
+			       struct wireless_dev *wdev);
+
 /* free object */
 void cfg80211_dev_free(struct cfg80211_registered_device *rdev);
 
@@ -536,6 +539,8 @@ int cfg80211_validate_beacon_int(struct cfg80211_registered_device *rdev,
 void cfg80211_update_iface_num(struct cfg80211_registered_device *rdev,
 			       enum nl80211_iftype iftype, int num);
 
+void cfg80211_leave_locked(struct cfg80211_registered_device *rdev,
+			   struct wireless_dev *wdev);
 void cfg80211_leave(struct cfg80211_registered_device *rdev,
 		    struct wireless_dev *wdev);
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 5831a9b7a2c8..cf63f114bd1c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1684,6 +1684,7 @@ static int nl80211_key_allowed(struct wireless_dev *wdev)
 			return 0;
 		return -ENOLINK;
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
 		if (wiphy_ext_feature_isset(wdev->wiphy,
 					    NL80211_EXT_FEATURE_SECURE_NAN))
 			return 0;
@@ -4803,6 +4804,8 @@ static int nl80211_del_interface(struct sk_buff *skb, struct genl_info *info)
 	else
 		dev_close(wdev->netdev);
 
+	cfg80211_close_dependents(rdev, wdev);
+
 	mutex_lock(&rdev->wiphy.mtx);
 
 	return cfg80211_remove_virtual_intf(rdev, wdev);
@@ -15773,6 +15776,10 @@ static int nl80211_stop_nan(struct sk_buff *skb, struct genl_info *info)
 	if (wdev->iftype != NL80211_IFTYPE_NAN)
 		return -EOPNOTSUPP;
 
+	cfg80211_close_dependents(rdev, wdev);
+
+	guard(wiphy)(&rdev->wiphy);
+
 	cfg80211_stop_nan(rdev, wdev);
 
 	return 0;
@@ -18059,7 +18066,11 @@ nl80211_epcs_cfg(struct sk_buff *skb, struct genl_info *info)
 		 NL80211_FLAG_NEED_RTNL)		\
 	SELECTOR(__sel, WIPHY_CLEAR,			\
 		 NL80211_FLAG_NEED_WIPHY |		\
-		 NL80211_FLAG_CLEAR_SKB)
+		 NL80211_FLAG_CLEAR_SKB)		\
+	SELECTOR(__sel, WDEV_UP_RTNL_NOMTX,		\
+		 NL80211_FLAG_NEED_WDEV_UP |		\
+		 NL80211_FLAG_NO_WIPHY_MTX |		\
+		 NL80211_FLAG_NEED_RTNL)
 
 enum nl80211_internal_flags_selector {
 #define SELECTOR(_, name, value)	NL80211_IFL_SEL_##name,
@@ -18896,6 +18907,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_stop_nan,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP |
+					 NL80211_FLAG_NO_WIPHY_MTX |
 					 NL80211_FLAG_NEED_RTNL),
 	},
 	{
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 029499595bdf..488267a1a354 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2411,6 +2411,9 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 				continue;
 			chandef = wdev->u.ocb.chandef;
 			break;
+		case NL80211_IFTYPE_NAN_DATA:
+			/* NAN channels are checked in NL80211_IFTYPE_NAN interface */
+			break;
 		default:
 			/* others not implemented for now */
 			WARN_ON_ONCE(1);
@@ -2447,11 +2450,14 @@ static void reg_leave_invalid_chans(struct wiphy *wiphy)
 	struct wireless_dev *wdev;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
-	guard(wiphy)(wiphy);
+	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
+		bool valid;
 
-	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list)
-		if (!reg_wdev_chan_valid(wiphy, wdev))
+		scoped_guard(wiphy, wiphy)
+			valid = reg_wdev_chan_valid(wiphy, wdev);
+		if (!valid)
 			cfg80211_leave(rdev, wdev);
+	}
 }
 
 static void reg_check_chans_work(struct work_struct *work)
diff --git a/net/wireless/sysfs.c b/net/wireless/sysfs.c
index 77762938edb8..1879adc058e0 100644
--- a/net/wireless/sysfs.c
+++ b/net/wireless/sysfs.c
@@ -102,25 +102,26 @@ static int wiphy_suspend(struct device *dev)
 	if (!rdev->wiphy.registered)
 		goto out_unlock_rtnl;
 
-	wiphy_lock(&rdev->wiphy);
 	if (rdev->wiphy.wowlan_config) {
-		cfg80211_process_wiphy_works(rdev, NULL);
-		if (rdev->ops->suspend)
-			ret = rdev_suspend(rdev, rdev->wiphy.wowlan_config);
-		if (ret <= 0)
-			goto out_unlock_wiphy;
+		scoped_guard(wiphy, &rdev->wiphy) {
+			cfg80211_process_wiphy_works(rdev, NULL);
+			if (rdev->ops->suspend)
+				ret = rdev_suspend(rdev,
+						   rdev->wiphy.wowlan_config);
+			if (ret <= 0)
+				goto out_unlock_rtnl;
+		}
 	}
 
 	/* Driver refused to configure wowlan (ret = 1) or no wowlan */
 
 	cfg80211_leave_all(rdev);
-	cfg80211_process_rdev_events(rdev);
-	cfg80211_process_wiphy_works(rdev, NULL);
-	if (rdev->ops->suspend)
-		ret = rdev_suspend(rdev, NULL);
-
-out_unlock_wiphy:
-	wiphy_unlock(&rdev->wiphy);
+	scoped_guard(wiphy, &rdev->wiphy) {
+		cfg80211_process_rdev_events(rdev);
+		cfg80211_process_wiphy_works(rdev, NULL);
+		if (rdev->ops->suspend)
+			ret = rdev_suspend(rdev, NULL);
+	}
 out_unlock_rtnl:
 	if (ret == 0)
 		rdev->suspended = true;
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 3c38d830cf2b..076fe39b630f 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1144,7 +1144,14 @@ void cfg80211_process_wdev_events(struct wireless_dev *wdev)
 					       ev->ij.channel);
 			break;
 		case EVENT_STOPPED:
-			cfg80211_leave(wiphy_to_rdev(wdev->wiphy), wdev);
+			/*
+			 * for NAN interfaces cfg80211_leave must be called but
+			 * locking here doesn't allow this.
+			 */
+			if (WARN_ON(wdev->iftype == NL80211_IFTYPE_NAN))
+				break;
+
+			cfg80211_leave_locked(wiphy_to_rdev(wdev->wiphy), wdev);
 			break;
 		case EVENT_PORT_AUTHORIZED:
 			__cfg80211_port_authorized(wdev, ev->pa.peer_addr,
@@ -1183,6 +1190,13 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 	if (otype == NL80211_IFTYPE_AP_VLAN)
 		return -EOPNOTSUPP;
 
+	/*
+	 * for NAN interfaces cfg80211_leave must be called for leaving,
+	 * but locking here doesn't allow this.
+	 */
+	if (otype == NL80211_IFTYPE_NAN)
+		return -EOPNOTSUPP;
+
 	/* cannot change into P2P device or NAN */
 	if (ntype == NL80211_IFTYPE_P2P_DEVICE ||
 	    ntype == NL80211_IFTYPE_NAN)
@@ -1203,7 +1217,7 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 		dev->ieee80211_ptr->use_4addr = false;
 		rdev_set_qos_map(rdev, dev, NULL);
 
-		cfg80211_leave(rdev, dev->ieee80211_ptr);
+		cfg80211_leave_locked(rdev, dev->ieee80211_ptr);
 
 		cfg80211_process_rdev_events(rdev);
 		cfg80211_mlme_purge_registrations(dev->ieee80211_ptr);
@@ -1231,6 +1245,7 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 		case NL80211_IFTYPE_OCB:
 		case NL80211_IFTYPE_P2P_CLIENT:
 		case NL80211_IFTYPE_ADHOC:
+		case NL80211_IFTYPE_NAN_DATA:
 			dev->priv_flags |= IFF_DONT_BRIDGE;
 			break;
 		case NL80211_IFTYPE_P2P_GO:
-- 
2.34.1


