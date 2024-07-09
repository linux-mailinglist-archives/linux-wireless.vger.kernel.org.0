Return-Path: <linux-wireless+bounces-10111-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2768092B2AD
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 10:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9BF92813B3
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 08:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B65014A4E2;
	Tue,  9 Jul 2024 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pbAcDh1D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0336152E0E
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jul 2024 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720515309; cv=none; b=sh4okxykFDJ5ZdpE3zPNylf8mbKveDVt46I2t6KsB5F+cy5Wi8W0e05TeNj+wUPbLfXDk6P+cAndtppDk3JuugokTosBkPd+Uj3FJDhrSL34MFdzomERLRE7rso2djuKbL2TJcRCZwiMQUMV2BTTOUgEiZI2ik95Gc+/rre6vYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720515309; c=relaxed/simple;
	bh=CBz6EgDcPZDoNdZOfwdD6d5j5cKF4UZvIgS4LkQ8eNA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=IsVi5uyvMBOPJMtfDKTC0VZUDxUdQm6Wv7ORr4QHnZ2h6mnaPq8u6Ie4bIe1cclKU5jWVEKv31Ii+TbXFPjKH3V30zEMCOQZDdffQ4AuxGFnVvmM7PQX6uLbanlwL2woQmi7i2dodnVTC1nw2yS2qZqBdyh0i5AXkDEIuaCDoF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pbAcDh1D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46936YFf003896;
	Tue, 9 Jul 2024 08:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TY8kjBizpzP/x8/CmOeMfVPzZ7k+RNELugj86WYSnZ4=; b=pbAcDh1DKIxUSbS7
	RZu8ntiE3zcv6iVdeoPpEd4y/YtMSjHZNgq1M0rt2Gi/N0P6wa3KaxFRWPKkMuNo
	g73/OEiJcGPwTJIzdAE9jcl2AWcP/oyj8e7YbLWNG7PMxtIAex+FavY8PQNYx0z4
	Gyyg2YyZvbLAdrjyaiBLb38v+9z/Trrwe4BmTp87Htx/fr26UBpb6bidMwozN2Ve
	MwNqYOHKuc4SKNCNffVj76IgHGOGa43h3eVqbSdXsRN0+NXmAQ+tSpiF45eMouug
	1azZWWNXytx6CoC54LdzWDeM4xudq3kpfFXRerOBlmMZsPD7sOplZsHF08QSnqwG
	XgQ8ow==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 408w0r8q48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 08:55:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4698t12e011130
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 08:55:01 GMT
Received: from [10.216.11.89] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 01:54:59 -0700
Message-ID: <fb93e262-d250-4d19-84dc-28cf893d4a21@quicinc.com>
Date: Tue, 9 Jul 2024 14:24:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] wifi: mac80211: handle ieee80211_radar_detected()
 for MLO
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240626045216.3754013-1-quic_adisi@quicinc.com>
 <20240626045216.3754013-9-quic_adisi@quicinc.com>
 <9cf07d0861d6c8ee8a2004361a37a3ebb9860ea9.camel@sipsolutions.net>
 <8079de14-ef9d-454f-862f-704dac821ee3@quicinc.com>
 <3ad1b0c648ce1757a06fceafc371d7b8d14fff33.camel@sipsolutions.net>
 <03731b8e-16f7-4ca0-a720-c41c296efa23@quicinc.com>
Content-Language: en-US
In-Reply-To: <03731b8e-16f7-4ca0-a720-c41c296efa23@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FmHI7N4_g96l_jb0Kf5-JgIuH00rwKey
X-Proofpoint-GUID: FmHI7N4_g96l_jb0Kf5-JgIuH00rwKey
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=901
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090059

On 7/8/24 15:20, Aditya Kumar Singh wrote:
> On 7/8/24 15:02, Johannes Berg wrote:
>> On Sun, 2024-07-07 at 10:42 +0530, Aditya Kumar Singh wrote:
>>>
>>> So I was trying to implement above suggestion, and I see this -
>>>
>>> * Drivers don't have chanctx visible in it. Driver visible part is
>>> ieee80211_chanctx_conf (stored in chanctx)
>>
>> Sure, but you can go back and forth from these in mac80211, so that's
>> not really an issue.
>>
>>> * In order to pass this from driver, I need to access each driver's per
>>> interface struct which should have ieee80211_vif. This will have
>>> bss_conf pointer and in turn which will have chanctx_conf pointer.
>>> (per_vif_struct)->vif->bss_conf->chanctx_conf.
>>
>> Depends on the driver, but maybe, yes.
>>
>>> * I see for many drivers the place where ieee80211_radar_detected() is
>>> called, the interface level struct is not present. So making
>>> chanctx_conf mandatory argument to pass requires a lot of code changes
>>> across the drivers.
>>>
>>> * So in order to keep things simple, we'd have to allow drivers to pass
>>> NULL and let the current logic kick in. Iterate over all ctxs and all 
>>> those.
>>
>> Seems reasonable. I'd even go so far as saying that you get a WARN_ON if
>> there are multiple at that point if NULL was passed, and we just set the
>> flag on *all* of them since we can't know which was intended?
>>
>> For current drivers that's all fine, and for MLO/multi-radio drivers
>> they'd just need to ensure they pass the struct.
>>
>> Perhaps even WARN immediately it if it's a multi-radio driver? Though
>> you can't do that yet since I haven't landed that series yet, but I will
>> soon.
>>
> 
> Yup got it. Will do as discussed and send next version soon.
> 

So, I was trying as discussed above but I see concurrency issue now.

In order to mark or let's say to iterate over *all* ctxs (in case NULL 
is passed by driver), that part of code ideally should be under wiphy 
lock right? But ieee80211_radar_detected() is called in an interrupt 
context. Hence, can not take wiphy lock there :(

Now, obviously there is a work scheduled from ieee80211_radar_detected() 
but to make the information (chanctx) available in the worker, we need 
some infra to pass that info, correct? And given 
ieee80211_radar_detected() can be called multiple times back to back, we 
can not just have one member in some struct or else that will get over 
-written with the latest called chanctx. So in the end, looks like 
linked list only is useful?

On every ieee80211_radar_detected() call, add a node to a head pointer 
and schedule the work if not already. In worker, go through all the 
nodes and get the required chanctx and process further. For drivers 
which will still pass NULL (non-MLO), for them go with the existing logic.


>>> * If driver passes chanctx_conf, then while going through the ctx, if
>>> the flag is set, further process can immediately kick in and other
>>> num_ctx checks will be ignored.
>>>
>>> * Now if driver has clubbed multiple hardwares under single wiphy due to
>>> which num_ctx will be greater than 1, obviously such drivers are bound
>>> to pass a valid chanctx_conf or else the event will be dropped.
>>>
>>> Sounds fine?
>>>
>>
>> Sure!
> 
> :) Thanks for your inputs.
> 
>>
>> johannes
> 


