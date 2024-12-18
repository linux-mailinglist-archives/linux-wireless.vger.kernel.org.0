Return-Path: <linux-wireless+bounces-16546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDE79F6B81
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 17:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EEBD7A4484
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 16:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D4113B58F;
	Wed, 18 Dec 2024 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GiGIEn9k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFDA1F63E7
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734540699; cv=none; b=qtUoho6ULrlcs/QfqCbnx/micTfKqE0QR+MujoBDLzGeHf0K1qjmWu4kKG+yIMjX75O3yRCIQ1SS+xP95bVRw73aEoxBtJhojXyL6S0m7Gdux9NhjEyqjgWi1ug49JcUlo4AGb4szr/7h8AEQ6yWKJJ0S2Vvk1sSqlq7ltzLNUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734540699; c=relaxed/simple;
	bh=1CHqfZYhPlf6EKoCl22DXsM9T1lN4zg/5IyelH5t39g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NLS42K4nIFnLMyyPXMZf+ib8RlWcsgGeJnBsOPgytEOPnwDFwpJolfxgBgwwer5rjd9j2/cwJzuxLRIocdOPFHT0OGWDJJKwsWPsMm1vL7GyGm77Dz9og9+3fmNBsyiQDhbhnwDHBAl9znJF9m9mAXACkga4xWZLkBfWoDRbxu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GiGIEn9k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIGQvJh007253;
	Wed, 18 Dec 2024 16:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7EFb4x4pnlVX1zLDUnhAMikpn7chtgX8B/AWY/a21Hg=; b=GiGIEn9kT/SbK5rM
	3t82XzrqBOGTZr7Ol1ZMUQCNtnZrFuHqiE0RhNu0PumLXgqk5KpkTEIboOfxVsrF
	zQdFMl+Wis5vNGGcPvySu8m+BbrNICBCZ3ULTVuERp1hPJlt5Kmd+lGeqlc85INn
	UfM7CoGvoqnzljhUiaCBF6OPzjHMoFzRni0z2OBcZaeNy09Jrr0pqq3QfGYsvtTi
	T74temfvRy6VQKzlqC1bSGHA29uA1jTGVjqiFq1lQPWClJt9ora88lpM3SyRBf4w
	2t1bc/Ld7VBHMN2jB1SPddUnQf1bJkuttTbHi/a/3Rmm/viRsLwPa92uFvQRXKwQ
	eTBMDw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43m00y8e0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 16:51:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BIGpWcF003110
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 16:51:32 GMT
Received: from [10.216.55.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 18 Dec
 2024 08:51:30 -0800
Message-ID: <82c78aac-8870-c809-e6f5-5fa1c0b2a2ef@quicinc.com>
Date: Wed, 18 Dec 2024 22:21:26 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: ieee80211: update Indoor AFC standard power type
 definition
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
CC: <linux-wireless@vger.kernel.org>
References: <20241213121146.2398269-1-quic_vjakkam@quicinc.com>
 <a850fd692db3458301eb5b7388110a3ec6ec0d01.camel@sipsolutions.net>
 <11d8f3a6-3942-44dd-9c41-fdc645e5fdeb@oss.qualcomm.com>
 <42e0e767b0dd55c8ddaca0cbf6aa123ec8fa3942.camel@sipsolutions.net>
 <a78e51f4-ea73-4d46-8893-07dbf4c9a2a3@quicinc.com>
From: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
In-Reply-To: <a78e51f4-ea73-4d46-8893-07dbf4c9a2a3@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pUjlrcC9UVqJBMIDlVg36C8kulQL5C_X
X-Proofpoint-GUID: pUjlrcC9UVqJBMIDlVg36C8kulQL5C_X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412180131


On 12/16/2024 11:46 PM, Jeff Johnson wrote:
> On 12/16/2024 2:54 AM, Johannes Berg wrote:
>> On Fri, 2024-12-13 at 12:11 -0800, Jeff Johnson wrote:
>>> On 12/13/2024 4:16 AM, Johannes Berg wrote:
>>>> On Fri, 2024-12-13 at 17:41 +0530, Veerendranath Jakkam wrote:
>>>>> Update 6 GHz regulatory info subfield mask and Indoor AFC standard power
>>>>> type definitions to align with spec changes introduced in the Draft
>>>>> P802.11Revme_D4.2, Figure 9-896 and Table E-13.
>>>>>
>>>> Huh. That seems like a change explicitly *designed* to break backward
>>>> compatibility? Should we accept the old value from older APs or so?
>>>> Otherwise we can't connect in some scenarios, I think?
>>>>
>>>> Or at least should we say here in the commit message or so why backward
>>>> compatibility was broken, and that it was for other clients that didn't
>>>> behave well or something but our code was already fine?
>>>>
>>>> Or am I completely confused about it?
>>> IEEE Drafts sometimes make non-backward-compatible changes.
>> Umm. Me voicing confusion isn't a reason to state obvious things back to
>> me as if that explained anything at all?
>>
>> In any case, they actually do that _very_ rarely (these days at least,
>> that was different 20 years ago I'd say) without taking existing
>> deployed things into account though.
>>
>>> This change brings
>>> us up to date with the language in Draft 7.0 that was ratified and will be
>>> published as IEEE 802.11be-2024.>
>> That's not what this claimed in the commit log.
> You are correct. When writing my response I referenced IEEE 802.11be Draft 7.0
> when I meant to reference P802.11Revme_D7.0 (since that is the latest Revme)
>
> I've been so focused on 11be that I completely messed up the reference.
>
>> It also _cannot_ be correct since this stuff is in baseline as far as
>> 802.11be is concerned, so it really cannot make incompatible changes
>> that suddenly make all HE stations non-compliant.
>>
>> And now that you're forcing me to look into it, I see that of course it
>> doesn't do that. This has nothing to do with Draft 802.11be in any
>> version which only makes one simple change to Annex E to add 320 MHz.
>>
>> The commit log claims that REVme changes it, and while that might be
>> true, looking at REVme (I don't have a redline version at hand right
>> now) indicates that certainly it didn't make it backward incompatible,
>> it now accepts multiple values and accepts the old values.
>>
>>>   So if anything breaks, it is because it
>>> hasn't been updated from the draft to the ratified standard.
>> Clearly not.
>>
>> Suggest you go back to the drawing board with these changes.
> Veerendranath, can you follow up on this part.
>
> /jeff


Thanks Johannes and Jeff for the comments.

As per my understanding, if client supports reading the 4th bit of 
regulatory info sub-field (i.e, dot11ExtendedRegInfoSupport is true) in 
HE Operation Element. it needs to use the values from "Table E-13,  
P802.11Revme_D7.0". I didn't keep the value 4 definition as it is 
reserved currently in "Table E-13" .


If we need to support both "Table E-12" (applicable when 
dot11ExtendedRegInfoSupport is not true) and "Table E-13" (applicable 
when dot11ExtendedRegInfoSupport is true) with same client, then I think 
value "12" also should be considered as Indoor AFC standard power type 
as per "Table E-12". So, we need to map to 4, 8 and 12 to Indoor AFC 
standard power type. Please let me know if this is fine.



