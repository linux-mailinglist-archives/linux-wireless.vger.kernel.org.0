Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55AE496815
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 19:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfHTRxs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 13:53:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbfHTRxs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 13:53:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F29C98D5BA6;
        Tue, 20 Aug 2019 17:53:46 +0000 (UTC)
Received: from ovpn-112-65.rdu2.redhat.com (ovpn-112-65.rdu2.redhat.com [10.10.112.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B027C1001959;
        Tue, 20 Aug 2019 17:53:45 +0000 (UTC)
Message-ID: <32547793981b3997f7e0f74137745f38615e5c54.camel@redhat.com>
Subject: Re: [RFC 0/1] Allow MAC change on up interface
From:   Dan Williams <dcbw@redhat.com>
To:     Denis Kenzior <denkenz@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 20 Aug 2019 12:53:44 -0500
In-Reply-To: <7b9a7df3-6880-98f6-5c09-257165025559@gmail.com>
References: <20190815185702.30937-1-prestwoj@gmail.com>
         <645af7dad899e8eb186b3fee0f8a8a151a408557.camel@sipsolutions.net>
         <394092a2f20697c9b055166a8254a5ef888551a5.camel@gmail.com>
         <4848c3a9d0b330fab4442436244387a2c127fa03.camel@sipsolutions.net>
         <1d975fec-a480-f40b-ff98-90d0e4852758@gmail.com>
         <72ac048c01619e0639fc182cd32818a5712cda1c.camel@sipsolutions.net>
         <7b9a7df3-6880-98f6-5c09-257165025559@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Tue, 20 Aug 2019 17:53:47 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-08-20 at 10:40 -0500, Denis Kenzior wrote:
> Hi Johannes,
> 
> > Stop.
> > 
> > Your tone, and in particular the constant snide comments and
> > attacks on
> > me are, quite frankly, getting extremely tiring.
> > 
> 
> Look, I'm sorry I hit a nerve, but from where I am sitting, it had to
> be 
> said...

But did it really? And in that way?  There were certainly better ways
to go about that response.

I don't recall seeing a NAK anywhere his email chain (which you'd get
with some other kernel maintainers) but instead (a) an explanation of
why the proposed solution had some problems, (b) some alternative
possibilities and (c) requests for more information so the discussion
could continue.

It does the requested changes no good to take that kind of tone. Let's
move on from here and keep things constructive to solve the problem at
hand, which is:

"Changing the MAC address of a WiFi interface takes longer than I'd
like and clears some state that I'd like it to keep."

That is a technical problem we can solve, so let's keep it at that
level.

Dan

> Regardless.  Peace, I'm not trying to start drama here.  We just want
> to 
> improve things and it feels like you're shutting down every idea
> without 
> truly understanding the issues we're facing.
> 
> > It almost seems like you're just trying to bully me into taking
> > your
> > patches by constantly trying to make me feel that I cannot know
> > better
> > anyway. This is not how you should be treating anyone.
> > 
> 
> Before lecturing me on my tone, can you go back and re-read your 
> responses to many of the contributors here?  I mean really read
> them? 
> Your tone is quite dismissive, whether intentional or not.  When one
> of 
> my guys comes to me and says:
> 	"Johannes' response was completely useless, it feels like he
> didn't 
> even read my cover letter"
> 
> I will come out and call you on it.  So if you don't mean to come
> off 
> that way, great.  We'll just chalk it up to a mis-understanding.
> 
> > Look, I did say I don't see a point in this, but you're taking that
> > out
> > of context. I also stated that I didn't understand the whole thing
> > about
> > "race conditions" and all, because nobody actually explained the
> > reasoning behind the changes here.
> 
> Fine.  I get that.  But how about asking what the use case is? Or
> say 
> you don't quite understand why something is needed?  We'll happily 
> explain.  When the first reaction to an RFC is: "I don't see the
> point" 
> or "You're doing it wrong" from a maintainer who's job (by
> definition) 
> is to encourage new contributors and improve the subsystem he 
> maintains...?  Well that's kind of a downer, don't you
> agree?  You're 
> the maintainer and you should be held to a higher standard...
> 
> I maintain 3 projects, I know the job isn't great, but you still
> should 
> be (more) civil to people...
> 
> > James, unlike you, managed to reply on point and explain why it was
> > needed. If all you can do is accuse me of not using the software
> > and
> > therefore not knowing how it should be used, even implying that I'm
> > not
> > smart enough to understand the use cases, then I don't know why you
> > bother replying at all.
> 
> Good on James.  I council all my guys to keep cool when dealing with 
> upstream.  But that doesn't mean you should be dismissing things out
> of 
> hand on the very first interaction you have with a new contributor.
> 
> > I can understand your frustration to some extent, and I want to
> > give you
> > the benefit of doubt and want to believe this behaviour was borne
> > out of
> > it, since I've been reviewing your changes relatively critically.
> > 
> 
> Good.  I want you to do that.  The changes are in very tricky areas
> and 
> you know the code best.
> 
> > However, I also want to believe that I've been (trying to) keep the
> > discussion on a technical level, telling you why I believe some
> > things
> > shouldn't be done the way you did them, rather than telling you
> > that
> > you're not smart enough to be working on this. If you feel
> > otherwise,
> > please do let me know and I'll go back to understand, in order to
> > improve my behaviour in the future.
> 
> If you interpreted my rants as an assault to your intelligence, then
> I'm 
> sorry.  They really were not meant this way.  But sometimes we
> really 
> had to wonder if you were using the same API we were?  So the
> question I 
> asked above was purely logical consequence of what I was seeing.
> 
> You yourself admitted that you have never implemented an event
> driven 
> stack.  So how about listening to the guys that are?
> 
> We are using your APIs in different ways.  So instead of questioning
> why 
> or attacking those ways, how about asking whether improvements can be
> made?
> 
> We are facing serious pain points with the API.  So instead of 
> dismissing things out of hand, can we work together to improve
> things?
> 
> We are trying to make things fast.  The API is frequently not setup
> for 
> that.  The MAC randomization is just one example.  Bringing down the 
> interface (and shutting down the firmware, toggling power state, 
> cleaning up resources/state) prior to every connection is just not 
> acceptable.  Look at the link I sent.  The Android guys state 3
> seconds 
> is the typical 'hit'.  This is literally wasting everyone's time.
> 
> > Please help keep the discussion technical, without demeaning
> > undertones.
> 
> Point taken.  And I apologize again.  But please consider what I said
> above.
> 
> Regards,
> -Denis

