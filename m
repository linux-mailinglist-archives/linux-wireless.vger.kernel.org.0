Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365BB51621A
	for <lists+linux-wireless@lfdr.de>; Sun,  1 May 2022 08:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241635AbiEAGFZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 May 2022 02:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbiEAGFY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 May 2022 02:05:24 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4302B195
        for <linux-wireless@vger.kernel.org>; Sat, 30 Apr 2022 23:01:58 -0700 (PDT)
Received: from fsav412.sakura.ne.jp (fsav412.sakura.ne.jp [133.242.250.111])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 24161dGT001738;
        Sun, 1 May 2022 15:01:39 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav412.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp);
 Sun, 01 May 2022 15:01:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav412.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 24161cGf001728
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 1 May 2022 15:01:38 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e25078f4-96f4-482c-b5da-a4a22d88b072@I-love.SAKURA.ne.jp>
Date:   Sun, 1 May 2022 15:01:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: [PATCH] wfx: avoid flush_workqueue(system_highpri_wq) usage
Content-Language: en-US
To:     =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        Kalle Valo <kvalo@kernel.org>
References: <20220225112405.355599-1-Jerome.Pouiller@silabs.com>
 <20220225112405.355599-10-Jerome.Pouiller@silabs.com>
 <033f49bc-cc31-7384-7a7c-5d3c45ce9594@I-love.SAKURA.ne.jp>
 <4557835.LvFx2qVVIh@pc-42>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <4557835.LvFx2qVVIh@pc-42>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Flushing system-wide workqueues is dangerous and will be forbidden.
Replace system_highpri_wq with local wfx_wq.

While we are at it, add missing spi_unregister_driver() call when
sdio_register_driver() failed.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Note: This patch is only compile tested.

 drivers/net/wireless/silabs/wfx/bh.c     |  6 +++---
 drivers/net/wireless/silabs/wfx/hif_tx.c |  2 +-
 drivers/net/wireless/silabs/wfx/main.c   | 11 +++++++++++
 drivers/net/wireless/silabs/wfx/wfx.h    |  2 ++
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/silabs/wfx/bh.c b/drivers/net/wireless/silabs/wfx/bh.c
index bcea9d5b119c..377dd8b010e2 100644
--- a/drivers/net/wireless/silabs/wfx/bh.c
+++ b/drivers/net/wireless/silabs/wfx/bh.c
@@ -267,7 +267,7 @@ void wfx_bh_request_rx(struct wfx_dev *wdev)
 	wfx_control_reg_read(wdev, &cur);
 	prev = atomic_xchg(&wdev->hif.ctrl_reg, cur);
 	complete(&wdev->hif.ctrl_ready);
-	queue_work(system_highpri_wq, &wdev->hif.bh);
+	queue_work(wfx_wq, &wdev->hif.bh);
 
 	if (!(cur & CTRL_NEXT_LEN_MASK))
 		dev_err(wdev->dev, "unexpected control register value: length field is 0: %04x\n",
@@ -280,7 +280,7 @@ void wfx_bh_request_rx(struct wfx_dev *wdev)
 /* Driver want to send data */
 void wfx_bh_request_tx(struct wfx_dev *wdev)
 {
-	queue_work(system_highpri_wq, &wdev->hif.bh);
+	queue_work(wfx_wq, &wdev->hif.bh);
 }
 
 /* If IRQ is not available, this function allow to manually poll the control register and simulate
@@ -295,7 +295,7 @@ void wfx_bh_poll_irq(struct wfx_dev *wdev)
 	u32 reg;
 
 	WARN(!wdev->poll_irq, "unexpected IRQ polling can mask IRQ");
-	flush_workqueue(system_highpri_wq);
+	flush_workqueue(wfx_wq);
 	start = ktime_get();
 	for (;;) {
 		wfx_control_reg_read(wdev, &reg);
diff --git a/drivers/net/wireless/silabs/wfx/hif_tx.c b/drivers/net/wireless/silabs/wfx/hif_tx.c
index 9c653d0e9034..85c68b1b11c4 100644
--- a/drivers/net/wireless/silabs/wfx/hif_tx.c
+++ b/drivers/net/wireless/silabs/wfx/hif_tx.c
@@ -73,7 +73,7 @@ int wfx_cmd_send(struct wfx_dev *wdev, struct wfx_hif_msg *request,
 
 	if (no_reply) {
 		/* Chip won't reply. Ensure the wq has send the buffer before to continue. */
-		flush_workqueue(system_highpri_wq);
+		flush_workqueue(wfx_wq);
 		ret = 0;
 		goto end;
 	}
diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wireless/silabs/wfx/main.c
index e575a81ca2ca..d3d18c498dd0 100644
--- a/drivers/net/wireless/silabs/wfx/main.c
+++ b/drivers/net/wireless/silabs/wfx/main.c
@@ -40,6 +40,8 @@ MODULE_DESCRIPTION("Silicon Labs 802.11 Wireless LAN driver for WF200");
 MODULE_AUTHOR("J辿r担me Pouiller <jerome.pouiller@silabs.com>");
 MODULE_LICENSE("GPL");
 
+struct workqueue_struct *wfx_wq;
+
 #define RATETAB_ENT(_rate, _rateid, _flags) { \
 	.bitrate  = (_rate),   \
 	.hw_value = (_rateid), \
@@ -473,10 +475,18 @@ static int __init wfx_core_init(void)
 {
 	int ret = 0;
 
+	wfx_wq = alloc_workqueue("wfx_wq", WQ_HIGHPRI, 0);
+	if (!wfx_wq)
+		return -ENOMEM;
 	if (IS_ENABLED(CONFIG_SPI))
 		ret = spi_register_driver(&wfx_spi_driver);
 	if (IS_ENABLED(CONFIG_MMC) && !ret)
 		ret = sdio_register_driver(&wfx_sdio_driver);
+	if (ret) {
+		if (IS_ENABLED(CONFIG_SPI))
+			spi_unregister_driver(&wfx_spi_driver);
+		destroy_workqueue(wfx_wq);
+	}
 	return ret;
 }
 module_init(wfx_core_init);
@@ -487,5 +497,6 @@ static void __exit wfx_core_exit(void)
 		sdio_unregister_driver(&wfx_sdio_driver);
 	if (IS_ENABLED(CONFIG_SPI))
 		spi_unregister_driver(&wfx_spi_driver);
+	destroy_workqueue(wfx_wq);
 }
 module_exit(wfx_core_exit);
diff --git a/drivers/net/wireless/silabs/wfx/wfx.h b/drivers/net/wireless/silabs/wfx/wfx.h
index 6594cc647c2f..ea0ba002eb1f 100644
--- a/drivers/net/wireless/silabs/wfx/wfx.h
+++ b/drivers/net/wireless/silabs/wfx/wfx.h
@@ -159,4 +159,6 @@ static inline int memzcmp(void *src, unsigned int size)
 	return memcmp(buf, buf + 1, size - 1);
 }
 
+extern struct workqueue_struct *wfx_wq;
+
 #endif
-- 
2.34.1


