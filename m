Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729477B7AA8
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 10:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241846AbjJDIva (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 04:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbjJDIv3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 04:51:29 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF70D7
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 01:51:25 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3948pBSc93164818, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3948pBSc93164818
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Oct 2023 16:51:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 4 Oct 2023 16:51:11 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 4 Oct 2023
 16:51:10 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/5] wifi: rtw88: regd: configure QATAR and UK
Date:   Wed, 4 Oct 2023 16:50:47 +0800
Message-ID: <20231004085051.205683-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004085051.205683-1-pkshih@realtek.com>
References: <20231004085051.205683-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

In newer Realtek parameter package, Realtek regd can configure
QATAR and UK individually. So, driver extends the regd enum.
Besides, driver configure alternative of them which will be
referenced when parameter package of a chip doesn't consider
QATAR and UK individually.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h | 4 +++-
 drivers/net/wireless/realtek/rtw88/regd.c | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index c42ef8294d59..86dc1516effa 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -342,8 +342,10 @@ enum rtw_regulatory_domains {
 	RTW_REGD_UKRAINE	= 7,
 	RTW_REGD_MEXICO		= 8,
 	RTW_REGD_CN		= 9,
-	RTW_REGD_WW,
+	RTW_REGD_QATAR		= 10,
+	RTW_REGD_UK		= 11,
 
+	RTW_REGD_WW,
 	RTW_REGD_MAX
 };
 
diff --git a/drivers/net/wireless/realtek/rtw88/regd.c b/drivers/net/wireless/realtek/rtw88/regd.c
index 2f547cbcf6da..680d8f32fce6 100644
--- a/drivers/net/wireless/realtek/rtw88/regd.c
+++ b/drivers/net/wireless/realtek/rtw88/regd.c
@@ -519,6 +519,8 @@ rtw_regd_alt[RTW_REGD_MAX] = {
 	DECL_REGD_ALT(RTW_REGD_UKRAINE, RTW_REGD_ETSI),
 	DECL_REGD_ALT(RTW_REGD_MEXICO, RTW_REGD_FCC),
 	DECL_REGD_ALT(RTW_REGD_CN, RTW_REGD_ETSI),
+	DECL_REGD_ALT(RTW_REGD_QATAR, RTW_REGD_ETSI),
+	DECL_REGD_ALT(RTW_REGD_UK, RTW_REGD_ETSI),
 };
 
 bool rtw_regd_has_alt(u8 regd, u8 *regd_alt)
-- 
2.25.1

