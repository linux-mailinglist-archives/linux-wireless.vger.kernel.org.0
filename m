Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740FC1E0A5A
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 11:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389387AbgEYJZL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 05:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389105AbgEYJZL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 05:25:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C68FC061A0E
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 02:25:11 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jd9M5-002bif-0h; Mon, 25 May 2020 11:25:09 +0200
Message-ID: <83abd321a059b4bed470775333f3dbc598661c68.camel@sipsolutions.net>
Subject: Re: mac80211 spam and deadlock on OpenWrt
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Mon, 25 May 2020 11:25:08 +0200
In-Reply-To: <e5caffb7-b387-9010-8445-54992ccf6e4c@candelatech.com> (sfid-20200513_155619_741277_EDC79A78)
References: <e5caffb7-b387-9010-8445-54992ccf6e4c@candelatech.com>
         (sfid-20200513_155619_741277_EDC79A78)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-05-13 at 06:56 -0700, Ben Greear wrote:
> Hello,
> 
> I've been running some stress tests against OpenWrt APs.  My AP partially died yesterday
> during a test and did not recover.  It looks like firmware became non responsive,
> but then it could not recover due to what I think is bugs I fixed long ago in
> the kernel that I normally use.  The OpenWrt image is using my ath10k-ct driver and firmware,
> but stock OpenWrt kernel/mac80211 as far as I know.
> 
> I think there are several issues:
> 
> 1)  The WARN-ON about check-sdata-in-driver should be a warn-on-once.  Spamming serial
>    console logs like this is both very slow and also useless for debugging.
> 
> I posted a patch with this title some time back to mitigate this problem:
> "mac80211: Don't spam kernel with sdata-in-driver failures."
> 
> 2)  I suspect that the ensuing lockup may be fixed by this patch I posted
> back in 12/1/2016:
> "mac80211:  do not iterate active interfaces when in re-configure"
> 
> I have been running both of those patches since posting them to the list, so they have good
> soak time in some strenuous wifi usage cases.

Huh, these are kinda old I guess.

Can you repost them?

johannes

