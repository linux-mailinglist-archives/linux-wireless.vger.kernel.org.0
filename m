Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823C51ECCAD
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2020 11:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgFCJi0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 05:38:26 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:42239 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgFCJi0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 05:38:26 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0539c9nY5011911, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0539c9nY5011911
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 3 Jun 2020 17:38:09 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 3 Jun 2020 17:38:09 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 3 Jun 2020 17:38:08 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>,
        <bigeasy@linutronix.de>
Subject: [PATCH v3 3/7] rtw88: 8821c: add dig related settings
Date:   Wed, 3 Jun 2020 17:38:00 +0800
Message-ID: <20200603093804.19779-4-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603093804.19779-1-yhchuang@realtek.com>
References: <20200603093804.19779-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

To improve user experience in field, we need DIG to adjust RX initial
gain depends on field situation.

Define the register addresses for 8821c.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index d5ce4ce568dd..dfce8f6cb5fc 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -579,6 +579,10 @@ static const struct rtw_rfe_def rtw8821c_rfe_defs[] = {
 	[0] = RTW_DEF_RFE(8821c, 0, 0),
 };
 
+static struct rtw_hw_reg rtw8821c_dig[] = {
+	[0] = { .addr = 0xc50, .mask = 0x7f },
+};
+
 static const struct rtw_ltecoex_addr rtw8821c_ltecoex_addr = {
 	.ctrl = LTECOEX_ACCESS_CTRL,
 	.wdata = LTECOEX_WRITE_DATA,
@@ -660,6 +664,7 @@ struct rtw_chip_info rtw8821c_hw_spec = {
 	.csi_buf_pg_num = 0,
 	.band = RTW_BAND_2G | RTW_BAND_5G,
 	.page_size = 128,
+	.dig_min = 0x1c,
 	.ht_supported = true,
 	.vht_supported = true,
 	.lps_deep_mode_supported = BIT(LPS_DEEP_MODE_LCLK),
@@ -670,6 +675,7 @@ struct rtw_chip_info rtw8821c_hw_spec = {
 	.rqpn_table = rqpn_table_8821c,
 	.prioq_addrs = &prioq_addrs_8821c,
 	.intf_table = &phy_para_table_8821c,
+	.dig = rtw8821c_dig,
 	.rf_base_addr = {0x2800, 0x2c00},
 	.rf_sipi_addr = {0xc90, 0xe90},
 	.ltecoex_addr = &rtw8821c_ltecoex_addr,
-- 
2.17.1

