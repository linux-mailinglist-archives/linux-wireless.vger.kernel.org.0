Return-Path: <linux-wireless+bounces-11165-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A361894CB1F
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 302041F22E65
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 07:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1E9174EDB;
	Fri,  9 Aug 2024 07:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="LATmsAk0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0A41741FE
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188051; cv=none; b=CXzgN9I1DsSo6fBaWq9dyd1Zpu+Cty7pVunM0WFWYZbBpCCMuc/2ZpWDEO8Kgg3autP3dHFTqKIzYmKTyIhCf2GA9mqKfhufq08d9H3dMsKhf2IwNLtafePmlBieggWrUI3bi2zlwlbiVZXoP9abe698mTovriqaEBRNHYRFy8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188051; c=relaxed/simple;
	bh=+PmQ/dW/2+rMkeo9c87Uy9SRjphwZ8ax2eOsqxjWuzU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYf09BK34wgPd/OqFywniQy+PeO59inTK2VuRxK5zXPzNaBlsYGIFZ4AqdY6upH+tsNbtnekbE2oTfFyV+u3Usz85xD4lub0VUw0oB4fOUYkKPLAIKnGezcI/U2EWIWB2nQz7PZJlyz29MoVmNYnau2Ua3Ckf6UEFLhKOfK6msg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=LATmsAk0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4797Kk3dA514064, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723188047; bh=+PmQ/dW/2+rMkeo9c87Uy9SRjphwZ8ax2eOsqxjWuzU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=LATmsAk01Jk+OSmn1aMNYv2o8wqYDGXtif/hhC4YBkVdB6glaaaC3IWkH03JhbdQP
	 Lv3+twgpXI62lMcPBXiN62duUJzrj+R28yuQD0DnDQnh9aiMzTueNDDag7q9BAhjkO
	 EcrmysdcbiXlMUFX1syig0tRw7luQaYHZE750LeI5FkTzHOs9SHDeDI17RMeDVjhHA
	 0Nouax/MYIZpTum+WmYYViC9f0xzu/j3KHAW/YBWVAkIurmFAkzygP3GqHdIhWKluX
	 6fFjaoTsiH7JAOZ1NlwC59qGjGcIb/0qiYK27Rpq9vXT9NRt1Pxe/OHlSBtRJjmNIe
	 /MP7jaoxVqrNw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4797Kk3dA514064
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 9 Aug 2024 15:20:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 15:20:46 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 9 Aug
 2024 15:20:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH 2/6] wifi: rtw89: 8922a: add digital compensation to avoid TX EVM degrade
Date: Fri, 9 Aug 2024 15:20:08 +0800
Message-ID: <20240809072012.84152-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809072012.84152-1-pkshih@realtek.com>
References: <20240809072012.84152-1-pkshih@realtek.com>
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

TX EVM will significantly decrease for long packets when
the TX idle time increases. Introduce digital compensation
based on TX idle time, to mitigate TX EVM degradation, and
TX throughput improved from 1871 to 1947 Mbps.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 11 ++++
 drivers/net/wireless/realtek/rtw89/ps.c       |  7 ++-
 drivers/net/wireless/realtek/rtw89/reg.h      |  3 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 61 ++++++++++++++++++-
 9 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b42a33b9868a..3edb2f4372e4 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3566,6 +3566,8 @@ struct rtw89_chip_ops {
 	void (*cfg_txrx_path)(struct rtw89_dev *rtwdev);
 	void (*set_txpwr_ul_tb_offset)(struct rtw89_dev *rtwdev,
 				       s8 pw_ofst, enum rtw89_mac_idx mac_idx);
+	void (*digital_pwr_comp)(struct rtw89_dev *rtwdev,
+				 enum rtw89_phy_idx phy_idx);
 	int (*pwr_on_func)(struct rtw89_dev *rtwdev);
 	int (*pwr_off_func)(struct rtw89_dev *rtwdev);
 	void (*query_rxdesc)(struct rtw89_dev *rtwdev,
@@ -6274,6 +6276,15 @@ void rtw89_chip_cfg_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
 		chip->ops->set_txpwr_ul_tb_offset(rtwdev, 0, rtwvif->mac_idx);
 }
 
+static inline void rtw89_chip_digital_pwr_comp(struct rtw89_dev *rtwdev,
+					       enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->digital_pwr_comp)
+		chip->ops->digital_pwr_comp(rtwdev, phy_idx);
+}
+
 static inline void rtw89_load_txpwr_table(struct rtw89_dev *rtwdev,
 					  const struct rtw89_txpwr_table *tbl)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index 92074b73ebeb..aebd6404f802 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -98,10 +98,10 @@ static void __rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif
 	rtw89_fw_h2c_lps_ch_info(rtwdev, rtwvif);
 }
 
-static void __rtw89_leave_lps(struct rtw89_dev *rtwdev, u8 mac_id)
+static void __rtw89_leave_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
 	struct rtw89_lps_parm lps_param = {
-		.macid = mac_id,
+		.macid = rtwvif->mac_id,
 		.psmode = RTW89_MAC_AX_PS_MODE_ACTIVE,
 		.lastrpwm = RTW89_LAST_RPWM_ACTIVE,
 	};
@@ -109,6 +109,7 @@ static void __rtw89_leave_lps(struct rtw89_dev *rtwdev, u8 mac_id)
 	rtw89_fw_h2c_lps_parm(rtwdev, &lps_param);
 	rtw89_fw_leave_lps_check(rtwdev, 0);
 	rtw89_btc_ntfy_radio_state(rtwdev, BTC_RFCTRL_WL_ON);
+	rtw89_chip_digital_pwr_comp(rtwdev, rtwvif->phy_idx);
 }
 
 void rtw89_leave_ps_mode(struct rtw89_dev *rtwdev)
@@ -137,7 +138,7 @@ static void rtw89_leave_lps_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwv
 	    rtwvif->wifi_role != RTW89_WIFI_ROLE_P2P_CLIENT)
 		return;
 
-	__rtw89_leave_lps(rtwdev, rtwvif->mac_id);
+	__rtw89_leave_lps(rtwdev, rtwvif);
 }
 
 void rtw89_leave_lps(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 7afec48c4056..eacf9161db2c 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -6044,6 +6044,9 @@
 #define R_BE_WP_PAGE_INFO1 0xB7AC
 #define B_BE_WP_AVAL_PG_MASK GENMASK(28, 16)
 
+#define R_BE_LTPC_T0_PATH0 0xBA28
+#define R_BE_LTPC_T0_PATH1 0xBB28
+
 #define R_BE_CMAC_SHARE_FUNC_EN 0x0E000
 #define B_BE_CMAC_SHARE_CRPRT BIT(31)
 #define B_BE_CMAC_SHARE_EN BIT(30)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index e6463035a7af..d1358b9a73f9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2388,6 +2388,7 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.ctrl_nbtg_bt_tx	= rtw8851b_ctrl_nbtg_bt_tx,
 	.cfg_txrx_path		= rtw8851b_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= rtw8851b_set_txpwr_ul_tb_offset,
+	.digital_pwr_comp	= NULL,
 	.pwr_on_func		= rtw8851b_pwr_on_func,
 	.pwr_off_func		= rtw8851b_pwr_off_func,
 	.query_rxdesc		= rtw89_core_query_rxdesc,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 7ea388fa0657..b073e041a16b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2111,6 +2111,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.ctrl_nbtg_bt_tx	= rtw8852a_ctrl_nbtg_bt_tx,
 	.cfg_txrx_path		= NULL,
 	.set_txpwr_ul_tb_offset	= rtw8852a_set_txpwr_ul_tb_offset,
+	.digital_pwr_comp	= NULL,
 	.pwr_on_func		= NULL,
 	.pwr_off_func		= NULL,
 	.query_rxdesc		= rtw89_core_query_rxdesc,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index f26979b89cc9..36a81c3323f8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -742,6 +742,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.ctrl_nbtg_bt_tx	= rtw8852bx_ctrl_nbtg_bt_tx,
 	.cfg_txrx_path		= rtw8852bx_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= rtw8852bx_set_txpwr_ul_tb_offset,
+	.digital_pwr_comp	= NULL,
 	.pwr_on_func		= rtw8852b_pwr_on_func,
 	.pwr_off_func		= rtw8852b_pwr_off_func,
 	.query_rxdesc		= rtw89_core_query_rxdesc,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index fb98ef9dbc54..647bc98bcc5d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -676,6 +676,7 @@ static const struct rtw89_chip_ops rtw8852bt_chip_ops = {
 	.ctrl_nbtg_bt_tx	= rtw8852bx_ctrl_nbtg_bt_tx,
 	.cfg_txrx_path		= rtw8852bx_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= rtw8852bx_set_txpwr_ul_tb_offset,
+	.digital_pwr_comp	= NULL,
 	.pwr_on_func		= rtw8852bt_pwr_on_func,
 	.pwr_off_func		= rtw8852bt_pwr_off_func,
 	.query_rxdesc		= rtw89_core_query_rxdesc,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index dc1da9ff055c..65e61a2ede27 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2891,6 +2891,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.ctrl_nbtg_bt_tx	= rtw8852c_ctrl_nbtg_bt_tx,
 	.cfg_txrx_path		= rtw8852c_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= rtw8852c_set_txpwr_ul_tb_offset,
+	.digital_pwr_comp	= NULL,
 	.pwr_on_func		= rtw8852c_pwr_on_func,
 	.pwr_off_func		= rtw8852c_pwr_off_func,
 	.query_rxdesc		= rtw89_core_query_rxdesc,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 6004a622d244..7f4ac8b63e48 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -1689,6 +1689,60 @@ static int rtw8922a_ctrl_rx_path_tmac(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+#define DIGITAL_PWR_COMP_REG_NUM 22
+static const u32 rtw8922a_digital_pwr_comp_val[][DIGITAL_PWR_COMP_REG_NUM] = {
+	{0x012C0096, 0x044C02BC, 0x00322710, 0x015E0096, 0x03C8028A,
+	 0x0BB80708, 0x17701194, 0x02020100, 0x03030303, 0x01000303,
+	 0x05030302, 0x06060605, 0x06050300, 0x0A090807, 0x02000B0B,
+	 0x09080604, 0x0D0D0C0B, 0x08060400, 0x110F0C0B, 0x05001111,
+	 0x0D0C0907, 0x12121210},
+	{0x012C0096, 0x044C02BC, 0x00322710, 0x015E0096, 0x03C8028A,
+	 0x0BB80708, 0x17701194, 0x04030201, 0x05050505, 0x01000505,
+	 0x07060504, 0x09090908, 0x09070400, 0x0E0D0C0B, 0x03000E0E,
+	 0x0D0B0907, 0x1010100F, 0x0B080500, 0x1512100D, 0x05001515,
+	 0x100D0B08, 0x15151512},
+};
+
+static void rtw8922a_set_digital_pwr_comp(struct rtw89_dev *rtwdev,
+					  bool enable, u8 nss,
+					  enum rtw89_rf_path path)
+{
+	static const u32 ltpc_t0[2] = {R_BE_LTPC_T0_PATH0, R_BE_LTPC_T0_PATH1};
+	const u32 *digital_pwr_comp;
+	u32 addr, val;
+	u32 i;
+
+	if (nss == 1)
+		digital_pwr_comp = rtw8922a_digital_pwr_comp_val[0];
+	else
+		digital_pwr_comp = rtw8922a_digital_pwr_comp_val[1];
+
+	addr = ltpc_t0[path];
+	for (i = 0; i < DIGITAL_PWR_COMP_REG_NUM; i++, addr += 4) {
+		val = enable ? digital_pwr_comp[i] : 0;
+		rtw89_phy_write32(rtwdev, addr, val);
+	}
+}
+
+static void rtw8922a_digital_pwr_comp(struct rtw89_dev *rtwdev,
+				      enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	bool enable = chan->band_type != RTW89_BAND_2G;
+	u8 path;
+
+	if (rtwdev->mlo_dbcc_mode == MLO_1_PLUS_1_1RF) {
+		if (phy_idx == RTW89_PHY_0)
+			path = RF_PATH_A;
+		else
+			path = RF_PATH_B;
+		rtw8922a_set_digital_pwr_comp(rtwdev, enable, 1, path);
+	} else {
+		rtw8922a_set_digital_pwr_comp(rtwdev, enable, 2, RF_PATH_A);
+		rtw8922a_set_digital_pwr_comp(rtwdev, enable, 2, RF_PATH_B);
+	}
+}
+
 static int rtw8922a_ctrl_mlo(struct rtw89_dev *rtwdev, enum rtw89_mlo_dbcc_mode mode)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
@@ -1810,11 +1864,13 @@ static void rtw8922a_pre_set_channel_bb(struct rtw89_dev *rtwdev,
 }
 
 static void rtw8922a_post_set_channel_bb(struct rtw89_dev *rtwdev,
-					 enum rtw89_mlo_dbcc_mode mode)
+					 enum rtw89_mlo_dbcc_mode mode,
+					 enum rtw89_phy_idx phy_idx)
 {
 	if (!rtwdev->dbcc_en)
 		return;
 
+	rtw8922a_digital_pwr_comp(rtwdev, phy_idx);
 	rtw8922a_ctrl_mlo(rtwdev, mode);
 }
 
@@ -1921,7 +1977,7 @@ static void rtw8922a_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
 	rtw8922a_hal_reset(rtwdev, phy_idx, mac_idx, chan->band_type, &p->tx_en, enter);
 
 	if (!enter) {
-		rtw8922a_post_set_channel_bb(rtwdev, rtwdev->mlo_dbcc_mode);
+		rtw8922a_post_set_channel_bb(rtwdev, rtwdev->mlo_dbcc_mode, phy_idx);
 		rtw8922a_post_set_channel_rf(rtwdev, phy_idx);
 	}
 }
@@ -2494,6 +2550,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.ctrl_nbtg_bt_tx	= rtw8922a_ctrl_nbtg_bt_tx,
 	.cfg_txrx_path		= rtw8922a_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= NULL,
+	.digital_pwr_comp	= rtw8922a_digital_pwr_comp,
 	.pwr_on_func		= rtw8922a_pwr_on_func,
 	.pwr_off_func		= rtw8922a_pwr_off_func,
 	.query_rxdesc		= rtw89_core_query_rxdesc_v2,
-- 
2.25.1


