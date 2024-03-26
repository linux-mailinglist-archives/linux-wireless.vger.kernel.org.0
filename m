Return-Path: <linux-wireless+bounces-5295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF7E88CC1D
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 19:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724AF1C2AE6F
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 18:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DEF13C9AF;
	Tue, 26 Mar 2024 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T9rarylL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4449D3A8D0
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478191; cv=none; b=Wtf8qxhw/pRSQuWZbNEXTVvV1GMXP1kxl6ftCABA4lVBSUWrSZwPRLtwyl+LrX8zRkewwvjBpR06OpDOKqx2R4cdSdLUtgcS1U+psiY0h4lP2vCYhMOfRZkjfrgoZfdwlfNPXdzycze9Hw5ZONQVXNt7dq6ElNMM4z9LIyVJZHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478191; c=relaxed/simple;
	bh=U4OFmNtu5WQcqY9fZT0169qv6OPVSRmYUDbBW68hSOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FjP+ZsnlsvcURCB/6x0c8f1tjPjm2OiE9EMLWXdYiBP9uQ6+bYGSHthQdPAiozJCo2XxLqA6Aib7X2ObG9oW+GlcOLKOcGGHi4QcFioVTw2KRl9zSWrrEygxOe1V9tQs4luP74/qjWxtllqJHvyEXp3rzP06qTW0TPNiREKMA4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T9rarylL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QG67d8011784;
	Tue, 26 Mar 2024 18:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=s3/3hAL6UlvpFzxo2umnwfzumWgCgBGpQ0ePDGiNPnc=; b=T9
	rarylLQ9nFyMhX3nFmFipqdupN8AMFTFa3gXhD1o/52uE7IbugEY3OnfHrql8hWi
	jiGiIzdfDw75yhPGmsthA01joUQxrWRIlZMMZP3pwJNGqPbKYQxAgN7Ei9oSrJCA
	1NalQyfyxWikKGGmpKH+iYbjl2o8j6NXvK30SgHeQLzkL4dWMrJRv8oHxkOXUpV1
	gpwVmcLRBCJjGf8Gi894hdXoue3NkF5g3fYYXBFYwYnHjI3FfKMceIsmDqLN0DtX
	F4zyGKRbzAlTyebrvybmGkemaaJTm3g54RtRiURbyCsDcc0YGYNYAnsScOQmyGeM
	Pd0E7Ld1uUPAUWmMNyvg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x41k68dfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 18:36:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QIaNtQ007547
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 18:36:23 GMT
Received: from [10.110.10.42] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 26 Mar
 2024 11:36:22 -0700
Message-ID: <c6891df6-0b34-43d6-b931-16a3da577407@quicinc.com>
Date: Tue, 26 Mar 2024 11:36:21 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] wifi: mac80211: Add EHT UL MU-MIMO flag in
 ieee80211_bss_conf
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240325201031.10837-1-quic_pradeepc@quicinc.com>
 <20240325201031.10837-2-quic_pradeepc@quicinc.com>
 <8efc258b698acd504c1fc699d026b906bf383894.camel@sipsolutions.net>
 <b4fb2e9f-b7af-42da-be97-9ae1560ebad2@quicinc.com>
 <a313c313ab41325843092dc8445386dd802ed115.camel@sipsolutions.net>
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
In-Reply-To: <a313c313ab41325843092dc8445386dd802ed115.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FYnLHGR7_wwKFh8ECE7_z06JFbowGO8r
X-Proofpoint-GUID: FYnLHGR7_wwKFh8ECE7_z06JFbowGO8r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260133



On 3/26/2024 11:32 AM, Johannes Berg wrote:
> On Tue, 2024-03-26 at 11:31 -0700, Pradeep Kumar Chitrapu wrote:
>>
>> On 3/26/2024 6:00 AM, Johannes Berg wrote:
>>> On Mon, 2024-03-25 at 13:10 -0700, Pradeep Kumar Chitrapu wrote:
>>>> Add flag for Full Bandwidth UL MU-MIMO for EHT. This is utilized
>>>> to pass EHT MU-MIMO configurations from user space to driver in
>>>> AP mode.
>>>
>>> This ^^ doesn't match this:
>>>
>>>> + * @eht_80mhz_full_bw_ul_mumimo: does this BSS support the reception (AP) or transmission
>>>> + *	(non-AP STA) of an EHT TB PPDU on an RU that spans the entire PPDU
>>>> + *	bandwidth
>>>>
>>>
>>> which doesn't match the implementation ... Wouldn't be a bad idea to
>>> actually do what it documents though, I guess?
>>>
>> Thanks Johannes for review.
>> can you please help clarify what you meant by "actually do what it
>> documents"? This will help me to amend next revision appropriately.
>>
>> I have tried to describe what this flag is trying to represent.
> 
> Yes but ... you document AP and non-AP STA, but only implemented it for
> AP?
> 
> johannes
Sure. Thanks. will fix this in next revision.

