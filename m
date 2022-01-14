Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0300648F179
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jan 2022 21:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbiANUf1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jan 2022 15:35:27 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:13765 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244778AbiANUeM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jan 2022 15:34:12 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1642192452; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=28CDXxcF4VAS96vslYOtTdFJVocsav6Ju95JUO7jCxI=;
 b=t+yhjJPvRUKGvlRm8OX9RjHRMlF89wlx178KZAarRPTd2huWU8+A5WV77SyYg8Cd+JGqVvg7
 O9L/ak6OS7U25Oljg61gEmftmn8lqGFAe73AdinaemrOwnqLvtdeLEYoDGLJUQotOfKxACjh
 fHvG97QM0LfcJnOz32V+paOeVw0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 61e1de3b2b595aa3216d20c2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Jan 2022 20:34:03
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 85843C43635; Fri, 14 Jan 2022 20:34:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6C5EFC4361C;
        Fri, 14 Jan 2022 20:34:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Jan 2022 12:34:01 -0800
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [v13 2/3] mac80211: MBSSID and EMA beacon handling in AP mode
In-Reply-To: <ebb1ddc51e6e0eff436de50cbbddec77d61af495.camel@sipsolutions.net>
References: <20211006040938.9531-1-alokad@codeaurora.org>
 <20211006040938.9531-3-alokad@codeaurora.org>
 <16a03353cee422340c8ac36240b1e088fd45802e.camel@sipsolutions.net>
 <d2c980b72af1488282f18e8b1814b56c@codeaurora.org>
 <ebb1ddc51e6e0eff436de50cbbddec77d61af495.camel@sipsolutions.net>
Message-ID: <661712f782228b735ab65364932bb18e@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2022-01-14 12:12, Johannes Berg wrote:
> Hi!
> 
>> 
>> > This function is called from ieee80211_beacon_get_ap(). That's called
>> > from __ieee80211_beacon_get(), under RCU read lock.
>> >
>> > > +	for (i = 0; i < beacon->mbssid_ies->cnt; i++) {
>> > > +		struct ieee80211_ema_bcns *bcn;
>> > > +
>> > > +		bcn = kzalloc(sizeof(*bcn), GFP_KERNEL);
>> >
>> > Therefore, you really cannot GFP_KERNEL allocate anything. But I really
>> > only saw this because I went back to my comments on v12 where this was
>> > still more obvious.
>> >
>> 
>> Okay, I understand now that it is illegal because GFP_KERNEL is
>> blocking.
> 
> Right.
> 
>> I thought of following:
>> lock rcu -> get mbssid count first -> unlock rcu -> allocate memory.
>> But in that case, will have again: lock -> dereference to get beacon
>> snapshot.
>> Beacon can change in between so new count might be wrong. In general
>> sounds complicated and wrong.
> 
> Indeed. You could make it work (and count changing is highly unlikely!)
> by going back and checking if the count was correct in the critical
> section, and then going back if necessary (i.e. if it was wrong). But 
> if
> you do this, you should do something like this pseudo-code:
> 
> rcu_read_lock();
> repeat:
> calculated_size = calculate_size();
> rcu_read_unlock();
> 
> alloc = kzalloc(calculated_size, GFP_KERNEL);
> // omitting error handling
> 
> rcu_read_lock();
> calculated_size = calculate_size();
> if (ksize(alloc) < calculated_size)
> 	goto repeat;
> ...
> 
> 
> i.e. note the ksize(), since allocations are rounded up. Even if the
> count increased, you might not need a new allocation.
> 
> Also maybe anyway it'd make sense to allocate all of them together as 
> an
> array, rather than individual pointers for each beacon?
> 
> 
>> I read that GFP_ATOMIC should be used sparingly, mainly for interrupt
>> handlers etc.
> 
> I guess once every beacon is still fairly sparingly though :)
> 
> 

Thank you so much for the quick response, will enable the debug flags 
henceforth.

With that, what would be a better way:
(1) Making it work with pseudo code, still using GFP_KERNEL or
(2) Changing to GFP_ATOMIC but otherwise keep the code fairly similar to 
v13 (preferably allocating an array instead of separate pointers as you 
suggested)?

