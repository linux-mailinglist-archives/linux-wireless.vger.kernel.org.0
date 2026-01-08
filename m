Return-Path: <linux-wireless+bounces-30545-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A67BD03D92
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90BDE31FA559
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2F64849F7;
	Thu,  8 Jan 2026 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Gwr+YY9R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB16484A16
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873811; cv=none; b=qQMCWf567BfMAF1zAM9IzcuyPb7G5sdwcKiKOUJNvCdl+YcIzM5X7drAa/5KpS5S+/Iv0WvcwZVpCpZ5bOcUw4xIrSDCOwH6CKgROo19w1TqBZ80UDXNMzhZJSYkRri8qKV3TVTNfETbPowP83Q75ngLOBm7tAZllPvCxmKYk5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873811; c=relaxed/simple;
	bh=YyHDJklJwEDtOMcN0Qbb8hE9l+QZ+Fy1IGRXUHvKgdc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=is+d1skd8nZeJfco0gUZXGo+NYZ9TG/sO3l3dcaGeUmpZAMURYmzkn5BeKzc2eg/WlGciWJO6B4EheNnMI0ekEKhntZt8vtt0nBcJACkHGzoYcTUSwlLB4/bZGhoRRSi7RdfTay0bkcDLMPwz6NSDj7gYsCZvjW9wZyW9oU+70Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Gwr+YY9R; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 608C3POx8969967, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767873805; bh=tBiw/TBDt6tzOHKbbNejgD/szTmrLYUVsp3cDtsh28o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Gwr+YY9RKMlwpY+3T9quocu4gs1DfjwUPC+aHJxNqqovLOV0Cm/3PjoFRGhSntcz5
	 mFilOjDZOCACmV+bG89hVsp4s8nPHoDXr8M0Y6LcYiSHrhB7x4b1lUyACZaNSdEvzg
	 EB1bM+7HxJvG9+/LpBRO3D1j/k62hB5ferAcnhmGKNHev/VZeycvbxLpiXpplUDxlE
	 Fw7E9zsoejeGBeahV+3vmIhdYQUxc3R52XTCTH+fdfgtOTDCeLviRx9iupqLkbh1J1
	 5uYw/m8V9Wh8DcZfPlysAUavivLWSA5XjK7GQJ91KY/sV6iOzE1f6X/9nUsg6IfFPI
	 w1lQOm6gdK5Kw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 608C3POx8969967
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 8 Jan 2026 20:03:25 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 8 Jan 2026 20:03:25 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 8 Jan 2026 20:03:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>
Subject: [PATCH rtw-next 01/13] wifi: rtw89: coex: make coex scoreboard as chip info
Date: Thu, 8 Jan 2026 20:03:08 +0800
Message-ID: <20260108120320.2217402-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260108120320.2217402-1-pkshih@realtek.com>
References: <20260108120320.2217402-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The coex scoreboard is to exchange WiFi and BT profiles, and the coming
chip 8922D changes the design including extend to two scoreboards and
individual register for cfg/get. Follow the changes to abstract current
code, but not change logic for existing chips at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h      |  8 ++++++++
 drivers/net/wireless/realtek/rtw89/mac.c       | 16 +++++++++++-----
 drivers/net/wireless/realtek/rtw89/reg.h       |  4 ++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c  |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c  |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c  |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c  |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c  |  1 +
 9 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 661b6a23082a..84b6549d411c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4338,6 +4338,13 @@ struct rtw89_rfkill_regs {
 	struct rtw89_reg3_def mode;
 };
 
+struct rtw89_sb_regs {
+	struct {
+		u32 cfg;
+		u32 get;
+	} n[2];
+};
+
 struct rtw89_dig_regs {
 	u32 seg0_pd_reg;
 	u32 pd_lower_bound_mask;
@@ -4555,6 +4562,7 @@ struct rtw89_chip_info {
 	u32 bss_clr_map_reg;
 	const struct rtw89_rfkill_regs *rfkill_init;
 	struct rtw89_reg_def rfkill_get;
+	struct rtw89_sb_regs btc_sb;
 	u32 dma_ch_mask;
 	const struct rtw89_edcca_regs *edcca_regs;
 	const struct wiphy_wowlan_support *wowlan_stub;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 1375ab324a8b..1a53824f58b5 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1498,6 +1498,7 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_pwr_cfg * const *cfg_seq;
 	int (*cfg_func)(struct rtw89_dev *rtwdev);
+	u32 reg = chip->btc_sb.n[0].cfg;
 	int ret;
 
 	rtw89_mac_power_switch_boot_mode(rtwdev);
@@ -1537,14 +1538,14 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 		set_bit(RTW89_FLAG_POWERON, rtwdev->flags);
 		set_bit(RTW89_FLAG_DMAC_FUNC, rtwdev->flags);
 		set_bit(RTW89_FLAG_CMAC0_FUNC, rtwdev->flags);
-		rtw89_write8(rtwdev, R_AX_SCOREBOARD + 3, MAC_AX_NOTIFY_TP_MAJOR);
+		rtw89_write8(rtwdev, reg + 3, MAC_AX_NOTIFY_TP_MAJOR);
 	} else {
 		clear_bit(RTW89_FLAG_POWERON, rtwdev->flags);
 		clear_bit(RTW89_FLAG_DMAC_FUNC, rtwdev->flags);
 		clear_bit(RTW89_FLAG_CMAC0_FUNC, rtwdev->flags);
 		clear_bit(RTW89_FLAG_CMAC1_FUNC, rtwdev->flags);
 		clear_bit(RTW89_FLAG_FW_RDY, rtwdev->flags);
-		rtw89_write8(rtwdev, R_AX_SCOREBOARD + 3, MAC_AX_NOTIFY_PWR_MAJOR);
+		rtw89_write8(rtwdev, reg + 3, MAC_AX_NOTIFY_PWR_MAJOR);
 		rtw89_set_entity_state(rtwdev, RTW89_PHY_0, false);
 		rtw89_set_entity_state(rtwdev, RTW89_PHY_1, false);
 	}
@@ -6413,9 +6414,11 @@ int rtw89_mac_cfg_plt_ax(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_plt *plt)
 
 void rtw89_mac_cfg_sb(struct rtw89_dev *rtwdev, u32 val)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u32 reg = chip->btc_sb.n[0].cfg;
 	u32 fw_sb;
 
-	fw_sb = rtw89_read32(rtwdev, R_AX_SCOREBOARD);
+	fw_sb = rtw89_read32(rtwdev, reg);
 	fw_sb = FIELD_GET(B_MAC_AX_SB_FW_MASK, fw_sb);
 	fw_sb = fw_sb & ~B_MAC_AX_BTGS1_NOTIFY;
 	if (!test_bit(RTW89_FLAG_POWERON, rtwdev->flags))
@@ -6426,13 +6429,16 @@ void rtw89_mac_cfg_sb(struct rtw89_dev *rtwdev, u32 val)
 	val = B_AX_TOGGLE |
 	      FIELD_PREP(B_MAC_AX_SB_DRV_MASK, val) |
 	      FIELD_PREP(B_MAC_AX_SB_FW_MASK, fw_sb);
-	rtw89_write32(rtwdev, R_AX_SCOREBOARD, val);
+	rtw89_write32(rtwdev, reg, val);
 	fsleep(1000); /* avoid BT FW loss information */
 }
 
 u32 rtw89_mac_get_sb(struct rtw89_dev *rtwdev)
 {
-	return rtw89_read32(rtwdev, R_AX_SCOREBOARD);
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u32 reg = chip->btc_sb.n[0].get;
+
+	return rtw89_read32(rtwdev, reg);
 }
 
 int rtw89_mac_cfg_ctrl_path(struct rtw89_dev *rtwdev, bool wl)
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 9f963bd85f02..afe13c0c5629 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4220,6 +4220,10 @@
 #define B_BE_EF_DSB_EN BIT(11)
 #define B_BE_EF_DLY_SEL_MASK GENMASK(3, 0)
 
+#define R_BE_SCOREBOARD 0x00AC
+#define B_BE_TOGGLE BIT(31)
+#define B_BE_DATA_LINE_MASK GENMASK(30, 0)
+
 #define R_BE_PMC_DBG_CTRL2 0x00CC
 #define B_BE_EFUSE_BURN_GNT_MASK GENMASK(31, 24)
 #define B_BE_DIS_IOWRAP_TIMEOUT BIT(16)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index e06e70751735..0383d3b5c7bc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2707,6 +2707,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.bss_clr_map_reg	= R_BSS_CLR_MAP_V1,
 	.rfkill_init		= &rtw8851b_rfkill_regs,
 	.rfkill_get		= {R_AX_GPIO_EXT_CTRL, B_AX_GPIO_IN_9},
+	.btc_sb			= {{{R_AX_SCOREBOARD, R_AX_SCOREBOARD},}},
 	.dma_ch_mask		= BIT(RTW89_DMA_ACH4) | BIT(RTW89_DMA_ACH5) |
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
 				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index bb12982afef7..329fc0a7b07b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2394,6 +2394,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.bss_clr_map_reg	= R_BSS_CLR_MAP,
 	.rfkill_init		= &rtw8852a_rfkill_regs,
 	.rfkill_get		= {R_AX_GPIO_EXT_CTRL, B_AX_GPIO_IN_9},
+	.btc_sb			= {{{R_AX_SCOREBOARD, R_AX_SCOREBOARD},}},
 	.dma_ch_mask		= 0,
 	.edcca_regs		= &rtw8852a_edcca_regs,
 #ifdef CONFIG_PM
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index a138d89bce84..f44674a39e30 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -1041,6 +1041,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.bss_clr_map_reg	= R_BSS_CLR_MAP_V1,
 	.rfkill_init		= &rtw8852b_rfkill_regs,
 	.rfkill_get		= {R_AX_GPIO_EXT_CTRL, B_AX_GPIO_IN_9},
+	.btc_sb			= {{{R_AX_SCOREBOARD, R_AX_SCOREBOARD},}},
 	.dma_ch_mask		= BIT(RTW89_DMA_ACH4) | BIT(RTW89_DMA_ACH5) |
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
 				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 7b637483e9b4..ab60ed389ff7 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -878,6 +878,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.bss_clr_map_reg	= R_BSS_CLR_MAP_V1,
 	.rfkill_init		= &rtw8852bt_rfkill_regs,
 	.rfkill_get		= {R_AX_GPIO_EXT_CTRL, B_AX_GPIO_IN_9},
+	.btc_sb			= {{{R_AX_SCOREBOARD, R_AX_SCOREBOARD},}},
 	.dma_ch_mask		= BIT(RTW89_DMA_ACH4) | BIT(RTW89_DMA_ACH5) |
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
 				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index a82bbe3ec901..d2138be3640d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3239,6 +3239,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.bss_clr_map_reg	= R_BSS_CLR_MAP,
 	.rfkill_init		= &rtw8852c_rfkill_regs,
 	.rfkill_get		= {R_AX_GPIO_EXT_CTRL, B_AX_GPIO_IN_9},
+	.btc_sb			= {{{R_AX_SCOREBOARD, R_AX_SCOREBOARD},}},
 	.dma_ch_mask		= 0,
 	.edcca_regs		= &rtw8852c_edcca_regs,
 #ifdef CONFIG_PM
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 041ffec9a327..6d2cd914e16e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -3005,6 +3005,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.bss_clr_map_reg	= R_BSS_CLR_MAP_V2,
 	.rfkill_init		= &rtw8922a_rfkill_regs,
 	.rfkill_get		= {R_BE_GPIO_EXT_CTRL, B_BE_GPIO_IN_9},
+	.btc_sb			= {{{R_BE_SCOREBOARD, R_BE_SCOREBOARD},}},
 	.dma_ch_mask		= 0,
 	.edcca_regs		= &rtw8922a_edcca_regs,
 #ifdef CONFIG_PM
-- 
2.25.1


