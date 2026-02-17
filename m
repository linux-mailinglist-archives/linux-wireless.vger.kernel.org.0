Return-Path: <linux-wireless+bounces-31939-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAJDEJlXlGkXDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31939-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:57:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7325314BA90
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FA99300A25F
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 11:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52121335BC0;
	Tue, 17 Feb 2026 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6i0j39r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB48C3358AE
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329401; cv=none; b=JEL6xhLmDRy52uGdgpqJYGFDu9uvpB6mEFkvVBrQY/w/b1YC/4A2G3QhUHLp0ruhv3ynmv/06w/OKLOlXKVTY2hQeGuNf/au7ypLd3B/oyBDPQsgCLRJy/LsZUr7+hZ2YOFXC0gNK/VNu+8J3b9cI3LF+xVmnZmrScPMoI4LEsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329401; c=relaxed/simple;
	bh=Hop6seFrJ1osh/G4jba22yrt19WyxezUTUW6nMAZ8pI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SCCClC886xyDG7AX0Sie/JCrhC6YCxWwKzzWsmWMaQv7CKy1iyXoSaeYeop7H0fEGy9WBAeloFmtCWcT8upgqGBBeeQT2sMJupS93HsJwb+5NYZMyPz5TOFoAXdM/Oy6pu8lDcVgxQLwXDlqBSL39j2MnXMx7tv/613mUIZ3qng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6i0j39r; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771329399; x=1802865399;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Hop6seFrJ1osh/G4jba22yrt19WyxezUTUW6nMAZ8pI=;
  b=A6i0j39rn6tPG3K4sUDiJAeR6FZiNm7oJuO+FnBAuL3RzXt6P7f48pSO
   zrWTG0T8P7ZREAI50mRwkOIDmGZfOVdWQjLEjzgM+rfKg++CEKPwQSDtw
   1ZYizF+3cqYobSOzaGmjBUEwazwo965cgtu0iz/iB/DaW8bEMK5wKOPk+
   8zc2ZZhPXm0wFrhcIQj6E3TpLerC+ZjPmRXWxOcT8WHX6VjrMmA5msQTh
   +0fIYZM0BSr0qAam5irkHM+2rmPC8g6kY5hBsVcLd73M+f1nhxBd6fefU
   rSN/Ie9eMztgHRlzI4o0E6w1I2zpOl9okYfrncpIJ2SJtv15GeBq9gYT+
   g==;
X-CSE-ConnectionGUID: 1jTY7VXbRo2FPxmZ31+43w==
X-CSE-MsgGUID: JsVnLGChSRWP5pIc7kJt1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83495871"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="83495871"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 03:56:39 -0800
X-CSE-ConnectionGUID: riTKfm1HQn+yZvYdmDRe6Q==
X-CSE-MsgGUID: Rl0FQXazQs2FeF+ehwfC7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="251547133"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 03:56:38 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v3 wireless-next 08/15] wifi: cfg80211: add support for NAN data interface
Date: Tue, 17 Feb 2026 13:56:11 +0200
Message-Id: <20260217134342.2d455362bd3b.I92973483e927820ae2297853c141842fdb262747@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217115618.2066972-1-miriam.rachel.korenblit@intel.com>
References: <20260217115618.2066972-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31939-lists,linux-wireless=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 7325314BA90
X-Rspamd-Action: no action

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
 include/uapi/linux/nl80211.h |  4 +++
 net/mac80211/cfg.c           |  1 +
 net/mac80211/chan.c          |  2 ++
 net/mac80211/iface.c         |  3 ++
 net/mac80211/rx.c            |  2 ++
 net/mac80211/util.c          |  1 +
 net/wireless/chan.c          |  2 ++
 net/wireless/core.c          | 70 +++++++++++++++++++++++++++++++-----
 net/wireless/core.h          |  6 ++++
 net/wireless/nl80211.c       | 14 +++++++-
 net/wireless/reg.c           | 12 +++++--
 net/wireless/sysfs.c         | 27 +++++++-------
 net/wireless/util.c          | 21 +++++++++--
 14 files changed, 157 insertions(+), 29 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index ea04afa72fa4..6ccd80868800 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3977,6 +3977,27 @@ struct cfg80211_qos_map {
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
index 4edc6eb9c467..b1584f145eac 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3723,6 +3723,9 @@ enum nl80211_attrs {
  * @NL80211_IFTYPE_OCB: Outside Context of a BSS
  *	This mode corresponds to the MIB variable dot11OCBActivated=true
  * @NL80211_IFTYPE_NAN: NAN device interface type (not a netdev)
+ * @NL80211_IFTYPE_NAN_DATA: NAN data interface type (netdev); NAN data
+ *	interfaces can only be brought up (IFF_UP) when a NAN interface
+ *	already exists and NAN has been started (using %NL80211_CMD_START_NAN).
  * @NL80211_IFTYPE_MAX: highest interface type number currently defined
  * @NUM_NL80211_IFTYPES: number of defined interface types
  *
@@ -3744,6 +3747,7 @@ enum nl80211_iftype {
 	NL80211_IFTYPE_P2P_DEVICE,
 	NL80211_IFTYPE_OCB,
 	NL80211_IFTYPE_NAN,
+	NL80211_IFTYPE_NAN_DATA,
 
 	/* keep last */
 	NUM_NL80211_IFTYPES,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 2e840330c243..f56007740bdc 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -726,6 +726,7 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 	case NL80211_IFTYPE_P2P_CLIENT:
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_OCB:
+	case NL80211_IFTYPE_NAN_DATA:
 		/* shouldn't happen */
 		WARN_ON_ONCE(1);
 		break;
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index d8c5f11afc15..c61121416426 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -488,6 +488,7 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 		case NUM_NL80211_IFTYPES:
 		case NL80211_IFTYPE_P2P_CLIENT:
 		case NL80211_IFTYPE_P2P_GO:
+		case NL80211_IFTYPE_NAN_DATA:
 			WARN_ON_ONCE(1);
 		}
 
@@ -1414,6 +1415,7 @@ ieee80211_link_chanctx_reservation_complete(struct ieee80211_link_data *link)
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
 	case NUM_NL80211_IFTYPES:
 		WARN_ON(1);
 		break;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 676b2a43c9f2..6407c33fe9c8 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1369,6 +1369,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_OCB:
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
 		/* no special treatment */
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
@@ -1937,6 +1938,8 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	case NL80211_IFTYPE_P2P_DEVICE:
 		sdata->vif.bss_conf.bssid = sdata->vif.addr;
 		break;
+	case NL80211_IFTYPE_NAN_DATA:
+		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_WDS:
 	case NUM_NL80211_IFTYPES:
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 11d6c56c9d7e..7c854080f52a 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4621,6 +4621,8 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			(ieee80211_is_public_action(hdr, skb->len) ||
 			 (ieee80211_is_auth(hdr->frame_control) &&
 			  ether_addr_equal(sdata->vif.addr, hdr->addr1)));
+	case NL80211_IFTYPE_NAN_DATA:
+		return false;
 	default:
 		break;
 	}
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index a5e09c0fa6b3..194fc138bdb3 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2120,6 +2120,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
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
index e86c404b0cfa..6750efbdf34c 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -329,16 +329,21 @@ void cfg80211_shutdown_all_interfaces(struct wiphy *wiphy)
 
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
@@ -406,6 +411,21 @@ void cfg80211_destroy_ifaces(struct cfg80211_registered_device *rdev)
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
@@ -1419,9 +1439,8 @@ void cfg80211_update_iface_num(struct cfg80211_registered_device *rdev,
 		rdev->num_running_monitor_ifaces += num;
 }
 
-void cfg80211_leave(struct cfg80211_registered_device *rdev,
-		    struct wireless_dev *wdev,
-		    int link_id)
+void cfg80211_leave_locked(struct cfg80211_registered_device *rdev,
+			   struct wireless_dev *wdev, int link_id)
 {
 	struct net_device *dev = wdev->netdev;
 	struct cfg80211_sched_scan_request *pos, *tmp;
@@ -1472,6 +1491,7 @@ void cfg80211_leave(struct cfg80211_registered_device *rdev,
 		break;
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_MONITOR:
+	case NL80211_IFTYPE_NAN_DATA:
 		/* nothing to do */
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
@@ -1482,6 +1502,19 @@ void cfg80211_leave(struct cfg80211_registered_device *rdev,
 	}
 }
 
+void cfg80211_leave(struct cfg80211_registered_device *rdev,
+		    struct wireless_dev *wdev, int link_id)
+{
+	ASSERT_RTNL();
+
+	/* NAN_DATA interfaces must be closed before stopping NAN */
+	cfg80211_close_dependents(rdev, wdev);
+
+	guard(wiphy)(&rdev->wiphy);
+
+	cfg80211_leave_locked(rdev, wdev, link_id);
+}
+
 void cfg80211_stop_link(struct wiphy *wiphy, struct wireless_dev *wdev,
 			int link_id, gfp_t gfp)
 {
@@ -1497,6 +1530,9 @@ void cfg80211_stop_link(struct wiphy *wiphy, struct wireless_dev *wdev,
 
 	trace_cfg80211_stop_link(wiphy, wdev, link_id);
 
+	if (wdev->iftype == NL80211_IFTYPE_NAN)
+		return;
+
 	ev = kzalloc(sizeof(*ev), gfp);
 	if (!ev)
 		return;
@@ -1647,10 +1683,9 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		}
 		break;
 	case NETDEV_GOING_DOWN:
-		scoped_guard(wiphy, &rdev->wiphy) {
-			cfg80211_leave(rdev, wdev, -1);
+		cfg80211_leave(rdev, wdev, -1);
+		scoped_guard(wiphy, &rdev->wiphy)
 			cfg80211_remove_links(wdev);
-		}
 		/* since we just did cfg80211_leave() nothing to do there */
 		cancel_work_sync(&wdev->disconnect_wk);
 		cancel_work_sync(&wdev->pmsr_free_wk);
@@ -1731,6 +1766,23 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 
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
index cd8e18a33e79..ad7609770f74 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -318,6 +318,9 @@ void cfg80211_cqm_rssi_notify_work(struct wiphy *wiphy,
 
 void cfg80211_destroy_ifaces(struct cfg80211_registered_device *rdev);
 
+void cfg80211_close_dependents(struct cfg80211_registered_device *rdev,
+			       struct wireless_dev *wdev);
+
 /* free object */
 void cfg80211_dev_free(struct cfg80211_registered_device *rdev);
 
@@ -537,6 +540,9 @@ int cfg80211_validate_beacon_int(struct cfg80211_registered_device *rdev,
 void cfg80211_update_iface_num(struct cfg80211_registered_device *rdev,
 			       enum nl80211_iftype iftype, int num);
 
+void cfg80211_leave_locked(struct cfg80211_registered_device *rdev,
+			   struct wireless_dev *wdev, int link_id);
+
 void cfg80211_leave(struct cfg80211_registered_device *rdev,
 		    struct wireless_dev *wdev,
 		    int link_id);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ffc7e4a8a391..0b2bdd1d989e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1743,6 +1743,7 @@ static int nl80211_key_allowed(struct wireless_dev *wdev)
 			return 0;
 		return -ENOLINK;
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
 		if (wiphy_ext_feature_isset(wdev->wiphy,
 					    NL80211_EXT_FEATURE_SECURE_NAN))
 			return 0;
@@ -4897,6 +4898,8 @@ static int nl80211_del_interface(struct sk_buff *skb, struct genl_info *info)
 	else
 		dev_close(wdev->netdev);
 
+	cfg80211_close_dependents(rdev, wdev);
+
 	mutex_lock(&rdev->wiphy.mtx);
 
 	return cfg80211_remove_virtual_intf(rdev, wdev);
@@ -15932,6 +15935,10 @@ static int nl80211_stop_nan(struct sk_buff *skb, struct genl_info *info)
 	if (wdev->iftype != NL80211_IFTYPE_NAN)
 		return -EOPNOTSUPP;
 
+	cfg80211_close_dependents(rdev, wdev);
+
+	guard(wiphy)(&rdev->wiphy);
+
 	cfg80211_stop_nan(rdev, wdev);
 
 	return 0;
@@ -18292,7 +18299,11 @@ nl80211_epcs_cfg(struct sk_buff *skb, struct genl_info *info)
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
@@ -19129,6 +19140,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_stop_nan,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP |
+					 NL80211_FLAG_NO_WIPHY_MTX |
 					 NL80211_FLAG_NEED_RTNL),
 	},
 	{
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 43c5193a6ed9..6cd55e534fbe 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2422,6 +2422,9 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 				continue;
 			chandef = wdev->u.ocb.chandef;
 			break;
+		case NL80211_IFTYPE_NAN_DATA:
+			/* NAN channels are checked in NL80211_IFTYPE_NAN interface */
+			break;
 		default:
 			/* others not implemented for now */
 			WARN_ON_ONCE(1);
@@ -2458,11 +2461,14 @@ static void reg_leave_invalid_chans(struct wiphy *wiphy)
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
 			cfg80211_leave(rdev, wdev, -1);
+	}
 }
 
 static void reg_check_chans_work(struct work_struct *work)
diff --git a/net/wireless/sysfs.c b/net/wireless/sysfs.c
index 3385a27468f7..d45ddc457c30 100644
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
index 659f0b46ad82..f2ebef59a943 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1144,8 +1144,15 @@ void cfg80211_process_wdev_events(struct wireless_dev *wdev)
 					       ev->ij.channel);
 			break;
 		case EVENT_STOPPED:
-			cfg80211_leave(wiphy_to_rdev(wdev->wiphy), wdev,
-				       ev->link_id);
+			/*
+			 * for NAN interfaces cfg80211_leave must be called but
+			 * locking here doesn't allow this.
+			 */
+			if (WARN_ON(wdev->iftype == NL80211_IFTYPE_NAN))
+				break;
+
+			cfg80211_leave_locked(wiphy_to_rdev(wdev->wiphy), wdev,
+					      ev->link_id);
 			break;
 		case EVENT_PORT_AUTHORIZED:
 			__cfg80211_port_authorized(wdev, ev->pa.peer_addr,
@@ -1184,6 +1191,13 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
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
@@ -1204,7 +1218,7 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 		dev->ieee80211_ptr->use_4addr = false;
 		rdev_set_qos_map(rdev, dev, NULL);
 
-		cfg80211_leave(rdev, dev->ieee80211_ptr, -1);
+		cfg80211_leave_locked(rdev, dev->ieee80211_ptr, -1);
 
 		cfg80211_process_rdev_events(rdev);
 		cfg80211_mlme_purge_registrations(dev->ieee80211_ptr);
@@ -1232,6 +1246,7 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 		case NL80211_IFTYPE_OCB:
 		case NL80211_IFTYPE_P2P_CLIENT:
 		case NL80211_IFTYPE_ADHOC:
+		case NL80211_IFTYPE_NAN_DATA:
 			dev->priv_flags |= IFF_DONT_BRIDGE;
 			break;
 		case NL80211_IFTYPE_P2P_GO:
-- 
2.34.1


