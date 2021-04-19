Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5E236408C
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Apr 2021 13:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbhDSL2j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Apr 2021 07:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbhDSL2h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Apr 2021 07:28:37 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76495C06174A
        for <linux-wireless@vger.kernel.org>; Mon, 19 Apr 2021 04:28:07 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lYS4T-00DkYh-Nx; Mon, 19 Apr 2021 13:28:05 +0200
Message-ID: <9ce462d7c0dc707259d8bb50ec27a189ec89ef61.camel@sipsolutions.net>
Subject: Re: [PATCH v9 2/4] mac80211: add multiple bssid support to
 interface handling
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Date:   Mon, 19 Apr 2021 13:28:04 +0200
In-Reply-To: <494efc64a803693324dee5b7a03cfda0@codeaurora.org>
References: <20210310182604.8858-1-alokad@codeaurora.org>
         <20210310182604.8858-3-alokad@codeaurora.org>
         (sfid-20210310_192729_241525_2DF37B20) <7f6f0a8c151746e8bb44ad50daf75259a0fac829.camel@sipsolutions.net>
         <494efc64a803693324dee5b7a03cfda0@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> > > +	if (sdata && sdata->vif.type == NL80211_IFTYPE_AP) {
> > > +		if (sdata->vif.multiple_bssid.flags & 
> > > IEEE80211_VIF_MBSS_TRANSMITTING) {
> > > +			struct ieee80211_sub_if_data *child;
> > > +
> > > +			rcu_read_lock();
> > > +			list_for_each_entry_rcu(child, &sdata->local->interfaces, list)
> > > +				if (child->vif.multiple_bssid.parent == &sdata->vif)
> > > +					dev_close(child->wdev.netdev);
> > > +			rcu_read_unlock();

> This was added for graceful shutdown of non-transmitting interfaces 
> whenever the transmitting one is being brought down. 
> 

I know, I asked you to.

> But I see that 
> dev_close() is happening twice now.
> 

That wouldn't be an issue.

The issue is that dev_close() needs to be able to sleep, and it even
contains a might_sleep(), so you can't do it under the RCU protection
you used here.

> Inclining towards removing this and just return error to application if 
> it tries to remove transmitting before all non-transmitting are deleted.
> However, currently the "parent" pointer to indicate the transmitting 
> interface is maintained in mac80211, nothing in cfg80211.

That seems kinda awkward, considering e.g. if hostapd crashes and then a
new instance has to clean up, it might not really have much knowledge of
the order in which it should be doing that.

I think it's better if you just fix the locking here?

johannes

