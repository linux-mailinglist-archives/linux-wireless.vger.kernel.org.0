Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C56219941
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2019 10:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfEJIDx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 May 2019 04:03:53 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59204 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfEJIDw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 May 2019 04:03:52 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x4A83dKV021573, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x4A83dKV021573
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Fri, 10 May 2019 16:03:39 +0800
Received: from localhost.localdomain (172.21.69.114) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.408.0; Fri, 10 May 2019 16:03:38 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <Larry.Finger@lwfinger.net>, <linux-wireless@vger.kernel.org>,
        <colin.king@canonical.com>
Subject: [PATCH 2/4] rtlwifi: 8192de: make tables to be 'static const'
Date:   Fri, 10 May 2019 16:03:31 +0800
Message-ID: <20190510080333.3789-3-pkshih@realtek.com>
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

This can reduce code size 264 bytes, and make code more readable.

         text	   data	    bss	    dec	    hex	filename
Before: 13586	      0	     16	  13602	   3522	rtl8192de/dm.o
After:  13322	      0	     16	  13338	   341a	rtl8192de/dm.o

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
index 6bbbd36cc664..cc9f01a19845 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
@@ -718,8 +718,8 @@ static void rtl92d_bandtype_5G(struct rtl_hal *rtlhal, u8 *ofdm_index,
 			       bool *internal_pa, u8 thermalvalue, u8 delta,
 			       u8 rf, struct rtl_efuse *rtlefuse,
 			       struct rtl_priv *rtlpriv, struct rtl_phy *rtlphy,
-			       u8 index_mapping[5][INDEX_MAPPING_NUM],
-			       u8 index_mapping_pa[8][INDEX_MAPPING_NUM])
+			       const u8 index_mapping[5][INDEX_MAPPING_NUM],
+			       const u8 index_mapping_pa[8][INDEX_MAPPING_NUM])
 {
 	int i;
 	u8 index;
@@ -797,7 +797,7 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 	u8 ofdm_min_index = 6, ofdm_min_index_internal_pa = 3, rf;
 	u8 indexforchannel =
 	    rtl92d_get_rightchnlplace_for_iqk(rtlphy->current_channel);
-	u8 index_mapping[5][INDEX_MAPPING_NUM] = {
+	static const u8 index_mapping[5][INDEX_MAPPING_NUM] = {
 		/* 5G, path A/MAC 0, decrease power  */
 		{0, 1, 3, 6, 8, 9,	11, 13, 14, 16, 17, 18, 18},
 		/* 5G, path A/MAC 0, increase power  */
@@ -809,7 +809,7 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 		/* 2.4G, for decreas power */
 		{0, 1, 2, 3, 4, 5,	6, 7, 7, 8, 9, 10, 10},
 	};
-	u8 index_mapping_internal_pa[8][INDEX_MAPPING_NUM] = {
+	static const u8 index_mapping_internal_pa[8][INDEX_MAPPING_NUM] = {
 		/* 5G, path A/MAC 0, ch36-64, decrease power  */
 		{0, 1, 2, 4, 6, 7,	9, 11, 12, 14, 15, 16, 16},
 		/* 5G, path A/MAC 0, ch36-64, increase power  */
-- 
2.21.0

