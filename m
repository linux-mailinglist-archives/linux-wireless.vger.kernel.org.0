Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5041146CB
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2019 19:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfLESUT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Dec 2019 13:20:19 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:59716 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLESUT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Dec 2019 13:20:19 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1icvjb-004Ntc-1n; Thu, 05 Dec 2019 19:20:15 +0100
Message-ID: <792356df00a9be73f2613f5b4c74bfe2edb05013.camel@sipsolutions.net>
Subject: Re: debugging TXQs being empty
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 05 Dec 2019 19:20:13 +0100
In-Reply-To: <e89fc619-b8b2-c77a-1da5-943a34e9c607@candelatech.com>
References: <bbc516f28782175b27ac5e19dcdeac13cd6ee76a.camel@sipsolutions.net>
         <49288397-55b3-f49a-e277-5197d7c1bea3@candelatech.com>
         <2e01fb1d5b8ff3335220231251f893c01c6c22d3.camel@sipsolutions.net>
         <64a6ae15-b7be-8c27-4e60-4cb3d253f3dc@candelatech.com>
         <e600f75741bd4c766bf043b0a404286f0ea22349.camel@sipsolutions.net>
         <e89fc619-b8b2-c77a-1da5-943a34e9c607@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-12-05 at 10:09 -0800, Ben Greear wrote:

> > Hmm, yeah, maybe not then. Something more general in the stack? I just
> > can't think of anything.
> 
> Test similar setup 10g wired to 10g wired to make sure traffic generator
> can generate hoped for load?

Oh, I think it normally works better - I'd have to look up the numbers,
don't have them handy now. It's a specific issue to this specific PC
that I have, could be related to the (bastardized) kernel that has, or
something else.

Hence my more general questions how I would understand/debug this, I
don't think I can say what the hardware or even kernel is (and even if
you knew it'd probably be useless, not sure that's public now.)

> > Using chariot. I don't really know it well, just the testers use it.
> 
> So, you have some PC with AX200 in it, acting as station, connected to some AP,
> and Charriot runs on that PC and something upstream of the AP and tries to
> send traffic from PC to AP?

Traffic is going from the DUT to a wired station behind the AP, which
actually has two gigabit ethernet links to the AP and two IP addresses,
so that we can distribute the wireless load onto two gigabit links.

> If you can share the AP model, just possibly we have one and could do a similar
> test....

:)

I think it's a RT-AX88U. Not sure that really makes a difference.

Seems this AP has a bug btw, it's advertising packet extension of 16usec
for 20 and 40 MHz, but not for 80 and 160 MHz, which seems a bit odd,
and indeed we miss ACK there sometimes. To exclude that as a reason I
hacked the driver to always do 16us ignoring the AP information. But I
think the issues I outlined with the TXQs are the primary reason for
even sending single frames where this would matter ... rather than only
A-MPDUs.

So I don't *think* it's really related to that, but others are looking
at that part (or well, I hope they will be on Sunday, given they're in
Israel).

In the meantime, I'm stuck trying to figure out why we run the TXQs
empty :)

johannes

