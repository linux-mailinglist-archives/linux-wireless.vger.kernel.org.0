Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2A62D0DCF
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Dec 2020 11:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgLGKLf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Dec 2020 05:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgLGKLe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Dec 2020 05:11:34 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A125C0613D0
        for <linux-wireless@vger.kernel.org>; Mon,  7 Dec 2020 02:10:54 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id y19so5108264lfa.13
        for <linux-wireless@vger.kernel.org>; Mon, 07 Dec 2020 02:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K47wu4tGpZjEegZDHSMcX//OMw84yDtF4PLZpldFX/c=;
        b=X7FVyP/JmIsydfoF1R1cBkwRC4MVs1AN6WluJJ4MmelUT9cg7OlL/J1MTbUhqWl6QW
         6WYj1v/xcVEHcCKxfdTSNijjIL6OU3Aa6+Id8b3TyhDFJRFk1VD7dzZMP2SZXw1qr+xc
         W7hHMhkGXJTx6utwZiJb1p1SrUnasJkLb5e5iTGBMulPSfjzzIXjgKn9Bv/gHRculRwP
         rxdV4MZP7LN74W8+QAsVowe0xBQ7uy+sDXlBhpXezQSeQlBjFzPK4RToD+eMP/BGDLeb
         IB25OxgP5X7m/9AFW9ItBcHwe9paB0pBPlIQAG54/7rUWlfSE7FcOilkzDf27QnPBcYS
         Q7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K47wu4tGpZjEegZDHSMcX//OMw84yDtF4PLZpldFX/c=;
        b=L7Pdwj+PHnRvaRXus4qZvI3oWAusbSmV/0FIk1+/pDpQPLr0i0fZvTagNbvTrxZhG5
         0ITBKCPbZ/td+A2+U8d6pdj+sQygWss/fhvidvtf3+miLG8+J1iODadkypOfD9+3DIjC
         Rid6+pzRzT0eI/vwu1aRYV1qFvgZBO+B+Cx7g+3+bOuVBE1pQSs9TlFdT9McxGELJonJ
         FLjBWt+XjVh3CvOhI0I236Z4XobtIbAWNgFSZTnVBmRH7UY74aHbUFyfq2hSdlNUXtd6
         fvp3i7cmf4/LFvtCn7My3qBsNcJp8REkz1qoEeN4Um7/3FKbuO5ADnkkl4lLAYVK5Joo
         +BsA==
X-Gm-Message-State: AOAM530iO4H1yzbt8j0uzo0B6O4vKfsVHeUgFlE45htUptgS6fmT6nJF
        smnJKcjaAOdRsiaGCj5OPy8uOep9ef3/dfNvOCQKwfBuQ4E=
X-Google-Smtp-Source: ABdhPJyAcQQtYezO+P9dWgfSncjPDVHDEgFVtm6OCN08v+bmXl9/phRwqP4mUizawAx2LUC8hd8w0TX8yAqY5Cj/aTk=
X-Received: by 2002:a19:4c02:: with SMTP id z2mr8125166lfa.198.1607335852516;
 Mon, 07 Dec 2020 02:10:52 -0800 (PST)
MIME-Version: 1.0
References: <a79286b90cdfdee3a83397008c0f7b6d67bc7f69.1607035229.git.b.K.il.h.u+tigbuh@gmail.com>
 <X8pRrWfZPhLdguu8@ubuntu-x1> <CAPuHQ=EUcsn24EoSP+PGH2H6kPROvauyJN_6RtYLXqVYW=sK-g@mail.gmail.com>
 <X82welCPwyUV8VJw@ubuntu-x1>
In-Reply-To: <X82welCPwyUV8VJw@ubuntu-x1>
From:   b.K.il.h.u+tigbuh@gmail.com
Date:   Mon, 7 Dec 2020 11:10:41 +0100
Message-ID: <CAPuHQ=EXa9zbXuqoU44b=Jv=hL4tK3nRPksgOEN=LVjJvWt8PA@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: recent FCC report and order allows
 5850-5895 immediately
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb <wireless-regdb@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Indeed your logic seems reasonable regarding passive scanning.
However, I'm only looking at it from a wireless-regdb perspective:
this seems to be the first NO-IR directive in the database other than
for the "world" domain, and I thought that NO-IR is more of a thing
that would apply for client devices having no clue where they are, but
wouldn't adding NO_IR here keep hostapd from enabling an AP on such a
channel? Here's some documentation on this:

https://wireless.wiki.kernel.org/en/developers/regulatory/processing_rules#=
beacon_hints

I see that passive-scan and no-ibss flags had been consolidated in this com=
mit:

https://patchwork.kernel.org/project/linux-wireless/patch/1382376158-25586-=
2-git-send-email-mcgrof@do-not-panic.com/

This is a use case that might see a benefit in splitting the two
again. But isn't that what PTMP-ONLY is for? Although, they mention at
one place that PTMP-ONLY isn't quite being used in the code as of now.

Some more mentions:
https://medium.com/@renaudcerrato/how-to-build-your-own-wireless-router-fro=
m-scratch-part-3-d54eecce157f
https://www.spinics.net/lists/linux-wireless/msg124066.html

On Mon, Dec 7, 2020 at 5:33 AM Seth Forshee <seth.forshee@canonical.com> wr=
ote:
>
> On Sat, Dec 05, 2020 at 09:24:03PM +0100, b.K.il.h.u+tigbuh@gmail.com wro=
te:
> > Thanks for double checking. Honestly, I've only spent a few hours
> > skimming through the document and haven't read it through all the way.
> >
> > Agreed that both bandwidths should probably be upped to 160.
> >
> > Considering  =C2=A7 15.407 (a)(3)(v): shouldn't the flag `PTMP-ONLY`
> > already signal this infrastructure-mode only restriction? I think
> > sending a probe request frame before connecting may be considered a
> > "brief message", and NO-IR would even disallow that. Also, if we added
> > NO-IR, wouldn't that close the band for AP's running Linux as well?
>
> But it's a brief message "after detecting a signal that confirms that an
> access point is operating on a particular channel." I think that implies
> a passive scan, then sending an association request only after seeing a
> beacon from the AP on the channel. I could be wrong though; my memory on
> the 802.11 protocol is rusty and out of date.
>
> Thanks,
> Seth
>
> >
> > Other than deciding the above questions, should we get back to
> > finishing this patch after publication sometime next year? There may
> > be a chance for it to change until then.
> >
> > On Fri, Dec 4, 2020 at 4:11 PM Seth Forshee <seth.forshee@canonical.com=
> wrote:
> > >
> > > On Thu, Dec 03, 2020 at 11:40:30PM +0100, bkil wrote:
> > > > The new band is called U-NII-4.
> > >
> > > The report states in paragraph 203 that the order is effective 60 day=
s
> > > from publication in the Federal Register, and it looks like they have=
n't
> > > even been published in the Federal Register yet. We will need to wait
> > > for the rules to go into effect before applying any updates.
> > >
> > > > The report recommends combining it with 5725-5895 to allow 160 MHz
> > > > bandwidth, but that's technically not that easy with regdb due to t=
he
> > > > differing restrictions of the two parts. Marking the line for U-NII=
-3
> > > > NO-OUTDOOR and PTMP-ONLY along with extending its range would be a
> > > > possible workaround, but this needs to be discussed.
> > >
> > > I think it should be sufficient to set the bandwidth of both 5730-585=
0
> > > and 5850-5895 to 160 MHz with AUTO-BW. The kernel will see the AUTO-B=
W
> > > flags and calculate a combined rule where 160 MHz is allowed, and for
> > > the original rules any bandwidth exceeding the available bandwidth of
> > > the rule will be disallowed.
> > >
> > > > I don't see a requirement for TPC, hence reducing EIRP by 3dB is no=
t
> > > > needed. I've marked it 33dBm (minus 6dB for clients) to cope with 2=
0MHz,
> > > > but the band can support higher power, though the logic is complica=
ted.
> > >
> > > I believe we have an additional requirement from =C2=A7 15.407 (a)(3)=
(v):
> > >
> > >   In the 5.850-5.895 GHz band, client devices must operate under the
> > >   control of an indoor access point. In all cases, an exception exist=
s
> > >   for transmitting brief messages to an access point when attempting =
to
> > >   join its network after detecting a signal that confirms that an acc=
ess
> > >   point is operating on a particular channel.
> > >
> > > This sounds like a requirement for passive scanning, if so the range
> > > should also have the NO-IR flag.
> > >
> > > Thanks,
> > > Seth
> > >
> > > >
> > > > The upper subband (5895-5925 MHz) of the new band is reserved for I=
TS.
> > > >
> > > > "We limit unlicensed use to indoor operations in recognition of the
> > > > potential that ITS licensees may currently be operating"
> > > >
> > > > "We also proposed that U-NII-4 devices be permitted to operate at t=
he same
> > > > power levels as U-NII-3 devices."
> > > >
> > > > "For the U-NII-4 band, indoor access point EIRP will be limited to
> > > > 33 dBm/20 MHz and 36 dBm/40 MHz. When combined with U-NII-3 band sp=
ectrum,
> > > > indoor access point EIRP can scale to 36 dBm for 80 and 160 megaher=
tz
> > > > channels."
> > > >
> > > > "Client devices would be limited to power levels 6 dB below the pow=
er
> > > > limits for access points."
> > > >
> > > > "the First Report and Order prohibit U-NII-4 client-to-client
> > > > communications to protect co-channel incumbent ITS"
> > > >
> > > > Signed-off-by: bkil <b.K.il.h.u+tigbuh@gmail.com>
> > > > ---
> > > >  db.txt | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/db.txt b/db.txt
> > > > index c71a03a..e6dd063 100644
> > > > --- a/db.txt
> > > > +++ b/db.txt
> > > > @@ -1587,7 +1587,10 @@ country US: DFS-FCC
> > > >       # requirements, we can extend the range by 5 MHz to make the =
kernel
> > > >       # happy and be able to use channel 144.
> > > >       (5470 - 5730 @ 160), (23), DFS
> > > > -     (5730 - 5850 @ 80), (30)
> > > > +     (5730 - 5850 @ 80), (30), AUTO-BW
> > > > +     # https://www.fcc.gov/document/fcc-modernizes-59-ghz-band-imp=
rove-wi-fi-and-automotive-safety-0
> > > > +     # max. 33 dBm AP @ 20MHz, 36 dBm AP @ 40Mhz+, 6 dB less for c=
lients
> > > > +     (5850 - 5895 @ 40), (27), NO-OUTDOOR, PTMP-ONLY, AUTO-BW
> > > >       # 60g band
> > > >       # reference: section IV-D https://docs.fcc.gov/public/attachm=
ents/FCC-16-89A1.pdf
> > > >       # channels 1-6 EIRP=3D40dBm(43dBm peak)
