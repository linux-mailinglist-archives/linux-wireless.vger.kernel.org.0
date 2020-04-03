Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E727619E188
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Apr 2020 01:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgDCXpU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Apr 2020 19:45:20 -0400
Received: from mx.sdf.org ([205.166.94.20]:49607 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgDCXpU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Apr 2020 19:45:20 -0400
Received: from sdf.org (IDENT:lkml@faeroes.freeshell.org [205.166.94.9])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 033NeTPw000829
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Fri, 3 Apr 2020 23:40:29 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 033NeSdE027418;
        Fri, 3 Apr 2020 23:40:28 GMT
Date:   Fri, 3 Apr 2020 23:40:28 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org, Ajay.Kathat@microchip.com,
        gregkh@linuxfoundation.org, linux-wireless@vger.kernel.org,
        Adham.Abozaeid@microchip.com, johannes@sipsolutions.net,
        lkml@sdf.org
Subject: Re: [PATCH v3] staging: wilc1000: Use crc7 in lib/ rather than a
 private copy
Message-ID: <20200403234028.GA11944@SDF.ORG>
References: <20200326152251.19094-1-ajay.kathat@microchip.com>
 <20200402082745.GG2001@kadam>
 <20200402153034.GB2013@SDF.ORG>
 <20200403091029.GC2001@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403091029.GC2001@kadam>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Apr 03, 2020 at 12:10:29PM +0300, Dan Carpenter wrote:
> On Thu, Apr 02, 2020 at 03:30:34PM +0000, George Spelvin wrote:
> > On Thu, Apr 02, 2020 at 11:27:45AM +0300, Dan Carpenter wrote:
> > > I don't know how this patch made it through two versions without anyone
> > > complaining that this paragraph should be done as a separate patch...
> > 
> > I often fold comment (and spacing/formatting) patches in to a main
> > patch, when touching adjacent code anyway and it doesn't cause
> > distracting clutter.
> > 
> > This seemed like such a case, which is why I submitted it as one.
> > But it's a bit of style thing.
> > 
> 
> We're super strict in Staging.  :P  Greg is more strict than I am.

Okay, but it's my fault, not his.

>> This should have you Signed-off-by.  The Reviewed-by is kind of assumed
>>> so you can drop that bit.  But everyone who touches a patch needs to
>>> add their signed off by.
>> 
>> Er... all he did was add "staging: " to the front of the title.
>> 
>> That's not a change to the code at all, and as trivial a change
>> to the commit message as adding "Reviewed-by:" to the end.
>> We don't need S-o-b for such things or we'd end up in a horrible
>> infinite recursion.
> 
> You've misunderstood.  He sent the email so he has to add his
> Signed-off-by.  It's not at all related to changing anything in the
> patch.  That's how sign offs work.

Looking at my commits (just because I remember how they went in),
you seem to be right, but damn, submitting-patches.rst could be
clearer on the subject.

I understand that it's addressed more to patch authors than
maintainers forwarding them, but I've read that thing a dozen times,
and the description of S-o-b always seemed to be about copyright.

So I had assumed that edits which were below the de minimus standard
of copyright didn't need a separate S-o-b.

Am I right that there should be an S-o-b from everyone from the
patch author to the patch committer (as recorded in git)?  And the
one exception is that we don't need S-o-b for git pulls after that,
because the merge commits record the information?

For example, my patch series ending at 4684fe95300c (v4.7-rc1~8^2)
only has my S-o-b because it was pulled straight from my git server
and merge 7e0fb73c52c4 (v4.7-rc1~8) records who merged it.

But b5c56e0cdd62 has an S-o-b from both akpm and Linus because
it went to akpm, into his quilt, and then as a patch series to Linus,
who committed it.

All of which is eactly why git-am has a -s option.

That's not a hard rule to understand, but I wish submitting-patches
*said* so somewhere, rather than having it be implied by the
existence of option (c) in the DCO and the fact that it's *doesn't*
say that someone else's S-o-b will suffice.

And the git merge exception should be stated, because otherwise it's
not clear what the limits of that exception are.  I had assumed that
accumulating and forwarding patches in general was okay without a
S-o-b.

So thank you for enlightening me, and if you can confirm the rules,
I'll prepare a Documentation/ patch to reduce re-occurrence.
