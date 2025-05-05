Return-Path: <linux-wireless+bounces-22550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EC6AAA828
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 02:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42FD165291
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 00:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA09629A9DE;
	Mon,  5 May 2025 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNZSXwOK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FADD29A9DB;
	Mon,  5 May 2025 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484754; cv=none; b=qI9GQTIBjVJJUwVxCB2UAAVEUj2QmbwT3uh8rx+akIa4cmjZwTccuawjtAU9qlxIfpWVl1IGn7FJwfwT5kAE9htXuyZJ5RQZy3Z3f8+r3qprObiO50emnpH0fklFNFOK1FAUGiI2gZ1jrFtcccPtFLIDIwRUO/mRApEJ5+H0Zdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484754; c=relaxed/simple;
	bh=YaiywORcDeKAFK1qBwB+JEAwarRZTad7iuZtA6m7xW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pyLK5MuF4yWGDocyk2CZezam7tI2J/2sU2ghHaVZN3RB0uEPFCZkkRNSzJRbzVe/Oob7tWelrBjJbKClR59GyKi8WSpxULZFDPYqeGB7yHvNmbVKDVMMNolVahiXS6cQVcmWRXi6cR6ug+dQQ11YO6sC8t1vbJJHjbfZCua3wr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNZSXwOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E27BC4CEE4;
	Mon,  5 May 2025 22:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484754;
	bh=YaiywORcDeKAFK1qBwB+JEAwarRZTad7iuZtA6m7xW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kNZSXwOKtqzBvlok4S65663rOMoZc/sQH6FWk2yuABFMIOOm/TYRHORgcXizOuBMy
	 anUMpYJUm0AxygFPrCYKZ7ozWsKyZQO2kTEWCLYsPqdHVl+CfJ622NyWOSPCc9uqkb
	 SuSle/qNjUhQDXPOTx+/vfE3Ayw1MYwB0For6IW4Wa0FxAFklewkjvgtp2Bartd/r5
	 lWNQNMPLE5SC5l648vuACOvXZlGWVhSbjZOIq8wLELQ3FX1p0IwOB5QkvaeWAjhgo6
	 ftSodQe3Sf9t0oDDSlX9ZnUn91f+gYQorGfBOIWnWDA1kq4KRc1hCBhq2RyKgnqdlE
	 ndR7wbjM9Moeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Wetzel <Alexander@wetzel-home.de>,
	Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 640/642] wifi: mac80211: Add counter for all monitor interfaces
Date: Mon,  5 May 2025 18:14:16 -0400
Message-Id: <20250505221419.2672473-640-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Alexander Wetzel <Alexander@wetzel-home.de>

[ Upstream commit 129860044c611008be37f49d04cf41874e3659e6 ]

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
Tested-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Link: https://patch.msgid.link/20250220094139.61459-1-Alexander@wetzel-home.de
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c         |  5 ++---
 net/mac80211/ethtool.c     |  2 +-
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/iface.c       | 22 +++++++++++++---------
 net/mac80211/util.c        |  3 ++-
 5 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 1ec246133d244..a7aeb37254bbf 100644
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
index 42f7ee142ce3f..0397755a3bd1c 100644
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
index afc6fda6b606b..3d7304ce23e23 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1378,7 +1378,7 @@ struct ieee80211_local {
 	spinlock_t queue_stop_reason_lock;
 
 	int open_count;
-	int monitors, tx_mntrs;
+	int monitors, virt_monitors, tx_mntrs;
 	/* number of interfaces with corresponding FIF_ flags */
 	int fif_fcsfail, fif_plcpfail, fif_control, fif_other_bss, fif_pspoll,
 	    fif_probe_req;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 5616c0adbe093..768d774d7d1f9 100644
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
@@ -686,7 +688,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	case NL80211_IFTYPE_AP_VLAN:
 		break;
 	case NL80211_IFTYPE_MONITOR:
-		if (local->monitors == 0)
+		if (local->virt_monitors == 0)
 			ieee80211_del_virtual_monitor(local);
 
 		ieee80211_recalc_idle(local);
@@ -723,7 +725,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	ieee80211_configure_filter(local);
 	ieee80211_hw_config(local, hw_reconf_flags);
 
-	if (local->monitors == local->open_count)
+	if (local->virt_monitors == local->open_count)
 		ieee80211_add_virtual_monitor(local);
 }
 
@@ -982,7 +984,7 @@ static bool ieee80211_set_sdata_offload_flags(struct ieee80211_sub_if_data *sdat
 		    local->hw.wiphy->frag_threshold != (u32)-1)
 			flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
 
-		if (local->monitors)
+		if (local->virt_monitors)
 			flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
 	} else {
 		flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
@@ -992,7 +994,7 @@ static bool ieee80211_set_sdata_offload_flags(struct ieee80211_sub_if_data *sdat
 	    ieee80211_iftype_supports_hdr_offload(sdata->vif.type)) {
 		flags |= IEEE80211_OFFLOAD_DECAP_ENABLED;
 
-		if (local->monitors &&
+		if (local->virt_monitors &&
 		    !ieee80211_hw_check(&local->hw, SUPPORTS_CONC_MON_RX_DECAP))
 			flags &= ~IEEE80211_OFFLOAD_DECAP_ENABLED;
 	} else {
@@ -1336,20 +1338,22 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
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
index fdda14c08e2b1..dec6e16b8c7d2 100644
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
2.39.5


