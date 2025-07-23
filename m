Return-Path: <linux-wireless+bounces-25924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B95B0EE01
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 11:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1885609DA
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 09:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791AD283FC2;
	Wed, 23 Jul 2025 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="w0U0ITPp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB65281538
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 09:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261481; cv=none; b=jb8ld2CAcSS/HBteKIoVgY0pwm5BPk1I6XKje9nPXj7FZBMjgC2znxXlyY9E4IYRo092WPmwG8HkgnqxiDagW+mrvFkUetgJqQn+0H98LLmGUhz/rvK3JeU4XcSiVU6EcoJRX8FlZgEkPXNC/QBQqkKrIYCFBi0BdqwnRKMCpbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261481; c=relaxed/simple;
	bh=rPBgA9KDxz2jPZSyISRFwWv+nXniri2GCVZL5SwAE2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNHHBDJRoXfOn9pID7ZIHRYXuKmIwq4ATZVWBYbtFrHMCqIYlEF2WP0LZF3aG2q/X9jInCex5GkrkYoW4Rcap1pRg2OGs4F4oMuKpS9HR4t/alVP5ES5d8E7yaPB8Q4HlVqNRP+dRtWdtpxRU4WFyxkmCz40hfMB7BmYnJmAP2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=w0U0ITPp; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b350704f506so598542a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 02:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1753261479; x=1753866279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=72TmxPhZeTpaBLmimWF8FXoOOTRtZSHdK51XiztlkLk=;
        b=w0U0ITPpRrGnz8BCPpdo5pZvVBBqrAZojKzMC46kfqfd8vP8bk6tXNHbBbigXzTtd3
         h4mOqhPlK/IK9K0sEv6kGpTTEkTmJcAOUOm99k7lbBZm1AntZ5WYbPZxvyrinS4c57hI
         n1agLkYHU5RNg9V8eC1FTPZDuOr6GCz5NGRK0gkEFYJwU9aGdl8DN7RW+BIJ3ZHJA/x2
         Zu7hwt+kf9tPJ7hchoFatT7dmA8VwQtoz4hxg2X4hL+jYBoq6mHRl57/yopar3s5MSaw
         CsbRr4t0iDhc1LVJYnFuYnmhr1tvBgfuuQA+6nIOVR9Lku6mpvXt5rzR2KL3WRV/VVXr
         zg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753261479; x=1753866279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72TmxPhZeTpaBLmimWF8FXoOOTRtZSHdK51XiztlkLk=;
        b=Px2U12yWaeFQxEwNtSNGm8qeORGHkngWJ9KoFwwLpcWa1B5JjH4J0QDkg4zjbJcNkk
         Clqfv549R/jyqtkJMAtduEpp9aVU8alPAlS4IPsdpBFCutjvoUdYq3uuXTbhI6HT1S9q
         Qnwni8hm9P14mmCy6Shj8JWbe+DTeFHnEoroSP2k+871eO1ImHEMogEma9JHJ+5ISrQW
         gPDv8vbvQH+wR0WOQsGMVmPNI50gzE561P8DnuFI9e2WxbtoJ5Nadt186bE0DrYBpEc+
         lOIq5DhFJ1nSVmSKQa8/e3Gha2303wkJ/RKmSLbmb8GP1x5nRmL/lnnnyzG1Lla0Jfgb
         JThQ==
X-Gm-Message-State: AOJu0Yw+7azcA2awLlP89fbOTT/DltQqkXRP6ZY9OLmaLHM0BNJCV3u7
	TSerANWqAyFQzCEe4jxztgynYdh/mbXBs2Yc9+MSMvlZscUc2eG5aUhYx8CBRZB0ZF+Oj6B1Tjv
	/xDcnepE=
X-Gm-Gg: ASbGncsKNOif0Hi5+9sIR9o9NZmz3jegW4sUCjpg8wr/PLWwdn6owlXWhP9QYoX9Huv
	QBnENvAksWf4PbMugzge6POlvKRkmekzYUIai06496SfdpOB+s+5CmhvHfvL5vgsQuTfjQhGcNu
	H3LnEhC73jVIxFLRYg/81Mgd9AK4tDIwIEbvb+QSG5kayiFTWnzTWLAfttvRAl8q4METKablGYv
	9kndQgLuc23Q9gvxs5IrAvfxOeVEzqZp2jM4sPTBtM+l64Ps+zFO6ZLSaJsHFffnyj2EB56xmxs
	Oa23oAB2+V1cabu1CfvDvvqm0eEuc6E2fg6xN2izKQrXmWDmkW5igER9SbycGCl0rjr9JilxVOP
	vsqUN+t33FdsyoJ4qASJM1Fy2YlhrAgQ=
X-Google-Smtp-Source: AGHT+IGGy1TdeAuk1PY0qihACnUZblKPmr+isnRuguCS+z8nJWgaQcxW0C4+Egzk+sRLbAFuAA70fw==
X-Received: by 2002:a17:902:d2ca:b0:231:e413:986c with SMTP id d9443c01a7336-23f8ac468a5mr98416855ad.11.1753261478575;
        Wed, 23 Jul 2025 02:04:38 -0700 (PDT)
Received: from localhost ([101.180.88.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4cf8sm91911475ad.107.2025.07.23.02.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 02:04:38 -0700 (PDT)
Date: Wed, 23 Jul 2025 19:04:36 +1000
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, arien.judge@morsemicro.com
Subject: Re: [wireless-next 1/2] wifi: mac80211: support encoding S1G TIM PVB
Message-ID: <yprbgvamtyf67oqwwhqpz7csb3yfegljdasyczkrilfrou4z3e@lvitjre3rfez>
References: <20250722071642.875875-1-lachlan.hodges@morsemicro.com>
 <20250722071642.875875-2-lachlan.hodges@morsemicro.com>
 <d97f20cff120e813b83c3a7d41bae63b151da26a.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d97f20cff120e813b83c3a7d41bae63b151da26a.camel@sipsolutions.net>

On Wed, Jul 23, 2025 at 10:04:06AM +0200, Johannes Berg wrote:
Hi Johannes

> On Tue, 2025-07-22 at 17:16 +1000, Lachlan Hodges wrote:
> 
> > +/*
> > + * An S1G PPDU TIM PVB uses the notion of pages. Each page can reference
> > + * 2048 AIDs, however since mac80211 does not support page slicing we
> > + * are reusing the existing TIM bitmap, which supports up to 2008 AIDs.
> > + * As the TIM element has a maximum length of 255 bytes, and each encoded
> > + * block has a maximum length of 10 bytes at most we can support 25 blocks,
> > + * as 1 + 1 + 1 + 25 * 10 = 253 bytes, leaving our maximum AID count for
> > + * an S1G PPDU at 25 * 64 = 1600. If page slicing is introduced in the
> > + * future, this will need to be modified.
> > + */
> > +#define IEEE80211_MAX_AID_S1G_NO_PS	1600
> > +#define IEEE80211_MAX_S1G_TIM_BLOCKS	25
> 
> Come to think of it, neither of these really makes sense in the
> ieee80211.h header file since they're implementation related limits due
> to the encoding. And IEEE80211_MAX_S1G_TIM_BLOCKS is questionable too
> (see below), spec wise the limit would maybe be 32 (you cannot encode
> higher than block 0..31 in the 5 bit block index.)

Yup you are right, since this is an implementation detail rather then
the actual spec. Will move these somewhere else for v2.

> > +static void ieee80211_beacon_add_tim_pvb(struct ps_data *ps,
> > +					 struct sk_buff *skb, u8 aid0, u8 *tim)
> 
> Maybe use 'struct element' for the tim pointer? that way tim[1] = ...
> becomes tim->datalen = ... which seems easier to understand.
> 
> I know the code didn't use that (it predates the existence of 'struct
> element') but it could also originally put the WLAN_EID_TIM that way,
> for example.
> 
> And maybe aid0 could be 'bool mcast_traffic' or 'bool aid0_traffic' (if
> mcast is too specific, not sure what might get encoded there now/s1g.)
> 
> (mostly I'm thinking it should be bool, 'bool aid0' is also fine)

Yup I guess If im shuffling this code around I should clean up the
normal TIM function, since it definitely looks like it was written a
long time ago :)

> > +static void ieee80211_s1g_beacon_add_tim_pvb(struct ps_data *ps,
> > +					     struct sk_buff *skb, u8 aid0,
> > +					     u8 *tim)
> [...]
> > +	/* Emit an encoded block for each non-zero sub-block */
> > +	for (blk = 0; blk < IEEE80211_MAX_S1G_TIM_BLOCKS; blk++) {
> 
> So this only makes sense if you actually limit the AIDs to 1600... Maybe
> then that's what you want to do :)
> 
> Otherwise even if you have no traffic for AIDs 1..1000 you would still
> never indicate the traffic for AIDs >=1600 (or so.)
> 
> If you don't want to limit to 1600 then I think encoding wise we're
> limit to 2048 (but in practice to 2008 with the AID limit in nl80211),
> but this code would then probably attempt to access 2048 so we need to
> ensure the ps->tim bitmap is actually slightly larger. Not that I really
> see an issue with that. Or add a check for the actual idx below, similar
> to the one you have there, but with a subblock index of 2008/8 == 251
> instead.

As mentioned in other email, I'll stick with the 1600 limit as an
"Implementation detail" for now. 

> > +		u8 blk_bmap = 0;
> > +		int sblk, subcnt = 0;
> > +
> > +		for (sblk = 0; sblk < 8; sblk++) {
> > +			int idx = blk * 8 + sblk;
> > +
> > +			if (idx >= IEEE80211_MAX_AID_S1G_NO_PS)
> > +				break;
> 
> I think you'll want to remove this condition. If you _do_ limit the AIDs
> anyway it's not needed, and if you _don't_ limit the AIDs then it should
> be replaced by some "does it fit" condition, and/or checking for the
> 2008 value.

Ah yep its redundant due to the outer loop. Will fix.

> 
> > +			/*
> > +			 * If the current subblock is non-zero, increase the
> > +			 * number of subblocks to emit for the current block.
> > +			 */
> > +			if (ps->tim[idx]) {
> 
> Also ... this line and the idx>= cannot simultaneously be right ... Here
> it's basically a subblock index into the bitmap, whereas the >=MAX_AID
> means it would be an AID, i.e. they're different units by a factor of 8.
> 
> It actually looks like it's a subblock index, but then the AID condition
> makes no sense anyway.
> 
> Maybe rename the variable ;-)

Yep will tidy this up.

> > +				blk_bmap |= BIT(sblk);
> > +				subcnt++;
> 
> I'd be tempted to remove the subcnt variable and use hweight8(blk_bmap)
> in its place? I don't think it's _that_ much more expensive, and avoids
> having to maintain the same information twice, basically?

Yep I see - we can just use hweight8 rather then tracking it
separately. I think anytime we can make these bit twiddling functions
simpler is always good :)

> > +		/*
> > +		 * Increase the tim length by the current encoded block
> > +		 * length by block control + block bitmap + n_subblocks where
> > +		 * n_subblocks represents the number of subblock bytes to emit
> > +		 * for the current block.
> > +		 */
> > +		tim[1] += 1 + 1 + subcnt;
> 
> Or you could just remove all of this tim[1] code from _both_ functions
> in the first place, and just have the _caller_ update it:
> 
> struct element *tim;
> 
> pos = skb_put(skb, 4);
> tim = (void *)pos;
> // add all the stuff including PVB
> tim->datalen = skb_tail_pointer(skb) - &tim->data;
> 
> or so. I could be off by one I guess :)
> 
> Then (going back down the stack of thoughts) you don't need the 'subcnt'
> at all.

That is probably cleaner overall, will probably do something like that
in v2.

lachlan




