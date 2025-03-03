Return-Path: <linux-wireless+bounces-19694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F309A4BBE1
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 11:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CBCE3AC089
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 10:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E800C1F1905;
	Mon,  3 Mar 2025 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VjgoimUx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CAB1EDA04
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 10:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740997127; cv=none; b=dsB4LGcppvdhHpa+WPu0VlYSZ2buGXnJlNZ1mEVYfqgTzu8MFj++I+5mbg6vFbcwjSc/HA248PQOTM6tvtb92SznB1T/yuasREUDdMs4Y2Bqab80ud9Ir2PLBQY8ek7OwOmCfHwrpK/OXrlYfo+nw9ubYDuHyhj4EsdTKPODw9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740997127; c=relaxed/simple;
	bh=18JoiGu++6FnPrq1+QGw2bVsdp5I+Af3yjJrch2BlQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lmozHOWMvldnux9uIOu0V1qT4bTkOJnhEpdC7RfGOUJQaYQfbE1SQ7lSrnxtsiwhT58Ro9NQjVf1iAb/IGDsNZIBa/Ebo6aX7e2ZuaZPcUN/pBtjypoCzY6hvnGZQ5CJ82lDxIZ7kr7Lq0DuSb4zTd/FDpwaRn98sU8Um1ZCpBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VjgoimUx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522NfjE6003941;
	Mon, 3 Mar 2025 10:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	J/lRz/OPYuF4ykGl/7vX3TSprk6U1/0ugtqhkEUfBnE=; b=VjgoimUxWcFvt/P4
	G73awsppMBy0bWxWgx2MWKPjjbiFlIvbPgJYEoCxrBeuN3qRJNEoCSJZ3UM/Ahc+
	RgpM5KPlr9og1HKMaeTIsmlwYRvObk87vkoFIccVdDInHGRKV946pCAZ266214K2
	b1iFJkVc7LJCH6IREB47IBKinmU5DyLc2OMpV5OXJlJBv5wgj2UFMU1W7mK7yPLz
	8R5LLAyGNfDo8Fb+gR8WuHNhzlvL/T+bVReOADQMx5IZfsmvAeI852FGjhdyJYfw
	txVibALKkab+kofzCCNHiCUxcKR7oukbzJhgPpgLyDbQpUgTDO6fKqJny8OMdEu7
	fQH5HA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t7hvj7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 10:18:41 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 523AIeF3001367
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Mar 2025 10:18:40 GMT
Received: from [10.152.206.29] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Mar 2025
 02:18:39 -0800
Message-ID: <133849d8-759e-4a31-9894-917a4b509623@quicinc.com>
Date: Mon, 3 Mar 2025 15:48:32 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] wifi: cfg80211: Add Support to Set RTS Threshold
 for each Radio
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250129155246.155587-1-quic_rdevanat@quicinc.com>
 <20250129155246.155587-2-quic_rdevanat@quicinc.com>
 <6f25563f9d68f4e2c230ff426cbabec43ea56335.camel@sipsolutions.net>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <6f25563f9d68f4e2c230ff426cbabec43ea56335.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2wnEzrfQP-6cfgSBnLbAQ1nvRrlCcJuo
X-Proofpoint-ORIG-GUID: 2wnEzrfQP-6cfgSBnLbAQ1nvRrlCcJuo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_04,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=720 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030079



On 2/28/2025 6:31 PM, Johannes Berg wrote:
>> +/**
>> + * struct wiphy_radio_cfg - physical radio config of a wiphy
>> + * This structure describes the configurations of a physical radio in a
>> + * wiphy. It is used to denote per-radio attributes belonging to a wiphy.
>>
> 
> Seems like there should be a blank line after the short description so
> it doesn't all end up in there?
> 
Sure, I'll add one.

>> + * @NL80211_ATTR_WIPHY_RADIO_INDEX: Integer attribute denoting the index of
>> + *	the radio in interest. Internally a value of 0xff is used to indicate
>> + *	this attribute is not present, and hence any associated attributes are
>> + *	deemed to be applicable to all radios
> 
> Please document the type here. Also, the description of the internal
> 0xff handling and all that is inappropriate in the public API
> documentation.
> 
Sure, I'll add a detailed description of those here.

> However, it seems using -1, would be nicer? Also,
> NL80211_WIPHY_RADIO_ID_MAX is a _really_ bad name for that.> 
We are using u8 to store the radio_id to serve two purposes. First is to check if
the number of radios in the device is greater than the value in wiphy->n_radio.
Second is to check if the number of radios is given in the user-space. Both these
checks culminate in using a common - if (radio_id > wiphy->n_radio), to check if
radio_id is valid. If -1 is used, we might need to check if radio_id is -1 and is
greater than wiphy->n_radio separately. 

Can we stick to using 0xff if radio_id is not given in userspace?

>> +++ b/net/wireless/core.c
>> @@ -1077,6 +1077,23 @@ int wiphy_register(struct wiphy *wiphy)
>>  		return res;
>>  	}
>>  
>> +	/* Allocate radio configuration space for multi-radio wiphy.
>> +	 */
>> +	if (wiphy->n_radio) {
>> +		int idx;
>> +
>> +		wiphy->radio_cfg = kcalloc(wiphy->n_radio, sizeof(*wiphy->radio_cfg),
>> +					   GFP_KERNEL);
>> +		if (!wiphy->radio_cfg)
>> +			return -ENOMEM;
>> +		/*
>> +		 * Initialize wiphy radio parameters to IEEE 802.11 MIB default values.
>> +		 * RTS threshold is disabled by default with the special -1 value.
>> +		 */
>> +		for (idx = 0; idx < wiphy->n_radio; idx++)
>> +			wiphy->radio_cfg[idx].rts_threshold = (u32)-1;
>> +	}
> 
> This error handling is obviously all wrong. Please ask someone else to
> review before you resubmit.
> 
Sure, I'll make modifications, get it reviewed internally and re-send.
> 
> The later code in nl80211.c could also use some refactoring, rather than
> just indent it a bit and call it done.
> 
I caught your review comments in your other reply to this patch, thanks.

> johannes

