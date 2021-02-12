Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9E8319BC0
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Feb 2021 10:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBLJVF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Feb 2021 04:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhBLJVA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Feb 2021 04:21:00 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1566C061574
        for <linux-wireless@vger.kernel.org>; Fri, 12 Feb 2021 01:20:16 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id a16so7613187ilq.5
        for <linux-wireless@vger.kernel.org>; Fri, 12 Feb 2021 01:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ZGziJCgfOp3eK9+SLJGjh0ud/akHMIW3uThFczcSMx4=;
        b=MRZQGrsWGqHWhzpIURx+QBesBlw1dk6Z+U/h/+f+/MEyHASFahZPBLGd9AvcarATSr
         Y20E2s0Aldi4WwvHHrNL4/8bT+jotzPP9YtqNrgoVtUxsRSxTWiiFGSqcSudsDB/K9Xl
         PAl3kibDVigvNsUlRNdqg950fdxPvYxQ0G7CxJJVWtlD/xUP7KPe8pKRW2OmANEdiMwC
         XiOelifWyD8YpJ/TICIpyjel4JBW3fLjQCdzxLK0VmrAX3+PWuJxbWljK2n4cRrX1i2P
         oYyzKdUMtoyZuhgjq325nRQVvH2FtFwX+EWie9+gbyOdTCsk7PNT+ywnABaKfC+SsRKQ
         otlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ZGziJCgfOp3eK9+SLJGjh0ud/akHMIW3uThFczcSMx4=;
        b=hGv8tLnQz8lt7FuPC18fz/Kze4m+2wdoo3o5ZEgtoKRjzCRW2HHZnhd898RdvMOV1+
         QBz3bz3bmedlslMi5wwF8c7tujTOs6OaGbmcyaeU+Y+B5Tao/INisxaYef2jqOk2cL0B
         Tgha5vkN0qfvVuFkLiWJsfEiZBonW8Z8mrUrEEVS8IlWGsCum/ECUdg8mq1AYr/xV16p
         vrIFaJgYWo4Ume/emdhzTL4zvvujL6izh8uD/daU2rXBV+6Hy3sQfzyR6/Ff/ncDzhHu
         QT62MTEwUNnc9LUFmgUHsEvrcCjtH/1+Qm69a+UiM800GpOBb61UzoaR81NBgX09kLvx
         q8sg==
X-Gm-Message-State: AOAM532spki0XfbfQ0KfZnQx9cq2PhwcUBOsAW8/CegRf08MTkKtojP0
        93QheATqxc5UTV1/HkGjQqNm/zt0wFdta+WylJc9OzptG5k=
X-Google-Smtp-Source: ABdhPJz1Q500OsF8j0/ZZasaShWKuPIAQ8lRzVehGvA2jPrcFlgmb7eFIN5NclFNkLZd/6vZuwARxIgPHCQeEm6DR54=
X-Received: by 2002:a05:6e02:4ca:: with SMTP id f10mr1687381ils.112.1613121616157;
 Fri, 12 Feb 2021 01:20:16 -0800 (PST)
MIME-Version: 1.0
References: <CAM+r-RhxY4TA4zPm6e6ah9RWdBY67J=5oRS3+=+EQMomKa10QQ@mail.gmail.com>
 <CA+icZUUM8cPUvwVRFqodZxNs=4pVaBJGCWu6mL=9T5tym_OmeA@mail.gmail.com>
 <CA+icZUX7+bOgqPTtwNjXO4PCvjAm9T7akWvDxV47QPMR2auiSQ@mail.gmail.com> <87blcpspde.fsf@codeaurora.org>
In-Reply-To: <87blcpspde.fsf@codeaurora.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 12 Feb 2021 10:20:05 +0100
Message-ID: <CA+icZUVZQ-1L=etOF5-jX8m0PCwhpf9c88t9gcsfLv1yYmYd7Q@mail.gmail.com>
Subject: Re: wireless wiki: ath11k missing in drivers page
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Feb 12, 2021 at 8:43 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Sedat Dilek <sedat.dilek@gmail.com> writes:
>
> > On Sun, Jan 3, 2021 at 1:50 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >>
> >> Hi,
> >>
> >> recently someone asked about issues with ath11k devices.
> >>
> >> So, I checked the wireless wiki pages.
> >>
> >> In the drivers overview [1] ath10k is listed and linked [2] but not ath11k.
> >> Smart enough I found [3].
> >>
> >> Can you or someone else add the link to athk11 in [1]?
> >>
> >> Thanks.
> >>
> >> Regards,
> >> - Sedat -
> >>
> >> [1] https://wireless.wiki.kernel.org/en/users/drivers
> >> [2] https://wireless.wiki.kernel.org/en/users/drivers/ath10k
> >> [3] https://wireless.wiki.kernel.org/en/users/drivers/ath11k
> >
> > Thanks to whomever fixed the drivers overview page.
>
> Thanks from my side as well. I updated the entry now, for example ath11k
> does not support IBSS.
>

Cool, up2date docs :-).

- sed@ -
