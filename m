Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BF82D09BE
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Dec 2020 05:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgLGEdp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 23:33:45 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49038 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbgLGEdp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 23:33:45 -0500
Received: from mail-oi1-f198.google.com ([209.85.167.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1km8Cs-0004fK-BE
        for linux-wireless@vger.kernel.org; Mon, 07 Dec 2020 04:33:02 +0000
Received: by mail-oi1-f198.google.com with SMTP id t67so6516501oie.14
        for <linux-wireless@vger.kernel.org>; Sun, 06 Dec 2020 20:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=etAhXIO1CChwXHREzXo+/hxT9Ivk156w9vCR1d/qGPI=;
        b=gOqnxWG3D7spRiLVYkybEYbcw4JFXzQSwkEm/3HFcc4aorgzOH12CEAhGvx7ETT/du
         NyRra1MDnrquEGvK/W2f7r0i6NzjZ45B+fXVWh60foBrcI8y2CeAPFRijBpB6KTGULQM
         Tqv3xxXsf29+/KIwQeNiX3XdMTLJuGvhMtSKqJcKmL5avNfxYi4XAyt9MHxlbM3Rin/V
         2suMmS6ACT0zHLmkKO7MNc4CJkDQGyGVwo0Tjs9eWTr8D3Niph0QgfNIG/DKjQLqYOhT
         4i90WcHoCjWUdnd1/1/qAvE1S7cWNqLsid6+7SB/5Pct91KIekdfPptVYfdPdeCVmviE
         /ZUw==
X-Gm-Message-State: AOAM5326UqF2dnX+Lq91fzDizn4ZmRYdoq+kOOv4WTcngHUH8fkABcC3
        pacok+gi+wIM5/tGhdjUqyLVrkH2cU/LLPKAVJxK1omrSeLz4EAh8haayKXwRvVuXWz/s3pMMd8
        ZrPHVAXsge/sfPgv75f5QWAYcKcXMxBMwuqxxs/Eq9DTc
X-Received: by 2002:a54:4603:: with SMTP id p3mr11231111oip.127.1607315580874;
        Sun, 06 Dec 2020 20:33:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwiX3sH8EM8rSn2M42shvBmiy7hduq+/mBU+G2jnLJwd4ppb+XjFW41B20Sq0jSxnzpwrBoUA==
X-Received: by 2002:a54:4603:: with SMTP id p3mr11231098oip.127.1607315580568;
        Sun, 06 Dec 2020 20:33:00 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:2453:d595:a6f1:b7a0])
        by smtp.gmail.com with ESMTPSA id u130sm2639804oib.53.2020.12.06.20.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 20:32:59 -0800 (PST)
Date:   Sun, 6 Dec 2020 22:32:58 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     b.K.il.h.u+tigbuh@gmail.com
Cc:     wireless-regdb <wireless-regdb@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wireless-regdb: recent FCC report and order allows
 5850-5895 immediately
Message-ID: <X82welCPwyUV8VJw@ubuntu-x1>
References: <a79286b90cdfdee3a83397008c0f7b6d67bc7f69.1607035229.git.b.K.il.h.u+tigbuh@gmail.com>
 <X8pRrWfZPhLdguu8@ubuntu-x1>
 <CAPuHQ=EUcsn24EoSP+PGH2H6kPROvauyJN_6RtYLXqVYW=sK-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPuHQ=EUcsn24EoSP+PGH2H6kPROvauyJN_6RtYLXqVYW=sK-g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Dec 05, 2020 at 09:24:03PM +0100, b.K.il.h.u+tigbuh@gmail.com wrote:
> Thanks for double checking. Honestly, I've only spent a few hours
> skimming through the document and haven't read it through all the way.
> 
> Agreed that both bandwidths should probably be upped to 160.
> 
> Considering  § 15.407 (a)(3)(v): shouldn't the flag `PTMP-ONLY`
> already signal this infrastructure-mode only restriction? I think
> sending a probe request frame before connecting may be considered a
> "brief message", and NO-IR would even disallow that. Also, if we added
> NO-IR, wouldn't that close the band for AP's running Linux as well?

But it's a brief message "after detecting a signal that confirms that an
access point is operating on a particular channel." I think that implies
a passive scan, then sending an association request only after seeing a
beacon from the AP on the channel. I could be wrong though; my memory on
the 802.11 protocol is rusty and out of date.

Thanks,
Seth

> 
> Other than deciding the above questions, should we get back to
> finishing this patch after publication sometime next year? There may
> be a chance for it to change until then.
> 
> On Fri, Dec 4, 2020 at 4:11 PM Seth Forshee <seth.forshee@canonical.com> wrote:
> >
> > On Thu, Dec 03, 2020 at 11:40:30PM +0100, bkil wrote:
> > > The new band is called U-NII-4.
> >
> > The report states in paragraph 203 that the order is effective 60 days
> > from publication in the Federal Register, and it looks like they haven't
> > even been published in the Federal Register yet. We will need to wait
> > for the rules to go into effect before applying any updates.
> >
> > > The report recommends combining it with 5725-5895 to allow 160 MHz
> > > bandwidth, but that's technically not that easy with regdb due to the
> > > differing restrictions of the two parts. Marking the line for U-NII-3
> > > NO-OUTDOOR and PTMP-ONLY along with extending its range would be a
> > > possible workaround, but this needs to be discussed.
> >
> > I think it should be sufficient to set the bandwidth of both 5730-5850
> > and 5850-5895 to 160 MHz with AUTO-BW. The kernel will see the AUTO-BW
> > flags and calculate a combined rule where 160 MHz is allowed, and for
> > the original rules any bandwidth exceeding the available bandwidth of
> > the rule will be disallowed.
> >
> > > I don't see a requirement for TPC, hence reducing EIRP by 3dB is not
> > > needed. I've marked it 33dBm (minus 6dB for clients) to cope with 20MHz,
> > > but the band can support higher power, though the logic is complicated.
> >
> > I believe we have an additional requirement from § 15.407 (a)(3)(v):
> >
> >   In the 5.850-5.895 GHz band, client devices must operate under the
> >   control of an indoor access point. In all cases, an exception exists
> >   for transmitting brief messages to an access point when attempting to
> >   join its network after detecting a signal that confirms that an access
> >   point is operating on a particular channel.
> >
> > This sounds like a requirement for passive scanning, if so the range
> > should also have the NO-IR flag.
> >
> > Thanks,
> > Seth
> >
> > >
> > > The upper subband (5895-5925 MHz) of the new band is reserved for ITS.
> > >
> > > "We limit unlicensed use to indoor operations in recognition of the
> > > potential that ITS licensees may currently be operating"
> > >
> > > "We also proposed that U-NII-4 devices be permitted to operate at the same
> > > power levels as U-NII-3 devices."
> > >
> > > "For the U-NII-4 band, indoor access point EIRP will be limited to
> > > 33 dBm/20 MHz and 36 dBm/40 MHz. When combined with U-NII-3 band spectrum,
> > > indoor access point EIRP can scale to 36 dBm for 80 and 160 megahertz
> > > channels."
> > >
> > > "Client devices would be limited to power levels 6 dB below the power
> > > limits for access points."
> > >
> > > "the First Report and Order prohibit U-NII-4 client-to-client
> > > communications to protect co-channel incumbent ITS"
> > >
> > > Signed-off-by: bkil <b.K.il.h.u+tigbuh@gmail.com>
> > > ---
> > >  db.txt | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/db.txt b/db.txt
> > > index c71a03a..e6dd063 100644
> > > --- a/db.txt
> > > +++ b/db.txt
> > > @@ -1587,7 +1587,10 @@ country US: DFS-FCC
> > >       # requirements, we can extend the range by 5 MHz to make the kernel
> > >       # happy and be able to use channel 144.
> > >       (5470 - 5730 @ 160), (23), DFS
> > > -     (5730 - 5850 @ 80), (30)
> > > +     (5730 - 5850 @ 80), (30), AUTO-BW
> > > +     # https://www.fcc.gov/document/fcc-modernizes-59-ghz-band-improve-wi-fi-and-automotive-safety-0
> > > +     # max. 33 dBm AP @ 20MHz, 36 dBm AP @ 40Mhz+, 6 dB less for clients
> > > +     (5850 - 5895 @ 40), (27), NO-OUTDOOR, PTMP-ONLY, AUTO-BW
> > >       # 60g band
> > >       # reference: section IV-D https://docs.fcc.gov/public/attachments/FCC-16-89A1.pdf
> > >       # channels 1-6 EIRP=40dBm(43dBm peak)
