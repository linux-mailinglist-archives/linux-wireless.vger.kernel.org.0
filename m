Return-Path: <linux-wireless+bounces-26468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A023B2D487
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 09:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00863621CBA
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 07:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E61277C80;
	Wed, 20 Aug 2025 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iGf7/PdB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286F02D24AA
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 07:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755673900; cv=none; b=Cv8bO3LKX2MY97HxqWfDaLrKPcGFxFLYqZFeHGOLDV02aq3D58bLCUOKMokFkQa69Tp1RoDG5bdmT0ij808SMMTEK1bTtUjjpOlgTfzsGQWk9j2UXUqTjENpSkZxhkYiuNVDHX7yAeF01Q/q8c2XRyB9ssvgFQst0WgTPJADD5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755673900; c=relaxed/simple;
	bh=5ReA4GnAlQGR60KFDddq7Ff9WakOJ5ug8NAQHcp+sp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWnSinHI1v5g89dSlG9/nk0Q3bKmewCbRL0pcK2RStC3IwrWokAP1pJvQNwjv+LKy65od7dIWLsqRHlmviN/Oi/OaO9NRSBvawaSlMplkFNqYdy+o6mpOa9FVSj9av7SnETaXKAQKwGYLEFpkNgqtFHRJWXPAgP3PZiO1tW830s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iGf7/PdB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1oVqc001993
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 07:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zXzEOnV+cDeHlGbV6CuI7MA2Sg53isAp+SimUKmE4U4=; b=iGf7/PdBddYaULYM
	2jl+tlsatPcTmWdUCob5SOP4/fbnoEiYH6ztf2zE3Gbiu95CkLK+C2YyFLez/ASu
	232mh9Ni2xuUdl89Zk5VgYSJKpKNO5RcOoyM3Wr0Ro0lgZ/34EhqOVSN8QCmLU44
	LGWpYZ9GVJzJAcEGuckhm8U8N6kz6dttv95j3RJ3mWOksADQ1N8CBMzmkA+rYfrx
	Qj4eQBZv0xprz+X/DNNnEX9+R2fQ58lMsqxu4PX7SMmVH+vaRw+KDzvFahmqvaNI
	q+tTeQKRWNwhnqoOpYF8A4qGezOThLUzfoOTzQf5fvqq8eiN+hWkSNwjmxT2kjkJ
	158WWA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n528rrbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 07:11:35 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-323266a1e87so6527536a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 00:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755673894; x=1756278694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zXzEOnV+cDeHlGbV6CuI7MA2Sg53isAp+SimUKmE4U4=;
        b=YQ6qgZXlUlT8c1yu73b9JrgeqtNc98YSBbo7QHwJexHRB/hBUAAoxJvQ5Sm4g3vnK/
         A4cIrRFUxG1A5Cg11NzeWf+8soo60H8FKNG6prJnPTDqsKm1z3FxDNsrqc5JOoykAr6i
         t392g/eCWYjaROxgARTSdGLFuyWD6Pjq5bNUcFggTbWu3Tt1U49fR0wqPy9x+If5+Lq2
         JOEPoztMvL7HQNxRLIj2/bqJO0nNuH6xBpK/RIZy0CzUDpzh6dp0GjiJUUNkf1MyCBJF
         tHhP5uI55AXxThMtSYfvdfTVBe8jU05CTyswfBT9MDdKNN1Zr49egxIv1ABod/piG4w9
         XEYQ==
X-Gm-Message-State: AOJu0YzrPY7WCOkNegXUgg7IRh+tT260++RcRx0ixwJqi7iCTNr88GcA
	lbCA0CJ6qFLtZHZeW6k4JrWzfxSH+lLmsRkLZOk80m+lL7a7RzPqWvJJCyt/HMZAAHnMrnqw/zi
	T2lu6HqwJDFjcQ8YBmC3ZbQ8+54df41gqsBzU+rEkwphyS6qLZPnc/irOFHz1LwEqXfR7dg==
X-Gm-Gg: ASbGncu/XH3Jc+1L5cHjXb7/vk/VjzFc0cHlpC8Ui6eOHEpCpAYWky+H2mIGWT6xjEX
	jX/tLXwHo0e65UWaL8hJM/YSfTRrIl331wU1rP8S4qWa16pxQuU+0Fm1OljYrm67npqsVtdAm5s
	/ffXA3uoUHlIaI4CtldkGR5PbVtlS9QOl0Zy9M0+dWEr3AIX4Og/S4s4KZyRItoqaCnzWYddu8h
	yEyO4NVzPEUa7eUY3gx6DrkIMjTg2SC02D2tUcYtunaWwXTK0kS3Gkg+FwQ6lFD9HG30h/HiXS5
	mk/wBVbuUWnuxefuDZF06r2jaPayD5xXKk/XvjxSh11zzOShLisv697V+gwg9jCGgJjqidKdrtH
	rpqKa3GsWGUeyAyySt6/mTOKWFl8O+wEYFK06
X-Received: by 2002:a17:90b:57c5:b0:31e:cee1:c5e1 with SMTP id 98e67ed59e1d1-324e1408994mr2595860a91.30.1755673894369;
        Wed, 20 Aug 2025 00:11:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU+wrtOzR0AAC0rbw6K+R2q4waLhIbFFCTghUtyPLxEoNyigaKo7hvTjikhXZt8YxCZ7hy9Q==
X-Received: by 2002:a17:90b:57c5:b0:31e:cee1:c5e1 with SMTP id 98e67ed59e1d1-324e1408994mr2595824a91.30.1755673893873;
        Wed, 20 Aug 2025 00:11:33 -0700 (PDT)
Received: from [10.133.33.94] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e26259b6sm1324377a91.17.2025.08.20.00.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 00:11:33 -0700 (PDT)
Message-ID: <110b6e64-7a9c-4a8f-9b1c-830251d6c733@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 15:11:28 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath12k-ng 00/13] wifi: ath12k: Ath12k modularization
 changes
To: Kiran Venkatappa <quic_kiranv@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fpOFpF4f c=1 sm=1 tr=0 ts=68a57527 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=FANxXbjX70Gmbhvze2IA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: zN0wiIYL1dMxr3yGbALKuYvke1pWSG2O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX2LWYyfqKOk0D
 DDV5AcaOVUX1p5Hbcx6WATWsdrufe+Bsi09riL81Xy/kVqCo78da6bd3oWzUBmRHlsGDrW7IhQj
 u3BO5rijDWmOPImR0zfB5QnzS/WhkEwk/E7PIbjMNyHTVv4+2qeRy4V5MQLXQfINlk6iBH8HL7g
 VpBd0Mc6rZBRoXYH/69Kf6luUlvacEV+wAgYBpopPWTMOwtg0hvFxnD7pN5Q7XhVDomkF//LMpC
 tmOs4D7wXg539plx44TYDUtYToVmKEVr99R0jmR+M+0c7ZrNgCxgIk2FyJR2vLbdBPM+gDoA9Yj
 cN72YZJNEz1EgQk9NTCCbR1gqZsvtMmY9Hcv5EGtv8W3opbYjYZFHJNLI6AhLsEFp1XnyB74k4f
 E/r36T235Ynh4IvO1xtL/7ol7FBKww==
X-Proofpoint-ORIG-GUID: zN0wiIYL1dMxr3yGbALKuYvke1pWSG2O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 8/13/2025 1:09 AM, Kiran Venkatappa wrote:
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
>       - mac80211 interface: Control path operations are mostly common across
>         different ATH hardware and will be shared as much as possible.
>       - Firmware interface (WMI, HTT, HTC, QMI): Firmware messaging and
>         sequences are common and maintained with backward/forward compatibility
>         using TLVs.
>       - Datapath: Data path files are also separated similarly. More information
>         will be provided in later patches.
>       - Core initialization, reset, and recovery sequences: These will be part
>         of the shared code.
> 
> Device-specific code includes:
>       - Hardware capabilities, configurations, HAL, and other
>         architecture-specific logic.
> 
> The original ath12k.ko is split into these two modules as depicted below.
> 
>                                       +-----------------+
>                                       |                 |
>                                       |   ath12k.ko     |
>                                       |    (common)     |
>     +---------------+                 |                 |
>     |               |                 +-----------------+
>     |   ath12k.ko   | ===========>
>     |               |                 +------------------+
>     +---------------+                 |                  |
>                                       | ath12k_wifi7.ko  |
>                                       | (wifi7 family)   |
>                                       |                  |
>                                       +------------------+
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
>       wifi: ath12k: Restructure PCI code to common and Wi-Fi 7 specific logic
>       wifi: ath12k: Move Copy Engine configuration to Wi-Fi 7 specific file
>       wifi: ath12k: Move Wi-Fi 7 WMI configuration to dedicated file
>       wifi: ath12k: Move Wi-Fi 7 MHI configuration to dedicated file
>       wifi: ath12k: Rename hw.c to Wi-Fi 7 specific implementation file
>       wifi: ath12k: Rename ahb_hif_ops to reflect generic usage
>       wifi: ath12k: Restructure ahb.c into common and Wi-Fi 7 specific modules
>       wifi: ath12k: Move Wi-Fi 7 specific init routines to dedicated file
>       wifi: ath12k: Move hw_init invocation to target-specific probe
>       wifi: ath12k: Modularize driver into common and Wi-Fi 7 specific components
>       wifi: ath12k: Rename ath12k_* symbols to ath12k_wifi7_* for clarity
>       wifi: ath12k: Remove HAL defines from shared PCI code
>       wifi: ath12k: Remove HAL define dependencies from shared AHB code
>  
>  drivers/net/wireless/ath/ath12k/Makefile         |   4 +-
>  drivers/net/wireless/ath/ath12k/ahb.c            | 139 ++--
>  drivers/net/wireless/ath/ath12k/ahb.h            |  27 +-
>  drivers/net/wireless/ath/ath12k/ce.c             | 301 -------
>  drivers/net/wireless/ath/ath12k/ce.h             |   5 +-
>  drivers/net/wireless/ath/ath12k/core.c           |  38 +-
>  drivers/net/wireless/ath/ath12k/core.h           |   7 +
>  drivers/net/wireless/ath/ath12k/debug.c          |   4 +
>  drivers/net/wireless/ath/ath12k/dp_rx.c          |   3 +
>  drivers/net/wireless/ath/ath12k/hal.c            |   4 +
>  drivers/net/wireless/ath/ath12k/htc.c            |   2 +
>  drivers/net/wireless/ath/ath12k/hw.h             |   2 -
>  drivers/net/wireless/ath/ath12k/mhi.c            | 130 ---
>  drivers/net/wireless/ath/ath12k/mhi.h            |   4 +-
>  drivers/net/wireless/ath/ath12k/pci.c            | 215 ++---
>  drivers/net/wireless/ath/ath12k/pci.h            |  28 +-
>  drivers/net/wireless/ath/ath12k/peer.c           |   2 +
>  drivers/net/wireless/ath/ath12k/wifi7/Makefile   |  10 +
>  drivers/net/wireless/ath/ath12k/wifi7/ahb.c      |  71 ++
>  drivers/net/wireless/ath/ath12k/wifi7/ahb.h      |  20 +
>  drivers/net/wireless/ath/ath12k/wifi7/ce.c       | 973 +++++++++++++++++++++++
>  drivers/net/wireless/ath/ath12k/wifi7/ce.h       |  22 +
>  drivers/net/wireless/ath/ath12k/wifi7/core.c     |  44 +
>  drivers/net/wireless/ath/ath12k/{ => wifi7}/hw.c | 798 +++----------------
>  drivers/net/wireless/ath/ath12k/wifi7/hw.h       |  13 +
>  drivers/net/wireless/ath/ath12k/wifi7/mhi.c      | 138 ++++
>  drivers/net/wireless/ath/ath12k/wifi7/mhi.h      |  11 +
>  drivers/net/wireless/ath/ath12k/wifi7/pci.c      | 188 +++++
>  drivers/net/wireless/ath/ath12k/wifi7/pci.h      |  12 +
>  drivers/net/wireless/ath/ath12k/wifi7/wmi.c      | 105 +++
>  drivers/net/wireless/ath/ath12k/wifi7/wmi.h      |  15 +
>  drivers/net/wireless/ath/ath12k/wmi.c            |  97 ---
>  drivers/net/wireless/ath/ath12k/wmi.h            |   4 -
>  33 files changed, 1956 insertions(+), 1480 deletions(-)
> ---
> base-commit: d9104cec3e8fe4b458b74709853231385779001f
> change-id: 20250812-ath12k-mod-bd00156df202
> 

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>>


