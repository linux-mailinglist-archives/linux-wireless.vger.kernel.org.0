Return-Path: <linux-wireless+bounces-1517-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9411E824EBE
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 07:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BA32846B3
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 06:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D0B7E;
	Fri,  5 Jan 2024 06:44:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E0620B09
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jan 2024 06:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4056iZttD2211731, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4056iZttD2211731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jan 2024 14:44:35 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 5 Jan 2024 14:44:36 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 5 Jan 2024
 14:44:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <cj.hsieh@realtek.com>, <hsuan8331@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/8] wifi: rtw89: phy: add BB wrapper of TX power for WiFi 7 chips
Date: Fri, 5 Jan 2024 14:44:33 +0800
Message-ID: <20240105064433.36870-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240105064228.36580-1-pkshih@realtek.com>
References: <20240105064228.36580-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

TX power is controlled by BB layer basically, but it should interact with
MAC layer, so these registers are put on MAC register domain and called
BB wrapper, which contains TX power for each MAC ID, OFDMA RU power, and
consideration of power type table.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c    |   2 +
 drivers/net/wireless/realtek/rtw89/phy.h    |   9 ++
 drivers/net/wireless/realtek/rtw89/phy_be.c | 106 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    |  47 +++++++++
 4 files changed, 164 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index e9baa939d987..69debc156edb 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4966,6 +4966,7 @@ void rtw89_phy_dm_init(struct rtw89_dev *rtwdev)
 	rtw89_physts_parsing_init(rtwdev);
 	rtw89_phy_dig_init(rtwdev);
 	rtw89_phy_cfo_init(rtwdev);
+	rtw89_phy_bb_wrap_init(rtwdev);
 	rtw89_phy_edcca_init(rtwdev);
 	rtw89_phy_ul_tb_info_init(rtwdev);
 	rtw89_phy_antdiv_init(rtwdev);
@@ -5491,6 +5492,7 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_ax = {
 	.cfo = &rtw89_cfo_regs_ax,
 	.config_bb_gain = rtw89_phy_config_bb_gain_ax,
 	.preinit_rf_nctl = rtw89_phy_preinit_rf_nctl_ax,
+	.bb_wrap_init = NULL,
 
 	.set_txpwr_byrate = rtw89_phy_set_txpwr_byrate_ax,
 	.set_txpwr_offset = rtw89_phy_set_txpwr_offset_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 5347aba994df..2ffd33b078b2 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -514,6 +514,7 @@ struct rtw89_phy_gen_def {
 			       enum rtw89_rf_path rf_path,
 			       void *extra_data);
 	void (*preinit_rf_nctl)(struct rtw89_dev *rtwdev);
+	void (*bb_wrap_init)(struct rtw89_dev *rtwdev);
 
 	void (*set_txpwr_byrate)(struct rtw89_dev *rtwdev,
 				 const struct rtw89_chan *chan,
@@ -803,6 +804,14 @@ static inline void rtw89_phy_preinit_rf_nctl(struct rtw89_dev *rtwdev)
 	phy->preinit_rf_nctl(rtwdev);
 }
 
+static inline void rtw89_phy_bb_wrap_init(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+
+	if (phy->bb_wrap_init)
+		phy->bb_wrap_init(rtwdev);
+}
+
 static inline
 void rtw89_phy_set_txpwr_byrate(struct rtw89_dev *rtwdev,
 				const struct rtw89_chan *chan,
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 0f61d86c5e8f..e8ce29de1c52 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -270,6 +270,111 @@ static void rtw89_phy_preinit_rf_nctl_be(struct rtw89_dev *rtwdev)
 	}
 }
 
+static
+void rtw89_phy_bb_wrap_pwr_by_macid_init(struct rtw89_dev *rtwdev)
+{
+	u32 macid_idx, cr, base_macid_lmt, max_macid = 32;
+
+	base_macid_lmt = R_BE_PWR_MACID_LMT_BASE;
+
+	for (macid_idx = 0; macid_idx < 4 * max_macid; macid_idx += 4) {
+		cr = base_macid_lmt + macid_idx;
+		rtw89_write32(rtwdev, cr, 0x03007F7F);
+	}
+}
+
+static
+void rtw89_phy_bb_wrap_tx_path_by_macid_init(struct rtw89_dev *rtwdev)
+{
+	int i, max_macid = 32;
+	u32 cr = R_BE_PWR_MACID_PATH_BASE;
+
+	for (i = 0; i < max_macid; i++, cr += 4)
+		rtw89_write32(rtwdev, cr, 0x03C86000);
+}
+
+static void rtw89_phy_bb_wrap_tpu_set_all(struct rtw89_dev *rtwdev,
+					  enum rtw89_mac_idx mac_idx)
+{
+	u32 addr;
+
+	for (addr = R_BE_PWR_BY_RATE; addr <= R_BE_PWR_BY_RATE_END; addr += 4)
+		rtw89_write32(rtwdev, addr, 0);
+	for (addr = R_BE_PWR_RULMT_START; addr <= R_BE_PWR_RULMT_END; addr += 4)
+		rtw89_write32(rtwdev, addr, 0);
+	for (addr = R_BE_PWR_RATE_OFST_CTRL; addr <= R_BE_PWR_RATE_OFST_END; addr += 4)
+		rtw89_write32(rtwdev, addr, 0);
+
+	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_REF_CTRL, mac_idx);
+	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_OFST_LMT_DB, 0);
+	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_OFST_LMTBF, mac_idx);
+	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_OFST_LMTBF_DB, 0);
+	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_RATE_CTRL, mac_idx);
+	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_OFST_BYRATE_DB, 0);
+	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_OFST_RULMT, mac_idx);
+	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_OFST_RULMT_DB, 0);
+	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_OFST_SW, mac_idx);
+	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_OFST_SW_DB, 0);
+}
+
+static
+void rtw89_phy_bb_wrap_listen_path_en_init(struct rtw89_dev *rtwdev)
+{
+	u32 addr;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_1, RTW89_CMAC_SEL);
+	if (ret)
+		return;
+
+	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_LISTEN_PATH, RTW89_MAC_1);
+	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_LISTEN_PATH_EN, 0x2);
+}
+
+static void rtw89_phy_bb_wrap_force_cr_init(struct rtw89_dev *rtwdev,
+					    enum rtw89_mac_idx mac_idx)
+{
+	u32 addr;
+
+	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_FORCE_LMT, mac_idx);
+	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_FORCE_LMT_ON, 0);
+	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_BOOST, mac_idx);
+	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_FORCE_RATE_ON, 0);
+	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_OFST_RULMT, mac_idx);
+	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_FORCE_RU_ENON, 0);
+	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_FORCE_RU_ON, 0);
+	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_FORCE_MACID, mac_idx);
+	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_FORCE_MACID_ON, 0);
+	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_COEX_CTRL, mac_idx);
+	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_FORCE_COEX_ON, 0);
+	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_RATE_CTRL, mac_idx);
+	rtw89_write32_mask(rtwdev, addr, B_BE_FORCE_PWR_BY_RATE_EN, 0);
+}
+
+static void rtw89_phy_bb_wrap_ftm_init(struct rtw89_dev *rtwdev,
+				       enum rtw89_mac_idx mac_idx)
+{
+	u32 addr;
+
+	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_FTM, mac_idx);
+	rtw89_write32(rtwdev, addr, 0xE4E431);
+
+	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_FTM_SS, mac_idx);
+	rtw89_write32_mask(rtwdev, addr, 0x7, 0);
+}
+
+static void rtw89_phy_bb_wrap_init_be(struct rtw89_dev *rtwdev)
+{
+	enum rtw89_mac_idx mac_idx = RTW89_MAC_0;
+
+	rtw89_phy_bb_wrap_pwr_by_macid_init(rtwdev);
+	rtw89_phy_bb_wrap_tx_path_by_macid_init(rtwdev);
+	rtw89_phy_bb_wrap_listen_path_en_init(rtwdev);
+	rtw89_phy_bb_wrap_force_cr_init(rtwdev, mac_idx);
+	rtw89_phy_bb_wrap_ftm_init(rtwdev, mac_idx);
+	rtw89_phy_bb_wrap_tpu_set_all(rtwdev, mac_idx);
+}
+
 struct rtw89_byr_spec_ent_be {
 	struct rtw89_rate_desc init;
 	u8 num_of_idx;
@@ -838,6 +943,7 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_be = {
 	.cfo = &rtw89_cfo_regs_be,
 	.config_bb_gain = rtw89_phy_config_bb_gain_be,
 	.preinit_rf_nctl = rtw89_phy_preinit_rf_nctl_be,
+	.bb_wrap_init = rtw89_phy_bb_wrap_init_be,
 
 	.set_txpwr_byrate = rtw89_phy_set_txpwr_byrate_be,
 	.set_txpwr_offset = rtw89_phy_set_txpwr_offset_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index dc237f12dc5e..a03fb3784d1c 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -5822,6 +5822,9 @@
 #define B_BE_MACID_ACQ_GRP0_CLR_P BIT(2)
 #define B_BE_R_MACID_ACQ_CHK_EN BIT(0)
 
+#define R_BE_PWR_MACID_PATH_BASE 0x0E500
+#define R_BE_PWR_MACID_LMT_BASE 0x0ED00
+
 #define R_BE_CMAC_FUNC_EN 0x10000
 #define R_BE_CMAC_FUNC_EN_C1 0x14000
 #define B_BE_CMAC_CRPRT BIT(31)
@@ -7178,12 +7181,56 @@
 
 #define R_BE_PWR_MODULE 0x11900
 #define R_BE_PWR_MODULE_C1 0x15900
+#define R_BE_PWR_LISTEN_PATH 0x11988
+#define B_BE_PWR_LISTEN_PATH_EN GENMASK(31, 28)
+
+#define R_BE_PWR_REF_CTRL 0x11A20
+#define B_BE_PWR_REF_CTRL_OFDM GENMASK(9, 1)
+#define B_BE_PWR_REF_CTRL_CCK GENMASK(18, 10)
+#define B_BE_PWR_OFST_LMT_DB GENMASK(27, 19)
+#define R_BE_PWR_OFST_LMTBF 0x11A24
+#define B_BE_PWR_OFST_LMTBF_DB GENMASK(8, 0)
+#define R_BE_PWR_FORCE_LMT 0x11A28
+#define B_BE_PWR_FORCE_LMT_ON BIT(6)
+
+#define R_BE_PWR_RATE_CTRL 0x11A2C
+#define B_BE_PWR_OFST_BYRATE_DB GENMASK(8, 0)
+#define B_BE_FORCE_PWR_BY_RATE_EN BIT(19)
+#define B_BE_FORCE_PWR_BY_RATE_VAL GENMASK(28, 20)
 
 #define R_BE_PWR_RATE_OFST_CTRL 0x11A30
+#define R_BE_PWR_RATE_OFST_END 0x11A38
+#define R_BE_PWR_RULMT_START 0x12048
+#define R_BE_PWR_RULMT_END 0x120e4
+
+#define R_BE_PWR_BOOST 0x11A40
+#define B_BE_PWR_CTRL_SEL BIT(16)
+#define B_BE_PWR_FORCE_RATE_ON BIT(29)
+#define R_BE_PWR_OFST_RULMT 0x11A44
+#define B_BE_PWR_OFST_RULMT_DB GENMASK(17, 9)
+#define B_BE_PWR_FORCE_RU_ON BIT(18)
+#define B_BE_PWR_FORCE_RU_ENON BIT(28)
+#define R_BE_PWR_FORCE_MACID 0x11A48
+#define B_BE_PWR_FORCE_MACID_ON BIT(9)
+
+#define R_BE_PWR_REG_CTRL 0x11A50
+#define B_BE_PWR_BT_EN BIT(23)
+
+#define R_BE_PWR_COEX_CTRL 0x11A54
+#define B_BE_PWR_BT_VAL GENMASK(8, 0)
+#define B_BE_PWR_FORCE_COEX_ON GENMASK(29, 27)
+
+#define R_BE_PWR_OFST_SW 0x11AE8
+#define B_BE_PWR_OFST_SW_DB GENMASK(27, 24)
+
+#define R_BE_PWR_FTM 0x11B00
+#define R_BE_PWR_FTM_SS 0x11B04
+
 #define R_BE_PWR_BY_RATE 0x11E00
 #define R_BE_PWR_BY_RATE_MAX 0x11FA8
 #define R_BE_PWR_LMT 0x11FAC
 #define R_BE_PWR_LMT_MAX 0x12040
+#define R_BE_PWR_BY_RATE_END 0x12044
 #define R_BE_PWR_RU_LMT 0x12048
 #define R_BE_PWR_RU_LMT_MAX 0x120E4
 
-- 
2.25.1


