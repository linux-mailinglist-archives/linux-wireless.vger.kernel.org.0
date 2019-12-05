Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00BF811467E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2019 19:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbfLESEQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Dec 2019 13:04:16 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:59212 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbfLESEQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Dec 2019 13:04:16 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1icvU4-004Lo4-5v; Thu, 05 Dec 2019 19:04:12 +0100
Message-ID: <e600f75741bd4c766bf043b0a404286f0ea22349.camel@sipsolutions.net>
Subject: Re: debugging TXQs being empty
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 05 Dec 2019 19:04:10 +0100
In-Reply-To: <64a6ae15-b7be-8c27-4e60-4cb3d253f3dc@candelatech.com>
References: <bbc516f28782175b27ac5e19dcdeac13cd6ee76a.camel@sipsolutions.net>
         <49288397-55b3-f49a-e277-5197d7c1bea3@candelatech.com>
         <2e01fb1d5b8ff3335220231251f893c01c6c22d3.camel@sipsolutions.net>
         <64a6ae15-b7be-8c27-4e60-4cb3d253f3dc@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-12-05 at 08:57 -0800, Ben Greear wrote:
> On 12/5/19 8:49 AM, Johannes Berg wrote:
> > On Thu, 2019-12-05 at 08:37 -0800, Ben Greear wrote:
> > 
> > > > All this seems to mean that the TCP stack isn't feeding us fast enough,
> > > > but is that really possible?
> > > 
> > > Does UDP work better?
> > 
> > Somewhat, I get about 1020-1030 Mbps. But still a TON of "TXQ of STA ...
> > is now empty" messages. Say this run got about 15 per second of those.
> 
> It would seem that it is not some issue with TCP stack then?

Hmm, yeah, maybe not then. Something more general in the stack? I just
can't think of anything.

> In general, UDP uses more CPU to send from user-space than TCP
> because of TSO, etc.  Sendmmsg can help a bit, but it is a bit painful
> to code against so things like iperf do not use it, at least ones I've
> looked at.

True.

> Can you provide some details on how you are generating this load?

Using chariot. I don't really know it well, just the testers use it.

> For what it's worth, we've seen about 1.9Gbps download goodput
> when using ax200 as a station receiving traffic from 160Mhz AP.
> I don't have any reports of > 1Gbps of upload performance though,
> not sure our user with the fast AP has done much upload testing...

:)

> > > or pktgen?
> > 
> > I haven't really tried, the setup is a bit complicated ... and it's
> > nowhere near me either :)
> 
> Yeah, it will likely crash your system unless you apply years-old patches I posted
> too :)
> 
> But, at least with pktgen, you can be quite sure it is not some slowdown farther up
> the stack that is causing the problem.

True.

johannes

