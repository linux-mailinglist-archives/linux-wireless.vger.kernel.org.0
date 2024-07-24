Return-Path: <linux-wireless+bounces-10469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C9393AC3C
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 07:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387CE1C22DC4
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 05:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7544026AD7;
	Wed, 24 Jul 2024 05:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="nar20gsp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE394208D7
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 05:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721798814; cv=none; b=O4EcA+Zqte+BXHvhltC4cAVQLtJKLdb8oE+akeVJ+E7G81fLvAK1RlP1ZrcmUuz8rmkwLy4O2XkZy1XVdjFIR6R6oMglkax7CrcfyXYu3RBacf0h9h4jPRaVQWMCEHkApVKcb0znG6l3eP77T9121G/gInJBWIXsY8FD6cg9ssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721798814; c=relaxed/simple;
	bh=iUr4CljPhezp3nnzJDiXv7jlGw2riOKu8iAFfvviGXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=apX7rTG/xfHtPHoflz4UTWpD57dAyzKPU90vMKk7JmYwWUfH1XXlceMRw1+K0UzRqzt4M/1L9GRpmB+n92wNWeBzO+iMCCOYC/3nHQGJeHgQKfUmEIELEvC1y21+Pdy/Sn6G4hJXcambAAmIoHJIrCGlkYi+j142uffIeDK+6IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=nar20gsp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46O5Qn1G21894623, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721798809; bh=iUr4CljPhezp3nnzJDiXv7jlGw2riOKu8iAFfvviGXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=nar20gspeA3IHACo+4z87iOISLu+GkeO8wdOBaLm/gCehsMo5LB60214mMGzwzLpa
	 mnxgovncfjaY+uT48CsGhpxy5l3/GVe7AXGX8xfWEaXGJDhFEq3OC2h6+mZMUtX+XO
	 fWdtKB1Lh30zz0ilyZR0GCzES7UOiY0w0OY8ikVF5Yhn7AUtat3ir64WwXWrpgbA5V
	 0qXI1p4eht8gdVFaeTfbzF346WEPTC/cVlT2yznZEDGxO6/xOiwAewcXHbF/pIqjVX
	 bN5AZIZOri43kG5bq8EIO1L+/bpiM47HyJvnLpCU0jzZvdqkIuMMmV7+avmT1E6iR+
	 zLUMdfZWDgarA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46O5Qn1G21894623
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 13:26:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 13:26:49 +0800
Received: from [127.0.1.1] (172.16.23.66) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 24 Jul
 2024 13:26:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 2/4] wifi: rtw89: add support for hardware rfkill
Date: Wed, 24 Jul 2024 13:26:24 +0800
Message-ID: <20240724052626.12774-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240724052626.12774-1-pkshih@realtek.com>
References: <20240724052626.12774-1-pkshih@realtek.com>
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

Add support for ieee80211::rfkill_poll ops. This enables periodic
monitoring of the hardware rfkill state, triggering updates when the
status changes.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 68 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h     |  9 +++
 drivers/net/wireless/realtek/rtw89/mac80211.c | 17 +++++
 drivers/net/wireless/realtek/rtw89/reg.h      | 24 +++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 11 +++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 11 +++
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 11 +++
 .../net/wireless/realtek/rtw89/rtw8852bt.c    | 11 +++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 11 +++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 11 +++
 10 files changed, 184 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 86b6febedc25..45952994ffa6 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3217,6 +3217,7 @@ static void rtw89_track_work(struct work_struct *work)
 	rtw89_phy_edcca_track(rtwdev);
 	rtw89_tas_track(rtwdev);
 	rtw89_chanctx_track(rtwdev);
+	rtw89_core_rfkill_poll(rtwdev, false);
 
 	if (rtwdev->lps_enabled && !rtwdev->btc.lps)
 		rtw89_enter_lps_track(rtwdev);
@@ -4499,6 +4500,70 @@ static int rtw89_chip_board_info_setup(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static bool rtw89_chip_has_rfkill(struct rtw89_dev *rtwdev)
+{
+	return !!rtwdev->chip->rfkill_init;
+}
+
+static void rtw89_core_rfkill_init(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_rfkill_regs *regs = rtwdev->chip->rfkill_init;
+
+	rtw89_write16_mask(rtwdev, regs->pinmux.addr,
+			   regs->pinmux.mask, regs->pinmux.data);
+	rtw89_write16_mask(rtwdev, regs->mode.addr,
+			   regs->mode.mask, regs->mode.data);
+}
+
+static bool rtw89_core_rfkill_get(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_reg_def *reg = &rtwdev->chip->rfkill_get;
+
+	return !rtw89_read8_mask(rtwdev, reg->addr, reg->mask);
+}
+
+static void rtw89_rfkill_polling_init(struct rtw89_dev *rtwdev)
+{
+	if (!rtw89_chip_has_rfkill(rtwdev))
+		return;
+
+	rtw89_core_rfkill_init(rtwdev);
+	rtw89_core_rfkill_poll(rtwdev, true);
+	wiphy_rfkill_start_polling(rtwdev->hw->wiphy);
+}
+
+static void rtw89_rfkill_polling_deinit(struct rtw89_dev *rtwdev)
+{
+	if (!rtw89_chip_has_rfkill(rtwdev))
+		return;
+
+	wiphy_rfkill_stop_polling(rtwdev->hw->wiphy);
+}
+
+void rtw89_core_rfkill_poll(struct rtw89_dev *rtwdev, bool force)
+{
+	bool prev, blocked;
+
+	if (!rtw89_chip_has_rfkill(rtwdev))
+		return;
+
+	prev = test_bit(RTW89_FLAG_HW_RFKILL_STATE, rtwdev->flags);
+	blocked = rtw89_core_rfkill_get(rtwdev);
+
+	if (!force && prev == blocked)
+		return;
+
+	rtw89_info(rtwdev, "rfkill hardware state changed to %s\n",
+		   blocked ? "disable" : "enable");
+
+	if (blocked)
+		set_bit(RTW89_FLAG_HW_RFKILL_STATE, rtwdev->flags);
+	else
+		clear_bit(RTW89_FLAG_HW_RFKILL_STATE, rtwdev->flags);
+
+	wiphy_rfkill_set_hw_state(rtwdev->hw->wiphy, blocked);
+}
+
 int rtw89_chip_info_setup(struct rtw89_dev *rtwdev)
 {
 	int ret;
@@ -4654,6 +4719,8 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 		goto err_unregister_hw;
 	}
 
+	rtw89_rfkill_polling_init(rtwdev);
+
 	return 0;
 
 err_unregister_hw:
@@ -4668,6 +4735,7 @@ static void rtw89_core_unregister_hw(struct rtw89_dev *rtwdev)
 {
 	struct ieee80211_hw *hw = rtwdev->hw;
 
+	rtw89_rfkill_polling_deinit(rtwdev);
 	ieee80211_unregister_hw(hw);
 	rtw89_core_clr_supported_band(rtwdev);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 0a09360515dc..a0d0bf53d961 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4069,6 +4069,11 @@ struct rtw89_rrsr_cfgs {
 	struct rtw89_reg3_def rsc;
 };
 
+struct rtw89_rfkill_regs {
+	struct rtw89_reg3_def pinmux;
+	struct rtw89_reg3_def mode;
+};
+
 struct rtw89_dig_regs {
 	u32 seg0_pd_reg;
 	u32 pd_lower_bound_mask;
@@ -4260,6 +4265,8 @@ struct rtw89_chip_info {
 	const struct rtw89_rrsr_cfgs *rrsr_cfgs;
 	struct rtw89_reg_def bss_clr_vld;
 	u32 bss_clr_map_reg;
+	const struct rtw89_rfkill_regs *rfkill_init;
+	struct rtw89_reg_def rfkill_get;
 	u32 dma_ch_mask;
 	const struct rtw89_edcca_regs *edcca_regs;
 	const struct wiphy_wowlan_support *wowlan_stub;
@@ -4618,6 +4625,7 @@ enum rtw89_flags {
 	RTW89_FLAG_WOWLAN,
 	RTW89_FLAG_FORBIDDEN_TRACK_WROK,
 	RTW89_FLAG_CHANGING_INTERFACE,
+	RTW89_FLAG_HW_RFKILL_STATE,
 
 	NUM_OF_RTW89_FLAGS,
 };
@@ -6506,6 +6514,7 @@ int rtw89_core_sta_remove(struct rtw89_dev *rtwdev,
 void rtw89_core_set_tid_config(struct rtw89_dev *rtwdev,
 			       struct ieee80211_sta *sta,
 			       struct cfg80211_tid_config *tid_config);
+void rtw89_core_rfkill_poll(struct rtw89_dev *rtwdev, bool force);
 void rtw89_check_quirks(struct rtw89_dev *rtwdev, const struct dmi_system_id *quirks);
 int rtw89_core_init(struct rtw89_dev *rtwdev);
 void rtw89_core_deinit(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 1508693032cb..b95fa288c5f5 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1147,6 +1147,22 @@ static void rtw89_set_rekey_data(struct ieee80211_hw *hw,
 }
 #endif
 
+static void rtw89_ops_rfkill_poll(struct ieee80211_hw *hw)
+{
+	struct rtw89_dev *rtwdev = hw->priv;
+
+	mutex_lock(&rtwdev->mutex);
+
+	/* wl_disable GPIO get floating when entering LPS */
+	if (test_bit(RTW89_FLAG_RUNNING, rtwdev->flags))
+		goto out;
+
+	rtw89_core_rfkill_poll(rtwdev, false);
+
+out:
+	mutex_unlock(&rtwdev->mutex);
+}
+
 const struct ieee80211_ops rtw89_ops = {
 	.tx			= rtw89_ops_tx,
 	.wake_tx_queue		= rtw89_ops_wake_tx_queue,
@@ -1193,5 +1209,6 @@ const struct ieee80211_ops rtw89_ops = {
 	.set_wakeup		= rtw89_ops_set_wakeup,
 	.set_rekey_data		= rtw89_set_rekey_data,
 #endif
+	.rfkill_poll		= rtw89_ops_rfkill_poll,
 };
 EXPORT_SYMBOL(rtw89_ops);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 15b17e2cf99b..7afec48c4056 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -107,6 +107,15 @@
 #define B_AX_DBG_SEL0_16BIT BIT(11)
 #define B_AX_DBG_SEL0 GENMASK(7, 0)
 
+#define R_AX_GPIO_EXT_CTRL 0x0060
+#define B_AX_GPIO_MOD_15_TO_8_MASK GENMASK(31, 24)
+#define B_AX_GPIO_MOD_9 BIT(25)
+#define B_AX_GPIO_IO_SEL_15_TO_8_MASK GENMASK(23, 16)
+#define B_AX_GPIO_IO_SEL_9 BIT(17)
+#define B_AX_GPIO_OUT_15_TO_8_MASK GENMASK(15, 8)
+#define B_AX_GPIO_IN_15_TO_8_MASK GENMASK(7, 0)
+#define B_AX_GPIO_IN_9 BIT(1)
+
 #define R_AX_SYS_SDIO_CTRL 0x0070
 #define B_AX_PCIE_DIS_L2_CTRL_LDO_HCI BIT(15)
 #define B_AX_PCIE_DIS_WLSUS_AFT_PDN BIT(14)
@@ -267,6 +276,9 @@
 
 #define R_AX_GPIO0_7_FUNC_SEL 0x02D0
 
+#define R_AX_GPIO8_15_FUNC_SEL 0x02D4
+#define B_AX_PINMUX_GPIO9_FUNC_SEL_MASK GENMASK(7, 4)
+
 #define R_AX_EECS_EESK_FUNC_SEL 0x02D8
 #define B_AX_PINMUX_EESK_FUNC_SEL_MASK GENMASK(7, 4)
 
@@ -3910,6 +3922,15 @@
 #define R_BE_EFUSE_CTRL_1_V1 0x0034
 #define B_BE_EF_DATA_MASK GENMASK(31, 0)
 
+#define R_BE_GPIO_EXT_CTRL 0x0060
+#define B_BE_GPIO_MOD_15_TO_8_MASK GENMASK(31, 24)
+#define B_BE_GPIO_MOD_9 BIT(25)
+#define B_BE_GPIO_IO_SEL_15_TO_8_MASK GENMASK(23, 16)
+#define B_BE_GPIO_IO_SEL_9 BIT(17)
+#define B_BE_GPIO_OUT_15_TO_8_MASK GENMASK(15, 8)
+#define B_BE_GPIO_IN_15_TO_8_MASK GENMASK(7, 0)
+#define B_BE_GPIO_IN_9 BIT(1)
+
 #define R_BE_WL_BT_PWR_CTRL 0x0068
 #define B_BE_ISO_BD2PP BIT(31)
 #define B_BE_LDOV12B_EN BIT(30)
@@ -4355,6 +4376,9 @@
 #define B_BE_REG_CK40M_EN BIT(1)
 #define B_BE_REG_CK640M_EN BIT(0)
 
+#define R_BE_GPIO8_15_FUNC_SEL 0x02D4
+#define B_BE_PINMUX_GPIO9_FUNC_SEL_MASK GENMASK(7, 4)
+
 #define R_BE_WLAN_XTAL_SI_CTRL 0x0270
 #define B_BE_WL_XTAL_SI_CMD_POLL BIT(31)
 #define B_BE_WL_XTAL_SI_CHIPID_MASK GENMASK(30, 28)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 40cf84a79c46..b8f57a602dcf 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -185,6 +185,15 @@ static const struct rtw89_rrsr_cfgs rtw8851b_rrsr_cfgs = {
 	.rsc = {R_AX_TRXPTCL_RRSR_CTL_0, B_AX_WMAC_RESP_RSC_MASK, 2},
 };
 
+static const struct rtw89_rfkill_regs rtw8851b_rfkill_regs = {
+	.pinmux = {R_AX_GPIO8_15_FUNC_SEL,
+		   B_AX_PINMUX_GPIO9_FUNC_SEL_MASK,
+		   0xf},
+	.mode = {R_AX_GPIO_EXT_CTRL + 2,
+		 (B_AX_GPIO_MOD_9 | B_AX_GPIO_IO_SEL_9) >> 16,
+		 0x0},
+};
+
 static const struct rtw89_dig_regs rtw8851b_dig_regs = {
 	.seg0_pd_reg = R_SEG0R_PD_V1,
 	.pd_lower_bound_mask = B_SEG0R_PD_LOWER_BOUND_MSK,
@@ -2524,6 +2533,8 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.rrsr_cfgs		= &rtw8851b_rrsr_cfgs,
 	.bss_clr_vld		= {R_BSS_CLR_MAP_V1, B_BSS_CLR_MAP_VLD0},
 	.bss_clr_map_reg	= R_BSS_CLR_MAP_V1,
+	.rfkill_init		= &rtw8851b_rfkill_regs,
+	.rfkill_get		= {R_AX_GPIO_EXT_CTRL, B_AX_GPIO_IN_9},
 	.dma_ch_mask		= BIT(RTW89_DMA_ACH4) | BIT(RTW89_DMA_ACH5) |
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
 				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 08e148328c62..88f8f2f4c6e2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -478,6 +478,15 @@ static const struct rtw89_rrsr_cfgs rtw8852a_rrsr_cfgs = {
 	.rsc = {R_AX_TRXPTCL_RRSR_CTL_0, B_AX_WMAC_RESP_RSC_MASK, 2},
 };
 
+static const struct rtw89_rfkill_regs rtw8852a_rfkill_regs = {
+	.pinmux = {R_AX_GPIO8_15_FUNC_SEL,
+		   B_AX_PINMUX_GPIO9_FUNC_SEL_MASK,
+		   0xf},
+	.mode = {R_AX_GPIO_EXT_CTRL + 2,
+		 (B_AX_GPIO_MOD_9 | B_AX_GPIO_IO_SEL_9) >> 16,
+		 0x0},
+};
+
 static const struct rtw89_dig_regs rtw8852a_dig_regs = {
 	.seg0_pd_reg = R_SEG0R_PD,
 	.pd_lower_bound_mask = B_SEG0R_PD_LOWER_BOUND_MSK,
@@ -2240,6 +2249,8 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.rrsr_cfgs		= &rtw8852a_rrsr_cfgs,
 	.bss_clr_vld		= {R_BSS_CLR_MAP, B_BSS_CLR_MAP_VLD0},
 	.bss_clr_map_reg	= R_BSS_CLR_MAP,
+	.rfkill_init		= &rtw8852a_rfkill_regs,
+	.rfkill_get		= {R_AX_GPIO_EXT_CTRL, B_AX_GPIO_IN_9},
 	.dma_ch_mask		= 0,
 	.edcca_regs		= &rtw8852a_edcca_regs,
 #ifdef CONFIG_PM
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index a22847a311ad..ef888545d988 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -150,6 +150,15 @@ static const struct rtw89_rrsr_cfgs rtw8852b_rrsr_cfgs = {
 	.rsc = {R_AX_TRXPTCL_RRSR_CTL_0, B_AX_WMAC_RESP_RSC_MASK, 2},
 };
 
+static const struct rtw89_rfkill_regs rtw8852b_rfkill_regs = {
+	.pinmux = {R_AX_GPIO8_15_FUNC_SEL,
+		   B_AX_PINMUX_GPIO9_FUNC_SEL_MASK,
+		   0xf},
+	.mode = {R_AX_GPIO_EXT_CTRL + 2,
+		 (B_AX_GPIO_MOD_9 | B_AX_GPIO_IO_SEL_9) >> 16,
+		 0x0},
+};
+
 static const struct rtw89_dig_regs rtw8852b_dig_regs = {
 	.seg0_pd_reg = R_SEG0R_PD_V1,
 	.pd_lower_bound_mask = B_SEG0R_PD_LOWER_BOUND_MSK,
@@ -880,6 +889,8 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.rrsr_cfgs		= &rtw8852b_rrsr_cfgs,
 	.bss_clr_vld		= {R_BSS_CLR_MAP_V1, B_BSS_CLR_MAP_VLD0},
 	.bss_clr_map_reg	= R_BSS_CLR_MAP_V1,
+	.rfkill_init		= &rtw8852b_rfkill_regs,
+	.rfkill_get		= {R_AX_GPIO_EXT_CTRL, B_AX_GPIO_IN_9},
 	.dma_ch_mask		= BIT(RTW89_DMA_ACH4) | BIT(RTW89_DMA_ACH5) |
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
 				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index dd9fbddc411a..8173063bcc8e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -148,6 +148,15 @@ static const struct rtw89_rrsr_cfgs rtw8852bt_rrsr_cfgs = {
 	.rsc = {R_AX_TRXPTCL_RRSR_CTL_0, B_AX_WMAC_RESP_RSC_MASK, 2},
 };
 
+static const struct rtw89_rfkill_regs rtw8852bt_rfkill_regs = {
+	.pinmux = {R_AX_GPIO8_15_FUNC_SEL,
+		   B_AX_PINMUX_GPIO9_FUNC_SEL_MASK,
+		   0xf},
+	.mode = {R_AX_GPIO_EXT_CTRL + 2,
+		 (B_AX_GPIO_MOD_9 | B_AX_GPIO_IO_SEL_9) >> 16,
+		 0x0},
+};
+
 static const struct rtw89_dig_regs rtw8852bt_dig_regs = {
 	.seg0_pd_reg = R_SEG0R_PD_V1,
 	.pd_lower_bound_mask = B_SEG0R_PD_LOWER_BOUND_MSK,
@@ -813,6 +822,8 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.rrsr_cfgs		= &rtw8852bt_rrsr_cfgs,
 	.bss_clr_vld		= {R_BSS_CLR_MAP_V1, B_BSS_CLR_MAP_VLD0},
 	.bss_clr_map_reg	= R_BSS_CLR_MAP_V1,
+	.rfkill_init		= &rtw8852bt_rfkill_regs,
+	.rfkill_get		= {R_AX_GPIO_EXT_CTRL, B_AX_GPIO_IN_9},
 	.dma_ch_mask		= BIT(RTW89_DMA_ACH4) | BIT(RTW89_DMA_ACH5) |
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
 				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 193168dc7b6c..8e500d0eb70b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -147,6 +147,15 @@ static const struct rtw89_rrsr_cfgs rtw8852c_rrsr_cfgs = {
 	.rsc = {R_AX_PTCL_RRSR1, B_AX_RSC_MASK, 2},
 };
 
+static const struct rtw89_rfkill_regs rtw8852c_rfkill_regs = {
+	.pinmux = {R_AX_GPIO8_15_FUNC_SEL,
+		   B_AX_PINMUX_GPIO9_FUNC_SEL_MASK,
+		   0xf},
+	.mode = {R_AX_GPIO_EXT_CTRL + 2,
+		 (B_AX_GPIO_MOD_9 | B_AX_GPIO_IO_SEL_9) >> 16,
+		 0x0},
+};
+
 static const struct rtw89_dig_regs rtw8852c_dig_regs = {
 	.seg0_pd_reg = R_SEG0R_PD,
 	.pd_lower_bound_mask = B_SEG0R_PD_LOWER_BOUND_MSK,
@@ -3022,6 +3031,8 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.rrsr_cfgs		= &rtw8852c_rrsr_cfgs,
 	.bss_clr_vld		= {R_BSS_CLR_MAP, B_BSS_CLR_MAP_VLD0},
 	.bss_clr_map_reg	= R_BSS_CLR_MAP,
+	.rfkill_init		= &rtw8852c_rfkill_regs,
+	.rfkill_get		= {R_AX_GPIO_EXT_CTRL, B_AX_GPIO_IN_9},
 	.dma_ch_mask		= 0,
 	.edcca_regs		= &rtw8852c_edcca_regs,
 #ifdef CONFIG_PM
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 2af568a3264d..c763b14d43e9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -165,6 +165,15 @@ static const struct rtw89_rrsr_cfgs rtw8922a_rrsr_cfgs = {
 	.rsc = {R_BE_PTCL_RRSR1, B_BE_RSC_MASK, 2},
 };
 
+static const struct rtw89_rfkill_regs rtw8922a_rfkill_regs = {
+	.pinmux = {R_BE_GPIO8_15_FUNC_SEL,
+		   B_BE_PINMUX_GPIO9_FUNC_SEL_MASK,
+		   0xf},
+	.mode = {R_BE_GPIO_EXT_CTRL + 2,
+		 (B_BE_GPIO_MOD_9 | B_BE_GPIO_IO_SEL_9) >> 16,
+		 0x0},
+};
+
 static const struct rtw89_dig_regs rtw8922a_dig_regs = {
 	.seg0_pd_reg = R_SEG0R_PD_V2,
 	.pd_lower_bound_mask = B_SEG0R_PD_LOWER_BOUND_MSK,
@@ -2624,6 +2633,8 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.rrsr_cfgs		= &rtw8922a_rrsr_cfgs,
 	.bss_clr_vld		= {R_BSS_CLR_VLD_V2, B_BSS_CLR_VLD0_V2},
 	.bss_clr_map_reg	= R_BSS_CLR_MAP_V2,
+	.rfkill_init		= &rtw8922a_rfkill_regs,
+	.rfkill_get		= {R_BE_GPIO_EXT_CTRL, B_BE_GPIO_IN_9},
 	.dma_ch_mask		= 0,
 	.edcca_regs		= &rtw8922a_edcca_regs,
 #ifdef CONFIG_PM
-- 
2.25.1


