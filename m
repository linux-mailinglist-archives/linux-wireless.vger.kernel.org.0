Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED0D111A788
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2019 10:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfLKJjb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Dec 2019 04:39:31 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43826 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfLKJjb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Dec 2019 04:39:31 -0500
Received: by mail-yw1-f67.google.com with SMTP id s187so8697874ywe.10
        for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2019 01:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8x+Y+g7D+wywTIuCCRndpwe4hjsPYQiM40tzg3LPGjM=;
        b=FoBmU3OLb5+JeiqmEMULFWny9uAu9+oYzKP5uz8LtC+4oaeCwwcCw2U9OrU9gCFKYf
         9Qt/1y4oMgs+/xb0aebkudFXteHFg6fUAl8106JyPVf/A6jZEKjKTwAOpYKPVHoGX47x
         gPH+Kxq7mPUEWTQHI1FmQ3eYy8VONLXwO8LMUd70iaH2gNt2cp+n2DGUdsZn0HjU2AUK
         BNH4Z7x22ipo3Y0sK51FhERdykWqY64DrYm8+2O3ym9DIq4y/YgRm8XZUQUQbRw3ZNTx
         1jXwwrY/YEIXvvixn6YqdieJp5S6pdnNvegHtmsnQvMPFSKYWqGl52+mfjaqrMyGLQP9
         KyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8x+Y+g7D+wywTIuCCRndpwe4hjsPYQiM40tzg3LPGjM=;
        b=hhCfMmGCaRKCEwgQava+GSJ5lcgqEKgywLXq4yoEdR+bwiz6E2yHhjXBPyY7DvvDya
         3nEFEN31UnEXWywgWJmofbtGWCbxyZ4TLCZeLH6YO5WoTNRcM5TJ/PlZ8+pOdFhWxHil
         f8fHVbm5gKmivdmrgcc2aUz/11V99/tu1CmUXkLgq7B3gEvi6M2Iebu4BuZcU1gDjmpp
         pHsU+jkmQmkO9bz5v8oOfc9bukBGq+tZe3BAyFn8Y+C3oUWEMoIGVixn2FaswHIphESz
         MSRnCgaFHgMR36Zqmze02yDu0EDrlGfBHdwSwFhvF8R/Jpq+wukBzBF4n3FfAnfxNvYt
         qs7Q==
X-Gm-Message-State: APjAAAWBRvTIsupbYRhznz3epCtmi7pBW4a7KblJuaPcLXPQP7zz24Fl
        rv8V82LS3oym2Ac/BgBA9mtlYuWJ4QEXXPLu+10=
X-Google-Smtp-Source: APXvYqxthHe7jUNZD8lp5PojSnH7tYNrwWFyGjzrGJyXNJI+7bow3AMQuxeAVe9ldkYltrHvwogmfm1TKfAVcVALqyM=
X-Received: by 2002:a81:d549:: with SMTP id l9mr1569378ywj.58.1576057170296;
 Wed, 11 Dec 2019 01:39:30 -0800 (PST)
MIME-Version: 1.0
References: <CACyXjPzq-ePB1ux6wi_Rv3onPKXomcJcm15XJwA51u0E4W2txw@mail.gmail.com>
 <38F46E1D-1C4A-48DC-A906-9522006E8474@alum.mit.edu> <1606812C-649C-4C06-ABE0-AE2F4474BCD0@alum.mit.edu>
 <1440402013.3735.1.camel@sipsolutions.net> <CACyXjPwSZPV+U_=zQpDBpeBnhMntzEFhyJnBOw3-N8qPfyHc1A@mail.gmail.com>
 <55DE44EB.6080603@superduper.net> <126B842D-05EA-4510-BC9B-DB1A4AABEC12@alum.mit.edu>
 <1135A126-6A5A-4C84-A52D-13C0387609CC@alum.mit.edu> <1442507879.2821.9.camel@sipsolutions.net>
 <C5FF46C6-BDEE-41D8-B7E1-1EFFE9411DE3@alum.mit.edu> <4cf0c2a4a2d1cd92dff4f1a791d74523e446cf01.camel@sipsolutions.net>
In-Reply-To: <4cf0c2a4a2d1cd92dff4f1a791d74523e446cf01.camel@sipsolutions.net>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Wed, 11 Dec 2019 15:09:19 +0530
Message-ID: <CABPxzY+0v-Rb-GWkL-iwCfefzhFE5AiGBh2xxV_U_OC0Q+eoVQ@mail.gmail.com>
Subject: Re: Correct radiotap header for 802.11ad
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Guy Harris <guy@alum.mit.edu>,
        "radiotap@netbsd.org" <radiotap@netbsd.org>,
        Simon Barber <simon@superduper.net>,
        Richard Sharpe <realrichardsharpe@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Maya Erez <merez@codeaurora.org>, wil6210@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Dec 11, 2019 at 2:02 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> ++ for the DMG discussion
>
> On Tue, 2019-12-10 at 15:51 -0800, Guy Harris wrote:
> > On Sep 17, 2015, at 9:37 AM, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Reviving an old thread :-)
>
> > > Not being familiar with DMG, I can't really comment on this.
> > >
> > > It does sound like we need *some* new field though, be it either a DMG
> > > field or a PLCP SIGNAL field, or perhaps even both.
> > >
> > > Going back to the original thread though, I think using the MCS field
> > > is quite wrong.
> >
> > But a presumably-Linux system does appear to use it; see Wireshark bug
> >
> >       https://bugs.wireshark.org/bugzilla/show_bug.cgi?id=16272
> >
> > For now, I'll throw a hack into Wireshark to treat a signal >= 60 GHz
> > as meaning 11ad,
>
> I don't think that's quite right - you'll need to do something like >=
> 56 GHz.
>
> > but, again, should there be additional fields for 11ad?
>
> I would think so.
>
> On the one hand I think (and looking at the spec seems to confirm this)
> that basically DMG uses an MCS index. Now, the MCS radiotap field was
> designed for HT and has a lot of things that are not applicable (GI,
> STBC, etc.)
>
> OTOH, there are DMG-specific things that probably ought to be captured
> by a proper sniffer, like the PPDU type, training length, etc. Also,
> there's the thing with the "Extended SC MCS Indication field", which
> really also ought to be captured.
>
> Sadly, the only Linux implementation didn't bother adjusting any of this
> even in the Linux general stack (and I didn't pay enough attention to it
> at the beginning), so even the rate reporting to userspace is just the
> MCS index. This might actually be sufficient for the current uses
> (there's a conversion function to bandwidth too), though it doesn't seem
> quite applicable to the whole spec.
>
> For both the Linux userspace reporting and radiotap then, this
> completely ignores the existence of the MCSes 9.1 and 12.1-12.6, which
> cannot be captured in either format right now. Maybe the extended SC
> MCSes are just not used by equipment in the field?
>
They are used. Unfortunately, Linux-wireless doesn't have native support for DMG
wil6210 and our driver has to workaround by using HT IE's
(ieee80211_supported_band).
>
>
> In any case, to capture DMG properly I'd say we need a new radiotap
> field with at least
>  * (base) MCS
>  * Extended SC MCS bit
> and it should probably optionally cover the other possible fields as
> well
>  * Scrambler Initialization
>  * Length (?)
>  * Additional PPDU bit
>  * PPDU type bit
>  * Training Length
>  * Beam Tracking Request
>  * Last RSSI
>  * Turnaround
yes, we definitely need this, there are some additional fields in
11ay, but I guess that
discussion is for another time.
