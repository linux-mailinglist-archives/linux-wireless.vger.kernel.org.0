Return-Path: <linux-wireless+bounces-11687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 254CA95866B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 14:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90F9EB2222A
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBEE190052;
	Tue, 20 Aug 2024 12:00:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC46018F2E0
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155234; cv=none; b=sCe6rTVP0iYbqtaeU/aqcAFPOFNfAPq3Tt7pm2YQhTJqn3GXiXJwZQzIqJn/DhU2EctUmqiGsSqP9ZJ8RJnXp026th26BrE/5AUAjBo092QX4epYq55OeZUjA2BGFyZjpxUDxHl41beIerfhoLl16o5fTg9SdYNLEy+H+udJ8HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155234; c=relaxed/simple;
	bh=mhTrDaiebGDY7kRj4LaTKvbwTASM29CFZ/GNVUSNDr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gOiUrLWNDgRfdCX4yzdr88g0sghK02j3SkArt3i6DSt+nDzcpXlMmpOaLEtXF0/5CinzZ9EVLqOAyH0DXXj0IMmNzvgMXMgTQlL135WEvPlhcdWnktmfL0QoXBDo5MA+pF7kszSjOc/47NEI9BQF/LjZfRtii++cXNtOAy6exPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXG-0000ut-HR; Tue, 20 Aug 2024 14:00:26 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXG-001lND-2P; Tue, 20 Aug 2024 14:00:26 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-1J;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:38 +0200
Subject: [PATCH 13/31] wifi: mwifiex: drop driver internal AP/STA limit
 counting
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-13-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=9634;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=mhTrDaiebGDY7kRj4LaTKvbwTASM29CFZ/GNVUSNDr8=;
 b=1rubbqlPRBBzrzsXGZXHRmC94TFO7HtsOYz0K/jx6jJzlGr9Eovbk67SqCp6lFrFwjcWqPc/a
 WYglYAAbeTHCTT4bi4GvFPDpGS2MNZL7FOvMp787q1kmmOAFr8hzQAQ
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

The mwifiex driver maintains internal counters to check if there
are still enough resources to change a virtual interface to a certain
type. This seems to be a remnant of old times and can be removed.

We can currently create three virtual interfaces (could be expanded to
16) and each of the interfaces can be configured to any type without
further restrictions. The limits we actually have are already correctly
described in wiphy->iface_combinations.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 149 ------------------------
 drivers/net/wireless/marvell/mwifiex/decl.h     |  10 --
 drivers/net/wireless/marvell/mwifiex/init.c     |   3 -
 drivers/net/wireless/marvell/mwifiex/main.h     |   2 -
 4 files changed, 164 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 715d98b7ff550..4c63b849e3809 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -963,117 +963,6 @@ mwifiex_init_new_priv_params(struct mwifiex_private *priv,
 	return 0;
 }
 
-static bool
-is_vif_type_change_allowed(struct mwifiex_adapter *adapter,
-			   enum nl80211_iftype old_iftype,
-			   enum nl80211_iftype new_iftype)
-{
-	switch (old_iftype) {
-	case NL80211_IFTYPE_ADHOC:
-		switch (new_iftype) {
-		case NL80211_IFTYPE_STATION:
-			return true;
-		case NL80211_IFTYPE_P2P_CLIENT:
-		case NL80211_IFTYPE_P2P_GO:
-			return adapter->curr_iface_comb.p2p_intf !=
-			       adapter->iface_limit.p2p_intf;
-		case NL80211_IFTYPE_AP:
-			return adapter->curr_iface_comb.uap_intf !=
-			       adapter->iface_limit.uap_intf;
-		default:
-			return false;
-		}
-
-	case NL80211_IFTYPE_STATION:
-		switch (new_iftype) {
-		case NL80211_IFTYPE_ADHOC:
-			return true;
-		case NL80211_IFTYPE_P2P_CLIENT:
-		case NL80211_IFTYPE_P2P_GO:
-			return adapter->curr_iface_comb.p2p_intf !=
-			       adapter->iface_limit.p2p_intf;
-		case NL80211_IFTYPE_AP:
-			return adapter->curr_iface_comb.uap_intf !=
-			       adapter->iface_limit.uap_intf;
-		default:
-			return false;
-		}
-
-	case NL80211_IFTYPE_AP:
-		switch (new_iftype) {
-		case NL80211_IFTYPE_ADHOC:
-		case NL80211_IFTYPE_STATION:
-			return adapter->curr_iface_comb.sta_intf !=
-			       adapter->iface_limit.sta_intf;
-		case NL80211_IFTYPE_P2P_CLIENT:
-		case NL80211_IFTYPE_P2P_GO:
-			return adapter->curr_iface_comb.p2p_intf !=
-			       adapter->iface_limit.p2p_intf;
-		default:
-			return false;
-		}
-
-	case NL80211_IFTYPE_P2P_CLIENT:
-		switch (new_iftype) {
-		case NL80211_IFTYPE_ADHOC:
-		case NL80211_IFTYPE_STATION:
-			return true;
-		case NL80211_IFTYPE_P2P_GO:
-			return true;
-		case NL80211_IFTYPE_AP:
-			return adapter->curr_iface_comb.uap_intf !=
-			       adapter->iface_limit.uap_intf;
-		default:
-			return false;
-		}
-
-	case NL80211_IFTYPE_P2P_GO:
-		switch (new_iftype) {
-		case NL80211_IFTYPE_ADHOC:
-		case NL80211_IFTYPE_STATION:
-			return true;
-		case NL80211_IFTYPE_P2P_CLIENT:
-			return true;
-		case NL80211_IFTYPE_AP:
-			return adapter->curr_iface_comb.uap_intf !=
-			       adapter->iface_limit.uap_intf;
-		default:
-			return false;
-		}
-
-	default:
-		break;
-	}
-
-	return false;
-}
-
-static void
-update_vif_type_counter(struct mwifiex_adapter *adapter,
-			enum nl80211_iftype iftype,
-			int change)
-{
-	switch (iftype) {
-	case NL80211_IFTYPE_UNSPECIFIED:
-	case NL80211_IFTYPE_ADHOC:
-	case NL80211_IFTYPE_STATION:
-		adapter->curr_iface_comb.sta_intf += change;
-		break;
-	case NL80211_IFTYPE_AP:
-		adapter->curr_iface_comb.uap_intf += change;
-		break;
-	case NL80211_IFTYPE_P2P_CLIENT:
-	case NL80211_IFTYPE_P2P_GO:
-		adapter->curr_iface_comb.p2p_intf += change;
-		break;
-	default:
-		mwifiex_dbg(adapter, ERROR,
-			    "%s: Unsupported iftype passed: %d\n",
-			    __func__, iftype);
-		break;
-	}
-}
-
 static int
 mwifiex_change_vif_to_p2p(struct net_device *dev,
 			  enum nl80211_iftype curr_iftype,
@@ -1098,8 +987,6 @@ mwifiex_change_vif_to_p2p(struct net_device *dev,
 	if (mwifiex_init_new_priv_params(priv, dev, type))
 		return -1;
 
-	update_vif_type_counter(adapter, curr_iftype, -1);
-	update_vif_type_counter(adapter, type, +1);
 	dev->ieee80211_ptr->iftype = type;
 
 	switch (type) {
@@ -1156,8 +1043,6 @@ mwifiex_change_vif_to_sta_adhoc(struct net_device *dev,
 	if (mwifiex_init_new_priv_params(priv, dev, type))
 		return -1;
 
-	update_vif_type_counter(adapter, curr_iftype, -1);
-	update_vif_type_counter(adapter, type, +1);
 	dev->ieee80211_ptr->iftype = type;
 
 	if (mwifiex_send_cmd(priv, HostCmd_CMD_SET_BSS_MODE,
@@ -1193,8 +1078,6 @@ mwifiex_change_vif_to_ap(struct net_device *dev,
 	if (mwifiex_init_new_priv_params(priv, dev, type))
 		return -1;
 
-	update_vif_type_counter(adapter, curr_iftype, -1);
-	update_vif_type_counter(adapter, type, +1);
 	dev->ieee80211_ptr->iftype = type;
 
 	if (mwifiex_send_cmd(priv, HostCmd_CMD_SET_BSS_MODE,
@@ -1237,13 +1120,6 @@ mwifiex_cfg80211_change_virtual_intf(struct wiphy *wiphy,
 		return 0;
 	}
 
-	if (!is_vif_type_change_allowed(priv->adapter, curr_iftype, type)) {
-		mwifiex_dbg(priv->adapter, ERROR,
-			    "%s: change from type %d to %d is not allowed\n",
-			    dev->name, curr_iftype, type);
-		return -EOPNOTSUPP;
-	}
-
 	switch (curr_iftype) {
 	case NL80211_IFTYPE_ADHOC:
 		switch (type) {
@@ -2988,13 +2864,6 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_ADHOC:
-		if (adapter->curr_iface_comb.sta_intf ==
-		    adapter->iface_limit.sta_intf) {
-			mwifiex_dbg(adapter, ERROR,
-				    "cannot create multiple sta/adhoc ifaces\n");
-			return ERR_PTR(-EINVAL);
-		}
-
 		priv = mwifiex_get_unused_priv(adapter);
 		if (!priv) {
 			mwifiex_dbg(adapter, ERROR,
@@ -3017,13 +2886,6 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 
 		break;
 	case NL80211_IFTYPE_AP:
-		if (adapter->curr_iface_comb.uap_intf ==
-		    adapter->iface_limit.uap_intf) {
-			mwifiex_dbg(adapter, ERROR,
-				    "cannot create multiple AP ifaces\n");
-			return ERR_PTR(-EINVAL);
-		}
-
 		priv = mwifiex_get_unused_priv(adapter);
 		if (!priv) {
 			mwifiex_dbg(adapter, ERROR,
@@ -3043,13 +2905,6 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 
 		break;
 	case NL80211_IFTYPE_P2P_CLIENT:
-		if (adapter->curr_iface_comb.p2p_intf ==
-		    adapter->iface_limit.p2p_intf) {
-			mwifiex_dbg(adapter, ERROR,
-				    "cannot create multiple P2P ifaces\n");
-			return ERR_PTR(-EINVAL);
-		}
-
 		priv = mwifiex_get_unused_priv(adapter);
 		if (!priv) {
 			mwifiex_dbg(adapter, ERROR,
@@ -3182,8 +3037,6 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 	mwifiex_dev_debugfs_init(priv);
 #endif
 
-	update_vif_type_counter(adapter, type, +1);
-
 	return &priv->wdev;
 
 err_reg_netdev:
@@ -3246,8 +3099,6 @@ int mwifiex_del_virtual_intf(struct wiphy *wiphy, struct wireless_dev *wdev)
 	/* Clear the priv in adapter */
 	priv->netdev = NULL;
 
-	update_vif_type_counter(adapter, priv->bss_mode, -1);
-
 	priv->bss_mode = NL80211_IFTYPE_UNSPECIFIED;
 
 	if (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_STA ||
diff --git a/drivers/net/wireless/marvell/mwifiex/decl.h b/drivers/net/wireless/marvell/mwifiex/decl.h
index 84603f1e7f6e0..d64f75119014c 100644
--- a/drivers/net/wireless/marvell/mwifiex/decl.h
+++ b/drivers/net/wireless/marvell/mwifiex/decl.h
@@ -122,10 +122,6 @@
 /* Rate index for OFDM 0 */
 #define MWIFIEX_RATE_INDEX_OFDM0   4
 
-#define MWIFIEX_MAX_STA_NUM		3
-#define MWIFIEX_MAX_UAP_NUM		3
-#define MWIFIEX_MAX_P2P_NUM		3
-
 #define MWIFIEX_A_BAND_START_FREQ	5000
 
 /* SDIO Aggr data packet special info */
@@ -267,12 +263,6 @@ struct mwifiex_histogram_data {
 	atomic_t num_samples;
 };
 
-struct mwifiex_iface_comb {
-	u8 sta_intf;
-	u8 uap_intf;
-	u8 p2p_intf;
-};
-
 struct mwifiex_radar_params {
 	struct cfg80211_chan_def *chandef;
 	u32 cac_time_ms;
diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index 0259c9f88486b..df89c9dc44b75 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -307,9 +307,6 @@ static void mwifiex_init_adapter(struct mwifiex_adapter *adapter)
 	adapter->key_api_major_ver = 0;
 	adapter->key_api_minor_ver = 0;
 	eth_broadcast_addr(adapter->perm_addr);
-	adapter->iface_limit.sta_intf = MWIFIEX_MAX_STA_NUM;
-	adapter->iface_limit.uap_intf = MWIFIEX_MAX_UAP_NUM;
-	adapter->iface_limit.p2p_intf = MWIFIEX_MAX_P2P_NUM;
 	adapter->active_scan_triggered = false;
 	timer_setup(&adapter->wakeup_timer, wakeup_timer_fn, 0);
 	adapter->devdump_len = 0;
diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 39f9bb49f83ff..60bdc6329d4a0 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -856,8 +856,6 @@ struct mwifiex_if_ops {
 struct mwifiex_adapter {
 	u8 iface_type;
 	unsigned int debug_mask;
-	struct mwifiex_iface_comb iface_limit;
-	struct mwifiex_iface_comb curr_iface_comb;
 	struct mwifiex_private *priv[MWIFIEX_MAX_BSS_NUM];
 	u8 priv_num;
 	const struct firmware *firmware;

-- 
2.39.2


