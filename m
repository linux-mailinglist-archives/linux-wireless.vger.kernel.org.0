Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C768A5291F7
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 22:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbiEPUtQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 May 2022 16:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348229AbiEPUsH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 May 2022 16:48:07 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C36D54034
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 13:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652732706; x=1684268706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z8cY0tZfvPvoJnRSr5EuyyXmpD1wFhTuAW9mYAg6VlE=;
  b=XFy37gHamFCiqTnJFTAGzrYGcyF6jtXqp830u28BCsQJmFbtdwkTQt4E
   YXQWxyTlszLJbsBIEzNIOCMnbnlp3/DYTUH0dy4LUd9dsskxjTtZbYXGr
   v/4spHEBq5BHies50KNMe4iAvhXfyFQpILu0daf8PTfqWTLx6bANZ5yM0
   8=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 16 May 2022 13:25:06 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 13:25:06 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 16 May 2022 13:25:05 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 16 May 2022 13:25:05 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v5 3/3] drivers: modify prototype for beacon change functions
Date:   Mon, 16 May 2022 13:24:54 -0700
Message-ID: <20220516202454.4925-4-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220516202454.4925-1-quic_alokad@quicinc.com>
References: <20220516202454.4925-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Modify driver specific functions pointed by change_beacon to
to use struct cfg80211_ap_settings instead of
struct cfg80211_beacon_data.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c                  | 4 ++--
 drivers/net/wireless/ath/wil6210/cfg80211.c                 | 3 ++-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 4 ++--
 drivers/net/wireless/marvell/mwifiex/cfg80211.c             | 3 ++-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c          | 4 ++--
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c           | 4 ++--
 6 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index bd1183830e91..42f289c6d65e 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -2954,7 +2954,7 @@ static int ath6kl_start_ap(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int ath6kl_change_beacon(struct wiphy *wiphy, struct net_device *dev,
-				struct cfg80211_beacon_data *beacon)
+				struct cfg80211_ap_settings *params)
 {
 	struct ath6kl_vif *vif = netdev_priv(dev);
 
@@ -2964,7 +2964,7 @@ static int ath6kl_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	if (vif->next_mode != AP_NETWORK)
 		return -EOPNOTSUPP;
 
-	return ath6kl_set_ies(vif, beacon);
+	return ath6kl_set_ies(vif, &params->beacon);
 }
 
 static int ath6kl_stop_ap(struct wiphy *wiphy, struct net_device *dev)
diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 8f2638f5b87b..360137e59f14 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -2082,11 +2082,12 @@ void wil_cfg80211_ap_recovery(struct wil6210_priv *wil)
 
 static int wil_cfg80211_change_beacon(struct wiphy *wiphy,
 				      struct net_device *ndev,
-				      struct cfg80211_beacon_data *bcon)
+				      struct cfg80211_ap_settings *params)
 {
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
 	struct wireless_dev *wdev = ndev->ieee80211_ptr;
 	struct wil6210_vif *vif = ndev_to_vif(ndev);
+	struct cfg80211_beacon_data *bcon = &params->beacon;
 	int rc;
 	u32 privacy = 0;
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 360b103fe898..9be5ddc7d4da 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5038,14 +5038,14 @@ static int brcmf_cfg80211_stop_ap(struct wiphy *wiphy, struct net_device *ndev)
 
 static s32
 brcmf_cfg80211_change_beacon(struct wiphy *wiphy, struct net_device *ndev,
-			     struct cfg80211_beacon_data *info)
+			     struct cfg80211_ap_settings *info)
 {
 	struct brcmf_if *ifp = netdev_priv(ndev);
 	s32 err;
 
 	brcmf_dbg(TRACE, "Enter\n");
 
-	err = brcmf_config_ap_mgmt_ie(ifp->vif, info);
+	err = brcmf_config_ap_mgmt_ie(ifp->vif, &info->beacon);
 
 	return err;
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 6f23ec34e2e2..856cc8a4d0da 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -1843,10 +1843,11 @@ static int mwifiex_cfg80211_set_cqm_rssi_config(struct wiphy *wiphy,
  */
 static int mwifiex_cfg80211_change_beacon(struct wiphy *wiphy,
 					  struct net_device *dev,
-					  struct cfg80211_beacon_data *data)
+					  struct cfg80211_ap_settings *params)
 {
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 	struct mwifiex_adapter *adapter = priv->adapter;
+	struct cfg80211_beacon_data *data = &params->beacon;
 
 	mwifiex_cancel_scan(adapter);
 
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index 8d8378bafd9b..b356009f1d80 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1371,11 +1371,11 @@ static int start_ap(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int change_beacon(struct wiphy *wiphy, struct net_device *dev,
-			 struct cfg80211_beacon_data *beacon)
+			 struct cfg80211_ap_settings *params)
 {
 	struct wilc_vif *vif = netdev_priv(dev);
 
-	return wilc_add_beacon(vif, 0, 0, beacon);
+	return wilc_add_beacon(vif, 0, 0, &params->beacon);
 }
 
 static int stop_ap(struct wiphy *wiphy, struct net_device *dev)
diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index 84b15a655eab..518a66cef489 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -331,11 +331,11 @@ static int qtnf_mgmt_set_appie(struct qtnf_vif *vif,
 }
 
 static int qtnf_change_beacon(struct wiphy *wiphy, struct net_device *dev,
-			      struct cfg80211_beacon_data *info)
+			      struct cfg80211_ap_settings *info)
 {
 	struct qtnf_vif *vif = qtnf_netdev_get_priv(dev);
 
-	return qtnf_mgmt_set_appie(vif, info);
+	return qtnf_mgmt_set_appie(vif, &info->beacon);
 }
 
 static int qtnf_start_ap(struct wiphy *wiphy, struct net_device *dev,
-- 
2.31.1

