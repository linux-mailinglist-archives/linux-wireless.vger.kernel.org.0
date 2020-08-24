Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA3D24FAFA
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 12:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgHXKEM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 06:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgHXKEK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 06:04:10 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB941C061573
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 03:04:09 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id g3so4852168ybc.3
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 03:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SWJ6Jq5FvLQuWBZmS4Mo7RaIBatUYrlSs7lVSYi0l6s=;
        b=nTvHT8lA4gEoBngQJjBeuCxMuD2twp0zYL0/sO7MIPjnOs5FpHCfVyv5IuHJouS2wS
         vZrMHe0PQggnAHABoUP13gDEG7c1f805T5/6Wn8O2cBCpbrg0Lur0InRrCccCnYBl8LD
         +oAauxTkhVWH9luxUf6jviadGDDgK/faKYSxv3B90cTeiv1Pzss0HD6h1e9tmc9x7LqW
         pBg+6I52tvBHUD70qG+L7W6spySg+l5ygGhQeM1D0jep8rT18rpzCE4Sra0/JBHj3TNa
         JL9V0MwC/4Nn0peORq8TYJ+kmYxxb7E+lSwKsjqZBnKYdv73NFnh+8ane2IL1EDbwclh
         kwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SWJ6Jq5FvLQuWBZmS4Mo7RaIBatUYrlSs7lVSYi0l6s=;
        b=jW95AAj+mVakqVIASZon1lMG2JJbsJqPQO99+AzqieaC5XCoIRe4pFitpjg+fCLiGJ
         QoUbQB7wU6W/QlY8B9E+uG/sL6VulWmcKtlIL+RP/nXJ/czNu20urg7nvXUUPFOLIqjv
         TH3f66qcV8SG4R+vz7z8oOZg3cKnXD0uz8F7CQXMPC7rdHTSK7VkdZnYRSr326xct43k
         lhDLqYBfYz7DaZI6oBBFE/3up68uI9p2TvlBDTcOFxONS2QHu42kwIXwPnSmmKP/5jzL
         HgTlm/IOtrr9D/a9MELNHJK0I/dUXEJtLB30zdEHDuXJrsfUx8Pj3u3aHKXfMd8Bte+k
         ybpg==
X-Gm-Message-State: AOAM531gsLLVkGxL7JXC67u/8aYFIBvbG8dXoflRBScVxZ3IsXZ9b+eC
        IBV6IGAgrj8Tm2KgzuLD4vPIy/2tpv21OIjwsBKh4k7F07Y=
X-Google-Smtp-Source: ABdhPJyXyjvDC7pPPnLsHiQTqp1AFvH/QHYELPdiL7XOsC8dxPM1T+GMX6vho/rMOmbl5Sj58eGpYC5AtkvnJeKX84k=
X-Received: by 2002:a25:1683:: with SMTP id 125mr5814653ybw.145.1598263448882;
 Mon, 24 Aug 2020 03:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <1598243612-4627-1-git-send-email-wgong@codeaurora.org>
 <CABPxzYLjys+cXXRM5J680ZOs+6VrYt=_3rWv-gqkCod=-A1VrA@mail.gmail.com> <fd98989a87f2a50655dc95bdcd535c0d@codeaurora.org>
In-Reply-To: <fd98989a87f2a50655dc95bdcd535c0d@codeaurora.org>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Mon, 24 Aug 2020 15:33:57 +0530
Message-ID: <CABPxzYKvPwtQwxMfRcv9jT+d92ErhYGR91SKBH86T3Rd2QH9Qg@mail.gmail.com>
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

On Mon, Aug 24, 2020 at 3:10 PM Wen Gong <wgong@codeaurora.org> wrote:
>
> On 2020-08-24 16:35, Krishna Chaitanya wrote:
> > On Mon, Aug 24, 2020 at 10:03 AM Wen Gong <wgong@codeaurora.org> wrote:
> >>
> >> It happened "Kernel panic - not syncing: hung_task: blocked tasks"
> >> when
> >> test simulate crash and ifconfig down/rmmod meanwhile.
> >>
> ...
> >>
> >>  #ifdef CONFIG_PM
> > Even though your DUT is SDIO based we should be doing this in general
> > for all, no?
> > core_restart + hif_stop is common to all.
> this patch does not have core_restart.
I was referring to the combination which is causing the issue.

> I dit not hit the issue for others bus(PCIe,SNOC...), so I can not
> change them with a
> assumption they also have this issue.
But that doesn't make sense, the combination is being hit for others also.
(they should also endup calling napi_disable twice?) or they are using
some other check to avoid this (doesn't appear so from a quick look at the
code).

So, I am back to my initial guess that the SDIO specific async_rx_work is
causing/aggravating this issue.
