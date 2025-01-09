Return-Path: <linux-wireless+bounces-17226-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EADD5A06D96
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 06:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D73188A486
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 05:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF2514EC77;
	Thu,  9 Jan 2025 05:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z7JX46kv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DAA2144D7
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jan 2025 05:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736400573; cv=none; b=t+11hMGQF6diHsCexzlD+5Asx/Wach5CJNKiRb1Bc1RcyrcWdfnEfiCi9/Dyp6QmvID0zCUWCgJoaYqBJoMqNNAKwW5BtNDmhAJeb9aNyAEt37G3GyApjkKQjpoSQ0C9pyOFf81Kr0zd0gma4mnaYMXOeV69aqjsABEUp/AkH6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736400573; c=relaxed/simple;
	bh=TKmtxuxCs2cDlUvMnCilskVQXQLFMeNBVIRzOAKIQiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A40hRDApNOnVzvC4RIDGg8Ef936xYoIbnVfUpxA/0CPmZZYMqrejDF+HemuIoPIXvROP2SoVWtQlDlUjxXaOh74MX9jBTqKmDDJ4/6AdDoPD0y6xli4WvNBPXhpeItW06flU/+bXCQLaVXMlkLYUGfRT0obmq8anBpNJcoiMOYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z7JX46kv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50903kHX015239
	for <linux-wireless@vger.kernel.org>; Thu, 9 Jan 2025 05:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AomeDFgSGwMC362R7pKEtJlMficun3hyRQoON7UXbyo=; b=Z7JX46kvBeHvmV9r
	7I/2YCGtC1UGgGJysBRLPMMTj4lH07q37jSvok4GAACEeTHHdz6mzyZ6vifbwI7y
	c7q+TVkFUOWMSNPLyfHq5UQsEoiUPVjAaqRZuSvsi0KGQGpGMeE+Rb7B1lUoYfjt
	1PSCGvLGeLP7CLn1DeRs60wGrY2sLR2nLCTthx6x+sRAB4xIwaSaCvJCZpfOkNj6
	2CBCql7xslpMSAQWRHTrgooB37385M7hOY1xF4AfvCOP80U9f017XEeGsWLx8iWY
	jbfghyv2o2oqv3j/Kk0nvJfOptw9kL1a44+MNTgqbzao5mB8mvbWrKptKtSjr7/w
	dGwOCg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4423jsrmdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 09 Jan 2025 05:29:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ee9f66cb12so1059972a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jan 2025 21:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736400569; x=1737005369;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AomeDFgSGwMC362R7pKEtJlMficun3hyRQoON7UXbyo=;
        b=HmTon4sBK1xfOcrhTeulDOVlzsNxFlGaNXf5shd6g7TynHgIaCMsZakUw0CUkSh6Nv
         kZMUyzNkZmcgdoicLr1OLG5IpXzvWkhc4Cg2E8E6qGFxPe8gvlL4squozbyKj7G6+8mM
         KAdmuefsOdgICnaD/zlTncAwzOl5b6uTBjWScFgEGYBEx+xWoG8GMf0sK3csVpr26P8K
         U4W7zVllltOgDMRS2Jub1HNScR63jA3UO/bftni8JUuDqHp9H7yT8p0HbiNI52z/g9qQ
         TFSaF9CUIXv7IA0vYYHYzhTe2nHJ3Lx7k/xHDCrIw9ZS80wGL2tL7AAU2jbbMJW4Dwow
         fQhw==
X-Gm-Message-State: AOJu0YwlirfQwEHEumood48lOFRAD6wHZKQ1hNiXq9s7XOnfgkRg4G+c
	dhVbSj4x2G0BZSE4MC4W0G/fsOSTR0AEV04xeuwy5kPMfAoO67RR5PR1ur3KTA7KF9S1B0rhSH6
	IVM2Qyv2LlRtxKq78NA9pI2FtUHmCgNoJUiad0jrQpcxvf7TrjoxacgyoQwK32X4AfQ==
X-Gm-Gg: ASbGncvqWqjxBKE/BibRpKEG7z7mkGdnBiwMjHvHSxrfD4CU4oJOl3wQ3O76AsxxfNA
	M6BwwYYIPcgZcC6JjXYjUilokwhHB7XgFJw5zA7UctMTIWILc7RyYwJdhFS5jHh0HXfkDhoI27q
	nlxpxymm0z4KPmtRLBAFiRv51hbh8HXIDRPyKDIRyQM6PTUlTzej/fgqkjJM54gtMbXeJDQ6btP
	PvZbi52Omkrg3n1501hg1dczYZWZxH9xmQD204vlP1jG6mixDg/eOyFdyxNnAdx/Eov9W8QQDAk
	9gku1LsDJ6EMn1XHya6KGq52FuaN82izhuf4CQYq3bElMvISeA==
X-Received: by 2002:a05:6a00:9285:b0:725:e499:5b8a with SMTP id d2e1a72fcca58-72d21f55d89mr6401053b3a.15.1736400568844;
        Wed, 08 Jan 2025 21:29:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrCgxuWtbvMdWYVLTNLA/J3knebI2sC8L8gjBe+t3P6abGGWwoViNcMxXvAkjUpDYfeYaxOw==
X-Received: by 2002:a05:6a00:9285:b0:725:e499:5b8a with SMTP id d2e1a72fcca58-72d21f55d89mr6401029b3a.15.1736400568453;
        Wed, 08 Jan 2025 21:29:28 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72b282bae08sm22534428b3a.163.2025.01.08.21.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 21:29:28 -0800 (PST)
Message-ID: <5f05898c-cc5c-4c31-891e-9d5cb9cf5bfa@oss.qualcomm.com>
Date: Wed, 8 Jan 2025 21:29:27 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] wifi: ath12k: Factory test mode support
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Aaradhana Sahu <quic_aarasahu@quicinc.com>, ath12k@lists.infradead.org,
        Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
References: <20240624095305.37189-1-quic_aarasahu@quicinc.com>
 <d38ac7f6-3596-4336-bd9d-61e99f3b070c@quicinc.com>
 <b4852e3d-1f9a-40fe-9593-84d5812d25be@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b4852e3d-1f9a-40fe-9593-84d5812d25be@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fHazwMb8S1YWSuTQ0o2FJ6Eu9ZJKKIE4
X-Proofpoint-ORIG-GUID: fHazwMb8S1YWSuTQ0o2FJ6Eu9ZJKKIE4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090042

On 1/8/2025 8:55 PM, Aditya Kumar Singh wrote:
> On 1/9/25 10:13, Aaradhana Sahu wrote:
>>
>>
>> On 6/24/2024 3:23 PM, Aaradhana Sahu wrote:
>>> Device is booted in factory test mode for calibration.
>>> The commands are sent from userspace application, which
>>> is sent to firmware using wmi commands. Firmware sends
>>> the response to driver as wmi events and driver sends
>>> these events to the application via netlink message.
>>>
>>> Also added changes related to correct pdev id access for
>>> fw test cmd.
>>>
>>> Aaradhana Sahu (3):
>>>    wifi: ath: create common testmode_i.h file for ath drivers
>>>    wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
>>>    wifi: ath12k: add factory test mode support
>>>
>>> Rajat Soni (1):
>>>    wifi: ath12k: Fill pdev id for fw test cmd
>>>
>>> ---
>>> v5:
>>>    -Updated copyright
>>>    -Fixed line length within 90 char
>>> v4:
>>>    -Rebased on latest ToT
>>> v3:
>>>    -Rebased on latest ToT
>>>    -Updated Tested-on Tag
>>>    -Removed second parameter of ath12k_core_start()
>>>    -Updated copyright
>>> v2:
>>>    -Rebased on latest ath ToT
>>> ---
>>>
>>>   drivers/net/wireless/ath/ath11k/testmode.c    |  78 ++--
>>>   drivers/net/wireless/ath/ath12k/Makefile      |   1 +
>>>   drivers/net/wireless/ath/ath12k/core.c        |  22 +-
>>>   drivers/net/wireless/ath/ath12k/core.h        |  13 +
>>>   drivers/net/wireless/ath/ath12k/debug.h       |   1 +
>>>   drivers/net/wireless/ath/ath12k/dp.c          |   3 +
>>>   drivers/net/wireless/ath/ath12k/mac.c         |  15 +-
>>>   drivers/net/wireless/ath/ath12k/pci.c         |   1 +
>>>   drivers/net/wireless/ath/ath12k/testmode.c    | 423 ++++++++++++++++++
>>>   drivers/net/wireless/ath/ath12k/testmode.h    |  40 ++
>>>   drivers/net/wireless/ath/ath12k/wmi.c         |  39 +-
>>>   drivers/net/wireless/ath/ath12k/wmi.h         |  21 +
>>>   .../wireless/ath/{ath11k => }/testmode_i.h    |  54 +--
>>>   13 files changed, 636 insertions(+), 75 deletions(-)
>>>   create mode 100644 drivers/net/wireless/ath/ath12k/testmode.c
>>>   create mode 100644 drivers/net/wireless/ath/ath12k/testmode.h
>>>   rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (50%)
>>>
>>>
>>> base-commit: cac9bfd02678adbcca9a7dce770609b9f7434d37
>>
>> Hi Kalle,
>>
>> Please let me know, if any thing is pending from the developer side, to merge this series into ath.git tree.
> 
> This series does not apply cleanly on latest tip. And base commit is 
> around 6 months old. So may be you would want to rebase and send a new 
> version?
> 
> Applying: wifi: ath: create common testmode_i.h file for ath drivers
> Applying: wifi: ath12k: export ath12k_wmi_tlv_hdr for testmode
> Applying: wifi: ath12k: add factory test mode support
> error: patch failed: drivers/net/wireless/ath/ath12k/Makefile:26
> error: drivers/net/wireless/ath/ath12k/Makefile: patch does not apply
> error: patch failed: drivers/net/wireless/ath/ath12k/core.c:42
> error: drivers/net/wireless/ath/ath12k/core.c: patch does not apply
> error: patch failed: drivers/net/wireless/ath/ath12k/core.h:209
> error: drivers/net/wireless/ath/ath12k/core.h: patch does not apply
> error: patch failed: drivers/net/wireless/ath/ath12k/debug.h:33
> error: drivers/net/wireless/ath/ath12k/debug.h: patch does not apply
> error: patch failed: drivers/net/wireless/ath/ath12k/mac.c:13
> error: drivers/net/wireless/ath/ath12k/mac.c: patch does not apply
> error: patch failed: drivers/net/wireless/ath/ath12k/wmi.c:7150
> error: drivers/net/wireless/ath/ath12k/wmi.c: patch does not apply
> Patch failed at 0003 wifi: ath12k: add factory test mode support
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> 
> And since you'll be submitting in 2025, don't forget to update
> copyrights.
> 
> 

Make sure to review all the changes that Kalle made locally to the pending
version and incorporate those.

/jeff

