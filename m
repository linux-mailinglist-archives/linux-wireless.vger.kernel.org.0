Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 170C9CECB6
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2019 21:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfJGTXz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Oct 2019 15:23:55 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:45018 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfJGTXy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Oct 2019 15:23:54 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iHYbm-0007aT-Vs; Mon, 07 Oct 2019 21:23:51 +0200
Message-ID: <aa40e945adfbeb52890afb2de493142e82ecf69d.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] mac80211: Implement Airtime-based Queue Limit (AQL)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Kan Yan <kyan@google.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, Felix Fietkau <nbd@nbd.name>,
        Yibo Zhao <yiboz@codeaurora.org>
Date:   Mon, 07 Oct 2019 21:23:49 +0200
In-Reply-To: <87pnj9n55y.fsf@toke.dk>
References: <20191004062151.131405-1-kyan@google.com>
         <20191004062151.131405-2-kyan@google.com> <87imp4o6qp.fsf@toke.dk>
         <CA+iem5vJFRxskyHOKf5K73X8aGH965P4hoiCj-wQtK-Z-47pdg@mail.gmail.com>
         <87pnj9n55y.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2019-10-06 at 19:40 +0200, Toke Høiland-Jørgensen wrote:

> > That's a good point.  I haven't thought about real simultaneous dual
> > band chipset and such chipset do exists now. Is RSDB support coming to
> > mac80211 soon? Just curious if it will be just virtual interfaces or
> > something else. I chose "local" instead of "sdata" thinking about the
> > case of several virtual interfaces (AP, STA, MESH) operates in the
> > same channel, then the interface total could be a better choice.
> > 
> > I am ok with moving the "aql_total_pending_airtime" into sdata, but
> > afraid that's not the most optimal choice for the case of multiple
> > virtual interfaces operates in the same channel.
> > Maybe we could leave it in "local" for now. What do you think?
> 
> I'd lean towards keeping it in 'local' for consistency with all the
> other airtime stuff. For now, I think having multiple SSIDs on the same
> radio is more common than the reverse (multiple bands on a single
> radio).
> 
> In particular, the per-group airtime fairness stuff is definitely
> designed on the assumption that all BSSes share the same band.

s/band/channel/, presumably.

> So if and when we start supporting true multi-band devices we'll have to
> change these things anyway. So might as well keep everything together so
> it all gets fixed :)

I guess I'm OK with that, but I'm pretty sure this will come up sooner
rather than later ...

What else is there though?

johannes

