Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4D32A3FCC
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Nov 2020 10:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgKCJRz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Nov 2020 04:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgKCJRw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Nov 2020 04:17:52 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8BCC061A48
        for <linux-wireless@vger.kernel.org>; Tue,  3 Nov 2020 01:17:52 -0800 (PST)
Received: from [149.224.151.57] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1kZsRo-0006BN-Vi; Tue, 03 Nov 2020 10:17:49 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Aloka Dixit <alokad@codeaurora.org>
Subject: [PATCH V5 2/4] mac80211: add multiple bssid support to interface handling
Date:   Tue,  3 Nov 2020 10:17:41 +0100
Message-Id: <20201103091743.1924854-3-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103091743.1924854-1-john@phrozen.org>
References: <20201103091743.1924854-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a new helper ieee80211_set_multiple_bssid_options() takes propagating
the cfg80211 data down the stack.

The patch also makes sure that all members of the bss set will get closed
when either of them is shutdown.

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/mac80211.h | 28 +++++++++++++++++++++-
 net/mac80211/cfg.c     | 53 ++++++++++++++++++++++++++++++++++++++++++
 net/mac80211/debugfs.c |  1 +
 net/mac80211/iface.c   |  6 +++++
 4 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index e8e295dae744..1edaee6710a6 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -630,6 +630,7 @@ struct ieee80211_fils_discovery {
  * @s1g: BSS is S1G BSS (affects Association Request format).
  * @beacon_tx_rate: The configured beacon transmit rate that needs to be passed
  *	to driver when rate control is offloaded to firmware.
+ * @multiple_bssid: the multiple bssid settings of the AP.
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -701,6 +702,7 @@ struct ieee80211_bss_conf {
 	u32 unsol_bcast_probe_resp_interval;
 	bool s1g;
 	struct cfg80211_bitrate_mask beacon_tx_rate;
+	struct ieee80211_multiple_bssid multiple_bssid;
 };
 
 /**
@@ -1653,6 +1655,20 @@ enum ieee80211_offload_flags {
 	IEEE80211_OFFLOAD_ENCAP_4ADDR		= BIT(1),
 };
 
+/**
+ * enum ieee80211_vif_multiple_bssid_flags - virtual interface multiple bssid flags
+ *
+ * @IEEE80211_VIF_MBSS_TRANSMITTING: this BSS is transmitting beacons
+ * @IEEE80211_VIF_MBSS_NON_TRANSMITTING: this BSS is not transmitting beacons
+ * @IEEE80211_VIF_MBSS_EMA_BEACON: beacons should be send out in EMA mode
+ */
+
+enum ieee80211_vif_multiple_bssid_flags {
+	IEEE80211_VIF_MBSS_TRANSMITTING         = BIT(1),
+	IEEE80211_VIF_MBSS_NON_TRANSMITTING     = BIT(2),
+	IEEE80211_VIF_MBSS_EMA_BEACON           = BIT(3),
+};
+
 /**
  * struct ieee80211_vif - per-interface data
  *
@@ -1699,6 +1715,9 @@ enum ieee80211_offload_flags {
  *	protected by fq->lock.
  * @offload_flags: 802.3 -> 802.11 enapsulation offload flags, see
  *	&enum ieee80211_offload_flags.
+ * @multiple_bssid.parent: a non-transmitted bssid has a transmitted parent.
+ * @multiple_bssid.flags: multiple bssid flags, see
+ *	&enum ieee80211_vif_multiple_bssid_flags
  */
 struct ieee80211_vif {
 	enum nl80211_iftype type;
@@ -1726,6 +1745,10 @@ struct ieee80211_vif {
 	bool rx_mcast_action_reg;
 
 	bool txqs_stopped[IEEE80211_NUM_ACS];
+	struct {
+		struct ieee80211_vif *parent;
+		u32 flags;
+	} multiple_bssid;
 
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
@@ -2374,7 +2397,7 @@ struct ieee80211_txq {
  * @IEEE80211_HW_TX_STATUS_NO_AMPDU_LEN: Driver does not report accurate A-MPDU
  *	length in tx status information
  *
- * @IEEE80211_HW_SUPPORTS_MULTI_BSSID: Hardware supports multi BSSID
+ * @IEEE80211_HW_SUPPORTS_MULTI_BSSID: Hardware supports multi BSSID in STA mode
  *
  * @IEEE80211_HW_SUPPORTS_ONLY_HE_MULTI_BSSID: Hardware supports multi BSSID
  *	only for HE APs. Applies if @IEEE80211_HW_SUPPORTS_MULTI_BSSID is set.
@@ -2386,6 +2409,8 @@ struct ieee80211_txq {
  * @IEEE80211_HW_SUPPORTS_TX_ENCAP_OFFLOAD: Hardware supports tx encapsulation
  *	offload
  *
+ * @IEEE80211_HW_SUPPORTS_MULTI_BSSID_AP: Hardware supports multi BSSID in AP mode
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2439,6 +2464,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_SUPPORTS_ONLY_HE_MULTI_BSSID,
 	IEEE80211_HW_AMPDU_KEYBORDER_SUPPORT,
 	IEEE80211_HW_SUPPORTS_TX_ENCAP_OFFLOAD,
+	IEEE80211_HW_SUPPORTS_MULTI_BSSID_AP,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 7276e66ae435..12a6edf490ca 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -111,6 +111,39 @@ static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+static void ieee80211_set_multiple_bssid_options(struct ieee80211_sub_if_data *sdata,
+						 struct cfg80211_ap_settings *params)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct wiphy *wiphy = local->hw.wiphy;
+	struct net_device *parent;
+	struct ieee80211_sub_if_data *psdata;
+
+	if (!ieee80211_hw_check(&local->hw, SUPPORTS_MULTI_BSSID_AP))
+		return;
+
+	if (!params->multiple_bssid.count)
+		return;
+
+	if (params->multiple_bssid.parent) {
+		parent = __dev_get_by_index(wiphy_net(wiphy),
+					    params->multiple_bssid.parent);
+		if (!parent || !parent->ieee80211_ptr)
+			return;
+		psdata = IEEE80211_WDEV_TO_SUB_IF(parent->ieee80211_ptr);
+		if (psdata->vif.multiple_bssid.parent)
+			return;
+		sdata->vif.multiple_bssid.parent = &psdata->vif;
+		sdata->vif.multiple_bssid.flags |= IEEE80211_VIF_MBSS_NON_TRANSMITTING;
+	} else {
+		sdata->vif.multiple_bssid.flags |= IEEE80211_VIF_MBSS_TRANSMITTING;
+	}
+
+	if (params->multiple_bssid.ema)
+		sdata->vif.multiple_bssid.flags |= IEEE80211_VIF_MBSS_EMA_BEACON;
+	sdata->vif.bss_conf.multiple_bssid = params->multiple_bssid;
+}
+
 static struct wireless_dev *ieee80211_add_iface(struct wiphy *wiphy,
 						const char *name,
 						unsigned char name_assign_type,
@@ -141,6 +174,23 @@ static struct wireless_dev *ieee80211_add_iface(struct wiphy *wiphy,
 
 static int ieee80211_del_iface(struct wiphy *wiphy, struct wireless_dev *wdev)
 {
+	struct ieee80211_sub_if_data *sdata;
+
+	sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
+	if (sdata && sdata->vif.type == NL80211_IFTYPE_AP) {
+		if (sdata->vif.multiple_bssid.flags & IEEE80211_VIF_MBSS_TRANSMITTING) {
+			struct ieee80211_sub_if_data *child;
+
+			rcu_read_lock();
+			list_for_each_entry_rcu(child, &sdata->local->interfaces, list)
+				if (child->vif.multiple_bssid.parent == &sdata->vif)
+					dev_close(child->wdev.netdev);
+			rcu_read_unlock();
+		} else {
+			sdata->vif.multiple_bssid.parent = NULL;
+		}
+	}
+
 	ieee80211_if_remove(IEEE80211_WDEV_TO_SUB_IF(wdev));
 
 	return 0;
@@ -1077,6 +1127,9 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			changed |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
+	if (sdata->vif.type == NL80211_IFTYPE_AP)
+		ieee80211_set_multiple_bssid_options(sdata, params);
+
 	mutex_lock(&local->mtx);
 	err = ieee80211_vif_use_channel(sdata, &params->chandef,
 					IEEE80211_CHANCTX_SHARED);
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 90470392fdaa..ee5ead592835 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -409,6 +409,7 @@ static const char *hw_flag_names[] = {
 	FLAG(SUPPORTS_ONLY_HE_MULTI_BSSID),
 	FLAG(AMPDU_KEYBORDER_SUPPORT),
 	FLAG(SUPPORTS_TX_ENCAP_OFFLOAD),
+	FLAG(SUPPORTS_MULTI_BSSID_AP),
 #undef FLAG
 };
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 1be775979132..63a0391d2b66 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -377,6 +377,12 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
 	bool cancel_scan;
 	struct cfg80211_nan_func *func;
 
+	/* make sure the parent is already down */
+	if (sdata->vif.type == NL80211_IFTYPE_AP &&
+	    sdata->vif.multiple_bssid.parent &&
+	    ieee80211_sdata_running(vif_to_sdata(sdata->vif.multiple_bssid.parent)))
+		dev_close(vif_to_sdata(sdata->vif.multiple_bssid.parent)->wdev.netdev);
+
 	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 
 	cancel_scan = rcu_access_pointer(local->scan_sdata) == sdata;
-- 
2.25.1

