Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956586EA714
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 11:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjDUJfW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Apr 2023 05:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjDUJfP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Apr 2023 05:35:15 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CBFA27E
        for <linux-wireless@vger.kernel.org>; Fri, 21 Apr 2023 02:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8kUh4sF+xAh1D5Vupz3zJ2Y3eob8a64haviMdVtgPC4=;
        t=1682069707; x=1683279307; b=Oe3XOKFUDK/H1TEhZPjT97QmOP1Ut55mMBcc2/H4k0iq695
        LtiTvA3GsDIwKgfIHwnVl1s71v4Pq30eSR9rshktfgs/hqE+O8bH8NnXio9KKto3cYiWjqiLoRZ03
        /pCC112yY9/old/Oz8EvRZHr//kHojSPRN/IWqrXE55sAKe/LNgEqxbQ/yvrbz/8UlRiSOOq/KwK0
        g1xpefIK9wYmCTjC0fgSRUpAlLkDQPEawHJ0EKB+zFpdwXdWX2EFNxBBHLZIW6OXhO6LpomyoVdpB
        vfm0Q0NyNjy4+UwFrPEL3OhZhCfOvTuCZz+IC1aGZxhUnmKVGcNQbknx/Fbz3abw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ppnAW-004NLi-05;
        Fri, 21 Apr 2023 11:35:04 +0200
Message-ID: <ad5febda1c32c0d84aa8ac509fefc5b31a8b7ed4.camel@sipsolutions.net>
Subject: Re: [PATCH v1] wifi: mac80211: Initialize EWMA fail avg to 1
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>,
        Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Cc:     Karthik M <quic_karm@quicinc.com>, linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Date:   Fri, 21 Apr 2023 11:35:03 +0200
In-Reply-To: <04A41274-08B2-4473-AFD0-7D91D3850F4B@nbd.name>
References: <4f0efc62-0ca5-fe85-fdd8-9beca7ff94d7@uni-rostock.de>
         <04A41274-08B2-4473-AFD0-7D91D3850F4B@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2023-04-20 at 15:15 +0200, Felix Fietkau wrote:
>=20
> > On 20. Apr 2023, at 15:00, Benjamin Beichler <Benjamin.Beichler@uni-ros=
tock.de> wrote:
> >=20
> > =EF=BB=BFAm 20.04.2023 um 14:22 schrieb Felix Fietkau:
> > > > On 20.04.23 12:27, Johannes Berg wrote:
> > > > On Thu, 2023-04-20 at 11:30 +0200, Benjamin Beichler wrote:
> > > > > > To me, basically, I see two ways to solve this:
> > > > > >=20
> > > > > > 1) we have DECLARE_EWMA_ZERO_VALID() or something like that whi=
ch
> > > > > >     *doesn't* treat 0 as an uninitialized value, and either has=
 a
> > > > > >     separate "not initialized yet" bit (but that's iffy storage=
 wise),
> > > > > >     or simply has another argument to _init() for the initial v=
alue or
> > > > > >     so.
> > > > > >=20
> > > > > > 2) you don't just don't use 0 and 100 but say 1 and 100, that r=
esults in
> > > > > >     basically the same behaviour, but avoids the special 0.
> > > > > >=20
> > > > > > johannes
> > > > >=20
> > > > > I also ran into that problem in the past, and reviewing it again =
with a
> > > > > college, I think, this is a real bug in the EWMA implementation. =
I try
> > > > > to provide a proper patch in the next days, but actually the EWMA
> > > > > handles the internal value zero, always like in the initializatio=
n,
> > > > > which is wrong, e.g., for positive/negative averaged values.
> > > >=20
> > > > Yes, it's always wrong as long as you feed it something zero, or va=
lues
> > > > with different sign.
> > > >=20
> > > > For a lot of use cases, however, that doesn't matter. Originally, i=
t was
> > > > used e.g. for signal strength averaging, average packet lengths, et=
c.
> > > > where it really doesn't matter since you can never use 0 or values =
that
> > > > have different sign.
> > > >=20
> > > > > A quick research shows, this bug is since the first implementatio=
n of
> > > > > the ewma in the code ...
> > > > >=20
> > > >=20
> > > > Yeah, I'm aware of that, I was around for it ;-)
> > > >=20
> > > > But see above, I'm not sure I'd even call it a bug, at least not
> > > > originally with the users that we had intended.
> > > >=20
> > > > Hence I don't know if it's really good to fix this in general - for=
 many
> > > > of these cases zero can still be treated specially (and like I ment=
ioned
> > > > in my previous email, we can even here avoid 0), and then we don't =
spend
> > > > an extra byte (or likely 4) to hold a "first time" flag.
> > > >=20
> > > > Dunno. Maybe it's not worth thinking about the extra memory space v=
s.
> > > > the extra maintenance cost. But maybe at least on 64-bit we could s=
teal
> > > > a bit from the unsigned long? Not sure what all the users are..
> > > We don't actually need a full bit. We can just add 1 to the internal
> > > value for initialized values. How about this (completely untested):
> > > https://nbd.name/p/69b00c5b
> > >=20
> > Nice hack, but even a bit more dirty than before :-D
>=20
> I disagree. With my =E2=80=9Chack=E2=80=9D at least the implementation wi=
ll do the
> right thing without the API user having to worry about 0 as a value.
> It could use some comments to clarify the details, but I do think it
> makes things easier.
>=20

To me, the first question is if there are potentially any users that are
_relying_ on the current behaviour. This seems unlikely though, looking
at the ~30 users, most sound like signal/rssi, packet sizes, etc.

So let's say with the bug found here that prompted this patch, chances
are that there aren't any users that really want 0 to be special. I also
can't even really think of a reason for wanting that.


So then let's say we want to fix the existing code. I can think of these
possible ways:

 * splitting off a bit for initialized from the unsigned long
   (which at least for 64-bit should be OK since presumably most code
    using this will run on 32-bit systems too)
 * adding another value for it, e.g. making it u32 and adding a bool for
   "first value"
 * biasing the value, like Felix proposes, could be by 1 or -1 for
   example

All of these have a memory cost, of course, though the first two are
data and the second code, so for things like stations the code exists
only once and the data multiple times. On 64-bit we can probably make
the first two not have a data memory cost though.

As for biasing the value, couldn't that lead to a similar problem? It's
clearly less likely that the end of the range is reached rather than
zero, but still?

johannes
