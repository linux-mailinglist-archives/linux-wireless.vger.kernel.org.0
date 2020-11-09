Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846B92AB63D
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Nov 2020 12:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgKILMl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 06:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKILMl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 06:12:41 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF2AC0613CF
        for <linux-wireless@vger.kernel.org>; Mon,  9 Nov 2020 03:12:41 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kc56E-004Hyz-L1; Mon, 09 Nov 2020 12:12:38 +0100
Message-ID: <ef27c87e34c173e015ce41242dab3bdf2d312d8d.camel@sipsolutions.net>
Subject: Re: [PATCH 8/8] cfg80211: remove WDS code
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 09 Nov 2020 12:12:21 +0100
In-Reply-To: <87lffa6azd.fsf@tynnyri.adurom.net>
References: <20201109095747.113720-1-johannes@sipsolutions.net>
         <20201109105103.8f5b98e4068d.I5f5129041649ef2862b69683574bb3344743727b@changeid>
         <87lffa6azd.fsf@tynnyri.adurom.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-11-09 at 13:11 +0200, Kalle Valo wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
> 
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > Remove all the code that was there to configure WDS interfaces,
> > now that there's no way to reach it anymore.
> > 
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
> [...]
> 
> > @@ -675,10 +673,8 @@ int wiphy_register(struct wiphy *wiphy)
> >  		     !(wiphy->nan_supported_bands & BIT(NL80211_BAND_2GHZ)))))
> >  		return -EINVAL;
> >  
> > -#ifndef CONFIG_WIRELESS_WDS
> >  	if (WARN_ON(wiphy->interface_modes & BIT(NL80211_IFTYPE_WDS)))
> >  		return -EINVAL;
> > -#endif
> 
> What about out-of-tree drivers? Should we have (or do we already have?)
> a some kind safe guard if an out of tree driver tries to use WDS?

That's what happens here, no? We warn and return invalid - now
unconditionally, before we allowed it if CONFIG_WIRELESS_WDS was
enabled.

johannes

