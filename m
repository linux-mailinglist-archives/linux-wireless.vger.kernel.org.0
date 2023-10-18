Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554677CDC7B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Oct 2023 14:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjJRM6o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Oct 2023 08:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjJRM6o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Oct 2023 08:58:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F6C106
        for <linux-wireless@vger.kernel.org>; Wed, 18 Oct 2023 05:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=H6wpHQyqDRiGMAVO4r6r3kA3To3bH+EnFoHtKSoZecw=;
        t=1697633922; x=1698843522; b=kUrAoalDUgV/Q1ITGXki+hlVQVm3eqNVtckXsspiFeyqPjn
        9wxebqgWTNms8X4w1TRh/FCr0ZH3/nP3+jBESI7p2KMfc8s2Lsq0K32WZ/YiHdiPGvFxtErhkGDNs
        9IjIufOO/wUrAiwWeZpGqNy2fofpW1I9EA/MzBK3bh9yQyYg2xobmZbCkPygGlvYZ5Pr05jPZba2I
        YN7VQQzqUwQs0iNnmfoaxnHChdW8YPPUoYiFgHDPaJd3sjfw8Ut93GG4MEfNypR+l0qcTS5FkdEPx
        MmyB5fO0bUw10D2NbHrmVGxjGVWTccIcy8SEdr1h9/+z4ai0di8XbkFVuo9gQO6g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qt68E-0000000Bopw-4BvM;
        Wed, 18 Oct 2023 14:58:39 +0200
Message-ID: <28b099e7a37824f0b59ab824e67b3437485e45d5.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] cfg80211: validate RU puncturing bitmap
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 18 Oct 2023 14:58:37 +0200
In-Reply-To: <460cb443-868c-ec05-7aec-5b1eee381ae2@quicinc.com>
References: <20220214223051.3610-1-quic_alokad@quicinc.com>
         <20220214223051.3610-3-quic_alokad@quicinc.com>
         <a9813545a25cd63f71cc31476230514a80350802.camel@sipsolutions.net>
         <6cf56be5-16d6-2bcd-150f-bf29f98b7f1b@quicinc.com>
         <58fdd62041c0388740cabea5a421c5417f959124.camel@sipsolutions.net>
         <9fd4a3097e078c1fe2acd5fbd0c559b0390daa49.camel@sipsolutions.net>
         <460cb443-868c-ec05-7aec-5b1eee381ae2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> > > > Regarding if different puncturing pattern should be considered as a=
 new
> > > > context - yes, depending on if it is HE or non-HE mode, the new bit=
map
> > > > may be invalid and the operation should fail.
> >=20
> > Which I'm not sure I understood then, and certainly not sure I
> > understand now, but I said:
> >=20
>=20
> 802.11be allows only few patterns when AP is operating in non-OFDMA mode=
=20
> but if OFDMA is used then each 80 MHz sub-block can have a different=20
> puncturing pattern when BW > 80MHz.

Right, but that's not the same, it's per PPDU more or less, no? I mean,
you say in the trigger frame for example that some RU is not allocated.

So is that relevant here?

> I know *_HE was not the best terminology, originally it was *_OFDMA but=
=20
> later changed because we decided to base the puncturing bitmap=20
> validation based on HE vs older modes.
> Function "cfg80211_ru_punct_bitmap_valid" added in this version first=20
> checks for non-OFDMA patterns, and only if "ru_punct_bitmap_supp_he"=20
> attribute is set by the userspace then it goes further to also check=20
> against patterns allowed for OFDMA.
> I could not find any other way to decide OFDMA vs non-OFDMA than letting=
=20
> userspace explicitly indicate latter.
> It would be great if you can provide your inputs on this.

This ... doesn't exist upstream?

OK actually it did exist in this patch though.

Not sure I understand. Let's go back to what we have in the tree now.
The only thing we check there is
cfg80211_valid_disable_subchannel_bitmap(), which on the client at least
is just for the "disabled subchannel bitmap" in the EHT operation.

Are you thinking about (separately?) configuring the OFDMA puncturing?
Which spec-wise you do per PPDU, controlled by the AP (trigger frame), I
think?


> > Which, actually, I've learned since that I was completely wrong about!
> > It should, and likely must, in fact be two separate channel contexts,
> > with all the limitations that implies.
> >=20
> > The thing is - back then I was making not just one, but in fact *two*
> > wrong assumptions:
> >=20
> >     1. The DSP/radio can receive punctured PPDUs if listening on the no=
n
> >        punctured channel.
> >       =20
> >        At least for our device that's not true, not sure about ath12k? =
It
> >        seems you have a per-peer puncturing configuration even, but tha=
t
> >        seems odd, and it's always just set to the vif puncturing
> >        configuration.
> >       =20
>=20
> Yes, same vif puncturing pattern is assigned for all the peers=20
> associated on that vif, but firmware requires it to be sent separately=
=20
> for each peer.

OK, thanks.

What if it differs for different vifs?

> >     2. You can simply transmit punctured PPDUs when on a non-punctured
> >        channel, i.e. it's just a rate control decision.
> >       =20
> >        This is perhaps less important, but it's also not really true.
> >        While you can clearly _transmit_ this way, that's not the only
> >        thing - you also need to do the CCA before transmitting, and if
> >        there's noise/interference on the punctured channel, you'd much
> >        more rarely find the channel to be clear and be able to transmit
> >        if this doesn't consider the puncturing, but that's something to
> >        do sort of generally in the background for the transmit.
> >=20
> > It might be possible to work around #2, but I'm not sure it's possible
> > to work around #1?
> >=20
> >=20
> > So I think I have two questions:
> >     A. Would you object if I moved the puncturing into the chandef afte=
r
> >        all?
> >       =20
>=20
> This is where I'm getting confused.

:)

> The main reason to put in chandef was that I thought of the bitmap as a=
=20
> radio characteristic (not vif).=C2=A0

Right.

> But after you brought up that AP+STA=20
> mode can have different bitmaps, even though all other channel=20
> characteristics (width, cf etc) are same, I realized my original=20
> assumption wrong incorrect.

So I convinced you, I guess, but what I'm saying is that - at least as
far as our hardware is concerned - I was wrong!

Thing is: you're not just transmitting with this bitmap, you're also
listening - for both CCA and RX - in a specific way. And at least the
way our hardware works, we apparently can't do puncturing just based on
the preamble, and can't do CCA depending on the next frame.

So that means the (non-OFDMA) puncturing bitmap *does* in fact become a
radio characteristic.

I don't know though is if that's really true for all hardware in
general, or just a side effect of our design. I could see that it might
be possible to receive punctured/non-punctured without changing hardware
configuration, and certainly that it might be doable to do CCA depending
on which frame you're going to transmit.

But in any case, as far as I'm told the hardware design we have doesn't
allow that, so I think I'd like to move this to the chandef/chanctx, and
then perhaps define a driver callback to determine compatibility, if
needed?

> Moving the bitmap to cfg80211_ap_settings() meant that each AP vif can=
=20
> have different bitmap, and I'm guessing you similarly added for each STA=
=20
> vif context.

Yes.

> Now if you move it back into chandef, how exactly will this work if you=
=20
> need different bitmaps?

You'd get two chanctx since it's not compatible, unless we define some
extra callback or hw flags to determine what's treated as compatible and
what isn't. But see above - I actually want that, now that I know how
the HW works :)

> >     B. How does ath12k cope #1/#2 above? Would we need to have a callba=
ck
> >        to the driver to compare if two channel contexts are compatible =
or
> >        not (e.g. if they have different puncturing), or does ath12k als=
o
> >        have limitations on RX/TX that mean it would actually prefer two
> >        channel contexts for the cases I had outlined in the quoted text
> >        above (STA+STA/AP+STA)?
> >=20
>=20
> If we do end up moving the bitmap back to chandef, we may need some=20
> changes, because as I said above, when I originally added it I hadn't=20
> thought of different bitmaps for each vif.
> But can you give an example of what you would consider as compatible=20
> channel contexts and what would be incompatible? I'm not clear on that pa=
rt.

Easy example:

 * control channel 36, 80 MHz, puncturing bitmap 0x2
 * control channel 36, 80 MHz, puncturing bitmap 0

Contrary to what I thought and said before, I want to treat these as
*not* compatible now, and allocate two channel contexts if I end up
having to do this.

johannes
