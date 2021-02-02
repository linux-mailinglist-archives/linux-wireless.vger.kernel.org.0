Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0EF30B76F
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Feb 2021 06:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhBBFwI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Feb 2021 00:52:08 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:33933 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhBBFwF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Feb 2021 00:52:05 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1125pFEB1018643, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 1125pFEB1018643
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 2 Feb 2021 13:51:15 +0800
Received: from localhost (172.21.236.51) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 2 Feb 2021
 13:51:15 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/3] rtw88: coex: 8821c: correct antenna switch function
Date:   Tue, 2 Feb 2021 13:50:10 +0800
Message-ID: <20210202055012.8296-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210202055012.8296-1-pkshih@realtek.com>
References: <20210202055012.8296-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.236.51]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Guo-Feng Fan <vincent_fann@realtek.com>

This patch fixes a defect that uses incorrect function to access
registers. Use 8 and 32 bit access function to access 8 and 32 bit long
data respectively.

Signed-off-by: Guo-Feng Fan <vincent_fann@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 74155c999ebb..8f53afb67870 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -719,8 +719,8 @@ static void rtw8821c_coex_cfg_ant_switch(struct rtw_dev *rtwdev, u8 ctrl_type,
 			regval = (!polarity_inverse ? 0x1 : 0x2);
 		}
 
-		rtw_write8_mask(rtwdev, REG_RFE_CTRL8, BIT_MASK_R_RFE_SEL_15,
-				regval);
+		rtw_write32_mask(rtwdev, REG_RFE_CTRL8, BIT_MASK_R_RFE_SEL_15,
+				 regval);
 		break;
 	case COEX_SWITCH_CTRL_BY_PTA:
 		rtw_write32_clr(rtwdev, REG_LED_CFG, BIT_DPDT_SEL_EN);
@@ -730,8 +730,8 @@ static void rtw8821c_coex_cfg_ant_switch(struct rtw_dev *rtwdev, u8 ctrl_type,
 				PTA_CTRL_PIN);
 
 		regval = (!polarity_inverse ? 0x2 : 0x1);
-		rtw_write8_mask(rtwdev, REG_RFE_CTRL8, BIT_MASK_R_RFE_SEL_15,
-				regval);
+		rtw_write32_mask(rtwdev, REG_RFE_CTRL8, BIT_MASK_R_RFE_SEL_15,
+				 regval);
 		break;
 	case COEX_SWITCH_CTRL_BY_ANTDIV:
 		rtw_write32_clr(rtwdev, REG_LED_CFG, BIT_DPDT_SEL_EN);
@@ -757,11 +757,11 @@ static void rtw8821c_coex_cfg_ant_switch(struct rtw_dev *rtwdev, u8 ctrl_type,
 	}
 
 	if (ctrl_type == COEX_SWITCH_CTRL_BY_BT) {
-		rtw_write32_clr(rtwdev, REG_CTRL_TYPE, BIT_CTRL_TYPE1);
-		rtw_write32_clr(rtwdev, REG_CTRL_TYPE, BIT_CTRL_TYPE2);
+		rtw_write8_clr(rtwdev, REG_CTRL_TYPE, BIT_CTRL_TYPE1);
+		rtw_write8_clr(rtwdev, REG_CTRL_TYPE, BIT_CTRL_TYPE2);
 	} else {
-		rtw_write32_set(rtwdev, REG_CTRL_TYPE, BIT_CTRL_TYPE1);
-		rtw_write32_set(rtwdev, REG_CTRL_TYPE, BIT_CTRL_TYPE2);
+		rtw_write8_set(rtwdev, REG_CTRL_TYPE, BIT_CTRL_TYPE1);
+		rtw_write8_set(rtwdev, REG_CTRL_TYPE, BIT_CTRL_TYPE2);
 	}
 }
 
-- 
2.21.0

