Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C2A7B5ED5
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 03:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjJCBzS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Oct 2023 21:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJCBzR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Oct 2023 21:55:17 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F13ABF
        for <linux-wireless@vger.kernel.org>; Mon,  2 Oct 2023 18:55:13 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3931t4BR11334490, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3931t4BR11334490
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Oct 2023 09:55:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 3 Oct 2023 09:55:04 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 3 Oct 2023
 09:55:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/7] wifi: rtw89: mac: get TX power control register according to chip gen
Date:   Tue, 3 Oct 2023 09:54:40 +0800
Message-ID: <20231003015446.14658-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231003015446.14658-1-pkshih@realtek.com>
References: <20231003015446.14658-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

There are two difference between Wi-Fi 6 and Wi-Fi 7 chips.
1. Address range of TX power control register
2. Checking code to get a TX power control register

So, separate the implementation of them, access according to
chip generation, and rename original things with a suffix `_ax`.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 14 ++++---
 drivers/net/wireless/realtek/rtw89/mac.h    | 16 +++++---
 drivers/net/wireless/realtek/rtw89/mac_be.c | 40 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    | 42 ++++++++++++++++++++-
 4 files changed, 98 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 070a2eddfd19..f1d14e84cda7 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4774,21 +4774,22 @@ void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	handler(rtwdev, skb, len);
 }
 
-bool rtw89_mac_get_txpwr_cr(struct rtw89_dev *rtwdev,
-			    enum rtw89_phy_idx phy_idx,
-			    u32 reg_base, u32 *cr)
+static
+bool rtw89_mac_get_txpwr_cr_ax(struct rtw89_dev *rtwdev,
+			       enum rtw89_phy_idx phy_idx,
+			       u32 reg_base, u32 *cr)
 {
 	const struct rtw89_dle_mem *dle_mem = rtwdev->chip->dle_mem;
 	enum rtw89_qta_mode mode = dle_mem->mode;
 	u32 addr = rtw89_mac_reg_by_idx(rtwdev, reg_base, phy_idx);
 
-	if (addr < R_AX_PWR_RATE_CTRL || addr > CMAC1_END_ADDR) {
+	if (addr < R_AX_PWR_RATE_CTRL || addr > CMAC1_END_ADDR_AX) {
 		rtw89_err(rtwdev, "[TXPWR] addr=0x%x exceed txpwr cr\n",
 			  addr);
 		goto error;
 	}
 
-	if (addr >= CMAC1_START_ADDR && addr <= CMAC1_END_ADDR)
+	if (addr >= CMAC1_START_ADDR_AX && addr <= CMAC1_END_ADDR_AX)
 		if (mode == RTW89_QTA_SCC) {
 			rtw89_err(rtwdev,
 				  "[TXPWR] addr=0x%x but hw not enable\n",
@@ -4805,7 +4806,6 @@ bool rtw89_mac_get_txpwr_cr(struct rtw89_dev *rtwdev,
 
 	return false;
 }
-EXPORT_SYMBOL(rtw89_mac_get_txpwr_cr);
 
 int rtw89_mac_cfg_ppdu_status(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable)
 {
@@ -5756,5 +5756,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.fwdl_enable_wcpu = rtw89_mac_enable_cpu_ax,
 	.fwdl_get_status = rtw89_fw_get_rdy_ax,
 	.fwdl_check_path_ready = rtw89_fwdl_check_path_ready_ax,
+
+	.get_txpwr_cr = rtw89_mac_get_txpwr_cr_ax,
 };
 EXPORT_SYMBOL(rtw89_mac_gen_ax);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 3c17b57a8ca2..617fd2aea776 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -865,6 +865,10 @@ struct rtw89_mac_gen_def {
 				bool dlfw, bool include_bb);
 	u8 (*fwdl_get_status)(struct rtw89_dev *rtwdev, enum rtw89_fwdl_check_type type);
 	int (*fwdl_check_path_ready)(struct rtw89_dev *rtwdev, bool h2c_or_fwdl);
+
+	bool (*get_txpwr_cr)(struct rtw89_dev *rtwdev,
+			     enum rtw89_phy_idx phy_idx,
+			     u32 reg_base, u32 *cr);
 };
 
 extern const struct rtw89_mac_gen_def rtw89_mac_gen_ax;
@@ -1028,9 +1032,6 @@ u32 rtw89_mac_get_sb(struct rtw89_dev *rtwdev);
 bool rtw89_mac_get_ctrl_path(struct rtw89_dev *rtwdev);
 int rtw89_mac_cfg_ctrl_path(struct rtw89_dev *rtwdev, bool wl);
 int rtw89_mac_cfg_ctrl_path_v1(struct rtw89_dev *rtwdev, bool wl);
-bool rtw89_mac_get_txpwr_cr(struct rtw89_dev *rtwdev,
-			    enum rtw89_phy_idx phy_idx,
-			    u32 reg_base, u32 *cr);
 void rtw89_mac_power_mode_change(struct rtw89_dev *rtwdev, bool enter);
 void rtw89_mac_notify_wake(struct rtw89_dev *rtwdev);
 void rtw89_mac_bf_assoc(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
@@ -1060,9 +1061,10 @@ static inline int rtw89_mac_txpwr_read32(struct rtw89_dev *rtwdev,
 					 enum rtw89_phy_idx phy_idx,
 					 u32 reg_base, u32 *val)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u32 cr;
 
-	if (!rtw89_mac_get_txpwr_cr(rtwdev, phy_idx, reg_base, &cr))
+	if (!mac->get_txpwr_cr(rtwdev, phy_idx, reg_base, &cr))
 		return -EINVAL;
 
 	*val = rtw89_read32(rtwdev, cr);
@@ -1073,9 +1075,10 @@ static inline int rtw89_mac_txpwr_write32(struct rtw89_dev *rtwdev,
 					  enum rtw89_phy_idx phy_idx,
 					  u32 reg_base, u32 val)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u32 cr;
 
-	if (!rtw89_mac_get_txpwr_cr(rtwdev, phy_idx, reg_base, &cr))
+	if (!mac->get_txpwr_cr(rtwdev, phy_idx, reg_base, &cr))
 		return -EINVAL;
 
 	rtw89_write32(rtwdev, cr, val);
@@ -1086,9 +1089,10 @@ static inline int rtw89_mac_txpwr_write32_mask(struct rtw89_dev *rtwdev,
 					       enum rtw89_phy_idx phy_idx,
 					       u32 reg_base, u32 mask, u32 val)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u32 cr;
 
-	if (!rtw89_mac_get_txpwr_cr(rtwdev, phy_idx, reg_base, &cr))
+	if (!mac->get_txpwr_cr(rtwdev, phy_idx, reg_base, &cr))
 		return -EINVAL;
 
 	rtw89_write32_mask(rtwdev, cr, mask, val);
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index fbf55274e00e..8af71d8a659a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -205,6 +205,44 @@ static int rtw89_fwdl_check_path_ready_be(struct rtw89_dev *rtwdev,
 					rtwdev, R_BE_WCPU_FW_CTRL);
 }
 
+static bool rtw89_mac_get_txpwr_cr_be(struct rtw89_dev *rtwdev,
+				      enum rtw89_phy_idx phy_idx,
+				      u32 reg_base, u32 *cr)
+{
+	const struct rtw89_dle_mem *dle_mem = rtwdev->chip->dle_mem;
+	enum rtw89_qta_mode mode = dle_mem->mode;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, (enum rtw89_mac_idx)phy_idx,
+				     RTW89_CMAC_SEL);
+	if (ret) {
+		if (test_bit(RTW89_FLAG_SER_HANDLING, rtwdev->flags))
+			return false;
+
+		rtw89_err(rtwdev, "[TXPWR] check mac enable failed\n");
+		return false;
+	}
+
+	if (reg_base < R_BE_PWR_MODULE || reg_base > R_BE_CMAC_FUNC_EN_C1) {
+		rtw89_err(rtwdev, "[TXPWR] reg_base=0x%x exceed txpwr cr\n",
+			  reg_base);
+		return false;
+	}
+
+	*cr = rtw89_mac_reg_by_idx(rtwdev, reg_base, phy_idx);
+
+	if (*cr >= CMAC1_START_ADDR_BE && *cr <= CMAC1_END_ADDR_BE) {
+		if (mode == RTW89_QTA_SCC) {
+			rtw89_err(rtwdev,
+				  "[TXPWR] addr=0x%x but hw not enable\n",
+				  *cr);
+			return false;
+		}
+	}
+
+	return true;
+}
+
 const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.band1_offset = RTW89_MAC_BE_BAND_REG_OFFSET,
 	.filter_model_addr = R_BE_FILTER_MODEL_ADDR,
@@ -217,5 +255,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.fwdl_enable_wcpu = rtw89_mac_fwdl_enable_wcpu_be,
 	.fwdl_get_status = fwdl_get_status_be,
 	.fwdl_check_path_ready = rtw89_fwdl_check_path_ready_be,
+
+	.get_txpwr_cr = rtw89_mac_get_txpwr_cr_be,
 };
 EXPORT_SYMBOL(rtw89_mac_gen_be);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index edaf2a13ef98..7b0408246fd4 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3581,8 +3581,8 @@
 #define R_AX_MACID_ANT_TABLE 0xDC00
 #define R_AX_MACID_ANT_TABLE_LAST 0xDDFC
 
-#define CMAC1_START_ADDR 0xE000
-#define CMAC1_END_ADDR 0xFFFF
+#define CMAC1_START_ADDR_AX 0xE000
+#define CMAC1_END_ADDR_AX 0xFFFF
 #define R_AX_CMAC_REG_END 0xFFFF
 
 #define R_AX_LTE_SW_CFG_1 0x0038
@@ -3736,6 +3736,38 @@
 #define R_BE_PLE_DBG_FUN_INTF_DATA 0x9114
 #define B_BE_PLE_DFI_DATA_MASK GENMASK(31, 0)
 
+#define R_BE_CMAC_FUNC_EN 0x10000
+#define R_BE_CMAC_FUNC_EN_C1 0x14000
+#define B_BE_CMAC_CRPRT BIT(31)
+#define B_BE_CMAC_EN BIT(30)
+#define B_BE_CMAC_TXEN BIT(29)
+#define B_BE_CMAC_RXEN BIT(28)
+#define B_BE_FORCE_RESP_PKTCTL_GCKEN BIT(26)
+#define B_BE_FORCE_SIGB_REG_GCKEN BIT(25)
+#define B_BE_FORCE_POWER_REG_GCKEN BIT(23)
+#define B_BE_FORCE_RMAC_REG_GCKEN BIT(22)
+#define B_BE_FORCE_TRXPTCL_REG_GCKEN BIT(21)
+#define B_BE_FORCE_TMAC_REG_GCKEN BIT(20)
+#define B_BE_FORCE_CMAC_DMA_REG_GCKEN BIT(19)
+#define B_BE_FORCE_PTCL_REG_GCKEN BIT(18)
+#define B_BE_FORCE_SCHEDULER_RREG_GCKEN BIT(17)
+#define B_BE_FORCE_CMAC_COMMON_REG_GCKEN BIT(16)
+#define B_BE_FORCE_CMACREG_GCKEN BIT(15)
+#define B_BE_TXTIME_EN BIT(8)
+#define B_BE_RESP_PKTCTL_EN BIT(7)
+#define B_BE_SIGB_EN BIT(6)
+#define B_BE_PHYINTF_EN BIT(5)
+#define B_BE_CMAC_DMA_EN BIT(4)
+#define B_BE_PTCLTOP_EN BIT(3)
+#define B_BE_SCHEDULER_EN BIT(2)
+#define B_BE_TMAC_EN BIT(1)
+#define B_BE_RMAC_EN BIT(0)
+#define B_BE_CMAC_FUNC_EN_SET (B_BE_CMAC_EN | B_BE_CMAC_TXEN | B_BE_CMAC_RXEN | \
+			       B_BE_PHYINTF_EN | B_BE_CMAC_DMA_EN | B_BE_PTCLTOP_EN | \
+			       B_BE_SCHEDULER_EN | B_BE_TMAC_EN | B_BE_RMAC_EN | \
+			       B_BE_CMAC_CRPRT | B_BE_TXTIME_EN | B_BE_RESP_PKTCTL_EN | \
+			       B_BE_SIGB_EN)
+
 #define R_BE_PORT_0_TSF_SYNC 0x102A0
 #define R_BE_PORT_0_TSF_SYNC_C1 0x142A0
 #define B_BE_P0_SYNC_NOW_P BIT(30)
@@ -3902,6 +3934,12 @@
 #define B_BE_A_A1_MATCH BIT(1)
 #define B_BE_SNIFFER_MODE BIT(0)
 
+#define R_BE_PWR_MODULE 0x11900
+#define R_BE_PWR_MODULE_C1 0x15900
+
+#define CMAC1_START_ADDR_BE 0x14000
+#define CMAC1_END_ADDR_BE 0x17FFF
+
 #define RR_MOD 0x00
 #define RR_MOD_V1 0x10000
 #define RR_MOD_IQK GENMASK(19, 4)
-- 
2.25.1

