Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 595F6F4398
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 10:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbfKHJjl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 04:39:41 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:53176 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbfKHJjl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 04:39:41 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iT0ju-0006v5-K3; Fri, 08 Nov 2019 10:39:34 +0100
Message-ID: <84ca3a8b61757360ab9898afcdd3f2f63c770f86.camel@sipsolutions.net>
Subject: Re: [PATCHv8 0/6] cfg80211/mac80211: Add support for TID specific
 configuration
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Tamizh chelvam <tamizhr@codeaurora.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Fri, 08 Nov 2019 10:39:33 +0100
In-Reply-To: <20191108093207.uv4j44xpm2qvtsv5@bars>
References: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
         <20191108093207.uv4j44xpm2qvtsv5@bars>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Sergey,

Thanks for looking!

> BTW, there are two open questions remaining from the previous reviews:
> 
> - NL80211_TX_RATE_LIMITED and NL80211_TX_RATE_FIXED
>   Interpretation and validation of these two rate options is left
>   up to drivers.

(need to look at this still)

> - 'apply to all TIDs' usecase
>   Currently, if peer is not specified, then configuration is applied to
>   all the connected STAs. It is tempting to use some spare TID value
>   to inform drivers that provided configuration should be applied to
>   all TIDs of the specified STA or even to all TIDS and STAs. But that
>   can not be left up to drivers since this value needs to be passed
>   from userspace tools, e.g. from iw.

I was *just* replying on exactly the same point over in patch 1 (not
sent yet). It's actually not even clear to me that the configuration
really would be applied to *all* STAs, it's sort of left open for the
driver, afaict?

But I agree with you that this is not a good thing.

I don't think using a spare TID value is the right signalling, we can
add another attribute? E.g. we could easily add

	NL80211_TID_CONFIG_ATTR_OVERRIDE

and make that be

@NL80211_TID_CONFIG_ATTR_OVERRIDE: flag attribute, valid only if no STA
	is selected, if set indicates that the new configuration
	overrides all previous STA configurations, otherwise previous
	STA-specific configurations should be left untouched

You also raise a good point wrt. "all TIDs" - but then we should
probably just remove NL80211_TID_CONFIG_ATTR_TID and add a new
NL80211_TID_CONFIG_ATTR_TIDS as a bitmap? OTOH, it's not hard to just
explicitly spell out all TIDs either, I guess, just makes the message a
bit bigger.

johannes

