Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7390966A1B
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 11:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfGLJkP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 05:40:15 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:55792 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfGLJkP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 05:40:15 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hls2H-00077E-4Y; Fri, 12 Jul 2019 11:40:13 +0200
Message-ID: <43055be7b2d7ff0f8dbadd19443fc73f30f93bb6.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v3 0/2] cfg80211: fix duplicated scan entries after
 channel switch
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>
Date:   Fri, 12 Jul 2019 11:40:11 +0200
In-Reply-To: <20190712092716.ywnkns473s5rtoku@bars>
References: <20190710173651.15770-1-sergey.matyukevich.os@quantenna.com>
         <1c371a5921200a11da459b591df121bbcb0f967d.camel@sipsolutions.net>
         <20190712092716.ywnkns473s5rtoku@bars>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-07-12 at 09:27 +0000, Sergey Matyukevich wrote:
> On Fri, Jul 12, 2019 at 11:11:19AM +0200, Johannes Berg wrote:
> > 
> > [External Email]: This email arrived from an external source - Please exercise caution when opening any attachments or clicking on links.

Heh, you have a not so fun email system that rewrites mails ...

> > > Suggested approach to handle non-transmitting BSS entries is simplified in the
> > > following sense. If new entries have been already created after channel switch,
> > > only transmitting bss will be updated using IEs of new entry for the same
> > > transmitting bss. Non-transmitting bss entries will be updated as soon as
> > > new mgmt frames are received. Updating non-transmitting bss entries seems
> > > too expensive: nested nontrans_list traversing is needed since we can not
> > > rely on the same order of old and new non-transmitting entries.
> > 
> > That sounds like a reasonable trade-off. I do wonder though what happens
> > if we're connected to a non-transmitting BSS?
> 
> Well, here I rely upon the assumption that CSA IEs of non-transmitting BSS
> are handled correctly by mac80211 or any FullMAC firmware. And if we are
> connected to non-transmitting BSS rather than transmitting one, the
> following code in the beginning of new cfg80211_update_assoc_bss_entry
> function is supposed to care about this use-case:

Right, it will be updated on RX. But then if we chanswitch, we would
probably (mac80211 using a pointer to the non-transmitting BSS) update
only one of the nontransmitting BSSes?

Just saying that maybe we need to be careful there - or your wording
might be incorrect. We might end up updating a *nontransmitting* BSS,
and then its transmitting/other non-tx ones only later?

johannes

