Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B71860772E
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 14:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJUMqB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 08:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJUMp7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 08:45:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AC126206E
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 05:45:58 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29LA8mXb007645;
        Fri, 21 Oct 2022 12:45:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Yfve1U8hUmQqoztTTHqXWuzB71y3OyEqQqDK2VgqXUw=;
 b=UzdHQ16WsNt/5baWD8vB9SSyc+zSx+vHxpmIuBrHi90BdwYjNqZ18gJcURmPn7i8ZITc
 EHs6YBMYay0p/toScycKOMRaWzEO0UIS2bhVGLvAeTCYtpl0Z5vc1eOtGJHR4OB66glA
 gSKdtygPmEHih0UeOkn/1o+JOQjK5clP6ECLrCXU814P+keYS9YRqKxFTKMQoUweBzmR
 kwAsL6xWhwHKK3hknuNDbK7Dt4++o6nxXStnu70/Qk+kRG+LGp32+1SuUdrDQsjhq2Ai
 bH+kUQr3zDebj6mHvWFRNRqChuoO3cmptSS/0n4iKhpdxeUMU+psOaDegUb8I7HEnDjQ eQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kak1c5nkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 12:45:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29LCjrrF025132
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Oct 2022 12:45:53 GMT
Received: from [10.216.6.194] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 21 Oct
 2022 05:45:52 -0700
Message-ID: <2a731aab-8783-209b-dc6a-abbc8265b68a@quicinc.com>
Date:   Fri, 21 Oct 2022 18:15:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC 1/4] wifi: cfg80211: Add provision to advertise multiple
 radio in one wiphy
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20220920100518.19705-1-quic_vthiagar@quicinc.com>
 <20220920100518.19705-2-quic_vthiagar@quicinc.com>
 <0af1c2b6e7b964b559989e860e600a5c27372e83.camel@sipsolutions.net>
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <0af1c2b6e7b964b559989e860e600a5c27372e83.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DQMuBFvUm6ZiA2palgg6SoiR6Oykl6wX
X-Proofpoint-ORIG-GUID: DQMuBFvUm6ZiA2palgg6SoiR6Oykl6wX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_04,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 adultscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210210075
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 10/21/2022 5:34 PM, Johannes Berg wrote:
> On Tue, 2022-09-20 at 15:35 +0530, Vasanthakumar Thiagarajan wrote:
>> The prerequisite for MLO support in cfg80211/mac80211 is that all
>> the links participating in MLO must be from the same wiphy/ieee80211_hw.
>> To meet this expectation, some drivers may need to group multiple discrete
>> hardware each acting as a link in MLO under one wiphy. Though most of the
>> hardware abstractions must be handled within the driver itself, it may be
>> required to have some sort of mapping while describing interface
>> combination capabilities for each of the underlying hardware. This commit
>> adds an advertisement provision for drivers supporting such MLO mode of
>> operation.
>>
>> Capability advertisement such as the number of supported channels for each
>> physical hardware has been identified to support some of the common use
>> cases.
>>
>> Signed-off-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
>> ---
>>   include/net/cfg80211.h |  24 +++++++++
>>   net/wireless/core.c    | 109 +++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 133 insertions(+)
>>
>> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
>> index e09ff87146c1..4662231ad068 100644
>> --- a/include/net/cfg80211.h
>> +++ b/include/net/cfg80211.h
>> @@ -5088,6 +5088,18 @@ struct wiphy_iftype_akm_suites {
>>   	int n_akm_suites;
>>   };
>>   
>> +/**
>> + * struct ieee80211_supported_chans_per_hw - supported channels as per the
>> + * underlying physical hardware configuration
>> + *
>> + * @n_chans: number of channels in @chans
>> + * @chans: list of channels supported by the constituent hardware
>> + */
>> +struct ieee80211_chans_per_hw {
>> +	int n_chans;
> 
> nit: unsigned?
> 
>> + * @hw_chans: list of the channels supported by every constituent underlying
> 
> "every" here refers to the fact that you have all the channels, right? I
> mean, hw_chans is per hardware, basically.

Correct, it refers all the channels supported per hardware registered 
something like below

hw_chans[0] =	{
  			// 2 GHz radio
			<num_2ghz_chans>,
			{
				<ieee80211_channel_2ghz_1>,
				<ieee80211_channel_2ghz_2>, ...
			}
		}

hw_chans[1] = {
		{
  			// 5 GHz radio
			<num_5ghz_chans>,
			{
				<ieee80211_channel_5ghz_1>,
				<ieee80211_channel_5ghz_2>, ...
			}
		}
		
...


> 
>> + *	hardware. Drivers abstracting multiple discrete hardware (radio) under
>> + *	one wiphy can advertise the list of channels supported by each physical
>> + *	hardware in this list. Underlying hardware specific channel list can be
>> + *	used while describing interface combination for each of them.
>> + * @num_hw: number of underlying hardware for which the channels list are
>> + *	advertised in @hw_chans.
>> + *
>>    */
>>   struct wiphy {
>>   	struct mutex mtx;
>> @@ -5445,6 +5466,9 @@ struct wiphy {
>>   	u8 ema_max_profile_periodicity;
>>   	u16 max_num_akm_suites;
>>   
>> +	struct ieee80211_chans_per_hw **hw_chans;
>> +	int num_hw;
> 
> also here, maybe unsigned.
> 
>> +static bool
>> +cfg80211_hw_chans_in_supported_list(struct wiphy *wiphy,
>> +				    const struct ieee80211_chans_per_hw *chans)
>> +{
>> +	enum nl80211_band band;
>> +	struct ieee80211_supported_band *sband;
>> +	bool found;
>> +	int i, j;
>> +
>> +	for (i = 0; i < chans->n_chans; i++) {
>> +		found = false;
> 
> nit: you can move the variable declaration here
> 
> 	bool found = false;
> 	\n
> 
> since you don't need it outside the loop.
> 
>> +	for (i = 0; i < wiphy->num_hw; i++) {
>> +		for (j = 0; j < wiphy->num_hw; j++) {
>> +			const struct ieee80211_chans_per_hw *hw_chans1;
>> +			const struct ieee80211_chans_per_hw *hw_chans2;
>> +
>> +			if (i == j)
>> +				continue;
> 
> It's symmetric, if I read the code above right, so you can do
> 
> 	for (j = i; j < ...; j++)
> 
> in the second loop and avoid this?

Sure

> 
> 
>> +		hw_chans = wiphy->hw_chans[i];
>> +		if (!cfg80211_hw_chans_in_supported_list(wiphy, hw_chans)) {
>> +			WARN_ON(1);
> 
> I can kind of see the point in not using WARN_ON(!cfg80211_hw_chans...)
> since it gets really long, but maybe just remove the warning?
>   
>> +	if (cfg80211_validate_per_hw_chans(&rdev->wiphy)) {
>> +		WARN_ON(1);
>> +		return -EINVAL;
>>
> 
> Anyway you'll have one here, and it's not directly visible which
> condition failed anyway.
> 
> And you could use WARN_ON(validate(...)) here :)

Sure, thanks!

Vasanth
