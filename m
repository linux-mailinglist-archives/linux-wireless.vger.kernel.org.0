Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BECB75FF1
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 09:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfGZHgX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 03:36:23 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:44440 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfGZHgX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 03:36:23 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hqum4-0006vt-Sg; Fri, 26 Jul 2019 09:36:20 +0200
Message-ID: <2efa83ab8120e29d1eb1be8295d59568b4eacc9a.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v3 0/2] cfg80211: fix duplicated scan entries after
 channel switch
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>
Date:   Fri, 26 Jul 2019 09:36:19 +0200
In-Reply-To: <20190712105212.clf77zne6i4gh5ti@bars>
References: <20190710173651.15770-1-sergey.matyukevich.os@quantenna.com>
         <1c371a5921200a11da459b591df121bbcb0f967d.camel@sipsolutions.net>
         <20190712092716.ywnkns473s5rtoku@bars>
         <43055be7b2d7ff0f8dbadd19443fc73f30f93bb6.camel@sipsolutions.net>
         <20190712105212.clf77zne6i4gh5ti@bars>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Sergey,

Sorry for dropping the ball on this thread.

> > Right, it will be updated on RX. But then if we chanswitch, we would
> > probably (mac80211 using a pointer to the non-transmitting BSS) update
> > only one of the nontransmitting BSSes?
> > 
> > Just saying that maybe we need to be careful there - or your wording
> > might be incorrect. We might end up updating a *nontransmitting* BSS,
> > and then its transmitting/other non-tx ones only later?
> 
> Hmmm... I am not sure we are on the same page here. Could you please
> clarify your concerns here ?

I'm trying to say we might have this:

cfg80211
 * transmitting BSS 0
   - nontx BSS 1
   - nontx BSS 2
   - nontx BSS 3
mac80211
 * ifmgd->associated (and cfg80211's wdev->current_bss?) = nontx BSS 2


Now, things like the channel information etc. will always be identical
between the 4 BSSes, by definition.

However, if you chanswitch and mac80211 just lets cfg80211 know about
the current_bss, then you may end up in a situation where the channel
information is no longer the same, which is very surprising.


> The normal (non multi-BSSID) BSS usecase seem to be clear: keep old and
> remove new (if any), since it is not easy to update ifmgd->associated.

Right.

> Now let me take another look at the usecase when STA is connected to
> a transmitting or non-transmitting BSS of a multi-BSS AP. At the moment
> suggested code does the following. If STA is connected to the non-transmitting
> BSS, then we switch to its transmitting BSS, instead of working with
> current_bss directly.

We switch? Where? Maybe I missed that.

> So we look for the new entry (with new channel) of the transmitting BSS.
> If it exists, then we remove it and _all_ of its non-transmitting BSSs.
> Finally, we update channel and location in rb-tree of the existing (old)
> transmitting BSS as well as _all_ of its non-transmitting entries.

That would indeed address the scenario I was thinking of ...

johannes

