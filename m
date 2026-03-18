Return-Path: <linux-wireless+bounces-33386-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GVoL02eumngZgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33386-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 13:45:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 297FD2BBBC3
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 13:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27CAD30B55E1
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 12:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8154D3D6CA5;
	Wed, 18 Mar 2026 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIVcpY9Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936EE20E030
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837583; cv=none; b=RZikWDaYXNqvy1c6yA+8FuTJvvFlSOBDnXCAQxHWiUYuCFkBfDpWD0PRf+WhS+yvxdp2ZbnVz9GbO8+kP4Oi0WgEzqLKuuiKz4NokhvzhhAc2rurhn4FLLS5ApEiNaEt3asNeMCcqz2ZmIN1COawYOQkLn7T/BOW8gQ1LibausY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837583; c=relaxed/simple;
	bh=dOqFaUgQ73ZLmZhjHBprSpmVqOMJhuO9afSRiv+kQls=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AsqRDuZnUzkwurjLLX5R54LGIpGb1jejeyaSfHN5gMCkqv7RuiTjUhvMPFUdd/06o5l1GR/65kSpeqbMiC0spKCgo5W1glUGVab6Zxpr4a095k0q9nwKIzonL2k3yUeZpskgGg55QE4bYxMM1v2Pvd4QgQa1BQ+vZRbzR3yjd8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jIVcpY9Z; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773837582; x=1805373582;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=dOqFaUgQ73ZLmZhjHBprSpmVqOMJhuO9afSRiv+kQls=;
  b=jIVcpY9ZlAcouye2ZC/hScWizfyMreAbDiuzS1zkQGTYyiq/TpGZqz7W
   +iJqTHojqsVrWNlKIWfpchCiFcWa7tkfgM9vjeQpPiNStme+nekxQjAh7
   Tr2eymor/x7yG8aLxJ4E7Ns/6+NILSij63RysXbKx9ocoaRRFlBTV2/eG
   gFKYVhNvuQOMmXdYoxQUarGELU9m3WLq/m0VuK8nsb9oN5YEaJKrS89fD
   YCD2SbeSgYm6LGuHhz0sSIBkWaJHUTFPmOepquC37FVaGYihBIMMFOMsL
   02RZT4nBgfMsbUkyeEGYK2He2WTRsgTDxvmSc5vKhJYOS5Pwerjsf9pGn
   Q==;
X-CSE-ConnectionGUID: Po2p3DCGSGOqU4NWcJg+Ig==
X-CSE-MsgGUID: NLquld8TRDGWbO51pLer9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="85519265"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="85519265"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:39:41 -0700
X-CSE-ConnectionGUID: 75ZFi53FSkSkvk2B4Q2Blw==
X-CSE-MsgGUID: DjGsV1P/S66j/yhCOyoGNQ==
X-ExtLoop1: 1
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 05:39:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v5 wireless-next 03/12] wifi: cfg80211: add support for NAN data interface
Date: Wed, 18 Mar 2026 14:39:17 +0200
Message-Id: <20260318123926.206536-4-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318123926.206536-1-miriam.rachel.korenblit@intel.com>
References: <20260318123926.206536-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-33386-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 297FD2BBBC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Link: https://patch.msgid.link/20260219114327.0d681335c2e2.I92973483e927820ae2297853c141842fdb262747@changeid
---
 include/net/cfg80211.h       | 21 +++++++++++
 include/uapi/linux/nl80211.h |  4 ++
 net/mac80211/cfg.c           |  1 +
 net/mac80211/chan.c          |  2 +
 net/mac80211/iface.c         |  3 ++
 net/mac80211/rx.c            |  2 +
 net/mac80211/util.c          |  1 +
 net/wireless/chan.c          |  2 +
 net/wireless/core.c          | 72 +++++++++++++++++++++++++++++++-----
 net/wireless/core.h          |  6 +++
 net/wireless/nl80211.c       | 14 ++++++-
 net/wireless/reg.c           | 12 ++++--
 net/wireless/sysfs.c         | 27 +++++++-------
 net/wireless/util.c          | 21 +++++++++--
 14 files changed, 159 insertions(+), 29 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 539dcf65c188..1797ece50295 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3980,6 +3980,27 @@ struct cfg80211_qos_map {
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
index 484094667abc..3984c176f9e7 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3749,6 +3749,9 @@ enum nl80211_attrs {
  * @NL80211_IFTYPE_OCB: Outside Context of a BSS
  *	This mode corresponds to the MIB variable dot11OCBActivated=true
  * @NL80211_IFTYPE_NAN: NAN device interface type (not a netdev)
+ * @NL80211_IFTYPE_NAN_DATA: NAN data interface type (netdev); NAN data
+ *	interfaces can only be brought up (IFF_UP) when a NAN interface
+ *	already exists and NAN has been started (using %NL80211_CMD_START_NAN).
  * @NL80211_IFTYPE_MAX: highest interface type number currently defined
  * @NUM_NL80211_IFTYPES: number of defined interface types
  *
@@ -3770,6 +3773,7 @@ enum nl80211_iftype {
 	NL80211_IFTYPE_P2P_DEVICE,
 	NL80211_IFTYPE_OCB,
 	NL80211_IFTYPE_NAN,
+	NL80211_IFTYPE_NAN_DATA,
 
 	/* keep last */
 	NUM_NL80211_IFTYPES,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index ee64ac8e0f61..1fbcc773c3ed 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -718,6 +718,7 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 	case NL80211_IFTYPE_P2P_CLIENT:
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_OCB:
+	case NL80211_IFTYPE_NAN_DATA:
 		/* shouldn't happen */
 		WARN_ON_ONCE(1);
 		break;
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 2f0c93f3ace6..95ebfad15512 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -509,6 +509,7 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 		case NUM_NL80211_IFTYPES:
 		case NL80211_IFTYPE_P2P_CLIENT:
 		case NL80211_IFTYPE_P2P_GO:
+		case NL80211_IFTYPE_NAN_DATA:
 			WARN_ON_ONCE(1);
 		}
 
@@ -1436,6 +1437,7 @@ ieee80211_link_chanctx_reservation_complete(struct ieee80211_link_data *link)
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
 	case NUM_NL80211_IFTYPES:
 		WARN_ON(1);
 		break;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 40ce0bb72726..02f464eb2cde 100644
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
@@ -1940,6 +1941,8 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	case NL80211_IFTYPE_P2P_DEVICE:
 		sdata->vif.bss_conf.bssid = sdata->vif.addr;
 		break;
+	case NL80211_IFTYPE_NAN_DATA:
+		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_WDS:
 	case NUM_NL80211_IFTYPES:
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 19c33f7a8193..d9a654ef082d 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4607,6 +4607,8 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			(ieee80211_is_public_action(hdr, skb->len) ||
 			 (ieee80211_is_auth(hdr->frame_control) &&
 			  ether_addr_equal(sdata->vif.addr, hdr->addr1)));
+	case NL80211_IFTYPE_NAN_DATA:
+		return false;
 	default:
 		break;
 	}
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 55054de62508..8987a4504520 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2118,6 +2118,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 				return res;
 			}
 			break;
+		case NL80211_IFTYPE_NAN_DATA:
 		case NL80211_IFTYPE_AP_VLAN:
 		case NL80211_IFTYPE_MONITOR:
 		case NL80211_IFTYPE_P2P_DEVICE:
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index fa0764ede9c5..d4eff81a9027 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -816,6 +816,7 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_P2P_DEVICE:
+	case NL80211_IFTYPE_NAN_DATA:
 		break;
 	case NL80211_IFTYPE_WDS:
 	case NL80211_IFTYPE_UNSPECIFIED:
@@ -939,6 +940,7 @@ bool cfg80211_beaconing_iface_active(struct wireless_dev *wdev)
 	case NL80211_IFTYPE_P2P_DEVICE:
 	/* Can NAN type be considered as beaconing interface? */
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_WDS:
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 54c89b0db352..200b97f912eb 100644
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
@@ -396,6 +401,8 @@ void cfg80211_destroy_ifaces(struct cfg80211_registered_device *rdev)
 
 	list_for_each_entry_safe(wdev, tmp, &rdev->wiphy.wdev_list, list) {
 		if (wdev->nl_owner_dead) {
+			cfg80211_close_dependents(rdev, wdev);
+
 			if (wdev->netdev)
 				dev_close(wdev->netdev);
 
@@ -406,6 +413,21 @@ void cfg80211_destroy_ifaces(struct cfg80211_registered_device *rdev)
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
@@ -1419,9 +1441,8 @@ void cfg80211_update_iface_num(struct cfg80211_registered_device *rdev,
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
@@ -1472,6 +1493,7 @@ void cfg80211_leave(struct cfg80211_registered_device *rdev,
 		break;
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_MONITOR:
+	case NL80211_IFTYPE_NAN_DATA:
 		/* nothing to do */
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
@@ -1482,6 +1504,19 @@ void cfg80211_leave(struct cfg80211_registered_device *rdev,
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
@@ -1497,6 +1532,9 @@ void cfg80211_stop_link(struct wiphy *wiphy, struct wireless_dev *wdev,
 
 	trace_cfg80211_stop_link(wiphy, wdev, link_id);
 
+	if (wdev->iftype == NL80211_IFTYPE_NAN)
+		return;
+
 	ev = kzalloc_obj(*ev, gfp);
 	if (!ev)
 		return;
@@ -1647,10 +1685,9 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
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
@@ -1731,6 +1768,23 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 
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
index c7ae1f8a9bd8..ae2d56d3ad90 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -318,6 +318,9 @@ void cfg80211_cqm_rssi_notify_work(struct wiphy *wiphy,
 
 void cfg80211_destroy_ifaces(struct cfg80211_registered_device *rdev);
 
+void cfg80211_close_dependents(struct cfg80211_registered_device *rdev,
+			       struct wireless_dev *wdev);
+
 /* free object */
 void cfg80211_dev_free(struct cfg80211_registered_device *rdev);
 
@@ -541,6 +544,9 @@ int cfg80211_validate_beacon_int(struct cfg80211_registered_device *rdev,
 void cfg80211_update_iface_num(struct cfg80211_registered_device *rdev,
 			       enum nl80211_iftype iftype, int num);
 
+void cfg80211_leave_locked(struct cfg80211_registered_device *rdev,
+			   struct wireless_dev *wdev, int link_id);
+
 void cfg80211_leave(struct cfg80211_registered_device *rdev,
 		    struct wireless_dev *wdev,
 		    int link_id);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index e70141cccb44..b3c68d281c3f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1764,6 +1764,7 @@ static int nl80211_key_allowed(struct wireless_dev *wdev)
 			return 0;
 		return -ENOLINK;
 	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
 		if (wiphy_ext_feature_isset(wdev->wiphy,
 					    NL80211_EXT_FEATURE_SECURE_NAN))
 			return 0;
@@ -4921,6 +4922,8 @@ static int nl80211_del_interface(struct sk_buff *skb, struct genl_info *info)
 	else
 		dev_close(wdev->netdev);
 
+	cfg80211_close_dependents(rdev, wdev);
+
 	mutex_lock(&rdev->wiphy.mtx);
 
 	return cfg80211_remove_virtual_intf(rdev, wdev);
@@ -15964,6 +15967,10 @@ static int nl80211_stop_nan(struct sk_buff *skb, struct genl_info *info)
 	if (wdev->iftype != NL80211_IFTYPE_NAN)
 		return -EOPNOTSUPP;
 
+	cfg80211_close_dependents(rdev, wdev);
+
+	guard(wiphy)(&rdev->wiphy);
+
 	cfg80211_stop_nan(rdev, wdev);
 
 	return 0;
@@ -18356,7 +18363,11 @@ nl80211_epcs_cfg(struct sk_buff *skb, struct genl_info *info)
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
@@ -19193,6 +19204,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_stop_nan,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP |
+					 NL80211_FLAG_NO_WIPHY_MTX |
 					 NL80211_FLAG_NEED_RTNL),
 	},
 	{
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 4b5450aec72e..5db2121c0b57 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2409,6 +2409,9 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 				continue;
 			chandef = wdev->u.ocb.chandef;
 			break;
+		case NL80211_IFTYPE_NAN_DATA:
+			/* NAN channels are checked in NL80211_IFTYPE_NAN interface */
+			break;
 		default:
 			/* others not implemented for now */
 			WARN_ON_ONCE(1);
@@ -2445,11 +2448,14 @@ static void reg_leave_invalid_chans(struct wiphy *wiphy)
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
index 0a0cea018fc5..8dda571585cf 100644
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


