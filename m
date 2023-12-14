Return-Path: <linux-wireless+bounces-797-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C148131A1
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 14:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5630F1F22213
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 13:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD31E56473;
	Thu, 14 Dec 2023 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MYEJ/0Fd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A9F128
	for <linux-wireless@vger.kernel.org>; Thu, 14 Dec 2023 05:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OGmOdeBKAMsY/kbajXVRe90anub7rYVK5ahJ/Ss1iks=;
	t=1702560681; x=1703770281; b=MYEJ/0Fdxc6Eqeg/17ys6N8DajkiL7rsXVHFVXZG5Ro6kPW
	aNTHe5uKYTPvH1BFBE8Gz9t1XUMNH+nCsxawRug+6I7wAxkBnGsSgHqiEzYo2kNGgwkeyzC6Uuk25
	mkhFo4vAHsmhcIrUn/130P9fmoJ7FJKT+XKH6J0wILNZjaIh2588cwLQLBIPuNSivS5nbBKSwkDim
	7mlbqhY2gcHlxzyTib+rvyCZeJrd0gqyN5CgBMgN/1fTHh1BdF5DvAkovJ2ABJ8qT6F8S9ZR58Bww
	xc+ACFbtQijT9mMuBaoSRt5DLqxJMeUTVbtlvPA8VaKApWYinJl0IWlf/+9Y67hg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rDlo5-0000000ArAu-3rkq;
	Thu, 14 Dec 2023 14:31:18 +0100
Message-ID: <2f7b735e343a46066236ad4bbdb64236e5fa4691.camel@sipsolutions.net>
Subject: Re: [PATCH v3,2/2] wifi: mac80211: refactor STA CSA parsing flows
From: Johannes Berg <johannes@sipsolutions.net>
To: Michael-cy Lee =?UTF-8?Q?=28=E6=9D=8E=E5=B3=BB=E5=AE=87=29?=
	 <Michael-cy.Lee@mediatek.com>, "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>
Cc: "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>,  "nbd@nbd.name" <nbd@nbd.name>,
 Evelyn Tsai =?UTF-8?Q?=28=E8=94=A1=E7=8F=8A=E9=88=BA=29?=
 <Evelyn.Tsai@mediatek.com>, "lorenzo@kernel.org" <lorenzo@kernel.org>,
 Money Wang =?UTF-8?Q?=28=E7=8E=8B=E4=BF=A1=E5=AE=89=29?=
 <Money.Wang@mediatek.com>
Date: Thu, 14 Dec 2023 14:31:16 +0100
In-Reply-To: <4d8562c2ad67e6476805a436e36b70954161a178.camel@mediatek.com>
References: <20231129054321.10199-1-michael-cy.lee@mediatek.com>
	 <20231129054321.10199-2-michael-cy.lee@mediatek.com>
	 <575322249ff9b9d062edfc3bd6aa234a085d6a94.camel@sipsolutions.net>
	 <4d8562c2ad67e6476805a436e36b70954161a178.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

Sorry for the delay.
=20
> I would like to start by explaining why we prioritized the operating
> class.=20
>=20
> In IEEE Std 802.11-2020 11.38.4 (Channel switching methods for a VHT
> BSS), there is a note about operating class and WBCS Element:
> =20
> =E2=80=9CNOTE 2=E2=80=94The indicated operating class within the Extended=
 Channel
> Switch Announcement element identifies the bandwidth and the relative
> position of the primary 20 MHz and secondary 20 MHz channels. Hence a
> Wide Bandwidth Channel Switch subelement is unnecessary when the
> Extended Channel Switch Announcement element is used for a channel
> switch to a 40 MHz bandwidth.=E2=80=9D

That's ... interesting. I hadn't seen that. But I guess it doesn't
surprise me, it's in line with what seems to be a general push to give
the operating class more relevance :)

> Although it only limits the switch to a 40 MHz bandwidth, we thought it
> is applicable in 80/80+80/160 MHz bandwidth. So in the version 1, we
> preferred to use the operating class than the WBCS Element.

Right. Though at least with 40 MHz you can do "opclass X -> secondary is
above" and "opclass Y -> secondary is below", without really relying on
the channelisation plan. For wider than 40, you can't do that any more,
I think?

> Also, we agree your suggestion that WBCS Element has higher priority
> than operating class. Our reason is, when channel switch to a bandwidth
> wider than 40 MHz, WBCS Element is mandatory while ECSA (which contains
> operating class) is not.

OK :)

> (Note that either CSA or ECSA will be sent in a channel switch.)

Right.

> BTW, I would also like to clarify one thing. We did this upstream work
> solely based on the standard and with the intention of contributing to
> mac80211. In fact, we developed and tested with the upstream driver
> (mt76) for AP and STA solution together. Before doing upstream, we used
> the MTK AP (proprietary solution) to do IOT tests and indeed found some
> problems, which were already reported and fixed.
> So, we were not aware of what was going on to MTK AP until we used it
> to do an IOT test. We didn=E2=80=99t do it with the intention of covering=
 the
> broken WBCS element sent by MTK AP.

:-)
I'm sorry I shouldn't have phrased it that way, I apologize.

Just by sheer coincidence, both these patches and the AP bug report for
our client landed in my Inbox at around the same time, and I clearly
drew a conclusion I shouldn't have.
=20
> For other replies, please see the inline. (we deleted some of your
> replies since we just change as you suggested)
> In summary, we=E2=80=99ll modify the code and submit a new version.

sounds good

> > So perhaps better:
> >  - use, in this order: BWI, WBCS, ECSA, CSA (according to the mode
> >    we parse as, and our own capabilities)
> >  - if present, check that operating class agrees
> >=20
> > no?
>=20
> we agree the order. AS for the check for operating class, we think it=E2=
=80=99s
> a little useless.

I don't disagree that checking the operating class is "a little
useless". Up to you :-)

What I've been brewing in my head for a while now though is a (per-
wiphy?) "strict mode" where we do more such consistency checks, and also
disable workarounds like using beacon elements if missing in association
response. I'd want to enable that in our testing, and perhaps also when
doing interoperability testing with other APs.

I realize that's only tangentially related to this patch, but I think it
could be very useful.

> Image the case that the WBCS Element and the operating class indicate
> two different  chandef, but both are valid, which one should we trust,
> or neither?
> Our answer is that WBCS Element is worth trusting, since it is
> mandatory in a channel switch to bandwidth wider than 40 MHz, while
> operating class isn=E2=80=99t.=20

Yeah, makes sense. We could have a check behind a "strict mode" flag,
but I guess that's something for the future.

> The operating class can be use in the case that the WBCS Element is
> missing or indicates a wrong chandef. In other word, the operating
> class has lower priority than WBCS Element.
> What do you think?

I'm not sure I'd use it for the case of "wrong chandef"? You said
yourself that WBCS is mandatory and opclass is optional, so I think we
should be able to trust the AP when it says WBCS is something, and if
it's confused about it, we'd better not trust it to accidentally (?)
have gotten the opclass correct?

> We will change the HT/VHT operation to static allocation in the
> function. However, the size of HE/EHT operation are variable, so it can
> only be dynamically allocated.

There's a pretty small upper bound though, so you could just pack it
into a struct with a buffer?

struct {
	struct eht_operation oper;
	u8 buf[MAX_EHT_OPER_OPTIONAL];
} __packed eht;

and use it as "eht.oper"?

Maybe not worth it though. We cannot use dynamically sized stack arrays
in the kernel, so that wouldn't work either.


> According to the Standard, 80+80 MHz bandwidth still exists in HE mode.
> The function ieee80211_chandef_he_6ghz_oper() handles this case.

Hah, OK.

> However, from our experience, there are few commercial APs that support
> 80+80 MHz bandwidth in HE mode. We can remove it, what do you think?=20

I have no idea. We don't support it even as a client, so we'd always
just use 80 MHz. So from our (Intel) POV it doesn't matter. Up to you. I
don't mind having it or leaving it out, either way. Now that you have
the code anyway maybe leave it?

> > > +/* parse one of the Elements to build a new chandef */
> >=20
> > except you don't really, as discussed above
> >=20
> > I'd actually kind of like to have these validated against each other,
> > but that's for another day, and we don't build the strictest
> > implementation.
> >=20
> > Though I probably will make the implementation optionally stricter in
> > some places like this, and enable that for all testing/certification
> > in the future.
>=20
> we agree that the validation can be done in the future.

Right, which basically the discussion above.

Thanks!

johannes

