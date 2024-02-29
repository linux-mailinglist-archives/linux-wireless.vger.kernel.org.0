Return-Path: <linux-wireless+bounces-4230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5698886C2C9
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 08:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF107281082
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 07:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC1B45C04;
	Thu, 29 Feb 2024 07:46:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215C51037
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 07:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192783; cv=none; b=fJx2cX7XH95OXcpogCqrfswJ5ThAGAo/dxyGwKWh1JJnF5hiRaFDz1DDR8zCnIdqBptop6zJ5H3dShcP3L6beP7SfVVGMK0ktPudmCjSdui3v0hHkP3oVQUtqMIEP0RFW39N4d2RiNYo1NcJ4i2gl2zBFyoCdarE2FteD2kv/UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192783; c=relaxed/simple;
	bh=oxYM/lOmOou4OFvW1tSlDBEUsijTL0P+eNcyAONN7Xg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qiVfG6mVB7B0et59sW8jA4oEKbggXuQQulrED4T7iC9JPpXhj3/Amq4rQvF5w3tWLLnWXQXXSCCM5HsuPj3LlCqOE6QHY5QUTVmOFIP9GbOmdGWtHQ6gOg50UZQYiE2GVIrlvuorg5jVFtq/7ovV1WIEpVAmjkA29MN7gFw/oKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41T7kChdD1229757, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41T7kChdD1229757
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 15:46:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 29 Feb 2024 15:46:13 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 29 Feb
 2024 15:46:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/8] wifi: rtw89: mac: add coexistence helpers {cfg/get}_plt
Date: Thu, 29 Feb 2024 15:45:07 +0800
Message-ID: <20240229074514.219276-2-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

When hardware grant BT initially but transition to grant WiFi, the PLT
(polluted) bit is set to assist coexistence mechanism to debug if
grant signal is expected.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    |  8 +++-
 drivers/net/wireless/realtek/rtw89/mac.h    | 22 ++++++++++-
 drivers/net/wireless/realtek/rtw89/mac_be.c | 41 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    | 14 +++++++
 4 files changed, 81 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 908245ac46bd..288383ee6d1e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5615,7 +5615,8 @@ int rtw89_mac_cfg_gnt_v1(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_mac_cfg_gnt_v1);
 
-int rtw89_mac_cfg_plt(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_plt *plt)
+static
+int rtw89_mac_cfg_plt_ax(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_plt *plt)
 {
 	u32 reg;
 	u16 val;
@@ -5711,7 +5712,7 @@ bool rtw89_mac_get_ctrl_path(struct rtw89_dev *rtwdev)
 	return !!val;
 }
 
-u16 rtw89_mac_get_plt_cnt(struct rtw89_dev *rtwdev, u8 band)
+static u16 rtw89_mac_get_plt_cnt_ax(struct rtw89_dev *rtwdev, u8 band)
 {
 	u32 reg;
 	u16 cnt;
@@ -6340,6 +6341,9 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.parse_phycap_map = rtw89_parse_phycap_map_ax,
 	.cnv_efuse_state = rtw89_cnv_efuse_state_ax,
 
+	.cfg_plt = rtw89_mac_cfg_plt_ax,
+	.get_plt_cnt = rtw89_mac_get_plt_cnt_ax,
+
 	.get_txpwr_cr = rtw89_mac_get_txpwr_cr_ax,
 
 	.write_xtal_si = rtw89_mac_write_xtal_si_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index db95509fad2f..721a57150378 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -958,6 +958,9 @@ struct rtw89_mac_gen_def {
 	int (*parse_phycap_map)(struct rtw89_dev *rtwdev);
 	int (*cnv_efuse_state)(struct rtw89_dev *rtwdev, bool idle);
 
+	int (*cfg_plt)(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_plt *plt);
+	u16 (*get_plt_cnt)(struct rtw89_dev *rtwdev, u8 band);
+
 	bool (*get_txpwr_cr)(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy_idx,
 			     u32 reg_base, u32 *cr);
@@ -1185,8 +1188,23 @@ int rtw89_mac_cfg_gnt(struct rtw89_dev *rtwdev,
 		      const struct rtw89_mac_ax_coex_gnt *gnt_cfg);
 int rtw89_mac_cfg_gnt_v1(struct rtw89_dev *rtwdev,
 			 const struct rtw89_mac_ax_coex_gnt *gnt_cfg);
-int rtw89_mac_cfg_plt(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_plt *plt);
-u16 rtw89_mac_get_plt_cnt(struct rtw89_dev *rtwdev, u8 band);
+
+static inline
+int rtw89_mac_cfg_plt(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_plt *plt)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+
+	return mac->cfg_plt(rtwdev, plt);
+}
+
+static inline
+u16 rtw89_mac_get_plt_cnt(struct rtw89_dev *rtwdev, u8 band)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+
+	return mac->get_plt_cnt(rtwdev, band);
+}
+
 void rtw89_mac_cfg_sb(struct rtw89_dev *rtwdev, u32 val);
 u32 rtw89_mac_get_sb(struct rtw89_dev *rtwdev);
 bool rtw89_mac_get_ctrl_path(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 320e88229971..c68fef0f55f1 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -1797,6 +1797,44 @@ static int trx_init_be(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static
+int rtw89_mac_cfg_plt_be(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_plt *plt)
+{
+	u32 reg;
+	u16 val;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, plt->band, RTW89_CMAC_SEL);
+	if (ret)
+		return ret;
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_BT_PLT, plt->band);
+	val = (plt->tx & RTW89_MAC_AX_PLT_LTE_RX ? B_BE_TX_PLT_GNT_LTE_RX : 0) |
+	      (plt->tx & RTW89_MAC_AX_PLT_GNT_BT_TX ? B_BE_TX_PLT_GNT_BT_TX : 0) |
+	      (plt->tx & RTW89_MAC_AX_PLT_GNT_BT_RX ? B_BE_TX_PLT_GNT_BT_RX : 0) |
+	      (plt->tx & RTW89_MAC_AX_PLT_GNT_WL ? B_BE_TX_PLT_GNT_WL : 0) |
+	      (plt->rx & RTW89_MAC_AX_PLT_LTE_RX ? B_BE_RX_PLT_GNT_LTE_RX : 0) |
+	      (plt->rx & RTW89_MAC_AX_PLT_GNT_BT_TX ? B_BE_RX_PLT_GNT_BT_TX : 0) |
+	      (plt->rx & RTW89_MAC_AX_PLT_GNT_BT_RX ? B_BE_RX_PLT_GNT_BT_RX : 0) |
+	      (plt->rx & RTW89_MAC_AX_PLT_GNT_WL ? B_BE_RX_PLT_GNT_WL : 0) |
+	      B_BE_PLT_EN;
+	rtw89_write16(rtwdev, reg, val);
+
+	return 0;
+}
+
+static u16 rtw89_mac_get_plt_cnt_be(struct rtw89_dev *rtwdev, u8 band)
+{
+	u32 reg;
+	u16 cnt;
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_BT_PLT, band);
+	cnt = rtw89_read32_mask(rtwdev, reg, B_BE_BT_PLT_PKT_CNT_MASK);
+	rtw89_write16_set(rtwdev, reg, B_BE_BT_PLT_RST);
+
+	return cnt;
+}
+
 static int rtw89_set_hw_sch_tx_en_v2(struct rtw89_dev *rtwdev, u8 mac_idx,
 				     u32 tx_en, u32 tx_en_mask)
 {
@@ -2439,6 +2477,9 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.parse_phycap_map = rtw89_parse_phycap_map_be,
 	.cnv_efuse_state = rtw89_cnv_efuse_state_be,
 
+	.cfg_plt = rtw89_mac_cfg_plt_be,
+	.get_plt_cnt = rtw89_mac_get_plt_cnt_be,
+
 	.get_txpwr_cr = rtw89_mac_get_txpwr_cr_be,
 
 	.write_xtal_si = rtw89_mac_write_xtal_si_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 37ccd8ffa87a..c2751391044a 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -6457,6 +6457,20 @@
 #define B_BE_PORT_DROP_4_0_MASK GENMASK(20, 16)
 #define B_BE_MBSSID_DROP_15_0_MASK GENMASK(15, 0)
 
+#define R_BE_BT_PLT 0x1087C
+#define R_BE_BT_PLT_C1 0x1487C
+#define B_BE_BT_PLT_PKT_CNT_MASK GENMASK(31, 16)
+#define B_BE_BT_PLT_RST BIT(9)
+#define B_BE_PLT_EN BIT(8)
+#define B_BE_RX_PLT_GNT_LTE_RX BIT(7)
+#define B_BE_RX_PLT_GNT_BT_RX BIT(6)
+#define B_BE_RX_PLT_GNT_BT_TX BIT(5)
+#define B_BE_RX_PLT_GNT_WL BIT(4)
+#define B_BE_TX_PLT_GNT_LTE_RX BIT(3)
+#define B_BE_TX_PLT_GNT_BT_RX BIT(2)
+#define B_BE_TX_PLT_GNT_BT_TX BIT(1)
+#define B_BE_TX_PLT_GNT_WL BIT(0)
+
 #define R_BE_PTCL_BSS_COLOR_0 0x108A0
 #define R_BE_PTCL_BSS_COLOR_0_C1 0x148A0
 #define B_BE_BSS_COLOB_BE_PORT_3_MASK GENMASK(29, 24)
-- 
2.25.1


