Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57A6233ADA
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 23:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbgG3V0f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 17:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730627AbgG3V0e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 17:26:34 -0400
X-Greylist: delayed 268 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Jul 2020 14:26:34 PDT
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4C3C061574;
        Thu, 30 Jul 2020 14:26:34 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k1G4O-00Dkwj-J2; Thu, 30 Jul 2020 23:26:32 +0200
Message-ID: <d1b5dd7d9f93d3fc87c58dcfc28c9a3c6b4c923e.camel@sipsolutions.net>
Subject: Re: [PATCH v4 2/2] mac80211: Add FILS discovery support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Date:   Thu, 30 Jul 2020 23:26:31 +0200
In-Reply-To: <c86a98180879365bab34d8d9eb2f5c3c@codeaurora.org>
References: <20200618050427.5891-1-alokad@codeaurora.org>
         <20200618050427.5891-3-alokad@codeaurora.org>
         <bb2be4ac581487aa9e89d3c75180a1766b112370.camel@sipsolutions.net>
         <c86a98180879365bab34d8d9eb2f5c3c@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-07-30 at 14:00 -0700, Aloka Dixit wrote:

> > > +	fd = &sdata->vif.bss_conf.fils_discovery;
> > > +	fd->min_interval = params->min_interval;
> > > +	fd->max_interval = params->max_interval;
> > > +
> > > +	if (!params->tmpl || !params->tmpl_len) /* Optional template */
> > > +		return 0;
> > 
> > Now I'm even more confused. If the template is optional, then if it's
> > not given it doesn't mean *everything* should be ignored, does it?
> > 
> > What would be the point of that? OTOH, if the template isn't there, 
> > what
> > would you do?
> > 
> > But it still doesn't make sense - if no template means you shouldn't do
> > anything then that doesn't mean the template should be optional, that
> > just means userspace shouldn't even put the NL80211_ATTR_FILS_DISCOVERY
> > attribute when it doesn't want anything to be done?
> > 
> > So it seems to me that something doesn't match. Either the template is
> > truly optional and then this shouldn't just return success, or the
> > template isn't actually optional?
> > 
> 
> Everything is not ignored, I set the minimum and maximum interval values 
> before checking for the template so that those are accepted even if 
> template isn't present.

Right, oops, missed that.

> For 6GHz, template is required, at least for ath11k driver.
> But for 2.4GHz and 5GHz FILS discovery transmission is not offloaded to 
> FW.

But ... now I'm still confused.

If you *don't* offload it, how will it work? Will it all bubble up to
hostapd and that will send the response? Does that work without any
other changes?

But then what would you need the min/max for? I guess I still don't
understand it... I thought this was a periodic frame anyway like beacon,
so how could you _not_ offload it?

> We can make the template mandatory instead and then the respective 
> drivers will choose the handling.
> Please suggest.

I have no idea ... still trying to understand it.

> > > +	err = ieee80211_set_fils_discovery(sdata, &params->fils_discovery);
> > > +	if (err < 0) {
> > > +		ieee80211_vif_release_channel(sdata);
> > > +		return err;
> > 
> > Is there no goto label for this error case?
> > 
> 
> Existing function doesn't use goto labels for error cases, only return.

Maybe add one? Surely the release_channel() must alraedy exist there
somewhere.

> > > +	skb = dev_alloc_skb(tmpl->len);
> > > +	if (skb)
> > > +		skb_put_data(skb, tmpl->data, tmpl->len);
> > 
> > You should consider the headroom that the driver may have requested.
> > 
> 
> I didn't understand this point, what would the driver request headroom 
> for?

Whatever it wants for ... drivers are allowed request extra headroom
(hw->extra_tx_headroom) and we generally honour that for every skb we
build for the driver.

johannes

