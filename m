Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB8E21076B2
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 18:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKVRpM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 12:45:12 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:48598 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKVRpK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 12:45:10 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iYCzU-00020a-Qm; Fri, 22 Nov 2019 18:45:08 +0100
Message-ID: <2fe0e6d4ad9f3e4eb1359fa4b340963a7e8c2523.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: set start_time_tsf/tsf_bssid for sw scans
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 22 Nov 2019 18:45:07 +0100
In-Reply-To: <51080819b4018bb5fa694bb51e7d426ea7fd6659.camel@gmail.com> (sfid-20191122_184027_144136_DDE5DB34)
References: <20191119221509.11370-1-prestwoj@gmail.com>
         (sfid-20191119_231813_756724_8FA90451) <23be17c6cddca53a2f3b945248516d3e7801a75c.camel@sipsolutions.net>
         <51080819b4018bb5fa694bb51e7d426ea7fd6659.camel@gmail.com>
         (sfid-20191122_184027_144136_DDE5DB34)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> > > +		req->info.scan_start_tsf = req->scan_start;
> > 
> > These are two very different things.
> 
> Is this a jiffies vs TSF issue? Or are they really completely different
> things?

Two different things. You're supposed to report the TSF of your AP when
the scan started, not some local clock.

> Looking at iwlwifi I now see that I wrongly read the scan_start values
> they were using. I thought they were setting mvm->scan_start = jiffies,
> but that was in another structure. mvm->scan_start gets set to
> scan_start_tsf, and looks like it comes from a scan complete callback.
> 
> So if this value is only obtainable in the driver, I'll drop this and
> maybe add support into mac80211_hwsim.

Right, I think you can only do it in the driver, see above.

> I don't mean to hijack this patch thread (its related), but there is
> some confusion about these ext features in nl80211:
> 
> NL80211_EXT_FEATURE_SCAN_START_TIME
> NL80211_EXT_FEATURE_BSS_PARENT_TSF
> 
> They were only added into iwlwifi and its not clear why or whether
> these features should even be checked by userspace (wpa_supplicant does
> not check). We were planning on using these to enable support for
> beacon measurement requests (if set) but its looking like, for the
> majority of hardware, these values are not included in scan results,
> meaning they end up being zero/unset in the measurement report (as they
> do with wpa_supplicant). The spec is does not explicitly say these
> values are required for measurement reports, but it also doesn't say
> they are optional.

I don't recall exactly which program they were required by, off the top
of my head. I could look it up but not right now.

But yes, this is basically used for measurement request/report.

> Am I just looking too deeply into this? Maybe its the case that an AP
> which utilizes measurement requests/reports doesn't even care about
> these values? There is also a ext feature for RRM as a whole which
> further confuses me. It would seem like if RRM is supported both these
> other features also need to be supported. And maybe this is the case,
> and only iwlwifi 'technically' works with RRM (at least if you follow
> the spec and require inclusion of these two values).

Well, there's this spec and this spec ... So IEEE 802.11 might have all
this be optional, but some WFA programs might require it. I think this
is the case of the latter, but I don't know off the top of my head which
one (and even if I did I'd have to think about whether I can mention it
in public ...)

johannes

