Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA983251420
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Aug 2020 10:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgHYIZC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Aug 2020 04:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgHYIZB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Aug 2020 04:25:01 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F62C061574
        for <linux-wireless@vger.kernel.org>; Tue, 25 Aug 2020 01:25:01 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id e14so6694720ybf.4
        for <linux-wireless@vger.kernel.org>; Tue, 25 Aug 2020 01:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fEcm0/mWZVF6Q0LDNpH3ElgXvSjjwXFdNhIuG7jVALc=;
        b=XW04ofREcAJ0Ifn2Bx7ghqwZAJ6eYmpee02p+fHpWpSGPwdzonQ2HVri24wjPThXbK
         b8CalkQUcbT1dLkm/ttkJI8kwYMeLls/wQquKAkriwB48QLs49r1UtkPgbbiDTy5leZK
         MnLat1prRh7M/jV7kvUmAd3j8gJVuU1Q9NmDlVAtbmFwPouf3xmpj9/6YTJvf9c5bMeg
         8JVp2Lc2k6fYhyPizYbPteRi2C9pEuTwQ3TKo/MMo0U6336im6GAiEtKVziqsKFzdIHB
         lAXa9X27lnNGPYr/NaXodYlZb3RkKnSwKoov4qq/TWpM9DkbilL9esC1vBkOiPRz+4Eh
         YOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fEcm0/mWZVF6Q0LDNpH3ElgXvSjjwXFdNhIuG7jVALc=;
        b=ORNikDjESHwnLQdzEoZ2g/exMGfRkrJ2ZSmQWuUq6MPcFCDp+sY00Zvlrg3adfqZjC
         xn+k1eZ7srlHbEptAoI12ZaSLH794gjqAGM2jGL5gpQEqWuvCe0n3A6Co902O9RI420Q
         QimrtuYgZUf2t2tewin64sumgGl8+XLy9L4IaYsPUU6PLHg66B2ld96+K2AKs7VYaPrF
         O5pWZQfY55dySFSqG/S4qTfv6Xcq9A6l2Zi/j0OmeCYlU2jYJNCJaNpa6Y/+Z/zitFkQ
         pA919C7AyejyfJARCKuUfaKJnxFLD7QUu/mTaQX0yWr3gqI73ZJbzuGiLsVNk9pVj8ba
         CK5A==
X-Gm-Message-State: AOAM530iUwVnIuJMawzmNLom+T6hBuhQEZ+f5fU4dj7PrC6FFYOiCxFl
        fhyYC+WRsuM/dV3+HI9YAeowGG7L5LmfHziUhC4=
X-Google-Smtp-Source: ABdhPJw72pGJvgkVlDlRvFUsu+dipcuVagCUU/h7RIGOmhCHaJT1eigXiC5mp0od3W8c8S27pJ3MtIUtucZi/XDQ98Q=
X-Received: by 2002:a5b:308:: with SMTP id j8mr12132440ybp.185.1598343900508;
 Tue, 25 Aug 2020 01:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <1598243612-4627-1-git-send-email-wgong@codeaurora.org>
 <CABPxzYLjys+cXXRM5J680ZOs+6VrYt=_3rWv-gqkCod=-A1VrA@mail.gmail.com>
 <fd98989a87f2a50655dc95bdcd535c0d@codeaurora.org> <CABPxzYKvPwtQwxMfRcv9jT+d92ErhYGR91SKBH86T3Rd2QH9Qg@mail.gmail.com>
 <2d6362ce85956d0f7df2e596b89a7028@codeaurora.org> <CABPxzY+Fc22ke1ygRnDs0Uds0a7n=792QN8ALXciDrnx9SQuqQ@mail.gmail.com>
 <663fbb682fd8df555b2964d7d86b8eca@codeaurora.org>
In-Reply-To: <663fbb682fd8df555b2964d7d86b8eca@codeaurora.org>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Tue, 25 Aug 2020 13:54:49 +0530
Message-ID: <CABPxzYJ982LdcUD3a_tyu3rrqp+iacZrmAp4zG_3HqCiDCR_2w@mail.gmail.com>
Subject: Re: [PATCH v2] ath10k: add flag to protect napi operation to avoid
 dead loop hang for SDIO
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 25, 2020 at 9:11 AM Wen Gong <wgong@codeaurora.org> wrote:
>
> On 2020-08-24 19:15, Krishna Chaitanya wrote:
> > On Mon, Aug 24, 2020 at 4:15 PM Wen Gong <wgong@codeaurora.org> wrote:
> >>
> >> On 2020-08-24 18:03, Krishna Chaitanya wrote:
> >> > On Mon, Aug 24, 2020 at 3:10 PM Wen Gong <wgong@codeaurora.org> wrote:
> >> >>
> >> >> On 2020-08-24 16:35, Krishna Chaitanya wrote:
> >> >> > On Mon, Aug 24, 2020 at 10:03 AM Wen Gong <wgong@codeaurora.org> wrote:
> >> >> >>
> >> >> >> It happened "Kernel panic - not syncing: hung_task: blocked tasks"
> >> >> >> when
> >> >> >> test simulate crash and ifconfig down/rmmod meanwhile.
> >> >> >>
> >> >> ...
> >> >> >>
> >> >> >>  #ifdef CONFIG_PM
> >> >> > Even though your DUT is SDIO based we should be doing this in general
> >> >> > for all, no?
> >> >> > core_restart + hif_stop is common to all.
> >> >> this patch does not have core_restart.
> >> > I was referring to the combination which is causing the issue.
> >> >
> >> >> I dit not hit the issue for others bus(PCIe,SNOC...), so I can not
> >> >> change them with a
> >> >> assumption they also have this issue.
> >> > But that doesn't make sense, the combination is being hit for others
> >> > also.
> >> > (they should also endup calling napi_disable twice?) or they are using
> >> > some other check to avoid this (doesn't appear so from a quick look at
> >> > the
> >> > code).
> >> Because I only use SDIO, I did not use others BUS, so I did not hit
> >> the
> >> issue
> >> on other BUS.
> > I understand, my point was based on the description the issue looks
> > independent
> > of the BUS type, so, the fix should also be generic. I understand that
> > your testing
> > is only focused on SDIO, but we should have a generic fix and probably
> > use
> > communities help to get it tested rather than fixing SDIO only.
> I checked the ath10k, only sdio.c, snoc.c, pci.c have used napi.
> I think it can change to move the
> napi_synchronize/napi_disable/napi_enable from
> sido.c/snoc.c/pci.c to ath10k_core.ko as below:
> void ath10k_core_napi_enable(struct ath10k *ar)
> {
>         if (!ar->napi_enabled) {
>                 napi_enable(&ar->napi);
>                 ar->napi_enabled = true;
>         }
> }
> EXPORT_SYMBOL(ath10k_core_napi_enable);
>
> void ath10k_core_napi_disable_sync(struct ath10k *ar)
> {
>         if (ar->napi_enabled) {
>                 napi_synchronize(&ar->napi);
>                 napi_disable(&ar->napi);
>                 ar->napi_enabled = false;
>         }
> }
> EXPORT_SYMBOL(ath10k_core_napi_disable_sync);
>
> is it appropriate?
> ...
Yes, this is perfect. One minor comment you can just do the
check initially and return.

if (ar->napi_enabled)
   return
