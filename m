Return-Path: <linux-wireless+bounces-21248-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB599A7F4B6
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 08:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82FB3B5916
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 06:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789D725FA09;
	Tue,  8 Apr 2025 06:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FH9eK1Pl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC98225EFB8
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092457; cv=none; b=Ba67O65kK4B71Tt9LhtLuj3CAK6SppQC6ECUkqrc9ym1vrMeDzNwEcilwK92IntUuSBC9RL+R8IWAMyGvZYkuT0bShPeYFLM+ysAGrzvrSI7seulkwFKpLyIGsUOfCXgCDTecUusdFDwkYPeEwAoUnMOWD7y153OHmPwavqVYfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092457; c=relaxed/simple;
	bh=hfpnCLCaLXnBZlzRrE7zqqhlUK6fAnXbACeM5+PAZQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPuhFuzeTOGPMIZN9rhy+e5ATb1dCuuJYufELHOElFQ6Q6TOR13rXfy4TmQk77XidASO3iy9fhPnN7oDOZtrWrmS02vBKacIsywMcFEYbOmgTxXf3bp0G36CTH0i1It33CwevOj19r9HLPVijXe7J55vHne/2lJBDC5wp07e8XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FH9eK1Pl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GOMY032623
	for <linux-wireless@vger.kernel.org>; Tue, 8 Apr 2025 06:07:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g+93NX7hMLFSwrHGefljN7u3jVdkUJtzM3/NQSF70tM=; b=FH9eK1PlLeR81dJ5
	o1nKATUVNjm0+ggtb6nAazqwLYI3M6psFnt8QnYtSaqZJHFN+Gm6OBC/WnASZnAo
	cEgk5nNNYclYor2RZCwmiqbkr7iaSFov1ICHaCicl+AbRMaWrJSCDmwO0WYxpapa
	hwJQCnq0FgVSk/SFAREJLswUwK9NmhIIoZEKG35HJQHm59xDQK5INma5qMoHg25r
	Gg0sXqfVd30VKFbf3nE99HJpN0jHL4uUYajffTJcLSyF6BvnzvhULXeK2mAN/+wb
	T42v5/QCks7TX5eHplvIl6CmMluiuepXo7QtGXwW2432FVcwgKsA/MEeRQajvo+/
	c+SEQA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twfkejwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Apr 2025 06:07:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-225974c6272so38852175ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 23:07:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744092453; x=1744697253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+93NX7hMLFSwrHGefljN7u3jVdkUJtzM3/NQSF70tM=;
        b=WrRSy3AOrSFCWoh3TDDPsXtDpGKzVLp59APZg1mpi2lhCmNJE/pxXjJ/nahMLnQWhb
         SiOOS0ZFZv8OGl1GOp7SxW189MGKYtJPjL91IprGEPOaBJEBGiokV7iCQhMGUJOyZpYt
         NtrfRM+RALR5/Ipy192ikpT9f0ht3ifR4oCtdoIjAJwabLc//OtE1Jq3nXlRb/C2IQQY
         28VQJ7Q6GMqXhzHB0yapeuPeNADYktb+CZPIeT41XKcrmYiiPEvH5uqcphdB+MSZk7Hq
         lA6GaRl+wn2WYEONqrxHmm0TAxe1Dt6TO4avvP8LeO+lnwovwDk+SdxQ3VAai7sRUSl2
         atDw==
X-Gm-Message-State: AOJu0YwluuPTxXDL44hvG8vX5nbwxmfO+etgYJ6tsfBm9QeP+jEtXkDA
	AzSuXeBb/+++JdLBNJdiO+22BN9712gT1hXDpN21IOOIbvhkNf7qamilqyE3/yQMQ39AHxZVarD
	sCOCo6dPWl2VdzA0fxTYP1XXkUJAA5F2iJqSKz2BfPtjXYkQUT39q01p2a6VC5ZkCbI95t+BsNA
	==
X-Gm-Gg: ASbGncu5vjMWf38hH0imc5n0gnlUAvpv8JnFcUCEjvx+mXoOITbL8ETDYAKSz0X3TEW
	wtc2mHDgpNFswomdEviUc2LtyYB7OXGVrFSUd8PNR57Y7X+S4A+C5B37zKiaP3Qs2wHEHGfO0jP
	0vlhsdl6iyKFsH6G/mjV2WWMNwixIteZgbXIJS81Vt2mYhkZToGohqdLZ7MptKUkNZZLEAmAXzp
	oNBi3bG7e5utv8JR6FLJBaPvaMELba9PTwZpfCAUohA1hd2ehnGcZGd5IfG9GVj9qwYLG1e8/6X
	0LdyZTL857p9GOBAO4KTld1TqiO3+RzsSqZ9SmY=
X-Received: by 2002:a17:903:2acc:b0:223:fb95:b019 with SMTP id d9443c01a7336-22ab5eaa5a3mr34537455ad.24.1744092453076;
        Mon, 07 Apr 2025 23:07:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWKEZ4KRDBQDRBa0q5215GWlCqu+MFm9EVeC8sjd5ksd8QKaPKRbsG34GB3NFoOzk58Qx1tA==
X-Received: by 2002:a17:903:2acc:b0:223:fb95:b019 with SMTP id d9443c01a7336-22ab5eaa5a3mr34537075ad.24.1744092452644;
        Mon, 07 Apr 2025 23:07:32 -0700 (PDT)
Received: from [10.152.200.95] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e1bfsm92058025ad.168.2025.04.07.23.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Apr 2025 23:07:32 -0700 (PDT)
Message-ID: <d97d8fa3-36d9-435f-9efd-e71f8f1fbab4@oss.qualcomm.com>
Date: Tue, 8 Apr 2025 11:37:13 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 0/4] wifi: ath12k: Fix multicast memory leak in
 tx path
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        P Praneesh <praneesh.p@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250402181454.2699777-1-praneesh.p@oss.qualcomm.com>
 <406a43b8-10ad-4bb2-b27b-e97bb1c992b0@oss.qualcomm.com>
Content-Language: en-US
From: Praneesh P <praneesh.p@oss.qualcomm.com>
In-Reply-To: <406a43b8-10ad-4bb2-b27b-e97bb1c992b0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 81pixuJohjGiMJeIZ2O37aB-lpWfEJk6
X-Proofpoint-ORIG-GUID: 81pixuJohjGiMJeIZ2O37aB-lpWfEJk6
X-Authority-Analysis: v=2.4 cv=b7Oy4sGx c=1 sm=1 tr=0 ts=67f4bd26 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=O_1ZbGT33wkLeJ7M5ggA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_02,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 mlxlogscore=732 bulkscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080042



On 4/7/2025 10:46 PM, Jeff Johnson wrote:
> On 4/2/2025 11:14 AM, P Praneesh wrote:
>> Address the memory leak caused by extended skb allocation observed during
>> multicast transmission in this series.
>>
>> P Praneesh (4):
>>    wifi: ath12k: Handle error cases during extended skb allocation
>>    wifi: ath12k: Refactor tx descriptor handling in tx completion handler
>>    wifi: ath12k: Fix memory leak during extended skb allocation
>>    wifi: ath12k: Use skb->len for dma_unmap_single() length parameter
>>
>>   drivers/net/wireless/ath/ath12k/dp.c    | 10 ++-
>>   drivers/net/wireless/ath/ath12k/dp.h    |  7 ++
>>   drivers/net/wireless/ath/ath12k/dp_tx.c | 87 ++++++++++++++-----------
>>   3 files changed, 64 insertions(+), 40 deletions(-)
>>
>>
>> base-commit: ba613742db305037ca2193b2b552b769c4f2a5f7
> 
> Please rebase to current ath/main
> 
> Applying: wifi: ath12k: Handle error cases during extended skb allocation
> Applying: wifi: ath12k: Refactor tx descriptor handling in tx completion handler
> Using index info to reconstruct a base tree...
> M       drivers/net/wireless/ath/ath12k/dp.h
> M       drivers/net/wireless/ath/ath12k/dp_tx.c
> Falling back to patching base and 3-way merge...
> Auto-merging drivers/net/wireless/ath/ath12k/dp_tx.c
> CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/dp_tx.c
> Auto-merging drivers/net/wireless/ath/ath12k/dp.h
> Recorded preimage for 'drivers/net/wireless/ath/ath12k/dp_tx.c'
> error: Failed to merge in the changes.
> Patch failed at 0002 wifi: ath12k: Refactor tx descriptor handling in tx completion handler
> 
> /jeff
> 
Sure, I'll rebase to the TOT and send the next version.


