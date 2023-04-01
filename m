Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA22D6D30C6
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Apr 2023 14:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjDAMpv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Apr 2023 08:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjDAMps (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Apr 2023 08:45:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F2620C06
        for <linux-wireless@vger.kernel.org>; Sat,  1 Apr 2023 05:45:45 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 331CjDwY5021665, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 331CjDwY5021665
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 1 Apr 2023 20:45:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Sat, 1 Apr 2023 20:45:31 +0800
Received: from localhost (172.16.16.15) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 1 Apr 2023
 20:45:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/7] wifi: rtw88: add port switch for AP mode
Date:   Sat, 1 Apr 2023 20:44:05 +0800
Message-ID: <20230401124410.33221-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230401124410.33221-1-pkshih@realtek.com>
References: <20230401124410.33221-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.15]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Switch port settings if AP mode does not start on port 0 because of
hardware limitation. For some ICs, beacons on ports other than zero
could misbehave and do not issue properly, to fix this we change AP
VIFs to port zero when multiple interfaces is active.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c |  1 +
 drivers/net/wireless/realtek/rtw88/main.c     | 79 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 3 files changed, 81 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index d026094a72c40..19c4d7c29759e 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -212,6 +212,7 @@ static int rtw_ops_add_interface(struct ieee80211_hw *hw,
 	rtwvif->bcn_ctrl = bcn_ctrl;
 	config |= PORT_SET_BCN_CTRL;
 	rtw_vif_port_config(rtwdev, rtwvif, config);
+	rtw_core_port_switch(rtwdev, vif);
 
 	mutex_unlock(&rtwdev->mutex);
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 39b18c7468c9e..ba05a5d68d05e 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -2244,6 +2244,85 @@ void rtw_unregister_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 }
 EXPORT_SYMBOL(rtw_unregister_hw);
 
+static
+void rtw_swap_reg_nbytes(struct rtw_dev *rtwdev, const struct rtw_hw_reg *reg1,
+			 const struct rtw_hw_reg *reg2, u8 nbytes)
+{
+	u8 i;
+
+	for (i = 0; i < nbytes; i++) {
+		u8 v1 = rtw_read8(rtwdev, reg1->addr + i);
+		u8 v2 = rtw_read8(rtwdev, reg2->addr + i);
+
+		rtw_write8(rtwdev, reg1->addr + i, v2);
+		rtw_write8(rtwdev, reg2->addr + i, v1);
+	}
+}
+
+static
+void rtw_swap_reg_mask(struct rtw_dev *rtwdev, const struct rtw_hw_reg *reg1,
+		       const struct rtw_hw_reg *reg2)
+{
+	u32 v1, v2;
+
+	v1 = rtw_read32_mask(rtwdev, reg1->addr, reg1->mask);
+	v2 = rtw_read32_mask(rtwdev, reg2->addr, reg2->mask);
+	rtw_write32_mask(rtwdev, reg2->addr, reg2->mask, v1);
+	rtw_write32_mask(rtwdev, reg1->addr, reg1->mask, v2);
+}
+
+struct rtw_iter_port_switch_data {
+	struct rtw_dev *rtwdev;
+	struct rtw_vif *rtwvif_ap;
+};
+
+static void rtw_port_switch_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct rtw_iter_port_switch_data *iter_data = data;
+	struct rtw_dev *rtwdev = iter_data->rtwdev;
+	struct rtw_vif *rtwvif_target = (struct rtw_vif *)vif->drv_priv;
+	struct rtw_vif *rtwvif_ap = iter_data->rtwvif_ap;
+	const struct rtw_hw_reg *reg1, *reg2;
+
+	if (rtwvif_target->port != RTW_PORT_0)
+		return;
+
+	rtw_info(rtwdev, "AP port switch from %d -> %d\n", rtwvif_ap->port,
+		 rtwvif_target->port);
+
+	reg1 = &rtwvif_ap->conf->net_type;
+	reg2 = &rtwvif_target->conf->net_type;
+	rtw_swap_reg_mask(rtwdev, reg1, reg2);
+
+	reg1 = &rtwvif_ap->conf->mac_addr;
+	reg2 = &rtwvif_target->conf->mac_addr;
+	rtw_swap_reg_nbytes(rtwdev, reg1, reg2, ETH_ALEN);
+
+	reg1 = &rtwvif_ap->conf->bssid;
+	reg2 = &rtwvif_target->conf->bssid;
+	rtw_swap_reg_nbytes(rtwdev, reg1, reg2, ETH_ALEN);
+
+	reg1 = &rtwvif_ap->conf->bcn_ctrl;
+	reg2 = &rtwvif_target->conf->bcn_ctrl;
+	rtw_swap_reg_nbytes(rtwdev, reg1, reg2, 1);
+
+	swap(rtwvif_target->port, rtwvif_ap->port);
+	swap(rtwvif_target->conf, rtwvif_ap->conf);
+}
+
+void rtw_core_port_switch(struct rtw_dev *rtwdev, struct ieee80211_vif *vif)
+{
+	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
+	struct rtw_iter_port_switch_data iter_data;
+
+	if (vif->type != NL80211_IFTYPE_AP || rtwvif->port == RTW_PORT_0)
+		return;
+
+	iter_data.rtwdev = rtwdev;
+	iter_data.rtwvif_ap = rtwvif;
+	rtw_iterate_vifs(rtwdev, rtw_port_switch_iter, &iter_data);
+}
+
 MODULE_AUTHOR("Realtek Corporation");
 MODULE_DESCRIPTION("Realtek 802.11ac wireless core module");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index efac271497f5b..790ebf781bc41 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -2198,4 +2198,5 @@ void rtw_set_txrx_1ss(struct rtw_dev *rtwdev, bool config_1ss);
 void rtw_update_channel(struct rtw_dev *rtwdev, u8 center_channel,
 			u8 primary_channel, enum rtw_supported_band band,
 			enum rtw_bandwidth bandwidth);
+void rtw_core_port_switch(struct rtw_dev *rtwdev, struct ieee80211_vif *vif);
 #endif
-- 
2.25.1

