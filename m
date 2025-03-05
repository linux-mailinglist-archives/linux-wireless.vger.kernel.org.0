Return-Path: <linux-wireless+bounces-19810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA4CA50A13
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 19:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECB7188802A
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 18:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5E3253322;
	Wed,  5 Mar 2025 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ixK9I0/n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7CD2517B4
	for <linux-wireless@vger.kernel.org>; Wed,  5 Mar 2025 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741199950; cv=none; b=G9N+6zyA6nvYvyY8y+1/c+NRRwzDhePwaQptqmbIw4X/swHLZwRpgGnbMOtimNKBhA9DM0GBcrXRo+SXhBf3ZGYR7MwagbgJ+9vaiGvYQn88q6a+dwQXASYwLuhXR5cMBsdN7Kx6uQ8A4Bg6gY6NIRRBLclzZ7RUH8l1xqS+3Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741199950; c=relaxed/simple;
	bh=QrjgqBdN6W9UX65TNadJxdfdCxawnlqP0+1xVoI+dzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVNOlkyhFrdiO2fna6VfBFyiXkNAZ1sY7p1MhGsjaclpqeowENuedvaH6D+n+p/HdccJJMBx3Onv9EYFt+T/oXTgCUDs54M2YPxzTfJ+/AGd7+2Pa3ifNe4osx8CYjd9YypFqsvW6o5BSsWcYkNQEhY3E2ORPlIGvgQaUVzrOEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ixK9I0/n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525B1Bi2029016
	for <linux-wireless@vger.kernel.org>; Wed, 5 Mar 2025 18:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4x6wONZUBfsWlOj2E3IYGYtr1M7k0FZH2clO4Vq2FEg=; b=ixK9I0/n3F3231Pk
	GeG5rFY6fTezSzxLMzf2zzi7EpegQDyTlkleUpbuIZ6c9V1RU6tandjRfsh9KF/6
	pkIsWDAb3apUQOskOMVmhv0P6egzfbjJxL54JOD3zds9Zn2/jGScpYHJA7K7L7gX
	w9drYsOu40egdwvslCb5b8DFzGmkl0zd9i2cYU5uk98zmhVKtdvp1RN+ockJfhfr
	56fcocqtAAtp/BA5SoFyREbzwAqQj69rLl3SV9DMoKf7JW0OJax2z3WSl/Z2WGLX
	YKeR3eHOjSMb4esNUFXLAOeaUvUjNIcClC7nEwe8hYV9G2hoZzdQ6JsT43TyUAxL
	Sj+TFg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6tpd50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 05 Mar 2025 18:39:07 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fecd603bb8so9479252a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 05 Mar 2025 10:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741199947; x=1741804747;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4x6wONZUBfsWlOj2E3IYGYtr1M7k0FZH2clO4Vq2FEg=;
        b=DjFmsMJs+jDP/MHVC+F9Kir6WYFJiEjJr89wYmHQk525XO/NPTj75zWYXKsieDY//9
         f44kfMDSxpwbcvYN6E+3Xvk/kEB5cc46gORSDKfcAgGGcAC6l8/LzzHSweywIZnoLqr0
         ETcj8B3WIp4E5Wfj0MCFI8GJdH37FERAG9WVvYeTNDlOZ5x2M15qXtBX1Z4h/OIhvYlC
         Uy+0Xllxpd0jBE7ZNROGPp7FrShbDKouxD0LO94vkH+AleNqDSAXDELAqSmhn9XcHA5O
         mGIPXOrWOoWU8AM1B6ZXOgzJ1OO/zLnc1wpNr25ewFAazbzx0iuaCAdBXkoylCwBc7Xn
         c+Lw==
X-Forwarded-Encrypted: i=1; AJvYcCVHW74dxwVnKO+cKTp3bqurbRG7DDVErTGLioTYtdJ50cKlt9NQdQZdbxCwskQaGJi4aZ9GKR3mWCDb/YJiRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3IW2SpItwRfDXUyJhbT5c8aaV2C5yhW4BZX2K6ys8GaWveuIp
	2FmxaFihwEQHPt1Lu4+9PNvmlMyB/950I8QjgGdDAuydrh0DshyZZ0JJp3uhAH/HPayVtoy0Nk9
	i4w1QSLn9a0S5RmV2/4Jo3jOcoL/c2Fds/GVEFEA9xaZQP9V8dBrWiNYEiiVrxBX0Sg==
X-Gm-Gg: ASbGncsFs3e6Kx+U2fs7YzwN3O4k2/4lSOSTRJRF/hOME4H+HLB98GvxhtisrpE2MPs
	aieAkaZJJNzQWh/XHD181KJ+O+wH71ulS+EQt4Ljr69xWS3yGSUbDUsbfHhSw86Utbwpody7INQ
	vofL93HuyJAsrcrneDwpmBEzPvg5ut+Puj5o2M8IQ1SLu578jY6O8W7Njn23Pj/1twbntucnQjM
	XNQy7rEy9c+NjmXtk8X8TS8nGKLmz/43sXJ22sbHylqNNLRya3mYtl5pwOuv22+DXhbdSR62xWa
	IFelcD7qO8M6/124ENVt/99FIA8EaatJRGwDrj//Uj4cFcYwEL/XedHakTeCbMG4ZHOcSL+e
X-Received: by 2002:a05:6a21:1f81:b0:1ee:e20f:f14e with SMTP id adf61e73a8af0-1f349577126mr8153708637.38.1741199946934;
        Wed, 05 Mar 2025 10:39:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuSB9M02Q6a4KnrOJn0CyfVp2XReVOm6VU9oxtaY5OBN6OCEGzWZdyqwTqIJGdfdByEGgkpA==
X-Received: by 2002:a05:6a21:1f81:b0:1ee:e20f:f14e with SMTP id adf61e73a8af0-1f349577126mr8153672637.38.1741199946520;
        Wed, 05 Mar 2025 10:39:06 -0800 (PST)
Received: from [10.227.89.219] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af26a9b285csm1866206a12.2.2025.03.05.10.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 10:39:06 -0800 (PST)
Message-ID: <13fc7b10-dbaf-4df8-aa8f-9e9095657d47@oss.qualcomm.com>
Date: Wed, 5 Mar 2025 10:39:05 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] wifi: mac80211: restructure tx profile retrieval
 for MLO MBSSID
To: Johannes Berg <johannes@sipsolutions.net>, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Muna Sinada <muna.sinada@oss.qualcomm.com>
References: <20250213225036.3118133-1-aloka.dixit@oss.qualcomm.com>
 <20250213225036.3118133-3-aloka.dixit@oss.qualcomm.com>
 <e38f01b2fe15902770cc11de24e82fcfed1aad5d.camel@sipsolutions.net>
Content-Language: en-US
From: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
In-Reply-To: <e38f01b2fe15902770cc11de24e82fcfed1aad5d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PMb1+eqC c=1 sm=1 tr=0 ts=67c89a4b cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=oEaP63jJ1L8retAtHqEA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: UuxxTkCQKFV3ZaCLeXg_BJk6T2TSOqS-
X-Proofpoint-GUID: UuxxTkCQKFV3ZaCLeXg_BJk6T2TSOqS-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_07,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050143

On 2/28/2025 5:44 AM, Johannes Berg wrote:
> On Thu, 2025-02-13 at 14:50 -0800, Aloka Dixit wrote:
>> From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
>>
>> For MBSSID, each vif (struct ieee80211_vif) stores another vif
>> pointer for the transmitting profile of MBSSID set. This won't
>> suffice for MLO as there may be multiple links, each of which can
>> be part of different MBSSID sets. Hence the information needs to
>> be stored per-link. Additionally, the transmitted profile itself
>> may be part of an MLD hence storing vif will not suffice either.
>> Fix MLO by storing an instance of struct ieee80211_bss_conf
>> for each link.
>>
>> Modify following operations to reflect the above structure updates:
>> - channel switch completion
>> - BSS color change completion
>> - Removing nontransmitted links in ieee80211_stop_mbssid()
>> - drivers retrieving the transmitted link for beacon templates.
>>
>> Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
>> Co-developed-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
>> Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
>> Co-developed-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
>> Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
>> ---
>>   drivers/net/wireless/ath/ath11k/mac.c         | 20 +++--
>>   drivers/net/wireless/ath/ath12k/mac.c         | 33 ++++++---
> 
> This probably shouldn't come with so many driver changes in the first
> place, but in any case the changes don't apply on my tree.
> 
> johannes
> 

I will refactor some of the driver changes in a separate patch in next 
version.

This series isn't applying cleanly because it depends on another 
refactoring series I had mentioned in the cover letter:
https://patchwork.kernel.org/project/linux-wireless/list/?series=932457&archive=both&state=*

I know it is a big no-no for mac80211 changes to depend on the driver 
but sent both for the sake of completeness. It also explains why the 
driver refactoring was required in the first place, because without that 
series this current patch was even uglier trying to access tx conf at 
2-3 places, RCU accesses everywhere.

Anyway, the pre-req is now in ath.git, let's revisit this one once it is 
merged in wireless-next.

Aloka

