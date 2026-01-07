Return-Path: <linux-wireless+bounces-30458-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73886CFDF71
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 14:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D80AC306C98C
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 13:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE8132D0C6;
	Wed,  7 Jan 2026 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpIaHfBL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E82329375
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792034; cv=none; b=J6Vj0PA6Ax0q1ukVYrbmSFJCX2kKj27MFxMruBL3NZYHFQhFOoHorp1q/DK88CDCPAEoRjdIRF81E3N0ycbWMReQB/WXCol5AcFWNJVLAdujrBGh9pokvrHpJ5PWlwDz8zrtaNPcJWYLFEPwbeVcHI1NvOTGWZn2CVYO+LGdI3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792034; c=relaxed/simple;
	bh=Bc83v3noObSUxfaZiLge3gVCdigM5f69bjOnqGgiflc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OItP+Da0O019qkdSPYiWoCPRhW20af/x1Pg7gmKSAhzF7AcT6wRdVIiw56HvcIgoZlsruwDekVY6J3Z3fsnIO/f/FgrrCLCC1FtdjhyLNvOdbBi+m+BLeszSKseuXuSas+Lya9DWpikbgO8CHjulroaeZeas4mVi9rY/265NGSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpIaHfBL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767792031; x=1799328031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bc83v3noObSUxfaZiLge3gVCdigM5f69bjOnqGgiflc=;
  b=VpIaHfBLyi3cFsLu+Bx6uuYsZ7A0cTFa1lbvViz6zzmQaSP0SoT198nT
   hRz3iDIf0ilBT/wL5CNdiqHgx06xsCQfIgVLGesYpg2sJgp8bzAwAqqc7
   xvJZ3DD7KPegga0GwVHm7SNjQgPFO+UbbP+OdygPRqnpO9khYBDd3Q8bf
   KTaKtrJMqHAG297VZRfYKAsFkx+9FuX8SZ5R5gyezfWaEM69xKaL75df4
   1dhMWnkARpVtqQG+/yo2jcG0uY/zf7yRTF+BPfDVxssyoB2r2KCCzh+d9
   bDhioqVkKlkPIDgx29op9szIGRy62i2hxGNzfKSf+mI0z8b65qwwyGalM
   g==;
X-CSE-ConnectionGUID: Cu+rsN7VQ6O+EyFYgkp7aw==
X-CSE-MsgGUID: RyDcMCevSpuOzzMADfSAKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="86576873"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="86576873"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 05:20:31 -0800
X-CSE-ConnectionGUID: ac4M9ZPnQ7OFGCU/vNhGhg==
X-CSE-MsgGUID: 7hmCNZEWSGy0ugIFlctDJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="203185807"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 05:20:29 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 14/15] wifi: cfg80211: support key installation on non-netdev wdevs
Date: Wed,  7 Jan 2026 15:20:02 +0200
Message-Id: <20260107150057.69a0cfad95fa.I00efdf3b2c11efab82ef6ece9f393382bcf33ba8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107132003.2291979-1-miriam.rachel.korenblit@intel.com>
References: <20260107132003.2291979-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

Currently key installation is only supported for netdev. For NAN,
support most key operations (except setting default data key) on
wdevs instead of netdevs, and adjust all the APIs and tracing to
match.

Since nothing currently sets NL80211_EXT_FEATURE_SECURE_NAN, this
doesn't change anything (P2P Device already isn't allowed.)

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c    | 16 ++---
 drivers/net/wireless/ath/wil6210/cfg80211.c   | 13 ++--
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 18 +++---
 drivers/net/wireless/marvell/libertas/cfg.c   |  6 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   | 12 ++--
 .../wireless/microchip/wilc1000/cfg80211.c    | 18 +++---
 .../net/wireless/quantenna/qtnfmac/cfg80211.c | 12 ++--
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  9 +--
 include/net/cfg80211.h                        | 12 ++--
 net/mac80211/cfg.c                            | 22 +++----
 net/wireless/ibss.c                           |  4 +-
 net/wireless/nl80211.c                        | 46 ++++++++------
 net/wireless/rdev-ops.h                       | 32 +++++-----
 net/wireless/sme.c                            |  4 +-
 net/wireless/trace.h                          | 62 +++++++++----------
 net/wireless/util.c                           |  4 +-
 net/wireless/wext-compat.c                    |  6 +-
 17 files changed, 151 insertions(+), 145 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index eecba2201b10..739a24a6ad67 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -1123,13 +1123,13 @@ void ath6kl_cfg80211_ch_switch_notify(struct ath6kl_vif *vif, int freq,
 	wiphy_unlock(vif->ar->wiphy);
 }
 
-static int ath6kl_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
+static int ath6kl_cfg80211_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 				   int link_id, u8 key_index, bool pairwise,
 				   const u8 *mac_addr,
 				   struct key_params *params)
 {
-	struct ath6kl *ar = ath6kl_priv(ndev);
-	struct ath6kl_vif *vif = netdev_priv(ndev);
+	struct ath6kl *ar = ath6kl_priv(wdev->netdev);
+	struct ath6kl_vif *vif = netdev_priv(wdev->netdev);
 	struct ath6kl_key *key = NULL;
 	int seq_len;
 	u8 key_usage;
@@ -1248,12 +1248,12 @@ static int ath6kl_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
 				     (u8 *) mac_addr, SYNC_BOTH_WMIFLAG);
 }
 
-static int ath6kl_cfg80211_del_key(struct wiphy *wiphy, struct net_device *ndev,
+static int ath6kl_cfg80211_del_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 				   int link_id, u8 key_index, bool pairwise,
 				   const u8 *mac_addr)
 {
-	struct ath6kl *ar = ath6kl_priv(ndev);
-	struct ath6kl_vif *vif = netdev_priv(ndev);
+	struct ath6kl *ar = ath6kl_priv(wdev->netdev);
+	struct ath6kl_vif *vif = netdev_priv(wdev->netdev);
 
 	ath6kl_dbg(ATH6KL_DBG_WLAN_CFG, "%s: index %d\n", __func__, key_index);
 
@@ -1278,13 +1278,13 @@ static int ath6kl_cfg80211_del_key(struct wiphy *wiphy, struct net_device *ndev,
 	return ath6kl_wmi_deletekey_cmd(ar->wmi, vif->fw_vif_idx, key_index);
 }
 
-static int ath6kl_cfg80211_get_key(struct wiphy *wiphy, struct net_device *ndev,
+static int ath6kl_cfg80211_get_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 				   int link_id, u8 key_index, bool pairwise,
 				   const u8 *mac_addr, void *cookie,
 				   void (*callback) (void *cookie,
 						     struct key_params *))
 {
-	struct ath6kl_vif *vif = netdev_priv(ndev);
+	struct ath6kl_vif *vif = netdev_priv(wdev->netdev);
 	struct ath6kl_key *key = NULL;
 	struct key_params params;
 
diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index f97a311d9f76..6acc5173b42c 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -1619,15 +1619,14 @@ static void wil_del_rx_key(u8 key_index, enum wmi_key_usage key_usage,
 }
 
 static int wil_cfg80211_add_key(struct wiphy *wiphy,
-				struct net_device *ndev, int link_id,
+				struct wireless_dev *wdev, int link_id,
 				u8 key_index, bool pairwise,
 				const u8 *mac_addr,
 				struct key_params *params)
 {
 	int rc;
-	struct wil6210_vif *vif = ndev_to_vif(ndev);
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
-	struct wireless_dev *wdev = vif_to_wdev(vif);
+	struct wil6210_vif *vif = wdev_to_vif(wil, wdev);
 	enum wmi_key_usage key_usage = wil_detect_key_usage(wdev, pairwise);
 	struct wil_sta_info *cs = wil_find_sta_by_key_usage(wil, vif->mid,
 							    key_usage,
@@ -1695,13 +1694,12 @@ static int wil_cfg80211_add_key(struct wiphy *wiphy,
 }
 
 static int wil_cfg80211_del_key(struct wiphy *wiphy,
-				struct net_device *ndev, int link_id,
+				struct wireless_dev *wdev, int link_id,
 				u8 key_index, bool pairwise,
 				const u8 *mac_addr)
 {
-	struct wil6210_vif *vif = ndev_to_vif(ndev);
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
-	struct wireless_dev *wdev = vif_to_wdev(vif);
+	struct wil6210_vif *vif = wdev_to_vif(wil, wdev);
 	enum wmi_key_usage key_usage = wil_detect_key_usage(wdev, pairwise);
 	struct wil_sta_info *cs = wil_find_sta_by_key_usage(wil, vif->mid,
 							    key_usage,
@@ -2071,7 +2069,8 @@ void wil_cfg80211_ap_recovery(struct wil6210_priv *wil)
 		key_params.key = vif->gtk;
 		key_params.key_len = vif->gtk_len;
 		key_params.seq_len = IEEE80211_GCMP_PN_LEN;
-		rc = wil_cfg80211_add_key(wiphy, ndev, -1, vif->gtk_index,
+		rc = wil_cfg80211_add_key(wiphy, vif_to_wdev(vif), -1,
+					  vif->gtk_index,
 					  false, NULL, &key_params);
 		if (rc)
 			wil_err(wil, "vif %d recovery add key failed (%d)\n",
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index ce39c917a8c5..b26e6b33012f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -2758,11 +2758,11 @@ brcmf_cfg80211_config_default_key(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static s32
-brcmf_cfg80211_del_key(struct wiphy *wiphy, struct net_device *ndev,
+brcmf_cfg80211_del_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 		       int link_id, u8 key_idx, bool pairwise,
 		       const u8 *mac_addr)
 {
-	struct brcmf_if *ifp = netdev_priv(ndev);
+	struct brcmf_if *ifp = netdev_priv(wdev->netdev);
 	struct brcmf_wsec_key *key;
 	s32 err;
 
@@ -2796,12 +2796,12 @@ brcmf_cfg80211_del_key(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static s32
-brcmf_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
+brcmf_cfg80211_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 		       int link_id, u8 key_idx, bool pairwise,
 		       const u8 *mac_addr, struct key_params *params)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
-	struct brcmf_if *ifp = netdev_priv(ndev);
+	struct brcmf_if *ifp = netdev_priv(wdev->netdev);
 	struct brcmf_pub *drvr = cfg->pub;
 	struct brcmf_wsec_key *key;
 	s32 val;
@@ -2822,7 +2822,7 @@ brcmf_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
 	}
 
 	if (params->key_len == 0)
-		return brcmf_cfg80211_del_key(wiphy, ndev, -1, key_idx,
+		return brcmf_cfg80211_del_key(wiphy, wdev, -1, key_idx,
 					      pairwise, mac_addr);
 
 	if (params->key_len > sizeof(key->data)) {
@@ -2918,7 +2918,7 @@ brcmf_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static s32
-brcmf_cfg80211_get_key(struct wiphy *wiphy, struct net_device *ndev,
+brcmf_cfg80211_get_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 		       int link_id, u8 key_idx, bool pairwise,
 		       const u8 *mac_addr, void *cookie,
 		       void (*callback)(void *cookie,
@@ -2926,7 +2926,7 @@ brcmf_cfg80211_get_key(struct wiphy *wiphy, struct net_device *ndev,
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct key_params params;
-	struct brcmf_if *ifp = netdev_priv(ndev);
+	struct brcmf_if *ifp = netdev_priv(wdev->netdev);
 	struct brcmf_cfg80211_profile *profile = &ifp->vif->profile;
 	struct brcmf_pub *drvr = cfg->pub;
 	struct brcmf_cfg80211_security *sec;
@@ -2976,10 +2976,10 @@ brcmf_cfg80211_get_key(struct wiphy *wiphy, struct net_device *ndev,
 
 static s32
 brcmf_cfg80211_config_default_mgmt_key(struct wiphy *wiphy,
-				       struct net_device *ndev, int link_id,
+				       struct wireless_dev *wdev, int link_id,
 				       u8 key_idx)
 {
-	struct brcmf_if *ifp = netdev_priv(ndev);
+	struct brcmf_if *ifp = netdev_priv(wdev->netdev);
 
 	brcmf_dbg(TRACE, "Enter key_idx %d\n", key_idx);
 
diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index 4c5b712eb1e1..310094b31e51 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -1507,7 +1507,7 @@ static int lbs_cfg_set_default_key(struct wiphy *wiphy,
 }
 
 
-static int lbs_cfg_add_key(struct wiphy *wiphy, struct net_device *netdev,
+static int lbs_cfg_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			   int link_id, u8 idx, bool pairwise,
 			   const u8 *mac_addr, struct key_params *params)
 {
@@ -1516,7 +1516,7 @@ static int lbs_cfg_add_key(struct wiphy *wiphy, struct net_device *netdev,
 	u16 key_type;
 	int ret = 0;
 
-	if (netdev == priv->mesh_dev)
+	if (wdev->netdev == priv->mesh_dev)
 		return -EOPNOTSUPP;
 
 	lbs_deb_assoc("add_key: cipher 0x%x, mac_addr %pM\n",
@@ -1568,7 +1568,7 @@ static int lbs_cfg_add_key(struct wiphy *wiphy, struct net_device *netdev,
 }
 
 
-static int lbs_cfg_del_key(struct wiphy *wiphy, struct net_device *netdev,
+static int lbs_cfg_del_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			   int link_id, u8 key_index, bool pairwise,
 			   const u8 *mac_addr)
 {
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index ef32ff611ba3..39f0e136c5be 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -141,11 +141,11 @@ static void *mwifiex_cfg80211_get_adapter(struct wiphy *wiphy)
  * CFG802.11 operation handler to delete a network key.
  */
 static int
-mwifiex_cfg80211_del_key(struct wiphy *wiphy, struct net_device *netdev,
+mwifiex_cfg80211_del_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			 int link_id, u8 key_index, bool pairwise,
 			 const u8 *mac_addr)
 {
-	struct mwifiex_private *priv = mwifiex_netdev_get_priv(netdev);
+	struct mwifiex_private *priv = mwifiex_netdev_get_priv(wdev->netdev);
 	static const u8 bc_mac[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	const u8 *peer_mac = pairwise ? mac_addr : bc_mac;
 
@@ -480,11 +480,11 @@ mwifiex_cfg80211_set_default_key(struct wiphy *wiphy, struct net_device *netdev,
  * CFG802.11 operation handler to add a network key.
  */
 static int
-mwifiex_cfg80211_add_key(struct wiphy *wiphy, struct net_device *netdev,
+mwifiex_cfg80211_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			 int link_id, u8 key_index, bool pairwise,
 			 const u8 *mac_addr, struct key_params *params)
 {
-	struct mwifiex_private *priv = mwifiex_netdev_get_priv(netdev);
+	struct mwifiex_private *priv = mwifiex_netdev_get_priv(wdev->netdev);
 	struct mwifiex_wep_key *wep_key;
 	static const u8 bc_mac[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	const u8 *peer_mac = pairwise ? mac_addr : bc_mac;
@@ -518,11 +518,11 @@ mwifiex_cfg80211_add_key(struct wiphy *wiphy, struct net_device *netdev,
  */
 static int
 mwifiex_cfg80211_set_default_mgmt_key(struct wiphy *wiphy,
-				      struct net_device *netdev,
+				      struct wireless_dev *wdev,
 				      int link_id,
 				      u8 key_index)
 {
-	struct mwifiex_private *priv = mwifiex_netdev_get_priv(netdev);
+	struct mwifiex_private *priv = mwifiex_netdev_get_priv(wdev->netdev);
 	struct mwifiex_ds_encrypt_key encrypt_key;
 
 	wiphy_dbg(wiphy, "set default mgmt key, key index=%d\n", key_index);
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index d854cb10fd2b..fba65abb0c3e 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -537,7 +537,7 @@ static int wilc_wfi_cfg_copy_wpa_info(struct wilc_wfi_key *key_info,
 	return 0;
 }
 
-static int add_key(struct wiphy *wiphy, struct net_device *netdev, int link_id,
+static int add_key(struct wiphy *wiphy, struct wireless_dev *wdev, int link_id,
 		   u8 key_index, bool pairwise, const u8 *mac_addr,
 		   struct key_params *params)
 
@@ -547,7 +547,7 @@ static int add_key(struct wiphy *wiphy, struct net_device *netdev, int link_id,
 	const u8 *tx_mic = NULL;
 	u8 mode = WILC_FW_SEC_NO;
 	u8 op_mode;
-	struct wilc_vif *vif = netdev_priv(netdev);
+	struct wilc_vif *vif = netdev_priv(wdev->netdev);
 	struct wilc_priv *priv = &vif->priv;
 	struct wilc_wfi_key *key;
 
@@ -635,19 +635,19 @@ static int add_key(struct wiphy *wiphy, struct net_device *netdev, int link_id,
 		break;
 
 	default:
-		netdev_err(netdev, "%s: Unsupported cipher\n", __func__);
+		netdev_err(wdev->netdev, "%s: Unsupported cipher\n", __func__);
 		ret = -ENOTSUPP;
 	}
 
 	return ret;
 }
 
-static int del_key(struct wiphy *wiphy, struct net_device *netdev, int link_id,
+static int del_key(struct wiphy *wiphy, struct wireless_dev *wdev, int link_id,
 		   u8 key_index,
 		   bool pairwise,
 		   const u8 *mac_addr)
 {
-	struct wilc_vif *vif = netdev_priv(netdev);
+	struct wilc_vif *vif = netdev_priv(wdev->netdev);
 	struct wilc_priv *priv = &vif->priv;
 
 	if (!pairwise && (key_index == 4 || key_index == 5)) {
@@ -683,12 +683,12 @@ static int del_key(struct wiphy *wiphy, struct net_device *netdev, int link_id,
 	return 0;
 }
 
-static int get_key(struct wiphy *wiphy, struct net_device *netdev, int link_id,
+static int get_key(struct wiphy *wiphy, struct wireless_dev *wdev, int link_id,
 		   u8 key_index, bool pairwise, const u8 *mac_addr,
 		   void *cookie,
 		   void (*callback)(void *cookie, struct key_params *))
 {
-	struct wilc_vif *vif = netdev_priv(netdev);
+	struct wilc_vif *vif = netdev_priv(wdev->netdev);
 	struct wilc_priv *priv = &vif->priv;
 	struct  key_params key_params;
 
@@ -728,10 +728,10 @@ static int set_default_key(struct wiphy *wiphy, struct net_device *netdev,
 	return 0;
 }
 
-static int set_default_mgmt_key(struct wiphy *wiphy, struct net_device *netdev,
+static int set_default_mgmt_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 				int link_id, u8 key_index)
 {
-	struct wilc_vif *vif = netdev_priv(netdev);
+	struct wilc_vif *vif = netdev_priv(wdev->netdev);
 
 	return wilc_set_default_mgmt_key_index(vif, key_index);
 }
diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index 340240847a2f..9e44c85d2051 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -532,11 +532,11 @@ qtnf_dump_station(struct wiphy *wiphy, struct wireless_dev *wdev,
 	return ret;
 }
 
-static int qtnf_add_key(struct wiphy *wiphy, struct net_device *dev,
+static int qtnf_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			int link_id, u8 key_index, bool pairwise,
 			const u8 *mac_addr, struct key_params *params)
 {
-	struct qtnf_vif *vif = qtnf_netdev_get_priv(dev);
+	struct qtnf_vif *vif = qtnf_netdev_get_priv(wdev->netdev);
 	int ret;
 
 	ret = qtnf_cmd_send_add_key(vif, key_index, pairwise, mac_addr, params);
@@ -548,11 +548,11 @@ static int qtnf_add_key(struct wiphy *wiphy, struct net_device *dev,
 	return ret;
 }
 
-static int qtnf_del_key(struct wiphy *wiphy, struct net_device *dev,
+static int qtnf_del_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			int link_id, u8 key_index, bool pairwise,
 			const u8 *mac_addr)
 {
-	struct qtnf_vif *vif = qtnf_netdev_get_priv(dev);
+	struct qtnf_vif *vif = qtnf_netdev_get_priv(wdev->netdev);
 	int ret;
 
 	ret = qtnf_cmd_send_del_key(vif, key_index, pairwise, mac_addr);
@@ -587,10 +587,10 @@ static int qtnf_set_default_key(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int
-qtnf_set_default_mgmt_key(struct wiphy *wiphy, struct net_device *dev,
+qtnf_set_default_mgmt_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			  int link_id, u8 key_index)
 {
-	struct qtnf_vif *vif = qtnf_netdev_get_priv(dev);
+	struct qtnf_vif *vif = qtnf_netdev_get_priv(wdev->netdev);
 	int ret;
 
 	ret = qtnf_cmd_send_set_default_mgmt_key(vif, key_index);
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index c24f3cb8b999..d0251b1cf4fc 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -828,7 +828,7 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 	return ret;
 }
 
-static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
+static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 				int link_id, u8 key_index, bool pairwise,
 				const u8 *mac_addr, struct key_params *params)
 {
@@ -836,6 +836,7 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
 	u32 param_len;
 	struct ieee_param *param = NULL;
 	int ret = 0;
+	struct net_device *ndev = wdev->netdev;
 	struct adapter *padapter = rtw_netdev_priv(ndev);
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
@@ -908,7 +909,7 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
 	return ret;
 }
 
-static int cfg80211_rtw_get_key(struct wiphy *wiphy, struct net_device *ndev,
+static int cfg80211_rtw_get_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 				int link_id, u8 key_index, bool pairwise,
 				const u8 *mac_addr, void *cookie,
 				void (*callback)(void *cookie,
@@ -917,11 +918,11 @@ static int cfg80211_rtw_get_key(struct wiphy *wiphy, struct net_device *ndev,
 	return 0;
 }
 
-static int cfg80211_rtw_del_key(struct wiphy *wiphy, struct net_device *ndev,
+static int cfg80211_rtw_del_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 				int link_id, u8 key_index, bool pairwise,
 				const u8 *mac_addr)
 {
-	struct adapter *padapter = rtw_netdev_priv(ndev);
+	struct adapter *padapter = rtw_netdev_priv(wdev->netdev);
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 
 	if (key_index == psecuritypriv->dot11PrivacyKeyIndex) {
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 5d4c223e3c6e..1bb8ea25e9ad 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7,7 +7,7 @@
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014 Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 
 #include <linux/ethtool.h>
@@ -5037,24 +5037,24 @@ struct cfg80211_ops {
 				 struct wireless_dev *wdev,
 				 unsigned int link_id);
 
-	int	(*add_key)(struct wiphy *wiphy, struct net_device *netdev,
+	int	(*add_key)(struct wiphy *wiphy, struct wireless_dev *wdev,
 			   int link_id, u8 key_index, bool pairwise,
 			   const u8 *mac_addr, struct key_params *params);
-	int	(*get_key)(struct wiphy *wiphy, struct net_device *netdev,
+	int	(*get_key)(struct wiphy *wiphy, struct wireless_dev *wdev,
 			   int link_id, u8 key_index, bool pairwise,
 			   const u8 *mac_addr, void *cookie,
 			   void (*callback)(void *cookie, struct key_params*));
-	int	(*del_key)(struct wiphy *wiphy, struct net_device *netdev,
+	int	(*del_key)(struct wiphy *wiphy, struct wireless_dev *wdev,
 			   int link_id, u8 key_index, bool pairwise,
 			   const u8 *mac_addr);
 	int	(*set_default_key)(struct wiphy *wiphy,
 				   struct net_device *netdev, int link_id,
 				   u8 key_index, bool unicast, bool multicast);
 	int	(*set_default_mgmt_key)(struct wiphy *wiphy,
-					struct net_device *netdev, int link_id,
+					struct wireless_dev *wdev, int link_id,
 					u8 key_index);
 	int	(*set_default_beacon_key)(struct wiphy *wiphy,
-					  struct net_device *netdev,
+					  struct wireless_dev *wdev,
 					  int link_id,
 					  u8 key_index);
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f034dcc4bdaa..593440a00981 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -616,11 +616,11 @@ static int ieee80211_set_tx(struct ieee80211_sub_if_data *sdata,
 	return ret;
 }
 
-static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
+static int ieee80211_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			     int link_id, u8 key_idx, bool pairwise,
 			     const u8 *mac_addr, struct key_params *params)
 {
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 	struct ieee80211_link_data *link =
 		ieee80211_link_or_deflink(sdata, link_id, false);
 	struct ieee80211_local *local = sdata->local;
@@ -791,11 +791,11 @@ ieee80211_lookup_key(struct ieee80211_sub_if_data *sdata, int link_id,
 	return NULL;
 }
 
-static int ieee80211_del_key(struct wiphy *wiphy, struct net_device *dev,
+static int ieee80211_del_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			     int link_id, u8 key_idx, bool pairwise,
 			     const u8 *mac_addr)
 {
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_key *key;
 
@@ -810,7 +810,7 @@ static int ieee80211_del_key(struct wiphy *wiphy, struct net_device *dev,
 	return 0;
 }
 
-static int ieee80211_get_key(struct wiphy *wiphy, struct net_device *dev,
+static int ieee80211_get_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			     int link_id, u8 key_idx, bool pairwise,
 			     const u8 *mac_addr, void *cookie,
 			     void (*callback)(void *cookie,
@@ -826,7 +826,7 @@ static int ieee80211_get_key(struct wiphy *wiphy, struct net_device *dev,
 	int err = -ENOENT;
 	struct ieee80211_key_seq kseq = {};
 
-	sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 
 	rcu_read_lock();
 
@@ -930,10 +930,10 @@ static int ieee80211_config_default_key(struct wiphy *wiphy,
 }
 
 static int ieee80211_config_default_mgmt_key(struct wiphy *wiphy,
-					     struct net_device *dev,
+					     struct wireless_dev *wdev,
 					     int link_id, u8 key_idx)
 {
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 	struct ieee80211_link_data *link =
 		ieee80211_link_or_deflink(sdata, link_id, true);
 
@@ -946,10 +946,10 @@ static int ieee80211_config_default_mgmt_key(struct wiphy *wiphy,
 }
 
 static int ieee80211_config_default_beacon_key(struct wiphy *wiphy,
-					       struct net_device *dev,
+					       struct wireless_dev *wdev,
 					       int link_id, u8 key_idx)
 {
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_sub_if_data *sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 	struct ieee80211_link_data *link =
 		ieee80211_link_or_deflink(sdata, link_id, true);
 
diff --git a/net/wireless/ibss.c b/net/wireless/ibss.c
index 1e3ed29f7cfc..cf0adaa738b9 100644
--- a/net/wireless/ibss.c
+++ b/net/wireless/ibss.c
@@ -3,7 +3,7 @@
  * Some IBSS support code for cfg80211.
  *
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2020-2024 Intel Corporation
+ * Copyright (C) 2020-2026 Intel Corporation
  */
 
 #include <linux/etherdevice.h>
@@ -172,7 +172,7 @@ void cfg80211_clear_ibss(struct net_device *dev, bool nowext)
 	 */
 	if (rdev->ops->del_key)
 		for (i = 0; i < 6; i++)
-			rdev_del_key(rdev, dev, -1, i, false, NULL);
+			rdev_del_key(rdev, wdev, -1, i, false, NULL);
 
 	if (wdev->u.ibss.current_bss) {
 		cfg80211_unhold_bss(wdev->u.ibss.current_bss);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 27f5a786a4db..9d8738e895c6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5040,7 +5040,7 @@ static int nl80211_get_key(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	int err;
-	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = info->user_ptr[1];
 	u8 key_idx = 0;
 	const u8 *mac_addr = NULL;
 	bool pairwise;
@@ -5051,7 +5051,6 @@ static int nl80211_get_key(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *msg;
 	bool bigtk_support = false;
 	int link_id = nl80211_link_id_or_invalid(info->attrs);
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
 
 	if (wiphy_ext_feature_isset(&rdev->wiphy,
 				    NL80211_EXT_FEATURE_BEACON_PROTECTION))
@@ -5103,7 +5102,10 @@ static int nl80211_get_key(struct sk_buff *skb, struct genl_info *info)
 	cookie.msg = msg;
 	cookie.idx = key_idx;
 
-	if (nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex) ||
+	if ((wdev->netdev &&
+	     nla_put_u32(msg, NL80211_ATTR_IFINDEX, wdev->netdev->ifindex)) ||
+	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
+			      NL80211_ATTR_PAD) ||
 	    nla_put_u8(msg, NL80211_ATTR_KEY_IDX, key_idx))
 		goto nla_put_failure;
 	if (mac_addr &&
@@ -5114,7 +5116,7 @@ static int nl80211_get_key(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto free_msg;
 
-	err = rdev_get_key(rdev, dev, link_id, key_idx, pairwise, mac_addr,
+	err = rdev_get_key(rdev, wdev, link_id, key_idx, pairwise, mac_addr,
 			   &cookie, get_key_callback);
 
 	if (err)
@@ -5138,9 +5140,8 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct key_parse key;
 	int err;
-	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = info->user_ptr[1];
 	int link_id = nl80211_link_id_or_invalid(info->attrs);
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
 
 	err = nl80211_parse_key(info, &key);
 	if (err)
@@ -5160,6 +5161,9 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 		if (!rdev->ops->set_default_key)
 			return -EOPNOTSUPP;
 
+		if (!wdev->netdev)
+			return -EINVAL;
+
 		err = nl80211_key_allowed(wdev);
 		if (err)
 			return err;
@@ -5168,7 +5172,7 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 		if (err)
 			return err;
 
-		err = rdev_set_default_key(rdev, dev, link_id, key.idx,
+		err = rdev_set_default_key(rdev, wdev->netdev, link_id, key.idx,
 					   key.def_uni, key.def_multi);
 
 		if (err)
@@ -5193,7 +5197,7 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 		if (err)
 			return err;
 
-		err = rdev_set_default_mgmt_key(rdev, dev, link_id, key.idx);
+		err = rdev_set_default_mgmt_key(rdev, wdev, link_id, key.idx);
 		if (err)
 			return err;
 
@@ -5216,7 +5220,8 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 		if (err)
 			return err;
 
-		return rdev_set_default_beacon_key(rdev, dev, link_id, key.idx);
+		return rdev_set_default_beacon_key(rdev, wdev, link_id,
+						   key.idx);
 	} else if (key.p.mode == NL80211_KEY_SET_TX &&
 		   wiphy_ext_feature_isset(&rdev->wiphy,
 					   NL80211_EXT_FEATURE_EXT_KEY_ID)) {
@@ -5232,7 +5237,7 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 		if (err)
 			return err;
 
-		return rdev_add_key(rdev, dev, link_id, key.idx,
+		return rdev_add_key(rdev, wdev, link_id, key.idx,
 				    NL80211_KEYTYPE_PAIRWISE,
 				    mac_addr, &key.p);
 	}
@@ -5244,11 +5249,10 @@ static int nl80211_new_key(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	int err;
-	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = info->user_ptr[1];
 	struct key_parse key;
 	const u8 *mac_addr = NULL;
 	int link_id = nl80211_link_id_or_invalid(info->attrs);
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
 
 	err = nl80211_parse_key(info, &key);
 	if (err)
@@ -5299,7 +5303,7 @@ static int nl80211_new_key(struct sk_buff *skb, struct genl_info *info)
 				key.type == NL80211_KEYTYPE_PAIRWISE);
 
 	if (!err) {
-		err = rdev_add_key(rdev, dev, link_id, key.idx,
+		err = rdev_add_key(rdev, wdev, link_id, key.idx,
 				   key.type == NL80211_KEYTYPE_PAIRWISE,
 				    mac_addr, &key.p);
 		if (err)
@@ -5313,11 +5317,10 @@ static int nl80211_del_key(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	int err;
-	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = info->user_ptr[1];
 	u8 *mac_addr = NULL;
 	struct key_parse key;
 	int link_id = nl80211_link_id_or_invalid(info->attrs);
-	struct wireless_dev *wdev = dev->ieee80211_ptr;
 
 	err = nl80211_parse_key(info, &key);
 	if (err)
@@ -5356,7 +5359,7 @@ static int nl80211_del_key(struct sk_buff *skb, struct genl_info *info)
 				key.type == NL80211_KEYTYPE_PAIRWISE);
 
 	if (!err)
-		err = rdev_del_key(rdev, dev, link_id, key.idx,
+		err = rdev_del_key(rdev, wdev, link_id, key.idx,
 				   key.type == NL80211_KEYTYPE_PAIRWISE,
 				   mac_addr);
 
@@ -18527,6 +18530,9 @@ nl80211_epcs_cfg(struct sk_buff *skb, struct genl_info *info)
 		 NL80211_FLAG_CLEAR_SKB)		\
 	SELECTOR(__sel, WDEV_UP,			\
 		 NL80211_FLAG_NEED_WDEV_UP)		\
+	SELECTOR(__sel, WDEV_UP_CLEAR,			\
+		 NL80211_FLAG_NEED_WDEV_UP |		\
+		 NL80211_FLAG_CLEAR_SKB)		\
 	SELECTOR(__sel, WDEV_UP_LINK,			\
 		 NL80211_FLAG_NEED_WDEV_UP |		\
 		 NL80211_FLAG_MLO_VALID_LINK_ID)	\
@@ -18863,7 +18869,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_get_key,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_SET_KEY,
@@ -18871,7 +18877,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.doit = nl80211_set_key,
 		.flags = GENL_UNS_ADMIN_PERM,
 		/* cannot use NL80211_FLAG_MLO_VALID_LINK_ID, depends on key */
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP |
 					 NL80211_FLAG_CLEAR_SKB),
 	},
 	{
@@ -18879,7 +18885,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_new_key,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP |
 					 NL80211_FLAG_CLEAR_SKB),
 	},
 	{
@@ -18887,7 +18893,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_del_key,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
+		.internal_flags = IFLAGS(NL80211_FLAG_NEED_WDEV_UP),
 	},
 	{
 		.cmd = NL80211_CMD_SET_BEACON,
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index ef5a2897c240..bba239a068f6 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -2,7 +2,7 @@
 /*
  * Portions of this file
  * Copyright(c) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018, 2021-2025 Intel Corporation
+ * Copyright (C) 2018, 2021-2026 Intel Corporation
  */
 #ifndef __CFG80211_RDEV_OPS
 #define __CFG80211_RDEV_OPS
@@ -77,42 +77,42 @@ rdev_change_virtual_intf(struct cfg80211_registered_device *rdev,
 }
 
 static inline int rdev_add_key(struct cfg80211_registered_device *rdev,
-			       struct net_device *netdev, int link_id,
+			       struct wireless_dev *wdev, int link_id,
 			       u8 key_index, bool pairwise, const u8 *mac_addr,
 			       struct key_params *params)
 {
 	int ret;
-	trace_rdev_add_key(&rdev->wiphy, netdev, link_id, key_index, pairwise,
+	trace_rdev_add_key(&rdev->wiphy, wdev, link_id, key_index, pairwise,
 			   mac_addr, params->mode);
-	ret = rdev->ops->add_key(&rdev->wiphy, netdev, link_id, key_index,
+	ret = rdev->ops->add_key(&rdev->wiphy, wdev, link_id, key_index,
 				  pairwise, mac_addr, params);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
 
 static inline int
-rdev_get_key(struct cfg80211_registered_device *rdev, struct net_device *netdev,
+rdev_get_key(struct cfg80211_registered_device *rdev, struct wireless_dev *wdev,
 	     int link_id, u8 key_index, bool pairwise, const u8 *mac_addr,
 	     void *cookie,
 	     void (*callback)(void *cookie, struct key_params*))
 {
 	int ret;
-	trace_rdev_get_key(&rdev->wiphy, netdev, link_id, key_index, pairwise,
+	trace_rdev_get_key(&rdev->wiphy, wdev, link_id, key_index, pairwise,
 			   mac_addr);
-	ret = rdev->ops->get_key(&rdev->wiphy, netdev, link_id, key_index,
+	ret = rdev->ops->get_key(&rdev->wiphy, wdev, link_id, key_index,
 				  pairwise, mac_addr, cookie, callback);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
 
 static inline int rdev_del_key(struct cfg80211_registered_device *rdev,
-			       struct net_device *netdev, int link_id,
+			       struct wireless_dev *wdev, int link_id,
 			       u8 key_index, bool pairwise, const u8 *mac_addr)
 {
 	int ret;
-	trace_rdev_del_key(&rdev->wiphy, netdev, link_id, key_index, pairwise,
+	trace_rdev_del_key(&rdev->wiphy, wdev, link_id, key_index, pairwise,
 			   mac_addr);
-	ret = rdev->ops->del_key(&rdev->wiphy, netdev, link_id, key_index,
+	ret = rdev->ops->del_key(&rdev->wiphy, wdev, link_id, key_index,
 				  pairwise, mac_addr);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
@@ -134,12 +134,12 @@ rdev_set_default_key(struct cfg80211_registered_device *rdev,
 
 static inline int
 rdev_set_default_mgmt_key(struct cfg80211_registered_device *rdev,
-			  struct net_device *netdev, int link_id, u8 key_index)
+			  struct wireless_dev *wdev, int link_id, u8 key_index)
 {
 	int ret;
-	trace_rdev_set_default_mgmt_key(&rdev->wiphy, netdev, link_id,
+	trace_rdev_set_default_mgmt_key(&rdev->wiphy, wdev, link_id,
 					key_index);
-	ret = rdev->ops->set_default_mgmt_key(&rdev->wiphy, netdev, link_id,
+	ret = rdev->ops->set_default_mgmt_key(&rdev->wiphy, wdev, link_id,
 					       key_index);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
@@ -147,14 +147,14 @@ rdev_set_default_mgmt_key(struct cfg80211_registered_device *rdev,
 
 static inline int
 rdev_set_default_beacon_key(struct cfg80211_registered_device *rdev,
-			    struct net_device *netdev, int link_id,
+			    struct wireless_dev *wdev, int link_id,
 			    u8 key_index)
 {
 	int ret;
 
-	trace_rdev_set_default_beacon_key(&rdev->wiphy, netdev, link_id,
+	trace_rdev_set_default_beacon_key(&rdev->wiphy, wdev, link_id,
 					  key_index);
-	ret = rdev->ops->set_default_beacon_key(&rdev->wiphy, netdev, link_id,
+	ret = rdev->ops->set_default_beacon_key(&rdev->wiphy, wdev, link_id,
 						 key_index);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 4e629ca305bc..0609345911a8 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -5,7 +5,7 @@
  * (for nl80211's connect() and wext)
  *
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2009, 2020, 2022-2025 Intel Corporation. All rights reserved.
+ * Copyright (C) 2009, 2020, 2022-2026 Intel Corporation. All rights reserved.
  * Copyright 2017	Intel Deutschland GmbH
  */
 
@@ -1386,7 +1386,7 @@ void __cfg80211_disconnected(struct net_device *dev, const u8 *ie,
 			    NL80211_EXT_FEATURE_BEACON_PROTECTION_CLIENT))
 			max_key_idx = 7;
 		for (i = 0; i <= max_key_idx; i++)
-			rdev_del_key(rdev, dev, -1, i, false, NULL);
+			rdev_del_key(rdev, wdev, -1, i, false, NULL);
 	}
 
 	rdev_set_qos_map(rdev, dev, NULL);
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 458d6e895444..f54be1b4a9a1 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2,7 +2,7 @@
 /*
  * Portions of this file
  * Copyright(c) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018, 2020-2025 Intel Corporation
+ * Copyright (C) 2018, 2020-2026 Intel Corporation
  */
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM cfg80211
@@ -546,12 +546,12 @@ TRACE_EVENT(rdev_change_virtual_intf,
 );
 
 DECLARE_EVENT_CLASS(key_handle,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, int link_id,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, int link_id,
 		 u8 key_index, bool pairwise, const u8 *mac_addr),
-	TP_ARGS(wiphy, netdev, link_id, key_index, pairwise, mac_addr),
+	TP_ARGS(wiphy, wdev, link_id, key_index, pairwise, mac_addr),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
-		NETDEV_ENTRY
+		WDEV_ENTRY
 		MAC_ENTRY(mac_addr)
 		__field(int, link_id)
 		__field(u8, key_index)
@@ -559,38 +559,38 @@ DECLARE_EVENT_CLASS(key_handle,
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
-		NETDEV_ASSIGN;
+		WDEV_ASSIGN;
 		MAC_ASSIGN(mac_addr, mac_addr);
 		__entry->link_id = link_id;
 		__entry->key_index = key_index;
 		__entry->pairwise = pairwise;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %d, "
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", link_id: %d, "
 		  "key_index: %u, pairwise: %s, mac addr: %pM",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->link_id,
+		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->link_id,
 		  __entry->key_index, BOOL_TO_STR(__entry->pairwise),
 		  __entry->mac_addr)
 );
 
 DEFINE_EVENT(key_handle, rdev_get_key,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, int link_id,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, int link_id,
 		 u8 key_index, bool pairwise, const u8 *mac_addr),
-	TP_ARGS(wiphy, netdev, link_id, key_index, pairwise, mac_addr)
+	TP_ARGS(wiphy, wdev, link_id, key_index, pairwise, mac_addr)
 );
 
 DEFINE_EVENT(key_handle, rdev_del_key,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, int link_id,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, int link_id,
 		 u8 key_index, bool pairwise, const u8 *mac_addr),
-	TP_ARGS(wiphy, netdev, link_id, key_index, pairwise, mac_addr)
+	TP_ARGS(wiphy, wdev, link_id, key_index, pairwise, mac_addr)
 );
 
 TRACE_EVENT(rdev_add_key,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, int link_id,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, int link_id,
 		 u8 key_index, bool pairwise, const u8 *mac_addr, u8 mode),
-	TP_ARGS(wiphy, netdev, link_id, key_index, pairwise, mac_addr, mode),
+	TP_ARGS(wiphy, wdev, link_id, key_index, pairwise, mac_addr, mode),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
-		NETDEV_ENTRY
+		WDEV_ENTRY
 		MAC_ENTRY(mac_addr)
 		__field(int, link_id)
 		__field(u8, key_index)
@@ -599,17 +599,17 @@ TRACE_EVENT(rdev_add_key,
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
-		NETDEV_ASSIGN;
+		WDEV_ASSIGN;
 		MAC_ASSIGN(mac_addr, mac_addr);
 		__entry->link_id = link_id;
 		__entry->key_index = key_index;
 		__entry->pairwise = pairwise;
 		__entry->mode = mode;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %d, "
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", link_id: %d, "
 		  "key_index: %u, mode: %u, pairwise: %s, "
 		  "mac addr: %pM",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->link_id,
+		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->link_id,
 		  __entry->key_index, __entry->mode,
 		  BOOL_TO_STR(__entry->pairwise), __entry->mac_addr)
 );
@@ -642,45 +642,45 @@ TRACE_EVENT(rdev_set_default_key,
 );
 
 TRACE_EVENT(rdev_set_default_mgmt_key,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, int link_id,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, int link_id,
 		 u8 key_index),
-	TP_ARGS(wiphy, netdev, link_id, key_index),
+	TP_ARGS(wiphy, wdev, link_id, key_index),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
-		NETDEV_ENTRY
+		WDEV_ENTRY
 		__field(int, link_id)
 		__field(u8, key_index)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
-		NETDEV_ASSIGN;
+		WDEV_ASSIGN;
 		__entry->link_id = link_id;
 		__entry->key_index = key_index;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %d, "
-		  "key index: %u", WIPHY_PR_ARG, NETDEV_PR_ARG,
-		  __entry->link_id, __entry->key_index)
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", link_id: %d, key index: %u",
+		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->link_id,
+		  __entry->key_index)
 );
 
 TRACE_EVENT(rdev_set_default_beacon_key,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, int link_id,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, int link_id,
 		 u8 key_index),
-	TP_ARGS(wiphy, netdev, link_id, key_index),
+	TP_ARGS(wiphy, wdev, link_id, key_index),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
-		NETDEV_ENTRY
+		WDEV_ENTRY
 		__field(int, link_id)
 		__field(u8, key_index)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
-		NETDEV_ASSIGN;
+		WDEV_ASSIGN;
 		__entry->link_id = link_id;
 		__entry->key_index = key_index;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %d, "
-		  "key index: %u", WIPHY_PR_ARG, NETDEV_PR_ARG,
-		  __entry->link_id, __entry->key_index)
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", link_id: %d, key index: %u",
+		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->link_id,
+		  __entry->key_index)
 );
 
 TRACE_EVENT(rdev_start_ap,
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 5de7ea57768e..388d77a2e78f 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -5,7 +5,7 @@
  * Copyright 2007-2009	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2023, 2025 Intel Corporation
+ * Copyright (C) 2018-2023, 2025-2026 Intel Corporation
  */
 #include <linux/export.h>
 #include <linux/bitops.h>
@@ -1096,7 +1096,7 @@ void cfg80211_upload_connect_keys(struct wireless_dev *wdev)
 	for (i = 0; i < 4; i++) {
 		if (!wdev->connect_keys->params[i].cipher)
 			continue;
-		if (rdev_add_key(rdev, dev, -1, i, false, NULL,
+		if (rdev_add_key(rdev, wdev, -1, i, false, NULL,
 				 &wdev->connect_keys->params[i])) {
 			netdev_err(dev, "failed to set key %d\n", i);
 			continue;
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 2b39bffb4456..591408c8ec45 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -458,7 +458,7 @@ static int cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 			    !(rdev->wiphy.flags & WIPHY_FLAG_IBSS_RSN))
 				err = -ENOENT;
 			else
-				err = rdev_del_key(rdev, dev, -1, idx, pairwise,
+				err = rdev_del_key(rdev, wdev, -1, idx, pairwise,
 						   addr);
 		}
 		wdev->wext.connect.privacy = false;
@@ -497,7 +497,7 @@ static int cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 	if (wdev->connected ||
 	    (wdev->iftype == NL80211_IFTYPE_ADHOC &&
 	     wdev->u.ibss.current_bss))
-		err = rdev_add_key(rdev, dev, -1, idx, pairwise, addr, params);
+		err = rdev_add_key(rdev, wdev, -1, idx, pairwise, addr, params);
 	else if (params->cipher != WLAN_CIPHER_SUITE_WEP40 &&
 		 params->cipher != WLAN_CIPHER_SUITE_WEP104)
 		return -EINVAL;
@@ -550,7 +550,7 @@ static int cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 		if (wdev->connected ||
 		    (wdev->iftype == NL80211_IFTYPE_ADHOC &&
 		     wdev->u.ibss.current_bss))
-			err = rdev_set_default_mgmt_key(rdev, dev, -1, idx);
+			err = rdev_set_default_mgmt_key(rdev, wdev, -1, idx);
 		if (!err)
 			wdev->wext.default_mgmt_key = idx;
 		return err;
-- 
2.34.1


