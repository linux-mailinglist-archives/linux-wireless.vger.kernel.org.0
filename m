Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9494445B73
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 13:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfFNLb3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 07:31:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37852 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbfFNLb3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 07:31:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD4B530B97AA;
        Fri, 14 Jun 2019 11:31:28 +0000 (UTC)
Received: from localhost (ovpn-204-80.brq.redhat.com [10.40.204.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24C8054696;
        Fri, 14 Jun 2019 11:31:25 +0000 (UTC)
Date:   Fri, 14 Jun 2019 13:31:25 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, nbd@nbd.name
Subject: Re: [PATCH v3 wireless-drivers 1/3] mt76: usb: fix rx A-MSDU support
Message-ID: <20190614113120.GC17298@redhat.com>
References: <cover.1560461404.git.lorenzo@kernel.org>
 <66fc02e45fb5ce0d6176395b5ac43acbd53b3e66.1560461404.git.lorenzo@kernel.org>
 <20190614072449.GA3395@redhat.com>
 <20190614101115.GA2669@localhost.localdomain>
 <a50de3e52ece8a636ae902b1a5b901d0d3cd068f.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a50de3e52ece8a636ae902b1a5b901d0d3cd068f.camel@sipsolutions.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 14 Jun 2019 11:31:28 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jun 14, 2019 at 12:20:59PM +0200, Johannes Berg wrote:
> On Fri, 2019-06-14 at 12:11 +0200, Lorenzo Bianconi wrote:
> 
> > Looking at __ieee80211_amsdu_copy() now I got why other drivers copy hdrlen +
> > 8, thx :)
> > In our case reuse_frag is true in __ieee80211_amsdu_copy, so we will end up
> > copying 32B + ether_len. Anyway I think 32 is a little bit too low and we could get
> > better performances increasing it a little bit.
> > A typical use case (e.g IPv6 + TCP):
> > 
> > IPv6 = 40B, TCP = 32B --> so 72B..I guess 128B is a good value :)
> > @Felix, Johannes: what do you think?
> 
> I think while we might *allocate* more, I don't think we should *copy*
> more, since then the TCP payload will no longer be in pages.
> 
> It'd probably be better to implement leaving enough tailroom (allocate
> 128), but copying nothing, unless the *entire* packet fits.

iwl4965 put entire packet in fragment in il4965_pass_packet_to_mac80211() .
Initially I thought this is a bug, since mac80211 require header be
in the linear area, but looks like ieee80211_rx_monitor() copy header
before rest of mac80211 check it, so 4965 is fine.

Anyway I think the driver should put ieee80211 header in linear area
and iwlwifi & mt7601u implementation is somewhat optimal.

Stanislaw
