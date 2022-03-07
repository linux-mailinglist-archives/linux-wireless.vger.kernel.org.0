Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D2B4CF199
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 07:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbiCGGHI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 01:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbiCGGHH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 01:07:07 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1AB5F4C2
        for <linux-wireless@vger.kernel.org>; Sun,  6 Mar 2022 22:06:12 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 227664Yn8022629, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 227664Yn8022629
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 7 Mar 2022 14:06:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 14:06:04 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 7 Mar
 2022 14:06:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 11/13] rtw89: support DAV efuse reading operation
Date:   Mon, 7 Mar 2022 14:04:55 +0800
Message-ID: <20220307060457.56789-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307060457.56789-1-pkshih@realtek.com>
References: <20220307060457.56789-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/07/2022 05:48:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvNyCkV6TIIDAzOjQ5OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DAV is an another efuse region that new chip, like 8852C, has this region.
Extend the code to read it, and convert the physical map to logical map
followed by original logical map.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |   2 +
 drivers/net/wireless/realtek/rtw89/efuse.c    | 160 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/mac.c      |  24 +++
 drivers/net/wireless/realtek/rtw89/mac.h      |  12 ++
 drivers/net/wireless/realtek/rtw89/reg.h      |  11 ++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   6 +
 7 files changed, 208 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 207ac7e605691..3582e352c4a66 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2256,6 +2256,8 @@ struct rtw89_chip_info {
 	u32 physical_efuse_size;
 	u32 logical_efuse_size;
 	u32 limit_efuse_size;
+	u32 dav_phy_efuse_size;
+	u32 dav_log_efuse_size;
 	u32 phycap_addr;
 	u32 phycap_size;
 
diff --git a/drivers/net/wireless/realtek/rtw89/efuse.c b/drivers/net/wireless/realtek/rtw89/efuse.c
index c0b80f3da56c2..7bd4f8558e03b 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse.c
+++ b/drivers/net/wireless/realtek/rtw89/efuse.c
@@ -4,6 +4,7 @@
 
 #include "debug.h"
 #include "efuse.h"
+#include "mac.h"
 #include "reg.h"
 
 enum rtw89_efuse_bank {
@@ -16,6 +17,9 @@ static int rtw89_switch_efuse_bank(struct rtw89_dev *rtwdev,
 {
 	u8 val;
 
+	if (rtwdev->chip->chip_id != RTL8852A)
+		return 0;
+
 	val = rtw89_read32_mask(rtwdev, R_AX_EFUSE_CTRL_1,
 				B_AX_EF_CELL_SEL_MASK);
 	if (bank == val)
@@ -32,14 +36,61 @@ static int rtw89_switch_efuse_bank(struct rtw89_dev *rtwdev,
 	return -EBUSY;
 }
 
-static int rtw89_dump_physical_efuse_map(struct rtw89_dev *rtwdev, u8 *map,
-					 u32 dump_addr, u32 dump_size)
+static void rtw89_enable_otp_burst_mode(struct rtw89_dev *rtwdev, bool en)
+{
+	if (en)
+		rtw89_write32_set(rtwdev, R_AX_EFUSE_CTRL_1_V1, B_AX_EF_BURST);
+	else
+		rtw89_write32_clr(rtwdev, R_AX_EFUSE_CTRL_1_V1, B_AX_EF_BURST);
+}
+
+static void rtw89_enable_efuse_pwr_cut_ddv(struct rtw89_dev *rtwdev)
+{
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	if (chip_id == RTL8852A)
+		return;
+
+	rtw89_write8_set(rtwdev, R_AX_PMC_DBG_CTRL2, B_AX_SYSON_DIS_PMCR_AX_WRMSK);
+	rtw89_write16_set(rtwdev, R_AX_SYS_ISO_CTRL, B_AX_PWC_EV2EF_B14);
+
+	fsleep(1000);
+
+	rtw89_write16_set(rtwdev, R_AX_SYS_ISO_CTRL, B_AX_PWC_EV2EF_B15);
+	rtw89_write16_clr(rtwdev, R_AX_SYS_ISO_CTRL, B_AX_ISO_EB2CORE);
+	if (chip_id == RTL8852B && hal->cv == CHIP_CAV)
+		rtw89_enable_otp_burst_mode(rtwdev, true);
+}
+
+static void rtw89_disable_efuse_pwr_cut_ddv(struct rtw89_dev *rtwdev)
+{
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+	struct rtw89_hal *hal = &rtwdev->hal;
+
+	if (chip_id == RTL8852A)
+		return;
+
+	if (chip_id == RTL8852B && hal->cv == CHIP_CAV)
+		rtw89_enable_otp_burst_mode(rtwdev, false);
+
+	rtw89_write16_set(rtwdev, R_AX_SYS_ISO_CTRL, B_AX_ISO_EB2CORE);
+	rtw89_write16_clr(rtwdev, R_AX_SYS_ISO_CTRL, B_AX_PWC_EV2EF_B15);
+
+	fsleep(1000);
+
+	rtw89_write16_clr(rtwdev, R_AX_SYS_ISO_CTRL, B_AX_PWC_EV2EF_B14);
+	rtw89_write8_clr(rtwdev, R_AX_PMC_DBG_CTRL2, B_AX_SYSON_DIS_PMCR_AX_WRMSK);
+}
+
+static int rtw89_dump_physical_efuse_map_ddv(struct rtw89_dev *rtwdev, u8 *map,
+					     u32 dump_addr, u32 dump_size)
 {
 	u32 efuse_ctl;
 	u32 addr;
 	int ret;
 
-	rtw89_switch_efuse_bank(rtwdev, RTW89_EFUSE_BANK_WIFI);
+	rtw89_enable_efuse_pwr_cut_ddv(rtwdev);
 
 	for (addr = dump_addr; addr < dump_addr + dump_size; addr++) {
 		efuse_ctl = u32_encode_bits(addr, B_AX_EF_ADDR_MASK);
@@ -54,6 +105,74 @@ static int rtw89_dump_physical_efuse_map(struct rtw89_dev *rtwdev, u8 *map,
 		*map++ = (u8)(efuse_ctl & 0xff);
 	}
 
+	rtw89_disable_efuse_pwr_cut_ddv(rtwdev);
+
+	return 0;
+}
+
+static int rtw89_dump_physical_efuse_map_dav(struct rtw89_dev *rtwdev, u8 *map,
+					     u32 dump_addr, u32 dump_size)
+{
+	u32 addr;
+	u8 val8;
+	int err;
+	int ret;
+
+	for (addr = dump_addr; addr < dump_addr + dump_size; addr++) {
+		ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_CTRL, 0x40, FULL_BIT_MASK);
+		if (ret)
+			return ret;
+		ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_LOW_ADDR,
+					      addr & 0xff, XTAL_SI_LOW_ADDR_MASK);
+		if (ret)
+			return ret;
+		ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_CTRL, addr >> 8,
+					      XTAL_SI_HIGH_ADDR_MASK);
+		if (ret)
+			return ret;
+		ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_CTRL, 0,
+					      XTAL_SI_MODE_SEL_MASK);
+		if (ret)
+			return ret;
+
+		ret = read_poll_timeout_atomic(rtw89_mac_read_xtal_si, err,
+					       !err && (val8 & XTAL_SI_RDY),
+					       1, 10000, false,
+					       rtwdev, XTAL_SI_CTRL, &val8);
+		if (ret) {
+			rtw89_warn(rtwdev, "failed to read dav efuse\n");
+			return ret;
+		}
+
+		ret = rtw89_mac_read_xtal_si(rtwdev, XTAL_SI_READ_VAL, &val8);
+		if (ret)
+			return ret;
+		*map++ = val8;
+	}
+
+	return 0;
+}
+
+static int rtw89_dump_physical_efuse_map(struct rtw89_dev *rtwdev, u8 *map,
+					 u32 dump_addr, u32 dump_size, bool dav)
+{
+	int ret;
+
+	if (!map || dump_size == 0)
+		return 0;
+
+	rtw89_switch_efuse_bank(rtwdev, RTW89_EFUSE_BANK_WIFI);
+
+	if (dav) {
+		ret = rtw89_dump_physical_efuse_map_dav(rtwdev, map, dump_addr, dump_size);
+		if (ret)
+			return ret;
+	} else {
+		ret = rtw89_dump_physical_efuse_map_ddv(rtwdev, map, dump_addr, dump_size);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -78,6 +197,9 @@ static int rtw89_dump_logical_efuse_map(struct rtw89_dev *rtwdev, u8 *phy_map,
 	u8 word_en;
 	int i;
 
+	if (!phy_map)
+		return 0;
+
 	while (phy_idx < physical_size - sec_ctrl_size) {
 		hdr1 = phy_map[phy_idx];
 		hdr2 = phy_map[phy_idx + 1];
@@ -109,8 +231,13 @@ int rtw89_parse_efuse_map(struct rtw89_dev *rtwdev)
 {
 	u32 phy_size = rtwdev->chip->physical_efuse_size;
 	u32 log_size = rtwdev->chip->logical_efuse_size;
+	u32 dav_phy_size = rtwdev->chip->dav_phy_efuse_size;
+	u32 dav_log_size = rtwdev->chip->dav_log_efuse_size;
+	u32 full_log_size = log_size + dav_log_size;
 	u8 *phy_map = NULL;
 	u8 *log_map = NULL;
+	u8 *dav_phy_map = NULL;
+	u8 *dav_log_map = NULL;
 	int ret;
 
 	if (rtw89_read16(rtwdev, R_AX_SYS_WL_EFUSE_CTRL) & B_AX_AUTOLOAD_SUS)
@@ -119,27 +246,41 @@ int rtw89_parse_efuse_map(struct rtw89_dev *rtwdev)
 		rtw89_warn(rtwdev, "failed to check efuse autoload\n");
 
 	phy_map = kmalloc(phy_size, GFP_KERNEL);
-	log_map = kmalloc(log_size, GFP_KERNEL);
+	log_map = kmalloc(full_log_size, GFP_KERNEL);
+	if (dav_phy_size && dav_log_size) {
+		dav_phy_map = kmalloc(dav_phy_size, GFP_KERNEL);
+		dav_log_map = log_map + log_size;
+	}
 
-	if (!phy_map || !log_map) {
+	if (!phy_map || !log_map || (dav_phy_size && !dav_phy_map)) {
 		ret = -ENOMEM;
 		goto out_free;
 	}
 
-	ret = rtw89_dump_physical_efuse_map(rtwdev, phy_map, 0, phy_size);
+	ret = rtw89_dump_physical_efuse_map(rtwdev, phy_map, 0, phy_size, false);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to dump efuse physical map\n");
 		goto out_free;
 	}
+	ret = rtw89_dump_physical_efuse_map(rtwdev, dav_phy_map, 0, dav_phy_size, true);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to dump efuse dav physical map\n");
+		goto out_free;
+	}
 
-	memset(log_map, 0xff, log_size);
+	memset(log_map, 0xff, full_log_size);
 	ret = rtw89_dump_logical_efuse_map(rtwdev, phy_map, log_map);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to dump efuse logical map\n");
 		goto out_free;
 	}
+	ret = rtw89_dump_logical_efuse_map(rtwdev, dav_phy_map, dav_log_map);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to dump efuse dav logical map\n");
+		goto out_free;
+	}
 
-	rtw89_hex_dump(rtwdev, RTW89_DBG_FW, "log_map: ", log_map, log_size);
+	rtw89_hex_dump(rtwdev, RTW89_DBG_FW, "log_map: ", log_map, full_log_size);
 
 	ret = rtwdev->chip->ops->read_efuse(rtwdev, log_map);
 	if (ret) {
@@ -148,6 +289,7 @@ int rtw89_parse_efuse_map(struct rtw89_dev *rtwdev)
 	}
 
 out_free:
+	kfree(dav_phy_map);
 	kfree(log_map);
 	kfree(phy_map);
 
@@ -169,7 +311,7 @@ int rtw89_parse_phycap_map(struct rtw89_dev *rtwdev)
 		return -ENOMEM;
 
 	ret = rtw89_dump_physical_efuse_map(rtwdev, phycap_map,
-					    phycap_addr, phycap_size);
+					    phycap_addr, phycap_size, false);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to dump phycap map\n");
 		goto out_free;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 0081cfbfea042..8fbdfd983cc53 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4074,3 +4074,27 @@ int rtw89_mac_write_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 mask
 	return 0;
 }
 EXPORT_SYMBOL(rtw89_mac_write_xtal_si);
+
+int rtw89_mac_read_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
+{
+	u32 val32;
+	int ret;
+
+	val32 = FIELD_PREP(B_AX_WL_XTAL_SI_ADDR_MASK, offset) |
+		FIELD_PREP(B_AX_WL_XTAL_SI_DATA_MASK, 0x00) |
+		FIELD_PREP(B_AX_WL_XTAL_SI_BITMASK_MASK, 0x00) |
+		FIELD_PREP(B_AX_WL_XTAL_SI_MODE_MASK, XTAL_SI_NORMAL_READ) |
+		FIELD_PREP(B_AX_WL_XTAL_SI_CMD_POLL, 1);
+	rtw89_write32(rtwdev, R_AX_WLAN_XTAL_SI_CTRL, val32);
+
+	ret = read_poll_timeout(rtw89_read32, val32, !(val32 & B_AX_WL_XTAL_SI_CMD_POLL),
+				50, 50000, false, rtwdev, R_AX_WLAN_XTAL_SI_CTRL);
+	if (ret) {
+		rtw89_warn(rtwdev, "xtal si not ready(R): offset=%x\n", offset);
+		return ret;
+	}
+
+	*val = rtw89_read8(rtwdev, R_AX_WLAN_XTAL_SI_CTRL + 1);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index e74806d333079..2f707c817fa79 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -885,11 +885,21 @@ int rtw89_mac_get_tx_retry_limit(struct rtw89_dev *rtwdev,
 enum rtw89_mac_xtal_si_offset {
 	XTAL_SI_XTAL_SC_XI = 0x04,
 	XTAL_SI_XTAL_SC_XO = 0x05,
+	XTAL_SI_PWR_CUT = 0x10,
+#define XTAL_SI_SMALL_PWR_CUT	BIT(0)
+#define XTAL_SI_BIG_PWR_CUT	BIT(1)
 	XTAL_SI_XTAL_XMD_2 = 0x24,
 #define XTAL_SI_LDO_LPS		GENMASK(6, 4)
 	XTAL_SI_XTAL_XMD_4 = 0x26,
 #define XTAL_SI_LPS_CAP		GENMASK(3, 0)
 	XTAL_SI_CV = 0x41,
+	XTAL_SI_LOW_ADDR = 0x62,
+#define XTAL_SI_LOW_ADDR_MASK	GENMASK(7, 0)
+	XTAL_SI_CTRL = 0x63,
+#define XTAL_SI_MODE_SEL_MASK	GENMASK(7, 6)
+#define XTAL_SI_RDY		BIT(5)
+#define XTAL_SI_HIGH_ADDR_MASK	GENMASK(2, 0)
+	XTAL_SI_READ_VAL = 0x7A,
 	XTAL_SI_WL_RFC_S0 = 0x80,
 #define XTAL_SI_RF00		BIT(0)
 	XTAL_SI_WL_RFC_S1 = 0x81,
@@ -904,8 +914,10 @@ enum rtw89_mac_xtal_si_offset {
 #define XTAL_SI_PON_EI		BIT(1)
 #define XTAL_SI_PON_WEI		BIT(0)
 	XTAL_SI_SRAM_CTRL = 0xA1,
+#define FULL_BIT_MASK		GENMASK(7, 0)
 };
 
 int rtw89_mac_write_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 val, u8 mask);
+int rtw89_mac_read_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 *val);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 222aaddbff624..ec5e70b866009 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -61,6 +61,17 @@
 #define B_AX_EF_ADDR_MASK GENMASK(26, 16)
 #define B_AX_EF_DATA_MASK GENMASK(15, 0)
 
+#define R_AX_EFUSE_CTRL_1_V1 0x0038
+#define B_AX_EF_ENT BIT(31)
+#define B_AX_EF_BURST BIT(19)
+#define B_AX_EF_TEST_SEL_MASK GENMASK(18, 16)
+#define B_AX_EF_TROW_EN BIT(15)
+#define B_AX_EF_ERR_FLAG BIT(14)
+#define B_AX_EF_DSB_EN BIT(11)
+#define B_AX_PCIE_CALIB_EN_V1 BIT(12)
+#define B_AX_WDT_WAKE_PCIE_EN BIT(10)
+#define B_AX_WDT_WAKE_USB_EN BIT(9)
+
 #define R_AX_GPIO_MUXCFG 0x0040
 #define B_AX_BOOT_MODE BIT(19)
 #define B_AX_WL_EECS_EXT_32K_SEL BIT(18)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 4eb03dde34130..c429eeae1b567 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2063,6 +2063,8 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.physical_efuse_size	= 1216,
 	.logical_efuse_size	= 1536,
 	.limit_efuse_size	= 1152,
+	.dav_phy_efuse_size	= 0,
+	.dav_log_efuse_size	= 0,
 	.phycap_addr		= 0x580,
 	.phycap_size		= 128,
 	.para_ver		= 0x05050864,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 55dca693cb5ab..e17e0ab75d0eb 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -232,6 +232,12 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.dle_mem		= rtw8852c_dle_mem_pcie,
 	.pwr_on_seq		= NULL,
 	.pwr_off_seq		= NULL,
+	.sec_ctrl_efuse_size	= 4,
+	.physical_efuse_size	= 1216,
+	.logical_efuse_size	= 2048,
+	.limit_efuse_size	= 1280,
+	.dav_phy_efuse_size	= 96,
+	.dav_log_efuse_size	= 16,
 	.hci_func_en_addr	= R_AX_HCI_FUNC_EN_V1,
 	.h2c_ctrl_reg		= R_AX_H2CREG_CTRL_V1,
 	.h2c_regs		= rtw8852c_h2c_regs,
-- 
2.25.1

