Return-Path: <linux-wireless+bounces-9266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53C390FC6B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 07:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C214283ADE
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 05:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B7C383AE;
	Thu, 20 Jun 2024 05:58:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A51C2744C
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 05:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863129; cv=none; b=jqkjEPZK4Pkii/kP/XiXWleI3hQ+myBcn6xZV0jyNZ3dSg/9FvbLmGAxGbUP0b7HP0j+pPFO0uRKjrFTv85+/7rh24FXV6tVPrGMQAChzS1md8Qu0xiANQRlnu1OH3ZU9wySz/ytl/0KwkxMFceZ0lmz2oakxILn1JOCjOHkSV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863129; c=relaxed/simple;
	bh=qSjx2ZR0SpsLOLSLb654XahFGDfzTaGPPptrGztQPE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SPuR2L9+Q9iiCOXKkjBNhq4+0Oy41iEjYMVWp+1yYfgAfqB3tyEpClSG0kInBeT8mB28UYIBlrreh9PZs989sKozGk2A4ErNXIwJchOdOo0zJYe2l5ilsQNGEaIU2xGgSvZKalnZ1xra06OsexV3zEdeov/vfpXko41aClPoNvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45K5wifjF2577635, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45K5wifjF2577635
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 13:58:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 13:58:45 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 20 Jun
 2024 13:58:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH 2/7] wifi: rtw89: wow: update WoWLAN reason register for different FW
Date: Thu, 20 Jun 2024 13:58:20 +0800
Message-ID: <20240620055825.17592-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620055825.17592-1-pkshih@realtek.com>
References: <20240620055825.17592-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

Need to update WoWLAN wakeup reason register after firmware version
0.35.22.0 for RTL8922A, and 0.27.80.0 for RTL8852CE.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 3 ++-
 drivers/net/wireless/realtek/rtw89/fw.c       | 2 ++
 drivers/net/wireless/realtek/rtw89/fw.h       | 6 ++++++
 drivers/net/wireless/realtek/rtw89/reg.h      | 4 ++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 6 +++++-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 6 +++++-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 6 +++++-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 6 +++++-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 6 +++++-
 drivers/net/wireless/realtek/rtw89/wow.c      | 7 ++++++-
 10 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e8ec0246bccd..f1de975c5356 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4236,7 +4236,7 @@ struct rtw89_chip_info {
 	const u32 *c2h_regs;
 	struct rtw89_reg_def c2h_counter_reg;
 	const struct rtw89_page_regs *page_regs;
-	u32 wow_reason_reg;
+	const u32 *wow_reason_reg;
 	bool cfo_src_fd;
 	bool cfo_hw_comp;
 	const struct rtw89_reg_def *dcfo_comp;
@@ -4346,6 +4346,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_NO_LPS_PG,
 	RTW89_FW_FEATURE_BEACON_FILTER,
 	RTW89_FW_FEATURE_MACID_PAUSE_SLEEP,
+	RTW89_FW_FEATURE_WOW_REASON_V1,
 };
 
 struct rtw89_fw_suit {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 3c666fd0f8ed..a907d381ac77 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -675,10 +675,12 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 36, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 40, 0, CRASH_TRIGGER),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 56, 10, BEACON_FILTER),
+	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 80, 0, WOW_REASON_V1),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 30, 0, CRASH_TRIGGER),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 11, 0, MACID_PAUSE_SLEEP),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 35, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 12, 0, BEACON_FILTER),
+	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 22, 0, WOW_REASON_V1),
 };
 
 static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 01fea0b004d3..c3b4324c621c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4659,4 +4659,10 @@ const struct rtw89_rfe_parms *
 rtw89_load_rfe_data_from_fw(struct rtw89_dev *rtwdev,
 			    const struct rtw89_rfe_parms *init);
 
+enum rtw89_wow_wakeup_ver {
+	RTW89_WOW_REASON_V0,
+	RTW89_WOW_REASON_V1,
+	RTW89_WOW_REASON_NUM,
+};
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 5a59234301ca..fd81cf863bea 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -311,6 +311,8 @@
 #define B_AX_S1_LDO2PWRCUT_F BIT(23)
 #define B_AX_S0_LDO_VSEL_F_MASK GENMASK(22, 21)
 
+#define R_AX_DBG_WOW 0x0504
+
 #define R_AX_SEC_CTRL 0x0C00
 #define B_AX_SEC_IDMEM_SIZE_CONFIG_MASK GENMASK(17, 16)
 
@@ -4315,6 +4317,8 @@
 
 #define R_BE_WLCPU_PORT_PC 0x03FC
 
+#define R_BE_DBG_WOW 0x0504
+
 #define R_BE_DCPU_PLATFORM_ENABLE 0x0888
 #define B_BE_DCPU_SYM_DPLT_MEM_MUX_EN BIT(10)
 #define B_BE_DCPU_WARM_EN BIT(9)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 78e276f321c2..40cf84a79c46 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -105,6 +105,10 @@ static const u32 rtw8851b_c2h_regs[RTW89_C2HREG_MAX] = {
 	R_AX_C2HREG_DATA3
 };
 
+static const u32 rtw8851b_wow_wakeup_regs[RTW89_WOW_REASON_NUM] = {
+	R_AX_C2HREG_DATA3 + 3, R_AX_C2HREG_DATA3 + 3,
+};
+
 static const struct rtw89_page_regs rtw8851b_page_regs = {
 	.hci_fc_ctrl	= R_AX_HCI_FC_CTRL,
 	.ch_page_ctrl	= R_AX_CH_PAGE_CTRL,
@@ -2509,7 +2513,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.c2h_counter_reg	= {R_AX_UDM1 + 1, B_AX_UDM1_HALMAC_C2H_ENQ_CNT_MASK >> 8},
 	.c2h_regs		= rtw8851b_c2h_regs,
 	.page_regs		= &rtw8851b_page_regs,
-	.wow_reason_reg		= R_AX_C2HREG_DATA3 + 3,
+	.wow_reason_reg		= rtw8851b_wow_wakeup_regs,
 	.cfo_src_fd		= true,
 	.cfo_hw_comp		= true,
 	.dcfo_comp		= &rtw8851b_dcfo_comp,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index aebbceea93f8..08e148328c62 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -398,6 +398,10 @@ static const u32 rtw8852a_c2h_regs[RTW89_C2HREG_MAX] = {
 	R_AX_C2HREG_DATA3
 };
 
+static const u32 rtw8852a_wow_wakeup_regs[RTW89_WOW_REASON_NUM] = {
+	R_AX_C2HREG_DATA3 + 3, R_AX_C2HREG_DATA3 + 3,
+};
+
 static const struct rtw89_page_regs rtw8852a_page_regs = {
 	.hci_fc_ctrl	= R_AX_HCI_FC_CTRL,
 	.ch_page_ctrl	= R_AX_CH_PAGE_CTRL,
@@ -2225,7 +2229,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.c2h_regs		= rtw8852a_c2h_regs,
 	.c2h_counter_reg	= {R_AX_UDM1 + 1, B_AX_UDM1_HALMAC_C2H_ENQ_CNT_MASK >> 8},
 	.page_regs		= &rtw8852a_page_regs,
-	.wow_reason_reg		= R_AX_C2HREG_DATA3 + 3,
+	.wow_reason_reg		= rtw8852a_wow_wakeup_regs,
 	.cfo_src_fd		= false,
 	.cfo_hw_comp            = false,
 	.dcfo_comp		= &rtw8852a_dcfo_comp,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 381c881fee69..24f9fd444ca0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -76,6 +76,10 @@ static const u32 rtw8852b_c2h_regs[RTW89_C2HREG_MAX] = {
 	R_AX_C2HREG_DATA3
 };
 
+static const u32 rtw8852b_wow_wakeup_regs[RTW89_WOW_REASON_NUM] = {
+	R_AX_C2HREG_DATA3 + 3, R_AX_C2HREG_DATA3 + 3,
+};
+
 static const struct rtw89_page_regs rtw8852b_page_regs = {
 	.hci_fc_ctrl	= R_AX_HCI_FC_CTRL,
 	.ch_page_ctrl	= R_AX_CH_PAGE_CTRL,
@@ -1026,7 +1030,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.c2h_counter_reg	= {R_AX_UDM1 + 1, B_AX_UDM1_HALMAC_C2H_ENQ_CNT_MASK >> 8},
 	.c2h_regs		= rtw8852b_c2h_regs,
 	.page_regs		= &rtw8852b_page_regs,
-	.wow_reason_reg		= R_AX_C2HREG_DATA3 + 3,
+	.wow_reason_reg		= rtw8852b_wow_wakeup_regs,
 	.cfo_src_fd		= true,
 	.cfo_hw_comp		= true,
 	.dcfo_comp		= &rtw8852b_dcfo_comp,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 544ea1d3b577..193168dc7b6c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -73,6 +73,10 @@ static const u32 rtw8852c_c2h_regs[RTW89_H2CREG_MAX] = {
 	R_AX_C2HREG_DATA3_V1
 };
 
+static const u32 rtw8852c_wow_wakeup_regs[RTW89_WOW_REASON_NUM] = {
+	R_AX_C2HREG_DATA3_V1 + 3, R_AX_DBG_WOW,
+};
+
 static const struct rtw89_page_regs rtw8852c_page_regs = {
 	.hci_fc_ctrl	= R_AX_HCI_FC_CTRL_V1,
 	.ch_page_ctrl	= R_AX_CH_PAGE_CTRL_V1,
@@ -3007,7 +3011,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.c2h_counter_reg	= {R_AX_UDM1 + 1, B_AX_UDM1_HALMAC_C2H_ENQ_CNT_MASK >> 8},
 	.c2h_regs		= rtw8852c_c2h_regs,
 	.page_regs		= &rtw8852c_page_regs,
-	.wow_reason_reg		= R_AX_C2HREG_DATA3_V1 + 3,
+	.wow_reason_reg		= rtw8852c_wow_wakeup_regs,
 	.cfo_src_fd		= false,
 	.cfo_hw_comp            = false,
 	.dcfo_comp		= &rtw8852c_dcfo_comp,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index cc4f251caadd..2af568a3264d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -85,6 +85,10 @@ static const u32 rtw8922a_c2h_regs[RTW89_H2CREG_MAX] = {
 	R_BE_C2HREG_DATA3
 };
 
+static const u32 rtw8922a_wow_wakeup_regs[RTW89_WOW_REASON_NUM] = {
+	R_AX_C2HREG_DATA3_V1 + 3, R_BE_DBG_WOW,
+};
+
 static const struct rtw89_page_regs rtw8922a_page_regs = {
 	.hci_fc_ctrl	= R_BE_HCI_FC_CTRL,
 	.ch_page_ctrl	= R_BE_CH_PAGE_CTRL,
@@ -2609,7 +2613,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.c2h_counter_reg	= {R_BE_UDM1 + 1, B_BE_UDM1_HALMAC_C2H_ENQ_CNT_MASK >> 8},
 	.c2h_regs		= rtw8922a_c2h_regs,
 	.page_regs		= &rtw8922a_page_regs,
-	.wow_reason_reg		= R_AX_C2HREG_DATA3_V1 + 3,
+	.wow_reason_reg		= rtw8922a_wow_wakeup_regs,
 	.cfo_src_fd		= true,
 	.cfo_hw_comp            = true,
 	.dcfo_comp		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index df22a53b8f41..a49265cda98f 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -723,13 +723,18 @@ static void rtw89_wow_show_wakeup_reason(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct rtw89_wow_aoac_report *aoac_rpt = &rtw_wow->aoac_rpt;
-	u32 wow_reason_reg = rtwdev->chip->wow_reason_reg;
 	struct cfg80211_wowlan_nd_info nd_info;
 	struct cfg80211_wowlan_wakeup wakeup = {
 		.pattern_idx = -1,
 	};
+	u32 wow_reason_reg;
 	u8 reason;
 
+	if (RTW89_CHK_FW_FEATURE(WOW_REASON_V1, &rtwdev->fw))
+		wow_reason_reg = rtwdev->chip->wow_reason_reg[RTW89_WOW_REASON_V1];
+	else
+		wow_reason_reg = rtwdev->chip->wow_reason_reg[RTW89_WOW_REASON_V0];
+
 	reason = rtw89_read8(rtwdev, wow_reason_reg);
 	switch (reason) {
 	case RTW89_WOW_RSN_RX_DEAUTH:
-- 
2.25.1


