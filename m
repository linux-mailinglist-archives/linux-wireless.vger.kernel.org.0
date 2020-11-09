Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44342AB42B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 10:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgKIJ6B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 04:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729277AbgKIJ55 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 04:57:57 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED15C0613CF
        for <linux-wireless@vger.kernel.org>; Mon,  9 Nov 2020 01:57:56 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kc3vu-004EGg-MK; Mon, 09 Nov 2020 10:57:54 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 7/8] mac80211: remove WDS-related code
Date:   Mon,  9 Nov 2020 10:57:46 +0100
Message-Id: <20201109105103.38960c413d46.I3603c90a44562d847c39d15d5ff33d8c00df5834@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201109095747.113720-1-johannes@sipsolutions.net>
References: <20201109095747.113720-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Now that all the mac80211-based drivers have removed WDS code
and in particular the ability to advertise such devices, also
remove all the code related to WDS here.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c            | 11 --------
 net/mac80211/chan.c           |  3 +--
 net/mac80211/debugfs_netdev.c | 11 --------
 net/mac80211/ieee80211_i.h    |  6 -----
 net/mac80211/iface.c          | 50 ++++-------------------------------
 net/mac80211/main.c           |  8 ------
 net/mac80211/pm.c             | 15 -----------
 net/mac80211/rx.c             |  5 ----
 net/mac80211/tx.c             | 26 ++----------------
 net/mac80211/util.c           |  2 +-
 net/mac80211/wme.c            |  3 ---
 11 files changed, 9 insertions(+), 131 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 7276e66ae435..454432ced0c9 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2708,16 +2708,6 @@ static int ieee80211_get_tx_power(struct wiphy *wiphy,
 	return 0;
 }
 
-static int ieee80211_set_wds_peer(struct wiphy *wiphy, struct net_device *dev,
-				  const u8 *addr)
-{
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
-
-	memcpy(&sdata->u.wds.remote_addr, addr, ETH_ALEN);
-
-	return 0;
-}
-
 static void ieee80211_rfkill_poll(struct wiphy *wiphy)
 {
 	struct ieee80211_local *local = wiphy_priv(wiphy);
@@ -4138,7 +4128,6 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.set_wiphy_params = ieee80211_set_wiphy_params,
 	.set_tx_power = ieee80211_set_tx_power,
 	.get_tx_power = ieee80211_get_tx_power,
-	.set_wds_peer = ieee80211_set_wds_peer,
 	.rfkill_poll = ieee80211_rfkill_poll,
 	CFG80211_TESTMODE_CMD(ieee80211_testmode_cmd)
 	CFG80211_TESTMODE_DUMP(ieee80211_testmode_dump)
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 8f48aff74c7b..b6c80a45b9f5 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -275,11 +275,11 @@ ieee80211_get_chanctx_max_required_bw(struct ieee80211_local *local,
 		case NL80211_IFTYPE_NAN:
 			continue;
 		case NL80211_IFTYPE_ADHOC:
-		case NL80211_IFTYPE_WDS:
 		case NL80211_IFTYPE_MESH_POINT:
 		case NL80211_IFTYPE_OCB:
 			width = vif->bss_conf.chandef.width;
 			break;
+		case NL80211_IFTYPE_WDS:
 		case NL80211_IFTYPE_UNSPECIFIED:
 		case NUM_NL80211_IFTYPES:
 		case NL80211_IFTYPE_MONITOR:
@@ -743,7 +743,6 @@ void ieee80211_recalc_smps_chanctx(struct ieee80211_local *local,
 			continue;
 		case NL80211_IFTYPE_AP:
 		case NL80211_IFTYPE_ADHOC:
-		case NL80211_IFTYPE_WDS:
 		case NL80211_IFTYPE_MESH_POINT:
 		case NL80211_IFTYPE_OCB:
 			break;
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index fe8a7a87e513..9fc8ce214322 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -574,9 +574,6 @@ static ssize_t ieee80211_if_parse_tsf(
 IEEE80211_IF_FILE_RW(tsf);
 
 
-/* WDS attributes */
-IEEE80211_IF_FILE(peer, u.wds.remote_addr, MAC);
-
 #ifdef CONFIG_MAC80211_MESH
 IEEE80211_IF_FILE(estab_plinks, u.mesh.estab_plinks, ATOMIC);
 
@@ -701,11 +698,6 @@ static void add_ibss_files(struct ieee80211_sub_if_data *sdata)
 	DEBUGFS_ADD_MODE(tsf, 0600);
 }
 
-static void add_wds_files(struct ieee80211_sub_if_data *sdata)
-{
-	DEBUGFS_ADD(peer);
-}
-
 #ifdef CONFIG_MAC80211_MESH
 
 static void add_mesh_files(struct ieee80211_sub_if_data *sdata)
@@ -805,9 +797,6 @@ static void add_files(struct ieee80211_sub_if_data *sdata)
 	case NL80211_IFTYPE_AP_VLAN:
 		add_vlan_files(sdata);
 		break;
-	case NL80211_IFTYPE_WDS:
-		add_wds_files(sdata);
-		break;
 	default:
 		break;
 	}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 2a21226fb518..bb56fdd0db81 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -311,11 +311,6 @@ struct ieee80211_if_ap {
 	bool multicast_to_unicast;
 };
 
-struct ieee80211_if_wds {
-	struct sta_info *sta;
-	u8 remote_addr[ETH_ALEN];
-};
-
 struct ieee80211_if_vlan {
 	struct list_head list; /* write-protected with RTNL and local->mtx */
 
@@ -985,7 +980,6 @@ struct ieee80211_sub_if_data {
 
 	union {
 		struct ieee80211_if_ap ap;
-		struct ieee80211_if_wds wds;
 		struct ieee80211_if_vlan vlan;
 		struct ieee80211_if_managed mgd;
 		struct ieee80211_if_ibss ibss;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 56a1bcea2c1c..51ef7a7ea93c 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -230,10 +230,6 @@ static inline int identical_mac_addr_allowed(int type1, int type2)
 		type2 == NL80211_IFTYPE_MONITOR ||
 		type1 == NL80211_IFTYPE_P2P_DEVICE ||
 		type2 == NL80211_IFTYPE_P2P_DEVICE ||
-		(type1 == NL80211_IFTYPE_AP && type2 == NL80211_IFTYPE_WDS) ||
-		(type1 == NL80211_IFTYPE_WDS &&
-			(type2 == NL80211_IFTYPE_WDS ||
-			 type2 == NL80211_IFTYPE_AP)) ||
 		(type1 == NL80211_IFTYPE_AP && type2 == NL80211_IFTYPE_AP_VLAN) ||
 		(type1 == NL80211_IFTYPE_AP_VLAN &&
 			(type2 == NL80211_IFTYPE_AP ||
@@ -417,15 +413,12 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
 	 * (because if we remove a STA after ops->remove_interface()
 	 * the driver will have removed the vif info already!)
 	 *
-	 * In WDS mode a station must exist here and be flushed, for
-	 * AP_VLANs stations may exist since there's nothing else that
+	 * For AP_VLANs stations may exist since there's nothing else that
 	 * would have removed them, but in other modes there shouldn't
 	 * be any stations.
 	 */
 	flushed = sta_info_flush(sdata);
-	WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
-		     ((sdata->vif.type != NL80211_IFTYPE_WDS && flushed > 0) ||
-		      (sdata->vif.type == NL80211_IFTYPE_WDS && flushed != 1)));
+	WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_AP_VLAN && flushed > 0);
 
 	/* don't count this interface for allmulti while it is down */
 	if (sdata->flags & IEEE80211_SDATA_ALLMULTI)
@@ -552,8 +545,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
 		 * When we get here, the interface is marked down.
 		 * Free the remaining keys, if there are any
 		 * (which can happen in AP mode if userspace sets
-		 * keys before the interface is operating, and maybe
-		 * also in WDS mode)
+		 * keys before the interface is operating)
 		 *
 		 * Force the key freeing to always synchronize_net()
 		 * to wait for the RX path in case it is using this
@@ -1026,10 +1018,6 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	u32 hw_reconf_flags = 0;
 
 	switch (sdata->vif.type) {
-	case NL80211_IFTYPE_WDS:
-		if (!is_valid_ether_addr(sdata->u.wds.remote_addr))
-			return -ENOLINK;
-		break;
 	case NL80211_IFTYPE_AP_VLAN: {
 		struct ieee80211_sub_if_data *master;
 
@@ -1078,6 +1066,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	case NUM_NL80211_IFTYPES:
 	case NL80211_IFTYPE_P2P_CLIENT:
 	case NL80211_IFTYPE_P2P_GO:
+	case NL80211_IFTYPE_WDS:
 		/* cannot happen */
 		WARN_ON(1);
 		break;
@@ -1196,7 +1185,6 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		case NL80211_IFTYPE_OCB:
 			netif_carrier_off(dev);
 			break;
-		case NL80211_IFTYPE_WDS:
 		case NL80211_IFTYPE_P2P_DEVICE:
 		case NL80211_IFTYPE_NAN:
 			break;
@@ -1218,28 +1206,6 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	set_bit(SDATA_STATE_RUNNING, &sdata->state);
 
 	switch (sdata->vif.type) {
-	case NL80211_IFTYPE_WDS:
-		/* Create STA entry for the WDS peer */
-		sta = sta_info_alloc(sdata, sdata->u.wds.remote_addr,
-				     GFP_KERNEL);
-		if (!sta) {
-			res = -ENOMEM;
-			goto err_del_interface;
-		}
-
-		sta_info_pre_move_state(sta, IEEE80211_STA_AUTH);
-		sta_info_pre_move_state(sta, IEEE80211_STA_ASSOC);
-		sta_info_pre_move_state(sta, IEEE80211_STA_AUTHORIZED);
-
-		res = sta_info_insert(sta);
-		if (res) {
-			/* STA has been freed */
-			goto err_del_interface;
-		}
-
-		rate_control_rate_init(sta);
-		netif_carrier_on(dev);
-		break;
 	case NL80211_IFTYPE_P2P_DEVICE:
 		rcu_assign_pointer(local->p2p_sdata, sdata);
 		break;
@@ -1576,9 +1542,6 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 		sdata->u.mntr.flags = MONITOR_FLAG_CONTROL |
 				      MONITOR_FLAG_OTHER_BSS;
 		break;
-	case NL80211_IFTYPE_WDS:
-		sdata->vif.bss_conf.bssid = NULL;
-		break;
 	case NL80211_IFTYPE_NAN:
 		idr_init(&sdata->u.nan.function_inst_ids);
 		spin_lock_init(&sdata->u.nan.func_lock);
@@ -1633,9 +1596,7 @@ static int ieee80211_runtime_change_iftype(struct ieee80211_sub_if_data *sdata,
 	case NL80211_IFTYPE_OCB:
 		/*
 		 * Could probably support everything
-		 * but WDS here (WDS do_open can fail
-		 * under memory pressure, which this
-		 * code isn't prepared to handle).
+		 * but here.
 		 */
 		break;
 	case NL80211_IFTYPE_P2P_CLIENT:
@@ -1728,7 +1689,6 @@ static void ieee80211_assign_perm_addr(struct ieee80211_local *local,
 	case NL80211_IFTYPE_MONITOR:
 		/* doesn't matter */
 		break;
-	case NL80211_IFTYPE_WDS:
 	case NL80211_IFTYPE_AP_VLAN:
 		/* match up with an AP interface */
 		list_for_each_entry(sdata, &local->interfaces, list) {
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 523380aed92e..b58d588440f0 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -935,14 +935,6 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 				return -EINVAL;
 		}
 	} else {
-		/*
-		 * WDS is currently prohibited when channel contexts are used
-		 * because there's no clear definition of which channel WDS
-		 * type interfaces use
-		 */
-		if (local->hw.wiphy->interface_modes & BIT(NL80211_IFTYPE_WDS))
-			return -EINVAL;
-
 		/* DFS is not supported with multi-channel combinations yet */
 		for (i = 0; i < local->hw.wiphy->n_iface_combinations; i++) {
 			const struct ieee80211_iface_combination *comb;
diff --git a/net/mac80211/pm.c b/net/mac80211/pm.c
index 38c45e1dafd8..ae378a41c927 100644
--- a/net/mac80211/pm.c
+++ b/net/mac80211/pm.c
@@ -150,21 +150,6 @@ int __ieee80211_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 		case NL80211_IFTYPE_STATION:
 			ieee80211_mgd_quiesce(sdata);
 			break;
-		case NL80211_IFTYPE_WDS:
-			/* tear down aggregation sessions and remove STAs */
-			mutex_lock(&local->sta_mtx);
-			sta = sdata->u.wds.sta;
-			if (sta && sta->uploaded) {
-				enum ieee80211_sta_state state;
-
-				state = sta->sta_state;
-				for (; state > IEEE80211_STA_NOTEXIST; state--)
-					WARN_ON(drv_sta_state(local, sta->sdata,
-							      sta, state,
-							      state - 1));
-			}
-			mutex_unlock(&local->sta_mtx);
-			break;
 		default:
 			break;
 		}
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 09d1c9fb8872..062c2b45584e 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1477,7 +1477,6 @@ ieee80211_rx_h_check(struct ieee80211_rx_data *rx)
 	if (unlikely((ieee80211_is_data(hdr->frame_control) ||
 		      ieee80211_is_pspoll(hdr->frame_control)) &&
 		     rx->sdata->vif.type != NL80211_IFTYPE_ADHOC &&
-		     rx->sdata->vif.type != NL80211_IFTYPE_WDS &&
 		     rx->sdata->vif.type != NL80211_IFTYPE_OCB &&
 		     (!rx->sta || !test_sta_flag(rx->sta, WLAN_STA_ASSOC)))) {
 		/*
@@ -4080,10 +4079,6 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			return false;
 
 		return true;
-	case NL80211_IFTYPE_WDS:
-		if (bssid || !ieee80211_is_data(hdr->frame_control))
-			return false;
-		return ether_addr_equal(sdata->u.wds.remote_addr, hdr->addr2);
 	case NL80211_IFTYPE_P2P_DEVICE:
 		return ieee80211_is_public_action(hdr, skb->len) ||
 		       ieee80211_is_probe_req(hdr->frame_control) ||
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 1651cf7b2500..72f84b33a6ba 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -319,9 +319,6 @@ ieee80211_tx_h_check_assoc(struct ieee80211_tx_data *tx)
 	if (tx->sdata->vif.type == NL80211_IFTYPE_OCB)
 		return TX_CONTINUE;
 
-	if (tx->sdata->vif.type == NL80211_IFTYPE_WDS)
-		return TX_CONTINUE;
-
 	if (tx->flags & IEEE80211_TX_PS_BUFFERED)
 		return TX_CONTINUE;
 
@@ -2289,8 +2286,7 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 	 * we handle as though they are non-injected frames.
 	 * This code here isn't entirely correct, the local MAC address
 	 * isn't always enough to find the interface to use; for proper
-	 * VLAN/WDS support we will need a different mechanism (which
-	 * likely isn't going to be monitor interfaces).
+	 * VLAN support we have an nl80211-based mechanism.
 	 *
 	 * This is necessary, for example, for old hostapd versions that
 	 * don't use nl80211-based management TX/RX.
@@ -2301,8 +2297,7 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 		if (!ieee80211_sdata_running(tmp_sdata))
 			continue;
 		if (tmp_sdata->vif.type == NL80211_IFTYPE_MONITOR ||
-		    tmp_sdata->vif.type == NL80211_IFTYPE_AP_VLAN ||
-		    tmp_sdata->vif.type == NL80211_IFTYPE_WDS)
+		    tmp_sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 			continue;
 		if (ether_addr_equal(tmp_sdata->vif.addr, hdr->addr2)) {
 			sdata = tmp_sdata;
@@ -2396,9 +2391,6 @@ int ieee80211_lookup_ra_sta(struct ieee80211_sub_if_data *sdata,
 		}
 		sta = sta_info_get_bss(sdata, skb->data);
 		break;
-	case NL80211_IFTYPE_WDS:
-		sta = sta_info_get(sdata, sdata->u.wds.remote_addr);
-		break;
 #ifdef CONFIG_MAC80211_MESH
 	case NL80211_IFTYPE_MESH_POINT:
 		/* determined much later */
@@ -2574,20 +2566,6 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 		hdrlen = 24;
 		band = chanctx_conf->def.chan->band;
 		break;
-	case NL80211_IFTYPE_WDS:
-		fc |= cpu_to_le16(IEEE80211_FCTL_FROMDS | IEEE80211_FCTL_TODS);
-		/* RA TA DA SA */
-		memcpy(hdr.addr1, sdata->u.wds.remote_addr, ETH_ALEN);
-		memcpy(hdr.addr2, sdata->vif.addr, ETH_ALEN);
-		memcpy(hdr.addr3, skb->data, ETH_ALEN);
-		memcpy(hdr.addr4, skb->data + ETH_ALEN, ETH_ALEN);
-		hdrlen = 30;
-		/*
-		 * This is the exception! WDS style interfaces are prohibited
-		 * when channel contexts are in used so this must be valid
-		 */
-		band = local->hw.conf.chandef.chan->band;
-		break;
 #ifdef CONFIG_MAC80211_MESH
 	case NL80211_IFTYPE_MESH_POINT:
 		if (!is_multicast_ether_addr(skb->data)) {
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 49342060490f..70a27948a084 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2513,7 +2513,6 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 				return res;
 			}
 			break;
-		case NL80211_IFTYPE_WDS:
 		case NL80211_IFTYPE_AP_VLAN:
 		case NL80211_IFTYPE_MONITOR:
 		case NL80211_IFTYPE_P2P_DEVICE:
@@ -2523,6 +2522,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		case NUM_NL80211_IFTYPES:
 		case NL80211_IFTYPE_P2P_CLIENT:
 		case NL80211_IFTYPE_P2P_GO:
+		case NL80211_IFTYPE_WDS:
 			WARN_ON(1);
 			break;
 		}
diff --git a/net/mac80211/wme.c b/net/mac80211/wme.c
index 2702d314ef59..9ea6004abe1b 100644
--- a/net/mac80211/wme.c
+++ b/net/mac80211/wme.c
@@ -205,9 +205,6 @@ u16 ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
 	case NL80211_IFTYPE_AP:
 		ra = skb->data;
 		break;
-	case NL80211_IFTYPE_WDS:
-		ra = sdata->u.wds.remote_addr;
-		break;
 	case NL80211_IFTYPE_STATION:
 		/* might be a TDLS station */
 		sta = sta_info_get(sdata, skb->data);
-- 
2.26.2

