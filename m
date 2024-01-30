Return-Path: <linux-wireless+bounces-2751-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773A58419AE
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 03:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33281281E89
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 02:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76256107A0;
	Tue, 30 Jan 2024 02:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UaOJERW0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C0536AFD
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 02:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583355; cv=none; b=SvFMO5QmADgU0bnEbbEWEppKjQFZW3Um4h5kowroh7/r8XKpqkSxOvLcsXTjb8U5d7RNxAHEZVvjRdt4pKTRtMdF1EKy4KROow75bmm32NvJMjnIh7Yo6Lqgf5xmGxy4SqbD7J9PNYvaLHFi/QIRUIWpZBPUPjWqAZcZ6qr36eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583355; c=relaxed/simple;
	bh=Ugbmfj/8YEPI7/5Y5qkaaqfbg0DGG2/r3hpspWNqDvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JSODlI711nhDxCD1ikWyJTT4p3EA/sTdE9uKm5+y4YSVs8SgstS8Cejf7dNHdDWgFkPv9Q5klOKn+OrrttO6dif1r4RzMUNI0t1+7oPl1uEuMVHaWEn+RdbQ1+tVfznMKsEbagPMNKAWWdNiyswdBrTpD/ZMGOjhEAtGnQIAbws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UaOJERW0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U0piZr007114;
	Tue, 30 Jan 2024 02:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=234l4OnW0/PTyBygl5xLPoJLoDfwCT9daSxZ9koa7Pw=; b=Ua
	OJERW03F9hU8Jj+6FWsHX6L1IzpW1MdRJhsGLJG0TdDSA8JyPAXdvAvnEPOb5xMH
	CuXz5VEc7YVqb4IoddK2xC4iMDnkPKqLaUEHgO8RWKGzCIHQqSehFFYoSRw3GUNt
	WIJUHjcgAXNqRtHSMMnxFQlDFtoGLrQsOJ8vTHMW2DRAq4Z+/Hc3NfY+GR7pYOCT
	oSknNxbmWKieHovg2JnlT509fN1/H1XtCGUHR9u2FT0J4F9FNDlp+fLkrAv9DHgC
	sPwW3uQu+31ryruIpakjgL+tTQKm39iVPCq9+Au4kfdb4Mx4A3d0BZsWPW98lvcj
	hXTcH/VzdXWbs52i41aw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxa42j54p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 02:55:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U2tmhm004738
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 02:55:48 GMT
Received: from [10.201.207.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 18:55:46 -0800
Message-ID: <6ca7d562-faeb-456b-a189-1f508ad99453@quicinc.com>
Date: Tue, 30 Jan 2024 08:25:43 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] wifi: cfg80211: send link id in channel_switch ops
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240129052832.905113-1-quic_adisi@quicinc.com>
 <20240129052832.905113-2-quic_adisi@quicinc.com>
 <153c2f4f-8caa-4d76-9d05-a0ee443fb274@quicinc.com>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <153c2f4f-8caa-4d76-9d05-a0ee443fb274@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tBwR5jw89rrtjx_DI-K9prCSjRo7x8qD
X-Proofpoint-ORIG-GUID: tBwR5jw89rrtjx_DI-K9prCSjRo7x8qD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=870 phishscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401300019

On 1/30/24 06:44, Jeff Johnson wrote:
> On 1/28/2024 9:28 PM, Aditya Kumar Singh wrote:
>> --- a/net/wireless/trace.h
>> +++ b/net/wireless/trace.h
>> @@ -2341,11 +2342,13 @@ TRACE_EVENT(rdev_channel_switch,
>>   			memcpy(__get_dynamic_array(pres_ofs),
>>   			       params->counter_offsets_presp,
>>   			       params->n_counter_offsets_presp * sizeof(u16));
>> +		__entry->link_id = params->link_id;
>>   	),
>>   	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " CHAN_DEF_PR_FMT
>> -		  ", block_tx: %d, count: %u, radar_required: %d",
>> +		  ", block_tx: %d, count: %u, radar_required: %d link_id: %d",
> 
> nit s/%d link_id/%d, link_id/
> 

Sure will add comma in next version.

>>   		  WIPHY_PR_ARG, NETDEV_PR_ARG, CHAN_DEF_PR_ARG,
>> -		  __entry->block_tx, __entry->count, __entry->radar_required)
>> +		  __entry->block_tx, __entry->count, __entry->radar_required,
>> +		  __entry->link_id)
>>   );
>>   
>>   TRACE_EVENT(rdev_set_qos_map,
> 



