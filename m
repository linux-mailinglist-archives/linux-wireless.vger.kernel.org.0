Return-Path: <linux-wireless+bounces-13533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8706A991087
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 22:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A90A1F25F0C
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 20:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48FA1D90A9;
	Fri,  4 Oct 2024 20:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="IrqP+A4l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B4A1D8A0F
	for <linux-wireless@vger.kernel.org>; Fri,  4 Oct 2024 20:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728073333; cv=none; b=BLClJeEgXKvxdKPTOcCYPls8Pnq0gu4hkAs1AqcLS4q51VYUDmNcmjL5RwpWmdhtE5CZijPWICnjIGBW6dBvSuxTn7IRbHNk0nxBsfBftzOKGj4HWWj6A1G/+VSaiLIsaL0OSyPN13+ls0xzgsmNT98VM5mQW9FyW3Qf4lHlnfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728073333; c=relaxed/simple;
	bh=9+6QACUb+GhnZBZC6bGuSL4roRCNT1wWjwIVB6Mm7Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLn34/KihaRh8yTbuICiJEaKBEfOcTD94RlSXie0gFsvOwLobX0XBm6cidUqZT9XTtHCZspCBT0UvLULxFXGGZ8RXCHZ2APxGdqjtBg1HX0r5J7/7gmonUOiYuU5v3iXbKYCEJFMOEvMfnlX9ze51FtCfayCVIkC+OdGJOTmxZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=IrqP+A4l; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Z8ylunqAvnBjE6nhboz5X7aY/14jSbwOaRzAWcLmtOw=; b=IrqP+A4lZcKKrTR6XSJYjLmRLg
	9zIMJOWS5IdhBCasZdgcA/B55Ke03iMIcIORWYXsl7TziHuUicuYtkv2QOHEQD+lNiPji4Y7OA0os
	fVNfK3T7jsnW2ZyMweKvRDiibKREBrTrwuVg/8NM7YxRO2a2m8pQVUIrS2KPfxIC1Z68=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1swooN-004jVl-2F;
	Fri, 04 Oct 2024 22:22:03 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v3 07/11] wifi: mac80211: add flag to opt out of virtual monitor support
Date: Fri,  4 Oct 2024 22:21:57 +0200
Message-ID: <17d878796b36fbadffa677f418e300c0058c485e.1728063865.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.b9e938930e3d3683952cc034fde2a2e938e0b6f8.1728063865.git-series.nbd@nbd.name>
References: <cover.b9e938930e3d3683952cc034fde2a2e938e0b6f8.1728063865.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is useful for multi-radio devices that are capable of monitoring on
multiple channels simultanenously. When this flag is set, each monitor
interface is passed to the driver individually and can have a configured
channel.
The vif mac address for non-active monitor interfaces is cleared, in order
to allow the driver to tell them apart from active ones.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/mac80211.h    |  6 +++++-
 net/mac80211/cfg.c        | 44 +++++++++++++++++++++++++---------------
 net/mac80211/chan.c       | 14 ++++++++++++-
 net/mac80211/debugfs.c    |  1 +-
 net/mac80211/driver-ops.c |  1 +-
 net/mac80211/iface.c      | 22 +++++++++++++++-----
 net/mac80211/rx.c         |  3 +++-
 net/mac80211/tx.c         |  6 +++--
 net/mac80211/util.c       | 14 +++++++++----
 9 files changed, 83 insertions(+), 28 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index be916e1e5e1d..1343ea4f8103 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2679,6 +2679,11 @@ struct ieee80211_txq {
  *	a virtual monitor interface when monitor interfaces are the only
  *	active interfaces.
  *
+ * @IEEE80211_HW_NO_VIRTUAL_MONITOR: The driver would like to be informed
+ *	of any monitor interface, as well as their configured channel.
+ *	This is useful for supporting multiple monitor interfaces on different
+ *	channels.
+ *
  * @IEEE80211_HW_NO_AUTO_VIF: The driver would like for no wlanX to
  *	be created.  It is expected user-space will create vifs as
  *	desired (and thus have them named as desired).
@@ -2838,6 +2843,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_SUPPORTS_DYNAMIC_PS,
 	IEEE80211_HW_MFP_CAPABLE,
 	IEEE80211_HW_WANT_MONITOR_VIF,
+	IEEE80211_HW_NO_VIRTUAL_MONITOR,
 	IEEE80211_HW_NO_AUTO_VIF,
 	IEEE80211_HW_SW_CRYPTO_CONTROL,
 	IEEE80211_HW_SUPPORT_FAST_XMIT,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b1ea7006f8d3..a67f38bc3961 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -105,8 +105,11 @@ static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
 	}
 
 	/* also validate MU-MIMO change */
-	monitor_sdata = wiphy_dereference(local->hw.wiphy,
-					  local->monitor_sdata);
+	if (ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
+		monitor_sdata = sdata;
+	else
+		monitor_sdata = wiphy_dereference(local->hw.wiphy,
+						  local->monitor_sdata);
 
 	if (!monitor_sdata &&
 	    (params->vht_mumimo_groups || params->vht_mumimo_follow_addr))
@@ -114,7 +117,9 @@ static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
 
 	/* apply all changes now - no failures allowed */
 
-	if (monitor_sdata && ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
+	if (monitor_sdata &&
+		(ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF) ||
+		 ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR)))
 		ieee80211_set_mu_mimo_follow(monitor_sdata, params);
 
 	if (params->flags) {
@@ -889,22 +894,25 @@ static int ieee80211_set_monitor_channel(struct wiphy *wiphy,
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (cfg80211_chandef_identical(&local->monitor_chanreq.oper,
-				       &chanreq.oper))
-		return 0;
+	sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	if (!ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR)) {
+		if (cfg80211_chandef_identical(&local->monitor_chanreq.oper,
+						   &chanreq.oper))
+			return 0;
 
-	sdata = wiphy_dereference(local->hw.wiphy,
-				  local->monitor_sdata);
-	if (!sdata)
-		goto done;
+		sdata = wiphy_dereference(wiphy, local->monitor_sdata);
+		if (!sdata)
+			goto done;
+	}
 
-	if (cfg80211_chandef_identical(&sdata->vif.bss_conf.chanreq.oper,
+	if (rcu_access_pointer(sdata->deflink.conf->chanctx_conf) &&
+		cfg80211_chandef_identical(&sdata->vif.bss_conf.chanreq.oper,
 				       &chanreq.oper))
 		return 0;
 
 	ieee80211_link_release_channel(&sdata->deflink);
 	ret = ieee80211_link_use_channel(&sdata->deflink, &chanreq,
-					 IEEE80211_CHANCTX_EXCLUSIVE);
+					 IEEE80211_CHANCTX_SHARED);
 	if (ret)
 		return ret;
 done:
@@ -3053,7 +3061,8 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 	if (wdev) {
 		sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 
-		if (sdata->vif.type == NL80211_IFTYPE_MONITOR) {
+		if (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
+		    !ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR)) {
 			if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
 				return -EOPNOTSUPP;
 
@@ -3101,7 +3110,8 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 	}
 
 	list_for_each_entry(sdata, &local->interfaces, list) {
-		if (sdata->vif.type == NL80211_IFTYPE_MONITOR) {
+		if (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
+		    !ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR)) {
 			has_monitor = true;
 			continue;
 		}
@@ -3111,7 +3121,8 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 		sdata->vif.bss_conf.txpower_type = txp_type;
 	}
 	list_for_each_entry(sdata, &local->interfaces, list) {
-		if (sdata->vif.type == NL80211_IFTYPE_MONITOR)
+		if (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
+		    !ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
 			continue;
 		ieee80211_recalc_txpower(sdata, update_txp_type);
 	}
@@ -4302,7 +4313,8 @@ static int ieee80211_cfg_get_channel(struct wiphy *wiphy,
 	if (chanctx_conf) {
 		*chandef = link->conf->chanreq.oper;
 		ret = 0;
-	} else if (local->open_count > 0 &&
+	} else if (!ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR) &&
+		   local->open_count > 0 &&
 		   local->open_count == local->monitors &&
 		   sdata->vif.type == NL80211_IFTYPE_MONITOR) {
 		*chandef = local->monitor_chanreq.oper;
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index fbc3b28953a6..c375c86dd38c 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -339,6 +339,10 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 		case NL80211_IFTYPE_P2P_DEVICE:
 		case NL80211_IFTYPE_NAN:
 			continue;
+		case NL80211_IFTYPE_MONITOR:
+			WARN_ON_ONCE(!ieee80211_hw_check(&local->hw,
+							 NO_VIRTUAL_MONITOR));
+			fallthrough;
 		case NL80211_IFTYPE_ADHOC:
 		case NL80211_IFTYPE_MESH_POINT:
 		case NL80211_IFTYPE_OCB:
@@ -347,7 +351,6 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 		case NL80211_IFTYPE_WDS:
 		case NL80211_IFTYPE_UNSPECIFIED:
 		case NUM_NL80211_IFTYPES:
-		case NL80211_IFTYPE_MONITOR:
 		case NL80211_IFTYPE_P2P_CLIENT:
 		case NL80211_IFTYPE_P2P_GO:
 			WARN_ON_ONCE(1);
@@ -956,6 +959,10 @@ void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 			if (!link->sdata->u.mgd.associated)
 				continue;
 			break;
+		case NL80211_IFTYPE_MONITOR:
+			if (!ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
+				continue;
+			break;
 		case NL80211_IFTYPE_AP:
 		case NL80211_IFTYPE_ADHOC:
 		case NL80211_IFTYPE_MESH_POINT:
@@ -968,6 +975,11 @@ void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 		if (rcu_access_pointer(link->conf->chanctx_conf) != &chanctx->conf)
 			continue;
 
+		if (link->sdata->vif.type == NL80211_IFTYPE_MONITOR) {
+			rx_chains_dynamic = rx_chains_static = local->rx_chains;
+			break;
+		}
+
 		switch (link->smps_mode) {
 		default:
 			WARN_ONCE(1, "Invalid SMPS mode %d\n",
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 02b5476a4376..b777240c924e 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -456,6 +456,7 @@ static const char *hw_flag_names[] = {
 	FLAG(SUPPORTS_DYNAMIC_PS),
 	FLAG(MFP_CAPABLE),
 	FLAG(WANT_MONITOR_VIF),
+	FLAG(NO_VIRTUAL_MONITOR),
 	FLAG(NO_AUTO_VIF),
 	FLAG(SW_CRYPTO_CONTROL),
 	FLAG(SUPPORT_FAST_XMIT),
diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index fe868b521622..8179310595ac 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -65,6 +65,7 @@ int drv_add_interface(struct ieee80211_local *local,
 	if (WARN_ON(sdata->vif.type == NL80211_IFTYPE_AP_VLAN ||
 		    (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
 		     !ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF) &&
+		     !ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR) &&
 		     !(sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE))))
 		return -EINVAL;
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 6ef0990d3d29..3aefc62034ba 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -279,8 +279,13 @@ static int _ieee80211_change_mac(struct ieee80211_sub_if_data *sdata,
 	ret = eth_mac_addr(sdata->dev, sa);
 
 	if (ret == 0) {
-		memcpy(sdata->vif.addr, sa->sa_data, ETH_ALEN);
-		ether_addr_copy(sdata->vif.bss_conf.addr, sdata->vif.addr);
+		if (check_dup) {
+			memcpy(sdata->vif.addr, sa->sa_data, ETH_ALEN);
+			ether_addr_copy(sdata->vif.bss_conf.addr, sdata->vif.addr);
+		} else {
+			memset(sdata->vif.addr, 0, ETH_ALEN);
+			memset(sdata->vif.bss_conf.addr, 0, ETH_ALEN);
+		}
 	}
 
 	/* Regardless of eth_mac_addr() return we still want to add the
@@ -699,9 +704,11 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 		ieee80211_recalc_idle(local);
 		ieee80211_recalc_offload(local);
 
-		if (!(sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE))
+		if (!(sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE) &&
+		    !ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
 			break;
 
+		ieee80211_link_release_channel(&sdata->deflink);
 		fallthrough;
 	default:
 		if (!going_down)
@@ -1131,7 +1138,8 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 	ASSERT_RTNL();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (local->monitor_sdata)
+	if (local->monitor_sdata ||
+	    ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
 		return 0;
 
 	sdata = kzalloc(sizeof(*sdata) + local->hw.vif_data_size, GFP_KERNEL);
@@ -1193,6 +1201,9 @@ void ieee80211_del_virtual_monitor(struct ieee80211_local *local)
 {
 	struct ieee80211_sub_if_data *sdata;
 
+	if (ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
+		return;
+
 	ASSERT_RTNL();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -1328,7 +1339,8 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 			break;
 		}
 
-		if (sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE) {
+		if ((sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE) ||
+		    ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR)) {
 			res = drv_add_interface(local, sdata);
 			if (res)
 				goto err_stop;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 718f02f0a181..b35e1b472e82 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -840,6 +840,9 @@ ieee80211_rx_monitor(struct ieee80211_local *local, struct sk_buff *origskb,
 		bool last_monitor = list_is_last(&sdata->u.mntr.list,
 						 &local->mon_list);
 
+		if (ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
+			ieee80211_handle_mu_mimo_mon(sdata, origskb, rtap_space);
+
 		if (!monskb)
 			monskb = ieee80211_make_monitor_skb(local, &origskb,
 							    rate, rtap_space,
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a9ee86982259..f55f0518b35e 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1763,7 +1763,8 @@ static bool __ieee80211_tx(struct ieee80211_local *local,
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_MONITOR:
-		if (sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE) {
+		if ((sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE) ||
+		    ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR)) {
 			vif = &sdata->vif;
 			break;
 		}
@@ -3952,7 +3953,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 
 	switch (tx.sdata->vif.type) {
 	case NL80211_IFTYPE_MONITOR:
-		if (tx.sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE) {
+		if ((tx.sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE) ||
+		    ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR)) {
 			vif = &tx.sdata->vif;
 			break;
 		}
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index f94faa86ba8a..279210fabd35 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -756,7 +756,8 @@ static void __iterate_interfaces(struct ieee80211_local *local,
 				lockdep_is_held(&local->hw.wiphy->mtx)) {
 		switch (sdata->vif.type) {
 		case NL80211_IFTYPE_MONITOR:
-			if (!(sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE))
+			if (!(sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE) &&
+			    !ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
 				continue;
 			break;
 		case NL80211_IFTYPE_AP_VLAN:
@@ -1873,8 +1874,10 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	}
 
 	list_for_each_entry(sdata, &local->interfaces, list) {
+		if (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
+		    !ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
+			continue;
 		if (sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
-		    sdata->vif.type != NL80211_IFTYPE_MONITOR &&
 		    ieee80211_sdata_running(sdata)) {
 			res = drv_add_interface(local, sdata);
 			if (WARN_ON(res))
@@ -1887,11 +1890,14 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	 */
 	if (res) {
 		list_for_each_entry_continue_reverse(sdata, &local->interfaces,
-						     list)
+						     list) {
+			if (sdata->vif.type == NL80211_IFTYPE_MONITOR &&
+			    !ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
+				continue;
 			if (sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
-			    sdata->vif.type != NL80211_IFTYPE_MONITOR &&
 			    ieee80211_sdata_running(sdata))
 				drv_remove_interface(local, sdata);
+		}
 		ieee80211_handle_reconfig_failure(local);
 		return res;
 	}
-- 
git-series 0.9.1

