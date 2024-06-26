Return-Path: <linux-wireless+bounces-9620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F28F918E9A
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 20:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 194E21F27B37
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 18:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE5818E767;
	Wed, 26 Jun 2024 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V4vE+0TQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0CD6E611;
	Wed, 26 Jun 2024 18:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426739; cv=none; b=NRCuPlTdpHUyqwkLMfeOCyupSZ9UWHId2GYmugC+Bp8LLHyRBnz5jFmEY1EcAy7NZGWbR9iD7wjoeJEbOXpMVAAtDo5GMODvepwbUQvAbn7q1u5EH7s4GZAZP5CLAXi6ErVoVwvdYk2hY4oCglVIKMgVaJgioedDyXtrp4Mm7j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426739; c=relaxed/simple;
	bh=KjBdZ3SXuyrmxQ7Ayc3jST629W+fr3nL3KtaDE9xuNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E+awAUAi6GIebV7kAan2XbOi3NweQ8GBNTxDPWbeZIea9KKOZ184Wb/IqoeM+U8qmt8W2gzHepDFJjvGGZEM+1O990wXsO2jXwtsU6yfm/pSEhl8YhC6zeJBhW2jC0tmvnSj0qKMGZVL9pzBlhEE01iI8cLvfz90XasOizSlDLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V4vE+0TQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfOmK015314;
	Wed, 26 Jun 2024 18:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ivjT5UVTQXSk7sRR7CTZnltIbA5NeS1HHPv860bEwLI=; b=V4vE+0TQk3H4rMC6
	F3QXO/SUQ+bpAL7OXW0CLar+4d7qFvSmVuIqVQjipWX11AVFRz5TLow2vjB4tg54
	H1sW6tUK0C249IfMEQj4zc+5HpNNa4dkHoGXc9OShvjAnkkcPm6luGFU35pUfMsG
	7FmZR2o/1CLzWGlv93LvdvSanv8R/GIU4IdMzIC2rsf2sh5gaVi5igIOOkHvQ9bv
	7iLE7fBdGRibUs1eLAT3pZqQe+UGEUPKfx1v9AzLY5yHJatUh6ZKa1DqD2wulBiA
	m85s5KuedJZTbb0A/qKuY4ajW2qBEr2yW+7RShjFRvc8qMI1GFCVHKYwCnciM6hn
	yItdpw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 400gcm9b7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 18:31:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QIVx3g005487
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 18:31:59 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 26 Jun
 2024 11:31:58 -0700
Message-ID: <f593427a-f9fb-4cf4-bc22-60fb6396890c@quicinc.com>
Date: Wed, 26 Jun 2024 11:31:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ieee80211.h virtual_map splat
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>
CC: Koen Vandeputte <koen.vandeputte@citymesh.com>,
        <ath10k@lists.infradead.org>,
        linux-wireless
	<linux-wireless@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
        Kees
 Cook <keescook@chromium.org>
References: <CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com>
 <c470e4ff-3f70-40f6-844a-f9614286509f@quicinc.com>
 <87o77pik7w.fsf@kernel.org> <20240625080248.32c3e03d@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240625080248.32c3e03d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NUImmeksSqzJHQIK55x5q31F9N1bvCYA
X-Proofpoint-ORIG-GUID: NUImmeksSqzJHQIK55x5q31F9N1bvCYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_11,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 mlxlogscore=627 clxscore=1015 mlxscore=0 phishscore=0 impostorscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260136

On 6/25/2024 8:02 AM, Jakub Kicinski wrote:
> On Tue, 25 Jun 2024 09:56:35 +0300 Kalle Valo wrote:
>>> Adding netdev to the initial message in the thread.
>>> https://lore.kernel.org/all/CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com/
>>>
>>> There was some discussion in the thread, with the observation that the splat 
>>> is fixed by:
>>> 2ae5c9248e06 ("wifi: mac80211: Use flexible array in struct ieee80211_tim_ie")
>>>
>>> Followed by discussion if this should be backported.
>>>
>>> Kees said that "netdev [...] maintainers have asked that contributors not 
>>> include "Cc: stable" tags, as they want to evaluate for themselves whether 
>>> patches should go to stable or not"  
>>
>> BTW this rule doesn't apply to wireless subsystem. For wireless patches
>> it's ok to "Cc: stable" in patches or anyone can send a request to
>> stable maintainers to pick a patch.
> 
> It's an old rule. Quoting documentation:
> 
>   Stable tree
>   ~~~~~~~~~~~
>   
>   While it used to be the case that netdev submissions were not supposed
>   to carry explicit ``CC: stable@vger.kernel.org`` tags that is no longer
>   the case today. Please follow the standard stable rules in
>   :ref:`Documentation/process/stable-kernel-rules.rst <stable_kernel_rules>`,
>   and make sure you include appropriate Fixes tags!
>   
> See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#stable-tree

Thanks for the pointer.

I've now followed option 2 to notify the stable team to backport this patch

