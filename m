Return-Path: <linux-wireless+bounces-21009-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34340A771DB
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 02:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB131668CC
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 00:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCE9BA33;
	Tue,  1 Apr 2025 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CgHsKl7F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEAB2110
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 00:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743467181; cv=none; b=f5M4xzcjMx4CVkKyREWPT+5DYCfoJwe8wdNfyiuD45anyLbHuUAwAVMXcHtSo9ev45U3rp6+NOtw0eJzvzo0qmvwTeibteoYhjnryLIcGU0XG985wxzglIYzVXDfQlQqhydxfG0lkXmDtUXAVLlOa02Nn6tgIdMx2AIWf4rfZoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743467181; c=relaxed/simple;
	bh=ZQoNzf9RJ9w6Lkjo3s7/Z0/1OXLRPTLMIOq2+w84wOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjTzMEMYWUS7brH7XdAS1+25jFo4WNZog4YrQyTVEskySDxANTZo5jEuLLSbzp2Yk0frAD4CLH1NMDV37XwKAU62mSM1zCUffK/vJmxLfSaujDie6vk1zfc03XsEkEIG26/1WEq/Bm1Bc69UNKXIjMDGgQrGiOKJTUoAsiDZfA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CgHsKl7F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VFCqnc025623
	for <linux-wireless@vger.kernel.org>; Tue, 1 Apr 2025 00:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nj98MI/Ht+TuXfUcrmfWsvc4nni4nX6/r0YOfJeFQ2Q=; b=CgHsKl7Fdn/Qzyl3
	hDaCLuKCRQnNGonBVJc+/rWIZj6e/F5p591B9UJOib1BXswWdVZ2wv2aHJxfm+bM
	pa1j3kaaj0kZj+ThqZmaZTjH/BQMnbQpvNfAnvkJBxCOePwbXT5yQBVS5WjAppGB
	3yq+tscgzeX8fJ6YS5LZy+1ccp/17MsoaLiWL8vFo0MTuYpmHqTg2l21QSuf7JA0
	vIT7pZQDmdHchFnGMvGN10Z8/t7bTynzaNnRHBJZsP4Jjgn9s45PVDvnn+53rQhP
	p6rq1JtzD2Mro/S1pvhfkST8UI4vaJnNpvK/2OOYbFHXMHpWfWE3Dt6cabM29sNS
	w9M94w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p6jhp5n2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 01 Apr 2025 00:26:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff69646218so15030375a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 17:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743467177; x=1744071977;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nj98MI/Ht+TuXfUcrmfWsvc4nni4nX6/r0YOfJeFQ2Q=;
        b=oxx3GYGu+3lopDLi1h79eorTzhQHUReVLNEtmAoNlwPCXZohunL53Ro7TYU9EVFPE2
         JngKuEyaIQwfhjX+wiEOBIVrdcadulP31GnqzEJycN49fpDi0ENYFh/xM04bgLvnml4v
         rBLJB+/tqUGcW2xvw93qtSv32u8s8IYhnKsB1z5EoYD1gQZMayYzn2m5oSbU/5+9dt4s
         pYsAGw1lnqEYV4Qfkxd0Cyksl5A5/g1MlzODkI0tTl506Xk+Ydj0A8mSfrmdoA+/yRA9
         StNha1Drw0TeFbKcwslRZEPd1egE30z3UvoEEV88DWydlTRei8fITMBSiXrsGHWMmJyN
         u6tA==
X-Gm-Message-State: AOJu0YxkCrgifmkJEb4FOk+tCMoS4iJrlcg0ndxwKUSHhWIDvJw1sxFL
	lqzFcC8iflyjmKBMcRqQCDPElyuhS2s7mqglVPphdtM988Ju9p9s2DGsM1cofjHRHSHpk5uKhrC
	pIl87583D5dgLHRBALNQc11+WshNzv5GQ2vSANYAzG0Dk/7+P6OPcdpkI8ZEiCbPQLw==
X-Gm-Gg: ASbGnctqs0qYnsKFjF9A8sbpcCxCPSBgR52WiwD7wkRso4YaCWlYUP98gDK31pmwaXW
	afADi9OdNC6T0J15nojA3HH78KDfNQrwCjyWRDqiNke1543kHMIyYuk1gwxQp9M3sJf7FbHBJyk
	VDl+0j0gxl8TnHfQjg26aFn2+5d9TcvkRk3KCVjid/QJojLn/w7Fdt1FqB3PflkktWwsX16qqVN
	FA9kUp7im6mQoEhMrVRBg/soVghO33xUkrn8sasFoYo7B/+hIrxR5TTlgHeg58+AHq4w8+dToX2
	QdvpN3W2zpqGmsKRm3kgs/upNSnLAQSB5usSGft5EMXEP8abiXxSKEs5icCTscmB8eIEEcNkPgV
	dqJwrL7BG
X-Received: by 2002:a05:6a20:43a3:b0:1f5:8a1d:3904 with SMTP id adf61e73a8af0-2009f5bbad3mr20583410637.7.1743467176624;
        Mon, 31 Mar 2025 17:26:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx/aNjQmQG10wCwYwIB/c1wC1UJUayWNouRXjgmxojMWIKHkdkoMaR/aYPo2i9WrRTdbMBJw==
X-Received: by 2002:a05:6a20:43a3:b0:1f5:8a1d:3904 with SMTP id adf61e73a8af0-2009f5bbad3mr20583378637.7.1743467176236;
        Mon, 31 Mar 2025 17:26:16 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93b8b4141sm6952697a12.51.2025.03.31.17.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 17:26:15 -0700 (PDT)
Message-ID: <f5129046-4034-43db-8ca0-05b5c27e1d1e@oss.qualcomm.com>
Date: Mon, 31 Mar 2025 17:26:14 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v14 0/4] wifi: ath12k: add 11d scan offload
 support and handle country code for WCN7850
To: Kang Yang <quic_kangyang@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250327020527.1527-1-quic_kangyang@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250327020527.1527-1-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: eowv0OJlVMnkgoglCBc71JPebrPzyjZl
X-Proofpoint-ORIG-GUID: eowv0OJlVMnkgoglCBc71JPebrPzyjZl
X-Authority-Analysis: v=2.4 cv=bZZrUPPB c=1 sm=1 tr=0 ts=67eb32a9 cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=hbj1clWKTLgvv7SpeOkA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_11,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504010001

On 3/26/2025 7:05 PM, Kang Yang wrote:
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
> v14: add branch tag.
> v13: rebase on tag: ath/main(ath-202503251458).
> v12:
>     1. add reviewed-by tag.
>     2. add branch tag.
>     3. rebase on tag: ath-202503172347.
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
>  drivers/net/wireless/ath/ath12k/hw.c   |   6 +
>  drivers/net/wireless/ath/ath12k/hw.h   |   1 +
>  drivers/net/wireless/ath/ath12k/mac.c  | 167 ++++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/mac.h  |   7 ++
>  drivers/net/wireless/ath/ath12k/reg.c  |  72 ++++++++---
>  drivers/net/wireless/ath/ath12k/reg.h  |   2 +-
>  drivers/net/wireless/ath/ath12k/wmi.c  | 158 ++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/wmi.h  |  38 ++++++
>  10 files changed, 480 insertions(+), 22 deletions(-)
> 
> 
> base-commit: 11cea2b6a2e3a5ddf3562314d1a378e7ea1c26eb

please rebase again, does not apply on ath-202503312147

Applying: wifi: ath12k: add configure country code for WCN7850
Using index info to reconstruct a base tree...
M       drivers/net/wireless/ath/ath12k/wmi.c
M       drivers/net/wireless/ath/ath12k/wmi.h
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath12k/wmi.h
Auto-merging drivers/net/wireless/ath/ath12k/wmi.c
Applying: wifi: ath12k: use correct WMI command to set country code for WCN7850
Applying: wifi: ath12k: add 11d scan offload support
Using index info to reconstruct a base tree...
M       drivers/net/wireless/ath/ath12k/core.c
M       drivers/net/wireless/ath/ath12k/core.h
M       drivers/net/wireless/ath/ath12k/mac.c
M       drivers/net/wireless/ath/ath12k/wmi.c
M       drivers/net/wireless/ath/ath12k/wmi.h
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath12k/wmi.h
Auto-merging drivers/net/wireless/ath/ath12k/wmi.c
Auto-merging drivers/net/wireless/ath/ath12k/mac.c
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/mac.c
Auto-merging drivers/net/wireless/ath/ath12k/core.h
Auto-merging drivers/net/wireless/ath/ath12k/core.c
Recorded preimage for 'drivers/net/wireless/ath/ath12k/mac.c'
error: Failed to merge in the changes.
Patch failed at 0003 wifi: ath12k: add 11d scan offload support


