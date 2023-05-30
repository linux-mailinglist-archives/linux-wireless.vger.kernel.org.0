Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12DA7159B0
	for <lists+linux-wireless@lfdr.de>; Tue, 30 May 2023 11:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjE3JPr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 May 2023 05:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjE3JPq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 May 2023 05:15:46 -0400
Received: from bin-mail-out-06.binero.net (bin-mail-out-06.binero.net [195.74.38.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5479CBE
        for <linux-wireless@vger.kernel.org>; Tue, 30 May 2023 02:15:43 -0700 (PDT)
X-Halon-ID: 88cb9742-feca-11ed-9190-9961c02482a6
Authorized-sender: petter@technux.se
Received: from localhost.localdomain (user33.85-195-12.netatonce.net [85.195.12.33])
        by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPSA
        id 88cb9742-feca-11ed-9190-9961c02482a6;
        Tue, 30 May 2023 11:15:37 +0200 (CEST)
From:   petter@technux.se
To:     linux-wireless@vger.kernel.org
Cc:     s.hauer@pengutronix.de, Larry.Finger@lwfinger.net,
        andreas@fatal.se, g0000ga@gmail.com, iam@valdikss.org.ru,
        kernel@pengutronix.de, linux@ulli-kroll.de, morrownr@gmail.com,
        mr.nuke.me@gmail.com, petter@technux.se, pkshih@realtek.com,
        tpkuester@gmail.com, Petter Mabacker <petter.mabacker@esab.se>
Subject: [PATCH] wifi: rtw88: usb: Make work queues high prio
Date:   Tue, 30 May 2023 11:15:32 +0200
Message-Id: <20230530091532.2711675-1-petter@technux.se>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Petter Mabacker <petter.mabacker@esab.se>

The rtw8822cu driver have problem to handle high rx or tx rates compared
with high load (such as high I/O) on slower systems, such as for example
i.MX6 SoloX and similar platforms.

The problems are more frequent when having the access point close to the
device. On slower systems it's often enough to download a large file,
combined with generating I/O load to trigger:

[  374.763424] rtw_8822cu 1-1.2:1.2: failed to get tx report from firmware
[  377.771790] rtw_8822cu 1-1.2:1.2: failed to send h2c command
[  407.813460] rtw_8822cu 1-1.2:1.2: firmware failed to report density after scan
[  414.965826] rtw_8822cu 1-1.2:1.2: failed to send h2c command
[  444.993462] rtw_8822cu 1-1.2:1.2: firmware failed to report density after scan
[  452.144551] rtw_8822cu 1-1.2:1.2: failed to send h2c command
[  482.183445] rtw_8822cu 1-1.2:1.2: firmware failed to report density after scan
[  489.426263] rtw_8822cu 1-1.2:1.2: failed to send h2c command

Another way is to simply perform a wifi rescan.

Benchmarking shows that setting a high prio workqueue for tx/rx will
significally improve things. Also compared alloc_workqueue with
alloc_ordered_workqueue, but even thou the later seems to slightly
improve things it's still quite easy to reproduce the above issues. So
that leads to the decision to go for alloc_workqueue.

Thanks to Ping-Ke Shih <pkshih@realtek.com> that came up with the idea
of exploring tweaking of the work queue's within a similar discussion.

Fixes: a82dfd33d1237 ("wifi: rtw88: Add common USB chip support")
Signed-off-by: Petter Mabacker <petter.mabacker@esab.se>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 44a5fafb9905..bfe0845528ec 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -716,7 +716,7 @@ static int rtw_usb_init_rx(struct rtw_dev *rtwdev)
 	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
 	int i;
 
-	rtwusb->rxwq = create_singlethread_workqueue("rtw88_usb: rx wq");
+	rtwusb->rxwq = alloc_workqueue("rtw88_usb: rx wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
 	if (!rtwusb->rxwq) {
 		rtw_err(rtwdev, "failed to create RX work queue\n");
 		return -ENOMEM;
@@ -750,7 +750,7 @@ static int rtw_usb_init_tx(struct rtw_dev *rtwdev)
 	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
 	int i;
 
-	rtwusb->txwq = create_singlethread_workqueue("rtw88_usb: tx wq");
+	rtwusb->txwq = alloc_workqueue("rtw88_usb: tx wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
 	if (!rtwusb->txwq) {
 		rtw_err(rtwdev, "failed to create TX work queue\n");
 		return -ENOMEM;
-- 
2.39.2

