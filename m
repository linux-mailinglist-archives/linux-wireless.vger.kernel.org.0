Return-Path: <linux-wireless+bounces-5584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60ED891FE2
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 16:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 160351C27D9E
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 15:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF4028DC0;
	Fri, 29 Mar 2024 14:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gRz2ShmK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC7029D02
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711722897; cv=none; b=XnMhIHCLFHJeo/w0rP0E1NCsHVMSVj+4hMXcw78lu3AOqS9oOJxGWmjXAW+UvgqMqTAkubhAsystNo2mEUBYmRFXuGLTOveaDWxES1y9ANJyDf8K8zBOxAQ5bffegl+xq6dGzSdgXS4Bd+6vUrLxQfvcrt1vMLQL6N35yyF7nQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711722897; c=relaxed/simple;
	bh=Y7e5yHe9VqV6vuFKIo8boCvlUU87RxfWebLkjyV3mms=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H57jJyvZix/AhXusvnppJBP/BlrugIcHw69yG0jFHjJHNHV9LT8eJUs1DeclCuB0EnvNE4QnoFGFr/ZmKeVa/4fU8EG2nO+TNncWV/gtDdO7GMJU07mFRHMy0mYEQdHQWhwlujcFUOQwkylFfnB3UTHQ7TsVRmQCzP4HTIlPK2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gRz2ShmK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TBswHW006517;
	Fri, 29 Mar 2024 14:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nWl53/V4jFKzvKS2gdsunApD5QYSywlJNEcB5eRW1OU=; b=gR
	z2ShmKxpsmFr8et6K5BHmutuM6pzJAD/wCvDsiUJtY73r3R6nLixgX+f6BeNz7wK
	k2Ap29K3yInTJO32OHhobp9ABIsGl72q5A5EHZ9+fHLajTYR6nJFzEbpOtIyEQ1w
	N1squX8jNK821LeGlcrDgagUvyJ7hwm39ThYHHkuEtRQJqs/6+Z6S0lv9PaJADPM
	K5d/DOTNhVv2i6JbNGH36VjpVSgDBz+Isc0vT1wekfJEtWedBp9tx9zlmeKHDslF
	Y8iJA5V2t9SAKz2oVBS7m0bKxQg5R64cDk8MGDNFe9wMQESkACugTr3Flg6Iiyps
	Gr/6ZyALFGBlSnfhBoEw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5w6g0anv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 14:34:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TEYjb5024566
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 14:34:45 GMT
Received: from [10.216.7.62] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 07:34:43 -0700
Message-ID: <14909268-53de-a686-eecd-443ce153c756@quicinc.com>
Date: Fri, 29 Mar 2024 20:04:38 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/13] wifi: nl80211: send iface combination to user space
 in multi-hardware wiphy
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-7-quic_periyasa@quicinc.com>
 <29fc2719d6814a8e84f5db9ad81c76116a52828b.camel@sipsolutions.net>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <29fc2719d6814a8e84f5db9ad81c76116a52828b.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vDAiKnPZzWoHCEHpfI7GaLkUzBVOgyGa
X-Proofpoint-ORIG-GUID: vDAiKnPZzWoHCEHpfI7GaLkUzBVOgyGa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=541
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290129



On 3/28/2024 7:03 PM, Johannes Berg wrote:
> On Thu, 2024-03-28 at 12:59 +0530, Karthikeyan Periyasamy wrote:
>>
>> + *	When describing per-hardware combinations in multi-hardware in
>> + *	one wiphy model, the first possibility can further include the finer
>> + *	capabilities like below
> 
> Not sure I'd say "below" rather than e.g. "like this:"
> 
>> + *	hw_chan_idx = 0, numbers = [ #{STA} <= 1, #{AP} <= 1 ],
>> + *	channels = 1, max = 2
>> + *	=> allows a STA plus an AP interface on the underlying hardware mac
>> + *	   advertised at index 0 in wiphy @hw_chans array.
>> + *	hw_chan_idx = 1, numbers = [ #{STA} <= 1, #{AP} <= 2 ],
>> + *	channels = 1, max = 3
>> + *	=> allows a STA plus two AP interfaces on the underlying hardware mac
>> + *	   advertised at index 1 in wiphy @hw_chans array.
> 
> Have you checked the rst output for this? Seems likely that's not going
> to be great with that formatting, but I haven't checked.
> 
>> + * @NL80211_IFACE_COMB_PER_HW_COMB_HW_IDX: u8 attribute specifying the index
>> + *	to the wiphy @hw_chans list for which the iface combination is being
>> + *	described.
> 
> "@hw_chans" doesn't make sense here, this is nl80211, it should refer to
> some attribute
> 
> but why didn't you just _say_ in the patch 2 discussion that it's used
> here ...
> 
>> + * @NL80211_IFACE_COMB_PER_HW_COMB_LIMITS: nested attribute containing the
>> + *	limits for the given interface types, see
>> + *	&enum nl80211_iface_limit_attrs.
>> + * @NL80211_IFACE_COMB_PER_HW_COMB_MAXIMUM: u32 attribute giving the maximum
>> + *	number of interfaces that can be created in this group. This number
>> + *	does not apply to the interfaces purely managed in software.
>> + * @NL80211_IFACE_COMB_PER_HW_COMB_NUM_CHANNELS: u32 attribute specifying the
>> + *	number of different channels that can be used in this group.
>> + * @NUM_NL80211_IFACE_COMB_PER_HW_COMB: number of attributes
>> + * @MAX_NL80211_IFACE_COMB_PER_HW_COMB: highest attribute number
>> + */
>> +enum nl80211_if_comb_per_hw_comb_attrs {
>> +	NL80211_IFACE_COMB_PER_HW_COMB_UNSPEC,
>> +	NL80211_IFACE_COMB_PER_HW_COMB_HW_IDX,
>> +	NL80211_IFACE_COMB_PER_HW_COMB_LIMITS,
>> +	NL80211_IFACE_COMB_PER_HW_COMB_MAXIMUM,
>> +	NL80211_IFACE_COMB_PER_HW_COMB_NUM_CHANNELS,
> 
> Almost all these attributes duplicate - including their docs -
> attributes from enum nl80211_if_combination_attrs. Is it really worth
> doing that, rather than adding NL80211_IFACE_COMB_HW_IDX and documenting
> the different uses of the attribute set?
> 

I agree, more duplication. So we have to have the per_hw_comb_attrs
defines like below?

enum nl80211_if_comb_per_hw_comb_attrs {
	NL80211_IFACE_COMB_PER_HW_COMB_UNSPEC,
	NL80211_IFACE_COMB_PER_HW_COMB_HW_IDX = 			
			NL80211_IFACE_COMB_NUM_CHANNELS + 1,
	/* keep last */
	NUM_NL80211_IFACE_COMB_PER_HW_COMB,
	MAX_NL80211_IFACE_COMB_PER_HW_COMB =
			NUM_NL80211_IFACE_COMB_PER_HW_COMB - 1
};

Vasanth

