Return-Path: <linux-wireless+bounces-2592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563D383EB17
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 05:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1C16B224BA
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 04:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D88513FE7;
	Sat, 27 Jan 2024 04:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hJX6sFyL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38CB13FE0
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jan 2024 04:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706331169; cv=none; b=oCcz8pGuxuYEgjsRLHXz15SVCjgIzvuo6eEgdoYDuc5Sw9YzYNv+kBrLGLDJAODATDAtpUcfl2/usG9akGHC2tyB+BYwzgE7Bm6gdA4YT/CF83hP7Cbv7qo3zAK8Z5nmoYckGOUJBd6EhVn9BL3EPtgE0CBLLg//E1RU+8Q6e6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706331169; c=relaxed/simple;
	bh=DxUVXHctvZ8YtUNZ4gFV05atOVmtEgNIhpcArqt/YHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W4yf2zYCRnbYaiq17KSZ1P/C/VRNXuD/dqqweh5k57tCtv9s3GlulB1zVT0MBQWBgTeDW24kzCA1V8vygW2LxzOViWWx7lY5HlVmDr3xIhEiNmU2Ypd2aQPD98N69lUbu50V1l/6t5d1Vsnj4DydiItNxUzEcCpavSQ4Ti1F8Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hJX6sFyL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40R4nJad005095;
	Sat, 27 Jan 2024 04:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=A42eYZHLTGwhV62DiLKLfzKqKPTKNWCdFWnyZMOCgA0=; b=hJ
	X6sFyLxzjG7yVWEdrA2J+ccNhmdv8FAeEqUE56UG1NxNuFofymVOjrRGGZzvvNVD
	VOPNW7bwosLQNmPSxalF7ETAHIwG8PAQCk94Q8TVHKdkJIGgLbhSnUsU1tk2lWvo
	PghLDN9zPEzt0a+II9YfFdnoBCfIY5pEWaLU35FyCTjOgQ38FsNkLBWl3rF3mAV/
	uy0WPP/h2B/a84s2quQS9AhqIzEgiKo1RBMpF4HQWW2f2A6UmsTTUoz6u4XAEqro
	+JWQ7TBh5TbLVuQ2GL2GV4sfZl5C/GKVfHIERykS/MyEsy7OukZm2pW139feSAQp
	FcpcOGq+uiSLE15FQWxw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvu4cr05g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 04:52:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40R4qeXo026527
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 04:52:40 GMT
Received: from [10.216.58.0] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 20:52:39 -0800
Message-ID: <489989fe-4663-47a3-9340-6ef4f17ab735@quicinc.com>
Date: Sat, 27 Jan 2024 10:22:36 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] wifi: cfg80211: send link id in channel_switch ops
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240125130410.827701-1-quic_adisi@quicinc.com>
 <20240125130410.827701-2-quic_adisi@quicinc.com>
 <bc9e932fd450fb4f8e0c6a35a5ee6087d9c5b189.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <bc9e932fd450fb4f8e0c6a35a5ee6087d9c5b189.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IQx6IauCSZolxCFuzO2bWew4crjHgEeA
X-Proofpoint-ORIG-GUID: IQx6IauCSZolxCFuzO2bWew4crjHgEeA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=684 phishscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401270034

On 1/26/24 14:48, Johannes Berg wrote:
> On Thu, 2024-01-25 at 18:34 +0530, Aditya Kumar Singh wrote:
>> Currently, during channel switch, no link id information is passed
>> due to which channel switch is carried on deflink always.
> 
> I guess I already know what you mean, but ... that's really hard to
> parse, can you rewrite it?
> 

Sure, let me rephrase it.

>> --- a/include/net/cfg80211.h
>> +++ b/include/net/cfg80211.h
>> @@ -1531,6 +1531,8 @@ struct cfg80211_ap_update {
>>    * @punct_bitmap: Preamble puncturing bitmap. Each bit represents
>>    *	a 20 MHz channel, lowest bit corresponding to the lowest channel.
>>    *	Bit set to 1 indicates that the channel is punctured.
>> + * @link_id: defines the link on which channel switch is expected during
>> + *	     MLO. 0 is case of non-MLO.
> 
> please use a tab
> 
Oh, checkpatch did not warn me. Let me take a look still. Thanks for 
pointing it out.

