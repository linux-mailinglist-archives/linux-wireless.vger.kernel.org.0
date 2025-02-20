Return-Path: <linux-wireless+bounces-19186-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D47A3D4FE
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 10:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECAA167FF6
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 09:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C1F1B87EE;
	Thu, 20 Feb 2025 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="uY7c/eWL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3371EF0B4
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 09:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044518; cv=none; b=niyjyS7KeS48UKq1g62KvO2Pq0o38FYIF5Wuu5cZdvLwBzDqo9J+Of27RjAMd6CwLB488fi82+JZg9BZVh4A2v9NI4HkHh2xlu/Au3/AcFtRvpTAmPzkuvD49aDCJsGPSCKgZ864lIhpkuDugEWv17Yed1K37+NEY4pVfGsJriw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044518; c=relaxed/simple;
	bh=seoy02n/WqhkIUBVMv9VcfS9c/U2yF581RasKyG0pAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pNZCA2j2hXvBNSp0eX404v8fhd9+/VWjjdkyPtjziHRRpMscs4GAIJIXADZDltNr6QVnSKwqKS93KSOSopYjnv9LBrzFZF9g2OeYmsnXoDWyZG29ZN3tty6c3RJ0q6snhhLlapbKWS3GxgduPlx3deGWsFE/CGUCE/qvfG2U9zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=uY7c/eWL; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1740044510;
	bh=seoy02n/WqhkIUBVMv9VcfS9c/U2yF581RasKyG0pAs=;
	h=From:To:Cc:Subject:Date;
	b=uY7c/eWL939GDnKrSwZi47yGuh5MKnps5WZfiqGMxsZL2b1sVg7f8fNqU3tVgajdS
	 SWCgGktmGky9WtU8b1RIMy/uREjwuJAjgRcPy58XcwkpHa4LKG5+c2kyOl9ex5sEZl
	 YXYtr+77nPO7aUvVK9OMqAtVd5H6nhG9K/Bbo4+w=
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [PATCH] wifi: mac80211: Add counter for all monitor interfaces
Date: Thu, 20 Feb 2025 10:41:39 +0100
Message-ID: <20250220094139.61459-1-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Count open monitor interfaces regardless of the monitor interface type.
The new counter virt_monitors takes over counting interfaces depending
on the virtual monitor interface while monitors is used for all active
monitor interfaces.

This fixes monitor packet mirroring when using MONITOR_FLAG_ACTIVE or
NO_VIRTUAL_MONITOR interfaces.

Fixes: 286e69677065 ("wifi: mac80211: Drop cooked monitor support")
Reported-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Closes: https://lore.kernel.org/r/cc715114-4e3b-619a-49dc-a4878075e1dc@quicinc.com
Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
---
This should fix the issue from the Reported-by above.
I can't verify that myself, though. Can you confirm that solves the
issue?

Alexander
---
 net/mac80211/cfg.c         |  5 ++---
 net/mac80211/ethtool.c     |  2 +-
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/iface.c       | 22 +++++++++++++---------
 net/mac80211/util.c        |  3 ++-
 5 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 5785fe30adaa..09708a060bb7 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4370,9 +4370,8 @@ static int ieee80211_cfg_get_channel(struct wiphy *wiphy,
 	if (chanctx_conf) {
 		*chandef = link->conf->chanreq.oper;
 		ret = 0;
-	} else if (!ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR) &&
-		   local->open_count > 0 &&
-		   local->open_count == local->monitors &&
+	} else if (local->open_count > 0 &&
+		   local->open_count == local->virt_monitors &&
 		   sdata->vif.type == NL80211_IFTYPE_MONITOR) {
 		*chandef = local->monitor_chanreq.oper;
 		ret = 0;
diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
index 42f7ee142ce3..0397755a3bd1 100644
--- a/net/mac80211/ethtool.c
+++ b/net/mac80211/ethtool.c
@@ -158,7 +158,7 @@ static void ieee80211_get_stats(struct net_device *dev,
 	if (chanctx_conf)
 		channel = chanctx_conf->def.chan;
 	else if (local->open_count > 0 &&
-		 local->open_count == local->monitors &&
+		 local->open_count == local->virt_monitors &&
 		 sdata->vif.type == NL80211_IFTYPE_MONITOR)
 		channel = local->monitor_chanreq.oper.chan;
 	else
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index f23be8b5d0d8..845888ac3d2c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1384,7 +1384,7 @@ struct ieee80211_local {
 	spinlock_t queue_stop_reason_lock;
 
 	int open_count;
-	int monitors, tx_mntrs;
+	int monitors, virt_monitors, tx_mntrs;
 	/* number of interfaces with corresponding FIF_ flags */
 	int fif_fcsfail, fif_plcpfail, fif_control, fif_other_bss, fif_pspoll,
 	    fif_probe_req;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 77d0078616fb..b0423046028c 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -582,11 +582,13 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		/* no need to tell driver */
 		break;
 	case NL80211_IFTYPE_MONITOR:
+		local->monitors--;
+
 		if (!(sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE) &&
 		    !ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR)) {
 
-			local->monitors--;
-			if (local->monitors == 0) {
+			local->virt_monitors--;
+			if (local->virt_monitors == 0) {
 				local->hw.conf.flags &= ~IEEE80211_CONF_MONITOR;
 				hw_reconf_flags |= IEEE80211_CONF_CHANGE_MONITOR;
 			}
@@ -683,7 +685,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	case NL80211_IFTYPE_AP_VLAN:
 		break;
 	case NL80211_IFTYPE_MONITOR:
-		if (local->monitors == 0)
+		if (local->virt_monitors == 0)
 			ieee80211_del_virtual_monitor(local);
 
 		ieee80211_recalc_idle(local);
@@ -720,7 +722,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	ieee80211_configure_filter(local);
 	ieee80211_hw_config(local, hw_reconf_flags);
 
-	if (local->monitors == local->open_count)
+	if (local->virt_monitors == local->open_count)
 		ieee80211_add_virtual_monitor(local);
 }
 
@@ -979,7 +981,7 @@ static bool ieee80211_set_sdata_offload_flags(struct ieee80211_sub_if_data *sdat
 		    local->hw.wiphy->frag_threshold != (u32)-1)
 			flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
 
-		if (local->monitors)
+		if (local->virt_monitors)
 			flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
 	} else {
 		flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
@@ -989,7 +991,7 @@ static bool ieee80211_set_sdata_offload_flags(struct ieee80211_sub_if_data *sdat
 	    ieee80211_iftype_supports_hdr_offload(sdata->vif.type)) {
 		flags |= IEEE80211_OFFLOAD_DECAP_ENABLED;
 
-		if (local->monitors &&
+		if (local->virt_monitors &&
 		    !ieee80211_hw_check(&local->hw, SUPPORTS_CONC_MON_RX_DECAP))
 			flags &= ~IEEE80211_OFFLOAD_DECAP_ENABLED;
 	} else {
@@ -1333,20 +1335,22 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 			if (res)
 				goto err_stop;
 		} else {
-			if (local->monitors == 0 && local->open_count == 0) {
+			if (local->virt_monitors == 0 && local->open_count == 0) {
 				res = ieee80211_add_virtual_monitor(local);
 				if (res)
 					goto err_stop;
 			}
-			local->monitors++;
+			local->virt_monitors++;
 
 			/* must be before the call to ieee80211_configure_filter */
-			if (local->monitors == 1) {
+			if (local->virt_monitors == 1) {
 				local->hw.conf.flags |= IEEE80211_CONF_MONITOR;
 				hw_reconf_flags |= IEEE80211_CONF_CHANGE_MONITOR;
 			}
 		}
 
+		local->monitors++;
+
 		ieee80211_adjust_monitor_flags(sdata, 1);
 		ieee80211_configure_filter(local);
 		ieee80211_recalc_offload(local);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 7f02bd5891eb..e2680589254f 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2156,7 +2156,8 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 
  wake_up:
 
-	if (local->monitors == local->open_count && local->monitors > 0)
+	if (local->virt_monitors > 0 &&
+	    local->virt_monitors == local->open_count)
 		ieee80211_add_virtual_monitor(local);
 
 	/*
-- 
2.48.1


