Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D06458262A
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2019 22:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbfHEUlG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Aug 2019 16:41:06 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:52468 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbfHEUlG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Aug 2019 16:41:06 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hujmy-0005av-5s; Mon, 05 Aug 2019 22:41:04 +0200
Message-ID: <806e8714fc6b87fea44bbe6838590bde3cdfe7cd.camel@sipsolutions.net>
Subject: Re: [EXT] [RFC/RFT] cfg80211: decouple us from the RTNL
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dedy Lansky <dlansky@codeaurora.org>,
        linux-wireless@vger.kernel.org
Cc:     'Florian Westphal' <fw@strlen.de>
Date:   Mon, 05 Aug 2019 22:41:02 +0200
In-Reply-To: <000701d54ba1$48ea2520$dabe6f60$@codeaurora.org>
References: <20190731220848.1045-1-johannes@sipsolutions.net>
         <000701d54ba1$48ea2520$dabe6f60$@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-08-05 at 18:20 +0300, Dedy Lansky wrote:

> > Then, we can restrict the RTNL to a few cases where we add or
> > remove interfaces and really need the added protection. Some
> > of the global list management still also uses the RTNL, since
> > we need to have it anyway for netdev management.
> > TODO:
> >  - use wiphy_lock()/wiphy_unlock() in all drivers as the code
> >    changed in mac80211 does
> 
> I guess this change breaks existing drivers because some drivers assume RTNL
> is locked when their cfg callbacks are executed. Is that correct?

It might, to some extent. Mostly though, it shouldn't really matter to
them since the actual callbacks that manipulate interfaces (add, remove,
set type) and thus require RTNL still hold the RTNL.

> Would there be any simple rules for drivers when to use each one of the
> locking API: rtnl vs wiphy vs wdev ?

I'd say RTNL only if externally required. Wiphy vs. wdev I haven't
really quite made up my mind - I'm contemplating just removing the wdev
lock since for (driver/mac80211) simplicity we'll probably not want
concurrency there anyway? Should be rare (Ben Greear will be the only
one hitting it ...) that you really need concurrency there, and
simplifies things a lot.

johannes

