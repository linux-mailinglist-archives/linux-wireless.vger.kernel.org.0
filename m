Return-Path: <linux-wireless+bounces-7290-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E088BE621
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 16:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4949B26E2A
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 14:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253AE15FA63;
	Tue,  7 May 2024 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T4du+4mb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A4C1514C5
	for <linux-wireless@vger.kernel.org>; Tue,  7 May 2024 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715092540; cv=none; b=lVSK55FEJiRoqbkMLZU1UVkIEXhfCdPVINKI7AdxAZQyd+rWfKT8hY+PZJDYG2QM00RsGIa66l/GZDXfLA0DsTY2LrcBd/tTrJbIZh04FmDSVM+C5KCGCsOyoL1wpRIRJK187VwNbvaqJ/L6D76XnMgiVBUu2H2qLpWvgVVoaVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715092540; c=relaxed/simple;
	bh=U9sjjNWRXLW1JnUj8XSo5gqCjAAy7qwoC0e0VljA3C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NAp9ZW5mavHI6vH/MNe89q4rAfb8/PqBudhPDktgimD9IdfLC7dt7Ast7vr/b7i9U8DRF85jzgRBUFYMu/r4e649otHSnHo3UKn8nWPNvIpXQtMfqfjKSieAb0Es0iTCYUbLm9M8wS1jCQpBOcbcCoQboWInO5Psn7tLo7FqxpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T4du+4mb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 447BTHP1009585;
	Tue, 7 May 2024 14:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=g9eZjM8TZq3HQJBCrmbeXv9VLARCEt7Z9RPIMfiyBUQ=; b=T4
	du+4mb+V/2k0JS92W+hcOA6Z/mTt4AyAIIxMdKOokltr4302L0uO9F63lNLyxP8n
	wrgy5USO9qsC9THeaj1QzXJUrXDER3WQVLKq/Y9Ca7qgolVOFRUJz+9iGyDM5o3h
	eoJWPXkKBPYnLH0T5M799oOFO72aWjnAvgO2++O7wuOygXI/3YoglZFwv6mBLD9J
	GW+xyVgLAYKU9RJBmMyWoKTQcVb9yUa7onXuhot/Evse4rShTaTImP/jHcnWg4cp
	AJGsw3S7Qa+3FKnMRI6K+Tp6ZRKfcJtWijvcbmYNB9C8ECQnqzDHNoFfE70x23WV
	HOPuqv0YM6Gth1kbw+kg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xyfhv150n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 14:35:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 447EZUc5003979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 May 2024 14:35:30 GMT
Received: from [10.50.36.33] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 7 May 2024
 07:35:28 -0700
Message-ID: <23d5074b-0992-2d68-7ddd-dca43bbcb878@quicinc.com>
Date: Tue, 7 May 2024 20:05:25 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC] wifi: cfg80211: Refactor interface combination input
 parameter
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240427031503.22870-1-quic_periyasa@quicinc.com>
 <3f8e4d6d0f2facde80ad82b5b3060eb0af0958a4.camel@sipsolutions.net>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <3f8e4d6d0f2facde80ad82b5b3060eb0af0958a4.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SGwoDN72boZ1icEY1tyYZ9fjezLzxD4x
X-Proofpoint-ORIG-GUID: SGwoDN72boZ1icEY1tyYZ9fjezLzxD4x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_08,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405070100



On 5/7/2024 3:17 PM, Johannes Berg wrote:
> On Sat, 2024-04-27 at 08:45 +0530, Karthikeyan Periyasamy wrote:
>> Currently, the interface combination input parameter num_different_channels
>> and iftype_num are directly filled in by the caller under the assumption
>> that all channels and interfaces belong to a single hardware device. This
>> assumption is incorrect for multi-device interface combinations because
>> each device supports a different set of channels and interfaces. As
>> discussed in [1], need to refactor the input parameters to encode enough
>> data to handle both single and multiple device interface combinations.
>> This can be achieved by encoding the frequency and interface type under
>> the interface entity itself. With this new input parameter structure, the
>> cfg80211 can classify and construct the device parameters, then verify them
>> against the device specific interface combinations.
> 
> ^^ This should probably mention _something_ about links too :)
> 

sure

> 
>> [1]: https://lore.kernel.org/linux-wireless/ca70eeb3cdee1e8c3caee69db595bc8160eb4115.camel@sipsolutions.net/
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/wil6210/cfg80211.c   |  44 +++++--
>>   .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  60 +++++++--
>>   .../net/wireless/quantenna/qtnfmac/cfg80211.c |  32 +++--
>>   include/net/cfg80211.h                        |  37 +++++-
>>   net/mac80211/util.c                           | 124 +++++++++++++++---
>>   net/wireless/util.c                           |  56 ++++++--
>>   6 files changed, 276 insertions(+), 77 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
>> index 8993028709ec..3f9f5f56bd19 100644
>> --- a/drivers/net/wireless/ath/wil6210/cfg80211.c
>> +++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
>> @@ -625,17 +625,25 @@ static int wil_cfg80211_validate_add_iface(struct wil6210_priv *wil,
>>   {
>>   	int i;
>>   	struct wireless_dev *wdev;
>> -	struct iface_combination_params params = {
>> -		.num_different_channels = 1,
>> -	};
>> +	struct iface_combination_params params = { 0 };
> 
> nit: just use "= {}".
> 

sure, will address in the next version.


>> +	ifaces = kcalloc(total_iface, sizeof(*ifaces), GFP_KERNEL);
>> +	if (!ifaces)
>> +		return -ENOMEM;
>> +
>> +	list_for_each_entry(pos, &cfg->vif_list, list) {
>> +		if (params.num_iface >= total_iface)
>> +			continue;
> 
> ??
> Seems like that should be a WARN_ON or something?

WARN_ON() is good.

> 
>> +	struct iface_combination_interface *ifaces = NULL;
>> +	u16 total_iface = 0;
>> +	int ret;
>>   
>>   	list_for_each_entry(pos, &cfg->vif_list, list)
>> -		params.iftype_num[pos->wdev.iftype]++;
>> +		total_iface++;
>>   
>> -	params.iftype_num[new_type]++;
>> -	return cfg80211_check_combinations(cfg->wiphy, &params);
>> +	ifaces = kcalloc(total_iface, sizeof(*ifaces), GFP_KERNEL);
> 
> No point in "= NULL" if you overwrite it immediately.
> 

sure, will address in the next version.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

