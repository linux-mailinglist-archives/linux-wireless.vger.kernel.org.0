Return-Path: <linux-wireless+bounces-23032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABE7AB8E1E
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 19:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75E43A682B
	for <lists+linux-wireless@lfdr.de>; Thu, 15 May 2025 17:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C191F0E4B;
	Thu, 15 May 2025 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fhOloNMv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B758A8F6E
	for <linux-wireless@vger.kernel.org>; Thu, 15 May 2025 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747331437; cv=none; b=VleW/HIp3UVrk1eTYu+rxwTnjwNipNu1+RlvjgDlecuYV3PhuffdluWaNli/XPF8mHYJh/3IPTRybmOLdQCjrgieloNypJ/UW665vq06kwlArJ+avh6rzJbgEFxeNZDDJjR0cpqQZEZ4jlSOxLbDI6f7HPlZsJEOQrof4SWUdbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747331437; c=relaxed/simple;
	bh=PFjL2c3E7b/O0N4EiAgIbuRtX5nJihpWbzaM5rYdCmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DrU0I95PZ2QtpOcj0Ofk47R0p5Bij9b0nGpoV/mvHehhXlphfozovChcwW6QRj6Ba+rbxRrr7cQt9/88wvhpNz6oncQMaoW+aWfNhxLhFd55dQR6O7fQrjX0uepGksW7Du8Kh3i6GVurI2DmzgLs1DUgg4XC/K9KtDS4CStI6+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fhOloNMv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FEFMo7018727;
	Thu, 15 May 2025 17:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Xx10L0HPAk6k+uhAq6eGa4GW/LpI9uotIubQUO+ZSPM=; b=fhOloNMvP2s5A7O6
	xxxwVU89GJ01XgjPi1xUNrqpF+Apol0rZL+e3qKQym/e8+k8SF0knNKN6Q/foNxZ
	FtymmGPhrJlP/Eq7YPx0ysHs3HBEU03PgyZuBegSThcvzwNlmwA/GrKodouUJ8vF
	IlXxuZ3aPP3yzz+T4ijCQJOpBVAb7Iy3mir4cPsC3WwNzFcvo2SjEv+7e9hQAAlT
	n4oHJ7nwx9Nm2f+RBwpKIdVADMOoNqVLCEeylz/ehSh7W+qxvuzj0FDJJk8p7tVc
	fLIYJloJ4kFyOpMLsbKdFahEdKyBi1kEYf8slZj/4CfjsRYXiMJBgV2OuApv0mbF
	XomLPQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcnq3va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 17:50:31 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54FHoUCq013332
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 17:50:30 GMT
Received: from [10.50.45.88] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 15 May
 2025 10:50:29 -0700
Message-ID: <b6d1145a-4a9c-4af7-a06c-bbefc0588762@quicinc.com>
Date: Thu, 15 May 2025 23:20:26 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v8 06/10] wifi: mac80211: add support to
 accumulate removed link statistics
To: Ben Greear <greearb@candelatech.com>,
        Johannes Berg
	<johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250515054904.1214096-1-quic_sarishar@quicinc.com>
 <20250515054904.1214096-7-quic_sarishar@quicinc.com>
 <52d96a61f56cd37b297e12b7ffb2936a479607ea.camel@sipsolutions.net>
 <f6d6ed3c-54de-4dcb-bea3-8a420f001c9a@quicinc.com>
 <921a952f-84ab-38dc-836a-1de0aa565f24@candelatech.com>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <921a952f-84ab-38dc-836a-1de0aa565f24@candelatech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0529UDa9A5BOThHmewN7dIQmT_aI9J-D
X-Authority-Analysis: v=2.4 cv=aIbwqa9m c=1 sm=1 tr=0 ts=68262967 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=KXajRAVGq2nrHfwbTzwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0529UDa9A5BOThHmewN7dIQmT_aI9J-D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE3NiBTYWx0ZWRfX4qDGm2jDjSv+
 PKUxBCRChhq/0lTa9Yqj4LhI0JQe5YXf5/4QWkkd444BmKq/HJKfVuDI91Pu6yerbrgFqR5lxtr
 8H8ojhMl2bqabxTvLdzJ+oUiEY6yGYNAgmPENsFgfE0ooC/S4NMAltxgPxNDOOa3zEuDZkPLtu2
 HglIe2gn22XGE+6HawAtcYuDWh0/Rog78zzNAxi4EJqzGYYbKuE5csaP+mHV/Y09Oyz55IVqGHf
 IGN8JqDd0d6y/xExgX1ndCWccEi+mBnHKxTXQ69GeEJuNXpBygpOFLdsTFJnJH+vvvvz5Rv9cKQ
 RNW6Wf8/h+x7gPLbjtiG51FP/kYzj3/P4FUVjDdgPdg2cvj6HNQAOpqJlz0/SySTLR/6JX4WlvS
 QiRO05FFdfsjywPUxDlgr1W3hiYxNIVanu+XsRvUDX0DI7p/tlHswwV1ObgFfjWFIjRs85ca
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 impostorscore=0
 clxscore=1015 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505150176

On 5/15/2025 11:08 PM, Ben Greear wrote:
> On 5/15/25 10:35, Sarika Sharma wrote:
>> On 5/15/2025 5:00 PM, Johannes Berg wrote:
>>> On Thu, 2025-05-15 at 11:19 +0530, Sarika Sharma wrote:
>>>>
>>>> +void sta_set_accumulated_removed_links_sinfo(struct sta_info *sta,
>>>> +                         struct station_info *sinfo)
>>>> +{
>>>> +    /* Resetting the MLO statistics for accumulated fields, to
>>>> +     * avoid duplication.
>>>> +     */
>>>> +    sinfo->tx_packets = 0;
>>>> +    sinfo->rx_packets = 0;
>>>> +    sinfo->tx_bytes = 0;
>>>> +    sinfo->rx_bytes = 0;
>>>> +    sinfo->tx_retries = 0;
>>>> +    sinfo->tx_failed = 0;
>>>> +    sinfo->rx_dropped_misc = 0;
>>>> +    sinfo->beacon_loss_count = 0;
>>>> +    sinfo->expected_throughput = 0;
>>>> +    sinfo->rx_mpdu_count = 0;
>>>> +    sinfo->fcs_err_count = 0;
>>>> +    sinfo->rx_beacon = 0;
>>>> +    sinfo->rx_duration = 0;
>>>> +    sinfo->tx_duration = 0;
>>>> +
>>>> +    /* Accumulating the removed link statistics. */
>>>> +    sinfo->tx_packets += sta->rem_link_stats.tx_packets;
>>>> +    sinfo->rx_packets += sta->rem_link_stats.rx_packets;
>>>> +    sinfo->tx_bytes += sta->rem_link_stats.tx_bytes;
>>>> +    sinfo->rx_bytes += sta->rem_link_stats.rx_bytes;
>>>> +    sinfo->tx_retries += sta->rem_link_stats.tx_retries;
>>>> +    sinfo->tx_failed += sta->rem_link_stats.tx_failed;
>>>> +    sinfo->rx_dropped_misc += sta->rem_link_stats.rx_dropped_misc;
>>>
>>> Setting something to 0 just to += it seems silly?
>>>
>>> However I think it also needs a bit more explanation - it's sinfo, so
>>> it's zeroed at allocation, where would non-zero numbers come from?
>>
>> Currently, the station information for MLO is populated with some 
>> values from sta->deflink, as the sta_set_sinfo() call is common for 
>> both non-MLO and MLO.
>>
>> When updating the station_info structure in 
>> cfg80211_sta_set_mld_sinfo(), the accumulated fields (such as packets, 
>> bytes, etc.) will already contain values set by mac80211 (from the 
>> deflink fields).
>>
>> Therefore, directly adding to these fields would be incorrect, so they 
>> should be reset to zero.
>>
>> May be this, resetting can be done directly in cfg80211 during 
>> cfg80211_sta_set_mld_sinfo(), will correct this.
> 
> If nothing else, you could just do assignment instead of setting to zero 
> and then
> incrementing?
> 
> I did not actually review the over-all logic, so perhaps there are bigger
> issues I'm not aware of.

Yes, here I can directly use assignment.
But some of fields I need to reset to 0 in cfg80211.
Will check and update this in next version.

> 
> Thanks,
> Ben
> 
> 


