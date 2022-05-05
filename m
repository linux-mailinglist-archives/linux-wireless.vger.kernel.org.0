Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8010651B760
	for <lists+linux-wireless@lfdr.de>; Thu,  5 May 2022 07:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243259AbiEEFOC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 01:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243260AbiEEFOB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 01:14:01 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B235B92
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 22:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651727422; x=1683263422;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cTUrDwVUOh1C3VgNnUrO1/QyZWlyktJmlbqijKCg0Pw=;
  b=JG47tUzfVm4Le7cxNbshhPAAq/d/70ert5fZeU691/Nku32XAKRai/ll
   aUkjm4jqSy646s1Z8bAcc+zZxT6CjQZYpE9Q5xtEU2QPqqOECj+AUDkMg
   4z+qXMoFJ3gcCSqiD+gDqKcGGE/K5RvcK/1Jzd/YNbfbmOBCQLEnwP0Zd
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 May 2022 22:10:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 22:10:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 4 May 2022 22:10:20 -0700
Received: from [10.50.36.195] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 4 May 2022
 22:10:18 -0700
Message-ID: <22bf2f78-587d-429b-867f-f73e542018d2@quicinc.com>
Date:   Thu, 5 May 2022 10:40:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] cfg80211: Add support for sending more than two AKMs
 in crypto settings
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <1650344143-1615-1-git-send-email-quic_vjakkam@quicinc.com>
 <cb419675d2ae276d9b4eac8ab5deafe62167051f.camel@sipsolutions.net>
From:   Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <cb419675d2ae276d9b4eac8ab5deafe62167051f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 5/5/2022 2:24 AM, Johannes Berg wrote:
> I don't know why, but this patch seems to cause memory corruption and
> various issues when I run the hwsim tests.
> 
Oh.. I ran some hwsim tests from hostap.git to verify the changes but 
didn't face any issues. Are you seeing the issues with any specific 
hwsim tests? Also, the issues are coming without any of the below 
changes also(i.e. with actual patch i sent)?

> I did make a few minor changes, but I think those were OK.
> 
> 
>> --- a/include/net/cfg80211.h
>> +++ b/include/net/cfg80211.h
>> @@ -1112,7 +1112,7 @@ struct cfg80211_crypto_settings {
>>   	int n_ciphers_pairwise;
>>   	u32 ciphers_pairwise[NL80211_MAX_NR_CIPHER_SUITES];
>>   	int n_akm_suites;
>> -	u32 akm_suites[NL80211_MAX_NR_AKM_SUITES];
>> +	u32 *akm_suites;
> 
> I made this const, that required a bit of juggling in the wext code, but
> it's probably still better overall.
> 
>>   
>> +	/*
>> +	 * Maximum number of AKM suites allowed for NL80211_CMD_CONECT,
>> +	 * NL80211_CMD_ASSOCIATE and NL80211_CMD_START_AP, must be at least
>> +	 * NL80211_MAX_NR_AKM_SUITES to avoid issues with legacy userspace.
>> +	 */
>> +	if (WARN_ON(wiphy->max_num_akm_suites &&
>> +		    wiphy->max_num_akm_suites < NL80211_MAX_NR_AKM_SUITES))
>> +		return -EINVAL;
> 
> I made it so here if it's 0 we set it to NL80211_MAX_NR_AKM_SUITES, that
> way we don't need to have all the questions about it being 0 later.
> 
>> +		if (nla_put_u16(msg, NL80211_ATTR_MAX_NUM_AKM_SUITES,
>> +				rdev->wiphy.max_num_akm_suites ?
>> +				rdev->wiphy.max_num_akm_suites :
>> +				NL80211_MAX_NR_AKM_SUITES))
>> +			goto nla_put_failure;
> 
> e.g. here, that was then without the ternary operator
> 
>> +		int max_num_akm_suites = NL80211_MAX_NR_AKM_SUITES;
>>   
>>   		data = nla_data(info->attrs[NL80211_ATTR_AKM_SUITES]);
>>   		len = nla_len(info->attrs[NL80211_ATTR_AKM_SUITES]);
>> @@ -10261,10 +10269,13 @@ static int nl80211_crypto_settings(struct cfg80211_registered_device *rdev,
>>   		if (len % sizeof(u32))
>>   			return -EINVAL;
>>   
>> -		if (settings->n_akm_suites > NL80211_MAX_NR_AKM_SUITES)
>> +		if (rdev->wiphy.max_num_akm_suites)
>> +			max_num_akm_suites = rdev->wiphy.max_num_akm_suites;
>> +
>> +		if (settings->n_akm_suites > max_num_akm_suites)
>>   			return -EINVAL;
>>   
>> -		memcpy(settings->akm_suites, data, len);
>> +		settings->akm_suites = data;
> 
> and all that complexity also goes away
> 
>> +	if (connect->crypto.n_akm_suites) {
>> +		wdev->conn->params.crypto.akm_suites =
>> +			kcalloc(connect->crypto.n_akm_suites, sizeof(u32),
>> +				GFP_KERNEL);
>> +		if (!wdev->conn->params.crypto.akm_suites) {
>> +			cfg80211_sme_free(wdev);
>> +			return -ENOMEM;
>> +		}
>> +
>> +		wdev->conn->params.crypto.n_akm_suites =
>> +			connect->crypto.n_akm_suites;
>> +		memcpy(wdev->conn->params.crypto.akm_suites,
>> +		       connect->crypto.akm_suites,
>> +		       sizeof(u32) * connect->crypto.n_akm_suites);
> 
> I made this use kmemdup(), I don't think it makes a big difference.
> 
> Anyway, it crashes. Perhaps an invalid free, because the middle of some
> netlink packet is being freed or so? >
> Please check.
Sure, I will try with suggested changes and update you

> 
> johannes

-- 
veeru
