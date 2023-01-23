Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D201677542
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jan 2023 07:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjAWGys (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Jan 2023 01:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjAWGyr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Jan 2023 01:54:47 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C180819684
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jan 2023 22:54:43 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30N6sSx55012869, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30N6sSx55012869
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 23 Jan 2023 14:54:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Mon, 23 Jan 2023 14:54:30 +0800
Received: from localhost (172.16.16.32) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 23 Jan
 2023 14:54:30 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/6] wifi: rtw89: refine packet offload flow
Date:   Mon, 23 Jan 2023 14:53:57 +0800
Message-ID: <20230123065401.14174-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123065401.14174-1-pkshih@realtek.com>
References: <20230123065401.14174-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.32]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/23/2023 06:33:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMjMgpFekyCAxMjozNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

For upcoming firmware, driver needs to do packet offload to firmware to
ensure LPS protocol work properly, so we update current connection and
disconnect flow to maintain packet offload flow, and integrate with
current WoWLAN flow which also needs packet offload.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 17 +++---
 drivers/net/wireless/realtek/rtw89/core.h     |  2 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 54 +++++++++++++++----
 drivers/net/wireless/realtek/rtw89/fw.h       |  6 ++-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  1 +
 drivers/net/wireless/realtek/rtw89/ser.c      |  1 +
 drivers/net/wireless/realtek/rtw89/wow.c      | 26 ++++-----
 7 files changed, 71 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 4cf4a81ed4f79..b63ff71353d37 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2491,8 +2491,10 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 	if (sta->tdls)
 		rtw89_cam_deinit_bssid_cam(rtwdev, &rtwsta->bssid_cam);
 
-	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
+	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
 		rtw89_vif_type_mapping(vif, false);
+		rtw89_fw_release_general_pkt_list_vif(rtwdev, rtwvif, true);
+	}
 
 	ret = rtw89_fw_h2c_assoc_cmac_tbl(rtwdev, vif, sta);
 	if (ret) {
@@ -2580,12 +2582,6 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 		return ret;
 	}
 
-	ret = rtw89_fw_h2c_general_pkt(rtwdev, rtwsta->mac_id);
-	if (ret) {
-		rtw89_warn(rtwdev, "failed to send h2c general packet\n");
-		return ret;
-	}
-
 	rtwdev->total_sta_assoc++;
 	rtw89_phy_ra_assoc(rtwdev, sta);
 	rtw89_mac_bf_assoc(rtwdev, vif, sta);
@@ -2602,6 +2598,12 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 					 BTC_ROLE_MSTS_STA_CONN_END);
 		rtw89_core_get_no_ul_ofdma_htc(rtwdev, &rtwsta->htc_template);
 		rtw89_phy_ul_tb_assoc(rtwdev, rtwvif);
+
+		ret = rtw89_fw_h2c_general_pkt(rtwdev, rtwvif, rtwsta->mac_id);
+		if (ret) {
+			rtw89_warn(rtwdev, "failed to send h2c general packet\n");
+			return ret;
+		}
 	}
 
 	return ret;
@@ -3126,7 +3128,6 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 			continue;
 		INIT_LIST_HEAD(&rtwdev->scan_info.pkt_list[band]);
 	}
-	INIT_LIST_HEAD(&rtwdev->wow.pkt_list);
 	INIT_WORK(&rtwdev->ba_work, rtw89_core_ba_work);
 	INIT_WORK(&rtwdev->txq_work, rtw89_core_txq_work);
 	INIT_DELAYED_WORK(&rtwdev->txq_reinvoke_work, rtw89_core_txq_reinvoke_work);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 39c5a003e36cc..663e1b281fa15 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2460,6 +2460,7 @@ struct rtw89_vif {
 	struct rtw89_phy_rate_pattern rate_pattern;
 	struct cfg80211_scan_request *scan_req;
 	struct ieee80211_scan_ies *scan_ies;
+	struct list_head general_pkt_list;
 };
 
 enum rtw89_lv1_rcvy_step {
@@ -3723,7 +3724,6 @@ struct rtw89_wow_param {
 	DECLARE_BITMAP(flags, RTW89_WOW_FLAG_NUM);
 	struct rtw89_wow_cam_info patterns[RTW89_MAX_PATTERN_NUM];
 	u8 pattern_cnt;
-	struct list_head pkt_list;
 };
 
 struct rtw89_mcc_info {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 210785149801b..dc90074261244 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -10,6 +10,7 @@
 #include "mac.h"
 #include "phy.h"
 #include "reg.h"
+#include "util.h"
 
 static void rtw89_fw_c2h_cmd_handle(struct rtw89_dev *rtwdev,
 				    struct sk_buff *skb);
@@ -913,13 +914,12 @@ int rtw89_fw_h2c_fw_log(struct rtw89_dev *rtwdev, bool enable)
 	return ret;
 }
 
-static int rtw89_fw_h2c_add_wow_fw_ofld(struct rtw89_dev *rtwdev,
+static int rtw89_fw_h2c_add_general_pkt(struct rtw89_dev *rtwdev,
 					struct rtw89_vif *rtwvif,
 					enum rtw89_fw_pkt_ofld_type type,
 					u8 *id)
 {
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
-	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct rtw89_pktofld_info *info;
 	struct sk_buff *skb;
 	int ret;
@@ -954,7 +954,7 @@ static int rtw89_fw_h2c_add_wow_fw_ofld(struct rtw89_dev *rtwdev,
 	if (ret)
 		goto err;
 
-	list_add_tail(&info->list, &rtw_wow->pkt_list);
+	list_add_tail(&info->list, &rtwvif->general_pkt_list);
 	*id = info->id;
 	return 0;
 
@@ -963,13 +963,48 @@ static int rtw89_fw_h2c_add_wow_fw_ofld(struct rtw89_dev *rtwdev,
 	return -ENOMEM;
 }
 
+void rtw89_fw_release_general_pkt_list_vif(struct rtw89_dev *rtwdev,
+					   struct rtw89_vif *rtwvif, bool notify_fw)
+{
+	struct list_head *pkt_list = &rtwvif->general_pkt_list;
+	struct rtw89_pktofld_info *info, *tmp;
+
+	list_for_each_entry_safe(info, tmp, pkt_list, list) {
+		if (notify_fw)
+			rtw89_fw_h2c_del_pkt_offload(rtwdev, info->id);
+		rtw89_core_release_bit_map(rtwdev->pkt_offload,
+					   info->id);
+		list_del(&info->list);
+		kfree(info);
+	}
+}
+
+void rtw89_fw_release_general_pkt_list(struct rtw89_dev *rtwdev, bool notify_fw)
+{
+	struct rtw89_vif *rtwvif;
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif)
+		rtw89_fw_release_general_pkt_list_vif(rtwdev, rtwvif, notify_fw);
+}
+
 #define H2C_GENERAL_PKT_LEN 6
 #define H2C_GENERAL_PKT_ID_UND 0xff
-int rtw89_fw_h2c_general_pkt(struct rtw89_dev *rtwdev, u8 macid)
+int rtw89_fw_h2c_general_pkt(struct rtw89_dev *rtwdev,
+			     struct rtw89_vif *rtwvif, u8 macid)
 {
+	u8 pkt_id_ps_poll = H2C_GENERAL_PKT_ID_UND;
+	u8 pkt_id_null = H2C_GENERAL_PKT_ID_UND;
+	u8 pkt_id_qos_null = H2C_GENERAL_PKT_ID_UND;
 	struct sk_buff *skb;
 	int ret;
 
+	rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif,
+				     RTW89_PKT_OFLD_TYPE_PS_POLL, &pkt_id_ps_poll);
+	rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif,
+				     RTW89_PKT_OFLD_TYPE_NULL_DATA, &pkt_id_null);
+	rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif,
+				     RTW89_PKT_OFLD_TYPE_QOS_NULL, &pkt_id_qos_null);
+
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_GENERAL_PKT_LEN);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for fw dl\n");
@@ -978,9 +1013,9 @@ int rtw89_fw_h2c_general_pkt(struct rtw89_dev *rtwdev, u8 macid)
 	skb_put(skb, H2C_GENERAL_PKT_LEN);
 	SET_GENERAL_PKT_MACID(skb->data, macid);
 	SET_GENERAL_PKT_PROBRSP_ID(skb->data, H2C_GENERAL_PKT_ID_UND);
-	SET_GENERAL_PKT_PSPOLL_ID(skb->data, H2C_GENERAL_PKT_ID_UND);
-	SET_GENERAL_PKT_NULL_ID(skb->data, H2C_GENERAL_PKT_ID_UND);
-	SET_GENERAL_PKT_QOS_NULL_ID(skb->data, H2C_GENERAL_PKT_ID_UND);
+	SET_GENERAL_PKT_PSPOLL_ID(skb->data, pkt_id_ps_poll);
+	SET_GENERAL_PKT_NULL_ID(skb->data, pkt_id_null);
+	SET_GENERAL_PKT_QOS_NULL_ID(skb->data, pkt_id_qos_null);
 	SET_GENERAL_PKT_CTS2SELF_ID(skb->data, H2C_GENERAL_PKT_ID_UND);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
@@ -3099,8 +3134,9 @@ int rtw89_fw_h2c_keep_alive(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	int ret;
 
 	if (enable) {
-		ret = rtw89_fw_h2c_add_wow_fw_ofld(rtwdev, rtwvif,
-						   RTW89_PKT_OFLD_TYPE_NULL_DATA, &pkt_id);
+		ret = rtw89_fw_h2c_add_general_pkt(rtwdev, rtwvif,
+						   RTW89_PKT_OFLD_TYPE_NULL_DATA,
+						   &pkt_id);
 		if (ret)
 			return -EPERM;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 3ce59ac48f433..c15be03e5f2d3 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3518,7 +3518,11 @@ int rtw89_fw_h2c_raw_with_hdr(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_raw(struct rtw89_dev *rtwdev, const u8 *buf, u16 len);
 void rtw89_fw_send_all_early_h2c(struct rtw89_dev *rtwdev);
 void rtw89_fw_free_all_early_h2c(struct rtw89_dev *rtwdev);
-int rtw89_fw_h2c_general_pkt(struct rtw89_dev *rtwdev, u8 macid);
+int rtw89_fw_h2c_general_pkt(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			     u8 macid);
+void rtw89_fw_release_general_pkt_list_vif(struct rtw89_dev *rtwdev,
+					   struct rtw89_vif *rtwvif, bool notify_fw);
+void rtw89_fw_release_general_pkt_list(struct rtw89_dev *rtwdev, bool notify_fw);
 int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			bool valid, struct ieee80211_ampdu_params *params);
 void rtw89_fw_h2c_init_ba_cam_v1(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index f9b95c52916bb..d43281f7335b1 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -135,6 +135,7 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 	rtwvif->sub_entity_idx = RTW89_SUB_ENTITY_0;
 	rtwvif->hit_rule = 0;
 	ether_addr_copy(rtwvif->mac_addr, vif->addr);
+	INIT_LIST_HEAD(&rtwvif->general_pkt_list);
 
 	ret = rtw89_mac_add_vif(rtwdev, rtwvif);
 	if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index c1a4bc1c64d16..61db7189fdab8 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -611,6 +611,7 @@ static void ser_l2_reset_st_pre_hdl(struct rtw89_ser *ser)
 	ser_reset_mac_binding(rtwdev);
 	rtw89_core_stop(rtwdev);
 	rtw89_entity_init(rtwdev);
+	rtw89_fw_release_general_pkt_list(rtwdev, false);
 	INIT_LIST_HEAD(&rtwdev->rtwvifs_list);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index b2b826b2e09ae..92fa366ccfcf7 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -490,21 +490,6 @@ static int rtw89_wow_check_fw_status(struct rtw89_dev *rtwdev, bool wow_enable)
 	return ret;
 }
 
-static void rtw89_wow_release_pkt_list(struct rtw89_dev *rtwdev)
-{
-	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
-	struct list_head *pkt_list = &rtw_wow->pkt_list;
-	struct rtw89_pktofld_info *info, *tmp;
-
-	list_for_each_entry_safe(info, tmp, pkt_list, list) {
-		rtw89_fw_h2c_del_pkt_offload(rtwdev, info->id);
-		rtw89_core_release_bit_map(rtwdev->pkt_offload,
-					   info->id);
-		list_del(&info->list);
-		kfree(info);
-	}
-}
-
 static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 {
 	enum rtw89_fw_type fw_type = wow ? RTW89_FW_WOWLAN : RTW89_FW_NORMAL;
@@ -561,6 +546,11 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 	}
 
 	if (is_conn) {
+		ret = rtw89_fw_h2c_general_pkt(rtwdev, rtwvif, rtwsta->mac_id);
+		if (ret) {
+			rtw89_warn(rtwdev, "failed to send h2c general packet\n");
+			return ret;
+		}
 		rtw89_phy_ra_assoc(rtwdev, wow_sta);
 		rtw89_phy_set_bss_color(rtwdev, wow_vif);
 		rtw89_chip_cfg_txpwr_ul_tb_offset(rtwdev, wow_vif);
@@ -708,8 +698,6 @@ static int rtw89_wow_fw_stop(struct rtw89_dev *rtwdev)
 		goto out;
 	}
 
-	rtw89_wow_release_pkt_list(rtwdev);
-
 	ret = rtw89_fw_h2c_disconnect_detect(rtwdev, rtwvif, false);
 	if (ret) {
 		rtw89_err(rtwdev, "wow: failed to disable disconnect detect\n");
@@ -744,6 +732,8 @@ static int rtw89_wow_enable(struct rtw89_dev *rtwdev)
 		goto out;
 	}
 
+	rtw89_fw_release_general_pkt_list(rtwdev, true);
+
 	ret = rtw89_wow_swap_fw(rtwdev, true);
 	if (ret) {
 		rtw89_err(rtwdev, "wow: failed to swap to wow fw\n");
@@ -789,6 +779,8 @@ static int rtw89_wow_disable(struct rtw89_dev *rtwdev)
 		goto out;
 	}
 
+	rtw89_fw_release_general_pkt_list(rtwdev, true);
+
 	ret = rtw89_wow_swap_fw(rtwdev, false);
 	if (ret) {
 		rtw89_err(rtwdev, "wow: failed to disable trx_post\n");
-- 
2.25.1

