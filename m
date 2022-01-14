Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C097948F06E
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jan 2022 20:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiANTX3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jan 2022 14:23:29 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:40748 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231594AbiANTX3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jan 2022 14:23:29 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1642188208; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=3E++mqqeSSAx6RPe4mtoLkORWSZDVafU4u4yyeEST6I=;
 b=uxDDI1e+hB+LTSkgo9MuRytCZw1atogb+gA5Vox/BTt1AD4HduGNWQfE2iOfVag+ecOTRYdj
 S6gqUuTMsiuG9IUhKn87nVKxNOjZHpyWPi+0B/EPikE3QSfAtmS0CyCIaZSHYPWLc83DQjdN
 Y6HqrcphFNegbHFWE7JcTj+yF0k=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 61e1cdad69943108c58f6a6f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Jan 2022 19:23:25
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E1A18C4360C; Fri, 14 Jan 2022 19:23:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 70809C4338F;
        Fri, 14 Jan 2022 19:23:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Jan 2022 11:23:23 -0800
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [v13 2/3] mac80211: MBSSID and EMA beacon handling in AP mode
In-Reply-To: <16a03353cee422340c8ac36240b1e088fd45802e.camel@sipsolutions.net>
References: <20211006040938.9531-1-alokad@codeaurora.org>
 <20211006040938.9531-3-alokad@codeaurora.org>
 <16a03353cee422340c8ac36240b1e088fd45802e.camel@sipsolutions.net>
Message-ID: <d2c980b72af1488282f18e8b1814b56c@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-11-26 03:23, Johannes Berg wrote:
> On Tue, 2021-10-05 at 21:09 -0700, Aloka Dixit wrote:
> 
>> 
>> +static struct sk_buff *
>> +ieee80211_beacon_get_ap_mbssid(struct ieee80211_hw *hw,
>> +			       struct ieee80211_vif *vif,
>> +			       struct ieee80211_mutable_offsets *offs,
>> +			       bool is_template,
>> +			       struct beacon_data *beacon,
>> +			       struct ieee80211_chanctx_conf *chanctx_conf,
>> +			       int ema_index,
>> +			       struct list_head *ema_list)
> 
> This function is called from ieee80211_beacon_get_ap(). That's called
> from __ieee80211_beacon_get(), under RCU read lock.
> 
>> +	for (i = 0; i < beacon->mbssid_ies->cnt; i++) {
>> +		struct ieee80211_ema_bcns *bcn;
>> +
>> +		bcn = kzalloc(sizeof(*bcn), GFP_KERNEL);
> 
> Therefore, you really cannot GFP_KERNEL allocate anything. But I really
> only saw this because I went back to my comments on v12 where this was
> still more obvious.
> 

Okay, I understand now that it is illegal because GFP_KERNEL is 
blocking.

I thought of following:
lock rcu -> get mbssid count first -> unlock rcu -> allocate memory.
But in that case, will have again: lock -> dereference to get beacon 
snapshot.
Beacon can change in between so new count might be wrong. In general 
sounds complicated and wrong.

I read that GFP_ATOMIC should be used sparingly, mainly for interrupt 
handlers etc.
Do you think this code path warrants its use?
Or should I look for some other function split?

Will add hwsim test cases before the next version but I genuinely did 
not see any issue during testing with current code.
So can you tell me which debug flags should be enabled to make such 
errors become obvious to someone like me who is new to these details in 
kernel programming?

Thanks!!
