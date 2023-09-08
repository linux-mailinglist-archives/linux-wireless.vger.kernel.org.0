Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080A67980DD
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Sep 2023 05:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbjIHDNK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 23:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbjIHDNI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 23:13:08 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509F51BD8
        for <linux-wireless@vger.kernel.org>; Thu,  7 Sep 2023 20:13:04 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3883Cu6P21359715, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3883Cu6P21359715
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Sep 2023 11:12:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 8 Sep 2023 11:12:56 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 8 Sep 2023
 11:12:56 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/8] wifi: rtw89: mcc: deal with BT slot change
Date:   Fri, 8 Sep 2023 11:11:44 +0800
Message-ID: <20230908031145.20931-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230908031145.20931-1-pkshih@realtek.com>
References: <20230908031145.20931-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

When receiving request of adjusting BT slot from coex. mechanism,
we need to fetch the new BT slot and use the new one to calculate
MCC (multi-channel concurrency) pattern. Then, we update the new
MCC pattern to FW.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 5 ++++-
 drivers/net/wireless/realtek/rtw89/core.c | 1 +
 drivers/net/wireless/realtek/rtw89/core.h | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 6f584a56e92f..2bc936761374 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -1646,12 +1646,15 @@ void rtw89_chanctx_work(struct work_struct *work)
 		break;
 	case RTW89_ENTITY_MODE_MCC:
 		if (changed & BIT(RTW89_CHANCTX_BCN_OFFSET_CHANGE) ||
-		    changed & BIT(RTW89_CHANCTX_P2P_PS_CHANGE))
+		    changed & BIT(RTW89_CHANCTX_P2P_PS_CHANGE) ||
+		    changed & BIT(RTW89_CHANCTX_BT_SLOT_CHANGE))
 			update_mcc_pattern = true;
 		if (changed & BIT(RTW89_CHANCTX_REMOTE_STA_CHANGE))
 			rtw89_mcc_update_macid_bitmap(rtwdev);
 		if (changed & BIT(RTW89_CHANCTX_P2P_PS_CHANGE))
 			rtw89_mcc_update_limit(rtwdev);
+		if (changed & BIT(RTW89_CHANCTX_BT_SLOT_CHANGE))
+			rtw89_mcc_fill_bt_role(rtwdev);
 		if (update_mcc_pattern) {
 			ret = rtw89_mcc_update(rtwdev);
 			if (ret)
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 53425d09fe5c..982e67a97e9e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3529,6 +3529,7 @@ void rtw89_core_ntfy_btc_event(struct rtw89_dev *rtwdev, enum rtw89_btc_hmsg eve
 		bt_req_len = rtw89_coex_query_bt_req_len(rtwdev, RTW89_PHY_0);
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
 			    "coex updates BT req len to %d TU\n", bt_req_len);
+		rtw89_queue_chanctx_change(rtwdev, RTW89_CHANCTX_BT_SLOT_CHANGE);
 		break;
 	default:
 		if (event < NUM_OF_RTW89_BTC_HMSG)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4cf11bbc00cb..78ba5fd6923b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3791,6 +3791,7 @@ enum rtw89_chanctx_changes {
 	RTW89_CHANCTX_REMOTE_STA_CHANGE,
 	RTW89_CHANCTX_BCN_OFFSET_CHANGE,
 	RTW89_CHANCTX_P2P_PS_CHANGE,
+	RTW89_CHANCTX_BT_SLOT_CHANGE,
 
 	NUM_OF_RTW89_CHANCTX_CHANGES,
 	RTW89_CHANCTX_CHANGE_DFLT = NUM_OF_RTW89_CHANCTX_CHANGES,
-- 
2.25.1

