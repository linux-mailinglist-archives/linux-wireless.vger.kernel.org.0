Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 874B0CEE38
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2019 23:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfJGVLm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Oct 2019 17:11:42 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:46742 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbfJGVLm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Oct 2019 17:11:42 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iHaI8-0001fg-A1; Mon, 07 Oct 2019 23:11:40 +0200
Message-ID: <fa09d946e85a637d7b49e208714945dcbcc23f76.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] mac80211: Support LIVE_ADDRESS_CHANGE feature
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Mon, 07 Oct 2019 23:11:38 +0200
In-Reply-To: <90ae00044bc0834d87d3f9fb75ce63dce4cfadd5.camel@gmail.com> (sfid-20191004_182756_493717_F6EB75F5)
References: <20190913195908.7871-1-prestwoj@gmail.com>
         <20190913195908.7871-2-prestwoj@gmail.com>
         (sfid-20190913_220113_985031_7C3A66BD) <c6835b5c5d2a97fa82b0fb21f7b7f0056aa42e1b.camel@sipsolutions.net>
         <90ae00044bc0834d87d3f9fb75ce63dce4cfadd5.camel@gmail.com>
         (sfid-20191004_182756_493717_F6EB75F5)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-10-04 at 09:25 -0700, James Prestwood wrote:
> 
> > I'm not even entirely sure it _is_ needed - if we've still not
> > created
> > the IBSS but are scanning for it or trying to merge the MAC address
> > won't really matter yet? Probably?
> 
> I guess its just paranoia, rather be safe than sorry. I can take this
> out, but is "Probably?" a good reason? ;)

Fair enough, nobody really cares about IBSS anyway ;-)

I guess I was mostly wondering if you had noticed anything that would
actually be a problem.

> Ok so no switch statement, simply just check that we aren't offchannel
> or scanning. I guess this would then cover the IBSS case too.

Don't think it covers IBSS - that one is really specially accessing some
IBSS data.

> > If you do care about this being more granular then you should check
> > *which* interface is scanning, and then you can still switch the MAC
> > address for *other* interfaces - but I'd still argue it should be
> > independent of interface type.
> 
> I think maybe in the future we might want this, but for now lets not
> worry about it. But just to make sure we are on the same page, your
> talking about e.g. hardware with multiple radios so you could be doing
> offchannel work/scanning/connecting simultaneously without having to
> wait for the current operation to complete?

Not really multiple radios, who cares? Just multiple interfaces would be
sufficient. You're just removing/adding some interface (as far as the
driver is concerned) - doesn't matter if you actually are scanning or
something on another interface right?

> > And, I'm confused, but isn't the polarity of the scanning check
> > wrong?
> 
> Ah yeah, after you pointed that out I realized 'scanning' is a bit
> field. I should be doing:
> 
> test_bit(SCAN_HW_SCANNING, &sdata->local->scanning)

I think checking for all the bits is fine (and necessary, just HW scan
is unlikely to be enough, changing the MAC address would also disrupt a
software scan) - just need to invert the polarity?


> Either way I'll send another patch with these things addressed.

I'll wait, thanks.

johannes

