Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726352AD3E1
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 11:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgKJKfu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 05:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgKJKft (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 05:35:49 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D056C0613CF
        for <linux-wireless@vger.kernel.org>; Tue, 10 Nov 2020 02:35:49 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id g19so11989195otp.13
        for <linux-wireless@vger.kernel.org>; Tue, 10 Nov 2020 02:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MOJsY0raLbWWCa5wUGGgTqpNJnC7oaSPD0C7yom7JQs=;
        b=CqqbsG4AcrG895urZTQ2EUDC2aj7ydxcR1owcvq6gJO1dxhYTwB2g+Kct3b9C8tIP8
         ILAOJ7H4SXUsS75RX5ybeBG9xnSY5LLrOlOkA0psML6iwnMihdThnczWRGPQCo4rxf2n
         E+Im6cNe4OdtXdZ4K9yXiFbsIAOPchkUg6oWyYzldkaD3xzy0RxFgs/8ZBu/oxNseL7y
         x99NGGwyM+gGxVaHIEnL5d2HcyeZVDS8lJySTIdmWHYeq/TPYyMOuVJrOG3jVy9V0ClZ
         6ecURni0znUvmnumjazkKM/pRYtqDrf12yDuJSIU4YG2EubMqFh8P3pFi7EjbAFI8EX5
         m+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MOJsY0raLbWWCa5wUGGgTqpNJnC7oaSPD0C7yom7JQs=;
        b=DcKIkIh+WhYqtesYpsK7okYvEeLtxAvTBLGDZvstSxHvWB+w5mFBPRv76EXNNqh5qZ
         wIIcyoEjZT4vcRfzegYjqYUsnXbR/kiyd4kadA6lSOAoS9YJTR9paohZhipXqIjFJEit
         GfClJCZrZr/ugxXNf8G80sFN+Bo4abBWGXpD8SSSUT07WGxRmziP0lxmRGSc6508oSVK
         K956pJPKdTUOiCYSa+vbjYJnoBvWrirFGNpO6scXMiLEf2k2SxAuspOT4Wf9+asHSO66
         DW8+o9XygCgLmz8lA9foNKRC+wvwr5Fyg/o4tce3pxHxseIq/ddUZtvyuAaKBhJB8JEQ
         xQMg==
X-Gm-Message-State: AOAM531KrvqTdKdVBGDtf/gKVS+DDW5+xao/aqJT19eZ56Ku2XRGknum
        y0SW3Nu4xw6h7SX3mAFi51rT9V29f6MLYddN2SD3lR+wmgsl8tyI
X-Google-Smtp-Source: ABdhPJysW7lWTRWDBPS8CrTxbQunQV+FPr97jr+yFtCuFJpNqCNyDYUvmvuJ4A7iZBlTTReipqzRjbvfjDfN80JS+KU=
X-Received: by 2002:a05:6830:789:: with SMTP id w9mr13619317ots.243.1605004548949;
 Tue, 10 Nov 2020 02:35:48 -0800 (PST)
MIME-Version: 1.0
References: <20200913172140.66439-1-robert.marko@sartura.hr> <20201109231649.GH6125@ubuntu-x1>
In-Reply-To: <20201109231649.GH6125@ubuntu-x1>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 10 Nov 2020 11:35:38 +0100
Message-ID: <CA+HBbNHfxt7pggPDtz2gTyg74OD9KmYto7-Lck3qF_pTGvuQqQ@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Croatia (HR)
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Nov 10, 2020 at 12:16 AM Seth Forshee
<seth.forshee@canonical.com> wrote:
>
> On Sun, Sep 13, 2020 at 07:21:40PM +0200, Robert Marko wrote:
> > Croatian Regulatory Authority for Network Industries (HAKOM) has
> > updated the general licenses OD-85 and OD-86 with the new OD-85a
> > and OD-86a versions.
> >
> > These introuduce the following changes:
> > * Outdoor usage for 5150-5250 and 5250-5350 MHz ranges is permitted
> > * 5150-5250 MHz range TPC requirment was dropped and power output raised to 200mW
> >
> > OD-85a: https://www.hakom.hr/UserDocsImages/op%C4%87e%20dozvole%20prosinac%202009.g/Opca_dozvola_85a.pdf
> > OD-86a: https://www.hakom.hr/UserDocsImages/op%C4%87e%20dozvole%20prosinac%202009.g/Opca_dozvola_86a.pdf
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > Cc: Luka Perkov <luka.perkov@sartura.hr>
> > ---
> >  db.txt | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/db.txt b/db.txt
> > index ac32483..52d0fab 100644
> > --- a/db.txt
> > +++ b/db.txt
> > @@ -693,8 +693,8 @@ country HR: DFS-ETSI
> >  # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
> >  # HR: http://tablice.hakom.hr:8080/vis?lang=en
> >       (2400 - 2483.5 @ 40), (100 mW)
> > -     (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
> > -     (5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
> > +     (5150 - 5250 @ 80), (200 mW), AUTO-BW, wmmrule=ETSI
>
> Based on the translation I'm reading the 200 mW applied to elevations
> from 5 degrees to 30 degrees, and for elevations above 30 degress the
> limit is 125 mW. I'm not expeienced with regulations that vary with the
> elevation angle. Why should we use 200 mW instead of 125 mW, which is
> allowed for any elevation?

You can see in the OD-86a that now 1W (30 dBm) EIRP is the maximum
allowed power.
Then in usage conditions, they state that if median EIRP power larger
than 200mW (23 dBm) is used then the listed
angle and power limits should be used.
That is why I used 200mW as it has no limitations associated.
>
> > +     (5250 - 5350 @ 80), (200 mW), DFS, AUTO-BW, wmmrule=ETSI
>
> The translation of OD-86a I'm reading says "use mostly indoors." Is that
> an accurate translation? How does this compare to the language from
> OD-86? I'm a little unsure how to interpret it.

Yes, it's accurate.
In OD-86 this was strictly written as "exclusive use indoors", Hakom
even stated in their press release that the
changes to OD-86 now allow outdoor usage.
https://www.hakom.hr/default.aspx?id=10442
It's in English.

They are just trying to encourage the band to still be mostly used for
indoor stuff.

Regards,
Robert
>
> Thanks,
> Seth
>
> >       (5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
> >       # short range devices (ETSI EN 300 440-1)
> >       (5725 - 5875 @ 80), (25 mW)
> > --
> > 2.26.2
> >
