Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8275045B86
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 13:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfFNLeg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 07:34:36 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:40476 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfFNLeg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 07:34:36 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hbkTW-0006zw-FG; Fri, 14 Jun 2019 13:34:30 +0200
Message-ID: <2c983ef178ae8164c3cdcedb9833292c7b91a703.camel@sipsolutions.net>
Subject: Re: [PATCH v3 wireless-drivers 1/3] mt76: usb: fix rx A-MSDU support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, nbd@nbd.name
Date:   Fri, 14 Jun 2019 13:34:28 +0200
In-Reply-To: <20190614113120.GC17298@redhat.com>
References: <cover.1560461404.git.lorenzo@kernel.org>
         <66fc02e45fb5ce0d6176395b5ac43acbd53b3e66.1560461404.git.lorenzo@kernel.org>
         <20190614072449.GA3395@redhat.com>
         <20190614101115.GA2669@localhost.localdomain>
         <a50de3e52ece8a636ae902b1a5b901d0d3cd068f.camel@sipsolutions.net>
         <20190614113120.GC17298@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-06-14 at 13:31 +0200, Stanislaw Gruszka wrote:
> On Fri, Jun 14, 2019 at 12:20:59PM +0200, Johannes Berg wrote:
> > On Fri, 2019-06-14 at 12:11 +0200, Lorenzo Bianconi wrote:
> > 
> > > Looking at __ieee80211_amsdu_copy() now I got why other drivers copy hdrlen +
> > > 8, thx :)
> > > In our case reuse_frag is true in __ieee80211_amsdu_copy, so we will end up
> > > copying 32B + ether_len. Anyway I think 32 is a little bit too low and we could get
> > > better performances increasing it a little bit.
> > > A typical use case (e.g IPv6 + TCP):
> > > 
> > > IPv6 = 40B, TCP = 32B --> so 72B..I guess 128B is a good value :)
> > > @Felix, Johannes: what do you think?
> > 
> > I think while we might *allocate* more, I don't think we should *copy*
> > more, since then the TCP payload will no longer be in pages.
> > 
> > It'd probably be better to implement leaving enough tailroom (allocate
> > 128), but copying nothing, unless the *entire* packet fits.
> 
> iwl4965 put entire packet in fragment in il4965_pass_packet_to_mac80211() .
> Initially I thought this is a bug, since mac80211 require header be
> in the linear area, but looks like ieee80211_rx_monitor() copy header
> before rest of mac80211 check it, so 4965 is fine.

Mac80211 should not assume anything about header being present or not,
just like the rest of the network stack.

> Anyway I think the driver should put ieee80211 header in linear area
> and iwlwifi & mt7601u implementation is somewhat optimal.

Yes, it's just an optimisation to do the copy-break (copy small packets
completely) or to copy the header already (since we may have better ways
to do so than skb_copy_bits if we still have a virt pointer to the page,
rather than just the page pointer).

johannes

