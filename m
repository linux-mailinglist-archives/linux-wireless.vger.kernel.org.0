Return-Path: <linux-wireless+bounces-5593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 497DF89227C
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD45F1F23891
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 17:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2D92C698;
	Fri, 29 Mar 2024 17:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o12mlgC3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD974A0A
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732441; cv=none; b=RgriV9kFvfbdU6dYxbhXMJePXjCHFuBci0pkW5x2eimCKSYzpC6Q4vnau9DLRPL2NqDCunJ50ZBmDWA45JXw7iOPcE0kf7u5KR+pMNs6ACwP/I43VvUsogBhKdiRynylDkTSVczvBWTlFA0nO5QwgEgjUNWP8g6Xws56ZTOQmZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732441; c=relaxed/simple;
	bh=hisFj6rG7zQLznOMrexoCcqrPsmtCZ1QiwkJTal0sCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IOyUJzdkkP0/4bUnoQ/bgYIBtejD5+ZSkyIRACFk5D5kR5mF21c8rUVoplN1a18pHBV+bkE7bMsl0UnnlqN8HivnZNriOxD0iiAKSP08Z1JsXK2dg4rkqfdjR7LnwJntUmYHCzz4kbfO+elRgn8HzuOJpnNCUpMPqPchzc27uvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o12mlgC3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TFjGJ2001307;
	Fri, 29 Mar 2024 17:13:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=w2Wbdio+voAPhLoZffWxoA2TpZPl4hlRHVJNP7extlM=; b=o1
	2mlgC31zDw4kbgQ6fw261a/zdegAiXTTP1RKgx4CTgDoKHWFBssiu0RJXlrI1IaT
	SOP+BHIg4MDun5FreUSGSaPu2PtdHJv7DpxlH1ff/1h9G0NkdM/Uc6RDtyNUdyuR
	Mr/Iw5getGQ7HnFk9X2DiNgrZzJyvxm86klxGGPyTXvPUQOTqaPBC4Y+M6SukrRg
	yUIERL6pyTYgfUHB8RD/wgSu/P2eufJDQxXEkAtTchMeNFRX7/YuSe/yp1dVSKPn
	EVxWDPP/8ZjGnDOFb8fXRQS9CnxqJjaCcaS0QohcIVRABAYs7wrW0DVa8xf7LaiG
	8d2npkgi9+k9Exmwfouw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5xcy0fvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:13:55 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42THDtc8005933
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:13:55 GMT
Received: from [10.50.15.209] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 10:13:54 -0700
Message-ID: <8b0f6f62-ff3a-483c-bceb-2f9c56526f44@quicinc.com>
Date: Fri, 29 Mar 2024 22:43:54 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] wifi: mac80211: Add support for link reconfigure
 removal
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240328055235.3034174-1-quic_mdharane@quicinc.com>
 <20240328055235.3034174-3-quic_mdharane@quicinc.com>
 <3f77e4e0455fbfdec7e14777cf116175eae32f49.camel@sipsolutions.net>
From: Manish Dharanenthiran <quic_mdharane@quicinc.com>
In-Reply-To: <3f77e4e0455fbfdec7e14777cf116175eae32f49.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FsG0TSUg6IVbeUTuHUWIzJcO0vOa66eW
X-Proofpoint-ORIG-GUID: FsG0TSUg6IVbeUTuHUWIzJcO0vOa66eW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=661 adultscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290152



On 3/28/2024 11:53 PM, Johannes Berg wrote:
> On Thu, 2024-03-28 at 11:22 +0530, Manish Dharanenthiran wrote:
>>
>> +int __ieee80211_link_reconfig_remove(struct ieee80211_local *local,
>> +				     struct ieee80211_sub_if_data *sdata,
>> +				     const struct cfg80211_link_reconfig_removal_params *params)
>> +{
>> +	struct ieee80211_link_data *link;
>> +	int ret;
>> +
>> +	if (!ieee80211_sdata_running(sdata))
>> +		return -ENETDOWN;
>> +
>> +	if (sdata->vif.type != NL80211_IFTYPE_AP)
>> +		return -EINVAL;
>> +
>> +	link = sdata_dereference(sdata->link[params->link_id], sdata);
>> +	if (!link)
>> +		return -ENOLINK;
>> +
>> +	ret = drv_link_reconfig_remove(local, sdata, params);
>> +
>> +	return ret;
> 
> Again ... remove the 'ret' variable, it serves no purpose at all.
> 
>> +}
>> +
>> +int ieee80211_update_link_reconfig_remove_status(struct ieee80211_vif *vif,
>> +						 unsigned int link_id,
>> +						 u8 tbtt_count, u64 tsf,
>> +						 enum ieee80211_link_reconfig_remove_state status)
>> +{
>> +	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
>> +
>> +	if (vif->type != NL80211_IFTYPE_AP) {
>> +		sdata_err(sdata, "Discarding link reconfig status for unsupported vif type\n");
> 
> Uh, no. Remove that message please.
> 
Sure, will make this if block in different way.

>> +TRACE_EVENT(drv_link_reconfig_remove,
>> +	    TP_PROTO(struct ieee80211_local *local,
>> +		     struct ieee80211_sub_if_data *sdata,
>> +		     const struct cfg80211_link_reconfig_removal_params *params),
>> +
>> +	TP_ARGS(local, sdata, params),
>> +
>> +	TP_STRUCT__entry(LOCAL_ENTRY
>> +			 VIF_ENTRY
>> +			 __field(u32, link_id)
>> +			 __field(u16, count)
>> +			 __dynamic_array(u8, frame, params->ie_len)
>> +	),
> 
> All the same things about indentation apply here.
> 
> johannes
> 

