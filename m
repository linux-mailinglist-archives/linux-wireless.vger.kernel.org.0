Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D60319C36
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Feb 2021 11:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhBLJ7s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Feb 2021 04:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhBLJ7q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Feb 2021 04:59:46 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7B0C061574
        for <linux-wireless@vger.kernel.org>; Fri, 12 Feb 2021 01:59:04 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lAVE7-001nbe-2k; Fri, 12 Feb 2021 10:59:03 +0100
Message-ID: <c3b48c141c763e0cc1beb74482cd0bb4fbc546aa.camel@sipsolutions.net>
Subject: Re: [PATCH V7 0/4] mac80211: add multiple bssid support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 12 Feb 2021 10:59:02 +0100
In-Reply-To: <20210120005120.32424-1-alokad@codeaurora.org> (sfid-20210120_015542_749517_52354F67)
References: <20210120005120.32424-1-alokad@codeaurora.org>
         (sfid-20210120_015542_749517_52354F67)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> John Crispin (4):
>   nl80211: add basic multiple bssid support
>   mac80211: add multiple bssid support to interface handling
>   mac80211: add multiple bssid/EMA support to beacon handling
>   mac80211: CSA on non-transmitting interfaces

As much as I hate to send this back to you ...

I don't understand how you can not have an nl80211 feature flag for AP-
side multi-BSSID support, yet have a mac80211-level feature flag?

For STA side we could get away with it because we present all the BSSes
in cfg80211's scan results, and even a version of wpa_supplicant that's
not aware of multi-BSSID should be able to pick one of the non-
transmitting BSSes and connect to it.

But here? I don't understand how that'd be possible.

Also, are the interface limits (# of AP interfaces) even sufficient, or
should there be different limits for non-transmitting? I could imagine
that it'd be easier to have more interfaces if they're non-transmitting, 
since then you don't have to deal with more beacons but only more MAC
addresses.

So from that POV this seems rather lacking the necessary bits to be able
to confidently use it from userspace?

johannes

