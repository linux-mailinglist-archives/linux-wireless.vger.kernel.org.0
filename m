Return-Path: <linux-wireless+bounces-5796-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8CF896B3A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 11:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348611F292A3
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 09:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5071350D6;
	Wed,  3 Apr 2024 09:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dVGnky6K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79115134CD4
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712138370; cv=none; b=Huik96pu51oRaeTcXzmqcWMqS51BSFtb6mUW/hbH6qOLa484ISjRCsjlk4iR1UVyYmzSX/He/dCxQF/ZHeUvDFKJMKxG706hDtPhoGgO4ArND9i8q0JzOJl4+fEdH2KGuL+PXYYS/6ZlgEmAl6OUJjsUBuzKerlVZgtOOvJYAVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712138370; c=relaxed/simple;
	bh=FY9qyGVTn2fzNNg52jRWIk3Tr/ZxExvG53Dgj3MxXRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UVGtKn7RxMncCfIsLA2nPOSStjOY+B20c9etJFFEcVqi5gqF7PU+eVK94lyzr/8xHnnvoxFnZKyiuQ67OH/k5whKzH5a2saT/FRqTAS33tUBL+kgGC6LH+Jv9ByKFnaPopBjf6xjNnnPPecBQhlbBbXGULTDf7zZOdX0u3Bj3T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dVGnky6K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4334Z6tP005076;
	Wed, 3 Apr 2024 09:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=CVoOQL6BL5QltBMYhaBYd0mReQolKmj5oeLMAJ4L9nA=; b=dV
	Gnky6KyhGrnAyzXBEu7QfqxGQqVf7+/I5eYZmtLsS8E6yFx+jzKK+IeMvzHLjX3X
	x+at0RmZIQFqPTPQurU7MnFOpqoe7hXAU9W+2v7J+nsnV51KJNjsfxnhBAiI079E
	I4Wmb5AgP9Ln2Mz+mtmXNvDu/MLe62S8FZnCQq9w57FlJ7jF2q85ZBC3JOXxxiKs
	Gl3NhQmsG69gYvTtJvklPyXSwdeFSSFRK0ugtFVjbYGbMr8qYhK/0JtIicxV1SNQ
	QI/GYGbj3n+XCuvTy8SHOguyta2sE/jLKJsGO6SV5o4RUgY3Tq1eWUf+cLfgV+br
	n5Lpz5sA9i3FQr4wAFbQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9077gkwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 09:58:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4339wsPv005015
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 09:58:54 GMT
Received: from [10.152.205.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 02:58:52 -0700
Message-ID: <7bbd676a-748b-a1d6-aa5c-2e8868017159@quicinc.com>
Date: Wed, 3 Apr 2024 15:28:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 09/13] wifi: cfg80211: Add multi-hardware iface
 combination support
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-10-quic_periyasa@quicinc.com>
 <a24b7d967dbe31ef613fae8c331f4ff718482c93.camel@sipsolutions.net>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <a24b7d967dbe31ef613fae8c331f4ff718482c93.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _TYS5nf6FFZMcsC5OfbWM4QKc8JS5NRH
X-Proofpoint-ORIG-GUID: _TYS5nf6FFZMcsC5OfbWM4QKc8JS5NRH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_08,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030068



On 3/28/2024 7:46 PM, Johannes Berg wrote:

> 
>> +static const struct ieee80211_iface_per_hw *
>> +cfg80211_get_hw_iface_comb_by_idx(struct wiphy *wiphy,
>> +				  const struct ieee80211_iface_combination *c,
>> +				  int idx)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < c->n_hw_list; i++)
>> +		if (c->iface_hw_list[i].hw_chans_idx == idx)
>> +			break;
>> +
>> +	if (i == c->n_hw_list)
>> +		return NULL;
>> +
>> +	return &c->iface_hw_list[i];
>> +}
> 
> ???
> 
> Hint: it's perfectly legal to return directly from a loop.

sure

> 
>> +static int
>> +cfg80211_validate_iface_comb_per_hw_limits(struct wiphy *wiphy,
>> +					   struct iface_combination_params *params,
>> +					   const struct ieee80211_iface_combination *c,
>> +					   u16 *num_ifaces, u32 *all_iftypes)
>> +{
>> +	struct ieee80211_iface_limit *limits;
>> +	const struct iface_comb_per_hw_params *per_hw;
>> +	const struct ieee80211_iface_per_hw *per_hw_comb;
>> +	int i, ret = 0;
> 
> The = 0 doesn't seem needed.

sure

> 
>> +		ret = cfg80211_validate_iface_limits(wiphy,
>> +						     per_hw->iftype_num,
>> +						     limits,
>> +						     per_hw_comb->n_limits,
>> +						     all_iftypes);
>> +
>> +		kfree(limits);
>> +
>> +		if (ret)
>> +			goto out;
>> +	}
>> +
>> +out:
>> +	return ret;
> 
> That 'out' label is pointless.

sure

> 
>> +static void cfg80211_put_iface_comb_iftypes(u16 *num_ifaces)
>> +{
>> +	kfree(num_ifaces);
>> +}
> 
> Not sure I see value in that indirection?

sure

> 
>> +static u16*
> 
> missing space

sure

> 
>> +cfg80211_get_iface_comb_iftypes(struct wiphy *wiphy,
>> +				struct iface_combination_params *params,
>> +				u32 *used_iftypes)
>> +{
>> +	const struct iface_comb_per_hw_params *per_hw;
>> +	u16 *num_ifaces;
>> +	int i;
>> +	u8 num_hw;
>> +
>> +	num_hw = params->n_per_hw ? params->n_per_hw : 1;
> 
> I think we're allowed to use the "?:" shortcut.

sure

> 
>> +	num_ifaces = kcalloc(num_hw, sizeof(*num_ifaces), GFP_KERNEL);
>> +	if (!num_ifaces)
>> +		return NULL;
> 
> But ... maybe we should just cap num_hw to a reasonable limit (4? 5?)
> and use a static array in the caller instead of allocating here.
> 
>> +	is_per_hw = cfg80211_per_hw_iface_comb_advertised(wiphy);
> 
> Maybe call that "have_per_hw_combinations" or so? Or "check_per_hw"
> even, "is" seems not clear - "what is?"

sure, will address all the above comments in the next version of the patch.


-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

