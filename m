Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BC56C1C31
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 17:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjCTQlw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 12:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjCTQlV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 12:41:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D092CC79
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 09:35:47 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KFR4G7016937;
        Mon, 20 Mar 2023 16:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=0pOxAshrO8MW+ZuVucdQMuKT5rrUjP9qJpZO2ARR2iQ=;
 b=k71qA0XiEUeBxodj50GZNzSULtYmUR0m9thofYSQvpMKJTXT3oPY2ulRUR9qAfdg5xNg
 YHZa2PS0HkKJBGCVL7LZjStiqsyVCecEMJzkOHq+sJSXkRxef1I3hqbI57WoKO6M88pz
 UdK7O09Bn1im0B0oSmDFFNkd+/BvkrcmFqWtuGAtcBKmSaX8AFWckQQUah7pMAAAHepW
 bvTdLmu8W0JubiW0s61ZntbZNDMlvY+humK9DSE31YxbDMgNyLgwOtxXYRI+ABef0YXI
 oWOJ8mVGZ+ayvyvi9u8xAz+t2PYqeWL1NdDS/gfj5vOSpP4kfLEWuda4LCwNiDAxJNja xA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pejxc9bp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 16:35:42 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32KGZfLb028098
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Mar 2023 16:35:41 GMT
Received: from che-siroccolnx03.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 20 Mar 2023 09:35:39 -0700
From:   Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
Subject: [PATCH 1/4] wifi: nl80211: rename NL80211_CMD_SET_BEACON to NL80211_CMD_UDPATE_AP
Date:   Mon, 20 Mar 2023 22:05:19 +0530
Message-ID: <20230320163522.3325587-2-quic_mkenna@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320163522.3325587-1-quic_mkenna@quicinc.com>
References: <20230320163522.3325587-1-quic_mkenna@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9HAJG-qITbuy-gY4nQ0JpoxKsKD3GzBP
X-Proofpoint-ORIG-GUID: 9HAJG-qITbuy-gY4nQ0JpoxKsKD3GzBP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_13,2023-03-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303200141
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>

Currently NL80211_CMD_SET_BEACON is limited to set only few AP
parameters. Renaming NL80211_CMD_SET_BEACON to NL80211_UPDATE_AP
would help users to configure more AP parameters which can vary
at the runtime of the BSS.

Replacing the argument 'struct cfg80211_beacon_data' parameter
with 'struct cfg80211_ap_settings' in the callback function for
this command, which has more information about AP parameters
along with the struct cfg80211_beacon_data.

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Signed-off-by: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c    | 11 +--
 drivers/net/wireless/ath/wil6210/cfg80211.c   | 14 ++--
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 11 +--
 .../net/wireless/marvell/mwifiex/cfg80211.c   | 15 ++--
 .../wireless/microchip/wilc1000/cfg80211.c    | 11 +--
 .../net/wireless/quantenna/qtnfmac/cfg80211.c | 11 +--
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 12 +++-
 include/net/cfg80211.h                        | 36 ++++++++--
 include/uapi/linux/nl80211.h                  | 19 ++---
 net/mac80211/cfg.c                            | 20 +++---
 net/wireless/nl80211.c                        | 21 +++---
 net/wireless/rdev-ops.h                       | 10 +--
 net/wireless/trace.h                          | 70 ++++++++++---------
 13 files changed, 165 insertions(+), 96 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index 0c2b8b1a10d5..126c0c156e77 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -2953,8 +2953,8 @@ static int ath6kl_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	return 0;
 }
 
-static int ath6kl_change_beacon(struct wiphy *wiphy, struct net_device *dev,
-				struct cfg80211_beacon_data *beacon)
+static int ath6kl_update_ap(struct wiphy *wiphy, struct net_device *dev,
+			    struct cfg80211_ap_update *params)
 {
 	struct ath6kl_vif *vif = netdev_priv(dev);
 
@@ -2964,7 +2964,10 @@ static int ath6kl_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	if (vif->next_mode != AP_NETWORK)
 		return -EOPNOTSUPP;
 
-	return ath6kl_set_ies(vif, beacon);
+	if (!test_bit(BEACON_VALID, params->valid))
+		return 0;
+
+	return ath6kl_set_ies(vif, &params->settings.beacon);
 }
 
 static int ath6kl_stop_ap(struct wiphy *wiphy, struct net_device *dev,
@@ -3456,7 +3459,7 @@ static struct cfg80211_ops ath6kl_cfg80211_ops = {
 	.resume = __ath6kl_cfg80211_resume,
 #endif
 	.start_ap = ath6kl_start_ap,
-	.change_beacon = ath6kl_change_beacon,
+	.update_ap = ath6kl_update_ap,
 	.stop_ap = ath6kl_stop_ap,
 	.del_station = ath6kl_del_station,
 	.change_station = ath6kl_change_station,
diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 40f9a7ef8980..01838d7ccfe6 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -2080,17 +2080,21 @@ void wil_cfg80211_ap_recovery(struct wil6210_priv *wil)
 	}
 }
 
-static int wil_cfg80211_change_beacon(struct wiphy *wiphy,
-				      struct net_device *ndev,
-				      struct cfg80211_beacon_data *bcon)
+static int wil_cfg80211_update_ap(struct wiphy *wiphy,
+				  struct net_device *ndev,
+				  struct cfg80211_ap_update *params)
 {
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
 	struct wireless_dev *wdev = ndev->ieee80211_ptr;
 	struct wil6210_vif *vif = ndev_to_vif(ndev);
+	struct cfg80211_beacon_data *bcon = &params->settings.beacon;
 	int rc;
 	u32 privacy = 0;
 
-	wil_dbg_misc(wil, "change_beacon, mid=%d\n", vif->mid);
+	if (!test_bit(BEACON_VALID, params->valid))
+		return 0;
+
+	wil_dbg_misc(wil, "update_ap, mid=%d\n", vif->mid);
 	wil_print_bcon_data(bcon);
 
 	if (bcon->tail &&
@@ -2654,7 +2658,7 @@ static const struct cfg80211_ops wil_cfg80211_ops = {
 	.del_key = wil_cfg80211_del_key,
 	.set_default_key = wil_cfg80211_set_default_key,
 	/* AP mode */
-	.change_beacon = wil_cfg80211_change_beacon,
+	.update_ap = wil_cfg80211_update_ap,
 	.start_ap = wil_cfg80211_start_ap,
 	.stop_ap = wil_cfg80211_stop_ap,
 	.add_station = wil_cfg80211_add_station,
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index e0a70a671550..6375f188a879 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -5410,14 +5410,17 @@ static int brcmf_cfg80211_stop_ap(struct wiphy *wiphy, struct net_device *ndev,
 }
 
 static s32
-brcmf_cfg80211_change_beacon(struct wiphy *wiphy, struct net_device *ndev,
-			     struct cfg80211_beacon_data *info)
+brcmf_cfg80211_update_ap(struct wiphy *wiphy, struct net_device *ndev,
+			 struct cfg80211_ap_update *params)
 {
 	struct brcmf_if *ifp = netdev_priv(ndev);
 
+	if (!test_bit(BEACON_VALID, params->valid))
+		return 0;
+
 	brcmf_dbg(TRACE, "Enter\n");
 
-	return brcmf_config_ap_mgmt_ie(ifp->vif, info);
+	return brcmf_config_ap_mgmt_ie(ifp->vif, &params->settings.beacon);
 }
 
 static int
@@ -5945,7 +5948,7 @@ static struct cfg80211_ops brcmf_cfg80211_ops = {
 	.flush_pmksa = brcmf_cfg80211_flush_pmksa,
 	.start_ap = brcmf_cfg80211_start_ap,
 	.stop_ap = brcmf_cfg80211_stop_ap,
-	.change_beacon = brcmf_cfg80211_change_beacon,
+	.update_ap = brcmf_cfg80211_update_ap,
 	.del_station = brcmf_cfg80211_del_station,
 	.change_station = brcmf_cfg80211_change_station,
 	.sched_scan_start = brcmf_cfg80211_sched_scan_start,
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index bcd564dc3554..1d70c5c5ee6a 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -1830,12 +1830,12 @@ static int mwifiex_cfg80211_set_cqm_rssi_config(struct wiphy *wiphy,
 	return 0;
 }
 
-/* cfg80211 operation handler for change_beacon.
+/* cfg80211 operation handler for update_ap.
  * Function retrieves and sets modified management IEs to FW.
  */
-static int mwifiex_cfg80211_change_beacon(struct wiphy *wiphy,
-					  struct net_device *dev,
-					  struct cfg80211_beacon_data *data)
+static int mwifiex_cfg80211_update_ap(struct wiphy *wiphy,
+				      struct net_device *dev,
+				      struct cfg80211_ap_update *params)
 {
 	struct mwifiex_private *priv = mwifiex_netdev_get_priv(dev);
 	struct mwifiex_adapter *adapter = priv->adapter;
@@ -1854,7 +1854,10 @@ static int mwifiex_cfg80211_change_beacon(struct wiphy *wiphy,
 		return -EINVAL;
 	}
 
-	if (mwifiex_set_mgmt_ies(priv, data)) {
+	if (!test_bit(BEACON_VALID, params->valid))
+		return 0;
+
+	if (mwifiex_set_mgmt_ies(priv, &params->settings.beacon)) {
 		mwifiex_dbg(priv->adapter, ERROR,
 			    "%s: setting mgmt ies failed\n", __func__);
 		return -EFAULT;
@@ -4230,7 +4233,7 @@ static struct cfg80211_ops mwifiex_cfg80211_ops = {
 	.set_bitrate_mask = mwifiex_cfg80211_set_bitrate_mask,
 	.start_ap = mwifiex_cfg80211_start_ap,
 	.stop_ap = mwifiex_cfg80211_stop_ap,
-	.change_beacon = mwifiex_cfg80211_change_beacon,
+	.update_ap = mwifiex_cfg80211_update_ap,
 	.set_cqm_rssi_config = mwifiex_cfg80211_set_cqm_rssi_config,
 	.set_antenna = mwifiex_cfg80211_set_antenna,
 	.get_antenna = mwifiex_cfg80211_get_antenna,
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index b545d93c6e37..c475e874c200 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1440,12 +1440,15 @@ static int start_ap(struct wiphy *wiphy, struct net_device *dev,
 				   settings->dtim_period, &settings->beacon);
 }
 
-static int change_beacon(struct wiphy *wiphy, struct net_device *dev,
-			 struct cfg80211_beacon_data *beacon)
+static int update_ap(struct wiphy *wiphy, struct net_device *dev,
+		     struct cfg80211_ap_update *params)
 {
 	struct wilc_vif *vif = netdev_priv(dev);
 
-	return wilc_add_beacon(vif, 0, 0, beacon);
+	if (!test_bit(BEACON_VALID, params->valid))
+		return 0;
+
+	return wilc_add_beacon(vif, 0, 0, &params->settings.beacon);
 }
 
 static int stop_ap(struct wiphy *wiphy, struct net_device *dev,
@@ -1724,7 +1727,7 @@ static const struct cfg80211_ops wilc_cfg80211_ops = {
 	.change_virtual_intf = change_virtual_intf,
 
 	.start_ap = start_ap,
-	.change_beacon = change_beacon,
+	.update_ap = update_ap,
 	.stop_ap = stop_ap,
 	.add_station = add_station,
 	.del_station = del_station,
diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
index 73e6f9408b51..ad2140849c12 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -330,12 +330,15 @@ static int qtnf_mgmt_set_appie(struct qtnf_vif *vif,
 	return ret;
 }
 
-static int qtnf_change_beacon(struct wiphy *wiphy, struct net_device *dev,
-			      struct cfg80211_beacon_data *info)
+static int qtnf_update_ap(struct wiphy *wiphy, struct net_device *dev,
+			  struct cfg80211_ap_update *params)
 {
 	struct qtnf_vif *vif = qtnf_netdev_get_priv(dev);
 
-	return qtnf_mgmt_set_appie(vif, info);
+	if (!test_bit(BEACON_VALID, params->valid))
+		return 0;
+
+	return qtnf_mgmt_set_appie(vif, &params->settings.beacon);
 }
 
 static int qtnf_start_ap(struct wiphy *wiphy, struct net_device *dev,
@@ -1003,7 +1006,7 @@ static struct cfg80211_ops qtn_cfg80211_ops = {
 	.change_virtual_intf	= qtnf_change_virtual_intf,
 	.del_virtual_intf	= qtnf_del_virtual_intf,
 	.start_ap		= qtnf_start_ap,
-	.change_beacon		= qtnf_change_beacon,
+	.update_ap              = qtnf_update_ap,
 	.stop_ap		= qtnf_stop_ap,
 	.set_wiphy_params	= qtnf_set_wiphy_params,
 	.update_mgmt_frame_registrations =
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 54004f846cf0..0b76063bd399 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2350,10 +2350,16 @@ static int cfg80211_rtw_start_ap(struct wiphy *wiphy, struct net_device *ndev,
 	return ret;
 }
 
-static int cfg80211_rtw_change_beacon(struct wiphy *wiphy, struct net_device *ndev,
-		struct cfg80211_beacon_data *info)
+static int cfg80211_rtw_update_ap(struct wiphy *wiphy,
+				  struct net_device *ndev,
+				  struct cfg80211_ap_update *params)
+
 {
 	struct adapter *adapter = rtw_netdev_priv(ndev);
+	struct cfg80211_beacon_data *info = &params->settings.beacon;
+
+	if (!test_bit(BEACON_VALID, params->valid))
+		return 0;
 
 	return rtw_add_beacon(adapter, info->head, info->head_len, info->tail, info->tail_len);
 }
@@ -2759,7 +2765,7 @@ static struct cfg80211_ops rtw_cfg80211_ops = {
 	.del_virtual_intf = cfg80211_rtw_del_virtual_intf,
 
 	.start_ap = cfg80211_rtw_start_ap,
-	.change_beacon = cfg80211_rtw_change_beacon,
+	.update_ap = cfg80211_rtw_update_ap,
 	.stop_ap = cfg80211_rtw_stop_ap,
 
 	.add_station = cfg80211_rtw_add_station,
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7cebba1c4135..0d62b5853929 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1368,6 +1368,34 @@ struct cfg80211_ap_settings {
 	u16 punct_bitmap;
 };
 
+/**
+ * enum cfg80211_ap_settings_valid - struct cfg80211_ap_settings
+validation flags
+ *
+ * These flags are used with the nl80211_update_ap() callback
+ * to indicate the valid settings in struct cfg80211_ap_settings.
+ *
+ * @BEACON_VALID: beacon setting is valid.
+ */
+enum cfg80211_ap_settings_valid {
+	BEACON_VALID,
+	LAST_VALID,
+};
+
+/**
+ * struct cfg80211_ap_update - updated AP configuration
+ *
+ * Used to update the AP parameters in run time.
+ *
+ * @changed: Indicate the valid parameters in struct
+cfg80211_ap_settings
+ * @settings: updated AP settings
+ */
+struct cfg80211_ap_update {
+	DECLARE_BITMAP(valid, LAST_VALID);
+	struct cfg80211_ap_settings settings;
+};
+
 /**
  * struct cfg80211_csa_settings - channel switch settings
  *
@@ -4024,8 +4052,8 @@ struct mgmt_frame_regs {
  * @set_rekey_data: give the data necessary for GTK rekeying to the driver
  *
  * @start_ap: Start acting in AP mode defined by the parameters.
- * @change_beacon: Change the beacon parameters for an access point mode
- *	interface. This should reject the call when AP mode wasn't started.
+ * @update_ap: Update parameters for an access point mode interface.
+ * This should reject the call when AP mode wasn't started.
  * @stop_ap: Stop being an AP, including stopping beaconing.
  *
  * @add_station: Add a new station.
@@ -4392,8 +4420,8 @@ struct cfg80211_ops {
 
 	int	(*start_ap)(struct wiphy *wiphy, struct net_device *dev,
 			    struct cfg80211_ap_settings *settings);
-	int	(*change_beacon)(struct wiphy *wiphy, struct net_device *dev,
-				 struct cfg80211_beacon_data *info);
+	int     (*update_ap)(struct wiphy *wiphy, struct net_device *dev,
+			     struct cfg80211_ap_update *params);
 	int	(*stop_ap)(struct wiphy *wiphy, struct net_device *dev,
 			   unsigned int link_id);
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 9a0ac0363f1f..e7b7d8031582 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -395,13 +395,15 @@
  *	%NL80211_ATTR_MLO_LINK_ID.
  *
  * @NL80211_CMD_GET_BEACON: (not used)
- * @NL80211_CMD_SET_BEACON: change the beacon on an access point interface
+ * @NL80211_CMD_UPDATE_AP: Update AP parameters which can vary at the
+ *	runtime of BSS. change the beacon on an access point interface
  *	using the %NL80211_ATTR_BEACON_HEAD and %NL80211_ATTR_BEACON_TAIL
  *	attributes. For drivers that generate the beacon and probe responses
- *	internally, the following attributes must be provided: %NL80211_ATTR_IE,
- *	%NL80211_ATTR_IE_PROBE_RESP and %NL80211_ATTR_IE_ASSOC_RESP.
+ *	internally, the following attributes must be provided for the
+ *	beacon update: %NL80211_ATTR_IE, %NL80211_ATTR_IE_PROBE_RESP and
+ *	%NL80211_ATTR_IE_ASSOC_RESP.
  * @NL80211_CMD_START_AP: Start AP operation on an AP interface, parameters
- *	are like for %NL80211_CMD_SET_BEACON, and additionally parameters that
+ *	are like for %NL80211_CMD_UPDATE_AP, and additionally parameters that
  *	do not change are used, these include %NL80211_ATTR_BEACON_INTERVAL,
  *	%NL80211_ATTR_DTIM_PERIOD, %NL80211_ATTR_SSID,
  *	%NL80211_ATTR_HIDDEN_SSID, %NL80211_ATTR_CIPHERS_PAIRWISE,
@@ -1332,7 +1334,8 @@ enum nl80211_commands {
 	NL80211_CMD_DEL_KEY,
 
 	NL80211_CMD_GET_BEACON,
-	NL80211_CMD_SET_BEACON,
+	NL80211_CMD_UPDATE_AP,
+	NL80211_CMD_SET_BEACON = NL80211_CMD_UPDATE_AP,
 	NL80211_CMD_START_AP,
 	NL80211_CMD_NEW_BEACON = NL80211_CMD_START_AP,
 	NL80211_CMD_STOP_AP,
@@ -2050,12 +2053,12 @@ enum nl80211_commands {
  *	&enum nl80211_hidden_ssid, represented as a u32
  *
  * @NL80211_ATTR_IE_PROBE_RESP: Information element(s) for Probe Response frame.
- *	This is used with %NL80211_CMD_NEW_BEACON and %NL80211_CMD_SET_BEACON to
+ *	This is used with %NL80211_CMD_NEW_BEACON and %NL80211_CMD_UPDATE_AP to
  *	provide extra IEs (e.g., WPS/P2P IE) into Probe Response frames when the
  *	driver (or firmware) replies to Probe Request frames.
  * @NL80211_ATTR_IE_ASSOC_RESP: Information element(s) for (Re)Association
  *	Response frames. This is used with %NL80211_CMD_NEW_BEACON and
- *	%NL80211_CMD_SET_BEACON to provide extra IEs (e.g., WPS/P2P IE) into
+ *	%NL80211_CMD_UPDATE_AP to provide extra IEs (e.g., WPS/P2P IE) into
  *	(Re)Association Response frames when the driver (or firmware) replies to
  *	(Re)Association Request frames.
  *
@@ -2581,7 +2584,7 @@ enum nl80211_commands {
  *	only if %NL80211_STA_FLAG_WME is set.
  *
  * @NL80211_ATTR_FTM_RESPONDER: nested attribute which user-space can include
- *	in %NL80211_CMD_START_AP or %NL80211_CMD_SET_BEACON for fine timing
+ *	in %NL80211_CMD_START_AP or %NL80211_CMD_UPDATE_AP for fine timing
  *	measurement (FTM) responder functionality and containing parameters as
  *	possible, see &enum nl80211_ftm_responder_attr
  *
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 760ad934f9e1..657be3d4dfcd 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1460,8 +1460,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	return err;
 }
 
-static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
-				   struct cfg80211_beacon_data *params)
+static int ieee80211_update_ap(struct wiphy *wiphy, struct net_device *dev,
+			       struct cfg80211_ap_update *params)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_link_data *link;
@@ -1471,7 +1471,8 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 
 	sdata_assert_lock(sdata);
 
-	link = sdata_dereference(sdata->link[params->link_id], sdata);
+	link = sdata_dereference(sdata->link[params->settings.beacon.link_id],
+				 sdata);
 	if (!link)
 		return -ENOLINK;
 
@@ -1487,13 +1488,16 @@ static int ieee80211_change_beacon(struct wiphy *wiphy, struct net_device *dev,
 	if (!old)
 		return -ENOENT;
 
-	err = ieee80211_assign_beacon(sdata, link, params, NULL, NULL);
+	err = ieee80211_assign_beacon(sdata, link, &params->settings.beacon,
+				      NULL, NULL);
 	if (err < 0)
 		return err;
 
-	if (params->he_bss_color_valid &&
-	    params->he_bss_color.enabled != link_conf->he_bss_color.enabled) {
-		link_conf->he_bss_color.enabled = params->he_bss_color.enabled;
+	if (params->settings.beacon.he_bss_color_valid &&
+	    params->settings.beacon.he_bss_color.enabled !=
+	    link_conf->he_bss_color.enabled) {
+		link_conf->he_bss_color.enabled =
+			params->settings.beacon.he_bss_color.enabled;
 		err |= BSS_CHANGED_HE_BSS_COLOR;
 	}
 
@@ -4960,7 +4964,7 @@ const struct cfg80211_ops mac80211_config_ops = {
 	.set_default_mgmt_key = ieee80211_config_default_mgmt_key,
 	.set_default_beacon_key = ieee80211_config_default_beacon_key,
 	.start_ap = ieee80211_start_ap,
-	.change_beacon = ieee80211_change_beacon,
+	.update_ap = ieee80211_update_ap,
 	.stop_ap = ieee80211_stop_ap,
 	.add_station = ieee80211_add_station,
 	.del_station = ieee80211_del_station,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 0a31b1d2845d..a45bda39d8ab 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6142,35 +6142,40 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
+static int nl80211_update_ap(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	unsigned int link_id = nl80211_link_id(info->attrs);
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
-	struct cfg80211_beacon_data params;
+	struct cfg80211_ap_update params;
 	int err;
 
 	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP &&
 	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
 		return -EOPNOTSUPP;
 
-	if (!rdev->ops->change_beacon)
+	if (!rdev->ops->update_ap)
 		return -EOPNOTSUPP;
 
 	if (!wdev->links[link_id].ap.beacon_interval)
 		return -EINVAL;
 
-	err = nl80211_parse_beacon(rdev, info->attrs, &params);
+	memset(&params, 0, sizeof(params));
+
+	err = nl80211_parse_beacon(rdev, info->attrs,
+				   &params.settings.beacon);
 	if (err)
 		goto out;
 
+	set_bit(BEACON_VALID, params.valid);
+
 	wdev_lock(wdev);
-	err = rdev_change_beacon(rdev, dev, &params);
+	err = rdev_update_ap(rdev, dev, &params);
 	wdev_unlock(wdev);
 
 out:
-	kfree(params.mbssid_ies);
+	kfree(params.settings.beacon.mbssid_ies);
 	return err;
 }
 
@@ -16619,10 +16624,10 @@ static const struct genl_small_ops nl80211_small_ops[] = {
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP),
 	},
 	{
-		.cmd = NL80211_CMD_SET_BEACON,
+		.cmd = NL80211_CMD_UPDATE_AP,
 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
 		.flags = GENL_UNS_ADMIN_PERM,
-		.doit = nl80211_set_beacon,
+		.doit = nl80211_update_ap,
 		.internal_flags = IFLAGS(NL80211_FLAG_NEED_NETDEV_UP |
 					 NL80211_FLAG_MLO_VALID_LINK_ID),
 	},
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 2e497cf26ef2..ac6bdf3434a1 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -171,13 +171,13 @@ static inline int rdev_start_ap(struct cfg80211_registered_device *rdev,
 	return ret;
 }
 
-static inline int rdev_change_beacon(struct cfg80211_registered_device *rdev,
-				     struct net_device *dev,
-				     struct cfg80211_beacon_data *info)
+static inline int rdev_update_ap(struct cfg80211_registered_device *rdev,
+				 struct net_device *dev,
+				 struct cfg80211_ap_update *info)
 {
 	int ret;
-	trace_rdev_change_beacon(&rdev->wiphy, dev, info);
-	ret = rdev->ops->change_beacon(&rdev->wiphy, dev, info);
+	trace_rdev_update_ap(&rdev->wiphy, dev, &info->settings);
+	ret = rdev->ops->update_ap(&rdev->wiphy, dev, info);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 716a1fa70069..34f517ab2068 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -613,54 +613,58 @@ TRACE_EVENT(rdev_start_ap,
 		  __entry->inactivity_timeout, __entry->link_id)
 );
 
-TRACE_EVENT(rdev_change_beacon,
-	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
-		 struct cfg80211_beacon_data *info),
-	TP_ARGS(wiphy, netdev, info),
-	TP_STRUCT__entry(
+TRACE_EVENT(rdev_update_ap,
+	    TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
+		     struct cfg80211_ap_settings *info),
+	    TP_ARGS(wiphy, netdev, info),
+	    TP_STRUCT__entry(
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
-	),
-	TP_fast_assign(
+				info ? info->beacon.assocresp_ies_len : 0)
+		__dynamic_array(u8, probe_resp,
+				info ? info->beacon.probe_resp_len : 0)
+	    ),
+	    TP_fast_assign(
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
+				memcpy(__get_dynamic_array(head), info->beacon.head,
+				       info->beacon.head_len);
+			if (info->beacon.tail)
+				memcpy(__get_dynamic_array(tail), info->beacon.tail,
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
-	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id:%d",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->link_id)
+	    ),
+	    TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", link_id:%d",
+		      WIPHY_PR_ARG, NETDEV_PR_ARG, __entry->link_id)
 );
 
 TRACE_EVENT(rdev_stop_ap,
-- 
2.25.1

