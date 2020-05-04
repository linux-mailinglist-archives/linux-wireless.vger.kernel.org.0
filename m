Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2E01C3730
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 12:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgEDKuU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 06:50:20 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:51252 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgEDKuU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 06:50:20 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 044AoFQ11003135, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 044AoFQ11003135
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 4 May 2020 18:50:15 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 4 May 2020 18:50:14 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 4 May 2020 18:50:14 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <bigeasy@linutronix.de>
Subject: [PATCH v4 8/8] rtw88: 8723d: add interface configurations table
Date:   Mon, 4 May 2020 18:50:10 +0800
Message-ID: <20200504105010.10780-9-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504105010.10780-1-yhchuang@realtek.com>
References: <20200504105010.10780-1-yhchuang@realtek.com>
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

Interface configuration table is used to configure PCI PHY that are
normally decided by design or bootstrap pin, and driver can do additional
settings by this table.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index b6266b2942cf..92c742d1ce6d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -1048,6 +1048,26 @@ static const struct rtw_rqpn rqpn_table_8723d[] = {
 	 RTW_DMA_MAPPING_EXTRA, RTW_DMA_MAPPING_HIGH},
 };
 
+static const struct rtw_intf_phy_para pcie_gen1_param_8723d[] = {
+	{0x0008, 0x4a22,
+	 RTW_IP_SEL_PHY,
+	 RTW_INTF_PHY_CUT_ALL,
+	 RTW_INTF_PHY_PLATFORM_ALL},
+	{0x0009, 0x1000,
+	 RTW_IP_SEL_PHY,
+	 ~(RTW_INTF_PHY_CUT_A | RTW_INTF_PHY_CUT_B),
+	 RTW_INTF_PHY_PLATFORM_ALL},
+	{0xFFFF, 0x0000,
+	 RTW_IP_SEL_PHY,
+	 RTW_INTF_PHY_CUT_ALL,
+	 RTW_INTF_PHY_PLATFORM_ALL},
+};
+
+static const struct rtw_intf_phy_para_table phy_para_table_8723d = {
+	.gen1_para	= pcie_gen1_param_8723d,
+	.n_gen1_para	= ARRAY_SIZE(pcie_gen1_param_8723d),
+};
+
 static const struct rtw_hw_reg rtw8723d_dig[] = {
 	[0] = { .addr = 0xc50, .mask = 0x7f },
 	[1] = { .addr = 0xc50, .mask = 0x7f },
@@ -1098,6 +1118,7 @@ struct rtw_chip_info rtw8723d_hw_spec = {
 	.pwr_off_seq = card_disable_flow_8723d,
 	.page_table = page_table_8723d,
 	.rqpn_table = rqpn_table_8723d,
+	.intf_table = &phy_para_table_8723d,
 	.dig = rtw8723d_dig,
 	.dig_cck = rtw8723d_dig_cck,
 	.rf_sipi_addr = {0x840, 0x844},
-- 
2.17.1

