Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDDD340DE5
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Mar 2021 20:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbhCRTLM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Mar 2021 15:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhCRTLB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Mar 2021 15:11:01 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80EAC06174A
        for <linux-wireless@vger.kernel.org>; Thu, 18 Mar 2021 12:11:01 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id d2so5892249ilm.10
        for <linux-wireless@vger.kernel.org>; Thu, 18 Mar 2021 12:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hl/o1czNNh5eByBOw2SNzW+IoLTK83DZiXZSJxM0tiQ=;
        b=tgdA7HX1OB8coNDG57ztJeSNSTNOPXdyhJEVRUaRg6O4ah3TJqZjg6gfYl89R/o8UG
         E/ySnIL7fH5xxigZCGthDXYlPYwHEeF0GlLTQUWqGpjR7GIkbhf9f4ZJUHS7q5RD8TX3
         HnrO5Tr0wm++4l8QiDI5HAIaNhw99ljY4U3YFHyeGjXHbrRgpYM9J7DBrZxQLzrN28TC
         ghtD1NRyXzPm09bLSm83KoYmEvdlmLaj3PcLVQTmCOfQC6rEfnc16C9jysMJx1//slKr
         YYK0Es5YmWa+RFjA630FKrbwwKaRWU1RWTWbtqGEHaUZgjGmxEuXA+Zel7H0WMZsUjFJ
         5xoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hl/o1czNNh5eByBOw2SNzW+IoLTK83DZiXZSJxM0tiQ=;
        b=AGnieHShl5omyv/TNWB03nnd1AfpsGJpnZoWehhNIuBBIH0Q8LzJmfxsO6x1KtwsRb
         F/fGA5oik8wVcZw+IBqz1HcFeLJWHoMcvtCgjC8cnaJkQdwQAGGXN1/LeNXRHI0R7OEM
         F07wCnSLI/zvtdc8N9DyeSkz+guY+xcCpvBBOfbQmX9EmbTlTGLs+hxnM5yxX4iZjdqm
         ywAdUbdzoOkv3m/r10UwBDn8yk6gLI4WnTq0liu5OSBwZN1oAT4nhe+FYLbLixMZ75lm
         fpmSw9gR9wVzClqUnfZfNtOAwRW55IDT95CDtGssOrL44qp5DC3OhapBQeN/dYgbitDr
         UXEA==
X-Gm-Message-State: AOAM532sDgxMcPYpfH43/umWvksQ9yDi/kSrBYv3eYhCxtEn90y2J0aF
        qyPBtSz6J0qKfJ5fxGCccu5MPpUt91wwZbM3V0GHSd2q6cg=
X-Google-Smtp-Source: ABdhPJxoPBsJFiyUwkLlhss7mbcR+fhYKCnd2JnVlI83uwuQoRBwFEsuVUAZYqwpX26bP+xRZbqk72eyvrOo7ahmG+g=
X-Received: by 2002:a05:6e02:1411:: with SMTP id n17mr53238ilo.61.1616094661045;
 Thu, 18 Mar 2021 12:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAMn1gO7evHe+pvcFwv1XE+y090CSWwXL=pRKjZwmnrZa3j4gtg@mail.gmail.com>
 <a4502cc2a3547780b075e4ee0d3946f9b727adb9.camel@sipsolutions.net>
In-Reply-To: <a4502cc2a3547780b075e4ee0d3946f9b727adb9.camel@sipsolutions.net>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 18 Mar 2021 12:10:49 -0700
Message-ID: <CAMn1gO6PoOZyejd_Pu0fj9DHz7d8ty8-sb8voRvXd3=-XV23jA@mail.gmail.com>
Subject: Re: [PATCH v2] cfg80211: avoid holding the RTNL when calling the driver
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Mar 18, 2021 at 12:55 AM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> Hi Peter,
>
>
> > I'm seeing warnings like this on 5.12.0-rc2 which I think were caused
> > by your patch.
> >
> > [    4.898946][  T455] ------------[ cut here ]------------
> > [    4.899434][  T455] RTNL: assertion failed at net/core/dev.c (10988)
>
> Yes, sorry about that. I clearly didn't audit that particular code path
> (well enough, or at all) with the locking changes.
>
> Even worse, it probably deadlocks?

Yes, it was deadlocking after a few minutes, although at that time I
hadn't confirmed that the deadlock was being caused by the patch or by
some other issue.

> In any case, I fixed it here, I believe:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git/commit/?id=77cbf790e5b482256662e14c8b6ef4fecb07d06d

I cherry-picked that patch and tested it on my setup, and it fixed
both the warnings and the deadlocks. So if you like you can add my:

Tested-by: Peter Collingbourne <pcc@google.com>

to that patch.

Peter
