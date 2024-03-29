Return-Path: <linux-wireless+bounces-5594-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A842089227D
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 18:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C77001C20B51
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 17:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4C939FF7;
	Fri, 29 Mar 2024 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Sk/pCA4c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AAB364D8
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711732483; cv=none; b=uer18qZR7ZdcRJ0inJn3DnxASrMQErlAhdQCJ85OGzB1SYq/CwRs0WcbVt+tKWCSg5ySMaI9LM46N4D/rwYZ+hAywxHHVunc4P8gJF8tFRvdrcFTZ1704qhkl94sEg9SWv9tI5Fv/h6+1SrtTtHDpPNX+G15sI/Xi3wgnNdJvWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711732483; c=relaxed/simple;
	bh=nZnWVA30Bf56vouwPFF8UwC0pZR6VPfUB6Q+hU4pSj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Up5T36tzlRg4FaNHDuHs+pfdiqziBG3L8814wDuf9cWShWJsVuEo5E/3c9/mH2z9V2tOAry9bjPkZM3fvbdGhPhPKT4lxQgzzd1W2bfuBh6pvcR+JhokTvu9cKuoNtR/QYhxl6Zq2RMj9NfdxlYBa5VYQ+Kz34DnKe0jbCnSfQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Sk/pCA4c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42TEvFWo031646;
	Fri, 29 Mar 2024 17:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=yXq4ktTN74LI4eAOGsll4zVdw27T+3mRz0u9gf/jUvs=; b=Sk
	/pCA4cF+ze1Mp1L4LMJ2MttuyxSaqEU07z+VPSlmsnFMnfRi59U8n4PxiG8gv5Hq
	7iCjlqDrE5Vbh0Cans+ahsjOxanBC7kq6k1PbCsLC2M/k6A7SticBC3SXQ3OTNW1
	uTQn3jd7NYIMe01POe3lMHnHi9mEJ5LFFNjP9+s+J0KRMyMzC+2ovl5U7V6Rwq4Q
	iuDs5yhLNbf8QaGWp9rJPFpLuXwEH1herWZeATSoQxZhdqjl0QCaU0zHkRhFk8qL
	TLlyhjAftyATU3MOME3fJ1E59o9iQo3Az+ugdnIAgNi9/XlH2FF82zGeyOE2cw9z
	WnpKHjb0BffJZcmV80bA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5xcy0fxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:14:37 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42THEb8E006953
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 17:14:37 GMT
Received: from [10.50.15.209] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 10:14:36 -0700
Message-ID: <544b2adc-9b4f-4198-8547-c556c9ebdaa9@quicinc.com>
Date: Fri, 29 Mar 2024 22:44:36 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] Add Multi-Link Reconfigure link removal support
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240328055235.3034174-1-quic_mdharane@quicinc.com>
 <36c9759651193a1de32020b9f9a019523eebabc8.camel@sipsolutions.net>
From: Manish Dharanenthiran <quic_mdharane@quicinc.com>
In-Reply-To: <36c9759651193a1de32020b9f9a019523eebabc8.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: brmS0Elt_7Bc9lZkekNFzXfSDTkz8w-Z
X-Proofpoint-ORIG-GUID: brmS0Elt_7Bc9lZkekNFzXfSDTkz8w-Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290152



On 3/28/2024 11:55 PM, Johannes Berg wrote:
> On Thu, 2024-03-28 at 11:22 +0530, Manish Dharanenthiran wrote:
>> This is a preparation for supporting Multi-Link reconfigure link removal
>> procedure[IEEE P802.11be/D5.0 - 35.3.6.3 Removing affiliated APs] for
>> driver which supports offloaded Multi-Link reconfigure link removal.
>>
>> Multi-Link reconfigure link removal offloaded drivers will take care
>> of updating the reconfiguration MLE in self and partner beacons.
> 
> I think we need to flesh that out. I don't know if you saw the CSA
> discussion, but I think it's pretty obvious that the same discussion
> about partner links is going to apply here. That doesn't necessarily
> mean that you _have_ to do that in this set (though I'd actually like to
> see it to support hwsim, for testing purposes of both sides), but I
> think the way it's written now the API doesn't consider how we might
> update partner links if it's not automatically handled by firmware, etc.
> 
> johannes

Yeah, the intention for this RFC to get some insights from upstream 
community about the usage of new NL commands and attributes for driver 
which has the synchronization between partner links in the lower level.

Will try to send hwsim changes in a separate one where it handles for 
both (offload/non-offload) cases.

I believe you are referring to discussion here: 
https://lore.kernel.org/linux-wireless/f7174207668cac149246cafa0e4b4749ee3289f0.camel@sipsolutions.net/

I thought of sending these API(s) with only offloaded driver in design 
for this RFC which i will try de-couple or make it more generic while 
sending the upcoming versions.

Also, for non-offloaded there are certain API like reporting TSF might 
be redundant, since, we will do the offset and time calculation either 
in hostapd or kernel directly. We are still finding ways on how to do 
that for non-offloaded driver since this might need a similar or 
additional handling as CSA.

