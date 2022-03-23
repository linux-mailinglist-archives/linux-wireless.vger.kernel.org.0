Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDE14E58BB
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 19:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344077AbiCWSv4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 14:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240221AbiCWSvz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 14:51:55 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70D366CB1
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 11:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=AKBjif4EINWWORbM9KvKAC4xLIFUTDcmFUkgmOfWYy4=;
        t=1648061417; x=1649271017; b=s3Pk52jOOihOfytoPjExV5bu/Sd4W588qgsF1fgnoVV695o
        i452BujlXJPaAngqi2ON0xX552EtwqzOM3LwAtzEkuVprs647EdPTvGEq2eSslIWZPRH6gtZEKs8a
        Vhwurz5sg1ZdcZg6xK9iGWL0g0Zb+kzx2EwR6ehnwXB1HYXVdTeML2xSXnAwnMLutmiiJ0qZ5J06c
        Hwny977KTGd4fodnfPE+g21d4LZPYl/a/SKTPy/8H3/rrFFlYjiFxMua0sY4XkZg674s7Xr5k5ieK
        KxKeO9hIg0h0ix+rLCWxa/R6w4ZmlUSWaqRydqI5zCfh36WcYisxmy9EKz1XKP7w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nX63i-00HCCC-OC;
        Wed, 23 Mar 2022 19:50:14 +0100
Message-ID: <a2c1706527d11312b504f8d445bcbba7738f9c8c.camel@sipsolutions.net>
Subject: Re: poor beacon/scan reliability with mac80211_hwsim
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Wed, 23 Mar 2022 19:50:13 +0100
In-Reply-To: <928be46d97a3da3fd677c9d87f9be6a02f4d3277.camel@gmail.com>
References: <928be46d97a3da3fd677c9d87f9be6a02f4d3277.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi James,

> We use mac80211_hwsim and our own 'hwsim' daemon to test conditions
> like poor signal strength or dropped frames. For quite a while we've
> noticed very poor reliability related to scanning when
> HWSIM_CMD_REGISTER is used to process frames. Scan results are just
> empty.
> 
> We've put in some work arounds like only registering for tests that
> absolutely need it and repeatedly scanning until the expected network
> is found, but there are cases where this is not possible.
> 
> I'm hoping for some ideas on how to actually fix this problem rather
> than continue trying to come up with workarounds. I have tried removing
> any frame processing (just an empty function) and noticed the problem
> still occurs, basically just calling HWSIM_CMD_REGISTER causes these
> problems.
> 
> I will admit this seems to happen more on slower systems, like inside a
> virtual machine environment, or in tests which create more than just a
> few radios (like ~5-6+) so it does seem like mac80211_hwsim/wmediumd
> processing the frame is just taking too long for beacons.
> 

That sounds like it's just scheduling? HWSIM_CMD_REGISTER makes all the
frames go through the wmediumd (or whatever other tool you use),
including the beacons - which makes sense, but there's scheduling
overhead. Also probe requests/probe responses will go through, and we
only wait for a limited time on each channel for a response/beacon.

Though I'm surprised the overhead and all is enough to make the jump out
to userspace and back take 30+ milliseconds (which is the smallest
possible dwell time if you have hwsim hw-scan enabled, otherwise it's
slightly larger).

Maybe, since beacons are sent periodically, and perhaps we can assume
the overhead is always similar, then you could do passive scanning?

No good answers to this, I guess ...

Though if you can run tests under UML/time-travel that would get rid of
this problem ;-)

johannes
