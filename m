Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A63D6E2EE1
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Apr 2023 05:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjDODuW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 23:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjDODuT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 23:50:19 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4011955B4
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 20:50:10 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33F3ngpJ7021908, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33F3ngpJ7021908
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 15 Apr 2023 11:49:42 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Sat, 15 Apr 2023 11:49:25 +0800
Received: from localhost (172.16.20.53) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 15 Apr
 2023 11:49:24 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 1/6] wifi: rtw89: prohibit enter IPS during HW scan
Date:   Sat, 15 Apr 2023 11:48:55 +0800
Message-ID: <20230415034900.15679-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230415034900.15679-1-pkshih@realtek.com>
References: <20230415034900.15679-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.20.53]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chih-Kang Chang <gary.chang@realtek.com>

Mac80211 core may ask driver to change to idle mode during HW scan,
then H2C command for HW scan will send failed since chip is in idle
mode. Therefore, We check the SCANNING flag before entering IPS to
prevent this behavior.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index b059aa8d88dbf..b5cbfc15ebad8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -105,7 +105,8 @@ static int rtw89_ops_config(struct ieee80211_hw *hw, u32 changed)
 	}
 
 	if ((changed & IEEE80211_CONF_CHANGE_IDLE) &&
-	    (hw->conf.flags & IEEE80211_CONF_IDLE))
+	    (hw->conf.flags & IEEE80211_CONF_IDLE) &&
+	    !rtwdev->scanning)
 		rtw89_enter_ips(rtwdev);
 
 	mutex_unlock(&rtwdev->mutex);
-- 
2.25.1

