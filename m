Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98762A7D13
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Nov 2020 12:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbgKELdp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Nov 2020 06:33:45 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:28087 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730152AbgKELc0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Nov 2020 06:32:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604575946; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=tvHQg0ZoHXpE4ayeyfVb3i3qkFktcJdGNcSl1maiUfI=;
 b=OJpGSIxe782bIR+a+TS7W+cJwLlWLPMn2wrOFoIKa3jcqwOshIXWVaYJ/oL5bN/df++yvuR3
 n1KPlC17qKbL3rpIfwierZnADxgIjz8fVILu6dpnyCA1rcA2654+RqiIua5QpEK/WJ5nCHTi
 HP9U1jqy/WTqSrEPuGXHcU3Yzw0=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fa3e26ef152c56ebff7273c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 05 Nov 2020 11:30:54
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A6158C433F0; Thu,  5 Nov 2020 11:30:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD48EC433C6;
        Thu,  5 Nov 2020 11:30:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Nov 2020 19:30:53 +0800
From:   Carl Huang <cjhuang@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-wireless@vger.kernel.org, dianders@chromium.org,
        ath10k@lists.infradead.org, kuabhs@google.com
Subject: Re: [RFC 1/2] nl80211: add common API to configure SAR power
 limitations.
In-Reply-To: <20201104232706.GC3212577@google.com>
References: <1600753775-4745-1-git-send-email-cjhuang@codeaurora.org>
 <20201104232706.GC3212577@google.com>
Message-ID: <63b38ac1969ecb29b8e57918c17a6ce5@codeaurora.org>
X-Sender: cjhuang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-05 07:27, Brian Norris wrote:
> Hi Carl,
> 
> Sorry, I lied; I have a few more notes after spending another day
> looking at this:
> 
> On Tue, Sep 22, 2020 at 01:49:34PM +0800, Carl Huang wrote:
>> --- a/include/net/cfg80211.h
>> +++ b/include/net/cfg80211.h
>> @@ -1663,6 +1663,55 @@ struct station_info {
>> +/**
>> + * @struct cfg80211_sar_chan_ranges - sar frequency ranges
>> + * @index: the index of this range. It's used to specify
>> + *	the frequency range when setting SAR power limitation
>> + * @start_freq:  start channel frequency in kHZ. For example,
>> + *	2.4G channel 1 is represented as 2412000
>> + * @end_freq:    end channel frequency in kHZ
> 
> If you accept my comments in nl80211.h, you'll want to change this too.
> 
Yes.

>> + */
>> +struct cfg80211_sar_freq_ranges {
>> +	u8 index;
>> +	u32 start_freq;
>> +	u32 end_freq;
>> +};
> 
>> --- a/include/uapi/linux/nl80211.h
>> +++ b/include/uapi/linux/nl80211.h
> 
>> + * @NL80211_SAR_ATTR_SPECS_START_FREQ: Required (u32) value to 
>> specify the start
>> + *	frequency of this range to register SAR capability to wihpy and 
>> the unit
>> + *	is kHZ
>> + *
>> + * @NL80211_SAR_ATTR_SPECS_END_FREQ: Required (u32) value to specify 
>> the end frequency
>> + *	of this range to register SAR capability to wiphy and the unit is 
>> kHZ
> 
> The documentation here isn't clear whether these are center frequencies
> or band edges. The cfg80211 comments do though (center freq). However,
> this is inconsistent with NL80211_ATTR_FREQ_RANGE_START and
> NL80211_ATTR_FREQ_RANGE_END -- I'd suggest being consistent?
> 
Yes. Will change to band edge.

>> --- a/net/mac80211/cfg.c
>> +++ b/net/mac80211/cfg.c
> 
>> @@ -15331,6 +15496,14 @@ static const struct genl_ops nl80211_ops[] = 
>> {
>>  		.internal_flags = NL80211_FLAG_NEED_NETDEV |
>>  				  NL80211_FLAG_NEED_RTNL,
>>  	},
>> +	{
>> +		.cmd = NL80211_CMD_SET_SAR_SPECS,
>> +		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>> +		.doit = nl80211_set_sar_specs,
>> +		.flags = GENL_UNS_ADMIN_PERM,
>> +		.internal_flags = NL80211_FLAG_NEED_NETDEV_UP |
> 
> Is there a reason this needs to be UP? CMD_SET_WIPHY (which can also
> configure TX power, a little differently) does not. Seems like this
> could just be NL80211_FLAG_NEED_NETDEV -- or maybe not even that, if we
> switch this to a WIPHY command like Johannes noted.
> 

Will change to NL80211_FLAG_NEED_WIPHY.

> Brian
> 
>> +				  NL80211_FLAG_NEED_RTNL,
>> +	},
>>  };
> 
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
