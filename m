Return-Path: <linux-wireless+bounces-193-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAE47FCFA6
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 08:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E0B1C20F71
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 07:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF601094F;
	Wed, 29 Nov 2023 07:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA62419AB
	for <linux-wireless@vger.kernel.org>; Tue, 28 Nov 2023 23:02:08 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AT71tCaA2598092, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AT71tCaA2598092
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Nov 2023 15:01:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 29 Nov 2023 15:01:56 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 29 Nov
 2023 15:01:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/4] wifi: rtw89: fix not entering PS mode after AP stops
Date: Wed, 29 Nov 2023 15:00:43 +0800
Message-ID: <20231129070046.18443-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231129070046.18443-1-pkshih@realtek.com>
References: <20231129070046.18443-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

From: Po-Hao Huang <phhuang@realtek.com>

The attempt to enter power save mode might fail if there are still
beacons pending in the queue. This sometimes happens after stopping
P2P GO or AP mode. Extend stop AP function and flush all beacons to
resolve this.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 71 ++++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/reg.h | 17 ++++++
 2 files changed, 82 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 9ec307051611..23d41398be87 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3754,6 +3754,50 @@ static const struct rtw89_port_reg rtw89_port_base_ax = {
 		    R_AX_PORT_HGQ_WINDOW_CFG + 3},
 };
 
+static void rtw89_mac_check_packet_ctrl(struct rtw89_dev *rtwdev,
+					struct rtw89_vif *rtwvif, u8 type)
+{
+	u8 mask = B_AX_PTCL_DBG_INFO_MASK_BY_PORT(rtwvif->port);
+	u32 reg_info, reg_ctrl;
+	u32 val;
+	int ret;
+
+	reg_info = rtw89_mac_reg_by_idx(rtwdev, R_AX_PTCL_DBG_INFO, rtwvif->mac_idx);
+	reg_ctrl = rtw89_mac_reg_by_idx(rtwdev, R_AX_PTCL_DBG, rtwvif->mac_idx);
+
+	rtw89_write32_mask(rtwdev, reg_ctrl, B_AX_PTCL_DBG_SEL_MASK, type);
+	rtw89_write32_set(rtwdev, reg_ctrl, B_AX_PTCL_DBG_EN);
+	fsleep(100);
+
+	ret = read_poll_timeout(rtw89_read32_mask, val, val == 0, 1000, 100000,
+				true, rtwdev, reg_info, mask);
+	if (ret)
+		rtw89_warn(rtwdev, "Polling beacon packet empty fail\n");
+}
+
+static void rtw89_mac_bcn_drop(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_port_reg *p = mac->port_base;
+
+	rtw89_write32_set(rtwdev, R_AX_BCN_DROP_ALL0, BIT(rtwvif->port));
+	rtw89_write32_port_mask(rtwdev, rtwvif, p->tbtt_prohib, B_AX_TBTT_SETUP_MASK, 1);
+	rtw89_write32_port_mask(rtwdev, rtwvif, p->bcn_area, B_AX_BCN_MSK_AREA_MASK, 0);
+	rtw89_write32_port_mask(rtwdev, rtwvif, p->tbtt_prohib, B_AX_TBTT_HOLD_MASK, 0);
+	rtw89_write32_port_mask(rtwdev, rtwvif, p->bcn_early, B_AX_BCNERLY_MASK, 2);
+	rtw89_write16_port_mask(rtwdev, rtwvif, p->tbtt_early, B_AX_TBTTERLY_MASK, 1);
+	rtw89_write32_port_mask(rtwdev, rtwvif, p->bcn_space, B_AX_BCN_SPACE_MASK, 1);
+	rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, B_AX_BCNTX_EN);
+
+	rtw89_mac_check_packet_ctrl(rtwdev, rtwvif, AX_PTCL_DBG_BCNQ_NUM0);
+	if (rtwvif->port == RTW89_PORT_0)
+		rtw89_mac_check_packet_ctrl(rtwdev, rtwvif, AX_PTCL_DBG_BCNQ_NUM1);
+
+	rtw89_write32_clr(rtwdev, R_AX_BCN_DROP_ALL0, BIT(rtwvif->port));
+	rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, B_AX_TBTT_PROHIB_EN);
+	fsleep(2);
+}
+
 #define BCN_INTERVAL 100
 #define BCN_ERLY_DEF 160
 #define BCN_SETUP_DEF 2
@@ -3769,21 +3813,36 @@ static void rtw89_mac_port_cfg_func_sw(struct rtw89_dev *rtwdev,
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_port_reg *p = mac->port_base;
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	bool need_backup = false;
+	u32 backup_val;
 
 	if (!rtw89_read32_port_mask(rtwdev, rtwvif, p->port_cfg, B_AX_PORT_FUNC_EN))
 		return;
 
-	rtw89_write32_port_clr(rtwdev, rtwvif, p->tbtt_prohib, B_AX_TBTT_SETUP_MASK);
-	rtw89_write32_port_mask(rtwdev, rtwvif, p->tbtt_prohib, B_AX_TBTT_HOLD_MASK, 1);
-	rtw89_write16_port_clr(rtwdev, rtwvif, p->tbtt_early, B_AX_TBTTERLY_MASK);
-	rtw89_write16_port_clr(rtwdev, rtwvif, p->bcn_early, B_AX_BCNERLY_MASK);
+	if (chip->chip_id == RTL8852A && rtwvif->port != RTW89_PORT_0) {
+		need_backup = true;
+		backup_val = rtw89_read32_port(rtwdev, rtwvif, p->tbtt_prohib);
+	}
 
-	msleep(vif->bss_conf.beacon_int + 1);
+	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE)
+		rtw89_mac_bcn_drop(rtwdev, rtwvif);
+
+	if (chip->chip_id == RTL8852A) {
+		rtw89_write32_port_clr(rtwdev, rtwvif, p->tbtt_prohib, B_AX_TBTT_SETUP_MASK);
+		rtw89_write32_port_mask(rtwdev, rtwvif, p->tbtt_prohib, B_AX_TBTT_HOLD_MASK, 1);
+		rtw89_write16_port_clr(rtwdev, rtwvif, p->tbtt_early, B_AX_TBTTERLY_MASK);
+		rtw89_write16_port_clr(rtwdev, rtwvif, p->bcn_early, B_AX_BCNERLY_MASK);
+	}
 
+	msleep(vif->bss_conf.beacon_int + 1);
 	rtw89_write32_port_clr(rtwdev, rtwvif, p->port_cfg, B_AX_PORT_FUNC_EN |
 							    B_AX_BRK_SETUP);
 	rtw89_write32_port_set(rtwdev, rtwvif, p->port_cfg, B_AX_TSFTR_RST);
 	rtw89_write32_port(rtwdev, rtwvif, p->bcn_cnt_tmr, 0);
+
+	if (need_backup)
+		rtw89_write32_port(rtwdev, rtwvif, p->tbtt_prohib, backup_val);
 }
 
 static void rtw89_mac_port_cfg_tx_rpt(struct rtw89_dev *rtwdev,
@@ -4268,7 +4327,7 @@ void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 
 void rtw89_mac_stop_ap(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
-	rtw89_mac_port_cfg_func_en(rtwdev, rtwvif, false);
+	rtw89_mac_port_cfg_func_sw(rtwdev, rtwvif);
 }
 
 int rtw89_mac_add_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 7a9ae6cd86e5..692644d0769e 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -2376,6 +2376,14 @@
 #define R_AX_TSFTR_HIGH_P4 0xC53C
 #define B_AX_TSFTR_HIGH_MASK GENMASK(31, 0)
 
+#define R_AX_BCN_DROP_ALL0 0xC560
+#define R_AX_BCN_DROP_ALL0_C1 0xE560
+#define B_AX_BCN_DROP_ALL_P4 BIT(4)
+#define B_AX_BCN_DROP_ALL_P3 BIT(3)
+#define B_AX_BCN_DROP_ALL_P2 BIT(2)
+#define B_AX_BCN_DROP_ALL_P1 BIT(1)
+#define B_AX_BCN_DROP_ALL_P0 BIT(0)
+
 #define R_AX_MBSSID_CTRL 0xC568
 #define R_AX_MBSSID_CTRL_C1 0xE568
 #define B_AX_P0MB_ALL_MASK GENMASK(23, 1)
@@ -2555,11 +2563,20 @@
 
 #define R_AX_PTCL_DBG_INFO 0xC6F0
 #define R_AX_PTCL_DBG_INFO_C1 0xE6F0
+#define B_AX_PTCL_DBG_INFO_MASK_BY_PORT(port) \
+({\
+	typeof(port) _port = (port); \
+	GENMASK((_port) * 2 + 1, (_port) * 2); \
+})
+
 #define B_AX_PTCL_DBG_INFO_MASK GENMASK(31, 0)
 #define R_AX_PTCL_DBG 0xC6F4
 #define R_AX_PTCL_DBG_C1 0xE6F4
 #define B_AX_PTCL_DBG_EN BIT(8)
 #define B_AX_PTCL_DBG_SEL_MASK GENMASK(7, 0)
+#define AX_PTCL_DBG_BCNQ_NUM0 8
+#define AX_PTCL_DBG_BCNQ_NUM1 9
+
 
 #define R_AX_DLE_CTRL 0xC800
 #define R_AX_DLE_CTRL_C1 0xE800
-- 
2.25.1


