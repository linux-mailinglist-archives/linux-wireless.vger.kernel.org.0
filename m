Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8262470E0
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Aug 2020 20:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390715AbgHQSQX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Aug 2020 14:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388384AbgHQQFw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Aug 2020 12:05:52 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F19C061389
        for <linux-wireless@vger.kernel.org>; Mon, 17 Aug 2020 09:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=W1hONAIxDjltce1Ky6QkC5vEO6lJ2pVL9C4d8ewI0Hk=; b=abPUOf4bY+mez2AfdoHhw+85ue
        SPqmayzRwJfO9dscwZhvmQfCIMMQLa9K2wJvIWBLRJeuRCxqHGmzDu0RtTtJsgSBzeTwbSJs1DKvF
        TWnIOE0jRDRzW5HlekBwnG5awsObQtgBcqxbWvuYf0qIbWsY1HRpIZTg9K2kkEZ9Ka60=;
Received: from p54ae996c.dip0.t-ipconnect.de ([84.174.153.108] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k7hdO-0004Gg-Rx; Mon, 17 Aug 2020 18:05:19 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 1/7] mac80211: rework tx encapsulation offload API
Date:   Mon, 17 Aug 2020 18:05:11 +0200
Message-Id: <20200817160517.94564-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The current API (which lets the driver turn on/off per vif directly) has a
number of limitations:
- it does not deal with AP_VLAN
- conditions for enabling (no tkip, no monitor) are only checked at
  add_interface time
- no way to indicate 4-addr support

In order to address this, store offload flags in struct ieee80211_vif
(easy to extend for decap offload later). mac80211 initially sets the enable
flag, but gives the driver a chance to modify it before its settings are
applied. In addition to the .add_interface op, a .update_vif_offload op is
introduced, which can be used for runtime changes.

If a driver can't disable encap offload at runtime, or if it has some extra
limitations, it can simply override the flags within those ops.

Support for encap offload with 4-address mode interfaces can be enabled
by setting a flag from .add_interface or .update_vif_offload.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/ath/ath11k/mac.c |  57 ++++----
 include/net/mac80211.h                |  29 ++++
 net/mac80211/cfg.c                    |   5 +
 net/mac80211/debugfs.c                |   1 +
 net/mac80211/driver-ops.h             |  15 ++
 net/mac80211/ieee80211_i.h            |   3 +-
 net/mac80211/iface.c                  | 201 +++++++++++++++++++-------
 net/mac80211/key.c                    |  23 +--
 net/mac80211/trace.h                  |   6 +
 net/mac80211/tx.c                     |   5 -
 10 files changed, 242 insertions(+), 103 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 94ae2b9ea663..c100ac6298ce 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4304,6 +4304,35 @@ static int ath11k_set_he_mu_sounding_mode(struct ath11k *ar,
 	return ret;
 }
 
+static void ath11k_mac_op_update_vif_offload(struct ieee80211_hw *hw,
+					    struct ieee80211_vif *vif)
+{
+	struct ath11k *ar = hw->priv;
+	struct ath11k_base *ab = ar->ab;
+	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
+	u32 param_id, param_value;
+	int ret;
+
+	param_id = WMI_VDEV_PARAM_TX_ENCAP_TYPE;
+	if (ath11k_frame_mode != ATH11K_HW_TXRX_ETHERNET ||
+	    (vif->type != NL80211_IFTYPE_STATION &&
+	     vif->type != NL80211_IFTYPE_AP))
+		vif->offload_flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
+
+	if (vif->offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED)
+		param_value = ATH11K_HW_TXRX_ETHERNET;
+	else
+		param_value = ATH11K_HW_TXRX_NATIVE_WIFI;
+
+	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+					    param_id, param_value);
+	if (ret) {
+		ath11k_warn(ab, "failed to set vdev %d tx encap mode: %d\n",
+			    arvif->vdev_id, ret);
+		vif->offload_flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
+	}
+}
+
 static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif)
 {
@@ -4313,7 +4342,6 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	struct vdev_create_params vdev_param = {0};
 	struct peer_create_params peer_param;
 	u32 param_id, param_value;
-	int hw_encap = 0;
 	u16 nss;
 	int i;
 	int ret;
@@ -4407,30 +4435,7 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	list_add(&arvif->list, &ar->arvifs);
 	spin_unlock_bh(&ar->data_lock);
 
-	param_id = WMI_VDEV_PARAM_TX_ENCAP_TYPE;
-	if (ath11k_frame_mode == ATH11K_HW_TXRX_ETHERNET)
-		switch (vif->type) {
-		case NL80211_IFTYPE_STATION:
-		case NL80211_IFTYPE_AP_VLAN:
-		case NL80211_IFTYPE_AP:
-			hw_encap = 1;
-			break;
-		default:
-			break;
-		}
-
-	if (ieee80211_set_hw_80211_encap(vif, hw_encap))
-		param_value = ATH11K_HW_TXRX_ETHERNET;
-	else
-		param_value = ATH11K_HW_TXRX_NATIVE_WIFI;
-
-	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
-					    param_id, param_value);
-	if (ret) {
-		ath11k_warn(ab, "failed to set vdev %d tx encap mode: %d\n",
-			    arvif->vdev_id, ret);
-		goto err_vdev_del;
-	}
+	ath11k_mac_op_update_vif_offload(hw, vif);
 
 	nss = get_num_chains(ar->cfg_tx_chainmask) ? : 1;
 	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
@@ -5753,6 +5758,7 @@ static const struct ieee80211_ops ath11k_ops = {
 	.reconfig_complete              = ath11k_mac_op_reconfig_complete,
 	.add_interface                  = ath11k_mac_op_add_interface,
 	.remove_interface		= ath11k_mac_op_remove_interface,
+	.update_vif_offload		= ath11k_mac_op_update_vif_offload,
 	.config                         = ath11k_mac_op_config,
 	.bss_info_changed               = ath11k_mac_op_bss_info_changed,
 	.configure_filter		= ath11k_mac_op_configure_filter,
@@ -6034,6 +6040,7 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	ieee80211_hw_set(ar->hw, QUEUE_CONTROL);
 	ieee80211_hw_set(ar->hw, SUPPORTS_TX_FRAG);
 	ieee80211_hw_set(ar->hw, REPORTS_LOW_ACK);
+	ieee80211_hw_set(ar->hw, SUPPORTS_TX_ENCAP_OFFLOAD);
 	if (ht_cap & WMI_HT_CAP_ENABLED) {
 		ieee80211_hw_set(ar->hw, AMPDU_AGGREGATION);
 		ieee80211_hw_set(ar->hw, TX_AMPDU_SETUP_IN_HW);
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 66e2bfd165e8..d635f530300d 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1606,6 +1606,21 @@ enum ieee80211_vif_flags {
 	IEEE80211_VIF_GET_NOA_UPDATE		= BIT(3),
 };
 
+
+/**
+ * enum ieee80211_offload_flags - virtual interface offload flags
+ *
+ * @IEEE80211_OFFLOAD_ENCAP_ENABLED: tx encapsulation offload is enabled
+ *	The driver supports sending frames passed as 802.3 frames by mac80211.
+ *	It must also support sending 802.11 packets for the same interface.
+ * @IEEE80211_OFFLOAD_ENCAP_4ADDR: support 4-address mode encapsulation offload
+ */
+
+enum ieee80211_offload_flags {
+	IEEE80211_OFFLOAD_ENCAP_ENABLED		= BIT(0),
+	IEEE80211_OFFLOAD_ENCAP_4ADDR		= BIT(1),
+};
+
 /**
  * struct ieee80211_vif - per-interface data
  *
@@ -1626,6 +1641,11 @@ enum ieee80211_vif_flags {
  *	these need to be set (or cleared) when the interface is added
  *	or, if supported by the driver, the interface type is changed
  *	at runtime, mac80211 will never touch this field
+ * @offloaad_flags: hardware offload capabilities/flags for this interface.
+ *	These are initialized by mac80211 before calling .add_interface,
+ *	.change_interface or .update_vif_offload and updated by the driver
+ *	within these ops, based on supported features or runtime change
+ *	restrictions.
  * @hw_queue: hardware queue for each AC
  * @cab_queue: content-after-beacon (DTIM beacon really) queue, AP mode only
  * @chanctx_conf: The channel context this interface is assigned to, or %NULL
@@ -1662,6 +1682,7 @@ struct ieee80211_vif {
 	struct ieee80211_chanctx_conf __rcu *chanctx_conf;
 
 	u32 driver_flags;
+	u32 offload_flags;
 
 #ifdef CONFIG_MAC80211_DEBUGFS
 	struct dentry *debugfs_dir;
@@ -2328,6 +2349,9 @@ struct ieee80211_txq {
  *	aggregating MPDUs with the same keyid, allowing mac80211 to keep Tx
  *	A-MPDU sessions active while rekeying with Extended Key ID.
  *
+ * @IEEE80211_HW_SUPPORTS_TX_ENCAP_OFFLOAD: Hardware supports tx encapsulation
+ *	offload
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2380,6 +2404,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_SUPPORTS_MULTI_BSSID,
 	IEEE80211_HW_SUPPORTS_ONLY_HE_MULTI_BSSID,
 	IEEE80211_HW_AMPDU_KEYBORDER_SUPPORT,
+	IEEE80211_HW_SUPPORTS_TX_ENCAP_OFFLOAD,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
@@ -3814,6 +3839,8 @@ enum ieee80211_reconfig_type {
  * @set_tid_config: Apply TID specific configurations. This callback may sleep.
  * @reset_tid_config: Reset TID specific configuration for the peer.
  *	This callback may sleep.
+ * @update_vif_config: Update virtual interface offload flags
+ *	This callback may sleep.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -4125,6 +4152,8 @@ struct ieee80211_ops {
 	int (*reset_tid_config)(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta, u8 tids);
+	void (*update_vif_offload)(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif);
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 87fddd84c621..ea6f4d83f529 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -504,6 +504,7 @@ static int ieee80211_del_key(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_local *local = sdata->local;
 	struct sta_info *sta;
 	struct ieee80211_key *key = NULL;
+	bool recalc_offload = false;
 	int ret;
 
 	mutex_lock(&local->sta_mtx);
@@ -528,6 +529,7 @@ static int ieee80211_del_key(struct wiphy *wiphy, struct net_device *dev,
 		goto out_unlock;
 	}
 
+	recalc_offload = key->conf.cipher == WLAN_CIPHER_SUITE_TKIP;
 	ieee80211_key_free(key, sdata->vif.type == NL80211_IFTYPE_STATION);
 
 	ret = 0;
@@ -535,6 +537,9 @@ static int ieee80211_del_key(struct wiphy *wiphy, struct net_device *dev,
 	mutex_unlock(&local->key_mtx);
 	mutex_unlock(&local->sta_mtx);
 
+	if (recalc_offload)
+		ieee80211_recalc_offload(local);
+
 	return ret;
 }
 
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 54080290d6e2..90470392fdaa 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -408,6 +408,7 @@ static const char *hw_flag_names[] = {
 	FLAG(SUPPORTS_MULTI_BSSID),
 	FLAG(SUPPORTS_ONLY_HE_MULTI_BSSID),
 	FLAG(AMPDU_KEYBORDER_SUPPORT),
+	FLAG(SUPPORTS_TX_ENCAP_OFFLOAD),
 #undef FLAG
 };
 
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 41d495d73d3a..e3dfb9307fae 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1384,4 +1384,19 @@ static inline int drv_reset_tid_config(struct ieee80211_local *local,
 
 	return ret;
 }
+
+static inline void drv_update_vif_offload(struct ieee80211_local *local,
+					  struct ieee80211_sub_if_data *sdata)
+{
+	might_sleep();
+	check_sdata_in_driver(sdata);
+
+	if (!local->ops->update_vif_offload)
+		return;
+
+	trace_drv_update_vif_offload(local, sdata);
+	local->ops->update_vif_offload(&local->hw, &sdata->vif);
+	trace_drv_return_void(local);
+}
+
 #endif /* __MAC80211_DRIVER_OPS */
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 0b1eaec6649f..b6fb85ff3ce4 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -989,8 +989,6 @@ struct ieee80211_sub_if_data {
 	} debugfs;
 #endif
 
-	bool hw_80211_encap;
-
 	/* must be last, dynamically sized area in this! */
 	struct ieee80211_vif vif;
 };
@@ -1767,6 +1765,7 @@ void ieee80211_del_virtual_monitor(struct ieee80211_local *local);
 bool __ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata);
 void ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata,
 			      bool update_bss);
+void ieee80211_recalc_offload(struct ieee80211_local *local);
 
 static inline bool ieee80211_sdata_running(struct ieee80211_sub_if_data *sdata)
 {
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 9740ae8fa697..e48038a5d629 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -43,6 +43,7 @@
  */
 
 static void ieee80211_iface_work(struct work_struct *work);
+static void ieee80211_set_vif_encap_ops(struct ieee80211_sub_if_data *sdata);
 
 bool __ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata)
 {
@@ -348,6 +349,99 @@ static int ieee80211_check_queues(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+static bool ieee80211_iftype_supports_encap_offload(enum nl80211_iftype iftype)
+{
+	switch (iftype) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+	case NL80211_IFTYPE_P2P_CLIENT:
+	case NL80211_IFTYPE_STATION:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool ieee80211_set_sdata_offload_flags(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_key *key;
+	u32 flags;
+
+	flags = sdata->vif.offload_flags;
+
+	if (ieee80211_hw_check(&local->hw, SUPPORTS_TX_ENCAP_OFFLOAD) &&
+	    ieee80211_iftype_supports_encap_offload(sdata->vif.type)) {
+		flags |= IEEE80211_OFFLOAD_ENCAP_ENABLED;
+		mutex_lock(&local->key_mtx);
+		list_for_each_entry(key, &sdata->key_list, list) {
+			if (key->conf.cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
+			    key->conf.cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
+			    key->conf.cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256 ||
+			    key->conf.cipher == WLAN_CIPHER_SUITE_BIP_CMAC_256)
+				continue;
+			if (key->conf.cipher == WLAN_CIPHER_SUITE_TKIP ||
+			    !(key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE))
+				flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
+		}
+		mutex_unlock(&local->key_mtx);
+
+		if (!ieee80211_hw_check(&local->hw, SUPPORTS_TX_FRAG) &&
+		    local->hw.wiphy->frag_threshold != (u32)-1)
+			flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
+
+		if (local->monitors)
+			flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
+	} else {
+		flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
+	}
+
+	if (sdata->vif.offload_flags == flags)
+		return false;
+
+	sdata->vif.offload_flags = flags;
+	return true;
+}
+
+
+static void ieee80211_recalc_sdata_offload(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_sub_if_data *vsdata;
+
+	if (ieee80211_set_sdata_offload_flags(sdata)) {
+		drv_update_vif_offload(local, sdata);
+		ieee80211_set_vif_encap_ops(sdata);
+	}
+
+	list_for_each_entry(vsdata, &local->interfaces, list) {
+		if (vsdata->vif.type != NL80211_IFTYPE_AP_VLAN ||
+		    vsdata->bss != &sdata->u.ap)
+			continue;
+
+		ieee80211_set_vif_encap_ops(vsdata);
+	}
+}
+
+void ieee80211_recalc_offload(struct ieee80211_local *local)
+{
+	struct ieee80211_sub_if_data *sdata;
+
+	if (!ieee80211_hw_check(&local->hw, SUPPORTS_TX_ENCAP_OFFLOAD))
+		return;
+
+	mutex_lock(&local->iflist_mtx);
+
+	list_for_each_entry(sdata, &local->interfaces, list) {
+		if (!ieee80211_sdata_running(sdata))
+			continue;
+
+		ieee80211_recalc_sdata_offload(sdata);
+	}
+
+	mutex_unlock(&local->iflist_mtx);
+}
+
 void ieee80211_adjust_monitor_flags(struct ieee80211_sub_if_data *sdata,
 				    const int offset)
 {
@@ -616,6 +710,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 
 		ieee80211_adjust_monitor_flags(sdata, 1);
 		ieee80211_configure_filter(local);
+		ieee80211_recalc_offload(local);
 		mutex_lock(&local->mtx);
 		ieee80211_recalc_idle(local);
 		mutex_unlock(&local->mtx);
@@ -625,10 +720,13 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 	default:
 		if (coming_up) {
 			ieee80211_del_virtual_monitor(local);
+			ieee80211_set_sdata_offload_flags(sdata);
 
 			res = drv_add_interface(local, sdata);
 			if (res)
 				goto err_stop;
+
+			ieee80211_set_vif_encap_ops(sdata);
 			res = ieee80211_check_queues(sdata,
 				ieee80211_vif_type_p2p(&sdata->vif));
 			if (res)
@@ -1227,61 +1325,6 @@ static const struct net_device_ops ieee80211_dataif_8023_ops = {
 	.ndo_get_stats64	= ieee80211_get_stats64,
 };
 
-static void __ieee80211_set_hw_80211_encap(struct ieee80211_sub_if_data *sdata,
-					   bool enable)
-{
-	sdata->dev->netdev_ops = enable ? &ieee80211_dataif_8023_ops :
-					  &ieee80211_dataif_ops;
-	sdata->hw_80211_encap = enable;
-}
-
-bool ieee80211_set_hw_80211_encap(struct ieee80211_vif *vif, bool enable)
-{
-	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
-	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_sub_if_data *iter;
-	struct ieee80211_key *key;
-
-	mutex_lock(&local->iflist_mtx);
-	list_for_each_entry(iter, &local->interfaces, list) {
-		struct ieee80211_sub_if_data *disable = NULL;
-
-		if (vif->type == NL80211_IFTYPE_MONITOR) {
-			disable = iter;
-			__ieee80211_set_hw_80211_encap(iter, false);
-		} else if (iter->vif.type == NL80211_IFTYPE_MONITOR) {
-			disable = sdata;
-			enable = false;
-		}
-		if (disable)
-			sdata_dbg(disable,
-				  "disable hw 80211 encap due to mon co-exist\n");
-	}
-	mutex_unlock(&local->iflist_mtx);
-
-	if (enable == sdata->hw_80211_encap)
-		return enable;
-
-	if (!sdata->dev)
-		return false;
-
-	if (!ieee80211_hw_check(&local->hw, SUPPORTS_TX_FRAG) &&
-	    (local->hw.wiphy->frag_threshold != (u32)-1))
-		enable = false;
-
-	mutex_lock(&sdata->local->key_mtx);
-	list_for_each_entry(key, &sdata->key_list, list) {
-		if (key->conf.cipher == WLAN_CIPHER_SUITE_TKIP)
-			enable = false;
-	}
-	mutex_unlock(&sdata->local->key_mtx);
-
-	__ieee80211_set_hw_80211_encap(sdata, enable);
-
-	return enable;
-}
-EXPORT_SYMBOL(ieee80211_set_hw_80211_encap);
-
 static void ieee80211_if_free(struct net_device *dev)
 {
 	free_percpu(dev->tstats);
@@ -1302,6 +1345,51 @@ static void ieee80211_if_setup_no_queue(struct net_device *dev)
 	dev->priv_flags |= IFF_NO_QUEUE;
 }
 
+static void ieee80211_set_vif_encap_ops(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_sub_if_data *bss = sdata;
+	struct ieee80211_key *key;
+	bool enabled;
+
+	if (!ieee80211_hw_check(&local->hw, SUPPORTS_TX_ENCAP_OFFLOAD) ||
+	    !ieee80211_iftype_supports_encap_offload(sdata->vif.type))
+		return;
+
+	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
+		if (!sdata->bss)
+			return;
+
+		bss = container_of(sdata->bss, struct ieee80211_sub_if_data, u.ap);
+	}
+
+	enabled = bss->vif.offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED;
+	if (sdata->wdev.use_4addr &&
+	    !(bss->vif.offload_flags & IEEE80211_OFFLOAD_ENCAP_4ADDR))
+		enabled = false;
+
+	/*
+	 * Encapsulation offload cannot be used with software crypto, and a per-VLAN
+	 * key may have been set
+	 */
+	if (enabled && sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
+		mutex_lock(&local->key_mtx);
+		list_for_each_entry(key, &sdata->key_list, list) {
+			if (key->conf.cipher == WLAN_CIPHER_SUITE_AES_CMAC ||
+			    key->conf.cipher == WLAN_CIPHER_SUITE_BIP_GMAC_128 ||
+			    key->conf.cipher == WLAN_CIPHER_SUITE_BIP_GMAC_256 ||
+			    key->conf.cipher == WLAN_CIPHER_SUITE_BIP_CMAC_256)
+				continue;
+			if (!(key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE))
+				enabled = false;
+		}
+		mutex_unlock(&local->key_mtx);
+	}
+
+	sdata->dev->netdev_ops = enabled ? &ieee80211_dataif_8023_ops :
+					   &ieee80211_dataif_ops;
+}
+
 static void ieee80211_iface_work(struct work_struct *work)
 {
 	struct ieee80211_sub_if_data *sdata =
@@ -1484,7 +1572,6 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	sdata->vif.bss_conf.txpower = INT_MIN; /* unset */
 
 	sdata->noack_map = 0;
-	sdata->hw_80211_encap = false;
 
 	/* only monitor/p2p-device differ */
 	if (sdata->dev) {
@@ -1619,6 +1706,7 @@ static int ieee80211_runtime_change_iftype(struct ieee80211_sub_if_data *sdata,
 
 	ieee80211_teardown_sdata(sdata);
 
+	ieee80211_set_sdata_offload_flags(sdata);
 	ret = drv_change_interface(local, sdata, internal_type, p2p);
 	if (ret)
 		type = ieee80211_vif_type_p2p(&sdata->vif);
@@ -1631,6 +1719,7 @@ static int ieee80211_runtime_change_iftype(struct ieee80211_sub_if_data *sdata,
 	ieee80211_check_queues(sdata, type);
 
 	ieee80211_setup_sdata(sdata, type);
+	ieee80211_set_vif_encap_ops(sdata);
 
 	err = ieee80211_do_open(&sdata->wdev, false);
 	WARN(err, "type change: do_open returned %d", err);
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 2df636c32432..cef210ad07d6 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -177,13 +177,6 @@ static int ieee80211_key_enable_hw_accel(struct ieee80211_key *key)
 		}
 	}
 
-	/* TKIP countermeasures don't work in encap offload mode */
-	if (key->conf.cipher == WLAN_CIPHER_SUITE_TKIP &&
-	    sdata->hw_80211_encap) {
-		sdata_dbg(sdata, "TKIP is not allowed in hw 80211 encap mode\n");
-		return -EINVAL;
-	}
-
 	ret = drv_set_key(key->local, SET_KEY, sdata,
 			  sta ? &sta->sta : NULL, &key->conf);
 
@@ -219,14 +212,6 @@ static int ieee80211_key_enable_hw_accel(struct ieee80211_key *key)
 	case WLAN_CIPHER_SUITE_CCMP_256:
 	case WLAN_CIPHER_SUITE_GCMP:
 	case WLAN_CIPHER_SUITE_GCMP_256:
-		/* We cannot do software crypto of data frames with
-		 * encapsulation offload enabled. However for 802.11w to
-		 * function properly we need cmac/gmac keys.
-		 */
-		if (sdata->hw_80211_encap)
-			return -EINVAL;
-		fallthrough;
-
 	case WLAN_CIPHER_SUITE_AES_CMAC:
 	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
@@ -824,6 +809,7 @@ int ieee80211_key_link(struct ieee80211_key *key,
 	 */
 	bool delay_tailroom = sdata->vif.type == NL80211_IFTYPE_STATION;
 	int ret = -EOPNOTSUPP;
+	bool recalc_offload = false;
 
 	mutex_lock(&sdata->local->key_mtx);
 
@@ -864,11 +850,15 @@ int ieee80211_key_link(struct ieee80211_key *key,
 	key->local = sdata->local;
 	key->sdata = sdata;
 	key->sta = sta;
+	recalc_offload = !old_key && key->conf.cipher == WLAN_CIPHER_SUITE_TKIP;
 
 	increment_tailroom_need_count(sdata);
 
 	ret = ieee80211_key_replace(sdata, sta, pairwise, old_key, key);
 
+	if (!(key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE))
+		recalc_offload = true;
+
 	if (!ret) {
 		ieee80211_debugfs_key_add(key);
 		ieee80211_key_destroy(old_key, delay_tailroom);
@@ -879,6 +869,9 @@ int ieee80211_key_link(struct ieee80211_key *key,
  out:
 	mutex_unlock(&sdata->local->key_mtx);
 
+	if (recalc_offload)
+		ieee80211_recalc_offload(sdata->local);
+
 	return ret;
 }
 
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 50ab5b9d8eab..50a0a83e96fc 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -2734,6 +2734,12 @@ TRACE_EVENT(drv_get_ftm_responder_stats,
 	)
 );
 
+DEFINE_EVENT(local_sdata_addr_evt, drv_update_vif_offload,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata),
+	TP_ARGS(local, sdata)
+);
+
 #endif /* !__MAC80211_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index dca01d7e6e3e..607dd1e97274 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4273,11 +4273,6 @@ netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct sta_info *sta;
 
-	if (WARN_ON(!sdata->hw_80211_encap)) {
-		kfree_skb(skb);
-		return NETDEV_TX_OK;
-	}
-
 	if (unlikely(skb->len < ETH_HLEN)) {
 		kfree_skb(skb);
 		return NETDEV_TX_OK;
-- 
2.28.0

