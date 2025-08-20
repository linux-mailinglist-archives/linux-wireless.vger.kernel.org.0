Return-Path: <linux-wireless+bounces-26467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D3EB2D32C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 06:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D14352A1B85
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 04:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF802343C0;
	Wed, 20 Aug 2025 04:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dfi4XGWf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC94D220F38
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 04:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755665425; cv=none; b=DGB5RqZk8PxnDT++zwORBrk96FMtsIiMZydLiJvimcJUC8pi/MVQfFx2GeperJPFYbsIztGiJ855R9x3N5UjZhr0Rg4RoRsUMbqxq7GX94rLnyGK2PKAqFqHyiCkZ9TcpKxhJ5G6LlN87V0OrVOKYjyiVFbpPk5jidlcmf64suY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755665425; c=relaxed/simple;
	bh=J7aLxptPdAHoKwvJG7I9ECgnt1g8HKEMrF5XFFZI/HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l2tt2EduJArEydGexTqLUA2804r6jfTbceWTujoD3O5bPmnblxhrsQStk8l+4oFT9ICB4ALCwUUe8HevkaNTxKW//r6vPS9vI2mCBDGylLaZUXhMEwhBqGWrqVDPe08DnclTXuaP1KR3q8ArldzNNxZR2FKwGGaH5cvvUQFc0K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dfi4XGWf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1q5RB026721
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 04:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0Kc49WKRfQ4kJFiTDPrjxF5cfNocY22jjwu3rJcPr9o=; b=Dfi4XGWfJgkBaS8L
	1MHQ2yR7KWpV5xia3dkv3XT1KEPFLiH5+DN8ItE+QSzngi1GE2UKxBqTQxQCdN61
	z2XdE7OYhkE8Hqwq6bz2MrqrfEDh1tEgjEk35O7lxZJ21jGggKM36OG3FPdhhw6H
	lGu7ndg9nO6OfmAyjYorKd6SWrHZnXMXnyBOZnKn+B7l6acC+9JF81XHi0D/0PmE
	vYU9Z7glBHBaM0RCUzBt/iqv00nfqyhlXJJIrE6u5kBiB/faFMNrxHSeNauO/T9v
	EP33Ow+4zw45ZXrCk27NiUkjgVGG8uT5iIG4VSZ6h0wfBkPoGYtEMerldnkd9dGw
	se1d+Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5290djm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 04:50:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-323267858edso6135038a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 21:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755665422; x=1756270222;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Kc49WKRfQ4kJFiTDPrjxF5cfNocY22jjwu3rJcPr9o=;
        b=QTdVRgR6mOc2orNDYwIRsEiPTqOYveIUBwsiedzezYdPDdViMxPRT0mk2s/YxnqBsD
         dqKPGVFhA5ZHDaxje4i6Iu2d8rAOUn+C7/SEG7KUJUrYJYXkn/SVceJio0gvGHsJk2Zm
         AN2/8lEWdjT02Ur8+mUW6ikh1HuhvDRyE/Sh0ijAuslBQp2KUWcYIVDX7jLEiHR2NqA+
         T/6/eiyc7LWxoEEUW3QUUOyYkd6wolmiekd8IyEE/rQ3jsGi+Qn0fklu+YwZzK6SXEjF
         Tzy50jb+Vo2punA6/8Lt7lNh+gE2HgY8bd2O3t9V8g9vvcFGSIaMVE33IXcytQ9gaVEB
         vvCw==
X-Gm-Message-State: AOJu0YwaFDQxUHEZC/FqGXysWqCYshlMzJ6DBj51WE3/ievASULanJRz
	qNOljByE1Lm9QUN4bxe3WE8QLV57MjezKyNTgTrNAHd/9p1Gd6aT6ssirFTSdebCkfgrYk1SHOb
	UWJjm8DZxGDK1JkhsCQb/j1EwjwIfATGfcKDXIUEOLJqfNGYHYVSpfGHVE0q4rqRSpG2bww==
X-Gm-Gg: ASbGncvcg6XOHeP9HR+hlGrOiZMsZHgU8oKpHdjcWkDZvQZJWWm95k1iHHPjRPL2DC1
	LATAaoQooCgUziv5LPzpV7FCbtczglc0XYDcLS5d+utlwX1o2JKDYBlVaqtgdbCw4Og06phJkKn
	JNFm8MH9H2+jImsbHuKEqWsl440K1zy7847ZcnnodKpj3Q8fnVoQbccqvAg9EC6xz/GfFt490i3
	UIfVS4Yc3GQ/TeG07aNMHtwyeJJDVA5lWX92lbQA58/a6RwURSr4kh+h5FqxGIWGi8cBTMuTmni
	+MgmE8WfgG4FWgQPzcfe3xOjKXWg1YfD9w3C/MApGqWROTSkfE1nFrNuBg+E9AuV27KXds9vlDb
	HPGFOjzqzVMw=
X-Received: by 2002:a17:90b:544b:b0:321:c53c:4e70 with SMTP id 98e67ed59e1d1-324e13ad075mr2012971a91.9.1755665421904;
        Tue, 19 Aug 2025 21:50:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHXwTl3vuHw5N7Y7UmHDVAzbnaYw56yh4QKooZ0Q9HtRnfRB72ym+zdhguStg8z/KgZ+gRMQ==
X-Received: by 2002:a17:90b:544b:b0:321:c53c:4e70 with SMTP id 98e67ed59e1d1-324e13ad075mr2012951a91.9.1755665421347;
        Tue, 19 Aug 2025 21:50:21 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.248.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm1135052a12.38.2025.08.19.21.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 21:50:20 -0700 (PDT)
Message-ID: <b9a45766-2034-b444-1348-57d360aa70b5@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 10:20:17 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath12k-ng 00/13] wifi: ath12k: Ath12k modularization
 changes
Content-Language: en-US
To: Kiran Venkatappa <quic_kiranv@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a5540e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=pagehsHO18wfKU6DcLw+7w==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=S4ZghseuWT4aJn0Jpu0A:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: y-cpheMgfAtX7MedP8RofIPIx21JV-hl
X-Proofpoint-GUID: y-cpheMgfAtX7MedP8RofIPIx21JV-hl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX+7RC8uA93szN
 S4OVbQNASEoaWxagLT4NX/o5mjB7tT3oECq9DfEU8lChsFbeno3HVVjoy6f5t1YLZsH/Ea6m83m
 yOjb64z//niiyUYZsVndBMk5SYSVocd1Yo7nTI3X0ETcDJkM83+XhZNi3howVw1uwUNthV8BVjX
 5KkoSaAidnZjBqBZEXsImH0l8RrrLUDPnJa1J0aj4ZlQp8BeGzg3EWkO+m7b0IbLOXMv5VbkmPD
 Wy8wI1Bc3YgIPtCpU2mTmXNxiM+teEmBRRVNGbODf4ZKvTzjM2CzOq6wyfq07CgHZtQC1O0f7MV
 jPM1HiXmRKOfaC9D21VMnYjE8dXe9S60RNvwh7ymEhIgwGZfYaeu5DZkWqMKPgFeGnWOH+wMRYF
 0k5IQtjGCHCisgaR1ljRCDrCHM76JA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 8/12/2025 10:39 PM, Kiran Venkatappa wrote:
> Current ath drivers have separate implementations for different
> classes of devices. For example, ath11k supports WiFi-6 devices,
> while ath12k supports Wi-Fi 7 devices. However, there is significant
> common functionality across these generations due to shared firmware
> and hardware architecture. In the existing driver code, this leverage
> is achieved through code duplication. As a result, when a new driver
> is introduced, many features are missed, and new additions require
> porting across different generation drivers.
> 
> To improve reuse and maintainability, ath12k should be split into common
> and device-specific modules. Common code can be shared across multiple
> architectures, enabling better leverage for future hardware generations.
> generation drivers.
> 
> Firmware interfaces and core initialization sequences are typically common
> across different device families. In contrast, hardware register offsets, copy
> engine mappings, and HAL configurations are usually hardware-specific.
> 
> Common components include:
>        - mac80211 interface: Control path operations are mostly common across
>          different ATH hardware and will be shared as much as possible.
>        - Firmware interface (WMI, HTT, HTC, QMI): Firmware messaging and
>          sequences are common and maintained with backward/forward compatibility
>          using TLVs.
>        - Datapath: Data path files are also separated similarly. More information
>          will be provided in later patches.
>        - Core initialization, reset, and recovery sequences: These will be part
>          of the shared code.
> 
> Device-specific code includes:
>        - Hardware capabilities, configurations, HAL, and other
>          architecture-specific logic.
> 
> The original ath12k.ko is split into these two modules as depicted below.
> 
>                                        +-----------------+
>                                        |                 |
>                                        |   ath12k.ko     |
>                                        |    (common)     |
>      +---------------+                 |                 |
>      |               |                 +-----------------+
>      |   ath12k.ko   | ===========>
>      |               |                 +------------------+
>      +---------------+                 |                  |
>                                        | ath12k_wifi7.ko  |
>                                        | (wifi7 family)   |
>                                        |                  |
>                                        +------------------+
> 
> The ath12k.ko module will serve as the common component, while ath12k_wifi7.ko
> will be the architecture-specific module for WiFi-7 devices.
> 
> After this modular separation, adding support for a new device will
> primarily involve implementing device-specific code, while reusing the
> majority of the shared common components.
> 
> ---
> Kiran Venkatappa (13):
>        wifi: ath12k: Restructure PCI code to common and Wi-Fi 7 specific logic
>        wifi: ath12k: Move Copy Engine configuration to Wi-Fi 7 specific file
>        wifi: ath12k: Move Wi-Fi 7 WMI configuration to dedicated file
>        wifi: ath12k: Move Wi-Fi 7 MHI configuration to dedicated file
>        wifi: ath12k: Rename hw.c to Wi-Fi 7 specific implementation file
>        wifi: ath12k: Rename ahb_hif_ops to reflect generic usage
>        wifi: ath12k: Restructure ahb.c into common and Wi-Fi 7 specific modules
>        wifi: ath12k: Move Wi-Fi 7 specific init routines to dedicated file
>        wifi: ath12k: Move hw_init invocation to target-specific probe
>        wifi: ath12k: Modularize driver into common and Wi-Fi 7 specific components
>        wifi: ath12k: Rename ath12k_* symbols to ath12k_wifi7_* for clarity
>        wifi: ath12k: Remove HAL defines from shared PCI code
>        wifi: ath12k: Remove HAL define dependencies from shared AHB code
>   
>   drivers/net/wireless/ath/ath12k/Makefile         |   4 +-
>   drivers/net/wireless/ath/ath12k/ahb.c            | 139 ++--
>   drivers/net/wireless/ath/ath12k/ahb.h            |  27 +-
>   drivers/net/wireless/ath/ath12k/ce.c             | 301 -------
>   drivers/net/wireless/ath/ath12k/ce.h             |   5 +-
>   drivers/net/wireless/ath/ath12k/core.c           |  38 +-
>   drivers/net/wireless/ath/ath12k/core.h           |   7 +
>   drivers/net/wireless/ath/ath12k/debug.c          |   4 +
>   drivers/net/wireless/ath/ath12k/dp_rx.c          |   3 +
>   drivers/net/wireless/ath/ath12k/hal.c            |   4 +
>   drivers/net/wireless/ath/ath12k/htc.c            |   2 +
>   drivers/net/wireless/ath/ath12k/hw.h             |   2 -
>   drivers/net/wireless/ath/ath12k/mhi.c            | 130 ---
>   drivers/net/wireless/ath/ath12k/mhi.h            |   4 +-
>   drivers/net/wireless/ath/ath12k/pci.c            | 215 ++---
>   drivers/net/wireless/ath/ath12k/pci.h            |  28 +-
>   drivers/net/wireless/ath/ath12k/peer.c           |   2 +
>   drivers/net/wireless/ath/ath12k/wifi7/Makefile   |  10 +
>   drivers/net/wireless/ath/ath12k/wifi7/ahb.c      |  71 ++
>   drivers/net/wireless/ath/ath12k/wifi7/ahb.h      |  20 +
>   drivers/net/wireless/ath/ath12k/wifi7/ce.c       | 973 +++++++++++++++++++++++
>   drivers/net/wireless/ath/ath12k/wifi7/ce.h       |  22 +
>   drivers/net/wireless/ath/ath12k/wifi7/core.c     |  44 +
>   drivers/net/wireless/ath/ath12k/{ => wifi7}/hw.c | 798 +++----------------
>   drivers/net/wireless/ath/ath12k/wifi7/hw.h       |  13 +
>   drivers/net/wireless/ath/ath12k/wifi7/mhi.c      | 138 ++++
>   drivers/net/wireless/ath/ath12k/wifi7/mhi.h      |  11 +
>   drivers/net/wireless/ath/ath12k/wifi7/pci.c      | 188 +++++
>   drivers/net/wireless/ath/ath12k/wifi7/pci.h      |  12 +
>   drivers/net/wireless/ath/ath12k/wifi7/wmi.c      | 105 +++
>   drivers/net/wireless/ath/ath12k/wifi7/wmi.h      |  15 +
>   drivers/net/wireless/ath/ath12k/wmi.c            |  97 ---
>   drivers/net/wireless/ath/ath12k/wmi.h            |   4 -
>   33 files changed, 1956 insertions(+), 1480 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

