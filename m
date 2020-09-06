Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5247E25EEFB
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Sep 2020 18:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgIFQEw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Sep 2020 12:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbgIFQEn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Sep 2020 12:04:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7F4C061573
        for <linux-wireless@vger.kernel.org>; Sun,  6 Sep 2020 09:04:30 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kEx9V-00GzVa-NR; Sun, 06 Sep 2020 18:04:25 +0200
Message-ID: <da06b5074a5d40d811a67656048f3afa262ff134.camel@sipsolutions.net>
Subject: Re: [PATCH v2 00/22] add support for S1G association
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Jouni Malinen <j@w1.fi>
Date:   Sun, 06 Sep 2020 18:04:24 +0200
In-Reply-To: <20200831205600.21058-1-thomas@adapt-ip.com>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-08-31 at 13:55 -0700, Thomas Pedersen wrote:
> 
> Note the mac80211_hwsim S1G support introduces a regression in a few
> hostap hwsim tests. This is because when processing the reported bands,
> hostap assumes freq < 4000 is 11b, and the actual 11b/g band is
> overwritten by the S1G band info. Though it does count as a userspace
> regression, I'm not sure there is much to do about it besides apply a
> small patch to hostapd which treats freq < 2000 as an unknown band.
> 
> After the hostap workaround
> (https://lists.infradead.org/pipermail/hostap/2020-August/038748.html),
> these patches continue to pass the hwsim tests as well as HEAD.


That sounds like we could "hack around" it by sending the S1G data
first, and then the 2.4 GHz, so the latter overwrites it on broken
versions?

Not sure it's worth it though, I'd say it depends a bit on what real
hardware plans are?

I mean, if it's only hwsim for now ... who cares? And if it's going to
be special hardware that only does S1G, then also meh, you need newer
versions to support it, big deal.

But if OTOH a commonly used chipset like e.g. ath9k or ath10k will get
S1G support, then that'd be more relevant?

johannes

