Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943BB1AD7DE
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgDQHrf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:47:35 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37053 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729200AbgDQHrM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:47:12 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03H7l6oD5020081, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03H7l6oD5020081
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Apr 2020 15:47:06 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:03 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:03 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>,
        <briannorris@chromium.org>, <kevin_yang@realtek.com>
Subject: [PATCH 23/40] rtw88: 8723d: Set IG register for CCK rate
Date:   Fri, 17 Apr 2020 15:46:36 +0800
Message-ID: <20200417074653.15591-24-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417074653.15591-1-yhchuang@realtek.com>
References: <20200417074653.15591-1-yhchuang@realtek.com>
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

DIG sets only one IG register for most chips, but 8723D need to set
additional register for CCK rate.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h     | 1 +
 drivers/net/wireless/realtek/rtw88/phy.c      | 4 ++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 5 +++++
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 1 +
 5 files changed, 12 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 157aca641f6d..d51eeda3627c 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1099,6 +1099,7 @@ struct rtw_chip_info {
 	const struct rtw_intf_phy_para_table *intf_table;
 
 	const struct rtw_hw_reg *dig;
+	const struct rtw_hw_reg *dig_cck;
 	u32 rf_base_addr[2];
 	u32 rf_sipi_addr[2];
 	const struct rtw_rf_sipi_addr *rf_sipi_read_addr;
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 8489abfdc12e..72a16eff9db3 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -140,9 +140,13 @@ void rtw_phy_dig_write(struct rtw_dev *rtwdev, u8 igi)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_hal *hal = &rtwdev->hal;
+	const struct rtw_hw_reg *dig_cck = &chip->dig_cck[0];
 	u32 addr, mask;
 	u8 path;
 
+	if (dig_cck)
+		rtw_write32_mask(rtwdev, dig_cck->addr, dig_cck->mask, igi >> 1);
+
 	for (path = 0; path < hal->rf_path_num; path++) {
 		addr = chip->dig[path].addr;
 		mask = chip->dig[path].mask;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index df78d3b4b07a..dd8943426bb3 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -1077,6 +1077,10 @@ static const struct rtw_hw_reg rtw8723d_dig[] = {
 	[1] = { .addr = 0xc50, .mask = 0x7f },
 };
 
+static const struct rtw_hw_reg rtw8723d_dig_cck[] = {
+	[0] = { .addr = 0xa0c, .mask = 0x3f00 },
+};
+
 static const struct rtw_rf_sipi_addr rtw8723d_rf_sipi_addr[] = {
 	[RF_PATH_A] = { .hssi_1 = 0x820, .lssi_read    = 0x8a0,
 			.hssi_2 = 0x824, .lssi_read_pi = 0x8b8},
@@ -1119,6 +1123,7 @@ struct rtw_chip_info rtw8723d_hw_spec = {
 	.page_table = page_table_8723d,
 	.rqpn_table = rqpn_table_8723d,
 	.dig = rtw8723d_dig,
+	.dig_cck = rtw8723d_dig_cck,
 	.rf_sipi_addr = {0x840, 0x844},
 	.rf_sipi_read_addr = rtw8723d_rf_sipi_addr,
 	.fix_rf_phy_num = 2,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index ffee8111d145..51b16a831162 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2435,6 +2435,7 @@ struct rtw_chip_info rtw8822b_hw_spec = {
 	.rqpn_table = rqpn_table_8822b,
 	.intf_table = &phy_para_table_8822b,
 	.dig = rtw8822b_dig,
+	.dig_cck = NULL,
 	.rf_base_addr = {0x2800, 0x2c00},
 	.rf_sipi_addr = {0xc90, 0xe90},
 	.mac_tbl = &rtw8822b_mac_tbl,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 2c4ead6b3bef..b17b7cfbbe40 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4183,6 +4183,7 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.rqpn_table = rqpn_table_8822c,
 	.intf_table = &phy_para_table_8822c,
 	.dig = rtw8822c_dig,
+	.dig_cck = NULL,
 	.rf_base_addr = {0x3c00, 0x4c00},
 	.rf_sipi_addr = {0x1808, 0x4108},
 	.mac_tbl = &rtw8822c_mac_tbl,
-- 
2.17.1

