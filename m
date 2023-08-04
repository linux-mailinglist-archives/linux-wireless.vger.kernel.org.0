Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA8176FF41
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Aug 2023 13:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjHDLMJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Aug 2023 07:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjHDLMI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Aug 2023 07:12:08 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 624AAEA;
        Fri,  4 Aug 2023 04:12:07 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 374AonmqF007376, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 374AonmqF007376
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 4 Aug 2023 18:50:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 4 Aug 2023 18:50:50 +0800
Received: from [127.0.1.1] (172.16.16.139) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 4 Aug 2023
 18:50:49 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <Stable@vger.kernel.org>, <bronecki.damian@gmail.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: fix 8852AE disconnection caused by RX full flags
Date:   Fri, 4 Aug 2023 18:50:02 +0800
Message-ID: <20230804105002.5781-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.139]
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

RX full flags are raised if certain types of RX FIFO are full, and then
drop all following MSDU of APMDU. In order to resume to receive MSDU
when RX FIFO becomes available, we clear the regitster bits by the
commit a0d99ebb3ecd ("wifi: rtw89: initialize DMA of CMAC"). But, 8852AE
needs more settings to support this. To quickly fix disconnection problem,
revert the behavior as before.

Fixes: a0d99ebb3ecd ("wifi: rtw89: initialize DMA of CMAC")
Reported-by: Damian B <bronecki.damian@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217710
Cc: <Stable@vger.kernel.org>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 1efa4da3cebc..cebefa3b1db3 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2524,7 +2524,7 @@ static int cmac_dma_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	u32 reg;
 	int ret;
 
-	if (chip_id != RTL8852A && chip_id != RTL8852B)
+	if (chip_id != RTL8852B)
 		return 0;
 
 	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
-- 
2.25.1

