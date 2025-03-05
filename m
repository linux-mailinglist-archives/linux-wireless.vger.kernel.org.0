Return-Path: <linux-wireless+bounces-19827-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A24A50BA5
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 20:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E6C3A249A
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 19:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D978E18E362;
	Wed,  5 Mar 2025 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cl5tZrIy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040A378F3A
	for <linux-wireless@vger.kernel.org>; Wed,  5 Mar 2025 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203604; cv=none; b=pALN94eAVzafnM1gaXrTA/zfk/CMbvqsYevqW4j128P1Y1UFDCTElfHih7KGRU9AkEv01v6WjttbOgWD0I3x/jqFtDNwoc3FyywHc7vrjGsSS0TnVDhE+iiTELRnqqWmjDIXN/0CJJEHEcY+1wgUTyvnopwW36pqRrgmyLfJY8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203604; c=relaxed/simple;
	bh=bF4flpPQpnftQtBPr6IzSLM8pD79TU5Jke3ANFCg3dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B7NxWXEZNm3GQvp87ZMtYKGobFqRnkwXIz4gxxbnFId6Me/mePzn/TKfPfEGrxy6F7U8r4v1rdvwGg9AYmv+h3X5FnaMEBn/G6KHtzBvvhtdiQBkzWmDEalnvY3nSNIXNabnfEJjurvAsAd4fkK7tFpA6a+sJF2wvOUdMGc2R4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cl5tZrIy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525B1iSd028207
	for <linux-wireless@vger.kernel.org>; Wed, 5 Mar 2025 19:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YRrcOt5UjejIK1PUNjHLBfNNK9uHRnWPZoQFKosMIBQ=; b=Cl5tZrIyKyy6FovS
	737odnMMoGugHNSzMb1A0QN7Vz6WgubiJ8TAwiXSqHav6mRMShOCyAL3JMFE29f9
	4lIOSVZJGGl3YwnsOD2TLcxgH8b2VDywGlvDPc1iJIkatEzGWnilrsuYLXzpfK3p
	LWs3/pPJvCi/WpTHEXWR2NDuqkaQyg7bdp/JNjr1cm6oHU7gLRsSrmF9jmOecSbg
	tXCRmV/s4YzZ2wI0WPLcHZDWCcsPdwKznERuiCS52Y9ZrDrMjwdFlCdz3W6W31ez
	EkMm1E5WRujzwvdZltNexaHEOFww5vmApw+pzTffhHb9C+6EGpXsE+b4QpatlyCa
	akCumg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6veg1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 05 Mar 2025 19:40:01 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22368fafed1so142829335ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 05 Mar 2025 11:40:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741203600; x=1741808400;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRrcOt5UjejIK1PUNjHLBfNNK9uHRnWPZoQFKosMIBQ=;
        b=elENwZTCqoq/NkiVmet7A02G5ssBZdyNjAZJsMPmrasYLDOfA6Qo2qoFArXtEBqTv5
         Z10nFpkPW4ZePfJxETmw0s660HYXewirbS6dPm74l9IZfG0oU2BSY83rdtDC9M/gTiqk
         uu9yNShAz9uvNV1tUneMhoWfeagjqjb0B4/HGQGe9ozwTF+VpsQAjI6cngU83+wq13aS
         4A5EdZff4uqP/w3LcAxwkcDPUJFY4K3nI3dR+y4Jsc2yiK/sDBiJHh4Y5UqNKuA0741G
         vBm+rSdEqE0L8kLcGDoaZzuheD+X89UfF4BKr5O8FV5PJIiF1bAk3jPDG4+iO0rWjQn4
         85ww==
X-Forwarded-Encrypted: i=1; AJvYcCU3jzVexcybqEJmusrdSLVzb/McPloyXQOKq6xVsRNvAc1910lIpz2KIv00rdhVvpix16TXwW18CBzfQQFB+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YybYYUgiXPobdqIghymar/jM/o6CO09hu0cZpfvcTqk8bys3GyU
	ARywTrePvnzbY37TqjRILcwaq8tfsqEsGtmSVh5IQzDJEsp3YgI5hKIG45YiXxnl5dzzYuNpQd7
	fxEtUvPnV3Z/ABb9DQDIZv1Q9O8V0w8shGhl8Z0JEdYcpVQ6GgHyT+2FOFsetNrpXCg==
X-Gm-Gg: ASbGncs5erSwGWEWtUZB/uBskGbNdWzbbDsITFyM7J2d163uObOCmcWBSLqSzDS0t3t
	0NLAp1fBL81AO53Xesm9dRy/1kAObRX6icFB64hwC0ieZs8S+kQT7HhPyvaJ0rXv9vRRWJHrrZV
	3WmRlmwRlZSA0mWoN+zhZobLEl5XwcJq7HMU0iFWxRKdE80mAOPw3tg1eIUHvMw5l30Gxe99+vE
	a5Xp7VUTeb28RErA165vDOn+qrUB4KjQPOJFOWjwjJc3w+wXeWjQXFV25j6iKSRY0B5nRv0j7v0
	eF/onT+X3px/sItJPRZmh9RFHsTJHrpVBrVPeJp4uVaGA/J0YlFaYFw2sVfPShzax3UeTAM=
X-Received: by 2002:a05:6a00:928a:b0:736:3d7c:236c with SMTP id d2e1a72fcca58-73682be4d64mr6258975b3a.14.1741203600041;
        Wed, 05 Mar 2025 11:40:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEit7rS+bUZLICAMk+jW8iJKAZYzsBcMpzhao9oXjFVFFRg+KWvR8uITBhQospGLt/JvQf/xQ==
X-Received: by 2002:a05:6a00:928a:b0:736:3d7c:236c with SMTP id d2e1a72fcca58-73682be4d64mr6258939b3a.14.1741203599565;
        Wed, 05 Mar 2025 11:39:59 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7363288529dsm9470348b3a.41.2025.03.05.11.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 11:39:59 -0800 (PST)
Message-ID: <ea1bf15d-ac1f-4443-af05-89c3f8280378@oss.qualcomm.com>
Date: Wed, 5 Mar 2025 11:39:57 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] wifi: mac80211: restructure tx profile retrieval
 for MLO MBSSID
To: Aloka Dixit <aloka.dixit@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Muna Sinada <muna.sinada@oss.qualcomm.com>
References: <20250213225036.3118133-1-aloka.dixit@oss.qualcomm.com>
 <20250213225036.3118133-3-aloka.dixit@oss.qualcomm.com>
 <e38f01b2fe15902770cc11de24e82fcfed1aad5d.camel@sipsolutions.net>
 <13fc7b10-dbaf-4df8-aa8f-9e9095657d47@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <13fc7b10-dbaf-4df8-aa8f-9e9095657d47@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: C7QupsjAMNBb2gP1iBw8CK-zmiYjpzdT
X-Authority-Analysis: v=2.4 cv=bPnsIO+Z c=1 sm=1 tr=0 ts=67c8a891 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=YuS9t3q7v_2qBqA6pgsA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: C7QupsjAMNBb2gP1iBw8CK-zmiYjpzdT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_08,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 spamscore=0 mlxscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050149

On 3/5/2025 10:39 AM, Aloka Dixit wrote:
> On 2/28/2025 5:44 AM, Johannes Berg wrote:
>> On Thu, 2025-02-13 at 14:50 -0800, Aloka Dixit wrote:
>>> From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
>>>
>>> For MBSSID, each vif (struct ieee80211_vif) stores another vif
>>> pointer for the transmitting profile of MBSSID set. This won't
>>> suffice for MLO as there may be multiple links, each of which can
>>> be part of different MBSSID sets. Hence the information needs to
>>> be stored per-link. Additionally, the transmitted profile itself
>>> may be part of an MLD hence storing vif will not suffice either.
>>> Fix MLO by storing an instance of struct ieee80211_bss_conf
>>> for each link.
>>>
>>> Modify following operations to reflect the above structure updates:
>>> - channel switch completion
>>> - BSS color change completion
>>> - Removing nontransmitted links in ieee80211_stop_mbssid()
>>> - drivers retrieving the transmitted link for beacon templates.
>>>
>>> Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
>>> Co-developed-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
>>> Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
>>> Co-developed-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
>>> Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
>>> ---
>>>   drivers/net/wireless/ath/ath11k/mac.c         | 20 +++--
>>>   drivers/net/wireless/ath/ath12k/mac.c         | 33 ++++++---
>>
>> This probably shouldn't come with so many driver changes in the first
>> place, but in any case the changes don't apply on my tree.
>>
>> johannes
>>
> 
> I will refactor some of the driver changes in a separate patch in next 
> version.
> 
> This series isn't applying cleanly because it depends on another 
> refactoring series I had mentioned in the cover letter:
> https://patchwork.kernel.org/project/linux-wireless/list/?series=932457&archive=both&state=*
> 
> I know it is a big no-no for mac80211 changes to depend on the driver 
> but sent both for the sake of completeness. It also explains why the 
> driver refactoring was required in the first place, because without that 
> series this current patch was even uglier trying to access tx conf at 
> 2-3 places, RCU accesses everywhere.
> 
> Anyway, the pre-req is now in ath.git, let's revisit this one once it is 
> merged in wireless-next.

My PR today will pull those driver changes into wireless-next.

/jeff

