Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8710A26D87E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Sep 2020 12:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgIQKKd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Sep 2020 06:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgIQKKX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Sep 2020 06:10:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB13C06174A
        for <linux-wireless@vger.kernel.org>; Thu, 17 Sep 2020 03:10:23 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kIqrs-005VtG-FQ; Thu, 17 Sep 2020 12:10:20 +0200
Message-ID: <0fe215e191e90dfa843151a5ca1a43c2c2775121.camel@sipsolutions.net>
Subject: Re: [PATCH] nl80211: Add support to get BIP failure counters
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jouni Malinen <j@w1.fi>
Cc:     "Vinita S. Maloo" <vmaloo@codeaurora.org>,
        linux-wireless@vger.kernel.org
Date:   Thu, 17 Sep 2020 12:10:19 +0200
In-Reply-To: <20200731152702.GA15382@w1.fi>
References: <1593498381-9337-1-git-send-email-vmaloo@codeaurora.org>
         <20d23075fb3437874a311ac18aa94194118a6e2b.camel@sipsolutions.net>
         <20200731152702.GA15382@w1.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-07-31 at 18:28 +0300, Jouni Malinen wrote:
> On Thu, Jul 30, 2020 at 01:41:04PM +0200, Johannes Berg wrote:
> > On Tue, 2020-06-30 at 11:56 +0530, Vinita S. Maloo wrote:
> > > Add support to get number of MIC errors, missing MME incidents and
> > > packet replay incidents observed while using IGTK/BIGTK keys when
> > > PMF and/or beacon protection features are enabled.
> > 
> > I can imagine you need this for WFA tests, but why are the debugfs
> > counters not enough for that?
> > 
> > I don't really see much functional reason (wpa_supplicant or so) to have
> > this, and thus why expose it in the nl80211 API?
> 
> Do we have a policy or some kind of preference on how to address dot11
> statistics counters that can be handy at debugging real production use
> error cases? 

Not really ...

> For this particular case, is there objection to adding
> support for fetching dot11RSNAStatsCMACReplays and
> dot11RSNAStatsCMACReplays counter values?

Do we really want to add them that way, or should they be at a key
level? To me it always felt a bit like they should be per key, and we
expose some counters that way in debugfs I believe.

OTOH, you can argue that they are MIBs today, so they should be exposed
as such? And maybe firmware doesn't support per-key data, etc.

So I don't really have a strong opinion on it, but I feel that we have a
hodge-podge of things in this area, doing one thing with debugfs,
another thing with nl80211, etc.

johannes

