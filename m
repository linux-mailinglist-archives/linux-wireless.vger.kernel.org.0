Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2C1B0005
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 17:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbfIKP25 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 11:28:57 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:43782 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfIKP25 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 11:28:57 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i84YB-00035U-Ey; Wed, 11 Sep 2019 17:28:55 +0200
Message-ID: <1eac4f853b835fef85cdf33d971382b2f6e7c5a9.camel@sipsolutions.net>
Subject: Re: [RFCv3 2/3] nl80211: Support >4096 byte NEW_WIPHY event nlmsg
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>, linux-wireless@vger.kernel.org
Date:   Wed, 11 Sep 2019 17:28:54 +0200
In-Reply-To: <5bd58103-bdb7-b72c-0b64-76c8573ca380@gmail.com> (sfid-20190911_163505_442886_F5C1C494)
References: <20190906154303.9303-1-denkenz@gmail.com>
         <20190906154303.9303-2-denkenz@gmail.com>
         <4397b67b63d1b1a332afa9010e7f48abd54b49b2.camel@sipsolutions.net>
         <5bd58103-bdb7-b72c-0b64-76c8573ca380@gmail.com>
         (sfid-20190911_163505_442886_F5C1C494)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-09-11 at 07:41 -0500, Denis Kenzior wrote:
> 
> For my dual band cards the channel dump all fits into a ~1k attribute if 
> I recall correctly.  So there may not really be a need for this.  Or at 
> the very least we could keep things simple(r) and only split at the band 
> level, not at the individual channel level.

Yeah, that does seem reasonable, especially if we're moving to bigger
messages anyway. If we do add something huge to each channel, we can
recover that code I suppose.

> > > [snip]
> > > +chan_put_failure:
> > > +			if (!last_channel_pos)
> > > +				goto nla_put_failure;
> > > +
> > > +			nlmsg_trim(msg, last_channel_pos);
> > > +			nla_nest_end(msg, nl_freqs);
> > >   			nla_nest_end(msg, nl_band);
> > >   
> > > -			if (state->split) {
> > > -				/* start again here */
> > > -				if (state->chan_start)
> > > -					band--;
> > > +			if (state->chan_start < sband->n_channels)
> > >   				break;
> > > -			}
> > > +
> > > +			state->chan_start = 0;
> > > +			state->band_start++;
> > >   		}
> > > -		nla_nest_end(msg, nl_bands);
> > >   
> > > -		if (band < NUM_NL80211_BANDS)
> > > -			state->band_start = band + 1;
> > > -		else
> > > -			state->band_start = 0;
> > > +band_put_failure:
> > > +		if (!last_channel_pos)
> > > +			goto nla_put_failure;
> > > +
> > > +		nla_nest_end(msg, nl_bands);
> > >   
> > > -		/* if bands & channels are done, continue outside */
> > > -		if (state->band_start == 0 && state->chan_start == 0)
> > > -			state->split_start++;
> > > -		if (state->split)
> > > +		if (state->band_start < NUM_NL80211_BANDS)
> > >   			break;
> > 
> > Thinking out loud, maybe we could simplify this by just having a small
> > "stack" of nested attributes to end?
> > 
> > I mean, essentially, you have here similar code to the nla_put_failure
> > label, in that it finishes and sends out the message, except here you
> > have to end a bunch of nested attributes.
> > 
> > What if we did something like
> > 
> > #define dump_nest_start(msg, attr) ({ 				\
> > 	struct nlattr r = nla_nest_start_noflag(msg, attr);	\
> > 	BUG_ON(nest_stack_depth >= ARRAY_SIZE(nest_stack);	\
> > 	nest_stack[nest_stack_depth++] = r;			\
> > 	r;							\
> > })
> > 
> > #define dump_nest_end(msg, r) do {				\
> > 	BUG_ON(nest_stack_depth > 0);				\
> > 	nest_stack_depth--;					\
> > 	BUG_ON(nest_stack[nest_stack_depth] == r);		\
> > 	nla_nest_end(msg, r);					\
> > } while (0)
> > 
> > 
> > or something like that (we probably don't want to use
> > nla_nest_start_noflag() for future attributes, etc. but anyway).
> > 
> > Then we could unwind any nesting at the end in the common code at the
> > nla_put_failure label very easily, I think?
> 
> I see where you're going with this, I think I do anyway...

I'm not sure I am going anywhere with this ;-)

> The current logic uses last_channel_pos for some of the trickery in 
> addition to last_good_pos.  So nla_put_failure would have to be made 
> aware of that.  Perhaps we can store last_good_pos in the stack, but the 
> split mechanism only allows the splits to be done at certain points...

Hmm, not sure I understand. last_channel_pos and last_good_pos are
basically equivalent, no? In fact, I'm not sure why you need
last_channel_pos vs. just using last_good_pos instead? Maybe I'm missing
something.

To me, conceptually, the "state->band_start" and "state->chan_start" is
basically a sub-state of "state->split", so this is underneath state-
>split == 3 (I think?), you basically get 3.0.0, 3.0.1, 3.0.2, ...,
3.1.0, 3.1.1 ... for the state? Which you have to unwind in terms of
message formatting, but the last_good_pos should be sufficient?

IOW, the only difference I see between the normal split states 1, 2, ...
and the band/channel split states 3.0.0, 3.0.1, ... is the fact that we
have to also fix up the nested attributes after we trim to last_good_pos
on failures. Where am I wrong?

> Right now only the channel dump uses this (and I'm still not fully 
> convinced we should go to all the trouble), so one argument would be not 
> to introduce something this generic until another user of it manifests 
> itself?

I was thinking it'd actually be less complex, but I guess I have to try
to write it to see for myself.

johannes

