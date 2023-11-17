Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA627EEB2A
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Nov 2023 03:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjKQCli (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 21:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjKQClh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 21:41:37 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C621A7
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 18:41:31 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AH2fNyE52818728, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AH2fNyE52818728
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 10:41:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 17 Nov 2023 10:41:23 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 17 Nov
 2023 10:41:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/6] wifi: rtw89: mac: add to access efuse for WiFi 7 chips
Date:   Fri, 17 Nov 2023 10:40:26 +0800
Message-ID: <20231117024029.113845-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231117024029.113845-1-pkshih@realtek.com>
References: <20231117024029.113845-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

MAC address, hardware type, calibration values and etc are stored in efuse,
so we read them at probe stage and use them as capabilities to register
hardware.

There are two physical efuse -- one is the main efuse for digital hardware
part, and the other is for analog part. Because they are very similar, we
only describe the main efuse below.

The main efuse is split into two regions -- one is for logic map, and the
other is for physical map. For both regions, we use the same method to read
data, but need additional parser to get logic map. To allow reading
operation, we need to convert power state to active, and turn to idle state
after reading.

For WiFi 7 chips, we introduce efuse blocks to define feature group easier,
and these blocks are discontinue. For example, RF block is from 0x1_0000 ~
0x1_0240, and the next block PCIE_SDIO is starting from 0x2_0000.
Comparing to old one used by WiFi 6 chips, there is only single one logic
map, it would be a little hard to add an new field to a group if we don't
reserve a room in advance.

The relationship between efuse, region and block is shown as below:

                                           (logical map)
 +------------+    +---------------+    +-----------------+
 | main efuse |    |   region 1    |    | block 0x1_0000~ |
 | (digital)  |    |(to logcal map)|    +-----------------+
 |            |    |               | => +-----------------+
 |            | => |               |    | block 0x2_0000~ |
 |            |    |               |    +-----------------+
 |            |    |---------------|             :
 |            |    |    region 2   |
 +------------+    +---------------+

 +------------+                         +-----------------+
 | 2nd efuse  | ======================> | block 0x7_0000~ |
 | (analog)   |                         +-----------------+
 +------------+

The parser converting from raw data to logic map is to decode block page,
block page offset, and word_en bits. Each word_en bit indicates two
following bytes as data of logic map, so total four word_en bits can
represent eight bytes. Thus, block page offset is 8-byte alignment.
The layout of a tuple is shown as below

  +--------+--------+--------+--------+--------+--------+
  | fixed 3 byte header      |        |        |        |
  |                          |        |        |        |
  | [19:17] block_page       |        |        |  ...   |
  | [16:4]  block_page_offset|        |        |        |
  | [3:0]   word_en          |   ^    |    ^   |        |
  +----|---+--------+--------+---|----+----|---+--------+
       |                         |         |
       +-------------------------+---------+
         a word_en bit indicates two bytes as data

For example,
  block_page = 0x3
  block_page_offset = 0x80 (must 8-byte alignment)
  word_en = 0x6 (b'0110; 0 means data is presented)
  following 4 bytes = 34 56 78 90
  Then,
    0x3_0080 = 34 56
    0x3_0086 = 78 90

A special block page is RTW89_EFUSE_BLOCK_ADIE (7) that uses different
but similar format, because its real efuse size is smaller than main efuse.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  19 +-
 drivers/net/wireless/realtek/rtw89/efuse.c    |   2 +-
 drivers/net/wireless/realtek/rtw89/efuse.h    |  12 +
 drivers/net/wireless/realtek/rtw89/efuse_be.c | 420 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac_be.c   |   4 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  72 +++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  13 +
 11 files changed, 552 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/efuse_be.c

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 07b529a76396..9983fb38b3a5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -16,6 +16,7 @@ struct rtw89_dev;
 struct rtw89_pci_info;
 struct rtw89_mac_gen_def;
 struct rtw89_phy_gen_def;
+struct rtw89_efuse_block_cfg;
 
 extern const struct ieee80211_ops rtw89_ops;
 
@@ -2777,6 +2778,20 @@ enum rtw89_rx_frame_type {
 	RTW89_RX_TYPE_RSVD = 3,
 };
 
+enum rtw89_efuse_block {
+	RTW89_EFUSE_BLOCK_SYS = 0,
+	RTW89_EFUSE_BLOCK_RF = 1,
+	RTW89_EFUSE_BLOCK_HCI_DIG_PCIE_SDIO = 2,
+	RTW89_EFUSE_BLOCK_HCI_DIG_USB = 3,
+	RTW89_EFUSE_BLOCK_HCI_PHY_PCIE = 4,
+	RTW89_EFUSE_BLOCK_HCI_PHY_USB3 = 5,
+	RTW89_EFUSE_BLOCK_HCI_PHY_USB2 = 6,
+	RTW89_EFUSE_BLOCK_ADIE = 7,
+
+	RTW89_EFUSE_BLOCK_NUM,
+	RTW89_EFUSE_BLOCK_IGNORE,
+};
+
 struct rtw89_ra_info {
 	u8 is_dis_ra:1;
 	/* Bit0 : CCK
@@ -3119,7 +3134,8 @@ struct rtw89_chip_ops {
 				 const struct rtw89_chan *chan,
 				 enum rtw89_mac_idx mac_idx,
 				 enum rtw89_phy_idx phy_idx);
-	int (*read_efuse)(struct rtw89_dev *rtwdev, u8 *log_map);
+	int (*read_efuse)(struct rtw89_dev *rtwdev, u8 *log_map,
+			  enum rtw89_efuse_block block);
 	int (*read_phycap)(struct rtw89_dev *rtwdev, u8 *phycap_map);
 	void (*fem_setup)(struct rtw89_dev *rtwdev);
 	void (*rfe_gpio)(struct rtw89_dev *rtwdev);
@@ -3655,6 +3671,7 @@ struct rtw89_chip_info {
 	u32 dav_log_efuse_size;
 	u32 phycap_addr;
 	u32 phycap_size;
+	const struct rtw89_efuse_block_cfg *efuse_blocks;
 
 	const struct rtw89_pwr_cfg * const *pwr_on_seq;
 	const struct rtw89_pwr_cfg * const *pwr_off_seq;
diff --git a/drivers/net/wireless/realtek/rtw89/efuse.c b/drivers/net/wireless/realtek/rtw89/efuse.c
index b2e8c6cc12d9..e1236079a84a 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse.c
+++ b/drivers/net/wireless/realtek/rtw89/efuse.c
@@ -291,7 +291,7 @@ int rtw89_parse_efuse_map_ax(struct rtw89_dev *rtwdev)
 
 	rtw89_hex_dump(rtwdev, RTW89_DBG_FW, "log_map: ", log_map, full_log_size);
 
-	ret = rtwdev->chip->ops->read_efuse(rtwdev, log_map);
+	ret = rtwdev->chip->ops->read_efuse(rtwdev, log_map, RTW89_EFUSE_BLOCK_IGNORE);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to read efuse map\n");
 		goto out_free;
diff --git a/drivers/net/wireless/realtek/rtw89/efuse.h b/drivers/net/wireless/realtek/rtw89/efuse.h
index 24173b3dc085..5c6787179bad 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse.h
+++ b/drivers/net/wireless/realtek/rtw89/efuse.h
@@ -7,9 +7,21 @@
 
 #include "core.h"
 
+#define RTW89_EFUSE_BLOCK_ID_MASK GENMASK(31, 16)
+#define RTW89_EFUSE_BLOCK_SIZE_MASK GENMASK(15, 0)
+#define RTW89_EFUSE_MAX_BLOCK_SIZE 0x10000
+
+struct rtw89_efuse_block_cfg {
+	u32 offset;
+	u32 size;
+};
+
 int rtw89_parse_efuse_map_ax(struct rtw89_dev *rtwdev);
 int rtw89_parse_phycap_map_ax(struct rtw89_dev *rtwdev);
 int rtw89_cnv_efuse_state_ax(struct rtw89_dev *rtwdev, bool idle);
+int rtw89_parse_efuse_map_be(struct rtw89_dev *rtwdev);
+int rtw89_parse_phycap_map_be(struct rtw89_dev *rtwdev);
+int rtw89_cnv_efuse_state_be(struct rtw89_dev *rtwdev, bool idle);
 int rtw89_read_efuse_ver(struct rtw89_dev *rtwdev, u8 *efv);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/efuse_be.c b/drivers/net/wireless/realtek/rtw89/efuse_be.c
new file mode 100644
index 000000000000..8e8b7cd315f7
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/efuse_be.c
@@ -0,0 +1,420 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2023  Realtek Corporation
+ */
+
+#include "debug.h"
+#include "efuse.h"
+#include "mac.h"
+#include "reg.h"
+
+static void rtw89_enable_efuse_pwr_cut_ddv_be(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	bool aphy_patch = true;
+
+	if (chip->chip_id == RTL8922A && hal->cv == CHIP_CAV)
+		aphy_patch = false;
+
+	rtw89_write8_set(rtwdev, R_BE_PMC_DBG_CTRL2, B_BE_SYSON_DIS_PMCR_BE_WRMSK);
+
+	if (aphy_patch) {
+		rtw89_write16_set(rtwdev, R_BE_SYS_ISO_CTRL, B_BE_PWC_EV2EF_S);
+		mdelay(1);
+		rtw89_write16_set(rtwdev, R_BE_SYS_ISO_CTRL, B_BE_PWC_EV2EF_B);
+		rtw89_write16_clr(rtwdev, R_BE_SYS_ISO_CTRL, B_BE_ISO_EB2CORE);
+	}
+
+	rtw89_write32_set(rtwdev, R_BE_EFUSE_CTRL_2_V1, B_BE_EF_BURST);
+}
+
+static void rtw89_disable_efuse_pwr_cut_ddv_be(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	bool aphy_patch = true;
+
+	if (chip->chip_id == RTL8922A && hal->cv == CHIP_CAV)
+		aphy_patch = false;
+
+	if (aphy_patch) {
+		rtw89_write16_set(rtwdev, R_BE_SYS_ISO_CTRL, B_BE_ISO_EB2CORE);
+		rtw89_write16_clr(rtwdev, R_BE_SYS_ISO_CTRL, B_BE_PWC_EV2EF_B);
+		mdelay(1);
+		rtw89_write16_clr(rtwdev, R_BE_SYS_ISO_CTRL, B_BE_PWC_EV2EF_S);
+	}
+
+	rtw89_write8_clr(rtwdev, R_BE_PMC_DBG_CTRL2, B_BE_SYSON_DIS_PMCR_BE_WRMSK);
+	rtw89_write32_clr(rtwdev, R_BE_EFUSE_CTRL_2_V1, B_BE_EF_BURST);
+}
+
+static int rtw89_dump_physical_efuse_map_ddv_be(struct rtw89_dev *rtwdev, u8 *map,
+						u32 dump_addr, u32 dump_size)
+{
+	u32 efuse_ctl;
+	u32 addr;
+	u32 data;
+	int ret;
+
+	if (!IS_ALIGNED(dump_addr, 4) || !IS_ALIGNED(dump_size, 4)) {
+		rtw89_err(rtwdev, "Efuse addr 0x%x or size 0x%x not aligned\n",
+			  dump_addr, dump_size);
+		return -EINVAL;
+	}
+
+	rtw89_enable_efuse_pwr_cut_ddv_be(rtwdev);
+
+	for (addr = dump_addr; addr < dump_addr + dump_size; addr += 4, map += 4) {
+		efuse_ctl = u32_encode_bits(addr, B_BE_EF_ADDR_MASK);
+		rtw89_write32(rtwdev, R_BE_EFUSE_CTRL, efuse_ctl & ~B_BE_EF_RDY);
+
+		ret = read_poll_timeout_atomic(rtw89_read32, efuse_ctl,
+					       efuse_ctl & B_BE_EF_RDY, 1, 1000000,
+					       true, rtwdev, R_BE_EFUSE_CTRL);
+		if (ret)
+			return -EBUSY;
+
+		data = rtw89_read32(rtwdev, R_BE_EFUSE_CTRL_1_V1);
+		*((__le32 *)map) = cpu_to_le32(data);
+	}
+
+	rtw89_disable_efuse_pwr_cut_ddv_be(rtwdev);
+
+	return 0;
+}
+
+static int rtw89_dump_physical_efuse_map_dav_be(struct rtw89_dev *rtwdev, u8 *map,
+						u32 dump_addr, u32 dump_size)
+{
+	u32 addr;
+	u8 val8;
+	int err;
+	int ret;
+
+	for (addr = dump_addr; addr < dump_addr + dump_size; addr++) {
+		ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_CTRL, 0x40,
+					      FULL_BIT_MASK);
+		if (ret)
+			return ret;
+		ret = rtw89_mac_write_xtal_si(rtwdev, XTAL_SI_LOW_ADDR, addr & 0xff,
+					      XTAL_SI_LOW_ADDR_MASK);
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
+int rtw89_cnv_efuse_state_be(struct rtw89_dev *rtwdev, bool idle)
+{
+	u32 val;
+	int ret = 0;
+
+	if (idle) {
+		rtw89_write32_set(rtwdev, R_BE_WL_BT_PWR_CTRL, B_BE_BT_DISN_EN);
+	} else {
+		rtw89_write32_clr(rtwdev, R_BE_WL_BT_PWR_CTRL, B_BE_BT_DISN_EN);
+
+		ret = read_poll_timeout(rtw89_read32_mask, val,
+					val == MAC_AX_SYS_ACT, 50, 5000,
+					false, rtwdev, R_BE_IC_PWR_STATE,
+					B_BE_WHOLE_SYS_PWR_STE_MASK);
+		if (ret)
+			rtw89_warn(rtwdev, "failed to convert efuse state\n");
+	}
+
+	return ret;
+}
+
+static int rtw89_dump_physical_efuse_map_be(struct rtw89_dev *rtwdev, u8 *map,
+					    u32 dump_addr, u32 dump_size, bool dav)
+{
+	int ret;
+
+	if (!map || dump_size == 0)
+		return 0;
+
+	rtw89_cnv_efuse_state_be(rtwdev, false);
+
+	if (dav) {
+		ret = rtw89_dump_physical_efuse_map_dav_be(rtwdev, map,
+							   dump_addr, dump_size);
+		if (ret)
+			return ret;
+
+		rtw89_hex_dump(rtwdev, RTW89_DBG_FW, "phy_map dav: ", map, dump_size);
+	} else {
+		ret = rtw89_dump_physical_efuse_map_ddv_be(rtwdev, map,
+							   dump_addr, dump_size);
+		if (ret)
+			return ret;
+
+		rtw89_hex_dump(rtwdev, RTW89_DBG_FW, "phy_map ddv: ", map, dump_size);
+	}
+
+	rtw89_cnv_efuse_state_be(rtwdev, true);
+
+	return 0;
+}
+
+#define EFUSE_HDR_CONST_MASK GENMASK(23, 20)
+#define EFUSE_HDR_PAGE_MASK GENMASK(19, 17)
+#define EFUSE_HDR_OFFSET_MASK GENMASK(16, 4)
+#define EFUSE_HDR_OFFSET_DAV_MASK GENMASK(11, 4)
+#define EFUSE_HDR_WORD_EN_MASK GENMASK(3, 0)
+
+#define invalid_efuse_header_be(hdr1, hdr2, hdr3) \
+	((hdr1) == 0xff || (hdr2) == 0xff || (hdr3) == 0xff)
+#define invalid_efuse_content_be(word_en, i) \
+	(((word_en) & BIT(i)) != 0x0)
+#define get_efuse_blk_idx_be(hdr1, hdr2, hdr3) \
+	(((hdr1) << 16) | ((hdr2) << 8) | (hdr3))
+#define block_idx_to_logical_idx_be(blk_idx, i) \
+	(((blk_idx) << 3) + ((i) << 1))
+
+#define invalid_efuse_header_dav_be(hdr1, hdr2) \
+	((hdr1) == 0xff || (hdr2) == 0xff)
+#define get_efuse_blk_idx_dav_be(hdr1, hdr2) \
+	(((hdr1) << 8) | (hdr2))
+
+static int rtw89_eeprom_parser_be(struct rtw89_dev *rtwdev,
+				  const u8 *phy_map, u32 phy_size, u8 *log_map,
+				  const struct rtw89_efuse_block_cfg *efuse_block)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	enum rtw89_efuse_block blk_page, page;
+	u32 size = efuse_block->size;
+	u32 phy_idx, log_idx;
+	u32 hdr, page_offset;
+	u8 hdr1, hdr2, hdr3;
+	u8 i, val0, val1;
+	u32 min, max;
+	u16 blk_idx;
+	u8 word_en;
+
+	page = u32_get_bits(efuse_block->offset, RTW89_EFUSE_BLOCK_ID_MASK);
+	page_offset = u32_get_bits(efuse_block->offset, RTW89_EFUSE_BLOCK_SIZE_MASK);
+
+	min = ALIGN_DOWN(page_offset, 2);
+	max = ALIGN(page_offset + size, 2);
+
+	memset(log_map, 0xff, size);
+
+	phy_idx = chip->sec_ctrl_efuse_size;
+
+	do {
+		if (page == RTW89_EFUSE_BLOCK_ADIE) {
+			hdr1 = phy_map[phy_idx];
+			hdr2 = phy_map[phy_idx + 1];
+			if (invalid_efuse_header_dav_be(hdr1, hdr2))
+				break;
+
+			phy_idx += 2;
+
+			hdr = get_efuse_blk_idx_dav_be(hdr1, hdr2);
+
+			blk_page = RTW89_EFUSE_BLOCK_ADIE;
+			blk_idx = u32_get_bits(hdr, EFUSE_HDR_OFFSET_DAV_MASK);
+			word_en = u32_get_bits(hdr, EFUSE_HDR_WORD_EN_MASK);
+		} else {
+			hdr1 = phy_map[phy_idx];
+			hdr2 = phy_map[phy_idx + 1];
+			hdr3 = phy_map[phy_idx + 2];
+			if (invalid_efuse_header_be(hdr1, hdr2, hdr3))
+				break;
+
+			phy_idx += 3;
+
+			hdr = get_efuse_blk_idx_be(hdr1, hdr2, hdr3);
+
+			blk_page = u32_get_bits(hdr, EFUSE_HDR_PAGE_MASK);
+			blk_idx = u32_get_bits(hdr, EFUSE_HDR_OFFSET_MASK);
+			word_en = u32_get_bits(hdr, EFUSE_HDR_WORD_EN_MASK);
+		}
+
+		if (blk_idx >= RTW89_EFUSE_MAX_BLOCK_SIZE >> 3) {
+			rtw89_err(rtwdev, "[ERR]efuse idx:0x%X\n", phy_idx - 3);
+			rtw89_err(rtwdev, "[ERR]read hdr:0x%X\n", hdr);
+			return -EINVAL;
+		}
+
+		for (i = 0; i < 4; i++) {
+			if (invalid_efuse_content_be(word_en, i))
+				continue;
+
+			if (phy_idx >= phy_size - 1)
+				return -EINVAL;
+
+			log_idx = block_idx_to_logical_idx_be(blk_idx, i);
+
+			if (blk_page == page && log_idx >= min && log_idx < max) {
+				val0 = phy_map[phy_idx];
+				val1 = phy_map[phy_idx + 1];
+
+				if (log_idx == min && page_offset > min) {
+					log_map[log_idx - page_offset + 1] = val1;
+				} else if (log_idx + 2 == max &&
+					   page_offset + size < max) {
+					log_map[log_idx - page_offset] = val0;
+				} else {
+					log_map[log_idx - page_offset] = val0;
+					log_map[log_idx - page_offset + 1] = val1;
+				}
+			}
+			phy_idx += 2;
+		}
+	} while (phy_idx < phy_size);
+
+	return 0;
+}
+
+static int rtw89_parse_logical_efuse_block_be(struct rtw89_dev *rtwdev,
+					      const u8 *phy_map, u32 phy_size,
+					      enum rtw89_efuse_block block)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_efuse_block_cfg *efuse_block;
+	u8 *log_map;
+	int ret;
+
+	efuse_block = &chip->efuse_blocks[block];
+
+	log_map = kmalloc(efuse_block->size, GFP_KERNEL);
+	if (!log_map)
+		return -ENOMEM;
+
+	ret = rtw89_eeprom_parser_be(rtwdev, phy_map, phy_size, log_map, efuse_block);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to dump efuse logical block %d\n", block);
+		goto out_free;
+	}
+
+	rtw89_hex_dump(rtwdev, RTW89_DBG_FW, "log_map: ", log_map, efuse_block->size);
+
+	ret = rtwdev->chip->ops->read_efuse(rtwdev, log_map, block);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to read efuse map\n");
+		goto out_free;
+	}
+
+out_free:
+	kfree(log_map);
+
+	return ret;
+}
+
+int rtw89_parse_efuse_map_be(struct rtw89_dev *rtwdev)
+{
+	u32 phy_size = rtwdev->chip->physical_efuse_size;
+	u32 dav_phy_size = rtwdev->chip->dav_phy_efuse_size;
+	enum rtw89_efuse_block block;
+	u8 *phy_map = NULL;
+	u8 *dav_phy_map = NULL;
+	int ret;
+
+	if (rtw89_read16(rtwdev, R_BE_SYS_WL_EFUSE_CTRL) & B_BE_AUTOLOAD_SUS)
+		rtwdev->efuse.valid = true;
+	else
+		rtw89_warn(rtwdev, "failed to check efuse autoload\n");
+
+	phy_map = kmalloc(phy_size, GFP_KERNEL);
+	if (dav_phy_size)
+		dav_phy_map = kmalloc(dav_phy_size, GFP_KERNEL);
+
+	if (!phy_map || (dav_phy_size && !dav_phy_map)) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	ret = rtw89_dump_physical_efuse_map_be(rtwdev, phy_map, 0, phy_size, false);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to dump efuse physical map\n");
+		goto out_free;
+	}
+	ret = rtw89_dump_physical_efuse_map_be(rtwdev, dav_phy_map, 0, dav_phy_size, true);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to dump efuse dav physical map\n");
+		goto out_free;
+	}
+
+	if (rtwdev->hci.type == RTW89_HCI_TYPE_USB)
+		block = RTW89_EFUSE_BLOCK_HCI_DIG_USB;
+	else
+		block = RTW89_EFUSE_BLOCK_HCI_DIG_PCIE_SDIO;
+
+	ret = rtw89_parse_logical_efuse_block_be(rtwdev, phy_map, phy_size, block);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to parse efuse logic block %d\n",
+			   RTW89_EFUSE_BLOCK_HCI_DIG_PCIE_SDIO);
+		goto out_free;
+	}
+
+	ret = rtw89_parse_logical_efuse_block_be(rtwdev, phy_map, phy_size,
+						 RTW89_EFUSE_BLOCK_RF);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to parse efuse logic block %d\n",
+			   RTW89_EFUSE_BLOCK_RF);
+		goto out_free;
+	}
+
+out_free:
+	kfree(dav_phy_map);
+	kfree(phy_map);
+
+	return ret;
+}
+
+int rtw89_parse_phycap_map_be(struct rtw89_dev *rtwdev)
+{
+	u32 phycap_addr = rtwdev->chip->phycap_addr;
+	u32 phycap_size = rtwdev->chip->phycap_size;
+	u8 *phycap_map = NULL;
+	int ret = 0;
+
+	if (!phycap_size)
+		return 0;
+
+	phycap_map = kmalloc(phycap_size, GFP_KERNEL);
+	if (!phycap_map)
+		return -ENOMEM;
+
+	ret = rtw89_dump_physical_efuse_map_be(rtwdev, phycap_map,
+					       phycap_addr, phycap_size, false);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to dump phycap map\n");
+		goto out_free;
+	}
+
+	ret = rtwdev->chip->ops->read_phycap(rtwdev, phycap_map);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to read phycap map\n");
+		goto out_free;
+	}
+
+out_free:
+	kfree(phycap_map);
+
+	return ret;
+}
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 3278f241db6e..1c607316f652 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -3,6 +3,7 @@
  */
 
 #include "debug.h"
+#include "efuse.h"
 #include "fw.h"
 #include "mac.h"
 #include "reg.h"
@@ -429,6 +430,9 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.fwdl_enable_wcpu = rtw89_mac_fwdl_enable_wcpu_be,
 	.fwdl_get_status = fwdl_get_status_be,
 	.fwdl_check_path_ready = rtw89_fwdl_check_path_ready_be,
+	.parse_efuse_map = rtw89_parse_efuse_map_be,
+	.parse_phycap_map = rtw89_parse_phycap_map_be,
+	.cnv_efuse_state = rtw89_cnv_efuse_state_be,
 
 	.get_txpwr_cr = rtw89_mac_get_txpwr_cr_be,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 7698fd3922f3..7a9ae6cd86e5 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3630,6 +3630,23 @@
 #define B_AX_GNT_BT_TX_SW_VAL BIT(1)
 #define B_AX_GNT_BT_TX_SW_CTRL BIT(0)
 
+#define R_BE_SYS_ISO_CTRL 0x0000
+#define B_BE_PWC_EV2EF_B BIT(15)
+#define B_BE_PWC_EV2EF_S BIT(14)
+#define B_BE_PA33V_EN BIT(13)
+#define B_BE_PA12V_EN BIT(12)
+#define B_BE_PAOOBS33V_EN BIT(11)
+#define B_BE_PAOOBS12V_EN BIT(10)
+#define B_BE_ISO_RFDIO BIT(9)
+#define B_BE_ISO_EB2CORE BIT(8)
+#define B_BE_ISO_DIOE BIT(7)
+#define B_BE_ISO_WLPON2PP BIT(6)
+#define B_BE_ISO_IP2MAC_WA02PP BIT(5)
+#define B_BE_ISO_PD2CORE BIT(4)
+#define B_BE_ISO_PA2PCIE BIT(3)
+#define B_BE_ISO_PAOOBS2PCIE BIT(1)
+#define B_BE_ISO_WD2PP BIT(0)
+
 #define R_BE_SYS_PW_CTRL 0x0004
 #define B_BE_SOP_ASWRM BIT(31)
 #define B_BE_SOP_EASWR BIT(30)
@@ -3667,6 +3684,16 @@
 #define B_BE_ANA_CLK_DIVISION_2 BIT(1)
 #define B_BE_CNTD16V_EN BIT(0)
 
+#define R_BE_SYS_WL_EFUSE_CTRL 0x000A
+#define B_BE_OTP_B_PWC_RPT BIT(15)
+#define B_BE_OTP_S_PWC_RPT BIT(14)
+#define B_BE_OTP_ISO_RPT BIT(13)
+#define B_BE_OTP_BURST_RPT BIT(12)
+#define B_BE_OTP_AUTOLOAD_RPT BIT(11)
+#define B_BE_AUTOLOAD_DIS_A_DIE BIT(6)
+#define B_BE_AUTOLOAD_SUS BIT(5)
+#define B_BE_AUTOLOAD_DIS BIT(4)
+
 #define R_BE_SYS_PAGE_CLK_GATED 0x000C
 #define B_BE_USB_APHY_PC_DLP_OP BIT(27)
 #define B_BE_PCIE_APHY_PC_DLP_OP BIT(26)
@@ -3696,6 +3723,38 @@
 #define B_BE_DIS_CLK_REG1_GATE BIT(1)
 #define B_BE_DIS_CLK_REG0_GATE BIT(0)
 
+#define R_BE_EFUSE_CTRL 0x0030
+#define B_BE_EF_MODE_SEL_MASK GENMASK(31, 30)
+#define B_BE_EF_RDY BIT(29)
+#define B_BE_EF_COMP_RESULT BIT(28)
+#define B_BE_EF_ADDR_MASK GENMASK(15, 0)
+
+#define R_BE_EFUSE_CTRL_1_V1 0x0034
+#define B_BE_EF_DATA_MASK GENMASK(31, 0)
+
+#define R_BE_WL_BT_PWR_CTRL 0x0068
+#define B_BE_ISO_BD2PP BIT(31)
+#define B_BE_LDOV12B_EN BIT(30)
+#define B_BE_CKEN_BT BIT(29)
+#define B_BE_FEN_BT BIT(28)
+#define B_BE_BTCPU_BOOTSEL BIT(27)
+#define B_BE_SPI_SPEEDUP BIT(26)
+#define B_BE_BT_LDO_MODE BIT(25)
+#define B_BE_ISO_BTPON2PP BIT(22)
+#define B_BE_BT_FUNC_EN BIT(18)
+#define B_BE_BT_HWPDN_SL BIT(17)
+#define B_BE_BT_DISN_EN BIT(16)
+#define B_BE_SDM_SRC_SEL BIT(12)
+#define B_BE_ISO_BA2PP BIT(11)
+#define B_BE_BT_AFE_LDO_EN BIT(10)
+#define B_BE_BT_AFE_PLL_EN BIT(9)
+#define B_BE_WLAN_32K_SEL BIT(6)
+#define B_BE_WL_DRV_EXIST_IDX BIT(5)
+#define B_BE_DOP_EHPAD BIT(4)
+#define B_BE_WL_FUNC_EN BIT(2)
+#define B_BE_WL_HWPDN_SL BIT(1)
+#define B_BE_WL_HWPDN_EN BIT(0)
+
 #define R_BE_SYS_SDIO_CTRL 0x0070
 #define B_BE_MCM_FLASH_EN BIT(28)
 #define B_BE_PCIE_SEC_LOAD BIT(26)
@@ -3780,6 +3839,19 @@
 #define B_BE_EF_DSB_EN BIT(11)
 #define B_BE_EF_DLY_SEL_MASK GENMASK(3, 0)
 
+#define R_BE_PMC_DBG_CTRL2 0x00CC
+#define B_BE_EFUSE_BURN_GNT_MASK GENMASK(31, 24)
+#define B_BE_DIS_IOWRAP_TIMEOUT BIT(16)
+#define B_BE_STOP_WL_PMC BIT(9)
+#define B_BE_STOP_SYM_PMC BIT(8)
+#define B_BE_SYM_REG_PCIE_WRMSK BIT(7)
+#define B_BE_BT_ACCESS_WL_PAGE0 BIT(6)
+#define B_BE_R_BE_RST_WLPMC BIT(5)
+#define B_BE_R_BE_RST_PD12N BIT(4)
+#define B_BE_SYSON_DIS_WLR_BE_WRMSK BIT(3)
+#define B_BE_SYSON_DIS_PMCR_BE_WRMSK BIT(2)
+#define B_BE_SYSON_R_BE_ARB_MASK GENMASK(1, 0)
+
 #define R_BE_HALT_H2C_CTRL 0x0160
 #define B_BE_HALT_H2C_TRIGGER BIT(0)
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index ffc464b2ac10..dd15b904cd2f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -500,7 +500,8 @@ static void rtw8851b_efuse_parsing_gain_offset(struct rtw89_dev *rtwdev,
 	gain->offset_valid = valid;
 }
 
-static int rtw8851b_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map)
+static int rtw8851b_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
+			       enum rtw89_efuse_block block)
 {
 	struct rtw89_efuse *efuse = &rtwdev->efuse;
 	struct rtw8851b_efuse *map;
@@ -2400,6 +2401,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.limit_efuse_size	= 1280,
 	.dav_phy_efuse_size	= 0,
 	.dav_log_efuse_size	= 0,
+	.efuse_blocks		= NULL,
 	.phycap_addr		= 0x580,
 	.phycap_size		= 128,
 	.para_ver		= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 0d6f87b900d5..2bddd0acb195 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -537,7 +537,8 @@ static void rtw8852a_efuse_parsing_tssi(struct rtw89_dev *rtwdev,
 	}
 }
 
-static int rtw8852a_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map)
+static int rtw8852a_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
+			       enum rtw89_efuse_block block)
 {
 	struct rtw89_efuse *efuse = &rtwdev->efuse;
 	struct rtw8852a_efuse *map;
@@ -2136,6 +2137,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.limit_efuse_size	= 1152,
 	.dav_phy_efuse_size	= 0,
 	.dav_log_efuse_size	= 0,
+	.efuse_blocks		= NULL,
 	.phycap_addr		= 0x580,
 	.phycap_size		= 128,
 	.para_ver		= 0x0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 62c2feab569c..a576e4f47880 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -638,7 +638,8 @@ static void rtw8852b_efuse_parsing_gain_offset(struct rtw89_dev *rtwdev,
 	gain->offset_valid = valid;
 }
 
-static int rtw8852b_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map)
+static int rtw8852b_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
+			       enum rtw89_efuse_block block)
 {
 	struct rtw89_efuse *efuse = &rtwdev->efuse;
 	struct rtw8852b_efuse *map;
@@ -2570,6 +2571,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.limit_efuse_size	= 1280,
 	.dav_phy_efuse_size	= 96,
 	.dav_log_efuse_size	= 16,
+	.efuse_blocks		= NULL,
 	.phycap_addr		= 0x580,
 	.phycap_size		= 128,
 	.para_ver		= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 7bb5d359a06a..1d655ce1fd5f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -430,7 +430,8 @@ static void rtw8852c_efuse_parsing_gain_offset(struct rtw89_dev *rtwdev,
 	gain->offset_valid = valid;
 }
 
-static int rtw8852c_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map)
+static int rtw8852c_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
+			       enum rtw89_efuse_block block)
 {
 	struct rtw89_efuse *efuse = &rtwdev->efuse;
 	struct rtw8852c_efuse *map;
@@ -2884,6 +2885,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.limit_efuse_size	= 1280,
 	.dav_phy_efuse_size	= 96,
 	.dav_log_efuse_size	= 16,
+	.efuse_blocks		= NULL,
 	.phycap_addr		= 0x590,
 	.phycap_size		= 0x60,
 	.para_ver		= 0x1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index e6f804b4907e..4a431640a1ce 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -3,6 +3,7 @@
  */
 
 #include "debug.h"
+#include "efuse.h"
 #include "fw.h"
 #include "mac.h"
 #include "phy.h"
@@ -14,6 +15,17 @@
 #define RTW8922A_MODULE_FIRMWARE \
 	RTW8922A_FW_BASENAME ".bin"
 
+static const struct rtw89_efuse_block_cfg rtw8922a_efuse_blocks[] = {
+	[RTW89_EFUSE_BLOCK_SYS]			= {.offset = 0x00000, .size = 0x310},
+	[RTW89_EFUSE_BLOCK_RF]			= {.offset = 0x10000, .size = 0x240},
+	[RTW89_EFUSE_BLOCK_HCI_DIG_PCIE_SDIO]	= {.offset = 0x20000, .size = 0x4800},
+	[RTW89_EFUSE_BLOCK_HCI_DIG_USB]		= {.offset = 0x30000, .size = 0x890},
+	[RTW89_EFUSE_BLOCK_HCI_PHY_PCIE]	= {.offset = 0x40000, .size = 0x200},
+	[RTW89_EFUSE_BLOCK_HCI_PHY_USB3]	= {.offset = 0x50000, .size = 0x80},
+	[RTW89_EFUSE_BLOCK_HCI_PHY_USB2]	= {.offset = 0x60000, .size = 0x0},
+	[RTW89_EFUSE_BLOCK_ADIE]		= {.offset = 0x70000, .size = 0x10},
+};
+
 #ifdef CONFIG_PM
 static const struct wiphy_wowlan_support rtw_wowlan_stub_8922a = {
 	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT,
@@ -81,6 +93,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.limit_efuse_size	= 0x40000,
 	.dav_phy_efuse_size	= 0,
 	.dav_log_efuse_size	= 0,
+	.efuse_blocks		= rtw8922a_efuse_blocks,
 	.phycap_addr		= 0x1700,
 	.phycap_size		= 0x38,
 
-- 
2.25.1

