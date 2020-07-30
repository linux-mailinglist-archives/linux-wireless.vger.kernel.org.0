Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50C4233A6B
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 23:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbgG3VRt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 17:17:49 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:29772 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730281AbgG3VRt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 17:17:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596143868; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=VYzqPduQzYY5DMAxe9wN74AoN74LbLs+XuxwlGN8PjI=;
 b=ESvibcEuEwNfFATdQrorP6HdWb/+O0jYzpLAToZjySODSP2LN44EAwA4Z3PSvQgRV48qdLGh
 r7EhaD8DsJBhTjVGmq3p/TunwzmAULfPzNr9LYZDcmvTOuMF8Aan2FO/QWMJHTCsy1Iaf4yR
 l+jtVe6dSlsU/FsKGTV5ZDCPTNc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-east-1.postgun.com with SMTP id
 5f2338fc798b10296896c122 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 30 Jul 2020 21:17:48
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3BC4DC433C9; Thu, 30 Jul 2020 21:17:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6711CC433C6;
        Thu, 30 Jul 2020 21:17:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 30 Jul 2020 14:17:46 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH v4 1/2] nl80211: Add FILS discovery support
In-Reply-To: <c3dbcc3e4ee2d3596625e8c1226325180444a961.camel@sipsolutions.net>
References: <20200618050427.5891-1-alokad@codeaurora.org>
 <20200618050427.5891-2-alokad@codeaurora.org>
 <c3dbcc3e4ee2d3596625e8c1226325180444a961.camel@sipsolutions.net>
Message-ID: <2b1ea1c4baedcb119f4e632b26399071@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-07-30 07:43, Johannes Berg wrote:
> On Wed, 2020-06-17 at 22:04 -0700, Aloka Dixit wrote:
>> + * @NL80211_FILS_DISCOVERY_TMPL: Optional FILS discovery template.
>> + *	It has contents of IEEE Std 802.11ai-2016 9.6.8.36 FILS discovery 
>> frame
>> + *	(Figure 9-687a).
> 
> Is that
> 
> "It has (contents of ... FILS discovery frame) ..."
> 
> or
> 
> "It has contents of (... FILS discovery frame) ..."?
> 
> I mean, is that with or without headers? The wording doesn't seem
> entirely clear to me.
> 
> OTOH, if it's with headers, how could it be optional? In fact, either
> way, how is it optional?
> 

Template has management frame headers as well. Will change the wording 
accordingly.
I made the template optional because FILS discovery may or may not be 
offloaded to FW.
Another way would be to make it mandatory here.

>> +static int nl80211_parse_fils_discovery(struct nlattr *attrs,
>> +					struct cfg80211_ap_settings *params)
>> +{
>> +	struct nlattr *tmpl;
>> +	struct nlattr *tb[NL80211_FILS_DISCOVERY_MAX + 1];
>> +	int ret;
>> +	struct cfg80211_fils_discovery *fd = &params->fils_discovery;
>> +
>> +	ret = nla_parse_nested(tb, NL80211_FILS_DISCOVERY_MAX, attrs,
>> +			       fils_discovery_policy, NULL);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!tb[NL80211_FILS_DISCOVERY_INT_MIN] ||
>> +	    !tb[NL80211_FILS_DISCOVERY_INT_MAX])
>> +		return -EINVAL;
>> +
>> +	fd->min_interval = nla_get_u32(tb[NL80211_FILS_DISCOVERY_INT_MIN]);
>> +	fd->max_interval = nla_get_u32(tb[NL80211_FILS_DISCOVERY_INT_MAX]);
>> +
>> +	tmpl = tb[NL80211_FILS_DISCOVERY_TMPL];
>> +	if (tmpl) {
>> +		fd->tmpl = nla_data(tmpl);
>> +		fd->tmpl_len = nla_len(tmpl);
> 
> And if it's with headers, it should have some kind of minimum length
> too? You've only put a maximum length into the policy.
> 
> (Which reminds me I wanted to have an NLA_POLICY_RANGE(NLA_BINARY, min,
> max) but haven't done that yet ...)
> 

Yeah, I looked through existing examples for NLA_BINARY, those provide 
only the higher bound for length.
But I can modify it to range once that is added.

> johannes
