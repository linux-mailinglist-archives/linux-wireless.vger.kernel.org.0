Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597C42ADA47
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 16:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbgKJPWs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 10:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730594AbgKJPWs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 10:22:48 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073E5C0613CF
        for <linux-wireless@vger.kernel.org>; Tue, 10 Nov 2020 07:22:48 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id w188so9176578oib.1
        for <linux-wireless@vger.kernel.org>; Tue, 10 Nov 2020 07:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VSh8DyqrFTLGg9mOm/yZA8V8LLuXrD4eCUIgAcRxsZI=;
        b=TJLAD9oqXiWcR0372YwuJ9FVsbX5HGOw9OxafbwKSKeus6Ub8Jm7ydVq5qgpOBQEX4
         V/MwDox1Xnr32CvXuWUYQj15yleFPljnMRCVvFX+EC8XJx6kkkQPz/Lox/WbUvzypCpz
         oaU7xULjuwPHK90nZQ9M1NDcB/d+4gSzqK2imAagzDy2oW5VJi7AqjYyTgSF1P/lPwpG
         zrcKclo60zCLuTgxYHrnYxuezyxisA4Ss57PMllTA2/MhgRyFYJ5hYH3ymhX9sIQuD6T
         gBY1WokuxbHiGYEPyq3XsMinX/EebgTIcUaG0fdS6zJ4lyocj9mvseWvm+i4XQgWgOf3
         hwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VSh8DyqrFTLGg9mOm/yZA8V8LLuXrD4eCUIgAcRxsZI=;
        b=c5hPAS6B8v2vO6KfJK4bDHYJdXVJ6h096jWepbhaqIJdl6zu2flqaKj23Ogbe1KLHD
         n+1N7R7ujaMmlb+C0w/0KZccI+QB2x6MJTy4UU3FmPEEjkQV6bxSnH+j/DtrrXqRtwtO
         VwbymrQeRnm4B7j4ESDI77m8ha6Pmpsq7hFarLaxjw30WsaUFivhlxZw7A+/uaxm7ENP
         SrPvSTKST5FnR2h3GbUO5LkjCo867jAB+urKlQGlXHwbrvNv+ZmFEmsF5s3pB5RlIqIl
         VWrk1Py03eKT+HhYtW4X2AX7sXp8+Vv8maZ0PJlzpeb00hGq7udSc3xqm0u5003EFfRY
         oE8Q==
X-Gm-Message-State: AOAM533SNJkGiLEQxTWrHp4A05xpPM+bd2D8ckokTT+rgRp3ovCM3Rd6
        Wg6O1s15Kvwq/ylGnXlffYiZNBTlbHFwPoeQoPwQaw==
X-Google-Smtp-Source: ABdhPJxcZrBN5QypAv6pPXoSXyNxGwImKZmIUeMHb4OVJN5ORlg+nDwuM9zJxLCQL9psVuMARSs84KHwGODAYII07eU=
X-Received: by 2002:a54:4388:: with SMTP id u8mr3077614oiv.173.1605021766912;
 Tue, 10 Nov 2020 07:22:46 -0800 (PST)
MIME-Version: 1.0
References: <20200913172140.66439-1-robert.marko@sartura.hr>
 <20201109231649.GH6125@ubuntu-x1> <CA+HBbNHfxt7pggPDtz2gTyg74OD9KmYto7-Lck3qF_pTGvuQqQ@mail.gmail.com>
 <20201110142803.GK6125@ubuntu-x1>
In-Reply-To: <20201110142803.GK6125@ubuntu-x1>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 10 Nov 2020 16:22:36 +0100
Message-ID: <CA+HBbNFfgCfdnikHpJeXjBrbu7FUnQ3rcDWoHrjPZg-hMmg3EQ@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Croatia (HR)
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Nov 10, 2020 at 3:28 PM Seth Forshee <seth.forshee@canonical.com> wrote:
>
> On Tue, Nov 10, 2020 at 11:35:38AM +0100, Robert Marko wrote:
> > On Tue, Nov 10, 2020 at 12:16 AM Seth Forshee
> > <seth.forshee@canonical.com> wrote:
> > >
> > > On Sun, Sep 13, 2020 at 07:21:40PM +0200, Robert Marko wrote:
> > > > Croatian Regulatory Authority for Network Industries (HAKOM) has
> > > > updated the general licenses OD-85 and OD-86 with the new OD-85a
> > > > and OD-86a versions.
> > > >
> > > > These introuduce the following changes:
> > > > * Outdoor usage for 5150-5250 and 5250-5350 MHz ranges is permitted
> > > > * 5150-5250 MHz range TPC requirment was dropped and power output raised to 200mW
> > > >
> > > > OD-85a: https://www.hakom.hr/UserDocsImages/op%C4%87e%20dozvole%20prosinac%202009.g/Opca_dozvola_85a.pdf
> > > > OD-86a: https://www.hakom.hr/UserDocsImages/op%C4%87e%20dozvole%20prosinac%202009.g/Opca_dozvola_86a.pdf
> > > >
> > > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > > > Cc: Luka Perkov <luka.perkov@sartura.hr>
> > > > ---
> > > >  db.txt | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/db.txt b/db.txt
> > > > index ac32483..52d0fab 100644
> > > > --- a/db.txt
> > > > +++ b/db.txt
> > > > @@ -693,8 +693,8 @@ country HR: DFS-ETSI
> > > >  # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
> > > >  # HR: http://tablice.hakom.hr:8080/vis?lang=en
> > > >       (2400 - 2483.5 @ 40), (100 mW)
> > > > -     (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
> > > > -     (5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
> > > > +     (5150 - 5250 @ 80), (200 mW), AUTO-BW, wmmrule=ETSI
> > >
> > > Based on the translation I'm reading the 200 mW applied to elevations
> > > from 5 degrees to 30 degrees, and for elevations above 30 degress the
> > > limit is 125 mW. I'm not expeienced with regulations that vary with the
> > > elevation angle. Why should we use 200 mW instead of 125 mW, which is
> > > allowed for any elevation?
> >
> > You can see in the OD-86a that now 1W (30 dBm) EIRP is the maximum
> > allowed power.
> > Then in usage conditions, they state that if median EIRP power larger
> > than 200mW (23 dBm) is used then the listed
> > angle and power limits should be used.
> > That is why I used 200mW as it has no limitations associated.
>
> Right, but OD-86a applies to 5250-5350 MHz. I don't see this same
> statement in OD-85a.
>
> However, digging into it a little more, it looks like the elevation
> restrictions come from WRC-19 resolution 229 [1], which has more detail.
> Based on my reading of that it seems that the situation here actually is
> similar to that for 5250-5350 MHz, i.e. that 200 mW is the general limit
> but that operation at 1W is allowed subject to the stated elevation
> angle restrictions. So it sounds like the 200 mW limit for 5150-5250 MHz
> should be okay.
>
> [1] https://www.itu.int/dms_pub/itu-r/opb/act/R-ACT-WRC.14-2019-PDF-E.pdf

OD-85a covers 5150-5250 MHz and power limits for it have not changed,
they remain the same as before.
I simply remove the no-outdoor limit as it was dropped.
>
> > >
> > > > +     (5250 - 5350 @ 80), (200 mW), DFS, AUTO-BW, wmmrule=ETSI
> > >
> > > The translation of OD-86a I'm reading says "use mostly indoors." Is that
> > > an accurate translation? How does this compare to the language from
> > > OD-86? I'm a little unsure how to interpret it.
> >
> > Yes, it's accurate.
> > In OD-86 this was strictly written as "exclusive use indoors", Hakom
> > even stated in their press release that the
> > changes to OD-86 now allow outdoor usage.
> > https://www.hakom.hr/default.aspx?id=10442
> > It's in English.
> >
> > They are just trying to encourage the band to still be mostly used for
> > indoor stuff.
>
> Great, thanks for clarifying.
>
> I've applied the patch. Thanks!

Thanks,
Robert
