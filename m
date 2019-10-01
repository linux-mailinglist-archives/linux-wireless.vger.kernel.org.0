Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDA36C39E5
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 18:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfJAQFv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 12:05:51 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:36938 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfJAQFu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 12:05:50 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iFKer-000502-4x; Tue, 01 Oct 2019 18:05:49 +0200
Message-ID: <8700634c968092ab63bd0511e99177fffff2e6d4.camel@sipsolutions.net>
Subject: Re: [PATCH v2] Can't scan on ETSI domains when operating ch is DFS
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aaron Komisar <aaron.komisar@tandemg.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Tue, 01 Oct 2019 18:05:47 +0200
In-Reply-To: <1568820782-4679-1-git-send-email-aaron.komisar@tandemg.com> (sfid-20190918_173335_168822_401A5437)
References: <1568820782-4679-1-git-send-email-aaron.komisar@tandemg.com>
         (sfid-20190918_173335_168822_401A5437)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-09-18 at 15:33 +0000, Aaron Komisar wrote:
> In non-ETSI reg domains scan is blocked when operating channel is a DFS ch.
> For ETSI domains, however, once DFS channel is marked as available afer
> the CAC, this channel will remain available even after leaving this channel.
> Therefore a new CAC will not be required when scan is done.
> 
> In cfg80211 scan is not blocked for ETSI reg domains.
> This patch enables scan in mac80211 as well when operating channel is a radar
> channel for ETSI reg domains (unless CAC is in progress).

Please fix the commit message - the subject needs a prefix ("mac80211:")
and "can't scan" is a bug report, not a changelog entry ...

I think I've understood after staring at this for far too long what
you're trying to do and what the problem is, but that really needs to be
described more accurately.

Thanks,
johannes

