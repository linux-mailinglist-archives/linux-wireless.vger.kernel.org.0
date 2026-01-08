Return-Path: <linux-wireless+bounces-30524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A19D040CC
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 672C632B452B
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F91036C0B1;
	Thu,  8 Jan 2026 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+Fus2k7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18567344034
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861370; cv=none; b=nI8Ex4JMajMCooxAKB8f8fj6n6jUtkWXn8hZYij1YC2KOi0DlT3YesP2wrHp2j7Cxip3EVQxxWH77jTuSiGQFEc6MOV+Qdo+fK2pjrDh6K1XixjBlpfsnXs36s2LLwmJtgw0hiBDLe/3OutWUfQ68sSNgjao7CPATWeEd3A27n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861370; c=relaxed/simple;
	bh=WfBbs2nhHiZN+gkGmrmvqS7YbYo+z0CfIm/qKDYd3lE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ISO86+SRWIuOuJNNz43twDr1iPybYs0+83/qvYTGCv6EaUSrKBGDFrd2FlsIXD+8V63VqyF13eQli6lB+JkXzXhV4osxEUVVZhDDyTqXISW7efhIZVrqKVn47BMPESC/aGlw57cc+lGQcOtG+hPeNLMgyNJiU3NMvM54iE9PSgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+Fus2k7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767861362; x=1799397362;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=WfBbs2nhHiZN+gkGmrmvqS7YbYo+z0CfIm/qKDYd3lE=;
  b=R+Fus2k7lwtynZ89TzNqYreA8BWc6RBSOESmxYTAZJOfLFbrAEvBWU/l
   074G9ig6EoYoXO5slWIhgu+F7g1ApaQpU9g6GTsGpKiWZTaIfgojSJSIl
   87lRxwm/ZU7mtXCGe9qqeNAhSE1qpWV5DuO8+f9gzKcL9tqMqTY5V3nic
   Q8YHjYn5m/H0/c0dliBTfxQWHAyE+9Z7xL/TfDGH5R1nK0Mq2kEYad+hf
   NhM6mK8awtKMpLTCp0p0tJsSLrP/EMvQYkrs/vpkzkpmRXwqrmb48D5ym
   UQYY4HcDVihZ92DRlVhi02DtfrF74xGJaVOewbpTYg05YjdFTQH5F57kZ
   w==;
X-CSE-ConnectionGUID: Iczi2lppRZaVHHlp8H25Bg==
X-CSE-MsgGUID: wrHVNDHhTma08zRnb3cqyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="73084785"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="73084785"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:35:54 -0800
X-CSE-ConnectionGUID: bgnPNhOiSRmUwf1G0p+S2Q==
X-CSE-MsgGUID: pDmiw8mfQemLuHZVPWz5HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="233847456"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:35:52 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next v2 03/14] wifi: nl80211/cfg80211: support stations of non-netdev interfaces
Date: Thu,  8 Jan 2026 10:35:29 +0200
Message-Id: <20260108102921.7aa9b564fe81.Ic02066b88bb8ad6b21e15cbea8d720280008c83b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260108083540.3129471-1-miriam.rachel.korenblit@intel.com>
References: <20260108083540.3129471-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Currently, a station can only be added to a netdev interface,
mainly because there was no need for a station of a non-netdev
interface.

But for NAN, we will have stations that belong to the NL80211_IFTYPE_NAN
interface.

Prepare for adding/changing/deleting a station that belongs to a non-netdev
interface. This doesn't actually allow such stations - this will be done
in a different patch.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |   9 +-
 drivers/net/wireless/ath/ath6kl/main.c        |   4 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  20 ++--
 drivers/net/wireless/ath/wil6210/main.c       |   3 +-
 drivers/net/wireless/ath/wil6210/wmi.c        |   5 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  23 ++--
 drivers/net/wireless/marvell/libertas/cfg.c   |   2 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  24 ++--
 .../net/wireless/marvell/mwifiex/uap_event.c  |   7 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |  26 ++---
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  26 ++---
 .../net/wireless/quantenna/qtnfmac/event.c    |   6 +-
 drivers/net/wireless/virtual/virt_wifi.c      |  12 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  24 ++--
 include/net/cfg80211.h                        |  24 ++--
 net/mac80211/cfg.c                            |  21 ++--
 net/mac80211/sta_info.c                       |   4 +-
 net/wireless/nl80211.c                        |  84 ++++++++------
 net/wireless/rdev-ops.h                       |  30 ++---
 net/wireless/trace.h                          | 104 ++++++++++++------
 net/wireless/util.c                           |   2 +-
 net/wireless/wext-compat.c                    |   6 +-
 22 files changed, 264 insertions(+), 202 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index 88f0197fc041..eecba2201b10 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -1775,9 +1775,10 @@ static bool is_rate_ht40(s32 rate, u8 *mcs, bool *sgi)
 	return false;
 }
 
-static int ath6kl_get_station(struct wiphy *wiphy, struct net_device *dev,
+static int ath6kl_get_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 			      const u8 *mac, struct station_info *sinfo)
 {
+	struct net_device *dev = wdev->netdev;
 	struct ath6kl *ar = ath6kl_priv(dev);
 	struct ath6kl_vif *vif = netdev_priv(dev);
 	long left;
@@ -2992,9 +2993,10 @@ static int ath6kl_stop_ap(struct wiphy *wiphy, struct net_device *dev,
 
 static const u8 bcast_addr[ETH_ALEN] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 
-static int ath6kl_del_station(struct wiphy *wiphy, struct net_device *dev,
+static int ath6kl_del_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 			      struct station_del_parameters *params)
 {
+	struct net_device *dev = wdev->netdev;
 	struct ath6kl *ar = ath6kl_priv(dev);
 	struct ath6kl_vif *vif = netdev_priv(dev);
 	const u8 *addr = params->mac ? params->mac : bcast_addr;
@@ -3003,10 +3005,11 @@ static int ath6kl_del_station(struct wiphy *wiphy, struct net_device *dev,
 				      addr, WLAN_REASON_PREV_AUTH_NOT_VALID);
 }
 
-static int ath6kl_change_station(struct wiphy *wiphy, struct net_device *dev,
+static int ath6kl_change_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 				 const u8 *mac,
 				 struct station_parameters *params)
 {
+	struct net_device *dev = wdev->netdev;
 	struct ath6kl *ar = ath6kl_priv(dev);
 	struct ath6kl_vif *vif = netdev_priv(dev);
 	int err;
diff --git a/drivers/net/wireless/ath/ath6kl/main.c b/drivers/net/wireless/ath/ath6kl/main.c
index 59068ea3879b..6fbc54f22369 100644
--- a/drivers/net/wireless/ath/ath6kl/main.c
+++ b/drivers/net/wireless/ath/ath6kl/main.c
@@ -494,7 +494,7 @@ void ath6kl_connect_ap_mode_sta(struct ath6kl_vif *vif, u16 aid, u8 *mac_addr,
 	sinfo->assoc_req_ies = ies;
 	sinfo->assoc_req_ies_len = ies_len;
 
-	cfg80211_new_sta(vif->ndev, mac_addr, sinfo, GFP_KERNEL);
+	cfg80211_new_sta(&vif->wdev, mac_addr, sinfo, GFP_KERNEL);
 
 	netif_wake_queue(vif->ndev);
 
@@ -1011,7 +1011,7 @@ void ath6kl_disconnect_event(struct ath6kl_vif *vif, u8 reason, u8 *bssid,
 
 		if (!is_broadcast_ether_addr(bssid)) {
 			/* send event to application */
-			cfg80211_del_sta(vif->ndev, bssid, GFP_KERNEL);
+			cfg80211_del_sta(&vif->wdev, bssid, GFP_KERNEL);
 		}
 
 		if (memcmp(vif->ndev->dev_addr, bssid, ETH_ALEN) == 0) {
diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 7218fe70f3bc..f97a311d9f76 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -533,11 +533,11 @@ int wil_cid_fill_sinfo(struct wil6210_vif *vif, int cid,
 }
 
 static int wil_cfg80211_get_station(struct wiphy *wiphy,
-				    struct net_device *ndev,
+				    struct wireless_dev *wdev,
 				    const u8 *mac, struct station_info *sinfo)
 {
-	struct wil6210_vif *vif = ndev_to_vif(ndev);
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
+	struct wil6210_vif *vif = wdev_to_vif(wil, wdev);
 	int rc;
 
 	int cid = wil_find_cid(wil, vif->mid, mac);
@@ -573,11 +573,11 @@ int wil_find_cid_by_idx(struct wil6210_priv *wil, u8 mid, int idx)
 }
 
 static int wil_cfg80211_dump_station(struct wiphy *wiphy,
-				     struct net_device *dev, int idx,
+				     struct wireless_dev *wdev, int idx,
 				     u8 *mac, struct station_info *sinfo)
 {
-	struct wil6210_vif *vif = ndev_to_vif(dev);
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
+	struct wil6210_vif *vif = wdev_to_vif(wil, wdev);
 	int rc;
 	int cid = wil_find_cid_by_idx(wil, vif->mid, idx);
 
@@ -2225,12 +2225,12 @@ static int wil_cfg80211_stop_ap(struct wiphy *wiphy,
 }
 
 static int wil_cfg80211_add_station(struct wiphy *wiphy,
-				    struct net_device *dev,
+				    struct wireless_dev *wdev,
 				    const u8 *mac,
 				    struct station_parameters *params)
 {
-	struct wil6210_vif *vif = ndev_to_vif(dev);
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
+	struct wil6210_vif *vif = wdev_to_vif(wil, wdev);
 
 	wil_dbg_misc(wil, "add station %pM aid %d mid %d mask 0x%x set 0x%x\n",
 		     mac, params->aid, vif->mid,
@@ -2250,11 +2250,11 @@ static int wil_cfg80211_add_station(struct wiphy *wiphy,
 }
 
 static int wil_cfg80211_del_station(struct wiphy *wiphy,
-				    struct net_device *dev,
+				    struct wireless_dev *wdev,
 				    struct station_del_parameters *params)
 {
-	struct wil6210_vif *vif = ndev_to_vif(dev);
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
+	struct wil6210_vif *vif = wdev_to_vif(wil, wdev);
 
 	wil_dbg_misc(wil, "del_station: %pM, reason=%d mid=%d\n",
 		     params->mac, params->reason_code, vif->mid);
@@ -2267,12 +2267,12 @@ static int wil_cfg80211_del_station(struct wiphy *wiphy,
 }
 
 static int wil_cfg80211_change_station(struct wiphy *wiphy,
-				       struct net_device *dev,
+				       struct wireless_dev *wdev,
 				       const u8 *mac,
 				       struct station_parameters *params)
 {
-	struct wil6210_vif *vif = ndev_to_vif(dev);
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
+	struct wil6210_vif *vif = wdev_to_vif(wil, wdev);
 	int authorize;
 	int cid, i;
 	struct wil_ring_tx_data *txdata = NULL;
diff --git a/drivers/net/wireless/ath/wil6210/main.c b/drivers/net/wireless/ath/wil6210/main.c
index 44c24c6c8360..d5aec72ecdce 100644
--- a/drivers/net/wireless/ath/wil6210/main.c
+++ b/drivers/net/wireless/ath/wil6210/main.c
@@ -245,7 +245,6 @@ __acquires(&sta->tid_rx_lock) __releases(&sta->tid_rx_lock)
 {
 	uint i;
 	struct wil6210_priv *wil = vif_to_wil(vif);
-	struct net_device *ndev = vif_to_ndev(vif);
 	struct wireless_dev *wdev = vif_to_wdev(vif);
 	struct wil_sta_info *sta = &wil->sta[cid];
 	int min_ring_id = wil_get_min_tx_ring_id(wil);
@@ -265,7 +264,7 @@ __acquires(&sta->tid_rx_lock) __releases(&sta->tid_rx_lock)
 		case NL80211_IFTYPE_AP:
 		case NL80211_IFTYPE_P2P_GO:
 			/* AP-like interface */
-			cfg80211_del_sta(ndev, sta->addr, GFP_KERNEL);
+			cfg80211_del_sta(wdev, sta->addr, GFP_KERNEL);
 			break;
 		default:
 			break;
diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 6d376f85fbde..010454e41948 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -1076,7 +1076,7 @@ static void wmi_evt_connect(struct wil6210_vif *vif, int id, void *d, int len)
 		if (rc) {
 			if (disable_ap_sme)
 				/* notify new_sta has failed */
-				cfg80211_del_sta(ndev, evt->bssid, GFP_KERNEL);
+				cfg80211_del_sta(wdev, evt->bssid, GFP_KERNEL);
 			goto out;
 		}
 
@@ -1093,7 +1093,8 @@ static void wmi_evt_connect(struct wil6210_vif *vif, int id, void *d, int len)
 			sinfo->assoc_req_ies_len = assoc_req_ielen;
 		}
 
-		cfg80211_new_sta(ndev, evt->bssid, sinfo, GFP_KERNEL);
+		cfg80211_new_sta(ndev->ieee80211_ptr, evt->bssid, sinfo,
+				 GFP_KERNEL);
 
 		kfree(sinfo);
 	} else {
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index bb96b87b2a6e..ce39c917a8c5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -3132,11 +3132,11 @@ brcmf_cfg80211_get_station_ibss(struct brcmf_if *ifp,
 }
 
 static s32
-brcmf_cfg80211_get_station(struct wiphy *wiphy, struct net_device *ndev,
+brcmf_cfg80211_get_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 			   const u8 *mac, struct station_info *sinfo)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
-	struct brcmf_if *ifp = netdev_priv(ndev);
+	struct brcmf_if *ifp = netdev_priv(wdev->netdev);
 	struct brcmf_pub *drvr = cfg->pub;
 	struct brcmf_scb_val_le scb_val;
 	s32 err = 0;
@@ -3255,11 +3255,11 @@ brcmf_cfg80211_get_station(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static int
-brcmf_cfg80211_dump_station(struct wiphy *wiphy, struct net_device *ndev,
+brcmf_cfg80211_dump_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 			    int idx, u8 *mac, struct station_info *sinfo)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
-	struct brcmf_if *ifp = netdev_priv(ndev);
+	struct brcmf_if *ifp = netdev_priv(wdev->netdev);
 	struct brcmf_pub *drvr = cfg->pub;
 	s32 err;
 
@@ -3284,7 +3284,8 @@ brcmf_cfg80211_dump_station(struct wiphy *wiphy, struct net_device *ndev,
 	}
 	if (idx < le32_to_cpu(cfg->assoclist.count)) {
 		memcpy(mac, cfg->assoclist.mac[idx], ETH_ALEN);
-		return brcmf_cfg80211_get_station(wiphy, ndev, mac, sinfo);
+		return brcmf_cfg80211_get_station(wiphy, wdev,
+						  mac, sinfo);
 	}
 	return -ENOENT;
 }
@@ -5452,12 +5453,13 @@ brcmf_cfg80211_change_beacon(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static int
-brcmf_cfg80211_del_station(struct wiphy *wiphy, struct net_device *ndev,
+brcmf_cfg80211_del_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 			   struct station_del_parameters *params)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct brcmf_pub *drvr = cfg->pub;
 	struct brcmf_scb_val_le scbval;
+	struct net_device *ndev = wdev->netdev;
 	struct brcmf_if *ifp = netdev_priv(ndev);
 	s32 err;
 
@@ -5484,12 +5486,12 @@ brcmf_cfg80211_del_station(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static int
-brcmf_cfg80211_change_station(struct wiphy *wiphy, struct net_device *ndev,
+brcmf_cfg80211_change_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 			      const u8 *mac, struct station_parameters *params)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct brcmf_pub *drvr = cfg->pub;
-	struct brcmf_if *ifp = netdev_priv(ndev);
+	struct brcmf_if *ifp = netdev_priv(wdev->netdev);
 	s32 err;
 
 	brcmf_dbg(TRACE, "Enter, MAC %pM, mask 0x%04x set 0x%04x\n", mac,
@@ -6548,13 +6550,14 @@ brcmf_notify_connect_status_ap(struct brcmf_cfg80211_info *cfg,
 		sinfo->assoc_req_ies_len = e->datalen;
 		generation++;
 		sinfo->generation = generation;
-		cfg80211_new_sta(ndev, e->addr, sinfo, GFP_KERNEL);
+		cfg80211_new_sta(ndev->ieee80211_ptr, e->addr, sinfo,
+				 GFP_KERNEL);
 
 		kfree(sinfo);
 	} else if ((event == BRCMF_E_DISASSOC_IND) ||
 		   (event == BRCMF_E_DEAUTH_IND) ||
 		   (event == BRCMF_E_DEAUTH)) {
-		cfg80211_del_sta(ndev, e->addr, GFP_KERNEL);
+		cfg80211_del_sta(ndev->ieee80211_ptr, e->addr, GFP_KERNEL);
 	}
 	return 0;
 }
diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index caba7491cd5a..4c5b712eb1e1 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -1607,7 +1607,7 @@ static int lbs_cfg_del_key(struct wiphy *wiphy, struct net_device *netdev,
  * Get station
  */
 
-static int lbs_cfg_get_station(struct wiphy *wiphy, struct net_device *dev,
+static int lbs_cfg_get_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 			       const u8 *mac, struct station_info *sinfo)
 {
 	struct lbs_private *priv = wiphy_priv(wiphy);
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index be23a29e7de0..ef32ff611ba3 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -1554,10 +1554,10 @@ mwifiex_dump_station_info(struct mwifiex_private *priv,
  * requested station information, if available.
  */
 static int
-mwifiex_cfg80211_get_station(struct wiphy *wiphy, struct net_device *dev,
+mwifiex_cfg80211_get_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 			     const u8 *mac, struct station_info *sinfo)
 {
-	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
+	struct mwifiex_private *priv = mwifiex_netdev_get_priv(wdev->netdev);
 
 	if (!priv->media_connected)
 		return -ENOENT;
@@ -1571,10 +1571,10 @@ mwifiex_cfg80211_get_station(struct wiphy *wiphy, struct net_device *dev,
  * CFG802.11 operation handler to dump station information.
  */
 static int
-mwifiex_cfg80211_dump_station(struct wiphy *wiphy, struct net_device *dev,
+mwifiex_cfg80211_dump_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 			      int idx, u8 *mac, struct station_info *sinfo)
 {
-	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
+	struct mwifiex_private *priv = mwifiex_netdev_get_priv(wdev->netdev);
 	struct mwifiex_sta_node *node;
 	int i;
 
@@ -1901,10 +1901,11 @@ static int mwifiex_cfg80211_change_beacon(struct wiphy *wiphy,
  * associated stations list, no action is taken.
  */
 static int
-mwifiex_cfg80211_del_station(struct wiphy *wiphy, struct net_device *dev,
+mwifiex_cfg80211_del_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 			     struct station_del_parameters *params)
 {
-	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
+	struct mwifiex_private *priv =
+		mwifiex_netdev_get_priv(wdev->netdev);
 	struct mwifiex_sta_node *sta_node;
 	u8 deauth_mac[ETH_ALEN];
 
@@ -3988,7 +3989,8 @@ mwifiex_cfg80211_uap_add_station(struct mwifiex_private *priv, const u8 *mac,
 		if (!sinfo)
 			return -ENOMEM;
 
-		cfg80211_new_sta(priv->netdev, mac, sinfo, GFP_KERNEL);
+		cfg80211_new_sta(priv->netdev->ieee80211_ptr, mac, sinfo,
+				 GFP_KERNEL);
 		kfree(sinfo);
 	}
 
@@ -3996,10 +3998,10 @@ mwifiex_cfg80211_uap_add_station(struct mwifiex_private *priv, const u8 *mac,
 }
 
 static int
-mwifiex_cfg80211_add_station(struct wiphy *wiphy, struct net_device *dev,
+mwifiex_cfg80211_add_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 			     const u8 *mac, struct station_parameters *params)
 {
-	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
+	struct mwifiex_private *priv = mwifiex_netdev_get_priv(wdev->netdev);
 
 	if (priv->adapter->host_mlme_enabled &&
 	    (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP))
@@ -4235,12 +4237,12 @@ mwifiex_cfg80211_start_radar_detection(struct wiphy *wiphy,
 }
 
 static int
-mwifiex_cfg80211_change_station(struct wiphy *wiphy, struct net_device *dev,
+mwifiex_cfg80211_change_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 				const u8 *mac,
 				struct station_parameters *params)
 {
 	int ret;
-	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
+	struct mwifiex_private *priv = mwifiex_netdev_get_priv(wdev->netdev);
 
 	if (priv->adapter->host_mlme_enabled &&
 	    (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP))
diff --git a/drivers/net/wireless/marvell/mwifiex/uap_event.c b/drivers/net/wireless/marvell/mwifiex/uap_event.c
index 245cb99a3daa..014aa75a612a 100644
--- a/drivers/net/wireless/marvell/mwifiex/uap_event.c
+++ b/drivers/net/wireless/marvell/mwifiex/uap_event.c
@@ -130,8 +130,8 @@ int mwifiex_process_uap_event(struct mwifiex_private *priv)
 					le16_to_cpu(event->len) - (u16)len;
 			}
 		}
-		cfg80211_new_sta(priv->netdev, event->sta_addr, sinfo,
-				 GFP_KERNEL);
+		cfg80211_new_sta(priv->netdev->ieee80211_ptr, event->sta_addr,
+				 sinfo, GFP_KERNEL);
 
 		node = mwifiex_add_sta_entry(priv, event->sta_addr);
 		if (!node) {
@@ -162,7 +162,8 @@ int mwifiex_process_uap_event(struct mwifiex_private *priv)
 	case EVENT_UAP_STA_DEAUTH:
 		deauth_mac = adapter->event_body +
 			     MWIFIEX_UAP_EVENT_EXTRA_HEADER;
-		cfg80211_del_sta(priv->netdev, deauth_mac, GFP_KERNEL);
+		cfg80211_del_sta(priv->netdev->ieee80211_ptr, deauth_mac,
+				 GFP_KERNEL);
 
 		if (priv->ap_11n_enabled) {
 			mwifiex_11n_del_rx_reorder_tbl_by_ta(priv, deauth_mac);
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index c39e7f313ea1..d854cb10fd2b 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -736,9 +736,10 @@ static int set_default_mgmt_key(struct wiphy *wiphy, struct net_device *netdev,
 	return wilc_set_default_mgmt_key_index(vif, key_index);
 }
 
-static int get_station(struct wiphy *wiphy, struct net_device *dev,
+static int get_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 		       const u8 *mac, struct station_info *sinfo)
 {
+	struct net_device *dev = wdev->netdev;
 	struct wilc_vif *vif = netdev_priv(dev);
 	struct wilc_priv *priv = &vif->priv;
 	struct wilc *wilc = vif->wilc;
@@ -1315,10 +1316,10 @@ static int set_cqm_rssi_config(struct wiphy *wiphy, struct net_device *dev,
 	return 0;
 }
 
-static int dump_station(struct wiphy *wiphy, struct net_device *dev,
+static int dump_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 			int idx, u8 *mac, struct station_info *sinfo)
 {
-	struct wilc_vif *vif = netdev_priv(dev);
+	struct wilc_vif *vif = netdev_priv(wdev->netdev);
 	int ret;
 
 	if (idx != 0)
@@ -1453,11 +1454,11 @@ static int stop_ap(struct wiphy *wiphy, struct net_device *dev,
 	return ret;
 }
 
-static int add_station(struct wiphy *wiphy, struct net_device *dev,
+static int add_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 		       const u8 *mac, struct station_parameters *params)
 {
 	int ret = 0;
-	struct wilc_vif *vif = netdev_priv(dev);
+	struct wilc_vif *vif = netdev_priv(wdev->netdev);
 	struct wilc_priv *priv = &vif->priv;
 
 	if (vif->iftype == WILC_AP_MODE || vif->iftype == WILC_GO_MODE) {
@@ -1466,18 +1467,18 @@ static int add_station(struct wiphy *wiphy, struct net_device *dev,
 
 		ret = wilc_add_station(vif, mac, params);
 		if (ret)
-			netdev_err(dev, "Host add station fail\n");
+			netdev_err(wdev->netdev, "Host add station fail\n");
 	}
 
 	return ret;
 }
 
-static int del_station(struct wiphy *wiphy, struct net_device *dev,
+static int del_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 		       struct station_del_parameters *params)
 {
 	const u8 *mac = params->mac;
 	int ret = 0;
-	struct wilc_vif *vif = netdev_priv(dev);
+	struct wilc_vif *vif = netdev_priv(wdev->netdev);
 	struct wilc_priv *priv = &vif->priv;
 	struct sta_info *info;
 
@@ -1491,20 +1492,19 @@ static int del_station(struct wiphy *wiphy, struct net_device *dev,
 
 	ret = wilc_del_station(vif, mac);
 	if (ret)
-		netdev_err(dev, "Host delete station fail\n");
+		netdev_err(wdev->netdev, "Host delete station fail\n");
 	return ret;
 }
 
-static int change_station(struct wiphy *wiphy, struct net_device *dev,
+static int change_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 			  const u8 *mac, struct station_parameters *params)
 {
 	int ret = 0;
-	struct wilc_vif *vif = netdev_priv(dev);
-
+	struct wilc_vif *vif = netdev_priv(wdev->netdev);
 	if (vif->iftype == WILC_AP_MODE || vif->iftype == WILC_GO_MODE) {
 		ret = wilc_edit_station(vif, mac, params);
 		if (ret)
-			netdev_err(dev, "Host edit station fail\n");
+			netdev_err(wdev->netdev, "Host edit station fail\n");
 	}
 	return ret;
 }
diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index f1188368e66b..340240847a2f 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -483,26 +483,26 @@ qtnf_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 }
 
 static int
-qtnf_get_station(struct wiphy *wiphy, struct net_device *dev,
+qtnf_get_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 		 const u8 *mac, struct station_info *sinfo)
 {
-	struct qtnf_vif *vif = qtnf_netdev_get_priv(dev);
+	struct qtnf_vif *vif = qtnf_netdev_get_priv(wdev->netdev);
 
 	sinfo->generation = vif->generation;
 	return qtnf_cmd_get_sta_info(vif, mac, sinfo);
 }
 
 static int
-qtnf_dump_station(struct wiphy *wiphy, struct net_device *dev,
+qtnf_dump_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 		  int idx, u8 *mac, struct station_info *sinfo)
 {
-	struct qtnf_vif *vif = qtnf_netdev_get_priv(dev);
+	struct qtnf_vif *vif = qtnf_netdev_get_priv(wdev->netdev);
 	const struct qtnf_sta_node *sta_node;
 	int ret;
 
-	switch (vif->wdev.iftype) {
+	switch (wdev->iftype) {
 	case NL80211_IFTYPE_STATION:
-		if (idx != 0 || !vif->wdev.connected)
+		if (idx != 0 || !wdev->connected)
 			return -ENOENT;
 
 		ether_addr_copy(mac, vif->bssid);
@@ -520,9 +520,9 @@ qtnf_dump_station(struct wiphy *wiphy, struct net_device *dev,
 
 	ret = qtnf_cmd_get_sta_info(vif, mac, sinfo);
 
-	if (vif->wdev.iftype == NL80211_IFTYPE_AP) {
+	if (wdev->iftype == NL80211_IFTYPE_AP) {
 		if (ret == -ENOENT) {
-			cfg80211_del_sta(vif->netdev, mac, GFP_KERNEL);
+			cfg80211_del_sta(&vif->wdev, mac, GFP_KERNEL);
 			sinfo->filled = 0;
 		}
 	}
@@ -602,10 +602,10 @@ qtnf_set_default_mgmt_key(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int
-qtnf_change_station(struct wiphy *wiphy, struct net_device *dev,
+qtnf_change_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 		    const u8 *mac, struct station_parameters *params)
 {
-	struct qtnf_vif *vif = qtnf_netdev_get_priv(dev);
+	struct qtnf_vif *vif = qtnf_netdev_get_priv(wdev->netdev);
 	int ret;
 
 	ret = qtnf_cmd_send_change_sta(vif, mac, params);
@@ -617,14 +617,14 @@ qtnf_change_station(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int
-qtnf_del_station(struct wiphy *wiphy, struct net_device *dev,
+qtnf_del_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 		 struct station_del_parameters *params)
 {
-	struct qtnf_vif *vif = qtnf_netdev_get_priv(dev);
+	struct qtnf_vif *vif = qtnf_netdev_get_priv(wdev->netdev);
 	int ret;
 
 	if (params->mac &&
-	    (vif->wdev.iftype == NL80211_IFTYPE_AP) &&
+	    (wdev->iftype == NL80211_IFTYPE_AP) &&
 	    !is_broadcast_ether_addr(params->mac) &&
 	    !qtnf_sta_list_lookup(&vif->sta_list, params->mac))
 		return 0;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/event.c b/drivers/net/wireless/quantenna/qtnfmac/event.c
index 71840f41b73c..fb514bac548e 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/event.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/event.c
@@ -90,8 +90,8 @@ qtnf_event_handle_sta_assoc(struct qtnf_wmac *mac, struct qtnf_vif *vif,
 		goto out;
 	}
 
-	cfg80211_new_sta(vif->netdev, sta_assoc->sta_addr, sinfo,
-			 GFP_KERNEL);
+	cfg80211_new_sta(vif->netdev->ieee80211_ptr, sta_assoc->sta_addr,
+			 sinfo, GFP_KERNEL);
 
 out:
 	kfree(sinfo);
@@ -126,7 +126,7 @@ qtnf_event_handle_sta_deauth(struct qtnf_wmac *mac, struct qtnf_vif *vif,
 		 sta_addr, reason);
 
 	if (qtnf_sta_list_del(vif, sta_addr))
-		cfg80211_del_sta(vif->netdev, sta_deauth->sta_addr,
+		cfg80211_del_sta(&vif->wdev, sta_deauth->sta_addr,
 				 GFP_KERNEL);
 
 	return 0;
diff --git a/drivers/net/wireless/virtual/virt_wifi.c b/drivers/net/wireless/virtual/virt_wifi.c
index 4eae89376feb..43617c32d70f 100644
--- a/drivers/net/wireless/virtual/virt_wifi.c
+++ b/drivers/net/wireless/virtual/virt_wifi.c
@@ -320,9 +320,11 @@ static int virt_wifi_disconnect(struct wiphy *wiphy, struct net_device *netdev,
 }
 
 /* Called with the rtnl lock held. */
-static int virt_wifi_get_station(struct wiphy *wiphy, struct net_device *dev,
-				 const u8 *mac, struct station_info *sinfo)
+static int virt_wifi_get_station(struct wiphy *wiphy,
+				 struct wireless_dev *wdev, const u8 *mac,
+				 struct station_info *sinfo)
 {
+	struct net_device *dev = wdev->netdev;
 	struct virt_wifi_netdev_priv *priv = netdev_priv(dev);
 
 	wiphy_debug(wiphy, "get_station\n");
@@ -345,10 +347,10 @@ static int virt_wifi_get_station(struct wiphy *wiphy, struct net_device *dev,
 }
 
 /* Called with the rtnl lock held. */
-static int virt_wifi_dump_station(struct wiphy *wiphy, struct net_device *dev,
+static int virt_wifi_dump_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 				  int idx, u8 *mac, struct station_info *sinfo)
 {
-	struct virt_wifi_netdev_priv *priv = netdev_priv(dev);
+	struct virt_wifi_netdev_priv *priv = netdev_priv(wdev->netdev);
 
 	wiphy_debug(wiphy, "dump_station\n");
 
@@ -356,7 +358,7 @@ static int virt_wifi_dump_station(struct wiphy *wiphy, struct net_device *dev,
 		return -ENOENT;
 
 	ether_addr_copy(mac, fake_router_bssid);
-	return virt_wifi_get_station(wiphy, dev, fake_router_bssid, sinfo);
+	return virt_wifi_get_station(wiphy, wdev, fake_router_bssid, sinfo);
 }
 
 static const struct cfg80211_ops virt_wifi_cfg80211_ops = {
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 60edeae1cffe..c24f3cb8b999 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -959,11 +959,12 @@ static int cfg80211_rtw_set_default_key(struct wiphy *wiphy,
 }
 
 static int cfg80211_rtw_get_station(struct wiphy *wiphy,
-				    struct net_device *ndev,
+				    struct wireless_dev *wdev,
 				const u8 *mac,
 				struct station_info *sinfo)
 {
 	int ret = 0;
+	struct net_device *ndev = wdev_to_ndev(wdev);
 	struct adapter *padapter = rtw_netdev_priv(ndev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct sta_info *psta = NULL;
@@ -1914,7 +1915,7 @@ static int cfg80211_rtw_flush_pmksa(struct wiphy *wiphy,
 
 void rtw_cfg80211_indicate_sta_assoc(struct adapter *padapter, u8 *pmgmt_frame, uint frame_len)
 {
-	struct net_device *ndev = padapter->pnetdev;
+	struct wireless_dev *wdev = padapter->rtw_wdev;
 
 	{
 		struct station_info sinfo = {};
@@ -1928,15 +1929,15 @@ void rtw_cfg80211_indicate_sta_assoc(struct adapter *padapter, u8 *pmgmt_frame,
 		sinfo.filled = 0;
 		sinfo.assoc_req_ies = pmgmt_frame + WLAN_HDR_A3_LEN + ie_offset;
 		sinfo.assoc_req_ies_len = frame_len - WLAN_HDR_A3_LEN - ie_offset;
-		cfg80211_new_sta(ndev, GetAddr2Ptr(pmgmt_frame), &sinfo, GFP_ATOMIC);
+		cfg80211_new_sta(wdev, GetAddr2Ptr(pmgmt_frame), &sinfo, GFP_ATOMIC);
 	}
 }
 
 void rtw_cfg80211_indicate_sta_disassoc(struct adapter *padapter, unsigned char *da, unsigned short reason)
 {
-	struct net_device *ndev = padapter->pnetdev;
+	struct wireless_dev *wdev = padapter->rtw_wdev;
 
-	cfg80211_del_sta(ndev, da, GFP_ATOMIC);
+	cfg80211_del_sta(wdev, da, GFP_ATOMIC);
 }
 
 static u8 rtw_get_chan_type(struct adapter *adapter)
@@ -2325,21 +2326,22 @@ static int cfg80211_rtw_stop_ap(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static int	cfg80211_rtw_add_station(struct wiphy *wiphy,
-					 struct net_device *ndev,
+					 struct wireless_dev *wdev,
 					 const u8 *mac,
 					 struct station_parameters *params)
 {
 	return 0;
 }
 
-static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev,
+static int cfg80211_rtw_del_station(struct wiphy *wiphy,
+				    struct wireless_dev *wdev,
 				    struct station_del_parameters *params)
 {
 	int ret = 0;
 	struct list_head *phead, *plist, *tmp;
 	u8 updated = false;
 	struct sta_info *psta = NULL;
-	struct adapter *padapter = rtw_netdev_priv(ndev);
+	struct adapter *padapter = rtw_netdev_priv(wdev->netdev);
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	const u8 *mac = params->mac;
@@ -2390,7 +2392,7 @@ static int cfg80211_rtw_del_station(struct wiphy *wiphy, struct net_device *ndev
 }
 
 static int cfg80211_rtw_change_station(struct wiphy *wiphy,
-				       struct net_device *ndev,
+				       struct wireless_dev *wdev,
 				       const u8 *mac,
 				       struct station_parameters *params)
 {
@@ -2418,12 +2420,12 @@ static struct sta_info *rtw_sta_info_get_by_idx(const int idx, struct sta_priv *
 }
 
 static int	cfg80211_rtw_dump_station(struct wiphy *wiphy,
-					  struct net_device *ndev,
+					 struct wireless_dev *wdev,
 					  int idx, u8 *mac,
 					  struct station_info *sinfo)
 {
 	int ret = 0;
-	struct adapter *padapter = rtw_netdev_priv(ndev);
+	struct adapter *padapter = rtw_netdev_priv(wdev_to_ndev(wdev));
 	struct sta_info *psta = NULL;
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 899f267b7cf9..7f269574c9a0 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4893,17 +4893,17 @@ struct cfg80211_ops {
 			   unsigned int link_id);
 
 
-	int	(*add_station)(struct wiphy *wiphy, struct net_device *dev,
+	int	(*add_station)(struct wiphy *wiphy, struct wireless_dev *wdev,
 			       const u8 *mac,
 			       struct station_parameters *params);
-	int	(*del_station)(struct wiphy *wiphy, struct net_device *dev,
+	int	(*del_station)(struct wiphy *wiphy, struct wireless_dev *wdev,
 			       struct station_del_parameters *params);
-	int	(*change_station)(struct wiphy *wiphy, struct net_device *dev,
+	int	(*change_station)(struct wiphy *wiphy, struct wireless_dev *wdev,
 				  const u8 *mac,
 				  struct station_parameters *params);
-	int	(*get_station)(struct wiphy *wiphy, struct net_device *dev,
+	int	(*get_station)(struct wiphy *wiphy, struct wireless_dev *wdev,
 			       const u8 *mac, struct station_info *sinfo);
-	int	(*dump_station)(struct wiphy *wiphy, struct net_device *dev,
+	int	(*dump_station)(struct wiphy *wiphy, struct wireless_dev *wdev,
 				int idx, u8 *mac, struct station_info *sinfo);
 
 	int	(*add_mpath)(struct wiphy *wiphy, struct net_device *dev,
@@ -8884,35 +8884,35 @@ static inline void cfg80211_sinfo_release_content(struct station_info *sinfo)
 /**
  * cfg80211_new_sta - notify userspace about station
  *
- * @dev: the netdev
+ * @wdev: the wireless device
  * @mac_addr: the station's address
  * @sinfo: the station information
  * @gfp: allocation flags
  */
-void cfg80211_new_sta(struct net_device *dev, const u8 *mac_addr,
+void cfg80211_new_sta(struct wireless_dev *wdev, const u8 *mac_addr,
 		      struct station_info *sinfo, gfp_t gfp);
 
 /**
  * cfg80211_del_sta_sinfo - notify userspace about deletion of a station
- * @dev: the netdev
+ * @wdev: the wireless device
  * @mac_addr: the station's address. For MLD station, MLD address is used.
  * @sinfo: the station information/statistics
  * @gfp: allocation flags
  */
-void cfg80211_del_sta_sinfo(struct net_device *dev, const u8 *mac_addr,
+void cfg80211_del_sta_sinfo(struct wireless_dev *wdev, const u8 *mac_addr,
 			    struct station_info *sinfo, gfp_t gfp);
 
 /**
  * cfg80211_del_sta - notify userspace about deletion of a station
  *
- * @dev: the netdev
+ * @wdev: the wireless device
  * @mac_addr: the station's address. For MLD station, MLD address is used.
  * @gfp: allocation flags
  */
-static inline void cfg80211_del_sta(struct net_device *dev,
+static inline void cfg80211_del_sta(struct wireless_dev *wdev,
 				    const u8 *mac_addr, gfp_t gfp)
 {
-	cfg80211_del_sta_sinfo(dev, mac_addr, NULL, gfp);
+	cfg80211_del_sta_sinfo(wdev, mac_addr, NULL, gfp);
 }
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c81091a5cc3a..1af00ce89a3f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -992,10 +992,10 @@ void sta_set_rate_info_tx(struct sta_info *sta,
 		rinfo->flags |= RATE_INFO_FLAGS_SHORT_GI;
 }
 
-static int ieee80211_dump_station(struct wiphy *wiphy, struct net_device *dev,
+static int ieee80211_dump_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 				  int idx, u8 *mac, struct station_info *sinfo)
 {
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 	struct ieee80211_local *local = sdata->local;
 	struct sta_info *sta;
 	int ret = -ENOENT;
@@ -1027,10 +1027,11 @@ static int ieee80211_dump_survey(struct wiphy *wiphy, struct net_device *dev,
 	return drv_get_survey(local, idx, survey);
 }
 
-static int ieee80211_get_station(struct wiphy *wiphy, struct net_device *dev,
+static int ieee80211_get_station(struct wiphy *wiphy,
+				 struct wireless_dev *wdev,
 				 const u8 *mac, struct station_info *sinfo)
 {
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 	struct ieee80211_local *local = sdata->local;
 	struct sta_info *sta;
 	int ret = -ENOENT;
@@ -2339,7 +2340,7 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	return 0;
 }
 
-static int ieee80211_add_station(struct wiphy *wiphy, struct net_device *dev,
+static int ieee80211_add_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 				 const u8 *mac,
 				 struct station_parameters *params)
 {
@@ -2357,7 +2358,7 @@ static int ieee80211_add_station(struct wiphy *wiphy, struct net_device *dev,
 		    sdata->vif.type != NL80211_IFTYPE_AP)
 			return -EINVAL;
 	} else
-		sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+		sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 
 	if (ether_addr_equal(mac, sdata->vif.addr))
 		return -EINVAL;
@@ -2411,12 +2412,12 @@ static int ieee80211_add_station(struct wiphy *wiphy, struct net_device *dev,
 	return sta_info_insert(sta);
 }
 
-static int ieee80211_del_station(struct wiphy *wiphy, struct net_device *dev,
+static int ieee80211_del_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 				 struct station_del_parameters *params)
 {
 	struct ieee80211_sub_if_data *sdata;
 
-	sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 
 	if (params->mac)
 		return sta_info_destroy_addr_bss(sdata, params->mac);
@@ -2426,10 +2427,10 @@ static int ieee80211_del_station(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int ieee80211_change_station(struct wiphy *wiphy,
-				    struct net_device *dev, const u8 *mac,
+				    struct wireless_dev *wdev, const u8 *mac,
 				    struct station_parameters *params)
 {
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 	struct ieee80211_local *local = wiphy_priv(wiphy);
 	struct sta_info *sta;
 	struct ieee80211_sub_if_data *vlansdata;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index f4d3b67fda06..f9526c0a37cb 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -962,7 +962,7 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
 	}
 
 	sinfo->generation = local->sta_generation;
-	cfg80211_new_sta(sdata->dev, sta->sta.addr, sinfo, GFP_KERNEL);
+	cfg80211_new_sta(&sdata->wdev, sta->sta.addr, sinfo, GFP_KERNEL);
 	kfree(sinfo);
 
 	sta_dbg(sdata, "Inserted STA %pM\n", sta->sta.addr);
@@ -1544,7 +1544,7 @@ static void __sta_info_destroy_part2(struct sta_info *sta, bool recalc)
 	sinfo = kzalloc(sizeof(*sinfo), GFP_KERNEL);
 	if (sinfo)
 		sta_set_sinfo(sta, sinfo, true);
-	cfg80211_del_sta_sinfo(sdata->dev, sta->sta.addr, sinfo, GFP_KERNEL);
+	cfg80211_del_sta_sinfo(&sdata->wdev, sta->sta.addr, sinfo, GFP_KERNEL);
 	kfree(sinfo);
 
 	ieee80211_sta_debugfs_remove(sta);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 515716fe5156..1467322d43a4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -7405,7 +7405,7 @@ static int nl80211_fill_link_station(struct sk_buff *msg,
 static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 				u32 seq, int flags,
 				struct cfg80211_registered_device *rdev,
-				struct net_device *dev,
+				struct wireless_dev *wdev,
 				const u8 *mac_addr, struct station_info *sinfo,
 				bool link_stats)
 {
@@ -7421,7 +7421,10 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 		return -1;
 	}
 
-	if (nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex) ||
+	if ((wdev->netdev &&
+	     nla_put_u32(msg, NL80211_ATTR_IFINDEX, wdev->netdev->ifindex)) ||
+	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
+			      NL80211_ATTR_PAD) ||
 	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, mac_addr) ||
 	    nla_put_u32(msg, NL80211_ATTR_GENERATION, sinfo->generation))
 		goto nla_put_failure;
@@ -7900,7 +7903,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 			sinfo_alloc = true;
 		}
 
-		err = rdev_dump_station(rdev, wdev->netdev, sta_idx,
+		err = rdev_dump_station(rdev, wdev, sta_idx,
 					mac_addr, &sinfo);
 		if (err == -ENOENT)
 			break;
@@ -7918,7 +7921,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 		if (nl80211_send_station(skb, NL80211_CMD_NEW_STATION,
 				NETLINK_CB(cb->skb).portid,
 				cb->nlh->nlmsg_seq, NLM_F_MULTI,
-				rdev, wdev->netdev, mac_addr,
+				rdev, wdev, mac_addr,
 				&sinfo, false) < 0)
 			goto out;
 
@@ -7939,7 +7942,7 @@ static int nl80211_dump_station(struct sk_buff *skb,
 static int nl80211_get_station(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
-	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = info->user_ptr[1];
 	struct station_info sinfo;
 	struct sk_buff *msg;
 	u8 *mac_addr = NULL;
@@ -7947,6 +7950,9 @@ static int nl80211_get_station(struct sk_buff *skb, struct genl_info *info)
 
 	memset(&sinfo, 0, sizeof(sinfo));
 
+	if (!wdev->netdev)
+		return -EINVAL;
+
 	if (!info->attrs[NL80211_ATTR_MAC])
 		return -EINVAL;
 
@@ -7963,7 +7969,7 @@ static int nl80211_get_station(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	err = rdev_get_station(rdev, dev, mac_addr, &sinfo);
+	err = rdev_get_station(rdev, wdev, mac_addr, &sinfo);
 	if (err) {
 		cfg80211_sinfo_release_content(&sinfo);
 		return err;
@@ -7980,7 +7986,7 @@ static int nl80211_get_station(struct sk_buff *skb, struct genl_info *info)
 
 	if (nl80211_send_station(msg, NL80211_CMD_NEW_STATION,
 				 info->snd_portid, info->snd_seq, 0,
-				 rdev, dev, mac_addr, &sinfo, false) < 0) {
+				 rdev, wdev, mac_addr, &sinfo, false) < 0) {
 		nlmsg_free(msg);
 		return -ENOBUFS;
 	}
@@ -8331,13 +8337,17 @@ static int nl80211_parse_sta_txpower_setting(struct genl_info *info,
 static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
-	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = info->user_ptr[1];
+	struct net_device *dev = wdev->netdev;
 	struct station_parameters params;
 	u8 *mac_addr;
 	int err;
 
 	memset(&params, 0, sizeof(params));
 
+	if (!dev)
+		return -EINVAL;
+
 	if (!rdev->ops->change_station)
 		return -EOPNOTSUPP;
 
@@ -8410,7 +8420,7 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 			nla_len(info->attrs[NL80211_ATTR_STA_EXT_CAPABILITY]);
 	}
 
-	if (parse_station_flags(info, dev->ieee80211_ptr->iftype, &params))
+	if (parse_station_flags(info, wdev->iftype, &params))
 		return -EINVAL;
 
 	if (info->attrs[NL80211_ATTR_STA_PLINK_ACTION])
@@ -8470,7 +8480,7 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 	if (IS_ERR(params.vlan))
 		return PTR_ERR(params.vlan);
 
-	switch (dev->ieee80211_ptr->iftype) {
+	switch (wdev->iftype) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_P2P_GO:
@@ -8485,7 +8495,7 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	/* driver will call cfg80211_check_station_change() */
-	err = rdev_change_station(rdev, dev, mac_addr, &params);
+	err = rdev_change_station(rdev, wdev, mac_addr, &params);
 
  out_put_vlan:
 	dev_put(params.vlan);
@@ -8497,8 +8507,8 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	int err;
-	struct net_device *dev = info->user_ptr[1];
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct wireless_dev *wdev = info->user_ptr[1];
+	struct net_device *dev = wdev->netdev;
 	struct station_parameters params;
 	u8 *mac_addr = NULL;
 	u32 auth_assoc = BIT(NL80211_STA_FLAG_AUTHENTICATED) |
@@ -8506,6 +8516,9 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 
 	memset(&params, 0, sizeof(params));
 
+	if (!dev)
+		return -EINVAL;
+
 	if (!rdev->ops->add_station)
 		return -EOPNOTSUPP;
 
@@ -8555,7 +8568,7 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 		 * and is NOT supported for AP interface
 		 */
 		params.support_p2p_ps =
-			dev->ieee80211_ptr->iftype == NL80211_IFTYPE_P2P_GO;
+			wdev->iftype == NL80211_IFTYPE_P2P_GO;
 	}
 
 	if (info->attrs[NL80211_ATTR_PEER_AID])
@@ -8651,7 +8664,7 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		return err;
 
-	if (parse_station_flags(info, dev->ieee80211_ptr->iftype, &params))
+	if (parse_station_flags(info, wdev->iftype, &params))
 		return -EINVAL;
 
 	/* HT/VHT requires QoS, but if we don't have that just ignore HT/VHT
@@ -8678,7 +8691,7 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 	/* When you run into this, adjust the code below for the new flag */
 	BUILD_BUG_ON(NL80211_STA_FLAG_MAX != 8);
 
-	switch (dev->ieee80211_ptr->iftype) {
+	switch (wdev->iftype) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_P2P_GO:
@@ -8783,7 +8796,7 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 		}
 	}
-	err = rdev_add_station(rdev, dev, mac_addr, &params);
+	err = rdev_add_station(rdev, wdev, mac_addr, &params);
 out:
 	dev_put(params.vlan);
 	return err;
@@ -8792,13 +8805,16 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 static int nl80211_del_station(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
-	struct net_device *dev = info->user_ptr[1];
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct wireless_dev *wdev = info->user_ptr[1];
+	struct net_device *dev = wdev->netdev;
 	struct station_del_parameters params;
 	int link_id = nl80211_link_id_or_invalid(info->attrs);
 
 	memset(&params, 0, sizeof(params));
 
+	if (!dev)
+		return -EINVAL;
+
 	if (info->attrs[NL80211_ATTR_MAC])
 		params.mac = nla_data(info->attrs[NL80211_ATTR_MAC]);
 
@@ -8854,7 +8870,7 @@ static int nl80211_del_station(struct sk_buff *skb, struct genl_info *info)
 
 	params.link_id = link_id;
 
-	return rdev_del_station(rdev, dev, &params);
+	return rdev_del_station(rdev, wdev, &params);
 }
 
 static int nl80211_send_mpath(struct sk_buff *msg, u32 portid, u32 seq,
@@ -14116,7 +14132,7 @@ static int cfg80211_cqm_rssi_update(struct cfg80211_registered_device *rdev,
 
 		mac_addr = wdev->links[0].client.current_bss->pub.bssid;
 
-		err = rdev_get_station(rdev, dev, mac_addr, &sinfo);
+		err = rdev_get_station(rdev, wdev, mac_addr, &sinfo);
 		if (err)
 			return err;
 
@@ -17215,7 +17231,7 @@ static int nl80211_probe_mesh_link(struct sk_buff *skb, struct genl_info *info)
 	    !ether_addr_equal(buf + ETH_ALEN, dev->dev_addr))
 		return -EINVAL;
 
-	err = rdev_get_station(rdev, dev, dest, &sinfo);
+	err = rdev_get_station(rdev, wdev, dest, &sinfo);
 	if (err)
 		return err;
 
@@ -18288,21 +18304,21 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_get_station,
 		.dumpit = nl80211_dump_station,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV),
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV),
 	},
 	{
 		.cmd = NL80211_CMD_SET_STATION,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_station,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_NEW_STATION,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_new_station,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_DEL_STATION,
@@ -18313,7 +18329,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		 * whether MAC address is passed or not. If MAC address is
 		 * passed, then even during MLO, link ID is not required.
 		 */
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_GET_MPATH,
@@ -20244,21 +20260,21 @@ void cfg80211_tx_mgmt_expired(struct wireless_dev *wdev, u64 cookie,
 }
 EXPORT_SYMBOL(cfg80211_tx_mgmt_expired);
 
-void cfg80211_new_sta(struct net_device *dev, const u8 *mac_addr,
+void cfg80211_new_sta(struct wireless_dev *wdev, const u8 *mac_addr,
 		      struct station_info *sinfo, gfp_t gfp)
 {
-	struct wiphy *wiphy = dev->ieee80211_ptr->wiphy;
+	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	struct sk_buff *msg;
 
-	trace_cfg80211_new_sta(dev, mac_addr, sinfo);
+	trace_cfg80211_new_sta(wdev, mac_addr, sinfo);
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
 	if (!msg)
 		return;
 
 	if (nl80211_send_station(msg, NL80211_CMD_NEW_STATION, 0, 0, 0,
-				 rdev, dev, mac_addr, sinfo, false) < 0) {
+				 rdev, wdev, mac_addr, sinfo, false) < 0) {
 		nlmsg_free(msg);
 		return;
 	}
@@ -20268,10 +20284,10 @@ void cfg80211_new_sta(struct net_device *dev, const u8 *mac_addr,
 }
 EXPORT_SYMBOL(cfg80211_new_sta);
 
-void cfg80211_del_sta_sinfo(struct net_device *dev, const u8 *mac_addr,
+void cfg80211_del_sta_sinfo(struct wireless_dev *wdev, const u8 *mac_addr,
 			    struct station_info *sinfo, gfp_t gfp)
 {
-	struct wiphy *wiphy = dev->ieee80211_ptr->wiphy;
+	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	struct sk_buff *msg;
 	struct station_info empty_sinfo = {};
@@ -20279,7 +20295,7 @@ void cfg80211_del_sta_sinfo(struct net_device *dev, const u8 *mac_addr,
 	if (!sinfo)
 		sinfo = &empty_sinfo;
 
-	trace_cfg80211_del_sta(dev, mac_addr);
+	trace_cfg80211_del_sta(wdev, mac_addr);
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
 	if (!msg) {
@@ -20288,7 +20304,7 @@ void cfg80211_del_sta_sinfo(struct net_device *dev, const u8 *mac_addr,
 	}
 
 	if (nl80211_send_station(msg, NL80211_CMD_DEL_STATION, 0, 0, 0,
-				 rdev, dev, mac_addr, sinfo, false) < 0) {
+				 rdev, wdev, mac_addr, sinfo, false) < 0) {
 		nlmsg_free(msg);
 		return;
 	}
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index ac6884bacf3f..a8f1e7ddc0c0 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -193,56 +193,56 @@ static inline int rdev_stop_ap(struct cfg80211_registered_device *rdev,
 }
 
 static inline int rdev_add_station(struct cfg80211_registered_device *rdev,
-				   struct net_device *dev, u8 *mac,
+				   struct wireless_dev *wdev, u8 *mac,
 				   struct station_parameters *params)
 {
 	int ret;
-	trace_rdev_add_station(&rdev->wiphy, dev, mac, params);
-	ret = rdev->ops->add_station(&rdev->wiphy, dev, mac, params);
+	trace_rdev_add_station(&rdev->wiphy, wdev, mac, params);
+	ret = rdev->ops->add_station(&rdev->wiphy, wdev, mac, params);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
 
 static inline int rdev_del_station(struct cfg80211_registered_device *rdev,
-				   struct net_device *dev,
+				   struct wireless_dev *wdev,
 				   struct station_del_parameters *params)
 {
 	int ret;
-	trace_rdev_del_station(&rdev->wiphy, dev, params);
-	ret = rdev->ops->del_station(&rdev->wiphy, dev, params);
+	trace_rdev_del_station(&rdev->wiphy, wdev, params);
+	ret = rdev->ops->del_station(&rdev->wiphy, wdev, params);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
 
 static inline int rdev_change_station(struct cfg80211_registered_device *rdev,
-				      struct net_device *dev, u8 *mac,
+				      struct wireless_dev *wdev, u8 *mac,
 				      struct station_parameters *params)
 {
 	int ret;
-	trace_rdev_change_station(&rdev->wiphy, dev, mac, params);
-	ret = rdev->ops->change_station(&rdev->wiphy, dev, mac, params);
+	trace_rdev_change_station(&rdev->wiphy, wdev, mac, params);
+	ret = rdev->ops->change_station(&rdev->wiphy, wdev, mac, params);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
 
 static inline int rdev_get_station(struct cfg80211_registered_device *rdev,
-				   struct net_device *dev, const u8 *mac,
+				   struct wireless_dev *wdev, const u8 *mac,
 				   struct station_info *sinfo)
 {
 	int ret;
-	trace_rdev_get_station(&rdev->wiphy, dev, mac);
-	ret = rdev->ops->get_station(&rdev->wiphy, dev, mac, sinfo);
+	trace_rdev_get_station(&rdev->wiphy, wdev, mac);
+	ret = rdev->ops->get_station(&rdev->wiphy, wdev, mac, sinfo);
 	trace_rdev_return_int_station_info(&rdev->wiphy, ret, sinfo);
 	return ret;
 }
 
 static inline int rdev_dump_station(struct cfg80211_registered_device *rdev,
-				    struct net_device *dev, int idx, u8 *mac,
+				    struct wireless_dev *wdev, int idx, u8 *mac,
 				    struct station_info *sinfo)
 {
 	int ret;
-	trace_rdev_dump_station(&rdev->wiphy, dev, idx, mac);
-	ret = rdev->ops->dump_station(&rdev->wiphy, dev, idx, mac, sinfo);
+	trace_rdev_dump_station(&rdev->wiphy, wdev, idx, mac);
+	ret = rdev->ops->dump_station(&rdev->wiphy, wdev, idx, mac, sinfo);
 	trace_rdev_return_int_station_info(&rdev->wiphy, ret, sinfo);
 	return ret;
 }
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 2b71f1d867a0..a5b94ad7a79a 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -856,12 +856,12 @@ TRACE_EVENT(rdev_end_cac,
 );
 
 DECLARE_EVENT_CLASS(station_add_change,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, u8 *mac,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, u8 *mac,
 		 struct station_parameters *params),
-	TP_ARGS(wiphy, netdev, mac, params),
+	TP_ARGS(wiphy, wdev, mac, params),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
-		NETDEV_ENTRY
+		WDEV_ENTRY
 		MAC_ENTRY(sta_mac)
 		__field(u32, sta_flags_mask)
 		__field(u32, sta_flags_set)
@@ -888,7 +888,7 @@ DECLARE_EVENT_CLASS(station_add_change,
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
-		NETDEV_ASSIGN;
+		WDEV_ASSIGN;
 		MAC_ASSIGN(sta_mac, mac);
 		__entry->sta_flags_mask = params->sta_flags_mask;
 		__entry->sta_flags_set = params->sta_flags_set;
@@ -936,11 +936,11 @@ DECLARE_EVENT_CLASS(station_add_change,
 		__entry->opmode_notif_used =
 			params->link_sta_params.opmode_notif_used;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", station mac: %pM"
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", station mac: %pM"
 		  ", station flags mask: 0x%x, station flags set: 0x%x, "
 		  "station modify mask: 0x%x, listen interval: %d, aid: %u, "
 		  "plink action: %u, plink state: %u, uapsd queues: %u, vlan:%s",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->sta_mac,
+		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->sta_mac,
 		  __entry->sta_flags_mask, __entry->sta_flags_set,
 		  __entry->sta_modify_mask, __entry->listen_interval,
 		  __entry->aid, __entry->plink_action, __entry->plink_state,
@@ -948,15 +948,15 @@ DECLARE_EVENT_CLASS(station_add_change,
 );
 
 DEFINE_EVENT(station_add_change, rdev_add_station,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, u8 *mac,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, u8 *mac,
 		 struct station_parameters *params),
-	TP_ARGS(wiphy, netdev, mac, params)
+	TP_ARGS(wiphy, wdev, mac, params)
 );
 
 DEFINE_EVENT(station_add_change, rdev_change_station,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, u8 *mac,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, u8 *mac,
 		 struct station_parameters *params),
-	TP_ARGS(wiphy, netdev, mac, params)
+	TP_ARGS(wiphy, wdev, mac, params)
 );
 
 DECLARE_EVENT_CLASS(wiphy_netdev_mac_evt,
@@ -977,12 +977,12 @@ DECLARE_EVENT_CLASS(wiphy_netdev_mac_evt,
 );
 
 DECLARE_EVENT_CLASS(station_del,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
 		 struct station_del_parameters *params),
-	TP_ARGS(wiphy, netdev, params),
+	TP_ARGS(wiphy, wdev, params),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
-		NETDEV_ENTRY
+		WDEV_ENTRY
 		MAC_ENTRY(sta_mac)
 		__field(u8, subtype)
 		__field(u16, reason_code)
@@ -990,28 +990,45 @@ DECLARE_EVENT_CLASS(station_del,
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
-		NETDEV_ASSIGN;
+		WDEV_ASSIGN;
 		MAC_ASSIGN(sta_mac, params->mac);
 		__entry->subtype = params->subtype;
 		__entry->reason_code = params->reason_code;
 		__entry->link_id = params->link_id;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", station mac: %pM"
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", station mac: %pM"
 		  ", subtype: %u, reason_code: %u, link_id: %d",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->sta_mac,
+		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->sta_mac,
 		  __entry->subtype, __entry->reason_code,
 		  __entry->link_id)
 );
 
 DEFINE_EVENT(station_del, rdev_del_station,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev,
 		 struct station_del_parameters *params),
-	TP_ARGS(wiphy, netdev, params)
+	TP_ARGS(wiphy, wdev, params)
 );
 
-DEFINE_EVENT(wiphy_netdev_mac_evt, rdev_get_station,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, const u8 *mac),
-	TP_ARGS(wiphy, netdev, mac)
+DECLARE_EVENT_CLASS(wiphy_wdev_mac_evt,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, const u8 *mac),
+	TP_ARGS(wiphy, wdev, mac),
+	TP_STRUCT__entry(
+		WIPHY_ENTRY
+		WDEV_ENTRY
+		MAC_ENTRY(sta_mac)
+	),
+	TP_fast_assign(
+		WIPHY_ASSIGN;
+		WDEV_ASSIGN;
+		MAC_ASSIGN(sta_mac, mac);
+	),
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", mac: %pM",
+		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->sta_mac)
+);
+
+DEFINE_EVENT(wiphy_wdev_mac_evt, rdev_get_station,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, const u8 *mac),
+	TP_ARGS(wiphy, wdev, mac)
 );
 
 DEFINE_EVENT(wiphy_netdev_mac_evt, rdev_del_mpath,
@@ -1020,23 +1037,23 @@ DEFINE_EVENT(wiphy_netdev_mac_evt, rdev_del_mpath,
 );
 
 TRACE_EVENT(rdev_dump_station,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, int _idx,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, int _idx,
 		 u8 *mac),
-	TP_ARGS(wiphy, netdev, _idx, mac),
+	TP_ARGS(wiphy, wdev, _idx, mac),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
-		NETDEV_ENTRY
+		WDEV_ENTRY
 		MAC_ENTRY(sta_mac)
 		__field(int, idx)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
-		NETDEV_ASSIGN;
+		WDEV_ASSIGN;
 		MAC_ASSIGN(sta_mac, mac);
 		__entry->idx = _idx;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", station mac: %pM, idx: %d",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->sta_mac,
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", station mac: %pM, idx: %d",
+		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->sta_mac,
 		  __entry->idx)
 );
 
@@ -3153,6 +3170,21 @@ DECLARE_EVENT_CLASS(cfg80211_netdev_mac_evt,
 		  NETDEV_PR_ARG, __entry->macaddr)
 );
 
+DECLARE_EVENT_CLASS(cfg80211_wdev_mac_evt,
+	TP_PROTO(struct wireless_dev *wdev, const u8 *macaddr),
+	TP_ARGS(wdev, macaddr),
+	TP_STRUCT__entry(
+		WDEV_ENTRY
+		MAC_ENTRY(macaddr)
+	),
+	TP_fast_assign(
+		WDEV_ASSIGN;
+		MAC_ASSIGN(macaddr, macaddr);
+	),
+	TP_printk(WDEV_PR_FMT ", mac: %pM",
+		  WDEV_PR_ARG, __entry->macaddr)
+);
+
 DEFINE_EVENT(cfg80211_netdev_mac_evt, cfg80211_notify_new_peer_candidate,
 	TP_PROTO(struct net_device *netdev, const u8 *macaddr),
 	TP_ARGS(netdev, macaddr)
@@ -3342,26 +3374,26 @@ TRACE_EVENT(cfg80211_tx_mgmt_expired,
 );
 
 TRACE_EVENT(cfg80211_new_sta,
-	TP_PROTO(struct net_device *netdev, const u8 *mac_addr,
+	TP_PROTO(struct wireless_dev *wdev, const u8 *mac_addr,
 		 struct station_info *sinfo),
-	TP_ARGS(netdev, mac_addr, sinfo),
+	TP_ARGS(wdev, mac_addr, sinfo),
 	TP_STRUCT__entry(
-		NETDEV_ENTRY
+		WDEV_ENTRY
 		MAC_ENTRY(mac_addr)
 		SINFO_ENTRY
 	),
 	TP_fast_assign(
-		NETDEV_ASSIGN;
+		WDEV_ASSIGN;
 		MAC_ASSIGN(mac_addr, mac_addr);
 		SINFO_ASSIGN;
 	),
-	TP_printk(NETDEV_PR_FMT ", %pM",
-		  NETDEV_PR_ARG, __entry->mac_addr)
+	TP_printk(WDEV_PR_FMT ", %pM",
+		  WDEV_PR_ARG, __entry->mac_addr)
 );
 
-DEFINE_EVENT(cfg80211_netdev_mac_evt, cfg80211_del_sta,
-	TP_PROTO(struct net_device *netdev, const u8 *macaddr),
-	TP_ARGS(netdev, macaddr)
+DEFINE_EVENT(cfg80211_wdev_mac_evt, cfg80211_del_sta,
+	TP_PROTO(struct wireless_dev *wdev, const u8 *macaddr),
+	TP_ARGS(wdev, macaddr)
 );
 
 TRACE_EVENT(cfg80211_rx_mgmt,
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 27e8a2f52f04..3c38d830cf2b 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2609,7 +2609,7 @@ int cfg80211_get_station(struct net_device *dev, const u8 *mac_addr,
 
 	guard(wiphy)(&rdev->wiphy);
 
-	return rdev_get_station(rdev, dev, mac_addr, sinfo);
+	return rdev_get_station(rdev, wdev, mac_addr, sinfo);
 }
 EXPORT_SYMBOL(cfg80211_get_station);
 
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 1241fda78a68..2b39bffb4456 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -7,7 +7,7 @@
  * we directly assign the wireless handlers of wireless interfaces.
  *
  * Copyright 2008-2009	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2019-2023 Intel Corporation
+ * Copyright (C) 2019-2023, 2025 Intel Corporation
  */
 
 #include <linux/export.h>
@@ -1262,7 +1262,7 @@ static int cfg80211_wext_giwrate(struct net_device *dev,
 		return err;
 
 	scoped_guard(wiphy, &rdev->wiphy) {
-		err = rdev_get_station(rdev, dev, addr, &sinfo);
+		err = rdev_get_station(rdev, wdev, addr, &sinfo);
 	}
 	if (err)
 		return err;
@@ -1306,7 +1306,7 @@ static struct iw_statistics *cfg80211_wireless_stats(struct net_device *dev)
 
 	memset(&sinfo, 0, sizeof(sinfo));
 
-	ret = rdev_get_station(rdev, dev, bssid, &sinfo);
+	ret = rdev_get_station(rdev, wdev, bssid, &sinfo);
 	wiphy_unlock(&rdev->wiphy);
 
 	if (ret)
-- 
2.34.1


