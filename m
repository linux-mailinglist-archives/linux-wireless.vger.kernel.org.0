Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684F91AD7C7
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbgDQHrQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:47:16 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37000 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbgDQHrN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:47:13 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03H7l1Oh9020020, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03H7l1Oh9020020
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Apr 2020 15:47:01 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:00 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:00 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>,
        <briannorris@chromium.org>, <kevin_yang@realtek.com>
Subject: [PATCH 03/40] rtw88: 8723d: Add power sequence
Date:   Fri, 17 Apr 2020 15:46:16 +0800
Message-ID: <20200417074653.15591-4-yhchuang@realtek.com>
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

Add corresponding power sequence for 8723D devices

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h     |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 403 ++++++++++++++++++
 2 files changed, 404 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index be74533320ad..e852ab194315 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -847,6 +847,7 @@ struct rtw_chip_ops {
 #define RTW_PWR_INTF_PCI_MSK	BIT(2)
 #define RTW_PWR_INTF_ALL_MSK	(BIT(0) | BIT(1) | BIT(2) | BIT(3))
 
+#define RTW_PWR_CUT_TEST_MSK	BIT(0)
 #define RTW_PWR_CUT_A_MSK	BIT(1)
 #define RTW_PWR_CUT_B_MSK	BIT(2)
 #define RTW_PWR_CUT_C_MSK	BIT(3)
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 5798a5804af3..5b97730f1407 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -21,6 +21,407 @@ static struct rtw_chip_ops rtw8723d_ops = {
 	.cfg_csi_rate		= NULL,
 };
 
+static const struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8723d[] = {
+	{0x0005,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(3) | BIT(7), 0},
+	{0x0086,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_SDIO,
+	 RTW_PWR_CMD_WRITE, BIT(0), 0},
+	{0x0086,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_SDIO,
+	 RTW_PWR_CMD_POLLING, BIT(1), BIT(1)},
+	{0x004A,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_USB_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(0), 0},
+	{0x0005,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(3) | BIT(4), 0},
+	{0x0023,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(4), 0},
+	{0x0301,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_PCI_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, 0xFF, 0},
+	{0xFFFF,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 0,
+	 RTW_PWR_CMD_END, 0, 0},
+};
+
+static const struct rtw_pwr_seq_cmd trans_cardemu_to_act_8723d[] = {
+	{0x0020,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(0), BIT(0)},
+	{0x0001,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_DELAY, 1, RTW_PWR_DELAY_MS},
+	{0x0000,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(5), 0},
+	{0x0005,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, (BIT(4) | BIT(3) | BIT(2)), 0},
+	{0x0075,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_PCI_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(0), BIT(0)},
+	{0x0006,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_POLLING, BIT(1), BIT(1)},
+	{0x0075,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_PCI_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(0), 0},
+	{0x0006,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(0), BIT(0)},
+	{0x0005,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_POLLING, (BIT(1) | BIT(0)), 0},
+	{0x0005,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(7), 0},
+	{0x0005,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, (BIT(4) | BIT(3)), 0},
+	{0x0005,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(0), BIT(0)},
+	{0x0005,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_POLLING, BIT(0), 0},
+	{0x0010,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(6), BIT(6)},
+	{0x0049,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(1), BIT(1)},
+	{0x0063,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(1), BIT(1)},
+	{0x0062,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(1), 0},
+	{0x0058,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(0), BIT(0)},
+	{0x005A,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(1), BIT(1)},
+	{0x0068,
+	 RTW_PWR_CUT_TEST_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(3), BIT(3)},
+	{0x0069,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(6), BIT(6)},
+	{0x001f,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, 0xFF, 0x00},
+	{0x0077,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, 0xFF, 0x00},
+	{0x001f,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, 0xFF, 0x07},
+	{0x0077,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, 0xFF, 0x07},
+	{0xFFFF,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 0,
+	 RTW_PWR_CMD_END, 0, 0},
+};
+
+static const struct rtw_pwr_seq_cmd *card_enable_flow_8723d[] = {
+	trans_carddis_to_cardemu_8723d,
+	trans_cardemu_to_act_8723d,
+	NULL
+};
+
+static const struct rtw_pwr_seq_cmd trans_act_to_lps_8723d[] = {
+	{0x0301,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_PCI_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, 0xFF, 0xFF},
+	{0x0522,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, 0xFF, 0xFF},
+	{0x05F8,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_POLLING, 0xFF, 0},
+	{0x05F9,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_POLLING, 0xFF, 0},
+	{0x05FA,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_POLLING, 0xFF, 0},
+	{0x05FB,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_POLLING, 0xFF, 0},
+	{0x0002,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(0), 0},
+	{0x0002,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_DELAY, 0, RTW_PWR_DELAY_US},
+	{0x0002,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(1), 0},
+	{0x0100,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, 0xFF, 0x03},
+	{0x0101,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(1), 0},
+	{0x0093,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, 0xFF, 0x00},
+	{0x0553,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(5), BIT(5)},
+	{0xFFFF,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 0,
+	 RTW_PWR_CMD_END, 0, 0},
+};
+
+static const struct rtw_pwr_seq_cmd trans_act_to_pre_carddis_8723d[] = {
+	{0x0003,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(2), 0},
+	{0x0080,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, 0xFF, 0},
+	{0xFFFF,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 0,
+	 RTW_PWR_CMD_END, 0, 0},
+};
+
+static const struct rtw_pwr_seq_cmd trans_act_to_cardemu_8723d[] = {
+	{0x0002,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(0), 0},
+	{0x0049,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(1), 0},
+	{0x0006,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(0), BIT(0)},
+	{0x0005,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(1), BIT(1)},
+	{0x0005,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_POLLING, BIT(1), 0},
+	{0x0010,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(6), 0},
+	{0x0000,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(5), BIT(5)},
+	{0x0020,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(0), 0},
+	{0xFFFF,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 0,
+	 RTW_PWR_CMD_END, 0, 0},
+};
+
+static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8723d[] = {
+	{0x0007,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, 0xFF, 0x20},
+	{0x0005,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(3) | BIT(4), BIT(3)},
+	{0x0005,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_PCI_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(2), BIT(2)},
+	{0x0005,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_PCI_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(3) | BIT(4), BIT(3) | BIT(4)},
+	{0x004A,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_USB_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(0), 1},
+	{0x0023,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(4), BIT(4)},
+	{0x0086,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_SDIO,
+	 RTW_PWR_CMD_WRITE, BIT(0), BIT(0)},
+	{0x0086,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_SDIO,
+	 RTW_PWR_CMD_POLLING, BIT(1), 0},
+	{0xFFFF,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 0,
+	 RTW_PWR_CMD_END, 0, 0},
+};
+
+static const struct rtw_pwr_seq_cmd trans_act_to_post_carddis_8723d[] = {
+	{0x001D,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(0), 0},
+	{0x001D,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(0), BIT(0)},
+	{0x001C,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, 0xFF, 0x0E},
+	{0xFFFF,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_ALL_MSK,
+	 0,
+	 RTW_PWR_CMD_END, 0, 0},
+};
+
+static const struct rtw_pwr_seq_cmd *card_disable_flow_8723d[] = {
+	trans_act_to_lps_8723d,
+	trans_act_to_pre_carddis_8723d,
+	trans_act_to_cardemu_8723d,
+	trans_cardemu_to_carddis_8723d,
+	trans_act_to_post_carddis_8723d,
+	NULL
+};
+
 struct rtw_chip_info rtw8723d_hw_spec = {
 	.ops = &rtw8723d_ops,
 	.id = RTW_CHIP_TYPE_8723D,
@@ -41,6 +442,8 @@ struct rtw_chip_info rtw8723d_hw_spec = {
 	.vht_supported = false,
 	.lps_deep_mode_supported = 0,
 	.sys_func_en = 0xFD,
+	.pwr_on_seq = card_enable_flow_8723d,
+	.pwr_off_seq = card_disable_flow_8723d,
 };
 EXPORT_SYMBOL(rtw8723d_hw_spec);
 
-- 
2.17.1

