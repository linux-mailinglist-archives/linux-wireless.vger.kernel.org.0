Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9EAF4584
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 12:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbfKHLR0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 06:17:26 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:56026 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbfKHLR0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 06:17:26 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iT2Ga-0000cW-Cz; Fri, 08 Nov 2019 12:17:24 +0100
Message-ID: <300bf0146db6c0d5890699b3911d35174d28c9c0.camel@sipsolutions.net>
Subject: Re: [PATCH v6 3/4] mac80211: Implement Airtime-based Queue Limit
 (AQL)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Date:   Fri, 08 Nov 2019 12:17:22 +0100
In-Reply-To: <874kzefwt3.fsf@toke.dk>
References: <157182473951.150713.7978051149956899705.stgit@toke.dk>
         <157182474287.150713.12867638269538730397.stgit@toke.dk>
         <1a2eb096119c9029e67caf797564d6511c8803a7.camel@sipsolutions.net>
         <87a796fxgd.fsf@toke.dk>
         <f395a9a971ca1a0d0438fca10dfb160c421caa7a.camel@sipsolutions.net>
         <874kzefwt3.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-11-08 at 12:10 +0100, Toke Høiland-Jørgensen wrote:

> Right, bugger. I was thinking maybe there's a case where skbs can be
> cloned (and retain the tx_time_est field) and then released twice? 

They could be cloned, but I don't see how that'd be while *inside* the
stack and then they get reported twice - unless the driver did something
like that?

I mean, TCP surely does that for example, but it's before we even get to
mac80211.

> Or
> maybe somewhere that steps on the skb->cb field in some other way?
> Couldn't find anything obvious on a first perusal of the TX path code,
> but maybe you could think of something?

No, sorry. But I also didn't actually look at the driver at all.

> Otherwise I guess we'll be forced to go and do some actual,
> old-fashioned debugging ;)

:)

johannes

