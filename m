Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03881463362
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 12:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhK3Lzg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 06:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhK3Lze (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 06:55:34 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FD1C061574
        for <linux-wireless@vger.kernel.org>; Tue, 30 Nov 2021 03:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=UbLgAx5QbK1ynRguQTETCb85qKit7+9d2mmsD010F5Y=;
        t=1638273135; x=1639482735; b=lK7DTB1VcsOWFzFregeNpQ6bWzVwCECKGtrDWV3ePq0JRX3
        6M0Mi3vX4s44yhVRq4XZIuZpfdQbym7PSqWntPrg4nwEzCs7i+rySoah3qlTsi1tmVrFJDsFJeIRf
        z+GEe8iLWP64A5c045lAI2yx+9g3bGMd3IJilH5dlLu0ZI/a8tj2CQ9Gnkp8/Z2NEgAzEJNkfX+Hg
        2nVBP0T7RFVCWhopeMSf+sXoGn1l3BXEEOWazgY49wqCtFieU20xvQZddreIORKYXGpTw84+oPkL2
        RhFtqsgd551nzO++prqsSp/GL8lHea4HOzKThnyiGdxFrf9U7MJaVCnFRl9EQTuw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ms1g6-004tlR-Ug;
        Tue, 30 Nov 2021 12:52:07 +0100
Message-ID: <41b83b76a37c51585fbe53cb03f9cf3ddc395e2c.camel@sipsolutions.net>
Subject: Re: [PATCH 15/16] mac80211: agg-tx: don't schedule_and_wake_txq()
 under sta->lock
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Luca Coelho <luca@coelho.fi>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 30 Nov 2021 12:52:06 +0100
In-Reply-To: <87ilw998vk.fsf@toke.dk>
References: <20211129133248.83829-1-luca@coelho.fi>
         <iwlwifi.20211129152938.d5fceeb7e166.I555fef8e67d93fff3d9a304886c4a9f8b322e591@changeid>
         <8735nf9ieg.fsf@toke.dk>
         <e947923fbeefd81d3b24acf009212d61864fac2c.camel@coelho.fi>
         <87ilw998vk.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-11-30 at 12:32 +0100, Toke Høiland-Jørgensen wrote:
> Luca Coelho <luca@coelho.fi> writes:
> 
> > On Mon, 2021-11-29 at 14:54 +0100, Toke Høiland-Jørgensen wrote:
> > > Luca Coelho <luca@coelho.fi> writes:
> > > 
> > > > From: Johannes Berg <johannes.berg@intel.com>
> > > > 
> > > > When we call ieee80211_agg_start_txq(), that will in turn call
> > > > schedule_and_wake_txq(). Called from ieee80211_stop_tx_ba_cb()
> > > > this is done under sta->lock, which leads to certain circular
> > > > lock dependencies, as reported by Chris Murphy:
> > > > https://lore.kernel.org/r/CAJCQCtSXJ5qA4bqSPY=oLRMbv-irihVvP7A2uGutEbXQVkoNaw@mail.gmail.com
> > > > 
> > > > In general, ieee80211_agg_start_txq() is usually not called
> > > > with sta->lock held, only in this one place. But it's always
> > > > called with sta->ampdu_mlme.mtx held, and that's therefore
> > > > clearly sufficient.
> > > > 
> > > > Change ieee80211_stop_tx_ba_cb() to also call it without the
> > > > sta->lock held, by factoring it out of ieee80211_remove_tid_tx()
> > > > (which is only called in this one place).
> > > > 
> > > > This breaks the locking chain and makes it less likely that
> > > > we'll have similar locking chain problems in the future.
> > > > 
> > > > Reported-by: Chris Murphy <lists@colorremedies.com>
> > > > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> > > > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> > > 
> > > Does this need a fixes: tag?
> > 
> > Hi Toke,
> > 
> > Neither Johannes nor Chris pointed to any specific patch that this
> > commit is fixing.  If you know the exact commit that broke this, I can
> > add the tag and send v2.
> 
> Well, it looks like the code you're changing comes all the way back from:
> ba8c3d6f16a1 ("mac80211: add an intermediate software queue implementation")
> 
> Maybe Johannes can comment on whether it's appropriate to include this,
> or if the code changed too much in the meantime...
> 

I think that probably makes sense, and I guess I can include that tag
when I apply it.

I suspect the reason I didn't do it internally (we have a different tag
though, so that's no excuse) is that there we didn't care until iwlwifi
actually gained TXQ support.

johannes
