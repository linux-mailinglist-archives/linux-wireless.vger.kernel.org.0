Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D94A8AF888
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 11:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfIKJJK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 05:09:10 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:33946 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbfIKJJK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 05:09:10 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i7yce-0002Ft-Th; Wed, 11 Sep 2019 11:09:09 +0200
Message-ID: <d776271eac8b7cd24da6dbd21fb87186b30a0e7f.camel@sipsolutions.net>
Subject: Re: [RFC 0/4] Allow live MAC address change
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 11 Sep 2019 11:09:07 +0200
In-Reply-To: <20190904191155.28056-1-prestwoj@gmail.com> (sfid-20190904_221357_305070_478BF6CA)
References: <20190904191155.28056-1-prestwoj@gmail.com>
         (sfid-20190904_221357_305070_478BF6CA)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi James,

TBH, I'm still not really convinced.

> I have taken some timings for all 3 ways of changing the MAC. Powered
> change via RTNL, non powered via RTNL, and changing through
> CMD_CONNECT. All times were taken in microseconds and tested on an
> Intel 7260 PCI wireless adapter:

From where to where did you measure? I mean, clearly you cannot have
counted all the way to the connection?

> Powered via RTNL:
> 
> Average: 294508.9
> Min: 284523
> Max: 300345
> 
> ==================================
> Non-Powered via RTNL:
> 
> Average: 14824.7
> Min: 11037
> Max: 17812
> 
> Speedup from powered change: 19.87x (average)

I'm assuming that this version is the IFF_LIVE_ADDR_CHANGE + setting the
MAC address via RTNL?

If so, yeah, obviously not powering off the firmware will be much faster
than powering it off. That's an easy win really.

> ==================================
> via CMD_CONNECT:
> 
> Average: 11848.7
> Min: 9748
> Max: 17152
> 
> Speedup from powered change: 24.86x (average)

And this really only gives you a gain of 3ms.

That'd be nice, but like I said before, it's not the only thing we/you
should be thinking about.

One fundamental issue I have with this is that you're now combining
together temporary with persistent state changes. After a disconnection
(or connection failure), the interface usually goes back to its previous
state. With this change, you're keeping the MAC address modified though.

Sure, you don't care (because you're probably going use a new random
address later anyway), but these are still things we should consider in
an API.

I'll happily take the subset of the patches that implements the
IFF_LIVE_ADDR_CHANGE in mac80211, but I don't think the 3ms win there
wins over having a well-defined API.

johannes

