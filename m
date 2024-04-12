Return-Path: <linux-wireless+bounces-6259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 882DA8A30E7
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 16:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149D01F22430
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4B713FD91;
	Fri, 12 Apr 2024 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hw//TUZo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A331420BC
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932783; cv=none; b=dMelwwPgKsmWrdhLiOgecLp3Z8vKOtajAe1LVZc0zI17Yh8PiWHUDjdPSZbe70a/IWjcegTmFiXu5wPYrDbgDI43M8cBs9RYPkBWEtI4ef9Txm8FP7xCmkGcm4DFBx7Bi5X+DBvFdYLs0FUKbms7YrDcjUN9gq6VK9opX6ilipE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932783; c=relaxed/simple;
	bh=xS7lWTQUhD7zbfwawr3HbJjgenbZfU1jJe6N+OvWkN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bdPBsFNgb5GppvljJe3T1nX74cb9wrdu+H3qWiwa+ioYt4nv+NQa811DZedOiaaSgxZTOXLAJ7VeFtCQPBqDYas96yxe+JqDEi83dAgUXsWzfZYT8fILRfl3lp+kfonA1wAjRHfk4r3AwtyOPy7N5ZWmxY5/iR72eEohM1D4fss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hw//TUZo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CENwdA014608;
	Fri, 12 Apr 2024 14:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gd1ZSzgzh2RKA4xCiVlmx0jdKFZJnll663fP+QHa0b0=; b=Hw
	//TUZoL7LbpKPLwlcyYkb1p4z+Diydn6o6wRf9K3uSZiIAPseh8kmj4BInvwWer5
	Q1HbkmEwUsdqfWNop35CiltbKqTjxki1+ZCKQt6S1fp7ABpYuB2zfIsWCsHcIK41
	1wN7IHU56Jz8knFTJ2S+CpNc/opyS8ISiS+YyWf6+rsh7EhDS3VpWpK9af2+ydPp
	kUFP3dDLyWuSgibFTgmNfcu42/vBzsSRpKvyrRu1unKCvcZrJ1t+uJpCG/bPjMof
	bN1vZb0N/BdqFRlmyZgIsLGsckAM4TtRZqvCq9ClgtlJ5WvbNI6kFwpLmdjL0uF8
	pCbSczIbYy8vDOLrYaqg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xewr396w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:39:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43CEdS3Y026107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:39:28 GMT
Received: from [10.216.26.110] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Apr
 2024 07:39:23 -0700
Message-ID: <3726f708-8674-e4f2-1561-ca334f27e910@quicinc.com>
Date: Fri, 12 Apr 2024 20:09:16 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise multiple
 radio in one wiphy
Content-Language: en-US
To: James Dutton <james.dutton@gmail.com>
CC: Nicolas Escande <nico.escande@gmail.com>, <mbizon@freebox.fr>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>,
        Ben Greear <greearb@candelatech.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <e36599d3269496de59505b36be46f873976f8706.camel@sipsolutions.net>
 <033185b0-f878-a50b-d0d9-57fa79439bdf@quicinc.com>
 <ef6b6a7a4a9d3b01c0eb6abf0991e7e27425e102.camel@sipsolutions.net>
 <80fe5786-f764-455d-ac44-22adf7aeaf94@candelatech.com>
 <31f30c0e318904f3a082c7f213576ceb1f407141.camel@sipsolutions.net>
 <20b56e52-a5e2-70cd-a62a-8c4a3526c2cf@candelatech.com>
 <614bb8a8f1d9174ad7d87cf7636f657cda7b1ef9.camel@sipsolutions.net>
 <aa9e1d54-bb5f-37cc-335f-c9970ab13789@candelatech.com>
 <0cfe990b-182b-4ceb-b5b4-2989fefedb2f@quicinc.com>
 <29f7ecb6d7c208c3614f37616943d5f97bb134d3.camel@freebox.fr>
 <5fc2f2d2-7403-79d2-8909-ddda918ff8d5@quicinc.com>
 <af70ee81e583f58dada3dde87ac335137c4038b0.camel@freebox.fr>
 <6ff353e2-785a-f2ce-8d3b-acc8e79a64cf@quicinc.com>
 <D0HZ1KH5VJ8P.2TZZ7NNZXSJA8@gmail.com>
 <816770ca-fb30-e1cc-3f57-51d1fd35f141@quicinc.com>
 <CAAMvbhFPdPUOYSnxhO36E0yYJ7cuQLUGt87EqoGhBc=sw7GgHw@mail.gmail.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <CAAMvbhFPdPUOYSnxhO36E0yYJ7cuQLUGt87EqoGhBc=sw7GgHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 75oqmx5GkI6LT20WT3NFcH8-KyKFbj-Y
X-Proofpoint-GUID: 75oqmx5GkI6LT20WT3NFcH8-KyKFbj-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_11,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 clxscore=1011 adultscore=0 mlxlogscore=794 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120106



On 4/12/2024 5:30 PM, James Dutton wrote:
> On Fri, 12 Apr 2024 at 09:02, Vasanthakumar Thiagarajan
> <quic_vthiagar@quicinc.com> wrote:
>> On 4/12/2024 1:08 PM, Nicolas Escande wrote:
>>> On Fri Apr 12, 2024 at 5:50 AM CEST, Vasanthakumar Thiagarajan wrote:
>>>> On 4/11/2024 10:09 PM, Maxime Bizon wrote:
>>>>>
>>>>> On Thu, 2024-04-11 at 21:56 +0530, Vasanthakumar Thiagarajan wrote:
>>>>>
>>>>> Hello,
>>>>>
>>>>> Thanks for making it clear,
>>>>>
>>>>>
>>>>>>> For example, starting a 5Ghz AP in ax-only mode, and at the same
>>>>>>> time
>>>>>>> creating a STA interface on 2.4GHz ?
>>>>>
>>>>>> Yes, such use cases continue to be supported in single wiphy mode.
>>>>>
>>>>> Understood, but I see some corner cases.
>>>>>
>>>>>
>>>>> For example, assume two bands AP hardware, 2.4GHz and 5GHz.
>>>>>
>>>>> Previously:
>>>>>      - phy0 is 2.4Ghz
>>>>>      - phy1 is 5Ghz
>>>>>      - iw phy phy0 interface create wlan0 type managed
>>>>>      - iw dev wlan0 scan
>>>>>
>>>>> => will only scan 2.4Ghz
>>>>>
>>>>>
>>>>> With single phy approach:
>>>>>      - phy0 is 2.4Ghz + 5Ghz concurrent
>>>>>      - # iw phy phy0 interface create wlan0 type managed
>>>>>      - # iw dev wlan0 scan
>>>>>
> .> >>> => will scan both bands ?
>>>>>
>>>>
>>>> Yes, both the bands will be scanned if freq list is not given
>>>>
>>>>>      - <starting from previous state>
>>>>>      - # iw phy phy0 interface create wlan1 type __ap
>>>>>      - # hostapd -i wlan1 <config>
>>>>>      - # iw dev wlan0 scan
>>>>>
>>>>> => what will happen then ?
>>>>>
>>>>
>>>> Scan will be carried out on all the radios including the one on which AP interface is
>>>> running. Scan with freq list can be used not to disturb the radio of AP interface.
>>>>
>>>>>> Same goes for hostapd ACS, I assume specifying freqlist becomes
>>>>> mandatory or we can't predict which band the AP will be on ?
>>>>>
>>>>
>>>> If no freq list is given, ACS will run through all the bands and select a channel from any
>>>> of the bands. But this can be optimized to do ACS and channels selection on a particular
>>>> band using channellist/freqlist hostapd configurations.
>>> Hello,
>>>
>>> And in a (very unlikely) case that there are two underlying radios that can
>>> operate on the same frequencies, how would freqlist enable us to really select
>>> the underlying radio ?
>>>
>>
>> This can not be supported in this approach. As only the radios participating in MLO are
>> supposed to be combined under one wiphy, not sure if we have real use case to combine
>> radios of same frequencies.
>>
>> Vasanth
>>
> 
> Looking at this discussion, I think it would really be helped with
> some architectural diagrams describing the various combinations of
> components in an RF chain.
> 
> Let us take a single example.
> We have antennas, analogue front end, and ADCs (Analogue to digital converters)
> The features of those two are:
> 1)  Antennas can be optimised for particular frequencies.
> 2) The analogue front end has many different parameters, but for this
> discussion, the important one is:
> a) frequencies it can tune to.
> b) instantaneous bandwidth. I.e. When tuned to a particular frequency,
> what is the bandwidth around that frequency that one can receive.
> 3) ADC
> a) The Sample rate
> 
> Once the RF sample are in the digital domain one has the ADC ->
> DIgital Processing -> Output data
> If we assume that the ADC is set to receive the full instantaneous
> bandwidth, the digital processing can do a number of things.
> 1) process the full instantaneous bandwidth into a single channel of data.
> 2) process the instantaneous bandwidth into multiple sub bands, or
> multiple channels of data.
> 
> There is also the control endpoint that controls all these components.
> There can be multiple front ends for each ADC. multiple ADCs per
> Digital Processing.
> 
> A higher level process (maybe hostapd) can then speak to multiple
> Digital Processing and ADC, RF Front end components and then somehow
> has to manage and coordinate them all.
> 
> All these capabilities and varying arrangement of the various
> components need to be reported up to a higher level, in a common way,
> that can handle all possible arrangements.
> Once the higher level process has all this information, it can then
> manage to do everything necessary for Multi-Link operation (MLO).
> 

Exactly, that is what this patch series is trying to do. Advertising
per-underlying radio's capabilities to upper layer.

> So, to answer some of the questions in this thread.
> Scanning: The high level process should know what capabilities are
> available and what can be done in parallel or not. So it should be
> able to convert a request from a user, into a more detailed request
> down towards the hardware.
> I.e. User asks for scan.  High level process tells which bits of the
> hardware should do the scanning and across which frequencies.
> While it might sound complicated, when implemented correctly, it is
> just a matter of iterating over a  tree with a search match criteria.
> 

Current implementation does not change anything in scan function
wrt a wiphy. So there will be only one scan at anytime for a wiphy.
Possible enhancements can be discussed and added in future.

Vasanth

