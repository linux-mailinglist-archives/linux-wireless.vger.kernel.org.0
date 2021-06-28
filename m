Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EAA3B68F5
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Jun 2021 21:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbhF1TUJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Jun 2021 15:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbhF1TUJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Jun 2021 15:20:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E46C061574
        for <linux-wireless@vger.kernel.org>; Mon, 28 Jun 2021 12:17:42 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lxwlI-00D0zx-21; Mon, 28 Jun 2021 21:17:40 +0200
Message-ID: <d21f4ecd99f46cbc2b0229309a4627c2a338b87b.camel@sipsolutions.net>
Subject: Re: [PATCH v10 2/4] mac80211: multiple bssid support in interface
 handling
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Date:   Mon, 28 Jun 2021 21:17:39 +0200
In-Reply-To: <9451f0db49f603d7e9a00d172ab341e2@codeaurora.org>
References: <20210426190534.12667-1-alokad@codeaurora.org>
         <20210426190534.12667-3-alokad@codeaurora.org>
         <6dc09b7dcfef37a703e95e264e6ab64738560160.camel@sipsolutions.net>
         <9451f0db49f603d7e9a00d172ab341e2@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Aloka,

> > >  static int ieee80211_del_iface(struct wiphy *wiphy, struct 
> > > wireless_dev *wdev)
> > >  {
> > > +	struct ieee80211_sub_if_data *sdata = 
> > > IEEE80211_WDEV_TO_SUB_IF(wdev);
> > > +	struct ieee80211_local *local;
> > > +	struct ieee80211_vif *vif;
> > > +
> > > +	if (!sdata)
> > > +		return 0;
> > > +
> > > +	local = sdata->local;
> > > +	vif = &sdata->vif;
> > > +	if (vif->type == NL80211_IFTYPE_AP &&
> > > +	    ieee80211_hw_check(&local->hw, SUPPORTS_MBSSID_AP)) {
> > > +		if (vif->mbssid.flags & IEEE80211_VIF_MBSSID_TX) {
> > > +			struct ieee80211_sub_if_data *child, *tmpsdata;
> > > +
> > > +			wiphy_unlock(local->hw.wiphy);
> > > +			mutex_lock(&local->iflist_mtx);
> > 
> > I really don't think you can drop the locking like that in the middle 
> > of something. That's almost always a recipe for disaster.

[...]

> 
> I'm not able to come up with a different solution which does not cause a 
> deadlock by continuing to hold wiphy_lock() as we discussed last time 
> that dev_close() will in turn call into cfg80211.
> 
> You had suggested looking at dev_close() for VLAN, that code also 
> doesn't lock wiphy_lock hence I did same here but locked 
> 'local->iflist_mtx'. Dropping both won't be good for sure.
> 
> Can you please suggest a better way? I'm really not able to come up with 
> one.

Yeah, it's a tricky one for sure, especially with the locking changes.

Now that I look at this more closely - the code in ieee80211_del_iface()
must be redundant since the interface has to go through
ieee80211_do_stop() (perhaps during this) if it's actually up?


However, I'm hnsure why you don't understand the VLAN code - see what I
did in commit d5befb224edb ("mac80211: fix deadlock in AP/VLAN
handling")?

johannes

