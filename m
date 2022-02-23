Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BEF4C10A6
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Feb 2022 11:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbiBWKrg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Feb 2022 05:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239702AbiBWKrf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Feb 2022 05:47:35 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262CD5A080
        for <linux-wireless@vger.kernel.org>; Wed, 23 Feb 2022 02:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645613226; x=1677149226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=fbS+n27Y1cr9BcfYGp0EKoWlT+0tf7+vHdla+eGCznU=;
  b=AzSc0H3tWRtHxwWeJgIblMOi98PWD0UB3+LwuTwm7SvLxcScshYiHYLL
   1pmAm9PN3AVm8pgGby9LMp1k070TylRPO400GFzKRFEDbhsaLCOfOhpMY
   P89acNNRycDtqr2JqKGk7iPPEwxcE/WeJuMb4llST5BgRbCMwNWVfw/Zw
   Q=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Feb 2022 02:47:05 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 02:47:05 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 23 Feb 2022 02:47:04 -0800
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 23 Feb 2022 02:47:02 -0800
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_usdutt@quicinc.com>
Subject: [PATCH v2 3/3] cfg80211: Add support for key operations on NL80211_IFTYPE_MLO_LINK
Date:   Wed, 23 Feb 2022 16:16:40 +0530
Message-ID: <1645613200-30221-4-git-send-email-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645613200-30221-1-git-send-email-quic_vjakkam@quicinc.com>
References: <1645613200-30221-1-git-send-email-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allow key operations on NL80211_IFTYPE_MLO_LINK to support configuring
per MLO link keys such as GTK/IGTK/BIGTK.

Add necessary changes in mac80211 and drivers to conform to updated
function signatures

Contains a fix that was:
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
v2:
 - fixed compilation issue reported by kernel test robot <lkp@intel.com>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |  52 +++++++---
 drivers/net/wireless/ath/wil6210/cfg80211.c        |  38 +++++---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  58 ++++++++---
 drivers/net/wireless/marvell/libertas/cfg.c        |  14 ++-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |  40 ++++++--
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |  48 ++++++---
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c  |  40 ++++++--
 drivers/net/wireless/rndis_wlan.c                  |  24 +++--
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |  40 ++++++--
 drivers/staging/wlan-ng/cfg80211.c                 |  41 ++++++--
 include/net/cfg80211.h                             |  12 +--
 net/mac80211/cfg.c                                 |  58 ++++++++---
 net/wireless/core.h                                |   8 ++
 net/wireless/ibss.c                                |   2 +-
 net/wireless/nl80211.c                             | 107 ++++++++++++++-------
 net/wireless/rdev-ops.h                            |  36 +++----
 net/wireless/sme.c                                 |   2 +-
 net/wireless/trace.h                               |  68 ++++++-------
 net/wireless/util.c                                |   9 +-
 net/wireless/wext-compat.c                         |  10 +-
 20 files changed, 494 insertions(+), 213 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index bd11838..8eb0dd7 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -1123,17 +1123,25 @@ void ath6kl_cfg80211_ch_switch_notify(struct ath6kl_vif *vif, int freq,
 	mutex_unlock(&vif->wdev.mtx);
 }
 
-static int ath6kl_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
+static int ath6kl_cfg80211_add_key(struct wiphy *wiphy,
+				   struct wireless_dev *wdev,
 				   u8 key_index, bool pairwise,
 				   const u8 *mac_addr,
 				   struct key_params *params)
 {
-	struct ath6kl *ar = ath6kl_priv(ndev);
-	struct ath6kl_vif *vif = netdev_priv(ndev);
+	struct ath6kl *ar;
+	struct ath6kl_vif *vif;
 	struct ath6kl_key *key = NULL;
 	int seq_len;
 	u8 key_usage;
 	u8 key_type;
+	struct net_device *ndev = wdev->netdev;
+
+	if (!ndev)
+		return -EOPNOTSUPP;
+
+	ar = ath6kl_priv(ndev);
+	vif = netdev_priv(ndev);
 
 	if (!ath6kl_cfg80211_ready(vif))
 		return -EIO;
@@ -1248,12 +1256,20 @@ static int ath6kl_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
 				     (u8 *) mac_addr, SYNC_BOTH_WMIFLAG);
 }
 
-static int ath6kl_cfg80211_del_key(struct wiphy *wiphy, struct net_device *ndev,
+static int ath6kl_cfg80211_del_key(struct wiphy *wiphy,
+				   struct wireless_dev *wdev,
 				   u8 key_index, bool pairwise,
 				   const u8 *mac_addr)
 {
-	struct ath6kl *ar = ath6kl_priv(ndev);
-	struct ath6kl_vif *vif = netdev_priv(ndev);
+	struct ath6kl *ar;
+	struct ath6kl_vif *vif;
+	struct net_device *ndev = wdev->netdev;
+
+	if (!ndev)
+		return -EOPNOTSUPP;
+
+	ar = ath6kl_priv(ndev);
+	vif = netdev_priv(ndev);
 
 	ath6kl_dbg(ATH6KL_DBG_WLAN_CFG, "%s: index %d\n", __func__, key_index);
 
@@ -1278,15 +1294,22 @@ static int ath6kl_cfg80211_del_key(struct wiphy *wiphy, struct net_device *ndev,
 	return ath6kl_wmi_deletekey_cmd(ar->wmi, vif->fw_vif_idx, key_index);
 }
 
-static int ath6kl_cfg80211_get_key(struct wiphy *wiphy, struct net_device *ndev,
+static int ath6kl_cfg80211_get_key(struct wiphy *wiphy,
+				   struct wireless_dev *wdev,
 				   u8 key_index, bool pairwise,
 				   const u8 *mac_addr, void *cookie,
 				   void (*callback) (void *cookie,
 						     struct key_params *))
 {
-	struct ath6kl_vif *vif = netdev_priv(ndev);
+	struct ath6kl_vif *vif;
 	struct ath6kl_key *key = NULL;
 	struct key_params params;
+	struct net_device *ndev = wdev->netdev;
+
+	if (!ndev)
+		return -EOPNOTSUPP;
+
+	vif = netdev_priv(ndev);
 
 	ath6kl_dbg(ATH6KL_DBG_WLAN_CFG, "%s: index %d\n", __func__, key_index);
 
@@ -1314,15 +1337,22 @@ static int ath6kl_cfg80211_get_key(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static int ath6kl_cfg80211_set_default_key(struct wiphy *wiphy,
-					   struct net_device *ndev,
+					   struct wireless_dev *wdev,
 					   u8 key_index, bool unicast,
 					   bool multicast)
 {
-	struct ath6kl *ar = ath6kl_priv(ndev);
-	struct ath6kl_vif *vif = netdev_priv(ndev);
+	struct ath6kl *ar;
+	struct ath6kl_vif *vif;
 	struct ath6kl_key *key = NULL;
 	u8 key_usage;
 	enum ath6kl_crypto_type key_type = NONE_CRYPT;
+	struct net_device *ndev = wdev->netdev;
+
+	if (!ndev)
+		return -EOPNOTSUPP;
+
+	ar = ath6kl_priv(ndev);
+	vif = netdev_priv(ndev);
 
 	ath6kl_dbg(ATH6KL_DBG_WLAN_CFG, "%s: index %d\n", __func__, key_index);
 
diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 764d1d1..685ac3a 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -1620,19 +1620,23 @@ static void wil_del_rx_key(u8 key_index, enum wmi_key_usage key_usage,
 }
 
 static int wil_cfg80211_add_key(struct wiphy *wiphy,
-				struct net_device *ndev,
+				struct wireless_dev *wdev,
 				u8 key_index, bool pairwise,
 				const u8 *mac_addr,
 				struct key_params *params)
 {
 	int rc;
-	struct wil6210_vif *vif = ndev_to_vif(ndev);
+	struct wil6210_vif *vif;
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
-	struct wireless_dev *wdev = vif_to_wdev(vif);
 	enum wmi_key_usage key_usage = wil_detect_key_usage(wdev, pairwise);
-	struct wil_sta_info *cs = wil_find_sta_by_key_usage(wil, vif->mid,
-							    key_usage,
-							    mac_addr);
+	struct wil_sta_info *cs;
+	struct net_device *ndev = wdev->netdev;
+
+	if (!ndev)
+		return -EOPNOTSUPP;
+
+	vif = ndev_to_vif(ndev);
+	cs = wil_find_sta_by_key_usage(wil, vif->mid, key_usage, mac_addr);
 
 	if (!params) {
 		wil_err(wil, "NULL params\n");
@@ -1697,17 +1701,21 @@ static int wil_cfg80211_add_key(struct wiphy *wiphy,
 }
 
 static int wil_cfg80211_del_key(struct wiphy *wiphy,
-				struct net_device *ndev,
+				struct wireless_dev *wdev,
 				u8 key_index, bool pairwise,
 				const u8 *mac_addr)
 {
-	struct wil6210_vif *vif = ndev_to_vif(ndev);
+	struct wil6210_vif *vif;
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
-	struct wireless_dev *wdev = vif_to_wdev(vif);
 	enum wmi_key_usage key_usage = wil_detect_key_usage(wdev, pairwise);
-	struct wil_sta_info *cs = wil_find_sta_by_key_usage(wil, vif->mid,
-							    key_usage,
-							    mac_addr);
+	struct wil_sta_info *cs;
+	struct net_device *ndev = wdev->netdev;
+
+	if (!ndev)
+		return -EOPNOTSUPP;
+
+	vif = ndev_to_vif(ndev);
+	cs = wil_find_sta_by_key_usage(wil, vif->mid, key_usage, mac_addr);
 
 	wil_dbg_misc(wil, "del_key: %pM %s[%d]\n", mac_addr,
 		     key_usage_str[key_usage], key_index);
@@ -1724,7 +1732,7 @@ static int wil_cfg80211_del_key(struct wiphy *wiphy,
 
 /* Need to be present or wiphy_new() will WARN */
 static int wil_cfg80211_set_default_key(struct wiphy *wiphy,
-					struct net_device *ndev,
+					struct wireless_dev *wdev,
 					u8 key_index, bool unicast,
 					bool multicast)
 {
@@ -2038,11 +2046,13 @@ void wil_cfg80211_ap_recovery(struct wil6210_priv *wil)
 		struct net_device *ndev;
 		struct cfg80211_beacon_data bcon = {};
 		struct key_params key_params = {};
+		struct wireless_dev *wdev;
 
 		if (!vif || vif->ssid_len == 0)
 			continue;
 
 		ndev = vif_to_ndev(vif);
+		wdev = ndev->ieee80211_ptr;
 		bcon.proberesp_ies = vif->proberesp_ies;
 		bcon.assocresp_ies = vif->assocresp_ies;
 		bcon.probe_resp = vif->proberesp;
@@ -2073,7 +2083,7 @@ void wil_cfg80211_ap_recovery(struct wil6210_priv *wil)
 		key_params.key = vif->gtk;
 		key_params.key_len = vif->gtk_len;
 		key_params.seq_len = IEEE80211_GCMP_PN_LEN;
-		rc = wil_cfg80211_add_key(wiphy, ndev, vif->gtk_index, false,
+		rc = wil_cfg80211_add_key(wiphy, wdev, vif->gtk_index, false,
 					  NULL, &key_params);
 		if (rc)
 			wil_err(wil, "vif %d recovery add key failed (%d)\n",
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index b2fb9fc..cf568a2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -2360,14 +2360,22 @@ brcmf_cfg80211_get_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 }
 
 static s32
-brcmf_cfg80211_config_default_key(struct wiphy *wiphy, struct net_device *ndev,
+brcmf_cfg80211_config_default_key(struct wiphy *wiphy,
+				  struct wireless_dev *wdev,
 				  u8 key_idx, bool unicast, bool multicast)
 {
-	struct brcmf_if *ifp = netdev_priv(ndev);
-	struct brcmf_pub *drvr = ifp->drvr;
+	struct brcmf_if *ifp;
+	struct brcmf_pub *drvr;
 	u32 index;
 	u32 wsec;
 	s32 err = 0;
+	struct net_device *ndev = wdev->netdev;
+
+	if (!ndev)
+		return -EOPNOTSUPP;
+
+	ifp = netdev_priv(ndev);
+	drvr = ifp->drvr;
 
 	brcmf_dbg(TRACE, "Enter\n");
 	brcmf_dbg(CONN, "key index (%d)\n", key_idx);
@@ -2394,13 +2402,18 @@ brcmf_cfg80211_config_default_key(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static s32
-brcmf_cfg80211_del_key(struct wiphy *wiphy, struct net_device *ndev,
+brcmf_cfg80211_del_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 		       u8 key_idx, bool pairwise, const u8 *mac_addr)
 {
-	struct brcmf_if *ifp = netdev_priv(ndev);
+	struct brcmf_if *ifp;
 	struct brcmf_wsec_key *key;
 	s32 err;
+	struct net_device *ndev = wdev->netdev;
 
+	if (!ndev)
+		return -EOPNOTSUPP;
+
+	ifp = netdev_priv(ndev);
 	brcmf_dbg(TRACE, "Enter\n");
 	brcmf_dbg(CONN, "key index (%d)\n", key_idx);
 
@@ -2431,12 +2444,12 @@ brcmf_cfg80211_del_key(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static s32
-brcmf_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
+brcmf_cfg80211_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 		       u8 key_idx, bool pairwise, const u8 *mac_addr,
 		       struct key_params *params)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
-	struct brcmf_if *ifp = netdev_priv(ndev);
+	struct brcmf_if *ifp;
 	struct brcmf_pub *drvr = cfg->pub;
 	struct brcmf_wsec_key *key;
 	s32 val;
@@ -2444,7 +2457,12 @@ brcmf_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
 	s32 err;
 	u8 keybuf[8];
 	bool ext_key;
+	struct net_device *ndev = wdev->netdev;
+
+	if (!ndev)
+		return -EOPNOTSUPP;
 
+	ifp = netdev_priv(ndev);
 	brcmf_dbg(TRACE, "Enter\n");
 	brcmf_dbg(CONN, "key index (%d)\n", key_idx);
 	if (!check_vif_up(ifp->vif))
@@ -2457,7 +2475,7 @@ brcmf_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
 	}
 
 	if (params->key_len == 0)
-		return brcmf_cfg80211_del_key(wiphy, ndev, key_idx, pairwise,
+		return brcmf_cfg80211_del_key(wiphy, wdev, key_idx, pairwise,
 					      mac_addr);
 
 	if (params->key_len > sizeof(key->data)) {
@@ -2553,20 +2571,27 @@ brcmf_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static s32
-brcmf_cfg80211_get_key(struct wiphy *wiphy, struct net_device *ndev, u8 key_idx,
-		       bool pairwise, const u8 *mac_addr, void *cookie,
+brcmf_cfg80211_get_key(struct wiphy *wiphy, struct wireless_dev *wdev,
+		       u8 key_idx, bool pairwise, const u8 *mac_addr,
+		       void *cookie,
 		       void (*callback)(void *cookie,
 					struct key_params *params))
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct key_params params;
-	struct brcmf_if *ifp = netdev_priv(ndev);
-	struct brcmf_cfg80211_profile *profile = &ifp->vif->profile;
+	struct brcmf_if *ifp;
+	struct brcmf_cfg80211_profile *profile;
 	struct brcmf_pub *drvr = cfg->pub;
 	struct brcmf_cfg80211_security *sec;
 	s32 wsec;
 	s32 err = 0;
+	struct net_device *ndev = wdev->netdev;
 
+	if (!ndev)
+		return -EOPNOTSUPP;
+
+	ifp = netdev_priv(ndev);
+	profile = &ifp->vif->profile;
 	brcmf_dbg(TRACE, "Enter\n");
 	brcmf_dbg(CONN, "key index (%d)\n", key_idx);
 	if (!check_vif_up(ifp->vif))
@@ -2610,10 +2635,15 @@ brcmf_cfg80211_get_key(struct wiphy *wiphy, struct net_device *ndev, u8 key_idx,
 
 static s32
 brcmf_cfg80211_config_default_mgmt_key(struct wiphy *wiphy,
-				       struct net_device *ndev, u8 key_idx)
+				       struct wireless_dev *wdev, u8 key_idx)
 {
-	struct brcmf_if *ifp = netdev_priv(ndev);
+	struct brcmf_if *ifp;
+	struct net_device *ndev = wdev->netdev;
+
+	if (!ndev)
+		return -EOPNOTSUPP;
 
+	ifp = netdev_priv(ndev);
 	brcmf_dbg(TRACE, "Enter key_idx %d\n", key_idx);
 
 	if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_MFP))
diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index 4e3de68..cc8a98d 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -1437,11 +1437,15 @@ static int lbs_cfg_disconnect(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int lbs_cfg_set_default_key(struct wiphy *wiphy,
-				   struct net_device *netdev,
+				   struct wireless_dev *wdev,
 				   u8 key_index, bool unicast,
 				   bool multicast)
 {
 	struct lbs_private *priv = wiphy_priv(wiphy);
+	struct net_device *netdev = wdev->netdev;
+
+	if (!netdev)
+		return -EOPNOTSUPP;
 
 	if (netdev == priv->mesh_dev)
 		return -EOPNOTSUPP;
@@ -1456,7 +1460,7 @@ static int lbs_cfg_set_default_key(struct wiphy *wiphy,
 }
 
 
-static int lbs_cfg_add_key(struct wiphy *wiphy, struct net_device *netdev,
+static int lbs_cfg_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			   u8 idx, bool pairwise, const u8 *mac_addr,
 			   struct key_params *params)
 {
@@ -1464,6 +1468,10 @@ static int lbs_cfg_add_key(struct wiphy *wiphy, struct net_device *netdev,
 	u16 key_info;
 	u16 key_type;
 	int ret = 0;
+	struct net_device *netdev = wdev->netdev;
+
+	if (!netdev)
+		return -EOPNOTSUPP;
 
 	if (netdev == priv->mesh_dev)
 		return -EOPNOTSUPP;
@@ -1517,7 +1525,7 @@ static int lbs_cfg_add_key(struct wiphy *wiphy, struct net_device *netdev,
 }
 
 
-static int lbs_cfg_del_key(struct wiphy *wiphy, struct net_device *netdev,
+static int lbs_cfg_del_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			   u8 key_index, bool pairwise, const u8 *mac_addr)
 {
 
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 6f23ec3..e5ce8dc 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -153,12 +153,18 @@ static void *mwifiex_cfg80211_get_adapter(struct wiphy *wiphy)
  * CFG802.11 operation handler to delete a network key.
  */
 static int
-mwifiex_cfg80211_del_key(struct wiphy *wiphy, struct net_device *netdev,
+mwifiex_cfg80211_del_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			 u8 key_index, bool pairwise, const u8 *mac_addr)
 {
-	struct mwifiex_private *priv = mwifiex_netdev_get_priv(netdev);
+	struct mwifiex_private *priv;
 	static const u8 bc_mac[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	const u8 *peer_mac = pairwise ? mac_addr : bc_mac;
+	struct net_device *netdev = wdev->netdev;
+
+	if (!netdev)
+		return -EOPNOTSUPP;
+
+	priv = mwifiex_netdev_get_priv(netdev);
 
 	if (mwifiex_set_encode(priv, NULL, NULL, 0, key_index, peer_mac, 1)) {
 		mwifiex_dbg(priv->adapter, ERROR, "deleting the crypto keys\n");
@@ -442,11 +448,17 @@ mwifiex_cfg80211_set_power_mgmt(struct wiphy *wiphy,
  * CFG802.11 operation handler to set the default network key.
  */
 static int
-mwifiex_cfg80211_set_default_key(struct wiphy *wiphy, struct net_device *netdev,
+mwifiex_cfg80211_set_default_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 				 u8 key_index, bool unicast,
 				 bool multicast)
 {
-	struct mwifiex_private *priv = mwifiex_netdev_get_priv(netdev);
+	struct mwifiex_private *priv;
+	struct net_device *netdev = wdev->netdev;
+
+	if (!netdev)
+		return -EOPNOTSUPP;
+
+	priv = mwifiex_netdev_get_priv(netdev);
 
 	/* Return if WEP key not configured */
 	if (!priv->sec_info.wep_enabled)
@@ -467,14 +479,20 @@ mwifiex_cfg80211_set_default_key(struct wiphy *wiphy, struct net_device *netdev,
  * CFG802.11 operation handler to add a network key.
  */
 static int
-mwifiex_cfg80211_add_key(struct wiphy *wiphy, struct net_device *netdev,
+mwifiex_cfg80211_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			 u8 key_index, bool pairwise, const u8 *mac_addr,
 			 struct key_params *params)
 {
-	struct mwifiex_private *priv = mwifiex_netdev_get_priv(netdev);
+	struct mwifiex_private *priv;
 	struct mwifiex_wep_key *wep_key;
 	static const u8 bc_mac[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 	const u8 *peer_mac = pairwise ? mac_addr : bc_mac;
+	struct net_device *netdev = wdev->netdev;
+
+	if (!netdev)
+		return -EOPNOTSUPP;
+
+	priv = mwifiex_netdev_get_priv(netdev);
 
 	if (GET_BSS_ROLE(priv) == MWIFIEX_BSS_ROLE_UAP &&
 	    (params->cipher == WLAN_CIPHER_SUITE_WEP40 ||
@@ -505,11 +523,17 @@ mwifiex_cfg80211_add_key(struct wiphy *wiphy, struct net_device *netdev,
  */
 static int
 mwifiex_cfg80211_set_default_mgmt_key(struct wiphy *wiphy,
-				      struct net_device *netdev,
+				      struct wireless_dev *wdev,
 				      u8 key_index)
 {
-	struct mwifiex_private *priv = mwifiex_netdev_get_priv(netdev);
+	struct mwifiex_private *priv;
 	struct mwifiex_ds_encrypt_key encrypt_key;
+	struct net_device *netdev = wdev->netdev;
+
+	if (!netdev)
+		return -EOPNOTSUPP;
+
+	priv = mwifiex_netdev_get_priv(netdev);
 
 	wiphy_dbg(wiphy, "set default mgmt key, key index=%d\n", key_index);
 
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index 8d8378b..0186650 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -539,7 +539,7 @@ static int wilc_wfi_cfg_copy_wpa_info(struct wilc_wfi_key *key_info,
 	return 0;
 }
 
-static int add_key(struct wiphy *wiphy, struct net_device *netdev, u8 key_index,
+static int add_key(struct wiphy *wiphy, struct wireless_dev *wdev, u8 key_index,
 		   bool pairwise, const u8 *mac_addr, struct key_params *params)
 
 {
@@ -548,8 +548,15 @@ static int add_key(struct wiphy *wiphy, struct net_device *netdev, u8 key_index,
 	const u8 *tx_mic = NULL;
 	u8 mode = WILC_FW_SEC_NO;
 	u8 op_mode;
-	struct wilc_vif *vif = netdev_priv(netdev);
-	struct wilc_priv *priv = &vif->priv;
+	struct wilc_vif *vif;
+	struct wilc_priv *priv;
+	struct net_device *netdev = wdev->netdev;
+
+	if (!netdev)
+		return -EOPNOTSUPP;
+
+	vif = netdev_priv(netdev);
+	priv = &vif->priv;
 
 	switch (params->cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
@@ -649,13 +656,20 @@ static int add_key(struct wiphy *wiphy, struct net_device *netdev, u8 key_index,
 	return ret;
 }
 
-static int del_key(struct wiphy *wiphy, struct net_device *netdev,
+static int del_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 		   u8 key_index,
 		   bool pairwise,
 		   const u8 *mac_addr)
 {
-	struct wilc_vif *vif = netdev_priv(netdev);
-	struct wilc_priv *priv = &vif->priv;
+	struct wilc_vif *vif;
+	struct wilc_priv *priv;
+	struct net_device *netdev = wdev->netdev;
+
+	if (!netdev)
+		return -EOPNOTSUPP;
+
+	vif = netdev_priv(netdev);
+	priv = &vif->priv;
 
 	if (priv->wilc_gtk[key_index]) {
 		kfree(priv->wilc_gtk[key_index]->key);
@@ -686,13 +700,20 @@ static int del_key(struct wiphy *wiphy, struct net_device *netdev,
 	return 0;
 }
 
-static int get_key(struct wiphy *wiphy, struct net_device *netdev, u8 key_index,
+static int get_key(struct wiphy *wiphy, struct wireless_dev *wdev, u8 key_index,
 		   bool pairwise, const u8 *mac_addr, void *cookie,
 		   void (*callback)(void *cookie, struct key_params *))
 {
-	struct wilc_vif *vif = netdev_priv(netdev);
-	struct wilc_priv *priv = &vif->priv;
+	struct wilc_vif *vif;
+	struct wilc_priv *priv;
 	struct  key_params key_params;
+	struct net_device *netdev = wdev->netdev;
+
+	if (!netdev)
+		return -EOPNOTSUPP;
+
+	vif = netdev_priv(netdev);
+	priv = &vif->priv;
 
 	if (!pairwise) {
 		key_params.key = priv->wilc_gtk[key_index]->key;
@@ -713,11 +734,16 @@ static int get_key(struct wiphy *wiphy, struct net_device *netdev, u8 key_index,
 	return 0;
 }
 
-static int set_default_key(struct wiphy *wiphy, struct net_device *netdev,
+static int set_default_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			   u8 key_index, bool unicast, bool multicast)
 {
-	struct wilc_vif *vif = netdev_priv(netdev);
+	struct wilc_vif *vif;
+	struct net_device *netdev = wdev->netdev;
+
+	if (!netdev)
+		return -EOPNOTSUPP;
 
+	vif = netdev_priv(netdev);
 	wilc_set_wep_default_keyid(vif, key_index);
 
 	return 0;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index 84b15a6..1aab9bb 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -530,12 +530,18 @@ qtnf_dump_station(struct wiphy *wiphy, struct net_device *dev,
 	return ret;
 }
 
-static int qtnf_add_key(struct wiphy *wiphy, struct net_device *dev,
+static int qtnf_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			u8 key_index, bool pairwise, const u8 *mac_addr,
 			struct key_params *params)
 {
-	struct qtnf_vif *vif = qtnf_netdev_get_priv(dev);
+	struct qtnf_vif *vif;
 	int ret;
+	struct net_device *dev = wdev->netdev;
+
+	if (!dev)
+		return -EOPNOTSUPP;
+
+	vif = qtnf_netdev_get_priv(dev);
 
 	ret = qtnf_cmd_send_add_key(vif, key_index, pairwise, mac_addr, params);
 	if (ret)
@@ -546,11 +552,17 @@ static int qtnf_add_key(struct wiphy *wiphy, struct net_device *dev,
 	return ret;
 }
 
-static int qtnf_del_key(struct wiphy *wiphy, struct net_device *dev,
+static int qtnf_del_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			u8 key_index, bool pairwise, const u8 *mac_addr)
 {
-	struct qtnf_vif *vif = qtnf_netdev_get_priv(dev);
+	struct qtnf_vif *vif;
 	int ret;
+	struct net_device *dev = wdev->netdev;
+
+	if (!dev)
+		return -EOPNOTSUPP;
+
+	vif = qtnf_netdev_get_priv(dev);
 
 	ret = qtnf_cmd_send_del_key(vif, key_index, pairwise, mac_addr);
 	if (ret) {
@@ -567,11 +579,17 @@ static int qtnf_del_key(struct wiphy *wiphy, struct net_device *dev,
 	return ret;
 }
 
-static int qtnf_set_default_key(struct wiphy *wiphy, struct net_device *dev,
+static int qtnf_set_default_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 				u8 key_index, bool unicast, bool multicast)
 {
-	struct qtnf_vif *vif = qtnf_netdev_get_priv(dev);
+	struct qtnf_vif *vif;
 	int ret;
+	struct net_device *dev = wdev->netdev;
+
+	if (!dev)
+		return -EOPNOTSUPP;
+
+	vif = qtnf_netdev_get_priv(dev);
 
 	ret = qtnf_cmd_send_set_default_key(vif, key_index, unicast, multicast);
 	if (ret)
@@ -583,11 +601,17 @@ static int qtnf_set_default_key(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int
-qtnf_set_default_mgmt_key(struct wiphy *wiphy, struct net_device *dev,
+qtnf_set_default_mgmt_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			  u8 key_index)
 {
-	struct qtnf_vif *vif = qtnf_netdev_get_priv(dev);
+	struct qtnf_vif *vif;
 	int ret;
+	struct net_device *dev = wdev->netdev;
+
+	if (!dev)
+		return -EOPNOTSUPP;
+
+	vif = qtnf_netdev_get_priv(dev);
 
 	ret = qtnf_cmd_send_set_default_mgmt_key(vif, key_index);
 	if (ret)
diff --git a/drivers/net/wireless/rndis_wlan.c b/drivers/net/wireless/rndis_wlan.c
index ff24483..b62fbc6 100644
--- a/drivers/net/wireless/rndis_wlan.c
+++ b/drivers/net/wireless/rndis_wlan.c
@@ -488,14 +488,14 @@ static int rndis_join_ibss(struct wiphy *wiphy, struct net_device *dev,
 
 static int rndis_leave_ibss(struct wiphy *wiphy, struct net_device *dev);
 
-static int rndis_add_key(struct wiphy *wiphy, struct net_device *netdev,
+static int rndis_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			 u8 key_index, bool pairwise, const u8 *mac_addr,
 			 struct key_params *params);
 
-static int rndis_del_key(struct wiphy *wiphy, struct net_device *netdev,
+static int rndis_del_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			 u8 key_index, bool pairwise, const u8 *mac_addr);
 
-static int rndis_set_default_key(struct wiphy *wiphy, struct net_device *netdev,
+static int rndis_set_default_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 				 u8 key_index, bool unicast, bool multicast);
 
 static int rndis_get_station(struct wiphy *wiphy, struct net_device *dev,
@@ -2376,13 +2376,17 @@ static int rndis_leave_ibss(struct wiphy *wiphy, struct net_device *dev)
 	return deauthenticate(usbdev);
 }
 
-static int rndis_add_key(struct wiphy *wiphy, struct net_device *netdev,
+static int rndis_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			 u8 key_index, bool pairwise, const u8 *mac_addr,
 			 struct key_params *params)
 {
 	struct rndis_wlan_private *priv = wiphy_priv(wiphy);
 	struct usbnet *usbdev = priv->usbdev;
 	__le32 flags;
+	struct net_device *netdev = wdev->netdev;
+
+	if (!netdev)
+		return -EOPNOTSUPP;
 
 	netdev_dbg(usbdev->net, "%s(%i, %pM, %08x)\n",
 		   __func__, key_index, mac_addr, params->cipher);
@@ -2412,23 +2416,31 @@ static int rndis_add_key(struct wiphy *wiphy, struct net_device *netdev,
 	}
 }
 
-static int rndis_del_key(struct wiphy *wiphy, struct net_device *netdev,
+static int rndis_del_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			 u8 key_index, bool pairwise, const u8 *mac_addr)
 {
 	struct rndis_wlan_private *priv = wiphy_priv(wiphy);
 	struct usbnet *usbdev = priv->usbdev;
+	struct net_device *netdev = wdev->netdev;
+
+	if (!netdev)
+		return -EOPNOTSUPP;
 
 	netdev_dbg(usbdev->net, "%s(%i, %pM)\n", __func__, key_index, mac_addr);
 
 	return remove_key(usbdev, key_index, mac_addr);
 }
 
-static int rndis_set_default_key(struct wiphy *wiphy, struct net_device *netdev,
+static int rndis_set_default_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 				 u8 key_index, bool unicast, bool multicast)
 {
 	struct rndis_wlan_private *priv = wiphy_priv(wiphy);
 	struct usbnet *usbdev = priv->usbdev;
 	struct rndis_wlan_encr_key key;
+	struct net_device *netdev = wdev->netdev;
+
+	if (!netdev)
+		return -EOPNOTSUPP;
 
 	netdev_dbg(usbdev->net, "%s(%i)\n", __func__, key_index);
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 5157b5b..7217d60 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -934,7 +934,7 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 	return ret;
 }
 
-static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
+static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 				u8 key_index, bool pairwise, const u8 *mac_addr,
 				struct key_params *params)
 {
@@ -942,9 +942,15 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
 	u32 param_len;
 	struct ieee_param *param = NULL;
 	int ret = 0;
-	struct adapter *padapter = rtw_netdev_priv(ndev);
-	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct adapter *padapter;
+	struct mlme_priv *pmlmepriv;
+	struct net_device *ndev = wdev->netdev;
+
+	if (!ndev)
+		return -EOPNOTSUPP;
 
+	padapter = rtw_netdev_priv(ndev);
+	pmlmepriv = &padapter->mlmepriv;
 	param_len = sizeof(struct ieee_param) + params->key_len;
 	param = rtw_malloc(param_len);
 	if (!param)
@@ -1026,7 +1032,7 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
 
 }
 
-static int cfg80211_rtw_get_key(struct wiphy *wiphy, struct net_device *ndev,
+static int cfg80211_rtw_get_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 				u8 key_index, bool pairwise, const u8 *mac_addr,
 				void *cookie,
 				void (*callback)(void *cookie,
@@ -1035,11 +1041,18 @@ static int cfg80211_rtw_get_key(struct wiphy *wiphy, struct net_device *ndev,
 	return 0;
 }
 
-static int cfg80211_rtw_del_key(struct wiphy *wiphy, struct net_device *ndev,
+static int cfg80211_rtw_del_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 				u8 key_index, bool pairwise, const u8 *mac_addr)
 {
-	struct adapter *padapter = rtw_netdev_priv(ndev);
-	struct security_priv *psecuritypriv = &padapter->securitypriv;
+	struct adapter *padapter;
+	struct security_priv *psecuritypriv;
+	struct net_device *ndev = wdev->netdev;
+
+	if (!ndev)
+		return -EOPNOTSUPP;
+
+	padapter = rtw_netdev_priv(ndev);
+	psecuritypriv = &padapter->securitypriv;
 
 	if (key_index == psecuritypriv->dot11PrivacyKeyIndex)
 	{
@@ -1051,12 +1064,19 @@ static int cfg80211_rtw_del_key(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static int cfg80211_rtw_set_default_key(struct wiphy *wiphy,
-	struct net_device *ndev, u8 key_index
+	struct wireless_dev *wdev, u8 key_index
 	, bool unicast, bool multicast
 	)
 {
-	struct adapter *padapter = rtw_netdev_priv(ndev);
-	struct security_priv *psecuritypriv = &padapter->securitypriv;
+	struct adapter *padapter;
+	struct security_priv *psecuritypriv;
+	struct net_device *ndev = wdev->netdev;
+
+	if (!ndev)
+		return -EOPNOTSUPP;
+
+	padapter = rtw_netdev_priv(ndev);
+	psecuritypriv = &padapter->securitypriv;
 
 	if ((key_index < WEP_KEYS) && ((psecuritypriv->dot11PrivacyAlgrthm == _WEP40_) || (psecuritypriv->dot11PrivacyAlgrthm == _WEP104_))) /* set wep default key */
 	{
diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 7951bd6..5e5e7d0 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -142,12 +142,18 @@ static int prism2_change_virtual_intf(struct wiphy *wiphy,
 	return err;
 }
 
-static int prism2_add_key(struct wiphy *wiphy, struct net_device *dev,
+static int prism2_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			  u8 key_index, bool pairwise, const u8 *mac_addr,
 			  struct key_params *params)
 {
-	struct wlandevice *wlandev = dev->ml_priv;
+	struct wlandevice *wlandev;
 	u32 did;
+	struct net_device *dev = wdev->netdev;
+
+	if (!dev)
+		return -EOPNOTSUPP;
+
+	wlandev = dev->ml_priv;
 
 	if (key_index >= NUM_WEPKEYS)
 		return -EINVAL;
@@ -171,14 +177,20 @@ static int prism2_add_key(struct wiphy *wiphy, struct net_device *dev,
 	return 0;
 }
 
-static int prism2_get_key(struct wiphy *wiphy, struct net_device *dev,
+static int prism2_get_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			  u8 key_index, bool pairwise,
 			  const u8 *mac_addr, void *cookie,
 			  void (*callback)(void *cookie, struct key_params*))
 {
-	struct wlandevice *wlandev = dev->ml_priv;
+	struct wlandevice *wlandev;
 	struct key_params params;
 	int len;
+	struct net_device *dev = wdev->netdev;
+
+	if (!dev)
+		return -EOPNOTSUPP;
+
+	wlandev = dev->ml_priv;
 
 	if (key_index >= NUM_WEPKEYS)
 		return -EINVAL;
@@ -201,13 +213,19 @@ static int prism2_get_key(struct wiphy *wiphy, struct net_device *dev,
 	return 0;
 }
 
-static int prism2_del_key(struct wiphy *wiphy, struct net_device *dev,
+static int prism2_del_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			  u8 key_index, bool pairwise, const u8 *mac_addr)
 {
-	struct wlandevice *wlandev = dev->ml_priv;
+	struct wlandevice *wlandev;
 	u32 did;
 	int err = 0;
 	int result = 0;
+	struct net_device *dev = wdev->netdev;
+
+	if (!dev)
+		return -EOPNOTSUPP;
+
+	wlandev = dev->ml_priv;
 
 	/* There is no direct way in the hardware (AFAIK) of removing
 	 * a key, so we will cheat by setting the key to a bogus value
@@ -226,10 +244,17 @@ static int prism2_del_key(struct wiphy *wiphy, struct net_device *dev,
 	return err;
 }
 
-static int prism2_set_default_key(struct wiphy *wiphy, struct net_device *dev,
+static int prism2_set_default_key(struct wiphy *wiphy,
+				  struct wireless_dev *wdev,
 				  u8 key_index, bool unicast, bool multicast)
 {
-	struct wlandevice *wlandev = dev->ml_priv;
+	struct wlandevice *wlandev;
+	struct net_device *dev = wdev->netdev;
+
+	if (!dev)
+		return -EOPNOTSUPP;
+
+	wlandev = dev->ml_priv;
 
 	return  prism2_domibset_uint32(wlandev,
 				       DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index f000e87..c3e43e8 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4177,23 +4177,23 @@ struct cfg80211_ops {
 				       enum nl80211_iftype type,
 				       struct vif_params *params);
 
-	int	(*add_key)(struct wiphy *wiphy, struct net_device *netdev,
+	int	(*add_key)(struct wiphy *wiphy, struct wireless_dev *wdev,
 			   u8 key_index, bool pairwise, const u8 *mac_addr,
 			   struct key_params *params);
-	int	(*get_key)(struct wiphy *wiphy, struct net_device *netdev,
+	int	(*get_key)(struct wiphy *wiphy, struct wireless_dev *wdev,
 			   u8 key_index, bool pairwise, const u8 *mac_addr,
 			   void *cookie,
 			   void (*callback)(void *cookie, struct key_params*));
-	int	(*del_key)(struct wiphy *wiphy, struct net_device *netdev,
+	int	(*del_key)(struct wiphy *wiphy, struct wireless_dev *wdev,
 			   u8 key_index, bool pairwise, const u8 *mac_addr);
 	int	(*set_default_key)(struct wiphy *wiphy,
-				   struct net_device *netdev,
+				   struct wireless_dev *wdev,
 				   u8 key_index, bool unicast, bool multicast);
 	int	(*set_default_mgmt_key)(struct wiphy *wiphy,
-					struct net_device *netdev,
+					struct wireless_dev *wdev,
 					u8 key_index);
 	int	(*set_default_beacon_key)(struct wiphy *wiphy,
-					  struct net_device *netdev,
+					  struct wireless_dev *wdev,
 					  u8 key_index);
 
 	int	(*start_ap)(struct wiphy *wiphy, struct net_device *dev,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 67a1602..522d3ad 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -431,17 +431,23 @@ static int ieee80211_set_tx(struct ieee80211_sub_if_data *sdata,
 	return ret;
 }
 
-static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
+static int ieee80211_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			     u8 key_idx, bool pairwise, const u8 *mac_addr,
 			     struct key_params *params)
 {
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
-	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_local *local;
 	struct sta_info *sta = NULL;
 	const struct ieee80211_cipher_scheme *cs = NULL;
 	struct ieee80211_key *key;
 	int err;
 
+	if (!wdev->netdev)
+		return -EOPNOTSUPP;
+
+	sdata = IEEE80211_DEV_TO_SUB_IF(wdev->netdev);
+	local = sdata->local;
+
 	if (!ieee80211_sdata_running(sdata))
 		return -ENETDOWN;
 
@@ -549,15 +555,21 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 	return err;
 }
 
-static int ieee80211_del_key(struct wiphy *wiphy, struct net_device *dev,
+static int ieee80211_del_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			     u8 key_idx, bool pairwise, const u8 *mac_addr)
 {
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
-	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_local *local;
 	struct sta_info *sta;
 	struct ieee80211_key *key = NULL;
 	int ret;
 
+	if (!wdev->netdev)
+		return -EOPNOTSUPP;
+
+	sdata = IEEE80211_DEV_TO_SUB_IF(wdev->netdev);
+	local = sdata->local;
+
 	mutex_lock(&local->sta_mtx);
 	mutex_lock(&local->key_mtx);
 
@@ -590,7 +602,7 @@ static int ieee80211_del_key(struct wiphy *wiphy, struct net_device *dev,
 	return ret;
 }
 
-static int ieee80211_get_key(struct wiphy *wiphy, struct net_device *dev,
+static int ieee80211_get_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 			     u8 key_idx, bool pairwise, const u8 *mac_addr,
 			     void *cookie,
 			     void (*callback)(void *cookie,
@@ -607,7 +619,10 @@ static int ieee80211_get_key(struct wiphy *wiphy, struct net_device *dev,
 	int err = -ENOENT;
 	struct ieee80211_key_seq kseq = {};
 
-	sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	if (!wdev->netdev)
+		return -EOPNOTSUPP;
+
+	sdata = IEEE80211_DEV_TO_SUB_IF(wdev->netdev);
 
 	rcu_read_lock();
 
@@ -710,11 +725,16 @@ static int ieee80211_get_key(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int ieee80211_config_default_key(struct wiphy *wiphy,
-					struct net_device *dev,
+					struct wireless_dev *wdev,
 					u8 key_idx, bool uni,
 					bool multi)
 {
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_sub_if_data *sdata;
+
+	if (!wdev->netdev)
+		return -EOPNOTSUPP;
+
+	sdata = IEEE80211_DEV_TO_SUB_IF(wdev->netdev);
 
 	ieee80211_set_default_key(sdata, key_idx, uni, multi);
 
@@ -722,10 +742,15 @@ static int ieee80211_config_default_key(struct wiphy *wiphy,
 }
 
 static int ieee80211_config_default_mgmt_key(struct wiphy *wiphy,
-					     struct net_device *dev,
+					     struct wireless_dev *wdev,
 					     u8 key_idx)
 {
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_sub_if_data *sdata;
+
+	if (!wdev->netdev)
+		return -EOPNOTSUPP;
+
+	sdata = IEEE80211_DEV_TO_SUB_IF(wdev->netdev);
 
 	ieee80211_set_default_mgmt_key(sdata, key_idx);
 
@@ -733,10 +758,15 @@ static int ieee80211_config_default_mgmt_key(struct wiphy *wiphy,
 }
 
 static int ieee80211_config_default_beacon_key(struct wiphy *wiphy,
-					       struct net_device *dev,
+					       struct wireless_dev *wdev,
 					       u8 key_idx)
 {
-	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct ieee80211_sub_if_data *sdata;
+
+	if (!wdev->netdev)
+		return -EOPNOTSUPP;
+
+	sdata = IEEE80211_DEV_TO_SUB_IF(wdev->netdev);
 
 	ieee80211_set_default_beacon_key(sdata, key_idx);
 
diff --git a/net/wireless/core.h b/net/wireless/core.h
index f3a5d7a..da55f76 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -584,4 +584,12 @@ cfg80211_get_colocated_ap_chan(struct cfg80211_registered_device *rdev,
 			       struct cfg80211_internal_bss *intbss,
 			       const u8 *colocated_bssid);
 
+#define wdev_err(wdev, fmt, ...)					\
+	do {								\
+		if ((wdev)->netdev)					\
+			netdev_err((wdev)->netdev, fmt, ##__VA_ARGS__);	\
+		else							\
+			pr_err(fmt, ##__VA_ARGS__);			\
+	} while (0)
+
 #endif /* __NET_WIRELESS_CORE_H */
diff --git a/net/wireless/ibss.c b/net/wireless/ibss.c
index 8f98e54..63c3537 100644
--- a/net/wireless/ibss.c
+++ b/net/wireless/ibss.c
@@ -173,7 +173,7 @@ static void __cfg80211_clear_ibss(struct net_device *dev, bool nowext)
 	 */
 	if (rdev->ops->del_key)
 		for (i = 0; i < 6; i++)
-			rdev_del_key(rdev, dev, i, false, NULL);
+			rdev_del_key(rdev, wdev, i, false, NULL);
 
 	if (wdev->current_bss) {
 		cfg80211_unhold_bss(wdev->current_bss);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 37f483f..0c1fd11 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4307,7 +4307,7 @@ static int nl80211_get_key(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	int err;
-	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = info->user_ptr[1];
 	u8 key_idx = 0;
 	const u8 *mac_addr = NULL;
 	bool pairwise;
@@ -4318,12 +4318,20 @@ static int nl80211_get_key(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *msg;
 	bool bigtk_support = false;
 
+	if (!wdev->netdev) {
+		if (wdev->iftype != NL80211_IFTYPE_MLO_LINK)
+			return -EINVAL;
+		if (!(rdev->wiphy.interface_modes &
+		      BIT(NL80211_IFTYPE_MLO_LINK)))
+			return -EOPNOTSUPP;
+	}
+
 	if (wiphy_ext_feature_isset(&rdev->wiphy,
 				    NL80211_EXT_FEATURE_BEACON_PROTECTION))
 		bigtk_support = true;
 
-	if ((dev->ieee80211_ptr->iftype == NL80211_IFTYPE_STATION ||
-	     dev->ieee80211_ptr->iftype == NL80211_IFTYPE_P2P_CLIENT) &&
+	if ((wdev->iftype == NL80211_IFTYPE_STATION ||
+	     wdev->iftype == NL80211_IFTYPE_P2P_CLIENT) &&
 	    wiphy_ext_feature_isset(&rdev->wiphy,
 				    NL80211_EXT_FEATURE_BEACON_PROTECTION_CLIENT))
 		bigtk_support = true;
@@ -4368,14 +4376,17 @@ static int nl80211_get_key(struct sk_buff *skb, struct genl_info *info)
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
 	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, mac_addr))
 		goto nla_put_failure;
 
-	err = rdev_get_key(rdev, dev, key_idx, pairwise, mac_addr, &cookie,
+	err = rdev_get_key(rdev, wdev, key_idx, pairwise, mac_addr, &cookie,
 			   get_key_callback);
 
 	if (err)
@@ -4399,7 +4410,15 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct key_parse key;
 	int err;
-	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = info->user_ptr[1];
+
+	if (!wdev->netdev) {
+		if (wdev->iftype != NL80211_IFTYPE_MLO_LINK)
+			return -EINVAL;
+		if (!(rdev->wiphy.interface_modes &
+		      BIT(NL80211_IFTYPE_MLO_LINK)))
+			return -EOPNOTSUPP;
+	}
 
 	err = nl80211_parse_key(info, &key);
 	if (err)
@@ -4415,7 +4434,7 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 	    !(key.p.mode == NL80211_KEY_SET_TX))
 		return -EINVAL;
 
-	wdev_lock(dev->ieee80211_ptr);
+	wdev_lock(wdev);
 
 	if (key.def) {
 		if (!rdev->ops->set_default_key) {
@@ -4423,18 +4442,18 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 		}
 
-		err = nl80211_key_allowed(dev->ieee80211_ptr);
+		err = nl80211_key_allowed(wdev);
 		if (err)
 			goto out;
 
-		err = rdev_set_default_key(rdev, dev, key.idx,
-						 key.def_uni, key.def_multi);
+		err = rdev_set_default_key(rdev, wdev, key.idx,
+					   key.def_uni, key.def_multi);
 
 		if (err)
 			goto out;
 
 #ifdef CONFIG_CFG80211_WEXT
-		dev->ieee80211_ptr->wext.default_key = key.idx;
+		wdev->wext.default_key = key.idx;
 #endif
 	} else if (key.defmgmt) {
 		if (key.def_uni || !key.def_multi) {
@@ -4447,16 +4466,16 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 		}
 
-		err = nl80211_key_allowed(dev->ieee80211_ptr);
+		err = nl80211_key_allowed(wdev);
 		if (err)
 			goto out;
 
-		err = rdev_set_default_mgmt_key(rdev, dev, key.idx);
+		err = rdev_set_default_mgmt_key(rdev, wdev, key.idx);
 		if (err)
 			goto out;
 
 #ifdef CONFIG_CFG80211_WEXT
-		dev->ieee80211_ptr->wext.default_mgmt_key = key.idx;
+		wdev->wext.default_mgmt_key = key.idx;
 #endif
 	} else if (key.defbeacon) {
 		if (key.def_uni || !key.def_multi) {
@@ -4469,11 +4488,11 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 		}
 
-		err = nl80211_key_allowed(dev->ieee80211_ptr);
+		err = nl80211_key_allowed(wdev);
 		if (err)
 			goto out;
 
-		err = rdev_set_default_beacon_key(rdev, dev, key.idx);
+		err = rdev_set_default_beacon_key(rdev, wdev, key.idx);
 		if (err)
 			goto out;
 	} else if (key.p.mode == NL80211_KEY_SET_TX &&
@@ -4489,14 +4508,14 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 		}
 
-		err = rdev_add_key(rdev, dev, key.idx,
+		err = rdev_add_key(rdev, wdev, key.idx,
 				   NL80211_KEYTYPE_PAIRWISE,
 				   mac_addr, &key.p);
 	} else {
 		err = -EINVAL;
 	}
  out:
-	wdev_unlock(dev->ieee80211_ptr);
+	wdev_unlock(wdev);
 
 	return err;
 }
@@ -4505,10 +4524,18 @@ static int nl80211_new_key(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	int err;
-	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = info->user_ptr[1];
 	struct key_parse key;
 	const u8 *mac_addr = NULL;
 
+	if (!wdev->netdev) {
+		if (wdev->iftype != NL80211_IFTYPE_MLO_LINK)
+			return -EINVAL;
+		if (!(rdev->wiphy.interface_modes &
+		      BIT(NL80211_IFTYPE_MLO_LINK)))
+			return -EOPNOTSUPP;
+	}
+
 	err = nl80211_parse_key(info, &key);
 	if (err)
 		return err;
@@ -4549,18 +4576,18 @@ static int nl80211_new_key(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 
-	wdev_lock(dev->ieee80211_ptr);
-	err = nl80211_key_allowed(dev->ieee80211_ptr);
+	wdev_lock(wdev);
+	err = nl80211_key_allowed(wdev);
 	if (err)
 		GENL_SET_ERR_MSG(info, "key not allowed");
 	if (!err) {
-		err = rdev_add_key(rdev, dev, key.idx,
+		err = rdev_add_key(rdev, wdev, key.idx,
 				   key.type == NL80211_KEYTYPE_PAIRWISE,
 				    mac_addr, &key.p);
 		if (err)
 			GENL_SET_ERR_MSG(info, "key addition failed");
 	}
-	wdev_unlock(dev->ieee80211_ptr);
+	wdev_unlock(wdev);
 
 	return err;
 }
@@ -4569,10 +4596,18 @@ static int nl80211_del_key(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	int err;
-	struct net_device *dev = info->user_ptr[1];
+	struct wireless_dev *wdev = info->user_ptr[1];
 	u8 *mac_addr = NULL;
 	struct key_parse key;
 
+	if (!wdev->netdev) {
+		if (wdev->iftype != NL80211_IFTYPE_MLO_LINK)
+			return -EINVAL;
+		if (!(rdev->wiphy.interface_modes &
+		      BIT(NL80211_IFTYPE_MLO_LINK)))
+			return -EOPNOTSUPP;
+	}
+
 	err = nl80211_parse_key(info, &key);
 	if (err)
 		return err;
@@ -4599,27 +4634,27 @@ static int nl80211_del_key(struct sk_buff *skb, struct genl_info *info)
 	if (!rdev->ops->del_key)
 		return -EOPNOTSUPP;
 
-	wdev_lock(dev->ieee80211_ptr);
-	err = nl80211_key_allowed(dev->ieee80211_ptr);
+	wdev_lock(wdev);
+	err = nl80211_key_allowed(wdev);
 
 	if (key.type == NL80211_KEYTYPE_GROUP && mac_addr &&
 	    !(rdev->wiphy.flags & WIPHY_FLAG_IBSS_RSN))
 		err = -ENOENT;
 
 	if (!err)
-		err = rdev_del_key(rdev, dev, key.idx,
+		err = rdev_del_key(rdev, wdev, key.idx,
 				   key.type == NL80211_KEYTYPE_PAIRWISE,
 				   mac_addr);
 
 #ifdef CONFIG_CFG80211_WEXT
 	if (!err) {
-		if (key.idx == dev->ieee80211_ptr->wext.default_key)
-			dev->ieee80211_ptr->wext.default_key = -1;
-		else if (key.idx == dev->ieee80211_ptr->wext.default_mgmt_key)
-			dev->ieee80211_ptr->wext.default_mgmt_key = -1;
+		if (key.idx == wdev->wext.default_key)
+			wdev->wext.default_key = -1;
+		else if (key.idx == wdev->wext.default_mgmt_key)
+			wdev->wext.default_mgmt_key = -1;
 	}
 #endif
-	wdev_unlock(dev->ieee80211_ptr);
+	wdev_unlock(wdev);
 
 	return err;
 }
@@ -15590,14 +15625,14 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_get_key,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_SET_KEY,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_set_key,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -15605,7 +15640,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_new_key,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
+		.internal_flags = NL80211_FLAG_NEED_WDEV_UP |
 				  NL80211_FLAG_CLEAR_SKB,
 	},
 	{
@@ -15613,7 +15648,7 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.doit = nl80211_del_key,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP,
+		.internal_flags = NL80211_FLAG_NEED_WDEV_UP,
 	},
 	{
 		.cmd = NL80211_CMD_SET_BEACON,
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 439bcf5..e12c621 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -72,39 +72,39 @@ rdev_change_virtual_intf(struct cfg80211_registered_device *rdev,
 }
 
 static inline int rdev_add_key(struct cfg80211_registered_device *rdev,
-			       struct net_device *netdev, u8 key_index,
+			       struct wireless_dev *wdev, u8 key_index,
 			       bool pairwise, const u8 *mac_addr,
 			       struct key_params *params)
 {
 	int ret;
-	trace_rdev_add_key(&rdev->wiphy, netdev, key_index, pairwise,
+	trace_rdev_add_key(&rdev->wiphy, wdev, key_index, pairwise,
 			   mac_addr, params->mode);
-	ret = rdev->ops->add_key(&rdev->wiphy, netdev, key_index, pairwise,
+	ret = rdev->ops->add_key(&rdev->wiphy, wdev, key_index, pairwise,
 				  mac_addr, params);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
 
 static inline int
-rdev_get_key(struct cfg80211_registered_device *rdev, struct net_device *netdev,
+rdev_get_key(struct cfg80211_registered_device *rdev, struct wireless_dev *wdev,
 	     u8 key_index, bool pairwise, const u8 *mac_addr, void *cookie,
 	     void (*callback)(void *cookie, struct key_params*))
 {
 	int ret;
-	trace_rdev_get_key(&rdev->wiphy, netdev, key_index, pairwise, mac_addr);
-	ret = rdev->ops->get_key(&rdev->wiphy, netdev, key_index, pairwise,
+	trace_rdev_get_key(&rdev->wiphy, wdev, key_index, pairwise, mac_addr);
+	ret = rdev->ops->get_key(&rdev->wiphy, wdev, key_index, pairwise,
 				  mac_addr, cookie, callback);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
 
 static inline int rdev_del_key(struct cfg80211_registered_device *rdev,
-			       struct net_device *netdev, u8 key_index,
+			       struct wireless_dev *wdev, u8 key_index,
 			       bool pairwise, const u8 *mac_addr)
 {
 	int ret;
-	trace_rdev_del_key(&rdev->wiphy, netdev, key_index, pairwise, mac_addr);
-	ret = rdev->ops->del_key(&rdev->wiphy, netdev, key_index, pairwise,
+	trace_rdev_del_key(&rdev->wiphy, wdev, key_index, pairwise, mac_addr);
+	ret = rdev->ops->del_key(&rdev->wiphy, wdev, key_index, pairwise,
 				  mac_addr);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
@@ -112,13 +112,13 @@ static inline int rdev_del_key(struct cfg80211_registered_device *rdev,
 
 static inline int
 rdev_set_default_key(struct cfg80211_registered_device *rdev,
-		     struct net_device *netdev, u8 key_index, bool unicast,
+		     struct wireless_dev *wdev, u8 key_index, bool unicast,
 		     bool multicast)
 {
 	int ret;
-	trace_rdev_set_default_key(&rdev->wiphy, netdev, key_index,
+	trace_rdev_set_default_key(&rdev->wiphy, wdev, key_index,
 				   unicast, multicast);
-	ret = rdev->ops->set_default_key(&rdev->wiphy, netdev, key_index,
+	ret = rdev->ops->set_default_key(&rdev->wiphy, wdev, key_index,
 					  unicast, multicast);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
@@ -126,11 +126,11 @@ rdev_set_default_key(struct cfg80211_registered_device *rdev,
 
 static inline int
 rdev_set_default_mgmt_key(struct cfg80211_registered_device *rdev,
-			  struct net_device *netdev, u8 key_index)
+			  struct wireless_dev *wdev, u8 key_index)
 {
 	int ret;
-	trace_rdev_set_default_mgmt_key(&rdev->wiphy, netdev, key_index);
-	ret = rdev->ops->set_default_mgmt_key(&rdev->wiphy, netdev,
+	trace_rdev_set_default_mgmt_key(&rdev->wiphy, wdev, key_index);
+	ret = rdev->ops->set_default_mgmt_key(&rdev->wiphy, wdev,
 					       key_index);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
@@ -138,12 +138,12 @@ rdev_set_default_mgmt_key(struct cfg80211_registered_device *rdev,
 
 static inline int
 rdev_set_default_beacon_key(struct cfg80211_registered_device *rdev,
-			    struct net_device *netdev, u8 key_index)
+			    struct wireless_dev *wdev, u8 key_index)
 {
 	int ret;
 
-	trace_rdev_set_default_beacon_key(&rdev->wiphy, netdev, key_index);
-	ret = rdev->ops->set_default_beacon_key(&rdev->wiphy, netdev,
+	trace_rdev_set_default_beacon_key(&rdev->wiphy, wdev, key_index);
+	ret = rdev->ops->set_default_beacon_key(&rdev->wiphy, wdev,
 						key_index);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 5d76e52..e287eb0 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1187,7 +1187,7 @@ void __cfg80211_disconnected(struct net_device *dev, const u8 *ie,
 			    NL80211_EXT_FEATURE_BEACON_PROTECTION_CLIENT))
 			max_key_idx = 7;
 		for (i = 0; i <= max_key_idx; i++)
-			rdev_del_key(rdev, dev, i, false, NULL);
+			rdev_del_key(rdev, wdev, i, false, NULL);
 	}
 
 	rdev_set_qos_map(rdev, dev, NULL);
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 228079d..a848b05 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -434,47 +434,47 @@ TRACE_EVENT(rdev_change_virtual_intf,
 );
 
 DECLARE_EVENT_CLASS(key_handle,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, u8 key_index,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, u8 key_index,
 		 bool pairwise, const u8 *mac_addr),
-	TP_ARGS(wiphy, netdev, key_index, pairwise, mac_addr),
+	TP_ARGS(wiphy, wdev, key_index, pairwise, mac_addr),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
-		NETDEV_ENTRY
+		WDEV_ENTRY
 		MAC_ENTRY(mac_addr)
 		__field(u8, key_index)
 		__field(bool, pairwise)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
-		NETDEV_ASSIGN;
+		WDEV_ASSIGN;
 		MAC_ASSIGN(mac_addr, mac_addr);
 		__entry->key_index = key_index;
 		__entry->pairwise = pairwise;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", key_index: %u, pairwise: %s, mac addr: " MAC_PR_FMT,
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->key_index,
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", key_index: %u, pairwise: %s, mac addr: " MAC_PR_FMT,
+		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->key_index,
 		  BOOL_TO_STR(__entry->pairwise), MAC_PR_ARG(mac_addr))
 );
 
 DEFINE_EVENT(key_handle, rdev_get_key,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, u8 key_index,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, u8 key_index,
 		 bool pairwise, const u8 *mac_addr),
-	TP_ARGS(wiphy, netdev, key_index, pairwise, mac_addr)
+	TP_ARGS(wiphy, wdev, key_index, pairwise, mac_addr)
 );
 
 DEFINE_EVENT(key_handle, rdev_del_key,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, u8 key_index,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, u8 key_index,
 		 bool pairwise, const u8 *mac_addr),
-	TP_ARGS(wiphy, netdev, key_index, pairwise, mac_addr)
+	TP_ARGS(wiphy, wdev, key_index, pairwise, mac_addr)
 );
 
 TRACE_EVENT(rdev_add_key,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, u8 key_index,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, u8 key_index,
 		 bool pairwise, const u8 *mac_addr, u8 mode),
-	TP_ARGS(wiphy, netdev, key_index, pairwise, mac_addr, mode),
+	TP_ARGS(wiphy, wdev, key_index, pairwise, mac_addr, mode),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
-		NETDEV_ENTRY
+		WDEV_ENTRY
 		MAC_ENTRY(mac_addr)
 		__field(u8, key_index)
 		__field(bool, pairwise)
@@ -482,75 +482,75 @@ TRACE_EVENT(rdev_add_key,
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
-		NETDEV_ASSIGN;
+		WDEV_ASSIGN;
 		MAC_ASSIGN(mac_addr, mac_addr);
 		__entry->key_index = key_index;
 		__entry->pairwise = pairwise;
 		__entry->mode = mode;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", key_index: %u, "
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", key_index: %u, "
 		  "mode: %u, pairwise: %s, mac addr: " MAC_PR_FMT,
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->key_index,
+		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->key_index,
 		  __entry->mode, BOOL_TO_STR(__entry->pairwise),
 		  MAC_PR_ARG(mac_addr))
 );
 
 TRACE_EVENT(rdev_set_default_key,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, u8 key_index,
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, u8 key_index,
 		 bool unicast, bool multicast),
-	TP_ARGS(wiphy, netdev, key_index, unicast, multicast),
+	TP_ARGS(wiphy, wdev, key_index, unicast, multicast),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
-		NETDEV_ENTRY
+		WDEV_ENTRY
 		__field(u8, key_index)
 		__field(bool, unicast)
 		__field(bool, multicast)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
-		NETDEV_ASSIGN;
+		WDEV_ASSIGN;
 		__entry->key_index = key_index;
 		__entry->unicast = unicast;
 		__entry->multicast = multicast;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", key index: %u, unicast: %s, multicast: %s",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->key_index,
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", key index: %u, unicast: %s, multicast: %s",
+		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->key_index,
 		  BOOL_TO_STR(__entry->unicast),
 		  BOOL_TO_STR(__entry->multicast))
 );
 
 TRACE_EVENT(rdev_set_default_mgmt_key,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, u8 key_index),
-	TP_ARGS(wiphy, netdev, key_index),
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, u8 key_index),
+	TP_ARGS(wiphy, wdev, key_index),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
-		NETDEV_ENTRY
+		WDEV_ENTRY
 		__field(u8, key_index)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
-		NETDEV_ASSIGN;
+		WDEV_ASSIGN;
 		__entry->key_index = key_index;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", key index: %u",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->key_index)
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", key index: %u",
+		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->key_index)
 );
 
 TRACE_EVENT(rdev_set_default_beacon_key,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, u8 key_index),
-	TP_ARGS(wiphy, netdev, key_index),
+	TP_PROTO(struct wiphy *wiphy, struct wireless_dev *wdev, u8 key_index),
+	TP_ARGS(wiphy, wdev, key_index),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
-		NETDEV_ENTRY
+		WDEV_ENTRY
 		__field(u8, key_index)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
-		NETDEV_ASSIGN;
+		WDEV_ASSIGN;
 		__entry->key_index = key_index;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", key index: %u",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->key_index)
+	TP_printk(WIPHY_PR_FMT ", " WDEV_PR_FMT ", key index: %u",
+		  WIPHY_PR_ARG, WDEV_PR_ARG, __entry->key_index)
 );
 
 TRACE_EVENT(rdev_start_ap,
diff --git a/net/wireless/util.c b/net/wireless/util.c
index e692a17..3dc83bb 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -926,7 +926,6 @@ EXPORT_SYMBOL(ieee80211_bss_get_elem);
 void cfg80211_upload_connect_keys(struct wireless_dev *wdev)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
-	struct net_device *dev = wdev->netdev;
 	int i;
 
 	if (!wdev->connect_keys)
@@ -935,14 +934,14 @@ void cfg80211_upload_connect_keys(struct wireless_dev *wdev)
 	for (i = 0; i < CFG80211_MAX_WEP_KEYS; i++) {
 		if (!wdev->connect_keys->params[i].cipher)
 			continue;
-		if (rdev_add_key(rdev, dev, i, false, NULL,
+		if (rdev_add_key(rdev, wdev, i, false, NULL,
 				 &wdev->connect_keys->params[i])) {
-			netdev_err(dev, "failed to set key %d\n", i);
+			wdev_err(wdev, "failed to set key %d\n", i);
 			continue;
 		}
 		if (wdev->connect_keys->def == i &&
-		    rdev_set_default_key(rdev, dev, i, true, true)) {
-			netdev_err(dev, "failed to set defkey %d\n", i);
+		    rdev_set_default_key(rdev, wdev, i, true, true)) {
+			wdev_err(wdev, "failed to set defkey %d\n", i);
 			continue;
 		}
 	}
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index a32065d..08fcd20 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -465,7 +465,7 @@ static int __cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 			    !(rdev->wiphy.flags & WIPHY_FLAG_IBSS_RSN))
 				err = -ENOENT;
 			else
-				err = rdev_del_key(rdev, dev, idx, pairwise,
+				err = rdev_del_key(rdev, wdev, idx, pairwise,
 						   addr);
 		}
 		wdev->wext.connect.privacy = false;
@@ -502,7 +502,7 @@ static int __cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 
 	err = 0;
 	if (wdev->current_bss)
-		err = rdev_add_key(rdev, dev, idx, pairwise, addr, params);
+		err = rdev_add_key(rdev, wdev, idx, pairwise, addr, params);
 	else if (params->cipher != WLAN_CIPHER_SUITE_WEP40 &&
 		 params->cipher != WLAN_CIPHER_SUITE_WEP104)
 		return -EINVAL;
@@ -537,7 +537,7 @@ static int __cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 				__cfg80211_leave_ibss(rdev, wdev->netdev, true);
 				rejoin = true;
 			}
-			err = rdev_set_default_key(rdev, dev, idx, true, true);
+			err = rdev_set_default_key(rdev, wdev, idx, true, true);
 		}
 		if (!err) {
 			wdev->wext.default_key = idx;
@@ -550,7 +550,7 @@ static int __cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 	if (params->cipher == WLAN_CIPHER_SUITE_AES_CMAC &&
 	    (tx_key || (!addr && wdev->wext.default_mgmt_key == -1))) {
 		if (wdev->current_bss)
-			err = rdev_set_default_mgmt_key(rdev, dev, idx);
+			err = rdev_set_default_mgmt_key(rdev, wdev, idx);
 		if (!err)
 			wdev->wext.default_mgmt_key = idx;
 		return err;
@@ -614,7 +614,7 @@ static int cfg80211_wext_siwencode(struct net_device *dev,
 		err = 0;
 		wdev_lock(wdev);
 		if (wdev->current_bss)
-			err = rdev_set_default_key(rdev, dev, idx, true,
+			err = rdev_set_default_key(rdev, wdev, idx, true,
 						   true);
 		if (!err)
 			wdev->wext.default_key = idx;
-- 
2.7.4

