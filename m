Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADDD36540A
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Apr 2021 10:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhDTI0F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Apr 2021 04:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhDTI0E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Apr 2021 04:26:04 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E30C06174A
        for <linux-wireless@vger.kernel.org>; Tue, 20 Apr 2021 01:25:33 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lYlhK-00EBzy-L8; Tue, 20 Apr 2021 10:25:30 +0200
Message-ID: <8f68ffae49cebca084658b810add0e6020002838.camel@sipsolutions.net>
Subject: Re: [PATCH v9 2/4] mac80211: add multiple bssid support to
 interface handling
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Date:   Tue, 20 Apr 2021 10:25:29 +0200
In-Reply-To: <865a59c2dd3a07c4ee88716f51759e88@codeaurora.org>
References: <20210310182604.8858-1-alokad@codeaurora.org>
         <20210310182604.8858-3-alokad@codeaurora.org>
         (sfid-20210310_192729_241525_2DF37B20) <7f6f0a8c151746e8bb44ad50daf75259a0fac829.camel@sipsolutions.net>
         <494efc64a803693324dee5b7a03cfda0@codeaurora.org>
         <9ce462d7c0dc707259d8bb50ec27a189ec89ef61.camel@sipsolutions.net>
         <865a59c2dd3a07c4ee88716f51759e88@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Aloka,
> 
> Is rcu_read_lock is not allowed around dev_close() because it might 
> block or *ANY* lock?

Well, I guess it's more nuanced than that.

rcu_read_lock() is not allowed because it enters an atomic context.
Similarly not allowed would be spinlocks, or local_bh_disable, or any
similar thing that makes the context atomic.

From a locking perspective, normal mutexes *would* be allowed.

However, you'd have to be extremely careful to not allow recursion,
since dev_close() will call back into cfg80211/mac80211.

> Because both functions with new dev_close() themselves are called with 
> locks held,
> (1) ieee80211_do_stop() happens inside 
> wiphy_lock(sdata->local->hw.wiphy)

This is probably already problematic.

> (2) ieee80211_del_iface() happens inside mutex_lock(&rdev->wiphy.mtx).

As you discovered, that's the same lock.

> Should these be unlocked temporarily too before calling dev_close()?

I don't think temporarily dropping locks is ever a good idea, it makes
it really hard to reason about the code.

But we already do this for AP-VLAN interfaces, so not sure why this is
so different?
> 
> Also, in cfg.c, list_for_each_entry(sdata, &local->interfaces, list) is 
> called with two different murexes: (1) local->iflist_mtx
> (2) local->mtx


> 
> Which is the correct one for this purpose among above two and 
> rcu_read_lock()?
> Once that decided, would following be sufficient -
>      lock()
>      list_for_each_entry(sdata, &local->interfaces, list) {
>          get_child_pointer
>          unlock()
>          dev_close()

What guarantees you don't lose the device after the unlock()? I think
you'd risk list corruption here this way...

Look at the other instance of dev_close() here - as long as you can
guarantee there won't be recursion (and you do, because non-transmitting
interfaces don't have other non-transmitting below them, though they may
actually have AP-VLANs!), we should be fine just doing it like that
code?

johannes


