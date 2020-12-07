Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7DE2D12A7
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Dec 2020 14:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgLGNzP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Dec 2020 08:55:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35658 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgLGNzO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Dec 2020 08:55:14 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1kmGyF-0001Cd-W8
        for linux-wireless@vger.kernel.org; Mon, 07 Dec 2020 13:54:32 +0000
Received: by mail-il1-f197.google.com with SMTP id w10so12909846ila.22
        for <linux-wireless@vger.kernel.org>; Mon, 07 Dec 2020 05:54:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=exIg4im978Af35t0Th41CdUqoCnbHcLk3dCbyFtDoWA=;
        b=j/+JsrnYpuETLjj1a8/Qs5jj29LGicYE30RlGv0xPkABV89D1TPvnjyD0YiljiqnJO
         Imu+tS51lUtIMEuupP/Nvs89KzV+PzCz9UZ1j9DhBK4CWWwGnWqLoIskB3sfnmFPTvI9
         4MmEOSm/CiBeRp6jDeNlDp451H1r9LzgEXEzpWiITis6nKhiWGzGVZkR7pwN46Fitqow
         NEuz9TtxSoM8escgZ0SzUIBF4j8Ds8wji6Js+RMxPTRIGIRuiIdz0h5TwPZu4BjJBwdX
         qpDnhHbmJ83yZ4dVbXPLgnJ5N8HiZJJlSYQ+6BakSKJ38wmzWJN9CK/BJcAQQnKdQAGF
         4Njw==
X-Gm-Message-State: AOAM531j7hXvF4aXW1lMc2za9kqWmeXWl8JuhoCe9LW3TDLGVznle6kY
        uuYfl2z84Kp2p3buiKkm0o3Ot5D9Tr3zg6/gnaIvgdrkzv4pL0mlCi/i2oeAZ1SArqXuJo6GSLo
        arXyEJTG99k0QZc7hKA4v8v6u+po9ZRhscuXu4TJnscIv
X-Received: by 2002:a92:cc90:: with SMTP id x16mr22203485ilo.153.1607349271020;
        Mon, 07 Dec 2020 05:54:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/MAVUkumrlBr2f0SRNg7gyKuAsiLriBta/VfYEqnAGd2dNNmnE3dr1sNSLhmZl+Bf0VcsCg==
X-Received: by 2002:a92:cc90:: with SMTP id x16mr22203466ilo.153.1607349270770;
        Mon, 07 Dec 2020 05:54:30 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:2629:2709:f729:78dc])
        by smtp.gmail.com with ESMTPSA id a3sm7295883ilp.5.2020.12.07.05.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:54:30 -0800 (PST)
Date:   Mon, 7 Dec 2020 07:54:29 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     b.K.il.h.u+tigbuh@gmail.com
Cc:     wireless-regdb <wireless-regdb@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wireless-regdb: recent FCC report and order allows
 5850-5895 immediately
Message-ID: <X840FVaelaS2hq/K@ubuntu-x1>
References: <a79286b90cdfdee3a83397008c0f7b6d67bc7f69.1607035229.git.b.K.il.h.u+tigbuh@gmail.com>
 <X8pRrWfZPhLdguu8@ubuntu-x1>
 <CAPuHQ=EUcsn24EoSP+PGH2H6kPROvauyJN_6RtYLXqVYW=sK-g@mail.gmail.com>
 <X82welCPwyUV8VJw@ubuntu-x1>
 <CAPuHQ=EXa9zbXuqoU44b=Jv=hL4tK3nRPksgOEN=LVjJvWt8PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPuHQ=EXa9zbXuqoU44b=Jv=hL4tK3nRPksgOEN=LVjJvWt8PA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 07, 2020 at 11:10:41AM +0100, b.K.il.h.u+tigbuh@gmail.com wrote:
> Indeed your logic seems reasonable regarding passive scanning.
> However, I'm only looking at it from a wireless-regdb perspective:
> this seems to be the first NO-IR directive in the database other than
> for the "world" domain, and I thought that NO-IR is more of a thing
> that would apply for client devices having no clue where they are, but
> wouldn't adding NO_IR here keep hostapd from enabling an AP on such a
> channel? Here's some documentation on this:
> 
> https://wireless.wiki.kernel.org/en/developers/regulatory/processing_rules#beacon_hints
> 
> I see that passive-scan and no-ibss flags had been consolidated in this commit:
> 
> https://patchwork.kernel.org/project/linux-wireless/patch/1382376158-25586-2-git-send-email-mcgrof@do-not-panic.com/
> 
> This is a use case that might see a benefit in splitting the two
> again. But isn't that what PTMP-ONLY is for? Although, they mention at
> one place that PTMP-ONLY isn't quite being used in the code as of now.

I'm not sure how hostapd treats NO-IR, but even ibss seems likely to be
off limits given the wording as it is still a point-to-point mode. NO-IR
is the only thing which restricts active scanning or ibss in the kernel.
If it also restricts AP mode in hostapd, then we currently have no flag
to enforce passive scanning without also restricting AP mode.

And yes, PTMP-ONLY is essentially unused in the kernel so it likely has
no real impact.

Thanks,
Seth

> 
> Some more mentions:
> https://medium.com/@renaudcerrato/how-to-build-your-own-wireless-router-from-scratch-part-3-d54eecce157f
> https://www.spinics.net/lists/linux-wireless/msg124066.html
> 
> On Mon, Dec 7, 2020 at 5:33 AM Seth Forshee <seth.forshee@canonical.com> wrote:
> >
> > On Sat, Dec 05, 2020 at 09:24:03PM +0100, b.K.il.h.u+tigbuh@gmail.com wrote:
> > > Thanks for double checking. Honestly, I've only spent a few hours
> > > skimming through the document and haven't read it through all the way.
> > >
> > > Agreed that both bandwidths should probably be upped to 160.
> > >
> > > Considering  § 15.407 (a)(3)(v): shouldn't the flag `PTMP-ONLY`
> > > already signal this infrastructure-mode only restriction? I think
> > > sending a probe request frame before connecting may be considered a
> > > "brief message", and NO-IR would even disallow that. Also, if we added
> > > NO-IR, wouldn't that close the band for AP's running Linux as well?
> >
> > But it's a brief message "after detecting a signal that confirms that an
> > access point is operating on a particular channel." I think that implies
> > a passive scan, then sending an association request only after seeing a
> > beacon from the AP on the channel. I could be wrong though; my memory on
> > the 802.11 protocol is rusty and out of date.
> >
> > Thanks,
> > Seth
> >
> > >
> > > Other than deciding the above questions, should we get back to
> > > finishing this patch after publication sometime next year? There may
> > > be a chance for it to change until then.
> > >
> > > On Fri, Dec 4, 2020 at 4:11 PM Seth Forshee <seth.forshee@canonical.com> wrote:
> > > >
> > > > On Thu, Dec 03, 2020 at 11:40:30PM +0100, bkil wrote:
> > > > > The new band is called U-NII-4.
> > > >
> > > > The report states in paragraph 203 that the order is effective 60 days
> > > > from publication in the Federal Register, and it looks like they haven't
> > > > even been published in the Federal Register yet. We will need to wait
> > > > for the rules to go into effect before applying any updates.
> > > >
> > > > > The report recommends combining it with 5725-5895 to allow 160 MHz
> > > > > bandwidth, but that's technically not that easy with regdb due to the
> > > > > differing restrictions of the two parts. Marking the line for U-NII-3
> > > > > NO-OUTDOOR and PTMP-ONLY along with extending its range would be a
> > > > > possible workaround, but this needs to be discussed.
> > > >
> > > > I think it should be sufficient to set the bandwidth of both 5730-5850
> > > > and 5850-5895 to 160 MHz with AUTO-BW. The kernel will see the AUTO-BW
> > > > flags and calculate a combined rule where 160 MHz is allowed, and for
> > > > the original rules any bandwidth exceeding the available bandwidth of
> > > > the rule will be disallowed.
> > > >
> > > > > I don't see a requirement for TPC, hence reducing EIRP by 3dB is not
> > > > > needed. I've marked it 33dBm (minus 6dB for clients) to cope with 20MHz,
> > > > > but the band can support higher power, though the logic is complicated.
> > > >
> > > > I believe we have an additional requirement from § 15.407 (a)(3)(v):
> > > >
> > > >   In the 5.850-5.895 GHz band, client devices must operate under the
> > > >   control of an indoor access point. In all cases, an exception exists
> > > >   for transmitting brief messages to an access point when attempting to
> > > >   join its network after detecting a signal that confirms that an access
> > > >   point is operating on a particular channel.
> > > >
> > > > This sounds like a requirement for passive scanning, if so the range
> > > > should also have the NO-IR flag.
> > > >
> > > > Thanks,
> > > > Seth
> > > >
> > > > >
> > > > > The upper subband (5895-5925 MHz) of the new band is reserved for ITS.
> > > > >
> > > > > "We limit unlicensed use to indoor operations in recognition of the
> > > > > potential that ITS licensees may currently be operating"
> > > > >
> > > > > "We also proposed that U-NII-4 devices be permitted to operate at the same
> > > > > power levels as U-NII-3 devices."
> > > > >
> > > > > "For the U-NII-4 band, indoor access point EIRP will be limited to
> > > > > 33 dBm/20 MHz and 36 dBm/40 MHz. When combined with U-NII-3 band spectrum,
> > > > > indoor access point EIRP can scale to 36 dBm for 80 and 160 megahertz
> > > > > channels."
> > > > >
> > > > > "Client devices would be limited to power levels 6 dB below the power
> > > > > limits for access points."
> > > > >
> > > > > "the First Report and Order prohibit U-NII-4 client-to-client
> > > > > communications to protect co-channel incumbent ITS"
> > > > >
> > > > > Signed-off-by: bkil <b.K.il.h.u+tigbuh@gmail.com>
> > > > > ---
> > > > >  db.txt | 5 ++++-
> > > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/db.txt b/db.txt
> > > > > index c71a03a..e6dd063 100644
> > > > > --- a/db.txt
> > > > > +++ b/db.txt
> > > > > @@ -1587,7 +1587,10 @@ country US: DFS-FCC
> > > > >       # requirements, we can extend the range by 5 MHz to make the kernel
> > > > >       # happy and be able to use channel 144.
> > > > >       (5470 - 5730 @ 160), (23), DFS
> > > > > -     (5730 - 5850 @ 80), (30)
> > > > > +     (5730 - 5850 @ 80), (30), AUTO-BW
> > > > > +     # https://www.fcc.gov/document/fcc-modernizes-59-ghz-band-improve-wi-fi-and-automotive-safety-0
> > > > > +     # max. 33 dBm AP @ 20MHz, 36 dBm AP @ 40Mhz+, 6 dB less for clients
> > > > > +     (5850 - 5895 @ 40), (27), NO-OUTDOOR, PTMP-ONLY, AUTO-BW
> > > > >       # 60g band
> > > > >       # reference: section IV-D https://docs.fcc.gov/public/attachments/FCC-16-89A1.pdf
> > > > >       # channels 1-6 EIRP=40dBm(43dBm peak)
