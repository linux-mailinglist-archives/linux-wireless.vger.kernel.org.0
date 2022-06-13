Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEBF548AF4
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jun 2022 18:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbiFMPpo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jun 2022 11:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238067AbiFMPpW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jun 2022 11:45:22 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ECA16CF5D
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 06:22:44 -0700 (PDT)
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 25DDLp1I091825;
        Mon, 13 Jun 2022 22:21:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Mon, 13 Jun 2022 22:21:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 25DDLoqX091818
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 13 Jun 2022 22:21:51 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f78ddbdc-8989-a1a7-2234-ce9ec3894625@I-love.SAKURA.ne.jp>
Date:   Mon, 13 Jun 2022 22:21:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: [PATCH v3] ath6kl: avoid flush_scheduled_work() usage
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <8de85fd9-50a1-aad7-86f7-24834be8bbc0@I-love.SAKURA.ne.jp>
 <acb6a5e3-d349-76da-27fc-3377d3343dc0@quicinc.com>
 <376b3413-c584-192c-756d-609f7c55d742@quicinc.com>
 <886f1a69-5688-196c-90f1-e1324e941e77@I-love.SAKURA.ne.jp>
 <7191382d-8794-ccb6-791b-01693cbd0921@I-love.SAKURA.ne.jp>
 <87pmjdouut.fsf@kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <87pmjdouut.fsf@kernel.org>
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

As per commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue() using
a macro") says, use per "struct ath6kl_usb" workqueue.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v3:
  Update patch description.

Changes in v2:
  Use per "struct ath6kl_usb" workqueue instead of per module workqueue.

This is a blind conversion, and is only compile tested.

 drivers/net/wireless/ath/ath6kl/usb.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/usb.c b/drivers/net/wireless/ath/ath6kl/usb.c
index 65e683effdcb..5220809841a6 100644
--- a/drivers/net/wireless/ath/ath6kl/usb.c
+++ b/drivers/net/wireless/ath/ath6kl/usb.c
@@ -71,6 +71,7 @@ struct ath6kl_usb {
 	u8 *diag_cmd_buffer;
 	u8 *diag_resp_buffer;
 	struct ath6kl *ar;
+	struct workqueue_struct *wq;
 };
 
 /* usb urb object */
@@ -478,7 +479,7 @@ static void ath6kl_usb_flush_all(struct ath6kl_usb *ar_usb)
 	 * Flushing any pending I/O may schedule work this call will block
 	 * until all scheduled work runs to completion.
 	 */
-	flush_scheduled_work();
+	flush_workqueue(ar_usb->wq);
 }
 
 static void ath6kl_usb_start_recv_pipes(struct ath6kl_usb *ar_usb)
@@ -544,7 +545,7 @@ static void ath6kl_usb_recv_complete(struct urb *urb)
 
 	/* note: queue implements a lock */
 	skb_queue_tail(&pipe->io_comp_queue, skb);
-	schedule_work(&pipe->io_complete_work);
+	queue_work(pipe->ar_usb->wq, &pipe->io_complete_work);
 
 cleanup_recv_urb:
 	ath6kl_usb_cleanup_recv_urb(urb_context);
@@ -579,7 +580,7 @@ static void ath6kl_usb_usb_transmit_complete(struct urb *urb)
 
 	/* note: queue implements a lock */
 	skb_queue_tail(&pipe->io_comp_queue, skb);
-	schedule_work(&pipe->io_complete_work);
+	queue_work(pipe->ar_usb->wq, &pipe->io_complete_work);
 }
 
 static void ath6kl_usb_io_comp_work(struct work_struct *work)
@@ -619,6 +620,7 @@ static void ath6kl_usb_destroy(struct ath6kl_usb *ar_usb)
 
 	kfree(ar_usb->diag_cmd_buffer);
 	kfree(ar_usb->diag_resp_buffer);
+	destroy_workqueue(ar_usb->wq);
 
 	kfree(ar_usb);
 }
@@ -631,9 +633,15 @@ static struct ath6kl_usb *ath6kl_usb_create(struct usb_interface *interface)
 	int status = 0;
 	int i;
 
+	/* ath6kl_usb_destroy() needs ar_usb != NULL && ar_usb->wq != NULL. */
 	ar_usb = kzalloc(sizeof(struct ath6kl_usb), GFP_KERNEL);
 	if (ar_usb == NULL)
-		goto fail_ath6kl_usb_create;
+		return NULL;
+	ar_usb->wq = alloc_workqueue("ath6kl_wq", 0, 0);
+	if (!ar_usb->wq) {
+		kfree(ar_usb);
+		return NULL;
+	}
 
 	usb_set_intfdata(interface, ar_usb);
 	spin_lock_init(&(ar_usb->cs_lock));
-- 
2.18.4

