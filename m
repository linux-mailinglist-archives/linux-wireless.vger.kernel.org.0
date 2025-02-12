Return-Path: <linux-wireless+bounces-18862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412CFA32CFC
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 18:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4CD162FC8
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 17:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EEE25D53C;
	Wed, 12 Feb 2025 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="clbcZAH0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D9025C70E
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379942; cv=none; b=apThbNu1ZsZcYvkWXmkJfPPudObDHCXV5IjjY/SXnGbFikgC8cOHBJW+MVOHRVd5F0Y9nF2RXlJg1IxkbNntNdnuRMUKSI3WvacJyUuY/c16EOg/+kl9L2rLTVr3SBHWYaf2Rm3rFMYsdkG413VlbpZHATSP0WTH6NaP2QEilpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379942; c=relaxed/simple;
	bh=H7tXEj1NdQHAKyqV8cpiuL0FVc3yiVn9AC7w16MT164=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8DfAmhfFJVQ7XGca7s5W9UIb2URefauJ4WqhVtFypLD+fbZ0TkNTFegomMyJW8KGcfqIYzW8fEVNEHYSvi+3YrVdQWuF3LtIbAwW2s6MA7xLS4HD8sEddCJsYpJ2MRqn8qxAlSr/132QgguiDVYdw1gMiQqvRD5tIKUGV8XRIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=clbcZAH0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C91vEF001366
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 17:05:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vnd0+ycBfQNPMC4oWZS4BXvKfWaH6/W1TyXhpqePNEQ=; b=clbcZAH0NjrgUDpd
	mRkzYwrySfK/E+3reVbcB3wjPAiuo2Z9jsNwG70COQE104N4jbx3wcfOSX2RRWic
	qT/49HcQVdqRCGYgp4+D2ipcQS7YrIzZd7zdkToQElA1hkkbZ33HQz9xkNhhMmd3
	OnHtCBUwd2NLZx9Rx++j8A84vGtbLPi2s+Rbx5vqZ8QsRZQBujWpVkUwBGtF1RTI
	yW0OrZytnbakYq/h9AfHeQW7neUMckugji3eAvEtcVqtIn7Ymvfnk0E6jalH9M8q
	2qsfBvzOUeozzo1H3Hwapq+llkGZW7Ek51ZhSJ9qa7x2AXsK1mssUCMeungcD2he
	B5kV4A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44rrnfs8g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 17:05:39 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2f9da17946fso6904a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 09:05:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379938; x=1739984738;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnd0+ycBfQNPMC4oWZS4BXvKfWaH6/W1TyXhpqePNEQ=;
        b=G1bj4EjMRuohhcW+7MWF1XcF3qtXM/73kTmEELFC8MS9tblZl4xrkhCbJIZdYLzSja
         ilEuYAvE6VMQp+ktEbkrtzS9C+ktHJlkHlu7FtYlXvO2f42zS/EoPSaQlvdZR3CBLaJK
         9h/9vhEEpINmyKWjpAUSrGf+D69ECaGk2N8d/+vDZuvf3ksMm/8DtD0Ocz/xyR+PytEr
         r9Gajz5jB/DGWUUYMuqEDOV0lJg/NM2bBcrUY1ZPIc1FPfnPNz45XSVn1xFQ9tVcbI7A
         lglDxVd8Ab2POWsNYzWWeIoCCTKsowYgaK3DRkryv/a9Jj6CcrAQMxhAdTC7akxwTksR
         E7WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgX0XhcSYCCb22f6i9QbnyULSxgOD125nGl7o3YLBLljJaQtQKC46o755QXQWqjACysJEww88st/2GPcTUag==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHrWpVtzCOX1+DSid7tFlk0Y68auUreWIx6uZEqyAc8r8oFUpM
	68UcSWs3lvSTbSqmkNbrKGUO1yMD4RC8Ion7Q4sO6xIpXdz1g1RaRkuNnmKfYOzqwXK/2AD77f3
	LOi213SKdQQPSHBwKY6YKOqpXz3cYsjdtXAn+DfnCmHWZ9XmTTfqgPe3MK/O+qagLAQ==
X-Gm-Gg: ASbGncukaN7jG8BJZGDMc4iELXTjLdU9dNnWOfaT2rGY/XWBDFBXxtVClQ7S+JuaKdW
	u+DkDdz1TrikqJiLjg/Uoy/GCZ2CovQkmbFYXcVipTw/UFFC+2TxnOxDaAV6wRw9YwHLK88LMoL
	zBMo4G42iYSYJOhYUPdE8OVx9WGhx+bEO3gtkk6TSaq9yrbUDQprJgwGINUFQADuhkFsl6ZpEDH
	A6jHNFvjx0GctGR71r+f3VK0jc2L2CJkTo46SaUgXnR8dgS6M6/EpTW6Gl8hraLAUUyE7gG9tzq
	yHtj91LQu/Y4VxpisJy5Kj4ml6PvYHnA2/aB/S0iq83vhtTEDiqd1eFMPcPV
X-Received: by 2002:a17:90a:c912:b0:2fc:b40:339a with SMTP id 98e67ed59e1d1-2fc0b403555mr1491481a91.10.1739379938114;
        Wed, 12 Feb 2025 09:05:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUt2lq1oFlB4bsT3D4UF+HoAa24Rkzxvgc6j4DJgkutmH/tUKFc2bhFS2x5A06AoQXeC1Oig==
X-Received: by 2002:a17:90a:c912:b0:2fc:b40:339a with SMTP id 98e67ed59e1d1-2fc0b403555mr1491259a91.10.1739379936213;
        Wed, 12 Feb 2025 09:05:36 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98d05cesm1746598a91.18.2025.02.12.09.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 09:05:35 -0800 (PST)
Message-ID: <f7f9d508-e999-4e5c-b02f-976e7cb700f3@oss.qualcomm.com>
Date: Wed, 12 Feb 2025 09:05:34 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Fix uninitialized variable and remove goto
To: Ping-Ke Shih <pkshih@realtek.com>,
        Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Kalle Valo <kvalo@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
References: <20250209-ath12k-uninit-v1-1-afc8005847be@ethancedwards.com>
 <a7ca4e4b-c432-4f2b-81c6-c7b06cd12de1@oss.qualcomm.com>
 <mmutvwbsr3h33hxr364zr6f3whmyxp73od3fihsbynek2pkvjd@6bqaqfkwkf4m>
 <94ddba7eff9f4261bf8fa547f1ba4d7d@realtek.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <94ddba7eff9f4261bf8fa547f1ba4d7d@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: SB3Tmtuk1J3v8FRP67NQWim_cuktZvt2
X-Proofpoint-ORIG-GUID: SB3Tmtuk1J3v8FRP67NQWim_cuktZvt2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=926 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120125

On 2/10/2025 8:09 PM, Ping-Ke Shih wrote:
>>>>
>>>> Addresses-Coverity-ID: 1642337 ("Uninitialized scalar variable")
>>>
>>> Is that an official kernel tag? IMO the proper tag would be
>> So, it isn't "official" as far as I can tell, but it is widely used in
>> other commits, especially by Gustavo Silva.
>>
>> Also:
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=778e2478d19574508861bcb
>> 1806d6e34d095587c
>>
>> Coverity-IDs: is another option I have found. I have seen Closes: a few
>> times as well. I'm not really sure what the best option is, honestly.
> 
> In my patch, I used and treated Addresses-Coverity-ID as a unofficial tag,
> so additional empty line is added.
> 
> Days ago I have received Coverity issues sent to mailing list, so I used
> Closes tag at that time. But recently I have not seen that kind of mails. 
> Instead, I visit Coverity web site to check issues and use
> Addresses-Coverity-ID tag, since Coverity link is not visible to everyone.
> That is just my thought. 

The problem I have is that I get Coverity fixes both from the linux and the
linux-next projects:

https://scan.coverity.com/projects/linux?tab=overview
https://scan.coverity.com/projects/linux-next-weekly-scan?tab=overview

The Coverity IDs from these projects are allocated independently, so a
Coverity ID does not uniquely identify an issue.

The URL uniquely identifies an issue, and also utilizes an official tag.

That is my thought.

/jeff

