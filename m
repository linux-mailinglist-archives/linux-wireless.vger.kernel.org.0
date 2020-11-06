Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B48F2A9284
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 10:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgKFJ1A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 04:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgKFJ1A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 04:27:00 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D4AC0613CF
        for <linux-wireless@vger.kernel.org>; Fri,  6 Nov 2020 01:26:59 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kay1K-002CIy-7z; Fri, 06 Nov 2020 10:26:58 +0100
Message-ID: <504b253121f6edd6e3f48072580af3e15c0bc580.camel@sipsolutions.net>
Subject: Re: [PATCH V5 1/4] nl80211: add basic multiple bssid support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, Aloka Dixit <alokad@codeaurora.org>
Date:   Fri, 06 Nov 2020 10:26:57 +0100
In-Reply-To: <aea6777ee2f588cf8df26c416ec0cdb2399ff8cf.camel@sipsolutions.net> (sfid-20201106_102443_717492_2C4D7676)
References: <20201103091743.1924854-1-john@phrozen.org>
         <20201103091743.1924854-2-john@phrozen.org>
         <aea6777ee2f588cf8df26c416ec0cdb2399ff8cf.camel@sipsolutions.net>
         (sfid-20201106_102443_717492_2C4D7676)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-11-06 at 10:24 +0100, Johannes Berg wrote:
> 
> and get rid of NL80211_MULTIPLE_BSSID_IES_MAX.

Oh, and the fact that this today has a value of 8 _probably_ means you
hardcoded the limits of your specific device that you were thinking of
now, and we really should have the device advertising the maximum
possible value or so?

And then I guess we can still hard-code the maximum possible value in
cfg80211.h somewhere, use it for array sizes etc., but limit the
userspace API to the driver-advertised value (and check in wiphy
registration that the cfg80211 limit is >= the driver value).

Or is this some fundamental (spec) limit?

johannes

