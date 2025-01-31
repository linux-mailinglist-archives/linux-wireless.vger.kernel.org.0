Return-Path: <linux-wireless+bounces-18237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8AAA23919
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 04:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF913A1E33
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 03:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859D4446DD;
	Fri, 31 Jan 2025 03:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vo8SnP43"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA71F42065
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 03:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738295733; cv=none; b=a/m9FAEz6lbiYEX/KBT3Xl2RMfm/XilErgaSx2IVy6LEnZvLK1yBnhVz6d3nTus2aDdJXn7cKofSSn4tPyq/eBovLbquEMVonBnzYcAAFoQC9RI6sEoCXNqg79wzIVxHnEqMEfihJzvITTMRa0GVneOWo3F8xIkLNYkKccmaOGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738295733; c=relaxed/simple;
	bh=Od3lL9GCId9ucqGztg9plGtNt4FzY3ZVHNIttMnU2+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cRQ3lizxgH8c6ATLiK8X2v73kSxCZp7WK508zXeudWboyDaVmZred/0lCGudDnf6mjt4OkTFY2UK8kIK3vKzTpnw0pv3wAwemUDnQGYg7woux35DLF5pjAJTc79NDplZ1bmrjwYxYsEcgPLl78EGhDI6eKs3H38N0WVVFKGsKVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vo8SnP43; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJ1cW7013607
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 03:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sUNx4j+0EG7yQiA+IcF9xR8NV8tps8BaZtOLkIpIB+E=; b=Vo8SnP43rvGJN25w
	kPgi0uYp7KWU0FMjkAvNHM/fLd+lCHiGSqCW0qK8iANA0hd7sEjzyeyISbCOieNA
	usdvtcQBaR/zlr493AgcCS3AkHILY8UatFjWcNHxnXoBDYYMDZlpk14Nu+IX9wzL
	Z18X7pUngw2a2mO6q+TAijycuxzYOQUPFsOEVwPLv8q0BH2Xfv+hzertpyNPMUs+
	NcVX8oautliza+OEowoHdphYshagzDiR8L/w6T0ZoHTMDgFTZnzFzQoP3DGi1W6f
	TQTA+4bRYcnJuFvwz2fLBX6YsNPeFNGfuzlVHGCL9570tQ6MOuUXlRV6lF3ABJ4G
	rVeZfg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gf7m0u37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 03:55:24 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ef775ec883so3044117a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 19:55:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738295724; x=1738900524;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sUNx4j+0EG7yQiA+IcF9xR8NV8tps8BaZtOLkIpIB+E=;
        b=uf8FrJn8i8zZHVnNfFUaZoYi/YT0Rok4/0BrIdVZmJ8DRJFVVURwlnPbXYchnaw2ou
         powMi689KzXCzPqIEswzq5yFC/3/hYAKChlB11zf2NPGNb5Cqmi8ms9X+3fXDbEvvGBW
         qK2Up/L6ya1LEkdxz2YEraO43oFGX87aLx8Hi1xadnbcSI5aEP2JjkpzCaaATZbGThVJ
         ftDAkvcc5TX+b1hM+Fl1xhS8YcWpAPcYSYk8hGLkhkG6Yu60zqN1liDpA+UZOXvTI7R/
         AYzkkzJ38LSmE0kz5UP9i0cSf+1JBK+NoW0Ffa7JSjpGkr+VVkWDnVMAlYgh6spVinIO
         gVQg==
X-Forwarded-Encrypted: i=1; AJvYcCW4nlMA4TgHfwNogelhfo43lqSeClzGJLw24wY8rLv46JuuDnMgoNADPzame0baEKNhYHSezF0s9hFnl61ZzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoxB7fOLqURYuAI9ZoI61l8QQ0QuTJfgDAoLCzN0ZvGNqZ7ExU
	Ofd64aEwbik72SdMwqPHSpWrUeUmwiW59EMra7BhNiiy1QU2P5xcTbF4/LRSX7cdmz5+LwymegY
	DfcHxzisHnywLzEQr7wsciWPlR9iSN3IMl6wKYKqCNw4eiXMurODlcsa9jC5Yrx6/Pw==
X-Gm-Gg: ASbGncvcGr+jzXKT8sAcErfs4nMXRVjFhGnfcjbSutcav557EpE7xSxyXP1jxl6Ma6I
	Yd5oASm3WqzUu1bI7Dvxs/K6gJIOPdRhJECx2L7++7nFS+lK/Wzr5RPG6gRZpi+ho0xbD3I2TKC
	O8DMrmtxnwxbGfIxwjAVVxV83mxgFVtJYn4mrumt4MFSmNA/34+RyRLXInlJgADxE1m2wDQ0zAo
	MBVbKBV1HSOBx2X7gof/poYnk2H5dKj5VNBiom5Em28s0wRy9SAVEJN2CXbUbGRpRW5Wp4vIYxW
	6Wd4XHtO3uiqP4CPgxPCwBolY37qpboGXeqUzU8=
X-Received: by 2002:a17:90b:548c:b0:2ee:a6f0:f54 with SMTP id 98e67ed59e1d1-2f83abda260mr14524118a91.13.1738295723935;
        Thu, 30 Jan 2025 19:55:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4RzkwFNDfu+ymr6WG1Kw2o1UU3U6Wsau4bq8pGsiE5KhJ7gVeX1dgGybRWsRMzBq7gWZy5g==
X-Received: by 2002:a17:90b:548c:b0:2ee:a6f0:f54 with SMTP id 98e67ed59e1d1-2f83abda260mr14524095a91.13.1738295723525;
        Thu, 30 Jan 2025 19:55:23 -0800 (PST)
Received: from [10.152.202.18] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f84897a290sm2775396a91.1.2025.01.30.19.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 19:55:23 -0800 (PST)
Message-ID: <bc3873ab-d2ca-4121-830a-bee76426dac8@oss.qualcomm.com>
Date: Fri, 31 Jan 2025 09:25:19 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: remove return for empty tx bitrate in
 mac_op_sta_statistics
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Remi Pommarel <repk@triplefau.lt>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>
References: <38c2a7c4f7eaf57b9306bb95a9e6c42b7d987e05.1738169458.git.repk@triplefau.lt>
 <9c12e9b9-35a4-47f1-bd17-6b4641de92a4@oss.qualcomm.com>
 <Z5s9CO_mmazq2Kg1@pilgrim>
 <94db4020-b1c7-4aee-b22c-6fe6d357e593@oss.qualcomm.com>
 <a1a65ff7-bb5c-4c90-98b6-7155b58e89c0@oss.qualcomm.com>
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <a1a65ff7-bb5c-4c90-98b6-7155b58e89c0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: n2GMGZLeQGwLHxb78Gt3kwF1LEbW38fm
X-Proofpoint-GUID: n2GMGZLeQGwLHxb78Gt3kwF1LEbW38fm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_01,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 suspectscore=0 adultscore=0 mlxlogscore=779 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310023

On 1/31/25 00:27, Jeff Johnson wrote:
> On 1/30/2025 1:18 AM, Aditya Kumar Singh wrote:
>> On 1/30/25 14:19, Remi Pommarel wrote:
>>> On Thu, Jan 30, 2025 at 12:21:54PM +0530, Aditya Kumar Singh wrote:
>>>> On 1/29/25 22:25, Remi Pommarel wrote:
>>>>> Currently in ath12k_mac_op_sta_statistics() there is the following
>>>>> logic:
>>>>>
>>>>>        if (!arsta->txrate.legacy && !arsta->txrate.nss)
>>>>>            return;
>>>>>
>>>>> Because ath12k_sta_statistics is used to report many info to iw wlan0 link,
>>>>> if it return for empty legacy and nss of arsta->txrate, then the other
>>>>> stats after it will not be set.
>>>>>
>>>>> To address this issue remove the return and instead invert the logic to set
>>>>> the txrate logic if (arsta->txrate.legacy || arsta->txrate.nss).
>>>>>
>>>>> The same was done also in both ath10k with commit 1cd6ba8ae33e ("ath10k:
>>>>> remove return for NL80211_STA_INFO_TX_BITRATE") and ath11k as well with
>>>>> commit 1d795645e1ee ("ath11k: remove return for empty tx bitrate in
>>>>> mac_op_sta_statistics").
>>>>>
>>>>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>>>>
>>>> MISSING_BLANK_LINE
>>>> 'Tested-on:' tag missing blank line after it.
>>>>
>>>> You missed v1 comment? :)
>>>
>>> Yes sorry I think your mail never reached me, did you CC me ? Do you
>>> need a respin ?
>>>
>>
>> No problem. No need of respin just because of this. I think Jeff can fix
>> in pending?
>>
>> It's strange that the v1 reply appears to be delivered from my mail box
>> and it is sent to the list. I see even Jeff replying to that. But none
>> of those are captured in patchwork. Not sure.
> 
> it was only sent to the ath12k list
> perhaps you need to include linux-wireless@vger.kernel.org
> 
>>
>> Anyways, v1 comment was regarding this blank line and one suggestion
>> that in future submissions, please use base commit tag.
>>
> 
> I've fixed the blank line in pending:
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=c7b9df20d6a48a279f4b537920049094701da14b

Looks good, thanks.

-- 
Aditya

