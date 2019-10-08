Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C62C8CFE28
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 17:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbfJHPwt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 11:52:49 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:42074 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbfJHPws (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 11:52:48 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iHrn4-0003Ef-Sf; Tue, 08 Oct 2019 17:52:46 +0200
Message-ID: <6530a6b06176790c5a6949d6ffccf37b506975bd.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] mac80211: Support LIVE_ADDRESS_CHANGE feature
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>,
        James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 08 Oct 2019 17:52:46 +0200
In-Reply-To: <6fa34e4c-5c81-4875-da29-cada1a078e2c@gmail.com> (sfid-20191008_174756_354544_4F2B93CF)
References: <20190913195908.7871-1-prestwoj@gmail.com>
         <20190913195908.7871-2-prestwoj@gmail.com>
         <c6835b5c5d2a97fa82b0fb21f7b7f0056aa42e1b.camel@sipsolutions.net>
         <90ae00044bc0834d87d3f9fb75ce63dce4cfadd5.camel@gmail.com>
         <0b57c1288016310050ccd6233dda886fc4a89b02.camel@gmail.com>
         <f468a8d573ddf401d2084b76eb625fef5950f265.camel@sipsolutions.net>
         <6fa34e4c-5c81-4875-da29-cada1a078e2c@gmail.com>
         (sfid-20191008_174756_354544_4F2B93CF)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> > You could have two interfaces, one which is scanning right now, right?
> > And then theoretically you don't care about the other one - it *should*
> > be OK to remove/re-add (with new MAC address) the one that *isn't*
> > scanning, right?
> 
> Actually, I don't think you can?  Unless I'm missing something?  All the 
> scan state is stored on struct ieee80211_local, so if that struct is 
> allocated per phy as you point out below, then what you suggest is 
> currently not possible?

?

The scan_req struct contains a reference to which interface is scanning,
so it should very well be possible to have

phy0:
 wlan0: IFF_UP & scanning
 wlan1: IFF_UP & change MAC address all the time

just like it's possible to change the MAC address when wlan1 *isn't*
IFF_UP even if wlan0 is scanning, right?

> > But we don't have that granularity here for anything - you're just
> > checking "sdata->local->something", and by going from sdata to local
> > you've now checked the whole NIC, not just a single interface on that
> > NIC.
> 
> Right.  But that seems to be a limitation of mac80211 actually.  We 
> can't run two scans concurrently on different interfaces.  This is 
> rather unintuitive given that scan requests require an ifindex/wdev.
> 
> Can this be changed / fixed in mac80211 actually?  I would expect that 
> if a card supports p2p and station simultaneously, then it can scan / go 
> offchannel on two interfaces simultaneously? Or not?  What can iwlwifi 
> do for example?

No, this typically cannot be fixed, and it doesn't really make sense.
The NIC cannot possibly do two scans at a time since it has only a
single radio resource :-)

> > But it's also completely confusing to do it this way because you go from
> > "sdata" to "local", and at that point the data that you're working on is
> > no longer specific to that one interface, it's actually for the whole
> > NIC.
> 
> I agree its confusing, but that seems to be how mac80211 works?

See above.

> Given the above, I'm not sure I see anything wrong?  The switch/case can 
> probably be gotten rid of, but it actually makes things clear that only 
> station/p2p_device and adhoc are handled specially.

I just don't think they *should* be handled specially.

Given your code now, you can have

phy0:
 wlan0: STATION, IFF_UP & something is doing remain-on-channel
 wlan1: STATION, IFF_UP

--> cannot change wlan1 MAC address

phy0:
 wlan0: STATION, IFF_UP & something is doing remain-on-channel

wlan1: AP, IFF_UP

--> *can* change wlan1 MAC address

This doesn't really make much sense?

johannes

