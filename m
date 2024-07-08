Return-Path: <linux-wireless+bounces-10069-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEB7929F86
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 11:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7369C1F20F1B
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 09:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A41553362;
	Mon,  8 Jul 2024 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C8p8rCTa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C8059147
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jul 2024 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720432222; cv=none; b=YY9ykD3H5uK8g79dG7nGxOV8ZKBqVJ+6XTMS+65RbwWQhjLd3RU3FxNqBT6P43HyxfhU25g1FX8gvIgtB2SHERxu6DCuN2h2Uo/2jbU0oiceR0qtXiTUV+fUTrQZCvyA6dCQaea+xtyYdMkO2xYlrq8gBHRRearbtpmVUpeX8KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720432222; c=relaxed/simple;
	bh=DoZtHANoQ4qHk8eCWKLTV5mkUzsu6bKFYvMIYbYNCbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZrdenYmvzrUs7dbc9S3AvGb87nHvDHDbMYG4RBim8w0fZkhd96UV7n2T6UV/VzxjXq5VQEehenNThmWo+TvjOSOlEXWr9LptlQhARjnSQMuFp3B27cqnEya2wfOhZGm8LWe3UjGkfYh+NrEEF+yWoWxKW38twbezmHm9dBpetes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C8p8rCTa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 467NxVK3000616;
	Mon, 8 Jul 2024 09:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jM3mSI94pugmZZsTHQMV75i+tmm3YJxbkik+WriCC0s=; b=C8p8rCTaZ9v8iiVh
	tbmpC/th3AbnIhhwrGmWBG33Iji9QTIlYpnavungzQZtbsy09+O0FhhUSmg+5ceD
	VHCMp8GH7nz4rXMoyhKFBPBAR8OjlFhVKiG0/d3Am59W+VFslgu2r4hhvQ6SaVFl
	91sZ0tbF0orGvGnV8aovFuQRQg/MJeHDq1yeYjJ0PwIJpO7Ba1RUmaSHAiJzn/Ln
	3PLWfyMFZxkMjSfNhit87hTEr2z3xAomaVTOE6JqlTy9wc4x3TJp4/JoM7rZf8JQ
	55mz/nQzIXdTJNWxE6MlA5zTjca0AcS62ZZOjq39kkec0dLnhS4D0A3mjuXSFKLi
	jzkBZg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406we8u8nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 09:50:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4689oFZO015070
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 09:50:15 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Jul 2024
 02:50:14 -0700
Message-ID: <03731b8e-16f7-4ca0-a720-c41c296efa23@quicinc.com>
Date: Mon, 8 Jul 2024 15:20:10 +0530
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
 <8079de14-ef9d-454f-862f-704dac821ee3@quicinc.com>
 <3ad1b0c648ce1757a06fceafc371d7b8d14fff33.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <3ad1b0c648ce1757a06fceafc371d7b8d14fff33.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RlEYQtgLzQiXhHnM0O5hJ3FGfEGiXk6q
X-Proofpoint-ORIG-GUID: RlEYQtgLzQiXhHnM0O5hJ3FGfEGiXk6q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_05,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=791 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080076

On 7/8/24 15:02, Johannes Berg wrote:
> On Sun, 2024-07-07 at 10:42 +0530, Aditya Kumar Singh wrote:
>>
>> So I was trying to implement above suggestion, and I see this -
>>
>> * Drivers don't have chanctx visible in it. Driver visible part is
>> ieee80211_chanctx_conf (stored in chanctx)
> 
> Sure, but you can go back and forth from these in mac80211, so that's
> not really an issue.
> 
>> * In order to pass this from driver, I need to access each driver's per
>> interface struct which should have ieee80211_vif. This will have
>> bss_conf pointer and in turn which will have chanctx_conf pointer.
>> (per_vif_struct)->vif->bss_conf->chanctx_conf.
> 
> Depends on the driver, but maybe, yes.
> 
>> * I see for many drivers the place where ieee80211_radar_detected() is
>> called, the interface level struct is not present. So making
>> chanctx_conf mandatory argument to pass requires a lot of code changes
>> across the drivers.
>>
>> * So in order to keep things simple, we'd have to allow drivers to pass
>> NULL and let the current logic kick in. Iterate over all ctxs and all those.
> 
> Seems reasonable. I'd even go so far as saying that you get a WARN_ON if
> there are multiple at that point if NULL was passed, and we just set the
> flag on *all* of them since we can't know which was intended?
> 
> For current drivers that's all fine, and for MLO/multi-radio drivers
> they'd just need to ensure they pass the struct.
> 
> Perhaps even WARN immediately it if it's a multi-radio driver? Though
> you can't do that yet since I haven't landed that series yet, but I will
> soon.
> 

Yup got it. Will do as discussed and send next version soon.

>> * If driver passes chanctx_conf, then while going through the ctx, if
>> the flag is set, further process can immediately kick in and other
>> num_ctx checks will be ignored.
>>
>> * Now if driver has clubbed multiple hardwares under single wiphy due to
>> which num_ctx will be greater than 1, obviously such drivers are bound
>> to pass a valid chanctx_conf or else the event will be dropped.
>>
>> Sounds fine?
>>
> 
> Sure!

:) Thanks for your inputs.

> 
> johannes

-- 
Aditya


