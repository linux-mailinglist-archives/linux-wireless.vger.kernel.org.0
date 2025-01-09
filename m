Return-Path: <linux-wireless+bounces-17231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C665FA07063
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 09:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C4907A1489
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 08:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9D81EBA19;
	Thu,  9 Jan 2025 08:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fH7KBzcM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97AA21506F
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 08:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736412949; cv=none; b=AkSxKfXVQeJ27XFPOaVOvreT54MtGjN54jatKS7KROsaguROgaxob9e3umhRmsBMBsK0UMqUqN/oKcYcn3OS76qxFrMfEkbVyzPheunjOoSPmgtmITwCR3X/Q5dEq8ojvQPXIia9DfT1J07GNpy2deL3DTfx71EPIjBm1iMBizs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736412949; c=relaxed/simple;
	bh=p6/uwNVXwVVO7YtLobjBLeUAjfLNZEnWSv3WhIew1cQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=j5OiVbcDWOJ2iAEzmK+cV57Lw+4YYSwISHE7b65NiRIXil209CWOAsHNv9MY6eF/1TCXks9LhUYHXQTlYtLyEZeKun8Nt1u7lG+hdBfR5YA5cSCNCD0/+4u+dMQ2IjPyZ8zpkZdr7Ozx0DM9zw6ZrGf/OpeXJd7UBMBQeBxQRV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fH7KBzcM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5094Bxe0018861;
	Thu, 9 Jan 2025 08:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AWfGqZeRXb28tohjY6prEpFZCsSptpel7Zl8YCViXlA=; b=fH7KBzcMeCAt4XCb
	AyTyJkcl8Vhu01T2PY0F3DLc+yUtgVNV6s7BRuBs2FvBiwZwCKPrqN6KHOubDCkR
	H17sC8lhOJA08XwUvwP9MM9QA8/jNRBpT+3Us/mmnkEyLDsJ7pkAG3SxhhPuQLcc
	8oRFXXtfWLiH4Bt9Wf3hv8oUlhjq5t384CNNwXYgavstiLtNMr8Y6O+g8KuuzagU
	bjQjhzMO2f7PdVNGz6oWSeAqMcLRzF86KYEx8FNAgRpIjyZkNaBiHhKtfTBPnwMJ
	Ag1jA4caVJ3HQK9BsVF0/0XQ7LhlEc1WQ1+/rJ+VWFJefXlI2CacisQF9Rfdd3i5
	EdSNQw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44277e0ktd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 08:55:43 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5098tgVc000564
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Jan 2025 08:55:43 GMT
Received: from [10.204.117.236] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 9 Jan 2025
 00:55:41 -0800
Message-ID: <a17e0431-30b3-49d3-8991-517ac34371d3@quicinc.com>
Date: Thu, 9 Jan 2025 14:25:31 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: cfg80211: skip regulatory checks when the
 channel is punctured
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_mpaluri@quicinc.com>
References: <20241125051624.29085-1-quic_kkavita@quicinc.com>
 <cc95ac5eb124ff46484a44beb0e2ec300d1d6392.camel@sipsolutions.net>
 <b4c7a1b1-86cf-4c06-b7ee-21f2f6333dec@quicinc.com>
 <81f864e1fcc1c226763273dec915e43f1fe14f5f.camel@sipsolutions.net>
 <bfe298e3-c096-4426-a948-c4a67a5b8db0@quicinc.com>
 <91fc1c1717646a8562ac2a74c4e2d9928a145171.camel@sipsolutions.net>
 <19e73db4-921a-4ccb-8f31-0c9a960933af@quicinc.com>
 <b368631e95d8171df90daa31b357e09d54294fcb.camel@sipsolutions.net>
Content-Language: en-US
From: Kavita Kavita <quic_kkavita@quicinc.com>
In-Reply-To: <b368631e95d8171df90daa31b357e09d54294fcb.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fQSbc9IJooi1l9p3SouyMgujJf6f0EFD
X-Proofpoint-GUID: fQSbc9IJooi1l9p3SouyMgujJf6f0EFD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=442 impostorscore=0 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501090072



On 12/19/2024 5:35 PM, Johannes Berg wrote:
> On Thu, 2024-12-19 at 17:29 +0530, Kavita Kavita wrote:
>>
>> For example,
>>
>> Please refer below Implementation of cfg80211_get_chans_dfs_required:
>>
>> for (freq = start_freq; freq <= end_freq; freq += MHZ_TO_KHZ(20)) {
>> 	c = ieee80211_get_channel_khz(wiphy, freq);
>> 	if (!c)
>> 		return -EINVAL;
>>
>> I handled this above "if" case within the macro itself, so when this
>> case occurs, the loop terminates and does not check further subchannels.
> 
> Oh. Hmm. I'd be surprised if we don't have anything that checks for this
> elsewhere and we even _need_ this check, but I suppose it's possible and
> then the macro should actually just have a NULL channel pointer for one
> of the iterations so the user can check?
> 

Yes, we have fixed it in v3 patch. Thanks.

> johannes
> 


