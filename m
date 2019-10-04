Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 213E5CBA1F
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 14:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfJDMP2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 08:15:28 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:39034 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfJDMP1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 08:15:27 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iGMUX-0007bY-EC; Fri, 04 Oct 2019 14:15:25 +0200
Message-ID: <164db03648d82e0bdf962d18508322ac71f1b66d.camel@sipsolutions.net>
Subject: Re: [PATCH v3] mac80211: fix scan blocked on DFS channels in ETSI
 domains
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aaron Komisar <aaron.komisar@tandemg.com>,
        "peter.oh@eero.com" <peter.oh@eero.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Fri, 04 Oct 2019 14:15:24 +0200
In-Reply-To: <1570090415-28671-1-git-send-email-aaron.komisar@tandemg.com> (sfid-20191003_101345_590925_ADCFE050)
References: <02f58201-4b92-0a1e-d237-6838543a3513@eero.com>
         <1570090415-28671-1-git-send-email-aaron.komisar@tandemg.com>
         (sfid-20191003_101345_590925_ADCFE050)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-10-03 at 08:13 +0000, Aaron Komisar wrote:

> > The real reason of scan failure is because mac80211 checks if it's DFS
> > channel, but it doesn't check if CAC is done or not.
> 
> The problem is that scan request is blocked in ETSI reg domains. In non-ETSI
> reg domains the behavior is fine.
> 
> cfg80211 blocks scan in non-ETSI reg domains and allows leaving the channel
> in ETSI reg domains. I think that if we add a function in mac80211, which
> checks if we can leave the operating channel this function should also take
> into account the reg domain for completeness.
> > So to solve the issue, the right approach should be "check if DFS
> > channels and check if CAC is done".
> 
> We can't scan while CAC is in progress but why must we verify that CAC was done
> in order to perform a scan operation?

I agree that'd be weird - if CAC wasn't done we shouldn't be operating
on that channel to start with?

Peter, can you clarify your objection? Just to be sure - we're talking
here about the channel we're currently operating on, not any channel
that we might want to scan on.

I also note that regulatory_pre_cac_allowed() is named a bit confusingly
in this context, but I understand it - maybe a comment would be
worthwhile where this function is used, saying e.g.
	/*
	 * If pre-CAC is allowed, we can also briefly leave the channel
	 * for scanning purposes.
	 */

or something like that.

I do wonder if we should pull up the check for "cac_started" into
cfg80211? But then if we do that, we could maybe even pull *all* of the
checks up? But maybe not because of the tracking which channels we're on
etc. But at least the "cac_started" seems feasible?

Thanks,
johannes

