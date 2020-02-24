Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3033D16B215
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2020 22:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgBXVVs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Feb 2020 16:21:48 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:47154 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXVVr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Feb 2020 16:21:47 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j6LAb-007kiD-DX; Mon, 24 Feb 2020 22:21:41 +0100
Message-ID: <d7c4c85ca707118a612a34607b4980b2448f2059.camel@sipsolutions.net>
Subject: Re: [PATCH v4 6/7] rtw88: Add wowlan pattern match support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Brian Norris <briannorris@chromium.org>, yhchuang@realtek.com
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        chiu@endlessm.com
Date:   Mon, 24 Feb 2020 22:21:40 +0100
In-Reply-To: <20200222005242.GA100360@google.com> (sfid-20200222_015250_208812_578FC10C)
References: <20191219085816.20709-1-yhchuang@realtek.com>
         <20191219085816.20709-7-yhchuang@realtek.com>
         <20200222005242.GA100360@google.com> (sfid-20200222_015250_208812_578FC10C)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Brian,

> > +	if (is_broadcast_ether_addr(pattern))
> 
> I'm pretty sure it's not valid to look at 'pkt_pattern->pattern' without
> also accounting for the ->mask. Same for all the other if/else here.

Indeed, I'm not even sure what we fill in there. Perhaps whatever
userspace happened to have there, including potentially uninitialized
data?

> This also hints at a deficiency in the wowlan APIs: nl80211_set_wowlan()
> only honors a pre-set set of restrictions, like min/max pattern length,
> max offset. For restrictions like this, we either need a wiphy callback,
> such that rtw88 can reject arbitrary patterns, or else some additional
> declarative fields in 'struct wiphy_wowlan_support'.

Yeah, well, we didn't dream up arbitrary restrictions when the API was
added :-)

It's maybe a bit harder now to add them, but we can do it in cfg80211,
and reject it if the conditions are not met, and then older userspace
will simply not be able to figure out easily why it was rejected, if it
doesn't understand some new features bits/capability advertisement, I
guess?

I guess I'm not a huge fan of just arbitrarily returning errors when
something went wrong and userspace cannot figure out why (vs. advertised
restrictions like what we have now), but I guess that'd still be better
than nothing ...

Ideally, this can just be fixed; if not, IMHO better to add some
advertisement bits, but if not then we can surely add some kind of
filter callback that's invoked at config time, rather than only at
suspend time when it's way too late to do anything about it.

johannes

