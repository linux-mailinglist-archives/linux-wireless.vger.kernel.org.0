Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7D81B012C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2020 07:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgDTFvP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Apr 2020 01:51:15 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:42171 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgDTFvP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Apr 2020 01:51:15 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03K5p9Zg9001143, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03K5p9Zg9001143
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Apr 2020 13:51:09 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 20 Apr 2020 13:51:09 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 20 Apr 2020 13:51:08 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 8/8] rtw88: 8723d: Add read_efuse to recognize efuse info from map
Date:   Mon, 20 Apr 2020 13:50:54 +0800
Message-ID: <20200420055054.14592-9-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420055054.14592-1-yhchuang@realtek.com>
References: <20200420055054.14592-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

The logical efuse map is decoded from physical map by parsing the
header format of the physical map. And each different type of chips
has different logical efuse layout. So add the logical map's layout
for parsing the efuse contents.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 43 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.h | 39 +++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 756454d69fad..c25cabbab64d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -14,6 +14,48 @@
 #include "reg.h"
 #include "debug.h"
 
+static void rtw8723de_efuse_parsing(struct rtw_efuse *efuse,
+				    struct rtw8723d_efuse *map)
+{
+	ether_addr_copy(efuse->addr, map->e.mac_addr);
+}
+
+static int rtw8723d_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
+{
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw8723d_efuse *map;
+	int i;
+
+	map = (struct rtw8723d_efuse *)log_map;
+
+	efuse->rfe_option = 0;
+	efuse->rf_board_option = map->rf_board_option;
+	efuse->crystal_cap = map->xtal_k;
+	efuse->pa_type_2g = map->pa_type;
+	efuse->lna_type_2g = map->lna_type_2g[0];
+	efuse->channel_plan = map->channel_plan;
+	efuse->country_code[0] = map->country_code[0];
+	efuse->country_code[1] = map->country_code[1];
+	efuse->bt_setting = map->rf_bt_setting;
+	efuse->regd = map->rf_board_option & 0x7;
+	efuse->thermal_meter[0] = map->thermal_meter;
+	efuse->thermal_meter_k = map->thermal_meter;
+
+	for (i = 0; i < 4; i++)
+		efuse->txpwr_idx_table[i] = map->txpwr_idx_table[i];
+
+	switch (rtw_hci_type(rtwdev)) {
+	case RTW_HCI_TYPE_PCIE:
+		rtw8723de_efuse_parsing(efuse, map);
+		break;
+	default:
+		/* unsupported now */
+		return -ENOTSUPP;
+	}
+
+	return 0;
+}
+
 static void rtw8723d_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
 {
 	u8 ldo_pwr;
@@ -41,6 +83,7 @@ static void rtw8723d_efuse_grant(struct rtw_dev *rtwdev, bool on)
 }
 
 static struct rtw_chip_ops rtw8723d_ops = {
+	.read_efuse		= rtw8723d_read_efuse,
 	.read_rf		= rtw_phy_read_rf_sipi,
 	.write_rf		= rtw_phy_write_rf_reg_sipi,
 	.set_antenna		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.h b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
index 0b784cfc34c6..1939d9897a26 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
@@ -5,4 +5,43 @@
 #ifndef __RTW8723D_H__
 #define __RTW8723D_H__
 
+struct rtw8723de_efuse {
+	u8 mac_addr[ETH_ALEN];		/* 0xd0 */
+	u8 vender_id[2];
+	u8 device_id[2];
+	u8 sub_vender_id[2];
+	u8 sub_device_id[2];
+};
+
+struct rtw8723d_efuse {
+	__le16 rtl_id;
+	u8 rsvd[2];
+	u8 afe;
+	u8 rsvd1[11];
+
+	/* power index for four RF paths */
+	struct rtw_txpwr_idx txpwr_idx_table[4];
+
+	u8 channel_plan;		/* 0xb8 */
+	u8 xtal_k;
+	u8 thermal_meter;
+	u8 iqk_lck;
+	u8 pa_type;			/* 0xbc */
+	u8 lna_type_2g[2];		/* 0xbd */
+	u8 lna_type_5g[2];
+	u8 rf_board_option;
+	u8 rf_feature_option;
+	u8 rf_bt_setting;
+	u8 eeprom_version;
+	u8 eeprom_customer_id;
+	u8 tx_bb_swing_setting_2g;
+	u8 res_c7;
+	u8 tx_pwr_calibrate_rate;
+	u8 rf_antenna_option;		/* 0xc9 */
+	u8 rfe_option;
+	u8 country_code[2];
+	u8 res[3];
+	struct rtw8723de_efuse e;
+};
+
 #endif
-- 
2.17.1

