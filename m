Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E354C362A62
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Apr 2021 23:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242841AbhDPVgF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Apr 2021 17:36:05 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:35219 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbhDPVgE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Apr 2021 17:36:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618608939; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=VuuXgRVi2I9t45HaEUdXxLnuHFSkVUfzl+EjC/badf4=;
 b=RGUuiVXkDsA5N/dyFo995qGCxy/odwtFX+Z4kCTLFol+KPf3dvVETsccatdJqvhh4UJEulzr
 cHpOnzUl1HVOJridNe+VQYuz5P9xsU3xJlP9S0ab81BFPFIik4zhFJ6Uyr44LUGlA3xJAvFM
 exgsPq7Pqo2a311yHRG2KwALdvA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 607a032a2cc44d3aea87a4c0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Apr 2021 21:35:38
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CB947C43461; Fri, 16 Apr 2021 21:35:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1602FC433CA;
        Fri, 16 Apr 2021 21:35:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 16 Apr 2021 14:35:38 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>
Subject: Re: [PATCH v9 2/4] mac80211: add multiple bssid support to interface
 handling
In-Reply-To: <7f6f0a8c151746e8bb44ad50daf75259a0fac829.camel@sipsolutions.net>
References: <20210310182604.8858-1-alokad@codeaurora.org>
 <20210310182604.8858-3-alokad@codeaurora.org>
 (sfid-20210310_192729_241525_2DF37B20)
 <7f6f0a8c151746e8bb44ad50daf75259a0fac829.camel@sipsolutions.net>
Message-ID: <494efc64a803693324dee5b7a03cfda0@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-04-08 05:06, Johannes Berg wrote:
> On Wed, 2021-03-10 at 10:26 -0800, Aloka Dixit wrote:
>> From: John Crispin <john@phrozen.org>
>> 
>> Add a new helper ieee80211_set_multiple_bssid_options() takes 
>> propagating
>> the cfg80211 data down the stack.
>> 
>> The patch also makes sure that all members of the bss set will get 
>> closed
>> when either of them is shutdown.
> 
> s/either/any/
>> 
>>  static int ieee80211_del_iface(struct wiphy *wiphy, struct 
>> wireless_dev *wdev)
>>  {
>> +	struct ieee80211_sub_if_data *sdata;
>> +
>> +	sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
> 
> can be one line
> 

Okay

>> +	if (sdata && sdata->vif.type == NL80211_IFTYPE_AP) {
>> +		if (sdata->vif.multiple_bssid.flags & 
>> IEEE80211_VIF_MBSS_TRANSMITTING) {
>> +			struct ieee80211_sub_if_data *child;
>> +
>> +			rcu_read_lock();
>> +			list_for_each_entry_rcu(child, &sdata->local->interfaces, list)
>> +				if (child->vif.multiple_bssid.parent == &sdata->vif)
>> +					dev_close(child->wdev.netdev);
>> +			rcu_read_unlock();
> 
> You never tested this properly, this is wrong.
> 
> johannes

This was added for graceful shutdown of non-transmitting interfaces 
whenever the transmitting one is being brought down. But I see that 
dev_close() is happening twice now.

Inclining towards removing this and just return error to application if 
it tries to remove transmitting before all non-transmitting are deleted.
However, currently the "parent" pointer to indicate the transmitting 
interface is maintained in mac80211, nothing in cfg80211.

Which option would be better,
(1) Add new function to mac80211_config_ops to return yes/no to whether 
cfg80211 can delete a particular interface when MBSSID is in use.
(2) Add a new pointer in struct wireless_dev to track the transmitting 
interface of the set. Then the yes/no decision can be taken in cfg80211 
itself.

Thanks.
