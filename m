Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 799A794ED1
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 22:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfHSUVD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 16:21:03 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:47536 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfHSUVD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 16:21:03 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hzo9E-00041E-Mb; Mon, 19 Aug 2019 22:21:00 +0200
Message-ID: <4848c3a9d0b330fab4442436244387a2c127fa03.camel@sipsolutions.net>
Subject: Re: [RFC 0/1] Allow MAC change on up interface
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Mon, 19 Aug 2019 22:20:59 +0200
In-Reply-To: <394092a2f20697c9b055166a8254a5ef888551a5.camel@gmail.com> (sfid-20190819_175627_344053_E33FB9B0)
References: <20190815185702.30937-1-prestwoj@gmail.com>
         (sfid-20190815_205833_978900_86B1E73D) <645af7dad899e8eb186b3fee0f8a8a151a408557.camel@sipsolutions.net>
         <394092a2f20697c9b055166a8254a5ef888551a5.camel@gmail.com>
         (sfid-20190819_175627_344053_E33FB9B0)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi James,

> > It actually seems wrong to set IFF_LIVE_ADDR_CHANGE at all, because
> > you
> > don't actually support that - you only support setting it while not
> > connected?
> 
> You are right, we only care about setting the MAC while not connected.
> But, the eth_ API's that set the MAC are contingent on
> IFF_LIVE_ADDR_CHANGE when the interface is running. If you follow down
> 'dev_set_mac_address':
> 
> dev_set_mac_address ->
>    ndo_set_mac_address (ieee80211_change_mac) ->
>       eth_mac_addr ->
>          eth_prepare_mac_addr_change:
> 
> You see the check for:
> 
> !(dev->priv_flags & IFF_LIVE_ADDR_CHANGE) && netif_running(dev)

Right.

> Like I said in my commit message, I did not think setting
> IFF_LIVE_ADDR_CHANGE where I did was the correct way to do it, but
> unless this eth code is changed its looking like it does need to be set
> somewhere to change the MAC while 'running'.

Also right.

> Maybe this is a historical thing but the comment about
> IFF_LIVE_ADDR_CHANGE says "device supports hardware address change when
> it's running". Isn't a wireless adapter 'running' when not connected?
> Or does 'running' indicate some different state than up/down?
> 
> If you have any suggestions on how I could do this without setting
> IFF_LIVE_ADDR_CHANGE I am all ears.

I don't, short of

1) don't do that then
2) extend the network stack to have IFF_LIVE_BUT_NO_CARRIER_ADDR_CHANGE
   or something like that

TBH, I'm not really sure I see any point in this to start with, many
devices will give the address to the firmware when the interface is
brought up (even iwlwifi does - I'm not sure we'd want to take your
patch for iwlwifi even if that works today, nothing says the firmware
might not change its mind on that), and so it's quite likely only going
to be supported in few devices.

You've also not really explained what exactly is troubling you with
changing the MAC address, you just mentioned some sort of "race
condition"?

Now, one thing I can imagine would be that you'd want to optimize

 * ifdown
   - remove iface from fw/hw
   - stop fw/hw
 * change MAC
 * ifup
   - start fw/hw
   - add iface to fw/hw

to just

 * ifdown
   - remove iface from fw/hw
 * change MAC
 * ifup
   - add iface to fw/hw

i.e. not restart the firmware (which takes time) for all this, but that
seems much easier to solve by e.g. having a combined operation for all
of this that gets handled in mac80211, or more generally by having a
"please keep the firmware running" token that you can hold while you do
the operation?


Your changes are also a bit strange - you modified the "connect" path
and iwlwifi, but the connect path is not usually (other than with iw or
even iwconfig) taken for iwlwifi? And if you modify auth/assoc paths,
you get into even weirder problems - what if you use different addresses
for auth and assoc? What if the assoc (or even connect) really was a
*re*assoc, and thus must have the same MAC address? To me, the whole
thing seems like more of a problem than a solution.

johannes

