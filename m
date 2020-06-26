Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3458820BBD8
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2020 23:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgFZVtQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jun 2020 17:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgFZVtP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jun 2020 17:49:15 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5F0C03E97A
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2020 14:49:15 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id r9so3513156ual.1
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2020 14:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UILKlvs+GHBhKFphEyncEpPSUsoHCqFUMYUBW3SvT5s=;
        b=jKgTWVCFrYAd3dJXBqQFQxSBYQjuuixCxOjPukeyqxUO/e+fi8dK32Eh9DjzJtOLL1
         nFWBuOWUVUO7aVSpIP1hVhfwFGkZBUrnRhfWlAH8a5WeFoRMyEyPpabt6LRLzTLDWcOA
         CqkvBWP4wDRZPRHKmpKJwVEZuyNtMSBjHBQLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UILKlvs+GHBhKFphEyncEpPSUsoHCqFUMYUBW3SvT5s=;
        b=H7ivXN4g3OJJi2ztUUoTbmnxzxqsr3pGqLqrhQp6MgmvfYEImEAF1NCtmJNxD1qCbm
         Wjl3oaV0wuwBbrH9X8pdxvQPwAtiJ7ndl9ZrVCgflOMjPK3Q43uPvxzu3eKP0fILn7Ok
         hTnQRVYEnci+qvSVVBsiCdCZL6Hiwm50v8DXpdpDhkDDtGH+KPCsCjkBDz5pBt01OuV3
         zWTnvhT4imW8Ynqszwqusy+RY70PrjDJ6AvcNUNBfhYxn3umOZU+w/6A0pa8YgGXaPEO
         fDlVEak7KlW3H/afN+C46X5LMBWpMHl9JofzpuBEdZ0tSoT81TWg4WNyNp++WM/RBuCS
         4ApA==
X-Gm-Message-State: AOAM533CpXPoamlivVYgkj9PA2gZU08kdDOhbfdBy5uaCSuNXJ78JujQ
        zEywfuw9egmZDfO4x6GuVeB+Y7Nkq3Q=
X-Google-Smtp-Source: ABdhPJzqfGuce8Ah6ZwdnotaHom1t5I7sTh+OAWIqBK4lVdbJHQSiQQfB/wTjrh1G7rc3yfhO5BwFw==
X-Received: by 2002:ab0:60c2:: with SMTP id g2mr4140415uam.36.1593208153933;
        Fri, 26 Jun 2020 14:49:13 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id k23sm3256856vkn.24.2020.06.26.14.49.13
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 14:49:13 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id m25so6252695vsp.8
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2020 14:49:13 -0700 (PDT)
X-Received: by 2002:a67:62c4:: with SMTP id w187mr4135305vsb.109.1593208152714;
 Fri, 26 Jun 2020 14:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <1593193967-29897-1-git-send-email-pillair@codeaurora.org> <CAD=FV=V_ynwukeR92nbJXkuQ7OAW4mLaTjxko7fXt5aEfDUNhA@mail.gmail.com>
In-Reply-To: <CAD=FV=V_ynwukeR92nbJXkuQ7OAW4mLaTjxko7fXt5aEfDUNhA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 26 Jun 2020 14:49:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XJDmGbEJQ1U-VDuN2p0+V+uRm_1=DwBnDPmPQsXqS4ZA@mail.gmail.com>
Message-ID: <CAD=FV=XJDmGbEJQ1U-VDuN2p0+V+uRm_1=DwBnDPmPQsXqS4ZA@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Add interrupt summary based CE processing
To:     Rakesh Pillai <pillair@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Fri, Jun 26, 2020 at 2:37 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Jun 26, 2020 at 10:53 AM Rakesh Pillai <pillair@codeaurora.org> wrote:
> >
> > Currently the NAPI processing loops through all
> > the copy engines and processes a particular copy
> > engine is the copy completion is set for that copy
> > engine. The host driver is not supposed to access
> > any copy engine register after clearing the interrupt
> > status register.
> >
> > This might result in kernel crash like the one below
> > [ 1159.220143] Call trace:
> > [ 1159.220170]  ath10k_snoc_read32+0x20/0x40 [ath10k_snoc]
> > [ 1159.220193]  ath10k_ce_per_engine_service_any+0x78/0x130 [ath10k_core]
> > [ 1159.220203]  ath10k_snoc_napi_poll+0x38/0x8c [ath10k_snoc]
> > [ 1159.220270]  net_rx_action+0x100/0x3b0
> > [ 1159.220312]  __do_softirq+0x164/0x30c
> > [ 1159.220345]  run_ksoftirqd+0x2c/0x64
> > [ 1159.220380]  smpboot_thread_fn+0x1b0/0x288
> > [ 1159.220405]  kthread+0x11c/0x12c
> > [ 1159.220423]  ret_from_fork+0x10/0x18
> >
> > To avoid such a scenario, we generate an interrupt
> > summary by reading the copy completion for all the
> > copy engine before actually processing any of them.
> > This will avoid reading the interrupt status register
> > for any CE after the interrupt status is cleared.
> >
> > Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
> >
> > Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
> > ---
> >  drivers/net/wireless/ath/ath10k/ce.c | 63 ++++++++++++++++++++++--------------
> >  drivers/net/wireless/ath/ath10k/ce.h |  5 +--
> >  2 files changed, 42 insertions(+), 26 deletions(-)
>
> I'm not an expert on this driver, but your change seems sane to me.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> With your patch I can no longer find a place to put in a magic delay
> and reproduce the crash, thus:
>
> Tested-by: Douglas Anderson <dianders@chromium.org>
>
>
> If it matters, my WiFi firmware reports this:
>
> WLAN.HL.3.2.2-00490-QCAHLSWMTPL-1
>
> ...and it should also be WCN3990.

I should also note that, while I'm not terribly familiar with Kalle's
workflow, I would have expected to see him in the "To:" list.  I've
added him, but it's possible he'll need you to repost the patch with
him in the "To:" list.

-Doug
