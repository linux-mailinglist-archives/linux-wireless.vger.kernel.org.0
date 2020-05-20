Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496DE1DAA20
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 07:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgETFyC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 May 2020 01:54:02 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:40904 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETFyB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 May 2020 01:54:01 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04K5rqteF026645, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04K5rqteF026645
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 20 May 2020 13:53:52 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 20 May 2020 13:53:52 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 20 May 2020 13:53:52 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <kevlo@kevlo.org>
Subject: [PATCH] Revert "rtw88: no need to set registers for SDIO"
Date:   Wed, 20 May 2020 13:53:50 +0800
Message-ID: <20200520055350.23328-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

This reverts commit 07d0f5534935e2daf63a4e1012af13d68e089fed.

For rtw88 driver, the SDIO is going to be supported, so there is
no need to remove the SDIO related power sequence settings. And
while the power sequence parser will pass in the mask of the HCI,
the SDIO part will not be used to set registers accordingly.

Moreover, the power sequence table is released as a whole package,
so the next time if we are going to update, the SDIO settings will
be overwritten. So, revert this now.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 40 ++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 95 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 20 ++++
 3 files changed, 155 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 8641ea645c4b..7422baf2d41b 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2093,6 +2093,16 @@ static const struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8723d[] = {
 	 RTW_PWR_INTF_ALL_MSK,
 	 RTW_PWR_ADDR_MAC,
 	 RTW_PWR_CMD_WRITE, BIT(3) | BIT(7), 0},
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
 	{0x004A,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_USB_MSK,
@@ -2103,6 +2113,11 @@ static const struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8723d[] = {
 	 RTW_PWR_INTF_ALL_MSK,
 	 RTW_PWR_ADDR_MAC,
 	 RTW_PWR_CMD_WRITE, BIT(3) | BIT(4), 0},
+	{0x0023,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(4), 0},
 	{0x0301,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_PCI_MSK,
@@ -2310,6 +2325,11 @@ static const struct rtw_pwr_seq_cmd trans_act_to_lps_8723d[] = {
 	 RTW_PWR_INTF_ALL_MSK,
 	 RTW_PWR_ADDR_MAC,
 	 RTW_PWR_CMD_WRITE, BIT(1), 0},
+	{0x0093,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, 0xFF, 0x00},
 	{0x0553,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_ALL_MSK,
@@ -2389,6 +2409,11 @@ static const struct rtw_pwr_seq_cmd trans_act_to_cardemu_8723d[] = {
 };
 
 static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8723d[] = {
+	{0x0007,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, 0xFF, 0x20},
 	{0x0005,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_SDIO_MSK,
@@ -2409,6 +2434,21 @@ static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8723d[] = {
 	 RTW_PWR_INTF_USB_MSK,
 	 RTW_PWR_ADDR_MAC,
 	 RTW_PWR_CMD_WRITE, BIT(0), 1},
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
 	{0xFFFF,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_ALL_MSK,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 6abcdf4070a2..e49bdd76ab9a 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -1551,6 +1551,16 @@ static void rtw8822b_bf_config_bfee(struct rtw_dev *rtwdev, struct rtw_vif *vif,
 }
 
 static const struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8822b[] = {
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
 	{0x004A,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_USB_MSK,
@@ -1679,6 +1689,11 @@ static const struct rtw_pwr_seq_cmd trans_cardemu_to_act_8822b[] = {
 	 RTW_PWR_INTF_ALL_MSK,
 	 RTW_PWR_ADDR_MAC,
 	 RTW_PWR_CMD_WRITE, 0xFF, 0x0c},
+	{0x0068,
+	 RTW_PWR_CUT_C_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(4), BIT(4)},
 	{0x0029,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_ALL_MSK,
@@ -1707,6 +1722,11 @@ static const struct rtw_pwr_seq_cmd trans_cardemu_to_act_8822b[] = {
 };
 
 static const struct rtw_pwr_seq_cmd trans_act_to_cardemu_8822b[] = {
+	{0x0003,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(2), 0},
 	{0x0093,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_ALL_MSK,
@@ -1775,6 +1795,11 @@ static const struct rtw_pwr_seq_cmd trans_act_to_cardemu_8822b[] = {
 };
 
 static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8822b[] = {
+	{0x0005,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(7), BIT(7)},
 	{0x0007,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_SDIO_MSK,
@@ -1795,6 +1820,46 @@ static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8822b[] = {
 	 RTW_PWR_INTF_USB_MSK,
 	 RTW_PWR_ADDR_MAC,
 	 RTW_PWR_CMD_WRITE, BIT(0), 0},
+	{0x0067,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(5), 0},
+	{0x0067,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(4), 0},
+	{0x004F,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(0), 0},
+	{0x0067,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(1), 0},
+	{0x0046,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(6), BIT(6)},
+	{0x0067,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(2), 0},
+	{0x0046,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(7), BIT(7)},
+	{0x0062,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(4), BIT(4)},
 	{0x0081,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_ALL_MSK,
@@ -1805,11 +1870,41 @@ static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8822b[] = {
 	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_SDIO_MSK,
 	 RTW_PWR_ADDR_MAC,
 	 RTW_PWR_CMD_WRITE, BIT(3) | BIT(4), BIT(3)},
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
 	{0x0090,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_PCI_MSK,
 	 RTW_PWR_ADDR_MAC,
 	 RTW_PWR_CMD_WRITE, BIT(1), 0},
+	{0x0044,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_SDIO,
+	 RTW_PWR_CMD_WRITE, 0xFF, 0},
+	{0x0040,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_SDIO,
+	 RTW_PWR_CMD_WRITE, 0xFF, 0x90},
+	{0x0041,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_SDIO,
+	 RTW_PWR_CMD_WRITE, 0xFF, 0x00},
+	{0x0042,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_SDIO,
+	 RTW_PWR_CMD_WRITE, 0xFF, 0x04},
 	{0xFFFF,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_ALL_MSK,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index fe995bb4e43e..5e4cc57dbd7c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -3563,6 +3563,16 @@ static void rtw8822c_pwr_track(struct rtw_dev *rtwdev)
 }
 
 static const struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8822c[] = {
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
 	{0x002E,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_ALL_MSK,
@@ -3773,6 +3783,11 @@ static const struct rtw_pwr_seq_cmd trans_act_to_cardemu_8822c[] = {
 };
 
 static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8822c[] = {
+	{0x0005,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_MAC,
+	 RTW_PWR_CMD_WRITE, BIT(7), BIT(7)},
 	{0x0007,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_SDIO_MSK,
@@ -3818,6 +3833,11 @@ static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8822c[] = {
 	 RTW_PWR_INTF_PCI_MSK,
 	 RTW_PWR_ADDR_MAC,
 	 RTW_PWR_CMD_WRITE, BIT(2), BIT(2)},
+	{0x0086,
+	 RTW_PWR_CUT_ALL_MSK,
+	 RTW_PWR_INTF_SDIO_MSK,
+	 RTW_PWR_ADDR_SDIO,
+	 RTW_PWR_CMD_WRITE, BIT(0), BIT(0)},
 	{0xFFFF,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_ALL_MSK,
-- 
2.17.1

