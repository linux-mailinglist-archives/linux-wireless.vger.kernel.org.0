Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAE2A34D0
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2019 12:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfH3KTQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Aug 2019 06:19:16 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:34330 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfH3KTP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Aug 2019 06:19:15 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i3dzu-0003YT-0Z; Fri, 30 Aug 2019 12:19:14 +0200
Message-ID: <f5986ccd8ecdcc08d5c3e0d65f8bddef8b0af021.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] nl80211: Add NL80211_EXT_FEATURE_LIVE_IFTYPE_CHANGE
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>, linux-wireless@vger.kernel.org
Date:   Fri, 30 Aug 2019 12:19:13 +0200
In-Reply-To: <20190826162637.7535-1-denkenz@gmail.com> (sfid-20190826_183338_274894_5A6F600C)
References: <20190826162637.7535-1-denkenz@gmail.com>
         (sfid-20190826_183338_274894_5A6F600C)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-08-26 at 11:26 -0500, Denis Kenzior wrote:
> 
> + *	Prior to Kernel 5.4, userspace applications should implement the
> + *	following behavior:

I'm not sure mentioning the kernel version here does us any good? I
mean, you really need to implement that behaviour regardless of kernel
version, if NL80211_EXT_FEATURE_LIVE_IFTYPE_CHANGE isn't set.

> + * @NL80211_EXT_FEATURE_LIVE_IFTYPE_CHANGE: This device supports switching
> + * 	the IFTYPE of an interface without having to bring the device DOWN
> + * 	first via RTNL.  Exact semantics of this feature is driver
> + * 	implementation dependent.  

That's not really nice.

> For mac80211, the following restrictions
> + * 	apply:
> + * 		- Only devices currently in IFTYPE AP, P2P_GO, P2P_CLIENT,
> + * 		  STATION, ADHOC and OCB can be switched.
> + * 		- The target IFTYPE must be one of: AP, P2P_GO, P2P_CLIENT,
> + * 		  STATION, ADHOC or OCB.
> + * 	Other drivers are expected to follow similar restrictions.

Maybe we should instead have a "bitmask of interface types that can be
switched while live" or something like that?

johannes

