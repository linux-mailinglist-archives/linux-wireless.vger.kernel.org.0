Return-Path: <linux-wireless+bounces-25912-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6704B0EC1E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 09:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D13E1AA743B
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 07:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBC5191493;
	Wed, 23 Jul 2025 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vRlHZP6e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1FE277017
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 07:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256425; cv=none; b=HDC9t0irIbqze+M78eXHXf4K1bXLLoWWmDlicN+ggHrBi3eay7gHN/hLGB1Z/3rWti8TR31OMIguReTWBl3M54OnJjYkzOOmettf3w0TnRMDNQe2ogOJg24AoVcBBnmnYVSu6jmmpLBjeP5sZAwJXaHF/bZFbooN5hhSUpHOryk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256425; c=relaxed/simple;
	bh=jvvLBOgLbUSiRZKOOJnhMTlRx7vZ7+8jRt8+/uyxfs8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mywojxBQyLr6CMNnwqVj3BdIXbbEcrunzwxoK3Nhgn7qAYTY+7DTrxUmyCEVCsQtS8HyMkmQX0os4dg3U5IvJMnI64f7Rs5ls96gnL6+FCss4ZJkuJVNqEwZVnVlk+bhyW3BwDuOzaKPGDU+p29hQH1TMj0zFKUjRvoWoISuKBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vRlHZP6e; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=p8kbkzGb6m5ij0O4/EU+JzpzYuAuMxgh9EdB2Fi+oNo=;
	t=1753256423; x=1754466023; b=vRlHZP6eCukoE4DUWMDl8j4qmyJMrZpHeColXzWW+hQBObr
	JG3M85nLWLIKbqdBQQ8qB3HclBXxiOPuMrgUhiWJ3lj/osOPyykmwJeCB5VK5KkL0VpD66Dc9UxyX
	n/ASVERRZzg24ceUqYPt+d1QsZHvKGuMcT2o8Wh+BPT4HnRT+oDGsOjrYBWBsChIrAGnvtMLaSSbX
	v7LdMdnzMPKYdQzhC6lZJpgb+SDqXs+uG7luZZwvVUqUdEAJ1185S48ERb7xfnKUVdXP6PZ3biuZD
	SCPzzZ+TtxqYZ+PCR2G1hMUT0ActJxZMMcNADBOI5KRXyZFUwWuf23+u3dsS9pUw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ueU54-00000003Yo0-38yl;
	Wed, 23 Jul 2025 09:40:03 +0200
Message-ID: <de49f2491030902d981840f36087af3dc2c9377e.camel@sipsolutions.net>
Subject: Re: [wireless-next 2/2] wifi: mac80211: support parsing S1G TIM PVB
From: Johannes Berg <johannes@sipsolutions.net>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Date: Wed, 23 Jul 2025 09:39:47 +0200
In-Reply-To: <yy2mk5xsimlpnohsg7d22cl7u45n3exmu43jo5l3qmqjx5wzer@mrnzw7rax5ew> (sfid-20250723_042945_817204_37C054A0)
References: <20250722071642.875875-1-lachlan.hodges@morsemicro.com>
	 <20250722071642.875875-3-lachlan.hodges@morsemicro.com>
	 <e60156bc1097385bceb624bac6bf55906947e6a9.camel@sipsolutions.net>
	 <ksb6rptacpnyxbcep332q247agx2u62h6o3j4oqfestaal2b7x@el6snwrs4kx5>
	 <98abd0c936a6169a106682da9359c01708cf4ee9.camel@sipsolutions.net>
	 <yy2mk5xsimlpnohsg7d22cl7u45n3exmu43jo5l3qmqjx5wzer@mrnzw7rax5ew>
	 (sfid-20250723_042945_817204_37C054A0)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi Lachlan,

On Wed, 2025-07-23 at 12:29 +1000, Lachlan Hodges wrote:
> Hi Johannes, yes that would be correct. For an AP advertising page
> slicing support, we could validate that within ieee80211_alloc_hw() and
> reject those trying to do so? I see there is _some_ validation for
> various HT configuration so this may make sense?

I'm not sure it matters that much one way or the other. We do that in
some cases, but also not in others, and I think someone who implements a
driver really needs to be aware of what's happening?

Up to you, add whatever you think is unlikely to be immediately obvious
perhaps? Off the top of my head I don't even know where/how the feature
advertisement works.

> So after some discussion internally, we agree that even if mac80211 only
> supports a single encoding mode, it should be able to decode all
> formats. This ensures complete interoperability on the STA side and on
> the AP side well the AP dictates it so shouldn't be any issues there.

Right. Makes sense.

> > Obviously the AP side then for S1G can't just put the partial virtual
> > bitmap from the ps->tim bitmap into the frame, but that's ultimately
> > just a question of bit twiddling while building the frame too. So not
> > sure where a union is needed for the AP side :)
>=20
> Sorry I did mean literal C union i.e:
>=20
> union {
> 	u8 tim[IEEE80211_MAX_AID];
> 	u8 s1g_tim[IEEE80211_S1G_MAX_AID];
> };
>=20
> of some sorts.

Oh, OK. I always just thought of the tim bitmap as just a bitmap,
regardless of its size, but OK, understood.

> Realistically however, nobody right now can get over 2008
> STAs associated, so I have no issue (and would be easier) to simply use
> the existing AID count for S1G (basically, remove all that AID
> validation stuff I added.. plus wasn't even done correct anyway). With
> this in mind however, we need to account for the TIM length which you
> alluded to below. Ill discuss that below, but I think from our side we
> have no issues limiting the AID count to 2008 or potentially lower and
> as you state, this can be an implementation choice.

Right.

> > (And kunit tests for this parsing would probably be a good idea :) )
>=20
> I assume when I implement these kunit tests they will simply be apart of
> the patchset? i.e go through the wireless-next tree?

Yes, they just go to net/mac80211/tests/. You can put something in the
same patch or if you feel that gets too big into a separate patch in the
series, I don't really care too much.

> But yes as you
> alluded to I think adding kunit tests with all samples for Annex L would
> be beneficial so Ill ensure to get that included with the next patchset.

Thanks much!

> > Once you get to/above 1600 you have a trade-off to make, you cannot
> > indicate the absolute worst case without paging any more. You could hop=
e
> > that STAs will retrieve their data and then you get free blocks, some
> > Block Bitmaps won't need to be 0xFF, and then you have more space, even
> > without resorting to other encodings.
>=20
> Correct. The choice I decided on was simply limiting the the AID count
> to 1600 (albeit, I think incorrectly given I did it on the STA side).

Yeah I understand now that was in some way incorrect, before I was just
confused :-)

> Thinking about this more though, if we keep the existing max AID count
> of 2008, which would leave all validation the same (always a good thing :=
)) =20
> is we could then simply stop adding blocks _if_ we are about to exceed
> the maximum length, let those STAs clear their bit and on the next
> beacon proceed? That way you'd have the block offsets increase and those
> earlier AIDs get cleared and so on.

Right, you can of course easily remove zeroes from all the blocks and
not set the bit in the block bitmap when the whole subblock is 0, and
also exclude the entire block when the whole 64 bits are 0.

That way, only a pathological case of having at least one out of every 8
stations have pending traffic will ever drop some information at the
end.

> Obviously we are discussing a case that should _never_ happen, but still
> need to account for it. I am leaning more to the case of utilising the
> max AID count of 2008 and simply preventing TIM length overflow (this is
> actually what I originally did) but you may see some issues with that or
> not. Let me know.

Sure, it's a bit of a trade-off in the encoding code, making sure it
cannot run over the element length vs. knowing a priori that it cannot.
Clearly it's a corner case, so it doesn't really matter.

> > But I think for an initial implementation you could just leave that
> > aside, limit AIDs to <1600, implement only block encoding and accept
> > that it's just not optimal in many cases, but at least you won't have t=
o
> > worry about not being able to include some data?
>=20
> Ha, now my mind is changed >:).

Hah, well, I don't really think it's an issue either way.

> It seems the error from my patch (and
> probably a source of confusion for you) is that I was only validating
> the maximum AID on the client side,

Yeah, that seemed to serve no practical purpose since even with an AID
<1600 the AP could still encode it in any kind of block, and so I just
really got confused about it.

> whereas (and, do correct me if im
> wrong) on the AP side the AID is passed down from hostap via
> NL80211_ATTR_PEER_AID, which is then validated using the
> NLA_POLICY_RANGE where the max is IEEE80211_MAX_AID. So if we were to
> limit the AID to 1600 for S1G, we'd need some way to validate it within
> cfg80211. Don't think this would be too hard, since we can confirm we
> have an S1G station via the presence of the S1G capabilities within
> nl80211_set_station_tdls():
>=20
> ...
> 	if (info->attrs[NL80211_ATTR_S1G_CAPABILITY])
> 		params->link_sta_params.s1g_capa =3D
> 			nla_data(info->attrs[NL80211_ATTR_S1G_CAPABILITY]);
> ...
>=20
> where we could maybe perform some extra validation on the AID? I know
> its maybe not the prettiest since we aren't technically using the
> explicit nl80211 intrinsic validation - but I would say it gets the job
> done.

Ohh! Now I see where you're coming from, I was completely handwaving
away the _practicalities_ of checking the limit in my head.

I mean, sure, we currently use a policy ... Using the S1G_CAPABILITY
attribute wouldn't work if hostapd isn't including it at that time, but
mac80211 can always also do the validation. Worst case we can even
expose a new max-AID attribute, per interface type.

If we wanted to extend it later to up to 8191 then we'd need to remove
the IEEE80211_MAX_AID policy anyway since it'd be limiting to much less.

So I don't really see this as too much an issue, I'd probably just have
added a comment in nl80211.h that it's practically 1600 for S1G for now,
and added validation in mac80211. Then if _later_ we extend it, we can
add a feature flag/feature attribute for "now we support bigger AIDs for
S1G".


> I think what I'll do from here, is wait for your response to my
> comments, mainly on the maximum AID count and any other comments you may=
=20
> have, and work on v2 which would roughly consist of the following:
>=20
> 1. On the AP side, we simply support block bitmap encoding. Patch 1=20
>    would more or less be the same (with the addition potentially of
>    new AID validation) though I'd add some details in there and
>    change some comments etc.

Sure. I write in a comment on the other patch that
IEEE80211_MAX_AID_S1G_NO_PS should probably not be in ieee80211.h, but I
guess with the changes to validation etc. you'd renamed that anyway and
put it in a different place. Or remove it.

> 2. Support decoding the other encoding modes on the STA side. I think
>    while a bit more work upfront, worth it in the long run.
> 3. Add in some kunit tests to tests both the encoding of block bitmap
>    and also the decoding of all the formats from Annex L.
> 4. Fix up the AID stuff depending on what you think, If we go with the
>    hard limit of 1600, ensure on the AP side we perform that validation.

I really don't mind either way. Like I said above, it's a bit of a
question of complexity in the AP encoding implementation. Maybe just
start updating the AP encoding implementation and see how hard the TIM
element length validation would be to add to it, vs. a priori knowledge
that it'll always fit?

With all this newfound knowledge I'll take another look at the patches,
but won't send more email if I don't see anything else :)

> Whew. Thought I became a software engineer to write code, not essays :)
> (though Im guessing you are very used to that...). Detailed response is
> much appreciated, and I think saves us both time from having to submit
> and review many patchsets.

:-D

johannes

