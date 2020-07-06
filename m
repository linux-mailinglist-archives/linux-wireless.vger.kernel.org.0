Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B802156C1
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2020 13:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgGFLwd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jul 2020 07:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgGFLwc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jul 2020 07:52:32 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152C8C08C5DF
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2020 04:52:32 -0700 (PDT)
Received: from [134.101.131.141] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jsPfh-000600-IH; Mon, 06 Jul 2020 13:52:29 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V2 03/10] mac80211: add multiple bssid support
Date:   Mon,  6 Jul 2020 13:52:12 +0200
Message-Id: <20200706115219.663650-3-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706115219.663650-1-john@phrozen.org>
References: <20200706115219.663650-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When bringing up multi bssid APs we need to track the parent-child relation
of non-transmitting and transmitting VAPs.

The patch warns when
* a parent is deleted while it has children
* a parent is opened before all children are opened
* a child is closed when its parent is open

This patch checks the above by using a linked list to track the relations.

Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/mac80211.h | 20 +++++++++++++
 net/mac80211/cfg.c     | 68 ++++++++++++++++++++++++++++++++++++++++++
 net/mac80211/iface.c   | 19 ++++++++++++
 net/mac80211/util.c    | 27 +++++++++++++++++
 4 files changed, 134 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 11d5610d2ad5..3617a2742c4d 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6558,4 +6558,24 @@ u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
  */
 bool ieee80211_set_hw_80211_encap(struct ieee80211_vif *vif, bool enable);
 
+/**
+ * ieee80211_get_multi_bssid_mode - get a vifs multi bssid mode.
+ *
+ * This function is used to help look up the multi bssid mode which is tracked
+ * inside the wdev.
+ *
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ */
+enum nl80211_multi_bssid_mode ieee80211_get_multi_bssid_mode(struct ieee80211_vif *vif);
+
+/**
+ * ieee80211_get_multi_bssid_parent - get a vifs multi bssid parent.
+ *
+ * This function is used to help look up the multi bssid parent which is tracked
+ * inside the wdev.
+ *
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ */
+struct ieee80211_vif *ieee80211_get_multi_bssid_parent(struct ieee80211_vif *vif);
+
 #endif /* MAC80211_H */
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 9b360544ad6f..d315120799c0 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -111,6 +111,42 @@ static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
+static int ieee80211_set_multi_bssid_options(struct ieee80211_sub_if_data *sdata,
+					     struct vif_params *params)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct wiphy *wiphy = local->hw.wiphy;
+	struct net_device *parent;
+
+	if (params->multi_bssid_mode &&
+	    !ieee80211_hw_check(&local->hw, SUPPORTS_MULTI_BSSID))
+		return -ENOTSUPP;
+
+	switch (params->multi_bssid_mode) {
+	case NL80211_MULTIPLE_BSSID_NON_TRANSMITTED:
+		parent = __dev_get_by_index(wiphy_net(wiphy),
+					    params->multi_bssid_parent);
+		if (!parent || !parent->ieee80211_ptr ||
+		    parent->ieee80211_ptr->multi_bssid_mode !=
+					NL80211_MULTIPLE_BSSID_TRANSMITTED)
+			return -EINVAL;
+		sdata->wdev.multi_bssid_parent = parent->ieee80211_ptr;
+		list_add(&sdata->wdev.multi_bssid_list,
+			 &parent->ieee80211_ptr->multi_bssid_list);
+		break;
+
+	case NL80211_MULTIPLE_BSSID_TRANSMITTED:
+		INIT_LIST_HEAD(&sdata->wdev.multi_bssid_list);
+		break;
+
+	default:
+		break;
+	}
+	sdata->wdev.multi_bssid_mode = params->multi_bssid_mode;
+
+	return 0;
+}
+
 static struct wireless_dev *ieee80211_add_iface(struct wiphy *wiphy,
 						const char *name,
 						unsigned char name_assign_type,
@@ -136,11 +172,43 @@ static struct wireless_dev *ieee80211_add_iface(struct wiphy *wiphy,
 		}
 	}
 
+	if (type == NL80211_IFTYPE_AP) {
+		err = ieee80211_set_multi_bssid_options(sdata, params);
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
+	struct wireless_dev *child, *tmp;
+
+	sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
+	switch (sdata->wdev.multi_bssid_mode) {
+	case NL80211_MULTIPLE_BSSID_TRANSMITTED:
+		if (list_empty(&sdata->wdev.multi_bssid_list))
+			break;
+		sdata_info(sdata, "deleting while non-transmitting children still exist\n");
+		list_for_each_entry_safe(child, tmp, &sdata->wdev.multi_bssid_list,
+					 multi_bssid_list) {
+			list_del(&child->multi_bssid_list);
+			child->multi_bssid_parent = NULL;
+		}
+		break;
+
+	case NL80211_MULTIPLE_BSSID_NON_TRANSMITTED:
+		list_del(&sdata->wdev.multi_bssid_list);
+		break;
+
+	default:
+		break;
+	}
+
 	ieee80211_if_remove(IEEE80211_WDEV_TO_SUB_IF(wdev));
 
 	return 0;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index f900c84fb40f..777b530e38d0 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -535,6 +535,18 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 		}
 	case NL80211_IFTYPE_AP:
 		sdata->bss = &sdata->u.ap;
+		if (wdev->multi_bssid_mode == NL80211_MULTIPLE_BSSID_TRANSMITTED) {
+			struct wireless_dev *child;
+			int children_down = 0;
+
+			/* check if all children are already up */
+			list_for_each_entry(child, &wdev->multi_bssid_list,
+					    multi_bssid_list)
+				if (!wdev_running(child))
+					children_down = 1;
+			if (children_down)
+				sdata_info(sdata, "non-transmitting children are not up yet\n");
+		}
 		break;
 	case NL80211_IFTYPE_MESH_POINT:
 	case NL80211_IFTYPE_STATION:
@@ -800,6 +812,7 @@ static int ieee80211_open(struct net_device *dev)
 static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
 			      bool going_down)
 {
+	struct wireless_dev *wdev = ieee80211_vif_to_wdev(&sdata->vif);
 	struct ieee80211_local *local = sdata->local;
 	unsigned long flags;
 	struct sk_buff *skb, *tmp;
@@ -810,6 +823,12 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
 	bool cancel_scan;
 	struct cfg80211_nan_func *func;
 
+	if (sdata->vif.type == NL80211_IFTYPE_AP &&
+	    wdev->multi_bssid_mode == NL80211_MULTIPLE_BSSID_NON_TRANSMITTED)
+		/* make sure the parent is already down */
+		if (wdev->multi_bssid_parent && wdev_running(wdev->multi_bssid_parent))
+			sdata_info(sdata, "transmitting parent is still up\n");
+
 	clear_bit(SDATA_STATE_RUNNING, &sdata->state);
 
 	cancel_scan = rcu_access_pointer(local->scan_sdata) == sdata;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 21c94094a699..3e4308c8f690 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -847,6 +847,33 @@ struct wireless_dev *ieee80211_vif_to_wdev(struct ieee80211_vif *vif)
 }
 EXPORT_SYMBOL_GPL(ieee80211_vif_to_wdev);
 
+enum nl80211_multi_bssid_mode ieee80211_get_multi_bssid_mode(struct ieee80211_vif *vif)
+{
+	struct ieee80211_sub_if_data *sdata;
+
+	if (!vif)
+		return 0;
+
+	sdata = vif_to_sdata(vif);
+
+	return sdata->wdev.multi_bssid_mode;
+}
+EXPORT_SYMBOL_GPL(ieee80211_get_multi_bssid_mode);
+
+struct ieee80211_vif *ieee80211_get_multi_bssid_parent(struct ieee80211_vif *vif)
+{
+	struct ieee80211_sub_if_data *sdata;
+
+	if (!vif)
+		return NULL;
+
+	sdata = vif_to_sdata(vif);
+	if (sdata->wdev.multi_bssid_parent)
+		return wdev_to_ieee80211_vif(sdata->wdev.multi_bssid_parent);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(ieee80211_get_multi_bssid_parent);
+
 /*
  * Nothing should have been stuffed into the workqueue during
  * the suspend->resume cycle. Since we can't check each caller
-- 
2.25.1

