Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1ADF51A165
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 15:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350874AbiEDN5A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 09:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350867AbiEDN45 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 09:56:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D3E3E5EC
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=el1Ln9MylwBEwB9FcjHpmWXmIYhzujzdSRc7heTE7iY=;
        t=1651672401; x=1652882001; b=capBjai4vkOz7H0UEPe7nINGSsTNdnI0uSp+vYGljaA89x9
        /NPQah3jM2wb0PtEPEJUfXEVHnjuUQ4pmryAx96ltVjWJp694Qi8caiv9MUnLnhv/N6GXSZvlzFAi
        Pu6bm5Xa8uvZOI2Rhq8GKsgifQldYWutdVI4er9gt1eaZK7OyEZvAGpfQGoxSa9oW0PWhguvKh32p
        pctqixzEnso3AXV+QkmOdlph4HQB3QWLxVu/5w05jl1B8R5FT5ua0qGMhtRLx4CcooXCZGZeNR2Eq
        sRZNSHwcZyCihIHtfPu6Bd2b2+7qJYjMjrSydVcvJuEsQPKBOk3mJjSlAfW7Iorw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nmFRO-0023rw-SM;
        Wed, 04 May 2022 15:53:18 +0200
Message-ID: <1001665f4de469761c4f786954912c40d0c88e72.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] mac80211: Allow drivers to report avg chain signal.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 04 May 2022 15:53:17 +0200
In-Reply-To: <d2c03c10-70cf-81a5-f2fa-73ad58b81a92@candelatech.com>
References: <20220225232842.32028-1-greearb@candelatech.com>
         <b11b11c0dab8e4eb527bba7b332287efe0bc2cbc.camel@sipsolutions.net>
         <d2c03c10-70cf-81a5-f2fa-73ad58b81a92@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-05-04 at 06:49 -0700, Ben Greear wrote:
> 
> > > +	/* Check if chain signal is not filled, for cases avg was filled by
> > > +	 * driver bug last chain signal was not.
> > > +	 */
> > > +	if (last_rxstats->chains &&
> > > +		 !(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL)))) {
> > > +		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_CHAIN_SIGNAL);
> > > +
> > > +		sinfo->chains = last_rxstats->chains;
> > > +
> > > +		for (i = 0; i < ARRAY_SIZE(sinfo->chain_signal); i++) {
> > > +			sinfo->chain_signal[i] =
> > > +				last_rxstats->chain_signal_last[i];
> > > +		}
> > > +	}
> > > 
> > 
> > Now you've duplicated this code ... you can remove it above, no?
> 
> The conditional check in this second block is different.  It is one reason
> why I added the other comment in the preceeding code.

Oh, sure, I get that.

But I mean you can end up setting sinfo->chains and all of the values in
sinfo->chain_signal[i] with both cases: when "both are unset" or when
"just chain signal is unset"?

So wouldn't it be more or less equivalent to do

 if (!signal-filled) { fill signal }

which is your new code here, and thus have

 if (!signal-filled) { fill signal }
 if (!signal-avg-filled) { fill avg signal }

rather than

 if (!signal-filled && !signal-avg-filled) {
    fill signal, fill avg-signal
 }
 if (!signal-filled) {
    fill signal
 }

or am I misreading that?

johannes
