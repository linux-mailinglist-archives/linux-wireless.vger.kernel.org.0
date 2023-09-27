Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7317AFBE7
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Sep 2023 09:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjI0HWZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Sep 2023 03:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjI0HWX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Sep 2023 03:22:23 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686091B5
        for <linux-wireless@vger.kernel.org>; Wed, 27 Sep 2023 00:22:19 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38R7MC9202061714, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38R7MC9202061714
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 15:22:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 27 Sep 2023 15:22:12 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 27 Sep
 2023 15:22:11 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/4] wifi: rtw89: regd: configure Thailand in regulation type
Date:   Wed, 27 Sep 2023 15:21:53 +0800
Message-ID: <20230927072156.26336-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230927072156.26336-1-pkshih@realtek.com>
References: <20230927072156.26336-1-pkshih@realtek.com>
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

Realtek RFE (RF Front End) parameters can consider Thailand individually
now, so we add it into regulation type enum. Then, we map country code TH
to RTW89_ETSI/RTW89_THAILAND according to band. The RF TX power tables will
add entries for RTW89_THAILAND in the following.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 1 +
 drivers/net/wireless/realtek/rtw89/regd.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ac09785c21a6..1c972f59fa17 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -709,6 +709,7 @@ enum rtw89_regulation_type {
 	RTW89_CN	= 12,
 	RTW89_QATAR	= 13,
 	RTW89_UK	= 14,
+	RTW89_THAILAND	= 15,
 	RTW89_REGD_NUM,
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index c956a8b971c6..ca99422e600f 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -115,7 +115,7 @@ static const struct rtw89_regd rtw89_regd_map[] = {
 	COUNTRY_REGD("SG", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("LK", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("TW", RTW89_FCC, RTW89_FCC, RTW89_NA),
-	COUNTRY_REGD("TH", RTW89_WW, RTW89_WW, RTW89_WW),
+	COUNTRY_REGD("TH", RTW89_ETSI, RTW89_ETSI, RTW89_THAILAND),
 	COUNTRY_REGD("VN", RTW89_ETSI, RTW89_ETSI, RTW89_NA),
 	COUNTRY_REGD("AU", RTW89_ACMA, RTW89_ACMA, RTW89_ACMA),
 	COUNTRY_REGD("NZ", RTW89_ACMA, RTW89_ACMA, RTW89_ACMA),
-- 
2.25.1

