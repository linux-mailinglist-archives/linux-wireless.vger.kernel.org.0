Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A483A78C23C
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Aug 2023 12:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbjH2KTu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Aug 2023 06:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbjH2KTX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Aug 2023 06:19:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B01F1A3
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 03:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=xqAePCLfz7E13Ci4rEST7CgiiFfm+CJQvnrKrjDVXIc=;
        t=1693304342; x=1694513942; b=BxXsf7Amr9k2aQhe4qtEGU6BG6CkKjdc9Sx/4POkhxLqq24
        hok+Ip+9mrTgxxUnQVmN20ruyCXAbEfigTG+V4S80J97PjGWRV5Nax2FFAECvQX/Bqz/mHZ2Jq2bn
        Weq7hXJEs5NEG1vSk36ccvFXGMb30aarH0w1YY+NR1YeTEZnDkkNPEVd8fodEslTNyygve+L9DC80
        u3qTOWriOQw/tASZVLGc0A1cbEYUR5CTMorMNcngATgE+Xd1YF9mkQ4PhoiWUONMj0DADZYs6GXqK
        DX5JWRwL9fGilXa/Cswr9k7uH6IDuSwI6P+YFDqc9hs1U+aep7IW6HDpt65DO+rQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qavoJ-000zrc-2m;
        Tue, 29 Aug 2023 12:19:00 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 40/40] wifi: cfg80211: remove wdev mutex
Date:   Tue, 29 Aug 2023 12:18:56 +0200
Message-ID: <20230829121855.7810134d2d62.I305c4dfc68d212721043f7a16b860e54fdab47ee@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828135928.a26d79032b43.I305c4dfc68d212721043f7a16b860e54fdab47ee@changeid>
References: <20230828135928.a26d79032b43.I305c4dfc68d212721043f7a16b860e54fdab47ee@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Since we're now protecting everything with the wiphy mutex
(and were really using it for almost everything before),
there's no longer any real reason to have a separate wdev
mutex. It may feel better, but really has no value.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |   4 +-
 drivers/net/wireless/marvell/mwifiex/11h.c    |   4 +-
 .../net/wireless/quantenna/qtnfmac/event.c    |   4 +-
 include/net/cfg80211.h                        |   6 +-
 include/net/mac80211.h                        |  20 +-
 net/mac80211/cfg.c                            |  43 +-
 net/mac80211/debugfs_netdev.c                 |  10 +-
 net/mac80211/driver-ops.c                     |   2 -
 net/mac80211/driver-ops.h                     |  14 -
 net/mac80211/ibss.c                           |  39 +-
 net/mac80211/ieee80211_i.h                    |  30 +-
 net/mac80211/iface.c                          |  11 -
 net/mac80211/link.c                           |  34 +-
 net/mac80211/main.c                           |   7 +-
 net/mac80211/mesh.c                           |  16 +-
 net/mac80211/mlme.c                           | 123 ++----
 net/mac80211/ocb.c                            |   6 +-
 net/mac80211/offchannel.c                     |   2 -
 net/mac80211/tdls.c                           |  26 +-
 net/mac80211/util.c                           |   5 -
 net/wireless/ap.c                             |  24 +-
 net/wireless/chan.c                           |  32 +-
 net/wireless/core.c                           |  24 +-
 net/wireless/core.h                           |  36 --
 net/wireless/ibss.c                           |  76 +---
 net/wireless/mesh.c                           |  23 +-
 net/wireless/mlme.c                           |  21 +-
 net/wireless/nl80211.c                        | 398 +++++-------------
 net/wireless/ocb.c                            |  43 +-
 net/wireless/pmsr.c                           |   4 +-
 net/wireless/reg.c                            |  16 +-
 net/wireless/sme.c                            |  55 +--
 net/wireless/util.c                           |  14 +-
 net/wireless/wext-compat.c                    |  43 +-
 net/wireless/wext-sme.c                       |  59 +--
 35 files changed, 300 insertions(+), 974 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index 0c2b8b1a10d5..1dba55c2d9dc 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -1118,9 +1118,9 @@ void ath6kl_cfg80211_ch_switch_notify(struct ath6kl_vif *vif, int freq,
 				 ath6kl_band_2ghz.ht_cap.ht_supported) ?
 					NL80211_CHAN_HT20 : NL80211_CHAN_NO_HT);
 
-	mutex_lock(&vif->wdev.mtx);
+	wiphy_lock(vif->ar->wiphy);
 	cfg80211_ch_switch_notify(vif->ndev, &chandef, 0, 0);
-	mutex_unlock(&vif->wdev.mtx);
+	wiphy_unlock(vif->ar->wiphy);
 }
 
 static int ath6kl_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
diff --git a/drivers/net/wireless/marvell/mwifiex/11h.c b/drivers/net/wireless/marvell/mwifiex/11h.c
index 2ea03725f188..da211372a481 100644
--- a/drivers/net/wireless/marvell/mwifiex/11h.c
+++ b/drivers/net/wireless/marvell/mwifiex/11h.c
@@ -287,7 +287,7 @@ void mwifiex_dfs_chan_sw_work_queue(struct work_struct *work)
 
 	mwifiex_dbg(priv->adapter, MSG,
 		    "indicating channel switch completion to kernel\n");
-	mutex_lock(&priv->wdev.mtx);
+	wiphy_lock(priv->wdev.wiphy);
 	cfg80211_ch_switch_notify(priv->netdev, &priv->dfs_chandef, 0, 0);
-	mutex_unlock(&priv->wdev.mtx);
+	wiphy_unlock(priv->wdev.wiphy);
 }
diff --git a/drivers/net/wireless/quantenna/qtnfmac/event.c b/drivers/net/wireless/quantenna/qtnfmac/event.c
index 31bc58e96ac0..3b283e93a13e 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/event.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/event.c
@@ -477,9 +477,9 @@ qtnf_event_handle_freq_change(struct qtnf_wmac *mac,
 		if (!vif->netdev)
 			continue;
 
-		mutex_lock(&vif->wdev.mtx);
+		wiphy_lock(priv_to_wiphy(vif->mac));
 		cfg80211_ch_switch_notify(vif->netdev, &chandef, 0, 0);
-		mutex_unlock(&vif->wdev.mtx);
+		wiphy_unlock(priv_to_wiphy(vif->mac));
 	}
 
 	return 0;
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d1964a6d0b35..aa9c26a03f30 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5938,8 +5938,6 @@ void wiphy_delayed_work_flush(struct wiphy *wiphy,
  * @mgmt_registrations: list of registrations for management frames
  * @mgmt_registrations_need_update: mgmt registrations were updated,
  *	need to propagate the update to the driver
- * @mtx: mutex used to lock data in this struct, may be used by drivers
- *	and some API functions require it held
  * @beacon_interval: beacon interval used on this device for transmitting
  *	beacons, 0 when not valid
  * @address: The address for this device, valid only if @netdev is %NULL
@@ -5985,8 +5983,6 @@ struct wireless_dev {
 	struct list_head mgmt_registrations;
 	u8 mgmt_registrations_need_update:1;
 
-	struct mutex mtx;
-
 	bool use_4addr, is_running, registered, registering;
 
 	u8 address[ETH_ALEN] __aligned(sizeof(u16));
@@ -8589,7 +8585,7 @@ bool cfg80211_reg_can_beacon_relax(struct wiphy *wiphy,
  * @link_id: the link ID for MLO, must be 0 for non-MLO
  * @punct_bitmap: the new puncturing bitmap
  *
- * Caller must acquire wdev_lock, therefore must only be called from sleepable
+ * Caller must hold wiphy mutex, therefore must only be called from sleepable
  * driver context!
  */
 void cfg80211_ch_switch_notify(struct net_device *dev,
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 7f3b6f00f8a2..154592ce48e5 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -643,9 +643,7 @@ struct ieee80211_fils_discovery {
  * @pwr_reduction: power constraint of BSS.
  * @eht_support: does this BSS support EHT
  * @eht_puncturing: bitmap to indicate which channels are punctured in this BSS
- * @csa_active: marks whether a channel switch is going on. Internally it is
- *	write-protected by sdata_lock and local->mtx so holding either is fine
- *	for read access.
+ * @csa_active: marks whether a channel switch is going on.
  * @csa_punct_bitmap: new puncturing bitmap for channel switch
  * @mu_mimo_owner: indicates interface owns MU-MIMO capability
  * @chanctx_conf: The channel context this interface is assigned to, or %NULL
@@ -653,9 +651,7 @@ struct ieee80211_fils_discovery {
  *	path needing to access it; even though the netdev carrier will always
  *	be off when it is %NULL there can still be races and packets could be
  *	processed after it switches back to %NULL.
- * @color_change_active: marks whether a color change is ongoing. Internally it is
- *	write-protected by sdata_lock and local->mtx so holding either is fine
- *	for read access.
+ * @color_change_active: marks whether a color change is ongoing.
  * @color_change_color: the bss color that will be used after the change.
  * @ht_ldpc: in AP mode, indicates interface has HT LDPC capability.
  * @vht_ldpc: in AP mode, indicates interface has VHT LDPC capability.
@@ -1974,22 +1970,18 @@ struct ieee80211_vif *wdev_to_ieee80211_vif(struct wireless_dev *wdev);
  */
 struct wireless_dev *ieee80211_vif_to_wdev(struct ieee80211_vif *vif);
 
-/**
- * lockdep_vif_mutex_held - for lockdep checks on link poiners
- * @vif: the interface to check
- */
-static inline bool lockdep_vif_mutex_held(struct ieee80211_vif *vif)
+static inline bool lockdep_vif_wiphy_mutex_held(struct ieee80211_vif *vif)
 {
-	return lockdep_is_held(&ieee80211_vif_to_wdev(vif)->mtx);
+	return lockdep_is_held(&ieee80211_vif_to_wdev(vif)->wiphy->mtx);
 }
 
 #define link_conf_dereference_protected(vif, link_id)		\
 	rcu_dereference_protected((vif)->link_conf[link_id],	\
-				  lockdep_vif_mutex_held(vif))
+				  lockdep_vif_wiphy_mutex_held(vif))
 
 #define link_conf_dereference_check(vif, link_id)		\
 	rcu_dereference_check((vif)->link_conf[link_id],	\
-			      lockdep_vif_mutex_held(vif))
+			      lockdep_vif_wiphy_mutex_held(vif))
 
 /**
  * enum ieee80211_key_flags - key flags
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 0201a3320136..851d6ed68367 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -573,8 +573,7 @@ ieee80211_lookup_key(struct ieee80211_sub_if_data *sdata, int link_id,
 	struct ieee80211_key *key;
 
 	if (link_id >= 0) {
-		link = rcu_dereference_check(sdata->link[link_id],
-					     lockdep_is_held(&sdata->wdev.mtx));
+		link = sdata_dereference(sdata->link[link_id], sdata);
 		if (!link)
 			return NULL;
 	}
@@ -896,12 +895,10 @@ static int ieee80211_set_monitor_channel(struct wiphy *wiphy,
 		sdata = wiphy_dereference(local->hw.wiphy,
 					  local->monitor_sdata);
 		if (sdata) {
-			sdata_lock(sdata);
 			ieee80211_link_release_channel(&sdata->deflink);
 			ret = ieee80211_link_use_channel(&sdata->deflink,
 							 chandef,
 							 IEEE80211_CHANCTX_EXCLUSIVE);
-			sdata_unlock(sdata);
 		}
 	} else {
 		if (local->open_count == local->monitors) {
@@ -1490,7 +1487,7 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_bss_conf *link_conf;
 	u64 changed = 0;
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(wiphy);
 
 	link = sdata_dereference(sdata->link[params->link_id], sdata);
 	if (!link)
@@ -1549,7 +1546,6 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 		sdata_dereference(sdata->link[link_id], sdata);
 	struct ieee80211_bss_conf *link_conf = link->conf;
 
-	sdata_assert_lock(sdata);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	old_beacon = sdata_dereference(link->u.ap.beacon, sdata);
@@ -2163,14 +2159,7 @@ static int ieee80211_change_station(struct wiphy *wiphy,
 		}
 	}
 
-	/* we use sta_info_get_bss() so this might be different */
-	if (sdata != sta->sdata) {
-		mutex_lock_nested(&sta->sdata->wdev.mtx, 1);
-		err = sta_apply_parameters(local, sta, params);
-		mutex_unlock(&sta->sdata->wdev.mtx);
-	} else {
-		err = sta_apply_parameters(local, sta, params);
-	}
+	err = sta_apply_parameters(local, sta, params);
 	if (err)
 		return err;
 
@@ -3132,7 +3121,7 @@ int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
 	struct sta_info *sta;
 	bool tdls_peer_found = false;
 
-	lockdep_assert_held(&sdata->wdev.mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_STATION))
 		return -EINVAL;
@@ -3211,7 +3200,6 @@ static int ieee80211_set_power_mgmt(struct wiphy *wiphy, struct net_device *dev,
 	local->dynamic_ps_forced_timeout = timeout;
 
 	/* no change, but if automatic follow powersave */
-	sdata_lock(sdata);
 	for (link_id = 0; link_id < ARRAY_SIZE(sdata->link); link_id++) {
 		struct ieee80211_link_data *link;
 
@@ -3222,7 +3210,6 @@ static int ieee80211_set_power_mgmt(struct wiphy *wiphy, struct net_device *dev,
 		__ieee80211_request_smps_mgd(sdata, link,
 					     link->u.mgd.req_smps);
 	}
-	sdata_unlock(sdata);
 
 	if (ieee80211_hw_check(&local->hw, SUPPORTS_DYNAMIC_PS))
 		ieee80211_hw_config(local, IEEE80211_CONF_CHANGE_PS);
@@ -3609,7 +3596,6 @@ static int __ieee80211_csa_finalize(struct ieee80211_sub_if_data *sdata)
 	u64 changed = 0;
 	int err;
 
-	sdata_assert_lock(sdata);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/*
@@ -3681,20 +3667,16 @@ void ieee80211_csa_finalize_work(struct wiphy *wiphy, struct wiphy_work *work)
 			     deflink.csa_finalize_work);
 	struct ieee80211_local *local = sdata->local;
 
-	sdata_lock(sdata);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/* AP might have been stopped while waiting for the lock. */
 	if (!sdata->vif.bss_conf.csa_active)
-		goto unlock;
+		return;
 
 	if (!ieee80211_sdata_running(sdata))
-		goto unlock;
+		return;
 
 	ieee80211_csa_finalize(sdata);
-
-unlock:
-	sdata_unlock(sdata);
 }
 
 static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
@@ -3850,7 +3832,6 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 	u64 changed = 0;
 	int err;
 
-	sdata_assert_lock(sdata);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!list_empty(&local->roc_list) || local->scanning)
@@ -4665,7 +4646,6 @@ static int ieee80211_color_change_finalize(struct ieee80211_sub_if_data *sdata)
 	u64 changed = 0;
 	int err;
 
-	sdata_assert_lock(sdata);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	sdata->vif.bss_conf.color_change_active = false;
@@ -4692,20 +4672,16 @@ void ieee80211_color_change_finalize_work(struct wiphy *wiphy,
 			     deflink.color_change_finalize_work);
 	struct ieee80211_local *local = sdata->local;
 
-	sdata_lock(sdata);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/* AP might have been stopped while waiting for the lock. */
 	if (!sdata->vif.bss_conf.color_change_active)
-		goto unlock;
+		return;
 
 	if (!ieee80211_sdata_running(sdata))
-		goto unlock;
+		return;
 
 	ieee80211_color_change_finalize(sdata);
-
-unlock:
-	sdata_unlock(sdata);
 }
 
 void ieee80211_color_collision_detection_work(struct work_struct *work)
@@ -4716,9 +4692,7 @@ void ieee80211_color_collision_detection_work(struct work_struct *work)
 			     color_collision_detect_work);
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 
-	sdata_lock(sdata);
 	cfg80211_obss_color_collision_notify(sdata->dev, link->color_bitmap);
-	sdata_unlock(sdata);
 }
 
 void ieee80211_color_change_finish(struct ieee80211_vif *vif)
@@ -4762,7 +4736,6 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 	u64 changed = 0;
 	int err;
 
-	sdata_assert_lock(sdata);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (sdata->vif.bss_conf.nontransmitted)
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index 706330fadc97..14a40348959a 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -322,7 +322,6 @@ static int ieee80211_set_smps(struct ieee80211_link_data *link,
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
-	int err;
 
 	if (sdata->vif.driver_flags & IEEE80211_VIF_DISABLE_SMPS_OVERRIDE)
 		return -EOPNOTSUPP;
@@ -340,11 +339,7 @@ static int ieee80211_set_smps(struct ieee80211_link_data *link,
 	if (sdata->vif.type != NL80211_IFTYPE_STATION)
 		return -EOPNOTSUPP;
 
-	sdata_lock(sdata);
-	err = __ieee80211_request_smps_mgd(link->sdata, link, smps_mode);
-	sdata_unlock(sdata);
-
-	return err;
+	return __ieee80211_request_smps_mgd(link->sdata, link, smps_mode);
 }
 
 static const char *smps_modes[IEEE80211_SMPS_NUM_MODES] = {
@@ -416,16 +411,13 @@ static ssize_t ieee80211_if_parse_tkip_mic_test(
 	case NL80211_IFTYPE_STATION:
 		fc |= cpu_to_le16(IEEE80211_FCTL_TODS);
 		/* BSSID SA DA */
-		sdata_lock(sdata);
 		if (!sdata->u.mgd.associated) {
-			sdata_unlock(sdata);
 			dev_kfree_skb(skb);
 			return -ENOTCONN;
 		}
 		memcpy(hdr->addr1, sdata->deflink.u.mgd.bssid, ETH_ALEN);
 		memcpy(hdr->addr2, sdata->vif.addr, ETH_ALEN);
 		memcpy(hdr->addr3, addr, ETH_ALEN);
-		sdata_unlock(sdata);
 		break;
 	default:
 		dev_kfree_skb(skb);
diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 9fc110264808..919300750527 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -300,7 +300,6 @@ int drv_assign_vif_chanctx(struct ieee80211_local *local,
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	drv_verify_link_exists(sdata, link_conf);
 	if (!check_sdata_in_driver(sdata))
 		return -EIO;
 
@@ -329,7 +328,6 @@ void drv_unassign_vif_chanctx(struct ieee80211_local *local,
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	drv_verify_link_exists(sdata, link_conf);
 	if (!check_sdata_in_driver(sdata))
 		return;
 
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 2fac7dc2eb9d..554c7aa10cc2 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -996,14 +996,6 @@ static inline void drv_change_chanctx(struct ieee80211_local *local,
 	trace_drv_return_void(local);
 }
 
-static inline void drv_verify_link_exists(struct ieee80211_sub_if_data *sdata,
-					  struct ieee80211_bss_conf *link_conf)
-{
-	/* deflink always exists, so need to check only for other links */
-	if (sdata->deflink.conf != link_conf)
-		sdata_assert_lock(sdata);
-}
-
 int drv_assign_vif_chanctx(struct ieee80211_local *local,
 			   struct ieee80211_sub_if_data *sdata,
 			   struct ieee80211_bss_conf *link_conf,
@@ -1022,9 +1014,6 @@ static inline int drv_start_ap(struct ieee80211_local *local,
 {
 	int ret = 0;
 
-	/* make sure link_conf is protected */
-	drv_verify_link_exists(sdata, link_conf);
-
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
@@ -1045,9 +1034,6 @@ static inline void drv_stop_ap(struct ieee80211_local *local,
 	might_sleep();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	/* make sure link_conf is protected */
-	drv_verify_link_exists(sdata, link_conf);
-
 	if (!check_sdata_in_driver(sdata))
 		return;
 
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index b95098c13153..9907cea6457c 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -235,7 +235,6 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 	bool radar_required;
 	int err;
 
-	sdata_assert_lock(sdata);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/* Reset own TSF to allow time synchronization work. */
@@ -403,7 +402,7 @@ static void ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 	u32 rate_flags;
 	int shift;
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (beacon_int < 10)
 		beacon_int = 10;
@@ -484,7 +483,7 @@ int ieee80211_ibss_csa_beacon(struct ieee80211_sub_if_data *sdata,
 	u16 capability = WLAN_CAPABILITY_IBSS;
 	u64 tsf;
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (ifibss->privacy)
 		capability |= WLAN_CAPABILITY_PRIVACY;
@@ -526,7 +525,7 @@ int ieee80211_ibss_finish_csa(struct ieee80211_sub_if_data *sdata, u64 *changed)
 	struct ieee80211_if_ibss *ifibss = &sdata->u.ibss;
 	struct cfg80211_bss *cbss;
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	/* When not connected/joined, sending CSA doesn't make sense. */
 	if (ifibss->state != IEEE80211_IBSS_MLME_JOINED)
@@ -648,7 +647,7 @@ static int ieee80211_sta_active_ibss(struct ieee80211_sub_if_data *sdata)
 	int active = 0;
 	struct sta_info *sta;
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	rcu_read_lock();
 
@@ -734,16 +733,12 @@ static void ieee80211_csa_connection_drop_work(struct wiphy *wiphy,
 		container_of(work, struct ieee80211_sub_if_data,
 			     u.ibss.csa_connection_drop_work);
 
-	sdata_lock(sdata);
-
 	ieee80211_ibss_disconnect(sdata);
 	synchronize_rcu();
 	skb_queue_purge(&sdata->skb_queue);
 
 	/* trigger a scan to find another IBSS network to join */
 	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
-
-	sdata_unlock(sdata);
 }
 
 static void ieee80211_ibss_csa_mark_radar(struct ieee80211_sub_if_data *sdata)
@@ -775,7 +770,7 @@ ieee80211_ibss_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	ieee80211_conn_flags_t conn_flags;
 	u32 vht_cap_info = 0;
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	conn_flags = IEEE80211_CONN_DISABLE_VHT;
 
@@ -947,7 +942,7 @@ static void ieee80211_rx_mgmt_auth_ibss(struct ieee80211_sub_if_data *sdata,
 {
 	u16 auth_alg, auth_transaction;
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (len < 24 + 6)
 		return;
@@ -1289,7 +1284,7 @@ static void ieee80211_sta_merge_ibss(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_if_ibss *ifibss = &sdata->u.ibss;
 	enum nl80211_bss_scan_width scan_width;
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	mod_timer(&ifibss->timer,
 		  round_jiffies(jiffies + IEEE80211_IBSS_MERGE_INTERVAL));
@@ -1321,7 +1316,7 @@ static void ieee80211_sta_create_ibss(struct ieee80211_sub_if_data *sdata)
 	u16 capability;
 	int i;
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (ifibss->fixed_bssid) {
 		memcpy(bssid, ifibss->bssid, ETH_ALEN);
@@ -1432,7 +1427,7 @@ static void ieee80211_sta_find_ibss(struct ieee80211_sub_if_data *sdata)
 	enum nl80211_bss_scan_width scan_width;
 	int active_ibss;
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	active_ibss = ieee80211_sta_active_ibss(sdata);
 	ibss_dbg(sdata, "sta_find_ibss (active_ibss=%d)\n", active_ibss);
@@ -1526,7 +1521,7 @@ static void ieee80211_rx_mgmt_probe_req(struct ieee80211_sub_if_data *sdata,
 	struct beacon_data *presp;
 	u8 *pos, *end;
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	presp = sdata_dereference(ifibss->presp, sdata);
 
@@ -1622,10 +1617,8 @@ void ieee80211_ibss_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 	mgmt = (struct ieee80211_mgmt *) skb->data;
 	fc = le16_to_cpu(mgmt->frame_control);
 
-	sdata_lock(sdata);
-
 	if (!sdata->u.ibss.ssid_len)
-		goto mgmt_out; /* not ready to merge yet */
+		return; /* not ready to merge yet */
 
 	switch (fc & IEEE80211_FCTL_STYPE) {
 	case IEEE80211_STYPE_PROBE_REQ:
@@ -1665,9 +1658,6 @@ void ieee80211_ibss_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 			break;
 		}
 	}
-
- mgmt_out:
-	sdata_unlock(sdata);
 }
 
 void ieee80211_ibss_work(struct ieee80211_sub_if_data *sdata)
@@ -1675,15 +1665,13 @@ void ieee80211_ibss_work(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_if_ibss *ifibss = &sdata->u.ibss;
 	struct sta_info *sta;
 
-	sdata_lock(sdata);
-
 	/*
 	 * Work could be scheduled after scan or similar
 	 * when we aren't even joined (or trying) with a
 	 * network.
 	 */
 	if (!ifibss->ssid_len)
-		goto out;
+		return;
 
 	spin_lock_bh(&ifibss->incomplete_lock);
 	while (!list_empty(&ifibss->incomplete_stations)) {
@@ -1709,9 +1697,6 @@ void ieee80211_ibss_work(struct ieee80211_sub_if_data *sdata)
 		WARN_ON(1);
 		break;
 	}
-
- out:
-	sdata_unlock(sdata);
 }
 
 static void ieee80211_ibss_timer(struct timer_list *t)
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 2d2a4445714e..b8465d205076 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -991,7 +991,7 @@ struct ieee80211_link_data {
 	struct ieee80211_key __rcu *default_beacon_key;
 
 	struct wiphy_work csa_finalize_work;
-	bool csa_block_tx; /* write-protected by sdata_lock and local->mtx */
+	bool csa_block_tx;
 
 	bool operating_11g_mode;
 
@@ -1135,28 +1135,8 @@ struct ieee80211_sub_if_data *vif_to_sdata(struct ieee80211_vif *p)
 	return container_of(p, struct ieee80211_sub_if_data, vif);
 }
 
-static inline void sdata_lock(struct ieee80211_sub_if_data *sdata)
-	__acquires(&sdata->wdev.mtx)
-{
-	mutex_lock(&sdata->wdev.mtx);
-	__acquire(&sdata->wdev.mtx);
-}
-
-static inline void sdata_unlock(struct ieee80211_sub_if_data *sdata)
-	__releases(&sdata->wdev.mtx)
-{
-	mutex_unlock(&sdata->wdev.mtx);
-	__release(&sdata->wdev.mtx);
-}
-
 #define sdata_dereference(p, sdata) \
-	rcu_dereference_protected(p, lockdep_is_held(&sdata->wdev.mtx))
-
-static inline void
-sdata_assert_lock(struct ieee80211_sub_if_data *sdata)
-{
-	lockdep_assert_held(&sdata->wdev.mtx);
-}
+	wiphy_dereference(sdata->local->hw.wiphy, p)
 
 static inline int
 ieee80211_chanwidth_get_shift(enum nl80211_chan_width width)
@@ -2034,8 +2014,10 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 void ieee80211_link_stop(struct ieee80211_link_data *link);
 int ieee80211_vif_set_links(struct ieee80211_sub_if_data *sdata,
 			    u16 new_links, u16 dormant_links);
-void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata);
-int __ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links);
+static inline void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata)
+{
+	ieee80211_vif_set_links(sdata, 0, 0);
+}
 
 /* tx handling */
 void ieee80211_clear_tx_pending(struct ieee80211_local *local);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index fc407be04ce9..7e3acf670f0f 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -529,7 +529,6 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	del_timer_sync(&local->dynamic_ps_timer);
 	wiphy_work_cancel(local->hw.wiphy, &local->dynamic_ps_enable_work);
 
-	sdata_lock(sdata);
 	WARN(ieee80211_vif_is_mld(&sdata->vif),
 	     "destroying interface with valid links 0x%04x\n",
 	     sdata->vif.valid_links);
@@ -542,7 +541,6 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 					  IEEE80211_QUEUE_STOP_REASON_CSA);
 		sdata->deflink.csa_block_tx = false;
 	}
-	sdata_unlock(sdata);
 
 	wiphy_work_cancel(local->hw.wiphy, &sdata->deflink.csa_finalize_work);
 	wiphy_work_cancel(local->hw.wiphy,
@@ -1133,7 +1131,6 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 	snprintf(sdata->name, IFNAMSIZ, "%s-monitor",
 		 wiphy_name(local->hw.wiphy));
 	sdata->wdev.iftype = NL80211_IFTYPE_MONITOR;
-	mutex_init(&sdata->wdev.mtx);
 	sdata->wdev.wiphy = local->hw.wiphy;
 
 	ieee80211_sdata_init(local, sdata);
@@ -1159,17 +1156,14 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 	rcu_assign_pointer(local->monitor_sdata, sdata);
 	mutex_unlock(&local->iflist_mtx);
 
-	sdata_lock(sdata);
 	ret = ieee80211_link_use_channel(&sdata->deflink, &local->monitor_chandef,
 					 IEEE80211_CHANCTX_EXCLUSIVE);
-	sdata_unlock(sdata);
 	if (ret) {
 		mutex_lock(&local->iflist_mtx);
 		RCU_INIT_POINTER(local->monitor_sdata, NULL);
 		mutex_unlock(&local->iflist_mtx);
 		synchronize_net();
 		drv_remove_interface(local, sdata);
-		mutex_destroy(&sdata->wdev.mtx);
 		kfree(sdata);
 		return ret;
 	}
@@ -1205,13 +1199,10 @@ void ieee80211_del_virtual_monitor(struct ieee80211_local *local)
 
 	synchronize_net();
 
-	sdata_lock(sdata);
 	ieee80211_link_release_channel(&sdata->deflink);
-	sdata_unlock(sdata);
 
 	drv_remove_interface(local, sdata);
 
-	mutex_destroy(&sdata->wdev.mtx);
 	kfree(sdata);
 }
 
@@ -2279,13 +2270,11 @@ void ieee80211_remove_interfaces(struct ieee80211_local *local)
 		 * we can't acquire the wiphy_lock() again there if already
 		 * inside this locked section.
 		 */
-		sdata_lock(sdata);
 		sdata->vif.cfg.arp_addr_cnt = 0;
 		if (sdata->vif.type == NL80211_IFTYPE_STATION &&
 		    sdata->u.mgd.associated)
 			ieee80211_vif_cfg_change_notify(sdata,
 							BSS_CHANGED_ARP_FILTER);
-		sdata_unlock(sdata);
 
 		list_del(&sdata->list);
 		cfg80211_unregister_wdev(&sdata->wdev);
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 80571dcc57f5..2a78374f6f04 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -191,7 +191,7 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_link_data *old_data[IEEE80211_MLD_MAX_NUM_LINKS];
 	bool use_deflink = old_links == 0; /* set for error case */
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	memset(to_free, 0, sizeof(links));
 
@@ -303,23 +303,6 @@ int ieee80211_vif_set_links(struct ieee80211_sub_if_data *sdata,
 	return ret;
 }
 
-void ieee80211_vif_clear_links(struct ieee80211_sub_if_data *sdata)
-{
-	struct link_container *links[IEEE80211_MLD_MAX_NUM_LINKS];
-
-	/*
-	 * The locking here is different because when we free links
-	 * in the station case we need to be able to cancel_work_sync()
-	 * something that also takes the lock.
-	 */
-
-	sdata_lock(sdata);
-	ieee80211_vif_update_links(sdata, links, 0, 0);
-	sdata_unlock(sdata);
-
-	ieee80211_free_links(sdata, links);
-}
-
 static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 				       u16 active_links)
 {
@@ -447,14 +430,13 @@ static int _ieee80211_set_active_links(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
-int __ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links)
+int ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 	struct ieee80211_local *local = sdata->local;
 	u16 old_active;
 	int ret;
 
-	sdata_assert_lock(sdata);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	old_active = sdata->vif.active_links;
@@ -475,18 +457,6 @@ int __ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links)
 
 	return ret;
 }
-
-int ieee80211_set_active_links(struct ieee80211_vif *vif, u16 active_links)
-{
-	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
-	int ret;
-
-	sdata_lock(sdata);
-	ret = __ieee80211_set_active_links(vif, active_links);
-	sdata_unlock(sdata);
-
-	return ret;
-}
 EXPORT_SYMBOL_GPL(ieee80211_set_active_links);
 
 void ieee80211_set_active_links_async(struct ieee80211_vif *vif,
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 411e44239bb9..0ab603850a85 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -365,13 +365,10 @@ static void ieee80211_restart_work(struct work_struct *work)
 			 */
 			wiphy_work_cancel(local->hw.wiphy,
 					  &sdata->u.mgd.csa_connection_drop_work);
-			if (sdata->vif.bss_conf.csa_active) {
-				sdata_lock(sdata);
+			if (sdata->vif.bss_conf.csa_active)
 				ieee80211_sta_connection_lost(sdata,
 							      WLAN_REASON_UNSPECIFIED,
 							      false);
-				sdata_unlock(sdata);
-			}
 		}
 		wiphy_delayed_work_flush(local->hw.wiphy,
 					 &sdata->dec_tailroom_needed_wk);
@@ -473,7 +470,6 @@ static int ieee80211_ifa_changed(struct notifier_block *nb,
 	 */
 	mutex_lock_nested(&local->hw.wiphy->mtx, 1);
 	__acquire(&local->hw.wiphy->mtx);
-	sdata_lock(sdata);
 
 	/* Copy the addresses to the vif config list */
 	ifa = rtnl_dereference(idev->ifa_list);
@@ -490,7 +486,6 @@ static int ieee80211_ifa_changed(struct notifier_block *nb,
 	if (ifmgd->associated)
 		ieee80211_vif_cfg_change_notify(sdata, BSS_CHANGED_ARP_FILTER);
 
-	sdata_unlock(sdata);
 	wiphy_unlock(local->hw.wiphy);
 
 	return NOTIFY_OK;
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index af8c5fc2db14..0d0fbae51b61 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1291,7 +1291,7 @@ ieee80211_mesh_process_chnswitch(struct ieee80211_sub_if_data *sdata,
 	ieee80211_conn_flags_t conn_flags = 0;
 	u32 vht_cap_info = 0;
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	sband = ieee80211_get_sband(sdata);
 	if (!sband)
@@ -1559,7 +1559,7 @@ int ieee80211_mesh_csa_beacon(struct ieee80211_sub_if_data *sdata,
 	struct mesh_csa_settings *tmp_csa_settings;
 	int ret = 0;
 
-	lockdep_assert_held(&sdata->wdev.mtx);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	tmp_csa_settings = kmalloc(sizeof(*tmp_csa_settings),
 				   GFP_ATOMIC);
@@ -1691,11 +1691,11 @@ void ieee80211_mesh_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_mgmt *mgmt;
 	u16 stype;
 
-	sdata_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	/* mesh already went down */
 	if (!sdata->u.mesh.mesh_id_len)
-		goto out;
+		return;
 
 	rx_status = IEEE80211_SKB_RXCB(skb);
 	mgmt = (struct ieee80211_mgmt *) skb->data;
@@ -1714,8 +1714,6 @@ void ieee80211_mesh_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 		ieee80211_mesh_rx_mgmt_action(sdata, mgmt, skb->len, rx_status);
 		break;
 	}
-out:
-	sdata_unlock(sdata);
 }
 
 static void mesh_bss_info_changed(struct ieee80211_sub_if_data *sdata)
@@ -1745,11 +1743,11 @@ void ieee80211_mesh_work(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
 
-	sdata_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	/* mesh already went down */
 	if (!sdata->u.mesh.mesh_id_len)
-		goto out;
+		return;
 
 	if (ifmsh->preq_queue_len &&
 	    time_after(jiffies,
@@ -1767,8 +1765,6 @@ void ieee80211_mesh_work(struct ieee80211_sub_if_data *sdata)
 
 	if (test_and_clear_bit(MESH_WORK_MBSS_CHANGED, &ifmsh->wrkq_flags))
 		mesh_bss_info_changed(sdata);
-out:
-	sdata_unlock(sdata);
 }
 
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 195e7202d51d..6d0a29749e8c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1,4 +1,3 @@
-// SPDX-License-Identifier: GPL-2.0-only
 /*
  * BSS client mode implementation
  * Copyright 2003-2008, Jouni Malinen <j@w1.fi>
@@ -175,7 +174,7 @@ ieee80211_handle_puncturing_bitmap(struct ieee80211_link_data *link,
 static void run_again(struct ieee80211_sub_if_data *sdata,
 		      unsigned long timeout)
 {
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (!timer_pending(&sdata->u.mgd.timer) ||
 	    time_before(timeout, sdata->u.mgd.timer.expires))
@@ -1401,7 +1400,7 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 						      assoc_data->ie,
 						      assoc_data->ie_len);
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	size = local->hw.extra_tx_headroom +
 	       sizeof(*mgmt) + /* bit too much but doesn't matter */
@@ -1689,14 +1688,13 @@ static void ieee80211_chswitch_work(struct wiphy *wiphy,
 	if (!ieee80211_sdata_running(sdata))
 		return;
 
-	sdata_lock(sdata);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!ifmgd->associated)
-		goto out;
+		return;
 
 	if (!link->conf->csa_active)
-		goto out;
+		return;
 
 	/*
 	 * using reservation isn't immediate as it may be deferred until later
@@ -1712,7 +1710,7 @@ static void ieee80211_chswitch_work(struct wiphy *wiphy,
 		 * reservations
 		 */
 		if (link->reserved_ready)
-			goto out;
+			return;
 
 		ret = ieee80211_link_use_reserved_context(link);
 		if (ret) {
@@ -1721,10 +1719,8 @@ static void ieee80211_chswitch_work(struct wiphy *wiphy,
 				   ret);
 			wiphy_work_queue(sdata->local->hw.wiphy,
 					 &ifmgd->csa_connection_drop_work);
-			goto out;
 		}
-
-		goto out;
+		return;
 	}
 
 	if (!cfg80211_chandef_identical(&link->conf->chandef,
@@ -1733,16 +1729,13 @@ static void ieee80211_chswitch_work(struct wiphy *wiphy,
 			   "failed to finalize channel switch, disconnecting\n");
 		wiphy_work_queue(sdata->local->hw.wiphy,
 				 &ifmgd->csa_connection_drop_work);
-		goto out;
+		return;
 	}
 
 	link->u.mgd.csa_waiting_bcn = true;
 
 	ieee80211_sta_reset_beacon_monitor(sdata);
 	ieee80211_sta_reset_conn_monitor(sdata);
-
-out:
-	sdata_unlock(sdata);
 }
 
 static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
@@ -1752,7 +1745,7 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	int ret;
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	WARN_ON(!link->conf->csa_active);
 
@@ -1846,7 +1839,6 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	unsigned long timeout;
 	int res;
 
-	sdata_assert_lock(sdata);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (!cbss)
@@ -2884,7 +2876,6 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 		.subtype = stype,
 	};
 
-	sdata_assert_lock(sdata);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (WARN_ON_ONCE(tx && !frame_buf))
@@ -3223,19 +3214,16 @@ static void ieee80211_mgd_probe_ap(struct ieee80211_sub_if_data *sdata,
 	if (!ieee80211_sdata_running(sdata))
 		return;
 
-	sdata_lock(sdata);
-
 	if (!ifmgd->associated)
-		goto out;
+		return;
 
-	if (sdata->local->tmp_channel || sdata->local->scanning) {
-		goto out;
-	}
+	if (sdata->local->tmp_channel || sdata->local->scanning)
+		return;
 
 	if (sdata->local->suspending) {
 		/* reschedule after resume */
 		ieee80211_reset_ap_probe(sdata);
-		goto out;
+		return;
 	}
 
 	if (beacon) {
@@ -3263,14 +3251,12 @@ static void ieee80211_mgd_probe_ap(struct ieee80211_sub_if_data *sdata,
 	ifmgd->flags |= IEEE80211_STA_CONNECTION_POLL;
 
 	if (already)
-		goto out;
+		return;
 
 	ieee80211_recalc_ps(sdata->local);
 
 	ifmgd->probe_send_count = 0;
 	ieee80211_mgd_probe_ap_send(sdata);
- out:
-	sdata_unlock(sdata);
 }
 
 struct sk_buff *ieee80211_ap_probereq_get(struct ieee80211_hw *hw,
@@ -3283,12 +3269,12 @@ struct sk_buff *ieee80211_ap_probereq_get(struct ieee80211_hw *hw,
 	const struct element *ssid;
 	int ssid_len;
 
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	if (WARN_ON(sdata->vif.type != NL80211_IFTYPE_STATION ||
 		    ieee80211_vif_is_mld(&sdata->vif)))
 		return NULL;
 
-	sdata_assert_lock(sdata);
-
 	if (ifmgd->associated)
 		cbss = sdata->deflink.u.mgd.bss;
 	else if (ifmgd->auth_data)
@@ -3335,7 +3321,7 @@ static void ieee80211_report_disconnect(struct ieee80211_sub_if_data *sdata,
 	drv_event_callback(sdata->local, sdata, &event);
 }
 
-static void ___ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
+static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
@@ -3394,13 +3380,6 @@ static void ___ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 	ifmgd->reconnect = false;
 }
 
-static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
-{
-	sdata_lock(sdata);
-	___ieee80211_disconnect(sdata);
-	sdata_unlock(sdata);
-}
-
 static void ieee80211_beacon_connection_loss_work(struct wiphy *wiphy,
 						  struct wiphy_work *work)
 {
@@ -3482,7 +3461,6 @@ static void ieee80211_destroy_auth_data(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_mgd_auth_data *auth_data = sdata->u.mgd.auth_data;
 
-	sdata_assert_lock(sdata);
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (!assoc) {
@@ -3522,7 +3500,6 @@ static void ieee80211_destroy_assoc_data(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_mgd_assoc_data *assoc_data = sdata->u.mgd.assoc_data;
 
-	sdata_assert_lock(sdata);
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (status != ASSOC_SUCCESS) {
@@ -3638,7 +3615,7 @@ static void ieee80211_rx_mgmt_auth(struct ieee80211_sub_if_data *sdata,
 		.subtype = IEEE80211_STYPE_AUTH,
 	};
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (len < 24 + 6)
 		return;
@@ -3796,7 +3773,7 @@ static void ieee80211_rx_mgmt_deauth(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	u16 reason_code = le16_to_cpu(mgmt->u.deauth.reason_code);
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (len < 24 + 2)
 		return;
@@ -3840,7 +3817,7 @@ static void ieee80211_rx_mgmt_disassoc(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	u16 reason_code;
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (len < 24 + 2)
 		return;
@@ -5253,7 +5230,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	u8 ap_mld_addr[ETH_ALEN] __aligned(2);
 	unsigned int link_id;
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (!assoc_data)
 		return;
@@ -5453,7 +5430,7 @@ static void ieee80211_rx_bss_info(struct ieee80211_link_data *link,
 	struct ieee80211_bss *bss;
 	struct ieee80211_channel *channel;
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	channel = ieee80211_get_channel_khz(local->hw.wiphy,
 					ieee80211_rx_status_to_khz(rx_status));
@@ -5480,7 +5457,7 @@ static void ieee80211_rx_mgmt_probe_resp(struct ieee80211_link_data *link,
 
 	ifmgd = &sdata->u.mgd;
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	/*
 	 * According to Draft P802.11ax D6.0 clause 26.17.2.3.2:
@@ -5691,21 +5668,16 @@ static void ieee80211_ml_reconf_work(struct wiphy *wiphy,
 	u16 new_valid_links, new_active_links, new_dormant_links;
 	int ret;
 
-	sdata_lock(sdata);
-	if (!sdata->u.mgd.removed_links) {
-		sdata_unlock(sdata);
+	if (!sdata->u.mgd.removed_links)
 		return;
-	}
 
 	sdata_info(sdata,
 		   "MLO Reconfiguration: work: valid=0x%x, removed=0x%x\n",
 		   sdata->vif.valid_links, sdata->u.mgd.removed_links);
 
 	new_valid_links = sdata->vif.valid_links & ~sdata->u.mgd.removed_links;
-	if (new_valid_links == sdata->vif.valid_links) {
-		sdata_unlock(sdata);
+	if (new_valid_links == sdata->vif.valid_links)
 		return;
-	}
 
 	if (!new_valid_links ||
 	    !(new_valid_links & ~sdata->vif.dormant_links)) {
@@ -5721,8 +5693,7 @@ static void ieee80211_ml_reconf_work(struct wiphy *wiphy,
 				BIT(ffs(new_valid_links &
 					~sdata->vif.dormant_links) - 1);
 
-		ret = __ieee80211_set_active_links(&sdata->vif,
-						   new_active_links);
+		ret = ieee80211_set_active_links(&sdata->vif, new_active_links);
 		if (ret) {
 			sdata_info(sdata,
 				   "Failed setting active links\n");
@@ -5741,11 +5712,9 @@ static void ieee80211_ml_reconf_work(struct wiphy *wiphy,
 	if (!ret)
 		cfg80211_links_removed(sdata->dev, sdata->u.mgd.removed_links);
 	else
-		___ieee80211_disconnect(sdata);
+		__ieee80211_disconnect(sdata);
 
 	sdata->u.mgd.removed_links = 0;
-
-	sdata_unlock(sdata);
 }
 
 static void ieee80211_ml_reconfiguration(struct ieee80211_sub_if_data *sdata,
@@ -5873,7 +5842,6 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 		.from_ap = true,
 	};
 
-	sdata_assert_lock(sdata);
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/* Process beacon from the current BSS */
@@ -6183,17 +6151,17 @@ void ieee80211_sta_rx_queued_ext(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_hdr *hdr;
 	u16 fc;
 
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	rx_status = (struct ieee80211_rx_status *) skb->cb;
 	hdr = (struct ieee80211_hdr *) skb->data;
 	fc = le16_to_cpu(hdr->frame_control);
 
-	sdata_lock(sdata);
 	switch (fc & IEEE80211_FCTL_STYPE) {
 	case IEEE80211_STYPE_S1G_BEACON:
 		ieee80211_rx_mgmt_beacon(link, hdr, skb->len, rx_status);
 		break;
 	}
-	sdata_unlock(sdata);
 }
 
 void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
@@ -6205,17 +6173,17 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 	u16 fc;
 	int ies_len;
 
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	rx_status = (struct ieee80211_rx_status *) skb->cb;
 	mgmt = (struct ieee80211_mgmt *) skb->data;
 	fc = le16_to_cpu(mgmt->frame_control);
 
-	sdata_lock(sdata);
-
 	if (rx_status->link_valid) {
 		link = sdata_dereference(sdata->link[rx_status->link_id],
 					 sdata);
 		if (!link)
-			goto out;
+			return;
 	}
 
 	switch (fc & IEEE80211_FCTL_STYPE) {
@@ -6298,8 +6266,6 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
 		}
 		break;
 	}
-out:
-	sdata_unlock(sdata);
 }
 
 static void ieee80211_sta_timer(struct timer_list *t)
@@ -6334,7 +6300,7 @@ static int ieee80211_auth(struct ieee80211_sub_if_data *sdata)
 		.subtype = IEEE80211_STYPE_AUTH,
 	};
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (WARN_ON_ONCE(!auth_data))
 		return -EINVAL;
@@ -6403,7 +6369,7 @@ static int ieee80211_do_assoc(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_local *local = sdata->local;
 	int ret;
 
-	sdata_assert_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	assoc_data->tries++;
 	if (assoc_data->tries > IEEE80211_ASSOC_MAX_TRIES) {
@@ -6459,7 +6425,7 @@ void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 
-	sdata_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (ifmgd->status_received) {
 		__le16 fc = ifmgd->status_fc;
@@ -6594,8 +6560,6 @@ void ieee80211_sta_work(struct ieee80211_sub_if_data *sdata)
 				WLAN_REASON_DISASSOC_DUE_TO_INACTIVITY, false);
 		}
 	}
-
-	sdata_unlock(sdata);
 }
 
 static void ieee80211_sta_bcn_mon_timer(struct timer_list *t)
@@ -6682,7 +6646,7 @@ void ieee80211_mgd_quiesce(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
 
-	sdata_lock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	if (ifmgd->auth_data || ifmgd->assoc_data) {
 		const u8 *ap_addr = ifmgd->auth_data ?
@@ -6734,8 +6698,6 @@ void ieee80211_mgd_quiesce(struct ieee80211_sub_if_data *sdata)
 		memcpy(bssid, sdata->vif.cfg.ap_addr, ETH_ALEN);
 		ieee80211_mgd_deauth(sdata, &req);
 	}
-
-	sdata_unlock(sdata);
 }
 #endif
 
@@ -6743,11 +6705,10 @@ void ieee80211_sta_restart(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 
-	sdata_lock(sdata);
-	if (!ifmgd->associated) {
-		sdata_unlock(sdata);
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
+	if (!ifmgd->associated)
 		return;
-	}
 
 	if (sdata->flags & IEEE80211_SDATA_DISCONNECT_RESUME) {
 		sdata->flags &= ~IEEE80211_SDATA_DISCONNECT_RESUME;
@@ -6755,7 +6716,6 @@ void ieee80211_sta_restart(struct ieee80211_sub_if_data *sdata)
 		ieee80211_sta_connection_lost(sdata,
 					      WLAN_REASON_UNSPECIFIED,
 					      true);
-		sdata_unlock(sdata);
 		return;
 	}
 
@@ -6765,11 +6725,8 @@ void ieee80211_sta_restart(struct ieee80211_sub_if_data *sdata)
 		ieee80211_sta_connection_lost(sdata,
 					      WLAN_REASON_UNSPECIFIED,
 					      true);
-		sdata_unlock(sdata);
 		return;
 	}
-
-	sdata_unlock(sdata);
 }
 
 static void ieee80211_request_smps_mgd_work(struct wiphy *wiphy,
@@ -6779,10 +6736,8 @@ static void ieee80211_request_smps_mgd_work(struct wiphy *wiphy,
 		container_of(work, struct ieee80211_link_data,
 			     u.mgd.request_smps_work);
 
-	sdata_lock(link->sdata);
 	__ieee80211_request_smps_mgd(link->sdata, link,
 				     link->u.mgd.driver_smps_mode);
-	sdata_unlock(link->sdata);
 }
 
 /* interface setup */
@@ -7830,7 +7785,6 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
 				  &ifmgd->ml_reconf_work);
 
-	sdata_lock(sdata);
 	if (ifmgd->assoc_data)
 		ieee80211_destroy_assoc_data(sdata, ASSOC_TIMEOUT);
 	if (ifmgd->auth_data)
@@ -7846,7 +7800,6 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 	ifmgd->assoc_req_ies_len = 0;
 	spin_unlock_bh(&ifmgd->teardown_lock);
 	del_timer_sync(&ifmgd->timer);
-	sdata_unlock(sdata);
 }
 
 void ieee80211_cqm_rssi_notify(struct ieee80211_vif *vif,
diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index 7661e96454b2..6e2965ffb809 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -124,11 +124,11 @@ void ieee80211_ocb_work(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_if_ocb *ifocb = &sdata->u.ocb;
 	struct sta_info *sta;
 
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
+
 	if (ifocb->joined != true)
 		return;
 
-	sdata_lock(sdata);
-
 	spin_lock_bh(&ifocb->incomplete_lock);
 	while (!list_empty(&ifocb->incomplete_stations)) {
 		sta = list_first_entry(&ifocb->incomplete_stations,
@@ -144,8 +144,6 @@ void ieee80211_ocb_work(struct ieee80211_sub_if_data *sdata)
 
 	if (test_and_clear_bit(OCB_WORK_HOUSEKEEPING, &ifocb->wrkq_flags))
 		ieee80211_ocb_housekeeping(sdata);
-
-	sdata_unlock(sdata);
 }
 
 static void ieee80211_ocb_housekeeping_timer(struct timer_list *t)
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 8325fbb1645e..be377ed12baa 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -826,13 +826,11 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 		break;
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
-		sdata_lock(sdata);
 		if (!sdata->u.mgd.associated ||
 		    (params->offchan && params->wait &&
 		     local->ops->remain_on_channel &&
 		     memcmp(sdata->vif.cfg.ap_addr, mgmt->bssid, ETH_ALEN)))
 			need_offchan = true;
-		sdata_unlock(sdata);
 		break;
 	case NL80211_IFTYPE_P2P_DEVICE:
 		need_offchan = true;
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 9bcb0c2bba7d..ba14f570cda7 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1465,22 +1465,18 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 	/* protect possible bss_conf changes and avoid concurrency in
 	 * ieee80211_bss_info_change_notify()
 	 */
-	sdata_lock(sdata);
 	tdls_dbg(sdata, "TDLS oper %d peer %pM\n", oper, peer);
 
 	switch (oper) {
 	case NL80211_TDLS_ENABLE_LINK:
 		if (sdata->vif.bss_conf.csa_active) {
 			tdls_dbg(sdata, "TDLS: disallow link during CSA\n");
-			ret = -EBUSY;
-			break;
+			return -EBUSY;
 		}
 
 		sta = sta_info_get(sdata, peer);
-		if (!sta) {
-			ret = -ENOLINK;
-			break;
-		}
+		if (!sta)
+			return -ENOLINK;
 
 		iee80211_tdls_recalc_chanctx(sdata, sta);
 		iee80211_tdls_recalc_ht_protection(sdata, sta);
@@ -1489,7 +1485,6 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 
 		WARN_ON_ONCE(is_zero_ether_addr(sdata->u.mgd.tdls_peer) ||
 			     !ether_addr_equal(sdata->u.mgd.tdls_peer, peer));
-		ret = 0;
 		break;
 	case NL80211_TDLS_DISABLE_LINK:
 		/*
@@ -1511,24 +1506,23 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 		iee80211_tdls_recalc_ht_protection(sdata, NULL);
 
 		iee80211_tdls_recalc_chanctx(sdata, NULL);
+		if (ret)
+			return ret;
 		break;
 	default:
-		ret = -ENOTSUPP;
-		break;
+		return -ENOTSUPP;
 	}
 
-	if (ret == 0 && ether_addr_equal(sdata->u.mgd.tdls_peer, peer)) {
+	if (ether_addr_equal(sdata->u.mgd.tdls_peer, peer)) {
 		wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
 					  &sdata->u.mgd.tdls_peer_del_work);
 		eth_zero_addr(sdata->u.mgd.tdls_peer);
 	}
 
-	if (ret == 0)
-		wiphy_work_queue(sdata->local->hw.wiphy,
-				 &sdata->deflink.u.mgd.request_smps_work);
+	wiphy_work_queue(sdata->local->hw.wiphy,
+			 &sdata->deflink.u.mgd.request_smps_work);
 
-	sdata_unlock(sdata);
-	return ret;
+	return 0;
 }
 
 void ieee80211_tdls_oper_request(struct ieee80211_vif *vif, const u8 *peer,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 7833043b0a4e..4aefb9483aa9 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2664,7 +2664,6 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		if (!ieee80211_sdata_running(sdata))
 			continue;
 
-		sdata_lock(sdata);
 		if (ieee80211_vif_is_mld(&sdata->vif)) {
 			struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS] = {
 				[0] = &sdata->vif.bss_conf,
@@ -2796,7 +2795,6 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		case NL80211_IFTYPE_NAN:
 			res = ieee80211_reconfig_nan(sdata);
 			if (res < 0) {
-				sdata_unlock(sdata);
 				ieee80211_handle_reconfig_failure(local);
 				return res;
 			}
@@ -2814,7 +2812,6 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			WARN_ON(1);
 			break;
 		}
-		sdata_unlock(sdata);
 
 		if (active_links)
 			ieee80211_set_active_links(&sdata->vif, active_links);
@@ -2844,7 +2841,6 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		if (!ieee80211_sdata_running(sdata))
 			continue;
 
-		sdata_lock(sdata);
 		switch (sdata->vif.type) {
 		case NL80211_IFTYPE_AP_VLAN:
 		case NL80211_IFTYPE_AP:
@@ -2853,7 +2849,6 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		default:
 			break;
 		}
-		sdata_unlock(sdata);
 	}
 
 	/* add back keys */
diff --git a/net/wireless/ap.c b/net/wireless/ap.c
index 0962770303b2..9a9a870806f5 100644
--- a/net/wireless/ap.c
+++ b/net/wireless/ap.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Parts of this file are
- * Copyright (C) 2022 Intel Corporation
+ * Copyright (C) 2022-2023 Intel Corporation
  */
 #include <linux/ieee80211.h>
 #include <linux/export.h>
@@ -18,7 +18,7 @@ static int ___cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	int err;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	if (!rdev->ops->stop_ap)
 		return -EOPNOTSUPP;
@@ -52,9 +52,9 @@ static int ___cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
 	return err;
 }
 
-int __cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
-		       struct net_device *dev, int link_id,
-		       bool notify)
+int cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
+		     struct net_device *dev, int link_id,
+		     bool notify)
 {
 	unsigned int link;
 	int ret = 0;
@@ -72,17 +72,3 @@ int __cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
 
 	return ret;
 }
-
-int cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
-		     struct net_device *dev, int link_id,
-		     bool notify)
-{
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	int err;
-
-	wdev_lock(wdev);
-	err = __cfg80211_stop_ap(rdev, dev, link_id, notify);
-	wdev_unlock(wdev);
-
-	return err;
-}
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index b2469e2c1e70..2af3aaee7493 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -713,7 +713,7 @@ bool cfg80211_beaconing_iface_active(struct wireless_dev *wdev)
 {
 	unsigned int link;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_AP:
@@ -782,18 +782,14 @@ static bool cfg80211_is_wiphy_oper_chan(struct wiphy *wiphy,
 {
 	struct wireless_dev *wdev;
 
+	lockdep_assert_wiphy(wiphy);
+
 	list_for_each_entry(wdev, &wiphy->wdev_list, list) {
-		wdev_lock(wdev);
-		if (!cfg80211_beaconing_iface_active(wdev)) {
-			wdev_unlock(wdev);
+		if (!cfg80211_beaconing_iface_active(wdev))
 			continue;
-		}
 
-		if (cfg80211_wdev_on_sub_chan(wdev, chan, false)) {
-			wdev_unlock(wdev);
+		if (cfg80211_wdev_on_sub_chan(wdev, chan, false))
 			return true;
-		}
-		wdev_unlock(wdev);
 	}
 
 	return false;
@@ -1325,10 +1321,7 @@ static bool cfg80211_ir_permissive_chan(struct wiphy *wiphy,
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 		bool ret;
 
-		wdev_lock(wdev);
 		ret = cfg80211_ir_permissive_check_wdev(iftype, wdev, chan);
-		wdev_unlock(wdev);
-
 		if (ret)
 			return ret;
 	}
@@ -1437,17 +1430,10 @@ EXPORT_SYMBOL(cfg80211_any_usable_channels);
 struct cfg80211_chan_def *wdev_chandef(struct wireless_dev *wdev,
 				       unsigned int link_id)
 {
-	/*
-	 * We need to sort out the locking here - in some cases
-	 * where we get here we really just don't care (yet)
-	 * about the valid links, but in others we do. But we
-	 * get here with various driver cases, so we cannot
-	 * easily require the wdev mutex.
-	 */
-	if (link_id || wdev->valid_links & BIT(0)) {
-		ASSERT_WDEV_LOCK(wdev);
-		WARN_ON(!(wdev->valid_links & BIT(link_id)));
-	}
+	lockdep_assert_wiphy(wdev->wiphy);
+
+	WARN_ON(wdev->valid_links && !(wdev->valid_links & BIT(link_id)));
+	WARN_ON(!wdev->valid_links && link_id > 0);
 
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_MESH_POINT:
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 88042a647aaa..c419177278da 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1278,14 +1278,13 @@ void cfg80211_update_iface_num(struct cfg80211_registered_device *rdev,
 		rdev->num_running_monitor_ifaces += num;
 }
 
-void __cfg80211_leave(struct cfg80211_registered_device *rdev,
-		      struct wireless_dev *wdev)
+void cfg80211_leave(struct cfg80211_registered_device *rdev,
+		    struct wireless_dev *wdev)
 {
 	struct net_device *dev = wdev->netdev;
 	struct cfg80211_sched_scan_request *pos, *tmp;
 
 	lockdep_assert_held(&rdev->wiphy.mtx);
-	ASSERT_WDEV_LOCK(wdev);
 
 	cfg80211_pmsr_wdev_down(wdev);
 
@@ -1293,7 +1292,7 @@ void __cfg80211_leave(struct cfg80211_registered_device *rdev,
 
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_ADHOC:
-		__cfg80211_leave_ibss(rdev, dev, true);
+		cfg80211_leave_ibss(rdev, dev, true);
 		break;
 	case NL80211_IFTYPE_P2P_CLIENT:
 	case NL80211_IFTYPE_STATION:
@@ -1313,14 +1312,14 @@ void __cfg80211_leave(struct cfg80211_registered_device *rdev,
 				    WLAN_REASON_DEAUTH_LEAVING, true);
 		break;
 	case NL80211_IFTYPE_MESH_POINT:
-		__cfg80211_leave_mesh(rdev, dev);
+		cfg80211_leave_mesh(rdev, dev);
 		break;
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_P2P_GO:
-		__cfg80211_stop_ap(rdev, dev, -1, true);
+		cfg80211_stop_ap(rdev, dev, -1, true);
 		break;
 	case NL80211_IFTYPE_OCB:
-		__cfg80211_leave_ocb(rdev, dev);
+		cfg80211_leave_ocb(rdev, dev);
 		break;
 	case NL80211_IFTYPE_P2P_DEVICE:
 	case NL80211_IFTYPE_NAN:
@@ -1338,14 +1337,6 @@ void __cfg80211_leave(struct cfg80211_registered_device *rdev,
 	}
 }
 
-void cfg80211_leave(struct cfg80211_registered_device *rdev,
-		    struct wireless_dev *wdev)
-{
-	wdev_lock(wdev);
-	__cfg80211_leave(rdev, wdev);
-	wdev_unlock(wdev);
-}
-
 void cfg80211_stop_iface(struct wiphy *wiphy, struct wireless_dev *wdev,
 			 gfp_t gfp)
 {
@@ -1370,7 +1361,6 @@ EXPORT_SYMBOL(cfg80211_stop_iface);
 
 void cfg80211_init_wdev(struct wireless_dev *wdev)
 {
-	mutex_init(&wdev->mtx);
 	INIT_LIST_HEAD(&wdev->event_list);
 	spin_lock_init(&wdev->event_lock);
 	INIT_LIST_HEAD(&wdev->mgmt_registrations);
@@ -1533,7 +1523,6 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 	case NETDEV_UP:
 		wiphy_lock(&rdev->wiphy);
 		cfg80211_update_iface_num(rdev, wdev->iftype, 1);
-		wdev_lock(wdev);
 		switch (wdev->iftype) {
 #ifdef CONFIG_CFG80211_WEXT
 		case NL80211_IFTYPE_ADHOC:
@@ -1563,7 +1552,6 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		default:
 			break;
 		}
-		wdev_unlock(wdev);
 		rdev->opencount++;
 
 		/*
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 5dc76ea3b84e..98f41d9d2ba7 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -235,28 +235,6 @@ void cfg80211_init_wdev(struct wireless_dev *wdev);
 void cfg80211_register_wdev(struct cfg80211_registered_device *rdev,
 			    struct wireless_dev *wdev);
 
-static inline void wdev_lock(struct wireless_dev *wdev)
-	__acquires(wdev)
-{
-	lockdep_assert_held(&wdev->wiphy->mtx);
-	mutex_lock(&wdev->mtx);
-	__acquire(wdev->mtx);
-}
-
-static inline void wdev_unlock(struct wireless_dev *wdev)
-	__releases(wdev)
-{
-	lockdep_assert_held(&wdev->wiphy->mtx);
-	__release(wdev->mtx);
-	mutex_unlock(&wdev->mtx);
-}
-
-static inline void ASSERT_WDEV_LOCK(struct wireless_dev *wdev)
-{
-	lockdep_assert_held(&wdev->wiphy->mtx);
-	lockdep_assert_held(&wdev->mtx);
-}
-
 static inline bool cfg80211_has_monitors_only(struct cfg80211_registered_device *rdev)
 {
 	lockdep_assert_held(&rdev->wiphy.mtx);
@@ -340,8 +318,6 @@ int __cfg80211_join_ibss(struct cfg80211_registered_device *rdev,
 			 struct cfg80211_ibss_params *params,
 			 struct cfg80211_cached_keys *connkeys);
 void cfg80211_clear_ibss(struct net_device *dev, bool nowext);
-int __cfg80211_leave_ibss(struct cfg80211_registered_device *rdev,
-			  struct net_device *dev, bool nowext);
 int cfg80211_leave_ibss(struct cfg80211_registered_device *rdev,
 			struct net_device *dev, bool nowext);
 void __cfg80211_ibss_joined(struct net_device *dev, const u8 *bssid,
@@ -356,8 +332,6 @@ int __cfg80211_join_mesh(struct cfg80211_registered_device *rdev,
 			 struct net_device *dev,
 			 struct mesh_setup *setup,
 			 const struct mesh_config *conf);
-int __cfg80211_leave_mesh(struct cfg80211_registered_device *rdev,
-			  struct net_device *dev);
 int cfg80211_leave_mesh(struct cfg80211_registered_device *rdev,
 			struct net_device *dev);
 int cfg80211_set_mesh_channel(struct cfg80211_registered_device *rdev,
@@ -365,21 +339,13 @@ int cfg80211_set_mesh_channel(struct cfg80211_registered_device *rdev,
 			      struct cfg80211_chan_def *chandef);
 
 /* OCB */
-int __cfg80211_join_ocb(struct cfg80211_registered_device *rdev,
-			struct net_device *dev,
-			struct ocb_setup *setup);
 int cfg80211_join_ocb(struct cfg80211_registered_device *rdev,
 		      struct net_device *dev,
 		      struct ocb_setup *setup);
-int __cfg80211_leave_ocb(struct cfg80211_registered_device *rdev,
-			 struct net_device *dev);
 int cfg80211_leave_ocb(struct cfg80211_registered_device *rdev,
 		       struct net_device *dev);
 
 /* AP */
-int __cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
-		       struct net_device *dev, int link,
-		       bool notify);
 int cfg80211_stop_ap(struct cfg80211_registered_device *rdev,
 		     struct net_device *dev, int link,
 		     bool notify);
@@ -557,8 +523,6 @@ int cfg80211_validate_beacon_int(struct cfg80211_registered_device *rdev,
 void cfg80211_update_iface_num(struct cfg80211_registered_device *rdev,
 			       enum nl80211_iftype iftype, int num);
 
-void __cfg80211_leave(struct cfg80211_registered_device *rdev,
-		      struct wireless_dev *wdev);
 void cfg80211_leave(struct cfg80211_registered_device *rdev,
 		    struct wireless_dev *wdev);
 
diff --git a/net/wireless/ibss.c b/net/wireless/ibss.c
index e6fdb0b8187d..9f02ee5f08be 100644
--- a/net/wireless/ibss.c
+++ b/net/wireless/ibss.c
@@ -3,7 +3,7 @@
  * Some IBSS support code for cfg80211.
  *
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2020-2022 Intel Corporation
+ * Copyright (C) 2020-2023 Intel Corporation
  */
 
 #include <linux/etherdevice.h>
@@ -93,7 +93,6 @@ int __cfg80211_join_ibss(struct cfg80211_registered_device *rdev,
 	int err;
 
 	lockdep_assert_held(&rdev->wiphy.mtx);
-	ASSERT_WDEV_LOCK(wdev);
 
 	if (wdev->u.ibss.ssid_len)
 		return -EALREADY;
@@ -151,13 +150,13 @@ int __cfg80211_join_ibss(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
-static void __cfg80211_clear_ibss(struct net_device *dev, bool nowext)
+void cfg80211_clear_ibss(struct net_device *dev, bool nowext)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 	int i;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	kfree_sensitive(wdev->connect_keys);
 	wdev->connect_keys = NULL;
@@ -187,22 +186,13 @@ static void __cfg80211_clear_ibss(struct net_device *dev, bool nowext)
 	cfg80211_sched_dfs_chan_update(rdev);
 }
 
-void cfg80211_clear_ibss(struct net_device *dev, bool nowext)
-{
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
-
-	wdev_lock(wdev);
-	__cfg80211_clear_ibss(dev, nowext);
-	wdev_unlock(wdev);
-}
-
-int __cfg80211_leave_ibss(struct cfg80211_registered_device *rdev,
-			  struct net_device *dev, bool nowext)
+int cfg80211_leave_ibss(struct cfg80211_registered_device *rdev,
+			struct net_device *dev, bool nowext)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	int err;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	if (!wdev->u.ibss.ssid_len)
 		return -ENOLINK;
@@ -213,24 +203,11 @@ int __cfg80211_leave_ibss(struct cfg80211_registered_device *rdev,
 		return err;
 
 	wdev->conn_owner_nlportid = 0;
-	__cfg80211_clear_ibss(dev, nowext);
+	cfg80211_clear_ibss(dev, nowext);
 
 	return 0;
 }
 
-int cfg80211_leave_ibss(struct cfg80211_registered_device *rdev,
-			struct net_device *dev, bool nowext)
-{
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	int err;
-
-	wdev_lock(wdev);
-	err = __cfg80211_leave_ibss(rdev, dev, nowext);
-	wdev_unlock(wdev);
-
-	return err;
-}
-
 #ifdef CONFIG_CFG80211_WEXT
 int cfg80211_ibss_wext_join(struct cfg80211_registered_device *rdev,
 			    struct wireless_dev *wdev)
@@ -239,7 +216,7 @@ int cfg80211_ibss_wext_join(struct cfg80211_registered_device *rdev,
 	enum nl80211_band band;
 	int i, err;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	if (!wdev->wext.ibss.beacon_interval)
 		wdev->wext.ibss.beacon_interval = 100;
@@ -336,11 +313,9 @@ int cfg80211_ibss_wext_siwfreq(struct net_device *dev,
 	if (wdev->wext.ibss.chandef.chan == chan)
 		return 0;
 
-	wdev_lock(wdev);
 	err = 0;
 	if (wdev->u.ibss.ssid_len)
-		err = __cfg80211_leave_ibss(rdev, dev, true);
-	wdev_unlock(wdev);
+		err = cfg80211_leave_ibss(rdev, dev, true);
 
 	if (err)
 		return err;
@@ -354,11 +329,7 @@ int cfg80211_ibss_wext_siwfreq(struct net_device *dev,
 		wdev->wext.ibss.channel_fixed = false;
 	}
 
-	wdev_lock(wdev);
-	err = cfg80211_ibss_wext_join(rdev, wdev);
-	wdev_unlock(wdev);
-
-	return err;
+	return cfg80211_ibss_wext_join(rdev, wdev);
 }
 
 int cfg80211_ibss_wext_giwfreq(struct net_device *dev,
@@ -372,12 +343,10 @@ int cfg80211_ibss_wext_giwfreq(struct net_device *dev,
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_ADHOC))
 		return -EINVAL;
 
-	wdev_lock(wdev);
 	if (wdev->u.ibss.current_bss)
 		chan = wdev->u.ibss.current_bss->pub.channel;
 	else if (wdev->wext.ibss.chandef.chan)
 		chan = wdev->wext.ibss.chandef.chan;
-	wdev_unlock(wdev);
 
 	if (chan) {
 		freq->m = chan->center_freq;
@@ -405,11 +374,9 @@ int cfg80211_ibss_wext_siwessid(struct net_device *dev,
 	if (!rdev->ops->join_ibss)
 		return -EOPNOTSUPP;
 
-	wdev_lock(wdev);
 	err = 0;
 	if (wdev->u.ibss.ssid_len)
-		err = __cfg80211_leave_ibss(rdev, dev, true);
-	wdev_unlock(wdev);
+		err = cfg80211_leave_ibss(rdev, dev, true);
 
 	if (err)
 		return err;
@@ -422,11 +389,7 @@ int cfg80211_ibss_wext_siwessid(struct net_device *dev,
 	wdev->wext.ibss.ssid = wdev->u.ibss.ssid;
 	wdev->wext.ibss.ssid_len = len;
 
-	wdev_lock(wdev);
-	err = cfg80211_ibss_wext_join(rdev, wdev);
-	wdev_unlock(wdev);
-
-	return err;
+	return cfg80211_ibss_wext_join(rdev, wdev);
 }
 
 int cfg80211_ibss_wext_giwessid(struct net_device *dev,
@@ -441,7 +404,6 @@ int cfg80211_ibss_wext_giwessid(struct net_device *dev,
 
 	data->flags = 0;
 
-	wdev_lock(wdev);
 	if (wdev->u.ibss.ssid_len) {
 		data->flags = 1;
 		data->length = wdev->u.ibss.ssid_len;
@@ -451,7 +413,6 @@ int cfg80211_ibss_wext_giwessid(struct net_device *dev,
 		data->length = wdev->wext.ibss.ssid_len;
 		memcpy(ssid, wdev->wext.ibss.ssid, data->length);
 	}
-	wdev_unlock(wdev);
 
 	return 0;
 }
@@ -491,11 +452,9 @@ int cfg80211_ibss_wext_siwap(struct net_device *dev,
 	    ether_addr_equal(bssid, wdev->wext.ibss.bssid))
 		return 0;
 
-	wdev_lock(wdev);
 	err = 0;
 	if (wdev->u.ibss.ssid_len)
-		err = __cfg80211_leave_ibss(rdev, dev, true);
-	wdev_unlock(wdev);
+		err = cfg80211_leave_ibss(rdev, dev, true);
 
 	if (err)
 		return err;
@@ -506,11 +465,7 @@ int cfg80211_ibss_wext_siwap(struct net_device *dev,
 	} else
 		wdev->wext.ibss.bssid = NULL;
 
-	wdev_lock(wdev);
-	err = cfg80211_ibss_wext_join(rdev, wdev);
-	wdev_unlock(wdev);
-
-	return err;
+	return cfg80211_ibss_wext_join(rdev, wdev);
 }
 
 int cfg80211_ibss_wext_giwap(struct net_device *dev,
@@ -525,7 +480,6 @@ int cfg80211_ibss_wext_giwap(struct net_device *dev,
 
 	ap_addr->sa_family = ARPHRD_ETHER;
 
-	wdev_lock(wdev);
 	if (wdev->u.ibss.current_bss)
 		memcpy(ap_addr->sa_data, wdev->u.ibss.current_bss->pub.bssid,
 		       ETH_ALEN);
@@ -534,8 +488,6 @@ int cfg80211_ibss_wext_giwap(struct net_device *dev,
 	else
 		eth_zero_addr(ap_addr->sa_data);
 
-	wdev_unlock(wdev);
-
 	return 0;
 }
 #endif
diff --git a/net/wireless/mesh.c b/net/wireless/mesh.c
index 59a3c5c092b1..dc75abdb8f2e 100644
--- a/net/wireless/mesh.c
+++ b/net/wireless/mesh.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Portions
- * Copyright (C) 2022 Intel Corporation
+ * Copyright (C) 2022-2023 Intel Corporation
  */
 #include <linux/ieee80211.h>
 #include <linux/export.h>
@@ -109,7 +109,7 @@ int __cfg80211_join_mesh(struct cfg80211_registered_device *rdev,
 
 	BUILD_BUG_ON(IEEE80211_MAX_SSID_LEN != IEEE80211_MAX_MESH_ID_LEN);
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_MESH_POINT)
 		return -EOPNOTSUPP;
@@ -257,13 +257,13 @@ int cfg80211_set_mesh_channel(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
-int __cfg80211_leave_mesh(struct cfg80211_registered_device *rdev,
-			  struct net_device *dev)
+int cfg80211_leave_mesh(struct cfg80211_registered_device *rdev,
+			struct net_device *dev)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	int err;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_MESH_POINT)
 		return -EOPNOTSUPP;
@@ -287,16 +287,3 @@ int __cfg80211_leave_mesh(struct cfg80211_registered_device *rdev,
 
 	return err;
 }
-
-int cfg80211_leave_mesh(struct cfg80211_registered_device *rdev,
-			struct net_device *dev)
-{
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	int err;
-
-	wdev_lock(wdev);
-	err = __cfg80211_leave_mesh(rdev, dev);
-	wdev_unlock(wdev);
-
-	return err;
-}
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 775cac4d6100..cc7ae9ea84ea 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -4,7 +4,7 @@
  *
  * Copyright (c) 2009, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2015		Intel Deutschland GmbH
- * Copyright (C) 2019-2020, 2022 Intel Corporation
+ * Copyright (C) 2019-2020, 2022-2023 Intel Corporation
  */
 
 #include <linux/kernel.h>
@@ -149,7 +149,7 @@ void cfg80211_rx_mlme_mgmt(struct net_device *dev, const u8 *buf, size_t len)
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct ieee80211_mgmt *mgmt = (void *)buf;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	trace_cfg80211_rx_mlme_mgmt(dev, buf, len);
 
@@ -214,7 +214,7 @@ void cfg80211_tx_mlme_mgmt(struct net_device *dev, const u8 *buf, size_t len,
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct ieee80211_mgmt *mgmt = (void *)buf;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	trace_cfg80211_tx_mlme_mgmt(dev, buf, len, reconnect);
 
@@ -262,7 +262,7 @@ int cfg80211_mlme_auth(struct cfg80211_registered_device *rdev,
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	if (!req->bss)
 		return -ENOENT;
@@ -331,7 +331,7 @@ int cfg80211_mlme_assoc(struct cfg80211_registered_device *rdev,
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	int err, i, j;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	for (i = 1; i < ARRAY_SIZE(req->links); i++) {
 		if (!req->links[i].bss)
@@ -393,7 +393,7 @@ int cfg80211_mlme_deauth(struct cfg80211_registered_device *rdev,
 		.local_state_change = local_state_change,
 	};
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	if (local_state_change &&
 	    (!wdev->connected ||
@@ -423,7 +423,7 @@ int cfg80211_mlme_disassoc(struct cfg80211_registered_device *rdev,
 	};
 	int err;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	if (!wdev->connected)
 		return -ENOTCONN;
@@ -446,7 +446,7 @@ void cfg80211_mlme_down(struct cfg80211_registered_device *rdev,
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	u8 bssid[ETH_ALEN];
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	if (!rdev->ops->deauth)
 		return;
@@ -726,6 +726,8 @@ int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 	const struct ieee80211_mgmt *mgmt;
 	u16 stype;
 
+	lockdep_assert_wiphy(&rdev->wiphy);
+
 	if (!wdev->wiphy->mgmt_stypes)
 		return -EOPNOTSUPP;
 
@@ -748,8 +750,6 @@ int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 	    mgmt->u.action.category != WLAN_CATEGORY_PUBLIC) {
 		int err = 0;
 
-		wdev_lock(wdev);
-
 		switch (wdev->iftype) {
 		case NL80211_IFTYPE_ADHOC:
 			/*
@@ -814,7 +814,6 @@ int cfg80211_mlme_mgmt_tx(struct cfg80211_registered_device *rdev,
 			err = -EOPNOTSUPP;
 			break;
 		}
-		wdev_unlock(wdev);
 
 		if (err)
 			return err;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f4298104a2f4..71a0a6e34bdb 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1544,7 +1544,7 @@ nl80211_parse_connkeys(struct cfg80211_registered_device *rdev,
 
 static int nl80211_key_allowed(struct wireless_dev *wdev)
 {
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_AP:
@@ -3423,13 +3423,8 @@ static int nl80211_set_channel(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	int link_id = nl80211_link_id_or_invalid(info->attrs);
 	struct net_device *netdev = info->user_ptr[1];
-	int ret;
 
-	wdev_lock(netdev->ieee80211_ptr);
-	ret = __nl80211_set_channel(rdev, netdev, info, link_id);
-	wdev_unlock(netdev->ieee80211_ptr);
-
-	return ret;
+	return __nl80211_set_channel(rdev, netdev, info, link_id);
 }
 
 static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
@@ -3536,7 +3531,6 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 			txq_params.link_id =
 				nl80211_link_id_or_invalid(info->attrs);
 
-			wdev_lock(netdev->ieee80211_ptr);
 			if (txq_params.link_id >= 0 &&
 			    !(netdev->ieee80211_ptr->valid_links &
 			      BIT(txq_params.link_id)))
@@ -3547,7 +3541,6 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 			else
 				result = rdev_set_txq_params(rdev, netdev,
 							     &txq_params);
-			wdev_unlock(netdev->ieee80211_ptr);
 			if (result)
 				goto out;
 		}
@@ -3557,12 +3550,10 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 		int link_id = nl80211_link_id_or_invalid(info->attrs);
 
 		if (wdev) {
-			wdev_lock(wdev);
 			result = __nl80211_set_channel(
 				rdev,
 				nl80211_can_set_dev_channel(wdev) ? netdev : NULL,
 				info, link_id);
-			wdev_unlock(wdev);
 		} else {
 			result = __nl80211_set_channel(rdev, netdev, info, link_id);
 		}
@@ -3870,33 +3861,31 @@ static int nl80211_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flag
 			goto nla_put_failure;
 	}
 
-	wdev_lock(wdev);
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_P2P_GO:
 		if (wdev->u.ap.ssid_len &&
 		    nla_put(msg, NL80211_ATTR_SSID, wdev->u.ap.ssid_len,
 			    wdev->u.ap.ssid))
-			goto nla_put_failure_locked;
+			goto nla_put_failure;
 		break;
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
 		if (wdev->u.client.ssid_len &&
 		    nla_put(msg, NL80211_ATTR_SSID, wdev->u.client.ssid_len,
 			    wdev->u.client.ssid))
-			goto nla_put_failure_locked;
+			goto nla_put_failure;
 		break;
 	case NL80211_IFTYPE_ADHOC:
 		if (wdev->u.ibss.ssid_len &&
 		    nla_put(msg, NL80211_ATTR_SSID, wdev->u.ibss.ssid_len,
 			    wdev->u.ibss.ssid))
-			goto nla_put_failure_locked;
+			goto nla_put_failure;
 		break;
 	default:
 		/* nothing */
 		break;
 	}
-	wdev_unlock(wdev);
 
 	if (rdev->ops->get_txq_stats) {
 		struct cfg80211_txq_stats txqstats = {};
@@ -3943,8 +3932,6 @@ static int nl80211_send_iface(struct sk_buff *msg, u32 portid, u32 seq, int flag
 	genlmsg_end(msg, hdr);
 	return 0;
 
- nla_put_failure_locked:
-	wdev_unlock(wdev);
  nla_put_failure:
 	genlmsg_cancel(msg, hdr);
 	return -EMSGSIZE;
@@ -4191,7 +4178,6 @@ static int nl80211_set_interface(struct sk_buff *skb, struct genl_info *info)
 		if (netif_running(dev))
 			return -EBUSY;
 
-		wdev_lock(wdev);
 		BUILD_BUG_ON(IEEE80211_MAX_SSID_LEN !=
 			     IEEE80211_MAX_MESH_ID_LEN);
 		wdev->u.mesh.id_up_len =
@@ -4199,7 +4185,6 @@ static int nl80211_set_interface(struct sk_buff *skb, struct genl_info *info)
 		memcpy(wdev->u.mesh.id,
 		       nla_data(info->attrs[NL80211_ATTR_MESH_ID]),
 		       wdev->u.mesh.id_up_len);
-		wdev_unlock(wdev);
 	}
 
 	if (info->attrs[NL80211_ATTR_4ADDR]) {
@@ -4300,7 +4285,6 @@ static int _nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 	case NL80211_IFTYPE_MESH_POINT:
 		if (!info->attrs[NL80211_ATTR_MESH_ID])
 			break;
-		wdev_lock(wdev);
 		BUILD_BUG_ON(IEEE80211_MAX_SSID_LEN !=
 			     IEEE80211_MAX_MESH_ID_LEN);
 		wdev->u.mesh.id_up_len =
@@ -4308,7 +4292,6 @@ static int _nl80211_new_interface(struct sk_buff *skb, struct genl_info *info)
 		memcpy(wdev->u.mesh.id,
 		       nla_data(info->attrs[NL80211_ATTR_MESH_ID]),
 		       wdev->u.mesh.id_up_len);
-		wdev_unlock(wdev);
 		break;
 	case NL80211_IFTYPE_NAN:
 	case NL80211_IFTYPE_P2P_DEVICE:
@@ -4599,79 +4582,67 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 	    !(key.p.mode == NL80211_KEY_SET_TX))
 		return -EINVAL;
 
-	wdev_lock(wdev);
-
 	if (key.def) {
-		if (!rdev->ops->set_default_key) {
-			err = -EOPNOTSUPP;
-			goto out;
-		}
+		if (!rdev->ops->set_default_key)
+			return -EOPNOTSUPP;
 
 		err = nl80211_key_allowed(wdev);
 		if (err)
-			goto out;
+			return err;
 
 		err = nl80211_validate_key_link_id(info, wdev, link_id, false);
 		if (err)
-			goto out;
+			return err;
 
 		err = rdev_set_default_key(rdev, dev, link_id, key.idx,
 					   key.def_uni, key.def_multi);
 
 		if (err)
-			goto out;
+			return err;
 
 #ifdef CONFIG_CFG80211_WEXT
 		wdev->wext.default_key = key.idx;
 #endif
+		return 0;
 	} else if (key.defmgmt) {
-		if (key.def_uni || !key.def_multi) {
-			err = -EINVAL;
-			goto out;
-		}
+		if (key.def_uni || !key.def_multi)
+			return -EINVAL;
 
-		if (!rdev->ops->set_default_mgmt_key) {
-			err = -EOPNOTSUPP;
-			goto out;
-		}
+		if (!rdev->ops->set_default_mgmt_key)
+			return -EOPNOTSUPP;
 
 		err = nl80211_key_allowed(wdev);
 		if (err)
-			goto out;
+			return err;
 
 		err = nl80211_validate_key_link_id(info, wdev, link_id, false);
 		if (err)
-			goto out;
+			return err;
 
 		err = rdev_set_default_mgmt_key(rdev, dev, link_id, key.idx);
 		if (err)
-			goto out;
+			return err;
 
 #ifdef CONFIG_CFG80211_WEXT
 		wdev->wext.default_mgmt_key = key.idx;
 #endif
+		return 0;
 	} else if (key.defbeacon) {
-		if (key.def_uni || !key.def_multi) {
-			err = -EINVAL;
-			goto out;
-		}
+		if (key.def_uni || !key.def_multi)
+			return -EINVAL;
 
-		if (!rdev->ops->set_default_beacon_key) {
-			err = -EOPNOTSUPP;
-			goto out;
-		}
+		if (!rdev->ops->set_default_beacon_key)
+			return -EOPNOTSUPP;
 
 		err = nl80211_key_allowed(wdev);
 		if (err)
-			goto out;
+			return err;
 
 		err = nl80211_validate_key_link_id(info, wdev, link_id, false);
 		if (err)
-			goto out;
+			return err;
 
-		err = rdev_set_default_beacon_key(rdev, dev, link_id, key.idx);
-		if (err)
-			goto out;
+		return rdev_set_default_beacon_key(rdev, dev, link_id, key.idx);
 	} else if (key.p.mode == NL80211_KEY_SET_TX &&
 		   wiphy_ext_feature_isset(&rdev->wiphy,
 					   NL80211_EXT_FEATURE_EXT_KEY_ID)) {
@@ -4680,25 +4651,19 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 		if (info->attrs[NL80211_ATTR_MAC])
 			mac_addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
 
-		if (!mac_addr || key.idx < 0 || key.idx > 1) {
-			err = -EINVAL;
-			goto out;
-		}
+		if (!mac_addr || key.idx < 0 || key.idx > 1)
+			return -EINVAL;
 
 		err = nl80211_validate_key_link_id(info, wdev, link_id, true);
 		if (err)
-			goto out;
+			return err;
 
-		err = rdev_add_key(rdev, dev, link_id, key.idx,
-				   NL80211_KEYTYPE_PAIRWISE,
-				   mac_addr, &key.p);
-	} else {
-		err = -EINVAL;
+		return rdev_add_key(rdev, dev, link_id, key.idx,
+				    NL80211_KEYTYPE_PAIRWISE,
+				    mac_addr, &key.p);
 	}
- out:
-	wdev_unlock(wdev);
 
-	return err;
+	return -EINVAL;
 }
 
 static int nl80211_new_key(struct sk_buff *skb, struct genl_info *info)
@@ -4751,7 +4716,6 @@ static int nl80211_new_key(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 
-	wdev_lock(wdev);
 	err = nl80211_key_allowed(wdev);
 	if (err)
 		GENL_SET_ERR_MSG(info, "key not allowed");
@@ -4767,7 +4731,6 @@ static int nl80211_new_key(struct sk_buff *skb, struct genl_info *info)
 		if (err)
 			GENL_SET_ERR_MSG(info, "key addition failed");
 	}
-	wdev_unlock(wdev);
 
 	return err;
 }
@@ -4808,7 +4771,6 @@ static int nl80211_del_key(struct sk_buff *skb, struct genl_info *info)
 	if (!rdev->ops->del_key)
 		return -EOPNOTSUPP;
 
-	wdev_lock(wdev);
 	err = nl80211_key_allowed(wdev);
 
 	if (key.type == NL80211_KEYTYPE_GROUP && mac_addr &&
@@ -4832,7 +4794,6 @@ static int nl80211_del_key(struct sk_buff *skb, struct genl_info *info)
 			wdev->wext.default_mgmt_key = -1;
 	}
 #endif
-	wdev_unlock(wdev);
 
 	return err;
 }
@@ -6072,20 +6033,18 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	wdev_lock(wdev);
-
 	if (info->attrs[NL80211_ATTR_TX_RATES]) {
 		err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
 						    NL80211_ATTR_TX_RATES,
 						    &params->beacon_rate,
 						    dev, false, link_id);
 		if (err)
-			goto out_unlock;
+			goto out;
 
 		err = validate_beacon_tx_rate(rdev, params->chandef.chan->band,
 					      &params->beacon_rate);
 		if (err)
-			goto out_unlock;
+			goto out;
 	}
 
 	if (info->attrs[NL80211_ATTR_SMPS_MODE]) {
@@ -6098,19 +6057,19 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			if (!(rdev->wiphy.features &
 			      NL80211_FEATURE_STATIC_SMPS)) {
 				err = -EINVAL;
-				goto out_unlock;
+				goto out;
 			}
 			break;
 		case NL80211_SMPS_DYNAMIC:
 			if (!(rdev->wiphy.features &
 			      NL80211_FEATURE_DYNAMIC_SMPS)) {
 				err = -EINVAL;
-				goto out_unlock;
+				goto out;
 			}
 			break;
 		default:
 			err = -EINVAL;
-			goto out_unlock;
+			goto out;
 		}
 	} else {
 		params->smps_mode = NL80211_SMPS_OFF;
@@ -6119,7 +6078,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	params->pbss = nla_get_flag(info->attrs[NL80211_ATTR_PBSS]);
 	if (params->pbss && !rdev->wiphy.bands[NL80211_BAND_60GHZ]) {
 		err = -EOPNOTSUPP;
-		goto out_unlock;
+		goto out;
 	}
 
 	if (info->attrs[NL80211_ATTR_ACL_POLICY]) {
@@ -6127,7 +6086,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 		if (IS_ERR(params->acl)) {
 			err = PTR_ERR(params->acl);
 			params->acl = NULL;
-			goto out_unlock;
+			goto out;
 		}
 	}
 
@@ -6139,7 +6098,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 					info->attrs[NL80211_ATTR_HE_OBSS_PD],
 					&params->he_obss_pd);
 		if (err)
-			goto out_unlock;
+			goto out;
 	}
 
 	if (info->attrs[NL80211_ATTR_FILS_DISCOVERY]) {
@@ -6147,7 +6106,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 						   info->attrs[NL80211_ATTR_FILS_DISCOVERY],
 						   params);
 		if (err)
-			goto out_unlock;
+			goto out;
 	}
 
 	if (info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP]) {
@@ -6155,7 +6114,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 			rdev, info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP],
 			params);
 		if (err)
-			goto out_unlock;
+			goto out;
 	}
 
 	if (info->attrs[NL80211_ATTR_MBSSID_CONFIG]) {
@@ -6166,17 +6125,17 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 							params->beacon.mbssid_ies->cnt :
 							0);
 		if (err)
-			goto out_unlock;
+			goto out;
 	}
 
 	if (!params->mbssid_config.ema && params->beacon.rnr_ies) {
 		err = -EINVAL;
-		goto out_unlock;
+		goto out;
 	}
 
 	err = nl80211_calculate_ap_params(params);
 	if (err)
-		goto out_unlock;
+		goto out;
 
 	if (info->attrs[NL80211_ATTR_AP_SETTINGS_FLAGS])
 		params->flags = nla_get_u32(
@@ -6188,7 +6147,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	    info->attrs[NL80211_ATTR_SOCKET_OWNER] &&
 	    wdev->conn_owner_nlportid != info->snd_portid) {
 		err = -EINVAL;
-		goto out_unlock;
+		goto out;
 	}
 
 	/* FIXME: validate MLO/link-id against driver capabilities */
@@ -6206,8 +6165,6 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 
 		nl80211_send_ap_started(wdev, link_id);
 	}
-out_unlock:
-	wdev_unlock(wdev);
 out:
 	kfree(params->acl);
 	kfree(params->beacon.mbssid_ies);
@@ -6244,9 +6201,7 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto out;
 
-	wdev_lock(wdev);
 	err = rdev_change_beacon(rdev, dev, &params);
-	wdev_unlock(wdev);
 
 out:
 	kfree(params.mbssid_ies);
@@ -7305,9 +7260,7 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	/* driver will call cfg80211_check_station_change() */
-	wdev_lock(dev->ieee80211_ptr);
 	err = rdev_change_station(rdev, dev, mac_addr, &params);
-	wdev_unlock(dev->ieee80211_ptr);
 
  out_put_vlan:
 	dev_put(params.vlan);
@@ -7575,7 +7528,6 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 
 	/* be aware of params.vlan when changing code here */
 
-	wdev_lock(dev->ieee80211_ptr);
 	if (wdev->valid_links) {
 		if (params.link_sta_params.link_id < 0) {
 			err = -EINVAL;
@@ -7593,7 +7545,6 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 	}
 	err = rdev_add_station(rdev, dev, mac_addr, &params);
 out:
-	wdev_unlock(dev->ieee80211_ptr);
 	dev_put(params.vlan);
 	return err;
 }
@@ -7603,7 +7554,6 @@ static int nl80211_del_station(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	struct station_del_parameters params;
-	int ret;
 
 	memset(&params, 0, sizeof(params));
 
@@ -7651,11 +7601,7 @@ static int nl80211_del_station(struct sk_buff *skb, struct genl_info *info)
 		params.reason_code = WLAN_REASON_PREV_AUTH_NOT_VALID;
 	}
 
-	wdev_lock(dev->ieee80211_ptr);
-	ret = rdev_del_station(rdev, dev, &params);
-	wdev_unlock(dev->ieee80211_ptr);
-
-	return ret;
+	return rdev_del_station(rdev, dev, &params);
 }
 
 static int nl80211_send_mpath(struct sk_buff *msg, u32 portid, u32 seq,
@@ -7974,9 +7920,7 @@ static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct bss_parameters params;
-	int err;
 
 	memset(&params, 0, sizeof(params));
 	params.link_id = nl80211_link_id_or_invalid(info->attrs);
@@ -8039,11 +7983,7 @@ static int nl80211_set_bss(struct sk_buff *skb, struct genl_info *info)
 	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
 		return -EOPNOTSUPP;
 
-	wdev_lock(wdev);
-	err = rdev_change_bss(rdev, dev, &params);
-	wdev_unlock(wdev);
-
-	return err;
+	return rdev_change_bss(rdev, dev, &params);
 }
 
 static int nl80211_req_set_reg(struct sk_buff *skb, struct genl_info *info)
@@ -8114,13 +8054,11 @@ static int nl80211_get_mesh_config(struct sk_buff *skb,
 	if (!rdev->ops->get_mesh_config)
 		return -EOPNOTSUPP;
 
-	wdev_lock(wdev);
 	/* If not connected, get default parameters */
 	if (!wdev->u.mesh.id_len)
 		memcpy(&cur_params, &default_mesh_config, sizeof(cur_params));
 	else
 		err = rdev_get_mesh_config(rdev, dev, &cur_params);
-	wdev_unlock(wdev);
 
 	if (err)
 		return err;
@@ -8496,15 +8434,12 @@ static int nl80211_update_mesh_config(struct sk_buff *skb,
 	if (err)
 		return err;
 
-	wdev_lock(wdev);
 	if (!wdev->u.mesh.id_len)
 		err = -ENOLINK;
 
 	if (!err)
 		err = rdev_update_mesh_config(rdev, dev, mask, &cfg);
 
-	wdev_unlock(wdev);
-
 	return err;
 }
 
@@ -8995,7 +8930,7 @@ static bool cfg80211_off_channel_oper_allowed(struct wireless_dev *wdev,
 	unsigned int link_id;
 	bool all_ok = true;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	if (!cfg80211_beaconing_iface_active(wdev))
 		return true;
@@ -9245,7 +9180,6 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 
 	request->n_channels = i;
 
-	wdev_lock(wdev);
 	for (i = 0; i < request->n_channels; i++) {
 		struct ieee80211_channel *chan = request->channels[i];
 
@@ -9254,12 +9188,10 @@ static int nl80211_trigger_scan(struct sk_buff *skb, struct genl_info *info)
 			continue;
 
 		if (!cfg80211_wdev_on_sub_chan(wdev, chan, true)) {
-			wdev_unlock(wdev);
 			err = -EBUSY;
 			goto out_free;
 		}
 	}
-	wdev_unlock(wdev);
 
 	i = 0;
 	if (n_ssids) {
@@ -10265,9 +10197,7 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 			goto free;
 	}
 
-	wdev_lock(wdev);
 	err = rdev_channel_switch(rdev, dev, &params);
-	wdev_unlock(wdev);
 
 free:
 	kfree(params.beacon_after.mbssid_ies);
@@ -10290,7 +10220,7 @@ static int nl80211_send_bss(struct sk_buff *msg, struct netlink_callback *cb,
 	void *hdr;
 	struct nlattr *bss;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	hdr = nl80211hdr_put(msg, NETLINK_CB(cb->skb).portid, seq, flags,
 			     NL80211_CMD_NEW_SCAN_RESULTS);
@@ -10439,7 +10369,6 @@ static int nl80211_dump_scan(struct sk_buff *skb, struct netlink_callback *cb)
 	/* nl80211_prepare_wdev_dump acquired it in the successful case */
 	__acquire(&rdev->wiphy.mtx);
 
-	wdev_lock(wdev);
 	spin_lock_bh(&rdev->bss_lock);
 
 	/*
@@ -10465,7 +10394,6 @@ static int nl80211_dump_scan(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 
 	spin_unlock_bh(&rdev->bss_lock);
-	wdev_unlock(wdev);
 
 	cb->args[2] = idx;
 	wiphy_unlock(&rdev->wiphy);
@@ -10588,9 +10516,7 @@ static int nl80211_dump_survey(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 
 	while (1) {
-		wdev_lock(wdev);
 		res = rdev_dump_survey(rdev, wdev->netdev, survey_idx, &survey);
-		wdev_unlock(wdev);
 		if (res == -ENOENT)
 			break;
 		if (res)
@@ -10763,9 +10689,7 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 	if (!req.bss)
 		return -ENOENT;
 
-	wdev_lock(dev->ieee80211_ptr);
 	err = cfg80211_mlme_auth(rdev, dev, &req);
-	wdev_unlock(dev->ieee80211_ptr);
 
 	cfg80211_put_bss(&rdev->wiphy, req.bss);
 
@@ -11180,8 +11104,6 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 
 	err = nl80211_crypto_settings(rdev, info, &req.crypto, 1);
 	if (!err) {
-		wdev_lock(dev->ieee80211_ptr);
-
 		err = cfg80211_mlme_assoc(rdev, dev, &req);
 
 		if (!err && info->attrs[NL80211_ATTR_SOCKET_OWNER]) {
@@ -11190,8 +11112,6 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 			memcpy(dev->ieee80211_ptr->disconnect_bssid,
 			       ap_addr, ETH_ALEN);
 		}
-
-		wdev_unlock(dev->ieee80211_ptr);
 	}
 
 free:
@@ -11208,7 +11128,7 @@ static int nl80211_deauthenticate(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	const u8 *ie = NULL, *bssid;
-	int ie_len = 0, err;
+	int ie_len = 0;
 	u16 reason_code;
 	bool local_state_change;
 
@@ -11244,11 +11164,8 @@ static int nl80211_deauthenticate(struct sk_buff *skb, struct genl_info *info)
 
 	local_state_change = !!info->attrs[NL80211_ATTR_LOCAL_STATE_CHANGE];
 
-	wdev_lock(dev->ieee80211_ptr);
-	err = cfg80211_mlme_deauth(rdev, dev, bssid, ie, ie_len, reason_code,
-				   local_state_change);
-	wdev_unlock(dev->ieee80211_ptr);
-	return err;
+	return cfg80211_mlme_deauth(rdev, dev, bssid, ie, ie_len, reason_code,
+				    local_state_change);
 }
 
 static int nl80211_disassociate(struct sk_buff *skb, struct genl_info *info)
@@ -11256,7 +11173,7 @@ static int nl80211_disassociate(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	const u8 *ie = NULL, *bssid;
-	int ie_len = 0, err;
+	int ie_len = 0;
 	u16 reason_code;
 	bool local_state_change;
 
@@ -11292,11 +11209,8 @@ static int nl80211_disassociate(struct sk_buff *skb, struct genl_info *info)
 
 	local_state_change = !!info->attrs[NL80211_ATTR_LOCAL_STATE_CHANGE];
 
-	wdev_lock(dev->ieee80211_ptr);
-	err = cfg80211_mlme_disassoc(rdev, dev, bssid, ie, ie_len, reason_code,
-				     local_state_change);
-	wdev_unlock(dev->ieee80211_ptr);
-	return err;
+	return cfg80211_mlme_disassoc(rdev, dev, bssid, ie, ie_len, reason_code,
+				      local_state_change);
 }
 
 static bool
@@ -11474,13 +11388,11 @@ static int nl80211_join_ibss(struct sk_buff *skb, struct genl_info *info)
 	ibss.userspace_handles_dfs =
 		nla_get_flag(info->attrs[NL80211_ATTR_HANDLE_DFS]);
 
-	wdev_lock(dev->ieee80211_ptr);
 	err = __cfg80211_join_ibss(rdev, dev, &ibss, connkeys);
 	if (err)
 		kfree_sensitive(connkeys);
 	else if (info->attrs[NL80211_ATTR_SOCKET_OWNER])
 		dev->ieee80211_ptr->conn_owner_nlportid = info->snd_portid;
-	wdev_unlock(dev->ieee80211_ptr);
 
 	return err;
 }
@@ -12013,8 +11925,6 @@ static int nl80211_connect(struct sk_buff *skb, struct genl_info *info)
 	if (nla_get_flag(info->attrs[NL80211_ATTR_MLO_SUPPORT]))
 		connect.flags |= CONNECT_REQ_MLO_SUPPORT;
 
-	wdev_lock(dev->ieee80211_ptr);
-
 	err = cfg80211_connect(rdev, dev, &connect, connkeys,
 			       connect.prev_bssid);
 	if (err)
@@ -12029,8 +11939,6 @@ static int nl80211_connect(struct sk_buff *skb, struct genl_info *info)
 			eth_zero_addr(dev->ieee80211_ptr->disconnect_bssid);
 	}
 
-	wdev_unlock(dev->ieee80211_ptr);
-
 	return err;
 }
 
@@ -12044,7 +11952,6 @@ static int nl80211_update_connect_params(struct sk_buff *skb,
 	bool fils_sk_offload;
 	u32 auth_type;
 	u32 changed = 0;
-	int ret;
 
 	if (!rdev->ops->update_connect_params)
 		return -EOPNOTSUPP;
@@ -12105,14 +12012,10 @@ static int nl80211_update_connect_params(struct sk_buff *skb,
 		changed |= UPDATE_AUTH_TYPE;
 	}
 
-	wdev_lock(dev->ieee80211_ptr);
 	if (!wdev->connected)
-		ret = -ENOLINK;
-	else
-		ret = rdev_update_connect_params(rdev, dev, &connect, changed);
-	wdev_unlock(dev->ieee80211_ptr);
+		return -ENOLINK;
 
-	return ret;
+	return rdev_update_connect_params(rdev, dev, &connect, changed);
 }
 
 static int nl80211_disconnect(struct sk_buff *skb, struct genl_info *info)
@@ -12120,7 +12023,6 @@ static int nl80211_disconnect(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	u16 reason;
-	int ret;
 
 	if (dev->ieee80211_ptr->conn_owner_nlportid &&
 	    dev->ieee80211_ptr->conn_owner_nlportid != info->snd_portid)
@@ -12138,10 +12040,7 @@ static int nl80211_disconnect(struct sk_buff *skb, struct genl_info *info)
 	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_CLIENT)
 		return -EOPNOTSUPP;
 
-	wdev_lock(dev->ieee80211_ptr);
-	ret = cfg80211_disconnect(rdev, dev, reason, true);
-	wdev_unlock(dev->ieee80211_ptr);
-	return ret;
+	return cfg80211_disconnect(rdev, dev, reason, true);
 }
 
 static int nl80211_wiphy_netns(struct sk_buff *skb, struct genl_info *info)
@@ -12352,7 +12251,6 @@ static int nl80211_remain_on_channel(struct sk_buff *skb,
 	if (err)
 		return err;
 
-	wdev_lock(wdev);
 	if (!cfg80211_off_channel_oper_allowed(wdev, chandef.chan)) {
 		const struct cfg80211_chan_def *oper_chandef, *compat_chandef;
 
@@ -12361,7 +12259,6 @@ static int nl80211_remain_on_channel(struct sk_buff *skb,
 		if (WARN_ON(!oper_chandef)) {
 			/* cannot happen since we must beacon to get here */
 			WARN_ON(1);
-			wdev_unlock(wdev);
 			return -EBUSY;
 		}
 
@@ -12369,12 +12266,9 @@ static int nl80211_remain_on_channel(struct sk_buff *skb,
 		compat_chandef = cfg80211_chandef_compatible(&chandef,
 							     oper_chandef);
 
-		if (compat_chandef != &chandef) {
-			wdev_unlock(wdev);
+		if (compat_chandef != &chandef)
 			return -EBUSY;
-		}
 	}
-	wdev_unlock(wdev);
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
@@ -12433,23 +12327,18 @@ static int nl80211_set_tx_bitrate_mask(struct sk_buff *skb,
 	unsigned int link_id = nl80211_link_id(info->attrs);
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	int err;
 
 	if (!rdev->ops->set_bitrate_mask)
 		return -EOPNOTSUPP;
 
-	wdev_lock(wdev);
 	err = nl80211_parse_tx_bitrate_mask(info, info->attrs,
 					    NL80211_ATTR_TX_RATES, &mask,
 					    dev, true, link_id);
 	if (err)
-		goto out;
+		return err;
 
-	err = rdev_set_bitrate_mask(rdev, dev, link_id, NULL, &mask);
-out:
-	wdev_unlock(wdev);
-	return err;
+	return rdev_set_bitrate_mask(rdev, dev, link_id, NULL, &mask);
 }
 
 static int nl80211_register_mgmt(struct sk_buff *skb, struct genl_info *info)
@@ -12578,12 +12467,9 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 	if (!chandef.chan && params.offchan)
 		return -EINVAL;
 
-	wdev_lock(wdev);
 	if (params.offchan &&
-	    !cfg80211_off_channel_oper_allowed(wdev, chandef.chan)) {
-		wdev_unlock(wdev);
+	    !cfg80211_off_channel_oper_allowed(wdev, chandef.chan))
 		return -EBUSY;
-	}
 
 	params.link_id = nl80211_link_id_or_invalid(info->attrs);
 	/*
@@ -12592,11 +12478,8 @@ static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
 	 * to the driver.
 	 */
 	if (params.link_id >= 0 &&
-	    !(wdev->valid_links & BIT(params.link_id))) {
-		wdev_unlock(wdev);
+	    !(wdev->valid_links & BIT(params.link_id)))
 		return -EINVAL;
-	}
-	wdev_unlock(wdev);
 
 	params.buf = nla_data(info->attrs[NL80211_ATTR_FRAME]);
 	params.len = nla_len(info->attrs[NL80211_ATTR_FRAME]);
@@ -12866,8 +12749,8 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	int i, err;
 	s32 prev = S32_MIN;
+	int i;
 
 	/* Check all values negative and sorted */
 	for (i = 0; i < n_thresholds; i++) {
@@ -12881,9 +12764,7 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 	    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT)
 		return -EOPNOTSUPP;
 
-	wdev_lock(wdev);
 	cfg80211_cqm_config_free(wdev);
-	wdev_unlock(wdev);
 
 	if (n_thresholds <= 1 && rdev->ops->set_cqm_rssi_config) {
 		if (n_thresholds == 0 || thresholds[0] == 0) /* Disabling */
@@ -12900,17 +12781,14 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 	if (n_thresholds == 1 && thresholds[0] == 0) /* Disabling */
 		n_thresholds = 0;
 
-	wdev_lock(wdev);
 	if (n_thresholds) {
 		struct cfg80211_cqm_config *cqm_config;
 
 		cqm_config = kzalloc(struct_size(cqm_config, rssi_thresholds,
 						 n_thresholds),
 				     GFP_KERNEL);
-		if (!cqm_config) {
-			err = -ENOMEM;
-			goto unlock;
-		}
+		if (!cqm_config)
+			return -ENOMEM;
 
 		cqm_config->rssi_hyst = hysteresis;
 		cqm_config->n_rssi_thresholds = n_thresholds;
@@ -12921,12 +12799,7 @@ static int nl80211_set_cqm_rssi(struct genl_info *info,
 		wdev->cqm_config = cqm_config;
 	}
 
-	err = cfg80211_cqm_rssi_update(rdev, dev);
-
-unlock:
-	wdev_unlock(wdev);
-
-	return err;
+	return cfg80211_cqm_rssi_update(rdev, dev);
 }
 
 static int nl80211_set_cqm(struct sk_buff *skb, struct genl_info *info)
@@ -13108,11 +12981,9 @@ static int nl80211_join_mesh(struct sk_buff *skb, struct genl_info *info)
 		setup.control_port_over_nl80211 = true;
 	}
 
-	wdev_lock(dev->ieee80211_ptr);
 	err = __cfg80211_join_mesh(rdev, dev, &setup, &cfg);
 	if (!err && info->attrs[NL80211_ATTR_SOCKET_OWNER])
 		dev->ieee80211_ptr->conn_owner_nlportid = info->snd_portid;
-	wdev_unlock(dev->ieee80211_ptr);
 
 	return err;
 }
@@ -14056,21 +13927,13 @@ static int nl80211_set_rekey_data(struct sk_buff *skb, struct genl_info *info)
 	if (tb[NL80211_REKEY_DATA_AKM])
 		rekey_data.akm = nla_get_u32(tb[NL80211_REKEY_DATA_AKM]);
 
-	wdev_lock(wdev);
-	if (!wdev->connected) {
-		err = -ENOTCONN;
-		goto out;
-	}
+	if (!wdev->connected)
+		return -ENOTCONN;
 
-	if (!rdev->ops->set_rekey_data) {
-		err = -EOPNOTSUPP;
-		goto out;
-	}
+	if (!rdev->ops->set_rekey_data)
+		return -EOPNOTSUPP;
 
-	err = rdev_set_rekey_data(rdev, dev, &rekey_data);
- out:
-	wdev_unlock(wdev);
-	return err;
+	return rdev_set_rekey_data(rdev, dev, &rekey_data);
 }
 
 static int nl80211_register_unexpected_frame(struct sk_buff *skb,
@@ -15274,11 +15137,9 @@ static int nl80211_set_qos_map(struct sk_buff *skb,
 		memcpy(qos_map->up, pos, IEEE80211_QOS_MAP_LEN_MIN);
 	}
 
-	wdev_lock(dev->ieee80211_ptr);
 	ret = nl80211_key_allowed(dev->ieee80211_ptr);
 	if (!ret)
 		ret = rdev_set_qos_map(rdev, dev, qos_map);
-	wdev_unlock(dev->ieee80211_ptr);
 
 	kfree(qos_map);
 	return ret;
@@ -15292,7 +15153,6 @@ static int nl80211_add_tx_ts(struct sk_buff *skb, struct genl_info *info)
 	const u8 *peer;
 	u8 tsid, up;
 	u16 admitted_time = 0;
-	int err;
 
 	if (!(rdev->wiphy.features & NL80211_FEATURE_SUPPORTS_WMM_ADMISSION))
 		return -EOPNOTSUPP;
@@ -15322,34 +15182,25 @@ static int nl80211_add_tx_ts(struct sk_buff *skb, struct genl_info *info)
 			return -EINVAL;
 	}
 
-	wdev_lock(wdev);
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
 		if (wdev->connected)
 			break;
-		err = -ENOTCONN;
-		goto out;
+		return -ENOTCONN;
 	default:
-		err = -EOPNOTSUPP;
-		goto out;
+		return -EOPNOTSUPP;
 	}
 
-	err = rdev_add_tx_ts(rdev, dev, tsid, peer, up, admitted_time);
-
- out:
-	wdev_unlock(wdev);
-	return err;
+	return rdev_add_tx_ts(rdev, dev, tsid, peer, up, admitted_time);
 }
 
 static int nl80211_del_tx_ts(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	const u8 *peer;
 	u8 tsid;
-	int err;
 
 	if (!info->attrs[NL80211_ATTR_TSID] || !info->attrs[NL80211_ATTR_MAC])
 		return -EINVAL;
@@ -15357,11 +15208,7 @@ static int nl80211_del_tx_ts(struct sk_buff *skb, struct genl_info *info)
 	tsid = nla_get_u8(info->attrs[NL80211_ATTR_TSID]);
 	peer = nla_data(info->attrs[NL80211_ATTR_MAC]);
 
-	wdev_lock(wdev);
-	err = rdev_del_tx_ts(rdev, dev, tsid, peer);
-	wdev_unlock(wdev);
-
-	return err;
+	return rdev_del_tx_ts(rdev, dev, tsid, peer);
 }
 
 static int nl80211_tdls_channel_switch(struct sk_buff *skb,
@@ -15417,11 +15264,7 @@ static int nl80211_tdls_channel_switch(struct sk_buff *skb,
 	addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
 	oper_class = nla_get_u8(info->attrs[NL80211_ATTR_OPER_CLASS]);
 
-	wdev_lock(wdev);
-	err = rdev_tdls_channel_switch(rdev, dev, addr, oper_class, &chandef);
-	wdev_unlock(wdev);
-
-	return err;
+	return rdev_tdls_channel_switch(rdev, dev, addr, oper_class, &chandef);
 }
 
 static int nl80211_tdls_cancel_channel_switch(struct sk_buff *skb,
@@ -15429,7 +15272,6 @@ static int nl80211_tdls_cancel_channel_switch(struct sk_buff *skb,
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	const u8 *addr;
 
 	if (!rdev->ops->tdls_channel_switch ||
@@ -15450,9 +15292,7 @@ static int nl80211_tdls_cancel_channel_switch(struct sk_buff *skb,
 
 	addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
 
-	wdev_lock(wdev);
 	rdev_tdls_cancel_channel_switch(rdev, dev, addr);
-	wdev_unlock(wdev);
 
 	return 0;
 }
@@ -15485,7 +15325,6 @@ static int nl80211_set_pmk(struct sk_buff *skb, struct genl_info *info)
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_pmk_conf pmk_conf = {};
-	int ret;
 
 	if (wdev->iftype != NL80211_IFTYPE_STATION &&
 	    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT)
@@ -15498,34 +15337,24 @@ static int nl80211_set_pmk(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[NL80211_ATTR_MAC] || !info->attrs[NL80211_ATTR_PMK])
 		return -EINVAL;
 
-	wdev_lock(wdev);
-	if (!wdev->connected) {
-		ret = -ENOTCONN;
-		goto out;
-	}
+	if (!wdev->connected)
+		return -ENOTCONN;
 
 	pmk_conf.aa = nla_data(info->attrs[NL80211_ATTR_MAC]);
-	if (memcmp(pmk_conf.aa, wdev->u.client.connected_addr, ETH_ALEN)) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (memcmp(pmk_conf.aa, wdev->u.client.connected_addr, ETH_ALEN))
+		return -EINVAL;
 
 	pmk_conf.pmk = nla_data(info->attrs[NL80211_ATTR_PMK]);
 	pmk_conf.pmk_len = nla_len(info->attrs[NL80211_ATTR_PMK]);
 	if (pmk_conf.pmk_len != WLAN_PMK_LEN &&
-	    pmk_conf.pmk_len != WLAN_PMK_LEN_SUITE_B_192) {
-		ret = -EINVAL;
-		goto out;
-	}
+	    pmk_conf.pmk_len != WLAN_PMK_LEN_SUITE_B_192)
+		return -EINVAL;
 
 	if (info->attrs[NL80211_ATTR_PMKR0_NAME])
 		pmk_conf.pmk_r0_name =
 			nla_data(info->attrs[NL80211_ATTR_PMKR0_NAME]);
 
-	ret = rdev_set_pmk(rdev, dev, &pmk_conf);
-out:
-	wdev_unlock(wdev);
-	return ret;
+	return rdev_set_pmk(rdev, dev, &pmk_conf);
 }
 
 static int nl80211_del_pmk(struct sk_buff *skb, struct genl_info *info)
@@ -15534,7 +15363,6 @@ static int nl80211_del_pmk(struct sk_buff *skb, struct genl_info *info)
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	const u8 *aa;
-	int ret;
 
 	if (wdev->iftype != NL80211_IFTYPE_STATION &&
 	    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT)
@@ -15547,12 +15375,8 @@ static int nl80211_del_pmk(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[NL80211_ATTR_MAC])
 		return -EINVAL;
 
-	wdev_lock(wdev);
 	aa = nla_data(info->attrs[NL80211_ATTR_MAC]);
-	ret = rdev_del_pmk(rdev, dev, aa);
-	wdev_unlock(wdev);
-
-	return ret;
+	return rdev_del_pmk(rdev, dev, aa);
 }
 
 static int nl80211_external_auth(struct sk_buff *skb, struct genl_info *info)
@@ -15626,8 +15450,6 @@ static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 
-	wdev_lock(wdev);
-
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_P2P_GO:
@@ -15636,21 +15458,16 @@ static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 	case NL80211_IFTYPE_ADHOC:
 		if (wdev->u.ibss.current_bss)
 			break;
-		err = -ENOTCONN;
-		goto out;
+		return -ENOTCONN;
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
 		if (wdev->connected)
 			break;
-		err = -ENOTCONN;
-		goto out;
+		return -ENOTCONN;
 	default:
-		err = -EOPNOTSUPP;
-		goto out;
+		return -EOPNOTSUPP;
 	}
 
-	wdev_unlock(wdev);
-
 	buf = nla_data(info->attrs[NL80211_ATTR_FRAME]);
 	len = nla_len(info->attrs[NL80211_ATTR_FRAME]);
 	dest = nla_data(info->attrs[NL80211_ATTR_MAC]);
@@ -15666,9 +15483,6 @@ static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 	if (!err && !dont_wait_for_ack)
 		nl_set_extack_cookie_u64(info->extack, cookie);
 	return err;
- out:
-	wdev_unlock(wdev);
-	return err;
 }
 
 static int nl80211_get_ftm_responder_stats(struct sk_buff *skb,
@@ -15946,8 +15760,6 @@ static int nl80211_set_tid_config(struct sk_buff *skb,
 	if (info->attrs[NL80211_ATTR_MAC])
 		tid_config->peer = nla_data(info->attrs[NL80211_ATTR_MAC]);
 
-	wdev_lock(dev->ieee80211_ptr);
-
 	nla_for_each_nested(tid, info->attrs[NL80211_ATTR_TID_CONFIG],
 			    rem_conf) {
 		ret = nla_parse_nested(attrs, NL80211_TID_CONFIG_ATTR_MAX,
@@ -15969,7 +15781,6 @@ static int nl80211_set_tid_config(struct sk_buff *skb,
 
 bad_tid_conf:
 	kfree(tid_config);
-	wdev_unlock(dev->ieee80211_ptr);
 	return ret;
 }
 
@@ -16066,9 +15877,7 @@ static int nl80211_color_change(struct sk_buff *skb, struct genl_info *info)
 		params.counter_offset_presp = offset;
 	}
 
-	wdev_lock(wdev);
 	err = rdev_color_change(rdev, dev, &params);
-	wdev_unlock(wdev);
 
 out:
 	kfree(params.beacon_next.mbssid_ies);
@@ -16124,7 +15933,6 @@ static int nl80211_add_link(struct sk_buff *skb, struct genl_info *info)
 	    !is_valid_ether_addr(nla_data(info->attrs[NL80211_ATTR_MAC])))
 		return -EINVAL;
 
-	wdev_lock(wdev);
 	wdev->valid_links |= BIT(link_id);
 	ether_addr_copy(wdev->links[link_id].addr,
 			nla_data(info->attrs[NL80211_ATTR_MAC]));
@@ -16134,7 +15942,6 @@ static int nl80211_add_link(struct sk_buff *skb, struct genl_info *info)
 		wdev->valid_links &= ~BIT(link_id);
 		eth_zero_addr(wdev->links[link_id].addr);
 	}
-	wdev_unlock(wdev);
 
 	return ret;
 }
@@ -16156,9 +15963,7 @@ static int nl80211_remove_link(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 
-	wdev_lock(wdev);
 	cfg80211_remove_link(wdev, link_id);
-	wdev_unlock(wdev);
 
 	return 0;
 }
@@ -16248,14 +16053,10 @@ nl80211_add_mod_link_station(struct sk_buff *skb, struct genl_info *info,
 	if (err)
 		return err;
 
-	wdev_lock(dev->ieee80211_ptr);
 	if (add)
-		err = rdev_add_link_station(rdev, dev, &params);
-	else
-		err = rdev_mod_link_station(rdev, dev, &params);
-	wdev_unlock(dev->ieee80211_ptr);
+		return rdev_add_link_station(rdev, dev, &params);
 
-	return err;
+	return rdev_mod_link_station(rdev, dev, &params);
 }
 
 static int
@@ -16276,7 +16077,6 @@ nl80211_remove_link_station(struct sk_buff *skb, struct genl_info *info)
 	struct link_station_del_parameters params = {};
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
-	int ret;
 
 	if (!rdev->ops->del_link_station)
 		return -EOPNOTSUPP;
@@ -16288,11 +16088,7 @@ nl80211_remove_link_station(struct sk_buff *skb, struct genl_info *info)
 	params.mld_mac = nla_data(info->attrs[NL80211_ATTR_MLD_ADDR]);
 	params.link_id = nla_get_u8(info->attrs[NL80211_ATTR_MLO_LINK_ID]);
 
-	wdev_lock(dev->ieee80211_ptr);
-	ret = rdev_del_link_station(rdev, dev, &params);
-	wdev_unlock(dev->ieee80211_ptr);
-
-	return ret;
+	return rdev_del_link_station(rdev, dev, &params);
 }
 
 static int nl80211_set_hw_timestamp(struct sk_buff *skb,
@@ -18300,7 +18096,7 @@ void cfg80211_links_removed(struct net_device *dev, u16 link_mask)
 	struct nlattr *links;
 	void *hdr;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 	trace_cfg80211_links_removed(dev, link_mask);
 
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_STATION &&
@@ -19354,7 +19150,7 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 	WARN_INVALID_LINK_ID(wdev, link_id);
 
 	trace_cfg80211_ch_switch_notify(dev, chandef, link_id, punct_bitmap);
@@ -19399,7 +19195,7 @@ void cfg80211_ch_switch_started_notify(struct net_device *dev,
 	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 	WARN_INVALID_LINK_ID(wdev, link_id);
 
 	trace_cfg80211_ch_switch_started_notify(dev, chandef, link_id,
@@ -19422,7 +19218,7 @@ int cfg80211_bss_color_notify(struct net_device *dev,
 	struct sk_buff *msg;
 	void *hdr;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	trace_cfg80211_bss_color_notify(dev, cmd, count, color_bitmap);
 
diff --git a/net/wireless/ocb.c b/net/wireless/ocb.c
index 29afaf3da54f..7d2d67f13ad9 100644
--- a/net/wireless/ocb.c
+++ b/net/wireless/ocb.c
@@ -4,7 +4,7 @@
  *
  * Copyright: (c) 2014 Czech Technical University in Prague
  *            (c) 2014 Volkswagen Group Research
- * Copyright (C) 2022 Intel Corporation
+ * Copyright (C) 2022-2023 Intel Corporation
  * Author:    Rostislav Lisovy <rostislav.lisovy@fel.cvut.cz>
  * Funded by: Volkswagen Group Research
  */
@@ -15,14 +15,14 @@
 #include "core.h"
 #include "rdev-ops.h"
 
-int __cfg80211_join_ocb(struct cfg80211_registered_device *rdev,
-			struct net_device *dev,
-			struct ocb_setup *setup)
+int cfg80211_join_ocb(struct cfg80211_registered_device *rdev,
+		      struct net_device *dev,
+		      struct ocb_setup *setup)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	int err;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_OCB)
 		return -EOPNOTSUPP;
@@ -40,27 +40,13 @@ int __cfg80211_join_ocb(struct cfg80211_registered_device *rdev,
 	return err;
 }
 
-int cfg80211_join_ocb(struct cfg80211_registered_device *rdev,
-		      struct net_device *dev,
-		      struct ocb_setup *setup)
+int cfg80211_leave_ocb(struct cfg80211_registered_device *rdev,
+		       struct net_device *dev)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	int err;
 
-	wdev_lock(wdev);
-	err = __cfg80211_join_ocb(rdev, dev, setup);
-	wdev_unlock(wdev);
-
-	return err;
-}
-
-int __cfg80211_leave_ocb(struct cfg80211_registered_device *rdev,
-			 struct net_device *dev)
-{
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	int err;
-
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_OCB)
 		return -EOPNOTSUPP;
@@ -77,16 +63,3 @@ int __cfg80211_leave_ocb(struct cfg80211_registered_device *rdev,
 
 	return err;
 }
-
-int cfg80211_leave_ocb(struct cfg80211_registered_device *rdev,
-		       struct net_device *dev)
-{
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	int err;
-
-	wdev_lock(wdev);
-	err = __cfg80211_leave_ocb(rdev, dev);
-	wdev_unlock(wdev);
-
-	return err;
-}
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 9611aa0bd051..e106dcea3977 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -600,7 +600,7 @@ static void cfg80211_pmsr_process_abort(struct wireless_dev *wdev)
 	struct cfg80211_pmsr_request *req, *tmp;
 	LIST_HEAD(free_list);
 
-	lockdep_assert_held(&wdev->mtx);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	spin_lock_bh(&wdev->pmsr_lock);
 	list_for_each_entry_safe(req, tmp, &wdev->pmsr_list, list) {
@@ -623,9 +623,7 @@ void cfg80211_pmsr_free_wk(struct work_struct *work)
 						 pmsr_free_wk);
 
 	wiphy_lock(wdev->wiphy);
-	wdev_lock(wdev);
 	cfg80211_pmsr_process_abort(wdev);
-	wdev_unlock(wdev);
 	wiphy_unlock(wdev->wiphy);
 }
 
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 1cdaf273d775..f86ee1a6daad 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2342,12 +2342,11 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 	bool ret;
 	int link;
 
-	wdev_lock(wdev);
 	iftype = wdev->iftype;
 
 	/* make sure the interface is active */
 	if (!wdev->netdev || !netif_running(wdev->netdev))
-		goto wdev_inactive_unlock;
+		return true;
 
 	for (link = 0; link < ARRAY_SIZE(wdev->links); link++) {
 		struct ieee80211_channel *chan;
@@ -2407,8 +2406,6 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 			break;
 		}
 
-		wdev_unlock(wdev);
-
 		switch (iftype) {
 		case NL80211_IFTYPE_AP:
 		case NL80211_IFTYPE_P2P_GO:
@@ -2429,16 +2426,8 @@ static bool reg_wdev_chan_valid(struct wiphy *wiphy, struct wireless_dev *wdev)
 		default:
 			break;
 		}
-
-		wdev_lock(wdev);
 	}
 
-	wdev_unlock(wdev);
-
-	return true;
-
-wdev_inactive_unlock:
-	wdev_unlock(wdev);
 	return true;
 }
 
@@ -3577,13 +3566,10 @@ static bool is_wiphy_all_set_reg_flag(enum ieee80211_regulatory_flags flag)
 	for_each_rdev(rdev) {
 		wiphy_lock(&rdev->wiphy);
 		list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
-			wdev_lock(wdev);
 			if (!(wdev->wiphy->regulatory_flags & flag)) {
-				wdev_unlock(wdev);
 				wiphy_unlock(&rdev->wiphy);
 				return false;
 			}
-			wdev_unlock(wdev);
 		}
 		wiphy_unlock(&rdev->wiphy);
 	}
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index c271f30b58fa..50fcb27e6dab 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -67,7 +67,7 @@ static int cfg80211_conn_scan(struct wireless_dev *wdev)
 	struct cfg80211_scan_request *request;
 	int n_channels, err;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	if (rdev->scan_req || rdev->scan_msg)
 		return -EBUSY;
@@ -151,7 +151,7 @@ static int cfg80211_conn_do_work(struct wireless_dev *wdev,
 	struct cfg80211_assoc_request req = {};
 	int err;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	if (!wdev->conn)
 		return 0;
@@ -255,16 +255,13 @@ void cfg80211_conn_work(struct work_struct *work)
 		if (!wdev->netdev)
 			continue;
 
-		wdev_lock(wdev);
-		if (!netif_running(wdev->netdev)) {
-			wdev_unlock(wdev);
+		if (!netif_running(wdev->netdev))
 			continue;
-		}
+
 		if (!wdev->conn ||
-		    wdev->conn->state == CFG80211_CONN_CONNECTED) {
-			wdev_unlock(wdev);
+		    wdev->conn->state == CFG80211_CONN_CONNECTED)
 			continue;
-		}
+
 		if (wdev->conn->params.bssid) {
 			memcpy(bssid_buf, wdev->conn->params.bssid, ETH_ALEN);
 			bssid = bssid_buf;
@@ -279,7 +276,6 @@ void cfg80211_conn_work(struct work_struct *work)
 			cr.timeout_reason = treason;
 			__cfg80211_connect_result(wdev->netdev, &cr, false);
 		}
-		wdev_unlock(wdev);
 	}
 
 	wiphy_unlock(&rdev->wiphy);
@@ -300,7 +296,7 @@ static struct cfg80211_bss *cfg80211_get_conn_bss(struct wireless_dev *wdev)
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 	struct cfg80211_bss *bss;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	bss = cfg80211_get_bss(wdev->wiphy, wdev->conn->params.channel,
 			       wdev->conn->params.bssid,
@@ -317,13 +313,13 @@ static struct cfg80211_bss *cfg80211_get_conn_bss(struct wireless_dev *wdev)
 	return bss;
 }
 
-static void __cfg80211_sme_scan_done(struct net_device *dev)
+void cfg80211_sme_scan_done(struct net_device *dev)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 	struct cfg80211_bss *bss;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	if (!wdev->conn)
 		return;
@@ -339,15 +335,6 @@ static void __cfg80211_sme_scan_done(struct net_device *dev)
 		schedule_work(&rdev->conn_work);
 }
 
-void cfg80211_sme_scan_done(struct net_device *dev)
-{
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
-
-	wdev_lock(wdev);
-	__cfg80211_sme_scan_done(dev);
-	wdev_unlock(wdev);
-}
-
 void cfg80211_sme_rx_auth(struct wireless_dev *wdev, const u8 *buf, size_t len)
 {
 	struct wiphy *wiphy = wdev->wiphy;
@@ -355,7 +342,7 @@ void cfg80211_sme_rx_auth(struct wireless_dev *wdev, const u8 *buf, size_t len)
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)buf;
 	u16 status_code = le16_to_cpu(mgmt->u.auth.status_code);
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	if (!wdev->conn || wdev->conn->state == CFG80211_CONN_CONNECTED)
 		return;
@@ -705,11 +692,9 @@ static bool cfg80211_is_all_idle(void)
 	for_each_rdev(rdev) {
 		wiphy_lock(&rdev->wiphy);
 		list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
-			wdev_lock(wdev);
 			if (wdev->conn || wdev->connected ||
 			    cfg80211_beaconing_iface_active(wdev))
 				is_all_idle = false;
-			wdev_unlock(wdev);
 		}
 		wiphy_unlock(&rdev->wiphy);
 	}
@@ -763,7 +748,7 @@ void __cfg80211_connect_result(struct net_device *dev,
 	const u8 *connected_addr;
 	bool bss_not_found = false;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_STATION &&
 		    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT))
@@ -1095,7 +1080,7 @@ void __cfg80211_roamed(struct wireless_dev *wdev,
 	unsigned int link;
 	const u8 *connected_addr;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_STATION &&
 		    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT))
@@ -1299,7 +1284,7 @@ EXPORT_SYMBOL(cfg80211_roamed);
 void __cfg80211_port_authorized(struct wireless_dev *wdev, const u8 *bssid,
 					const u8 *td_bitmap, u8 td_bitmap_len)
 {
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_STATION &&
 		    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT))
@@ -1355,7 +1340,7 @@ void __cfg80211_disconnected(struct net_device *dev, const u8 *ie,
 	union iwreq_data wrqu;
 #endif
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_STATION &&
 		    wdev->iftype != NL80211_IFTYPE_P2P_CLIENT))
@@ -1445,7 +1430,7 @@ int cfg80211_connect(struct cfg80211_registered_device *rdev,
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	int err;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	/*
 	 * If we have an ssid_len, we're trying to connect or are
@@ -1551,7 +1536,7 @@ int cfg80211_disconnect(struct cfg80211_registered_device *rdev,
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	int err = 0;
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	kfree_sensitive(wdev->connect_keys);
 	wdev->connect_keys = NULL;
@@ -1587,19 +1572,18 @@ void cfg80211_autodisconnect_wk(struct work_struct *work)
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 
 	wiphy_lock(wdev->wiphy);
-	wdev_lock(wdev);
 
 	if (wdev->conn_owner_nlportid) {
 		switch (wdev->iftype) {
 		case NL80211_IFTYPE_ADHOC:
-			__cfg80211_leave_ibss(rdev, wdev->netdev, false);
+			cfg80211_leave_ibss(rdev, wdev->netdev, false);
 			break;
 		case NL80211_IFTYPE_AP:
 		case NL80211_IFTYPE_P2P_GO:
-			__cfg80211_stop_ap(rdev, wdev->netdev, -1, false);
+			cfg80211_stop_ap(rdev, wdev->netdev, -1, false);
 			break;
 		case NL80211_IFTYPE_MESH_POINT:
-			__cfg80211_leave_mesh(rdev, wdev->netdev);
+			cfg80211_leave_mesh(rdev, wdev->netdev);
 			break;
 		case NL80211_IFTYPE_STATION:
 		case NL80211_IFTYPE_P2P_CLIENT:
@@ -1624,6 +1608,5 @@ void cfg80211_autodisconnect_wk(struct work_struct *work)
 		}
 	}
 
-	wdev_unlock(wdev);
 	wiphy_unlock(wdev->wiphy);
 }
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 1783ab9d57a3..fff99fe43fdd 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1044,7 +1044,6 @@ void cfg80211_process_wdev_events(struct wireless_dev *wdev)
 		list_del(&ev->list);
 		spin_unlock_irqrestore(&wdev->event_lock, flags);
 
-		wdev_lock(wdev);
 		switch (ev->type) {
 		case EVENT_CONNECT_RESULT:
 			__cfg80211_connect_result(
@@ -1066,7 +1065,7 @@ void cfg80211_process_wdev_events(struct wireless_dev *wdev)
 					       ev->ij.channel);
 			break;
 		case EVENT_STOPPED:
-			__cfg80211_leave(wiphy_to_rdev(wdev->wiphy), wdev);
+			cfg80211_leave(wiphy_to_rdev(wdev->wiphy), wdev);
 			break;
 		case EVENT_PORT_AUTHORIZED:
 			__cfg80211_port_authorized(wdev, ev->pa.bssid,
@@ -1074,7 +1073,6 @@ void cfg80211_process_wdev_events(struct wireless_dev *wdev)
 						   ev->pa.td_bitmap_len);
 			break;
 		}
-		wdev_unlock(wdev);
 
 		kfree(ev);
 
@@ -1124,9 +1122,7 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 			return -EBUSY;
 
 		dev->ieee80211_ptr->use_4addr = false;
-		wdev_lock(dev->ieee80211_ptr);
 		rdev_set_qos_map(rdev, dev, NULL);
-		wdev_unlock(dev->ieee80211_ptr);
 
 		switch (otype) {
 		case NL80211_IFTYPE_AP:
@@ -1138,10 +1134,8 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 			break;
 		case NL80211_IFTYPE_STATION:
 		case NL80211_IFTYPE_P2P_CLIENT:
-			wdev_lock(dev->ieee80211_ptr);
 			cfg80211_disconnect(rdev, dev,
 					    WLAN_REASON_DEAUTH_LEAVING, true);
-			wdev_unlock(dev->ieee80211_ptr);
 			break;
 		case NL80211_IFTYPE_MESH_POINT:
 			/* mesh should be handled? */
@@ -2647,12 +2641,12 @@ void cfg80211_remove_link(struct wireless_dev *wdev, unsigned int link_id)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_P2P_GO:
-		__cfg80211_stop_ap(rdev, wdev->netdev, link_id, true);
+		cfg80211_stop_ap(rdev, wdev->netdev, link_id, true);
 		break;
 	default:
 		/* per-link not relevant */
@@ -2677,12 +2671,10 @@ void cfg80211_remove_links(struct wireless_dev *wdev)
 	if (wdev->iftype != NL80211_IFTYPE_AP)
 		return;
 
-	wdev_lock(wdev);
 	if (wdev->valid_links) {
 		for_each_valid_link(wdev, link_id)
 			cfg80211_remove_link(wdev, link_id);
 	}
-	wdev_unlock(wdev);
 }
 
 int cfg80211_remove_virtual_intf(struct cfg80211_registered_device *rdev,
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index e3acfac7430a..d23ce088bffa 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -415,10 +415,10 @@ int cfg80211_wext_giwretry(struct net_device *dev,
 }
 EXPORT_WEXT_HANDLER(cfg80211_wext_giwretry);
 
-static int __cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
-				     struct net_device *dev, bool pairwise,
-				     const u8 *addr, bool remove, bool tx_key,
-				     int idx, struct key_params *params)
+static int cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
+				   struct net_device *dev, bool pairwise,
+				   const u8 *addr, bool remove, bool tx_key,
+				   int idx, struct key_params *params)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	int err, i;
@@ -471,7 +471,7 @@ static int __cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 			 */
 			if (idx == wdev->wext.default_key &&
 			    wdev->iftype == NL80211_IFTYPE_ADHOC) {
-				__cfg80211_leave_ibss(rdev, wdev->netdev, true);
+				cfg80211_leave_ibss(rdev, wdev->netdev, true);
 				rejoin = true;
 			}
 
@@ -552,7 +552,7 @@ static int __cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 			 */
 			if (wdev->iftype == NL80211_IFTYPE_ADHOC &&
 			    wdev->wext.default_key == -1) {
-				__cfg80211_leave_ibss(rdev, wdev->netdev, true);
+				cfg80211_leave_ibss(rdev, wdev->netdev, true);
 				rejoin = true;
 			}
 			err = rdev_set_default_key(rdev, dev, -1, idx, true,
@@ -580,21 +580,6 @@ static int __cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
-static int cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
-				   struct net_device *dev, bool pairwise,
-				   const u8 *addr, bool remove, bool tx_key,
-				   int idx, struct key_params *params)
-{
-	int err;
-
-	wdev_lock(dev->ieee80211_ptr);
-	err = __cfg80211_set_encryption(rdev, dev, pairwise, addr,
-					remove, tx_key, idx, params);
-	wdev_unlock(dev->ieee80211_ptr);
-
-	return err;
-}
-
 static int cfg80211_wext_siwencode(struct net_device *dev,
 				   struct iw_request_info *info,
 				   union iwreq_data *wrqu, char *keybuf)
@@ -639,7 +624,6 @@ static int cfg80211_wext_siwencode(struct net_device *dev,
 	else if (erq->length == 0) {
 		/* No key data - just set the default TX key index */
 		err = 0;
-		wdev_lock(wdev);
 		if (wdev->connected ||
 		    (wdev->iftype == NL80211_IFTYPE_ADHOC &&
 		     wdev->u.ibss.current_bss))
@@ -647,7 +631,6 @@ static int cfg80211_wext_siwencode(struct net_device *dev,
 						   true);
 		if (!err)
 			wdev->wext.default_key = idx;
-		wdev_unlock(wdev);
 		goto out;
 	}
 
@@ -697,12 +680,8 @@ static int cfg80211_wext_siwencodeext(struct net_device *dev,
 	    !rdev->ops->set_default_key)
 		return -EOPNOTSUPP;
 
-	wdev_lock(wdev);
-	if (wdev->valid_links) {
-		wdev_unlock(wdev);
+	if (wdev->valid_links)
 		return -EOPNOTSUPP;
-	}
-	wdev_unlock(wdev);
 
 	switch (ext->alg) {
 	case IW_ENCODE_ALG_NONE:
@@ -1341,13 +1320,11 @@ static int cfg80211_wext_giwrate(struct net_device *dev,
 		return -EOPNOTSUPP;
 
 	err = 0;
-	wdev_lock(wdev);
 	if (!wdev->valid_links && wdev->links[0].client.current_bss)
 		memcpy(addr, wdev->links[0].client.current_bss->pub.bssid,
 		       ETH_ALEN);
 	else
 		err = -EOPNOTSUPP;
-	wdev_unlock(wdev);
 	if (err)
 		return err;
 
@@ -1387,17 +1364,15 @@ static struct iw_statistics *cfg80211_wireless_stats(struct net_device *dev)
 		return NULL;
 
 	/* Grab BSSID of current BSS, if any */
-	wdev_lock(wdev);
+	wiphy_lock(&rdev->wiphy);
 	if (wdev->valid_links || !wdev->links[0].client.current_bss) {
-		wdev_unlock(wdev);
+		wiphy_unlock(&rdev->wiphy);
 		return NULL;
 	}
 	memcpy(bssid, wdev->links[0].client.current_bss->pub.bssid, ETH_ALEN);
-	wdev_unlock(wdev);
 
 	memset(&sinfo, 0, sizeof(sinfo));
 
-	wiphy_lock(&rdev->wiphy);
 	ret = rdev_get_station(rdev, dev, bssid, &sinfo);
 	wiphy_unlock(&rdev->wiphy);
 
diff --git a/net/wireless/wext-sme.c b/net/wireless/wext-sme.c
index f3eaa3388694..8edd9ada69d0 100644
--- a/net/wireless/wext-sme.c
+++ b/net/wireless/wext-sme.c
@@ -23,7 +23,7 @@ int cfg80211_mgd_wext_connect(struct cfg80211_registered_device *rdev,
 	int err, i;
 
 	ASSERT_RTNL();
-	ASSERT_WDEV_LOCK(wdev);
+	lockdep_assert_wiphy(wdev->wiphy);
 
 	if (!netif_running(wdev->netdev))
 		return 0;
@@ -87,15 +87,11 @@ int cfg80211_mgd_wext_siwfreq(struct net_device *dev,
 			return -EINVAL;
 	}
 
-	wdev_lock(wdev);
-
 	if (wdev->conn) {
 		bool event = true;
 
-		if (wdev->wext.connect.channel == chan) {
-			err = 0;
-			goto out;
-		}
+		if (wdev->wext.connect.channel == chan)
+			return 0;
 
 		/* if SSID set, we'll try right again, avoid event */
 		if (wdev->wext.connect.ssid_len)
@@ -103,14 +99,11 @@ int cfg80211_mgd_wext_siwfreq(struct net_device *dev,
 		err = cfg80211_disconnect(rdev, dev,
 					  WLAN_REASON_DEAUTH_LEAVING, event);
 		if (err)
-			goto out;
+			return err;
 	}
 
 	wdev->wext.connect.channel = chan;
-	err = cfg80211_mgd_wext_connect(rdev, wdev);
- out:
-	wdev_unlock(wdev);
-	return err;
+	return cfg80211_mgd_wext_connect(rdev, wdev);
 }
 
 int cfg80211_mgd_wext_giwfreq(struct net_device *dev,
@@ -127,12 +120,10 @@ int cfg80211_mgd_wext_giwfreq(struct net_device *dev,
 	if (wdev->valid_links)
 		return -EOPNOTSUPP;
 
-	wdev_lock(wdev);
 	if (wdev->links[0].client.current_bss)
 		chan = wdev->links[0].client.current_bss->pub.channel;
 	else if (wdev->wext.connect.channel)
 		chan = wdev->wext.connect.channel;
-	wdev_unlock(wdev);
 
 	if (chan) {
 		freq->m = chan->center_freq;
@@ -164,17 +155,13 @@ int cfg80211_mgd_wext_siwessid(struct net_device *dev,
 	if (len > 0 && ssid[len - 1] == '\0')
 		len--;
 
-	wdev_lock(wdev);
-
-	err = 0;
-
 	if (wdev->conn) {
 		bool event = true;
 
 		if (wdev->wext.connect.ssid && len &&
 		    len == wdev->wext.connect.ssid_len &&
 		    memcmp(wdev->wext.connect.ssid, ssid, len) == 0)
-			goto out;
+			return 0;
 
 		/* if SSID set now, we'll try to connect, avoid event */
 		if (len)
@@ -182,7 +169,7 @@ int cfg80211_mgd_wext_siwessid(struct net_device *dev,
 		err = cfg80211_disconnect(rdev, dev,
 					  WLAN_REASON_DEAUTH_LEAVING, event);
 		if (err)
-			goto out;
+			return err;
 	}
 
 	wdev->wext.prev_bssid_valid = false;
@@ -194,10 +181,7 @@ int cfg80211_mgd_wext_siwessid(struct net_device *dev,
 	wdev->wext.connect.crypto.control_port_ethertype =
 					cpu_to_be16(ETH_P_PAE);
 
-	err = cfg80211_mgd_wext_connect(rdev, wdev);
- out:
-	wdev_unlock(wdev);
-	return err;
+	return cfg80211_mgd_wext_connect(rdev, wdev);
 }
 
 int cfg80211_mgd_wext_giwessid(struct net_device *dev,
@@ -216,7 +200,6 @@ int cfg80211_mgd_wext_giwessid(struct net_device *dev,
 
 	data->flags = 0;
 
-	wdev_lock(wdev);
 	if (wdev->links[0].client.current_bss) {
 		const struct element *ssid_elem;
 
@@ -238,7 +221,6 @@ int cfg80211_mgd_wext_giwessid(struct net_device *dev,
 		data->length = wdev->wext.connect.ssid_len;
 		memcpy(ssid, wdev->wext.connect.ssid, data->length);
 	}
-	wdev_unlock(wdev);
 
 	return ret;
 }
@@ -263,23 +245,20 @@ int cfg80211_mgd_wext_siwap(struct net_device *dev,
 	if (is_zero_ether_addr(bssid) || is_broadcast_ether_addr(bssid))
 		bssid = NULL;
 
-	wdev_lock(wdev);
-
 	if (wdev->conn) {
-		err = 0;
 		/* both automatic */
 		if (!bssid && !wdev->wext.connect.bssid)
-			goto out;
+			return 0;
 
 		/* fixed already - and no change */
 		if (wdev->wext.connect.bssid && bssid &&
 		    ether_addr_equal(bssid, wdev->wext.connect.bssid))
-			goto out;
+			return 0;
 
 		err = cfg80211_disconnect(rdev, dev,
 					  WLAN_REASON_DEAUTH_LEAVING, false);
 		if (err)
-			goto out;
+			return err;
 	}
 
 	if (bssid) {
@@ -288,10 +267,7 @@ int cfg80211_mgd_wext_siwap(struct net_device *dev,
 	} else
 		wdev->wext.connect.bssid = NULL;
 
-	err = cfg80211_mgd_wext_connect(rdev, wdev);
- out:
-	wdev_unlock(wdev);
-	return err;
+	return cfg80211_mgd_wext_connect(rdev, wdev);
 }
 
 int cfg80211_mgd_wext_giwap(struct net_device *dev,
@@ -306,18 +282,15 @@ int cfg80211_mgd_wext_giwap(struct net_device *dev,
 
 	ap_addr->sa_family = ARPHRD_ETHER;
 
-	wdev_lock(wdev);
-	if (wdev->valid_links) {
-		wdev_unlock(wdev);
+	if (wdev->valid_links)
 		return -EOPNOTSUPP;
-	}
+
 	if (wdev->links[0].client.current_bss)
 		memcpy(ap_addr->sa_data,
 		       wdev->links[0].client.current_bss->pub.bssid,
 		       ETH_ALEN);
 	else
 		eth_zero_addr(ap_addr->sa_data);
-	wdev_unlock(wdev);
 
 	return 0;
 }
@@ -339,7 +312,6 @@ int cfg80211_wext_siwgenie(struct net_device *dev,
 		ie = NULL;
 
 	wiphy_lock(wdev->wiphy);
-	wdev_lock(wdev);
 
 	/* no change */
 	err = 0;
@@ -370,7 +342,6 @@ int cfg80211_wext_siwgenie(struct net_device *dev,
 	/* userspace better not think we'll reconnect */
 	err = 0;
  out:
-	wdev_unlock(wdev);
 	wiphy_unlock(wdev->wiphy);
 	return err;
 }
@@ -396,7 +367,6 @@ int cfg80211_wext_siwmlme(struct net_device *dev,
 		return -EINVAL;
 
 	wiphy_lock(&rdev->wiphy);
-	wdev_lock(wdev);
 	switch (mlme->cmd) {
 	case IW_MLME_DEAUTH:
 	case IW_MLME_DISASSOC:
@@ -406,7 +376,6 @@ int cfg80211_wext_siwmlme(struct net_device *dev,
 		err = -EOPNOTSUPP;
 		break;
 	}
-	wdev_unlock(wdev);
 	wiphy_unlock(&rdev->wiphy);
 
 	return err;
-- 
2.41.0

