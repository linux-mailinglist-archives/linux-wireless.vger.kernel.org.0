Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C770424FC68
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 13:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgHXLSv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 07:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgHXLQH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 07:16:07 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0313C061573
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 04:16:06 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id e187so4944059ybc.5
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 04:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S9OVpQer5jnHzcoLD60PVX5V0XIkbiXuXSZx4epkugw=;
        b=eE4uoWfXh6wIMjCrvXAArIn5/gDIk5Wgfhiep5ub9Ssy6LnqnmiCxf4vSPGK4nXoP2
         67qv6il5qpv94GBCoGkw5Zou4SDgLFPy1s9kLAo9Ah5cf8eqJrmEv5hBo06PFTq46s+Q
         XavsyE3gMFgI45iLlTzLt9z+aaHKvVaJZJ04V0chLDqpBxyICq5NPMhSlmIdS35A6qNz
         96Iw5K6tlmyRDyKXbl7ntQX/lAcyxJKJ22r0xSiYQE5Nt28YK66CxC3RLuVFGCKgVWd5
         oJI7fhwJyG029EPaBVsypB8RkSVF9ZpJwbsA0hUcCG7FDzgKPKyqjk+JWVe9YzP2fv8x
         ZKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S9OVpQer5jnHzcoLD60PVX5V0XIkbiXuXSZx4epkugw=;
        b=YFuZa7pUmxgs+QLrE1UyMzTpc4YSKT/nFLxDM0z/p8iY6o+E8koPaPx02UvDFYO6Mw
         zt4e5MkPPe5iI2/S+sKCegHgjsPLJUK5Ldnk3E8u9O4Gt7/Nthr1561zpE0U0ww3BmRC
         35nTddf9dHE4unGmncY2HuVOBiNevdWLyM0/L538cFuPKTjCvB4+xYwZB3Xb5Cgve2XF
         4sWfEGyWfi5h794OkrHYSCRGC5pxo4liKiNzjATnYDZq2wlzSTnQrpeqYRjQwzIvb9Un
         VEcIWKKDIET7k272j5Sdd2SnkK60CJDm8wgvY5SifA5ZD2XIJABz3K0yKgfKgw1EH6w8
         IKlw==
X-Gm-Message-State: AOAM531lxflhRRzObyS7QcUZSSirLV1uNZUAPI+bTGJRV2vhAsqw2LzL
        CiWl96zLlZENkh6SG2KNukVZHy2nEjrHvBoMOGA=
X-Google-Smtp-Source: ABdhPJzKng6divptEH9GpGToisH7FOLBfFZoqqfRYV8WevRuyK4GtCWnxb+14YeGJY+xmC5cVD9aOSh0wOOD3djr+8c=
X-Received: by 2002:a5b:d12:: with SMTP id y18mr6403815ybp.400.1598267765977;
 Mon, 24 Aug 2020 04:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <1598243612-4627-1-git-send-email-wgong@codeaurora.org>
 <CABPxzYLjys+cXXRM5J680ZOs+6VrYt=_3rWv-gqkCod=-A1VrA@mail.gmail.com>
 <fd98989a87f2a50655dc95bdcd535c0d@codeaurora.org> <CABPxzYKvPwtQwxMfRcv9jT+d92ErhYGR91SKBH86T3Rd2QH9Qg@mail.gmail.com>
 <2d6362ce85956d0f7df2e596b89a7028@codeaurora.org>
In-Reply-To: <2d6362ce85956d0f7df2e596b89a7028@codeaurora.org>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Mon, 24 Aug 2020 16:45:54 +0530
Message-ID: <CABPxzY+Fc22ke1ygRnDs0Uds0a7n=792QN8ALXciDrnx9SQuqQ@mail.gmail.com>
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

On Mon, Aug 24, 2020 at 4:15 PM Wen Gong <wgong@codeaurora.org> wrote:
>
> On 2020-08-24 18:03, Krishna Chaitanya wrote:
> > On Mon, Aug 24, 2020 at 3:10 PM Wen Gong <wgong@codeaurora.org> wrote:
> >>
> >> On 2020-08-24 16:35, Krishna Chaitanya wrote:
> >> > On Mon, Aug 24, 2020 at 10:03 AM Wen Gong <wgong@codeaurora.org> wrote:
> >> >>
> >> >> It happened "Kernel panic - not syncing: hung_task: blocked tasks"
> >> >> when
> >> >> test simulate crash and ifconfig down/rmmod meanwhile.
> >> >>
> >> ...
> >> >>
> >> >>  #ifdef CONFIG_PM
> >> > Even though your DUT is SDIO based we should be doing this in general
> >> > for all, no?
> >> > core_restart + hif_stop is common to all.
> >> this patch does not have core_restart.
> > I was referring to the combination which is causing the issue.
> >
> >> I dit not hit the issue for others bus(PCIe,SNOC...), so I can not
> >> change them with a
> >> assumption they also have this issue.
> > But that doesn't make sense, the combination is being hit for others
> > also.
> > (they should also endup calling napi_disable twice?) or they are using
> > some other check to avoid this (doesn't appear so from a quick look at
> > the
> > code).
> Because I only use SDIO, I did not use others BUS, so I did not hit the
> issue
> on other BUS.
I understand, my point was based on the description the issue looks independent
of the BUS type, so, the fix should also be generic. I understand that
your testing
is only focused on SDIO, but we should have a generic fix and probably use
communities help to get it tested rather than fixing SDIO only.
> >
> > So, I am back to my initial guess that the SDIO specific async_rx_work
> > is
> > causing/aggravating this issue.
> the commit log of this patch has explain the reason, it is not caused by
> the
> async_rx_work and I have started the "ath10k: cancel rx worker in
> hif_stop for SDIO"
> for async_rx_work.
Sure.
