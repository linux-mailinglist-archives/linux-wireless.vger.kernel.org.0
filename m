Return-Path: <linux-wireless+bounces-25858-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B7EB0D9A6
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 14:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F2673A3FB6
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 12:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5D238FA6;
	Tue, 22 Jul 2025 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="UPXGIW8l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCBCD53C
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187450; cv=none; b=CXNahqnNJsDBiMnfbEMBvMTUHg6tbuT98JI21B8r0lHiW3lbpJbwIBkNCzbo7LjqpMAMTUOhc3DdVjA0GGQb4vDNWyM/TkTtso/ltOj5hzGRSUe8wrcgEw8AQSkJm80Umv1Wi1XZ0Vmh+i0ucVCkdM9PQeQnwnMG4O6kFex2gnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187450; c=relaxed/simple;
	bh=BHSO9bha6VkJ/+j2R91jWJnheY50x6fHBRy/ahPOOTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7SIg9eaEt5ZtNB61iCqbnzvw36VpAG0hB7uF8A9aTee+uDbRw422hktvbiY/P3iuIIRoQ4YhhOT8ilZ2Gegnwa/oIZHSfeJmHqccvRMdD2ksdKD66tiGC7kDDgLHNuhCydwwSZiwcNXfWaDxj2nDhv9DpwEt0kfLwUPxNtfeIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=UPXGIW8l; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31329098ae8so4854822a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 05:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1753187448; x=1753792248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XN/2H06Co1beCadbHTMgnjQnzR5FGX7h7bafxRgIiAo=;
        b=UPXGIW8lH73CfP4jvQwQP5QXDo9uwyJMxl3AbIC+kKEXGXwr6pcC+N2qOBf9kttHsG
         YILLwPzsfmct+z55GJdtDsCELhVhTh1zkStqstSnIayYB5KxY6kMghcyNphXSDOYwfLO
         9XbHmkM03BQpwxw/zQUWhS5kki+oDGpGw0fxHbETLWPycCjmktEewtHA2vt5PrwO/pGK
         fT3ENpviyDYTtFT70ryduOJozcvl5gooDWZGLIAARYpV9s/R2XoVEAsUUeBjmaLLWwjT
         g5KotYy0SH4TiNcq55FaspBjigYfyvxJCBscJn7ywn39y2dL9PemCtOp0aLmp1XrbfQe
         +SZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753187448; x=1753792248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XN/2H06Co1beCadbHTMgnjQnzR5FGX7h7bafxRgIiAo=;
        b=BJRqsAQOGBfFk5fm6Ql7j1UuzgwFvI4Qog/oG0Ec6ElsCTMHbL3677L2rtbEFYRvx2
         JscTThFyNEhTUhIteY81sx7fx8JZTbuLbqKYvuTC+Qc/MkLsnq9/L9xehywoP/CSIphC
         js3JZrIbsAzRHjb1JKfnBo0b4fUIEb2ZyybcYzG5ZbW5Rk3YUYgKAM4mAJh69vc4Oszl
         5XD5VFwcWDg3O2H41N23YQker6dAeaMnp/KjJgtNCExW8qmOXk7obickSWyHSeBI2qis
         5QiiEM2PZXetE4sghEzQg3/uOKQdJ+9AnOpUt4w64ZXquzbMc7GYni3W5dfiFNo+69LN
         avBg==
X-Gm-Message-State: AOJu0YzOELDWnqtHf7cqltg5qREyXMyiSJIzHsqCCqSqAG6m97OEomY3
	1qsaVwuOd89FhPRuT8Mzpq3fCH/OeaQPW+ZScKN/hyPTGw9bxOaYVuO94Im0MMPMtUY=
X-Gm-Gg: ASbGncsTcDJRrB55oqbXFB9oGsUbCv3bFlw92C249scZ3bVdXemCWaN3PujFqVrKElQ
	5OJsVqav9T52UABgkFchGIa+gqm51zI1gR0IgskGjsCA68eTqBBGbewuPkXpK1LnkJeZTgw0miW
	n+Yo+ZgiAmQWhKIsvSOUEoBLD9g20Bc390QXRAruiPv1tB2yVxnQCrovm7fQ2uPPRSL4PUt+W1D
	26TDKArnu3es8L2otkcUyX6f6qznbRynt+XSMMs47xX0hZSgErwaJclRBAAw/Enpo2wuyGRjIAY
	t8jnWiWVRVXgWScDnywNVfdiTFirCS8k9PZlGcRxGtpqSjUx6H/U9DKJLnabcqVNMPzaEYuriKv
	Oly4bwKCKzaj1A2oX+8iLGJJOMpL6Al4=
X-Google-Smtp-Source: AGHT+IG/uh58M0zePXeeUQxhfa1iINPeMtfd3cD666l8zTruExX1ci+FjzNg5jPrAUQ5OE1MAUqtwQ==
X-Received: by 2002:a17:90b:3b43:b0:313:d342:448c with SMTP id 98e67ed59e1d1-31e3e19e7a8mr4644795a91.17.1753187447692;
        Tue, 22 Jul 2025 05:30:47 -0700 (PDT)
Received: from localhost ([101.180.88.40])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cb5c5da0csm9592523a91.25.2025.07.22.05.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 05:30:47 -0700 (PDT)
Date: Tue, 22 Jul 2025 22:30:44 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [wireless-next 2/2] wifi: mac80211: support parsing S1G TIM PVB
Message-ID: <ksb6rptacpnyxbcep332q247agx2u62h6o3j4oqfestaal2b7x@el6snwrs4kx5>
References: <20250722071642.875875-1-lachlan.hodges@morsemicro.com>
 <20250722071642.875875-3-lachlan.hodges@morsemicro.com>
 <e60156bc1097385bceb624bac6bf55906947e6a9.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e60156bc1097385bceb624bac6bf55906947e6a9.camel@sipsolutions.net>

On Tue, Jul 22, 2025 at 01:25:50PM +0200, Johannes Berg wrote:
> On Tue, 2025-07-22 at 17:16 +1000, Lachlan Hodges wrote:
> > When parsing a TIM element from an S1G AP, ensure we correctly
> > parse based on the S1G PPDU TIM PVB format, allowing an S1G STA
> > to correctly enter/exit power save states to receive buffered
> > unicast traffic.
> 
> I think this isn't quite correct.
> 
> > Also make sure we don't allocate over the
> > mac80211 supported S1G PPDU AID count.
> 
> But this specifically caught my eye - how can the client ensure it
> doesn't allocate over, since it doesn't even allocate? First I thought
> this really belongs into the AP side code (i.e. the other patch), but
> you actually did something here:
> 
> [...]
>
> Which ... seems questionable? At least in terms of message it's not
> actually _invalid_ if it's out of this range, in theory S1G allows up to
> 8191.

Yes, from a client side it is. See comments below.

> Also the parsing for S1G only parses a subset of the valid formats,
> notably the format that mac80211 can generate. That seems questionable,
> unless you expect there never to be another implementation (or the
> mac80211 one to never be extended) and you can basically make up your
> own standard?
> 
> And even if you _do_ get an AID that's <1600 there's still no guarantee
> that the encoding will be in the bitmap format, if only two stations
> have traffic the AP might well decide to use the "Single AID" mode?
> 
> So I'm overall a bit confused how all this is meant to work - even if
> only partially - because AID<1600 is no guarantee that you can parse the
> bitmap, so turning off powersave only for AID>=1600 will not really be
> sufficient?

This is something we discussed internally, and in retrospect mac80211
should be able to parse all types, even though it may only encode a
single type. So actually my reasoning for this is not very good as it
was essentially "nobody uses the other encoding modes" but in the future
who knows if that will remain true... 

One of the things I was concerned with was adding a new bitmap
specifically for S1G, but in actuality its probably more important
to be "correct" and we could probably just use an anonymous union.

After verifying with the standard and based on your feedback here is
what I propose:

For a first implementation, we still won't support page slicing - but
this is fine as it is an advertised capability. A new bitmap
should be added for S1G (as mentioned, probably a union of some sort
with the existing bitmap) that allows us to use the _actual_ S1G AID
count, this ensures correct interoperability into the future and is
safe due to page slicing being a discrete capabilitity. 

So as per figure 9-214, we can still use a page slice number of 31 which
states that the entire page indicated by the page index is encoded in
the PVB, but given we now have a correctly sized AID bitmap we would
correctly determine the page index. On the AP side, we would encode
using block bitmap but correctly indicate the page index. On the STA
side, we'd properly decode the PVB with the ability to decode all possible
formats. So this would consist of block bitmap, single AID, OLB and ADE
alongside their equivalent inverts.

One concern I have is that without page slicing, we are limited to a TIM
of size 255. A single page represents 2048 AIDs (page index = 2 bits),
using block bitmap encoding we can overflow given worst case scenario.
Now the easy answer is to probably encode until we hit the maximum
length, allow STAs to clear their bit after the beacon and repeat.
Though maybe this isn't the nicest? Not sure. Obviously this is an
extreme case and would (hopefully) never happen in the real wordl but
still needs to be considered. Internally, we default to block bitmap
encoding and this isn't modified dynamically, same goes for most
(if not all) vendor implementations - but as mentioned the client needs
the ability to decode these other formats.

Let me know your thoughts.

lachlan


