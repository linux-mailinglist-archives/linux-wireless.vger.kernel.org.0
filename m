Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5295E2AD8C9
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 15:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbgKJO2J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 09:28:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37728 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbgKJO2J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 09:28:09 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1kcUcw-0002x3-Jn
        for linux-wireless@vger.kernel.org; Tue, 10 Nov 2020 14:28:06 +0000
Received: by mail-il1-f198.google.com with SMTP id p17so9492177ilb.5
        for <linux-wireless@vger.kernel.org>; Tue, 10 Nov 2020 06:28:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+oL1vxxFWxN81kduFLariZ75AhDeELaOa5AhQgl4wXw=;
        b=oAOGn0ySaZHc1onMWr4BV0VJifFx8c5pUyKMrlZwClYHt+YgPGgeUEl5rq/lN78cju
         rbqQK9yFys0MBn2n3CHK+I4yfx1Cc4kt/8ahIIlCJhkH9JdEusilz4mkZtaTFzKQc6bP
         damEnWwXkRM19k+f22cMmedUSPmrfWEQwfuY7Gl28ivUPon4l9tY7fknjGC0quqfxeRq
         5p3/Cc/gWeokI2FQ88KM+1iECYflkcB9c1qvew88OeiFMT5ThZZn+vztY+n8trJ4EW0c
         i1mXdVmiNrWP5COifdXfjGdEHUWqTIKUfOxwxXj4nKqywxcyck0B70i/6Mny82FU1+z1
         ulNA==
X-Gm-Message-State: AOAM5311OaxmEpQbHxWmEO9DtCYhZ6wFG8WZyNl8wCVrKUTSK6xneY5u
        zt1x9etyv03tqWRVWYVqnV42jK7oLoVMUEW8/+zaaDixXc/6HteIFHtEI8D8LDhkLJzm38OqmYL
        O4yy1NWeINQNOwe4yvtS1+WNM44CbrBNoH/fiWAEN2arg
X-Received: by 2002:a05:6e02:928:: with SMTP id o8mr14788885ilt.47.1605018485322;
        Tue, 10 Nov 2020 06:28:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynQLyBTcrBljFY+wwXzllQKyC76fPyNzTcYn1+K45OGW3qkfTsk+ojBd3DcSuW/YKiv1JKdQ==
X-Received: by 2002:a05:6e02:928:: with SMTP id o8mr14788843ilt.47.1605018484849;
        Tue, 10 Nov 2020 06:28:04 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:59ea:bfb1:548d:1c70])
        by smtp.gmail.com with ESMTPSA id m26sm9460337ill.21.2020.11.10.06.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 06:28:04 -0800 (PST)
Date:   Tue, 10 Nov 2020 08:28:03 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Croatia (HR)
Message-ID: <20201110142803.GK6125@ubuntu-x1>
References: <20200913172140.66439-1-robert.marko@sartura.hr>
 <20201109231649.GH6125@ubuntu-x1>
 <CA+HBbNHfxt7pggPDtz2gTyg74OD9KmYto7-Lck3qF_pTGvuQqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+HBbNHfxt7pggPDtz2gTyg74OD9KmYto7-Lck3qF_pTGvuQqQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Nov 10, 2020 at 11:35:38AM +0100, Robert Marko wrote:
> On Tue, Nov 10, 2020 at 12:16 AM Seth Forshee
> <seth.forshee@canonical.com> wrote:
> >
> > On Sun, Sep 13, 2020 at 07:21:40PM +0200, Robert Marko wrote:
> > > Croatian Regulatory Authority for Network Industries (HAKOM) has
> > > updated the general licenses OD-85 and OD-86 with the new OD-85a
> > > and OD-86a versions.
> > >
> > > These introuduce the following changes:
> > > * Outdoor usage for 5150-5250 and 5250-5350 MHz ranges is permitted
> > > * 5150-5250 MHz range TPC requirment was dropped and power output raised to 200mW
> > >
> > > OD-85a: https://www.hakom.hr/UserDocsImages/op%C4%87e%20dozvole%20prosinac%202009.g/Opca_dozvola_85a.pdf
> > > OD-86a: https://www.hakom.hr/UserDocsImages/op%C4%87e%20dozvole%20prosinac%202009.g/Opca_dozvola_86a.pdf
> > >
> > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > > Cc: Luka Perkov <luka.perkov@sartura.hr>
> > > ---
> > >  db.txt | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/db.txt b/db.txt
> > > index ac32483..52d0fab 100644
> > > --- a/db.txt
> > > +++ b/db.txt
> > > @@ -693,8 +693,8 @@ country HR: DFS-ETSI
> > >  # Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/download/25c41779-cd6e/Rec7003e.pdf
> > >  # HR: http://tablice.hakom.hr:8080/vis?lang=en
> > >       (2400 - 2483.5 @ 40), (100 mW)
> > > -     (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
> > > -     (5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
> > > +     (5150 - 5250 @ 80), (200 mW), AUTO-BW, wmmrule=ETSI
> >
> > Based on the translation I'm reading the 200 mW applied to elevations
> > from 5 degrees to 30 degrees, and for elevations above 30 degress the
> > limit is 125 mW. I'm not expeienced with regulations that vary with the
> > elevation angle. Why should we use 200 mW instead of 125 mW, which is
> > allowed for any elevation?
> 
> You can see in the OD-86a that now 1W (30 dBm) EIRP is the maximum
> allowed power.
> Then in usage conditions, they state that if median EIRP power larger
> than 200mW (23 dBm) is used then the listed
> angle and power limits should be used.
> That is why I used 200mW as it has no limitations associated.

Right, but OD-86a applies to 5250-5350 MHz. I don't see this same
statement in OD-85a.

However, digging into it a little more, it looks like the elevation
restrictions come from WRC-19 resolution 229 [1], which has more detail.
Based on my reading of that it seems that the situation here actually is
similar to that for 5250-5350 MHz, i.e. that 200 mW is the general limit
but that operation at 1W is allowed subject to the stated elevation
angle restrictions. So it sounds like the 200 mW limit for 5150-5250 MHz
should be okay.

[1] https://www.itu.int/dms_pub/itu-r/opb/act/R-ACT-WRC.14-2019-PDF-E.pdf

> >
> > > +     (5250 - 5350 @ 80), (200 mW), DFS, AUTO-BW, wmmrule=ETSI
> >
> > The translation of OD-86a I'm reading says "use mostly indoors." Is that
> > an accurate translation? How does this compare to the language from
> > OD-86? I'm a little unsure how to interpret it.
> 
> Yes, it's accurate.
> In OD-86 this was strictly written as "exclusive use indoors", Hakom
> even stated in their press release that the
> changes to OD-86 now allow outdoor usage.
> https://www.hakom.hr/default.aspx?id=10442
> It's in English.
> 
> They are just trying to encourage the band to still be mostly used for
> indoor stuff.

Great, thanks for clarifying.

I've applied the patch. Thanks!
