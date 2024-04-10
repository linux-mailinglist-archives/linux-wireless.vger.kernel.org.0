Return-Path: <linux-wireless+bounces-6060-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D3E89E8B4
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 06:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CEA71F228D0
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 04:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA518472;
	Wed, 10 Apr 2024 04:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TaWqGy8O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C068A46B5
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 04:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712722259; cv=none; b=NkXZmF7nCeMSUYHJMfdzgF1EdXM9qx5oBgu9jA5wLCVaikafZG4uo4JR8XUbscGShEzzrkqxVLT94ojlKDEPFNbJ4jYt2Xm7xGmhIQ7CK1Y/X3u7OBN/lKtK6OwenITfpvxlOt+KI+znB3eVrnUp2pKcXap7L3ul3Fnk1whdGo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712722259; c=relaxed/simple;
	bh=uZ8rFmwY5SepYZJ6ez82eFeBKV+y+dSjf9FqPSnCI2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NsMV1B/AkQJMP+npXDXoKE88I8eCElOlKNyhuQDyKpnsnEjhkJfbrweioQTjXUq79INyAiC4yuq0hw1HPhLnxOfzuYcUxKtT212IXHfw5sDvZCe3cgemq+FSF89N+S85MR74oN7tLkWwwhgDQkhUal/HuBTWRR5UkvQRbJ4JfSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TaWqGy8O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43A2SPlN016036;
	Wed, 10 Apr 2024 04:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3osNcI7/qhZ6TVJ0FbSnCf/pHssNSWdP36bgFyTHfSM=; b=Ta
	WqGy8O0oxRQAxX7o0sjMgvZiSh1jPvEwBuYsyosmmfNQ5NrQ1cpYieifjv2ZGBZd
	EPhWqYz5ABSIUvv+o2IRSAl6EwrDDuZTP/alJf0Kyv9LERWaaMCygHuRPYBDnDR2
	Vfk0hSCo5RaVC9F2ZqBtJZ3pGSM89UKfP5h/2cBUkw+G4cs/2lFELltz6rvMh0Nk
	J6nrBYzPH9tK1bTwXRjkVtV4YZ9WK6sUnzv65EaGXhAPf0fQMZk/3QvWmmeHIXiO
	akXIFSGn2JlkfBDgElyEnLpkiy18i/Tl2VjNb/Jd4sWOgJHLMDoJJt+HUB13zSJs
	NstibOYhJN7DjnFAofsg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdh6x8n3c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 04:10:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43A4AjMw026159
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 04:10:45 GMT
Received: from [10.152.205.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 9 Apr 2024
 21:10:44 -0700
Message-ID: <13bbfe51-5a91-3c67-9b11-2f30a43f38ff@quicinc.com>
Date: Wed, 10 Apr 2024 09:40:41 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 06/13] wifi: nl80211: send iface combination to user space
 in multi-hardware wiphy
To: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-7-quic_periyasa@quicinc.com>
 <29fc2719d6814a8e84f5db9ad81c76116a52828b.camel@sipsolutions.net>
 <14909268-53de-a686-eecd-443ce153c756@quicinc.com>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <14909268-53de-a686-eecd-443ce153c756@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4kz68M_COlKfatjJuTnRnK1mPZXOJVBg
X-Proofpoint-ORIG-GUID: 4kz68M_COlKfatjJuTnRnK1mPZXOJVBg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=490 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100028



On 3/29/2024 8:04 PM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 3/28/2024 7:03 PM, Johannes Berg wrote:
>> On Thu, 2024-03-28 at 12:59 +0530, Karthikeyan Periyasamy wrote:
>>>
>>> + *    When describing per-hardware combinations in multi-hardware in
>>> + *    one wiphy model, the first possibility can further include the 
>>> finer
>>> + *    capabilities like below
>>
>> Not sure I'd say "below" rather than e.g. "like this:"
>>
>>> + *    hw_chan_idx = 0, numbers = [ #{STA} <= 1, #{AP} <= 1 ],
>>> + *    channels = 1, max = 2
>>> + *    => allows a STA plus an AP interface on the underlying 
>>> hardware mac
>>> + *       advertised at index 0 in wiphy @hw_chans array.
>>> + *    hw_chan_idx = 1, numbers = [ #{STA} <= 1, #{AP} <= 2 ],
>>> + *    channels = 1, max = 3
>>> + *    => allows a STA plus two AP interfaces on the underlying 
>>> hardware mac
>>> + *       advertised at index 1 in wiphy @hw_chans array.
>>
>> Have you checked the rst output for this? Seems likely that's not going
>> to be great with that formatting, but I haven't checked.
>>
>>> + * @NL80211_IFACE_COMB_PER_HW_COMB_HW_IDX: u8 attribute specifying 
>>> the index
>>> + *    to the wiphy @hw_chans list for which the iface combination is 
>>> being
>>> + *    described.
>>
>> "@hw_chans" doesn't make sense here, this is nl80211, it should refer to
>> some attribute
>>
>> but why didn't you just _say_ in the patch 2 discussion that it's used
>> here ...
>>
>>> + * @NL80211_IFACE_COMB_PER_HW_COMB_LIMITS: nested attribute 
>>> containing the
>>> + *    limits for the given interface types, see
>>> + *    &enum nl80211_iface_limit_attrs.
>>> + * @NL80211_IFACE_COMB_PER_HW_COMB_MAXIMUM: u32 attribute giving the 
>>> maximum
>>> + *    number of interfaces that can be created in this group. This 
>>> number
>>> + *    does not apply to the interfaces purely managed in software.
>>> + * @NL80211_IFACE_COMB_PER_HW_COMB_NUM_CHANNELS: u32 attribute 
>>> specifying the
>>> + *    number of different channels that can be used in this group.
>>> + * @NUM_NL80211_IFACE_COMB_PER_HW_COMB: number of attributes
>>> + * @MAX_NL80211_IFACE_COMB_PER_HW_COMB: highest attribute number
>>> + */
>>> +enum nl80211_if_comb_per_hw_comb_attrs {
>>> +    NL80211_IFACE_COMB_PER_HW_COMB_UNSPEC,
>>> +    NL80211_IFACE_COMB_PER_HW_COMB_HW_IDX,
>>> +    NL80211_IFACE_COMB_PER_HW_COMB_LIMITS,
>>> +    NL80211_IFACE_COMB_PER_HW_COMB_MAXIMUM,
>>> +    NL80211_IFACE_COMB_PER_HW_COMB_NUM_CHANNELS,
>>
>> Almost all these attributes duplicate - including their docs -
>> attributes from enum nl80211_if_combination_attrs. Is it really worth
>> doing that, rather than adding NL80211_IFACE_COMB_HW_IDX and documenting
>> the different uses of the attribute set?
>>
> 
> I agree, more duplication. So we have to have the per_hw_comb_attrs
> defines like below?
> 
> enum nl80211_if_comb_per_hw_comb_attrs {
>      NL80211_IFACE_COMB_PER_HW_COMB_UNSPEC,
>      NL80211_IFACE_COMB_PER_HW_COMB_HW_IDX =
>              NL80211_IFACE_COMB_NUM_CHANNELS + 1,
>      /* keep last */
>      NUM_NL80211_IFACE_COMB_PER_HW_COMB,
>      MAX_NL80211_IFACE_COMB_PER_HW_COMB =
>              NUM_NL80211_IFACE_COMB_PER_HW_COMB - 1
> };
> 

@johannes Berg


Any comments on the vasanth suggested approach ?


-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

