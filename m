Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E6B765AA3
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jul 2023 19:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjG0Rle (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jul 2023 13:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjG0Rld (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jul 2023 13:41:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2396930E2
        for <linux-wireless@vger.kernel.org>; Thu, 27 Jul 2023 10:41:28 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36RGfCeF015523;
        Thu, 27 Jul 2023 17:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=2zV0u20V+1Ku6Lb7aWVk5G20Ezu09l39E/o1hhNJfkE=;
 b=poauhq2Dqj1ffBEkiKNDDTR56+Ogl4c/G49OGnttQY6teCHUuiL4flI0INraWA1WBo/M
 67xBRhRltUWQtPnRAOhiCKjnasNnwV4sKGM1TPWq4WnVmP0TOqVjvEwmT2yH2vmCbCas
 G05zjQhSJQP8TR87RtccHpU9X/8+Hl6/Z5s+hQ9cgjp+jCPtnTAozpwSLmeVGnLN2fo7
 RfDDhcJCV5xPSmVEAMRFnXb9cwAMQiAvVFmYGaIBwj8qBbQSh7YROfsnvhBBpJc6sHVo
 gXGwFl9ibGSlM4o+AuBjvM1HgGrdhOW1NS5t/yRnLroQAazmyPIU4QOT34idPOA1ZEAJ GA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s37g0jt1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:41:24 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36RHfGgc018390
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 17:41:16 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 27 Jul 2023 10:41:15 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH v8 3/5] wifi: cfg80211: modify prototype for change_beacon
Date:   Thu, 27 Jul 2023 10:40:58 -0700
Message-ID: <20230727174100.11721-4-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230727174100.11721-1-quic_alokad@quicinc.com>
References: <20230727174100.11721-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NycZMY_cVT6Igl6PqL0oM0TQKKAQTQNf
X-Proofpoint-ORIG-GUID: NycZMY_cVT6Igl6PqL0oM0TQKKAQTQNf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_07,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1011
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270160
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Modify the prototype for change_beacon() in struct cfg80211_op to
accept cfg80211_ap_settings instead of cfg80211_beacon_data so that
it can process data in addition to beacons.
Modify the prototypes of ieee80211_change_beacon() and driver specific
functions accordingly.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
---
v8: Only cosmetic changes.

 drivers/net/wireless/ath/ath6kl/cfg80211.c    |  4 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  3 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  4 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  3 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |  4 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  4 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  6 ++-
 include/net/cfg80211.h                        |  2 +-
 net/mac80211/cfg.c                            | 14 ++---
 net/wireless/nl80211.c                        | 16 ++++--
 net/wireless/rdev-ops.h                       |  2 +-
 net/wireless/trace.h                          | 54 ++++++++++---------
 12 files changed, 67 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index 0c2b8b1a10d5..e7ce1de77f09 100644
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
 
 static int ath6kl_stop_ap(struct wiphy *wiphy, struct net_device *dev,
diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 40f9a7ef8980..dfbb478ae274 100644
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
index de8a2e27f49c..6a71fb22aa12 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5411,13 +5411,13 @@ static int brcmf_cfg80211_stop_ap(struct wiphy *wiphy, struct net_device *ndev,
 
 static s32
 brcmf_cfg80211_change_beacon(struct wiphy *wiphy, struct net_device *ndev,
-			     struct cfg80211_beacon_data *info)
+			     struct cfg80211_ap_settings *info)
 {
 	struct brcmf_if *ifp = netdev_priv(ndev);
 
 	brcmf_dbg(TRACE, "Enter\n");
 
-	return brcmf_config_ap_mgmt_ie(ifp->vif, info);
+	return brcmf_config_ap_mgmt_ie(ifp->vif, &info->beacon);
 }
 
 static int
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index ba4e29713a8c..70473be42d7b 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -1835,10 +1835,11 @@ static int mwifiex_cfg80211_set_cqm_rssi_config(struct wiphy *wiphy,
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
index b545d93c6e37..3447470d3d02 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1441,11 +1441,11 @@ static int start_ap(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int change_beacon(struct wiphy *wiphy, struct net_device *dev,
-			 struct cfg80211_beacon_data *beacon)
+			 struct cfg80211_ap_settings *params)
 {
 	struct wilc_vif *vif = netdev_priv(dev);
 
-	return wilc_add_beacon(vif, 0, 0, beacon);
+	return wilc_add_beacon(vif, 0, 0, &params->beacon);
 }
 
 static int stop_ap(struct wiphy *wiphy, struct net_device *dev,
diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index 73e6f9408b51..9388adcdcac1 100644
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
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 2ae7843abdf7..5ddc2d9a6060 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2319,11 +2319,13 @@ static int cfg80211_rtw_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static int cfg80211_rtw_change_beacon(struct wiphy *wiphy, struct net_device *ndev,
-		struct cfg80211_beacon_data *info)
+		struct cfg80211_ap_settings *info)
 {
 	struct adapter *adapter = rtw_netdev_priv(ndev);
 
-	return rtw_add_beacon(adapter, info->head, info->head_len, info->tail, info->tail_len);
+	return rtw_add_beacon(adapter, info->beacon.head,
+			      info->beacon.head_len, info->beacon.tail,
+			      info->beacon.tail_len);
 }
 
 static int cfg80211_rtw_stop_ap(struct wiphy *wiphy, struct net_device *ndev,
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 5317f67da67f..a4552d8f8200 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4452,7 +4452,7 @@ struct cfg80211_ops {
 	int	(*start_ap)(struct wiphy *wiphy, struct net_device *dev,
 			    struct cfg80211_ap_settings *settings);
 	int	(*change_beacon)(struct wiphy *wiphy, struct net_device *dev,
-				 struct cfg80211_beacon_data *info);
+				 struct cfg80211_ap_settings *info);
 	int	(*stop_ap)(struct wiphy *wiphy, struct net_device *dev,
 			   unsigned int link_id);
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index dcf152114652..3fe424992893 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1509,10 +1509,12 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
-				   struct cfg80211_beacon_data *params)
+				   struct cfg80211_ap_settings *params)
+
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_link_data *link;
+	struct cfg80211_beacon_data *beacon = &params->beacon;
 	struct beacon_data *old;
 	int err;
 	struct ieee80211_bss_conf *link_conf;
@@ -1520,7 +1522,7 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 
 	sdata_assert_lock(sdata);
 
-	link = sdata_dereference(sdata->link[params->link_id], sdata);
+	link = sdata_dereference(sdata->link[beacon->link_id], sdata);
 	if (!link)
 		return -ENOLINK;
 
@@ -1536,14 +1538,14 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	if (!old)
 		return -ENOENT;
 
-	err = ieee80211_assign_beacon(sdata, link, params, NULL, NULL,
+	err = ieee80211_assign_beacon(sdata, link, beacon, NULL, NULL,
 				      &changed);
 	if (err < 0)
 		return err;
 
-	if (params->he_bss_color_valid &&
-	    params->he_bss_color.enabled != link_conf->he_bss_color.enabled) {
-		link_conf->he_bss_color.enabled = params->he_bss_color.enabled;
+	if (beacon->he_bss_color_valid &&
+	    beacon->he_bss_color.enabled != link_conf->he_bss_color.enabled) {
+		link_conf->he_bss_color.enabled = beacon->he_bss_color.enabled;
 		changed |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 487a34cbc6fb..5e087534a12e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6238,7 +6238,7 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 	unsigned int link_id = nl80211_link_id(info->attrs);
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	struct cfg80211_beacon_data params;
+	struct cfg80211_ap_settings *params;
 	int err;
 
 	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP &&
@@ -6251,17 +6251,23 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 	if (!wdev->links[link_id].ap.beacon_interval)
 		return -EINVAL;
 
-	err = nl80211_parse_beacon(rdev, info->attrs, &params, info->extack);
+	params = kzalloc(sizeof(*params), GFP_KERNEL);
+	if (!params)
+		return -ENOMEM;
+
+	err = nl80211_parse_beacon(rdev, info->attrs, &params->beacon,
+				   info->extack);
 	if (err)
 		goto out;
 
 	wdev_lock(wdev);
-	err = rdev_change_beacon(rdev, dev, &params);
+	err = rdev_change_beacon(rdev, dev, params);
 	wdev_unlock(wdev);
 
 out:
-	kfree(params.mbssid_ies);
-	kfree(params.rnr_ies);
+	kfree(params->beacon.mbssid_ies);
+	kfree(params->beacon.rnr_ies);
+	kfree(params);
 	return err;
 }
 
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 90bb7ac4b930..c6a2c07e380b 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -173,7 +173,7 @@ static inline int rdev_start_ap(struct cfg80211_registered_device *rdev,
 
 static inline int rdev_change_beacon(struct cfg80211_registered_device *rdev,
 				     struct net_device *dev,
-				     struct cfg80211_beacon_data *info)
+				     struct cfg80211_ap_settings *info)
 {
 	int ret;
 	trace_rdev_change_beacon(&rdev->wiphy, dev, info);
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 617c0d0dfa96..5579b6a4f314 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -615,46 +615,52 @@ TRACE_EVENT(rdev_start_ap,
 
 TRACE_EVENT(rdev_change_beacon,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
-		 struct cfg80211_beacon_data *info),
+		 struct cfg80211_ap_settings *info),
 	TP_ARGS(wiphy, netdev, info),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
 		__field(int, link_id)
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
-			__entry->link_id = info->link_id;
-			if (info->head)
-				memcpy(__get_dynamic_array(head), info->head,
-				       info->head_len);
-			if (info->tail)
-				memcpy(__get_dynamic_array(tail), info->tail,
-				       info->tail_len);
-			if (info->beacon_ies)
+			__entry->link_id = info->beacon.link_id;
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
 		} else {
 			__entry->link_id = -1;
 		}
-- 
2.39.0

