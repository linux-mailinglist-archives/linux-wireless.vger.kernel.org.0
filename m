Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 738D9C3019
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 11:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfJAJXu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 05:23:50 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:57930 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfJAJXu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 05:23:50 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iFENo-0003hp-7P; Tue, 01 Oct 2019 11:23:48 +0200
Message-ID: <5ebdaccd04596bae01ee4e9474d6cab15902b2d1.camel@sipsolutions.net>
Subject: Re: [RFCv3 2/3] nl80211: Support >4096 byte NEW_WIPHY event nlmsg
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>, linux-wireless@vger.kernel.org
Date:   Tue, 01 Oct 2019 11:23:47 +0200
In-Reply-To: <8b22b64e-5efc-beac-6581-778e47625c89@gmail.com> (sfid-20190911_174425_379766_D82FAB27)
References: <20190906154303.9303-1-denkenz@gmail.com>
         <20190906154303.9303-2-denkenz@gmail.com>
         <4397b67b63d1b1a332afa9010e7f48abd54b49b2.camel@sipsolutions.net>
         <5bd58103-bdb7-b72c-0b64-76c8573ca380@gmail.com>
         <1eac4f853b835fef85cdf33d971382b2f6e7c5a9.camel@sipsolutions.net>
         <8b22b64e-5efc-beac-6581-778e47625c89@gmail.com>
         (sfid-20190911_174425_379766_D82FAB27)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> > Yeah, that does seem reasonable, especially if we're moving to bigger
> > messages anyway. If we do add something huge to each channel, we can
> > recover that code I suppose.
> 
> So do you want me to drop the channel splitting logic and only allow 
> this for bands?  Or just keep this since it is already done?

I guess I'm saying I don't really care. If we have it now might as well
keep it?

Actually, don't we already have up to 240 bytes per channel, counting
the channel nesting itself and all the flags and WMM data that can be
inside?

Am I counting this wrong?

If this is right, we really do need to be able to split this, because we
have ~60 channels in the 6/7 GHz band ...

> > > The current logic uses last_channel_pos for some of the trickery in
> > > addition to last_good_pos.  So nla_put_failure would have to be made
> > > aware of that.  Perhaps we can store last_good_pos in the stack, but the
> > > split mechanism only allows the splits to be done at certain points...
> > 
> > Hmm, not sure I understand. last_channel_pos and last_good_pos are
> > basically equivalent, no? In fact, I'm not sure why you need
> > last_channel_pos vs. just using last_good_pos instead? Maybe I'm missing
> > something.
> 
> Sort of.  The way I did it, last_channel_pos keeps track of whether any 
> channel info was added or not.  So if NULL, we simply backtrack to 
> last_good_pos in nla_put_failure. You can probably use last_good_pos for 
> everything and an extra variable for the channel info tracking.

Right.

> > To me, conceptually, the "state->band_start" and "state->chan_start" is
> > basically a sub-state of "state->split", so this is underneath state-
> > > split == 3 (I think?), you basically get 3.0.0, 3.0.1, 3.0.2, ...,
> > 3.1.0, 3.1.1 ... for the state? Which you have to unwind in terms of
> > message formatting, but the last_good_pos should be sufficient?
> 
> Right.  And as I mentioned above, this could be done, but you probably 
> need another state variable..
> 
> > IOW, the only difference I see between the normal split states 1, 2, ...
> > and the band/channel split states 3.0.0, 3.0.1, ... is the fact that we
> > have to also fix up the nested attributes after we trim to last_good_pos
> > on failures. Where am I wrong?
> > 
> 
> Didn't say that you were ;)

No, you didn't, but I thought I probably was missing something :)

> To be clear, I think it is a good approach and can be made to work.  My 
> main hesitation is whether doing it now is worth it given the discussion 
> at the very top.  But I can see what I can come up with if you want.

See above - unless I'm doing something completely wrong, each channel
with all the WMM data and stuff can really be big, no?

(Now, why did we put the WMM data into each channel? Maybe we could've
done per band? I think it can differ on the UNII subbands though)

johannes

