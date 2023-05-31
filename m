Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D03E7176AC
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 08:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjEaGIb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 02:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbjEaGIO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 02:08:14 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CF418F
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 23:07:49 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34V67St04025689, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34V67St04025689
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 31 May 2023 14:07:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 31 May 2023 14:07:42 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 31 May
 2023 14:07:41 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/4] wifi: rtw89: set TX power without precondition during setting channel
Date:   Wed, 31 May 2023 14:07:12 +0800
Message-ID: <20230531060713.57203-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230531060713.57203-1-pkshih@realtek.com>
References: <20230531060713.57203-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

The key condition to check in wrapper of setting TX power is whether entity
is active or not. Before entity is active, we restrict TX power from being
set by outside callers, e.g. SAR/regulatory.

We mark entity as inactive when powering off MAC. Then, we will mark it as
active when we initialize HW channel stuffs after MAC power on. Although we
can get an active entity after leaving idle phase, TX power doesn't be set
well for default channel until stack set target channel for connection. It
causes that RF things cannot use better TX power during this interval.

Below are some cases which may encounter this or a similar situation.
* hw scan process before connection
	As described above.
* right after restart hardware process (SER L2)
	HW stuffs of target channel is initialized after mac80211 restart
	hardware, but we unexpectedly need to wait one more command to set
	channel again or to set TX power.

To fix it and improve RF behavior in that interval, during setting channel,
we don't need to check entity state before setting TX power, which actually
is used to restrict outside callers. It means we call chip ops directly to
replace the wrapper call. Then, TX power can be initialized as long as we
initialize/setup HW stuffs on one channel.

Besides, all chips should configure ops of setting TX power, so we remove
trivial check on pointer.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 101047686fffb..408b5a8e5dd9c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -336,8 +336,7 @@ void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
 	sub_entity_idx = RTW89_SUB_ENTITY_0;
 	phy_idx = RTW89_PHY_0;
 	chan = rtw89_chan_get(rtwdev, sub_entity_idx);
-	if (chip->ops->set_txpwr)
-		chip->ops->set_txpwr(rtwdev, chan, phy_idx);
+	chip->ops->set_txpwr(rtwdev, chan, phy_idx);
 }
 
 void rtw89_set_channel(struct rtw89_dev *rtwdev)
@@ -373,7 +372,7 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev)
 
 	chip->ops->set_channel(rtwdev, &chan, mac_idx, phy_idx);
 
-	rtw89_core_set_chip_txpwr(rtwdev);
+	chip->ops->set_txpwr(rtwdev, &chan, phy_idx);
 
 	rtw89_chip_set_channel_done(rtwdev, &bak, &chan, mac_idx, phy_idx);
 
-- 
2.25.1

