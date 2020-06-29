Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F1420D290
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2020 20:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgF2SuX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 14:50:23 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:34467 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbgF2SuW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 14:50:22 -0400
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 05T5o9Bw9011317, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 05T5o9Bw9011317
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
Subject: [PATCH V2 1/2] rtlwifi: Use const in 8188ee/8723be/8821ae swing_table declarations
Date:   Mon, 29 Jun 2020 13:49:34 +0800
Message-ID: <20200629054935.25107-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
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

From: Joe Perches <joe@perches.com>

Reduce data usage about 1KB by using const.

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
  v1 -> v2: no change
---
 .../wireless/realtek/rtlwifi/rtl8188ee/dm.c   |   4 +-
 .../wireless/realtek/rtlwifi/rtl8723be/dm.c   |   4 +-
 .../wireless/realtek/rtlwifi/rtl8821ae/dm.c   | 114 +++++++++---------
 3 files changed, 64 insertions(+), 58 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
index dceb04a9b3f5..1ffa188a65c9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
@@ -870,11 +870,11 @@ static void dm_txpower_track_cb_therm(struct ieee80211_hw *hw)
 	/*0.1 the following TWO tables decide the
 	 *final index of OFDM/CCK swing table
 	 */
-	s8 delta_swing_table_idx[2][15]  = {
+	static const s8 delta_swing_table_idx[2][15]  = {
 		{0, 0, 2, 3, 4, 4, 5, 6, 7, 7, 8, 9, 10, 10, 11},
 		{0, 0, -1, -2, -3, -4, -4, -4, -4, -5, -7, -8, -9, -9, -10}
 	};
-	u8 thermal_threshold[2][15] = {
+	static const u8 thermal_threshold[2][15] = {
 		{0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 27},
 		{0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 25, 25, 25}
 	};
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c
index b13fd3c0c832..c9b3d9d09c48 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c
@@ -736,11 +736,11 @@ static void rtl8723be_dm_txpower_tracking_callback_thermalmeter(
 	u8 ofdm_min_index = 6;
 	u8 index_for_channel = 0;
 
-	s8 delta_swing_table_idx_tup_a[TXSCALE_TABLE_SIZE] = {
+	static const s8 delta_swing_table_idx_tup_a[TXSCALE_TABLE_SIZE] = {
 		0, 0, 1, 2, 2, 2, 3, 3, 3, 4,  5,
 		5, 6, 6, 7, 7, 8, 8, 9, 9, 9, 10,
 		10, 11, 11, 12, 12, 13, 14, 15};
-	s8 delta_swing_table_idx_tdown_a[TXSCALE_TABLE_SIZE] = {
+	static const s8 delta_swing_table_idx_tdown_a[TXSCALE_TABLE_SIZE] = {
 		0, 0, 1, 2, 2, 2, 3, 3, 3, 4,  5,
 		5, 6, 6, 6, 6, 7, 7, 7, 8, 8,  9,
 		9, 10, 10, 11, 12, 13, 14, 15};
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
index f57e8794f0ec..e8fb9354cf19 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
@@ -115,47 +115,47 @@ static const u32 edca_setting_ul[PEER_MAX] = {
 	0x5ea44f,	/* 7 MARV */
 };
 
-static u8 rtl8818e_delta_swing_table_idx_24gb_p[] = {
+static const u8 rtl8818e_delta_swing_table_idx_24gb_p[] = {
 	0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 4, 4, 4,
 	4, 4, 4, 5, 5, 7, 7, 8, 8, 8, 9, 9, 9, 9, 9};
 
-static u8 rtl8818e_delta_swing_table_idx_24gb_n[] = {
+static const u8 rtl8818e_delta_swing_table_idx_24gb_n[] = {
 	0, 0, 0, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5, 6, 6,
 	7, 7, 7, 7, 8, 8, 9, 9, 10, 10, 10, 11, 11, 11, 11};
 
-static u8 rtl8812ae_delta_swing_table_idx_24gb_n[]  = {
+static const u8 rtl8812ae_delta_swing_table_idx_24gb_n[]  = {
 	0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 5, 6,
 	6, 6, 7, 8, 9, 9, 9, 9, 10, 10, 10, 10, 11, 11};
 
-static u8 rtl8812ae_delta_swing_table_idx_24gb_p[] = {
+static const u8 rtl8812ae_delta_swing_table_idx_24gb_p[] = {
 	0, 0, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 6,
 	6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 9, 9, 9};
 
-static u8 rtl8812ae_delta_swing_table_idx_24ga_n[] = {
+static const u8 rtl8812ae_delta_swing_table_idx_24ga_n[] = {
 	0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 5, 6,
 	6, 6, 7, 8, 8, 9, 9, 9, 10, 10, 10, 10, 11, 11};
 
-static u8 rtl8812ae_delta_swing_table_idx_24ga_p[] = {
+static const u8 rtl8812ae_delta_swing_table_idx_24ga_p[] = {
 	0, 0, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 6,
 	6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 9, 9, 9};
 
-static u8 rtl8812ae_delta_swing_table_idx_24gcckb_n[] = {
+static const u8 rtl8812ae_delta_swing_table_idx_24gcckb_n[] = {
 	0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 5, 6,
 	6, 6, 7, 8, 9, 9, 9, 9, 10, 10, 10, 10, 11, 11};
 
-static u8 rtl8812ae_delta_swing_table_idx_24gcckb_p[] = {
+static const u8 rtl8812ae_delta_swing_table_idx_24gcckb_p[] = {
 	0, 0, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 6,
 	6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 9, 9, 9};
 
-static u8 rtl8812ae_delta_swing_table_idx_24gccka_n[] = {
+static const u8 rtl8812ae_delta_swing_table_idx_24gccka_n[] = {
 	0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 5, 6,
 	6, 6, 7, 8, 8, 9, 9, 9, 10, 10, 10, 10, 11, 11};
 
-static u8 rtl8812ae_delta_swing_table_idx_24gccka_p[] = {
+static const u8 rtl8812ae_delta_swing_table_idx_24gccka_p[] = {
 	0, 0, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 6,
 	6, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 9, 9, 9};
 
-static u8 rtl8812ae_delta_swing_table_idx_5gb_n[][DEL_SW_IDX_SZ] = {
+static const u8 rtl8812ae_delta_swing_table_idx_5gb_n[][DEL_SW_IDX_SZ] = {
 	{0, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 6, 7, 7,
 	7, 8, 8, 9, 9, 9, 10, 10, 11, 11, 12, 12, 13},
 	{0, 1, 1, 2, 2, 2, 3, 3, 4, 4, 4, 5, 5, 6, 6, 7,
@@ -164,7 +164,7 @@ static u8 rtl8812ae_delta_swing_table_idx_5gb_n[][DEL_SW_IDX_SZ] = {
 	12, 12, 13, 14, 14, 14, 15, 16, 17, 17, 17, 18, 18, 18},
 };
 
-static u8 rtl8812ae_delta_swing_table_idx_5gb_p[][DEL_SW_IDX_SZ] = {
+static const u8 rtl8812ae_delta_swing_table_idx_5gb_p[][DEL_SW_IDX_SZ] = {
 	{0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8,
 	8, 9, 9, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11},
 	{0, 1, 1, 2, 2, 3, 3, 4, 4, 4, 5, 5, 6, 6, 7, 7, 8,
@@ -173,7 +173,7 @@ static u8 rtl8812ae_delta_swing_table_idx_5gb_p[][DEL_SW_IDX_SZ] = {
 	9, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11},
 };
 
-static u8 rtl8812ae_delta_swing_table_idx_5ga_n[][DEL_SW_IDX_SZ] = {
+static const u8 rtl8812ae_delta_swing_table_idx_5ga_n[][DEL_SW_IDX_SZ] = {
 	{0, 1, 1, 2, 2, 3, 3, 4, 4, 4, 5, 5, 6, 6, 7, 7, 8,
 	8, 9, 9, 10, 10, 11, 11, 12, 12, 12, 13, 13, 13},
 	{0, 1, 1, 2, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 8, 9,
@@ -182,7 +182,7 @@ static u8 rtl8812ae_delta_swing_table_idx_5ga_n[][DEL_SW_IDX_SZ] = {
 	12, 13, 14, 14, 15, 15, 15, 16, 16, 16, 17, 17, 18, 18},
 };
 
-static u8 rtl8812ae_delta_swing_table_idx_5ga_p[][DEL_SW_IDX_SZ] = {
+static const u8 rtl8812ae_delta_swing_table_idx_5ga_p[][DEL_SW_IDX_SZ] = {
 	{0, 1, 1, 2, 2, 3, 3, 4, 4, 4, 4, 5, 5, 6, 7, 7, 8,
 	8, 9, 9, 10, 10, 11, 11, 11, 11, 11, 11, 11, 11},
 	{0, 1, 1, 2, 2, 3, 3, 4, 4, 4, 5, 5, 6, 6, 7, 7, 8,
@@ -191,39 +191,39 @@ static u8 rtl8812ae_delta_swing_table_idx_5ga_p[][DEL_SW_IDX_SZ] = {
 	10, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11},
 };
 
-static u8 rtl8821ae_delta_swing_table_idx_24gb_n[] = {
+static const u8 rtl8821ae_delta_swing_table_idx_24gb_n[] = {
 	0, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6,
 	6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10};
 
-static u8 rtl8821ae_delta_swing_table_idx_24gb_p[]  = {
+static const u8 rtl8821ae_delta_swing_table_idx_24gb_p[]  = {
 	0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8,
 	8, 9, 9, 10, 10, 11, 11, 12, 12, 12, 12, 12, 12};
 
-static u8 rtl8821ae_delta_swing_table_idx_24ga_n[]  = {
+static const u8 rtl8821ae_delta_swing_table_idx_24ga_n[]  = {
 	0, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6,
 	6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10};
 
-static u8 rtl8821ae_delta_swing_table_idx_24ga_p[] = {
+static const u8 rtl8821ae_delta_swing_table_idx_24ga_p[] = {
 	0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8,
 	8, 9, 9, 10, 10, 11, 11, 12, 12, 12, 12, 12, 12};
 
-static u8 rtl8821ae_delta_swing_table_idx_24gcckb_n[] = {
+static const u8 rtl8821ae_delta_swing_table_idx_24gcckb_n[] = {
 	0, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6,
 	6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10};
 
-static u8 rtl8821ae_delta_swing_table_idx_24gcckb_p[] = {
+static const u8 rtl8821ae_delta_swing_table_idx_24gcckb_p[] = {
 	0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8,
 	8, 9, 9, 10, 10, 11, 11, 12, 12, 12, 12, 12, 12};
 
-static u8 rtl8821ae_delta_swing_table_idx_24gccka_n[] = {
+static const u8 rtl8821ae_delta_swing_table_idx_24gccka_n[] = {
 	0, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6,
 	6, 7, 7, 7, 8, 8, 8, 9, 9, 9, 10, 10, 10};
 
-static u8 rtl8821ae_delta_swing_table_idx_24gccka_p[] = {
+static const u8 rtl8821ae_delta_swing_table_idx_24gccka_p[] = {
 	0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8,
 	8, 9, 9, 10, 10, 11, 11, 12, 12, 12, 12, 12, 12};
 
-static u8 rtl8821ae_delta_swing_table_idx_5gb_n[][DEL_SW_IDX_SZ] = {
+static const u8 rtl8821ae_delta_swing_table_idx_5gb_n[][DEL_SW_IDX_SZ] = {
 	{0, 0, 1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11,
 	12, 12, 13, 14, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16},
 	{0, 0, 1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11,
@@ -232,7 +232,7 @@ static u8 rtl8821ae_delta_swing_table_idx_5gb_n[][DEL_SW_IDX_SZ] = {
 	12, 12, 13, 14, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16},
 };
 
-static u8 rtl8821ae_delta_swing_table_idx_5gb_p[][DEL_SW_IDX_SZ] = {
+static const u8 rtl8821ae_delta_swing_table_idx_5gb_p[][DEL_SW_IDX_SZ] = {
 	{0, 0, 1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11,
 	12, 12, 13, 14, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16},
 	{0, 0, 1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11,
@@ -241,7 +241,7 @@ static u8 rtl8821ae_delta_swing_table_idx_5gb_p[][DEL_SW_IDX_SZ] = {
 	12, 12, 13, 14, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16},
 };
 
-static u8 rtl8821ae_delta_swing_table_idx_5ga_n[][DEL_SW_IDX_SZ] = {
+static const u8 rtl8821ae_delta_swing_table_idx_5ga_n[][DEL_SW_IDX_SZ] = {
 	{0, 0, 1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11,
 	12, 12, 13, 14, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16},
 	{0, 0, 1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11,
@@ -250,7 +250,7 @@ static u8 rtl8821ae_delta_swing_table_idx_5ga_n[][DEL_SW_IDX_SZ] = {
 	12, 12, 13, 14, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16},
 };
 
-static u8 rtl8821ae_delta_swing_table_idx_5ga_p[][DEL_SW_IDX_SZ] = {
+static const u8 rtl8821ae_delta_swing_table_idx_5ga_p[][DEL_SW_IDX_SZ] = {
 	{0, 0, 1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11,
 	12, 12, 13, 14, 15, 15, 16, 16, 16, 16, 16, 16, 16, 16},
 	{0, 0, 1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11,
@@ -962,8 +962,10 @@ static void rtl8821ae_dm_iq_calibrate(struct ieee80211_hw *hw)
 }
 
 static void rtl8812ae_get_delta_swing_table(struct ieee80211_hw *hw,
-					    u8 **up_a, u8 **down_a,
-					    u8 **up_b, u8 **down_b)
+					    const u8 **up_a,
+					    const u8 **down_a,
+					    const u8 **up_b,
+					    const u8 **down_b)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
@@ -999,10 +1001,10 @@ static void rtl8812ae_get_delta_swing_table(struct ieee80211_hw *hw,
 		*up_b = rtl8812ae_delta_swing_table_idx_5gb_p[2];
 		*down_b = rtl8812ae_delta_swing_table_idx_5gb_n[2];
 	} else {
-	    *up_a = (u8 *)rtl8818e_delta_swing_table_idx_24gb_p;
-	    *down_a = (u8 *)rtl8818e_delta_swing_table_idx_24gb_n;
-	    *up_b = (u8 *)rtl8818e_delta_swing_table_idx_24gb_p;
-	    *down_b = (u8 *)rtl8818e_delta_swing_table_idx_24gb_n;
+		*up_a = rtl8818e_delta_swing_table_idx_24gb_p;
+		*down_a = rtl8818e_delta_swing_table_idx_24gb_n;
+		*up_b = rtl8818e_delta_swing_table_idx_24gb_p;
+		*down_b = rtl8818e_delta_swing_table_idx_24gb_n;
 	}
 }
 
@@ -1492,17 +1494,17 @@ void rtl8812ae_dm_txpower_tracking_callback_thermalmeter(
 	/* 1. The following TWO tables decide
 	 * the final index of OFDM/CCK swing table.
 	 */
-	u8 *delta_swing_table_idx_tup_a;
-	u8 *delta_swing_table_idx_tdown_a;
-	u8 *delta_swing_table_idx_tup_b;
-	u8 *delta_swing_table_idx_tdown_b;
+	const u8 *delta_swing_table_idx_tup_a;
+	const u8 *delta_swing_table_idx_tdown_a;
+	const u8 *delta_swing_table_idx_tup_b;
+	const u8 *delta_swing_table_idx_tdown_b;
 
 	/*2. Initilization ( 7 steps in total )*/
 	rtl8812ae_get_delta_swing_table(hw,
-		(u8 **)&delta_swing_table_idx_tup_a,
-		(u8 **)&delta_swing_table_idx_tdown_a,
-		(u8 **)&delta_swing_table_idx_tup_b,
-		(u8 **)&delta_swing_table_idx_tdown_b);
+		&delta_swing_table_idx_tup_a,
+		&delta_swing_table_idx_tdown_a,
+		&delta_swing_table_idx_tup_b,
+		&delta_swing_table_idx_tdown_b);
 
 	rtldm->txpower_trackinginit = true;
 
@@ -1830,8 +1832,11 @@ void rtl8812ae_dm_txpower_tracking_callback_thermalmeter(
 		 "<===rtl8812ae_dm_txpower_tracking_callback_thermalmeter\n");
 }
 
-static void rtl8821ae_get_delta_swing_table(struct ieee80211_hw *hw, u8 **up_a,
-					    u8 **down_a, u8 **up_b, u8 **down_b)
+static void rtl8821ae_get_delta_swing_table(struct ieee80211_hw *hw,
+					    const u8 **up_a,
+					    const u8 **down_a,
+					    const u8 **up_b,
+					    const u8 **down_b)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
@@ -1867,10 +1872,10 @@ static void rtl8821ae_get_delta_swing_table(struct ieee80211_hw *hw, u8 **up_a,
 		*up_b = rtl8821ae_delta_swing_table_idx_5gb_p[2];
 		*down_b = rtl8821ae_delta_swing_table_idx_5gb_n[2];
 	} else {
-	    *up_a = (u8 *)rtl8818e_delta_swing_table_idx_24gb_p;
-	    *down_a = (u8 *)rtl8818e_delta_swing_table_idx_24gb_n;
-	    *up_b = (u8 *)rtl8818e_delta_swing_table_idx_24gb_p;
-	    *down_b = (u8 *)rtl8818e_delta_swing_table_idx_24gb_n;
+		*up_a = rtl8818e_delta_swing_table_idx_24gb_p;
+		*down_a = rtl8818e_delta_swing_table_idx_24gb_n;
+		*up_b = rtl8818e_delta_swing_table_idx_24gb_p;
+		*down_b = rtl8818e_delta_swing_table_idx_24gb_n;
 	}
 	return;
 }
@@ -2075,16 +2080,17 @@ void rtl8821ae_dm_txpower_tracking_callback_thermalmeter(
 	/* 1. The following TWO tables decide the final
 	 * index of OFDM/CCK swing table.
 	 */
-	u8 *delta_swing_table_idx_tup_a;
-	u8 *delta_swing_table_idx_tdown_a;
-	u8 *delta_swing_table_idx_tup_b;
-	u8 *delta_swing_table_idx_tdown_b;
+	const u8 *delta_swing_table_idx_tup_a;
+	const u8 *delta_swing_table_idx_tdown_a;
+	const u8 *delta_swing_table_idx_tup_b;
+	const u8 *delta_swing_table_idx_tdown_b;
 
 	/*2. Initilization ( 7 steps in total )*/
-	rtl8821ae_get_delta_swing_table(hw, (u8 **)&delta_swing_table_idx_tup_a,
-					(u8 **)&delta_swing_table_idx_tdown_a,
-					(u8 **)&delta_swing_table_idx_tup_b,
-					(u8 **)&delta_swing_table_idx_tdown_b);
+	rtl8821ae_get_delta_swing_table(hw,
+					&delta_swing_table_idx_tup_a,
+					&delta_swing_table_idx_tdown_a,
+					&delta_swing_table_idx_tup_b,
+					&delta_swing_table_idx_tdown_b);
 
 	rtldm->txpower_trackinginit = true;
 
-- 
2.21.0

