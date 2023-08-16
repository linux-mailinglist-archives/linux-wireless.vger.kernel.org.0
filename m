Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0A277DC11
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242858AbjHPIWw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242872AbjHPIW3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:22:29 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA0FD1FD0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:22:27 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37G8Lx4T2001143, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37G8Lx4T2001143
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Aug 2023 16:21:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 16 Aug 2023 16:22:18 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 16 Aug
 2023 16:22:18 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/6] wifi: rtw89: add function prototype for coex request duration
Date:   Wed, 16 Aug 2023 16:21:28 +0800
Message-ID: <20230816082133.57474-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816082133.57474-1-pkshih@realtek.com>
References: <20230816082133.57474-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

The request duration comes from coex mechanism, indicating the
length of time that should be reserved for BT in each time division.
It is required to handle update notification when channel concurrency
processes. Since it will involve in both coex and wifi code flow, this
commit ahead adds the prototype for required function interfaces to
split the implementation of coex and wifi in the following.

The follow-up are expected be add afterwards.
1. coex mechanism call rtw89_core_ntfy_btc_event() once bt req len changes
2. channel concurrency flow updates related stuffs when notified

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.h |  9 +++++++++
 drivers/net/wireless/realtek/rtw89/core.c | 21 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h | 12 ++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index f16421cb30ef..e76153709793 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -193,4 +193,13 @@ static inline u8 rtw89_btc_path_phymap(struct rtw89_dev *rtwdev,
 	return rtw89_btc_phymap(rtwdev, phy_idx, BIT(path));
 }
 
+/* return bt req len in TU */
+static inline u16 rtw89_coex_query_bt_req_len(struct rtw89_dev *rtwdev,
+					      enum rtw89_phy_idx phy_idx)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+
+	return btc->bt_req_len;
+}
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 71eb9cfd4896..a338b0a97910 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3464,6 +3464,27 @@ void rtw89_complete_cond(struct rtw89_wait_info *wait, unsigned int cond,
 	complete(&wait->completion);
 }
 
+void rtw89_core_ntfy_btc_event(struct rtw89_dev *rtwdev, enum rtw89_btc_hmsg event)
+{
+	u16 bt_req_len;
+
+	switch (event) {
+	case RTW89_BTC_HMSG_SET_BT_REQ_SLOT:
+		bt_req_len = rtw89_coex_query_bt_req_len(rtwdev, RTW89_PHY_0);
+		rtw89_debug(rtwdev, RTW89_DBG_BTC,
+			    "coex updates BT req len to %d TU\n", bt_req_len);
+		break;
+	default:
+		if (event < NUM_OF_RTW89_BTC_HMSG)
+			rtw89_debug(rtwdev, RTW89_DBG_BTC,
+				    "unhandled BTC HMSG event: %d\n", event);
+		else
+			rtw89_warn(rtwdev,
+				   "unrecognized BTC HMSG event: %d\n", event);
+		break;
+	}
+}
+
 int rtw89_core_start(struct rtw89_dev *rtwdev)
 {
 	int ret;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b5a08f90f5bd..5b60bc72b4a5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2656,6 +2656,17 @@ struct rtw89_btc {
 	bool lps;
 };
 
+enum rtw89_btc_hmsg {
+	RTW89_BTC_HMSG_TMR_EN = 0x0,
+	RTW89_BTC_HMSG_BT_REG_READBACK = 0x1,
+	RTW89_BTC_HMSG_SET_BT_REQ_SLOT = 0x2,
+	RTW89_BTC_HMSG_FW_EV = 0x3,
+	RTW89_BTC_HMSG_BT_LINK_CHG = 0x4,
+	RTW89_BTC_HMSG_SET_BT_REQ_STBC = 0x5,
+
+	NUM_OF_RTW89_BTC_HMSG,
+};
+
 enum rtw89_ra_mode {
 	RTW89_RA_MODE_CCK = BIT(0),
 	RTW89_RA_MODE_OFDM = BIT(1),
@@ -5325,5 +5336,6 @@ void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
 			      struct ieee80211_vif *vif, bool hw_scan);
 void rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif *rtwvif, bool active);
+void rtw89_core_ntfy_btc_event(struct rtw89_dev *rtwdev, enum rtw89_btc_hmsg event);
 
 #endif
-- 
2.25.1

