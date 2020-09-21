Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92265271B2B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Sep 2020 08:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIUG6E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Sep 2020 02:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgIUG6E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Sep 2020 02:58:04 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C63C061755
        for <linux-wireless@vger.kernel.org>; Sun, 20 Sep 2020 23:58:04 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kKFly-0084H1-QL; Mon, 21 Sep 2020 08:58:02 +0200
Message-ID: <58a237393a12e3de23d685f4dae4279a8823e47c.camel@sipsolutions.net>
Subject: Re: [PATCH v2 07/22] mac80211: s1g: choose scanning width based on
 frequency
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Mon, 21 Sep 2020 08:58:01 +0200
In-Reply-To: <b9024051fc27cae56173eef488e503e3@adapt-ip.com>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
         <20200831205600.21058-8-thomas@adapt-ip.com>
         <43afe1ee1067d77aa6be5765e02f3cf0549c7c8f.camel@sipsolutions.net>
         <b9024051fc27cae56173eef488e503e3@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2020-09-20 at 22:06 -0700, Thomas Pedersen wrote:
> 
> > > +	/* For scanning on the S1G band, ignore scan_width (which is 
> > > constant
> > > +	 * across all channels) for now since channel width is specific to 
> > > each
> > > +	 * channel. Detect the required channel width here and likely 
> > > revisit
> > > +	 * later. Maybe scan_width could be used to build the channel scan 
> > > list?
> > > +	 */
> > > +	if (chan->band == NL80211_BAND_S1GHZ) {
> > > +		local->scan_chandef.width = ieee80211_s1g_channel_width(chan);
> > > +		goto  set_channel;
> > > +	}
> > 
> > nit: double space after 'goto'
> > 
> > but really I came to say that this probably changes then, if you don't
> > convince me about the stuff in the previous patch review? :)
> > 
> > So I'm leaving this patch also for now - have applied 1-5 so far.
> 
> Thanks. I'm not really sure what else would make sense here? 
> scan_req->scan_width is constant across all channels in 
> scan_req->channels so for S1G we can either filter the scan_req channels 
> list based on scan_width (kind of strange and unexpected), or deduce the 
> correct chanenl width for each channel in the list and ignore scan_width 
> (mostly correct). It seems like scan_width is currently only used for 
> scanning at 5 or 10MHz anyway?

Yeah, that's true, it's sort of undefined if you're not in 5 or 10, and
then we currently assume it's 20, but obviously for S1G we should assume
then it's 1 MHz or something.

FWIW, here's probably where I thought you have a unique (freq, bw) tuple
and thus shouldn't really need to have the parsing in the other patch?
But I never looked at the spec so far ...


Anyway, wrt. the code here, I think perhaps you should just simply
remove the reference to scan_width? I'm not sure what you'd really do
with it, since it's a 5/10 MHz thing?

TBH though, offhand I don't even know how the 5/10 MHz scanning is
supposed to work?

johannes

