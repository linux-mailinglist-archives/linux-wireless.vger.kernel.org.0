Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF56261D74
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 21:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731706AbgIHThQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 15:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730980AbgIHP47 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 11:56:59 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E83C061366
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 05:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=YpJ5b4/uraq5f4jo03aHFyeSgJXJ8Br4HO7rkRmQOJY=; b=Qj5S6aa5furv0sEl7Qizwqll6k
        UloeUQJ5mgIeDh6z5nDa5NK9yEKT6cO3l/+5O7fTdBjPEdBAQBBm2lXoVSIzUfw/0cVZ9SUmJIBc7
        9BHV6k/aMExOPKyNpNvdTwoXVKJT7LNGXLsVgjHpbzPFQQcI9+FiWqZMDo4sVKy/WIvE=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kFcrx-00050i-D4; Tue, 08 Sep 2020 14:37:05 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v4 05/14] mac80211: rework tx encapsulation offload API
Date:   Tue,  8 Sep 2020 14:36:53 +0200
Message-Id: <20200908123702.88454-6-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908123702.88454-1-nbd@nbd.name>
References: <20200908123702.88454-1-nbd@nbd.name>
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
 drivers/net/wireless/ath/ath11k/mac.c |  57 +++++----
 include/net/mac80211.h                |  29 +++++
 net/mac80211/debugfs.c                |   1 +
 net/mac80211/driver-ops.h             |  15 +++
 net/mac80211/ieee80211_i.h            |   3 +-
 net/mac80211/iface.c                  | 169 +++++++++++++++++---------
 net/mac80211/key.c                    |  15 ---
 net/mac80211/trace.h                  |   6 +
 net/mac80211/tx.c                     |  34 +++---
 9 files changed, 217 insertions(+), 112 deletions(-)

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
index ec148b3e9c41..01612a82aacf 100644
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
index 6bf879660a93..79e538700edc 100644
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
index 9740ae8fa697..02bb94de7bde 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -43,6 +43,7 @@
  */
 
 static void ieee80211_iface_work(struct work_struct *work);
+static void ieee80211_set_vif_encap_ops(struct ieee80211_sub_if_data *sdata);
 
 bool __ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata)
 {
@@ -348,6 +349,85 @@ static int ieee80211_check_queues(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+static bool ieee80211_iftype_supports_encap_offload(enum nl80211_iftype iftype)
+{
+	switch (iftype) {
+	/* P2P GO and client are mapped to AP/STATION types */
+	case NL80211_IFTYPE_AP:
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
+	u32 flags;
+
+	flags = sdata->vif.offload_flags;
+
+	if (ieee80211_hw_check(&local->hw, SUPPORTS_TX_ENCAP_OFFLOAD) &&
+	    ieee80211_iftype_supports_encap_offload(sdata->vif.type)) {
+		flags |= IEEE80211_OFFLOAD_ENCAP_ENABLED;
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
@@ -587,6 +667,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		if (rtnl_dereference(sdata->bss->beacon)) {
 			ieee80211_vif_vlan_copy_chanctx(sdata);
 			netif_carrier_on(dev);
+			ieee80211_set_vif_encap_ops(sdata);
 		} else {
 			netif_carrier_off(dev);
 		}
@@ -616,6 +697,7 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 
 		ieee80211_adjust_monitor_flags(sdata, 1);
 		ieee80211_configure_filter(local);
+		ieee80211_recalc_offload(local);
 		mutex_lock(&local->mtx);
 		ieee80211_recalc_idle(local);
 		mutex_unlock(&local->mtx);
@@ -625,10 +707,13 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
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
@@ -1227,61 +1312,6 @@ static const struct net_device_ops ieee80211_dataif_8023_ops = {
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
@@ -1302,6 +1332,32 @@ static void ieee80211_if_setup_no_queue(struct net_device *dev)
 	dev->priv_flags |= IFF_NO_QUEUE;
 }
 
+static void ieee80211_set_vif_encap_ops(struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_sub_if_data *bss = sdata;
+	bool enabled;
+
+	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
+		if (!sdata->bss)
+			return;
+
+		bss = container_of(sdata->bss, struct ieee80211_sub_if_data, u.ap);
+	}
+
+	if (!ieee80211_hw_check(&local->hw, SUPPORTS_TX_ENCAP_OFFLOAD) ||
+	    !ieee80211_iftype_supports_encap_offload(bss->vif.type))
+		return;
+
+	enabled = bss->vif.offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED;
+	if (sdata->wdev.use_4addr &&
+	    !(bss->vif.offload_flags & IEEE80211_OFFLOAD_ENCAP_4ADDR))
+		enabled = false;
+
+	sdata->dev->netdev_ops = enabled ? &ieee80211_dataif_8023_ops :
+					   &ieee80211_dataif_ops;
+}
+
 static void ieee80211_iface_work(struct work_struct *work)
 {
 	struct ieee80211_sub_if_data *sdata =
@@ -1484,7 +1540,6 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	sdata->vif.bss_conf.txpower = INT_MIN; /* unset */
 
 	sdata->noack_map = 0;
-	sdata->hw_80211_encap = false;
 
 	/* only monitor/p2p-device differ */
 	if (sdata->dev) {
@@ -1619,6 +1674,7 @@ static int ieee80211_runtime_change_iftype(struct ieee80211_sub_if_data *sdata,
 
 	ieee80211_teardown_sdata(sdata);
 
+	ieee80211_set_sdata_offload_flags(sdata);
 	ret = drv_change_interface(local, sdata, internal_type, p2p);
 	if (ret)
 		type = ieee80211_vif_type_p2p(&sdata->vif);
@@ -1631,6 +1687,7 @@ static int ieee80211_runtime_change_iftype(struct ieee80211_sub_if_data *sdata,
 	ieee80211_check_queues(sdata, type);
 
 	ieee80211_setup_sdata(sdata, type);
+	ieee80211_set_vif_encap_ops(sdata);
 
 	err = ieee80211_do_open(&sdata->wdev, false);
 	WARN(err, "type change: do_open returned %d", err);
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 2df636c32432..8c5f829ff6d7 100644
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
index 65dfc24916e8..1e829597f32c 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4190,11 +4190,10 @@ static bool ieee80211_tx_8023(struct ieee80211_sub_if_data *sdata,
 
 static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 				struct net_device *dev, struct sta_info *sta,
-				struct sk_buff *skb)
+				struct ieee80211_key *key, struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_key *key;
 	struct tid_ampdu_tx *tid_tx;
 	u8 tid;
 
@@ -4243,7 +4242,6 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	info->control.flags |= IEEE80211_TX_CTRL_HW_80211_ENCAP;
 	info->control.vif = &sdata->vif;
 
-	key = rcu_dereference(sta->ptk[sta->ptk_idx]);
 	if (key)
 		info->control.hw_key = &key->conf;
 
@@ -4260,12 +4258,9 @@ netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ethhdr *ehdr = (struct ethhdr *)skb->data;
+	struct ieee80211_key *key;
 	struct sta_info *sta;
-
-	if (WARN_ON(!sdata->hw_80211_encap)) {
-		kfree_skb(skb);
-		return NETDEV_TX_OK;
-	}
+	bool offload = true;
 
 	if (unlikely(skb->len < ETH_HLEN)) {
 		kfree_skb(skb);
@@ -4274,15 +4269,26 @@ netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
 
 	rcu_read_lock();
 
-	if (ieee80211_lookup_ra_sta(sdata, skb, &sta))
+	if (ieee80211_lookup_ra_sta(sdata, skb, &sta)) {
 		kfree_skb(skb);
-	else if (unlikely(IS_ERR_OR_NULL(sta) || !sta->uploaded ||
-			  !test_sta_flag(sta, WLAN_STA_AUTHORIZED) ||
-			  sdata->control_port_protocol == ehdr->h_proto))
-		ieee80211_subif_start_xmit(skb, dev);
+		goto out;
+	}
+
+	if (unlikely(IS_ERR_OR_NULL(sta) || !sta->uploaded ||
+	    !test_sta_flag(sta, WLAN_STA_AUTHORIZED) ||
+		sdata->control_port_protocol == ehdr->h_proto))
+		offload = false;
+	else if ((key = rcu_dereference(sta->ptk[sta->ptk_idx])) &&
+		 (!(key->flags & KEY_FLAG_UPLOADED_TO_HARDWARE) ||
+		  key->conf.cipher == WLAN_CIPHER_SUITE_TKIP))
+		offload = false;
+
+	if (offload)
+		ieee80211_8023_xmit(sdata, dev, sta, key, skb);
 	else
-		ieee80211_8023_xmit(sdata, dev, sta, skb);
+		ieee80211_subif_start_xmit(skb, dev);
 
+out:
 	rcu_read_unlock();
 
 	return NETDEV_TX_OK;
-- 
2.28.0

