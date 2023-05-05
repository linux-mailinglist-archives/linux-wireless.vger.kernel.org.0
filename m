Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB176F8BA2
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 23:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjEEVwj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 May 2023 17:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjEEVwi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 May 2023 17:52:38 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1713A4C20
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 14:52:37 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64115e652eeso22764960b3a.0
        for <linux-wireless@vger.kernel.org>; Fri, 05 May 2023 14:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683323556; x=1685915556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJn8XjO8nC745+uxlIGAzXdUeqFmmI57N+GXJ6UUe9s=;
        b=nj6cAvzcg+4o8XbRgRM1LWDhL4kV/QSYZhcuOq9p8vlYBHwvzaG8UIaJey3jJ3es89
         i7NmNnDjmQ20wu5kxZJEtJDUQwPwXM7eYtuCQnOUzZiY5kv55hlzaciFq4Qzg/xZkZvj
         +gk9tq8qm6yyzSLYuIYWpI1G8OYp7IrS1CMJVcEdsjdv+4mM8SbN7asYmBBC6vCMVcjg
         vY6IfkDyZIbRQQNIqN+oFxNsTiOrh/gS392Y+kd7Qn/Gm6qfaAcbQurMqzoHlcGQx5K9
         GjvrstqsSzm/yPEmv/2PZuGa6W3UAHrWTaMEQXsltXKngI7SShhKDfZm7ighPV7NZvYx
         sU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683323556; x=1685915556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJn8XjO8nC745+uxlIGAzXdUeqFmmI57N+GXJ6UUe9s=;
        b=TAyiFf0LyP7KmAiRnNF2XhkYxo7YXLVwam4jx3m2Qtqd+4FcPnjL4uDYHUe8IovHjM
         99aDJfMPjY6IGTK2fTy69nLvpG6JUpW4A9ZsuxRSP7GZXYCRAykNypKEk1NJ5lDCsj+C
         0QuxwGZmNYb9oiPu+et2hmsFnpahi5aRXu+WrLxFfBFTgZX+1zPpvPj6Yh4XKUFt8yHh
         FFTOKyz0IiTuG/VTqHniXEw7yb1d/WsPuu3Nbd6UdfhiYSXk3J5hQEmIrbTl6KwUXgUl
         +qCDSdkXtUCiB8R+JL3ws5Q2ScBJURcWJ9kk2V6/Cogkj0XA3ZDBVh+hDhaapw1d/BhT
         1MvA==
X-Gm-Message-State: AC+VfDwVm/ZAVTfEZXmMKj0SRU+usqgHH8Rysw/V9ggu33xvB92R5Ulb
        FICVWaHkghgoBWzozcfPZrk=
X-Google-Smtp-Source: ACHHUZ5oGXjGhQU2c7mRpaICVoHMkL34PuMwosrMIfqPsUjDceQIeiRX6p+1tMRTFZACv7gHduJvcw==
X-Received: by 2002:a17:903:32c6:b0:1ab:1e6f:74d1 with SMTP id i6-20020a17090332c600b001ab1e6f74d1mr10906773plr.0.1683323556275;
        Fri, 05 May 2023 14:52:36 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id z24-20020a1709028f9800b001a95aef9728sm2251572plo.19.2023.05.05.14.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 14:52:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 5 May 2023 11:51:57 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Benjamin Berg <benjamin@sipsolutions.net>
Subject: Re: wireless locking simplifications
Message-ID: <ZFV6fTH_7umEa5H0@slm.duckdns.org>
References: <f3471853cd7063a4bd2d783caa14706ee9115748.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3471853cd7063a4bd2d783caa14706ee9115748.camel@sipsolutions.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello, Johannes.

On Fri, May 05, 2023 at 11:05:45PM +0200, Johannes Berg wrote:
...
> The implementation of (2) is a bit ... awkward, @Tejun, @Lai, there's no
> way to "pause" an ordered workqueue, is there? I came up with the below
> patch, but it's a bit ugly and requires a lot of context switches. Just
> flushing isn't enough since then some work might start and hang on
> acquiring the lock.

There isn't currently but workqueue already does something similar for
freezing by temporarily setting max_active to zero, so if you apply a patch
like the following

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b8b541caed48..6daf9ee7450d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4360,11 +4360,11 @@ static int wq_clamp_max_active(int max_active, unsigned int flags,
 {
 	int lim = flags & WQ_UNBOUND ? WQ_UNBOUND_MAX_ACTIVE : WQ_MAX_ACTIVE;
 
-	if (max_active < 1 || max_active > lim)
+	if (max_active < 0 || max_active > lim)
 		pr_warn("workqueue: max_active %d requested for %s is out of range, clamping between %d and %d\n",
 			max_active, name, 1, lim);
 
-	return clamp_val(max_active, 1, lim);
+	return clamp_val(max_active, 0, lim);
 }
 
 /*
@@ -4625,7 +4625,8 @@ void workqueue_set_max_active(struct workqueue_struct *wq, int max_active)
 	struct pool_workqueue *pwq;
 
 	/* disallow meddling with max_active for ordered workqueues */
-	if (WARN_ON(wq->flags & __WQ_ORDERED_EXPLICIT))
+	if (WARN_ON((wq->flags & __WQ_ORDERED_EXPLICIT) &&
+		    max_active != 0 && max_active != 1))
 		return;
 
 	max_active = wq_clamp_max_active(max_active, wq->flags, wq->name);

and then do set_max_active(wq, 0) followed by flush_workqueue(), it should
be paused until max_active is restored to 1. It probably would be better to
add a separate pause / resume interface which sets a per-wq flag which is
read by pwq_adjust_max_active() tho. Anyways, it's not difficult to
implement at all.

Thanks.

-- 
tejun
