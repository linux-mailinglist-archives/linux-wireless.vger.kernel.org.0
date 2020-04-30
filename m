Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDECC1C070C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 21:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgD3Tyn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 15:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgD3Tyn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 15:54:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A67C035494
        for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2020 12:54:42 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jUFGb-002qNU-3Z; Thu, 30 Apr 2020 21:54:41 +0200
Message-ID: <cc1a53345950c23ee1349520545c5595bbced952.camel@sipsolutions.net>
Subject: Re: [PATCH 02/10] cfg80211: validate 6 GHz chandef
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 30 Apr 2020 21:54:39 +0200
In-Reply-To: <f7fa5618844630a3315acad53765e5e5@codeaurora.org>
References: <1587768108-25248-1-git-send-email-rmanohar@codeaurora.org>
         <1587768108-25248-3-git-send-email-rmanohar@codeaurora.org>
         <73a4e63e16bffb69cd9b62fd904b926dd5278fbf.camel@sipsolutions.net>
         <f7fa5618844630a3315acad53765e5e5@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> > > +static enum nl80211_chan_width cfg80211_chan_to_bw_6ghz(u8 idx)
> > > +{
> > > +	/* channels: 1, 5, 9, 13... */
> > > +	if ((idx & 0x3) == 0x1)
> > > +		return NL80211_CHAN_WIDTH_20;
> > > +	/* channels 3, 11, 19... */
> > > +	if ((idx & 0x7) == 0x3)
> > > +		return NL80211_CHAN_WIDTH_40;
> > > +	/* channels 7, 23, 39.. */
> > > +	if ((idx & 0xf) == 0x7)
> > > +		return NL80211_CHAN_WIDTH_80;
> > > +	/* channels 15, 47, 79...*/
> > > +	if ((idx & 0x1f) == 0xf)
> > > +		return NL80211_CHAN_WIDTH_160;
> > > +
> > > +	return NL80211_CHAN_WIDTH_20;
> > > +}
> > 
> > We haven't really done that for anything else - is that really
> > necessary?
> > 
> Hmm.. to check whether give center_freq1 chan_idx is allowed to operate 
> in given bandwidth.
> Similar to center_idx_to_bw_6ghz of hostapd, this API is used to chandef 
> bw.

Yeah, but good enough if hostapd does that check? I don't really see the
kernel caring too much?

> Don't we have to check chandef bw? If not, I will drop the change.

I'm not really sure why we should, tbh.

johannes

