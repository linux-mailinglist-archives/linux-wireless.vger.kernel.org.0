Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475406FDC11
	for <lists+linux-wireless@lfdr.de>; Wed, 10 May 2023 12:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbjEJK6u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 May 2023 06:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjEJK6t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 May 2023 06:58:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F7819B
        for <linux-wireless@vger.kernel.org>; Wed, 10 May 2023 03:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=whokt5//vygFHy1Ckdo8X6MwMjdU2MsaxJEikZwrvKw=;
        t=1683716328; x=1684925928; b=dLaiG4Erec90gEQ73u59BpTfMjJO/c3rf+HmY3Ol0tOoqoz
        CeqoRazVkEnRm3C8i7/bX881F/cS9oAsa1wt3H5bi2R89wwh8hEW07qZ+UxXQ9r9UCl1L32r05XGf
        uJKHt0BNfe7x+sHe7UGP/x6J5oJvmuI0OZJYu3qyt/D6fBEx5itIRv5srnd1BGb38yxnR8muoc3oi
        VP576Sl1W2E7fKQx2MBgroFX8h5z3nsFUEuSpE/9/4vdGlKzlknBYmeKYpy3k9nyhKHLq7Fo2BfF6
        wJ9iYXUJpMIhCU71LhcAwpW0x5pWvIjRzwLEXMTdCQs300os6JDG85SVSR8zVzcQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pwhWu-005MRc-2L;
        Wed, 10 May 2023 12:58:44 +0200
Message-ID: <12d77a1427cb4c0888783d8544772e3c2d1a8908.camel@sipsolutions.net>
Subject: Re: wireless locking simplifications
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Benjamin Berg <benjamin@sipsolutions.net>
Date:   Wed, 10 May 2023 12:58:43 +0200
In-Reply-To: <ZFV6fTH_7umEa5H0@slm.duckdns.org>
References: <f3471853cd7063a4bd2d783caa14706ee9115748.camel@sipsolutions.net>
         <ZFV6fTH_7umEa5H0@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Tejun,

> There isn't currently but workqueue already does something similar for
> freezing by temporarily setting max_active to zero, so if you apply a pat=
ch
> like the following

Thanks for that! I came up with a bit of a different patch, see below.

Does that seem more or less reasonable?

johannes


diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index ac551b8ee7d9..5e2413017a89 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -340,6 +340,7 @@ enum {
 	__WQ_ORDERED		=3D 1 << 17, /* internal: workqueue is ordered */
 	__WQ_LEGACY		=3D 1 << 18, /* internal: create*_workqueue() */
 	__WQ_ORDERED_EXPLICIT	=3D 1 << 19, /* internal: alloc_ordered_workqueue()=
 */
+	__WQ_PAUSED		=3D 1 << 20, /* internal: workqueue_pause() */
=20
 	WQ_MAX_ACTIVE		=3D 512,	  /* I like 512, better ideas? */
 	WQ_MAX_UNBOUND_PER_CPU	=3D 4,	  /* 4 * #cpus for unbound wq */
@@ -474,6 +475,31 @@ extern void print_worker_info(const char *log_lvl, str=
uct task_struct *task);
 extern void show_all_workqueues(void);
 extern void show_one_workqueue(struct workqueue_struct *wq);
 extern void wq_worker_comm(char *buf, size_t size, struct task_struct *tas=
k);
+extern void __workqueue_pause_resume(struct workqueue_struct *wq, bool pau=
se);
+
+/**
+ * workqueue_pause - pause a workqueue
+ * @wq: workqueue to pause
+ *
+ * Pause (and flush) the given workqueue so it's not executing any
+ * work structs and won't until workqueue_resume() is called.
+ */
+static inline void workqueue_pause(struct workqueue_struct *wq)
+{
+	__workqueue_pause_resume(wq, true);
+}
+
+/**
+ * workqueue_resume - resume a paused workqueue
+ * @wq: workqueue to resume
+ *
+ * Resume the given workqueue that was paused previously to
+ * make it run work structs again.
+ */
+static inline void workqueue_resume(struct workqueue_struct *wq)
+{
+	__workqueue_pause_resume(wq, false);
+}
=20
 /**
  * queue_work - queue work on a workqueue
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b8b541caed48..418d99ff8325 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3863,10 +3863,16 @@ static void pwq_adjust_max_active(struct pool_workq=
ueue *pwq)
 	struct workqueue_struct *wq =3D pwq->wq;
 	bool freezable =3D wq->flags & WQ_FREEZABLE;
 	unsigned long flags;
+	int new_max_active;
=20
-	/* for @wq->saved_max_active */
+	/* for @wq->saved_max_active and @wq->flags */
 	lockdep_assert_held(&wq->mutex);
=20
+	if (wq->flags & __WQ_PAUSED)
+		new_max_active =3D 0;
+	else
+		new_max_active =3D wq->saved_max_active;
+
 	/* fast exit for non-freezable wqs */
 	if (!freezable && pwq->max_active =3D=3D wq->saved_max_active)
 		return;
@@ -4642,6 +4648,25 @@ void workqueue_set_max_active(struct workqueue_struc=
t *wq, int max_active)
 }
 EXPORT_SYMBOL_GPL(workqueue_set_max_active);
=20
+void __workqueue_pause_resume(struct workqueue_struct *wq, bool pause)
+{
+	struct pool_workqueue *pwq;
+
+	mutex_lock(&wq->mutex);
+	if (pause)
+		wq->flags |=3D __WQ_PAUSED;
+	else
+		wq->flags &=3D ~__WQ_PAUSED;
+
+	for_each_pwq(pwq, wq)
+		pwq_adjust_max_active(pwq);
+	mutex_unlock(&wq->mutex);
+
+	if (pause)
+		flush_workqueue(wq);
+}
+EXPORT_SYMBOL_GPL(__workqueue_pause_resume);
+
 /**
  * current_work - retrieve %current task's work struct
  *

