Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7866546539
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 13:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343956AbiFJLMf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 07:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345493AbiFJLMe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 07:12:34 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600361498CC
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 04:12:33 -0700 (PDT)
Received: from fsav120.sakura.ne.jp (fsav120.sakura.ne.jp [27.133.134.247])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 25ABCT4m013374;
        Fri, 10 Jun 2022 20:12:29 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav120.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp);
 Fri, 10 Jun 2022 20:12:29 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav120.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 25ABCSGR013370
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 10 Jun 2022 20:12:28 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8de85fd9-50a1-aad7-86f7-24834be8bbc0@I-love.SAKURA.ne.jp>
Date:   Fri, 10 Jun 2022 20:12:25 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] ath6kl: avoid flush_scheduled_work() usage
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use local wq in order to avoid flush_scheduled_work() usage.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Please see commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue()
using a macro") for background.

This is a blind conversion, and is only compile tested.

 drivers/net/wireless/ath/ath6kl/usb.c | 29 +++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index 65e683effdcb..e3c65a671be1 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -21,6 +21,8 @@
 #include "debug.h"
 #include "core.h"
 
+static struct workqueue_struct *ath6kl_wq;
+
 /* constants */
 #define TX_URB_COUNT            32
 #define RX_URB_COUNT            32
@@ -478,7 +480,7 @@ static void ath6kl_usb_flush_all(struct ath6kl_usb *ar_usb)
 	 * Flushing any pending I/O may schedule work this call will block
 	 * until all scheduled work runs to completion.
 	 */
-	flush_scheduled_work();
+	flush_workqueue(ath6kl_wq);
 }
 
 static void ath6kl_usb_start_recv_pipes(struct ath6kl_usb *ar_usb)
@@ -544,7 +546,7 @@ static void ath6kl_usb_recv_complete(struct urb *urb)
 
 	/* note: queue implements a lock */
 	skb_queue_tail(&pipe->io_comp_queue, skb);
-	schedule_work(&pipe->io_complete_work);
+	queue_work(ath6kl_wq, &pipe->io_complete_work);
 
 cleanup_recv_urb:
 	ath6kl_usb_cleanup_recv_urb(urb_context);
@@ -579,7 +581,7 @@ static void ath6kl_usb_usb_transmit_complete(struct urb *urb)
 
 	/* note: queue implements a lock */
 	skb_queue_tail(&pipe->io_comp_queue, skb);
-	schedule_work(&pipe->io_complete_work);
+	queue_work(ath6kl_wq, &pipe->io_complete_work);
 }
 
 static void ath6kl_usb_io_comp_work(struct work_struct *work)
@@ -1234,7 +1236,26 @@ static struct usb_driver ath6kl_usb_driver = {
 	.disable_hub_initiated_lpm = 1,
 };
 
-module_usb_driver(ath6kl_usb_driver);
+static int __init ath6kl_init(void)
+{
+	int ret;
+
+	ath6kl_wq = alloc_workqueue("ath6kl_wq", 0, 0);
+	if (!ath6kl_wq)
+		return -ENOMEM;
+	ret = usb_register(&ath6kl_usb_driver);
+	if (ret)
+		destroy_workqueue(ath6kl_wq);
+	return ret;
+}
+module_init(ath6kl_init);
+
+static void __exit ath6kl_exit(void)
+{
+	usb_deregister(&ath6kl_usb_driver);
+	destroy_workqueue(ath6kl_wq);
+}
+module_exit(ath6kl_exit);
 
 MODULE_AUTHOR("Atheros Communications, Inc.");
 MODULE_DESCRIPTION("Driver support for Atheros AR600x USB devices");
-- 
2.18.4

