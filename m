Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B67F097347
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 09:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfHUHVt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 03:21:49 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:56550 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbfHUHVs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 03:21:48 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i0KwE-0004Ha-Fr; Wed, 21 Aug 2019 09:21:46 +0200
Message-ID: <fb3e3b6457ca0b0a101c52a0f81d6fd43feb5ce8.camel@sipsolutions.net>
Subject: Re: [RFC 0/1] Allow MAC change on up interface
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>, Dan Williams <dcbw@redhat.com>,
        James Prestwood <prestwoj@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Wed, 21 Aug 2019 09:21:45 +0200
In-Reply-To: <86a8b422-87e3-5ab7-40fe-604969ec8ec1@gmail.com> (sfid-20190821_000042_023700_1DBF3775)
References: <20190815185702.30937-1-prestwoj@gmail.com>
         <645af7dad899e8eb186b3fee0f8a8a151a408557.camel@sipsolutions.net>
         <394092a2f20697c9b055166a8254a5ef888551a5.camel@gmail.com>
         <4848c3a9d0b330fab4442436244387a2c127fa03.camel@sipsolutions.net>
         <c6b719d6279211bbf52443f327884d96ef63f2b2.camel@gmail.com>
         <6835732fcc59ba8dbbcda4abc6e17dad499a7d8d.camel@sipsolutions.net>
         <b115e933-a357-9904-e831-dea7df1b46b9@gmail.com>
         <3576ad937c0b40b971a1b9c1a7c7396731a94bad.camel@sipsolutions.net>
         <8c04da29-7515-1196-8431-67a6390bc00d@gmail.com>
         <3fd41591acd55535863f11a0cc4f0f5f2afd5bdf.camel@sipsolutions.net>
         <3313f0a7-2b38-9941-46bf-4c1a3e06a267@gmail.com>
         <3beb3208443d39201272e822d26c1389aa4940db.camel@redhat.com>
         <86a8b422-87e3-5ab7-40fe-604969ec8ec1@gmail.com>
         (sfid-20190821_000042_023700_1DBF3775)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-08-20 at 16:52 -0500, Denis Kenzior wrote:

> I'm not sure you can state that definitively just yet?  

That's not an argument, you also cannot state definitively that it will
not happen. But yes, I'd think it _is_ in fact likely to happen at some
point for something new, maybe it won't be IBSS but NAN, or something
new that we can't even consider yet. Why close the door on it?

> So the real 
> question is whether saving the extra round-trip to the kernel is worth 
> the in-kernel complexity.

Sort of.

>   Given that interleaved system calls are _always_ a problem

They're not interleaved, they're just serial. And seriously, if syscalls
were such a big problem, we wouldn't be using them, we'd have found a
better solution.

(and FWIW, I don't feel you're really arguing in good faith here. You're
just throwing out statements like that and dismissing all other
arguments with no good explanation.)

> , I argue that it is worth it for at least the Station 
> case (and it will keep connection times even faster to boot).  Isn't 
> minimizing the latency of connections the end goal here?  I get that 
> there are trade offs and people have other opinions on what a good trade 
> off is.

That's ridiculous. If I extrapolate that statement the logical
consequence is that you should put iwd into a kernel module. You're not
doing that, last I checked? So minimizing the latency of connections is
quite clearly not the only goal here.

I understand that you're interested in minimizing the latency of
connections. I can even agree that it's a worthwhile goal. But it cannot
be the only goal.

> But don't misunderstand, either solution is better than what we have 
> today.  My argument is: "why close the door on a particular solution 
> until the costs are known?"

That's not actually what you said.

> > Not really. It's the job of maintainers to balance all these things, to
> > step back and think of the bigger picture and the future rather than
> > just solving one particular use-case today.
> >  > Your tone leaves the impression you want a particular solution pushed
> > through without the normal planning/architecture discussions that
> > accompany API changes. And that's not how the process typically works.
> > 
> 
> So who's attacking who now?  We're trying to solve a long standing issue 
> that nobody has bothered to fix for years in a clean way.  Something 
> that one of your projects would benefit from, btw.

Seriously Denis, stop it.

johannes

