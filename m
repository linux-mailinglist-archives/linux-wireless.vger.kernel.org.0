Return-Path: <linux-wireless+bounces-28163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8CCBF9DF9
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 05:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E9D163510DB
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 03:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EDC78F5D;
	Wed, 22 Oct 2025 03:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DVFKczZ+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF74D1ADFFB
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 03:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105110; cv=none; b=bSrnOdnK+mtYWeRnP9l701mkbriypesw7l/FygRn+AnK4bRIqLrEMIJRAId7uR8mYLvTAOt7HAQKXsm6WUW0+BgvI5h4QH23ggtxnzyDci5DPGniSCHHk/aiAT6T6MvKKcyiTm2/WwrhQeGHYkSBoYW992IB2+3Jl/0L5C0m+qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105110; c=relaxed/simple;
	bh=+BvikiwtzPxb58mA8nR+FCYW0W8u1MhP8rrkxIyg3es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGUUCBETaMGNkzBzRMPPlFockZnFuC2m70P6IZ4pauOHKfK8/71C6Zzy6zanFk6HIt7libs+XOjLBjHosIsHABSDScadJOVr+f65lEzu0DqhqhEqszsN6qFqt6IOaxBRy8owSbHyzOE/vtJ8/CObw1uhXSu9JKB/j2Q5misQbcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DVFKczZ+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M2NCaF018809
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 03:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6thBAmnnjed2vzk21aNxPfUfDu3hf6KvEZV+JLpHOZM=; b=DVFKczZ++8XRKTBw
	OmDJhbCRMxc1u4qfqSo+Cg+u4+L4nvG371VH0P0rG/KgdBicTQHIWserLvWW1ilI
	GWInlNywlOxpDH1zEh4OKNrueSgKWkAG4MS6HEdIuJynH/sUAENhB5bVEA1kf+yF
	2qokwxIVV4HCRuv5dfvlsRXf4orpYY9KETGPhZfv9mTbZC1MZ1NqNrYxLsylMaRI
	NopvFJRoGszPEdyWGXu7q4ArawL5d9s9jV0N7j9lB69K4Xf8+KKTdc0ZDiCGUKwk
	wvZcsKQPz/mIwnttwcQwP8jNgixDuPox0y3SzicCgPm+MUYDXOVzCneRer5yOX+u
	Fq7/Xg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v469k211-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 03:51:47 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2924b3b9d47so39340715ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 20:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761105107; x=1761709907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6thBAmnnjed2vzk21aNxPfUfDu3hf6KvEZV+JLpHOZM=;
        b=O+1ZgBdu+u6hDP4Nbd+Ha8u48tWBFHFQHcGTozzqHnUk4D3RofGUQXSWw91TX08nYO
         Cl37IQJ9tpy6+K5hlGfMMNfI6aIZ7rwLENrYFfaCWpatSIHaiwDyWnLh8wxfPuKoXQZ9
         XPGCl4kpi1xqiKf6B8kEK8gFwYOgNC0jxAnTNiLMOyfkIDND3wJJUxQhk6EXHYjLhFFm
         xUlFepQ4dpeWrfiwCLjJCJU3+9VAsTkAM5xJTLX5W3LdXe9+syX/qiI956LUt/396OzM
         Q97UcOy2+qg1bmprPMFSqPM7LHJ72dOxmaxASlrO6/csPQlv6o3HRAz/8OhEZvFCJ9Nx
         NUiA==
X-Forwarded-Encrypted: i=1; AJvYcCUl2LSMgmMpscDRE8Lz8Az3XFyK3mv78sC1BTy1ruzFGfi2i7NWYPOoC+V9QPQyPSUo1fsy0mZsnTpFWBtkZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyosnxV/yu6nfAOJvPUKHWMyHMdbXKz/omsKWpR+nWzqOHesuNb
	n6OVwk3+DMZdfJ+lnrCWeUZf/dR2fE0L/BeOpwQUx4UQD8fdQ8fhRn7jEXWGpoJ3yzzcFMgEKUs
	1XIZpoTotvEZ7KP3C/jnPPmo9lgRtuxMMaEwoDXgVIQLHb0dC4xaopPcGqUQbUBhBI3eLTQ==
X-Gm-Gg: ASbGncudLMZAPTIk9IzSjxYk9BCkqB1uTktbxhWlFoE1NSPr2kElmvZsHLOWo9r1dcp
	ZhvR9lFTkKKw0V7EOjNJrP86fx5bPBuSCNDy8pVx9VIPJGWut1lzHGPHXLjjsWobE5umlBNLZeb
	xA3tVd1qHHv7jRgSyMvL22Z/0oieVvXqvPlazUPYTuyIVdqrOo6GuE7tB30BsAQkGXGzzMI20fh
	3vyhBM6xCLd2t+/07RKsc7NLeri4nV5DIlx+0ECmKoaCQUdGEdeTjzJhR25VVfb89NCb4p3UiRp
	jyjc7qM9NyCrXY9j6uSMFHZJ/CYr/Nt1Wfthcptg0PNFxpgPzM64Ln0KNvZep5xppfD4W00YBV6
	vR4801B4N0U0eOvN3AxhphzYL7Aiub3T44D6JOc6t1I+T5C27tQ==
X-Received: by 2002:a17:903:b90:b0:276:d3e:6844 with SMTP id d9443c01a7336-290ca1218cbmr208678005ad.33.1761105106497;
        Tue, 21 Oct 2025 20:51:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh4seaOU3W1mfIG9lcURG5JRf7c9LzjOewpWD1MWdJ8Yyv2IjYcmg9Y/6PxAvNwjps7MHorw==
X-Received: by 2002:a17:903:b90:b0:276:d3e:6844 with SMTP id d9443c01a7336-290ca1218cbmr208677785ad.33.1761105106060;
        Tue, 21 Oct 2025 20:51:46 -0700 (PDT)
Received: from [192.168.225.142] ([157.48.122.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fd5d76sm125506975ad.39.2025.10.21.20.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 20:51:45 -0700 (PDT)
Message-ID: <6cad33a6-6f01-966d-a0b9-60818be0b56a@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 09:21:42 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 ath-next] wifi: ath12k: add support for BSS color
 change
Content-Language: en-US
To: Wei Zhang <wei.zhang@oss.qualcomm.com>, jeff.johnson@oss.qualcomm.com
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20251017060100.1751692-1-wei.zhang@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251017060100.1751692-1-wei.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: khNVqLjBHZMLZrV65aYzTSirMdVnyNc_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMiBTYWx0ZWRfX4VyOI0MJ9kPE
 3gCHOJT3Py9FScyQ9mLrfeSSlKDPiUIl1cRJtK01iuyTGhvrtPd81Cb6QD8xnQMAlMpriu7Wq1m
 /5UlueiZSH1Gzn1baQ9/Mf0Nz2+vzP+CxGeiY8L4tCI2iErHG3sjgq4i2IM6+3bTGeOCT4QnD8N
 4sj6dL33eJ1xZQFHtKwiEvKRBsKIELy0RkipjzkD9m7SfxHP8KKx/jwp6ZBZZx8sVg3rtRsiu+g
 Ou/0lid9Zbuy1kiOsGtRUpzPaoOFMf4fmeRLSWFDOuqpgl6YV4ZdqFwg3pPMbvWtzMGmdck9IVj
 BnhTCF19P+z/Y7UdIPqBZubcCNbolVILyoQHP2GUdhFTZWYClku2tFQmqngDSyy+6i7oq9/wv1I
 B7BJ4Ux2vzlDDPYrKhBLNRNDvfuC7w==
X-Authority-Analysis: v=2.4 cv=U8qfzOru c=1 sm=1 tr=0 ts=68f854d3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=MVWiM3nRykcdLg9H6cDE8w==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=wj1T3HU5gSB1aoFxu4UA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: khNVqLjBHZMLZrV65aYzTSirMdVnyNc_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180032



On 10/17/2025 11:31 AM, Wei Zhang wrote:
> Add support for handling BSS color collision events reported by firmware.
> 
> There are two scenarios where a BSS color collision may be detected:
> 1. The AP's MAC detects the collision directly, and firmware reports a
>     BSS color collision event to the host.
> 2. A STA associated with the AP detects the collision. The notification
>     frame from the peer is routed directly to the AP firmware, which handles
>     it and sends the BSS color collision event to the host.
> 
> Add logic to parse and handle such events, and pass the data
> up to mac80211.
> 
> Unlike CSA, firmware does not provide an offload mechanism for BSS color
> change. Instead, the color change process is triggered via beacon offload
> TX completion events sent by firmware.
> 
> BSS color feature is enabled depending on service flag advertised by
> firmware, based on which color change functionality is invoked.
> 
> This change builds upon the following ath11k patch.
> commit 886433a98425 ("ath11k: add support for BSS color change")
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.IOE_HMT.1.1-00011-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
> 
> Signed-off-by: Wei Zhang <wei.zhang@oss.qualcomm.com>

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

