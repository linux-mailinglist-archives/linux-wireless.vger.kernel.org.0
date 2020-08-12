Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C67242BC3
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 17:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgHLPBL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 11:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgHLPBA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 11:01:00 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDE9C061384
        for <linux-wireless@vger.kernel.org>; Wed, 12 Aug 2020 08:01:00 -0700 (PDT)
Received: from [149.224.82.90] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1k5sFN-0002OP-Fk; Wed, 12 Aug 2020 17:00:57 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V3 2/9] mac80211: add multiple bssid support to interface handling
Date:   Wed, 12 Aug 2020 17:00:43 +0200
Message-Id: <20200812150050.2683396-3-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200812150050.2683396-1-john@phrozen.org>
References: <20200812150050.2683396-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When bringing up multi bssid APs we need to track the parent-child relation
of non-transmitting and transmitting VAPs. This patch checks the above by
using a linked list to track the relations. The patch also ensures that
when a non-transmitting interface is closed the transmitting one is also
closed.

Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/mac80211.h | 13 +++++++++-
 net/mac80211/cfg.c     | 54 ++++++++++++++++++++++++++++++++++++++++++
 net/mac80211/debugfs.c |  1 +
 net/mac80211/iface.c   |  7 ++++++
 4 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f0ae718633d2..b409a5f1026c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1649,6 +1649,9 @@ enum ieee80211_vif_flags {
  *	write-protected by sdata_lock and local->mtx so holding either is fine
  *	for read access.
  * @cca_color: the color that we will have after the change.
+ * @multiple_bssid.parent: a non-transmitted bssid has a transmitted parent.
+ * @multiple_bssid.list: linked list for tracking parent - child relations.
+ * @multiple_bssid.non_transmitted: Is this a non-transmitted bssi
  */
 struct ieee80211_vif {
 	enum nl80211_iftype type;
@@ -1675,6 +1678,11 @@ struct ieee80211_vif {
 	bool rx_mcast_action_reg;
 
 	bool txqs_stopped[IEEE80211_NUM_ACS];
+	struct {
+		struct ieee80211_vif *parent;
+		struct list_head list;
+		bool non_transmitted;
+	} multiple_bssid;
 
 	bool cca_active;
 	u8 cca_color;
@@ -2326,7 +2334,7 @@ struct ieee80211_txq {
  * @IEEE80211_HW_TX_STATUS_NO_AMPDU_LEN: Driver does not report accurate A-MPDU
  *	length in tx status information
  *
- * @IEEE80211_HW_SUPPORTS_MULTI_BSSID: Hardware supports multi BSSID
+ * @IEEE80211_HW_SUPPORTS_MULTI_BSSID: Hardware supports multi BSSID in STA mode
  *
  * @IEEE80211_HW_SUPPORTS_ONLY_HE_MULTI_BSSID: Hardware supports multi BSSID
  *	only for HE APs. Applies if @IEEE80211_HW_SUPPORTS_MULTI_BSSID is set.
@@ -2335,6 +2343,8 @@ struct ieee80211_txq {
  *	aggregating MPDUs with the same keyid, allowing mac80211 to keep Tx
  *	A-MPDU sessions active while rekeying with Extended Key ID.
  *
+ * @IEEE80211_HW_SUPPORTS_MULTI_BSSID_AP: Hardware supports multi BSSID in AP mode
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2387,6 +2397,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_SUPPORTS_MULTI_BSSID,
 	IEEE80211_HW_SUPPORTS_ONLY_HE_MULTI_BSSID,
 	IEEE80211_HW_AMPDU_KEYBORDER_SUPPORT,
+	IEEE80211_HW_SUPPORTS_MULTI_BSSID_AP,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 37a218b89c9a..50a219d8a2cc 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -111,6 +111,36 @@ static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+static int ieee80211_set_multiple_bssid_options(struct ieee80211_sub_if_data *sdata,
+						struct vif_params *params)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct wiphy *wiphy = local->hw.wiphy;
+	struct net_device *parent;
+	struct ieee80211_sub_if_data *psdata;
+
+	if (!ieee80211_hw_check(&local->hw, SUPPORTS_MULTI_BSSID_AP))
+		return 0;
+
+	if (params->multiple_bssid.non_transmitted) {
+		parent = __dev_get_by_index(wiphy_net(wiphy),
+					    params->multiple_bssid.parent);
+		if (!parent || !parent->ieee80211_ptr)
+			return -EINVAL;
+		psdata = IEEE80211_WDEV_TO_SUB_IF(parent->ieee80211_ptr);
+		if (psdata->vif.multiple_bssid.non_transmitted)
+			return -EINVAL;
+		sdata->vif.multiple_bssid.parent = &psdata->vif;
+		list_add(&sdata->vif.multiple_bssid.list,
+			 &psdata->vif.multiple_bssid.list);
+		sdata->vif.multiple_bssid.non_transmitted = true;
+	} else {
+		INIT_LIST_HEAD(&sdata->vif.multiple_bssid.list);
+	}
+
+	return 0;
+}
+
 static struct wireless_dev *ieee80211_add_iface(struct wiphy *wiphy,
 						const char *name,
 						unsigned char name_assign_type,
@@ -136,11 +166,35 @@ static struct wireless_dev *ieee80211_add_iface(struct wiphy *wiphy,
 		}
 	}
 
+	if (type == NL80211_IFTYPE_AP) {
+		err = ieee80211_set_multiple_bssid_options(sdata, params);
+		if (err) {
+			ieee80211_if_remove(sdata);
+			return NULL;
+		}
+	}
+
 	return wdev;
 }
 
 static int ieee80211_del_iface(struct wiphy *wiphy, struct wireless_dev *wdev)
 {
+	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_vif *child, *tmp;
+
+	sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
+	if (sdata->vif.type == NL80211_IFTYPE_AP) {
+		if (!sdata->vif.multiple_bssid.non_transmitted) {
+			if (!list_empty(&sdata->vif.multiple_bssid.list))
+				list_for_each_entry_safe(child, tmp,
+							 &sdata->vif.multiple_bssid.list,
+							 multiple_bssid.list)
+					dev_close(vif_to_sdata(child)->wdev.netdev);
+		} else {
+			list_del(&sdata->vif.multiple_bssid.list);
+		}
+	}
+
 	ieee80211_if_remove(IEEE80211_WDEV_TO_SUB_IF(wdev));
 
 	return 0;
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 54080290d6e2..5d5c9185755a 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -408,6 +408,7 @@ static const char *hw_flag_names[] = {
 	FLAG(SUPPORTS_MULTI_BSSID),
 	FLAG(SUPPORTS_ONLY_HE_MULTI_BSSID),
 	FLAG(AMPDU_KEYBORDER_SUPPORT),
+	FLAG(SUPPORTS_MULTI_BSSID_AP),
 #undef FLAG
 };
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 8060cdc102d4..e6397d0c788d 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -810,6 +810,13 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
 	bool cancel_scan;
 	struct cfg80211_nan_func *func;
 
+	if (sdata->vif.type == NL80211_IFTYPE_AP &&
+	    sdata->vif.multiple_bssid.non_transmitted)
+		/* make sure the parent is already down */
+		if (sdata->vif.multiple_bssid.parent &&
+		    ieee80211_sdata_running(vif_to_sdata(sdata->vif.multiple_bssid.parent)))
+			dev_close(vif_to_sdata(sdata->vif.multiple_bssid.parent)->wdev.netdev);
+
 	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 
 	cancel_scan = rcu_access_pointer(local->scan_sdata) == sdata;
-- 
2.25.1

