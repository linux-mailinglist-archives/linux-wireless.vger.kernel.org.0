Return-Path: <linux-wireless+bounces-10058-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C27A9296AD
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jul 2024 07:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654C71C20C0F
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jul 2024 05:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABCE63C7;
	Sun,  7 Jul 2024 05:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LDF4I7Jv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C258B33EA
	for <linux-wireless@vger.kernel.org>; Sun,  7 Jul 2024 05:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720329159; cv=none; b=I8AB9EKoU5uzEQU9dQTclARw/QoqCKbp66Vqsg0O3sItVvV/h18DfADT2NQgW4LY5iVUjN27+Vx1fQPfPMRfmiej/0IRTmRiI5iVknQbBpQmIBsvCLTokjOkb2Nk4se0c4Q+iyUyK23qpjfNl6kazVsve8XyR4FTQtv31Y3bxzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720329159; c=relaxed/simple;
	bh=5TmsSOoFHzqGAgs2MpaXPzkNsPVFFxBZF2A55kEKaQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SOkPxVpe+Y9AVpupIn56fEw+gK2GF9tkSyzN++V4Ttz2L34/Eec5/H5RDhmCv/XpWc7iopCg+Sps/CsW4WnRjOMUmvRj3g+ejwi8ErNwzQieUaA6SzssxjwhQkARyTFLj+Zn4BeGrF1Fhs2lTj0p+dPTRJSiZlZ1Twxpt+OXvFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LDF4I7Jv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4675CRjs023855;
	Sun, 7 Jul 2024 05:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hcnRQWF/L5PppnZSQuOTzAJw6ImTWQodDR1139pO1D4=; b=LDF4I7JvYbVZPnEF
	sdUUlmV4DCGeKFn+bn9ZZ7pIPpkBullSjUVwKz+D6XJwqgRQIFX7oF7mu4M8WH42
	yDOx1RWWcH0YMN1ziuU55eALGL/RrqnOxu0e9RZxz+uzDasG6tzHiBZzXPMQH1NC
	6kpprWuWLbx2s3ZzzGsvqTYchXHNN7s0e/R7LW+W059exQNnlK0G2J7BQIXItInP
	yECVKRciHWcEZuDGI1qzf2R7fB12yVQ7Sb20IJn03k+Im6x0AcGkG4EFnTXdqY5q
	NbJVT/Gnp3PhTcQKzz4f74oJgcBc+bNM4EEKrSrJxJ2R95yWZnpiTGipmYyyfDps
	UNgl+g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406y77h88a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 05:12:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4675CQIj011987
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 7 Jul 2024 05:12:26 GMT
Received: from [10.216.57.79] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 6 Jul 2024
 22:12:25 -0700
Message-ID: <8079de14-ef9d-454f-862f-704dac821ee3@quicinc.com>
Date: Sun, 7 Jul 2024 10:42:21 +0530
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
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <9cf07d0861d6c8ee8a2004361a37a3ebb9860ea9.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ahPmD16r0VHrHOdhsOo6QBgmgvtxcbJN
X-Proofpoint-ORIG-GUID: ahPmD16r0VHrHOdhsOo6QBgmgvtxcbJN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_02,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=590 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407070039

On 6/26/24 18:05, Johannes Berg wrote:
> On Wed, 2024-06-26 at 10:22 +0530, Aditya Kumar Singh wrote:
>>
>> Hence, in order to support DFS with MLO, do the following changes -
>>    * Add channel pointer as an argument to the function
>>      ieee80211_radar_detected(). During MLO, drivers would have to pass on
>>      which channel radar is detected.
> 
> Makes sense, maybe?
> 
>>    * In order to pass on this channel information to the radar detected
>>      worker later on, introduce a linked list 'radar_info' in the structure
>>      local.
>>    * When driver calls radar detected, a node is created and added to this
>>      list and work is scheduled. The work handler takes care to process each
>>      node and take further action.
> 
> Not sure I like that so much, it adds book-keeping and all kinds of
> extra things.
> 
> Couldn't we just have a flag in the channel context or so - there must
> be one, after all? And perhaps pass the chanctx from the driver instead
> of the channel?
> 
> Actually, we're already having to do a channel/chanctx lookup in
> ieee80211_dfs_radar_detected_work() so it seems pretty weird to add more
> complex logic to it...
> 
> Please consider just passing the chanctx, and then we can set a flag
> there, and not have any of this.
> 

So I was trying to implement above suggestion, and I see this -

* Drivers don't have chanctx visible in it. Driver visible part is 
ieee80211_chanctx_conf (stored in chanctx)

* In order to pass this from driver, I need to access each driver's per 
interface struct which should have ieee80211_vif. This will have 
bss_conf pointer and in turn which will have chanctx_conf pointer.
(per_vif_struct)->vif->bss_conf->chanctx_conf.

* I see for many drivers the place where ieee80211_radar_detected() is 
called, the interface level struct is not present. So making 
chanctx_conf mandatory argument to pass requires a lot of code changes 
across the drivers.

* So in order to keep things simple, we'd have to allow drivers to pass 
NULL and let the current logic kick in. Iterate over all ctxs and all those.

* If driver passes chanctx_conf, then while going through the ctx, if 
the flag is set, further process can immediately kick in and other 
num_ctx checks will be ignored.

* Now if driver has clubbed multiple hardwares under single wiphy due to 
which num_ctx will be greater than 1, obviously such drivers are bound 
to pass a valid chanctx_conf or else the event will be dropped.

Sounds fine?


