Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D0E19B4EC
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2020 19:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732264AbgDARxS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 13:53:18 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:46330 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732121AbgDARxS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 13:53:18 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jJhYC-00CpOp-5A; Wed, 01 Apr 2020 19:53:16 +0200
Message-ID: <bbc12ff536862a8ca693c20b8721092979c49a36.camel@sipsolutions.net>
Subject: Re: [RFC 2/7] cfg80211: express channels with a KHz component
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Wed, 01 Apr 2020 19:53:15 +0200
In-Reply-To: <69451a0a-4bca-36f8-4295-9a386585c244@adapt-ip.com>
References: <20200401062150.3324-1-thomas@adapt-ip.com>
         <20200401062150.3324-3-thomas@adapt-ip.com>
         <52850c8eb3131ca742eea30a21a7e685a3a3045b.camel@sipsolutions.net>
         <69451a0a-4bca-36f8-4295-9a386585c244@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-04-01 at 10:30 -0700, Thomas Pedersen wrote:
> 
> ---
> .. c:function:: struct ieee80211_channel * ieee80211_get_channel (struct wiphy * wiphy, int freq)
> 
>    get channel struct from wiphy for specified frequency
> 
> **Parameters**
> 
> ``struct wiphy * wiphy``
>   the struct wiphy to get the channel for
> 
> ``int freq``
>   the center frequency (in MHz) of the channel
> ---
> 
> Documentation/doc-guide/kernel-doc.rst says:
> 
> The brief description following the function name may span multiple lines, and
> ends with an argument description, a blank comment line, or the end of the
> comment block.

Interesting. I guess they must've fixed this at some point - at least I
_seem_ to remember getting wrong output with it. Thanks for the
correction!

> > > +/**
> > > + * ieee80211_chandef_to_khz - convert chandef to frequency in KHz
> > > + *
> > > + * @chandef: the chandef to convert
> > > + *
> > > + * Returns the center frequency of chandef (1st segment) in KHz.
> > > + */
> > > +u32 ieee80211_chandef_to_khz(const struct cfg80211_chan_def *chandef);
> > 
> > Isn't this one trivial, and probably better inlined (mhz*1000 + khz)?
> 
> Do you mean open code the conversion? I would prefer not to. If you
> meant make it an inline function then yes probably.

Right, I meant making it an inline.

> > > +static int __ieee80211_frequency_to_channel(u32 freq)
> > 
> > export the double-underscore helpers like this one instead? That'd still
> > be less code overall, IMHO.
> 
> I didn't want to change the interface for
> ieee80211_frequency_to_channel(). It's a little confusing that one takes
> MHz, but the __ieee80211_frequency_to_channel() takes KHz? By giving the
> _khz() hint in the wrapper we were trying to make it explicit. Similar
> to below.

Right. I think that's fine. I was just wondering if / thinking that it
may be better to just export ieee80211_freq_khz_to_channel(), and
express the other ones as inline function in terms of that?

> > And maybe here? In fact, how is __ieee80211_get_channel() even different
> > from ieee80211_get_channel_khz()?
> 
> It's not. I thought the _khz() hint was helpful for the reader to keep
> the units straight.

Agree, but then you don't need the double-underscore version and can
just express the old one in terms of the _khz one?

> What do you think about keeping the interfaces in place, but otherwise
> converting them to inline functions (where it makes sense)?

Yes, I think that's what I had in mind.

> I'd like to avoid open coding the conversions and otherwise keep the
> gory internals of the channel structures hidden from the caller.

Agree.

johannes

