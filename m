Return-Path: <linux-wireless+bounces-6229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFBD8A28A6
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 10:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4087B2890C5
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 08:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F64E5028E;
	Fri, 12 Apr 2024 08:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j4OzTnRX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC5C50284
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908920; cv=none; b=DoBJ8fgIXxBirOPimW4cY6f+2ssS8ysraR/SpGbtwcmYdx+TOeZ4s3PQmBiWWji2/pK/p4uECmbmsU6lUv1S24WHdsDgG0vkOC2mvd1WkYK40l8gOJRbY4mlxYF8AkoMbMS5+b+K0dn9XOQBqApG7VDpKdzlI7HIoJNo6eCuHZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908920; c=relaxed/simple;
	bh=ZTljc3xsYBOItWKc1lJqgMiXwrIpr7b4wW6fdzNCKjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y7R5pxYk8V2l/adVSwbw+WFTuf2mPr2hxzUUhbo+7LM7kI8Wu/X55/ucWpCFhYl6J8kL1g/xvufNHL+33W2Ne75g20G8nHu/uHzJQbdvYfdLG1QcsR39Hpg9NB40x6hkyrt4udX7LFXQhg5tVXq1KnOvfKTAVzhsFVdwxqikV0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j4OzTnRX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C3Qrp7011206;
	Fri, 12 Apr 2024 08:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=AXzmqe/HV/pIPC+x11YnHRp97KRRithDzZxLf+bgUfQ=; b=j4
	OzTnRXQ84Opz3o+3H/K2rm4czoQ6o6R99i4r7wX/uoMnognpICb2cZs470+hfSIZ
	+Hp43n1Qvs0vIgCNy5KwZPBheENypAtEapsnKp8c8HE/vNjQHDOWIrupcNt6ckxm
	eT1VUaChf1RXhysqeQV3dH4ARc/MO+MtXZGG/xVTX+hWojzVj9HHpIiDlqIoxOtg
	QzjMh2iyQPNgDjGfmCMAboO1Zx/bI0O/DGN2LuyDKRMk/cqGZMn5tNlVDmjaVYa4
	PNYGYlFEpph2Fx4ERDUMrQpwIb212WDdm8A4hD1taD0nNwpkES3OJ3y1dluiE9VY
	HI6BdcCvyMBR1PXlpuaQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xevweghb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 08:01:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43C81f0W027173
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 08:01:41 GMT
Received: from [10.216.26.110] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Apr
 2024 01:01:37 -0700
Message-ID: <816770ca-fb30-e1cc-3f57-51d1fd35f141@quicinc.com>
Date: Fri, 12 Apr 2024 13:31:30 +0530
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
To: Nicolas Escande <nico.escande@gmail.com>, <mbizon@freebox.fr>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>,
        Ben Greear <greearb@candelatech.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-2-quic_periyasa@quicinc.com>
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
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <D0HZ1KH5VJ8P.2TZZ7NNZXSJA8@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bTQnSVxn0gzORnd4lBkXWkqhK_tKoFU8
X-Proofpoint-ORIG-GUID: bTQnSVxn0gzORnd4lBkXWkqhK_tKoFU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 mlxlogscore=407 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120056



On 4/12/2024 1:08 PM, Nicolas Escande wrote:
> On Fri Apr 12, 2024 at 5:50 AM CEST, Vasanthakumar Thiagarajan wrote:
>>
>>
>> On 4/11/2024 10:09 PM, Maxime Bizon wrote:
>>>
>>> On Thu, 2024-04-11 at 21:56 +0530, Vasanthakumar Thiagarajan wrote:
>>>
>>> Hello,
>>>
>>> Thanks for making it clear,
>>>
>>>
>>>>> For example, starting a 5Ghz AP in ax-only mode, and at the same
>>>>> time
>>>>> creating a STA interface on 2.4GHz ?
>>>
>>>> Yes, such use cases continue to be supported in single wiphy mode.
>>>
>>> Understood, but I see some corner cases.
>>>
>>>
>>> For example, assume two bands AP hardware, 2.4GHz and 5GHz.
>>>
>>> Previously:
>>>     - phy0 is 2.4Ghz
>>>     - phy1 is 5Ghz
>>>     - iw phy phy0 interface create wlan0 type managed
>>>     - iw dev wlan0 scan
>>>
>>> => will only scan 2.4Ghz
>>>
>>>
>>> With single phy approach:
>>>     - phy0 is 2.4Ghz + 5Ghz concurrent
>>>     - # iw phy phy0 interface create wlan0 type managed
>>>     - # iw dev wlan0 scan
>>>
>>> => will scan both bands ?
>>>
>>
>> Yes, both the bands will be scanned if freq list is not given
>>
>>>     - <starting from previous state>
>>>     - # iw phy phy0 interface create wlan1 type __ap
>>>     - # hostapd -i wlan1 <config>
>>>     - # iw dev wlan0 scan
>>>
>>> => what will happen then ?
>>>
>>
>> Scan will be carried out on all the radios including the one on which AP interface is
>> running. Scan with freq list can be used not to disturb the radio of AP interface.
>>
>>>> Same goes for hostapd ACS, I assume specifying freqlist becomes
>>> mandatory or we can't predict which band the AP will be on ?
>>>
>>
>> If no freq list is given, ACS will run through all the bands and select a channel from any
>> of the bands. But this can be optimized to do ACS and channels selection on a particular
>> band using channellist/freqlist hostapd configurations.
> Hello,
> 
> And in a (very unlikely) case that there are two underlying radios that can
> operate on the same frequencies, how would freqlist enable us to really select
> the underlying radio ?
> 

This can not be supported in this approach. As only the radios participating in MLO are 
supposed to be combined under one wiphy, not sure if we have real use case to combine 
radios of same frequencies.

Vasanth

