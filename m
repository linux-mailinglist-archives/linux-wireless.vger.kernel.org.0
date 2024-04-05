Return-Path: <linux-wireless+bounces-5884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FDE899303
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 04:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94241F23455
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Apr 2024 02:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D5028EC;
	Fri,  5 Apr 2024 02:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZCI2gpH5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F1C28E2
	for <linux-wireless@vger.kernel.org>; Fri,  5 Apr 2024 02:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712283183; cv=none; b=WsTAwzRuGVuMW0+l2F0tH1WTtdlY4DD1/OxTRR6SNYg9dUcV2fNywfpJsCg1e3p3y0qnNOS0NNZeJWfVjVKHHJEPHEhUMs+GGZ2A1wFCpE0y0s7GBo4Zbz4ytfM1ZPP5fVxGPm4Csfqri0i1M8eZYXwnoXeKPDjlKmAZ4kgHk5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712283183; c=relaxed/simple;
	bh=Xzw8cNAYmQKVPyY3losD+5pxsBv8FtkFG9PB2CvsEjc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=USXIr1c6/X1nN/Wc6JJ/Qm6UbgW3RxDHcML23R5ybRbTfr8ITUpBiNUApFinuoLhIgFA6QhgMVKR4I+LpURiowu2gdODWYIpGKmfwmvsh0mYlO4s5vfIZ6LTAiVlUAJi8kuFW6m7zfXmdthWl4NDzsACe43rLT4jgL+WVXTtNek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZCI2gpH5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4351mxfx020530;
	Fri, 5 Apr 2024 02:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=/iAnF6RMBMR9Cv+V593XwuDhEfJct5e1WWwMk7XEDjQ=; b=ZC
	I2gpH54cW/hFsVOguMvMRIRpZsGjffsTQ6ydCf+wlTbusRuvgzakMbyp+3R/gsfn
	dykIvSZJzLmZqcZI0JPfYD5Brnq0X9yfbDhug0OoAhbPiZHN+uEKvsm6+dDJGHQr
	Xrjbnrun9/3L4T5drKajst6rYxG8TMTFx3mgUfKgj1WfWSOJGht7Cca+h7N4Nz43
	nmXTuKcxahxCRGX+CVWOeQS4JYhAwDbKAOPJd8t2Bw1ItTxbRcE42KcsK9kYVHRT
	HZ7E/OpgQZ3UBe4drEpShDdeDRrsfMLQHa2jyggMsOx8BYdtLNpnzqxUjVzI/E3k
	Bpyc1H0+1XjETXAM4KoQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9v8jhhgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 02:12:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4352CrYV022972
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 02:12:53 GMT
Received: from [10.216.59.212] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 4 Apr 2024
 19:12:51 -0700
Message-ID: <65e994e1-8da9-470f-9b1e-b2db20974b2d@quicinc.com>
Date: Fri, 5 Apr 2024 07:42:31 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/12] wifi: ath12k: Add single wiphy suppor
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240401190409.2461819-1-quic_ramess@quicinc.com>
 <0d1058eb-aced-4e81-9f61-e4b5a08c04a2@quicinc.com>
 <bdf7abad-3d13-4085-8e75-c0d5ff4b41db@quicinc.com>
Content-Language: en-US
In-Reply-To: <bdf7abad-3d13-4085-8e75-c0d5ff4b41db@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hbJ3oNkSs0nRI806L6a3Zfhwnz_pPBNA
X-Proofpoint-ORIG-GUID: hbJ3oNkSs0nRI806L6a3Zfhwnz_pPBNA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_01,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0
 mlxscore=0 clxscore=1011 mlxlogscore=999 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050015



On 4/2/2024 3:36 PM, Rameshkumar Sundaram wrote:
> 
> 
> On 4/2/2024 1:04 AM, Jeff Johnson wrote:
>> On 4/1/2024 12:03 PM, Rameshkumar Sundaram wrote:
>>> From: Sriram R <quic_srirrama@quicinc.com>
>>>
>>> With the introduction of Multi Link Operation (MLO) support in
>>> IEEE802.11be, each EHT AP/non AP interface is capable of
>>> operating with multiple radio links.
>>>
>>> cfg80211/mac80211 expects drivers to abstract the communication
>>> between such Multi Link HW and mac80211/cfg80211 since it depends
>>> on different driver/HW implementation. Hence the single wiphy
>>> abstraction with changes in datastructures were introduced in
>>> "wifi: ath12k: Introduce hw abstraction"
>>>
>>> This patchset extends the implementation to allow combination
>>> of multiple underlying radios into a single composite hw/wiphy
>>> for registration. Since now multiple radios are represented by
>>> a single wiphy, changes are required in various mac ops that the
>>> driver supports since the driver now needs to learn on how to tunnel
>>> various mac ops properly to a specific radio.
>>>
>>> This patchset covers the basic mac80211 ops for an interface bring up
>>> and operation.
>>>
>>> Note:
>>> Monitor and hw reconfig support for Single Wiphy will be done in future
>>> patchsets.
>>
>> thinking about this series in the context of some other patches I've been
>> reviewing recently, I don't think this series should be talking about
>> supporting multiple radios with a single wiphy, but instead about 
>> supporting
>> multiple devices with a single wiphy. After all, the existing logic 
>> already
>> supports a single device with multiple radios, so it isn't the 
>> multitude of
>> radios that is the issue, it is the multitude of devices.
> So far we are only combining radios of a device (ab) and registering it 
> as single HW(ah) to mac80211. Currently ah will only contain radios of 
> one device. Combining multiple devices into a single HW is different 
> series (where ag will be introduced).
> 
> Having said that, even if multiple devices are combined with ag, at hw 
> (ah) level there are only radios of multiple devices (ab) and hence 
> these patches stay generic and call them as radios.
>>
>> this would have ramifications on many of the commit messages in this 
>> series.
>>
> 
Hi Jeff,
Planning to re-spin v7 to address comments on PATCH 07/12, do you have 
anymore comments on the commit text or other patches ?

