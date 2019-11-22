Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72328107695
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 18:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKVRkZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 12:40:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45110 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfKVRkZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 12:40:25 -0500
Received: by mail-pf1-f193.google.com with SMTP id z4so3786038pfn.12
        for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2019 09:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eu9ABsUNeNSu6DBIWl6EBVWNaSBOOSOWR/1pj7eySEw=;
        b=cRDT3RR0+sj+3ULrG+uS1PgDXnRefHcwUVbvdRI4COs5iIgSExzHZjxDL5SXXInaIs
         0pmqHzcEjY0S/RSdWGRM62e3u9AIghuTCZHDy8QZkMZn8TCs/i9PSS8KH8+WDEiO7mvB
         aP4TWi/gMPRuRHsfSwIU6aXXOltDi++M3+yyn6l23fjHib/dnBLrUBV93+sz8fsf50WV
         D3FrgmevnfdGlG6/8DrUTEEHroN497ChQlvsHxwf1CvjQ8rHI/KcSO0xqO8e96e6iE04
         LLW+K+VBYNCrDh6JT5ERtweMSDxGMkS2fhKqBkdKe4EXRJr1yOOG1ZHdVsXRcf/S4wJI
         z6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eu9ABsUNeNSu6DBIWl6EBVWNaSBOOSOWR/1pj7eySEw=;
        b=OSiNkxt69B2H+jafg0pc5WEGmDdMGmFMO4/iPU6bgqO4l/MM30LhE0jg4K+vjjivb1
         is5ir0MkaGjxw2pieU0l4YUbwreBXF4gLv/oEiB28+qj81S5Nn/g0kLaBX68GwsHf/MC
         /js8EVu9sQS2bMvFZeX0HyPv1jWPuV9H+bLZqv3HscN730kcrWUUKtvheJEK0xFvEHjY
         9iGN1pb2tleFsn2g684h2jmFhIfYipgX3Y3Mzyf3vIlQCTCTnbAZ+F3uPEbuKsUHkDzq
         LjgU6epNZCYTuhchZ2pgeWjTm4ix0J7bZAem5cFW694Y7/5xWY17ZqgWOBPyPpxHUVFT
         8QZw==
X-Gm-Message-State: APjAAAUxFqDZedtujeu3mok/7eaTEvHR5ql/iPwNGD+yMZYE3E0NIu3j
        GPUjfuacWfQ1zyZN2Ti+i+vKMtyM
X-Google-Smtp-Source: APXvYqyJBTD67A7pXYzvdVTfV3PYmG/d1A54gNszZRE4m3gNR3ODFCFMFQryhpRdM82oMv2GEBGVuQ==
X-Received: by 2002:aa7:91c7:: with SMTP id z7mr19593418pfa.111.1574444424654;
        Fri, 22 Nov 2019 09:40:24 -0800 (PST)
Received: from jprestwo-test.jf.intel.com ([134.134.139.76])
        by smtp.googlemail.com with ESMTPSA id s18sm8275239pfs.20.2019.11.22.09.40.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Nov 2019 09:40:23 -0800 (PST)
Message-ID: <51080819b4018bb5fa694bb51e7d426ea7fd6659.camel@gmail.com>
Subject: Re: [PATCH] mac80211: set start_time_tsf/tsf_bssid for sw scans
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Date:   Fri, 22 Nov 2019 09:37:29 -0800
In-Reply-To: <23be17c6cddca53a2f3b945248516d3e7801a75c.camel@sipsolutions.net>
References: <20191119221509.11370-1-prestwoj@gmail.com>
         (sfid-20191119_231813_756724_8FA90451) <23be17c6cddca53a2f3b945248516d3e7801a75c.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-11-22 at 13:04 +0100, Johannes Berg wrote:
> On Tue, 2019-11-19 at 14:15 -0800, James Prestwood wrote:
> > These values are already tracked so for the software scan path
> > we can set these into scan_info so NL80211 reports it in
> > TRIGGER_SCAN.
> 
> No.
> 
> > +		req->info.scan_start_tsf = req->scan_start;
> 
> These are two very different things.

Is this a jiffies vs TSF issue? Or are they really completely different
things?

Looking at iwlwifi I now see that I wrongly read the scan_start values
they were using. I thought they were setting mvm->scan_start = jiffies,
but that was in another structure. mvm->scan_start gets set to
scan_start_tsf, and looks like it comes from a scan complete callback.

So if this value is only obtainable in the driver, I'll drop this and
maybe add support into mac80211_hwsim.

I don't mean to hijack this patch thread (its related), but there is
some confusion about these ext features in nl80211:

NL80211_EXT_FEATURE_SCAN_START_TIME
NL80211_EXT_FEATURE_BSS_PARENT_TSF

They were only added into iwlwifi and its not clear why or whether
these features should even be checked by userspace (wpa_supplicant does
not check). We were planning on using these to enable support for
beacon measurement requests (if set) but its looking like, for the
majority of hardware, these values are not included in scan results,
meaning they end up being zero/unset in the measurement report (as they
do with wpa_supplicant). The spec is does not explicitly say these
values are required for measurement reports, but it also doesn't say
they are optional.

Am I just looking too deeply into this? Maybe its the case that an AP
which utilizes measurement requests/reports doesn't even care about
these values? There is also a ext feature for RRM as a whole which
further confuses me. It would seem like if RRM is supported both these
other features also need to be supported. And maybe this is the case,
and only iwlwifi 'technically' works with RRM (at least if you follow
the spec and require inclusion of these two values).

Thanks,
James

> 
> johannes
> 

