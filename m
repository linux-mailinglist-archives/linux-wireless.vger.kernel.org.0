Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D0A2DCD5D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 09:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgLQIJS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 03:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgLQIJS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 03:09:18 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBD4C061794
        for <linux-wireless@vger.kernel.org>; Thu, 17 Dec 2020 00:08:38 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kpoKw-00AYL0-9a; Thu, 17 Dec 2020 09:08:34 +0100
Message-ID: <cb011e2a7ef941ff729453087a71ab737aad98f6.camel@sipsolutions.net>
Subject: Re: [PATCH 7/7] mac80211: add rx decapsulation offload support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date:   Thu, 17 Dec 2020 09:08:17 +0100
In-Reply-To: <dc5db3c0-e4bf-d8ed-3da6-5b549628a0cb@nbd.name>
References: <20201216204316.44498-1-nbd@nbd.name>
         <20201216204316.44498-7-nbd@nbd.name>
         <893856dcc9ff9adf65b0bcdbb6ce127d56980ee8.camel@sipsolutions.net>
         <dc5db3c0-e4bf-d8ed-3da6-5b549628a0cb@nbd.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-12-16 at 22:19 +0100, Felix Fietkau wrote:
> On 2020-12-16 22:03, Johannes Berg wrote:
> > On Wed, 2020-12-16 at 21:43 +0100, Felix Fietkau wrote:
> > > +	offload = assign &&
> > > +		  (sdata->vif.offload_flags & IEEE80211_OFFLOAD_DECAP_ENABLED);
> > > +
> > > +	if (offload)
> > > +		set_offload = !test_and_set_sta_flag(sta, WLAN_STA_DECAP_OFFLOAD);
> > > +	else
> > > +		set_offload = test_and_clear_sta_flag(sta, WLAN_STA_DECAP_OFFLOAD);
> > > +
> > > +	if (set_offload)
> > > +		drv_sta_set_decap_offload(local, sdata, &sta->sta, assign);
> > 
> > Some of these lines look a bit long?
> Just a tiny bit over 80 characters. Wasn't the 80 characters line limit
> removed a while back? I don't think line wrapping would make things more
> readable here.

Ok, fair point, I didn't count :-)

> > Not sure that's really the right thing to do ... we often want monitor
> > interfaces (with no flags set) for debug?
> > 
> > Or maybe we should add some tracing then (instead).
> Tracing probably makes more sense. I'm not sure pcap or radiotap can
> deal with a mix of 802.3 and 802.11 packets. Leaving offload enabled and
> silently dropping 802.3 packets seems like a bad idea to me as well.

Right. I've long felt that perhaps we should have tracing for this,
rather than relying on the extra monitor interface, but the monitor
interface is oh so convenient since you can directly use the result for
wireshark etc. :)

I guess I don't really care that much either way. Going with your
approach seems reasonable, but people will have to be aware that "just
add a monitor interface" is now going to affect things more than it used
to.

johannes

