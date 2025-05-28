Return-Path: <linux-wireless+bounces-23473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B24CAC6B9A
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 16:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061414E3E78
	for <lists+linux-wireless@lfdr.de>; Wed, 28 May 2025 14:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA34288504;
	Wed, 28 May 2025 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L80+QYpG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9DC2882BE
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748441973; cv=none; b=TYgtTCVfbHEGBq7YE8+jdjDtl9Te+krd/kgLLroqs9Fy8FiteorJP5M1OtIV0nrnGpegG417f699uwphn4wqDTf5vpIWyKqYJinzKkUkcrgwte3+i7ejEDW8c/QJZPzgAABlJjYgDTBqoXkQaNHrK1umL14xW695bCSiMpQKE7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748441973; c=relaxed/simple;
	bh=1mvgoJCTWD42ezWDv9SuLhDqGhF/mPUfrZSEaaC8TCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NvTkyr0qc73pwtnz9BMAhZjd+8W4i0Ify7qRxCOHNET09YPoVMEOVcQ0L5vzIvs9R/W+Mxr6Wr+nanKrk5GXjP5WBEtpMK4h9jMhb5etiLLzZ/dcoeUlKo+HWe/vTGxUWTwFZbKrs99bNhPVhmPyYN6n599SXBV8bZgZwKSDbSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L80+QYpG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S5oQQm002310
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 14:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ft1i5MAHfi/TrXCVy7PskuVidIbr95NU5tS/3TIxvvc=; b=L80+QYpGxTK1Y7HN
	rCrn5fb3UP2xA8Qu/259y/2cXyQWtUmpNtWGib61jK5bc0UZyHCGgDPTjWifYtmX
	FHkLrjnpMT1hJ9rQkXD5lywZ0hV+8v0+yDXMy+cdnuW4bOrBMkMEo9kKrVbk6/x7
	SVXluJLfkgZugGmidxfXbZraT91lZ1u839u38tb4WYJmKwmpfN+0GEzUtJMfnM9M
	gdxOKJD4o0eRMe65ymAxOr+cuqHX/4tfut3tlMcxCF4aLDJteO/jdAhbtSgMLzMy
	o9j520TBgqAiqhoRsBDefx3p9Yip7ebYYYHbozPC5SwGmm9hxH02BcEe8p8tXfZj
	KUM0Hw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46wavkv8n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 14:19:30 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-73c09e99069so5265883b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 28 May 2025 07:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748441969; x=1749046769;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ft1i5MAHfi/TrXCVy7PskuVidIbr95NU5tS/3TIxvvc=;
        b=tjKfhl9PM3LI3lpMU5Y2YhmdgXudhyxucToNp2HSPX6yVWsH9Q6BCUvHkT/BcgxBmE
         +QZNZXmyZo34erO1MDJcqxqTbQ42kXK3b1a17xOBuiT7eLjLOqVKWoqOk4q7S44u6zgV
         Rw9v5ZFR8JlzneHMbAjCqB3tDuTg5z5EdS7r07RPo0+vLUiUPKGeGr8Z+4pHKgf9iPdL
         jTCg8HUaYdDrEw2vZB/47SgiuYI25Y+Exq9ZAjg+HiDvZ61ycmQEwgG7jIrfInqMgaIz
         Uw0UO+xes/e/JYrKjoBr3YdfyrJ+bnHnlX4fOUDNP0d84WbI3Fvm5/AFcs/GP8GBXg5K
         6jIw==
X-Forwarded-Encrypted: i=1; AJvYcCWiMrNN4eC4qQ+Kb2qEoe4eAfZHR80iJUKjtvhX731IioWhXExNX3grSy4oCBiqTcert/Kzx/VyYDWqggsiyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmEdsD7knL09uc3KmtdfeQgC+B98s8uYDvxt0OFGOE/bs2s/7E
	8Pw6IjHatYxcAbJHVJN3B016TclYyvQlLCvjHMt/8u70/y34R7ITxPUB+341dwcj5YQE6mGQo3+
	1GgdGoCxEZ+MidWDYLfJBxAkoQ46OlBjDKjIwMmX9fBAjHM8xlbWxZAdS7OXVUxDkC9IJuxN+Ts
	P6Wg==
X-Gm-Gg: ASbGnctQ3OrUVKSwTKWqARghyGinizGeisXo08O5e6sgh/XEgDnrud4DrRc/hP0UyMN
	pmkU/DnCxiHEKxxAorkz5YWe6NxPNkGW2BF49aILw7A/64d8F+csdGc0UcMpFsUZUgSb02U78ic
	VsqsWUyTTRd9154ibKz9OmoOPlr6DowSZBl/BYV5sFSnTnhSLNflOmlecsZWh5ZAwlr5NsMAkzZ
	RyMmgQkmpRMEg/99uexSXM1fBERxF2TTJFLe8wbvJHUegt9MqPLIkh1iDzCpbLqnPn7jNynRUhU
	+I/Oa3/2qzBH6wpv6hvHOMLG7gbbkAzuSBFtBdk4Hg8i3GLeEfir+Nfc77WxkGWQeCc=
X-Received: by 2002:a05:6a00:114d:b0:73f:f816:dd78 with SMTP id d2e1a72fcca58-745fe035fbdmr23637466b3a.15.1748441969063;
        Wed, 28 May 2025 07:19:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnmLCqNxKIQa+DR73xlUKbqDnRDvNlEqAyDuv1vVc9oRMJkDP1DTe7/VP//InnBGqf6vFfdA==
X-Received: by 2002:a05:6a00:114d:b0:73f:f816:dd78 with SMTP id d2e1a72fcca58-745fe035fbdmr23637434b3a.15.1748441968662;
        Wed, 28 May 2025 07:19:28 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-746e343c2e9sm1322576b3a.137.2025.05.28.07.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 07:19:28 -0700 (PDT)
Message-ID: <751fe689-793d-4f24-b85f-c81d8776268b@oss.qualcomm.com>
Date: Wed, 28 May 2025 07:19:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CI results
To: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <01da63d05c861af5a71eb18d117341b5f7c7628f.camel@sipsolutions.net>
 <8c0dfc10-f60f-47bd-a139-d60f2663c22b@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8c0dfc10-f60f-47bd-a139-d60f2663c22b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6L9xdfwZ0JwMkT0RDmLOmBw8BG-NavkM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEyNSBTYWx0ZWRfX6it/hcmBi4un
 ucDNlYE9z4eejGeadP2dxg3oJAEAn5HIMbdHeAv2upouoXN0SdXbPMFP3Zm4XVc1r0vre9FrKey
 CqSs2NAbUMZV5IH04GLJFm/ZlQe3JY5xjtWc9cKm1IF2dJCeFwTCWEl2Zd3phgJ4Q4xQR4+kWOn
 v/dWC7E291IF2anD8lAEPLT/DzgmtBK3f9U7ldRhs5cbRi2e+yv9CmO9k8zeZWWK9Jg4GZMWx8V
 jJj/iM0OGO2w/uk0aT0QwCw6J+hpRXWsD8zAkbDQx7E/y1s3eOxvXaF/Ux5Dc4LiicSCzgjd2Rn
 HvdOLIoa8+LaFz6AmyzYg9gr4iixbx5cmR/x0gTGr7HGM+lOpRCr/rQHzoq+UFnD0SOf0VU7cAJ
 qSlYG3+L83tBhKAC5Z6J1ZZr4O0lGsLliqGkVKQBlWIuu2LMweFC4Cnq4Cz9TbFC9NpWqETm
X-Authority-Analysis: v=2.4 cv=fMk53Yae c=1 sm=1 tr=0 ts=68371b72 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=voM4FWlXAAAA:8
 a=NEAV23lmAAAA:8 a=911_mx2uUerbPBWQAm8A:9 a=QEXdDO2ut3YA:10 a=WEDqQ-4R3nIA:10
 a=4b4ywMqCX7kA:10 a=OpyuDcXvxspvyRM73sMx:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: 6L9xdfwZ0JwMkT0RDmLOmBw8BG-NavkM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_07,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280125

On 5/27/2025 8:56 PM, Aditya Kumar Singh wrote:
> On 5/27/2025 2:25 PM, Johannes Berg wrote:
>> Hi,
>>
>> So I'm probably preaching to the choir, because those who don't pay
>> attention won't read the list either, but still ...
>>
>> Please everyone look at the patchwork dashboard:
>> https://patchwork.kernel.org/project/linux-wireless/list/
>>
>> You can filter by yourself, e.g. for me:
>>
>> https://patchwork.kernel.org/project/linux-wireless/list/?submitter=90
>> (but that list is empty now for me)
>>
>>
>> If you have _red_ items there reported by the CI bot, I'm most likely
>> simply not going to apply your patches. I _might_ if I care enough to
>> fix the issues. This also depends on the timing, if it's with a lot of
>> time left (like right), then there's plenty of time to resend.
>>
>> If you have _yellow_ items there reported by the CI bot, I'm going to
>> read that and I might decide to fix small issues such as spelling
>> myself, but I really prefer not to, it makes things go smoother. Not all
>> the yellow items always make sense, especially checkpatch.
>>
>>
>> And I guess it needs to be said, but since these results are public, I
>> feel silly manually requesting that people change the (obvious) things
>> that were pointed out by the CI bot. I think I'll just start marking as
>> "changes requested" semi-automatically.
>>
>> Ideally everyone would build an internal workflow that checks this
>> before, even the NIPA bot itself can be run pretty easily with the
>> docker container (we still do that internally before sending to the
>> list, even though we run the list instance now as well.) But I'll grant
>> that not everyone can set it up and have enough hardware to throw at it,
>> that's why the public version exists.
>>
>> Please? :)
> 
> Concur with your thoughts here. However, I just want to bring one point 
> related to _Dependencies_.
> 
> In case of Dependency (Depends-on tag) between series (even from the 
> same tree), the bots - kernel as well as the NIPA, currently does not 
> handle it gracefully and in such cases there could be legitimate build 
> failures reported since obviously the declarations are in parent series 
> which is not taken by the bots. So in such cases, _red_ items will be there.
> 
> Do you have any suggestions on how we should go about handling 
> dependencies?

patchwork itself very recently formalized the usage of Depends-on:
https://lists.ozlabs.org/pipermail/patchwork/2025-January/007465.html
https://lists.ozlabs.org/pipermail/patchwork/2025-March/007490.html
https://github.com/getpatchwork/patchwork/commit/bc2d1b1dcf89c619e027ae4dfd3036cba30e5583
https://patchwork.ozlabs.org/project/patchwork/list/?series=442332&state=*

Note that this support is only in mainline and not part of any release yet,
but hopefully the Linux Kernel community will adopt this approach (sending
e-mail to the workflows list to ask that question).

/jeff


