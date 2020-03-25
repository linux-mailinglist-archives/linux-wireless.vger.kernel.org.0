Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFDCF1922E0
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 09:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgCYIgl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 04:36:41 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:41892 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgCYIgl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 04:36:41 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jH1Wg-007ht6-Ca; Wed, 25 Mar 2020 09:36:38 +0100
Message-ID: <9d314aa41f9bb094e72791187cadd945dbdfd557.camel@sipsolutions.net>
Subject: Re: wmediumd MAC implementation/simulation
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>,
        Bob Copeland <me@bobcopeland.com>
Cc:     linux-wireless@vger.kernel.org,
        Masashi Honma <masashi.honma@gmail.com>
Date:   Wed, 25 Mar 2020 09:36:36 +0100
In-Reply-To: <12ddd641-1d54-7626-d177-cc2d12c2998e@uni-rostock.de>
References: <30484acdee4cd19078673f4f4229dfae49b17804.camel@sipsolutions.net>
         <20200324145344.GA17278@bobcopeland.com>
         <3bd9fa47c45cd983334ccae06b75501f161ed45c.camel@sipsolutions.net>
         <12ddd641-1d54-7626-d177-cc2d12c2998e@uni-rostock.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> > Well, it depends how deep we go, I guess? I mean, we could go all the
> > way down to the PHY layer, but then we're _really_ in ns3 territory and
> > it's probably not worth it... OTOH, to fully integrate the firmware, we
> > probably do need this eventually. But I'd rather not reinvent ns3 here,
> > obviously :)

> I think it's not the phy but the lower MAC layer, which at least need to
> be adapted to the hwsim interface. Although it has no extreme
> computational effort, its not that easy to implement. Depending on your
> envisioned setup this might already be done in your firmware. 

Yeah, I think so.

> Thy phy
> layer will bring much higher timing precision, when the right models are
> applied, but will greatly impact the simulation speed.

Right. No good for this, I think.

And anyway then we're looking at ns-3 I guess. Though I couldn't figure
out yesterday how we could possibly integrate all this simulation setup
into ns-3.

> >         int ack_time_usec = pkt_duration(14, index_to_rate(0, frame->freq)) +
> >                             sifs;
> > 
> > but this is incorrect ... so arguably we need that *anyway*?
> 
> Actually you are right. Currently, we apply this by a priori knowledge.
> Maybe a silly Idea, but could we interleave the cfg80211/nl80211
> protocol on the virtio channel to get the configuration information?

It'd really have to be the *mac80211* protocol, which is based only on
function calls etc. so we have to build a messaging layer around it ...
which basically is mac80211-hwsim, right?


> > I guess I'd start with actually subjecting the ACK to "channel
> > conditions", but I'd actually want to be able to hook into the TX/RX in
> > some way from the external MAC too ... I just don't think we need to
> > treat hwsim as an external MAC because that just complicates the whole
> > thing?
> > 
> > Well, honestly, I have no idea :)
> 
> Mhh I don't really get what you mean by that. Why can't you hook into
> RX/TX with a simulated ACK ?

I guess I could, but then I have to worry about all kinds of MAC
capabilities? I mean, essentially I'd end up building a MAC for hwsim,
in some integrated fashion, which seems like it probably should've been
done in ns-3 already or such?

> > > > Or perhaps then that's too much complexity and I should just teach ns3
> > > > the hwsim virtio interface?
> > > Up to you :)
> 
> It should be definitely possible. But I'm asking my self how good that
> interacts with your firmware simulation.

Well, ns-3 *is* layered, no? Arguably then I should be able to remove
the MAC layer and put in my own, hooking into the PHY layer signals? But
I quickly got lost in the documentation there, and it's not really what
I need right now anyway ...

johannes

