Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102B840C2D1
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 11:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhIOJfd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 05:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhIOJfd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 05:35:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB784C061574
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 02:34:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631698453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=41xRZuPBc75SDYD8MwI9v1fknOh4tNXTIrjwSD3WtC4=;
        b=dX3XzyGQqmGySpI05301LTMuncmKr5WDr0f+DBEXqiD7dbsXFLDiqY90cACt6RXqB2dDJ4
        dqIt9M9P6+kK7OfBIqL5s7HkOlPsHU6DAA74sJvlt7PXvJ5NL1rxKfW+Llf2EUx5A+XNvh
        brknAQ9Ebnf5YATlzUnglMH+bBDZ4cly0xTHVZOk8fw0KNwUxHwZFbCndwGHb8/O4+tcPH
        d7DftvCLzzfD9Iovt6TnLZ8+z5s6cUKKiJT7lrL4ih8suc8RVr/5ZuWQv97sXa4CEJStF1
        R9R2KdmQY3Y9F2gHJ8ysA61mMWlrkpLeiveAf9IRH/dlTqOzlYJrGfWOthzYTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631698453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=41xRZuPBc75SDYD8MwI9v1fknOh4tNXTIrjwSD3WtC4=;
        b=pKe7nzkFSCJabMsAF446JwGUUwQiy9fuEIJWODhlobPSwwsA7PpmscK9orppL07PVjk/Xr
        HnVElffgAT0CFoAw==
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot+0e964fad69a9c462bc1e@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] mac80211-hwsim: fix late beacon hrtimer handling
In-Reply-To: <20210915112936.544f383472eb.I3f9712009027aa09244b65399bf18bf482a8c4f1@changeid>
References: <20210915112936.544f383472eb.I3f9712009027aa09244b65399bf18bf482a8c4f1@changeid>
Date:   Wed, 15 Sep 2021 11:34:12 +0200
Message-ID: <87h7emb2sr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Sep 15 2021 at 11:29, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> Thomas explained in https://lore.kernel.org/r/87mtoeb4hb.ffs@tglx
> that our handling of the hrtimer here is wrong: If the timer fires
> late (e.g. due to vCPU scheduling, as reported by Dmitry/syzbot)
> then it tries to actually rearm the timer at the next deadline,
> which might be in the past already:
>
>  1          2          3          N          N+1
>  |          |          |   ...    |          |
>
>  ^ intended to fire here (1)
>             ^ next deadline here (2)
>                                       ^ actually fired here
>
> The next time it fires, it's later, but will still try to schedule
> for the next deadline (now 3), etc. until it catches up with N,
> but that might take a long time, causing stalls etc.
>
> Now, all of this is simulation, so we just have to fix it, but
> note that the behaviour is wrong even per spec, since there's no
> value then in sending all those beacons unaligned - they should be
> aligned to the TBTT (1, 2, 3, ... in the picture), and if we're a
> bit (or a lot) late, then just resume at that point.

Well done changelog!

> Therefore, change the code to use hrtimer_forward_now() which will
> ensure that the next firing of the timer would be at N+1 (in the
> picture), i.e. the next interval point after the current time.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Reported-by: syzbot+0e964fad69a9c462bc1e@syzkaller.appspotmail.com
> Fixes: 01e59e467ecf ("mac80211_hwsim: hrtimer beacon")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
