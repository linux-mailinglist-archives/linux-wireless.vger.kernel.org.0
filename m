Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243863DC94A
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Aug 2021 03:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhHABnC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Jul 2021 21:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhHABnC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Jul 2021 21:43:02 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274BBC06175F
        for <linux-wireless@vger.kernel.org>; Sat, 31 Jul 2021 18:42:54 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id a201so6313448ybg.12
        for <linux-wireless@vger.kernel.org>; Sat, 31 Jul 2021 18:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bPt1wuf08rGseocxIrquG5W562ANFATDjSxGwwlidFs=;
        b=JuF4paeQHZ0xEXz8T53uvP+m6zteB9CdLOQgm+20cZ51nlTbY38BNWVJwX7714Mk8S
         Yqg8aur2v1BCbsJXw+NUBv5r1yLt8EnhSwYIEirf+OxPj6RqVAEtUjK5UhhEE7W9FQm+
         TnQkxgBj6lTlty7NNZD5U+RSnV4GIFwbqri8x8icsw4+KJ7l0gZjxkyOpr2ghGsp0Sts
         6K2K4UxPhe7cXIFJEnNjDYQ/o7HAKaEDxk1SiVjb4Ap3oXHcWko9kkVpwtXuTH4eY0cy
         AN4/6mnY4mCnYEEwQAsrUqS3tlhTuRMrDo1zhbW/9UvntWDdP9UEvicjKNdn8SYV+oWw
         +E9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bPt1wuf08rGseocxIrquG5W562ANFATDjSxGwwlidFs=;
        b=K0/5u1Xgua6wdlNBrMaxjJZf7LfAgfWlocfLv7jclJ1aOPYTSu9nUmOADvHRWuZfN8
         r0dJjyKsTRPsBToiG799zjCAet7/i7iHpEETNJXpNEoGOxy3EEYHcrpypFHjeNuaadyE
         vrxzOKMa0MADYIC2xQmJMkoZ2+3AWFQ725p7IDtE9528IEbBWpc9BOChIAB0LC5dS8X+
         V4ms6dhvT1yCYKzovTmlZpwkDje6DX2+pbRIMJmeDCLbsbJbo8rig7XAlDYt1VXV7dLL
         5j0WkXWUGETq7rilVF2mp4sF6LbGJt62jw+iIbW0SwHeF8dygzvlhWOwQXrgmMohej5x
         hvWg==
X-Gm-Message-State: AOAM531yhKvnZj8Y1o0EcEYCSTeYasfJcSTtqeVyClDIVhpGqp9XxhYP
        +tPvqDrTSscRqilftxkYg23ISKxcJumoKA9dM4M=
X-Google-Smtp-Source: ABdhPJyB+GG6x8/xMo1Eb4pxrCFzydKfXBGOI50PXIYH2s0fiZecSPMkpOezvudY8Rlse4PdmkCbIf2Q2y/RH/S4ggg=
X-Received: by 2002:a25:b3c9:: with SMTP id x9mr12114917ybf.514.1627782173316;
 Sat, 31 Jul 2021 18:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <CANB4YXTf0DhJfL6kPa26ZCzj8FRwwdw_enGROzL-zXuWGyrwOQ@mail.gmail.com>
 <CANB4YXRtyvgu946rL=gxaRqhXja1qfBQ+DSYfiMvYcax7o45EQ@mail.gmail.com>
 <YPgvMph+3vRbrol3@ubuntu-x1> <CANB4YXSDuYndC26KPkV+XqPkowbN54MMceuj7MNaxh+EwLN4kw@mail.gmail.com>
 <YPg83HXFIXDAEFx1@ubuntu-x1> <CANB4YXS64QtxsgY0bx_Ri7bWfTY_5Ry7PbGwaGT3QVZb380vgQ@mail.gmail.com>
In-Reply-To: <CANB4YXS64QtxsgY0bx_Ri7bWfTY_5Ry7PbGwaGT3QVZb380vgQ@mail.gmail.com>
From:   Timo Witte <timo.witte@gmail.com>
Date:   Sun, 1 Aug 2021 03:42:42 +0200
Message-ID: <CANB4YXTKpu3gOJ4om8yo6ZSvnS497tk1cU-=56TGaktY2QBV-g@mail.gmail.com>
Subject: Re: wireless-regdb: Update regulatory rules for Germany (DE) on 6GHz
To:     Seth Forshee <sforshee@kernel.org>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Any updates on this Seth?
can we just add the "NO-OUTDOOR" line then as i did in my updated
patch, if the kernel does not support overlapping / identical
frequency ranges with different power limits?

Best regards,
Timo


On Wed, Jul 21, 2021 at 5:51 PM Timo Witte <timo.witte@gmail.com> wrote:
>
> Ok then let's just remove the 25mW line.
> Here is the new patch:
>
> diff --git a/db.txt b/db.txt
> index 1e5ed03..debd878 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -448,6 +448,12 @@ country CZ: DFS-ETSI
>  # Bereich 57 GHz - 66 GHz f=C3=BCr Funkanwendungen f=C3=BCr weitbandige
>  # Daten=C3=BCbertragungssysteme; =E2=80=9EMultiple Gigabit WAS/RLAN Syst=
ems (MGWS)=E2=80=9C).
>  # https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/T=
elekommunikation/Unternehmen_Institutionen/Frequenzen/Allgemeinzuteilungen/=
2011_08_MGWS_pdf.pdf
> +#
> +# Allocation for the WiFi 6E Band (Allgemeinzuteilung von Frequenzen im
> +# Bereich 5945 MHz - 6425 MHz f=C3=BCr drahtlose Zugangssysteme,
> +# einschlie=C3=9Flich lokaler Funknetze WAS/WLAN (=E2=80=9EWireless Acce=
ss Systems
> +# including Wireless Local Area Networks=E2=80=9C))
> +# https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/T=
elekommunikation/Unternehmen_Institutionen/Frequenzen/Allgemeinzuteilungen/=
MobilfunkDectWlanCBFunk/vfg552021WLAN6GHz.pdf
>  country DE: DFS-ETSI
>   (2400 - 2483.5 @ 40), (100 mW)
>   (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=3DETSI
> @@ -455,6 +461,8 @@ country DE: DFS-ETSI
>   (5470 - 5725 @ 160), (500 mW), DFS, wmmrule=3DETSI
>   # short range devices (ETSI EN 300 440-1)
>   (5725 - 5875 @ 80), (25 mW)
> + # WiFi 6E
> + (5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=3DETSI
>   # 60 GHz band channels 1-4 (ETSI EN 302 567)
>   (57000 - 66000 @ 2160), (40)
>
>
> On Wed, Jul 21, 2021 at 5:27 PM Seth Forshee <sforshee@kernel.org> wrote:
> >
> > On Wed, Jul 21, 2021 at 04:57:03PM +0200, Timo Witte wrote:
> > > From f9a99269b00f961e40024632c7b831c615bfa392 Mon Sep 17 00:00:00 200=
1
> > > From: Timo Witte <timo.witte@gmail.com>
> > > Date: Wed, 21 Jul 2021 16:51:40 +0200
> > > Subject: [PATCH] add wifi6e for germany
> > >
> > > Signed-off-by: Timo Witte <timo.witte@gmail.com>
> > > ---
> > >  db.txt | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/db.txt b/db.txt
> > > index 1e5ed03..411b7ac 100644
> > > --- a/db.txt
> > > +++ b/db.txt
> > > @@ -448,6 +448,12 @@ country CZ: DFS-ETSI
> > >  # Bereich 57 GHz - 66 GHz f=C3=BCr Funkanwendungen f=C3=BCr weitband=
ige
> > >  # Daten=C3=BCbertragungssysteme; =E2=80=9EMultiple Gigabit WAS/RLAN =
Systems (MGWS)=E2=80=9C).
> > >  # https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebie=
te/Telekommunikation/Unternehmen_Institutionen/Frequenzen/Allgemeinzuteilun=
gen/2011_08_MGWS_pdf.pdf
> > > +#
> > > +# Allocation for the WiFi 6E Band (Allgemeinzuteilung von Frequenzen=
 im
> > > +# Bereich 5945 MHz - 6425 MHz f=C3=BCr drahtlose Zugangssysteme,
> > > +# einschlie=C3=9Flich lokaler Funknetze WAS/WLAN (=E2=80=9EWireless =
Access Systems
> > > +# including Wireless Local Area Networks=E2=80=9C))
> > > +# https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebie=
te/Telekommunikation/Unternehmen_Institutionen/Frequenzen/Allgemeinzuteilun=
gen/MobilfunkDectWlanCBFunk/vfg552021WLAN6GHz.pdf
> > >  country DE: DFS-ETSI
> > >         (2400 - 2483.5 @ 40), (100 mW)
> > >         (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=3D=
ETSI
> > > @@ -455,6 +461,10 @@ country DE: DFS-ETSI
> > >         (5470 - 5725 @ 160), (500 mW), DFS, wmmrule=3DETSI
> > >         # short range devices (ETSI EN 300 440-1)
> > >         (5725 - 5875 @ 80), (25 mW)
> > > +       # WiFi 6E
> > > +       (5945 - 6425 @ 160), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=
=3DETSI
> > > +       # WiFi 6E Short range (Outdoor allowed)
> > > +       (5945 - 6425 @ 160), (25 mW), AUTO-BW, wmmrule=3DETSI
> >
> > Unfortunately the kernel doesn't support multiple rules for a given
> > range with differing flags. Currently it is necessary to specify either
> > the indoor power limit with NO-OUTDOOR or the outdoor power limit, but
> > not both.
> >
> > Thanks,
> > Seth
