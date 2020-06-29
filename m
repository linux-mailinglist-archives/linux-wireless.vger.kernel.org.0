Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57C320CC24
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2020 05:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgF2DaZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Jun 2020 23:30:25 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:35888 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgF2DaZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Jun 2020 23:30:25 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 05T3UD550000897, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 05T3UD550000897
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Jun 2020 11:30:13 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 29 Jun 2020 11:30:12 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 29 Jun 2020 11:30:12 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <joe@perches.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] rtlwifi: 8821ae: remove unused path B parameters from swing table
Date:   Mon, 29 Jun 2020 11:29:37 +0800
Message-ID: <20200629032937.17374-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200629032937.17374-1-pkshih@realtek.com>
References: <20200629032937.17374-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

8821AE is a 1x1 chip, so swing parameters for path B aren't necessary.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../wireless/realtek/rtlwifi/rtl8821ae/dm.c   | 22 ++-----------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
index e8fb9354cf19..194d56a98ef2 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
@@ -1834,9 +1834,7 @@ void rtl8812ae_dm_txpower_tracking_callback_thermalmeter(
 
 static void rtl8821ae_get_delta_swing_table(struct ieee80211_hw *hw,
 					    const u8 **up_a,
-					    const u8 **down_a,
-					    const u8 **up_b,
-					    const u8 **down_b)
+					    const u8 **down_a)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
@@ -1848,34 +1846,22 @@ static void rtl8821ae_get_delta_swing_table(struct ieee80211_hw *hw,
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
@@ -2082,15 +2068,11 @@ void rtl8821ae_dm_txpower_tracking_callback_thermalmeter(
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

