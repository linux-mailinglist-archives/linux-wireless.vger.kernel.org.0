Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D493720D28D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2020 20:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgF2SuU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 14:50:20 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:34467 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbgF2SuS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 14:50:18 -0400
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 05T5oABx9011317, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 05T5oABx9011317
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Jun 2020 13:50:10 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 29 Jun 2020 13:50:09 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 29 Jun 2020 13:50:09 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <joe@perches.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH V2 2/2] rtlwifi: 8821ae: remove unused path B parameters from swing table
Date:   Mon, 29 Jun 2020 13:49:35 +0800
Message-ID: <20200629054935.25107-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200629054935.25107-1-pkshih@realtek.com>
References: <20200629054935.25107-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

8821AE is a 1x1 chip, so swing parameters for path B aren't necessary.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 v1 -> v2: remove unused arrays
---
 .../wireless/realtek/rtlwifi/rtl8821ae/dm.c   | 56 +------------------
 1 file changed, 2 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
index e8fb9354cf19..97a30ccf0b27 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
@@ -191,14 +191,6 @@ static const u8 rtl8812ae_delta_swing_table_idx_5ga_p[][DEL_SW_IDX_SZ] = {
 	10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11},
 };
 
-static const u8 rtl8821ae_delta_swing_table_idx_24gb_n[] = {
-	0, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6,
-	6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10};
-
-static const u8 rtl8821ae_delta_swing_table_idx_24gb_p[]  = {
-	0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8,
-	8, 9, 9, 10, 10, 11, 11, 12, 12, 12, 12, 12, 12};
-
 static const u8 rtl8821ae_delta_swing_table_idx_24ga_n[]  = {
 	0, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6,
 	6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10};
@@ -207,14 +199,6 @@ static const u8 rtl8821ae_delta_swing_table_idx_24ga_p[] = {
 	0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8,
 	8, 9, 9, 10, 10, 11, 11, 12, 12, 12, 12, 12, 12};
 
-static const u8 rtl8821ae_delta_swing_table_idx_24gcckb_n[] = {
-	0, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6,
-	6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10};
-
-static const u8 rtl8821ae_delta_swing_table_idx_24gcckb_p[] = {
-	0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8,
-	8, 9, 9, 10, 10, 11, 11, 12, 12, 12, 12, 12, 12};
-
 static const u8 rtl8821ae_delta_swing_table_idx_24gccka_n[] = {
 	0, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6,
 	6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10};
@@ -223,24 +207,6 @@ static const u8 rtl8821ae_delta_swing_table_idx_24gccka_p[] = {
 	0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8,
 	8, 9, 9, 10, 10, 11, 11, 12, 12, 12, 12, 12, 12};
 
-static const u8 rtl8821ae_delta_swing_table_idx_5gb_n[][DEL_SW_IDX_SZ] = {
-	{0, 0, 1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11,
-	12, 12, 13, 14, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16},
-	{0, 0, 1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11,
-	12, 12, 13, 14, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16},
-	{0, 0, 1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11,
-	12, 12, 13, 14, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16},
-};
-
-static const u8 rtl8821ae_delta_swing_table_idx_5gb_p[][DEL_SW_IDX_SZ] = {
-	{0, 0, 1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11,
-	12, 12, 13, 14, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16},
-	{0, 0, 1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11,
-	12, 12, 13, 14, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16},
-	{0, 0, 1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11,
-	12, 12, 13, 14, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16},
-};
-
 static const u8 rtl8821ae_delta_swing_table_idx_5ga_n[][DEL_SW_IDX_SZ] = {
 	{0, 0, 1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11,
 	12, 12, 13, 14, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16},
@@ -1834,9 +1800,7 @@ void rtl8812ae_dm_txpower_tracking_callback_thermalmeter(
 
 static void rtl8821ae_get_delta_swing_table(struct ieee80211_hw *hw,
 					    const u8 **up_a,
-					    const u8 **down_a,
-					    const u8 **up_b,
-					    const u8 **down_b)
+					    const u8 **down_a)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
@@ -1848,34 +1812,22 @@ static void rtl8821ae_get_delta_swing_table(struct ieee80211_hw *hw,
 		if (RTL8821AE_RX_HAL_IS_CCK_RATE(rate)) {
 			*up_a = rtl8821ae_delta_swing_table_idx_24gccka_p;
 			*down_a = rtl8821ae_delta_swing_table_idx_24gccka_n;
-			*up_b = rtl8821ae_delta_swing_table_idx_24gcckb_p;
-			*down_b = rtl8821ae_delta_swing_table_idx_24gcckb_n;
 		} else {
 			*up_a = rtl8821ae_delta_swing_table_idx_24ga_p;
 			*down_a = rtl8821ae_delta_swing_table_idx_24ga_n;
-			*up_b = rtl8821ae_delta_swing_table_idx_24gb_p;
-			*down_b = rtl8821ae_delta_swing_table_idx_24gb_n;
 		}
 	} else if (36 <= channel && channel <= 64) {
 		*up_a = rtl8821ae_delta_swing_table_idx_5ga_p[0];
 		*down_a = rtl8821ae_delta_swing_table_idx_5ga_n[0];
-		*up_b = rtl8821ae_delta_swing_table_idx_5gb_p[0];
-		*down_b = rtl8821ae_delta_swing_table_idx_5gb_n[0];
 	} else if (100 <= channel && channel <= 140) {
 		*up_a = rtl8821ae_delta_swing_table_idx_5ga_p[1];
 		*down_a = rtl8821ae_delta_swing_table_idx_5ga_n[1];
-		*up_b = rtl8821ae_delta_swing_table_idx_5gb_p[1];
-		*down_b = rtl8821ae_delta_swing_table_idx_5gb_n[1];
 	} else if (149 <= channel && channel <= 173) {
 		*up_a = rtl8821ae_delta_swing_table_idx_5ga_p[2];
 		*down_a = rtl8821ae_delta_swing_table_idx_5ga_n[2];
-		*up_b = rtl8821ae_delta_swing_table_idx_5gb_p[2];
-		*down_b = rtl8821ae_delta_swing_table_idx_5gb_n[2];
 	} else {
 		*up_a = rtl8818e_delta_swing_table_idx_24gb_p;
 		*down_a = rtl8818e_delta_swing_table_idx_24gb_n;
-		*up_b = rtl8818e_delta_swing_table_idx_24gb_p;
-		*down_b = rtl8818e_delta_swing_table_idx_24gb_n;
 	}
 	return;
 }
@@ -2082,15 +2034,11 @@ void rtl8821ae_dm_txpower_tracking_callback_thermalmeter(
 	 */
 	const u8 *delta_swing_table_idx_tup_a;
 	const u8 *delta_swing_table_idx_tdown_a;
-	const u8 *delta_swing_table_idx_tup_b;
-	const u8 *delta_swing_table_idx_tdown_b;
 
 	/*2. Initilization ( 7 steps in total )*/
 	rtl8821ae_get_delta_swing_table(hw,
 					&delta_swing_table_idx_tup_a,
-					&delta_swing_table_idx_tdown_a,
-					&delta_swing_table_idx_tup_b,
-					&delta_swing_table_idx_tdown_b);
+					&delta_swing_table_idx_tdown_a);
 
 	rtldm->txpower_trackinginit = true;
 
-- 
2.21.0

