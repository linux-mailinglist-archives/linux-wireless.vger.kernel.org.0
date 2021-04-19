Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C624C364DC6
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Apr 2021 00:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhDSWnX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Apr 2021 18:43:23 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:52901 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhDSWnX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Apr 2021 18:43:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618872173; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=yeCrlLMGxTIrwZCaqKjkM9A1XVBn1hIAvkoGUKpGXy0=;
 b=LGDCn6iWPMXJtkN21FCPii3IWoTujyA6Iw3uUS65fWubLZG842ui1sbrKTJtAzI/UO/O8peB
 BW/qVEgSicViqv5FwJ9AEhHRhpqrVGSv7j9pZcrjd/rTZFsQCEOpj8ZKyhx/Kpk44bn/qsdk
 x5ruDgSw+b2eTtG18EuZEv3i76Y=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 607e076cfebcffa80f3531b3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 19 Apr 2021 22:42:52
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2A206C43460; Mon, 19 Apr 2021 22:42:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 71517C433D3;
        Mon, 19 Apr 2021 22:42:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 19 Apr 2021 15:42:51 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        alokad=codeaurora.org@codeaurora.org
Subject: Re: [PATCH v9 2/4] mac80211: add multiple bssid support to interface
 handling
In-Reply-To: <865a59c2dd3a07c4ee88716f51759e88@codeaurora.org>
References: <20210310182604.8858-1-alokad@codeaurora.org>
 <20210310182604.8858-3-alokad@codeaurora.org>
 (sfid-20210310_192729_241525_2DF37B20)
 <7f6f0a8c151746e8bb44ad50daf75259a0fac829.camel@sipsolutions.net>
 <494efc64a803693324dee5b7a03cfda0@codeaurora.org>
 <9ce462d7c0dc707259d8bb50ec27a189ec89ef61.camel@sipsolutions.net>
 <865a59c2dd3a07c4ee88716f51759e88@codeaurora.org>
Message-ID: <543bf0ddae17e1649b8008021bfde6f2@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-04-19 15:35, Aloka Dixit wrote:
> On 2021-04-19 04:28, Johannes Berg wrote:
>> Hi,
>> 
>>> > > +	if (sdata && sdata->vif.type == NL80211_IFTYPE_AP) {
>>> > > +		if (sdata->vif.multiple_bssid.flags &
>>> > > IEEE80211_VIF_MBSS_TRANSMITTING) {
>>> > > +			struct ieee80211_sub_if_data *child;
>>> > > +
>>> > > +			rcu_read_lock();
>>> > > +			list_for_each_entry_rcu(child, &sdata->local->interfaces, list)
>>> > > +				if (child->vif.multiple_bssid.parent == &sdata->vif)
>>> > > +					dev_close(child->wdev.netdev);
>>> > > +			rcu_read_unlock();
>> 
>>> This was added for graceful shutdown of non-transmitting interfaces
>>> whenever the transmitting one is being brought down. 
>>> 
>> 
>> I know, I asked you to.
>> 
>>> But I see that
>>> dev_close() is happening twice now.
>>> 
>> 
>> That wouldn't be an issue.
>> 
>> The issue is that dev_close() needs to be able to sleep, and it even
>> contains a might_sleep(), so you can't do it under the RCU protection
>> you used here.
>> 
>>> Inclining towards removing this and just return error to application 
>>> if
>>> it tries to remove transmitting before all non-transmitting are 
>>> deleted.
>>> However, currently the "parent" pointer to indicate the transmitting
>>> interface is maintained in mac80211, nothing in cfg80211.
>> 
>> That seems kinda awkward, considering e.g. if hostapd crashes and then 
>> a
>> new instance has to clean up, it might not really have much knowledge 
>> of
>> the order in which it should be doing that.
>> 
>> I think it's better if you just fix the locking here?
>> 
>> johannes
> 
> Hi Johannes,
> Thanks for the response, I need more help.
> 
> Is rcu_read_lock is not allowed around dev_close() because it might
> block or *ANY* lock?
> Because both functions with new dev_close() themselves are called with
> locks held,
> (1) ieee80211_do_stop() happens inside 
> wiphy_lock(sdata->local->hw.wiphy)
> (2) ieee80211_del_iface() happens inside mutex_lock(&rdev->wiphy.mtx).
> Should these be unlocked temporarily too before calling dev_close()?
> Didn't find any instance of wiphy.mtx lock/unlock in mac80211.
> 

My bad, wiphy_lock() internally uses wiphy.mtx so mac80211 does have a 
way, then should it be unlocked temporarily before dev_close()?

> Also, in cfg.c, list_for_each_entry(sdata, &local->interfaces, list)
> is called with two different murexes: (1) local->iflist_mtx
> (2) local->mtx
> 
> Which is the correct one for this purpose among above two and 
> rcu_read_lock()?
> Once that decided, would following be sufficient -
>     lock()
>     list_for_each_entry(sdata, &local->interfaces, list) {
>         get_child_pointer
>         unlock()
>         dev_close()
>         lock()
>     }
>     unlock
> 
> Thanks.

