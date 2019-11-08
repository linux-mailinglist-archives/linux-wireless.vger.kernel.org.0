Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE3FBF4B56
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 13:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731794AbfKHMUH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 07:20:07 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:59440 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbfKHMUH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 07:20:07 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iT3FC-0002Fu-P4; Fri, 08 Nov 2019 13:20:02 +0100
Message-ID: <1c553c457024b295c7d0a6b118c3848eec28bcbd.camel@sipsolutions.net>
Subject: Re: [PATCHv8 0/6] cfg80211/mac80211: Add support for TID specific
 configuration
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Cc:     Tamizh chelvam <tamizhr@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Fri, 08 Nov 2019 13:20:01 +0100
In-Reply-To: <20191108120504.ptl25hacxcftb7tw@bars>
References: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
         <20191108093207.uv4j44xpm2qvtsv5@bars>
         <84ca3a8b61757360ab9898afcdd3f2f63c770f86.camel@sipsolutions.net>
         <20191108120504.ptl25hacxcftb7tw@bars>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-11-08 at 12:05 +0000, Sergey Matyukevich wrote:

> > @NL80211_TID_CONFIG_ATTR_OVERRIDE: flag attribute, valid only if no STA
> > 	is selected, if set indicates that the new configuration
> > 	overrides all previous STA configurations, otherwise previous
> > 	STA-specific configurations should be left untouched
> > 
> > You also raise a good point wrt. "all TIDs" - but then we should
> > probably just remove NL80211_TID_CONFIG_ATTR_TID and add a new
> > NL80211_TID_CONFIG_ATTR_TIDS as a bitmap? OTOH, it's not hard to just
> > explicitly spell out all TIDs either, I guess, just makes the message a
> > bit bigger.
> 
> The idea with bitmask for TIDs looks good. It eliminates the need for both
> 'all TIDs' define and additional attribute NL80211_TID_CONFIG_ATTR_OVERRIDE.

I think we still need NL80211_TID_CONFIG_ATTR_OVERRIDE in some way
(maybe only as a flag attribute), since you could have

 * change all stations (some subset of TIDs) *including* already
   configured stations
 * or *excluding* already configured stations

> In fact, almost no changes are needed for the patch, mostly comments need
> to be updated. Manual typing in iw will be less convenient, but I guess
> this interface is not supposed to be used by humans after all...

If that's a concern we can parse a list in iw, e.g. "0,1,2,3" instaed of
"0xf", right?

johannes

