Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3694DD3C4
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Mar 2022 04:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiCRDyf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 23:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiCRDyd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 23:54:33 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23C21760D8
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 20:53:14 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22I3qjOF3008518, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22I3qjOF3008518
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Mar 2022 11:52:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 18 Mar 2022 11:52:45 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 11:52:45 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] rtw89: handle potential uninitialized variable
Date:   Fri, 18 Mar 2022 11:52:02 +0800
Message-ID: <20220318035202.42437-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-KSE-Antiphishing-Bases: 03/18/2022 03:40:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTggpFekyCAwMjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The smatch reports:
 rtw8852a.c:1857 rtw8852a_btc_set_wl_txpwr_ctrl() error: uninitialized symbol '_cur'.
 rtw8852a.c:1858 rtw8852a_btc_set_wl_txpwr_ctrl() error: uninitialized symbol '_cur'.

This is because rtw89_mac_txpwr_read32() can possibly return before setting
argument _cur, and the caller will use the uninitialized value. To fix this
problem, check the return value of rtw89_mac_txpwr_read32().

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 41fc8db311ecf..b6887325a27b3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1841,7 +1841,8 @@ rtw8852a_btc_set_wl_txpwr_ctrl(struct rtw89_dev *rtwdev, u32 txpwr_val)
 		u32 _cur, _wrt;						\
 		rtw89_debug(rtwdev, RTW89_DBG_TXPWR,			\
 			    "btc ctrl %s: 0x%x\n", #_case, _val);	\
-		rtw89_mac_txpwr_read32(rtwdev, RTW89_PHY_0, _reg, &_cur);\
+		if (rtw89_mac_txpwr_read32(rtwdev, RTW89_PHY_0, _reg, &_cur))\
+			break;						\
 		rtw89_debug(rtwdev, RTW89_DBG_TXPWR,			\
 			    "btc ctrl ori 0x%x: 0x%x\n", _reg, _cur);	\
 		_wrt = __do_clr(_val) ?					\
-- 
2.25.1

