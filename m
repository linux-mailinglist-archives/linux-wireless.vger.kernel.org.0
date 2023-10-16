Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B507C9FF6
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Oct 2023 08:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjJPGwD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Oct 2023 02:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjJPGwB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Oct 2023 02:52:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807B7C5
        for <linux-wireless@vger.kernel.org>; Sun, 15 Oct 2023 23:51:57 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39G6pmOwB2264252, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39G6pmOwB2264252
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 14:51:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 16 Oct 2023 14:51:49 +0800
Received: from [127.0.1.1] (172.21.71.113) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 16 Oct
 2023 14:51:48 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <cj.hsieh@realtek.com>, <hsuan8331@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/5] wifi: rtw89: correct the DCFO tracking flow to improve CFO compensation
Date:   Mon, 16 Oct 2023 14:51:14 +0800
Message-ID: <20231016065115.751662-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016065115.751662-1-pkshih@realtek.com>
References: <20231016065115.751662-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.71.113]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Cheng-Chieh Hsieh <cj.hsieh@realtek.com>

DCFO tracking compensate the CFO (carrier frequency offset) by digital
hardware that provides fine CFO estimation. Although the avg_cfo which
is a coarse information becomes zero, still we need DCFO tracking to
compensate the residual CFO. However, the original flow skips the case
when avg_cfo is zero, so we fix it to have expected performance.

Signed-off-by: Cheng-Chieh Hsieh <cj.hsieh@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index c7d8faa6265c..3b671a314e60 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2634,6 +2634,10 @@ static void rtw89_phy_cfo_crystal_cap_adjust(struct rtw89_dev *rtwdev,
 	s32 cfo_abs = abs(curr_cfo);
 	int sign;
 
+	if (curr_cfo == 0) {
+		rtw89_debug(rtwdev, RTW89_DBG_CFO, "curr_cfo=0\n");
+		return;
+	}
 	if (!cfo->is_adjust) {
 		if (cfo_abs > CFO_TRK_ENABLE_TH)
 			cfo->is_adjust = true;
@@ -2830,10 +2834,6 @@ static void rtw89_phy_cfo_dm(struct rtw89_dev *rtwdev)
 		new_cfo = rtw89_phy_average_cfo_calc(rtwdev);
 	else
 		new_cfo = rtw89_phy_multi_sta_cfo_calc(rtwdev);
-	if (new_cfo == 0) {
-		rtw89_debug(rtwdev, RTW89_DBG_CFO, "curr_cfo=0\n");
-		return;
-	}
 	if (cfo->divergence_lock_en) {
 		cfo->lock_cnt++;
 		if (cfo->lock_cnt > CFO_PERIOD_CNT) {
-- 
2.25.1

