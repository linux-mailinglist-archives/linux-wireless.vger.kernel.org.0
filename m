Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E97792110
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 12:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfHSKOS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 06:14:18 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:38952 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfHSKOS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 06:14:18 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hzeg4-0007ec-U2; Mon, 19 Aug 2019 12:14:17 +0200
Message-ID: <645af7dad899e8eb186b3fee0f8a8a151a408557.camel@sipsolutions.net>
Subject: Re: [RFC 0/1] Allow MAC change on up interface
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Mon, 19 Aug 2019 12:14:15 +0200
In-Reply-To: <20190815185702.30937-1-prestwoj@gmail.com> (sfid-20190815_205833_978900_86B1E73D)
References: <20190815185702.30937-1-prestwoj@gmail.com>
         (sfid-20190815_205833_978900_86B1E73D)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-08-15 at 11:57 -0700, James Prestwood wrote:
> This is an example of how a devices MAC address could be changed while
> the interface is up. Currently RTNL and mac80211 both require the
> interface be down before changing the MAC.
> 
> After poking around a bit I found that some drivers can actually
> change the MAC while the iface is up. Allowing user space to do this
> while the iface is up would elminate a few potential race conditions
> that arise when changing the MAC from user space.
> 
> This commit does a few things:
>  - Adds an EXT_FEATURE that user space can check to see if the driver
>    allows this MAC changing.
>  - Adds a new NL80211_ATTR for including a "random mac" to     
>    CMD_CONNECT. This MAC is passed down the stack and gets set to 
>    the net_device's address.
>  - Set this wiphy extended feature in iwlwifi (just as an example)
>  - Relax checks in mac80211 which check if the interface is running
>  - Set IFF_LIVE_ADDR_CHANGE on net_device. Note: I know setting this
>    where I did is likely not the right way to do it, but for this
>    proof-of-concept it works. With guidance I can move this around
>    to a proper place.


It actually seems wrong to set IFF_LIVE_ADDR_CHANGE at all, because you
don't actually support that - you only support setting it while not
connected?

johannes

