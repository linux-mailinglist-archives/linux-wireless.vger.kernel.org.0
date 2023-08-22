Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891D478416B
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 14:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbjHVM7c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 08:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbjHVM7b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 08:59:31 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4B0CCEF
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 05:59:27 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37MCwvotF022605, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37MCwvotF022605
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Aug 2023 20:58:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 22 Aug 2023 20:59:19 +0800
Received: from [127.0.1.1] (172.16.23.216) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 22 Aug
 2023 20:59:18 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <cj.hsieh@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/6] wifi: rtw89: phy: add phy_gen_def::cr_base to support WiFi 7 chips
Date:   Tue, 22 Aug 2023 20:58:21 +0800
Message-ID: <20230822125822.23817-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230822125822.23817-1-pkshih@realtek.com>
References: <20230822125822.23817-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.23.216]
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

cr_base is base address of PHY control register. The base of WiFi 6 and 7
chips are 0x1_0000 and 0x2_0000 respectively, so define them accordingly.
For example, if PHY address is 0x1330, absolute address is 0x1_1330 for
WiFi 6 chips, and 0x2_1330 for WiFi 7 chips.

Meanwhile, there are two copies of PHY hardware named PHY0 and PHY1. The
offset between them is 0x2_0000, so the base address of PHY0 and PHY1 are
0x2_0000 and 0x4_0000 respectively.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  2 +
 drivers/net/wireless/realtek/rtw89/phy.c      |  8 ++++
 drivers/net/wireless/realtek/rtw89/phy.h      | 48 ++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/phy_be.c   | 10 ++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 8 files changed, 61 insertions(+), 11 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/phy_be.c

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 98e6d6ade6c0..c49a1ab53f09 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -15,6 +15,7 @@
 struct rtw89_dev;
 struct rtw89_pci_info;
 struct rtw89_mac_gen_def;
+struct rtw89_phy_gen_def;
 
 extern const struct ieee80211_ops rtw89_ops;
 
@@ -3381,6 +3382,7 @@ struct rtw89_chip_info {
 	enum rtw89_chip_gen chip_gen;
 	const struct rtw89_chip_ops *ops;
 	const struct rtw89_mac_gen_def *mac_def;
+	const struct rtw89_phy_gen_def *phy_def;
 	const char *fw_basename;
 	u8 fw_format_max;
 	bool try_ce_fw;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index fa37d7d06093..9dc444934125 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1446,6 +1446,9 @@ static u32 rtw89_phy0_phy1_offset(struct rtw89_dev *rtwdev, u32 addr)
 	u32 phy_page = addr >> 8;
 	u32 ofst = 0;
 
+	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE)
+		return addr < 0x10000 ? 0x20000 : 0;
+
 	switch (phy_page) {
 	case 0x6:
 	case 0x7:
@@ -4725,3 +4728,8 @@ void rtw89_phy_config_edcca(struct rtw89_dev *rtwdev, bool scan)
 		rtw89_phy_write32(rtwdev, reg, hal->edcca_bak);
 	}
 }
+
+const struct rtw89_phy_gen_def rtw89_phy_gen_ax = {
+	.cr_base = 0x10000,
+};
+EXPORT_SYMBOL(rtw89_phy_gen_ax);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index ab174a0ba488..36a24676b2fe 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -7,7 +7,6 @@
 
 #include "core.h"
 
-#define RTW89_PHY_ADDR_OFFSET	0x10000
 #define RTW89_RF_ADDR_ADSEL_MASK  BIT(16)
 
 #define get_phy_headline(addr)		FIELD_GET(GENMASK(31, 28), addr)
@@ -337,61 +336,88 @@ struct rtw89_nbi_reg_def {
 	struct rtw89_reg_def notch2_en;
 };
 
+struct rtw89_phy_gen_def {
+	u32 cr_base;
+};
+
+extern const struct rtw89_phy_gen_def rtw89_phy_gen_ax;
+extern const struct rtw89_phy_gen_def rtw89_phy_gen_be;
+
 static inline void rtw89_phy_write8(struct rtw89_dev *rtwdev,
 				    u32 addr, u8 data)
 {
-	rtw89_write8(rtwdev, addr | RTW89_PHY_ADDR_OFFSET, data);
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+
+	rtw89_write8(rtwdev, addr + phy->cr_base, data);
 }
 
 static inline void rtw89_phy_write16(struct rtw89_dev *rtwdev,
 				     u32 addr, u16 data)
 {
-	rtw89_write16(rtwdev, addr | RTW89_PHY_ADDR_OFFSET, data);
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+
+	rtw89_write16(rtwdev, addr + phy->cr_base, data);
 }
 
 static inline void rtw89_phy_write32(struct rtw89_dev *rtwdev,
 				     u32 addr, u32 data)
 {
-	rtw89_write32(rtwdev, addr | RTW89_PHY_ADDR_OFFSET, data);
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+
+	rtw89_write32(rtwdev, addr + phy->cr_base, data);
 }
 
 static inline void rtw89_phy_write32_set(struct rtw89_dev *rtwdev,
 					 u32 addr, u32 bits)
 {
-	rtw89_write32_set(rtwdev, addr | RTW89_PHY_ADDR_OFFSET, bits);
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+
+	rtw89_write32_set(rtwdev, addr + phy->cr_base, bits);
 }
 
 static inline void rtw89_phy_write32_clr(struct rtw89_dev *rtwdev,
 					 u32 addr, u32 bits)
 {
-	rtw89_write32_clr(rtwdev, addr | RTW89_PHY_ADDR_OFFSET, bits);
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+
+	rtw89_write32_clr(rtwdev, addr + phy->cr_base, bits);
 }
 
 static inline void rtw89_phy_write32_mask(struct rtw89_dev *rtwdev,
 					  u32 addr, u32 mask, u32 data)
 {
-	rtw89_write32_mask(rtwdev, addr | RTW89_PHY_ADDR_OFFSET, mask, data);
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+
+	rtw89_write32_mask(rtwdev, addr + phy->cr_base, mask, data);
 }
 
 static inline u8 rtw89_phy_read8(struct rtw89_dev *rtwdev, u32 addr)
 {
-	return rtw89_read8(rtwdev, addr | RTW89_PHY_ADDR_OFFSET);
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+
+	return rtw89_read8(rtwdev, addr + phy->cr_base);
 }
 
 static inline u16 rtw89_phy_read16(struct rtw89_dev *rtwdev, u32 addr)
 {
-	return rtw89_read16(rtwdev, addr | RTW89_PHY_ADDR_OFFSET);
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+
+	return rtw89_read16(rtwdev, addr + phy->cr_base);
 }
 
 static inline u32 rtw89_phy_read32(struct rtw89_dev *rtwdev, u32 addr)
 {
-	return rtw89_read32(rtwdev, addr | RTW89_PHY_ADDR_OFFSET);
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+
+	return rtw89_read32(rtwdev, addr + phy->cr_base);
 }
 
 static inline u32 rtw89_phy_read32_mask(struct rtw89_dev *rtwdev,
 					u32 addr, u32 mask)
 {
-	return rtw89_read32_mask(rtwdev, addr | RTW89_PHY_ADDR_OFFSET, mask);
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+
+	return rtw89_read32_mask(rtwdev, addr + phy->cr_base, mask);
 }
 
 static inline
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
new file mode 100644
index 000000000000..143f900d29a6
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2023  Realtek Corporation
+ */
+
+#include "phy.h"
+
+const struct rtw89_phy_gen_def rtw89_phy_gen_be = {
+	.cr_base = 0x20000,
+};
+EXPORT_SYMBOL(rtw89_phy_gen_be);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index ccf96c963bb4..52eb7030fd0b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2337,6 +2337,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.chip_gen		= RTW89_CHIP_AX,
 	.ops			= &rtw8851b_chip_ops,
 	.mac_def		= &rtw89_mac_gen_ax,
+	.phy_def		= &rtw89_phy_gen_ax,
 	.fw_basename		= RTW8851B_FW_BASENAME,
 	.fw_format_max		= RTW8851B_FW_FORMAT_MAX,
 	.try_ce_fw		= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index aefc72f24cf2..eb6aad3bbb85 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2073,6 +2073,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.chip_gen		= RTW89_CHIP_AX,
 	.ops			= &rtw8852a_chip_ops,
 	.mac_def		= &rtw89_mac_gen_ax,
+	.phy_def		= &rtw89_phy_gen_ax,
 	.fw_basename		= RTW8852A_FW_BASENAME,
 	.fw_format_max		= RTW8852A_FW_FORMAT_MAX,
 	.try_ce_fw		= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index cd1863e7e6d4..49664cc44f36 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2506,6 +2506,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.chip_gen		= RTW89_CHIP_AX,
 	.ops			= &rtw8852b_chip_ops,
 	.mac_def		= &rtw89_mac_gen_ax,
+	.phy_def		= &rtw89_phy_gen_ax,
 	.fw_basename		= RTW8852B_FW_BASENAME,
 	.fw_format_max		= RTW8852B_FW_FORMAT_MAX,
 	.try_ce_fw		= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 4e936e0ba407..abd01e808d83 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2803,6 +2803,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.chip_gen		= RTW89_CHIP_AX,
 	.ops			= &rtw8852c_chip_ops,
 	.mac_def		= &rtw89_mac_gen_ax,
+	.phy_def		= &rtw89_phy_gen_ax,
 	.fw_basename		= RTW8852C_FW_BASENAME,
 	.fw_format_max		= RTW8852C_FW_FORMAT_MAX,
 	.try_ce_fw		= false,
-- 
2.25.1

