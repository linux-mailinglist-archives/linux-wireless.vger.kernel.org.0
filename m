Return-Path: <linux-wireless+bounces-25887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF878B0E8A6
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 04:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51383A65B6
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 02:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31D81C860C;
	Wed, 23 Jul 2025 02:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="WbM8ARJW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C2519E81F
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 02:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753237784; cv=none; b=CSmcSQSDUt2tLF0d7p7gFRNjtET9DjsN4i7rKjD3YzIzHzihtwuGAVQsK6MkKf1u3kZQ1XhWAl+dlZzTZvTzd8hsxHNfpGzf6E5joWgWh5ZZd+CcHfA+KaxL1+zZNC5f/tmHPSkfCbINSSWWqMDdByeRCdyEP6J5neGPaKDpjgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753237784; c=relaxed/simple;
	bh=VY6BqN1Y/G870PypRp76IfQCFppRm9tFqIXPWHksG84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2tKN5vGyDC4YS0uUIms7oJI4dgMvyxZVftPZcgdyvGJue5PbFtacjGW4WnHYSom1eQ1WvQ9Usu2NUtb6d3gAKee0vsLRGlsSLl5tMWgkstsDsAe2+w4biMGijQl8/Hox3PUJXOCCnD4k+WGdpfenVpLSIt+bLoaH+a36jq+m2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=WbM8ARJW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23c8f179e1bso62638935ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 19:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1753237782; x=1753842582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Aw0iM7kUE874XNeapzMTw+2k5/GzA00LKU3XmUBCDQ4=;
        b=WbM8ARJWjgP79+FPxIzUTvNHXjL2b7+Cz2EHTVlC8hxSM7vwOJ/sTXmQWsRrqGJ/aW
         StH7dOjz5xb8AgMbU//fY85Pd+FRDvNB0jjgb9/cCRiO8+UbDgvDGFiLzAJH3iWyWnz6
         RzdWQ/PygQeyBFvgeTFgB+R5gYcZmHFgvxvZEL0TPbgWf2kpUKIsZGGVScSlVyH7TE5T
         iETJEfCF0q2kGKlHW/BVye/mP9VHbdR0CEfiuSt+LBhgX1jZQNI+YJl9tb+kwu/w9V5a
         d/Np9V9+S/51StqiO9r+hunrgfathuZ/2zIYKTeOnqcWk7w+EGhxq4Yvs9SkMZClIc+w
         08Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753237782; x=1753842582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aw0iM7kUE874XNeapzMTw+2k5/GzA00LKU3XmUBCDQ4=;
        b=QozuOqk4hWDKJLmRhmdrtjhcBuOCfLRpYLy8g/xntm0XEY1t6TW9DrnjaZO6/+1lnm
         PCCAGlwB08saJ48TKo8oUJvF5Hou6LNaw1BiGsICNWlQFrWOZUvQFj8WqcQS2cQY+hJV
         +ZBrX4Cr5IUCV/XTw47HQwCBWwS7v74zBGgdVKgmg5wPDGCbhnSLTqn+bV3Mi79ossMA
         qoHdr2iu/tUnBjSSU9l0RcqlsgrRm4A7gsHLMMRNQp/45OxkoWwXWgULtqh5vJVSEo/i
         YH2GxlPBYB4RIQzfwMWhxtrlh2GjOkLh1ZAQ5UJyd8Yt6OK+6HTPSqAI1SEkAvMqIJBT
         cCAg==
X-Gm-Message-State: AOJu0YwclWlJQMAARoOUwHe8+srZJEURs2uWTCr6jysphk0zCk6iKpcN
	HGdlXXzkVYnmljrDdo2U3Nd1O5V/qK/YI+rGCkzmcgQ3NHdQL4Ul55e5nCpkVn3KXUQ=
X-Gm-Gg: ASbGnctjwzkDa0lVOSSb5WQq/fJl0gwmqESXaFY2VbvWY30XCy/6d56YEOXrQmCxwaQ
	7q3t12NW88WCae/ELowIfIQBIjNUSm8KgwSrJ3ioEb7q3ak2OhMTb92ZEKWv6dXiDvvYmOGBYB3
	h4j1H+leOJbbBEHr5fzhOor83KsEKffNzKflu6Az5rMwIGJPYaKiEwP3YMg+8PKyLU6ucMbOrST
	D+7FiAsm7iNFWsA3EPgybb1kDWdcJlmuRJdTAE+Tizcf9bM7xw8ExvCX4uHo9fU7NusP4buzfMr
	xi78hHeXGwlfMvImfrVXkx6bE0fbMvGeLqLoa0/1XUpvNgXNOzYbRapmMX0UqutDFi5vpQ3wdcC
	ZTJ/mXmMc56F9iGPfD+cwN6qpuGhXXtE=
X-Google-Smtp-Source: AGHT+IFj6xJcJrIsQJhJUramy3ugQ26fvvcfv89jwvZ9tgv5yAFv2lGYV4JXvaNkf+O60qnoYhsalw==
X-Received: by 2002:a17:902:e54e:b0:235:ea29:28e9 with SMTP id d9443c01a7336-23f981b0a15mr20742875ad.38.1753237781316;
        Tue, 22 Jul 2025 19:29:41 -0700 (PDT)
Received: from localhost ([101.180.88.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6cfa0esm85158495ad.145.2025.07.22.19.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 19:29:40 -0700 (PDT)
Date: Wed, 23 Jul 2025 12:29:38 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [wireless-next 2/2] wifi: mac80211: support parsing S1G TIM PVB
Message-ID: <yy2mk5xsimlpnohsg7d22cl7u45n3exmu43jo5l3qmqjx5wzer@mrnzw7rax5ew>
References: <20250722071642.875875-1-lachlan.hodges@morsemicro.com>
 <20250722071642.875875-3-lachlan.hodges@morsemicro.com>
 <e60156bc1097385bceb624bac6bf55906947e6a9.camel@sipsolutions.net>
 <ksb6rptacpnyxbcep332q247agx2u62h6o3j4oqfestaal2b7x@el6snwrs4kx5>
 <98abd0c936a6169a106682da9359c01708cf4ee9.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98abd0c936a6169a106682da9359c01708cf4ee9.camel@sipsolutions.net>

On Tue, Jul 22, 2025 at 03:55:19PM +0200, Johannes Berg wrote:
> Hi Lachlan,
> 
> First: I missed the whole page slicing with its extra element and the
> capability when I read through it earlier. But then of course we can
> simply decide not to implement that on either side, i.e. client doesn't
> support it, and AP just doesn't take advantage of it (and thus is
> limited to fewer STAs even if some of them implement page slicing.)
> 
> (So we have dot11PageSlicingImplemented = false and
> dot11PageSlicingActivated = false as well.)

Hi Johannes, yes that would be correct. For an AP advertising page
slicing support, we could validate that within ieee80211_alloc_hw() and
reject those trying to do so? I see there is _some_ validation for
various HT configuration so this may make sense?
 
> > > Which ... seems questionable? At least in terms of message it's not
> > > actually _invalid_ if it's out of this range, in theory S1G allows up to
> > > 8191.
> > 
> > Yes, from a client side it is. See comments below.
> 
> Maybe I'm confused, but what do you mean by invalid from the client
> side"? I've been looking now and didn't find any restrictions on the AID
> for STAs that e.g. don't implement page slicing, though of course an AP
> might want to e.g. reserve lower AIDs for them and always use higher
> AIDs for STAs with page slicing even if lower AIDs are free.

Sorry, I could have worded this better. I was talking from the
perspective of the implementation of this patchset - where we strictly
limit the number of AIDs based on limitations of the TIM length in worst
case scenarios (where that 1600 number came from). From the standards
perspective the limit is 8192 - regardless of whether page slicing is active.  
 
> > > Also the parsing for S1G only parses a subset of the valid formats,
> > > notably the format that mac80211 can generate. That seems questionable,
> > > unless you expect there never to be another implementation (or the
> > > mac80211 one to never be extended) and you can basically make up your
> > > own standard?
> > > 
> > > And even if you _do_ get an AID that's <1600 there's still no guarantee
> > > that the encoding will be in the bitmap format, if only two stations
> > > have traffic the AP might well decide to use the "Single AID" mode?
> > > 
> > > So I'm overall a bit confused how all this is meant to work - even if
> > > only partially - because AID<1600 is no guarantee that you can parse the
> > > bitmap, so turning off powersave only for AID>=1600 will not really be
> > > sufficient?
> > 
> > This is something we discussed internally, and in retrospect mac80211
> > should be able to parse all types, even though it may only encode a
> > single type. So actually my reasoning for this is not very good as it
> > was essentially "nobody uses the other encoding modes" but in the future
> > who knows if that will remain true... 
> 
> Yeah OK, that's fair, I'm really not going to push you too hard push
> into "must implement the spec faithfully" territory, and you know better
> than me what might be deployed or not matter, and lifetime of systems
> being built now possibly factors into it etc.
> 
> Mostly I'm asking because I didn't really understand what it was trying
> to do, so even clarifying that only part of it is implemented might be
> reasonable.

So after some discussion internally, we agree that even if mac80211 only
supports a single encoding mode, it should be able to decode all
formats. This ensures complete interoperability on the STA side and on
the AP side well the AP dictates it so shouldn't be any issues there.
Obviously the matter of optimisation - but for an initial implementation
block bitmap should suffice :) A little bit more work upfront but
probably worth it in the long run - and unit tests shall help.

> > A new bitmap
> > should be added for S1G (as mentioned, probably a union of some sort
> > with the existing bitmap) that allows us to use the _actual_ S1G AID
> > count, this ensures correct interoperability into the future and is
> > safe due to page slicing being a discrete capabilitity. 
> 
> OK I don't even follow here ... I feel confused between the AP side and
> non-AP STA side now.
> 
> If you talk about a union, do you literally mean in a struct or
> something? I'm not sure that really matters for either side? The AP side
> has the ps->tim bitmap, but that could even remain as is, even if it
> limits the # of STAs to 2008 right now. That's not a big deal, it just
> limits the AIDs to that, but that's an implementation choice. It just
> won't be able to have more STAs connected, but that's OK?
> 
> (In principle, we don't even really _need_ the ps->tim bitmap as a
> bitmap, we could iterate the stations instead or something, but that's
> more expensive and so the ps->tim bitmap is an optimisation, at least I
> see it that way.)
> 
> Obviously the AP side then for S1G can't just put the partial virtual
> bitmap from the ps->tim bitmap into the frame, but that's ultimately
> just a question of bit twiddling while building the frame too. So not
> sure where a union is needed for the AP side :)

Sorry I did mean literal C union i.e:

union {
	u8 tim[IEEE80211_MAX_AID];
	u8 s1g_tim[IEEE80211_S1G_MAX_AID];
};

of some sorts. Realistically however, nobody right now can get over 2008
STAs associated, so I have no issue (and would be easier) to simply use
the existing AID count for S1G (basically, remove all that AID
validation stuff I added.. plus wasn't even done correct anyway). With
this in mind however, we need to account for the TIM length which you
alluded to below. Ill discuss that below, but I think from our side we
have no issues limiting the AID count to 2008 or potentially lower and
as you state, this can be an implementation choice.
 
> For the client side, similarly, all it has to do is be able to walk
> through the element (elements, if later implementing page slicing), and
> be able to identify whether or not its own bit is set, so it never
> really needs a holistic view of the bitmap.

Correct.

> > So as per figure 9-214, we can still use a page slice number of 31 which
> > states that the entire page indicated by the page index is encoded in
> > the PVB, but given we now have a correctly sized AID bitmap we would
> > correctly determine the page index. On the AP side, we would encode
> > using block bitmap but correctly indicate the page index. On the STA
> > side, we'd properly decode the PVB with the ability to decode all possible
> > formats. So this would consist of block bitmap, single AID, OLB and ADE
> > alongside their equivalent inverts.
> 
> Yeah, that seems right.
> 
> (And kunit tests for this parsing would probably be a good idea :) )

I assume when I implement these kunit tests they will simply be apart of
the patchset? i.e go through the wireless-next tree? But yes as you
alluded to I think adding kunit tests with all samples for Annex L would
be beneficial so Ill ensure to get that included with the next patchset.

> > One concern I have is that without page slicing, we are limited to a TIM
> > of size 255. A single page represents 2048 AIDs (page index = 2 bits),
> > using block bitmap encoding we can overflow given worst case scenario.
> > Now the easy answer is to probably encode until we hit the maximum
> > length, allow STAs to clear their bit after the beacon and repeat.
> > Though maybe this isn't the nicest? Not sure. Obviously this is an
> > extreme case and would (hopefully) never happen in the real wordl but
> > still needs to be considered. Internally, we default to block bitmap
> > encoding and this isn't modified dynamically, same goes for most
> > (if not all) vendor implementations - but as mentioned the client needs
> > the ability to decode these other formats.
> 
> If I'm reading the spec correctly, then the worst case for only encoding
> with block bitmaps would be having a large number of scattered AIDs
> indicate presence, which would require
> 
>  - DTIM count [1 octet]
>  - DTIM period [1 octet]
>  - Bitmap Control [1 octet]
>     - B0 (depends on traffic)
>     - B1-B5: 31 (special page slice)
>     - B6-B7: 0b00 (page index 0)
>  - followed by a number B of blocks, numbered b=0..B-1, each:
>     - Block Control [1 octet]
>        - encoding mode: block bitmap
>        - inverse: 0
>        - block offset: b * 64
>     - Block Bitmap: 0xFF [1 octet, assuming worst case]
>     - subblocks [8 octets]
> 
> so out of 255 octets, 3 are overhead, leaving 252 = 25*10+2 for up to 25
> blocks, for up to 64*25=1600 AIDs? I think? Which matches your 1600, so
> whew, maybe I did this right ;-)

:D
 
> From that I'd argue the AP side should limit itself to AIDs 1..1599, I
> guess? Or actually maybe 64..1663 and use the block offset 1 higher, but
> probably not worth the added work just for 1 more AID.
> 
> Once you get to/above 1600 you have a trade-off to make, you cannot
> indicate the absolute worst case without paging any more. You could hope
> that STAs will retrieve their data and then you get free blocks, some
> Block Bitmaps won't need to be 0xFF, and then you have more space, even
> without resorting to other encodings.

Correct. The choice I decided on was simply limiting the the AID count
to 1600 (albeit, I think incorrectly given I did it on the STA side).
Thinking about this more though, if we keep the existing max AID count
of 2008, which would leave all validation the same (always a good thing :))  
is we could then simply stop adding blocks _if_ we are about to exceed
the maximum length, let those STAs clear their bit and on the next
beacon proceed? That way you'd have the block offsets increase and those
earlier AIDs get cleared and so on.

Obviously we are discussing a case that should _never_ happen, but still
need to account for it. I am leaning more to the case of utilising the
max AID count of 2008 and simply preventing TIM length overflow (this is
actually what I originally did) but you may see some issues with that or
not. Let me know.

> Overall it's also an interesting optimisation problem how to best encode
> this ... if you have clustered bits then a block bitmap is better, if
> there are sparse bits then Single AID could be better. I can't easily
> discern the cases right now where OLB or ADE would be better.
> 
> But I think for an initial implementation you could just leave that
> aside, limit AIDs to <1600, implement only block encoding and accept
> that it's just not optimal in many cases, but at least you won't have to
> worry about not being able to include some data?

Ha, now my mind is changed >:). It seems the error from my patch (and
probably a source of confusion for you) is that I was only validating
the maximum AID on the client side, whereas (and, do correct me if im
wrong) on the AP side the AID is passed down from hostap via
NL80211_ATTR_PEER_AID, which is then validated using the
NLA_POLICY_RANGE where the max is IEEE80211_MAX_AID. So if we were to
limit the AID to 1600 for S1G, we'd need some way to validate it within
cfg80211. Don't think this would be too hard, since we can confirm we
have an S1G station via the presence of the S1G capabilities within
nl80211_set_station_tdls():

...
	if (info->attrs[NL80211_ATTR_S1G_CAPABILITY])
		params->link_sta_params.s1g_capa =
			nla_data(info->attrs[NL80211_ATTR_S1G_CAPABILITY]);
...

where we could maybe perform some extra validation on the AID? I know
its maybe not the prettiest since we aren't technically using the
explicit nl80211 intrinsic validation - but I would say it gets the job
done.

I think what I'll do from here, is wait for your response to my
comments, mainly on the maximum AID count and any other comments you may 
have, and work on v2 which would roughly consist of the following:

1. On the AP side, we simply support block bitmap encoding. Patch 1 
   would more or less be the same (with the addition potentially of
   new AID validation) though I'd add some details in there and
   change some comments etc.
2. Support decoding the other encoding modes on the STA side. I think
   while a bit more work upfront, worth it in the long run.
3. Add in some kunit tests to tests both the encoding of block bitmap
   and also the decoding of all the formats from Annex L.
4. Fix up the AID stuff depending on what you think, If we go with the
   hard limit of 1600, ensure on the AP side we perform that validation.

Let me know if I've missed anything.

Whew. Thought I became a software engineer to write code, not essays :)
(though Im guessing you are very used to that...). Detailed response is
much appreciated, and I think saves us both time from having to submit
and review many patchsets.

lachlan

