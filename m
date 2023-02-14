Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F76169629D
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Feb 2023 12:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjBNLn6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Feb 2023 06:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBNLn5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Feb 2023 06:43:57 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AA56E84
        for <linux-wireless@vger.kernel.org>; Tue, 14 Feb 2023 03:43:55 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 31EBhkLhB020936, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (mapi.realtek.com[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 31EBhkLhB020936
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 14 Feb 2023 19:43:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 14 Feb 2023 19:43:48 +0800
Received: from localhost (172.16.16.240) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 14 Feb
 2023 19:43:47 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: move H2C of del_pkt_offload before polling FW status ready
Date:   Tue, 14 Feb 2023 19:43:14 +0800
Message-ID: <20230214114314.5268-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.240]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
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

From: Chin-Yen Lee <timlee@realtek.com>

The H2C of del_pkt_offload must be called before polling FW status
ready, otherwise the following downloading normal FW will fail.

Fixes: 5c12bb66b79d ("wifi: rtw89: refine packet offload flow")
Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
Hi Kalle,

We found a bug existing in commit 5c12bb66b79d that was merged yesterday.
Since merge window is next week, is it possible to merge this patch for
kernel 6.3?

Thank you 
Ping-Ke

---
 drivers/net/wireless/realtek/rtw89/wow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 92fa366ccfcf7..c78ee2ab732c9 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -710,6 +710,8 @@ static int rtw89_wow_fw_stop(struct rtw89_dev *rtwdev)
 		goto out;
 	}
 
+	rtw89_fw_release_general_pkt_list(rtwdev, true);
+
 	ret = rtw89_wow_check_fw_status(rtwdev, false);
 	if (ret) {
 		rtw89_err(rtwdev, "wow: failed to check disable fw ready\n");
@@ -779,8 +781,6 @@ static int rtw89_wow_disable(struct rtw89_dev *rtwdev)
 		goto out;
 	}
 
-	rtw89_fw_release_general_pkt_list(rtwdev, true);
-
 	ret = rtw89_wow_swap_fw(rtwdev, false);
 	if (ret) {
 		rtw89_err(rtwdev, "wow: failed to disable trx_post\n");
-- 
2.25.1

