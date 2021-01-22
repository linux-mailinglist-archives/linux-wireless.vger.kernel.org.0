Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE479300727
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jan 2021 16:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbhAVPZZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jan 2021 10:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbhAVPUs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jan 2021 10:20:48 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08311C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 22 Jan 2021 07:19:51 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l2yE0-00ABsc-8K; Fri, 22 Jan 2021 16:19:48 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 2/2] cfg80211: avoid holding the RTNL when calling the driver
Date:   Fri, 22 Jan 2021 16:19:43 +0100
Message-Id: <20210122161942.81df9f5e047a.I4a8e1a60b18863ea8c5e6d3a0faeafb2d45b2f40@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210122161942.cf2f4b65e4e9.Ida8234e50da13eb675b557bac52a713ad4eddf71@changeid>
References: <20210122161942.cf2f4b65e4e9.Ida8234e50da13eb675b557bac52a713ad4eddf71@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
we need to have it anyway for netdev management, but we only
hold the RTNL for very short periods of time here.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/ath/ath11k/reg.c         |   4 +-
 drivers/net/wireless/ath/ath6kl/core.c        |   2 +
 drivers/net/wireless/ath/ath6kl/init.c        |   2 +
 drivers/net/wireless/ath/wil6210/cfg80211.c   |   2 +
 drivers/net/wireless/ath/wil6210/netdev.c     |   7 +-
 drivers/net/wireless/ath/wil6210/pcie_bus.c   |   2 +
 .../broadcom/brcm80211/brcmfmac/core.c        |  18 +-
 .../broadcom/brcm80211/brcmfmac/core.h        |   6 +-
 .../broadcom/brcm80211/brcmfmac/p2p.c         |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |   2 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |   6 +-
 drivers/net/wireless/marvell/mwifiex/main.c   |   7 +
 drivers/net/wireless/quantenna/qtnfmac/core.c |   3 +-
 drivers/net/wireless/virt_wifi.c              |   8 +
 include/net/cfg80211.h                        | 104 ++-
 include/net/mac80211.h                        |  10 +-
 net/mac80211/iface.c                          |  14 +-
 net/mac80211/key.c                            |   4 +-
 net/mac80211/main.c                           |   5 +
 net/mac80211/pm.c                             |   6 +-
 net/mac80211/tdls.c                           |   6 +-
 net/mac80211/util.c                           |  14 +-
 net/wireless/chan.c                           |   5 +-
 net/wireless/core.c                           |  47 +-
 net/wireless/core.h                           |   2 +-
 net/wireless/debugfs.c                        |   4 -
 net/wireless/ibss.c                           |   3 +-
 net/wireless/mlme.c                           |   6 +-
 net/wireless/nl80211.c                        | 657 ++++++++++--------
 net/wireless/reg.c                            |  91 ++-
 net/wireless/reg.h                            |   1 -
 net/wireless/scan.c                           |  35 +-
 net/wireless/sme.c                            |   5 +-
 net/wireless/sysfs.c                          |   5 +
 net/wireless/util.c                           |   4 +-
 net/wireless/wext-compat.c                    | 271 ++++++--
 net/wireless/wext-sme.c                       |   4 +-
 39 files changed, 881 insertions(+), 509 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index b876fec7fa1b..e1a1df169034 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -247,7 +247,9 @@ int ath11k_regd_update(struct ath11k *ar, bool init)
 	}
 
 	rtnl_lock();
-	ret = regulatory_set_wiphy_regd_sync_rtnl(ar->hw->wiphy, regd_copy);
+	wiphy_lock(ar->hw->wiphy);
+	ret = regulatory_set_wiphy_regd_sync(ar->hw->wiphy, regd_copy);
+	wiphy_unlock(ar->hw->wiphy);
 	rtnl_unlock();
 
 	kfree(regd_copy);
diff --git a/drivers/net/wireless/ath/ath6kl/core.c b/drivers/net/wireless/ath/ath6kl/core.c
index ebb9f163710f..4f0a7a185fc9 100644
--- a/drivers/net/wireless/ath/ath6kl/core.c
+++ b/drivers/net/wireless/ath/ath6kl/core.c
@@ -212,11 +212,13 @@ int ath6kl_core_init(struct ath6kl *ar, enum ath6kl_htc_type htc_type)
 		ar->avail_idx_map |= BIT(i);
 
 	rtnl_lock();
+	wiphy_lock(ar->wiphy);
 
 	/* Add an initial station interface */
 	wdev = ath6kl_interface_add(ar, "wlan%d", NET_NAME_ENUM,
 				    NL80211_IFTYPE_STATION, 0, INFRA_NETWORK);
 
+	wiphy_unlock(ar->wiphy);
 	rtnl_unlock();
 
 	if (!wdev) {
diff --git a/drivers/net/wireless/ath/ath6kl/init.c b/drivers/net/wireless/ath/ath6kl/init.c
index 39bf19686175..9b5c7d8f2b95 100644
--- a/drivers/net/wireless/ath/ath6kl/init.c
+++ b/drivers/net/wireless/ath/ath6kl/init.c
@@ -1904,7 +1904,9 @@ void ath6kl_stop_txrx(struct ath6kl *ar)
 		spin_unlock_bh(&ar->list_lock);
 		ath6kl_cfg80211_vif_stop(vif, test_bit(WMI_READY, &ar->flag));
 		rtnl_lock();
+		wiphy_lock(ar->wiphy);
 		ath6kl_cfg80211_vif_cleanup(vif);
+		wiphy_unlock(ar->wiphy);
 		rtnl_unlock();
 		spin_lock_bh(&ar->list_lock);
 	}
diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 1c42410d68e1..60bba5b491e0 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -2820,7 +2820,9 @@ void wil_p2p_wdev_free(struct wil6210_priv *wil)
 	wil->radio_wdev = wil->main_ndev->ieee80211_ptr;
 	mutex_unlock(&wil->vif_mutex);
 	if (p2p_wdev) {
+		wiphy_lock(wil->wiphy);
 		cfg80211_unregister_wdev(p2p_wdev);
+		wiphy_unlock(wil->wiphy);
 		kfree(p2p_wdev);
 	}
 }
diff --git a/drivers/net/wireless/ath/wil6210/netdev.c b/drivers/net/wireless/ath/wil6210/netdev.c
index 472fe804203d..0913f0bf60e7 100644
--- a/drivers/net/wireless/ath/wil6210/netdev.c
+++ b/drivers/net/wireless/ath/wil6210/netdev.c
@@ -473,7 +473,9 @@ int wil_if_add(struct wil6210_priv *wil)
 	wil_update_net_queues_bh(wil, vif, NULL, true);
 
 	rtnl_lock();
+	wiphy_lock(wiphy);
 	rc = wil_vif_add(wil, vif);
+	wiphy_unlock(wiphy);
 	rtnl_unlock();
 	if (rc < 0)
 		goto out_wiphy;
@@ -543,15 +545,18 @@ void wil_if_remove(struct wil6210_priv *wil)
 {
 	struct net_device *ndev = wil->main_ndev;
 	struct wireless_dev *wdev = ndev->ieee80211_ptr;
+	struct wiphy *wiphy = wdev->wiphy;
 
 	wil_dbg_misc(wil, "if_remove\n");
 
 	rtnl_lock();
+	wiphy_lock(wiphy);
 	wil_vif_remove(wil, 0);
+	wiphy_unlock(wiphy);
 	rtnl_unlock();
 
 	netif_napi_del(&wil->napi_tx);
 	netif_napi_del(&wil->napi_rx);
 
-	wiphy_unregister(wdev->wiphy);
+	wiphy_unregister(wiphy);
 }
diff --git a/drivers/net/wireless/ath/wil6210/pcie_bus.c b/drivers/net/wireless/ath/wil6210/pcie_bus.c
index c174323c5c0b..ce40d94909ad 100644
--- a/drivers/net/wireless/ath/wil6210/pcie_bus.c
+++ b/drivers/net/wireless/ath/wil6210/pcie_bus.c
@@ -473,8 +473,10 @@ static void wil_pcie_remove(struct pci_dev *pdev)
 
 	wil6210_debugfs_remove(wil);
 	rtnl_lock();
+	wiphy_lock(wil->wiphy);
 	wil_p2p_wdev_free(wil);
 	wil_remove_all_additional_vifs(wil);
+	wiphy_unlock(wil->wiphy);
 	rtnl_unlock();
 	wil_if_remove(wil);
 	wil_if_pcie_disable(wil);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 6cf308d5934c..ea78fe527c5d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -633,7 +633,7 @@ static const struct net_device_ops brcmf_netdev_ops_pri = {
 	.ndo_set_rx_mode = brcmf_netdev_set_multicast_list
 };
 
-int brcmf_net_attach(struct brcmf_if *ifp, bool rtnl_locked)
+int brcmf_net_attach(struct brcmf_if *ifp, bool locked)
 {
 	struct brcmf_pub *drvr = ifp->drvr;
 	struct net_device *ndev;
@@ -656,7 +656,7 @@ int brcmf_net_attach(struct brcmf_if *ifp, bool rtnl_locked)
 	INIT_WORK(&ifp->multicast_work, _brcmf_set_multicast_list);
 	INIT_WORK(&ifp->ndoffload_work, _brcmf_update_ndtable);
 
-	if (rtnl_locked)
+	if (locked)
 		err = cfg80211_register_netdevice(ndev);
 	else
 		err = register_netdev(ndev);
@@ -677,10 +677,10 @@ int brcmf_net_attach(struct brcmf_if *ifp, bool rtnl_locked)
 	return -EBADE;
 }
 
-void brcmf_net_detach(struct net_device *ndev, bool rtnl_locked)
+void brcmf_net_detach(struct net_device *ndev, bool locked)
 {
 	if (ndev->reg_state == NETREG_REGISTERED) {
-		if (rtnl_locked)
+		if (locked)
 			cfg80211_unregister_netdevice(ndev);
 		else
 			unregister_netdev(ndev);
@@ -909,7 +909,7 @@ struct brcmf_if *brcmf_add_if(struct brcmf_pub *drvr, s32 bsscfgidx, s32 ifidx,
 }
 
 static void brcmf_del_if(struct brcmf_pub *drvr, s32 bsscfgidx,
-			 bool rtnl_locked)
+			 bool locked)
 {
 	struct brcmf_if *ifp;
 	int ifidx;
@@ -938,7 +938,7 @@ static void brcmf_del_if(struct brcmf_pub *drvr, s32 bsscfgidx,
 			cancel_work_sync(&ifp->multicast_work);
 			cancel_work_sync(&ifp->ndoffload_work);
 		}
-		brcmf_net_detach(ifp->ndev, rtnl_locked);
+		brcmf_net_detach(ifp->ndev, locked);
 	} else {
 		/* Only p2p device interfaces which get dynamically created
 		 * end up here. In this case the p2p module should be informed
@@ -947,7 +947,7 @@ static void brcmf_del_if(struct brcmf_pub *drvr, s32 bsscfgidx,
 		 * serious troublesome side effects. The p2p module will clean
 		 * up the ifp if needed.
 		 */
-		brcmf_p2p_ifp_removed(ifp, rtnl_locked);
+		brcmf_p2p_ifp_removed(ifp, locked);
 		kfree(ifp);
 	}
 
@@ -956,14 +956,14 @@ static void brcmf_del_if(struct brcmf_pub *drvr, s32 bsscfgidx,
 		drvr->if2bss[ifidx] = BRCMF_BSSIDX_INVALID;
 }
 
-void brcmf_remove_interface(struct brcmf_if *ifp, bool rtnl_locked)
+void brcmf_remove_interface(struct brcmf_if *ifp, bool locked)
 {
 	if (!ifp || WARN_ON(ifp->drvr->iflist[ifp->bsscfgidx] != ifp))
 		return;
 	brcmf_dbg(TRACE, "Enter, bsscfgidx=%d, ifidx=%d\n", ifp->bsscfgidx,
 		  ifp->ifidx);
 	brcmf_proto_del_if(ifp->drvr, ifp);
-	brcmf_del_if(ifp->drvr, ifp->bsscfgidx, rtnl_locked);
+	brcmf_del_if(ifp->drvr, ifp->bsscfgidx, locked);
 }
 
 static int brcmf_psm_watchdog_notify(struct brcmf_if *ifp,
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
index 5767d665cee5..8212c9de14f1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.h
@@ -201,16 +201,16 @@ int brcmf_netdev_wait_pend8021x(struct brcmf_if *ifp);
 char *brcmf_ifname(struct brcmf_if *ifp);
 struct brcmf_if *brcmf_get_ifp(struct brcmf_pub *drvr, int ifidx);
 void brcmf_configure_arp_nd_offload(struct brcmf_if *ifp, bool enable);
-int brcmf_net_attach(struct brcmf_if *ifp, bool rtnl_locked);
+int brcmf_net_attach(struct brcmf_if *ifp, bool locked);
 struct brcmf_if *brcmf_add_if(struct brcmf_pub *drvr, s32 bsscfgidx, s32 ifidx,
 			      bool is_p2pdev, const char *name, u8 *mac_addr);
-void brcmf_remove_interface(struct brcmf_if *ifp, bool rtnl_locked);
+void brcmf_remove_interface(struct brcmf_if *ifp, bool locked);
 void brcmf_txflowblock_if(struct brcmf_if *ifp,
 			  enum brcmf_netif_stop_reason reason, bool state);
 void brcmf_txfinalize(struct brcmf_if *ifp, struct sk_buff *txp, bool success);
 void brcmf_netif_rx(struct brcmf_if *ifp, struct sk_buff *skb, bool inirq);
 void brcmf_netif_mon_rx(struct brcmf_if *ifp, struct sk_buff *skb);
-void brcmf_net_detach(struct net_device *ndev, bool rtnl_locked);
+void brcmf_net_detach(struct net_device *ndev, bool locked);
 int brcmf_net_mon_attach(struct brcmf_if *ifp);
 void brcmf_net_setcarrier(struct brcmf_if *ifp, bool on);
 int __init brcmf_core_init(void);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index ec6fc7a150a6..6d30a0fcecea 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -2430,7 +2430,7 @@ int brcmf_p2p_del_vif(struct wiphy *wiphy, struct wireless_dev *wdev)
 	return err;
 }
 
-void brcmf_p2p_ifp_removed(struct brcmf_if *ifp, bool rtnl_locked)
+void brcmf_p2p_ifp_removed(struct brcmf_if *ifp, bool locked)
 {
 	struct brcmf_cfg80211_info *cfg;
 	struct brcmf_cfg80211_vif *vif;
@@ -2439,11 +2439,15 @@ void brcmf_p2p_ifp_removed(struct brcmf_if *ifp, bool rtnl_locked)
 	vif = ifp->vif;
 	cfg = wdev_to_cfg(&vif->wdev);
 	cfg->p2p.bss_idx[P2PAPI_BSSCFG_DEVICE].vif = NULL;
-	if (!rtnl_locked)
+	if (locked) {
 		rtnl_lock();
-	cfg80211_unregister_wdev(&vif->wdev);
-	if (!rtnl_locked)
+		wiphy_lock(cfg->wiphy);
+		cfg80211_unregister_wdev(&vif->wdev);
+		wiphy_unlock(cfg->wiphy);
 		rtnl_unlock();
+	} else {
+		cfg80211_unregister_wdev(&vif->wdev);
+	}
 	brcmf_free_vif(vif);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index c025188fa9bc..a0b7331cab31 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2143,7 +2143,7 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 
 out_iterate:
 	if (!test)
-		ieee80211_iterate_active_interfaces_rtnl(mvm->hw,
+		ieee80211_iterate_active_interfaces_mtx(mvm->hw,
 			IEEE80211_IFACE_ITER_NORMAL,
 			iwl_mvm_d3_disconnect_iter, keep ? vif : NULL);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index da32937ba9a7..6cce72b0685b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -260,7 +260,7 @@ int iwl_mvm_init_fw_regd(struct iwl_mvm *mvm)
 	int ret;
 	bool changed;
 	const struct ieee80211_regdomain *r =
-			rtnl_dereference(mvm->hw->wiphy->regd);
+			wiphy_dereference(mvm->hw->wiphy, mvm->hw->wiphy->regd);
 
 	if (!r)
 		return -ENOENT;
@@ -282,7 +282,7 @@ int iwl_mvm_init_fw_regd(struct iwl_mvm *mvm)
 
 	/* update cfg80211 if the regdomain was changed */
 	if (changed)
-		ret = regulatory_set_wiphy_regd_sync_rtnl(mvm->hw->wiphy, regd);
+		ret = regulatory_set_wiphy_regd_sync(mvm->hw->wiphy, regd);
 	else
 		ret = 0;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index abb8c1088c2f..7fb4e618f76e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -545,7 +545,7 @@ int iwl_mvm_init_mcc(struct iwl_mvm *mvm)
 			return -EIO;
 	}
 
-	retval = regulatory_set_wiphy_regd_sync_rtnl(mvm->hw->wiphy, regd);
+	retval = regulatory_set_wiphy_regd_sync(mvm->hw->wiphy, regd);
 	kfree(regd);
 	return retval;
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 15e1cee7f465..5553df913290 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -2097,7 +2097,7 @@ mwifiex_cfg80211_disconnect(struct wiphy *wiphy, struct net_device *dev,
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 
 	if (!mwifiex_stop_bg_scan(priv))
-		cfg80211_sched_scan_stopped_rtnl(priv->wdev.wiphy, 0);
+		cfg80211_sched_scan_stopped_locked(priv->wdev.wiphy, 0);
 
 	if (mwifiex_deauthenticate(priv, NULL))
 		return -EFAULT;
@@ -2366,7 +2366,7 @@ mwifiex_cfg80211_connect(struct wiphy *wiphy, struct net_device *dev,
 		    (int)sme->ssid_len, (char *)sme->ssid, sme->bssid);
 
 	if (!mwifiex_stop_bg_scan(priv))
-		cfg80211_sched_scan_stopped_rtnl(priv->wdev.wiphy, 0);
+		cfg80211_sched_scan_stopped_locked(priv->wdev.wiphy, 0);
 
 	ret = mwifiex_cfg80211_assoc(priv, sme->ssid_len, sme->ssid, sme->bssid,
 				     priv->bss_mode, sme->channel, sme, 0);
@@ -2576,7 +2576,7 @@ mwifiex_cfg80211_scan(struct wiphy *wiphy,
 		priv->scan_block = false;
 
 	if (!mwifiex_stop_bg_scan(priv))
-		cfg80211_sched_scan_stopped_rtnl(priv->wdev.wiphy, 0);
+		cfg80211_sched_scan_stopped_locked(priv->wdev.wiphy, 0);
 
 	user_scan_cfg = kzalloc(sizeof(*user_scan_cfg), GFP_KERNEL);
 	if (!user_scan_cfg)
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index ee52fb839ef7..529dfd8b7ae8 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -598,12 +598,14 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 	}
 
 	rtnl_lock();
+	wiphy_lock(adapter->wiphy);
 	/* Create station interface by default */
 	wdev = mwifiex_add_virtual_intf(adapter->wiphy, "mlan%d", NET_NAME_ENUM,
 					NL80211_IFTYPE_STATION, NULL);
 	if (IS_ERR(wdev)) {
 		mwifiex_dbg(adapter, ERROR,
 			    "cannot create default STA interface\n");
+		wiphy_unlock(adapter->wiphy);
 		rtnl_unlock();
 		goto err_add_intf;
 	}
@@ -614,6 +616,7 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 		if (IS_ERR(wdev)) {
 			mwifiex_dbg(adapter, ERROR,
 				    "cannot create AP interface\n");
+			wiphy_unlock(adapter->wiphy);
 			rtnl_unlock();
 			goto err_add_intf;
 		}
@@ -625,10 +628,12 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 		if (IS_ERR(wdev)) {
 			mwifiex_dbg(adapter, ERROR,
 				    "cannot create p2p client interface\n");
+			wiphy_unlock(adapter->wiphy);
 			rtnl_unlock();
 			goto err_add_intf;
 		}
 	}
+	wiphy_unlock(adapter->wiphy);
 	rtnl_unlock();
 
 	mwifiex_drv_get_driver_version(adapter, fmt, sizeof(fmt) - 1);
@@ -1440,9 +1445,11 @@ static void mwifiex_uninit_sw(struct mwifiex_adapter *adapter)
 		if (!priv)
 			continue;
 		rtnl_lock();
+		wiphy_lock(adapter->wiphy);
 		if (priv->netdev &&
 		    priv->wdev.iftype != NL80211_IFTYPE_UNSPECIFIED)
 			mwifiex_del_virtual_intf(adapter->wiphy, &priv->wdev);
+		wiphy_unlock(adapter->wiphy);
 		rtnl_unlock();
 	}
 
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index 18964e2a9f28..b4dd60b2ebc9 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -611,8 +611,9 @@ static int qtnf_core_mac_attach(struct qtnf_bus *bus, unsigned int macid)
 	mac->wiphy_registered = 1;
 
 	rtnl_lock();
-
+	wiphy_lock(priv_to_wiphy(mac));
 	ret = qtnf_core_net_attach(mac, vif, "wlan%d", NET_NAME_ENUM);
+	wiphy_unlock(priv_to_wiphy(mac));
 	rtnl_unlock();
 
 	if (ret) {
diff --git a/drivers/net/wireless/virt_wifi.c b/drivers/net/wireless/virt_wifi.c
index c878097f0dda..4b455a4ae15b 100644
--- a/drivers/net/wireless/virt_wifi.c
+++ b/drivers/net/wireless/virt_wifi.c
@@ -537,7 +537,9 @@ static int virt_wifi_newlink(struct net *src_net, struct net_device *dev,
 	dev->ieee80211_ptr->iftype = NL80211_IFTYPE_STATION;
 	dev->ieee80211_ptr->wiphy = common_wiphy;
 
+	wiphy_lock(common_wiphy);
 	err = register_netdevice(dev);
+	wiphy_unlock(common_wiphy);
 	if (err) {
 		dev_err(&priv->lowerdev->dev, "can't register_netdevice: %d\n",
 			err);
@@ -560,7 +562,9 @@ static int virt_wifi_newlink(struct net *src_net, struct net_device *dev,
 
 	return 0;
 unregister_netdev:
+	wiphy_lock(common_wiphy);
 	unregister_netdevice(dev);
+	wiphy_unlock(common_wiphy);
 free_wireless_dev:
 	kfree(dev->ieee80211_ptr);
 	dev->ieee80211_ptr = NULL;
@@ -586,7 +590,9 @@ static void virt_wifi_dellink(struct net_device *dev,
 	netdev_rx_handler_unregister(priv->lowerdev);
 	netdev_upper_dev_unlink(priv->lowerdev, dev);
 
+	wiphy_lock(common_wiphy);
 	unregister_netdevice_queue(dev, head);
+	wiphy_unlock(common_wiphy);
 	module_put(THIS_MODULE);
 
 	/* Deleting the wiphy is handled in the module destructor. */
@@ -625,7 +631,9 @@ static int virt_wifi_event(struct notifier_block *this, unsigned long event,
 		upper_dev = priv->upperdev;
 
 		upper_dev->rtnl_link_ops->dellink(upper_dev, &list_kill);
+		wiphy_lock(common_wiphy);
 		unregister_netdevice_many(&list_kill);
+		wiphy_unlock(common_wiphy);
 		break;
 	}
 
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e7703fdbac8d..4741d71ead21 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3632,9 +3632,10 @@ struct mgmt_frame_regs {
  * All callbacks except where otherwise noted should return 0
  * on success or a negative error code.
  *
- * All operations are currently invoked under rtnl for consistency with the
- * wireless extensions but this is subject to reevaluation as soon as this
- * code is used more widely and we have a first user without wext.
+ * All operations are invoked with the wiphy mutex held. The RTNL may be
+ * held in addition (due to wireless extensions) but this cannot be relied
+ * upon except in cases where documented below. Note that due to ordering,
+ * the RTNL also cannot be acquired in any handlers.
  *
  * @suspend: wiphy device needs to be suspended. The variable @wow will
  *	be %NULL or contain the enabled Wake-on-Wireless triggers that are
@@ -3649,11 +3650,14 @@ struct mgmt_frame_regs {
  *	the new netdev in the wiphy's network namespace! Returns the struct
  *	wireless_dev, or an ERR_PTR. For P2P device wdevs, the driver must
  *	also set the address member in the wdev.
+ *	This additionally holds the RTNL to be able to do netdev changes.
  *
  * @del_virtual_intf: remove the virtual interface
+ *	This additionally holds the RTNL to be able to do netdev changes.
  *
  * @change_virtual_intf: change type/configuration of virtual interface,
  *	keep the struct wireless_dev's iftype updated.
+ *	This additionally holds the RTNL to be able to do netdev changes.
  *
  * @add_key: add a key with the given parameters. @mac_addr will be %NULL
  *	when adding a group key.
@@ -4743,6 +4747,7 @@ struct wiphy_iftype_akm_suites {
 
 /**
  * struct wiphy - wireless hardware description
+ * @mtx: mutex for the data (structures) of this device
  * @reg_notifier: the driver's regulatory notification callback,
  *	note that if your driver uses wiphy_apply_custom_regulatory()
  *	the reg_notifier's request can be passed as NULL
@@ -4936,6 +4941,8 @@ struct wiphy_iftype_akm_suites {
  * @sar_capa: SAR control capabilities
  */
 struct wiphy {
+	struct mutex mtx;
+
 	/* assign these fields before you register the wiphy */
 
 	u8 perm_addr[ETH_ALEN];
@@ -5188,6 +5195,37 @@ static inline struct wiphy *wiphy_new(const struct cfg80211_ops *ops,
  */
 int wiphy_register(struct wiphy *wiphy);
 
+/* this is a define for better error reporting (file/line) */
+#define lockdep_assert_wiphy(wiphy) lockdep_assert_held(&(wiphy)->mtx)
+
+/**
+ * rcu_dereference_wiphy - rcu_dereference with debug checking
+ * @wiphy: the wiphy to check the locking on
+ * @p: The pointer to read, prior to dereferencing
+ *
+ * Do an rcu_dereference(p), but check caller either holds rcu_read_lock()
+ * or RTNL. Note: Please prefer wiphy_dereference() or rcu_dereference().
+ */
+#define rcu_dereference_wiphy(wiphy, p)				\
+        rcu_dereference_check(p, lockdep_is_held(&wiphy->mtx))
+
+/**
+ * wiphy_dereference - fetch RCU pointer when updates are prevented by wiphy mtx
+ * @wiphy: the wiphy to check the locking on
+ * @p: The pointer to read, prior to dereferencing
+ *
+ * Return the value of the specified RCU-protected pointer, but omit the
+ * READ_ONCE(), because caller holds the wiphy mutex used for updates.
+ */
+#define wiphy_dereference(wiphy, p)				\
+        rcu_dereference_protected(p, lockdep_is_held(&wiphy->mtx))
+
+/**
+ * get_wiphy_regdom - get custom regdomain for the given wiphy
+ * @wiphy: the wiphy to get the regdomain from
+ */
+const struct ieee80211_regdomain *get_wiphy_regdom(struct wiphy *wiphy);
+
 /**
  * wiphy_unregister - deregister a wiphy from cfg80211
  *
@@ -5212,6 +5250,35 @@ struct cfg80211_internal_bss;
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
+static inline void wiphy_lock(struct wiphy *wiphy)
+	__acquires(&wiphy->mtx)
+{
+	mutex_lock(&wiphy->mtx);
+	__acquire(&wiphy->mtx);
+}
+
+/**
+ * wiphy_unlock - unlock the wiphy again
+ * @wiphy: the wiphy to unlock
+ */
+static inline void wiphy_unlock(struct wiphy *wiphy)
+	__releases(&wiphy->mtx)
+{
+	__release(&wiphy->mtx);
+	mutex_unlock(&wiphy->mtx);
+}
+
 /**
  * struct wireless_dev - wireless device state
  *
@@ -5219,7 +5286,10 @@ struct cfg80211_cqm_config;
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
@@ -5981,18 +6051,18 @@ int regulatory_set_wiphy_regd(struct wiphy *wiphy,
 			      struct ieee80211_regdomain *rd);
 
 /**
- * regulatory_set_wiphy_regd_sync_rtnl - set regdom for self-managed drivers
+ * regulatory_set_wiphy_regd_sync - set regdom for self-managed drivers
  * @wiphy: the wireless device we want to process the regulatory domain on
  * @rd: the regulatory domain information to use for this wiphy
  *
- * This functions requires the RTNL to be held and applies the new regdomain
- * synchronously to this wiphy. For more details see
- * regulatory_set_wiphy_regd().
+ * This functions requires the RTNL and the wiphy mutex to be held and
+ * applies the new regdomain synchronously to this wiphy. For more details
+ * see regulatory_set_wiphy_regd().
  *
  * Return: 0 on success. -EINVAL, -EPERM
  */
-int regulatory_set_wiphy_regd_sync_rtnl(struct wiphy *wiphy,
-					struct ieee80211_regdomain *rd);
+int regulatory_set_wiphy_regd_sync(struct wiphy *wiphy,
+				   struct ieee80211_regdomain *rd);
 
 /**
  * wiphy_apply_custom_regulatory - apply a custom driver regulatory domain
@@ -6110,7 +6180,7 @@ void cfg80211_sched_scan_results(struct wiphy *wiphy, u64 reqid);
 void cfg80211_sched_scan_stopped(struct wiphy *wiphy, u64 reqid);
 
 /**
- * cfg80211_sched_scan_stopped_rtnl - notify that the scheduled scan has stopped
+ * cfg80211_sched_scan_stopped_locked - notify that the scheduled scan has stopped
  *
  * @wiphy: the wiphy on which the scheduled scan stopped
  * @reqid: identifier for the related scheduled scan request
@@ -6118,9 +6188,9 @@ void cfg80211_sched_scan_stopped(struct wiphy *wiphy, u64 reqid);
  * The driver can call this function to inform cfg80211 that the
  * scheduled scan had to be stopped, for whatever reason.  The driver
  * is then called back via the sched_scan_stop operation when done.
- * This function should be called with rtnl locked.
+ * This function should be called with the wiphy mutex held.
  */
-void cfg80211_sched_scan_stopped_rtnl(struct wiphy *wiphy, u64 reqid);
+void cfg80211_sched_scan_stopped_locked(struct wiphy *wiphy, u64 reqid);
 
 /**
  * cfg80211_inform_bss_frame_data - inform cfg80211 of a received BSS frame
@@ -7557,7 +7627,7 @@ bool cfg80211_reg_can_beacon(struct wiphy *wiphy,
  * also checks if IR-relaxation conditions apply, to allow beaconing under
  * more permissive conditions.
  *
- * Requires the RTNL to be held.
+ * Requires the wiphy mutex to be held.
  */
 bool cfg80211_reg_can_beacon_relax(struct wiphy *wiphy,
 				   struct cfg80211_chan_def *chandef,
@@ -7661,7 +7731,7 @@ u32 cfg80211_calculate_bitrate(struct rate_info *rate);
  * when the driver wishes to unregister the wdev, e.g. when the hardware device
  * is unbound from the driver.
  *
- * Requires the RTNL to be held.
+ * Requires the RTNL and wiphy mutex to be held.
  */
 void cfg80211_unregister_wdev(struct wireless_dev *wdev);
 
@@ -7673,6 +7743,8 @@ void cfg80211_unregister_wdev(struct wireless_dev *wdev);
  * than register_netdevice(), unregister_netdev() is impossible as the RTNL is
  * held. Otherwise, both register_netdevice() and register_netdev() are usable
  * instead as well.
+ *
+ * Requires the RTNL and wiphy mutex to be held.
  */
 int cfg80211_register_netdevice(struct net_device *dev);
 
@@ -7684,6 +7756,8 @@ int cfg80211_register_netdevice(struct net_device *dev);
  * than unregister_netdevice(), unregister_netdev() is impossible as the RTNL
  * is held. Otherwise, both unregister_netdevice() and unregister_netdev() are
  * usable instead as well.
+ *
+ * Requires the RTNL and wiphy mutex to be held.
  */
 static inline void cfg80211_unregister_netdevice(struct net_device *dev)
 {
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 176fe0d9f67f..2d1d629e5d14 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5529,7 +5529,7 @@ void ieee80211_iterate_active_interfaces_atomic(struct ieee80211_hw *hw,
 						void *data);
 
 /**
- * ieee80211_iterate_active_interfaces_rtnl - iterate active interfaces
+ * ieee80211_iterate_active_interfaces_mtx - iterate active interfaces
  *
  * This function iterates over the interfaces associated with a given
  * hardware that are currently active and calls the callback for them.
@@ -5540,12 +5540,12 @@ void ieee80211_iterate_active_interfaces_atomic(struct ieee80211_hw *hw,
  * @iterator: the iterator function to call, cannot sleep
  * @data: first argument of the iterator function
  */
-void ieee80211_iterate_active_interfaces_rtnl(struct ieee80211_hw *hw,
-					      u32 iter_flags,
-					      void (*iterator)(void *data,
+void ieee80211_iterate_active_interfaces_mtx(struct ieee80211_hw *hw,
+					     u32 iter_flags,
+					     void (*iterator)(void *data,
 						u8 *mac,
 						struct ieee80211_vif *vif),
-					      void *data);
+					     void *data);
 
 /**
  * ieee80211_iterate_stations_atomic - iterate stations
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index fcaf4d20cabf..4bc350cf4eee 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -357,11 +357,14 @@ static int ieee80211_open(struct net_device *dev)
 	if (err)
 		return err;
 
-	return ieee80211_do_open(&sdata->wdev, true);
+	wiphy_lock(sdata->local->hw.wiphy);
+	err = ieee80211_do_open(&sdata->wdev, true);
+	wiphy_unlock(sdata->local->hw.wiphy);
+
+	return err;
 }
 
-static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
-			      bool going_down)
+static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_down)
 {
 	struct ieee80211_local *local = sdata->local;
 	unsigned long flags;
@@ -637,7 +640,9 @@ static int ieee80211_stop(struct net_device *dev)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 
+	wiphy_lock(sdata->local->hw.wiphy);
 	ieee80211_do_stop(sdata, true);
+	wiphy_unlock(sdata->local->hw.wiphy);
 
 	return 0;
 }
@@ -2057,13 +2062,16 @@ void ieee80211_remove_interfaces(struct ieee80211_local *local)
 			list_add(&sdata->list, &wdev_list);
 	}
 	mutex_unlock(&local->iflist_mtx);
+
 	unregister_netdevice_many(&unreg_list);
 
+	wiphy_lock(local->hw.wiphy);
 	list_for_each_entry_safe(sdata, tmp, &wdev_list, list) {
 		list_del(&sdata->list);
 		cfg80211_unregister_wdev(&sdata->wdev);
 		kfree(sdata);
 	}
+	wiphy_unlock(local->hw.wiphy);
 }
 
 static int netdev_notify(struct notifier_block *nb,
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index a4817aa4b171..56c068cb49c4 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -887,7 +887,7 @@ void ieee80211_reenable_keys(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_key *key;
 	struct ieee80211_sub_if_data *vlan;
 
-	ASSERT_RTNL();
+	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	mutex_lock(&sdata->local->key_mtx);
 
@@ -924,7 +924,7 @@ void ieee80211_iter_keys(struct ieee80211_hw *hw,
 	struct ieee80211_key *key, *tmp;
 	struct ieee80211_sub_if_data *sdata;
 
-	ASSERT_RTNL();
+	lockdep_assert_wiphy(hw->wiphy);
 
 	mutex_lock(&local->key_mtx);
 	if (vif) {
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index dee88ec566ad..3c51cb9bee90 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -261,7 +261,9 @@ static void ieee80211_restart_work(struct work_struct *work)
 	     "%s called with hardware scan in progress\n", __func__);
 
 	flush_work(&local->radar_detected_work);
+	/* we might do interface manipulations, so need both */
 	rtnl_lock();
+	wiphy_lock(local->hw.wiphy);
 	list_for_each_entry(sdata, &local->interfaces, list) {
 		/*
 		 * XXX: there may be more work for other vif types and even
@@ -293,6 +295,7 @@ static void ieee80211_restart_work(struct work_struct *work)
 	synchronize_net();
 
 	ieee80211_reconfig(local);
+	wiphy_unlock(local->hw.wiphy);
 	rtnl_unlock();
 }
 
@@ -1278,8 +1281,10 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	    !ieee80211_hw_check(hw, NO_AUTO_VIF)) {
 		struct vif_params params = {0};
 
+		wiphy_lock(hw->wiphy);
 		result = ieee80211_if_add(local, "wlan%d", NET_NAME_ENUM, NULL,
 					  NL80211_IFTYPE_STATION, &params);
+		wiphy_unlock(hw->wiphy);
 		if (result)
 			wiphy_warn(local->hw.wiphy,
 				   "Failed to add default virtual iface\n");
diff --git a/net/mac80211/pm.c b/net/mac80211/pm.c
index ae378a41c927..7809a906d7fe 100644
--- a/net/mac80211/pm.c
+++ b/net/mac80211/pm.c
@@ -1,4 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * Portions
+ * Copyright (C) 2020-2021 Intel Corporation
+ */
 #include <net/mac80211.h>
 #include <net/rtnetlink.h>
 
@@ -11,7 +15,7 @@ static void ieee80211_sched_scan_cancel(struct ieee80211_local *local)
 {
 	if (ieee80211_request_sched_scan_stop(local))
 		return;
-	cfg80211_sched_scan_stopped_rtnl(local->hw.wiphy, 0);
+	cfg80211_sched_scan_stopped_locked(local->hw.wiphy, 0);
 }
 
 int __ieee80211_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index e01e4daeb8cd..f91d02b81b92 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1927,7 +1927,7 @@ ieee80211_process_tdls_channel_switch(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_tdls_data *tf = (void *)skb->data;
 	struct wiphy *wiphy = sdata->local->hw.wiphy;
 
-	ASSERT_RTNL();
+	lockdep_assert_wiphy(wiphy);
 
 	/* make sure the driver supports it */
 	if (!(wiphy->features & NL80211_FEATURE_TDLS_CHANNEL_SWITCH))
@@ -1979,7 +1979,7 @@ void ieee80211_tdls_chsw_work(struct work_struct *wk)
 	struct sk_buff *skb;
 	struct ieee80211_tdls_data *tf;
 
-	rtnl_lock();
+	wiphy_lock(local->hw.wiphy);
 	while ((skb = skb_dequeue(&local->skb_queue_tdls_chsw))) {
 		tf = (struct ieee80211_tdls_data *)skb->data;
 		list_for_each_entry(sdata, &local->interfaces, list) {
@@ -1994,7 +1994,7 @@ void ieee80211_tdls_chsw_work(struct work_struct *wk)
 
 		kfree_skb(skb);
 	}
-	rtnl_unlock();
+	wiphy_unlock(local->hw.wiphy);
 }
 
 void ieee80211_tdls_handle_disconnect(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 8d3ae6b2f95f..f080fcf60e45 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -832,7 +832,7 @@ void ieee80211_iterate_active_interfaces_atomic(
 }
 EXPORT_SYMBOL_GPL(ieee80211_iterate_active_interfaces_atomic);
 
-void ieee80211_iterate_active_interfaces_rtnl(
+void ieee80211_iterate_active_interfaces_mtx(
 	struct ieee80211_hw *hw, u32 iter_flags,
 	void (*iterator)(void *data, u8 *mac,
 			 struct ieee80211_vif *vif),
@@ -840,12 +840,12 @@ void ieee80211_iterate_active_interfaces_rtnl(
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 
-	ASSERT_RTNL();
+	lockdep_assert_wiphy(hw->wiphy);
 
 	__iterate_interfaces(local, iter_flags | IEEE80211_IFACE_ITER_ACTIVE,
 			     iterator, data);
 }
-EXPORT_SYMBOL_GPL(ieee80211_iterate_active_interfaces_rtnl);
+EXPORT_SYMBOL_GPL(ieee80211_iterate_active_interfaces_mtx);
 
 static void __iterate_stations(struct ieee80211_local *local,
 			       void (*iterator)(void *data,
@@ -2595,7 +2595,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 	mutex_unlock(&local->mtx);
 
 	if (sched_scan_stopped)
-		cfg80211_sched_scan_stopped_rtnl(local->hw.wiphy, 0);
+		cfg80211_sched_scan_stopped_locked(local->hw.wiphy, 0);
 
  wake_up:
 
@@ -3811,7 +3811,7 @@ void ieee80211_dfs_cac_cancel(struct ieee80211_local *local)
 	struct cfg80211_chan_def chandef;
 
 	/* for interface list, to avoid linking iflist_mtx and chanctx_mtx */
-	ASSERT_RTNL();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	mutex_lock(&local->mtx);
 	list_for_each_entry(sdata, &local->interfaces, list) {
@@ -3851,9 +3851,9 @@ void ieee80211_dfs_radar_detected_work(struct work_struct *work)
 	}
 	mutex_unlock(&local->chanctx_mtx);
 
-	rtnl_lock();
+	wiphy_lock(local->hw.wiphy);
 	ieee80211_dfs_cac_cancel(local);
-	rtnl_unlock();
+	wiphy_unlock(local->hw.wiphy);
 
 	if (num_chanctx > 1)
 		/* XXX: multi-channel is not supported yet */
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index e4030f1fbc60..285b8076054b 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -1093,7 +1093,7 @@ static bool cfg80211_ir_permissive_chan(struct wiphy *wiphy,
 	struct wireless_dev *wdev;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->wiphy.mtx);
 
 	if (!IS_ENABLED(CONFIG_CFG80211_REG_RELAX_NO_IR) ||
 	    !(wiphy->regulatory_flags & REGULATORY_ENABLE_RELAX_NO_IR))
@@ -1216,9 +1216,10 @@ bool cfg80211_reg_can_beacon_relax(struct wiphy *wiphy,
 				   struct cfg80211_chan_def *chandef,
 				   enum nl80211_iftype iftype)
 {
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	bool check_no_ir;
 
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->wiphy.mtx);
 
 	/*
 	 * Under certain conditions suggested by some regulatory bodies a
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 9e7d1f9620bd..5e8b523dc645 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -222,7 +222,7 @@ static void cfg80211_rfkill_poll(struct rfkill *rfkill, void *data)
 void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
 			      struct wireless_dev *wdev)
 {
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->wiphy.mtx);
 
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_P2P_DEVICE))
 		return;
@@ -247,7 +247,7 @@ void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
 void cfg80211_stop_nan(struct cfg80211_registered_device *rdev,
 		       struct wireless_dev *wdev)
 {
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->wiphy.mtx);
 
 	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_NAN))
 		return;
@@ -273,7 +273,11 @@ void cfg80211_shutdown_all_interfaces(struct wiphy *wiphy)
 			dev_close(wdev->netdev);
 			continue;
 		}
+
 		/* otherwise, check iftype */
+
+		wiphy_lock(wiphy);
+
 		switch (wdev->iftype) {
 		case NL80211_IFTYPE_P2P_DEVICE:
 			cfg80211_stop_p2p_device(rdev, wdev);
@@ -284,6 +288,8 @@ void cfg80211_shutdown_all_interfaces(struct wiphy *wiphy)
 		default:
 			break;
 		}
+
+		wiphy_unlock(wiphy);
 	}
 }
 EXPORT_SYMBOL_GPL(cfg80211_shutdown_all_interfaces);
@@ -318,9 +324,9 @@ static void cfg80211_event_work(struct work_struct *work)
 	rdev = container_of(work, struct cfg80211_registered_device,
 			    event_work);
 
-	rtnl_lock();
+	wiphy_lock(&rdev->wiphy);
 	cfg80211_process_rdev_events(rdev);
-	rtnl_unlock();
+	wiphy_unlock(&rdev->wiphy);
 }
 
 void cfg80211_destroy_ifaces(struct cfg80211_registered_device *rdev)
@@ -475,6 +481,7 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 		}
 	}
 
+	mutex_init(&rdev->wiphy.mtx);
 	INIT_LIST_HEAD(&rdev->wiphy.wdev_list);
 	INIT_LIST_HEAD(&rdev->beacon_registrations);
 	spin_lock_init(&rdev->beacon_registrations_lock);
@@ -1007,15 +1014,16 @@ void wiphy_unregister(struct wiphy *wiphy)
 
 	wait_event(rdev->dev_wait, ({
 		int __count;
-		rtnl_lock();
+		wiphy_lock(&rdev->wiphy);
 		__count = rdev->opencount;
-		rtnl_unlock();
+		wiphy_unlock(&rdev->wiphy);
 		__count == 0; }));
 
 	if (rdev->rfkill)
 		rfkill_unregister(rdev->rfkill);
 
 	rtnl_lock();
+	wiphy_lock(&rdev->wiphy);
 	nl80211_notify_wiphy(rdev, NL80211_CMD_DEL_WIPHY);
 	rdev->wiphy.registered = false;
 
@@ -1038,6 +1046,7 @@ void wiphy_unregister(struct wiphy *wiphy)
 	cfg80211_rdev_list_generation++;
 	device_del(&rdev->wiphy.dev);
 
+	wiphy_unlock(&rdev->wiphy);
 	rtnl_unlock();
 
 	flush_work(&rdev->scan_done_wk);
@@ -1070,6 +1079,7 @@ void cfg80211_dev_free(struct cfg80211_registered_device *rdev)
 	}
 	list_for_each_entry_safe(scan, tmp, &rdev->bss_list, list)
 		cfg80211_put_bss(&rdev->wiphy, &scan->pub);
+	mutex_destroy(&rdev->wiphy.mtx);
 	kfree(rdev);
 }
 
@@ -1100,6 +1110,7 @@ static void _cfg80211_unregister_wdev(struct wireless_dev *wdev,
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 
 	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->wiphy.mtx);
 
 	flush_work(&wdev->pmsr_free_wk);
 
@@ -1166,7 +1177,7 @@ static const struct device_type wiphy_type = {
 void cfg80211_update_iface_num(struct cfg80211_registered_device *rdev,
 			       enum nl80211_iftype iftype, int num)
 {
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->wiphy.mtx);
 
 	rdev->num_running_ifaces += num;
 	if (iftype == NL80211_IFTYPE_MONITOR)
@@ -1179,7 +1190,7 @@ void __cfg80211_leave(struct cfg80211_registered_device *rdev,
 	struct net_device *dev = wdev->netdev;
 	struct cfg80211_sched_scan_request *pos, *tmp;
 
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->wiphy.mtx);
 	ASSERT_WDEV_LOCK(wdev);
 
 	cfg80211_pmsr_wdev_down(wdev);
@@ -1296,6 +1307,9 @@ void cfg80211_init_wdev(struct wireless_dev *wdev)
 void cfg80211_register_wdev(struct cfg80211_registered_device *rdev,
 			    struct wireless_dev *wdev)
 {
+	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->wiphy.mtx);
+
 	/*
 	 * We get here also when the interface changes network namespaces,
 	 * as it's registered into the new one, but we don't want it to
@@ -1319,6 +1333,7 @@ int cfg80211_register_netdevice(struct net_device *dev)
 	int ret;
 
 	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->wiphy.mtx);
 
 	if (WARN_ON(!wdev))
 		return -EINVAL;
@@ -1375,21 +1390,30 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		cfg80211_init_wdev(wdev);
 		break;
 	case NETDEV_REGISTER:
-		if (!wdev->registered)
+		if (!wdev->registered) {
+			wiphy_lock(&rdev->wiphy);
 			cfg80211_register_wdev(rdev, wdev);
+			wiphy_unlock(&rdev->wiphy);
+		}
 		break;
 	case NETDEV_UNREGISTER:
 		/*
 		 * It is possible to get NETDEV_UNREGISTER multiple times,
 		 * so check wdev->registered.
 		 */
-		if (wdev->registered)
+		if (wdev->registered) {
+			wiphy_lock(&rdev->wiphy);
 			_cfg80211_unregister_wdev(wdev, false);
+			wiphy_unlock(&rdev->wiphy);
+		}
 		break;
 	case NETDEV_GOING_DOWN:
+		wiphy_lock(&rdev->wiphy);
 		cfg80211_leave(rdev, wdev);
+		wiphy_unlock(&rdev->wiphy);
 		break;
 	case NETDEV_DOWN:
+		wiphy_lock(&rdev->wiphy);
 		cfg80211_update_iface_num(rdev, wdev->iftype, -1);
 		if (rdev->scan_req && rdev->scan_req->wdev == wdev) {
 			if (WARN_ON(!rdev->scan_req->notified &&
@@ -1406,9 +1430,11 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		}
 
 		rdev->opencount--;
+		wiphy_unlock(&rdev->wiphy);
 		wake_up(&rdev->dev_wait);
 		break;
 	case NETDEV_UP:
+		wiphy_lock(&rdev->wiphy);
 		cfg80211_update_iface_num(rdev, wdev->iftype, 1);
 		wdev_lock(wdev);
 		switch (wdev->iftype) {
@@ -1455,6 +1481,7 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 			/* assume this means it's off */
 			wdev->ps = false;
 		}
+		wiphy_unlock(&rdev->wiphy);
 		break;
 	case NETDEV_PRE_UP:
 		if (!cfg80211_iftype_allowed(wdev->wiphy, wdev->iftype,
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 7df91f940212..a7d19b4b40ac 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -231,7 +231,7 @@ static inline void wdev_unlock(struct wireless_dev *wdev)
 
 static inline bool cfg80211_has_monitors_only(struct cfg80211_registered_device *rdev)
 {
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->wiphy.mtx);
 
 	return rdev->num_running_ifaces == rdev->num_running_monitor_ifaces &&
 	       rdev->num_running_ifaces > 0;
diff --git a/net/wireless/debugfs.c b/net/wireless/debugfs.c
index 76b845f68ac8..aab43469a2f0 100644
--- a/net/wireless/debugfs.c
+++ b/net/wireless/debugfs.c
@@ -73,8 +73,6 @@ static ssize_t ht40allow_map_read(struct file *file,
 	if (!buf)
 		return -ENOMEM;
 
-	rtnl_lock();
-
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {
 		sband = wiphy->bands[band];
 		if (!sband)
@@ -84,8 +82,6 @@ static ssize_t ht40allow_map_read(struct file *file,
 						buf, buf_size, offset);
 	}
 
-	rtnl_unlock();
-
 	r = simple_read_from_buffer(user_buf, count, ppos, buf, offset);
 
 	kfree(buf);
diff --git a/net/wireless/ibss.c b/net/wireless/ibss.c
index a0621bb76d8e..8f98e546becf 100644
--- a/net/wireless/ibss.c
+++ b/net/wireless/ibss.c
@@ -3,6 +3,7 @@
  * Some IBSS support code for cfg80211.
  *
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
+ * Copyright (C) 2020-2021 Intel Corporation
  */
 
 #include <linux/etherdevice.h>
@@ -92,7 +93,7 @@ int __cfg80211_join_ibss(struct cfg80211_registered_device *rdev,
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	int err;
 
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->wiphy.mtx);
 	ASSERT_WDEV_LOCK(wdev);
 
 	if (wdev->ssid_len)
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index e1e90761dc00..3aa69b375a10 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -450,7 +450,7 @@ static void cfg80211_mgmt_registrations_update(struct wireless_dev *wdev)
 	struct cfg80211_mgmt_registration *reg;
 	struct mgmt_frame_regs upd = {};
 
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->wiphy.mtx);
 
 	spin_lock_bh(&wdev->mgmt_registrations_lock);
 	if (!wdev->mgmt_registrations_need_update) {
@@ -492,10 +492,10 @@ void cfg80211_mgmt_registrations_update_wk(struct work_struct *wk)
 	rdev = container_of(wk, struct cfg80211_registered_device,
 			    mgmt_registrations_update_wk);
 
-	rtnl_lock();
+	wiphy_lock(&rdev->wiphy);
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list)
 		cfg80211_mgmt_registrations_update(wdev);
-	rtnl_unlock();
+	wiphy_unlock(&rdev->wiphy);
 }
 
 int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 775d0c4d86c3..e5e9d889f00f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -64,9 +64,9 @@ static const struct genl_multicast_group nl80211_mcgrps[] = {
 
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
@@ -74,8 +74,6 @@ __cfg80211_wdev_from_attrs(struct net *netns, struct nlattr **attrs)
 	int wiphy_idx = -1;
 	int ifidx = -1;
 
-	ASSERT_RTNL();
-
 	if (!have_ifidx && !have_wdev_id)
 		return ERR_PTR(-EINVAL);
 
@@ -86,6 +84,28 @@ __cfg80211_wdev_from_attrs(struct net *netns, struct nlattr **attrs)
 		wiphy_idx = wdev_id >> 32;
 	}
 
+	if (rdev) {
+		struct wireless_dev *wdev;
+
+		lockdep_assert_held(&rdev->wiphy.mtx);
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
 
@@ -914,22 +934,31 @@ int nl80211_prepare_wdev_dump(struct netlink_callback *cb,
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
+		mutex_lock(&(*rdev)->wiphy.mtx);
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
 
@@ -940,8 +969,12 @@ int nl80211_prepare_wdev_dump(struct netlink_callback *cb,
 			}
 		}
 
-		if (!*wdev)
+		if (!*wdev) {
+			rtnl_unlock();
 			return -ENODEV;
+		}
+		mutex_lock(&(*rdev)->wiphy.mtx);
+		rtnl_unlock();
 	}
 
 	return 0;
@@ -3141,7 +3174,7 @@ static int nl80211_set_channel(struct sk_buff *skb, struct genl_info *info)
 
 static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 {
-	struct cfg80211_registered_device *rdev;
+	struct cfg80211_registered_device *rdev = NULL;
 	struct net_device *netdev = NULL;
 	struct wireless_dev *wdev;
 	int result = 0, rem_txq_params = 0;
@@ -3152,8 +3185,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	u8 coverage_class = 0;
 	u32 txq_limit = 0, txq_memory_limit = 0, txq_quantum = 0;
 
-	ASSERT_RTNL();
-
+	rtnl_lock();
 	/*
 	 * Try to find the wiphy and netdev. Normally this
 	 * function shouldn't need the netdev, but this is
@@ -3177,14 +3209,19 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
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
 
+	wiphy_lock(&rdev->wiphy);
+	rtnl_unlock();
+
 	/*
 	 * end workaround code, by now the rdev is available
 	 * and locked, and wdev may or may not be NULL.
@@ -3195,24 +3232,32 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 			rdev, nla_data(info->attrs[NL80211_ATTR_WIPHY_NAME]));
 
 	if (result)
-		return result;
+		goto out;
 
 	if (info->attrs[NL80211_ATTR_WIPHY_TXQ_PARAMS]) {
 		struct ieee80211_txq_params txq_params;
 		struct nlattr *tb[NL80211_TXQ_ATTR_MAX + 1];
 
-		if (!rdev->ops->set_txq_params)
-			return -EOPNOTSUPP;
+		if (!rdev->ops->set_txq_params) {
+			result = -EOPNOTSUPP;
+			goto out;
+		}
 
-		if (!netdev)
-			return -EINVAL;
+		if (!netdev) {
+			result = -EINVAL;
+			goto out;
+		}
 
 		if (netdev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP &&
-		    netdev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
-			return -EINVAL;
+		    netdev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO) {
+			result = -EINVAL;
+			goto out;
+		}
 
-		if (!netif_running(netdev))
-			return -ENETDOWN;
+		if (!netif_running(netdev)) {
+			result = -ENETDOWN;
+			goto out;
+		}
 
 		nla_for_each_nested(nl_txq_params,
 				    info->attrs[NL80211_ATTR_WIPHY_TXQ_PARAMS],
@@ -3223,15 +3268,15 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 							     txq_params_policy,
 							     info->extack);
 			if (result)
-				return result;
+				goto out;
 			result = parse_txq_params(tb, &txq_params);
 			if (result)
-				return result;
+				goto out;
 
 			result = rdev_set_txq_params(rdev, netdev,
 						     &txq_params);
 			if (result)
-				return result;
+				goto out;
 		}
 	}
 
@@ -3241,7 +3286,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 			nl80211_can_set_dev_channel(wdev) ? netdev : NULL,
 			info);
 		if (result)
-			return result;
+			goto out;
 	}
 
 	if (info->attrs[NL80211_ATTR_WIPHY_TX_POWER_SETTING]) {
@@ -3252,15 +3297,19 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 		if (!(rdev->wiphy.features & NL80211_FEATURE_VIF_TXPOWER))
 			txp_wdev = NULL;
 
-		if (!rdev->ops->set_tx_power)
-			return -EOPNOTSUPP;
+		if (!rdev->ops->set_tx_power) {
+			result = -EOPNOTSUPP;
+			goto out;
+		}
 
 		idx = NL80211_ATTR_WIPHY_TX_POWER_SETTING;
 		type = nla_get_u32(info->attrs[idx]);
 
 		if (!info->attrs[NL80211_ATTR_WIPHY_TX_POWER_LEVEL] &&
-		    (type != NL80211_TX_POWER_AUTOMATIC))
-			return -EINVAL;
+		    (type != NL80211_TX_POWER_AUTOMATIC)) {
+			result = -EINVAL;
+			goto out;
+		}
 
 		if (type != NL80211_TX_POWER_AUTOMATIC) {
 			idx = NL80211_ATTR_WIPHY_TX_POWER_LEVEL;
@@ -3269,7 +3318,7 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 
 		result = rdev_set_tx_power(rdev, txp_wdev, type, mbm);
 		if (result)
-			return result;
+			goto out;
 	}
 
 	if (info->attrs[NL80211_ATTR_WIPHY_ANTENNA_TX] &&
@@ -3278,8 +3327,10 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 
 		if ((!rdev->wiphy.available_antennas_tx &&
 		     !rdev->wiphy.available_antennas_rx) ||
-		    !rdev->ops->set_antenna)
-			return -EOPNOTSUPP;
+		    !rdev->ops->set_antenna) {
+			result = -EOPNOTSUPP;
+			goto out;
+		}
 
 		tx_ant = nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_ANTENNA_TX]);
 		rx_ant = nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_ANTENNA_RX]);
@@ -3287,15 +3338,17 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 		/* reject antenna configurations which don't match the
 		 * available antenna masks, except for the "all" mask */
 		if ((~tx_ant && (tx_ant & ~rdev->wiphy.available_antennas_tx)) ||
-		    (~rx_ant && (rx_ant & ~rdev->wiphy.available_antennas_rx)))
-			return -EINVAL;
+		    (~rx_ant && (rx_ant & ~rdev->wiphy.available_antennas_rx))) {
+			result = -EINVAL;
+			goto out;
+		}
 
 		tx_ant = tx_ant & rdev->wiphy.available_antennas_tx;
 		rx_ant = rx_ant & rdev->wiphy.available_antennas_rx;
 
 		result = rdev_set_antenna(rdev, tx_ant, rx_ant);
 		if (result)
-			return result;
+			goto out;
 	}
 
 	changed = 0;
@@ -3317,8 +3370,10 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_WIPHY_FRAG_THRESHOLD]) {
 		frag_threshold = nla_get_u32(
 			info->attrs[NL80211_ATTR_WIPHY_FRAG_THRESHOLD]);
-		if (frag_threshold < 256)
-			return -EINVAL;
+		if (frag_threshold < 256) {
+			result = -EINVAL;
+			goto out;
+		}
 
 		if (frag_threshold != (u32) -1) {
 			/*
@@ -3339,8 +3394,10 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (info->attrs[NL80211_ATTR_WIPHY_COVERAGE_CLASS]) {
-		if (info->attrs[NL80211_ATTR_WIPHY_DYN_ACK])
-			return -EINVAL;
+		if (info->attrs[NL80211_ATTR_WIPHY_DYN_ACK]) {
+			result = -EINVAL;
+			goto out;
+		}
 
 		coverage_class = nla_get_u8(
 			info->attrs[NL80211_ATTR_WIPHY_COVERAGE_CLASS]);
@@ -3348,16 +3405,20 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (info->attrs[NL80211_ATTR_WIPHY_DYN_ACK]) {
-		if (!(rdev->wiphy.features & NL80211_FEATURE_ACKTO_ESTIMATION))
-			return -EOPNOTSUPP;
+		if (!(rdev->wiphy.features & NL80211_FEATURE_ACKTO_ESTIMATION)) {
+			result = -EOPNOTSUPP;
+			goto out;
+		}
 
 		changed |= WIPHY_PARAM_DYN_ACK;
 	}
 
 	if (info->attrs[NL80211_ATTR_TXQ_LIMIT]) {
 		if (!wiphy_ext_feature_isset(&rdev->wiphy,
-					     NL80211_EXT_FEATURE_TXQS))
-			return -EOPNOTSUPP;
+					     NL80211_EXT_FEATURE_TXQS)) {
+			result = -EOPNOTSUPP;
+			goto out;
+		}
 		txq_limit = nla_get_u32(
 			info->attrs[NL80211_ATTR_TXQ_LIMIT]);
 		changed |= WIPHY_PARAM_TXQ_LIMIT;
@@ -3365,8 +3426,10 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NL80211_ATTR_TXQ_MEMORY_LIMIT]) {
 		if (!wiphy_ext_feature_isset(&rdev->wiphy,
-					     NL80211_EXT_FEATURE_TXQS))
-			return -EOPNOTSUPP;
+					     NL80211_EXT_FEATURE_TXQS)) {
+			result = -EOPNOTSUPP;
+			goto out;
+		}
 		txq_memory_limit = nla_get_u32(
 			info->attrs[NL80211_ATTR_TXQ_MEMORY_LIMIT]);
 		changed |= WIPHY_PARAM_TXQ_MEMORY_LIMIT;
@@ -3374,8 +3437,10 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 
 	if (info->attrs[NL80211_ATTR_TXQ_QUANTUM]) {
 		if (!wiphy_ext_feature_isset(&rdev->wiphy,
-					     NL80211_EXT_FEATURE_TXQS))
-			return -EOPNOTSUPP;
+					     NL80211_EXT_FEATURE_TXQS)) {
+			result = -EOPNOTSUPP;
+			goto out;
+		}
 		txq_quantum = nla_get_u32(
 			info->attrs[NL80211_ATTR_TXQ_QUANTUM]);
 		changed |= WIPHY_PARAM_TXQ_QUANTUM;
@@ -3387,8 +3452,10 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 		u8 old_coverage_class;
 		u32 old_txq_limit, old_txq_memory_limit, old_txq_quantum;
 
-		if (!rdev->ops->set_wiphy_params)
-			return -EOPNOTSUPP;
+		if (!rdev->ops->set_wiphy_params) {
+			result = -EOPNOTSUPP;
+			goto out;
+		}
 
 		old_retry_short = rdev->wiphy.retry_short;
 		old_retry_long = rdev->wiphy.retry_long;
@@ -3426,10 +3493,15 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 			rdev->wiphy.txq_limit = old_txq_limit;
 			rdev->wiphy.txq_memory_limit = old_txq_memory_limit;
 			rdev->wiphy.txq_quantum = old_txq_quantum;
-			return result;
+			goto out;
 		}
 	}
-	return 0;
+
+	result = 0;
+
+out:
+	wiphy_unlock(&rdev->wiphy);
+	return result;
 }
 
 static int nl80211_send_chandef(struct sk_buff *msg,
@@ -3959,6 +4031,17 @@ static int nl80211_del_interface(struct sk_buff *skb, struct genl_info *info)
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
+	mutex_unlock(&rdev->wiphy.mtx);
+
 	/*
 	 * If we remove a wireless device without a netdev then clear
 	 * user_ptr[1] so that nl80211_post_doit won't dereference it
@@ -3968,6 +4051,10 @@ static int nl80211_del_interface(struct sk_buff *skb, struct genl_info *info)
 	 */
 	if (!wdev->netdev)
 		info->user_ptr[1] = NULL;
+	else
+		dev_close(wdev->netdev);
+
+	mutex_lock(&rdev->wiphy.mtx);
 
 	return rdev_del_virtual_intf(rdev, wdev);
 }
@@ -5884,10 +5971,11 @@ static int nl80211_dump_station(struct sk_buff *skb,
 	int sta_idx = cb->args[2];
 	int err;
 
-	rtnl_lock();
 	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev);
 	if (err)
-		goto out_err;
+		return err;
+	/* nl80211_prepare_wdev_dump acquired it in the successful case */
+	__acquire(&rdev->wiphy.mtx);
 
 	if (!wdev->netdev) {
 		err = -EINVAL;
@@ -5922,7 +6010,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 	cb->args[2] = sta_idx;
 	err = skb->len;
  out_err:
-	rtnl_unlock();
+	wiphy_unlock(&rdev->wiphy);
 
 	return err;
 }
@@ -6780,10 +6868,11 @@ static int nl80211_dump_mpath(struct sk_buff *skb,
 	int path_idx = cb->args[2];
 	int err;
 
-	rtnl_lock();
 	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev);
 	if (err)
-		goto out_err;
+		return err;
+	/* nl80211_prepare_wdev_dump acquired it in the successful case */
+	__acquire(&rdev->wiphy.mtx);
 
 	if (!rdev->ops->dump_mpath) {
 		err = -EOPNOTSUPP;
@@ -6816,7 +6905,7 @@ static int nl80211_dump_mpath(struct sk_buff *skb,
 	cb->args[2] = path_idx;
 	err = skb->len;
  out_err:
-	rtnl_unlock();
+	wiphy_unlock(&rdev->wiphy);
 	return err;
 }
 
@@ -6979,10 +7068,11 @@ static int nl80211_dump_mpp(struct sk_buff *skb,
 	int path_idx = cb->args[2];
 	int err;
 
-	rtnl_lock();
 	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev);
 	if (err)
-		goto out_err;
+		return err;
+	/* nl80211_prepare_wdev_dump acquired it in the successful case */
+	__acquire(&rdev->wiphy.mtx);
 
 	if (!rdev->ops->dump_mpp) {
 		err = -EOPNOTSUPP;
@@ -7015,7 +7105,7 @@ static int nl80211_dump_mpp(struct sk_buff *skb,
 	cb->args[2] = path_idx;
 	err = skb->len;
  out_err:
-	rtnl_unlock();
+	wiphy_unlock(&rdev->wiphy);
 	return err;
 }
 
@@ -7634,12 +7724,15 @@ static int nl80211_get_reg_do(struct sk_buff *skb, struct genl_info *info)
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
 
@@ -7651,6 +7744,7 @@ static int nl80211_get_reg_do(struct sk_buff *skb, struct genl_info *info)
 		/* a self-managed-reg device must have a private regdom */
 		if (WARN_ON(!regdom && self_managed)) {
 			nlmsg_free(msg);
+			rtnl_unlock();
 			return -EINVAL;
 		}
 
@@ -7675,11 +7769,13 @@ static int nl80211_get_reg_do(struct sk_buff *skb, struct genl_info *info)
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
@@ -7842,12 +7938,17 @@ static int nl80211_set_reg(struct sk_buff *skb, struct genl_info *info)
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
@@ -7879,10 +7980,13 @@ static int nl80211_set_reg(struct sk_buff *skb, struct genl_info *info)
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
@@ -9050,10 +9154,7 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_csa_settings params;
-	/* csa_attrs is defined static to avoid waste of stack size - this
-	 * function is called under RTNL lock, so this should not be a problem.
-	 */
-	static struct nlattr *csa_attrs[NL80211_ATTR_MAX+1];
+	struct nlattr **csa_attrs = NULL;
 	int err;
 	bool need_new_beacon = false;
 	bool need_handle_dfs_flag = true;
@@ -9118,28 +9219,39 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
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
 
-	if (!csa_attrs[NL80211_ATTR_CNTDWN_OFFS_BEACON])
-		return -EINVAL;
+	if (!csa_attrs[NL80211_ATTR_CNTDWN_OFFS_BEACON]) {
+		err = -EINVAL;
+		goto free;
+	}
 
 	len = nla_len(csa_attrs[NL80211_ATTR_CNTDWN_OFFS_BEACON]);
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
 		nla_data(csa_attrs[NL80211_ATTR_CNTDWN_OFFS_BEACON]);
@@ -9148,23 +9260,31 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
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
 
 	if (csa_attrs[NL80211_ATTR_CNTDWN_OFFS_PRESP]) {
 		len = nla_len(csa_attrs[NL80211_ATTR_CNTDWN_OFFS_PRESP]);
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
 			nla_data(csa_attrs[NL80211_ATTR_CNTDWN_OFFS_PRESP]);
@@ -9173,35 +9293,42 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
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
 
@@ -9212,6 +9339,8 @@ static int nl80211_channel_switch(struct sk_buff *skb, struct genl_info *info)
 	err = rdev_channel_switch(rdev, dev, &params);
 	wdev_unlock(wdev);
 
+free:
+	kfree(csa_attrs);
 	return err;
 }
 
@@ -9362,12 +9491,11 @@ static int nl80211_dump_scan(struct sk_buff *skb, struct netlink_callback *cb)
 	int start = cb->args[2], idx = 0;
 	int err;
 
-	rtnl_lock();
 	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev);
-	if (err) {
-		rtnl_unlock();
+	if (err)
 		return err;
-	}
+	/* nl80211_prepare_wdev_dump acquired it in the successful case */
+	__acquire(&rdev->wiphy.mtx);
 
 	wdev_lock(wdev);
 	spin_lock_bh(&rdev->bss_lock);
@@ -9398,7 +9526,7 @@ static int nl80211_dump_scan(struct sk_buff *skb, struct netlink_callback *cb)
 	wdev_unlock(wdev);
 
 	cb->args[2] = idx;
-	rtnl_unlock();
+	wiphy_unlock(&rdev->wiphy);
 
 	return skb->len;
 }
@@ -9496,10 +9624,13 @@ static int nl80211_dump_survey(struct sk_buff *skb, struct netlink_callback *cb)
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
+	/* nl80211_prepare_wdev_dump acquired it in the successful case */
+	__acquire(&rdev->wiphy.mtx);
 
 	/* prepare_wdev_dump parsed the attributes */
 	radio_stats = attrbuf[NL80211_ATTR_SURVEY_RADIO_STATS];
@@ -9541,7 +9672,7 @@ static int nl80211_dump_survey(struct sk_buff *skb, struct netlink_callback *cb)
 	res = skb->len;
  out_err:
 	kfree(attrbuf);
-	rtnl_unlock();
+	wiphy_unlock(&rdev->wiphy);
 	return res;
 }
 
@@ -10403,10 +10534,14 @@ EXPORT_SYMBOL(__cfg80211_send_event_skb);
 static int nl80211_testmode_do(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
-	struct wireless_dev *wdev =
-		__cfg80211_wdev_from_attrs(genl_info_net(info), info->attrs);
+	struct wireless_dev *wdev;
 	int err;
 
+	lockdep_assert_held(&rdev->wiphy.mtx);
+
+	wdev = __cfg80211_wdev_from_attrs(rdev, genl_info_net(info),
+					  info->attrs);
+
 	if (!rdev->ops->testmode_cmd)
 		return -EOPNOTSUPP;
 
@@ -13591,7 +13726,8 @@ static int nl80211_vendor_cmd(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct wireless_dev *wdev =
-		__cfg80211_wdev_from_attrs(genl_info_net(info), info->attrs);
+		__cfg80211_wdev_from_attrs(rdev, genl_info_net(info),
+					   info->attrs);
 	int i, err;
 	u32 vid, subcmd;
 
@@ -13715,7 +13851,7 @@ static int nl80211_prepare_vendor_dump(struct sk_buff *skb,
 		goto out;
 	}
 
-	*wdev = __cfg80211_wdev_from_attrs(sock_net(skb->sk), attrbuf);
+	*wdev = __cfg80211_wdev_from_attrs(NULL, sock_net(skb->sk), attrbuf);
 	if (IS_ERR(*wdev))
 		*wdev = NULL;
 
@@ -14650,31 +14786,24 @@ static int nl80211_set_tid_config(struct sk_buff *skb,
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
 
@@ -14683,8 +14812,7 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 
 		if (ops->internal_flags & NL80211_FLAG_NEED_NETDEV) {
 			if (!dev) {
-				if (rtnl)
-					rtnl_unlock();
+				rtnl_unlock();
 				return -EINVAL;
 			}
 
@@ -14695,8 +14823,7 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 
 		if (ops->internal_flags & NL80211_FLAG_CHECK_NETDEV_UP &&
 		    !wdev_running(wdev)) {
-			if (rtnl)
-				rtnl_unlock();
+			rtnl_unlock();
 			return -ENETDOWN;
 		}
 
@@ -14706,6 +14833,14 @@ static int nl80211_pre_doit(const struct genl_ops *ops, struct sk_buff *skb,
 		info->user_ptr[0] = rdev;
 	}
 
+	if (rdev) {
+		wiphy_lock(&rdev->wiphy);
+		/* we keep the mutex locked until post_doit */
+		__release(&rdev->wiphy.mtx);
+	}
+	if (!(ops->internal_flags & NL80211_FLAG_NEED_RTNL))
+		rtnl_unlock();
+
 	return 0;
 }
 
@@ -14723,6 +14858,14 @@ static void nl80211_post_doit(const struct genl_ops *ops, struct sk_buff *skb,
 		}
 	}
 
+	if (info->user_ptr[0]) {
+		struct cfg80211_registered_device *rdev = info->user_ptr[0];
+
+		/* we kept the mutex locked since pre_doit */
+		__acquire(&rdev->wiphy.mtx);
+		wiphy_unlock(&rdev->wiphy);
+	}
+
 	if (ops->internal_flags & NL80211_FLAG_NEED_RTNL)
 		rtnl_unlock();
 
@@ -14851,8 +14994,7 @@ static const struct genl_ops nl80211_ops[] = {
 		.dumpit = nl80211_dump_wiphy,
 		.done = nl80211_dump_wiphy_done,
 		/* can be retrieved by unprivileged users */
-		.internal_flags = NL80211_FLAG_NEED_WIPHY |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WIPHY,
 	},
 };
 
@@ -14862,7 +15004,6 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_wiphy,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_RTNL,
 	},
 	{
 		.cmd = NL80211_CMD_GET_INTERFACE,
@@ -14870,8 +15011,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_get_interface,
 		.dumpit = nl80211_dump_interface,
 		/* can be retrieved by unprivileged users */
-		.internal_flags = NL80211_FLAG_NEED_WDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WDEV,
 	},
 	{
 		.cmd = NL80211_CMD_SET_INTERFACE,
@@ -14902,8 +15042,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_get_key,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_SET_KEY,
@@ -14911,7 +15050,6 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_set_key,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -14920,7 +15058,6 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_new_key,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -14928,64 +15065,56 @@ static const struct genl_small_ops nl80211_small_ops[] = {
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
@@ -14993,8 +15122,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_get_mpath,
 		.dumpit = nl80211_dump_mpath,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_GET_MPP,
@@ -15002,47 +15130,42 @@ static const struct genl_small_ops nl80211_small_ops[] = {
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
@@ -15051,7 +15174,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_reg,
 		.flags = GENL_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_RTNL,
+		.internal_flags = 0,
 	},
 #endif
 	{
@@ -15071,32 +15194,28 @@ static const struct genl_small_ops nl80211_small_ops[] = {
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
@@ -15108,16 +15227,14 @@ static const struct genl_small_ops nl80211_small_ops[] = {
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
@@ -15125,7 +15242,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_authenticate,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL |
+				  0 |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -15134,7 +15251,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_associate,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL |
+				  0 |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -15142,32 +15259,28 @@ static const struct genl_small_ops nl80211_small_ops[] = {
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
@@ -15176,8 +15289,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_testmode_do,
 		.dumpit = nl80211_testmode_dump,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_WIPHY |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_WIPHY,
 	},
 #endif
 	{
@@ -15186,7 +15298,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_connect,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL |
+				  0 |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -15195,7 +15307,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_update_connect_params,
 		.flags = GENL_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL |
+				  0 |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -15203,16 +15315,14 @@ static const struct genl_small_ops nl80211_small_ops[] = {
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
@@ -15225,7 +15335,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_setdel_pmksa,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL |
+				  0 |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -15233,128 +15343,112 @@ static const struct genl_small_ops nl80211_small_ops[] = {
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
@@ -15362,16 +15456,14 @@ static const struct genl_small_ops nl80211_small_ops[] = {
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
@@ -15380,7 +15472,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_set_rekey_data,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
-				  NL80211_FLAG_NEED_RTNL |
+				  0 |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -15388,48 +15480,42 @@ static const struct genl_small_ops nl80211_small_ops[] = {
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
@@ -15468,48 +15554,42 @@ static const struct genl_small_ops nl80211_small_ops[] = {
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
@@ -15521,47 +15601,41 @@ static const struct genl_small_ops nl80211_small_ops[] = {
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
@@ -15570,7 +15644,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.dumpit = nl80211_vendor_cmd_dump,
 		.flags = GENL_UNS_ADMIN_PERM,
 		.internal_flags = NL80211_FLAG_NEED_WIPHY |
-				  NL80211_FLAG_NEED_RTNL |
+				  0 |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -15578,123 +15652,108 @@ static const struct genl_small_ops nl80211_small_ops[] = {
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
 	{
 		.cmd = NL80211_CMD_SET_TID_CONFIG,
 		.doit = nl80211_set_tid_config,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV |
-				  NL80211_FLAG_NEED_RTNL,
+		.internal_flags = NL80211_FLAG_NEED_NETDEV,
 	},
 	{
 		.cmd = NL80211_CMD_SET_SAR_SPECS,
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 8114bba8556c..452b698f42be 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -142,12 +142,15 @@ static const struct ieee80211_regdomain *get_cfg80211_regdom(void)
 /*
  * Returns the regulatory domain associated with the wiphy.
  *
- * Requires either RTNL or RCU protection
+ * Requires any of RTNL, wiphy mutex or RCU protection.
  */
 const struct ieee80211_regdomain *get_wiphy_regdom(struct wiphy *wiphy)
 {
-	return rcu_dereference_rtnl(wiphy->regd);
+	return rcu_dereference_check(wiphy->regd,
+				     lockdep_is_held(&wiphy->mtx) ||
+				     lockdep_rtnl_is_held());
 }
+EXPORT_SYMBOL(get_wiphy_regdom);
 
 static const char *reg_dfs_region_str(enum nl80211_dfs_regions dfs_region)
 {
@@ -169,7 +172,9 @@ enum nl80211_dfs_regions reg_get_dfs_region(struct wiphy *wiphy)
 	const struct ieee80211_regdomain *regd = NULL;
 	const struct ieee80211_regdomain *wiphy_regd = NULL;
 
+	rcu_read_lock();
 	regd = get_cfg80211_regdom();
+
 	if (!wiphy)
 		goto out;
 
@@ -186,6 +191,8 @@ enum nl80211_dfs_regions reg_get_dfs_region(struct wiphy *wiphy)
 		 reg_dfs_region_str(regd->dfs_region));
 
 out:
+	rcu_read_unlock();
+
 	return regd->dfs_region;
 }
 
@@ -2577,11 +2584,13 @@ void wiphy_apply_custom_regulatory(struct wiphy *wiphy,
 		return;
 
 	rtnl_lock();
+	wiphy_lock(wiphy);
 
 	tmp = get_wiphy_regdom(wiphy);
 	rcu_assign_pointer(wiphy->regd, new_regd);
 	rcu_free_regdom(tmp);
 
+	wiphy_unlock(wiphy);
 	rtnl_unlock();
 }
 EXPORT_SYMBOL(wiphy_apply_custom_regulatory);
@@ -2744,7 +2753,10 @@ reg_process_hint_driver(struct wiphy *wiphy,
 			return REG_REQ_IGNORE;
 
 		tmp = get_wiphy_regdom(wiphy);
+		ASSERT_RTNL();
+		wiphy_lock(wiphy);
 		rcu_assign_pointer(wiphy->regd, regd);
+		wiphy_unlock(wiphy);
 		rcu_free_regdom(tmp);
 	}
 
@@ -3076,41 +3088,52 @@ static void reg_process_pending_beacon_hints(void)
 	spin_unlock_bh(&reg_pending_beacons_lock);
 }
 
-static void reg_process_self_managed_hints(void)
+static void reg_process_self_managed_hint(struct wiphy *wiphy)
 {
-	struct cfg80211_registered_device *rdev;
-	struct wiphy *wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	const struct ieee80211_regdomain *tmp;
 	const struct ieee80211_regdomain *regd;
 	enum nl80211_band band;
 	struct regulatory_request request = {};
 
-	list_for_each_entry(rdev, &cfg80211_rdev_list, list) {
-		wiphy = &rdev->wiphy;
+	ASSERT_RTNL();
+	lockdep_assert_wiphy(wiphy);
 
-		spin_lock(&reg_requests_lock);
-		regd = rdev->requested_regd;
-		rdev->requested_regd = NULL;
-		spin_unlock(&reg_requests_lock);
+	spin_lock(&reg_requests_lock);
+	regd = rdev->requested_regd;
+	rdev->requested_regd = NULL;
+	spin_unlock(&reg_requests_lock);
 
-		if (regd == NULL)
-			continue;
+	if (!regd)
+		return;
 
-		tmp = get_wiphy_regdom(wiphy);
-		rcu_assign_pointer(wiphy->regd, regd);
-		rcu_free_regdom(tmp);
+	tmp = get_wiphy_regdom(wiphy);
+	rcu_assign_pointer(wiphy->regd, regd);
+	rcu_free_regdom(tmp);
+
+	for (band = 0; band < NUM_NL80211_BANDS; band++)
+		handle_band_custom(wiphy, wiphy->bands[band], regd);
 
-		for (band = 0; band < NUM_NL80211_BANDS; band++)
-			handle_band_custom(wiphy, wiphy->bands[band], regd);
+	reg_process_ht_flags(wiphy);
 
-		reg_process_ht_flags(wiphy);
+	request.wiphy_idx = get_wiphy_idx(wiphy);
+	request.alpha2[0] = regd->alpha2[0];
+	request.alpha2[1] = regd->alpha2[1];
+	request.initiator = NL80211_REGDOM_SET_BY_DRIVER;
 
-		request.wiphy_idx = get_wiphy_idx(wiphy);
-		request.alpha2[0] = regd->alpha2[0];
-		request.alpha2[1] = regd->alpha2[1];
-		request.initiator = NL80211_REGDOM_SET_BY_DRIVER;
+	nl80211_send_wiphy_reg_change_event(&request);
+}
 
-		nl80211_send_wiphy_reg_change_event(&request);
+static void reg_process_self_managed_hints(void)
+{
+	struct cfg80211_registered_device *rdev;
+
+	ASSERT_RTNL();
+
+	list_for_each_entry(rdev, &cfg80211_rdev_list, list) {
+		wiphy_lock(&rdev->wiphy);
+		reg_process_self_managed_hint(&rdev->wiphy);
+		wiphy_unlock(&rdev->wiphy);
 	}
 
 	reg_check_channels();
@@ -3789,14 +3812,21 @@ static int reg_set_rd_driver(const struct ieee80211_regdomain *rd,
 		return -ENODEV;
 
 	if (!driver_request->intersect) {
-		if (request_wiphy->regd)
+		ASSERT_RTNL();
+		wiphy_lock(request_wiphy);
+		if (request_wiphy->regd) {
+			wiphy_unlock(request_wiphy);
 			return -EALREADY;
+		}
 
 		regd = reg_copy_regd(rd);
-		if (IS_ERR(regd))
+		if (IS_ERR(regd)) {
+			wiphy_unlock(request_wiphy);
 			return PTR_ERR(regd);
+		}
 
 		rcu_assign_pointer(request_wiphy->regd, regd);
+		wiphy_unlock(request_wiphy);
 		reset_regdomains(false, rd);
 		return 0;
 	}
@@ -3978,8 +4008,8 @@ int regulatory_set_wiphy_regd(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL(regulatory_set_wiphy_regd);
 
-int regulatory_set_wiphy_regd_sync_rtnl(struct wiphy *wiphy,
-					struct ieee80211_regdomain *rd)
+int regulatory_set_wiphy_regd_sync(struct wiphy *wiphy,
+				   struct ieee80211_regdomain *rd)
 {
 	int ret;
 
@@ -3990,10 +4020,11 @@ int regulatory_set_wiphy_regd_sync_rtnl(struct wiphy *wiphy,
 		return ret;
 
 	/* process the request immediately */
-	reg_process_self_managed_hints();
+	reg_process_self_managed_hint(wiphy);
+	reg_check_channels();
 	return 0;
 }
-EXPORT_SYMBOL(regulatory_set_wiphy_regd_sync_rtnl);
+EXPORT_SYMBOL(regulatory_set_wiphy_regd_sync);
 
 void wiphy_regulatory_register(struct wiphy *wiphy)
 {
diff --git a/net/wireless/reg.h b/net/wireless/reg.h
index f9e83031a40a..f3707f729024 100644
--- a/net/wireless/reg.h
+++ b/net/wireless/reg.h
@@ -63,7 +63,6 @@ unsigned int reg_get_max_bandwidth(const struct ieee80211_regdomain *rd,
 				   const struct ieee80211_reg_rule *rule);
 
 bool reg_last_request_cell_base(void);
-const struct ieee80211_regdomain *get_wiphy_regdom(struct wiphy *wiphy);
 
 /**
  * regulatory_hint_found_beacon - hints a beacon was found on a channel
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 1b7fec3b53cd..019952d4fc7d 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -918,7 +918,7 @@ void ___cfg80211_scan_done(struct cfg80211_registered_device *rdev,
 	union iwreq_data wrqu;
 #endif
 
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->wiphy.mtx);
 
 	if (rdev->scan_msg) {
 		nl80211_send_scan_msg(rdev, rdev->scan_msg);
@@ -987,9 +987,9 @@ void __cfg80211_scan_done(struct work_struct *wk)
 	rdev = container_of(wk, struct cfg80211_registered_device,
 			    scan_done_wk);
 
-	rtnl_lock();
+	wiphy_lock(&rdev->wiphy);
 	___cfg80211_scan_done(rdev, true);
-	rtnl_unlock();
+	wiphy_unlock(&rdev->wiphy);
 }
 
 void cfg80211_scan_done(struct cfg80211_scan_request *request,
@@ -1022,7 +1022,7 @@ EXPORT_SYMBOL(cfg80211_scan_done);
 void cfg80211_add_sched_scan_req(struct cfg80211_registered_device *rdev,
 				 struct cfg80211_sched_scan_request *req)
 {
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->wiphy.mtx);
 
 	list_add_rcu(&req->list, &rdev->sched_scan_req_list);
 }
@@ -1030,7 +1030,7 @@ void cfg80211_add_sched_scan_req(struct cfg80211_registered_device *rdev,
 static void cfg80211_del_sched_scan_req(struct cfg80211_registered_device *rdev,
 					struct cfg80211_sched_scan_request *req)
 {
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->wiphy.mtx);
 
 	list_del_rcu(&req->list);
 	kfree_rcu(req, rcu_head);
@@ -1042,7 +1042,7 @@ cfg80211_find_sched_scan_req(struct cfg80211_registered_device *rdev, u64 reqid)
 	struct cfg80211_sched_scan_request *pos;
 
 	list_for_each_entry_rcu(pos, &rdev->sched_scan_req_list, list,
-				lockdep_rtnl_is_held()) {
+				lockdep_is_held(&rdev->wiphy.mtx)) {
 		if (pos->reqid == reqid)
 			return pos;
 	}
@@ -1090,7 +1090,7 @@ void cfg80211_sched_scan_results_wk(struct work_struct *work)
 	rdev = container_of(work, struct cfg80211_registered_device,
 			   sched_scan_res_wk);
 
-	rtnl_lock();
+	wiphy_lock(&rdev->wiphy);
 	list_for_each_entry_safe(req, tmp, &rdev->sched_scan_req_list, list) {
 		if (req->report_results) {
 			req->report_results = false;
@@ -1105,7 +1105,7 @@ void cfg80211_sched_scan_results_wk(struct work_struct *work)
 						NL80211_CMD_SCHED_SCAN_RESULTS);
 		}
 	}
-	rtnl_unlock();
+	wiphy_unlock(&rdev->wiphy);
 }
 
 void cfg80211_sched_scan_results(struct wiphy *wiphy, u64 reqid)
@@ -1126,23 +1126,23 @@ void cfg80211_sched_scan_results(struct wiphy *wiphy, u64 reqid)
 }
 EXPORT_SYMBOL(cfg80211_sched_scan_results);
 
-void cfg80211_sched_scan_stopped_rtnl(struct wiphy *wiphy, u64 reqid)
+void cfg80211_sched_scan_stopped_locked(struct wiphy *wiphy, u64 reqid)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 
-	ASSERT_RTNL();
+	lockdep_assert_held(&wiphy->mtx);
 
 	trace_cfg80211_sched_scan_stopped(wiphy, reqid);
 
 	__cfg80211_stop_sched_scan(rdev, reqid, true);
 }
-EXPORT_SYMBOL(cfg80211_sched_scan_stopped_rtnl);
+EXPORT_SYMBOL(cfg80211_sched_scan_stopped_locked);
 
 void cfg80211_sched_scan_stopped(struct wiphy *wiphy, u64 reqid)
 {
-	rtnl_lock();
-	cfg80211_sched_scan_stopped_rtnl(wiphy, reqid);
-	rtnl_unlock();
+	wiphy_lock(wiphy);
+	cfg80211_sched_scan_stopped_locked(wiphy, reqid);
+	wiphy_unlock(wiphy);
 }
 EXPORT_SYMBOL(cfg80211_sched_scan_stopped);
 
@@ -1150,7 +1150,7 @@ int cfg80211_stop_sched_scan_req(struct cfg80211_registered_device *rdev,
 				 struct cfg80211_sched_scan_request *req,
 				 bool driver_initiated)
 {
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->wiphy.mtx);
 
 	if (!driver_initiated) {
 		int err = rdev_sched_scan_stop(rdev, req->dev, req->reqid);
@@ -1170,7 +1170,7 @@ int __cfg80211_stop_sched_scan(struct cfg80211_registered_device *rdev,
 {
 	struct cfg80211_sched_scan_request *sched_scan_req;
 
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->wiphy.mtx);
 
 	sched_scan_req = cfg80211_find_sched_scan_req(rdev, reqid);
 	if (!sched_scan_req)
@@ -2774,6 +2774,8 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 
 	eth_broadcast_addr(creq->bssid);
 
+	wiphy_lock(&rdev->wiphy);
+
 	rdev->scan_req = creq;
 	err = rdev_scan(rdev, creq);
 	if (err) {
@@ -2785,6 +2787,7 @@ int cfg80211_wext_siwscan(struct net_device *dev,
 		creq = NULL;
 		dev_hold(dev);
 	}
+	wiphy_unlock(&rdev->wiphy);
  out:
 	kfree(creq);
 	return err;
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 38df713f2e2e..07756ca5e3b5 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -67,7 +67,6 @@ static int cfg80211_conn_scan(struct wireless_dev *wdev)
 	struct cfg80211_scan_request *request;
 	int n_channels, err;
 
-	ASSERT_RTNL();
 	ASSERT_WDEV_LOCK(wdev);
 
 	if (rdev->scan_req || rdev->scan_msg)
@@ -233,7 +232,7 @@ void cfg80211_conn_work(struct work_struct *work)
 	u8 bssid_buf[ETH_ALEN], *bssid = NULL;
 	enum nl80211_timeout_reason treason;
 
-	rtnl_lock();
+	wiphy_lock(&rdev->wiphy);
 
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
 		if (!wdev->netdev)
@@ -266,7 +265,7 @@ void cfg80211_conn_work(struct work_struct *work)
 		wdev_unlock(wdev);
 	}
 
-	rtnl_unlock();
+	wiphy_unlock(&rdev->wiphy);
 }
 
 /* Returned bss is reference counted and must be cleaned up appropriately. */
diff --git a/net/wireless/sysfs.c b/net/wireless/sysfs.c
index 3ac1f48195d2..043762354a66 100644
--- a/net/wireless/sysfs.c
+++ b/net/wireless/sysfs.c
@@ -5,6 +5,7 @@
  *
  * Copyright 2005-2006	Jiri Benc <jbenc@suse.cz>
  * Copyright 2006	Johannes Berg <johannes@sipsolutions.net>
+ * Copyright (C) 2020-2021 Intel Corporation
  */
 
 #include <linux/device.h>
@@ -104,6 +105,7 @@ static int wiphy_suspend(struct device *dev)
 	rdev->suspend_at = ktime_get_boottime_seconds();
 
 	rtnl_lock();
+	wiphy_lock(&rdev->wiphy);
 	if (rdev->wiphy.registered) {
 		if (!rdev->wiphy.wowlan_config) {
 			cfg80211_leave_all(rdev);
@@ -118,6 +120,7 @@ static int wiphy_suspend(struct device *dev)
 			ret = rdev_suspend(rdev, NULL);
 		}
 	}
+	wiphy_unlock(&rdev->wiphy);
 	rtnl_unlock();
 
 	return ret;
@@ -132,8 +135,10 @@ static int wiphy_resume(struct device *dev)
 	cfg80211_bss_age(rdev, ktime_get_boottime_seconds() - rdev->suspend_at);
 
 	rtnl_lock();
+	wiphy_lock(&rdev->wiphy);
 	if (rdev->wiphy.registered && rdev->ops->resume)
 		ret = rdev_resume(rdev);
+	wiphy_unlock(&rdev->wiphy);
 	rtnl_unlock();
 
 	return ret;
diff --git a/net/wireless/util.c b/net/wireless/util.c
index eab928002cd8..1bf0200f562a 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -997,7 +997,7 @@ void cfg80211_process_rdev_events(struct cfg80211_registered_device *rdev)
 {
 	struct wireless_dev *wdev;
 
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->wiphy.mtx);
 
 	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list)
 		cfg80211_process_wdev_events(wdev);
@@ -1010,7 +1010,7 @@ int cfg80211_change_iface(struct cfg80211_registered_device *rdev,
 	int err;
 	enum nl80211_iftype otype = dev->ieee80211_ptr->iftype;
 
-	ASSERT_RTNL();
+	lockdep_assert_held(&rdev->wiphy.mtx);
 
 	/* don't support changing VLANs, you just re-create them */
 	if (otype == NL80211_IFTYPE_AP_VLAN)
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index fd9ad74972fb..2e35cb78221e 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -7,7 +7,7 @@
  * we directly assign the wireless handlers of wireless interfaces.
  *
  * Copyright 2008-2009	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2019-2021 Intel Corporation
  */
 
 #include <linux/export.h>
@@ -253,17 +253,23 @@ int cfg80211_wext_siwrts(struct net_device *dev,
 	u32 orts = wdev->wiphy->rts_threshold;
 	int err;
 
-	if (rts->disabled || !rts->fixed)
+	wiphy_lock(&rdev->wiphy);
+	if (rts->disabled || !rts->fixed) {
 		wdev->wiphy->rts_threshold = (u32) -1;
-	else if (rts->value < 0)
-		return -EINVAL;
-	else
+	} else if (rts->value < 0) {
+		err = -EINVAL;
+		goto out;
+	} else {
 		wdev->wiphy->rts_threshold = rts->value;
+	}
 
 	err = rdev_set_wiphy_params(rdev, WIPHY_PARAM_RTS_THRESHOLD);
+
 	if (err)
 		wdev->wiphy->rts_threshold = orts;
 
+out:
+	wiphy_unlock(&rdev->wiphy);
 	return err;
 }
 EXPORT_WEXT_HANDLER(cfg80211_wext_siwrts);
@@ -291,11 +297,13 @@ int cfg80211_wext_siwfrag(struct net_device *dev,
 	u32 ofrag = wdev->wiphy->frag_threshold;
 	int err;
 
-	if (frag->disabled || !frag->fixed)
+	wiphy_lock(&rdev->wiphy);
+	if (frag->disabled || !frag->fixed) {
 		wdev->wiphy->frag_threshold = (u32) -1;
-	else if (frag->value < 256)
-		return -EINVAL;
-	else {
+	} else if (frag->value < 256) {
+		err = -EINVAL;
+		goto out;
+	} else {
 		/* Fragment length must be even, so strip LSB. */
 		wdev->wiphy->frag_threshold = frag->value & ~0x1;
 	}
@@ -303,6 +311,8 @@ int cfg80211_wext_siwfrag(struct net_device *dev,
 	err = rdev_set_wiphy_params(rdev, WIPHY_PARAM_FRAG_THRESHOLD);
 	if (err)
 		wdev->wiphy->frag_threshold = ofrag;
+out:
+	wiphy_unlock(&rdev->wiphy);
 
 	return err;
 }
@@ -337,6 +347,7 @@ static int cfg80211_wext_siwretry(struct net_device *dev,
 	    (retry->flags & IW_RETRY_TYPE) != IW_RETRY_LIMIT)
 		return -EINVAL;
 
+	wiphy_lock(&rdev->wiphy);
 	if (retry->flags & IW_RETRY_LONG) {
 		wdev->wiphy->retry_long = retry->value;
 		changed |= WIPHY_PARAM_RETRY_LONG;
@@ -355,6 +366,7 @@ static int cfg80211_wext_siwretry(struct net_device *dev,
 		wdev->wiphy->retry_short = oshort;
 		wdev->wiphy->retry_long = olong;
 	}
+	wiphy_unlock(&rdev->wiphy);
 
 	return err;
 }
@@ -577,15 +589,18 @@ static int cfg80211_wext_siwencode(struct net_device *dev,
 	    !rdev->ops->set_default_key)
 		return -EOPNOTSUPP;
 
+	wiphy_lock(&rdev->wiphy);
 	idx = erq->flags & IW_ENCODE_INDEX;
 	if (idx == 0) {
 		idx = wdev->wext.default_key;
 		if (idx < 0)
 			idx = 0;
-	} else if (idx < 1 || idx > 4)
-		return -EINVAL;
-	else
+	} else if (idx < 1 || idx > 4) {
+		err = -EINVAL;
+		goto out;
+	} else {
 		idx--;
+	}
 
 	if (erq->flags & IW_ENCODE_DISABLED)
 		remove = true;
@@ -599,22 +614,28 @@ static int cfg80211_wext_siwencode(struct net_device *dev,
 		if (!err)
 			wdev->wext.default_key = idx;
 		wdev_unlock(wdev);
-		return err;
+		goto out;
 	}
 
 	memset(&params, 0, sizeof(params));
 	params.key = keybuf;
 	params.key_len = erq->length;
-	if (erq->length == 5)
+	if (erq->length == 5) {
 		params.cipher = WLAN_CIPHER_SUITE_WEP40;
-	else if (erq->length == 13)
+	} else if (erq->length == 13) {
 		params.cipher = WLAN_CIPHER_SUITE_WEP104;
-	else if (!remove)
-		return -EINVAL;
+	} else if (!remove) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	err = cfg80211_set_encryption(rdev, dev, false, NULL, remove,
+				      wdev->wext.default_key == -1,
+				      idx, &params);
+out:
+	wiphy_unlock(&rdev->wiphy);
 
-	return cfg80211_set_encryption(rdev, dev, false, NULL, remove,
-				       wdev->wext.default_key == -1,
-				       idx, &params);
+	return err;
 }
 
 static int cfg80211_wext_siwencodeext(struct net_device *dev,
@@ -754,38 +775,61 @@ static int cfg80211_wext_siwfreq(struct net_device *dev,
 	struct cfg80211_chan_def chandef = {
 		.width = NL80211_CHAN_WIDTH_20_NOHT,
 	};
-	int freq;
+	int freq, ret;
+
+	wiphy_lock(&rdev->wiphy);
 
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_STATION:
-		return cfg80211_mgd_wext_siwfreq(dev, info, wextfreq, extra);
+		ret = cfg80211_mgd_wext_siwfreq(dev, info, wextfreq, extra);
+		break;
 	case NL80211_IFTYPE_ADHOC:
-		return cfg80211_ibss_wext_siwfreq(dev, info, wextfreq, extra);
+		ret = cfg80211_ibss_wext_siwfreq(dev, info, wextfreq, extra);
+		break;
 	case NL80211_IFTYPE_MONITOR:
 		freq = cfg80211_wext_freq(wextfreq);
-		if (freq < 0)
-			return freq;
-		if (freq == 0)
-			return -EINVAL;
+		if (freq < 0) {
+			ret = freq;
+			break;
+		}
+		if (freq == 0) {
+			ret = -EINVAL;
+			break;
+		}
 		chandef.center_freq1 = freq;
 		chandef.chan = ieee80211_get_channel(&rdev->wiphy, freq);
-		if (!chandef.chan)
-			return -EINVAL;
-		return cfg80211_set_monitor_channel(rdev, &chandef);
+		if (!chandef.chan) {
+			ret = -EINVAL;
+			break;
+		}
+		ret = cfg80211_set_monitor_channel(rdev, &chandef);
+		break;
 	case NL80211_IFTYPE_MESH_POINT:
 		freq = cfg80211_wext_freq(wextfreq);
-		if (freq < 0)
-			return freq;
-		if (freq == 0)
-			return -EINVAL;
+		if (freq < 0) {
+			ret = freq;
+			break;
+		}
+		if (freq == 0) {
+			ret = -EINVAL;
+			break;
+		}
 		chandef.center_freq1 = freq;
 		chandef.chan = ieee80211_get_channel(&rdev->wiphy, freq);
-		if (!chandef.chan)
-			return -EINVAL;
-		return cfg80211_set_mesh_channel(rdev, wdev, &chandef);
+		if (!chandef.chan) {
+			ret = -EINVAL;
+			break;
+		}
+		ret = cfg80211_set_mesh_channel(rdev, wdev, &chandef);
+		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		break;
 	}
+
+	wiphy_unlock(&rdev->wiphy);
+
+	return ret;
 }
 
 static int cfg80211_wext_giwfreq(struct net_device *dev,
@@ -797,24 +841,35 @@ static int cfg80211_wext_giwfreq(struct net_device *dev,
 	struct cfg80211_chan_def chandef = {};
 	int ret;
 
+	wiphy_lock(&rdev->wiphy);
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_STATION:
-		return cfg80211_mgd_wext_giwfreq(dev, info, freq, extra);
+		ret = cfg80211_mgd_wext_giwfreq(dev, info, freq, extra);
+		break;
 	case NL80211_IFTYPE_ADHOC:
-		return cfg80211_ibss_wext_giwfreq(dev, info, freq, extra);
+		ret = cfg80211_ibss_wext_giwfreq(dev, info, freq, extra);
+		break;
 	case NL80211_IFTYPE_MONITOR:
-		if (!rdev->ops->get_channel)
-			return -EINVAL;
+		if (!rdev->ops->get_channel) {
+			ret = -EINVAL;
+			break;
+		}
 
 		ret = rdev_get_channel(rdev, wdev, &chandef);
 		if (ret)
-			return ret;
+			break;
 		freq->m = chandef.chan->center_freq;
 		freq->e = 6;
-		return 0;
+		ret = 0;
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		break;
 	}
+
+	wiphy_unlock(&rdev->wiphy);
+
+	return ret;
 }
 
 static int cfg80211_wext_siwtxpower(struct net_device *dev,
@@ -825,6 +880,7 @@ static int cfg80211_wext_siwtxpower(struct net_device *dev,
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 	enum nl80211_tx_power_setting type;
 	int dbm = 0;
+	int ret;
 
 	if ((data->txpower.flags & IW_TXPOW_TYPE) != IW_TXPOW_DBM)
 		return -EINVAL;
@@ -866,7 +922,11 @@ static int cfg80211_wext_siwtxpower(struct net_device *dev,
 		return 0;
 	}
 
-	return rdev_set_tx_power(rdev, wdev, type, DBM_TO_MBM(dbm));
+	wiphy_lock(&rdev->wiphy);
+	ret = rdev_set_tx_power(rdev, wdev, type, DBM_TO_MBM(dbm));
+	wiphy_unlock(&rdev->wiphy);
+
+	return ret;
 }
 
 static int cfg80211_wext_giwtxpower(struct net_device *dev,
@@ -885,7 +945,9 @@ static int cfg80211_wext_giwtxpower(struct net_device *dev,
 	if (!rdev->ops->get_tx_power)
 		return -EOPNOTSUPP;
 
+	wiphy_lock(&rdev->wiphy);
 	err = rdev_get_tx_power(rdev, wdev, &val);
+	wiphy_unlock(&rdev->wiphy);
 	if (err)
 		return err;
 
@@ -1125,7 +1187,9 @@ static int cfg80211_wext_siwpower(struct net_device *dev,
 			timeout = wrq->value / 1000;
 	}
 
+	wiphy_lock(&rdev->wiphy);
 	err = rdev_set_power_mgmt(rdev, dev, ps, timeout);
+	wiphy_unlock(&rdev->wiphy);
 	if (err)
 		return err;
 
@@ -1156,7 +1220,7 @@ static int cfg80211_wext_siwrate(struct net_device *dev,
 	struct cfg80211_bitrate_mask mask;
 	u32 fixed, maxrate;
 	struct ieee80211_supported_band *sband;
-	int band, ridx;
+	int band, ridx, ret;
 	bool match = false;
 
 	if (!rdev->ops->set_bitrate_mask)
@@ -1195,7 +1259,11 @@ static int cfg80211_wext_siwrate(struct net_device *dev,
 	if (!match)
 		return -EINVAL;
 
-	return rdev_set_bitrate_mask(rdev, dev, NULL, &mask);
+	wiphy_lock(&rdev->wiphy);
+	ret = rdev_set_bitrate_mask(rdev, dev, NULL, &mask);
+	wiphy_unlock(&rdev->wiphy);
+
+	return ret;
 }
 
 static int cfg80211_wext_giwrate(struct net_device *dev,
@@ -1224,7 +1292,9 @@ static int cfg80211_wext_giwrate(struct net_device *dev,
 	if (err)
 		return err;
 
+	wiphy_lock(&rdev->wiphy);
 	err = rdev_get_station(rdev, dev, addr, &sinfo);
+	wiphy_unlock(&rdev->wiphy);
 	if (err)
 		return err;
 
@@ -1249,6 +1319,7 @@ static struct iw_statistics *cfg80211_wireless_stats(struct net_device *dev)
 	static struct iw_statistics wstats;
 	static struct station_info sinfo = {};
 	u8 bssid[ETH_ALEN];
+	int ret;
 
 	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_STATION)
 		return NULL;
@@ -1267,7 +1338,11 @@ static struct iw_statistics *cfg80211_wireless_stats(struct net_device *dev)
 
 	memset(&sinfo, 0, sizeof(sinfo));
 
-	if (rdev_get_station(rdev, dev, bssid, &sinfo))
+	wiphy_lock(&rdev->wiphy);
+	ret = rdev_get_station(rdev, dev, bssid, &sinfo);
+	wiphy_unlock(&rdev->wiphy);
+
+	if (ret)
 		return NULL;
 
 	memset(&wstats, 0, sizeof(wstats));
@@ -1318,15 +1393,24 @@ static int cfg80211_wext_siwap(struct net_device *dev,
 			       struct sockaddr *ap_addr, char *extra)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
+	int ret;
 
+	wiphy_lock(&rdev->wiphy);
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_ADHOC:
-		return cfg80211_ibss_wext_siwap(dev, info, ap_addr, extra);
+		ret = cfg80211_ibss_wext_siwap(dev, info, ap_addr, extra);
+		break;
 	case NL80211_IFTYPE_STATION:
-		return cfg80211_mgd_wext_siwap(dev, info, ap_addr, extra);
+		ret = cfg80211_mgd_wext_siwap(dev, info, ap_addr, extra);
+		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		break;
 	}
+	wiphy_unlock(&rdev->wiphy);
+
+	return ret;
 }
 
 static int cfg80211_wext_giwap(struct net_device *dev,
@@ -1334,15 +1418,24 @@ static int cfg80211_wext_giwap(struct net_device *dev,
 			       struct sockaddr *ap_addr, char *extra)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
+	int ret;
 
+	wiphy_lock(&rdev->wiphy);
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_ADHOC:
-		return cfg80211_ibss_wext_giwap(dev, info, ap_addr, extra);
+		ret = cfg80211_ibss_wext_giwap(dev, info, ap_addr, extra);
+		break;
 	case NL80211_IFTYPE_STATION:
-		return cfg80211_mgd_wext_giwap(dev, info, ap_addr, extra);
+		ret = cfg80211_mgd_wext_giwap(dev, info, ap_addr, extra);
+		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		break;
 	}
+	wiphy_unlock(&rdev->wiphy);
+
+	return ret;
 }
 
 static int cfg80211_wext_siwessid(struct net_device *dev,
@@ -1350,15 +1443,24 @@ static int cfg80211_wext_siwessid(struct net_device *dev,
 				  struct iw_point *data, char *ssid)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
+	int ret;
 
+	wiphy_lock(&rdev->wiphy);
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_ADHOC:
-		return cfg80211_ibss_wext_siwessid(dev, info, data, ssid);
+		ret = cfg80211_ibss_wext_siwessid(dev, info, data, ssid);
+		break;
 	case NL80211_IFTYPE_STATION:
-		return cfg80211_mgd_wext_siwessid(dev, info, data, ssid);
+		ret = cfg80211_mgd_wext_siwessid(dev, info, data, ssid);
+		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		break;
 	}
+	wiphy_unlock(&rdev->wiphy);
+
+	return ret;
 }
 
 static int cfg80211_wext_giwessid(struct net_device *dev,
@@ -1366,18 +1468,27 @@ static int cfg80211_wext_giwessid(struct net_device *dev,
 				  struct iw_point *data, char *ssid)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
+	int ret;
 
 	data->flags = 0;
 	data->length = 0;
 
+	wiphy_lock(&rdev->wiphy);
 	switch (wdev->iftype) {
 	case NL80211_IFTYPE_ADHOC:
-		return cfg80211_ibss_wext_giwessid(dev, info, data, ssid);
+		ret = cfg80211_ibss_wext_giwessid(dev, info, data, ssid);
+		break;
 	case NL80211_IFTYPE_STATION:
-		return cfg80211_mgd_wext_giwessid(dev, info, data, ssid);
+		ret = cfg80211_mgd_wext_giwessid(dev, info, data, ssid);
+		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		break;
 	}
+	wiphy_unlock(&rdev->wiphy);
+
+	return ret;
 }
 
 static int cfg80211_wext_siwpmksa(struct net_device *dev,
@@ -1388,6 +1499,7 @@ static int cfg80211_wext_siwpmksa(struct net_device *dev,
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 	struct cfg80211_pmksa cfg_pmksa;
 	struct iw_pmksa *pmksa = (struct iw_pmksa *)extra;
+	int ret;
 
 	memset(&cfg_pmksa, 0, sizeof(struct cfg80211_pmksa));
 
@@ -1397,28 +1509,39 @@ static int cfg80211_wext_siwpmksa(struct net_device *dev,
 	cfg_pmksa.bssid = pmksa->bssid.sa_data;
 	cfg_pmksa.pmkid = pmksa->pmkid;
 
+	wiphy_lock(&rdev->wiphy);
 	switch (pmksa->cmd) {
 	case IW_PMKSA_ADD:
-		if (!rdev->ops->set_pmksa)
-			return -EOPNOTSUPP;
-
-		return rdev_set_pmksa(rdev, dev, &cfg_pmksa);
+		if (!rdev->ops->set_pmksa) {
+			ret = -EOPNOTSUPP;
+			break;
+		}
 
+		ret = rdev_set_pmksa(rdev, dev, &cfg_pmksa);
+		break;
 	case IW_PMKSA_REMOVE:
-		if (!rdev->ops->del_pmksa)
-			return -EOPNOTSUPP;
-
-		return rdev_del_pmksa(rdev, dev, &cfg_pmksa);
+		if (!rdev->ops->del_pmksa) {
+			ret = -EOPNOTSUPP;
+			break;
+		}
 
+		ret = rdev_del_pmksa(rdev, dev, &cfg_pmksa);
+		break;
 	case IW_PMKSA_FLUSH:
-		if (!rdev->ops->flush_pmksa)
-			return -EOPNOTSUPP;
-
-		return rdev_flush_pmksa(rdev, dev);
+		if (!rdev->ops->flush_pmksa) {
+			ret = -EOPNOTSUPP;
+			break;
+		}
 
+		ret = rdev_flush_pmksa(rdev, dev);
+		break;
 	default:
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		break;
 	}
+	wiphy_unlock(&rdev->wiphy);
+
+	return ret;
 }
 
 #define DEFINE_WEXT_COMPAT_STUB(func, type)			\
diff --git a/net/wireless/wext-sme.c b/net/wireless/wext-sme.c
index 73df23570d43..193a18a53142 100644
--- a/net/wireless/wext-sme.c
+++ b/net/wireless/wext-sme.c
@@ -3,7 +3,7 @@
  * cfg80211 wext compat for managed mode.
  *
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2009   Intel Corporation. All rights reserved.
+ * Copyright (C) 2009, 2020-2021 Intel Corporation.
  */
 
 #include <linux/export.h>
@@ -379,6 +379,7 @@ int cfg80211_wext_siwmlme(struct net_device *dev,
 	if (mlme->addr.sa_family != ARPHRD_ETHER)
 		return -EINVAL;
 
+	wiphy_lock(&rdev->wiphy);
 	wdev_lock(wdev);
 	switch (mlme->cmd) {
 	case IW_MLME_DEAUTH:
@@ -390,6 +391,7 @@ int cfg80211_wext_siwmlme(struct net_device *dev,
 		break;
 	}
 	wdev_unlock(wdev);
+	wiphy_unlock(&rdev->wiphy);
 
 	return err;
 }
-- 
2.26.2

