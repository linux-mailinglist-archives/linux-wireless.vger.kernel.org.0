Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D50F5428C5
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 10:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiFHH7H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 03:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbiFHH6H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 03:58:07 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C1C6CF4E
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 00:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654673309; x=1686209309;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mqgLYiGtASjyGZDbpOPRQqhMDcUPy4/uczoT9mvp/7o=;
  b=QGjFf3uHwbsRegPUCevzGVnGjjmKJ8ZJKOiyTjfg3Ry1/lK6q0z92SYJ
   QGdtPhLDx/WH2PLuwspacKp0URbZ9E8WlKgytN8yJ4zBw/6jrsGhY5e6i
   QevkdhZJxY8yfIFCNdrLwts0P/UtqK8qMHMbniHNrSLDBAxhAkAP4R0rr
   c=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Jun 2022 00:28:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 00:28:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 8 Jun 2022 00:28:28 -0700
Received: from [10.216.28.56] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 8 Jun 2022
 00:28:26 -0700
Message-ID: <3f9dd3ca-03b1-18a7-b245-9b53357d6144@quicinc.com>
Date:   Wed, 8 Jun 2022 12:58:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC v2] cfg80211: Indicate MLO connection info in connect and
 roam callbacks
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
CC:     <linux-wireless@vger.kernel.org>
References: <1654536690-12588-1-git-send-email-quic_vjakkam@quicinc.com>
 <25ed0281-0880-1e8f-154c-53ee056e8879@quicinc.com>
 <43dc2cc68300070b3727f63ea796fc327664174d.camel@sipsolutions.net>
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <43dc2cc68300070b3727f63ea796fc327664174d.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 6/8/2022 12:53 PM, Johannes Berg wrote:
> On Tue, 2022-06-07 at 17:24 -0700, Jeff Johnson wrote:
>>> +		struct nlattr *nested;
>>> +
>>> +		nested = nla_nest_start(msg, NL80211_ATTR_MLO_LINKS);
>>> +		if (!nested)
>>> +			goto nla_put_failure;
>>> +
>>> +		for_each_valid_link(cr, link) {
>>> +			struct nlattr *nested_mlo_links;
>>> +			const u8 *bssid = cr->links[link].bss ?
>>> +					  cr->links[link].bss->bssid :
>>> +					  cr->links[link].bssid;
>>> +
>>> +			nested_mlo_links = nla_nest_start(msg, i + 1);
>> why i+1?
>> if you don't want to use 0 for the first entry (why not?) then init i to 1
>>
>> alternately since this is the only place i is used, use ++i or i++ as
>> you see fit and remove the i++ later
>>
>> ultimately we should only need to calculate i+1 once
>>
>> these comments apply to nl80211_send_roamed() as well
>>
>> (BTW I do see this pattern in some of the existing code, but I also see
>> 0 being used for the first record)
>>
> Yeah, we're not very consistent with this ...
>
> The background is that this ends up being an attribute, so the structure
> is
>
> NL80211_ATTR_MLO_LINKS = {
>    1 = {
>      NL80211_ATTR_MLO_LINK_ID = <integer>,
>      ...
>    },
>    ...
> }
>
> so the "1" there is an attribute. Netlink says that attribute number 0
> is invalid, and that's enforced if you were to try nla_parse_nested() or
> so on the data of the NL80211_ATTR_MLO_LINKS attribute.
>
> Now, nla_for_each_nested() doesn't care, and that's almost certainly
> what gets used in the parser side of this, since the attribute number
> doesn't even matter.
>
> (We could use the link ID as the attribute number, but 0 is a valid link
> ID and technically documented to not be a valid attribute number, so
> ...)
>
>
> So I can see where this is coming from, and I don't really think it
> matters. The compiler will almost certainly emit the same code anyway,
> or at least I'd hope so :)
>
> We probably have this pattern a few times ...
>
> If we ignore the documentation further, we could even always use 0 for
> the number, nla_for_each_nested() still won't care... but then we _try_
> to do the right thing, except sometimes probably get it wrong with 0 vs.
> 1 starting.
>
>
> Anyway, I guess it makes sense to just write it as
>
> 	int i = 1;
> ...
> 		nla_nest_start(msg, i);
>
> instead, and we need a [PATCH] resubmit of this anyway I guess.
>
> johannes


Thanks Jeff and Johannes for the comments. I will address the comments 
and will resend it as [PATCH]

