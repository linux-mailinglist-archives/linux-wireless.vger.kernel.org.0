Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8633E54783A
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jun 2022 04:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiFLCIV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Jun 2022 22:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiFLCIU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Jun 2022 22:08:20 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE755419C
        for <linux-wireless@vger.kernel.org>; Sat, 11 Jun 2022 19:08:17 -0700 (PDT)
Received: from fsav413.sakura.ne.jp (fsav413.sakura.ne.jp [133.242.250.112])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 25C282Wu069561;
        Sun, 12 Jun 2022 11:08:02 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav413.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp);
 Sun, 12 Jun 2022 11:08:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav413.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 25C2817V069557
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 12 Jun 2022 11:08:02 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7191382d-8794-ccb6-791b-01693cbd0921@I-love.SAKURA.ne.jp>
Date:   Sun, 12 Jun 2022 11:08:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ath6kl: avoid flush_scheduled_work() usage
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <8de85fd9-50a1-aad7-86f7-24834be8bbc0@I-love.SAKURA.ne.jp>
 <acb6a5e3-d349-76da-27fc-3377d3343dc0@quicinc.com>
 <376b3413-c584-192c-756d-609f7c55d742@quicinc.com>
 <886f1a69-5688-196c-90f1-e1324e941e77@I-love.SAKURA.ne.jp>
In-Reply-To: <886f1a69-5688-196c-90f1-e1324e941e77@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2022/06/11 7:51, Tetsuo Handa wrote:
> On 2022/06/11 4:10, Jeff Johnson wrote:
>> On 6/10/2022 12:05 PM, Jeff Johnson wrote:
>>>> +static int __init ath6kl_init(void)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    ath6kl_wq = alloc_workqueue("ath6kl_wq", 0, 0);
>>>> +    if (!ath6kl_wq)
>>>> +        return -ENOMEM;
>>>
>>> this approach means the driver will always allocate a workqueue even if the associated hardware is never present.
> 
> Creating a WQ without WQ_MEM_RECLAIM flag consumes little resource.

My understanding is that a loadable kernel module file is modprobe'd when
the kernel detected a hardware and some userspace program determined a .ko
file to use based on device IDs database). Thus, I think it is very likely
that an associated hardware presents if module's __init function is called.

If a module is built-in, that user is ready to tolerate memory footprint
wasted by non-present hardware. And I think memory wasted by keeping an
unused !WQ_MEM_RECLAIM workqueue is much smaller than memory wasted by
keeping that module.

Thus, I wonder who complains about creating possibly unused !WQ_MEM_RECLAIM
workqueue, unless that module is designed for tiny embedded environments.

> 
>>>
>>> did you consider instead having the allocation take place within the processing of ath6kl_usb_probe() and the destroy take place within the processing of ath6kl_usb_pm_remove()?
>>
>> typo: ath6kl_usb_pm_remove() => ath6kl_usb_remove()
> 
> Technically possible to use ath6kl_usb_create()/ath6kl_usb_destroy() if you prefer it.
> 
> Do you want ath6kl_wq be shared within this module (using a refcount), or be local to
> each "struct ath6kl_usb" (adding a member and accessing via usb_get_intfdata()) ?
> 

Anyway, here goes per "struct ath6kl_usb" version.


From 00c560307d72abffea29409328be8cd69abecc95 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sun, 12 Jun 2022 10:38:03 +0900
Subject: [PATCH v2] ath6kl: avoid flush_scheduled_work() usage

Use local wq in order to avoid flush_scheduled_work() usage.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v2:
  Use per "struct ath6kl_usb" workqueue instead of per module workqueue.

Please see commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue()
using a macro") for background.

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

