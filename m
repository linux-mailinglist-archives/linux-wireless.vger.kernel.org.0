Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47FE219944
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2019 10:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfEJIDw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 May 2019 04:03:52 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59203 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfEJIDw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 May 2019 04:03:52 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x4A83ePW021581, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x4A83ePW021581
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Fri, 10 May 2019 16:03:40 +0800
Received: from localhost.localdomain (172.21.69.114) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.408.0; Fri, 10 May 2019 16:03:40 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <Larry.Finger@lwfinger.net>, <linux-wireless@vger.kernel.org>,
        <colin.king@canonical.com>
Subject: [PATCH 4/4] rtlwifi: 8192de: use le32 to access cckswing tables
Date:   Fri, 10 May 2019 16:03:33 +0800
Message-ID: <20190510080333.3789-5-pkshih@realtek.com>
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

The cckswing tables cckswing_table_ch1ch13 and cckswing_table_ch14 are
u8 array in little-endian order. To compare four u8 value with register
u32 value, cast the value to cpu order.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../wireless/realtek/rtlwifi/rtl8192de/dm.c   | 36 ++++++++-----------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
index df02cb6e5e91..71f3b6b5d7bd 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
@@ -680,6 +680,7 @@ static void rtl92d_bandtype_2_4G(struct ieee80211_hw *hw, long *temp_cckg,
 	int i;
 	unsigned long flag = 0;
 	long temp_cck;
+	const u8 *cckswing;
 
 	/* Query CCK default setting From 0xa24 */
 	rtl92d_acquire_cckandrw_pagea_ctl(hw, &flag);
@@ -687,28 +688,19 @@ static void rtl92d_bandtype_2_4G(struct ieee80211_hw *hw, long *temp_cckg,
 				 MASKDWORD) & MASKCCK;
 	rtl92d_release_cckandrw_pagea_ctl(hw, &flag);
 	for (i = 0; i < CCK_TABLE_LENGTH; i++) {
-		if (rtlpriv->dm.cck_inch14) {
-			if (!memcmp((void *)&temp_cck,
-			    (void *)&cckswing_table_ch14[i][2], 4)) {
-				*cck_index_old = (u8) i;
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-					 "Initial reg0x%x = 0x%lx, cck_index=0x%x, ch 14 %d\n",
-					 RCCK0_TXFILTER2, temp_cck,
-					 *cck_index_old,
-					 rtlpriv->dm.cck_inch14);
-				break;
-			}
-		} else {
-			if (!memcmp((void *) &temp_cck,
-			    &cckswing_table_ch1ch13[i][2], 4)) {
-				*cck_index_old = (u8) i;
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-					 "Initial reg0x%x = 0x%lx, cck_index = 0x%x, ch14 %d\n",
-					 RCCK0_TXFILTER2, temp_cck,
-					 *cck_index_old,
-					 rtlpriv->dm.cck_inch14);
-				break;
-			}
+		if (rtlpriv->dm.cck_inch14)
+			cckswing = &cckswing_table_ch14[i][2];
+		else
+			cckswing = &cckswing_table_ch1ch13[i][2];
+
+		if (temp_cck == le32_to_cpu(*((__le32 *)cckswing))) {
+			*cck_index_old = (u8)i;
+			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				 "Initial reg0x%x = 0x%lx, cck_index = 0x%x, ch14 %d\n",
+				 RCCK0_TXFILTER2, temp_cck,
+				 *cck_index_old,
+				 rtlpriv->dm.cck_inch14);
+			break;
 		}
 	}
 	*temp_cckg = temp_cck;
-- 
2.21.0

