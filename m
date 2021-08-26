Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C653F85F9
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 12:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241634AbhHZLAC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 07:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbhHZLAB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 07:00:01 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F6BC061757
        for <linux-wireless@vger.kernel.org>; Thu, 26 Aug 2021 03:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=gDiGKjEUkKRAhz5HdTK51/IAOIhHO1MVRogdEKMpohQ=;
        t=1629975554; x=1631185154; b=fXridZ37kkzpjiOm4vEIiJ9kWg8B6RyVB9olaUoP3NzsFjC
        7QFEPVoyI3wJaoOA9T4B3ZmVv1afErjnXkuWXfguPCmg/26r1iN8DLNEi9MZf22vejPOd75wPn6OM
        MCVyHkp4NP93P2lIeoUYAGsojO3YHQgxYLYJxsTSvIvuNAEIFbY0pMY1oWGQSBZIe5kUCR1FguE/Z
        PtZ6AHafXty12LkrwveNSuJtjQ5+5vTlQGDg4eOKBESdKZa8U+8vo+CPsz1WcwURCjZf2NYSiVo/J
        KMfOFdWlTetY8sA1saSM1TDjdt6oGA+2awMjW+hmYODA6HtRCeHo+XIfUzRNj/JQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mJD6E-00G7PG-3A; Thu, 26 Aug 2021 12:59:10 +0200
Message-ID: <7e07a64f33bc1a1ca09e36d6152628478a622b69.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/8] cfg80211: add power type definition for 6 GHz
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Date:   Thu, 26 Aug 2021 12:59:09 +0200
In-Reply-To: <e6006814059d085a1f57af24b9561dde@codeaurora.org>
References: <20210820122041.12157-1-wgong@codeaurora.org>
         <20210820122041.12157-2-wgong@codeaurora.org>
         <b6ba152ce1efde5863cae53a94728e8472ba53c0.camel@sipsolutions.net>
         <e6006814059d085a1f57af24b9561dde@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-08-26 at 18:57 +0800, Wen Gong wrote:
> On 2021-08-26 16:20, Johannes Berg wrote:
> > >  struct cfg80211_chan_def {
> > >  	struct ieee80211_channel *chan;
> > > @@ -684,6 +685,7 @@ struct cfg80211_chan_def {
> > >  	u32 center_freq2;
> > >  	struct ieee80211_edmg edmg;
> > >  	u16 freq1_offset;
> > > +	enum nl80211_ap_reg_power power_type;
> > 
> > I'm not sure why this should be in the chandef, there's no way that
> > anything in cfg80211 is ever using it there, at least in your patches.
> > 
> It is used in mac80211 of [PATCH v2 3/8] mac80211: add parse regulatory 
> info in 6 GHz operation information.
> should i move it to mac80211's .h file?
> > > +/**
> > > + * enum nl80211_ap_reg_power - regulatory power for a Access Point
[...]
> > 
> It is used in mac80211 of [PATCH v2 3/8] mac80211: add parse regulatory 
> info in 6 GHz operation information.
> should i move it to mac80211's .h file?

Yeah I saw both of them are used, but why are they defined as nl80211
API? Do you have any intention to set them through nl80211?

And like I said, I'm not really convinced this belongs into struct
cfg80211_chan_def either. Maybe it should be in bss_conf too?

johannes
> 

