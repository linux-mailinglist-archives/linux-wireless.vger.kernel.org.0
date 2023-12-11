Return-Path: <linux-wireless+bounces-634-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E880E80C354
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 09:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94CBF1F20F07
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 08:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D9320DF4;
	Mon, 11 Dec 2023 08:35:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835B8A0
	for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 00:35:01 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BB8YsCD22598388, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BB8YsCD22598388
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Dec 2023 16:34:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 11 Dec 2023 16:34:54 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 11 Dec
 2023 16:34:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/6] wifi: rtw89: add XTAL SI for WiFi 7 chips
Date: Mon, 11 Dec 2023 16:33:36 +0800
Message-ID: <20231211083341.118047-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211083341.118047-1-pkshih@realtek.com>
References: <20231211083341.118047-1-pkshih@realtek.com>
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

The XTAL SI is a serial interface to indirectly access registers of
analog hardware circuit. Since WiFi 7 chips use different registers, add
a ops to access them via common functions. This patch doesn't change logic
for existing chips.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 11 +++--
 drivers/net/wireless/realtek/rtw89/mac.h    | 21 +++++++-
 drivers/net/wireless/realtek/rtw89/mac_be.c | 54 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    |  8 +++
 4 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 44decdf801a3..2da9c7a9629c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5946,7 +5946,8 @@ int rtw89_mac_set_hw_muedca_ctrl(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
-int rtw89_mac_write_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 mask)
+static
+int rtw89_mac_write_xtal_si_ax(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 mask)
 {
 	u32 val32;
 	int ret;
@@ -5968,9 +5969,9 @@ int rtw89_mac_write_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 mask
 
 	return 0;
 }
-EXPORT_SYMBOL(rtw89_mac_write_xtal_si);
 
-int rtw89_mac_read_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
+static
+int rtw89_mac_read_xtal_si_ax(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
 {
 	u32 val32;
 	int ret;
@@ -5993,7 +5994,6 @@ int rtw89_mac_read_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
 
 	return 0;
 }
-EXPORT_SYMBOL(rtw89_mac_read_xtal_si);
 
 static
 void rtw89_mac_pkt_drop_sta(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta)
@@ -6127,6 +6127,9 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 
 	.get_txpwr_cr = rtw89_mac_get_txpwr_cr_ax,
 
+	.write_xtal_si = rtw89_mac_write_xtal_si_ax,
+	.read_xtal_si = rtw89_mac_read_xtal_si_ax,
+
 	.dump_qta_lost = rtw89_mac_dump_qta_lost_ax,
 	.dump_err_status = rtw89_mac_dump_err_status_ax,
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 18b285d9d96f..70071b5243c6 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -935,6 +935,9 @@ struct rtw89_mac_gen_def {
 			     enum rtw89_phy_idx phy_idx,
 			     u32 reg_base, u32 *cr);
 
+	int (*write_xtal_si)(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 mask);
+	int (*read_xtal_si)(struct rtw89_dev *rtwdev, u8 offset, u8 *val);
+
 	void (*dump_qta_lost)(struct rtw89_dev *rtwdev);
 	void (*dump_err_status)(struct rtw89_dev *rtwdev,
 				enum mac_ax_err_info err);
@@ -1296,8 +1299,22 @@ enum rtw89_mac_xtal_si_offset {
 #define FULL_BIT_MASK		GENMASK(7, 0)
 };
 
-int rtw89_mac_write_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 mask);
-int rtw89_mac_read_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 *val);
+static inline
+int rtw89_mac_write_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 mask)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+
+	return mac->write_xtal_si(rtwdev, offset, val, mask);
+}
+
+static inline
+int rtw89_mac_read_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+
+	return mac->read_xtal_si(rtwdev, offset, val);
+}
+
 void rtw89_mac_pkt_drop_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 int rtw89_mac_typ_fltr_opt(struct rtw89_dev *rtwdev,
 			   enum rtw89_machdr_frame_type type,
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 7ad509787d72..23180d222623 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -348,6 +348,57 @@ static void rtw89_mac_dmac_func_pre_en_be(struct rtw89_dev *rtwdev)
 	rtw89_write32_set(rtwdev, R_BE_DMAC_TABLE_CTRL, B_BE_DMAC_ADDR_MODE);
 }
 
+static
+int rtw89_mac_write_xtal_si_be(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 mask)
+{
+	u32 val32;
+	int ret;
+
+	val32 = u32_encode_bits(offset, B_BE_WL_XTAL_SI_ADDR_MASK) |
+		u32_encode_bits(val, B_BE_WL_XTAL_SI_DATA_MASK) |
+		u32_encode_bits(mask, B_BE_WL_XTAL_SI_BITMASK_MASK) |
+		u32_encode_bits(XTAL_SI_NORMAL_WRITE, B_BE_WL_XTAL_SI_MODE_MASK) |
+		u32_encode_bits(0, B_BE_WL_XTAL_SI_CHIPID_MASK) |
+		B_BE_WL_XTAL_SI_CMD_POLL;
+	rtw89_write32(rtwdev, R_BE_WLAN_XTAL_SI_CTRL, val32);
+
+	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_BE_WL_XTAL_SI_CMD_POLL),
+				50, 50000, false, rtwdev, R_BE_WLAN_XTAL_SI_CTRL);
+	if (ret) {
+		rtw89_warn(rtwdev, "xtal si not ready(W): offset=%x val=%x mask=%x\n",
+			   offset, val, mask);
+		return ret;
+	}
+
+	return 0;
+}
+
+static
+int rtw89_mac_read_xtal_si_be(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
+{
+	u32 val32;
+	int ret;
+
+	val32 = u32_encode_bits(offset, B_BE_WL_XTAL_SI_ADDR_MASK) |
+		u32_encode_bits(0x0, B_BE_WL_XTAL_SI_DATA_MASK) |
+		u32_encode_bits(0x0, B_BE_WL_XTAL_SI_BITMASK_MASK) |
+		u32_encode_bits(XTAL_SI_NORMAL_READ, B_BE_WL_XTAL_SI_MODE_MASK) |
+		u32_encode_bits(0, B_BE_WL_XTAL_SI_CHIPID_MASK) |
+		B_BE_WL_XTAL_SI_CMD_POLL;
+	rtw89_write32(rtwdev, R_BE_WLAN_XTAL_SI_CTRL, val32);
+
+	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_BE_WL_XTAL_SI_CMD_POLL),
+				50, 50000, false, rtwdev, R_BE_WLAN_XTAL_SI_CTRL);
+	if (ret) {
+		rtw89_warn(rtwdev, "xtal si not ready(R): offset=%x\n", offset);
+		return ret;
+	}
+
+	*val = rtw89_read8(rtwdev, R_BE_WLAN_XTAL_SI_CTRL + 1);
+
+	return 0;
+}
+
 static void rtw89_mac_disable_cpu_be(struct rtw89_dev *rtwdev)
 {
 	u32 val32;
@@ -1121,6 +1172,9 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 
 	.get_txpwr_cr = rtw89_mac_get_txpwr_cr_be,
 
+	.write_xtal_si = rtw89_mac_write_xtal_si_be,
+	.read_xtal_si = rtw89_mac_read_xtal_si_be,
+
 	.dump_qta_lost = rtw89_mac_dump_qta_lost_be,
 	.dump_err_status = rtw89_mac_dump_err_status_be,
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 2f2ac0748ce0..eb40bfed9ed4 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4085,6 +4085,14 @@
 #define R_BE_UDM2 0x01F8
 #define B_BE_UDM2_EPC_RA_MASK GENMASK(31, 0)
 
+#define R_BE_WLAN_XTAL_SI_CTRL 0x0270
+#define B_BE_WL_XTAL_SI_CMD_POLL BIT(31)
+#define B_BE_WL_XTAL_SI_CHIPID_MASK GENMASK(30, 28)
+#define B_BE_WL_XTAL_SI_MODE_MASK GENMASK(25, 24)
+#define B_BE_WL_XTAL_SI_BITMASK_MASK GENMASK(23, 16)
+#define B_BE_WL_XTAL_SI_DATA_MASK GENMASK(15, 8)
+#define B_BE_WL_XTAL_SI_ADDR_MASK GENMASK(7, 0)
+
 #define R_BE_IC_PWR_STATE 0x03F0
 #define B_BE_WHOLE_SYS_PWR_STE_MASK GENMASK(25, 16)
 #define MAC_AX_SYS_ACT 0x220
-- 
2.25.1


