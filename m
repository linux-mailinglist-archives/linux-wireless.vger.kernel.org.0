Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20AD4E59AA
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 21:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344569AbiCWUPZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 16:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344568AbiCWUPY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 16:15:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100787655
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 13:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=NRpEnyOqsaUwAs5DucD1b5ETOzwDBz4Ik403KU7/bNY=;
        t=1648066434; x=1649276034; b=Q/taKYtf8wQaoqFmT02xFDJ32iRHMFANOQfE1aNdAosRXH5
        VEFPo217HL3xeQl2r8DNXw/dDNOYCS8dtb5RbZAu/xxJfDmtS1sEA0LPMAnjofvyWJMnK4+436Llj
        z1EOqcaLRpt+EPhWf0BuS5xLQDMUum9Bhue7Rb7Y6ycAhKs0eniMvQBUfGCUX3coTmx1qEfqUFeqW
        Sd/h0ffGCsDBUPlqbXK81vLkLNKy7p0lQWchOGgtrSHVWFd9OWRUqqhf/3xs3TuiRt4mlEaw6MyAP
        Cr+UG6jZDujO/dHi+7C2D0Xl5FqU125w/aIxD/pBGeDEr1/DLeRHrYxP1F4KD2RQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nX7Md-00HDUA-Co;
        Wed, 23 Mar 2022 21:13:51 +0100
Message-ID: <9e3f1db524321ac33a4aa79341e4e8165eb99189.camel@sipsolutions.net>
Subject: Re: poor beacon/scan reliability with mac80211_hwsim
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Wed, 23 Mar 2022 21:13:50 +0100
In-Reply-To: <545f0fb3be911c4bed6a0dc81b0679a9824fe6c9.camel@gmail.com>
References: <928be46d97a3da3fd677c9d87f9be6a02f4d3277.camel@gmail.com>
         <a2c1706527d11312b504f8d445bcbba7738f9c8c.camel@sipsolutions.net>
         <545f0fb3be911c4bed6a0dc81b0679a9824fe6c9.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-03-23 at 12:45 -0700, James Prestwood wrote:
> > Though I'm surprised the overhead and all is enough to make the jump
> > out
> > to userspace and back take 30+ milliseconds (which is the smallest
> > possible dwell time if you have hwsim hw-scan enabled, otherwise it's
> > slightly larger).
> 
> Yeah I'm surprised as well. I haven't _proven_ this is the case but its
> really all I can think of for why scan results are missing. 

Agree.

> I don't
> think hw-scan is being used, we don't set ATTR_USE_SCANCTX or
> ATTR_CHANNELS so I guess this is the best case scenario for dwell time,
> hmm.

Well in mac80211 it's HZ/33, which is about the same time.

> > Though if you can run tests under UML/time-travel that would get rid
> > of this problem ;-)
> 
> Yeah this has been in the back of my mind for a while since it could
> also speed stuff not having to wait for timeouts.

True.

> But with respect to this issue how could UML fix it? Pause time to
> allow the scheduler to catch up?

Well I should have said time-travel=inf-cpu, which is really the mode
I'd use for testing (and we have time-travel=ext of course for use with
multiple VMs).

In this case it simulates infinite CPU speed! Thus time only passes if
it passes *explicitly*. So a timeout of 30ms will only fire after
something else has slept 30ms, or nothing is actually doing anything at
all of course. The amount of time it takes the CPU to do the jump out to
userspace/wmediumd, come back, copy the frame, etc. is all completely
irrelevant in this case. It's just "sleep 30ms" and all the necessary
CPU expenditure is not accounted at all.

johannes
