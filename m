Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537EE607843
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 15:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiJUNVs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 09:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiJUNVr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 09:21:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E806D25F8E5
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 06:21:44 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L8gaom017184;
        Fri, 21 Oct 2022 13:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5AdyH5Fo3kM0bNwr47eQOvCVJbOfW/dVoI8n5stFD1g=;
 b=VuafSWCt+qB/nL9rMetn1303gnyAFfEJZIlpICOE8BdBKxmDcVnkfuPpnDqcacOpzQBb
 Ohu+ej48fbSJQrE7w2KtLHHBh0he64+ndMHtQXYnEUCviDMqFz9wfWPFWtXmDqdV7kIF
 c8KF/bnwStEwKj6mGyapNjma0eRsaur0GjC/GEI9z1mx09a/urNaD1RAcw71gTl0139E
 KkqAEUAVl4PdQBlhfnTsbWr+V0241BEPodmuI6552swEegZlLEPWB46CrcQbrlRBez/X
 8MS6BTAisjYYnLUD+U2k4jv81OpQ17dJCMchuIbPhczpdX8WPyoarvLYp7t/6yCRXIPt UA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kbr4f91ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 13:21:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29LDLfpo019612
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 13:21:41 GMT
Received: from [10.216.6.194] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 21 Oct
 2022 06:21:39 -0700
Message-ID: <34823783-4bdb-9e0b-80b8-27d18b6c1d15@quicinc.com>
Date:   Fri, 21 Oct 2022 18:51:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC 3/4] wifi: cfg80211/mac80211: extend iface comb
 advertisement for multi-hardware dev
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20220920100518.19705-1-quic_vthiagar@quicinc.com>
 <20220920100518.19705-4-quic_vthiagar@quicinc.com>
 <cca0f1a361400e71f41027e3f5e9a2c9353c008f.camel@sipsolutions.net>
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <cca0f1a361400e71f41027e3f5e9a2c9353c008f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aDtcLtUKXE1goP7HtF3gp5DkexNBHEAJ
X-Proofpoint-GUID: aDtcLtUKXE1goP7HtF3gp5DkexNBHEAJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210080
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 10/21/2022 5:52 PM, Johannes Berg wrote:
> On Tue, 2022-09-20 at 15:35 +0530, Vasanthakumar Thiagarajan wrote:
>>
>> +struct ieee80211_iface_per_hw {
>> +	u8 hw_chans_idx;
>> +	const struct ieee80211_iface_limit *limits;
>> +	u32 num_different_channels;
>> +	u16 max_interfaces;
>> +	u8 n_limits;
>> +};
> 
> nit: moving hw_chans_idx last would get rid of all the padding :)

Oops, I missed to check this, thanks.

> 
> 
>> + *    Drivers advertising per-hardware interface combination should also
>> + *    advertise a sub-set of capabilities using existing interface mainly for
>> + *    maintaining compatibility with the user space which is not aware of the
>> + *    new per-hardware advertisement.
>> + *
>> + *    Sub-set interface combination advertised in the existing infrastructure:
>> + *    Allow #STA <= 1, #AP <= 1, channels = 1, total 2
>> + *
>> + *    .. code-block:: c
>> + *
>> + *	struct ieee80211_iface_limit limits4[] = {
>> + *		{ .max = 1, .types = BIT(NL80211_IFTYPE_STATION), },
>> + *		{ .max = 1, .types = BIT(NL80211_IFTYPE_AP), },
>> + *	};
>> + *	struct ieee80211_iface_limit limits5_2ghz[] = {
>> + *		{ .max = 1, .types = BIT(NL80211_IFTYPE_STATION), },
>> + *		{ .max = 1, .types = BIT(NL80211_IFTYPE_AP), },
>> + *	};
>> + *	struct ieee80211_iface_limit limits5_5ghz[] = {
>> + *		{ .max = 1, .types = BIT(NL80211_IFTYPE_STATION), },
>> + *		{ .max = 2, .types = BIT(NL80211_IFTYPE_AP), },
>> + *	};
> 
> Where does the limits4/limits5 naming come from? The number of
> interfaces I guess? To me that wasn't so clear, maybe it makes more
> sense to name them
> 
> 	limits_overall,
> 	limits_2ghz, and
> 	limits_5ghz
> 
> respectively?

Yes, this is more clear.

> 
> (yeah, obviously I know this is just an example)
> 

This is very critical reference for the interface combination

>> +/**
>> + * cfg80211_hw_chans_includes_dfs - check if per-hardware channel includes DFS
>> + *	@chans: hardware channel list
> 
> prefer space instead of tab I think?
> 
>> + * Please note the channel is checked against the entire range of DFS
>> + * freq in 5 GHz irrespective of regulatory configurations.
> 
> Not sure what you mean by this? Is that different somehow from what we
> did before?
> 

Normally the DFS marking in the channel is done based on the regulatory
settings for the allowed channels. But here it is a bit different in a 
sense that the channel is to validated against the complete set of DFS 
channels irrespective of the regulatory domain because it is done in
the registration time. Added that note so that the helper is not used
for the regular channel operation.


>> +++ b/net/mac80211/main.c
>> @@ -933,6 +933,45 @@ static int ieee80211_init_cipher_suites(struct ieee80211_local *local)
>>   	return 0;
>>   }
>>   
>> +static int
>> +ieee80211_check_per_hw_iface_comb(struct ieee80211_local *local,
>> +				  const struct ieee80211_iface_combination *c)
>> +{
> 
> Why is this in mac80211? Wouldn't such a check apply equally to any non-
> mac80211 driver?

I had this confusion. I see few sanity checks duplicated in mac80211 in 
the existing code. But you are right, most of this should belong to 
cfg80211.

> 
>> +	int h, l;
>> +	u32 hw_idx_bm = 0;
>> +
>> +	if (!local->use_chanctx)
>> +		return -EINVAL;
> 
> Maybe mac80211 has this extra check, and can keep it, but
> 
>> +
>> +	for (h = 0; h < c->n_hw_list; h++) {
>> +		const struct ieee80211_iface_per_hw *hl;
>> +		const struct ieee80211_chans_per_hw *chans;
>> +
>> +		hl = &c->iface_hw_list[h];
>> +
>> +		if (hl->hw_chans_idx >= local->hw.wiphy->num_hw)
>> +			return -EINVAL;
>> +
>> +		chans = local->hw.wiphy->hw_chans[hl->hw_chans_idx];
>> +		if (c->radar_detect_widths &&
>> +		    cfg80211_hw_chans_includes_dfs(chans) &&
>> +		    hl->num_different_channels > 1)
>> +			return -EINVAL;
>> +
>> +		for (l = 0; l < hl->n_limits; l++)
>> +			if ((hl->limits[l].types & BIT(NL80211_IFTYPE_ADHOC)) &&
>> +			    hl->limits[l].max > 1)
>> +				return -EINVAL;
>> +
>> +		if (hw_idx_bm & BIT(h))
>> +			return -EINVAL;
>> +
>> +		hw_idx_bm |= BIT(h);
> 
> this pretty much seems applicable to do in cfg80211?

Sure.

> 
>> @@ -1035,6 +1074,21 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
>>   		}
>>   	}
>>   
>> +	for (i = 0; i < local->hw.wiphy->n_iface_combinations; i++) {
>> +		const struct ieee80211_iface_combination *comb;
>> +
>> +		comb = &local->hw.wiphy->iface_combinations[i];
>> +
>> +		if (comb->n_hw_list && !local->hw.wiphy->num_hw)
>> +			return -EINVAL;
>> +
>> +		if (!comb->n_hw_list)
>> +			continue;
>> +
>> +		if (ieee80211_check_per_hw_iface_comb(local, comb))
>> +			return -EINVAL;
>> +	}
> 
> and this then, of course.
> 
>> +++ b/net/wireless/core.c
>> @@ -563,10 +563,126 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
>>   }
>>   EXPORT_SYMBOL(wiphy_new_nm);
>>   
>> +static int
>> +wiphy_verify_comb_limit(struct wiphy *wiphy,
>> +			const struct ieee80211_iface_limit *limits,
>> +			u8 n_limits, u32 bcn_int_min_gcd, u32 *iface_cnt,
>> +			u16 *all_iftypes)
> 
> oh wait, you did it twice?
> 
> is there anything that mac80211 adds extra?
> 
>>   static int wiphy_verify_combinations(struct wiphy *wiphy)
>>   {
>>   	const struct ieee80211_iface_combination *c;
>> -	int i, j;
>> +	int i;
>> +	int ret;
>>   
>>   	for (i = 0; i < wiphy->n_iface_combinations; i++) {
>>   		u32 cnt = 0;
>> @@ -593,54 +709,11 @@ static int wiphy_verify_combinations(struct wiphy *wiphy)
>>   		if (WARN_ON(!c->n_limits))
>>   			return -EINVAL;
>>   
>> -		for (j = 0; j < c->n_limits; j++) {
>> -			u16 types = c->limits[j].types;
>>
> [...]
>> +		ret = wiphy_verify_comb_limit(wiphy, c->limits, c->n_limits,
>> +					      c->beacon_int_min_gcd,
>> +					      &cnt, &all_iftypes);
> 
> 
> Might be nice to break out this refactoring to a separate patch (and
> feel free to send it right away as PATCH, it's kind of worthwhile
> anyway), I think? Unless I missed something that changed here, but then
> it'd be even more worthwhile so I see it ;-)
> 
>> +bool
>> +cfg80211_hw_chans_includes_dfs(const struct ieee80211_chans_per_hw *chans)
>> +{
> 
> [...]
>> +EXPORT_SYMBOL(cfg80211_hw_chans_includes_dfs);
> 
> Since it's exported - who would use it and for what?

This was used in mac80211 sanity checker :) This will go away finally.

Thanks!

Vasanth
