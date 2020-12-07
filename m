Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3754E2D095A
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Dec 2020 04:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgLGDUU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 22:20:20 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:59288 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgLGDUU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 22:20:20 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0B73JBfZ4030816, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0B73JBfZ4030816
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 7 Dec 2020 11:19:11 +0800
Received: from localhost (172.21.69.213) by RTEXMB04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Mon, 7 Dec 2020
 11:19:11 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <Larry.Finger@lwfinger.net>, <linux-wireless@vger.kernel.org>,
        <dan.carpenter@oracle.com>
Subject: [PATCH] rtlwifi: rtl8192de: fix ofdm power compensation
Date:   Mon, 7 Dec 2020 11:19:03 +0800
Message-ID: <20201207031903.7599-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXH365.realtek.com.tw (172.21.6.37) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ofdm_index[] is used to indicate how many power compensation is needed to
current thermal value. For internal PA module or 2.4G band, the min_index
is different from other cases.

This issue originally is reported by Dan. He found the size of ofdm_index[]
is 2, but access index 'i' may be equal to 2 if 'rf' is 2 in case of
'is2t'.

In fact, the chunk of code is added to wrong place, so move it back to
proper place, and then power compensation and buffer overflow are fixed.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
index b3f25a228532..6cc9c7649eda 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
@@ -986,18 +986,19 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 			rtlpriv->dm.cck_index);
 	}
 	for (i = 0; i < rf; i++) {
-		if (ofdm_index[i] > OFDM_TABLE_SIZE_92D - 1)
+		if (ofdm_index[i] > OFDM_TABLE_SIZE_92D - 1) {
 			ofdm_index[i] = OFDM_TABLE_SIZE_92D - 1;
-		else if (ofdm_index[i] < ofdm_min_index)
+		} else if (internal_pa ||
+			   rtlhal->current_bandtype == BAND_ON_2_4G) {
+			if (ofdm_index[i] < ofdm_min_index_internal_pa)
+				ofdm_index[i] = ofdm_min_index_internal_pa;
+		} else if (ofdm_index[i] < ofdm_min_index) {
 			ofdm_index[i] = ofdm_min_index;
+		}
 	}
 	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
 		if (cck_index > CCK_TABLE_SIZE - 1) {
 			cck_index = CCK_TABLE_SIZE - 1;
-		} else if (internal_pa ||
-			   rtlhal->current_bandtype == BAND_ON_2_4G) {
-			if (ofdm_index[i] < ofdm_min_index_internal_pa)
-				ofdm_index[i] = ofdm_min_index_internal_pa;
 		} else if (cck_index < 0) {
 			cck_index = 0;
 		}
-- 
2.21.0

