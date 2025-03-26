Return-Path: <linux-wireless+bounces-20862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFF8A72074
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 22:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7AA1897113
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 21:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A515D1A2541;
	Wed, 26 Mar 2025 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="USaMbtdc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB449659
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 21:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743023320; cv=none; b=OaXBqWqip1vghlG57RZJKnnLUy5RR2lh6ljneivpteGCPcmIFzcmThzESIvqYZdB9ETExsiuB+aRRG9oqerrVrAPuV8u3KWlOpskU0pgMslzTDOer2hl2jq197jQhu90Gbh2KKS1vzDz1LHrD1Ff4QUDi4QapAtozZvI/WZjrLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743023320; c=relaxed/simple;
	bh=A6SLxFzUTh1gCOa25P7EjdgAVNgNLr/HqsSTIaRREyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXlnXReY4D9GNic2SSneJhDnnPqi3vRCeGRykKIjxZFOH0Vfilm2TwDXXf4MABfC1Yjys84cGDM5qtQ1zeWc+bi1WyGG5S23kqGWBb1PVc+4vARLOKfZqiiSi3nsSdq1cDgnGMm9jzACl0l6CHnGIncG1J2epYlIIDqLDL3Uh9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=USaMbtdc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QK2bF3025444
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 21:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LFSW+y+O3hp9uRAbVlBqXUI5+0dk9owsM69HnTAbWDw=; b=USaMbtdc8BMrTXS5
	d5cWpu8TjWojCO5RljFpSz4vBv45OUTfO29Yf4RCkZwI7ambwxKMUlz5iLo4BmYm
	ywsAzZ/whMU+vaOchody50q7ugaT/H4Yfv3PZ6H1tij+y0jm/SW0TudP/gCGJxKp
	J5ikHg80RbWhCmLOAudFQqiOxsOPAl7r3kjm0U+vlKLp9eHJLhE4CFKngKbwbU9+
	G6Vb+NXt5o1g5WBEfq7CJQbam0iP7f3ACLESG+Lt29tI/P/GmqzCw2NFlqYOt14X
	LG35fMnnDDKkKMOGQbk1HSp8IgqmRfSQYRbNGzTC3neFYFy3tFuX6XolubzAJ0o6
	qWR5GA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45mffchu21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 21:08:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff799be8f5so351443a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 14:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743023316; x=1743628116;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFSW+y+O3hp9uRAbVlBqXUI5+0dk9owsM69HnTAbWDw=;
        b=og0MkfgLnC0n56emJebgAGazTgps23Cc0LdMTF/j5HKIiNPvEdAhBKA7/okVw5XzZ4
         xktL4UzKeePDTSjXr9X0PGPW6fSq8XqJQXe6wWYOnuw53FIoFiFkQEs2DCjFF9GbRNfh
         aINSF4ikAvcZSZ4sz4fvn/FCqbjs4R8LR4YxyAk1onvU3XIkIXlKDbxv35YWqaqRPNWv
         l5FrLyk741Umxmtx6rl84H6yY7Wrc1R479A5C6hnNIhjjg69Fi9L9LLLejzK10px3gRz
         g5NE0KeoiNXM7LCSHTlF6vkQYYJCawDV7JTv5rF4R6zJ4np4yqwjrfezJ84zi76IL0wF
         j+Ng==
X-Gm-Message-State: AOJu0YwH8hy+p1zOj10tqHUYHhsWUfj48iMsPUMT3G4r3JSamxywM4k2
	moTg1cjVu8ef1w9Y/WomLDGvggups1j6xMP5KgoxLR4KK6CMKmhHPy6QXbJu1CwCNpuF4ocH0NR
	LeMmfHHjKNb0n5Ri2lEw3gtbyT7NRs+Xa8yrOqVRYxD/5kaKWBX6kIDG9vd78KjIAWw==
X-Gm-Gg: ASbGncsbNC9JG2K0lDD+OlM98fg/eOvkERS3g2otQjgLsHlhUrLtmq8dhJRLPH4C/Y3
	GzfQPbjtVrxUPZIVSQW8Bi4/ruk5cBrpSZd6Iv2OeDtDsoAIeaXS0hNqJ8NYUAvzHK7HFHe681y
	z8PxlE5EzPyquv7e5Vc/ZT2hn4MkLaGJ9plvyxQKit5glLMaP4zob3wcFnYKW1ddLSoWrQv1M3P
	duzyKmPORNVj1w4Qis0DA6z4M0QfzIhmPPQqB24uUBKz3Mi9xtqbPtOBXJGXjaQr8+VM6UDKOfh
	Yqn6uqdkL4JliyQuLiwPTCoDarBUqIyFlu2XrWRcGNjvA4vTbh3uGN8gRg2eVKJEnzo98t+YVhc
	sYzEkAxOz
X-Received: by 2002:a17:90b:3b52:b0:2fe:8282:cb9d with SMTP id 98e67ed59e1d1-303a906c3f1mr1702249a91.28.1743023315577;
        Wed, 26 Mar 2025 14:08:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWDNLjHocTdVUP2kL0YyRGZP3qzCAY7FwNZE9w5sWivK1L1uAaiVSgQwqo4kMozQ+ZzqF+mg==
X-Received: by 2002:a17:90b:3b52:b0:2fe:8282:cb9d with SMTP id 98e67ed59e1d1-303a906c3f1mr1702200a91.28.1743023314886;
        Wed, 26 Mar 2025 14:08:34 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039dfd3851sm722007a91.1.2025.03.26.14.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 14:08:34 -0700 (PDT)
Message-ID: <e7776b2f-56b5-4024-b878-13053e57227d@oss.qualcomm.com>
Date: Wed, 26 Mar 2025 14:08:33 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v12 0/4] wifi: ath12k: add 11d scan offload
 support and handle country code for WCN7850
To: kangyang <quic_kangyang@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250321084518.1619-1-quic_kangyang@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250321084518.1619-1-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=CdgI5Krl c=1 sm=1 tr=0 ts=67e46cd5 cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=uhMqMWLRpLrNCD56NxgA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: vBd2ZdisnSCtxMp6UBY8RlXHWmjDbPAF
X-Proofpoint-ORIG-GUID: vBd2ZdisnSCtxMp6UBY8RlXHWmjDbPAF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_09,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503260129

On 3/21/2025 1:45 AM, kangyang wrote:
> From: Kang Yang <quic_kangyang@quicinc.com>
> 
> This patch-set mainly does four things:
> 1. Add handler to send WMI_SET_CURRENT_COUNTRY_CMDID to firmware.
> 2. Use WMI_SET_CURRENT_COUNTRY_CMDID to set country code for WCN7850.
> 3. Implement 11d scan offload, and update new channel list to firmware
> when 11d scan finished.
> 4. Store country code, and update it to firmware after device recovery.
> 
> With this patch-set, WCN7850 can do 11d offload scan and update country
> code to firmware successfully.
> 
> Note: This patch-set is an old patch-set in public review written by
> Wen Gong. Just resend it for him.
> Link: https://patchwork.kernel.org/project/linux-wireless/cover/20230914090746.23560-1-quic_wgong@quicinc.com/
> 
> v12:
>     1. add reviewed-by tag.
>     2. rebase on tag: ath-202503172347.
> v11:
>     1. swap the order of patch #2 and #3.
>     2. rebase on tag:ath/main(ath-202502181756).
> v10: rebase on tag: ath/main(ath-202502111625).
> v9: update copy right in patch #1, #2, #3.
> v8: rebase on tag: ath/main(ath-202501172342).
> v7:
>     1. rebase on tag: ath/main(ath-202412191756).
>     2. rewrite commit message for patch#2.
> v6: rebase on tag: ath/main(ath-202410161539).
> v5: rebase on tag: ath/main(ath-202410111606).
> v4: rebase on tag: ath-202410072115.
> v3:
>     1. use wiphy::mtx lock instead of adding a new lock(patch#2).
>     2. rename struct according to wmi naming convention(patch#1, #2).
>     3. update copyright in reg.h
>     4. modifiy patch#3, #4 due to struct name change.
> v2: change per Jeff.
>     1. change alpha2 length from 3 to 2.
>     2. change wmi_11d_new_cc_ev to wmi_11d_new_cc_event.
> 
> Wen Gong (4):
>   wifi: ath12k: add configure country code for WCN7850
>   wifi: ath12k: use correct WMI command to set country code for WCN7850
>   wifi: ath12k: add 11d scan offload support
>   wifi: ath12k: store and send country code to firmware after recovery
> 
>  drivers/net/wireless/ath/ath12k/core.c |  34 ++++-
>  drivers/net/wireless/ath/ath12k/core.h |  17 +++
>  drivers/net/wireless/ath/ath12k/hw.c   |   8 +-
>  drivers/net/wireless/ath/ath12k/hw.h   |   3 +-
>  drivers/net/wireless/ath/ath12k/mac.c  | 167 ++++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/mac.h  |   7 ++
>  drivers/net/wireless/ath/ath12k/reg.c  |  72 ++++++++---
>  drivers/net/wireless/ath/ath12k/reg.h  |   2 +-
>  drivers/net/wireless/ath/ath12k/wmi.c  | 158 ++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/wmi.h  |  38 ++++++
>  10 files changed, 482 insertions(+), 24 deletions(-)
> 
> 
> base-commit: b6f473c96421b8b451a8df8ccb620bcd71d4b3f4

This series no longer applies, please rebase.

