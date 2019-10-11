Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A49D5D3A99
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2019 10:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfJKIQf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Oct 2019 04:16:35 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:34194 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfJKIQf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Oct 2019 04:16:35 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iIq68-000582-Kg; Fri, 11 Oct 2019 10:16:29 +0200
Message-ID: <3cbedfe48e796b9d2c28d97c301a08a03b42869c.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/2] mac80211: Implement Airtime-based Queue Limit
 (AQL)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kan Yan <kyan@google.com>,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, Felix Fietkau <nbd@nbd.name>,
        ath10k@lists.infradead.org, Yibo Zhao <yiboz@codeaurora.org>
Date:   Fri, 11 Oct 2019 10:16:27 +0200
In-Reply-To: <CA+iem5u8p7pDZw-QvqU285p7F5AunN3Z4YyS=TjAd9xbKqegnQ@mail.gmail.com> (sfid-20191011_042420_744343_355715ED)
References: <20191010022502.141862-1-kyan@google.com>
         <20191010022502.141862-2-kyan@google.com>
         <a2cc0ebecfb055c8b667db57d0469fe69054a69c.camel@sipsolutions.net>
         <87ftk0jr70.fsf@toke.dk>
         <CA+iem5u8p7pDZw-QvqU285p7F5AunN3Z4YyS=TjAd9xbKqegnQ@mail.gmail.com>
         (sfid-20191011_042420_744343_355715ED)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-10-10 at 19:24 -0700, Kan Yan wrote:

> > > + * ieee80211_txq_aql_check - check if a txq can send frame to device
> > I wonder if this really should even be have "aql" in the name? It's also
> > going to return NULL if there's nothing on the TXQ, for example, right?
> 
> Renamed to  ieee80211_txq_airtime_check()

:)

> This function is not for finding next eligible txq, but return a
> boolean to indicate if a given txq can send more packets to device. It
> is also called from ath10k:
> static bool ath10k_mac_tx_can_push(struct ieee80211_hw *hw,
>                                    struct ieee80211_txq *txq)
> {
>        ...
>         if (!ieee80211_txq_airtime_check(hw, txq))
>                 return false;

Sure, I get that.

I phrased this badly before because I neglected to look at the code of
the function closely.

You were documenting it as

+ * Return true if the AQL's airtime limit has not been reached and the txq can
+ * continue to send more packets to the device. Otherwise return false.

but with the current implementation that's not really true. For example,
if there are no packets on the TXQ at all, then the function still
returns true, even if it's not true that "the txq can continue to send
more packets to the device".

So I guess really what I should ask is if the documentation shouldn't be
rephrased to say something like

	[...] has not been reached and the TXQ is eligible to send
        packets to the device, regardless of whether or not it currently
        can or cannot (e.g. if it has no packets, or is stopped, etc.)

to make it more obvious that this really is *only* concerned about the
airtime aspects.

> > But then again, we don't really care *that* much about overflow or
> > underflow in this code path - it's not going to be security critical.
> > But it seems that your code there actually can cause UB? That would be
> > nice to avoid.
> > Actually, that condition can never be true, right? Wait, ok, this one
> > can because integer promotion?
> 
>  I don't think that condition could happen. The WARN_ONCE() was added
> per your earlier comment. The older version don't have underflow check
> and reset pending_airtime part and I didn't find any issues.

Of course it will never happen with a valid driver :-)

But it seems like a very easy mistake to make - add an estimate, and
later subtract the actual airtime, which may be more ...

> > Except aql_total_pending_airtime is still defined as s32 and that causes
> > different behaviour?
> > All this confuses me ... is it possible to write this more clearly?
> 
> I revised it to something similar to the original version, which
> ieee80211_sta_update_pending_airtime() takes extra parameter to
> indicate whether it is for a tx completion event.
> void ieee80211_sta_update_pending_airtime(struct ieee80211_sta *pubsta, u8 tid,
>                                           u32 tx_airtime, bool tx_completed)
> This help get rid of the problem that airtime need be signed. Also
> added the inline function of
> ieee80211_sta_register/release_pending_airtime() as you suggested.

ok

johannes

