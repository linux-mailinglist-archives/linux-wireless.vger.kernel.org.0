Return-Path: <linux-wireless+bounces-9698-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A05A91C380
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 18:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064281F20FF0
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 16:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF991C68AE;
	Fri, 28 Jun 2024 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gHT76VCh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638121C8FDD
	for <linux-wireless@vger.kernel.org>; Fri, 28 Jun 2024 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719591147; cv=none; b=ptu9Uohgyd0PFw0P46K85/LeJ00KCNNShY28MjnCGAC6K/lU86iIKaYMrS1BMkUfuu/sf2WpU5QZTQLn+H+Oq79dzTFeCn6UktImqUph3wkgpzGOJTxZEVEJknRXYqAwc0cucslOMLEeYVJlnzh3lORI9kkuHy1uVFVE1ux1wA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719591147; c=relaxed/simple;
	bh=SLjAcpuSPUgv/oDd+q4JB2Y/hyIVjr9QSUESkygbxKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e+MUajlCCgEmVdiGfeF8vLr+uDeHVh6rr3G6jmUmTNtiVsjt64mWHWyuHtXeu8S8pR1ADMkHyrb2fBJtA9JHcjhBz/T59VByGrEc0iiP96G7p4KdRFJdjU9yo4eTO4y0DrT8GZvE+8vL4T06sCQe7mkmkIxDlSMPIC3cOkdZYHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gHT76VCh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45SETt8G029750;
	Fri, 28 Jun 2024 16:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ly7Cr6tP7k2r2QIa8eeBSFPZ2LW4ER1aNdRGkdQ0Bvk=; b=gHT76VChFKVMsoWh
	K6g1L/9q9K1CX2a9i2sVoT/dRVBRGiuhfe7vwWamudo2S3rthoGanLUGdu8D9hmg
	fsY1OqBeoZ/yLkOPLHMlEvJH4Fp/LRNxM7vBZ/J7I51itY+DODcssqGvDUr9nm3d
	3hlozo1DYCgFRBVO9KZCm+qmkrqImbTg5zsyyKqKjyaqXludv6zWzPqigV12z/HI
	gy28eyzvQ/dMFYurc51ApkniDBY+jDGkexmgveQCGBeS6uAL/7j1fyKGlNnEsZHH
	PoMwOuVSxVfXgokjJ8njY9PnVErClBfBYwEkQwvLahQBqiZv1raVsOaDF6HjWeXQ
	OkExPw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400c46g92b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 16:12:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45SGCKBB006907
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 16:12:20 GMT
Received: from [10.216.49.26] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 28 Jun
 2024 09:12:19 -0700
Message-ID: <a3c8d621-95fd-413c-b88f-644a88384531@quicinc.com>
Date: Fri, 28 Jun 2024 21:42:14 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] wifi: mac80211: handle ieee80211_radar_detected()
 for MLO
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240626045216.3754013-1-quic_adisi@quicinc.com>
 <20240626045216.3754013-9-quic_adisi@quicinc.com>
 <9cf07d0861d6c8ee8a2004361a37a3ebb9860ea9.camel@sipsolutions.net>
 <8117e952-e189-41d6-9ed2-ed10d96f3b51@quicinc.com>
 <a9d518e9c53ed8e36bbb020b3eb3dfc4c8de772e.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <a9d518e9c53ed8e36bbb020b3eb3dfc4c8de772e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -lXnaxwT6AHqn-Owr30NOrh9rse2OSBu
X-Proofpoint-GUID: -lXnaxwT6AHqn-Owr30NOrh9rse2OSBu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_11,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406280120

On 6/28/24 14:29, Johannes Berg wrote:
> On Thu, 2024-06-27 at 09:38 +0530, Aditya Kumar Singh wrote:
>>> Couldn't we just have a flag in the channel context or so - there must
>>> be one, after all? And perhaps pass the chanctx from the driver instead
>>> of the channel?
>>
>> Not really. So this linked list thing came into picture for drivers
>> supporting split-band 5 GHz wiphy and both of them are grouped together
>> for MLO. Now, each one of them will use different chanctx as such and
>> there is a possibility of radar being detected simultaneously.
> 
> Right so ... I don't see how that answers my question in the negative?
> You necessarily have a channel context for each channel you're listening
> (even for radar) on [unless you have the extra radar chain API thing],
> so if radar is detected, can't you just set a flag in that chanctx and
> kick off the processing?
> 

Ah! okay. Now I see your point. Sorry partially misunderstood earlier. 
Yeah this can be done.

>> Could do but, logic in worker will be little bit complex?
>>
>> for each ctx in local:
>> 	if ctx radar_detected flag is set:
>> 		append to local ctx list/array
>> 		num_ctx++
>>
>> if num_ctx > 1 :
>> 	if wiphy supports mlo:
>> 		for each local ctx list/array:
>> 			call cfg80211_radar_event with the ctx chandef
>> 	else:
>> 		warn that mulit channel is not supported
>> else:
>> 	call cfg80211_radar_event with the first element in local ctx
>> list/array chandef
>>
>> -----
>>
>> This is because, in split-band devices, ieee80211_radar_detected can be
>> called simultaneously with different channel contexts and then there is
>> a possibility that before worker gets a chance to execute, both of the
>> calls have marked their chanctx radar detected flags.
> 
> Yeah, but no need to make that complex - simply doing
> 
> for each ctx in local:
> 	if ctx radar_detected flag is set:
> 		call cfg80211_radar_event() with ctx chandef
> 		clear ctx radar_detected flag
> 
> no?
> 

Yes got it. Thanks for clearing it out.

> You don't have to restrict the worker to processing a single one, in
> fact you must not since scheduling it again while scheduled (and not yet
> running) won't run it again. And if it races then worst case you have a
> worker run that does nothing?
> 

Yes, true that. Sure so let me incorporate these changes and send next 
version soon. Thanks for the suggestions.

- Aditya


