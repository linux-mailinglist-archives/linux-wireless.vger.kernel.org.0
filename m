Return-Path: <linux-wireless+bounces-5231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663A388AE25
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 19:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97DD71C603CE
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Mar 2024 18:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B52220310;
	Mon, 25 Mar 2024 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HnxI2a49"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26723DAC1C
	for <linux-wireless@vger.kernel.org>; Mon, 25 Mar 2024 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389399; cv=none; b=sFc9nKTsyY+0bVNVeZncOt/i1BCHZbv8Rx8LfkeIvyMStLgiX+Z7rDszZQn4l5beknHVqQG5uNCayzzvjpJzD8n34BMQeAeZB7X578kul0A61s0drW8wlDMb/zqO0S2m7LlherPpr9KCEprUBfC4CVh3SZRJ6ZQQhoWq3sKUZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389399; c=relaxed/simple;
	bh=G7Kbw94WkN9Q6kQ6nJMBwibyGFJAJKbD4M5EsqkNlxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ibQbZDCBCd0R40rNSEKRl8l84baItIwfo8r3ieIjG5325TOw2zZb3LzbnwkJ24LM1IiLxHE654hinMHvQ+41MhITKveuXcDx4aPHVxTzWsx//G5uTpDHFkmXQyLoJJAw6rBQmR4XKYWDbPy5nQ6zcgPdX85PoPnyb61mzYPAsT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HnxI2a49; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PCQP52029057;
	Mon, 25 Mar 2024 17:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=0B1ftZ1V1VSvyqbImclwkZ0YLs+5N7W2rQd28D6C91Y=; b=Hn
	xI2a492M1Uk8lP1yNoWricbG7oekC8w6R8o+0vWG+Ey1ZM3+6W84RWiizy1lW81U
	KPMuzhHYckNT/azDaylIB/dMuup8neYmHksLWsefKw7gzny5ASz+Ly13OXiqHjaY
	dCRAveictb6fEQcQfZOvGH9QD9EOTQ+U0XdqNjNdiJjUoavv6tmYvo1UKzZAn53/
	emgdFDMfE1la2CReyhpyz+QLprnxhLUOnydfiCzwSL24CvNr35VQdUAeLixaDG4J
	9RwWMPjImyBa5rFkDsnCmunTwMkzQ1ozTPdWqQ4I4NhVv7NtXucvizNqTF5EBSWJ
	ysrNViO949Jxl9UG1tbg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x3626hana-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 17:56:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PHuNZC011908
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 17:56:23 GMT
Received: from [10.216.55.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Mar
 2024 10:56:21 -0700
Message-ID: <d06a3aea-e515-4499-b56d-1fb5979152ee@quicinc.com>
Date: Mon, 25 Mar 2024 23:26:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/12] wifi: ath12k: Add single wiphy support
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>
References: <20240320190943.3850106-1-quic_ramess@quicinc.com>
 <ff7db654-fa0a-479a-8497-9d61065bc60e@quicinc.com>
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
In-Reply-To: <ff7db654-fa0a-479a-8497-9d61065bc60e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 332I5z7NAGGWfxj9tlhqMBIg-jecwlMV
X-Proofpoint-GUID: 332I5z7NAGGWfxj9tlhqMBIg-jecwlMV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_15,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=967 mlxscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250104



On 3/21/2024 2:30 AM, Jeff Johnson wrote:
> On 3/20/2024 12:09 PM, Rameshkumar Sundaram wrote:
>> From: Sriram R <quic_srirrama@quicinc.com>
>>
>> With the introduction of Multi Link Operation (MLO) support in
>> IEEE802.11be, each EHT AP/non AP interface is capable of
>> operating with multiple radio links.
>>
>> cfg80211/mac80211 expects drivers to abstract the communication
>> between such Multi Link HW and mac80211/cfg80211 since it depends
>> on different driver/HW implementation. Hence the single wiphy
>> abstraction with changes in datastructures were introduced in
>> "wifi: ath12k: Introduce hw abstraction"
>>
>> This patchset extends the implementation to allow combination
>> of multiple underlying radios into a single composite hw/wiphy
>> for registration. Since now multiple radios are represented by
>> a single wiphy, changes are required in various mac ops that the
>> driver supports since the driver now needs to learn on how to tunnel
>> various mac ops properly to a specific radio.
>>
>> This patchset covers the basic mac80211 ops for an interface bring up
>> and operation.
>>
>> Note:
>> Monitor and hw reconfig support for Single Wiphy will be done in future
>> patchsets.
>>
>> ---
>>   v5:
>>   - Addressed Jeff's comments
>>   - Made arvif config cache to be dynamic in PATCH 07/12
> 
> In the future please be specific about what patches in the series were
> modified so that reviewers don't have to spend time reviewing the parts that
> didn't change.
> 
Sure will follow this for future patches.

