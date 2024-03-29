Return-Path: <linux-wireless+bounces-5582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6730A891FD6
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 16:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988B21C23E16
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 15:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC307148839;
	Fri, 29 Mar 2024 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NPA6A6Ti"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB141C0DFB;
	Fri, 29 Mar 2024 14:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711722119; cv=none; b=PiPASvSjlpSdelrwzWOXIxE+te57umEa8J36oXyQq8oKDlOkJuoyn6WDcRp9ki7T0aHgBmezb7ZO3yk3B5FWyJSbV1afclEPfHMUaizRJ+WWGr0ttE/hogAaAsiurZFy44kpWwAhbXfyCbf86BwYq+kA1jErpStDePfx4EjLdYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711722119; c=relaxed/simple;
	bh=tRFGWFn8JvlgUfpnkz1zln9jZLKRsOjMdhyQu8Gm2nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=emkrjaUFQPq1CcC6VSKs0v3+IOpDIB0DLWuX9QJkQhdP8JVRUNCOMX9TjA/WrcyInBoieTh8nPcirFFv/kGDy5ZRgEL5+FAZG0a2MtNg8A4cps1LzN7K6K79Mf8q8fM+dNxI3dG9YBlZcnhWCZkLRFQY99nZpS00+Iqc/bnwo9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NPA6A6Ti; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T9glCL024605;
	Fri, 29 Mar 2024 14:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ejX7WA6CEulUy4Wyq0+pwMGa6pLxqtQg7gGpn2ixRo0=; b=NP
	A6A6TiuHJM4CPFXhLhUMHZHxsKXBI3u7hGWJgMH+RCpnAOaXJRuFmS/8iDeeQ3Cb
	FXxdhgXyu06/X6bYFdID+6OCRnlBauVY/uvvbPPHxIY9tPxm6+gxpvzgyYs85Bc1
	34RqjJuhxD+BVkyloKJF8TMsInfc4bmJ+WeHkRmcX3PFQmt1s3DGkDQVjCvLy/cN
	vMk9a8NGbewoke55k9ONeN0q43rYwiPgC5cz5TOhCXZY7SAGx3AM4qpG9NNiXMMn
	K2kIqHiqZKcEIgdGwgEz5g7TIbsaIkFb/W9EBjDaQt70ZT2ijsX+iknuCn/C02Z5
	dLnmp58YM4J3Gflzj4iw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5u89gprc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 14:21:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TELYNZ005721
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 14:21:34 GMT
Received: from [10.216.7.62] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 29 Mar
 2024 07:21:31 -0700
Message-ID: <b455f267-9552-be3b-95b0-a036bfa8e14a@quicinc.com>
Date: Fri, 29 Mar 2024 19:51:26 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/13] wifi: nl80211: send underlying multi-hardware
 channel capabilities to user space
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        Jakub Kicinski
	<kuba@kernel.org>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
 <20240328072916.1164195-3-quic_periyasa@quicinc.com>
 <6d92d0ba4a8764cd91cc20c4bd35613bcc41dfcd.camel@sipsolutions.net>
 <9d5c2f9f-19b5-af4d-8018-1eb97fac10d6@quicinc.com>
 <9d0f309da45ae657cd2ce0bc11a93d66e856ef64.camel@sipsolutions.net>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <9d0f309da45ae657cd2ce0bc11a93d66e856ef64.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4LexPhEF2dgILNBJ8m42xD9gLAAI04c8
X-Proofpoint-ORIG-GUID: 4LexPhEF2dgILNBJ8m42xD9gLAAI04c8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403290127



On 3/28/2024 5:31 PM, Johannes Berg wrote:
> On Thu, 2024-03-28 at 15:48 +0530, Karthikeyan Periyasamy wrote:
>> On 3/28/2024 1:19 PM, Johannes Berg wrote:
>>> On Thu, 2024-03-28 at 12:59 +0530, Karthikeyan Periyasamy wrote:
>>>> +/**
>>>> + * nl80211_multi_hw_attrs - multi-hw attributes
>>>> + *
>>>> + * @NL80211_MULTI_HW_ATTR_INVALID: invalid
>>>> + * @NL80211_MULTI_HW_ATTR_IDX: (u8) multi-HW index to refer the underlying HW
>>>> + *	for which the supported channel list is advertised. Internally refer
>>>> + *	the index of the wiphy's @hw_chans array.
>>> Is there a good reason to expose this? Seems pretty internal to me, and
>>> not sure what userspace would do with it?
>>
>> Hostapd use this hw index for the channel switch cmd.
> 
> What, where? I don't see that in this patchset? And why??
> 
> In any case, unless I just missed it and you're going to tell me to look
> at patch N, we don't need it here, and then I'd prefer to keep it an
> internal detail until it's needed.
> 
>> The hw index used as a sanity check to identify whether the user
>> requested channel fall under the different hw or not.
> 
> You mean within hostapd itself? That doesn't make sense, it can derive
> that information differently.
> 
>> In split-phy hardware, 5GHz band supported by two physical hardware's.
>> First supports 5GHz Low band and second supports 5GHz High band.
> 
> In your hardware design anyway, but yeah, I get it.
> 
>> In this case, user space cannot use band vise check here to identify
>> given channel or freq supported in the given hardware.
> 
> No, but it also doesn't need an index assigned by the kernel for that.
> 

The only purpose of hw index is to link hw_chans to per-hardware 
interface combination capability so that each hardware can be
identified during interface combination checks capability vs
current state. Thinking if we can embed the channel list also
into per-hardware interface combination signaling by giving the
pointer?

Vasanth

