Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4431B35BB
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 05:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgDVDqY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 23:46:24 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37005 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgDVDqS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 23:46:18 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03M3kBzB5004569, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03M3kBzB5004569
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Apr 2020 11:46:11 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Apr 2020 11:46:11 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Apr 2020 11:46:10 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>
Subject: [PATCH v2 6/8] rtw88: 8723d: implement set_tx_power_index ops
Date:   Wed, 22 Apr 2020 11:46:05 +0800
Message-ID: <20200422034607.28747-7-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422034607.28747-1-yhchuang@realtek.com>
References: <20200422034607.28747-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

The txagc table is used to map rate_id and txagc register address and
mask, and ops set_tx_power_index uses this table to write TX power to
corresponding registers. Since 8723D is a 1x1 2.4G 11n chip, only CCK, OFDM
and HT_MCS 0-7 are listed in the table.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 5e8e0dd6456e..f2d21272b237 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -14,6 +14,29 @@
 #include "reg.h"
 #include "debug.h"
 
+static const struct rtw_hw_reg rtw8723d_txagc[] = {
+	[DESC_RATE1M]	= { .addr = 0xe08, .mask = 0x0000ff00 },
+	[DESC_RATE2M]	= { .addr = 0x86c, .mask = 0x0000ff00 },
+	[DESC_RATE5_5M]	= { .addr = 0x86c, .mask = 0x00ff0000 },
+	[DESC_RATE11M]	= { .addr = 0x86c, .mask = 0xff000000 },
+	[DESC_RATE6M]	= { .addr = 0xe00, .mask = 0x000000ff },
+	[DESC_RATE9M]	= { .addr = 0xe00, .mask = 0x0000ff00 },
+	[DESC_RATE12M]	= { .addr = 0xe00, .mask = 0x00ff0000 },
+	[DESC_RATE18M]	= { .addr = 0xe00, .mask = 0xff000000 },
+	[DESC_RATE24M]	= { .addr = 0xe04, .mask = 0x000000ff },
+	[DESC_RATE36M]	= { .addr = 0xe04, .mask = 0x0000ff00 },
+	[DESC_RATE48M]	= { .addr = 0xe04, .mask = 0x00ff0000 },
+	[DESC_RATE54M]	= { .addr = 0xe04, .mask = 0xff000000 },
+	[DESC_RATEMCS0]	= { .addr = 0xe10, .mask = 0x000000ff },
+	[DESC_RATEMCS1]	= { .addr = 0xe10, .mask = 0x0000ff00 },
+	[DESC_RATEMCS2]	= { .addr = 0xe10, .mask = 0x00ff0000 },
+	[DESC_RATEMCS3]	= { .addr = 0xe10, .mask = 0xff000000 },
+	[DESC_RATEMCS4]	= { .addr = 0xe14, .mask = 0x000000ff },
+	[DESC_RATEMCS5]	= { .addr = 0xe14, .mask = 0x0000ff00 },
+	[DESC_RATEMCS6]	= { .addr = 0xe14, .mask = 0x00ff0000 },
+	[DESC_RATEMCS7]	= { .addr = 0xe14, .mask = 0xff000000 },
+};
+
 static void rtw8723de_efuse_parsing(struct rtw_efuse *efuse,
 				    struct rtw8723d_efuse *map)
 {
@@ -70,6 +93,43 @@ static void rtw8723d_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
 	rtw_write8(rtwdev, REG_LDO_EFUSE_CTRL + 3, ldo_pwr);
 }
 
+static void
+rtw8723d_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 rs)
+{
+	struct rtw_hal *hal = &rtwdev->hal;
+	const struct rtw_hw_reg *txagc;
+	u8 rate, pwr_index;
+	int j;
+
+	for (j = 0; j < rtw_rate_size[rs]; j++) {
+		rate = rtw_rate_section[rs][j];
+		pwr_index = hal->tx_pwr_tbl[path][rate];
+
+		if (rate >= ARRAY_SIZE(rtw8723d_txagc)) {
+			rtw_warn(rtwdev, "rate 0x%x isn't supported\n", rate);
+			continue;
+		}
+		txagc = &rtw8723d_txagc[rate];
+		if (!txagc->addr) {
+			rtw_warn(rtwdev, "rate 0x%x isn't defined\n", rate);
+			continue;
+		}
+
+		rtw_write32_mask(rtwdev, txagc->addr, txagc->mask, pwr_index);
+	}
+}
+
+static void rtw8723d_set_tx_power_index(struct rtw_dev *rtwdev)
+{
+	struct rtw_hal *hal = &rtwdev->hal;
+	int rs, path;
+
+	for (path = 0; path < hal->rf_path_num; path++) {
+		for (rs = 0; rs <= RTW_RATE_SECTION_HT_1S; rs++)
+			rtw8723d_set_tx_power_index_by_rate(rtwdev, path, rs);
+	}
+}
+
 static void rtw8723d_efuse_grant(struct rtw_dev *rtwdev, bool on)
 {
 	if (on) {
@@ -86,6 +146,7 @@ static struct rtw_chip_ops rtw8723d_ops = {
 	.read_efuse		= rtw8723d_read_efuse,
 	.read_rf		= rtw_phy_read_rf_sipi,
 	.write_rf		= rtw_phy_write_rf_reg_sipi,
+	.set_tx_power_index	= rtw8723d_set_tx_power_index,
 	.set_antenna		= NULL,
 	.cfg_ldo25		= rtw8723d_cfg_ldo25,
 	.efuse_grant		= rtw8723d_efuse_grant,
-- 
2.17.1

