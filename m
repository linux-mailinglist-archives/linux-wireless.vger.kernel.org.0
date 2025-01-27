Return-Path: <linux-wireless+bounces-18039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23930A1DAB1
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 17:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D1C18877FD
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 16:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5290D165F01;
	Mon, 27 Jan 2025 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="EQdBz4Zr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEE7433CB
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995872; cv=none; b=IHDRrwCDbj7I9BYkiCYjN18JohDMmnTnLIufpac2ACYA0ZJMmgSQH9RUwPC6ZlI5XhLVqAZTnkIQTLAn73IAEaa/Mc775YSAAhAMjZjvXo5OqHb8LLtXnfnivjMtnOLERlBC1VqUHGUDKu14nZo1ERh/aJFcRCZ+cT9qi+Cex3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995872; c=relaxed/simple;
	bh=iw3QBuJ33a31zo1ZvE+rnoHf3snSiO5DkCl+yRMi/IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jo/UYRxLlDnS3rzGVyNAurYO24kzcfoO1QcWj5dl04LTJDj/S8aA14WKm1I38mDLKEztw8wdoZVVcXkRgiHGL/XI6Gn1tErRPnI9cwyMoiht18v6hu78crh0IwQGPzrDLqBwM90klT+uJKgibIo40rSc2xynEXvBYPx+DHx0Zrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=EQdBz4Zr; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1737995297;
	bh=iw3QBuJ33a31zo1ZvE+rnoHf3snSiO5DkCl+yRMi/IU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EQdBz4Zr+KXbcJfj9a+FYb+4rFZbyyWKkz5tVTdd59z2fG6CHkvEdld3OlDOyCUW3
	 zzY83gae0xxkbHJLoTkqYw9fyUaPlT7MinNJ15h76MQk7Y3C9a7WXRMDnQREan08h7
	 wYEc5ZeqMc+UpU8VB5fu0QdSDDfWjLzSfzAyGC98=
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [RFC PATCH 01/13] wifi: mac80211: Fix virtual monitor interface creation
Date: Mon, 27 Jan 2025 17:26:13 +0100
Message-ID: <20250127162625.20747-2-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127162625.20747-1-Alexander@wetzel-home.de>
References: <20250127162625.20747-1-Alexander@wetzel-home.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Virtual monitor interfaces should only be created when all of the
following conditions are fulfilled:
 - All remaining enabled interfaces are monitor interface(s),
 - %IEEE80211_HW_NO_VIRTUAL_MONITOR isn't set by the driver and
 - %MONITOR_FLAG_ACTIVE and %MONITOR_FLAG_COOK_FRAMES isn't set on any
   of the enabled (monitor) interfaces.

ieee80211_add_virtual_monitor() will then setup the virtual monitor
interface for local->monitor_sdata and - when
%IEEE80211_HW_WANT_MONITOR_VIF is set - inform the driver about the
virtual monitor interface.

But assuming %IEEE80211_HW_NO_VIRTUAL_MONITOR is not set, the current
code still creates a virtual monitor interface when:

 1) We have one non-monitor and one monitor interface with
    %MONITOR_FLAG_ACTIVE enabled and then delete the non-monitor
    interface.

 2) We only have monitor interfaces enabled on resume while at least one
    has %MONITOR_FLAG_ACTIVE set.

Fix the logic to follow the above stated rules and fixed/updated related
checks not following the logic.

Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
---
I have problems understanding the current logic of how monitor
interfaces are handled. For me it looks like we use local->monitors
sometimes to count all monitor interfaces - except the ones using
%MONITOR_FLAG_COOK_FRAMES - and at other times to count interfaces
linked to the virtual monitor interface.

This patch tries to fix the logic according to my understanding.

Noteworthy here is the wording in 0d9c2beed116 ("wifi: mac80211:
fix monitor channel with chanctx emulation"):
     ...
     Fix this by always allocating the virtual monitor sdata, and
     simply not telling the driver about it unless it wanted to.
     This way, we have an interface/sdata to bind the chanctx to,
     and the emulation can work correctly.

But the commit with this statement is not changing the condition to call
ieee80211_add_virtual_monitor(), contradicting these sentences.

From ieee80211_do_open():
        case NL80211_IFTYPE_MONITOR:
                if (sdata->u.mntr.flags & MONITOR_FLAG_COOK_FRAMES) {
                        local->cooked_mntrs++;
                        break;
                }

                if (sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE) {
                        res = drv_add_interface(local, sdata);
                        if (res)
                                goto err_stop;
                } else if (local->monitors == 0 && local->open_count == 0) {
                        res = ieee80211_add_virtual_monitor(local);

So I'm not sure if the patch is what we want...
I'm also wondering, if we couldn't/shouldn't also drop %MONITOR_FLAG_ACTIVE
and %MONITOR_FLAG_COOK_FRAMES. I did not find a single use for them.
Thus, I'm also not sure I handle them correctly here. A monitor
interface with %MONITOR_FLAG_COOK_FRAMES was not picking up any frames
with or without this patch.. And %MONITOR_FLAG_ACTIVE does not work for
iwlmvm.
(At least one of them was probably for ancient versions of hostapd...)

Alexander
---
 net/mac80211/cfg.c         |  9 +++++----
 net/mac80211/ethtool.c     |  7 ++++---
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/iface.c       | 26 ++++++++++++++++++--------
 net/mac80211/pm.c          |  1 -
 net/mac80211/scan.c        |  2 +-
 net/mac80211/util.c        |  2 +-
 7 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b8495d5f2297..fbdd6b46b154 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4366,10 +4366,11 @@ static int ieee80211_cfg_get_channel(struct wiphy *wiphy,
 	if (chanctx_conf) {
 		*chandef = link->conf->chanreq.oper;
 		ret = 0;
-	} else if (!ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR) &&
-		   local->open_count > 0 &&
-		   local->open_count == local->monitors &&
-		   sdata->vif.type == NL80211_IFTYPE_MONITOR) {
+	} else if (local->virt_monitors &&
+		   local->open_count == local->virt_monitors &&
+		   sdata->vif.type == NL80211_IFTYPE_MONITOR &&
+		   !(sdata->u.mntr.flags & (MONITOR_FLAG_ACTIVE |
+					    MONITOR_FLAG_COOK_FRAMES))) {
 		*chandef = local->monitor_chanreq.oper;
 		ret = 0;
 	}
diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
index 42f7ee142ce3..52a278232c9d 100644
--- a/net/mac80211/ethtool.c
+++ b/net/mac80211/ethtool.c
@@ -157,9 +157,10 @@ static void ieee80211_get_stats(struct net_device *dev,
 	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (chanctx_conf)
 		channel = chanctx_conf->def.chan;
-	else if (local->open_count > 0 &&
-		 local->open_count == local->monitors &&
-		 sdata->vif.type == NL80211_IFTYPE_MONITOR)
+	else if (local->virt_monitors &&
+		 sdata->vif.type == NL80211_IFTYPE_MONITOR &&
+		 !(sdata->u.mntr.flags & (MONITOR_FLAG_ACTIVE |
+					  MONITOR_FLAG_COOK_FRAMES)))
 		channel = local->monitor_chanreq.oper.chan;
 	else
 		channel = NULL;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a98133d5c362..8aceec18ffaf 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1367,7 +1367,7 @@ struct ieee80211_local {
 	spinlock_t queue_stop_reason_lock;
 
 	int open_count;
-	int monitors, cooked_mntrs, tx_mntrs;
+	int monitors, virt_monitors, cooked_mntrs, tx_mntrs;
 	/* number of interfaces with corresponding FIF_ flags */
 	int fif_fcsfail, fif_plcpfail, fif_control, fif_other_bss, fif_pspoll,
 	    fif_probe_req;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 2e170dbde732..b0c02942dac3 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -589,6 +589,11 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 			break;
 		}
 
+		if (!(sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE) &&
+		    !ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR) &&
+		    !WARN_ON(local->virt_monitors <= 0))
+			local->virt_monitors--;
+
 		local->monitors--;
 		if (local->monitors == 0) {
 			local->hw.conf.flags &= ~IEEE80211_CONF_MONITOR;
@@ -686,7 +691,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	case NL80211_IFTYPE_AP_VLAN:
 		break;
 	case NL80211_IFTYPE_MONITOR:
-		if (local->monitors == 0)
+		if (local->virt_monitors == 0)
 			ieee80211_del_virtual_monitor(local);
 
 		ieee80211_recalc_idle(local);
@@ -723,7 +728,8 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	ieee80211_configure_filter(local);
 	ieee80211_hw_config(local, hw_reconf_flags);
 
-	if (local->monitors == local->open_count)
+	if (local->virt_monitors &&
+	    local->virt_monitors == local->open_count)
 		ieee80211_add_virtual_monitor(local);
 }
 
@@ -1129,7 +1135,7 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (local->monitor_sdata ||
-	    ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
+	    WARN_ON(ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR)))
 		return 0;
 
 	sdata = kzalloc(sizeof(*sdata) + local->hw.vif_data_size, GFP_KERNEL);
@@ -1336,15 +1342,19 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 			res = drv_add_interface(local, sdata);
 			if (res)
 				goto err_stop;
-		} else if (local->monitors == 0 && local->open_count == 0) {
-			res = ieee80211_add_virtual_monitor(local);
-			if (res)
-				goto err_stop;
+		} else {
+			if (local->virt_monitors == 0 &&
+			    local->open_count == 0) {
+				res = ieee80211_add_virtual_monitor(local);
+				if (res)
+					goto err_stop;
+			}
+			local->virt_monitors++;
 		}
 
 		/* must be before the call to ieee80211_configure_filter */
 		local->monitors++;
-		if (local->monitors == 1) {
+		if (local->monitors == 1 && local->virt_monitors == 1) {
 			local->hw.conf.flags |= IEEE80211_CONF_MONITOR;
 			hw_reconf_flags |= IEEE80211_CONF_CHANGE_MONITOR;
 		}
diff --git a/net/mac80211/pm.c b/net/mac80211/pm.c
index 7be52345f218..b914a1eeba82 100644
--- a/net/mac80211/pm.c
+++ b/net/mac80211/pm.c
@@ -150,7 +150,6 @@ int __ieee80211_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 			continue;
 		switch (sdata->vif.type) {
 		case NL80211_IFTYPE_AP_VLAN:
-		case NL80211_IFTYPE_MONITOR:
 			continue;
 		case NL80211_IFTYPE_STATION:
 			ieee80211_mgd_quiesce(sdata);
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index cb7079071885..4eb0cf5f73ca 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -334,7 +334,7 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 	}
 
 	/* Do not update the BSS table in case of only monitor interfaces */
-	if (local->open_count == local->monitors)
+	if (local->open_count == local->monitors + local->cooked_mntrs)
 		return;
 
 	bss = ieee80211_bss_info_update(local, rx_status,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 7b656326e68a..86320ecf306c 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2153,7 +2153,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 
  wake_up:
 
-	if (local->monitors == local->open_count && local->monitors > 0)
+	if (local->virt_monitors == local->open_count && local->monitors > 0)
 		ieee80211_add_virtual_monitor(local);
 
 	/*
-- 
2.48.1


