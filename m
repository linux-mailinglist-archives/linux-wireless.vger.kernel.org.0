Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66D6AB26FB
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 23:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfIMVBb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 17:01:31 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:33476 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfIMVBb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 17:01:31 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i8sh8-0000x1-1C; Fri, 13 Sep 2019 23:01:30 +0200
Message-ID: <47aaaccf7d8fb58587f0cfbe38acd18e1420dc9a.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] nl80211: Add LIVE_ADDR_CHANGE feature
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 13 Sep 2019 23:01:29 +0200
In-Reply-To: <38c222129dd182de4c55e536a89eada7f58a1bf1.camel@gmail.com> (sfid-20190913_225826_111097_E5ED9AB1)
References: <20190913195908.7871-1-prestwoj@gmail.com>
         (sfid-20190913_220113_419728_36032050) <6c85d9b108825939afb84ebc8a708a211f7e2b98.camel@sipsolutions.net>
         <38c222129dd182de4c55e536a89eada7f58a1bf1.camel@gmail.com>
         (sfid-20190913_225826_111097_E5ED9AB1)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-09-13 at 13:56 -0700, James Prestwood wrote:
> Hi,
> 
> On Fri, 2019-09-13 at 22:48 +0200, Johannes Berg wrote:
> > On Fri, 2019-09-13 at 12:59 -0700, James Prestwood wrote:
> > > Add a new feature bit signifying that the wireless hardware
> > > supports
> > > changing the mac address while the underlying net_device is
> > > UP.  Note
> > > that this is slightly different from IFF_LIVE_ADDR_CHANGE as
> > > additional
> > > restrictions might be imposed by the hardware.  Typical
> > > restrictions
> > > are:
> > > 	- No connection is active on this interface, e.g. carrier is
> > > off
> > > 	- No scan is in progress
> > > 	- No offchannel operation is in progress
> > 
> > Hmm, what do you need this patch for?
> > 
> > IFF_LIVE_ADDR_CHANGE should be sufficient to discover it?
> 
> Because userspace needs to know if this is supported?
> IFF_LIVE_ADDR_CHANGE is a private flag... AFAIK userspace has no way of
> obtaining this.

Oh, annoying.

But that doesn't really mean that nl80211 is an appropriate place to
advertise it, IMHO?

And in nl80211 you'd need the flag for if you actually have the "change
MAC address during connect" attribute.

johannes

