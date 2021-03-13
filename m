Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA44339C4A
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Mar 2021 06:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhCMFuK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Mar 2021 00:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbhCMFuE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Mar 2021 00:50:04 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E95DC061574;
        Fri, 12 Mar 2021 21:50:04 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e7so4597983ile.7;
        Fri, 12 Mar 2021 21:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=3H6MFCVhLmnM09/TpAZrPH+jErh+xZ0JJNfFLNUI1zA=;
        b=s+k9bPKIXC+qokWwlf6bkEcKtiEEel9+ST3RyF9c4wAj8sP3+V17OXq3wx8w2B8UAW
         5Y2c1psiHU3JeeWYZEeZoBBXEuUyNbmDPKogoPD4+8rmqz9BIZbd3mSlaqhTjkT+y6QD
         JjstluumxjDGPH4UIo8J4/YSFO7edmF0kdbFmYrwuNSHidBsgBM2LlIweSa9D8iE4MCS
         W9ayHAJ8hsC/v3l/vRUGHtb4mr583UealXzRXwXRbvE+3xvUjMClR+hXQNIqe6Q15Ukm
         moAgzYVf7I7B3EjSGZdqXC/8mq4zCqwJSAsspJRFTGDvtMdxCNVktztFuFZDQE6QFeET
         hneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=3H6MFCVhLmnM09/TpAZrPH+jErh+xZ0JJNfFLNUI1zA=;
        b=p2EEICCjYsNVHZtsj0WE/34nI/rghF9EbRaZks/OMA9oMw+Y3DPnDt6k+eTgR6oCSL
         BTRNi6llD50sczy5ffG1vf37X4eEm30E9u47ZTv4nsaDNaRnUDUkzkJ/ou+qqXu4J3nI
         2iJa9CBDpFJ0xiVaBSAD2kOf/MzXQkhw/eTVCdHT9Ay7leJkV3mub9vnxRPoAtQL5f4U
         kvL2mZGdA1P5hKDxqnyUlR0dwr9N3y8uMND9jfvNm/FXU3DzCgGLhGWhIrlCZwKl1DdJ
         JC4pdcxyzZe5xne0uIfxUs+bIjouxDbGkqIIQdfpe+8r5NXq8Rr9y931r3kwM05WZcRn
         yfyA==
X-Gm-Message-State: AOAM533mK5ZZil6V2ljMNuMJBubnEsyckS0dgrMNOq7FRd15Kig/c7HB
        UspBJ0z9yuHX1tVxaVp2YahBaRHjyHTVgOaKdw0=
X-Google-Smtp-Source: ABdhPJwmI728apDN+oe/BL0ZrtA0TZm2Eo6i1oZJACUbMySMwdGplUtO02cn9RQnkaWIJO5PDcihZkIdo72OAyYdLbI=
X-Received: by 2002:a92:c145:: with SMTP id b5mr5248748ilh.186.1615614603364;
 Fri, 12 Mar 2021 21:50:03 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2103021125430.12405@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2103080925230.12405@cbobk.fhfr.pm> <nycvar.YFH.7.76.2103130242460.12405@cbobk.fhfr.pm>
 <87h7lfbowr.fsf@tynnyri.adurom.net>
In-Reply-To: <87h7lfbowr.fsf@tynnyri.adurom.net>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 13 Mar 2021 06:49:27 +0100
Message-ID: <CA+icZUW9uctLqNYro3ASDkwofE61Cz4E_qTjk_XQnzv-1s++aw@mail.gmail.com>
Subject: Re: [PATCH] iwlwifi: Fix softirq/hardirq disabling in iwl_pcie_enqueue_hcmd()
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Mar 13, 2021 at 6:45 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Jiri Kosina <jikos@kernel.org> writes:
>
> > On Mon, 8 Mar 2021, Jiri Kosina wrote:
> >
> >> > From: Jiri Kosina <jkosina@suse.cz>
> >> >
> >> > It's possible for iwl_pcie_enqueue_hcmd() to be called with hard IRQs
> >> > disabled (e.g. from LED core). We can't enable BHs in such a situation.
> >> >
> >> > Turn the unconditional BH-enable/BH-disable code into
> >> > hardirq-disable/conditional-enable.
> >> >
> >> > This fixes the warning below.
> >>
> >> Hi,
> >>
> >> friendly ping on this one ...
> >
> > Luca,
> >
> > Johannes is telling me that he merged this patch internally, but I have no
> > idea what is happening to it ... ?
> >
> > The reported splat is a clear bug, so it should be fixed one way or the
> > other.
>
> Should I take this to wireless-drivers?
>

If you do so, please add:

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM/Clang v12.0.0-rc3

- Sedat -

> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
