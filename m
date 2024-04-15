Return-Path: <linux-wireless+bounces-6328-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5743F8A56DA
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 17:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C72E2845AD
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 15:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEF72837D;
	Mon, 15 Apr 2024 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gH39+hdJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE4A1E535
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713196673; cv=none; b=AX/MBExzC+2p5fipvBA2pqkkZu5HJw1Y+U29RwcqyAhVMf2csCdXRrIs4qBUGRziAGmtLznFJNdrTQgZS0neOB0U+0ow9htneib0ouERdeoIFVer/OPpJoxgU+60G3PIKgsT/rFcfZsRKcrgbORNTe4uhjFR5acrIdOYHC0mHnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713196673; c=relaxed/simple;
	bh=6Jv5oLVjRDNYdFMsOfnxRQwIzcn5whk1IZhesXjxzHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cIgIu+AfvZTk5GZW0HduMR1TsKYNrtE67kcJ9PUB/U9hDMbST0Cve5sIphsPv+bMjKTc+1xWlXx07FCqh7L4YnGn/X5x2zuruhRwP5/HoQTpae46cJRw7MYIicBAg11GL1ajX+CRwZ+tDDxsMNs8cuozpYy7OdOuct20gasYiDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gH39+hdJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43F6SFSd012555;
	Mon, 15 Apr 2024 15:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gJaiZoyMRIB5djIdru5I3VNWFoe7MSX0NH/9tzht5qA=; b=gH
	39+hdJCGGy74rIihqSZI+jf3KsvQuYxO3dN9SffM1xkPOdaAZG2sEOkgE3T769vn
	r1jiw6oM9+BpTctWGHddUwsH/JEAe4N0XOxDLOeew0yataAH8VlbB2uhnV+yUkZt
	iPN8/FNq9GXXdBRbftqykd3gI/YEyMjWx79tx7UYKsRn8AGG8zAcIdDtWxEIkA/D
	+k9XZUR/ot0fOgbbpU3uk1m70EqW5SQ6CsgipYwM4ZHT9skYY8/M3spvB9STFcB2
	nahM/TXmBqmgDJ84pYjbEGFFr8ug9THlz6d8roUa3UkcFvEwpp4v7voSsc6cs5N6
	/rEU8KkZNpz0+TtBlExg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xgy07hbn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:57:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43FFvh3n016888
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 15:57:43 GMT
Received: from [10.50.16.162] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 15 Apr
 2024 08:57:41 -0700
Message-ID: <647d23e5-0670-6d59-2887-5c77c311cb54@quicinc.com>
Date: Mon, 15 Apr 2024 21:27:38 +0530
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
To: Johannes Berg <johannes@sipsolutions.net>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-7-quic_periyasa@quicinc.com>
 <29fc2719d6814a8e84f5db9ad81c76116a52828b.camel@sipsolutions.net>
 <14909268-53de-a686-eecd-443ce153c756@quicinc.com>
 <6147ac95-a572-62df-619d-33078d51ccc3@quicinc.com>
 <c58f318641ec2e836a23f8769eb32c67326643a5.camel@sipsolutions.net>
Content-Language: en-US
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <c58f318641ec2e836a23f8769eb32c67326643a5.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xvNnjmlgWsq37-xQ3vYhgEGDGPuGmyIu
X-Proofpoint-ORIG-GUID: xvNnjmlgWsq37-xQ3vYhgEGDGPuGmyIu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_13,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=506 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404150104



On 4/15/2024 7:57 PM, Johannes Berg wrote:
> On Fri, 2024-04-12 at 10:57 +0530, Karthikeyan Periyasamy wrote:
>>>>> + * @NL80211_IFACE_COMB_PER_HW_COMB_LIMITS: nested attribute
>>>>> containing the
>>>>> + *    limits for the given interface types, see
>>>>> + *    &enum nl80211_iface_limit_attrs.
>>>>> + * @NL80211_IFACE_COMB_PER_HW_COMB_MAXIMUM: u32 attribute giving the
>>>>> maximum
>>>>> + *    number of interfaces that can be created in this group. This
>>>>> number
>>>>> + *    does not apply to the interfaces purely managed in software.
>>>>> + * @NL80211_IFACE_COMB_PER_HW_COMB_NUM_CHANNELS: u32 attribute
>>>>> specifying the
>>>>> + *    number of different channels that can be used in this group.
>>>>> + * @NUM_NL80211_IFACE_COMB_PER_HW_COMB: number of attributes
>>>>> + * @MAX_NL80211_IFACE_COMB_PER_HW_COMB: highest attribute number
>>>>> + */
>>>>> +enum nl80211_if_comb_per_hw_comb_attrs {
>>>>> +    NL80211_IFACE_COMB_PER_HW_COMB_UNSPEC,
>>>>> +    NL80211_IFACE_COMB_PER_HW_COMB_HW_IDX,
>>>>> +    NL80211_IFACE_COMB_PER_HW_COMB_LIMITS,
>>>>> +    NL80211_IFACE_COMB_PER_HW_COMB_MAXIMUM,
>>>>> +    NL80211_IFACE_COMB_PER_HW_COMB_NUM_CHANNELS,
>>>>
>>>> Almost all these attributes duplicate - including their docs -
>>>> attributes from enum nl80211_if_combination_attrs. Is it really worth
>>>> doing that, rather than adding NL80211_IFACE_COMB_HW_IDX and documenting
>>>> the different uses of the attribute set?
>>>>
>>>
>>> I agree, more duplication. So we have to have the per_hw_comb_attrs
>>> defines like below?
>>>
>>> enum nl80211_if_comb_per_hw_comb_attrs {
>>>       NL80211_IFACE_COMB_PER_HW_COMB_UNSPEC,
>>>       NL80211_IFACE_COMB_PER_HW_COMB_HW_IDX =
>>>               NL80211_IFACE_COMB_NUM_CHANNELS + 1,
>>>       /* keep last */
>>>       NUM_NL80211_IFACE_COMB_PER_HW_COMB,
>>>       MAX_NL80211_IFACE_COMB_PER_HW_COMB =
>>>               NUM_NL80211_IFACE_COMB_PER_HW_COMB - 1
>>> };
>>>
>>
>> I agree this approach. Instead of NUM_NL80211_IFACE_COMB_PER_HW_COMB,
>> shall we have MAX_NL80211_IFACE_COMB like below so that hw_idx attribute
>> value will not get conflict to any IFACE combination attributes
>>
>>    enum nl80211_if_comb_per_hw_comb_attrs {
>>         NL80211_IFACE_COMB_PER_HW_COMB_UNSPEC,
>>         NL80211_IFACE_COMB_PER_HW_COMB_HW_IDX =
>>                 MAX_NL80211_IFACE_COMB + 1,
>>         /* keep last */
>>         NUM_NL80211_IFACE_COMB_PER_HW_COMB,
>>         MAX_NL80211_IFACE_COMB_PER_HW_COMB =
>>                 NUM_NL80211_IFACE_COMB_PER_HW_COMB - 1
>> };
>>
> 
> You haven't thought this through - what happens here if something is
> added to enum nl80211_if_combination_attrs?
> 

Yeah, it break backward compatibility.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

