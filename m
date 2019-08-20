Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 321E996A00
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 22:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbfHTUPv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 16:15:51 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:43158 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729950AbfHTUPv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 16:15:51 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i0AXl-0007eV-8t; Tue, 20 Aug 2019 22:15:49 +0200
Message-ID: <3fd41591acd55535863f11a0cc4f0f5f2afd5bdf.camel@sipsolutions.net>
Subject: Re: [RFC 0/1] Allow MAC change on up interface
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>,
        James Prestwood <prestwoj@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Dan Williams <dcbw@redhat.com>
Date:   Tue, 20 Aug 2019 22:15:45 +0200
In-Reply-To: <8c04da29-7515-1196-8431-67a6390bc00d@gmail.com> (sfid-20190820_220640_385053_F92EA8C6)
References: <20190815185702.30937-1-prestwoj@gmail.com>
         <645af7dad899e8eb186b3fee0f8a8a151a408557.camel@sipsolutions.net>
         <394092a2f20697c9b055166a8254a5ef888551a5.camel@gmail.com>
         <4848c3a9d0b330fab4442436244387a2c127fa03.camel@sipsolutions.net>
         <c6b719d6279211bbf52443f327884d96ef63f2b2.camel@gmail.com>
         <6835732fcc59ba8dbbcda4abc6e17dad499a7d8d.camel@sipsolutions.net>
         <b115e933-a357-9904-e831-dea7df1b46b9@gmail.com>
         <3576ad937c0b40b971a1b9c1a7c7396731a94bad.camel@sipsolutions.net>
         <8c04da29-7515-1196-8431-67a6390bc00d@gmail.com>
         (sfid-20190820_220640_385053_F92EA8C6)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-08-20 at 14:58 -0500, Denis Kenzior wrote:
> 
> But what actual complexity are we talking about here? If the kernel can 
> do this while the CONNECT is pending, why not?  It makes things simpler 
> and faster for userspace.  I don't see the downside unless you can 
> somehow objectively explain 'complexity'.

It's just extra code that we have to worry about. Right now you want it
for CMD_CONNECT and CMD_AUTH. Somebody will come up with a reason to do
it in CMD_ASSOC next, perhaps, who knows. Somebody else will say "oh,
this is how it's done, so let's add it to CMD_JOIN_IBSS", because of
course that's what they care about. OCB? Mesh? AP mode for tethering?
Etc.

I don't see how this will not keep proliferating, and each new thing
will come with its own dozen lines of code, a new feature flag, etc.

Relaxing and defining once and for all in which situations while the
interface is up you can actually allow changing the address, and then
having userspace do it that way is IMHO a better way to design the
system, since it forgoes entirely all those questions of when and how
and which new use cases will come up etc.

> This was an RFC.  There isn't much point for us to cross all the 't's 
> and dot all the 'i's if you hate the idea in the first place.

Sure, but I cannot distinguish between "we only want it on CMD_CONNECT"
and "we'll extend this once we agree" unless you actually say so. It'd
help to communicate which t's and i's you didn't cross or dot.

> It would get the job done.  But it is still a waste of time and still 
> slowing us down.  Look at it this way, even if we save 10ms here.  Take 
> that and multiply by 3-4 billion devices and then by the number of 
> connections one does each day.  This adds up to some serious time 
> wasted.  So why not do this elegantly and faster in the first place?

It may be a bit faster, but I don't agree with elegantly. It may be more
elegant from the point of view of that single operation, but to me it's
a lot less elegant from a system view, with all the possible extensions
to it that we'll no doubt see, and not have thought about today.

johannes

