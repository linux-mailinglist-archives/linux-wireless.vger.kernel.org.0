Return-Path: <linux-wireless+bounces-2823-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCADE84271A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 15:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2BA21C262D4
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 14:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52987CF1A;
	Tue, 30 Jan 2024 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ilGYFTWd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA26D6BB20
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706625901; cv=none; b=KvbhesAU6gAivPl3q2lbNQOCk0WjSCNHl80CvT8ZBeIH0lh3Gw4TZ+qx4RTcbp+s2RYsy8VMgpjjtM2RrAG+G83M2IlcOyTIrD3YuRcUexsloX1kgFzPK8epZOlhQMqtlUTuvlHEXQTLio/ug1tEB0AwPzT4ex8ay8gDTT/Gats=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706625901; c=relaxed/simple;
	bh=aOKbTAiEVLZYwjda2V6PdNtP3dqeoXBLLxAbQ4ovJKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MVMY34xm0x22AhCaAMmuc5g3GenLVeMakmLwJLaywX9SdmFL57SOGSbIiI3Chcpwo4w8LOwuRcCEoxcEl5kC8HQRSlUGuQ9K5V/vTypxHxpJ/NX3LM0hTunMGnyaPab6VmFs4DbtPaNLebVcFChZeingeY0oTjIHveICN293jow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ilGYFTWd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UChheJ021458;
	Tue, 30 Jan 2024 14:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=m4dzeXwvqDH/4GlLmU63t3fp4FmaFzMtstw9GUe8/vs=; b=il
	GYFTWdKAl8M9ALT1prADvESNVobb6IRpk/bR/JLCndfeNgzzC56SaM+o/s0lVUMI
	dS2ktmrMP6hEdWQ+rt6gKpCFd70AK4AK236zFXT9QlwUPcwYeAskFfrbrtRE5jCC
	5snFnIPEuBXrW9enV6evC0goiNKmAXa3G0dfWWSWezIo1HFS6oh4cdXHUPRALaJ7
	1Rd6+YiQi/lthBe4tCplbUlx/+chS1E+ob4wY8dgZ3KHKxr7a/DmP6LJLwexObdm
	UymtdbBFZEG/5LgPZJqiiqyAyPlIg7v8YQiFzUoHf71c65NA8sOCBfYkMzHzVLFA
	aCp6NeLRqs4mbKb5isqQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxwyngs9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 14:44:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40UEir3w002863
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 14:44:53 GMT
Received: from [10.216.2.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 06:44:52 -0800
Message-ID: <f4501322-c9e4-449b-9c81-f64a6d2172fc@quicinc.com>
Date: Tue, 30 Jan 2024 20:14:47 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: allow CSA to same channel
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes.berg@intel.com>
References: <20240129203544.ef7258d5790d.Idafe22e41621757458d4960659b9621853f7104d@changeid>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <20240129203544.ef7258d5790d.Idafe22e41621757458d4960659b9621853f7104d@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: wQEwNJkTcgaIQd6e4B7Yhf_4WZI0gvVQ
X-Proofpoint-GUID: wQEwNJkTcgaIQd6e4B7Yhf_4WZI0gvVQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_07,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300108

On 1/30/24 01:05, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This could be used e.g. for temporarily sending quiet
> (mode=1 in CSA/ECSA), or updating bandwidth. This is

I know the intent here (from the other thread), but using the phrase _or 
updating bandwidth_ is probably not correct since currently without this 
change also, just changing the bandwidth is possible, isn't it?

In the chandef identical check we have -

return (chandef1->chan == chandef2->chan &&
	chandef1->width == chandef2->width && ....
	``````````````````````````````````
So the width would not match hence false would be returned.

Also, bringing a part of the discussion we had in the other thread -

 >>> I'm thinking about removing that identical() check entirely - you
 >>> might want to switch to the same channel with quiet=1. At least for
 >>> testing that'd be really useful, and I don't think it really serves
 >>> any purpose to forbid it.
 >
 >> Yeah, we can do. But is there any actual use case? Also, what if some
 >> notorious user space application simply sends NL command without even
 >> quiet=1? There should be some check I guess?
 >
 > I'm not sure we care much about a broken userspace application running
 > with root privileges breaking something here? :-)
 >
 > And at least for testing it's very useful to be able to do that. Agree
 > that identical channel and quiet==0 doesn't make _sense_, but even
 > then I'm not sure there's a lot of value in not permitting it. With
 > quiet==1 at least it does make some sense still though, and we're
 > currently not allowing it, hence my patch (to be able to test
 > scenarios like that we saw elsewhere.)

Agreed to your point. So in that case, should we skip the identical 
check only when quiet=1?

> also useful for testing, since it's something that an
> AP may do and the client needs to be prepared. Simply
> allow it.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   net/mac80211/cfg.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 8f647e28e354..c92acbf7b002 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -3874,10 +3874,6 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
>   	if (sdata->wdev.cac_started)
>   		return -EBUSY;
>   
> -	if (cfg80211_chandef_identical(&chanreq.oper,
> -				       &sdata->vif.bss_conf.chanreq.oper))
> -		return -EINVAL;
> -
>   	if (chanreq.oper.punctured && !sdata->vif.bss_conf.eht_support)
>   		return -EINVAL;
>   

