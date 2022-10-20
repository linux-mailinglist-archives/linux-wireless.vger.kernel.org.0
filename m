Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250136056C5
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Oct 2022 07:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJTF1g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Oct 2022 01:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJTF1e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Oct 2022 01:27:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9114B192989
        for <linux-wireless@vger.kernel.org>; Wed, 19 Oct 2022 22:27:33 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29K5Qsp96032275, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29K5Qsp96032275
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 20 Oct 2022 13:26:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 20 Oct 2022 13:27:26 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 20 Oct
 2022 13:27:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: rtw89: 8852c: make table of RU mask constant
Date:   Thu, 20 Oct 2022 13:27:02 +0800
Message-ID: <20221020052702.33988-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221020052702.33988-1-pkshih@realtek.com>
References: <20221020052702.33988-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/20/2022 04:59:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzIwIKRXpMggMDM6Mzg6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This table must be constant, so change it as expectation.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index f6bcac8268166..7e208a8fdf4bb 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1683,12 +1683,12 @@ static void rtw8852c_set_channel_bb(struct rtw89_dev *rtwdev,
 				    const struct rtw89_chan *chan,
 				    enum rtw89_phy_idx phy_idx)
 {
+	static const u32 ru_alloc_msk[2] = {B_P80_AT_HIGH_FREQ_RU_ALLOC_PHY0,
+					    B_P80_AT_HIGH_FREQ_RU_ALLOC_PHY1};
 	struct rtw89_hal *hal = &rtwdev->hal;
 	bool cck_en = chan->band_type == RTW89_BAND_2G;
 	u8 pri_ch_idx = chan->pri_ch_idx;
 	u32 mask, reg;
-	u32 ru_alloc_msk[2] = {B_P80_AT_HIGH_FREQ_RU_ALLOC_PHY0,
-			       B_P80_AT_HIGH_FREQ_RU_ALLOC_PHY1};
 	u8 ntx_path;
 
 	if (chan->band_type == RTW89_BAND_2G)
-- 
2.25.1

