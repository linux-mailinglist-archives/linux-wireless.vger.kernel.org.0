Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D936996B43
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 23:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbfHTVSm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 17:18:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730782AbfHTVSm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 17:18:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CF9493086E21;
        Tue, 20 Aug 2019 21:18:41 +0000 (UTC)
Received: from ovpn-112-65.rdu2.redhat.com (ovpn-112-65.rdu2.redhat.com [10.10.112.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3C6567627;
        Tue, 20 Aug 2019 21:18:40 +0000 (UTC)
Message-ID: <3beb3208443d39201272e822d26c1389aa4940db.camel@redhat.com>
Subject: Re: [RFC 0/1] Allow MAC change on up interface
From:   Dan Williams <dcbw@redhat.com>
To:     Denis Kenzior <denkenz@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        James Prestwood <prestwoj@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Tue, 20 Aug 2019 16:18:39 -0500
In-Reply-To: <3313f0a7-2b38-9941-46bf-4c1a3e06a267@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 20 Aug 2019 21:18:41 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-08-20 at 15:37 -0500, Denis Kenzior wrote:
> Hi Johannes,
> 
> On 8/20/19 3:15 PM, Johannes Berg wrote:
> > On Tue, 2019-08-20 at 14:58 -0500, Denis Kenzior wrote:
> > > But what actual complexity are we talking about here? If the
> > > kernel can
> > > do this while the CONNECT is pending, why not?  It makes things
> > > simpler
> > > and faster for userspace.  I don't see the downside unless you
> > > can
> > > somehow objectively explain 'complexity'.
> > 
> > It's just extra code that we have to worry about. Right now you
> > want it
> > for CMD_CONNECT and CMD_AUTH. Somebody will come up with a reason
> > to do
> > it in CMD_ASSOC next, perhaps, who knows. Somebody else will say
> > "oh,
> > this is how it's done, so let's add it to CMD_JOIN_IBSS", because
> > of
> > course that's what they care about. OCB? Mesh? AP mode for
> > tethering?
> > Etc.
> 
> I don't buy the extra code argument.  If you want to do something
> useful 
> you need to write 'extra code'.

Code will be written, but I'd rather it be written once rather than 3+
times for STA/AP/Mesh/etc.

> The rest, I'm not sure why you are worried about them now?  For
> station 
> there's a very clear & present use case.  If such a clear and
> present 
> use case is presented for AP or Mesh, then deal with it then.

Why would you not want to pass a random MAC for AP or Mesh modes? The
same reasons for MAC randomization apply for all those too, I'd think.

> > I don't see how this will not keep proliferating, and each new
> > thing
> > will come with its own dozen lines of code, a new feature flag,
> > etc.
> 
> Such is life? :)

Not really. It's the job of maintainers to balance all these things, to
step back and think of the bigger picture and the future rather than
just solving one particular use-case today.

Your tone leaves the impression you want a particular solution pushed
through without the normal planning/architecture discussions that 
accompany API changes. And that's not how the process typically works.

Dan

> > Relaxing and defining once and for all in which situations while
> > the
> > interface is up you can actually allow changing the address, and
> > then
> > having userspace do it that way is IMHO a better way to design the
> > system, since it forgoes entirely all those questions of when and
> > how
> > and which new use cases will come up etc.
> > 
> 
> That would be great in theory, but practically never works at least
> in 
> my experience.  So maybe keep and open mind?  There is a clear need
> to 
> make this path as fast as possible for STA.  There is no such need
> (yet) 
> for the other cases you mentioned.

> > > This was an RFC.  There isn't much point for us to cross all the
> > > 't's
> > > and dot all the 'i's if you hate the idea in the first place.
> > 
> > Sure, but I cannot distinguish between "we only want it on
> > CMD_CONNECT"
> > and "we'll extend this once we agree" unless you actually say so.
> > It'd
> > help to communicate which t's and i's you didn't cross or dot.
> 
> Okay, I'll admit the RFC description could have been better.  But in
> the 
> end you're human last I checked (at least I recall meeting you
> several 
> times? ;)  How about a simple "Why do you think you need this?"
> first?
> 
> Regards,
> -Denis

