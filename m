Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8854633A9
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 12:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbhK3MAo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 07:00:44 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50004 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241490AbhK3MAc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 07:00:32 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1ms1kx-0013ab-Jx; Tue, 30 Nov 2021 13:57:08 +0200
Message-ID: <a8b6dd0a49309eae96cf822c6e587adc05d14b7b.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 30 Nov 2021 13:57:06 +0200
In-Reply-To: <41b83b76a37c51585fbe53cb03f9cf3ddc395e2c.camel@sipsolutions.net>
References: <20211129133248.83829-1-luca@coelho.fi>
         <iwlwifi.20211129152938.d5fceeb7e166.I555fef8e67d93fff3d9a304886c4a9f8b322e591@changeid>
         <8735nf9ieg.fsf@toke.dk>
         <e947923fbeefd81d3b24acf009212d61864fac2c.camel@coelho.fi>
         <87ilw998vk.fsf@toke.dk>
         <41b83b76a37c51585fbe53cb03f9cf3ddc395e2c.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH 15/16] mac80211: agg-tx: don't schedule_and_wake_txq()
 under sta->lock
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-11-30 at 12:52 +0100, Johannes Berg wrote:
> On Tue, 2021-11-30 at 12:32 +0100, Toke Høiland-Jørgensen wrote:
> > Luca Coelho <luca@coelho.fi> writes:
> > 
> > > On Mon, 2021-11-29 at 14:54 +0100, Toke Høiland-Jørgensen wrote:
> > > > Luca Coelho <luca@coelho.fi> writes:
> > > > 
> > > > > From: Johannes Berg <johannes.berg@intel.com>
> > > > > 
> > > > > When we call ieee80211_agg_start_txq(), that will in turn call
> > > > > schedule_and_wake_txq(). Called from ieee80211_stop_tx_ba_cb()
> > > > > this is done under sta->lock, which leads to certain circular
> > > > > lock dependencies, as reported by Chris Murphy:
> > > > > https://lore.kernel.org/r/CAJCQCtSXJ5qA4bqSPY=oLRMbv-irihVvP7A2uGutEbXQVkoNaw@mail.gmail.com
> > > > > 
> > > > > In general, ieee80211_agg_start_txq() is usually not called
> > > > > with sta->lock held, only in this one place. But it's always
> > > > > called with sta->ampdu_mlme.mtx held, and that's therefore
> > > > > clearly sufficient.
> > > > > 
> > > > > Change ieee80211_stop_tx_ba_cb() to also call it without the
> > > > > sta->lock held, by factoring it out of ieee80211_remove_tid_tx()
> > > > > (which is only called in this one place).
> > > > > 
> > > > > This breaks the locking chain and makes it less likely that
> > > > > we'll have similar locking chain problems in the future.
> > > > > 
> > > > > Reported-by: Chris Murphy <lists@colorremedies.com>
> > > > > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > > > > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> > > > 
> > > > Does this need a fixes: tag?
> > > 
> > > Hi Toke,
> > > 
> > > Neither Johannes nor Chris pointed to any specific patch that this
> > > commit is fixing.  If you know the exact commit that broke this, I can
> > > add the tag and send v2.
> > 
> > Well, it looks like the code you're changing comes all the way back from:
> > ba8c3d6f16a1 ("mac80211: add an intermediate software queue implementation")
> > 
> > Maybe Johannes can comment on whether it's appropriate to include this,
> > or if the code changed too much in the meantime...
> > 
> 
> I think that probably makes sense, and I guess I can include that tag
> when I apply it.
> 
> I suspect the reason I didn't do it internally (we have a different tag
> though, so that's no excuse) is that there we didn't care until iwlwifi
> actually gained TXQ support.

Thanks, guys!

Johannes, do you want me to send v2 or do you want to add the tag
yourself? There is one more patch that is broken (ugh, sorry) that I
need to fix anyway...

--
Cheers,
Luca.
