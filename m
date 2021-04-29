Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC7F36E671
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Apr 2021 10:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbhD2IEK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Apr 2021 04:04:10 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:43410 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbhD2IED (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Apr 2021 04:04:03 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 13T83DoG4025406, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 13T83DoG4025406
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Apr 2021 16:03:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 29 Apr 2021 16:03:12 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 29 Apr
 2021 16:03:12 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v4 05/19] rtw89: add efuse files
Date:   Thu, 29 Apr 2021 16:01:35 +0800
Message-ID: <20210429080149.7068-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210429080149.7068-1-pkshih@realtek.com>
References: <20210429080149.7068-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXH36502.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMjkgpFekyCAwMjo0NTowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/29/2021 07:29:45
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163401 [Apr 29 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, headers_charset}
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/29/2021 07:33:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMjkgpFekyCAwNzoyMDowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/29/2021 07:51:53
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163403 [Apr 29 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, headers_charset}
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/29/2021 07:54:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Efuse is divided into several parts, in which physical map and PHY cap
parts are read and parsed by driver.

Storing main data, physical map is translated into logic map, and then use
chip specific map to explain the logic map. Then, we can have MAC address,
country code, thermal tracking calibration values, and so on.

PHY cap part is used to store PHY data. We don't need to translate it,
because it's a direct map, like logic map.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/efuse.c | 188 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/efuse.h |  13 ++
 2 files changed, 201 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/efuse.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/efuse.h

diff --git a/drivers/net/wireless/realtek/rtw89/efuse.c b/drivers/net/wireless/realtek/rtw89/efuse.c
new file mode 100644
index 000000000000..3bea7d813985
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/efuse.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+
+#include "debug.h"
+#include "efuse.h"
+#include "reg.h"
+
+enum rtw89_efuse_bank {
+	RTW89_EFUSE_BANK_WIFI,
+	RTW89_EFUSE_BANK_BT,
+};
+
+static int rtw89_switch_efuse_bank(struct rtw89_dev *rtwdev,
+				   enum rtw89_efuse_bank bank)
+{
+	u8 val;
+
+	val = rtw89_read32_mask(rtwdev, R_AX_EFUSE_CTRL_1,
+				B_AX_EF_CELL_SEL_MASK);
+	if (bank == val)
+		return 0;
+
+	rtw89_write32_mask(rtwdev, R_AX_EFUSE_CTRL_1, B_AX_EF_CELL_SEL_MASK,
+			   bank);
+
+	val = rtw89_read32_mask(rtwdev, R_AX_EFUSE_CTRL_1,
+				B_AX_EF_CELL_SEL_MASK);
+	if (bank == val)
+		return 0;
+
+	return -EBUSY;
+}
+
+static int rtw89_dump_physical_efuse_map(struct rtw89_dev *rtwdev, u8 *map,
+					 u32 dump_addr, u32 dump_size)
+{
+	u32 efuse_ctl;
+	u32 addr;
+	int ret;
+
+	rtw89_switch_efuse_bank(rtwdev, RTW89_EFUSE_BANK_WIFI);
+
+	for (addr = dump_addr; addr < dump_addr + dump_size; addr++) {
+		efuse_ctl = u32_encode_bits(addr, B_AX_EF_ADDR_MASK);
+		rtw89_write32(rtwdev, R_AX_EFUSE_CTRL, efuse_ctl & ~B_AX_EF_RDY);
+
+		ret = read_poll_timeout_atomic(rtw89_read32, efuse_ctl,
+					       efuse_ctl & B_AX_EF_RDY, 1, 1000000,
+					       true, rtwdev, R_AX_EFUSE_CTRL);
+		if (ret)
+			return -EBUSY;
+
+		*map++ = (u8)(efuse_ctl & 0xff);
+	}
+
+	return 0;
+}
+
+#define invalid_efuse_header(hdr1, hdr2) \
+	((hdr1) == 0xff || (hdr2) == 0xff)
+#define invalid_efuse_content(word_en, i) \
+	(((word_en) & BIT(i)) != 0x0)
+#define get_efuse_blk_idx(hdr1, hdr2) \
+	((((hdr2) & 0xf0) >> 4) | (((hdr1) & 0x0f) << 4))
+#define block_idx_to_logical_idx(blk_idx, i) \
+	(((blk_idx) << 3) + ((i) << 1))
+static int rtw89_dump_logical_efuse_map(struct rtw89_dev *rtwdev, u8 *phy_map,
+					u8 *log_map)
+{
+	u32 physical_size = rtwdev->chip->physical_efuse_size;
+	u32 logical_size = rtwdev->chip->logical_efuse_size;
+	u8 sec_ctrl_size = rtwdev->chip->sec_ctrl_efuse_size;
+	u32 phy_idx = sec_ctrl_size;
+	u32 log_idx;
+	u8 hdr1, hdr2;
+	u8 blk_idx;
+	u8 word_en;
+	int i;
+
+	while (phy_idx < physical_size - sec_ctrl_size) {
+		hdr1 = phy_map[phy_idx];
+		hdr2 = phy_map[phy_idx + 1];
+		if (invalid_efuse_header(hdr1, hdr2))
+			break;
+
+		blk_idx = get_efuse_blk_idx(hdr1, hdr2);
+		word_en = hdr2 & 0xf;
+		phy_idx += 2;
+
+		for (i = 0; i < 4; i++) {
+			if (invalid_efuse_content(word_en, i))
+				continue;
+
+			log_idx = block_idx_to_logical_idx(blk_idx, i);
+			if (phy_idx + 1 > physical_size - sec_ctrl_size - 1 ||
+			    log_idx + 1 > logical_size)
+				return -EINVAL;
+
+			log_map[log_idx] = phy_map[phy_idx];
+			log_map[log_idx + 1] = phy_map[phy_idx + 1];
+			phy_idx += 2;
+		}
+	}
+	return 0;
+}
+
+int rtw89_parse_efuse_map(struct rtw89_dev *rtwdev)
+{
+	u32 phy_size = rtwdev->chip->physical_efuse_size;
+	u32 log_size = rtwdev->chip->logical_efuse_size;
+	u8 *phy_map = NULL;
+	u8 *log_map = NULL;
+	int ret;
+
+	if (rtw89_read16(rtwdev, R_AX_SYS_EEPROM_CTRL) & B_AX_AUTOLOAD_SUS)
+		rtwdev->efuse.valid = true;
+	else
+		rtw89_warn(rtwdev, "failed to check efuse autoload\n");
+
+	phy_map = kmalloc(phy_size, GFP_KERNEL);
+	log_map = kmalloc(log_size, GFP_KERNEL);
+
+	if (!phy_map || !log_map) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	ret = rtw89_dump_physical_efuse_map(rtwdev, phy_map, 0, phy_size);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to dump efuse physical map\n");
+		goto out_free;
+	}
+
+	memset(log_map, 0xff, log_size);
+	ret = rtw89_dump_logical_efuse_map(rtwdev, phy_map, log_map);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to dump efuse logical map\n");
+		goto out_free;
+	}
+
+	rtw89_hex_dump(rtwdev, RTW89_DBG_FW, "log_map: ", log_map, log_size);
+
+	ret = rtwdev->chip->ops->read_efuse(rtwdev, log_map);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to read efuse map\n");
+		goto out_free;
+	}
+
+out_free:
+	kfree(log_map);
+	kfree(phy_map);
+
+	return ret;
+}
+
+int rtw89_parse_phycap_map(struct rtw89_dev *rtwdev)
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
+	ret = rtw89_dump_physical_efuse_map(rtwdev, phycap_map,
+					    phycap_addr, phycap_size);
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
diff --git a/drivers/net/wireless/realtek/rtw89/efuse.h b/drivers/net/wireless/realtek/rtw89/efuse.h
new file mode 100644
index 000000000000..622ff95e7476
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/efuse.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+
+#ifndef __RTW89_EFUSE_H__
+#define __RTW89_EFUSE_H__
+
+#include "core.h"
+
+int rtw89_parse_efuse_map(struct rtw89_dev *rtwdev);
+int rtw89_parse_phycap_map(struct rtw89_dev *rtwdev);
+
+#endif
-- 
2.21.0

