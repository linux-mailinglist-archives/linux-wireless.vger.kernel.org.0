Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0808719940
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2019 10:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfEJIDw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 May 2019 04:03:52 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59200 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbfEJIDw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 May 2019 04:03:52 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x4A83d2V021577, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x4A83d2V021577
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Fri, 10 May 2019 16:03:39 +0800
Received: from localhost.localdomain (172.21.69.114) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.408.0; Fri, 10 May 2019 16:03:39 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <Larry.Finger@lwfinger.net>, <linux-wireless@vger.kernel.org>,
        <colin.king@canonical.com>
Subject: [PATCH 3/4] rtlwifi: 8192de: Fix used uninitialized variables in power tracking
Date:   Fri, 10 May 2019 16:03:32 +0800
Message-ID: <20190510080333.3789-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190510080333.3789-1-pkshih@realtek.com>
References: <20190510080333.3789-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.114]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

ofdm_index_old[] is the index of ofdmswing_table[], and used to indicate
initial value of ROFDM0_X{A,B}TXIQIMBALANCE in rtl8192de_phy_reg_2tarray[]
table, and the initial value is corresponding to calibration thermal value
written in efuse, namely rtlefuse->eeprom_thermalmeter. Then, local
variable ofdm_index_old[] save to rtlpriv->dm.ofdm_index[] for operational
use.

If thermal value (temperature) is increasing, output TX power is lower.
So, we calculate the delta between current and calibration thermal value,
then add power to yield expected and the same output TX power.

Thus, ofdm_index[] should be initialized as rtlpriv->dm.ofdm_index[], and
shift to proper index depends on delta of thermal value. Then, new power
value ofdmswing_table[ofdm_index[]] is written to register.

Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
index cc9f01a19845..df02cb6e5e91 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
@@ -787,9 +787,9 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 	bool internal_pa = false;
 	long ele_a = 0, ele_d, temp_cck, val_x, value32;
 	long val_y, ele_c = 0;
-	u8 ofdm_index[3];
+	u8 ofdm_index[2];
 	s8 cck_index = 0;
-	u8 ofdm_index_old[3] = {0, 0, 0};
+	u8 ofdm_index_old[2] = {0, 0};
 	s8 cck_index_old = 0;
 	u8 index;
 	int i;
@@ -846,6 +846,9 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 	else
 		rf = 1;
 
+	if (rtlpriv->dm.thermalvalue && !rtlhal->reloadtxpowerindex)
+		goto old_index_done;
+
 	ele_d = rtl_get_bbreg(hw, ROFDM0_XATXIQIMBALANCE,  MASKDWORD) & MASKOFDM_D;
 	for (i = 0; i < OFDM_TABLE_SIZE_92D; i++) {
 		if (ele_d == (ofdmswing_table[i] & MASKOFDM_D)) {
@@ -897,6 +900,10 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 			 "reload ofdm index for band switch\n");
 	}
+old_index_done:
+	for (i = 0; i < rf; i++)
+		ofdm_index[i] = rtlpriv->dm.ofdm_index[i];
+
 	rtlpriv->dm.thermalvalue_avg
 		    [rtlpriv->dm.thermalvalue_avg_index] = thermalvalue;
 	rtlpriv->dm.thermalvalue_avg_index++;
-- 
2.21.0

