Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17940300708
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jan 2021 16:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbhAVPVL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jan 2021 10:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbhAVPUs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jan 2021 10:20:48 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381D5C0613D6
        for <linux-wireless@vger.kernel.org>; Fri, 22 Jan 2021 07:19:52 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l2yDz-00ABsc-Ts; Fri, 22 Jan 2021 16:19:48 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 1/2] cfg80211: change netdev registration/unregistration semantics
Date:   Fri, 22 Jan 2021 16:19:42 +0100
Message-Id: <20210122161942.cf2f4b65e4e9.Ida8234e50da13eb675b557bac52a713ad4eddf71@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We used to not require anything in terms of registering netdevs
with cfg80211, using a netdev notifier instead. However, in the
next patch reducing RTNL locking, this causes big problems, and
the simplest way is to just require drivers to do things better.

Change the registration/unregistration semantics to require the
drivers to call cfg80211_(un)register_netdevice() when this is
happening due to a cfg80211 request, i.e. add_virtual_intf() or
del_virtual_intf() (or if it somehow has to happen in any other
cfg80211 callback).

Otherwise, in other contexts, drivers may continue to use the
normal netdev (un)registration functions as usual.

Internally, we still use the netdev notifier and track (by the
new wdev->registered bool) if the wdev had already been added
to cfg80211 or not.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |   4 +-
 drivers/net/wireless/ath/wil6210/netdev.c     |   4 +-
 .../broadcom/brcm80211/brcmfmac/core.c        |   6 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |   4 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |   2 +-
 drivers/net/wireless/microchip/wilc1000/mon.c |   4 +-
 .../net/wireless/microchip/wilc1000/netdev.c  |   2 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |   4 +-
 drivers/net/wireless/quantenna/qtnfmac/core.c |   2 +-
 include/net/cfg80211.h                        |  40 ++++--
 net/mac80211/iface.c                          |   9 +-
 net/wireless/core.c                           | 119 +++++++++++-------
 12 files changed, 123 insertions(+), 77 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index 9c83e9a4299b..29527e8dcced 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -3648,7 +3648,7 @@ void ath6kl_cfg80211_vif_cleanup(struct ath6kl_vif *vif)
 		kfree(mc_filter);
 	}
 
-	unregister_netdevice(vif->ndev);
+	cfg80211_unregister_netdevice(vif->ndev);
 
 	ar->num_vif--;
 }
@@ -3821,7 +3821,7 @@ struct wireless_dev *ath6kl_interface_add(struct ath6kl *ar, const char *name,
 
 	netdev_set_default_ethtool_ops(ndev, &ath6kl_ethtool_ops);
 
-	if (register_netdevice(ndev))
+	if (cfg80211_register_netdevice(ndev))
 		goto err;
 
 	ar->avail_idx_map &= ~BIT(fw_vif_idx);
diff --git a/drivers/net/wireless/ath/wil6210/netdev.c b/drivers/net/wireless/ath/wil6210/netdev.c
index 07b4a252a23c..472fe804203d 100644
--- a/drivers/net/wireless/ath/wil6210/netdev.c
+++ b/drivers/net/wireless/ath/wil6210/netdev.c
@@ -424,7 +424,7 @@ int wil_vif_add(struct wil6210_priv *wil, struct wil6210_vif *vif)
 		if (rc)
 			return rc;
 	}
-	rc = register_netdevice(ndev);
+	rc = cfg80211_register_netdevice(ndev);
 	if (rc < 0) {
 		dev_err(&ndev->dev, "Failed to register netdev: %d\n", rc);
 		if (any_active && vif->mid != 0)
@@ -511,7 +511,7 @@ void wil_vif_remove(struct wil6210_priv *wil, u8 mid)
 	/* during unregister_netdevice cfg80211_leave may perform operations
 	 * such as stop AP, disconnect, so we only clear the VIF afterwards
 	 */
-	unregister_netdevice(ndev);
+	cfg80211_unregister_netdevice(ndev);
 
 	if (any_active && vif->mid != 0)
 		wmi_port_delete(wil, vif->mid);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 3dd28f5fef19..6cf308d5934c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -657,7 +657,7 @@ int brcmf_net_attach(struct brcmf_if *ifp, bool rtnl_locked)
 	INIT_WORK(&ifp->ndoffload_work, _brcmf_update_ndtable);
 
 	if (rtnl_locked)
-		err = register_netdevice(ndev);
+		err = cfg80211_register_netdevice(ndev);
 	else
 		err = register_netdev(ndev);
 	if (err != 0) {
@@ -681,7 +681,7 @@ void brcmf_net_detach(struct net_device *ndev, bool rtnl_locked)
 {
 	if (ndev->reg_state == NETREG_REGISTERED) {
 		if (rtnl_locked)
-			unregister_netdevice(ndev);
+			cfg80211_unregister_netdevice(ndev);
 		else
 			unregister_netdev(ndev);
 	} else {
@@ -758,7 +758,7 @@ int brcmf_net_mon_attach(struct brcmf_if *ifp)
 	ndev = ifp->ndev;
 	ndev->netdev_ops = &brcmf_netdev_ops_mon;
 
-	err = register_netdevice(ndev);
+	err = cfg80211_register_netdevice(ndev);
 	if (err)
 		bphy_err(drvr, "Failed to register %s device\n", ndev->name);
 
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index a6b9dc6700b1..15e1cee7f465 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -3081,7 +3081,7 @@ struct wireless_dev *mwifiex_add_virtual_intf(struct wiphy *wiphy,
 	mutex_init(&priv->async_mutex);
 
 	/* Register network device */
-	if (register_netdevice(dev)) {
+	if (cfg80211_register_netdevice(dev)) {
 		mwifiex_dbg(adapter, ERROR, "cannot register network device\n");
 		ret = -EFAULT;
 		goto err_reg_netdev;
@@ -3160,7 +3160,7 @@ int mwifiex_del_virtual_intf(struct wiphy *wiphy, struct wireless_dev *wdev)
 		netif_carrier_off(priv->netdev);
 
 	if (wdev->netdev->reg_state == NETREG_REGISTERED)
-		unregister_netdevice(wdev->netdev);
+		cfg80211_unregister_netdevice(wdev->netdev);
 
 	if (priv->dfs_cac_workqueue) {
 		flush_workqueue(priv->dfs_cac_workqueue);
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index e3dd205cbbe5..96973ec7bd9a 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1538,7 +1538,7 @@ static int del_virtual_intf(struct wiphy *wiphy, struct wireless_dev *wdev)
 		wilc_wfi_deinit_mon_interface(wl, true);
 	vif = netdev_priv(wdev->netdev);
 	cfg80211_stop_iface(wiphy, wdev, GFP_KERNEL);
-	unregister_netdevice(vif->ndev);
+	cfg80211_unregister_netdevice(vif->ndev);
 	vif->monitor_flag = 0;
 
 	wilc_set_operation_mode(vif, 0, 0, 0);
diff --git a/drivers/net/wireless/microchip/wilc1000/mon.c b/drivers/net/wireless/microchip/wilc1000/mon.c
index b5a1b65c087c..6bd63934c2d8 100644
--- a/drivers/net/wireless/microchip/wilc1000/mon.c
+++ b/drivers/net/wireless/microchip/wilc1000/mon.c
@@ -233,7 +233,7 @@ struct net_device *wilc_wfi_init_mon_interface(struct wilc *wl,
 	wl->monitor_dev->netdev_ops = &wilc_wfi_netdev_ops;
 	wl->monitor_dev->needs_free_netdev = true;
 
-	if (register_netdevice(wl->monitor_dev)) {
+	if (cfg80211_register_netdevice(wl->monitor_dev)) {
 		netdev_err(real_dev, "register_netdevice failed\n");
 		free_netdev(wl->monitor_dev);
 		return NULL;
@@ -251,7 +251,7 @@ void wilc_wfi_deinit_mon_interface(struct wilc *wl, bool rtnl_locked)
 		return;
 
 	if (rtnl_locked)
-		unregister_netdevice(wl->monitor_dev);
+		cfg80211_unregister_netdevice(wl->monitor_dev);
 	else
 		unregister_netdev(wl->monitor_dev);
 	wl->monitor_dev = NULL;
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net/wireless/microchip/wilc1000/netdev.c
index 2a1fbbdd6a4b..643cbb155439 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -950,7 +950,7 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
 	vif->priv.dev = ndev;
 
 	if (rtnl_locked)
-		ret = register_netdevice(ndev);
+		ret = cfg80211_register_netdevice(ndev);
 	else
 		ret = register_netdev(ndev);
 
diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index 54cdf3ad09d7..504b4d0b98c4 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -180,7 +180,7 @@ int qtnf_del_virtual_intf(struct wiphy *wiphy, struct wireless_dev *wdev)
 	cancel_work_sync(&vif->high_pri_tx_work);
 
 	if (netdev->reg_state == NETREG_REGISTERED)
-		unregister_netdevice(netdev);
+		cfg80211_unregister_netdevice(netdev);
 
 	if (qtnf_cmd_send_del_intf(vif))
 		pr_err("VIF%u.%u: failed to delete VIF\n", vif->mac->macid,
@@ -267,7 +267,7 @@ static struct wireless_dev *qtnf_add_virtual_intf(struct wiphy *wiphy,
 	if (qtnf_hwcap_is_set(&mac->bus->hw_info, QLINK_HW_CAPAB_HW_BRIDGE)) {
 		ret = qtnf_cmd_netdev_changeupper(vif, vif->netdev->ifindex);
 		if (ret) {
-			unregister_netdevice(vif->netdev);
+			cfg80211_unregister_netdevice(vif->netdev);
 			vif->netdev = NULL;
 			goto error_del_vif;
 		}
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index ad726bd100ec..18964e2a9f28 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -492,7 +492,7 @@ int qtnf_core_net_attach(struct qtnf_wmac *mac, struct qtnf_vif *vif,
 
 	SET_NETDEV_DEV(dev, wiphy_dev(wiphy));
 
-	ret = register_netdevice(dev);
+	ret = cfg80211_register_netdevice(dev);
 	if (ret) {
 		free_netdev(dev);
 		vif->netdev = NULL;
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 798f8eb15e00..e7703fdbac8d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5228,6 +5228,7 @@ struct cfg80211_cqm_config;
  *
  * @wiphy: pointer to hardware description
  * @iftype: interface type
+ * @registered: is this wdev already registered with cfg80211
  * @list: (private) Used to collect the interfaces
  * @netdev: (private) Used to reference back to the netdev, may be %NULL
  * @identifier: (private) Identifier used in nl80211 to identify this
@@ -5311,7 +5312,7 @@ struct wireless_dev {
 
 	struct mutex mtx;
 
-	bool use_4addr, is_running;
+	bool use_4addr, is_running, registered;
 
 	u8 address[ETH_ALEN] __aligned(sizeof(u16));
 
@@ -7654,18 +7655,41 @@ u32 cfg80211_calculate_bitrate(struct rate_info *rate);
  * cfg80211_unregister_wdev - remove the given wdev
  * @wdev: struct wireless_dev to remove
  *
- * Call this function only for wdevs that have no netdev assigned,
- * e.g. P2P Devices. It removes the device from the list so that
- * it can no longer be used. It is necessary to call this function
- * even when cfg80211 requests the removal of the interface by
- * calling the del_virtual_intf() callback. The function must also
- * be called when the driver wishes to unregister the wdev, e.g.
- * when the device is unbound from the driver.
+ * This function removes the device so it can no longer be used. It is necessary
+ * to call this function even when cfg80211 requests the removal of the device
+ * by calling the del_virtual_intf() callback. The function must also be called
+ * when the driver wishes to unregister the wdev, e.g. when the hardware device
+ * is unbound from the driver.
  *
  * Requires the RTNL to be held.
  */
 void cfg80211_unregister_wdev(struct wireless_dev *wdev);
 
+/**
+ * cfg80211_register_netdevice - register the given netdev
+ * @dev: the netdev to register
+ *
+ * Note: In contexts coming from cfg80211 callbacks, you must call this rather
+ * than register_netdevice(), unregister_netdev() is impossible as the RTNL is
+ * held. Otherwise, both register_netdevice() and register_netdev() are usable
+ * instead as well.
+ */
+int cfg80211_register_netdevice(struct net_device *dev);
+
+/**
+ * cfg80211_unregister_netdevice - unregister the given netdev
+ * @dev: the netdev to register
+ *
+ * Note: In contexts coming from cfg80211 callbacks, you must call this rather
+ * than unregister_netdevice(), unregister_netdev() is impossible as the RTNL
+ * is held. Otherwise, both unregister_netdevice() and unregister_netdev() are
+ * usable instead as well.
+ */
+static inline void cfg80211_unregister_netdevice(struct net_device *dev)
+{
+	cfg80211_unregister_wdev(dev->ieee80211_ptr);
+}
+
 /**
  * struct cfg80211_ft_event_params - FT Information Elements
  * @ies: FT IEs
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 1b44690823aa..fcaf4d20cabf 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1976,7 +1976,7 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 		ndev->min_mtu = 256;
 		ndev->max_mtu = local->hw.max_mtu;
 
-		ret = register_netdevice(ndev);
+		ret = cfg80211_register_netdevice(ndev);
 		if (ret) {
 			free_netdev(ndev);
 			return ret;
@@ -2006,10 +2006,9 @@ void ieee80211_if_remove(struct ieee80211_sub_if_data *sdata)
 
 	synchronize_rcu();
 
-	if (sdata->dev) {
-		unregister_netdevice(sdata->dev);
-	} else {
-		cfg80211_unregister_wdev(&sdata->wdev);
+	cfg80211_unregister_wdev(&sdata->wdev);
+
+	if (!sdata->dev) {
 		ieee80211_teardown_sdata(sdata);
 		kfree(sdata);
 	}
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 4b1f35e976e7..9e7d1f9620bd 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1094,7 +1094,8 @@ void cfg80211_cqm_config_free(struct wireless_dev *wdev)
 	wdev->cqm_config = NULL;
 }
 
-static void __cfg80211_unregister_wdev(struct wireless_dev *wdev, bool sync)
+static void _cfg80211_unregister_wdev(struct wireless_dev *wdev,
+				      bool unregister_netdev)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 
@@ -1104,9 +1105,16 @@ static void __cfg80211_unregister_wdev(struct wireless_dev *wdev, bool sync)
 
 	nl80211_notify_iface(rdev, wdev, NL80211_CMD_DEL_INTERFACE);
 
+	wdev->registered = false;
+
+	if (wdev->netdev) {
+		sysfs_remove_link(&wdev->netdev->dev.kobj, "phy80211");
+		if (unregister_netdev)
+			unregister_netdevice(wdev->netdev);
+	}
+
 	list_del_rcu(&wdev->list);
-	if (sync)
-		synchronize_rcu();
+	synchronize_net();
 	rdev->devlist_generation++;
 
 	cfg80211_mlme_purge_registrations(wdev);
@@ -1131,14 +1139,23 @@ static void __cfg80211_unregister_wdev(struct wireless_dev *wdev, bool sync)
 		flush_work(&wdev->disconnect_wk);
 
 	cfg80211_cqm_config_free(wdev);
+
+	/*
+	 * Ensure that all events have been processed and
+	 * freed.
+	 */
+	cfg80211_process_wdev_events(wdev);
+
+	if (WARN_ON(wdev->current_bss)) {
+		cfg80211_unhold_bss(wdev->current_bss);
+		cfg80211_put_bss(wdev->wiphy, &wdev->current_bss->pub);
+		wdev->current_bss = NULL;
+	}
 }
 
 void cfg80211_unregister_wdev(struct wireless_dev *wdev)
 {
-	if (WARN_ON(wdev->netdev))
-		return;
-
-	__cfg80211_unregister_wdev(wdev, true);
+	_cfg80211_unregister_wdev(wdev, true);
 }
 EXPORT_SYMBOL(cfg80211_unregister_wdev);
 
@@ -1290,10 +1307,49 @@ void cfg80211_register_wdev(struct cfg80211_registered_device *rdev,
 		wdev->identifier = ++rdev->wdev_id;
 	list_add_rcu(&wdev->list, &rdev->wiphy.wdev_list);
 	rdev->devlist_generation++;
+	wdev->registered = true;
 
 	nl80211_notify_iface(rdev, wdev, NL80211_CMD_NEW_INTERFACE);
 }
 
+int cfg80211_register_netdevice(struct net_device *dev)
+{
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct cfg80211_registered_device *rdev;
+	int ret;
+
+	ASSERT_RTNL();
+
+	if (WARN_ON(!wdev))
+		return -EINVAL;
+
+	rdev = wiphy_to_rdev(wdev->wiphy);
+
+	lockdep_assert_held(&rdev->wiphy.mtx);
+
+	/* we'll take care of this */
+	wdev->registered = true;
+	ret = register_netdevice(dev);
+	if (ret)
+		goto out;
+
+	if (sysfs_create_link(&dev->dev.kobj, &rdev->wiphy.dev.kobj,
+			      "phy80211")) {
+		pr_err("failed to add phy80211 symlink to netdev!\n");
+		unregister_netdevice(dev);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	cfg80211_register_wdev(rdev, wdev);
+	ret = 0;
+out:
+	if (ret)
+		wdev->registered = false;
+	return ret;
+}
+EXPORT_SYMBOL(cfg80211_register_netdevice);
+
 static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 					 unsigned long state, void *ptr)
 {
@@ -1319,17 +1375,16 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		cfg80211_init_wdev(wdev);
 		break;
 	case NETDEV_REGISTER:
+		if (!wdev->registered)
+			cfg80211_register_wdev(rdev, wdev);
+		break;
+	case NETDEV_UNREGISTER:
 		/*
-		 * NB: cannot take rdev->mtx here because this may be
-		 * called within code protected by it when interfaces
-		 * are added with nl80211.
+		 * It is possible to get NETDEV_UNREGISTER multiple times,
+		 * so check wdev->registered.
 		 */
-		if (sysfs_create_link(&dev->dev.kobj, &rdev->wiphy.dev.kobj,
-				      "phy80211")) {
-			pr_err("failed to add phy80211 symlink to netdev!\n");
-		}
-
-		cfg80211_register_wdev(rdev, wdev);
+		if (wdev->registered)
+			_cfg80211_unregister_wdev(wdev, false);
 		break;
 	case NETDEV_GOING_DOWN:
 		cfg80211_leave(rdev, wdev);
@@ -1401,38 +1456,6 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 			wdev->ps = false;
 		}
 		break;
-	case NETDEV_UNREGISTER:
-		/*
-		 * It is possible to get NETDEV_UNREGISTER
-		 * multiple times. To detect that, check
-		 * that the interface is still on the list
-		 * of registered interfaces, and only then
-		 * remove and clean it up.
-		 */
-		if (!list_empty(&wdev->list)) {
-			__cfg80211_unregister_wdev(wdev, false);
-			sysfs_remove_link(&dev->dev.kobj, "phy80211");
-		}
-		/*
-		 * synchronise (so that we won't find this netdev
-		 * from other code any more) and then clear the list
-		 * head so that the above code can safely check for
-		 * !list_empty() to avoid double-cleanup.
-		 */
-		synchronize_rcu();
-		INIT_LIST_HEAD(&wdev->list);
-		/*
-		 * Ensure that all events have been processed and
-		 * freed.
-		 */
-		cfg80211_process_wdev_events(wdev);
-
-		if (WARN_ON(wdev->current_bss)) {
-			cfg80211_unhold_bss(wdev->current_bss);
-			cfg80211_put_bss(wdev->wiphy, &wdev->current_bss->pub);
-			wdev->current_bss = NULL;
-		}
-		break;
 	case NETDEV_PRE_UP:
 		if (!cfg80211_iftype_allowed(wdev->wiphy, wdev->iftype,
 					     wdev->use_4addr, 0))
-- 
2.26.2

