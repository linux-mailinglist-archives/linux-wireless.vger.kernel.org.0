Return-Path: <linux-wireless+bounces-4231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 074D486C2CA
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 08:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE701C2130D
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 07:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D74B4D110;
	Thu, 29 Feb 2024 07:46:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C35481BF
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192785; cv=none; b=Le55Xi0JWygwTHa1FeAgKILqE4kaWYW9/tQDve9MrpREQ7wjb7tlXKx1iTQHBUo86UJc8j3tZzfYm0eoIKpruvd7XoskcJ2wTPINq8yd/kRFaQ7DaofhgqTIp1yCZ4GtiAHIT6yYXX72uLQiPVKY8yiA8UyXdfAu4iHtBMEziRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192785; c=relaxed/simple;
	bh=puVNhTK/zM11r0hXWu0x5CnjJZbzvhVrpGMmNZzL4hk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hg+0PKX/mDF36rgGCPzcKZDqDbpIfyXshnQ9DeqdFV1IQKkXpL+q6VWvwC9hqRA74Dpi9F1h9HlhyjMg2XcyWlD9NZopMl1thocty7o1iPYYyR82QCPS5bz9WRK3+0Rn7fSxgpXurJ7vFTSo4YGWXrGbC8Sflej8pu0Px0CyQ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41T7kGkuD1229760, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41T7kGkuD1229760
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 15:46:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 29 Feb 2024 15:46:17 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Feb
 2024 15:46:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/8] wifi: rtw89: 8922a: add coexistence helpers of SW grant
Date: Thu, 29 Feb 2024 15:45:08 +0800
Message-ID: <20240229074514.219276-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240229074514.219276-1-pkshih@realtek.com>
References: <20240229074514.219276-1-pkshih@realtek.com>
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

Under some circumstances, coexistence mechanism want to keep grant BT or
WiFi, such as inquiry and WiFi is connecting, to ensure BT or WiFi can
transmit or receive data in that period.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  6 ++
 drivers/net/wireless/realtek/rtw89/mac.h      |  3 +
 drivers/net/wireless/realtek/rtw89/mac_be.c   | 76 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h      | 28 +++++++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  2 +
 5 files changed, 115 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d62d23015c48..2bf1e4e95c0f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1151,9 +1151,15 @@ struct rtw89_mac_ax_gnt {
 	u8 gnt_wl;
 } __packed;
 
+struct rtw89_mac_ax_wl_act {
+	u8 wlan_act_en;
+	u8 wlan_act;
+};
+
 #define RTW89_MAC_AX_COEX_GNT_NR 2
 struct rtw89_mac_ax_coex_gnt {
 	struct rtw89_mac_ax_gnt band[RTW89_MAC_AX_COEX_GNT_NR];
+	struct rtw89_mac_ax_wl_act bt[RTW89_MAC_AX_COEX_GNT_NR];
 };
 
 enum rtw89_btc_ncnt {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 721a57150378..c55b7e4918eb 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1188,6 +1188,8 @@ int rtw89_mac_cfg_gnt(struct rtw89_dev *rtwdev,
 		      const struct rtw89_mac_ax_coex_gnt *gnt_cfg);
 int rtw89_mac_cfg_gnt_v1(struct rtw89_dev *rtwdev,
 			 const struct rtw89_mac_ax_coex_gnt *gnt_cfg);
+int rtw89_mac_cfg_gnt_v2(struct rtw89_dev *rtwdev,
+			 const struct rtw89_mac_ax_coex_gnt *gnt_cfg);
 
 static inline
 int rtw89_mac_cfg_plt(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_plt *plt)
@@ -1210,6 +1212,7 @@ u32 rtw89_mac_get_sb(struct rtw89_dev *rtwdev);
 bool rtw89_mac_get_ctrl_path(struct rtw89_dev *rtwdev);
 int rtw89_mac_cfg_ctrl_path(struct rtw89_dev *rtwdev, bool wl);
 int rtw89_mac_cfg_ctrl_path_v1(struct rtw89_dev *rtwdev, bool wl);
+int rtw89_mac_cfg_ctrl_path_v2(struct rtw89_dev *rtwdev, bool wl);
 void rtw89_mac_power_mode_change(struct rtw89_dev *rtwdev, bool enter);
 void rtw89_mac_notify_wake(struct rtw89_dev *rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index c68fef0f55f1..7ca94b70a9cb 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -1797,6 +1797,82 @@ static int trx_init_be(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+int rtw89_mac_cfg_gnt_v2(struct rtw89_dev *rtwdev,
+			 const struct rtw89_mac_ax_coex_gnt *gnt_cfg)
+{
+	u32 val = 0;
+
+	if (gnt_cfg->band[0].gnt_bt)
+		val |= B_BE_GNT_BT_BB0_VAL | B_BE_GNT_BT_RX_BB0_VAL |
+		       B_BE_GNT_BT_TX_BB0_VAL;
+
+	if (gnt_cfg->band[0].gnt_bt_sw_en)
+		val |= B_BE_GNT_BT_BB0_SWCTRL | B_BE_GNT_BT_RX_BB0_SWCTRL |
+		       B_BE_GNT_BT_TX_BB0_SWCTRL;
+
+	if (gnt_cfg->band[0].gnt_wl)
+		val |= B_BE_GNT_WL_BB0_VAL | B_BE_GNT_WL_RX_VAL |
+		       B_BE_GNT_WL_TX_VAL | B_BE_GNT_WL_BB_PWR_VAL;
+
+	if (gnt_cfg->band[0].gnt_wl_sw_en)
+		val |= B_BE_GNT_WL_BB0_SWCTRL | B_BE_GNT_WL_RX_SWCTRL |
+		       B_BE_GNT_WL_TX_SWCTRL | B_BE_GNT_WL_BB_PWR_SWCTRL;
+
+	if (gnt_cfg->band[1].gnt_bt)
+		val |= B_BE_GNT_BT_BB1_VAL | B_BE_GNT_BT_RX_BB1_VAL |
+		       B_BE_GNT_BT_TX_BB1_VAL;
+
+	if (gnt_cfg->band[1].gnt_bt_sw_en)
+		val |= B_BE_GNT_BT_BB1_SWCTRL | B_BE_GNT_BT_RX_BB1_SWCTRL |
+		       B_BE_GNT_BT_TX_BB1_SWCTRL;
+
+	if (gnt_cfg->band[1].gnt_wl)
+		val |= B_BE_GNT_WL_BB1_VAL | B_BE_GNT_WL_RX_VAL |
+		       B_BE_GNT_WL_TX_VAL | B_BE_GNT_WL_BB_PWR_VAL;
+
+	if (gnt_cfg->band[1].gnt_wl_sw_en)
+		val |= B_BE_GNT_WL_BB1_SWCTRL | B_BE_GNT_WL_RX_SWCTRL |
+		       B_BE_GNT_WL_TX_SWCTRL | B_BE_GNT_WL_BB_PWR_SWCTRL;
+
+	if (gnt_cfg->bt[0].wlan_act_en)
+		val |= B_BE_WL_ACT_SWCTRL;
+	if (gnt_cfg->bt[0].wlan_act)
+		val |= B_BE_WL_ACT_VAL;
+	if (gnt_cfg->bt[1].wlan_act_en)
+		val |= B_BE_WL_ACT2_SWCTRL;
+	if (gnt_cfg->bt[1].wlan_act)
+		val |= B_BE_WL_ACT2_VAL;
+
+	rtw89_write32(rtwdev, R_BE_GNT_SW_CTRL, val);
+
+	return 0;
+}
+EXPORT_SYMBOL(rtw89_mac_cfg_gnt_v2);
+
+int rtw89_mac_cfg_ctrl_path_v2(struct rtw89_dev *rtwdev, bool wl)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_mac_ax_gnt *g = dm->gnt.band;
+	struct rtw89_mac_ax_wl_act *gbt = dm->gnt.bt;
+	int i;
+
+	if (wl)
+		return 0;
+
+	for (i = 0; i < RTW89_PHY_MAX; i++) {
+		g[i].gnt_bt_sw_en = 1;
+		g[i].gnt_bt = 1;
+		g[i].gnt_wl_sw_en = 1;
+		g[i].gnt_wl = 0;
+		gbt[i].wlan_act = 1;
+		gbt[i].wlan_act_en = 0;
+	}
+
+	return rtw89_mac_cfg_gnt_v2(rtwdev, &dm->gnt);
+}
+EXPORT_SYMBOL(rtw89_mac_cfg_ctrl_path_v2);
+
 static
 int rtw89_mac_cfg_plt_be(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_plt *plt)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index c2751391044a..a7f7703a2556 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -5932,6 +5932,34 @@
 #define B_BE_MACID_ACQ_GRP0_CLR_P BIT(2)
 #define B_BE_R_MACID_ACQ_CHK_EN BIT(0)
 
+#define R_BE_GNT_SW_CTRL 0x0E348
+#define B_BE_WL_ACT2_VAL BIT(25)
+#define B_BE_WL_ACT2_SWCTRL BIT(24)
+#define B_BE_WL_ACT_VAL BIT(23)
+#define B_BE_WL_ACT_SWCTRL BIT(22)
+#define B_BE_GNT_BT_RX_BB1_VAL BIT(21)
+#define B_BE_GNT_BT_RX_BB1_SWCTRL BIT(20)
+#define B_BE_GNT_BT_TX_BB1_VAL BIT(19)
+#define B_BE_GNT_BT_TX_BB1_SWCTRL BIT(18)
+#define B_BE_GNT_BT_RX_BB0_VAL BIT(17)
+#define B_BE_GNT_BT_RX_BB0_SWCTRL BIT(16)
+#define B_BE_GNT_BT_TX_BB0_VAL BIT(15)
+#define B_BE_GNT_BT_TX_BB0_SWCTRL BIT(14)
+#define B_BE_GNT_WL_RX_VAL BIT(13)
+#define B_BE_GNT_WL_RX_SWCTRL BIT(12)
+#define B_BE_GNT_WL_TX_VAL BIT(11)
+#define B_BE_GNT_WL_TX_SWCTRL BIT(10)
+#define B_BE_GNT_BT_BB1_VAL BIT(9)
+#define B_BE_GNT_BT_BB1_SWCTRL BIT(8)
+#define B_BE_GNT_WL_BB1_VAL BIT(7)
+#define B_BE_GNT_WL_BB1_SWCTRL BIT(6)
+#define B_BE_GNT_BT_BB0_VAL BIT(5)
+#define B_BE_GNT_BT_BB0_SWCTRL BIT(4)
+#define B_BE_GNT_WL_BB0_VAL BIT(3)
+#define B_BE_GNT_WL_BB0_SWCTRL BIT(2)
+#define B_BE_GNT_WL_BB_PWR_VAL BIT(1)
+#define B_BE_GNT_WL_BB_PWR_SWCTRL BIT(0)
+
 #define R_BE_PWR_MACID_PATH_BASE 0x0E500
 #define R_BE_PWR_MACID_LMT_BASE 0x0ED00
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 823f0d840df9..0e99ecea32a3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2246,6 +2246,8 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.query_rxdesc		= rtw89_core_query_rxdesc_v2,
 	.fill_txdesc		= rtw89_core_fill_txdesc_v2,
 	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc_fwcmd_v2,
+	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path_v2,
+	.mac_cfg_gnt		= rtw89_mac_cfg_gnt_v2,
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx_v2,
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx_v2,
 	.h2c_dctl_sec_cam	= rtw89_fw_h2c_dctl_sec_cam_v2,
-- 
2.25.1


