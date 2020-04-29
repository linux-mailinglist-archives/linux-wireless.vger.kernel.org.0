Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC0B1BD8DF
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2020 11:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgD2J5J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 05:57:09 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:49973 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD2J5J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 05:57:09 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03T9v4561030884, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03T9v4561030884
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 29 Apr 2020 17:57:04 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 29 Apr 2020 17:57:04 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 29 Apr 2020 17:57:03 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>
Subject: [PATCH v3 1/8] rtw88: 8723d: Add DIG parameter
Date:   Wed, 29 Apr 2020 17:56:49 +0800
Message-ID: <20200429095656.19315-2-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429095656.19315-1-yhchuang@realtek.com>
References: <20200429095656.19315-1-yhchuang@realtek.com>
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

To improve user experience in field, we need DIG to adjust RX initial gain
depends on field situation. Since each chip has its own register address,
this commit defines 8723d specific address.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 8ca4d5794434..52afa72caf8f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -706,6 +706,11 @@ static const struct rtw_rqpn rqpn_table_8723d[] = {
 	 RTW_DMA_MAPPING_EXTRA, RTW_DMA_MAPPING_HIGH},
 };
 
+static const struct rtw_hw_reg rtw8723d_dig[] = {
+	[0] = { .addr = 0xc50, .mask = 0x7f },
+	[1] = { .addr = 0xc50, .mask = 0x7f },
+};
+
 static const struct rtw_rf_sipi_addr rtw8723d_rf_sipi_addr[] = {
 	[RF_PATH_A] = { .hssi_1 = 0x820, .lssi_read    = 0x8a0,
 			.hssi_2 = 0x824, .lssi_read_pi = 0x8b8},
@@ -738,6 +743,7 @@ struct rtw_chip_info rtw8723d_hw_spec = {
 	.csi_buf_pg_num = 0,
 	.band = RTW_BAND_2G,
 	.page_size = 128,
+	.dig_min = 0x20,
 	.ht_supported = true,
 	.vht_supported = false,
 	.lps_deep_mode_supported = 0,
@@ -746,6 +752,7 @@ struct rtw_chip_info rtw8723d_hw_spec = {
 	.pwr_off_seq = card_disable_flow_8723d,
 	.page_table = page_table_8723d,
 	.rqpn_table = rqpn_table_8723d,
+	.dig = rtw8723d_dig,
 	.rf_sipi_addr = {0x840, 0x844},
 	.rf_sipi_read_addr = rtw8723d_rf_sipi_addr,
 	.fix_rf_phy_num = 2,
-- 
2.17.1

