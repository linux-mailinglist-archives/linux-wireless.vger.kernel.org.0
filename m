Return-Path: <linux-wireless+bounces-15677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89F89D7B17
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 06:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69CA8281366
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 05:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105C92E62B;
	Mon, 25 Nov 2024 05:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S15Y+6Zi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2122AE7F
	for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2024 05:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732512097; cv=none; b=cVR1CekTQPgMDMsb8j9j10OItgpfI/9Ak6s4LUthuGhS5yqSa39tGbpKvWySmZyryiQVupEQBf4KIVfhYPDhOibMCPLyIyC/gumhZKnelTEYwiaThfY6YoV94ye+Gey3giszeKuMH5IWr6zFxI8Wzej4x5eL4+AvUp3MxsfoMgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732512097; c=relaxed/simple;
	bh=dK+bFhB8QR4H6uQUe9V5e465MLFOyU1f9ubGcrQsx7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sBBAPihMtOC6/1+s4vHpogiIsWuyhi5zrdoxZbeDADOxHaCFOPUKeAbJwYU8SBHZ8jjjmyZ0sk+sysBWafswNcdzJS1XB1AQ5N+YfAGan6luhsv+wNAiH0eppY3D73zaXR4WwN2bv4Ndqu6PjR/vrNU6TBlJf+0YLsazMD1fGo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S15Y+6Zi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AONClD7005923;
	Mon, 25 Nov 2024 05:21:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5uH1QZnIa8/0sw8bfAbNi0JhJWduX9Y24owxBx5G9BA=; b=S15Y+6ZinA0lcnqE
	gBKnNM5gkZB1sS9SnQNnOJRZPxuKi//0nFokHdwtyns3fQG7Mxv6WjL96Mt5HFmi
	yKpZNExazqyKMq/zT0LTz43uuWhk3M4pAqSasSXsBBabA7ALvbgDVAd53CmcV+LT
	j708p8BhH6ppOCPfjul4+n1pnT2XM1/hDeg0evg/06R9GHfSb/qIDwQMack96FRR
	8QGCrrpC29ueGiYPo2LFSpMG1elPyVrZwCYbszwXI9NTXXv6SClc9H3XAvavyBhJ
	dkwBHFTtImyImED1Ptj/FL2CGFMrlr3ti0FWaRPEKHgb4r9j92uSi8sjHUT79iKC
	mAuh6A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 433dny2trp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 05:21:29 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AP5LSPB009938
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 05:21:28 GMT
Received: from [10.204.117.236] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 24 Nov
 2024 21:21:26 -0800
Message-ID: <16790501-a326-4f00-9dd1-9c4795c1862e@quicinc.com>
Date: Mon, 25 Nov 2024 10:51:09 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: skip regulatory checks when the channel
 is punctured
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_mpaluri@quicinc.com>,
        "Aditya
 Kumar Singh" <quic_adisi@quicinc.com>
References: <20240826123341.5405-1-quic_kkavita@quicinc.com>
 <cfc85dc7bf175cc4237d9d1423b0101b9162f727.camel@sipsolutions.net>
Content-Language: en-US
From: Kavita Kavita <quic_kkavita@quicinc.com>
In-Reply-To: <cfc85dc7bf175cc4237d9d1423b0101b9162f727.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NUVlRYPMMMp9KeB3HtN9Two9ccNmyLY0
X-Proofpoint-ORIG-GUID: NUVlRYPMMMp9KeB3HtN9Two9ccNmyLY0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250044



On 8/28/2024 3:51 PM, Johannes Berg wrote:
> On Mon, 2024-08-26 at 18:03 +0530, Kavita Kavita wrote:
>> The kernel performs several regulatory checks for AP mode in
>> nl80211/cfg80211. These checks include radar detection,
>> verification of whether the sub-channel is disabled, and
>> an examination to determine if the channel is a DFS channel
>> (both DFS usable and DFS available). These checks are
>> performed across a frequency range, examining each sub-channel.
>>
>> However, these checks are also performed on frequencies that
>> have been punctured, which should not be examined as they are
>> not in use.
> 
> Makes sense.
> 
>> This leads to the issue where the AP stops because one of
>> the 20 MHz sub-channels is disabled or radar detected on
>> the channel, even when the sub-channel is punctured.
> 
> I'm curious, how did that even happen? How did it detect radar on a
> punctured channel in the first place?
> 
> Or are you saying it was detected before, but you say "the AP stops"
> rather than "the AP fails to start"?
> 

One of the use cases we are targeting here is after AP start, if radar 
is detected, SME offload drivers can indicate a channel switch with the 
radar-detected channel as punctured instead of switching to a new 
channel. But when the driver does this, currently the kernel stops the 
AP even after the driver punctures that channel.

Also, for the AP start case mentioned, the AP shouldn't stop or fail to 
start if the radar-detected channel is punctured in the START_AP command.

> However, this possibly also points to something that's missing in this
> patch and/or Aditya's patchset: if we do radar detection with a chandef
> that's already punctured, we don't know that all the subchannels were
> actually radar-free, and shouldn't mark them accordingly.
> 
> I think it'd make sense to incorporate that here as well, could you do
> that?
> 


Thanks, I added some additional changes in the v2 patch to handle this.

>> @@ -781,7 +784,7 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
>>   
>>   		ret = cfg80211_get_chans_dfs_required(wiphy,
>>   					MHZ_TO_KHZ(chandef->center_freq2),
>> -					width, iftype);
>> +					width, chandef->punctured, iftype);
> 
> This isn't really right: center_freq2 is for 80+80 which cannot use
> puncturing, certainly cannot use puncturing in the secondary 80. It's
> probably not strictly wrong either since 80+80 cannot be legal with
> puncturing in the first place, but this really should just pass 0 I'd
> think.
> 

Thanks, I fixed this in the v2 patch.

>> @@ -868,7 +877,7 @@ bool cfg80211_chandef_dfs_usable(struct wiphy *wiphy,
>>   		WARN_ON(!chandef->center_freq2);
>>   		r2 = cfg80211_get_chans_dfs_usable(wiphy,
>>   					MHZ_TO_KHZ(chandef->center_freq2),
>> -					width);
>> +					width, chandef->punctured);
> 
> same here
> 
>> @@ -1113,7 +1128,7 @@ static bool cfg80211_chandef_dfs_available(struct wiphy *wiphy,
>>   		WARN_ON(!chandef->center_freq2);
>>   		r = cfg80211_get_chans_dfs_available(wiphy,
>>   					MHZ_TO_KHZ(chandef->center_freq2),
>> -					width);
>> +					width, chandef->punctured);
> 
> and here, obviously
> 
>> @@ -1139,6 +1155,12 @@ static unsigned int cfg80211_get_chans_dfs_cac_time(struct wiphy *wiphy,
>>   		if (!c)
>>   			return 0;
>>   
>> +		if (punctured & 1) {
>> +			punctured >>= 1;
>> +			continue;
>> +		}
>> +		punctured >>= 1;
>> +
>>   		if (c->flags & IEEE80211_CHAN_DISABLED)
>>   			return 0;
> 
> We have this pattern a lot! I think perhaps we should add a kind of
> for_each_subchannel() macro?
> 
> Perhaps even iterate subchannels of a chandef including center_freq2,
> though I'm not sure how we'd arrange that...
> 
> Something like cfg80211_wdev_on_sub_chan() also seems to need to take
> puncturing into account and could be rewritten with such a helper.
> 
> #define for_each_subchannel(chandef, subchan)
>    for (subchan = ieee80211_next_subchan(chandef, NULL);
>         subchan;
>         subchan = ieee80211_next_subchan(chandef, subchan))
> 
> or so, with ieee80211_next_subchan() containing some necessary iteration
> logic?
> 

Added macro for_each_subchan() in v2 patch.

I tried to handle traversing both center_freq1 and center_freq2 with 
for_each_subchannel(chandef, subchan) as suggested by you, but it's 
complicated to handle both center_freq1 and center_freq2 cases together 
due to their different handling requirements.

> johannes


