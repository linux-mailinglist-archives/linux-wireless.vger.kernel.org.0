Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F207BCBCC
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Oct 2023 05:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344337AbjJHC7h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Oct 2023 22:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbjJHC7g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Oct 2023 22:59:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882DABF
        for <linux-wireless@vger.kernel.org>; Sat,  7 Oct 2023 19:59:32 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S36HT1JlYzTmNb;
        Sun,  8 Oct 2023 10:56:05 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sun, 8 Oct
 2023 10:59:29 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <linux-wireless@vger.kernel.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>, neo_jou <neo_jou@realtek.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Hans Ulli Kroll <linux@ulli-kroll.de>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH] wifi: rtw88: Remove duplicate NULL check before calling usb_kill/free_urb()
Date:   Sun, 8 Oct 2023 10:58:52 +0800
Message-ID: <20231008025852.1239450-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Both usb_kill_urb() and usb_free_urb() do the NULL check itself, so there
is no need to duplicate it prior to calling.

Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index d879d7e3dc81..e6ab1ac6d709 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -611,8 +611,7 @@ static void rtw_usb_cancel_rx_bufs(struct rtw_usb *rtwusb)
 
 	for (i = 0; i < RTW_USB_RXCB_NUM; i++) {
 		rxcb = &rtwusb->rx_cb[i];
-		if (rxcb->rx_urb)
-			usb_kill_urb(rxcb->rx_urb);
+		usb_kill_urb(rxcb->rx_urb);
 	}
 }
 
@@ -623,10 +622,8 @@ static void rtw_usb_free_rx_bufs(struct rtw_usb *rtwusb)
 
 	for (i = 0; i < RTW_USB_RXCB_NUM; i++) {
 		rxcb = &rtwusb->rx_cb[i];
-		if (rxcb->rx_urb) {
-			usb_kill_urb(rxcb->rx_urb);
-			usb_free_urb(rxcb->rx_urb);
-		}
+		usb_kill_urb(rxcb->rx_urb);
+		usb_free_urb(rxcb->rx_urb);
 	}
 }
 
-- 
2.34.1

