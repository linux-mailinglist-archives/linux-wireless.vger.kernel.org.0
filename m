Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357135163A3
	for <lists+linux-wireless@lfdr.de>; Sun,  1 May 2022 12:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343509AbiEAK1B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 May 2022 06:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245738AbiEAK07 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 May 2022 06:26:59 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6551CFD7
        for <linux-wireless@vger.kernel.org>; Sun,  1 May 2022 03:23:32 -0700 (PDT)
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 241ANErk075438;
        Sun, 1 May 2022 19:23:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Sun, 01 May 2022 19:23:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 241AND0j075435
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 1 May 2022 19:23:14 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <3841528e-78ae-c3c4-169a-eeb39714f7ca@I-love.SAKURA.ne.jp>
Date:   Sun, 1 May 2022 19:23:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] wfx: avoid flush_workqueue(system_highpri_wq) usage
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <20220225112405.355599-1-Jerome.Pouiller@silabs.com>
 <20220225112405.355599-10-Jerome.Pouiller@silabs.com>
 <033f49bc-cc31-7384-7a7c-5d3c45ce9594@I-love.SAKURA.ne.jp>
 <4557835.LvFx2qVVIh@pc-42>
 <e25078f4-96f4-482c-b5da-a4a22d88b072@I-love.SAKURA.ne.jp>
 <87fsltd462.fsf@kernel.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <87fsltd462.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2022/05/01 17:53, Kalle Valo wrote:
> So now the thread is created every time the module loaded, even if
> there's no device available.

Excuse me, but what thread? alloc_workqueue() without WQ_MEM_RECLAIM flag
does not create a thread, and therefore consumes little resource where
there's no device available does not matter.

>                              Also I'm not really a fan of global
> variables (wfx_wq). I would rather create a workqueue per device in
> wfx_probe() or use the workqueue provided by mac80211.

Whatever is fine. wfx is the last user of flush_workqueue(system_*_wq) and
I want to know whether I can include system_highpri_wq into below patch.

Subject: [PATCH] workqueue: wrap flush_workqueue() using a macro

While a conversion to stop flushing of kernel-global workqueues is in
progress, we can warn users who are not aware of this conversion, by
wrapping flush_workqueue() as a macro and injecting BUILD_BUG_ON() tests.

---
 include/linux/workqueue.h | 27 +++++++++++++++++++++++++++
 kernel/workqueue.c        |  1 +
 2 files changed, 28 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 7b13fae377e2..3eaf19262d19 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -654,4 +654,31 @@ int workqueue_offline_cpu(unsigned int cpu);
 void __init workqueue_init_early(void);
 void __init workqueue_init(void);
 
+/*
+ * Detect attempt to flush system-wide workqueues at compile time when possible.
+ * See https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp for
+ * reasons and steps for converting system-wide workqueues into local workqueues.
+ * Checks for system_wq and system_highpri_wq will be added after
+ * all in-tree users stopped flushing these workqueues.
+ */
+#define flush_workqueue(wq)						\
+({									\
+	BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_long_wq) && \
+			 &(wq) == &system_long_wq,			\
+			 "Please avoid flushing system_long_wq.");	\
+	BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_unbound_wq) && \
+			 &(wq) == &system_unbound_wq,			\
+			 "Please avoid flushing system_unbound_wq.");	\
+	BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_freezable_wq) &&	\
+			 &(wq) == &system_freezable_wq,			\
+			 "Please avoid flushing system_freezable_wq."); \
+	BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_power_efficient_wq) && \
+			 &(wq) == &system_power_efficient_wq,		\
+			 "Please avoid flushing system_power_efficient_wq."); \
+	BUILD_BUG_ON_MSG(__builtin_constant_p(&(wq) == &system_freezable_power_efficient_wq) &&	\
+			 &(wq) == &system_freezable_power_efficient_wq, \
+			 "Please avoid flushing system_freezable_power_efficient_wq."); \
+	flush_workqueue(wq);						\
+})
+
 #endif
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b447012df177..de53813a92d2 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2813,6 +2813,7 @@ static void warn_flush_attempt(struct workqueue_struct *wq)
  * This function sleeps until all work items which were queued on entry
  * have finished execution, but it is not livelocked by new incoming ones.
  */
+#undef flush_workqueue
 void flush_workqueue(struct workqueue_struct *wq)
 {
 	struct wq_flusher this_flusher = {
-- 
2.34.1

