Return-Path: <linux-wireless+bounces-31-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BE47F6CC3
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 08:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA04D1C20A0A
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 07:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD26B64A;
	Fri, 24 Nov 2023 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A97D6E
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 23:18:19 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AO7ICrxC3551165, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AO7ICrxC3551165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Nov 2023 15:18:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 24 Nov 2023 15:18:13 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 24 Nov
 2023 15:18:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/8] wifi: rtw89: mac: move code related to hardware engine to individual functions
Date: Fri, 24 Nov 2023 15:17:01 +0800
Message-ID: <20231124071703.132549-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231124071703.132549-1-pkshih@realtek.com>
References: <20231124071703.132549-1-pkshih@realtek.com>
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

WiFi 7 chips will use the same functionalities but different registers to
control hardware components, so move these stuff into functions, and then
we can implement these for WiFi 7 chips later. This patch doesn't change
logic.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 65 +++++++++++++++++-------
 1 file changed, 48 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 074c1edb0d25..be063f73573b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -901,7 +901,7 @@ static int hfc_pub_ctrl(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
-static int hfc_upd_mix_info(struct rtw89_dev *rtwdev)
+static void hfc_get_mix_info(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_page_regs *regs = chip->page_regs;
@@ -910,11 +910,6 @@ static int hfc_upd_mix_info(struct rtw89_dev *rtwdev)
 	struct rtw89_hfc_prec_cfg *prec_cfg = &param->prec_cfg;
 	struct rtw89_hfc_pub_info *info = &param->pub_info;
 	u32 val;
-	int ret;
-
-	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
-	if (ret)
-		return ret;
 
 	val = rtw89_read32(rtwdev, regs->pub_page_info1);
 	info->g0_used = u32_get_bits(val, B_AX_G0_USE_PG_MASK);
@@ -959,6 +954,18 @@ static int hfc_upd_mix_info(struct rtw89_dev *rtwdev)
 	val = rtw89_read32(rtwdev, regs->pub_page_ctrl1);
 	pub_cfg->grp0 = u32_get_bits(val, B_AX_PUBPG_G0_MASK);
 	pub_cfg->grp1 = u32_get_bits(val, B_AX_PUBPG_G1_MASK);
+}
+
+static int hfc_upd_mix_info(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
+	if (ret)
+		return ret;
+
+	hfc_get_mix_info(rtwdev);
 
 	ret = hfc_pub_info_chk(rtwdev);
 	if (param->en && ret)
@@ -1780,6 +1787,23 @@ static int dle_mix_cfg(struct rtw89_dev *rtwdev, const struct rtw89_dle_mem *cfg
 	return 0;
 }
 
+static int chk_dle_rdy(struct rtw89_dev *rtwdev, bool wde_or_ple)
+{
+	u32 reg, mask;
+	u32 ini;
+
+	if (wde_or_ple) {
+		reg = R_AX_WDE_INI_STATUS;
+		mask = WDE_MGN_INI_RDY;
+	} else {
+		reg = R_AX_PLE_INI_STATUS;
+		mask = PLE_MGN_INI_RDY;
+	}
+
+	return read_poll_timeout(rtw89_read32, ini, (ini & mask) == mask, 1,
+				2000, false, rtwdev, reg);
+}
+
 #define INVALID_QT_WCPU U16_MAX
 #define SET_QUOTA_VAL(_min_x, _max_x, _module, _idx)			\
 	do {								\
@@ -1884,7 +1908,6 @@ static int dle_init(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode,
 	const struct rtw89_dle_mem *cfg, *ext_cfg;
 	u16 ext_wde_min_qt_wcpu = INVALID_QT_WCPU;
 	int ret = 0;
-	u32 ini;
 
 	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
 	if (ret)
@@ -1926,17 +1949,13 @@ static int dle_init(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode,
 
 	dle_func_en(rtwdev, true);
 
-	ret = read_poll_timeout(rtw89_read32, ini,
-				(ini & WDE_MGN_INI_RDY) == WDE_MGN_INI_RDY, 1,
-				2000, false, rtwdev, R_AX_WDE_INI_STATUS);
+	ret = chk_dle_rdy(rtwdev, true);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]WDE cfg ready\n");
 		return ret;
 	}
 
-	ret = read_poll_timeout(rtw89_read32, ini,
-				(ini & WDE_MGN_INI_RDY) == WDE_MGN_INI_RDY, 1,
-				2000, false, rtwdev, R_AX_PLE_INI_STATUS);
+	ret = chk_dle_rdy(rtwdev, false);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]PLE cfg ready\n");
 		return ret;
@@ -3598,11 +3617,10 @@ static int rtw89_mac_enable_cpu_ax(struct rtw89_dev *rtwdev, u8 boot_reason,
 	return 0;
 }
 
-static int rtw89_mac_dmac_pre_init(struct rtw89_dev *rtwdev)
+static void rtw89_mac_hci_func_en(struct rtw89_dev *rtwdev)
 {
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	u32 val;
-	int ret;
 
 	if (chip_id == RTL8852C)
 		val = B_AX_MAC_FUNC_EN | B_AX_DMAC_FUNC_EN | B_AX_DISPATCHER_EN |
@@ -3611,6 +3629,12 @@ static int rtw89_mac_dmac_pre_init(struct rtw89_dev *rtwdev)
 		val = B_AX_MAC_FUNC_EN | B_AX_DMAC_FUNC_EN | B_AX_DISPATCHER_EN |
 		      B_AX_PKT_BUF_EN;
 	rtw89_write32(rtwdev, R_AX_DMAC_FUNC_EN, val);
+}
+
+static void rtw89_mac_dmac_func_pre_en(struct rtw89_dev *rtwdev)
+{
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+	u32 val;
 
 	if (chip_id == RTL8851B)
 		val = B_AX_DISPATCHER_CLK_EN | B_AX_AXIDMA_CLK_EN;
@@ -3619,7 +3643,7 @@ static int rtw89_mac_dmac_pre_init(struct rtw89_dev *rtwdev)
 	rtw89_write32(rtwdev, R_AX_DMAC_CLK_EN, val);
 
 	if (chip_id != RTL8852C)
-		goto dle;
+		return;
 
 	val = rtw89_read32(rtwdev, R_AX_HAXI_INIT_CFG1);
 	val &= ~(B_AX_DMA_MODE_MASK | B_AX_STOP_AXI_MST);
@@ -3634,8 +3658,15 @@ static int rtw89_mac_dmac_pre_init(struct rtw89_dev *rtwdev)
 			  B_AX_STOP_CH12 | B_AX_STOP_ACH2);
 	rtw89_write32_clr(rtwdev, R_AX_HAXI_DMA_STOP2, B_AX_STOP_CH10 | B_AX_STOP_CH11);
 	rtw89_write32_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_AXIDMA_EN);
+}
+
+static int rtw89_mac_dmac_pre_init(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	rtw89_mac_hci_func_en(rtwdev);
+	rtw89_mac_dmac_func_pre_en(rtwdev);
 
-dle:
 	ret = dle_init(rtwdev, RTW89_QTA_DLFW, rtwdev->mac.qta_mode);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]DLE pre init %d\n", ret);
-- 
2.25.1


