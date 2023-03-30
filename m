Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F436D06E0
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Mar 2023 15:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjC3NfE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Mar 2023 09:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjC3Nez (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Mar 2023 09:34:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19020BB99
        for <linux-wireless@vger.kernel.org>; Thu, 30 Mar 2023 06:34:43 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32UDYK0t8015764, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32UDYK0t8015764
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 30 Mar 2023 21:34:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 30 Mar 2023 21:34:36 +0800
Received: from localhost (172.16.16.62) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 30 Mar
 2023 21:34:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/4] wifi: rtw89: 8851b: fix TX path to path A for one RF path chip
Date:   Thu, 30 Mar 2023 21:33:22 +0800
Message-ID: <20230330133324.19538-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230330133324.19538-1-pkshih@realtek.com>
References: <20230330133324.19538-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.62]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For two RF paths chips, we normally set path B as main path by default.
8851B has single one RF path, so set TX path to A and set mapping of
path B to 0.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 713aefd0cf8dd..7f69a8ee86bb2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1150,9 +1150,18 @@ int rtw89_fw_h2c_p2p_act(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 static void __rtw89_fw_h2c_set_tx_path(struct rtw89_dev *rtwdev,
 				       struct sk_buff *skb)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_hal *hal = &rtwdev->hal;
-	u8 ntx_path = hal->antenna_tx ? hal->antenna_tx : RF_B;
-	u8 map_b = hal->antenna_tx == RF_AB ? 1 : 0;
+	u8 ntx_path;
+	u8 map_b;
+
+	if (chip->rf_path_num == 1) {
+		ntx_path = RF_A;
+		map_b = 0;
+	} else {
+		ntx_path = hal->antenna_tx ? hal->antenna_tx : RF_B;
+		map_b = hal->antenna_tx == RF_AB ? 1 : 0;
+	}
 
 	SET_CMC_TBL_NTX_PATH_EN(skb->data, ntx_path);
 	SET_CMC_TBL_PATH_MAP_A(skb->data, 0);
-- 
2.25.1

