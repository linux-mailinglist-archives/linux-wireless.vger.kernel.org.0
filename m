Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620291D56FE
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2020 19:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgEORDz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 May 2020 13:03:55 -0400
Received: from 220-134-220-36.HINET-IP.hinet.net ([220.134.220.36]:52599 "EHLO
        ns.kevlo.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgEORDz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 May 2020 13:03:55 -0400
Received: from ns.kevlo.org (localhost [127.0.0.1])
        by ns.kevlo.org (8.15.2/8.15.2) with ESMTPS id 04F6Bti6015739
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 15 May 2020 14:11:55 +0800 (CST)
        (envelope-from kevlo@ns.kevlo.org)
Received: (from kevlo@localhost)
        by ns.kevlo.org (8.15.2/8.15.2/Submit) id 04F6Bt6C015738;
        Fri, 15 May 2020 14:11:55 +0800 (CST)
        (envelope-from kevlo)
Date:   Fri, 15 May 2020 14:11:53 +0800
From:   Kevin Lo <kevlo@kevlo.org>
To:     linux-wireless@vger.kernel.org
Cc:     Yan-Hsuan Chuang <yhchuang@realtek.com>
Subject: [PATCH] rtw88: no need to set registers for SDIO
Message-ID: <20200515061153.GA15714@ns.kevlo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There's no need to set SDIO related registers when powering up/down the chip.

Signed-off-by: Kevin Lo <kevlo@kevlo.org>
---
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index b517af417e0e..5e0b7999bc8a 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2092,16 +2092,6 @@ static const struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8723d[] = {
 	 RTW_PWR_INTF_ALL_MSK,
 	 RTW_PWR_ADDR_MAC,
 	 RTW_PWR_CMD_WRITE, BIT(3) | BIT(7), 0},
-	{0x0086,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_SDIO,
-	 RTW_PWR_CMD_WRITE, BIT(0), 0},
-	{0x0086,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_SDIO,
-	 RTW_PWR_CMD_POLLING, BIT(1), BIT(1)},
 	{0x004A,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_USB_MSK,
@@ -2112,11 +2102,6 @@ static const struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8723d[] = {
 	 RTW_PWR_INTF_ALL_MSK,
 	 RTW_PWR_ADDR_MAC,
 	 RTW_PWR_CMD_WRITE, BIT(3) | BIT(4), 0},
-	{0x0023,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_MAC,
-	 RTW_PWR_CMD_WRITE, BIT(4), 0},
 	{0x0301,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_PCI_MSK,
@@ -2324,11 +2309,6 @@ static const struct rtw_pwr_seq_cmd trans_act_to_lps_8723d[] = {
 	 RTW_PWR_INTF_ALL_MSK,
 	 RTW_PWR_ADDR_MAC,
 	 RTW_PWR_CMD_WRITE, BIT(1), 0},
-	{0x0093,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_MAC,
-	 RTW_PWR_CMD_WRITE, 0xFF, 0x00},
 	{0x0553,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_ALL_MSK,
@@ -2408,11 +2388,6 @@ static const struct rtw_pwr_seq_cmd trans_act_to_cardemu_8723d[] = {
 };
 
 static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8723d[] = {
-	{0x0007,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_MAC,
-	 RTW_PWR_CMD_WRITE, 0xFF, 0x20},
 	{0x0005,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_SDIO_MSK,
@@ -2433,21 +2408,6 @@ static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8723d[] = {
 	 RTW_PWR_INTF_USB_MSK,
 	 RTW_PWR_ADDR_MAC,
 	 RTW_PWR_CMD_WRITE, BIT(0), 1},
-	{0x0023,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_MAC,
-	 RTW_PWR_CMD_WRITE, BIT(4), BIT(4)},
-	{0x0086,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_SDIO,
-	 RTW_PWR_CMD_WRITE, BIT(0), BIT(0)},
-	{0x0086,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_SDIO,
-	 RTW_PWR_CMD_POLLING, BIT(1), 0},
 	{0xFFFF,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_ALL_MSK,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 18c5a5a96d90..e0d911bbe534 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -1550,16 +1550,6 @@ static void rtw8822b_bf_config_bfee(struct rtw_dev *rtwdev, struct rtw_vif *vif,
 }
 
 static const struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8822b[] = {
-	{0x0086,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_SDIO,
-	 RTW_PWR_CMD_WRITE, BIT(0), 0},
-	{0x0086,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_SDIO,
-	 RTW_PWR_CMD_POLLING, BIT(1), BIT(1)},
 	{0x004A,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_USB_MSK,
@@ -1688,11 +1678,6 @@ static const struct rtw_pwr_seq_cmd trans_cardemu_to_act_8822b[] = {
 	 RTW_PWR_INTF_ALL_MSK,
 	 RTW_PWR_ADDR_MAC,
 	 RTW_PWR_CMD_WRITE, 0xFF, 0x0c},
-	{0x0068,
-	 RTW_PWR_CUT_C_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_MAC,
-	 RTW_PWR_CMD_WRITE, BIT(4), BIT(4)},
 	{0x0029,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_ALL_MSK,
@@ -1721,11 +1706,6 @@ static const struct rtw_pwr_seq_cmd trans_cardemu_to_act_8822b[] = {
 };
 
 static const struct rtw_pwr_seq_cmd trans_act_to_cardemu_8822b[] = {
-	{0x0003,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_MAC,
-	 RTW_PWR_CMD_WRITE, BIT(2), 0},
 	{0x0093,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_ALL_MSK,
@@ -1794,11 +1774,6 @@ static const struct rtw_pwr_seq_cmd trans_act_to_cardemu_8822b[] = {
 };
 
 static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8822b[] = {
-	{0x0005,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_MAC,
-	 RTW_PWR_CMD_WRITE, BIT(7), BIT(7)},
 	{0x0007,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_SDIO_MSK,
@@ -1819,46 +1794,6 @@ static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8822b[] = {
 	 RTW_PWR_INTF_USB_MSK,
 	 RTW_PWR_ADDR_MAC,
 	 RTW_PWR_CMD_WRITE, BIT(0), 0},
-	{0x0067,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_MAC,
-	 RTW_PWR_CMD_WRITE, BIT(5), 0},
-	{0x0067,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_MAC,
-	 RTW_PWR_CMD_WRITE, BIT(4), 0},
-	{0x004F,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_MAC,
-	 RTW_PWR_CMD_WRITE, BIT(0), 0},
-	{0x0067,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_MAC,
-	 RTW_PWR_CMD_WRITE, BIT(1), 0},
-	{0x0046,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_MAC,
-	 RTW_PWR_CMD_WRITE, BIT(6), BIT(6)},
-	{0x0067,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_MAC,
-	 RTW_PWR_CMD_WRITE, BIT(2), 0},
-	{0x0046,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_MAC,
-	 RTW_PWR_CMD_WRITE, BIT(7), BIT(7)},
-	{0x0062,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_MAC,
-	 RTW_PWR_CMD_WRITE, BIT(4), BIT(4)},
 	{0x0081,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_ALL_MSK,
@@ -1869,41 +1804,11 @@ static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8822b[] = {
 	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_SDIO_MSK,
 	 RTW_PWR_ADDR_MAC,
 	 RTW_PWR_CMD_WRITE, BIT(3) | BIT(4), BIT(3)},
-	{0x0086,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_SDIO,
-	 RTW_PWR_CMD_WRITE, BIT(0), BIT(0)},
-	{0x0086,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_SDIO,
-	 RTW_PWR_CMD_POLLING, BIT(1), 0},
 	{0x0090,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_PCI_MSK,
 	 RTW_PWR_ADDR_MAC,
 	 RTW_PWR_CMD_WRITE, BIT(1), 0},
-	{0x0044,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_SDIO,
-	 RTW_PWR_CMD_WRITE, 0xFF, 0},
-	{0x0040,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_SDIO,
-	 RTW_PWR_CMD_WRITE, 0xFF, 0x90},
-	{0x0041,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_SDIO,
-	 RTW_PWR_CMD_WRITE, 0xFF, 0x00},
-	{0x0042,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_SDIO,
-	 RTW_PWR_CMD_WRITE, 0xFF, 0x04},
 	{0xFFFF,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_ALL_MSK,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index d697d70170af..4cb85502d8ad 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -3562,16 +3562,6 @@ static void rtw8822c_pwr_track(struct rtw_dev *rtwdev)
 }
 
 static const struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8822c[] = {
-	{0x0086,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_SDIO,
-	 RTW_PWR_CMD_WRITE, BIT(0), 0},
-	{0x0086,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_SDIO,
-	 RTW_PWR_CMD_POLLING, BIT(1), BIT(1)},
 	{0x002E,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_ALL_MSK,
@@ -3782,11 +3772,6 @@ static const struct rtw_pwr_seq_cmd trans_act_to_cardemu_8822c[] = {
 };
 
 static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8822c[] = {
-	{0x0005,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_MAC,
-	 RTW_PWR_CMD_WRITE, BIT(7), BIT(7)},
 	{0x0007,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_USB_MSK | RTW_PWR_INTF_SDIO_MSK,
@@ -3832,11 +3817,6 @@ static const struct rtw_pwr_seq_cmd trans_cardemu_to_carddis_8822c[] = {
 	 RTW_PWR_INTF_PCI_MSK,
 	 RTW_PWR_ADDR_MAC,
 	 RTW_PWR_CMD_WRITE, BIT(2), BIT(2)},
-	{0x0086,
-	 RTW_PWR_CUT_ALL_MSK,
-	 RTW_PWR_INTF_SDIO_MSK,
-	 RTW_PWR_ADDR_SDIO,
-	 RTW_PWR_CMD_WRITE, BIT(0), BIT(0)},
 	{0xFFFF,
 	 RTW_PWR_CUT_ALL_MSK,
 	 RTW_PWR_INTF_ALL_MSK,
