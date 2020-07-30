Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF4E233404
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 16:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgG3OMU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 10:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgG3OMU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 10:12:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371D9C061574
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 07:12:20 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k19IA-00DZOu-HV; Thu, 30 Jul 2020 16:12:18 +0200
Message-ID: <c0591d784c1593e6df02e6f5932ba05cee59d08b.camel@sipsolutions.net>
Subject: Re: mac80211_hwsim: enable Beacon protection
 [a483e29ca07fb4eee2d7c7ee67c919d352fa4091]
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Mihai Moldovan <ionic@ionic.de>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 30 Jul 2020 16:12:17 +0200
In-Reply-To: <c6de3886-1dbe-180d-d37b-ebccfba83933@ionic.de>
References: <c6de3886-1dbe-180d-d37b-ebccfba83933@ionic.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+list

> As mentioned in the commit message, you've pulled Jouni's patch, but applied it
> to hwsim only.

Yes, intentionally.

> Unfortunately, that leaves beacon protection for any "real" driver disabled, so
> this new feature will be pretty much unusable and (apart from hwsim for testing)
> dead code (for now).

Yes, intentionally. It's just barely done with interop testing, to some
extent...

> I understand the reasoning that it's not clear that drivers can handle this
> correctly (i.e., not modify data after it has been signed), but isn't that a bit
> too conservative?

It's not that "it's not clear". We know for a fact that some drivers
(e.g. iwlwifi) cannot handle this correctly.

So the only thing we can do is have the drivers advertise when they can
do it, which is exactly what all these commits do.

> After all, BIGTK/BEACON_PROT will only be used if explicitly turned on, mostly
> by hostapd, or any other AP software. In the worst case, i.e., if drivers update
> data after the fact, the connection just wouldn't work. That might be
> unfortunate,

I wouldn't really say "that's unfortunate". That'd be a bug!

Also, the intent is that at least wpa_supplicant would automatically
enable this if available, once the feature is more mature across various
implementations.

> but I can at least confirm that ath9k seems to handle this well.

Then you should submit a patch to ath9k similar like the one for hwsim
to enable it.

> I've been using protected management frames with that driver and a patch set
> backported to 5.6.x for a few months now without obvious hiccups, so there seem
> to at least be some drivers that *do* work.

:)

> Crucially, though, I don't see any potential for regressions here. If it's
> disabled in the AP software, all of this stuff just won't be used, just like it
> always has been the case in the past. Otherwise, it *might* be buggy, but you'd
> never know. Unless people patch their kernel to enable this feature, they won't
> be able to enable and test it in the first place.

This will change...

> Would you reconsider your decision and enable the feature in net/mac80211/main.c
> as well?

No.

johannes

