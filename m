Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D455516BEB
	for <lists+linux-wireless@lfdr.de>; Mon,  2 May 2022 10:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377169AbiEBITw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 May 2022 04:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239965AbiEBITu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 May 2022 04:19:50 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013A61A3B8
        for <linux-wireless@vger.kernel.org>; Mon,  2 May 2022 01:16:19 -0700 (PDT)
Received: from fsav114.sakura.ne.jp (fsav114.sakura.ne.jp [27.133.134.241])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 2428GB1k081509;
        Mon, 2 May 2022 17:16:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav114.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp);
 Mon, 02 May 2022 17:16:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav114.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 2428GAs9081392
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 2 May 2022 17:16:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f15574a6-aba4-72bc-73af-26fdcdf9fb63@I-love.SAKURA.ne.jp>
Date:   Mon, 2 May 2022 17:16:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: [PATCH v2] wfx: avoid flush_workqueue(system_highpri_wq) usage
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <20220225112405.355599-1-Jerome.Pouiller@silabs.com>
 <20220225112405.355599-10-Jerome.Pouiller@silabs.com>
 <033f49bc-cc31-7384-7a7c-5d3c45ce9594@I-love.SAKURA.ne.jp>
 <4557835.LvFx2qVVIh@pc-42>
 <e25078f4-96f4-482c-b5da-a4a22d88b072@I-love.SAKURA.ne.jp>
 <87fsltd462.fsf@kernel.org>
 <3841528e-78ae-c3c4-169a-eeb39714f7ca@I-love.SAKURA.ne.jp>
 <87a6c0cuxf.fsf@kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <87a6c0cuxf.fsf@kernel.org>
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

Flushing system-wide workqueues is dangerous and will be forbidden.
Replace system_highpri_wq with per "struct wfx_dev" bh_wq.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Note: This patch is only compile tested.

Changes in v2:
  Use per "struct wfx_dev" workqueue.

 drivers/net/wireless/silabs/wfx/bh.c     | 6 +++---
 drivers/net/wireless/silabs/wfx/hif_tx.c | 2 +-
 drivers/net/wireless/silabs/wfx/main.c   | 6 ++++++
 drivers/net/wireless/silabs/wfx/wfx.h    | 1 +
 4 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/silabs/wfx/bh.c b/drivers/net/wireless/silabs/wfx/bh.c
index bcea9d5b119c..21dfdcf9cc27 100644
--- a/drivers/net/wireless/silabs/wfx/bh.c
+++ b/drivers/net/wireless/silabs/wfx/bh.c
@@ -267,7 +267,7 @@ void wfx_bh_request_rx(struct wfx_dev *wdev)
 	wfx_control_reg_read(wdev, &cur);
 	prev = atomic_xchg(&wdev->hif.ctrl_reg, cur);
 	complete(&wdev->hif.ctrl_ready);
-	queue_work(system_highpri_wq, &wdev->hif.bh);
+	queue_work(wdev->bh_wq, &wdev->hif.bh);
 
 	if (!(cur & CTRL_NEXT_LEN_MASK))
 		dev_err(wdev->dev, "unexpected control register value: length field is 0: %04x\n",
@@ -280,7 +280,7 @@ void wfx_bh_request_rx(struct wfx_dev *wdev)
 /* Driver want to send data */
 void wfx_bh_request_tx(struct wfx_dev *wdev)
 {
-	queue_work(system_highpri_wq, &wdev->hif.bh);
+	queue_work(wdev->bh_wq, &wdev->hif.bh);
 }
 
 /* If IRQ is not available, this function allow to manually poll the control register and simulate
@@ -295,7 +295,7 @@ void wfx_bh_poll_irq(struct wfx_dev *wdev)
 	u32 reg;
 
 	WARN(!wdev->poll_irq, "unexpected IRQ polling can mask IRQ");
-	flush_workqueue(system_highpri_wq);
+	flush_workqueue(wdev->bh_wq);
 	start = ktime_get();
 	for (;;) {
 		wfx_control_reg_read(wdev, &reg);
diff --git a/drivers/net/wireless/silabs/wfx/hif_tx.c b/drivers/net/wireless/silabs/wfx/hif_tx.c
index 9c653d0e9034..d35dd940d968 100644
--- a/drivers/net/wireless/silabs/wfx/hif_tx.c
+++ b/drivers/net/wireless/silabs/wfx/hif_tx.c
@@ -73,7 +73,7 @@ int wfx_cmd_send(struct wfx_dev *wdev, struct wfx_hif_msg *request,
 
 	if (no_reply) {
 		/* Chip won't reply. Ensure the wq has send the buffer before to continue. */
-		flush_workqueue(system_highpri_wq);
+		flush_workqueue(wdev->bh_wq);
 		ret = 0;
 		goto end;
 	}
diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wireless/silabs/wfx/main.c
index e575a81ca2ca..e015bfb8d221 100644
--- a/drivers/net/wireless/silabs/wfx/main.c
+++ b/drivers/net/wireless/silabs/wfx/main.c
@@ -345,6 +345,10 @@ int wfx_probe(struct wfx_dev *wdev)
 	wdev->pdata.gpio_wakeup = NULL;
 	wdev->poll_irq = true;
 
+	wdev->bh_wq = alloc_workqueue("wfx_bh_wq", WQ_HIGHPRI, 0);
+	if (!wdev->bh_wq)
+		return -ENOMEM;
+
 	wfx_bh_register(wdev);
 
 	err = wfx_init_device(wdev);
@@ -458,6 +462,7 @@ int wfx_probe(struct wfx_dev *wdev)
 	wdev->hwbus_ops->irq_unsubscribe(wdev->hwbus_priv);
 bh_unregister:
 	wfx_bh_unregister(wdev);
+	destroy_workqueue(wdev->bh_wq);
 	return err;
 }
 
@@ -467,6 +472,7 @@ void wfx_release(struct wfx_dev *wdev)
 	wfx_hif_shutdown(wdev);
 	wdev->hwbus_ops->irq_unsubscribe(wdev->hwbus_priv);
 	wfx_bh_unregister(wdev);
+	destroy_workqueue(wdev->bh_wq);
 }
 
 static int __init wfx_core_init(void)
diff --git a/drivers/net/wireless/silabs/wfx/wfx.h b/drivers/net/wireless/silabs/wfx/wfx.h
index 6594cc647c2f..6f5e95dae21f 100644
--- a/drivers/net/wireless/silabs/wfx/wfx.h
+++ b/drivers/net/wireless/silabs/wfx/wfx.h
@@ -57,6 +57,7 @@ struct wfx_dev {
 	struct mutex               rx_stats_lock;
 	struct wfx_hif_tx_power_loop_info tx_power_loop_info;
 	struct mutex               tx_power_loop_info_lock;
+	struct workqueue_struct    *bh_wq;
 };
 
 struct wfx_vif {
-- 
2.34.1


