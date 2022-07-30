Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9B05858C7
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Jul 2022 07:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbiG3F10 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Jul 2022 01:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbiG3F1Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Jul 2022 01:27:25 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7360AE0A2
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jul 2022 22:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659158842; x=1690694842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V/iIckThGCPA1kabN5EjyWOZxhZMDSEuvs641aCKB2E=;
  b=Dpk1tjTX1Or04kdaKf0bheSHIGWIbsQXOVLVGCEScaBWF5kifN9ln81e
   Pch54XCqCG28OkbM9MxiiOQhDqQiG0+gVWYIMT9BxgCW9MC+tTUHUBXeX
   +740N1fBZm+23mBD2/0aak2lWNKvRVfb+s40iqYKmS++pDjrjhF5iCac/
   k=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 29 Jul 2022 22:27:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 22:27:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Jul 2022 22:27:04 -0700
Received: from cnss-mw-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Jul 2022 22:27:02 -0700
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH v2 3/3] wifi: cfg80211: Add link_id parameter to various key operations for MLO
Date:   Sat, 30 Jul 2022 10:56:43 +0530
Message-ID: <20220730052643.1959111-4-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220730052643.1959111-1-quic_vjakkam@quicinc.com>
References: <20220730052643.1959111-1-quic_vjakkam@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for various key operations on MLD by adding new parameter
link_id. Pass the link_id received from userspace to driver for add_key,
get_key, del_key, set_default_key, set_default_mgmt_key and
set_default_beacon_key to support configuring keys specific to each MLO
link. Userspace must not specify link ID for MLO pairwise key since it
is common for all the MLO links.

Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c    |   8 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  10 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  22 +--
 drivers/net/wireless/marvell/libertas/cfg.c   |   9 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  10 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |  17 ++-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  12 +-
 drivers/net/wireless/rndis_wlan.c             |  20 +--
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  13 +-
 drivers/staging/wlan-ng/cfg80211.c            |  12 +-
 include/net/cfg80211.h                        |  37 +++--
 include/uapi/linux/nl80211.h                  |  14 +-
 net/mac80211/cfg.c                            |  17 +--
 net/wireless/ibss.c                           |   2 +-
 net/wireless/nl80211.c                        | 126 ++++++++++++++----
 net/wireless/rdev-ops.h                       |  58 ++++----
 net/wireless/sme.c                            |   2 +-
 net/wireless/trace.h                          |  86 +++++++-----
 net/wireless/util.c                           |   4 +-
 net/wireless/wext-compat.c                    |  11 +-
 20 files changed, 312 insertions(+), 178 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index e11c7e9accc0..a20e0aeae284 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -1124,7 +1124,7 @@ void ath6kl_cfg80211_ch_switch_notify(struct ath6kl_vif *vif, int freq,
 }
 
 static int ath6kl_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
-				   u8 key_index, bool pairwise,
+				   int link_id, u8 key_index, bool pairwise,
 				   const u8 *mac_addr,
 				   struct key_params *params)
 {
@@ -1249,7 +1249,7 @@ static int ath6kl_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static int ath6kl_cfg80211_del_key(struct wiphy *wiphy, struct net_device *ndev,
-				   u8 key_index, bool pairwise,
+				   int link_id, u8 key_index, bool pairwise,
 				   const u8 *mac_addr)
 {
 	struct ath6kl *ar = ath6kl_priv(ndev);
@@ -1279,7 +1279,7 @@ static int ath6kl_cfg80211_del_key(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static int ath6kl_cfg80211_get_key(struct wiphy *wiphy, struct net_device *ndev,
-				   u8 key_index, bool pairwise,
+				   int link_id, u8 key_index, bool pairwise,
 				   const u8 *mac_addr, void *cookie,
 				   void (*callback) (void *cookie,
 						     struct key_params *))
@@ -1314,7 +1314,7 @@ static int ath6kl_cfg80211_get_key(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static int ath6kl_cfg80211_set_default_key(struct wiphy *wiphy,
-					   struct net_device *ndev,
+					   struct net_device *ndev, int link_id,
 					   u8 key_index, bool unicast,
 					   bool multicast)
 {
diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index f93bdffa4d1d..40f9a7ef8980 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -1620,7 +1620,7 @@ static void wil_del_rx_key(u8 key_index, enum wmi_key_usage key_usage,
 }
 
 static int wil_cfg80211_add_key(struct wiphy *wiphy,
-				struct net_device *ndev,
+				struct net_device *ndev, int link_id,
 				u8 key_index, bool pairwise,
 				const u8 *mac_addr,
 				struct key_params *params)
@@ -1696,7 +1696,7 @@ static int wil_cfg80211_add_key(struct wiphy *wiphy,
 }
 
 static int wil_cfg80211_del_key(struct wiphy *wiphy,
-				struct net_device *ndev,
+				struct net_device *ndev, int link_id,
 				u8 key_index, bool pairwise,
 				const u8 *mac_addr)
 {
@@ -1723,7 +1723,7 @@ static int wil_cfg80211_del_key(struct wiphy *wiphy,
 
 /* Need to be present or wiphy_new() will WARN */
 static int wil_cfg80211_set_default_key(struct wiphy *wiphy,
-					struct net_device *ndev,
+					struct net_device *ndev, int link_id,
 					u8 key_index, bool unicast,
 					bool multicast)
 {
@@ -2072,8 +2072,8 @@ void wil_cfg80211_ap_recovery(struct wil6210_priv *wil)
 		key_params.key = vif->gtk;
 		key_params.key_len = vif->gtk_len;
 		key_params.seq_len = IEEE80211_GCMP_PN_LEN;
-		rc = wil_cfg80211_add_key(wiphy, ndev, vif->gtk_index, false,
-					  NULL, &key_params);
+		rc = wil_cfg80211_add_key(wiphy, ndev, -1, vif->gtk_index,
+					  false, NULL, &key_params);
 		if (rc)
 			wil_err(wil, "vif %d recovery add key failed (%d)\n",
 				i, rc);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index db45da33adfd..cd816c4551d1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -2361,7 +2361,8 @@ brcmf_cfg80211_get_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 
 static s32
 brcmf_cfg80211_config_default_key(struct wiphy *wiphy, struct net_device *ndev,
-				  u8 key_idx, bool unicast, bool multicast)
+				  int link_id, u8 key_idx, bool unicast,
+				  bool multicast)
 {
 	struct brcmf_if *ifp = netdev_priv(ndev);
 	struct brcmf_pub *drvr = ifp->drvr;
@@ -2395,7 +2396,8 @@ brcmf_cfg80211_config_default_key(struct wiphy *wiphy, struct net_device *ndev,
 
 static s32
 brcmf_cfg80211_del_key(struct wiphy *wiphy, struct net_device *ndev,
-		       u8 key_idx, bool pairwise, const u8 *mac_addr)
+		       int link_id, u8 key_idx, bool pairwise,
+		       const u8 *mac_addr)
 {
 	struct brcmf_if *ifp = netdev_priv(ndev);
 	struct brcmf_wsec_key *key;
@@ -2432,8 +2434,8 @@ brcmf_cfg80211_del_key(struct wiphy *wiphy, struct net_device *ndev,
 
 static s32
 brcmf_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
-		       u8 key_idx, bool pairwise, const u8 *mac_addr,
-		       struct key_params *params)
+		       int link_id, u8 key_idx, bool pairwise,
+		       const u8 *mac_addr, struct key_params *params)
 {
 	struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
 	struct brcmf_if *ifp = netdev_priv(ndev);
@@ -2457,8 +2459,8 @@ brcmf_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
 	}
 
 	if (params->key_len == 0)
-		return brcmf_cfg80211_del_key(wiphy, ndev, key_idx, pairwise,
-					      mac_addr);
+		return brcmf_cfg80211_del_key(wiphy, ndev, -1, key_idx,
+					      pairwise, mac_addr);
 
 	if (params->key_len > sizeof(key->data)) {
 		bphy_err(drvr, "Too long key length (%u)\n", params->key_len);
@@ -2553,8 +2555,9 @@ brcmf_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static s32
-brcmf_cfg80211_get_key(struct wiphy *wiphy, struct net_device *ndev, u8 key_idx,
-		       bool pairwise, const u8 *mac_addr, void *cookie,
+brcmf_cfg80211_get_key(struct wiphy *wiphy, struct net_device *ndev,
+		       int link_id, u8 key_idx, bool pairwise,
+		       const u8 *mac_addr, void *cookie,
 		       void (*callback)(void *cookie,
 					struct key_params *params))
 {
@@ -2610,7 +2613,8 @@ brcmf_cfg80211_get_key(struct wiphy *wiphy, struct net_device *ndev, u8 key_idx,
 
 static s32
 brcmf_cfg80211_config_default_mgmt_key(struct wiphy *wiphy,
-				       struct net_device *ndev, u8 key_idx)
+				       struct net_device *ndev, int link_id,
+				       u8 key_idx)
 {
 	struct brcmf_if *ifp = netdev_priv(ndev);
 
diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index b0b3f59dabc6..5e3ae00153b8 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -1435,7 +1435,7 @@ static int lbs_cfg_disconnect(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int lbs_cfg_set_default_key(struct wiphy *wiphy,
-				   struct net_device *netdev,
+				   struct net_device *netdev, int link_id,
 				   u8 key_index, bool unicast,
 				   bool multicast)
 {
@@ -1455,8 +1455,8 @@ static int lbs_cfg_set_default_key(struct wiphy *wiphy,
 
 
 static int lbs_cfg_add_key(struct wiphy *wiphy, struct net_device *netdev,
-			   u8 idx, bool pairwise, const u8 *mac_addr,
-			   struct key_params *params)
+			   int link_id, u8 idx, bool pairwise,
+			   const u8 *mac_addr, struct key_params *params)
 {
 	struct lbs_private *priv = wiphy_priv(wiphy);
 	u16 key_info;
@@ -1516,7 +1516,8 @@ static int lbs_cfg_add_key(struct wiphy *wiphy, struct net_device *netdev,
 
 
 static int lbs_cfg_del_key(struct wiphy *wiphy, struct net_device *netdev,
-			   u8 key_index, bool pairwise, const u8 *mac_addr)
+			   int link_id, u8 key_index, bool pairwise,
+			   const u8 *mac_addr)
 {
 
 	lbs_deb_assoc("del_key: key_idx %d, mac_addr %pM\n",
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index d68c40e0e122..4f3bfdbe0d9d 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -154,7 +154,8 @@ static void *mwifiex_cfg80211_get_adapter(struct wiphy *wiphy)
  */
 static int
 mwifiex_cfg80211_del_key(struct wiphy *wiphy, struct net_device *netdev,
-			 u8 key_index, bool pairwise, const u8 *mac_addr)
+			 int link_id, u8 key_index, bool pairwise,
+			 const u8 *mac_addr)
 {
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(netdev);
 	static const u8 bc_mac[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
@@ -443,7 +444,7 @@ mwifiex_cfg80211_set_power_mgmt(struct wiphy *wiphy,
  */
 static int
 mwifiex_cfg80211_set_default_key(struct wiphy *wiphy, struct net_device *netdev,
-				 u8 key_index, bool unicast,
+				 int link_id, u8 key_index, bool unicast,
 				 bool multicast)
 {
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(netdev);
@@ -468,8 +469,8 @@ mwifiex_cfg80211_set_default_key(struct wiphy *wiphy, struct net_device *netdev,
  */
 static int
 mwifiex_cfg80211_add_key(struct wiphy *wiphy, struct net_device *netdev,
-			 u8 key_index, bool pairwise, const u8 *mac_addr,
-			 struct key_params *params)
+			 int link_id, u8 key_index, bool pairwise,
+			 const u8 *mac_addr, struct key_params *params)
 {
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(netdev);
 	struct mwifiex_wep_key *wep_key;
@@ -506,6 +507,7 @@ mwifiex_cfg80211_add_key(struct wiphy *wiphy, struct net_device *netdev,
 static int
 mwifiex_cfg80211_set_default_mgmt_key(struct wiphy *wiphy,
 				      struct net_device *netdev,
+				      int link_id,
 				      u8 key_index)
 {
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(netdev);
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index 3ac373d29d93..f810a56a7ff0 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -540,8 +540,9 @@ static int wilc_wfi_cfg_copy_wpa_info(struct wilc_wfi_key *key_info,
 	return 0;
 }
 
-static int add_key(struct wiphy *wiphy, struct net_device *netdev, u8 key_index,
-		   bool pairwise, const u8 *mac_addr, struct key_params *params)
+static int add_key(struct wiphy *wiphy, struct net_device *netdev, int link_id,
+		   u8 key_index, bool pairwise, const u8 *mac_addr,
+		   struct key_params *params)
 
 {
 	int ret = 0, keylen = params->key_len;
@@ -644,7 +645,7 @@ static int add_key(struct wiphy *wiphy, struct net_device *netdev, u8 key_index,
 	return ret;
 }
 
-static int del_key(struct wiphy *wiphy, struct net_device *netdev,
+static int del_key(struct wiphy *wiphy, struct net_device *netdev, int link_id,
 		   u8 key_index,
 		   bool pairwise,
 		   const u8 *mac_addr)
@@ -685,8 +686,9 @@ static int del_key(struct wiphy *wiphy, struct net_device *netdev,
 	return 0;
 }
 
-static int get_key(struct wiphy *wiphy, struct net_device *netdev, u8 key_index,
-		   bool pairwise, const u8 *mac_addr, void *cookie,
+static int get_key(struct wiphy *wiphy, struct net_device *netdev, int link_id,
+		   u8 key_index, bool pairwise, const u8 *mac_addr,
+		   void *cookie,
 		   void (*callback)(void *cookie, struct key_params *))
 {
 	struct wilc_vif *vif = netdev_priv(netdev);
@@ -723,13 +725,14 @@ static int get_key(struct wiphy *wiphy, struct net_device *netdev, u8 key_index,
 
 /* wiphy_new_nm() will WARNON if not present */
 static int set_default_key(struct wiphy *wiphy, struct net_device *netdev,
-			   u8 key_index, bool unicast, bool multicast)
+			   int link_id, u8 key_index, bool unicast,
+			   bool multicast)
 {
 	return 0;
 }
 
 static int set_default_mgmt_key(struct wiphy *wiphy, struct net_device *netdev,
-				u8 key_index)
+				int link_id, u8 key_index)
 {
 	struct wilc_vif *vif = netdev_priv(netdev);
 
diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index 1593e810b3ca..832dd00991f3 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -532,8 +532,8 @@ qtnf_dump_station(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int qtnf_add_key(struct wiphy *wiphy, struct net_device *dev,
-			u8 key_index, bool pairwise, const u8 *mac_addr,
-			struct key_params *params)
+			int link_id, u8 key_index, bool pairwise,
+			const u8 *mac_addr, struct key_params *params)
 {
 	struct qtnf_vif *vif = qtnf_netdev_get_priv(dev);
 	int ret;
@@ -548,7 +548,8 @@ static int qtnf_add_key(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int qtnf_del_key(struct wiphy *wiphy, struct net_device *dev,
-			u8 key_index, bool pairwise, const u8 *mac_addr)
+			int link_id, u8 key_index, bool pairwise,
+			const u8 *mac_addr)
 {
 	struct qtnf_vif *vif = qtnf_netdev_get_priv(dev);
 	int ret;
@@ -569,7 +570,8 @@ static int qtnf_del_key(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int qtnf_set_default_key(struct wiphy *wiphy, struct net_device *dev,
-				u8 key_index, bool unicast, bool multicast)
+				int link_id, u8 key_index, bool unicast,
+				bool multicast)
 {
 	struct qtnf_vif *vif = qtnf_netdev_get_priv(dev);
 	int ret;
@@ -585,7 +587,7 @@ static int qtnf_set_default_key(struct wiphy *wiphy, struct net_device *dev,
 
 static int
 qtnf_set_default_mgmt_key(struct wiphy *wiphy, struct net_device *dev,
-			  u8 key_index)
+			  int link_id, u8 key_index)
 {
 	struct qtnf_vif *vif = qtnf_netdev_get_priv(dev);
 	int ret;
diff --git a/drivers/net/wireless/rndis_wlan.c b/drivers/net/wireless/rndis_wlan.c
index 05524291d60c..325933217b41 100644
--- a/drivers/net/wireless/rndis_wlan.c
+++ b/drivers/net/wireless/rndis_wlan.c
@@ -489,14 +489,16 @@ static int rndis_join_ibss(struct wiphy *wiphy, struct net_device *dev,
 static int rndis_leave_ibss(struct wiphy *wiphy, struct net_device *dev);
 
 static int rndis_add_key(struct wiphy *wiphy, struct net_device *netdev,
-			 u8 key_index, bool pairwise, const u8 *mac_addr,
-			 struct key_params *params);
+			 int link_id,  u8 key_index, bool pairwise,
+			 const u8 *mac_addr, struct key_params *params);
 
 static int rndis_del_key(struct wiphy *wiphy, struct net_device *netdev,
-			 u8 key_index, bool pairwise, const u8 *mac_addr);
+			 int link_id, u8 key_index, bool pairwise,
+			 const u8 *mac_addr);
 
 static int rndis_set_default_key(struct wiphy *wiphy, struct net_device *netdev,
-				 u8 key_index, bool unicast, bool multicast);
+				 int link_id, u8 key_index, bool unicast,
+				 bool multicast);
 
 static int rndis_get_station(struct wiphy *wiphy, struct net_device *dev,
 			     const u8 *mac, struct station_info *sinfo);
@@ -2377,8 +2379,8 @@ static int rndis_leave_ibss(struct wiphy *wiphy, struct net_device *dev)
 }
 
 static int rndis_add_key(struct wiphy *wiphy, struct net_device *netdev,
-			 u8 key_index, bool pairwise, const u8 *mac_addr,
-			 struct key_params *params)
+			 int link_id,  u8 key_index, bool pairwise,
+			 const u8 *mac_addr, struct key_params *params)
 {
 	struct rndis_wlan_private *priv = wiphy_priv(wiphy);
 	struct usbnet *usbdev = priv->usbdev;
@@ -2413,7 +2415,8 @@ static int rndis_add_key(struct wiphy *wiphy, struct net_device *netdev,
 }
 
 static int rndis_del_key(struct wiphy *wiphy, struct net_device *netdev,
-			 u8 key_index, bool pairwise, const u8 *mac_addr)
+			 int link_id, u8 key_index, bool pairwise,
+			 const u8 *mac_addr)
 {
 	struct rndis_wlan_private *priv = wiphy_priv(wiphy);
 	struct usbnet *usbdev = priv->usbdev;
@@ -2424,7 +2427,8 @@ static int rndis_del_key(struct wiphy *wiphy, struct net_device *netdev,
 }
 
 static int rndis_set_default_key(struct wiphy *wiphy, struct net_device *netdev,
-				 u8 key_index, bool unicast, bool multicast)
+				 int link_id, u8 key_index, bool unicast,
+				 bool multicast)
 {
 	struct rndis_wlan_private *priv = wiphy_priv(wiphy);
 	struct usbnet *usbdev = priv->usbdev;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index cf35125b7891..1632a2654cc5 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -901,8 +901,8 @@ static int rtw_cfg80211_set_encryption(struct net_device *dev, struct ieee_param
 }
 
 static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
-				u8 key_index, bool pairwise, const u8 *mac_addr,
-				struct key_params *params)
+				int link_id, u8 key_index, bool pairwise,
+				const u8 *mac_addr, struct key_params *params)
 {
 	char *alg_name;
 	u32 param_len;
@@ -993,8 +993,8 @@ static int cfg80211_rtw_add_key(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static int cfg80211_rtw_get_key(struct wiphy *wiphy, struct net_device *ndev,
-				u8 key_index, bool pairwise, const u8 *mac_addr,
-				void *cookie,
+				int link_id, u8 key_index, bool pairwise,
+				const u8 *mac_addr, void *cookie,
 				void (*callback)(void *cookie,
 						 struct key_params*))
 {
@@ -1002,7 +1002,8 @@ static int cfg80211_rtw_get_key(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static int cfg80211_rtw_del_key(struct wiphy *wiphy, struct net_device *ndev,
-				u8 key_index, bool pairwise, const u8 *mac_addr)
+				int link_id, u8 key_index, bool pairwise,
+				const u8 *mac_addr)
 {
 	struct adapter *padapter = rtw_netdev_priv(ndev);
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
@@ -1017,7 +1018,7 @@ static int cfg80211_rtw_del_key(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static int cfg80211_rtw_set_default_key(struct wiphy *wiphy,
-	struct net_device *ndev, u8 key_index
+	struct net_device *ndev, int link_id, u8 key_index
 	, bool unicast, bool multicast
 	)
 {
diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index b7b56d8406d1..471bb310176f 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -143,8 +143,8 @@ static int prism2_change_virtual_intf(struct wiphy *wiphy,
 }
 
 static int prism2_add_key(struct wiphy *wiphy, struct net_device *dev,
-			  u8 key_index, bool pairwise, const u8 *mac_addr,
-			  struct key_params *params)
+			  int link_id, u8 key_index, bool pairwise,
+			  const u8 *mac_addr, struct key_params *params)
 {
 	struct wlandevice *wlandev = dev->ml_priv;
 	u32 did;
@@ -172,7 +172,7 @@ static int prism2_add_key(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int prism2_get_key(struct wiphy *wiphy, struct net_device *dev,
-			  u8 key_index, bool pairwise,
+			  int link_id, u8 key_index, bool pairwise,
 			  const u8 *mac_addr, void *cookie,
 			  void (*callback)(void *cookie, struct key_params*))
 {
@@ -202,7 +202,8 @@ static int prism2_get_key(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int prism2_del_key(struct wiphy *wiphy, struct net_device *dev,
-			  u8 key_index, bool pairwise, const u8 *mac_addr)
+			  int link_id, u8 key_index, bool pairwise,
+			  const u8 *mac_addr)
 {
 	struct wlandevice *wlandev = dev->ml_priv;
 	u32 did;
@@ -227,7 +228,8 @@ static int prism2_del_key(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int prism2_set_default_key(struct wiphy *wiphy, struct net_device *dev,
-				  u8 key_index, bool unicast, bool multicast)
+				  int link_id, u8 key_index, bool unicast,
+				  bool multicast)
 {
 	struct wlandevice *wlandev = dev->ml_priv;
 
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 908d58393484..9f34b56153b5 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3929,22 +3929,33 @@ struct mgmt_frame_regs {
  * @del_intf_link: Remove an MLO link from the given interface.
  *
  * @add_key: add a key with the given parameters. @mac_addr will be %NULL
- *	when adding a group key.
+ *	when adding a group key. @link_id will be -1 for non-MLO connection.
+ *	For MLO connection, @link_id will be >= 0 for group key and -1 for
+ *	pairwise key, @mac_addr will be peer's MLD address for MLO pairwise key.
  *
  * @get_key: get information about the key with the given parameters.
  *	@mac_addr will be %NULL when requesting information for a group
  *	key. All pointers given to the @callback function need not be valid
  *	after it returns. This function should return an error if it is
  *	not possible to retrieve the key, -ENOENT if it doesn't exist.
+ *	@link_id will be -1 for non-MLO connection. For MLO connection,
+ *	@link_id will be >= 0 for group key and -1 for pairwise key, @mac_addr
+ *	will be peer's MLD address for MLO pairwise key.
  *
  * @del_key: remove a key given the @mac_addr (%NULL for a group key)
- *	and @key_index, return -ENOENT if the key doesn't exist.
+ *	and @key_index, return -ENOENT if the key doesn't exist. @link_id will
+ *	be -1 for non-MLO connection. For MLO connection, @link_id will be >= 0
+ *	for group key and -1 for pairwise key, @mac_addr will be peer's MLD
+ *	address for MLO pairwise key.
  *
- * @set_default_key: set the default key on an interface
+ * @set_default_key: set the default key on an interface. @link_id will be >= 0
+ *	for MLO connection and -1 for non-MLO connection.
  *
- * @set_default_mgmt_key: set the default management frame key on an interface
+ * @set_default_mgmt_key: set the default management frame key on an interface.
+ *	@link_id will be >= 0 for MLO connection and -1 for non-MLO connection.
  *
- * @set_default_beacon_key: set the default Beacon frame key on an interface
+ * @set_default_beacon_key: set the default Beacon frame key on an interface.
+ *	@link_id will be >= 0 for MLO connection and -1 for non-MLO connection.
  *
  * @set_rekey_data: give the data necessary for GTK rekeying to the driver
  *
@@ -4293,22 +4304,24 @@ struct cfg80211_ops {
 				 unsigned int link_id);
 
 	int	(*add_key)(struct wiphy *wiphy, struct net_device *netdev,
-			   u8 key_index, bool pairwise, const u8 *mac_addr,
-			   struct key_params *params);
+			   int link_id, u8 key_index, bool pairwise,
+			   const u8 *mac_addr, struct key_params *params);
 	int	(*get_key)(struct wiphy *wiphy, struct net_device *netdev,
-			   u8 key_index, bool pairwise, const u8 *mac_addr,
-			   void *cookie,
+			   int link_id, u8 key_index, bool pairwise,
+			   const u8 *mac_addr, void *cookie,
 			   void (*callback)(void *cookie, struct key_params*));
 	int	(*del_key)(struct wiphy *wiphy, struct net_device *netdev,
-			   u8 key_index, bool pairwise, const u8 *mac_addr);
+			   int link_id, u8 key_index, bool pairwise,
+			   const u8 *mac_addr);
 	int	(*set_default_key)(struct wiphy *wiphy,
-				   struct net_device *netdev,
+				   struct net_device *netdev, int link_id,
 				   u8 key_index, bool unicast, bool multicast);
 	int	(*set_default_mgmt_key)(struct wiphy *wiphy,
-					struct net_device *netdev,
+					struct net_device *netdev, int link_id,
 					u8 key_index);
 	int	(*set_default_beacon_key)(struct wiphy *wiphy,
 					  struct net_device *netdev,
+					  int link_id,
 					  u8 key_index);
 
 	int	(*start_ap)(struct wiphy *wiphy, struct net_device *dev,
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index ffb7c573e299..573db20403dc 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -377,14 +377,22 @@
  *	the non-transmitting interfaces are deleted as well.
  *
  * @NL80211_CMD_GET_KEY: Get sequence counter information for a key specified
- *	by %NL80211_ATTR_KEY_IDX and/or %NL80211_ATTR_MAC.
+ *	by %NL80211_ATTR_KEY_IDX and/or %NL80211_ATTR_MAC. %NL80211_ATTR_MAC
+ *	represents peer's MLD address for MLO pairwise key. For MLO group key,
+ *	the link is identified by %NL80211_ATTR_MLO_LINK_ID.
  * @NL80211_CMD_SET_KEY: Set key attributes %NL80211_ATTR_KEY_DEFAULT,
  *	%NL80211_ATTR_KEY_DEFAULT_MGMT, or %NL80211_ATTR_KEY_THRESHOLD.
+ *	For MLO connection, the link to set default key is identified by
+ *	%NL80211_ATTR_MLO_LINK_ID.
  * @NL80211_CMD_NEW_KEY: add a key with given %NL80211_ATTR_KEY_DATA,
  *	%NL80211_ATTR_KEY_IDX, %NL80211_ATTR_MAC, %NL80211_ATTR_KEY_CIPHER,
- *	and %NL80211_ATTR_KEY_SEQ attributes.
+ *	and %NL80211_ATTR_KEY_SEQ attributes. %NL80211_ATTR_MAC represents
+ *	peer's MLD address for MLO pairwise key. The link to add MLO
+ *	group key is identified by %NL80211_ATTR_MLO_LINK_ID.
  * @NL80211_CMD_DEL_KEY: delete a key identified by %NL80211_ATTR_KEY_IDX
- *	or %NL80211_ATTR_MAC.
+ *	or %NL80211_ATTR_MAC. %NL80211_ATTR_MAC represents peer's MLD address
+ *	for MLO pairwise key. The link to delete group key is identified by
+ *	%NL80211_ATTR_MLO_LINK_ID.
  *
  * @NL80211_CMD_GET_BEACON: (not used)
  * @NL80211_CMD_SET_BEACON: change the beacon on an access point interface
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index a4f6971b7a19..2aa3a044a12e 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -434,8 +434,8 @@ static int ieee80211_set_tx(struct ieee80211_sub_if_data *sdata,
 }
 
 static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
-			     u8 key_idx, bool pairwise, const u8 *mac_addr,
-			     struct key_params *params)
+			     int link_id, u8 key_idx, bool pairwise,
+			     const u8 *mac_addr, struct key_params *params)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
@@ -578,7 +578,8 @@ ieee80211_lookup_key(struct ieee80211_sub_if_data *sdata,
 }
 
 static int ieee80211_del_key(struct wiphy *wiphy, struct net_device *dev,
-			     u8 key_idx, bool pairwise, const u8 *mac_addr)
+			     int link_id, u8 key_idx, bool pairwise,
+			     const u8 *mac_addr)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
@@ -605,8 +606,8 @@ static int ieee80211_del_key(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int ieee80211_get_key(struct wiphy *wiphy, struct net_device *dev,
-			     u8 key_idx, bool pairwise, const u8 *mac_addr,
-			     void *cookie,
+			     int link_id, u8 key_idx, bool pairwise,
+			     const u8 *mac_addr, void *cookie,
 			     void (*callback)(void *cookie,
 					      struct key_params *params))
 {
@@ -711,7 +712,7 @@ static int ieee80211_get_key(struct wiphy *wiphy, struct net_device *dev,
 
 static int ieee80211_config_default_key(struct wiphy *wiphy,
 					struct net_device *dev,
-					u8 key_idx, bool uni,
+					int link_id, u8 key_idx, bool uni,
 					bool multi)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
@@ -723,7 +724,7 @@ static int ieee80211_config_default_key(struct wiphy *wiphy,
 
 static int ieee80211_config_default_mgmt_key(struct wiphy *wiphy,
 					     struct net_device *dev,
-					     u8 key_idx)
+					     int link_id, u8 key_idx)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 
@@ -734,7 +735,7 @@ static int ieee80211_config_default_mgmt_key(struct wiphy *wiphy,
 
 static int ieee80211_config_default_beacon_key(struct wiphy *wiphy,
 					       struct net_device *dev,
-					       u8 key_idx)
+					       int link_id, u8 key_idx)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 
diff --git a/net/wireless/ibss.c b/net/wireless/ibss.c
index 4935f94d1acc..edd062f104f4 100644
--- a/net/wireless/ibss.c
+++ b/net/wireless/ibss.c
@@ -171,7 +171,7 @@ static void __cfg80211_clear_ibss(struct net_device *dev, bool nowext)
 	 */
 	if (rdev->ops->del_key)
 		for (i = 0; i < 6; i++)
-			rdev_del_key(rdev, dev, i, false, NULL);
+			rdev_del_key(rdev, dev, -1, i, false, NULL);
 
 	if (wdev->u.ibss.current_bss) {
 		cfg80211_unhold_bss(wdev->u.ibss.current_bss);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2705e3ee8fc4..7a97181a4539 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1545,7 +1545,6 @@ static int nl80211_key_allowed(struct wireless_dev *wdev)
 		return -ENOLINK;
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
-		/* for MLO, require driver validation of the link ID */
 		if (wdev->connected)
 			return 0;
 		return -ENOLINK;
@@ -4320,6 +4319,38 @@ static int nl80211_set_noack_map(struct sk_buff *skb, struct genl_info *info)
 	return rdev_set_noack_map(rdev, dev, noack_map);
 }
 
+static int nl80211_validate_key_link_id(struct genl_info *info,
+					struct wireless_dev *wdev,
+					int link_id, bool pairwise)
+{
+	if (pairwise) {
+		if (link_id != -1) {
+			GENL_SET_ERR_MSG(info,
+					 "link ID not allowed for pairwise key");
+			return -EINVAL;
+		}
+
+		return 0;
+	}
+
+	if (wdev->valid_links) {
+		if (link_id == -1) {
+			GENL_SET_ERR_MSG(info,
+					 "link ID must for MLO group key");
+			return -EINVAL;
+		}
+		if (!(wdev->valid_links & BIT(link_id))) {
+			GENL_SET_ERR_MSG(info, "invalid link ID for MLO group key");
+			return -EINVAL;
+		}
+	} else if (link_id != -1) {
+		GENL_SET_ERR_MSG(info, "link ID not allowed for non-MLO group key");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 struct get_key_cookie {
 	struct sk_buff *msg;
 	int error;
@@ -4381,13 +4412,15 @@ static int nl80211_get_key(struct sk_buff *skb, struct genl_info *info)
 	void *hdr;
 	struct sk_buff *msg;
 	bool bigtk_support = false;
+	int link_id = nl80211_link_id_or_invalid(info->attrs);
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
 
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
@@ -4439,8 +4472,12 @@ static int nl80211_get_key(struct sk_buff *skb, struct genl_info *info)
 	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, mac_addr))
 		goto nla_put_failure;
 
-	err = rdev_get_key(rdev, dev, key_idx, pairwise, mac_addr, &cookie,
-			   get_key_callback);
+	err = nl80211_validate_key_link_id(info, wdev, link_id, pairwise);
+	if (err)
+		goto free_msg;
+
+	err = rdev_get_key(rdev, dev, link_id, key_idx, pairwise, mac_addr,
+			   &cookie, get_key_callback);
 
 	if (err)
 		goto free_msg;
@@ -4464,6 +4501,8 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 	struct key_parse key;
 	int err;
 	struct net_device *dev = info->user_ptr[1];
+	int link_id = nl80211_link_id_or_invalid(info->attrs);
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
 
 	err = nl80211_parse_key(info, &key);
 	if (err)
@@ -4479,7 +4518,7 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 	    !(key.p.mode == NL80211_KEY_SET_TX))
 		return -EINVAL;
 
-	wdev_lock(dev->ieee80211_ptr);
+	wdev_lock(wdev);
 
 	if (key.def) {
 		if (!rdev->ops->set_default_key) {
@@ -4487,18 +4526,22 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 		}
 
-		err = nl80211_key_allowed(dev->ieee80211_ptr);
+		err = nl80211_key_allowed(wdev);
+		if (err)
+			goto out;
+
+		err = nl80211_validate_key_link_id(info, wdev, link_id, false);
 		if (err)
 			goto out;
 
-		err = rdev_set_default_key(rdev, dev, key.idx,
-						 key.def_uni, key.def_multi);
+		err = rdev_set_default_key(rdev, dev, link_id, key.idx,
+					   key.def_uni, key.def_multi);
 
 		if (err)
 			goto out;
 
 #ifdef CONFIG_CFG80211_WEXT
-		dev->ieee80211_ptr->wext.default_key = key.idx;
+		wdev->wext.default_key = key.idx;
 #endif
 	} else if (key.defmgmt) {
 		if (key.def_uni || !key.def_multi) {
@@ -4511,16 +4554,20 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 		}
 
-		err = nl80211_key_allowed(dev->ieee80211_ptr);
+		err = nl80211_key_allowed(wdev);
+		if (err)
+			goto out;
+
+		err = nl80211_validate_key_link_id(info, wdev, link_id, false);
 		if (err)
 			goto out;
 
-		err = rdev_set_default_mgmt_key(rdev, dev, key.idx);
+		err = rdev_set_default_mgmt_key(rdev, dev, link_id, key.idx);
 		if (err)
 			goto out;
 
 #ifdef CONFIG_CFG80211_WEXT
-		dev->ieee80211_ptr->wext.default_mgmt_key = key.idx;
+		wdev->wext.default_mgmt_key = key.idx;
 #endif
 	} else if (key.defbeacon) {
 		if (key.def_uni || !key.def_multi) {
@@ -4533,11 +4580,15 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 		}
 
-		err = nl80211_key_allowed(dev->ieee80211_ptr);
+		err = nl80211_key_allowed(wdev);
+		if (err)
+			goto out;
+
+		err = nl80211_validate_key_link_id(info, wdev, link_id, false);
 		if (err)
 			goto out;
 
-		err = rdev_set_default_beacon_key(rdev, dev, key.idx);
+		err = rdev_set_default_beacon_key(rdev, dev, link_id, key.idx);
 		if (err)
 			goto out;
 	} else if (key.p.mode == NL80211_KEY_SET_TX &&
@@ -4553,14 +4604,18 @@ static int nl80211_set_key(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 		}
 
-		err = rdev_add_key(rdev, dev, key.idx,
+		err = nl80211_validate_key_link_id(info, wdev, link_id, true);
+		if (err)
+			goto out;
+
+		err = rdev_add_key(rdev, dev, link_id, key.idx,
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
@@ -4572,6 +4627,8 @@ static int nl80211_new_key(struct sk_buff *skb, struct genl_info *info)
 	struct net_device *dev = info->user_ptr[1];
 	struct key_parse key;
 	const u8 *mac_addr = NULL;
+	int link_id = nl80211_link_id_or_invalid(info->attrs);
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
 
 	err = nl80211_parse_key(info, &key);
 	if (err)
@@ -4613,18 +4670,23 @@ static int nl80211_new_key(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 
-	wdev_lock(dev->ieee80211_ptr);
-	err = nl80211_key_allowed(dev->ieee80211_ptr);
+	wdev_lock(wdev);
+	err = nl80211_key_allowed(wdev);
 	if (err)
 		GENL_SET_ERR_MSG(info, "key not allowed");
+
+	if (!err)
+		err = nl80211_validate_key_link_id(info, wdev, link_id,
+				key.type == NL80211_KEYTYPE_PAIRWISE);
+
 	if (!err) {
-		err = rdev_add_key(rdev, dev, key.idx,
+		err = rdev_add_key(rdev, dev, link_id, key.idx,
 				   key.type == NL80211_KEYTYPE_PAIRWISE,
 				    mac_addr, &key.p);
 		if (err)
 			GENL_SET_ERR_MSG(info, "key addition failed");
 	}
-	wdev_unlock(dev->ieee80211_ptr);
+	wdev_unlock(wdev);
 
 	return err;
 }
@@ -4636,6 +4698,8 @@ static int nl80211_del_key(struct sk_buff *skb, struct genl_info *info)
 	struct net_device *dev = info->user_ptr[1];
 	u8 *mac_addr = NULL;
 	struct key_parse key;
+	int link_id = nl80211_link_id_or_invalid(info->attrs);
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
 
 	err = nl80211_parse_key(info, &key);
 	if (err)
@@ -4663,27 +4727,31 @@ static int nl80211_del_key(struct sk_buff *skb, struct genl_info *info)
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
+		err = nl80211_validate_key_link_id(info, wdev, link_id,
+				key.type == NL80211_KEYTYPE_PAIRWISE);
+
+	if (!err)
+		err = rdev_del_key(rdev, dev, link_id, key.idx,
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
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 40915a82da73..13b209a8db28 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -77,65 +77,69 @@ rdev_change_virtual_intf(struct cfg80211_registered_device *rdev,
 }
 
 static inline int rdev_add_key(struct cfg80211_registered_device *rdev,
-			       struct net_device *netdev, u8 key_index,
-			       bool pairwise, const u8 *mac_addr,
+			       struct net_device *netdev, int link_id,
+			       u8 key_index, bool pairwise, const u8 *mac_addr,
 			       struct key_params *params)
 {
 	int ret;
-	trace_rdev_add_key(&rdev->wiphy, netdev, key_index, pairwise,
+	trace_rdev_add_key(&rdev->wiphy, netdev, link_id, key_index, pairwise,
 			   mac_addr, params->mode);
-	ret = rdev->ops->add_key(&rdev->wiphy, netdev, key_index, pairwise,
-				  mac_addr, params);
+	ret = rdev->ops->add_key(&rdev->wiphy, netdev, link_id, key_index,
+				  pairwise, mac_addr, params);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
 
 static inline int
 rdev_get_key(struct cfg80211_registered_device *rdev, struct net_device *netdev,
-	     u8 key_index, bool pairwise, const u8 *mac_addr, void *cookie,
+	     int link_id, u8 key_index, bool pairwise, const u8 *mac_addr,
+	     void *cookie,
 	     void (*callback)(void *cookie, struct key_params*))
 {
 	int ret;
-	trace_rdev_get_key(&rdev->wiphy, netdev, key_index, pairwise, mac_addr);
-	ret = rdev->ops->get_key(&rdev->wiphy, netdev, key_index, pairwise,
-				  mac_addr, cookie, callback);
+	trace_rdev_get_key(&rdev->wiphy, netdev, link_id, key_index, pairwise,
+			   mac_addr);
+	ret = rdev->ops->get_key(&rdev->wiphy, netdev, link_id, key_index,
+				  pairwise, mac_addr, cookie, callback);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
 
 static inline int rdev_del_key(struct cfg80211_registered_device *rdev,
-			       struct net_device *netdev, u8 key_index,
-			       bool pairwise, const u8 *mac_addr)
+			       struct net_device *netdev, int link_id,
+			       u8 key_index, bool pairwise, const u8 *mac_addr)
 {
 	int ret;
-	trace_rdev_del_key(&rdev->wiphy, netdev, key_index, pairwise, mac_addr);
-	ret = rdev->ops->del_key(&rdev->wiphy, netdev, key_index, pairwise,
-				  mac_addr);
+	trace_rdev_del_key(&rdev->wiphy, netdev, link_id, key_index, pairwise,
+			   mac_addr);
+	ret = rdev->ops->del_key(&rdev->wiphy, netdev, link_id, key_index,
+				  pairwise, mac_addr);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
 
 static inline int
 rdev_set_default_key(struct cfg80211_registered_device *rdev,
-		     struct net_device *netdev, u8 key_index, bool unicast,
-		     bool multicast)
+		     struct net_device *netdev, int link_id, u8 key_index,
+		     bool unicast, bool multicast)
 {
 	int ret;
-	trace_rdev_set_default_key(&rdev->wiphy, netdev, key_index,
+	trace_rdev_set_default_key(&rdev->wiphy, netdev, link_id, key_index,
 				   unicast, multicast);
-	ret = rdev->ops->set_default_key(&rdev->wiphy, netdev, key_index,
-					  unicast, multicast);
+	ret = rdev->ops->set_default_key(&rdev->wiphy, netdev, link_id,
+					  key_index, unicast, multicast);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
 
 static inline int
 rdev_set_default_mgmt_key(struct cfg80211_registered_device *rdev,
-			  struct net_device *netdev, u8 key_index)
+			  struct net_device *netdev, int link_id, u8 key_index)
 {
 	int ret;
-	trace_rdev_set_default_mgmt_key(&rdev->wiphy, netdev, key_index);
-	ret = rdev->ops->set_default_mgmt_key(&rdev->wiphy, netdev,
+	trace_rdev_set_default_mgmt_key(&rdev->wiphy, netdev, link_id,
+					key_index);
+	ret = rdev->ops->set_default_mgmt_key(&rdev->wiphy, netdev, link_id,
 					       key_index);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
@@ -143,13 +147,15 @@ rdev_set_default_mgmt_key(struct cfg80211_registered_device *rdev,
 
 static inline int
 rdev_set_default_beacon_key(struct cfg80211_registered_device *rdev,
-			    struct net_device *netdev, u8 key_index)
+			    struct net_device *netdev, int link_id,
+			    u8 key_index)
 {
 	int ret;
 
-	trace_rdev_set_default_beacon_key(&rdev->wiphy, netdev, key_index);
-	ret = rdev->ops->set_default_beacon_key(&rdev->wiphy, netdev,
-						key_index);
+	trace_rdev_set_default_beacon_key(&rdev->wiphy, netdev, link_id,
+					  key_index);
+	ret = rdev->ops->set_default_beacon_key(&rdev->wiphy, netdev, link_id,
+						 key_index);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 34d27a3070f0..0a5c95631f78 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1326,7 +1326,7 @@ void __cfg80211_disconnected(struct net_device *dev, const u8 *ie,
 			    NL80211_EXT_FEATURE_BEACON_PROTECTION_CLIENT))
 			max_key_idx = 7;
 		for (i = 0; i <= max_key_idx; i++)
-			rdev_del_key(rdev, dev, i, false, NULL);
+			rdev_del_key(rdev, dev, -1, i, false, NULL);
 	}
 
 	rdev_set_qos_map(rdev, dev, NULL);
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 10b2fd9bacb5..001c00d9c5e7 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -434,13 +434,14 @@ TRACE_EVENT(rdev_change_virtual_intf,
 );
 
 DECLARE_EVENT_CLASS(key_handle,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, u8 key_index,
-		 bool pairwise, const u8 *mac_addr),
-	TP_ARGS(wiphy, netdev, key_index, pairwise, mac_addr),
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, int link_id,
+		 u8 key_index, bool pairwise, const u8 *mac_addr),
+	TP_ARGS(wiphy, netdev, link_id, key_index, pairwise, mac_addr),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
 		MAC_ENTRY(mac_addr)
+		__field(int, link_id)
 		__field(u8, key_index)
 		__field(bool, pairwise)
 	),
@@ -448,34 +449,38 @@ DECLARE_EVENT_CLASS(key_handle,
 		WIPHY_ASSIGN;
 		NETDEV_ASSIGN;
 		MAC_ASSIGN(mac_addr, mac_addr);
+		__entry->link_id = link_id;
 		__entry->key_index = key_index;
 		__entry->pairwise = pairwise;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", key_index: %u, pairwise: %s, mac addr: " MAC_PR_FMT,
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->key_index,
-		  BOOL_TO_STR(__entry->pairwise), MAC_PR_ARG(mac_addr))
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %d, "
+		  "key_index: %u, pairwise: %s, mac addr: " MAC_PR_FMT,
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->link_id,
+		  __entry->key_index, BOOL_TO_STR(__entry->pairwise),
+		  MAC_PR_ARG(mac_addr))
 );
 
 DEFINE_EVENT(key_handle, rdev_get_key,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, u8 key_index,
-		 bool pairwise, const u8 *mac_addr),
-	TP_ARGS(wiphy, netdev, key_index, pairwise, mac_addr)
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, int link_id,
+		 u8 key_index, bool pairwise, const u8 *mac_addr),
+	TP_ARGS(wiphy, netdev, link_id, key_index, pairwise, mac_addr)
 );
 
 DEFINE_EVENT(key_handle, rdev_del_key,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, u8 key_index,
-		 bool pairwise, const u8 *mac_addr),
-	TP_ARGS(wiphy, netdev, key_index, pairwise, mac_addr)
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, int link_id,
+		 u8 key_index, bool pairwise, const u8 *mac_addr),
+	TP_ARGS(wiphy, netdev, link_id, key_index, pairwise, mac_addr)
 );
 
 TRACE_EVENT(rdev_add_key,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, u8 key_index,
-		 bool pairwise, const u8 *mac_addr, u8 mode),
-	TP_ARGS(wiphy, netdev, key_index, pairwise, mac_addr, mode),
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, int link_id,
+		 u8 key_index, bool pairwise, const u8 *mac_addr, u8 mode),
+	TP_ARGS(wiphy, netdev, link_id, key_index, pairwise, mac_addr, mode),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
 		MAC_ENTRY(mac_addr)
+		__field(int, link_id)
 		__field(u8, key_index)
 		__field(bool, pairwise)
 		__field(u8, mode)
@@ -484,24 +489,27 @@ TRACE_EVENT(rdev_add_key,
 		WIPHY_ASSIGN;
 		NETDEV_ASSIGN;
 		MAC_ASSIGN(mac_addr, mac_addr);
+		__entry->link_id = link_id;
 		__entry->key_index = key_index;
 		__entry->pairwise = pairwise;
 		__entry->mode = mode;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", key_index: %u, "
-		  "mode: %u, pairwise: %s, mac addr: " MAC_PR_FMT,
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->key_index,
-		  __entry->mode, BOOL_TO_STR(__entry->pairwise),
-		  MAC_PR_ARG(mac_addr))
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %d, "
+		  "key_index: %u, mode: %u, pairwise: %s, "
+		  "mac addr: " MAC_PR_FMT,
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->link_id,
+		  __entry->key_index, __entry->mode,
+		  BOOL_TO_STR(__entry->pairwise), MAC_PR_ARG(mac_addr))
 );
 
 TRACE_EVENT(rdev_set_default_key,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, u8 key_index,
-		 bool unicast, bool multicast),
-	TP_ARGS(wiphy, netdev, key_index, unicast, multicast),
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, int link_id,
+		 u8 key_index, bool unicast, bool multicast),
+	TP_ARGS(wiphy, netdev, link_id, key_index, unicast, multicast),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
+		__field(int, link_id)
 		__field(u8, key_index)
 		__field(bool, unicast)
 		__field(bool, multicast)
@@ -509,48 +517,58 @@ TRACE_EVENT(rdev_set_default_key,
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		NETDEV_ASSIGN;
+		__entry->link_id = link_id;
 		__entry->key_index = key_index;
 		__entry->unicast = unicast;
 		__entry->multicast = multicast;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", key index: %u, unicast: %s, multicast: %s",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->key_index,
-		  BOOL_TO_STR(__entry->unicast),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %d, "
+		  "key index: %u, unicast: %s, multicast: %s",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->link_id,
+		  __entry->key_index, BOOL_TO_STR(__entry->unicast),
 		  BOOL_TO_STR(__entry->multicast))
 );
 
 TRACE_EVENT(rdev_set_default_mgmt_key,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, u8 key_index),
-	TP_ARGS(wiphy, netdev, key_index),
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, int link_id,
+		 u8 key_index),
+	TP_ARGS(wiphy, netdev, link_id, key_index),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
+		__field(int, link_id)
 		__field(u8, key_index)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		NETDEV_ASSIGN;
+		__entry->link_id = link_id;
 		__entry->key_index = key_index;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", key index: %u",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->key_index)
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %d, "
+		  "key index: %u", WIPHY_PR_ARG, NETDEV_PR_ARG,
+		  __entry->link_id, __entry->key_index)
 );
 
 TRACE_EVENT(rdev_set_default_beacon_key,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, u8 key_index),
-	TP_ARGS(wiphy, netdev, key_index),
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, int link_id,
+		 u8 key_index),
+	TP_ARGS(wiphy, netdev, link_id, key_index),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
+		__field(int, link_id)
 		__field(u8, key_index)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		NETDEV_ASSIGN;
+		__entry->link_id = link_id;
 		__entry->key_index = key_index;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", key index: %u",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->key_index)
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id: %d, "
+		  "key index: %u", WIPHY_PR_ARG, NETDEV_PR_ARG,
+		  __entry->link_id, __entry->key_index)
 );
 
 TRACE_EVENT(rdev_start_ap,
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 2c127951764a..0b28d00ba8f5 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -935,13 +935,13 @@ void cfg80211_upload_connect_keys(struct wireless_dev *wdev)
 	for (i = 0; i < CFG80211_MAX_WEP_KEYS; i++) {
 		if (!wdev->connect_keys->params[i].cipher)
 			continue;
-		if (rdev_add_key(rdev, dev, i, false, NULL,
+		if (rdev_add_key(rdev, dev, -1, i, false, NULL,
 				 &wdev->connect_keys->params[i])) {
 			netdev_err(dev, "failed to set key %d\n", i);
 			continue;
 		}
 		if (wdev->connect_keys->def == i &&
-		    rdev_set_default_key(rdev, dev, i, true, true)) {
+		    rdev_set_default_key(rdev, dev, -1, i, true, true)) {
 			netdev_err(dev, "failed to set defkey %d\n", i);
 			continue;
 		}
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 129d3bb91dfb..ddf340bfa07a 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -470,7 +470,7 @@ static int __cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 			    !(rdev->wiphy.flags & WIPHY_FLAG_IBSS_RSN))
 				err = -ENOENT;
 			else
-				err = rdev_del_key(rdev, dev, idx, pairwise,
+				err = rdev_del_key(rdev, dev, -1, idx, pairwise,
 						   addr);
 		}
 		wdev->wext.connect.privacy = false;
@@ -509,7 +509,7 @@ static int __cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 	if (wdev->connected ||
 	    (wdev->iftype == NL80211_IFTYPE_ADHOC &&
 	     wdev->u.ibss.current_bss))
-		err = rdev_add_key(rdev, dev, idx, pairwise, addr, params);
+		err = rdev_add_key(rdev, dev, -1, idx, pairwise, addr, params);
 	else if (params->cipher != WLAN_CIPHER_SUITE_WEP40 &&
 		 params->cipher != WLAN_CIPHER_SUITE_WEP104)
 		return -EINVAL;
@@ -546,7 +546,8 @@ static int __cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 				__cfg80211_leave_ibss(rdev, wdev->netdev, true);
 				rejoin = true;
 			}
-			err = rdev_set_default_key(rdev, dev, idx, true, true);
+			err = rdev_set_default_key(rdev, dev, -1, idx, true,
+						   true);
 		}
 		if (!err) {
 			wdev->wext.default_key = idx;
@@ -561,7 +562,7 @@ static int __cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 		if (wdev->connected ||
 		    (wdev->iftype == NL80211_IFTYPE_ADHOC &&
 		     wdev->u.ibss.current_bss))
-			err = rdev_set_default_mgmt_key(rdev, dev, idx);
+			err = rdev_set_default_mgmt_key(rdev, dev, -1, idx);
 		if (!err)
 			wdev->wext.default_mgmt_key = idx;
 		return err;
@@ -632,7 +633,7 @@ static int cfg80211_wext_siwencode(struct net_device *dev,
 		if (wdev->connected ||
 		    (wdev->iftype == NL80211_IFTYPE_ADHOC &&
 		     wdev->u.ibss.current_bss))
-			err = rdev_set_default_key(rdev, dev, idx, true,
+			err = rdev_set_default_key(rdev, dev, -1, idx, true,
 						   true);
 		if (!err)
 			wdev->wext.default_key = idx;
-- 
2.25.1

