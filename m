Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6C3520803
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 00:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiEIW4v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 May 2022 18:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiEIW4u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 May 2022 18:56:50 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F95718B12A
        for <linux-wireless@vger.kernel.org>; Mon,  9 May 2022 15:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652136774; x=1683672774;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HbTCn3Bh0YEacYduYalRnpLiy9ZFzFYwmU42hQ/LP+M=;
  b=f+Ehjpvxj/aKulYQ0D3jO4TYStlhbT9hUqj2+NbiusUojGkf1U+WQKtB
   LW9f/VdJmIv4mTbVbVvqyevhRFB+GhlhWYnJF9nZqExfPbBs/v7O/N6Tj
   cil46bSlhiLYG1a3J9DTV68B5304XsdQfmTt9vkyThPifNOZlsVlp/nnK
   U=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 09 May 2022 15:52:54 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 15:52:54 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 15:52:53 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 15:52:53 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Aloka Dixit <quic_alokad@quicinc.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4] cfg80211: additional processing in NL80211_CMD_SET_BEACON
Date:   Mon, 9 May 2022 15:52:37 -0700
Message-ID: <20220509225237.15955-1-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
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

FILS discovery and unsolicited broadcast probe response transmissions
are configured as part of NL80211_CMD_START_AP, however both stop
after userspace uses the NL80211_CMD_SET_BEACON command as these
attributes are not processed as part of this command.

- Add the missing implementation in nl80211 and mac80211.
- Modify the local variable in nl80211_set_beacon() and input parameter
to rdev_change_beacon() from type struct cfg80211_beacon_data to
type struct cfg80211_ap_settings to support the new processing.
- Modify ieee80211_change_beacon() to reflect the new input parameter type.
- Modify driver specific functions pointed by change_beacon to
reflect the new input parameter type.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
v4:
- Modifications to all driver specific function pointers.
- Also included all files in a single patch instead of splitting as per
the modules because otherwise compilation fails with changes in only
net/wireless and include/net directories.

 drivers/net/wireless/ath/ath6kl/cfg80211.c    |  4 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  3 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  4 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  3 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |  4 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  4 +-
 include/net/cfg80211.h                        |  2 +-
 net/mac80211/cfg.c                            | 25 +++++++--
 net/wireless/nl80211.c                        | 28 ++++++++--
 net/wireless/rdev-ops.h                       |  2 +-
 net/wireless/trace.h                          | 52 +++++++++++--------
 11 files changed, 89 insertions(+), 42 deletions(-)

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
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 6a3e3f0a8615..16d49226420a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4197,7 +4197,7 @@ struct cfg80211_ops {
 	int	(*start_ap)(struct wiphy *wiphy, struct net_device *dev,
 			    struct cfg80211_ap_settings *settings);
 	int	(*change_beacon)(struct wiphy *wiphy, struct net_device *dev,
-				 struct cfg80211_beacon_data *info);
+				 struct cfg80211_ap_settings *info);
 	int	(*stop_ap)(struct wiphy *wiphy, struct net_device *dev);
 
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f1d211e61e49..22843184d6ee 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1313,11 +1313,12 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
-				   struct cfg80211_beacon_data *params)
+				   struct cfg80211_ap_settings *params)
 {
 	struct ieee80211_sub_if_data *sdata;
 	struct beacon_data *old;
 	int err;
+	u32 changed;
 
 	sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	sdata_assert_lock(sdata);
@@ -1332,10 +1333,28 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	if (!old)
 		return -ENOENT;
 
-	err = ieee80211_assign_beacon(sdata, params, NULL, NULL);
+	err = ieee80211_assign_beacon(sdata, &params->beacon, NULL, NULL);
 	if (err < 0)
 		return err;
-	ieee80211_bss_info_change_notify(sdata, err);
+	changed = err;
+
+	if (params->fils_discovery.max_interval) {
+		err = ieee80211_set_fils_discovery(sdata,
+						   &params->fils_discovery);
+		if (err < 0)
+			return err;
+		changed |= BSS_CHANGED_FILS_DISCOVERY;
+	}
+
+	if (params->unsol_bcast_probe_resp.interval) {
+		err = ieee80211_set_unsol_bcast_probe_resp(sdata,
+							   &params->unsol_bcast_probe_resp);
+		if (err < 0)
+			return err;
+		changed |= BSS_CHANGED_UNSOL_BCAST_PROBE_RESP;
+	}
+
+	ieee80211_bss_info_change_notify(sdata, changed);
 	return 0;
 }
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8b031b8c1abf..d5f2f99cac7f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5809,7 +5809,8 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	struct cfg80211_beacon_data params;
+	struct cfg80211_ap_settings *params;
+	struct nlattr *attrs;
 	int err;
 
 	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP &&
@@ -5822,16 +5823,35 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 	if (!wdev->beacon_interval)
 		return -EINVAL;
 
-	err = nl80211_parse_beacon(rdev, info->attrs, &params);
+	params = kzalloc(sizeof(*params), GFP_KERNEL);
+	if (!params)
+		return -ENOMEM;
+
+	err = nl80211_parse_beacon(rdev, info->attrs, &params->beacon);
 	if (err)
 		goto out;
 
+	attrs = info->attrs[NL80211_ATTR_FILS_DISCOVERY];
+	if (attrs) {
+		err = nl80211_parse_fils_discovery(rdev, attrs, params);
+		if (err)
+			goto out;
+	}
+
+	attrs = info->attrs[NL80211_ATTR_UNSOL_BCAST_PROBE_RESP];
+	if (attrs) {
+		err = nl80211_parse_unsol_bcast_probe_resp(rdev, attrs,	params);
+		if (err)
+			goto out;
+	}
+
 	wdev_lock(wdev);
-	err = rdev_change_beacon(rdev, dev, &params);
+	err = rdev_change_beacon(rdev, dev, params);
 	wdev_unlock(wdev);
 
 out:
-	kfree(params.mbssid_ies);
+	kfree(params->beacon.mbssid_ies);
+	kfree(params);
 	return err;
 }
 
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 439bcf52369c..131fbe9c3199 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -162,7 +162,7 @@ static inline int rdev_start_ap(struct cfg80211_registered_device *rdev,
 
 static inline int rdev_change_beacon(struct cfg80211_registered_device *rdev,
 				     struct net_device *dev,
-				     struct cfg80211_beacon_data *info)
+				     struct cfg80211_ap_settings *info)
 {
 	int ret;
 	trace_rdev_change_beacon(&rdev->wiphy, dev, info);
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 228079d7690a..97ca10cbbfee 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -597,44 +597,50 @@ TRACE_EVENT(rdev_start_ap,
 
 TRACE_EVENT(rdev_change_beacon,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
-		 struct cfg80211_beacon_data *info),
+		 struct cfg80211_ap_settings *info),
 	TP_ARGS(wiphy, netdev, info),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
-		__dynamic_array(u8, head, info ? info->head_len : 0)
-		__dynamic_array(u8, tail, info ? info->tail_len : 0)
-		__dynamic_array(u8, beacon_ies, info ? info->beacon_ies_len : 0)
+		__dynamic_array(u8, head, info ? info->beacon.head_len : 0)
+		__dynamic_array(u8, tail, info ? info->beacon.tail_len : 0)
+		__dynamic_array(u8, beacon_ies,
+				info ? info->beacon.beacon_ies_len : 0)
 		__dynamic_array(u8, proberesp_ies,
-				info ? info->proberesp_ies_len : 0)
+				info ? info->beacon.proberesp_ies_len : 0)
 		__dynamic_array(u8, assocresp_ies,
-				info ? info->assocresp_ies_len : 0)
-		__dynamic_array(u8, probe_resp, info ? info->probe_resp_len : 0)
+				info ? info->beacon.assocresp_ies_len : 0)
+		__dynamic_array(u8, probe_resp,
+				info ? info->beacon.probe_resp_len : 0)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		NETDEV_ASSIGN;
 		if (info) {
-			if (info->head)
-				memcpy(__get_dynamic_array(head), info->head,
-				       info->head_len);
-			if (info->tail)
-				memcpy(__get_dynamic_array(tail), info->tail,
-				       info->tail_len);
-			if (info->beacon_ies)
+			if (info->beacon.head)
+				memcpy(__get_dynamic_array(head),
+				       info->beacon.head,
+				       info->beacon.head_len);
+			if (info->beacon.tail)
+				memcpy(__get_dynamic_array(tail),
+				       info->beacon.tail,
+				       info->beacon.tail_len);
+			if (info->beacon.beacon_ies)
 				memcpy(__get_dynamic_array(beacon_ies),
-				       info->beacon_ies, info->beacon_ies_len);
-			if (info->proberesp_ies)
+				       info->beacon.beacon_ies,
+				       info->beacon.beacon_ies_len);
+			if (info->beacon.proberesp_ies)
 				memcpy(__get_dynamic_array(proberesp_ies),
-				       info->proberesp_ies,
-				       info->proberesp_ies_len);
-			if (info->assocresp_ies)
+				       info->beacon.proberesp_ies,
+				       info->beacon.proberesp_ies_len);
+			if (info->beacon.assocresp_ies)
 				memcpy(__get_dynamic_array(assocresp_ies),
-				       info->assocresp_ies,
-				       info->assocresp_ies_len);
-			if (info->probe_resp)
+				       info->beacon.assocresp_ies,
+				       info->beacon.assocresp_ies_len);
+			if (info->beacon.probe_resp)
 				memcpy(__get_dynamic_array(probe_resp),
-				       info->probe_resp, info->probe_resp_len);
+				       info->beacon.probe_resp,
+				       info->beacon.probe_resp_len);
 		}
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT, WIPHY_PR_ARG, NETDEV_PR_ARG)

base-commit: 70a5ba4b31aaaba991ba71d248b792e13dc0820e
-- 
2.31.1

