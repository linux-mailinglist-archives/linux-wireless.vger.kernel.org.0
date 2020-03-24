Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6451E191BE8
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 22:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgCXV0V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 17:26:21 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:56734 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgCXV0V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 17:26:21 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jGr3y-006JZq-LR; Tue, 24 Mar 2020 22:26:18 +0100
Message-ID: <3bd9fa47c45cd983334ccae06b75501f161ed45c.camel@sipsolutions.net>
Subject: Re: wmediumd MAC implementation/simulation
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bob Copeland <me@bobcopeland.com>
Cc:     linux-wireless@vger.kernel.org,
        Masashi Honma <masashi.honma@gmail.com>
Date:   Tue, 24 Mar 2020 22:26:16 +0100
In-Reply-To: <20200324145344.GA17278@bobcopeland.com> (sfid-20200324_155347_092664_62837DB4)
References: <30484acdee4cd19078673f4f4229dfae49b17804.camel@sipsolutions.net>
         <20200324145344.GA17278@bobcopeland.com>
         (sfid-20200324_155347_092664_62837DB4)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-03-24 at 10:53 -0400, Bob Copeland wrote:
> On Mon, Mar 23, 2020 at 02:56:46PM +0100, Johannes Berg wrote:
> > I wonder if this should be split, implementing a "real" MAC for hwsim,
> > and then sending also the ACKs "properly", perhaps implementing RTS/CTS
> > behaviour in the MAC, etc.?
> 
> The reason I did it this way was to go more for rough approximation rather
> than fidelity to get whatever simplifications that allows.  For example,
> loop really only considers a single frame at a time (and all of its rateset)
> rather than all the possible stations that could be sending at a given time
> step.  That is good enough for comparing rate controllers, and doing some
> mesh testing with a few one-off hacks bolted on top, but nowhere near
> complete.

Right, sure. I don't really object to this - but I realized it really
doesn't fit my model when I tried to integrate our firmware into it :)

And then I was left wondering if I really should even try ...

> That said, splitting them apart and having more realistic mac layer sounds
> reasonable -- how do you anticipate it looking?

Well, it depends how deep we go, I guess? I mean, we could go all the
way down to the PHY layer, but then we're _really_ in ns3 territory and
it's probably not worth it... OTOH, to fully integrate the firmware, we
probably do need this eventually. But I'd rather not reinvent ns3 here,
obviously :)

I've been trying to come up with some kind of hybrid model, where
perhaps we simulate the bare minimum for hwsim, and provide some kind of
"mostly the transport" bits for integrating other things. Though I may
still decide that even that is overkill, and right now I don't even care
about the timing accuracy at all, I just want something to work first.

What I anticipate this looking like is kinda hard to say, and we'd need
significantly more API between hwsim and its MAC too, because even to
simulate the ACK accurately we'd need to know the basic/mandatory rate
bitmap - right now the code just does

        int ack_time_usec = pkt_duration(14, index_to_rate(0, frame->freq)) +
                            sifs;

but this is incorrect ... so arguably we need that *anyway*?

I guess I'd start with actually subjecting the ACK to "channel
conditions", but I'd actually want to be able to hook into the TX/RX in
some way from the external MAC too ... I just don't think we need to
treat hwsim as an external MAC because that just complicates the whole
thing?

Well, honestly, I have no idea :)


> > Or perhaps then that's too much complexity and I should just teach ns3
> > the hwsim virtio interface?
> 
> Up to you :)

:)

johannes

