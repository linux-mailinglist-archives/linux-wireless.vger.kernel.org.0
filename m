Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168557325F7
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 05:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbjFPDpd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 23:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjFPDp2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 23:45:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135CD18D
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 20:45:26 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35G3j1inD029371, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35G3j1inD029371
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 16 Jun 2023 11:45:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 16 Jun 2023 11:45:20 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 16 Jun
 2023 11:45:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/6] wifi: rtw88: fix not entering PS mode after AP stops
Date:   Fri, 16 Jun 2023 11:44:31 +0800
Message-ID: <20230616034431.17403-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230616034431.17403-1-pkshih@realtek.com>
References: <20230616034431.17403-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Without this patch, firmware only track beacons for port 0 and since
we will always start AP on port 0, this results in misbehavior of
power saving mode on other ports after AP stops.

The "default port" H2C command is used to notify which port should
firmware track. Update the correct settings to firmware so power
saving mode can work properly.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       | 17 +++++++++++++++++
 drivers/net/wireless/realtek/rtw88/fw.h       |  8 ++++++++
 drivers/net/wireless/realtek/rtw88/mac80211.c |  1 +
 drivers/net/wireless/realtek/rtw88/main.c     |  8 ++++++++
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 5 files changed, 35 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 5e329bb95bb89..567bbedd8ee09 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -519,6 +519,23 @@ void rtw_fw_query_bt_info(struct rtw_dev *rtwdev)
 	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
 }
 
+void rtw_fw_default_port(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif)
+{
+	struct rtw_h2c_register h2c = {};
+
+	if (rtwvif->net_type != RTW_NET_MGD_LINKED)
+		return;
+
+	/* Leave LPS before default port H2C so FW timer is correct */
+	rtw_leave_lps(rtwdev);
+
+	h2c.w0 = u32_encode_bits(H2C_CMD_DEFAULT_PORT, RTW_H2C_W0_CMDID) |
+		 u32_encode_bits(rtwvif->port, RTW_H2C_DEFAULT_PORT_W0_PORTID) |
+		 u32_encode_bits(rtwvif->mac_id, RTW_H2C_DEFAULT_PORT_W0_MACID);
+
+	rtw_fw_send_h2c_command_register(rtwdev, &h2c);
+}
+
 void rtw_fw_wl_ch_info(struct rtw_dev *rtwdev, u8 link, u8 ch, u8 bw)
 {
 	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 11a77d86cd144..43ccdf9965ac4 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -86,6 +86,12 @@ struct rtw_h2c_register {
 	u32 w1;
 } __packed;
 
+#define RTW_H2C_W0_CMDID		GENMASK(7, 0)
+
+/* H2C_CMD_DEFAULT_PORT command */
+#define RTW_H2C_DEFAULT_PORT_W0_PORTID	GENMASK(15, 8)
+#define RTW_H2C_DEFAULT_PORT_W0_MACID	GENMASK(23, 16)
+
 struct rtw_h2c_cmd {
 	__le32 msg;
 	__le32 msg_ext;
@@ -535,6 +541,7 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define H2C_CMD_MEDIA_STATUS_RPT	0x01
 #define H2C_CMD_SET_PWR_MODE		0x20
 #define H2C_CMD_LPS_PG_INFO		0x2b
+#define H2C_CMD_DEFAULT_PORT		0x2c
 #define H2C_CMD_RA_INFO			0x40
 #define H2C_CMD_RSSI_MONITOR		0x42
 #define H2C_CMD_BCN_FILTER_OFFLOAD_P0	0x56
@@ -806,6 +813,7 @@ void rtw_fw_c2h_cmd_rx_irqsafe(struct rtw_dev *rtwdev, u32 pkt_offset,
 void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb);
 void rtw_fw_send_general_info(struct rtw_dev *rtwdev);
 void rtw_fw_send_phydm_info(struct rtw_dev *rtwdev);
+void rtw_fw_default_port(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif);
 
 void rtw_fw_do_iqk(struct rtw_dev *rtwdev, struct rtw_iqk_para *para);
 void rtw_fw_inform_rfk_status(struct rtw_dev *rtwdev, bool start);
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 0dc83c2f420da..c5a07285fa541 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -378,6 +378,7 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 
 			rtw_fw_download_rsvd_page(rtwdev);
 			rtw_send_rsvd_page_h2c(rtwdev);
+			rtw_fw_default_port(rtwdev, rtwvif);
 			rtw_coex_media_status_notify(rtwdev, vif->cfg.assoc);
 			if (rtw_bf_support)
 				rtw_bf_assoc(rtwdev, vif, conf);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index d55b041a6bb93..c853e2f2d448f 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -334,12 +334,15 @@ int rtw_sta_add(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 		struct ieee80211_vif *vif)
 {
 	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
+	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
 	int i;
 
 	si->mac_id = rtw_acquire_macid(rtwdev);
 	if (si->mac_id >= RTW_MAX_MAC_ID_NUM)
 		return -ENOSPC;
 
+	if (vif->type == NL80211_IFTYPE_STATION && vif->cfg.assoc == 0)
+		rtwvif->mac_id = si->mac_id;
 	si->rtwdev = rtwdev;
 	si->sta = sta;
 	si->vif = vif;
@@ -2340,6 +2343,9 @@ static void rtw_port_switch_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
 	rtw_dbg(rtwdev, RTW_DBG_STATE, "AP port switch from %d -> %d\n",
 		rtwvif_ap->port, rtwvif_target->port);
 
+	/* Leave LPS so the value swapped are not in PS mode */
+	rtw_leave_lps(rtwdev);
+
 	reg1 = &rtwvif_ap->conf->net_type;
 	reg2 = &rtwvif_target->conf->net_type;
 	rtw_swap_reg_mask(rtwdev, reg1, reg2);
@@ -2358,6 +2364,8 @@ static void rtw_port_switch_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
 
 	swap(rtwvif_target->port, rtwvif_ap->port);
 	swap(rtwvif_target->conf, rtwvif_ap->conf);
+
+	rtw_fw_default_port(rtwdev, rtwvif_target);
 }
 
 void rtw_core_port_switch(struct rtw_dev *rtwdev, struct ieee80211_vif *vif)
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 9e841f6991a9a..f9dd2ab941c8f 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -803,6 +803,7 @@ struct rtw_bf_info {
 struct rtw_vif {
 	enum rtw_net_type net_type;
 	u16 aid;
+	u8 mac_id; /* for STA mode only */
 	u8 mac_addr[ETH_ALEN];
 	u8 bssid[ETH_ALEN];
 	u8 port;
-- 
2.25.1

