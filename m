Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC3E794EAB
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 22:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfHSUDb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 16:03:31 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:47150 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbfHSUDb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 16:03:31 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hznsG-0003hB-W0; Mon, 19 Aug 2019 22:03:29 +0200
Message-ID: <52914e64663283eeff9445b8b1fb37986c15223d.camel@sipsolutions.net>
Subject: Re: [PATCH] iwlwifi: Extended Key ID support for mvm and dvm
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        luciano.coelho@intel.com
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
Date:   Mon, 19 Aug 2019 22:03:27 +0200
In-Reply-To: <da471544-3370-8ba1-2265-d02ab09cdcee@wetzel-home.de>
References: <20190819180540.2855-1-alexander@wetzel-home.de>
         <204c346ab9fc71865e4cb5f5c29ec33ca05050e2.camel@sipsolutions.net>
         <da471544-3370-8ba1-2265-d02ab09cdcee@wetzel-home.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-08-19 at 21:57 +0200, Alexander Wetzel wrote:
> > > +
> > > +	/* The new Tx API does not allow to pass the key or keyid of a MPDU to
> > > +	 * the hw, preventing us to control which key(id) to use per MPDU.
> > > +	 * Till that's fixed we can't use Extended Key ID for the newer cards.
> > 
> > Technically we still don't need per MPDU, we just need to switch which
> > one to use for TX after installing it for RX already.
> 
> The Extended Key ID API we finally merged in mac80211 is not notifying 
> the driver when to switch the key over to the other id.

Oh, right, good point.

> The current API provides the key/keyid per MPDU and let's mac80211 have 
> the full control what's the correct key for each frame.

Yeah, but as you noticed we no longer have that control per MPDU with
the new TX API in iwlmvm.

> That's especially critical for drivers setting 
> IEEE80211_KEY_FLAG_GENERATE_IV and/or supporting A-MPDU's. Allowing the 
> driver to override the mac80211 decision is only safe when the 
> driver/card generates the PNs itself and also handles the A-MPDU key 
> borders correctly.

Sure, the device does generate the PN itself now with the new TX API
too. It doesn't care about A-MPDU key borders, but it probably could
when taught to care about extended key ID.

> While less desirable we still could get that working: The mvm driver 
> would have to detect the key borders and then tell the firmware to 
> switch over to the other key. But we would have to make sure to not 
> re-enable A-MPDU aggregation till the card really has switched.

I'm not entirely sure off the top of my head how it works, but it seems
possible that if we just assign a new PN to retransmits of the same
frame but in a new A-MPDU after key switching, it wouldn't actually
matter?

But then again maybe somewhere it's stated that we must use the same key
for all transmit attempts of a single frame? Not sure.

I'm also not sure if we could actually assign a PN from the new key for
the retransmit, the hardware has to store those back into memory
normally.

So probably you're right, and we'd have to disable A-MPDUs until we have
no outstanding old-key-retransmits, but that seems manageable.

johannes

