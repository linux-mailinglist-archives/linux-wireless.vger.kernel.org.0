Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20AB1DE2B7
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 11:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbgEVJNF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 05:13:05 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:35624 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729480AbgEVJNF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 05:13:05 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04M9CukjE026284, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04M9CukjE026284
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 22 May 2020 17:12:56 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 22 May 2020 17:12:55 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 22 May 2020 17:12:55 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH] rtw88: 8822c: remove CCK TX setting when switch channel
Date:   Fri, 22 May 2020 17:12:34 +0800
Message-ID: <20200522091234.24495-1-yhchuang@realtek.com>
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

From: Chien-Hsun Liao <ben.liao@realtek.com>

The CCK TX setting when switch channel will fix the CCK to
path A only, so if the antenna is configured to path B
(e.g. iw phy set antenna 0x2 0x3 "TX B/RX AB"), then the CCK
packets can never be delivered to the air if only path B is
connected with an antenna (it can possibly be transmitted
through path A, but as path B is configured, the expected
behavior is incorrect).

This can also solve the racing issue of CCK TX setting between
driver and firmware. The CCK TX setting in driver should be
removed. Otherwise, the CCK TX setting would be wrong when the
racing occurs.

Fixes: 297bcf8222f2 ("rtw88: add support for set/get antennas")
Signed-off-by: Chien-Hsun Liao <ben.liao@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 8d65a9684af3..c3d72ef611c6 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1496,7 +1496,6 @@ static void rtw8822c_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 {
 	if (IS_CH_2G_BAND(channel)) {
 		rtw_write32_clr(rtwdev, REG_BGCTRL, BITS_RX_IQ_WEIGHT);
-		rtw_write32_mask(rtwdev, REG_RXCCKSEL, 0xf0000000, 0x8);
 		rtw_write32_set(rtwdev, REG_TXF4, BIT(20));
 		rtw_write32_clr(rtwdev, REG_CCK_CHECK, BIT_CHECK_CCK_EN);
 		rtw_write32_clr(rtwdev, REG_CCKTXONLY, BIT_BB_CCK_CHECK_EN);
@@ -1564,7 +1563,6 @@ static void rtw8822c_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 		rtw_write32_set(rtwdev, REG_CCK_CHECK, BIT_CHECK_CCK_EN);
 		rtw_write32_set(rtwdev, REG_BGCTRL, BITS_RX_IQ_WEIGHT);
 		rtw_write32_clr(rtwdev, REG_TXF4, BIT(20));
-		rtw_write32_mask(rtwdev, REG_RXCCKSEL, 0xf0000000, 0x0);
 		rtw_write32_mask(rtwdev, REG_CCAMSK, 0x3F000000, 0x22);
 		rtw_write32_mask(rtwdev, REG_TXDFIR0, 0x70, 0x3);
 		if (IS_CH_5G_BAND_1(channel) || IS_CH_5G_BAND_2(channel)) {
-- 
2.17.1

