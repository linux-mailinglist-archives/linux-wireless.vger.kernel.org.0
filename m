Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F5F7D075
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2019 00:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfGaWJH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 18:09:07 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:44118 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfGaWJH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 18:09:07 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hswmH-0004m8-CG; Thu, 01 Aug 2019 00:08:57 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [RFC/RFT] cfg80211: decouple us from the RTNL
Date:   Thu,  1 Aug 2019 00:08:47 +0200
Message-Id: <20190731220848.1045-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Currently, _everything_ in cfg80211 holds the RTNL, and if you
have a slow USB device (or a few) you can get some bad lock
contention on that.

Fix that by re-adding a mutex to each wiphy/rdev as we had at
some point, so we have locking for the wireless_dev lists and
all the other things in there, and also so that drivers still
don't have to worry too much about it (they still won't get
parallel calls for a single device).

Then, we can restrict the RTNL to a few cases where we add or
remove interfaces and really need the added protection. Some
of the global list management still also uses the RTNL, since
we need to have it anyway for netdev management.

TODO:
 - re-read everything a few times to make sure it seems right
 - use wiphy_lock()/wiphy_unlock() in all drivers as the code
   changed in mac80211 does
 - address the FIXME

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h |  24 +-
 net/mac80211/main.c    |   2 +
 net/wireless/chan.c    |   5 +-
 net/wireless/core.c    |  45 +++-
 net/wireless/core.h    |   4 +-
 net/wireless/ibss.c    |   2 +-
 net/wireless/mlme.c    |   6 +-
 net/wireless/nl80211.c | 547 +++++++++++++++++++++--------------------
 net/wireless/sme.c     |   1 -
 net/wireless/util.c    |   2 +-
 10 files changed, 353 insertions(+), 285 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 35ec1f0a2bf9..2ac6cb79f67d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4726,6 +4726,25 @@ struct cfg80211_internal_bss;
 struct cfg80211_cached_keys;
 struct cfg80211_cqm_config;
 
+/**
+ * wiphy_lock - lock the wiphy
+ * @wiphy: the wiphy to lock
+ *
+ * This is mostly exposed so it can be done around registering and
+ * unregistering netdevs that aren't created through cfg80211 calls,
+ * since that requires locking in cfg80211 when the notifiers is
+ * called, but that cannot differentiate which way it's called.
+ *
+ * When cfg80211 ops are called, the wiphy is already locked.
+ */
+void wiphy_lock(struct wiphy *wiphy);
+
+/**
+ * wiphy_unlock - unlock the wiphy again
+ * @wiphy: the wiphy to unlock
+ */
+void wiphy_unlock(struct wiphy *wiphy);
+
 /**
  * struct wireless_dev - wireless device state
  *
@@ -4733,7 +4752,10 @@ struct cfg80211_cqm_config;
  * that uses the ieee80211_ptr field in struct net_device (this
  * is intentional so it can be allocated along with the netdev.)
  * It need not be registered then as netdev registration will
- * be intercepted by cfg80211 to see the new wireless device.
+ * be intercepted by cfg80211 to see the new wireless device,
+ * however, drivers must lock the wiphy before registering or
+ * unregistering netdevs if they pre-create any netdevs (in ops
+ * called from cfg80211, the wiphy is already locked.)
  *
  * For non-netdev uses, it must also be allocated by the driver
  * in response to the cfg80211 callbacks that require it, as
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 29b9d57df1a3..03fc52587bff 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1252,8 +1252,10 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	    !ieee80211_hw_check(hw, NO_AUTO_VIF)) {
 		struct vif_params params = {0};
 
+		wiphy_lock(hw->wiphy);
 		result = ieee80211_if_add(local, "wlan%d", NET_NAME_ENUM, NULL,
 					  NL80211_IFTYPE_STATION, &params);
+		wiphy_unlock(hw->wiphy);
 		if (result)
 			wiphy_warn(local->hw.wiphy,
 				   "Failed to add default virtual iface\n");
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 7dc1bbd0888f..ac83c9030c17 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -839,7 +839,7 @@ static bool cfg80211_ir_permissive_chan(struct wiphy *wiphy,
 	struct wireless_dev *wdev;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->mtx);
 
 	if (!IS_ENABLED(CONFIG_CFG80211_REG_RELAX_NO_IR) ||
 	    !(wiphy->regulatory_flags & REGULATORY_ENABLE_RELAX_NO_IR))
@@ -961,9 +961,10 @@ bool cfg80211_reg_can_beacon_relax(struct wiphy *wiphy,
 				   struct cfg80211_chan_def *chandef,
 				   enum nl80211_iftype iftype)
 {
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	bool check_no_ir;
 
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->mtx);
 
 	/*
 	 * Under certain conditions suggested by some regulatory bodies a
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 742986c73490..2d5bd07ae11f 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -39,7 +39,7 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("wireless configuration support");
 MODULE_ALIAS_GENL_FAMILY(NL80211_GENL_NAME);
 
-/* RCU-protected (and RTNL for writers) */
+/* RTNL-protected for writing, RCU-based lookup */
 LIST_HEAD(cfg80211_rdev_list);
 int cfg80211_rdev_list_generation;
 
@@ -222,7 +222,7 @@ static void cfg80211_rfkill_poll(struct rfkill *rfkill, void *data)
 void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
 			      struct wireless_dev *wdev)
 {
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->mtx);
 
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_P2P_DEVICE))
 		return;
@@ -245,7 +245,7 @@ void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
 void cfg80211_stop_nan(struct cfg80211_registered_device *rdev,
 		       struct wireless_dev *wdev)
 {
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->mtx);
 
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_NAN))
 		return;
@@ -472,6 +472,7 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 		}
 	}
 
+	mutex_init(&rdev->mtx);
 	INIT_LIST_HEAD(&rdev->wiphy.wdev_list);
 	INIT_LIST_HEAD(&rdev->beacon_registrations);
 	spin_lock_init(&rdev->beacon_registrations_lock);
@@ -978,21 +979,38 @@ void wiphy_rfkill_stop_polling(struct wiphy *wiphy)
 }
 EXPORT_SYMBOL(wiphy_rfkill_stop_polling);
 
+void wiphy_lock(struct wiphy *wiphy)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+
+	mutex_lock(&rdev->mtx);
+}
+EXPORT_SYMBOL(wiphy_lock);
+
+void wiphy_unlock(struct wiphy *wiphy)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+
+	mutex_unlock(&rdev->mtx);
+}
+EXPORT_SYMBOL(wiphy_unlock);
+
 void wiphy_unregister(struct wiphy *wiphy)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
 	wait_event(rdev->dev_wait, ({
 		int __count;
-		rtnl_lock();
+		mutex_lock(&rdev->mtx);
 		__count = rdev->opencount;
-		rtnl_unlock();
+		mutex_unlock(&rdev->mtx);
 		__count == 0; }));
 
 	if (rdev->rfkill)
 		rfkill_unregister(rdev->rfkill);
 
 	rtnl_lock();
+	mutex_lock(&rdev->mtx);
 	nl80211_notify_wiphy(rdev, NL80211_CMD_DEL_WIPHY);
 	rdev->wiphy.registered = false;
 
@@ -1015,6 +1033,7 @@ void wiphy_unregister(struct wiphy *wiphy)
 	cfg80211_rdev_list_generation++;
 	device_del(&rdev->wiphy.dev);
 
+	mutex_unlock(&rdev->mtx);
 	rtnl_unlock();
 
 	flush_work(&rdev->scan_done_wk);
@@ -1047,6 +1066,7 @@ void cfg80211_dev_free(struct cfg80211_registered_device *rdev)
 	}
 	list_for_each_entry_safe(scan, tmp, &rdev->bss_list, list)
 		cfg80211_put_bss(&rdev->wiphy, &scan->pub);
+	mutex_destroy(&rdev->mtx);
 	kfree(rdev);
 }
 
@@ -1125,7 +1145,7 @@ static const struct device_type wiphy_type = {
 void cfg80211_update_iface_num(struct cfg80211_registered_device *rdev,
 			       enum nl80211_iftype iftype, int num)
 {
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->mtx);
 
 	rdev->num_running_ifaces += num;
 	if (iftype == NL80211_IFTYPE_MONITOR)
@@ -1138,7 +1158,7 @@ void __cfg80211_leave(struct cfg80211_registered_device *rdev,
 	struct net_device *dev = wdev->netdev;
 	struct cfg80211_sched_scan_request *pos, *tmp;
 
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->mtx);
 	ASSERT_WDEV_LOCK(wdev);
 
 	cfg80211_pmsr_wdev_down(wdev);
@@ -1234,6 +1254,9 @@ void cfg80211_init_wdev(struct cfg80211_registered_device *rdev,
 	spin_lock_init(&wdev->pmsr_lock);
 	INIT_WORK(&wdev->pmsr_free_wk, cfg80211_pmsr_free_wk);
 
+	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->mtx);
+
 	/*
 	 * We get here also when the interface changes network namespaces,
 	 * as it's registered into the new one, but we don't want it to
@@ -1269,6 +1292,7 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		SET_NETDEV_DEVTYPE(dev, &wiphy_type);
 		break;
 	case NETDEV_REGISTER:
+		lockdep_assert_held(&rdev->mtx);
 		/*
 		 * NB: cannot take rdev->mtx here because this may be
 		 * called within code protected by it when interfaces
@@ -1305,9 +1329,12 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		cfg80211_init_wdev(rdev, wdev);
 		break;
 	case NETDEV_GOING_DOWN:
+		mutex_lock(&rdev->mtx);
 		cfg80211_leave(rdev, wdev);
+		mutex_unlock(&rdev->mtx);
 		break;
 	case NETDEV_DOWN:
+		mutex_lock(&rdev->mtx);
 		cfg80211_update_iface_num(rdev, wdev->iftype, -1);
 		if (rdev->scan_req && rdev->scan_req->wdev == wdev) {
 			if (WARN_ON(!rdev->scan_req->notified))
@@ -1322,9 +1349,11 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		}
 
 		rdev->opencount--;
+		mutex_unlock(&rdev->mtx);
 		wake_up(&rdev->dev_wait);
 		break;
 	case NETDEV_UP:
+		mutex_lock(&rdev->mtx);
 		cfg80211_update_iface_num(rdev, wdev->iftype, 1);
 		wdev_lock(wdev);
 		switch (wdev->iftype) {
@@ -1371,8 +1400,10 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 			/* assume this means it's off */
 			wdev->ps = false;
 		}
+		mutex_unlock(&rdev->mtx);
 		break;
 	case NETDEV_UNREGISTER:
+		lockdep_assert_held(&rdev->mtx);
 		/*
 		 * It is possible to get NETDEV_UNREGISTER
 		 * multiple times. To detect that, check
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 77556c58d9ac..9ad586fd7939 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -25,6 +25,8 @@ struct cfg80211_registered_device {
 	const struct cfg80211_ops *ops;
 	struct list_head list;
 
+	struct mutex mtx;
+
 	/* rfkill support */
 	struct rfkill_ops rfkill_ops;
 	struct rfkill *rfkill;
@@ -231,7 +233,7 @@ static inline void wdev_unlock(struct wireless_dev *wdev)
 
 static inline bool cfg80211_has_monitors_only(struct cfg80211_registered_device *rdev)
 {
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->mtx);
 
 	return rdev->num_running_ifaces == rdev->num_running_monitor_ifaces &&
 	       rdev->num_running_ifaces > 0;
diff --git a/net/wireless/ibss.c b/net/wireless/ibss.c
index d1743e6abc34..e8d9162f9010 100644
--- a/net/wireless/ibss.c
+++ b/net/wireless/ibss.c
@@ -92,7 +92,7 @@ int __cfg80211_join_ibss(struct cfg80211_registered_device *rdev,
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	int err;
 
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->mtx);
 	ASSERT_WDEV_LOCK(wdev);
 
 	if (wdev->ssid_len)
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index f9462010575f..808821d521f9 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -433,7 +433,7 @@ cfg80211_process_mlme_unregistrations(struct cfg80211_registered_device *rdev)
 {
 	struct cfg80211_mgmt_registration *reg;
 
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->mtx);
 
 	spin_lock_bh(&rdev->mlme_unreg_lock);
 	while ((reg = list_first_entry_or_null(&rdev->mlme_unreg,
@@ -463,9 +463,9 @@ void cfg80211_mlme_unreg_wk(struct work_struct *wk)
 	rdev = container_of(wk, struct cfg80211_registered_device,
 			    mlme_unreg_wk);
 
-	rtnl_lock();
+	mutex_lock(&rdev->mtx);
 	cfg80211_process_mlme_unregistrations(rdev);
-	rtnl_unlock();
+	mutex_unlock(&rdev->mtx);
 }
 
 int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1a107f29016b..b79ab55f1f53 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -63,9 +63,9 @@ static const struct genl_multicast_group nl80211_mcgrps[] = {
 
 /* returns ERR_PTR values */
 static struct wireless_dev *
-__cfg80211_wdev_from_attrs(struct net *netns, struct nlattr **attrs)
+__cfg80211_wdev_from_attrs(struct cfg80211_registered_device *rdev,
+			   struct net *netns, struct nlattr **attrs)
 {
-	struct cfg80211_registered_device *rdev;
 	struct wireless_dev *result = NULL;
 	bool have_ifidx = attrs[NL80211_ATTR_IFINDEX];
 	bool have_wdev_id = attrs[NL80211_ATTR_WDEV];
@@ -73,8 +73,6 @@ __cfg80211_wdev_from_attrs(struct net *netns, struct nlattr **attrs)
 	int wiphy_idx = -1;
 	int ifidx = -1;
 
-	ASSERT_RTNL();
-
 	if (!have_ifidx && !have_wdev_id)
 		return ERR_PTR(-EINVAL);
 
@@ -85,6 +83,28 @@ __cfg80211_wdev_from_attrs(struct net *netns, struct nlattr **attrs)
 		wiphy_idx = wdev_id >> 32;
 	}
 
+	if (rdev) {
+		struct wireless_dev *wdev;
+
+		lockdep_assert_held(&rdev->mtx);
+
+		list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
+			if (have_ifidx && wdev->netdev &&
+			    wdev->netdev->ifindex == ifidx) {
+				result = wdev;
+				break;
+			}
+			if (have_wdev_id && wdev->identifier == (u32)wdev_id) {
+				result = wdev;
+				break;
+			}
+		}
+
+		return result ?: ERR_PTR(-ENODEV);
+	}
+
+	ASSERT_RTNL();
+
 	list_for_each_entry(rdev, &cfg80211_rdev_list, list) {
 		struct wireless_dev *wdev;
 
@@ -775,22 +795,31 @@ int nl80211_prepare_wdev_dump(struct netlink_callback *cb,
 			return err;
 		}
 
-		*wdev = __cfg80211_wdev_from_attrs(sock_net(cb->skb->sk),
+		rtnl_lock();
+		*wdev = __cfg80211_wdev_from_attrs(NULL, sock_net(cb->skb->sk),
 						   attrbuf);
 		kfree(attrbuf);
-		if (IS_ERR(*wdev))
+		if (IS_ERR(*wdev)) {
+			rtnl_unlock();
 			return PTR_ERR(*wdev);
+		}
 		*rdev = wiphy_to_rdev((*wdev)->wiphy);
+		mutex_lock(&(*rdev)->mtx);
+		rtnl_unlock();
 		/* 0 is the first index - add 1 to parse only once */
 		cb->args[0] = (*rdev)->wiphy_idx + 1;
 		cb->args[1] = (*wdev)->identifier;
 	} else {
 		/* subtract the 1 again here */
-		struct wiphy *wiphy = wiphy_idx_to_wiphy(cb->args[0] - 1);
+		struct wiphy *wiphy;
 		struct wireless_dev *tmp;
 
-		if (!wiphy)
+		rtnl_lock();
+		wiphy = wiphy_idx_to_wiphy(cb->args[0] - 1);
+		if (!wiphy) {
+			rtnl_unlock();
 			return -ENODEV;
+		}
 		*rdev = wiphy_to_rdev(wiphy);
 		*wdev = NULL;
 
@@ -801,8 +830,12 @@ int nl80211_prepare_wdev_dump(struct netlink_callback *cb,
 			}
 		}
 
-		if (!*wdev)
+		if (!*wdev) {
+			rtnl_unlock();
 			return -ENODEV;
+		}
+		mutex_lock(&(*rdev)->mtx);
+		rtnl_unlock();
 	}
 
 	return 0;
@@ -2791,7 +2824,7 @@ static int nl80211_set_wds_peer(struct sk_buff *skb, struct genl_info *info)
 
 static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 {
-	struct cfg80211_registered_device *rdev;
+	struct cfg80211_registered_device *rdev = NULL;
 	struct net_device *netdev = NULL;
 	struct wireless_dev *wdev;
 	int result = 0, rem_txq_params = 0;
@@ -2802,8 +2835,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	u8 coverage_class = 0;
 	u32 txq_limit = 0, txq_memory_limit = 0, txq_quantum = 0;
 
-	ASSERT_RTNL();
-
+	rtnl_lock();
 	/*
 	 * Try to find the wiphy and netdev. Normally this
 	 * function shouldn't need the netdev, but this is
@@ -2827,14 +2859,20 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	if (!netdev) {
 		rdev = __cfg80211_rdev_from_attrs(genl_info_net(info),
 						  info->attrs);
-		if (IS_ERR(rdev))
+		if (IS_ERR(rdev)) {
+			rtnl_unlock();
 			return PTR_ERR(rdev);
+		}
 		wdev = NULL;
 		netdev = NULL;
 		result = 0;
 	} else
 		wdev = netdev->ieee80211_ptr;
 
+	if (rdev)
+		mutex_lock(&rdev->mtx);
+	rtnl_unlock();
+
 	/*
 	 * end workaround code, by now the rdev is available
 	 * and locked, and wdev may or may not be NULL.
@@ -2844,6 +2882,10 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 		result = cfg80211_dev_rename(
 			rdev, nla_data(info->attrs[NL80211_ATTR_WIPHY_NAME]));
 
+	// FIXME - push this through to all the error paths below
+	if (rdev)
+		mutex_unlock(&rdev->mtx);
+
 	if (result)
 		return result;
 
@@ -3607,6 +3649,17 @@ static int nl80211_del_interface(struct sk_buff *skb, struct genl_info *info)
 	if (!rdev->ops->del_virtual_intf)
 		return -EOPNOTSUPP;
 
+	/*
+	 * We hold RTNL, so this is safe, without RTNL opencount cannot
+	 * reach 0, and thus the rdev cannot be deleted.
+	 *
+	 * We need to do it for the dev_close(), since that will call
+	 * the netdev notifiers, and we need to acquire the mutex there
+	 * but don't know if we get there from here or from some other
+	 * place (e.g. "ip link set ... down").
+	 */
+	mutex_unlock(&rdev->mtx);
+
 	/*
 	 * If we remove a wireless device without a netdev then clear
 	 * user_ptr[1] so that nl80211_post_doit won't dereference it
@@ -3616,6 +3669,10 @@ static int nl80211_del_interface(struct sk_buff *skb, struct genl_info *info)
 	 */
 	if (!wdev->netdev)
 		info->user_ptr[1] = NULL;
+	else
+		dev_close(wdev->netdev);
+
+	mutex_lock(&rdev->mtx);
 
 	return rdev_del_virtual_intf(rdev, wdev);
 }
@@ -5216,10 +5273,9 @@ static int nl80211_dump_station(struct sk_buff *skb,
 	int sta_idx = cb->args[2];
 	int err;
 
-	rtnl_lock();
 	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev);
 	if (err)
-		goto out_err;
+		return err;
 
 	if (!wdev->netdev) {
 		err = -EINVAL;
@@ -5254,7 +5310,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 	cb->args[2] = sta_idx;
 	err = skb->len;
  out_err:
-	rtnl_unlock();
+	mutex_unlock(&rdev->mtx);
 
 	return err;
 }
@@ -6099,10 +6155,9 @@ static int nl80211_dump_mpath(struct sk_buff *skb,
 	int path_idx = cb->args[2];
 	int err;
 
-	rtnl_lock();
 	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev);
 	if (err)
-		goto out_err;
+		return err;
 
 	if (!rdev->ops->dump_mpath) {
 		err = -EOPNOTSUPP;
@@ -6135,7 +6190,7 @@ static int nl80211_dump_mpath(struct sk_buff *skb,
 	cb->args[2] = path_idx;
 	err = skb->len;
  out_err:
-	rtnl_unlock();
+	mutex_unlock(&rdev->mtx);
 	return err;
 }
 
@@ -6295,10 +6350,9 @@ static int nl80211_dump_mpp(struct sk_buff *skb,
 	int path_idx = cb->args[2];
 	int err;
 
-	rtnl_lock();
 	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev);
 	if (err)
-		goto out_err;
+		return err;
 
 	if (!rdev->ops->dump_mpp) {
 		err = -EOPNOTSUPP;
@@ -6331,7 +6385,7 @@ static int nl80211_dump_mpp(struct sk_buff *skb,
 	cb->args[2] = path_idx;
 	err = skb->len;
  out_err:
-	rtnl_unlock();
+	mutex_unlock(&rdev->mtx);
 	return err;
 }
 
@@ -6939,12 +6993,15 @@ static int nl80211_get_reg_do(struct sk_buff *skb, struct genl_info *info)
 	if (!hdr)
 		goto put_failure;
 
+	rtnl_lock();
+
 	if (info->attrs[NL80211_ATTR_WIPHY]) {
 		bool self_managed;
 
 		rdev = cfg80211_get_dev_from_info(genl_info_net(info), info);
 		if (IS_ERR(rdev)) {
 			nlmsg_free(msg);
+			rtnl_unlock();
 			return PTR_ERR(rdev);
 		}
 
@@ -6953,9 +7010,11 @@ static int nl80211_get_reg_do(struct sk_buff *skb, struct genl_info *info)
 			       REGULATORY_WIPHY_SELF_MANAGED;
 		regdom = get_wiphy_regdom(wiphy);
 
+
 		/* a self-managed-reg device must have a private regdom */
 		if (WARN_ON(!regdom && self_managed)) {
 			nlmsg_free(msg);
+			rtnl_unlock();
 			return -EINVAL;
 		}
 
@@ -6980,11 +7039,13 @@ static int nl80211_get_reg_do(struct sk_buff *skb, struct genl_info *info)
 	rcu_read_unlock();
 
 	genlmsg_end(msg, hdr);
+	rtnl_unlock();
 	return genlmsg_reply(msg, info);
 
 nla_put_failure_rcu:
 	rcu_read_unlock();
 nla_put_failure:
+	rtnl_unlock();
 put_failure:
 	nlmsg_free(msg);
 	return -EMSGSIZE;
@@ -7147,12 +7208,17 @@ static int nl80211_set_reg(struct sk_buff *skb, struct genl_info *info)
 			return -EINVAL;
 	}
 
-	if (!reg_is_valid_request(alpha2))
-		return -EINVAL;
+	rtnl_lock();
+	if (!reg_is_valid_request(alpha2)) {
+		r = -EINVAL;
+		goto out;
+	}
 
 	rd = kzalloc(struct_size(rd, reg_rules, num_rules), GFP_KERNEL);
-	if (!rd)
-		return -ENOMEM;
+	if (!rd) {
+		r = -ENOMEM;
+		goto out;
+	}
 
 	rd->n_reg_rules = num_rules;
 	rd->alpha2[0] = alpha2[0];
@@ -7184,10 +7250,13 @@ static int nl80211_set_reg(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
+	r = set_regdom(rd, REGD_SOURCE_CRDA);
 	/* set_regdom takes ownership of rd */
-	return set_regdom(rd, REGD_SOURCE_CRDA);
+	rd = NULL;
  bad_reg:
 	kfree(rd);
+ out:
+	rtnl_unlock();
 	return r;
 }
 #endif /* CONFIG_CFG80211_CRDA_SUPPORT */
@@ -8367,10 +8436,7 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_csa_settings params;
-	/* csa_attrs is defined static to avoid waste of stack size - this
-	 * function is called under RTNL lock, so this should not be a problem.
-	 */
-	static struct nlattr *csa_attrs[NL80211_ATTR_MAX+1];
+	struct nlattr **csa_attrs;
 	int err;
 	bool need_new_beacon = false;
 	bool need_handle_dfs_flag = true;
@@ -8435,28 +8501,39 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		return err;
 
+	csa_attrs = kcalloc(NL80211_ATTR_MAX + 1, sizeof(*csa_attrs),
+			    GFP_KERNEL);
+	if (!csa_attrs)
+		return -ENOMEM;
+
 	err = nla_parse_nested_deprecated(csa_attrs, NL80211_ATTR_MAX,
 					  info->attrs[NL80211_ATTR_CSA_IES],
 					  nl80211_policy, info->extack);
 	if (err)
-		return err;
+		goto free;
 
 	err = nl80211_parse_beacon(rdev, csa_attrs, &params.beacon_csa);
 	if (err)
-		return err;
+		goto free;
 
-	if (!csa_attrs[NL80211_ATTR_CSA_C_OFF_BEACON])
-		return -EINVAL;
+	if (!csa_attrs[NL80211_ATTR_CSA_C_OFF_BEACON]) {
+		err = -EINVAL;
+		goto free;
+	}
 
 	len = nla_len(csa_attrs[NL80211_ATTR_CSA_C_OFF_BEACON]);
-	if (!len || (len % sizeof(u16)))
-		return -EINVAL;
+	if (!len || (len % sizeof(u16))) {
+		err = -EINVAL;
+		goto free;
+	}
 
 	params.n_counter_offsets_beacon = len / sizeof(u16);
 	if (rdev->wiphy.max_num_csa_counters &&
 	    (params.n_counter_offsets_beacon >
-	     rdev->wiphy.max_num_csa_counters))
-		return -EINVAL;
+	     rdev->wiphy.max_num_csa_counters)) {
+		err = -EINVAL;
+		goto free;
+	}
 
 	params.counter_offsets_beacon =
 		nla_data(csa_attrs[NL80211_ATTR_CSA_C_OFF_BEACON]);
@@ -8465,23 +8542,31 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	for (i = 0; i < params.n_counter_offsets_beacon; i++) {
 		u16 offset = params.counter_offsets_beacon[i];
 
-		if (offset >= params.beacon_csa.tail_len)
-			return -EINVAL;
+		if (offset >= params.beacon_csa.tail_len) {
+			err = -EINVAL;
+			goto free;
+		}
 
-		if (params.beacon_csa.tail[offset] != params.count)
-			return -EINVAL;
+		if (params.beacon_csa.tail[offset] != params.count) {
+			err = -EINVAL;
+			goto free;
+		}
 	}
 
 	if (csa_attrs[NL80211_ATTR_CSA_C_OFF_PRESP]) {
 		len = nla_len(csa_attrs[NL80211_ATTR_CSA_C_OFF_PRESP]);
-		if (!len || (len % sizeof(u16)))
-			return -EINVAL;
+		if (!len || (len % sizeof(u16))) {
+			err = -EINVAL;
+			goto free;
+		}
 
 		params.n_counter_offsets_presp = len / sizeof(u16);
 		if (rdev->wiphy.max_num_csa_counters &&
 		    (params.n_counter_offsets_presp >
-		     rdev->wiphy.max_num_csa_counters))
-			return -EINVAL;
+		     rdev->wiphy.max_num_csa_counters)) {
+			err = -EINVAL;
+			goto free;
+		}
 
 		params.counter_offsets_presp =
 			nla_data(csa_attrs[NL80211_ATTR_CSA_C_OFF_PRESP]);
@@ -8490,35 +8575,42 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 		for (i = 0; i < params.n_counter_offsets_presp; i++) {
 			u16 offset = params.counter_offsets_presp[i];
 
-			if (offset >= params.beacon_csa.probe_resp_len)
-				return -EINVAL;
+			if (offset >= params.beacon_csa.probe_resp_len) {
+				err = -EINVAL;
+				goto free;
+			}
 
 			if (params.beacon_csa.probe_resp[offset] !=
-			    params.count)
-				return -EINVAL;
+			    params.count) {
+				err = -EINVAL;
+				goto free;
+			}
 		}
 	}
 
 skip_beacons:
 	err = nl80211_parse_chandef(rdev, info, &params.chandef);
 	if (err)
-		return err;
+		goto free;
 
 	if (!cfg80211_reg_can_beacon_relax(&rdev->wiphy, &params.chandef,
-					   wdev->iftype))
-		return -EINVAL;
+					   wdev->iftype)) {
+		err = -EINVAL;
+		goto free;
+	}
 
 	err = cfg80211_chandef_dfs_required(wdev->wiphy,
 					    &params.chandef,
 					    wdev->iftype);
 	if (err < 0)
-		return err;
+		goto free;
 
 	if (err > 0) {
 		params.radar_required = true;
 		if (need_handle_dfs_flag &&
 		    !nla_get_flag(info->attrs[NL80211_ATTR_HANDLE_DFS])) {
-			return -EINVAL;
+			err = -EINVAL;
+			goto free;
 		}
 	}
 
@@ -8529,6 +8621,8 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	err = rdev_channel_switch(rdev, dev, &params);
 	wdev_unlock(wdev);
 
+free:
+	kfree(csa_attrs);
 	return err;
 }
 
@@ -8677,12 +8771,9 @@ static int nl80211_dump_scan(struct sk_buff *skb, struct netlink_callback *cb)
 	int start = cb->args[2], idx = 0;
 	int err;
 
-	rtnl_lock();
 	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev);
-	if (err) {
-		rtnl_unlock();
+	if (err)
 		return err;
-	}
 
 	wdev_lock(wdev);
 	spin_lock_bh(&rdev->bss_lock);
@@ -8713,7 +8804,7 @@ static int nl80211_dump_scan(struct sk_buff *skb, struct netlink_callback *cb)
 	wdev_unlock(wdev);
 
 	cb->args[2] = idx;
-	rtnl_unlock();
+	mutex_unlock(&rdev->mtx);
 
 	return skb->len;
 }
@@ -8802,10 +8893,11 @@ static int nl80211_dump_survey(struct sk_buff *skb, struct netlink_callback *cb)
 	if (!attrbuf)
 		return -ENOMEM;
 
-	rtnl_lock();
 	res = nl80211_prepare_wdev_dump(cb, &rdev, &wdev);
-	if (res)
-		goto out_err;
+	if (res) {
+		kfree(attrbuf);
+		return res;
+	}
 
 	/* prepare_wdev_dump parsed the attributes */
 	radio_stats = attrbuf[NL80211_ATTR_SURVEY_RADIO_STATS];
@@ -8847,7 +8939,7 @@ static int nl80211_dump_survey(struct sk_buff *skb, struct netlink_callback *cb)
 	res = skb->len;
  out_err:
 	kfree(attrbuf);
-	rtnl_unlock();
+	mutex_unlock(&rdev->mtx);
 	return res;
 }
 
@@ -9674,10 +9766,14 @@ EXPORT_SYMBOL(__cfg80211_send_event_skb);
 static int nl80211_testmode_do(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
-	struct wireless_dev *wdev =
-		__cfg80211_wdev_from_attrs(genl_info_net(info), info->attrs);
+	struct wireless_dev *wdev;
 	int err;
 
+	lockdep_assert_held(&rdev->mtx);
+
+	wdev = __cfg80211_wdev_from_attrs(rdev, genl_info_net(info),
+					  info->attrs);
+
 	if (!rdev->ops->testmode_cmd)
 		return -EOPNOTSUPP;
 
@@ -12817,7 +12913,8 @@ static int nl80211_vendor_cmd(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct wireless_dev *wdev =
-		__cfg80211_wdev_from_attrs(genl_info_net(info), info->attrs);
+		__cfg80211_wdev_from_attrs(rdev, genl_info_net(info),
+					   info->attrs);
 	int i, err;
 	u32 vid, subcmd;
 
@@ -12941,7 +13038,7 @@ static int nl80211_prepare_vendor_dump(struct sk_buff *skb,
 		goto out;
 	}
 
-	*wdev = __cfg80211_wdev_from_attrs(sock_net(skb->sk), attrbuf);
+	*wdev = __cfg80211_wdev_from_attrs(NULL, sock_net(skb->sk), attrbuf);
 	if (IS_ERR(*wdev))
 		*wdev = NULL;
 
@@ -13723,31 +13820,24 @@ static int nl80211_probe_mesh_link(struct sk_buff *skb, struct genl_info *info)
 static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 			    struct genl_info *info)
 {
-	struct cfg80211_registered_device *rdev;
+	struct cfg80211_registered_device *rdev = NULL;
 	struct wireless_dev *wdev;
 	struct net_device *dev;
-	bool rtnl = ops->internal_flags & NL80211_FLAG_NEED_RTNL;
-
-	if (rtnl)
-		rtnl_lock();
 
+	rtnl_lock();
 	if (ops->internal_flags & NL80211_FLAG_NEED_WIPHY) {
 		rdev = cfg80211_get_dev_from_info(genl_info_net(info), info);
 		if (IS_ERR(rdev)) {
-			if (rtnl)
-				rtnl_unlock();
+			rtnl_unlock();
 			return PTR_ERR(rdev);
 		}
 		info->user_ptr[0] = rdev;
 	} else if (ops->internal_flags & NL80211_FLAG_NEED_NETDEV ||
 		   ops->internal_flags & NL80211_FLAG_NEED_WDEV) {
-		ASSERT_RTNL();
-
-		wdev = __cfg80211_wdev_from_attrs(genl_info_net(info),
+		wdev = __cfg80211_wdev_from_attrs(NULL, genl_info_net(info),
 						  info->attrs);
 		if (IS_ERR(wdev)) {
-			if (rtnl)
-				rtnl_unlock();
+			rtnl_unlock();
 			return PTR_ERR(wdev);
 		}
 
@@ -13756,8 +13846,7 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 
 		if (ops->internal_flags & NL80211_FLAG_NEED_NETDEV) {
 			if (!dev) {
-				if (rtnl)
-					rtnl_unlock();
+				rtnl_unlock();
 				return -EINVAL;
 			}
 
@@ -13768,8 +13857,7 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 
 		if (ops->internal_flags & NL80211_FLAG_CHECK_NETDEV_UP &&
 		    !wdev_running(wdev)) {
-			if (rtnl)
-				rtnl_unlock();
+			rtnl_unlock();
 			return -ENETDOWN;
 		}
 
@@ -13779,6 +13867,11 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 		info->user_ptr[0] = rdev;
 	}
 
+	if (rdev)
+		mutex_lock(&rdev->mtx);
+	if (!(ops->internal_flags & NL80211_FLAG_NEED_RTNL))
+		rtnl_unlock();
+
 	return 0;
 }
 
@@ -13796,6 +13889,12 @@ static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
 		}
 	}
 
+	if (info->user_ptr[0]) {
+		struct cfg80211_registered_device *rdev = info->user_ptr[0];
+
+		mutex_unlock(&rdev->mtx);
+	}
+
 	if (ops->internal_flags & NL80211_FLAG_NEED_RTNL)
 		rtnl_unlock();
 
@@ -13819,15 +13918,13 @@ static const struct genl_ops nl80211_ops[] = {
 		.dumpit = nl80211_dump_wiphy,
 		.done = nl80211_dump_wiphy_done,
 		/* can be retrieved by unprivileged users */
-		.internal_flags = NL80211_FLAG_NEED_WIPHY |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WIPHY,
 	},
 	{
 		.cmd = NL80211_CMD_SET_WIPHY,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_wiphy,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_RTNL,
 	},
 	{
 		.cmd = NL80211_CMD_GET_INTERFACE,
@@ -13835,8 +13932,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_get_interface,
 		.dumpit = nl80211_dump_interface,
 		/* can be retrieved by unprivileged users */
-		.internal_flags = NL80211_FLAG_NEED_WDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WDEV,
 	},
 	{
 		.cmd = NL80211_CMD_SET_INTERFACE,
@@ -13867,8 +13963,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_get_key,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_SET_KEY,
@@ -13876,7 +13971,6 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_set_key,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -13885,7 +13979,6 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_new_key,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -13893,64 +13986,56 @@ static const struct genl_ops nl80211_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_del_key,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_SET_BEACON,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.doit = nl80211_set_beacon,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_START_AP,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.doit = nl80211_start_ap,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_STOP_AP,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.doit = nl80211_stop_ap,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_GET_STATION,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_get_station,
 		.dumpit = nl80211_dump_station,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV,
 	},
 	{
 		.cmd = NL80211_CMD_SET_STATION,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_station,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_NEW_STATION,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_new_station,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_DEL_STATION,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_del_station,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_GET_MPATH,
@@ -13958,8 +14043,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_get_mpath,
 		.dumpit = nl80211_dump_mpath,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_GET_MPP,
@@ -13967,47 +14051,42 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_get_mpp,
 		.dumpit = nl80211_dump_mpp,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_SET_MPATH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_mpath,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_NEW_MPATH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_new_mpath,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_DEL_MPATH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_del_mpath,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_SET_BSS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_bss,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_GET_REG,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_get_reg_do,
 		.dumpit = nl80211_get_reg_dump,
-		.internal_flags = NL80211_FLAG_NEED_RTNL,
+		.internal_flags = 0,
 		/* can be retrieved by unprivileged users */
 	},
 #ifdef CONFIG_CFG80211_CRDA_SUPPORT
@@ -14016,7 +14095,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_reg,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_RTNL,
+		.internal_flags = 0,
 	},
 #endif
 	{
@@ -14036,32 +14115,28 @@ static const struct genl_ops nl80211_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_get_mesh_config,
 		/* can be retrieved by unprivileged users */
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_SET_MESH_CONFIG,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_update_mesh_config,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_TRIGGER_SCAN,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_trigger_scan,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_ABORT_SCAN,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_abort_scan,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_GET_SCAN,
@@ -14073,16 +14148,14 @@ static const struct genl_ops nl80211_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_start_sched_scan,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_STOP_SCHED_SCAN,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_stop_sched_scan,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_AUTHENTICATE,
@@ -14090,7 +14163,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_authenticate,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL |
+				  0 |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -14099,7 +14172,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_associate,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL |
+				  0 |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -14107,32 +14180,28 @@ static const struct genl_ops nl80211_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_deauthenticate,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_DISASSOCIATE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_disassociate,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_JOIN_IBSS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_join_ibss,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_LEAVE_IBSS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_leave_ibss,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 #ifdef CONFIG_NL80211_TESTMODE
 	{
@@ -14141,8 +14210,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_testmode_do,
 		.dumpit = nl80211_testmode_dump,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WIPHY |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WIPHY,
 	},
 #endif
 	{
@@ -14151,7 +14219,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_connect,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL |
+				  0 |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -14160,7 +14228,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_update_connect_params,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL |
+				  0 |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -14168,16 +14236,14 @@ static const struct genl_ops nl80211_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_disconnect,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_SET_WIPHY_NETNS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_wiphy_netns,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WIPHY |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WIPHY,
 	},
 	{
 		.cmd = NL80211_CMD_GET_SURVEY,
@@ -14190,7 +14256,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_setdel_pmksa,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL |
+				  0 |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -14198,136 +14264,119 @@ static const struct genl_ops nl80211_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_setdel_pmksa,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_FLUSH_PMKSA,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_flush_pmksa,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_REMAIN_ON_CHANNEL,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_remain_on_channel,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_CANCEL_REMAIN_ON_CHANNEL,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_cancel_remain_on_channel,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_SET_TX_BITRATE_MASK,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_tx_bitrate_mask,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV,
 	},
 	{
 		.cmd = NL80211_CMD_REGISTER_FRAME,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_register_mgmt,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WDEV,
 	},
 	{
 		.cmd = NL80211_CMD_FRAME,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_tx_mgmt,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_FRAME_WAIT_CANCEL,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_tx_mgmt_cancel_wait,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_SET_POWER_SAVE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_power_save,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV,
 	},
 	{
 		.cmd = NL80211_CMD_GET_POWER_SAVE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_get_power_save,
 		/* can be retrieved by unprivileged users */
-		.internal_flags = NL80211_FLAG_NEED_NETDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV,
 	},
 	{
 		.cmd = NL80211_CMD_SET_CQM,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_cqm,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV,
 	},
 	{
 		.cmd = NL80211_CMD_SET_CHANNEL,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_channel,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV,
 	},
 	{
 		.cmd = NL80211_CMD_SET_WDS_PEER,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_wds_peer,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV,
 	},
 	{
 		.cmd = NL80211_CMD_JOIN_MESH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_join_mesh,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_LEAVE_MESH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_leave_mesh,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_JOIN_OCB,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_join_ocb,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_LEAVE_OCB,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_leave_ocb,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 #ifdef CONFIG_PM
 	{
@@ -14335,16 +14384,14 @@ static const struct genl_ops nl80211_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_get_wowlan,
 		/* can be retrieved by unprivileged users */
-		.internal_flags = NL80211_FLAG_NEED_WIPHY |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WIPHY,
 	},
 	{
 		.cmd = NL80211_CMD_SET_WOWLAN,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_wowlan,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WIPHY |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WIPHY,
 	},
 #endif
 	{
@@ -14353,7 +14400,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.doit = nl80211_set_rekey_data,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL |
+				  0 |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -14361,128 +14408,112 @@ static const struct genl_ops nl80211_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_tdls_mgmt,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_TDLS_OPER,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_tdls_oper,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_UNEXPECTED_FRAME,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_register_unexpected_frame,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV,
 	},
 	{
 		.cmd = NL80211_CMD_PROBE_CLIENT,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_probe_client,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_REGISTER_BEACONS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_register_beacons,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WIPHY |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WIPHY,
 	},
 	{
 		.cmd = NL80211_CMD_SET_NOACK_MAP,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_noack_map,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV,
 	},
 	{
 		.cmd = NL80211_CMD_START_P2P_DEVICE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_start_p2p_device,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WDEV,
 	},
 	{
 		.cmd = NL80211_CMD_STOP_P2P_DEVICE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_stop_p2p_device,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_START_NAN,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_start_nan,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WDEV,
 	},
 	{
 		.cmd = NL80211_CMD_STOP_NAN,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_stop_nan,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_ADD_NAN_FUNCTION,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_nan_add_func,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_DEL_NAN_FUNCTION,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_nan_del_func,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_CHANGE_NAN_CONFIG,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_nan_change_config,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_SET_MCAST_RATE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_mcast_rate,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV,
 	},
 	{
 		.cmd = NL80211_CMD_SET_MAC_ACL,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_mac_acl,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV,
 	},
 	{
 		.cmd = NL80211_CMD_RADAR_DETECT,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_start_radar_detection,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_GET_PROTOCOL_FEATURES,
@@ -14494,47 +14525,41 @@ static const struct genl_ops nl80211_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_update_ft_ies,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_CRIT_PROTOCOL_START,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_crit_protocol_start,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_CRIT_PROTOCOL_STOP,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_crit_protocol_stop,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_GET_COALESCE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_get_coalesce,
-		.internal_flags = NL80211_FLAG_NEED_WIPHY |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WIPHY,
 	},
 	{
 		.cmd = NL80211_CMD_SET_COALESCE,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_coalesce,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WIPHY |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WIPHY,
 	},
 	{
 		.cmd = NL80211_CMD_CHANNEL_SWITCH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_channel_switch,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_VENDOR,
@@ -14543,7 +14568,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.dumpit = nl80211_vendor_cmd_dump,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WIPHY |
-				  NL80211_FLAG_NEED_RTNL |
+				  0 |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -14551,116 +14576,102 @@ static const struct genl_ops nl80211_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_qos_map,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_ADD_TX_TS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_add_tx_ts,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_DEL_TX_TS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_del_tx_ts,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_TDLS_CHANNEL_SWITCH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_tdls_channel_switch,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_TDLS_CANCEL_CHANNEL_SWITCH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_tdls_cancel_channel_switch,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_SET_MULTICAST_TO_UNICAST,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_multicast_to_unicast,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV,
 	},
 	{
 		.cmd = NL80211_CMD_SET_PMK,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_pmk,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL |
+				  0 |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
 		.cmd = NL80211_CMD_DEL_PMK,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_del_pmk,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_EXTERNAL_AUTH,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_external_auth,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_CONTROL_PORT_FRAME,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_tx_control_port,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_GET_FTM_RESPONDER_STATS,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_get_ftm_responder_stats,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV,
 	},
 	{
 		.cmd = NL80211_CMD_PEER_MEASUREMENT_START,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_pmsr_start,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_NOTIFY_RADAR,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_notify_radar_detection,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_UPDATE_OWE_INFO,
 		.doit = nl80211_update_owe_info,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_PROBE_MESH_LINK,
 		.doit = nl80211_probe_mesh_link,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 };
 
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 7a6c38ddc65a..f6b68685189f 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -67,7 +67,6 @@ static int cfg80211_conn_scan(struct wireless_dev *wdev)
 	struct cfg80211_scan_request *request;
 	int n_channels, err;
 
-	ASSERT_RTNL();
 	ASSERT_WDEV_LOCK(wdev);
 
 	if (rdev->scan_req || rdev->scan_msg)
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 1c39d6a2e850..39587ad2fb48 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -891,7 +891,7 @@ void cfg80211_process_rdev_events(struct cfg80211_registered_device *rdev)
 {
 	struct wireless_dev *wdev;
 
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->mtx);
 
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list)
 		cfg80211_process_wdev_events(wdev);
-- 
2.20.1

