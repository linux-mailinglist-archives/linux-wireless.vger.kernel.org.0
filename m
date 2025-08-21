Return-Path: <linux-wireless+bounces-26484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8440AB2EAF7
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 03:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9EF166F19
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 01:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8505FEE6;
	Thu, 21 Aug 2025 01:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JcMU9T6w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3D21A9F84
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 01:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755740779; cv=none; b=HajpjoSnxWPP5ALJn+ZLvvWunw0P902qL7dR4Sij9PfrZ9GnVrke/2xHo6ml1GQ4s2IlkUr6G/5ps8hphH8EONIQwyFVL2MziJFRdPWZbW6z6t+GQCjph26QCXNEgmZQ8fUNA2aa47xzXdj65rxXRYtg6A46l+IXn/YcV7VLI2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755740779; c=relaxed/simple;
	bh=8jPoK6usN9icfhRwvZ3XMy+sz1drX4MKWFtlM+v5htw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FWenDdVeJl9zUQ7ZdnLKqGALVWlp3M3MKOc49dSB5XEbecEX163Ny26aJ5epfD/IOAXZcXAPQS3w/mdDPiOBki9kP4B8j3/7tSfHPfCd9aH1f7Kuwu2+g0goOXRFMJ0wNfov9tDsNGpC5iCeBSxa9thkYLJaKUmy7bBoLfmBIi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JcMU9T6w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KJJrMb019714
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 01:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+skZ8cNdqz/D37Oz19EMGUXV+lvtS8uVJDUr2Q9tiS8=; b=JcMU9T6wH2KfOoIK
	y9unaBHlVXP5jl3XtFPbNJKM+GeH/2qRiXR/34zUVwb94laMQh1RrBazboSYBfXF
	Hj3R+WbNDR1ns5GLG2QVYC7sIN/5MXPW06LCZcLE2+AE9407oW61sh13rGHdukf5
	xpJ6cWZmxpyW3BdZSu4W9jy2MmbP2ViJ9IlPzHGgYyqkCdMvXyZ7HjNF0k2fOIXc
	WEPn49xcv2QdWMzQiGdmloezaKOPSS1GZuM5UtP4TVM5CIyQO6K80WAA3yY/G3tG
	+pk6LAXRv7JI9jzrwCtgKcbxn7DgL9PnQF6FgRlZvr9EMIftDIIt1HOMMGQ7Zerb
	Q6SxMg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5293m3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 01:46:16 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2e614c60so504049b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 18:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755740775; x=1756345575;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+skZ8cNdqz/D37Oz19EMGUXV+lvtS8uVJDUr2Q9tiS8=;
        b=CHiBQwGyZF1Ltb9fd1Npxn9PZnrRaW8To2AmhjUAysjMzfjaEYTmaENzLk/IL6orLM
         HhhAVhgpx54Ni5mEvszVD8I1+BTmnrgtdMi889YVrsdov7yB7/FtyPyY5VwlKyPY49pO
         moZh2e5VkBIGWTX9OL9ZMiJkCFhI5nGzwO0GVPaMR54U9/rykTPdKTwijFDpvyR3bupK
         gktjQ4y6febPa92AN7dv89AdfzaK7hrxYmP2KvopGQ62k97hdwdl6MqTOL/9Q7IdIDqd
         jM5TRyxQG3O2vs7czkBrULvNTp1dOZ/QGYPnxcOjOx+FhY6Ty3EaW7x/9mEiQjijD0MV
         cSLg==
X-Gm-Message-State: AOJu0YxCXb99oucaR25vMu5XG5L4+nbCJWWkiRdWWNena4QNbYhuE9Y4
	hSn8QRAJ1aLBvyr/LGEeUIaS/3ZsLQ7eQPl5so6/0hZMMDWYIxpRvUOwWVowM4UKo6Ay2nH2nsw
	z/a9IqvyhlagDP53cOPqP++ZbVWEjkn0wADB1aLnSQGqZKQaSncQp8tPmKbT0CjDIVr/Xpw==
X-Gm-Gg: ASbGnctGAGXH4JZRCZ/ed9lPD7AxCImKYEOS9+0o0zS5YqS+E/VIIsgvC5nJEtIifxg
	bTiPqcj6NOjRUkGJZ9XktEcffsfWjN+nSu7X0AbmN9CKpizQlPWeSRqMXjI409Ygt3xUlg35zRa
	hH9KEAvVTjvoxGMGJV5/LfTVd3ToYytvk5jCWVXtxA6CqokQXIWYhbhTz1CCf8mg/Ya98WCZzIr
	8QZHT/YJZsDqdrXRsM+4bDLp3xKYtgEPUDkL/QPTxBlYuRE8AfTSfSraDEebzqY68sowW2Vsc+9
	mit4EvMzyCDnsJ1Q/N9gCLEH9RHzC5+fk6JvN/xl+T5Mrn2RQ4gZiYaEHmZA8CxcRwJd5mivzCr
	OhD2D6Mhyc4PUHIiyITjGWcQla9RPKg6+VG+J
X-Received: by 2002:a05:6a00:cc7:b0:747:b043:41e5 with SMTP id d2e1a72fcca58-76ea323d221mr600933b3a.16.1755740775400;
        Wed, 20 Aug 2025 18:46:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW1m+t5TPtRkC2LBlKD+WeAOeTQCXH5LiSwx3SBbSJSH/QO4VP/KUSioYDIkJCnWI+ixRwtg==
X-Received: by 2002:a05:6a00:cc7:b0:747:b043:41e5 with SMTP id d2e1a72fcca58-76ea323d221mr600905b3a.16.1755740774749;
        Wed, 20 Aug 2025 18:46:14 -0700 (PDT)
Received: from [10.133.33.94] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d39e1sm6614270b3a.20.2025.08.20.18.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 18:46:14 -0700 (PDT)
Message-ID: <746724e2-8aae-4103-b53e-da8d45a3d697@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 09:46:09 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath12k-ng 00/13] wifi: ath12k: Ath12k modularization
 changes
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Kiran Venkatappa <quic_kiranv@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
 <110b6e64-7a9c-4a8f-9b1c-830251d6c733@oss.qualcomm.com>
 <02584bb9-364e-4391-957f-7833d6bc0f79@oss.qualcomm.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <02584bb9-364e-4391-957f-7833d6bc0f79@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: z5IMe3lB_iv900bGnBU5XFxV66vytfiI
X-Proofpoint-ORIG-GUID: z5IMe3lB_iv900bGnBU5XFxV66vytfiI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX1jwohyCRpeOC
 m2NlVOgauqZ2c609ETaFRfc4u2ag3BdkHrfxCISne+ZzyC5Fwr4Ac9T3XfyCotJqlb+RMMk7t/O
 imPFM8H7iipozPWFoWpXsHiUWsep2kbrwZJsUXxGHZJPi/Clbg0v/F1sEg2vpnQGXSeSZZCPgH+
 xd9GyJwLauOKguX2lAKMbgp6Sz8azs2MicHHkPZ3gDh6TBQnmucnp9MWs1Gn1OHcmwkwsbdYhHC
 TMIxUfgusXkGtg9rVOeddRRhtl48RVH7jHAa223u1Ny3qLBURxLfUtb0RbpkjBhqxdLlR/h2vb6
 tdYfnNGFSd/7jYP3s15zwRy6my5/txJF62WkFn416AanLqOqaE317IVx9Y3fVFRhIMjcjBWe0Ov
 L/DGrZqg4DxPylWji7Cufsq3kB3zIg==
X-Authority-Analysis: v=2.4 cv=SPkblOvH c=1 sm=1 tr=0 ts=68a67a68 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=XBBnzUIGvRwb0vX7ptQA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013



On 8/21/2025 4:57 AM, Jeff Johnson wrote:
> On 8/20/2025 12:11 AM, Baochen Qiang wrote:
>>
>>
>> On 8/13/2025 1:09 AM, Kiran Venkatappa wrote:
>>> Current ath drivers have separate implementations for different
>>> classes of devices. For example, ath11k supports WiFi-6 devices,
>>> while ath12k supports Wi-Fi 7 devices. However, there is significant
>>> common functionality across these generations due to shared firmware
>>> and hardware architecture. In the existing driver code, this leverage
>>> is achieved through code duplication. As a result, when a new driver
>>> is introduced, many features are missed, and new additions require
>>> porting across different generation drivers.
>>>
>>> To improve reuse and maintainability, ath12k should be split into common
>>> and device-specific modules. Common code can be shared across multiple
>>> architectures, enabling better leverage for future hardware generations.
>>> generation drivers.
>>>
>>> Firmware interfaces and core initialization sequences are typically common
>>> across different device families. In contrast, hardware register offsets, copy
>>> engine mappings, and HAL configurations are usually hardware-specific.
>>>
>>> Common components include:
>>>       - mac80211 interface: Control path operations are mostly common across
>>>         different ATH hardware and will be shared as much as possible.
>>>       - Firmware interface (WMI, HTT, HTC, QMI): Firmware messaging and
>>>         sequences are common and maintained with backward/forward compatibility
>>>         using TLVs.
>>>       - Datapath: Data path files are also separated similarly. More information
>>>         will be provided in later patches.
>>>       - Core initialization, reset, and recovery sequences: These will be part
>>>         of the shared code.
>>>
>>> Device-specific code includes:
>>>       - Hardware capabilities, configurations, HAL, and other
>>>         architecture-specific logic.
>>>
>>> The original ath12k.ko is split into these two modules as depicted below.
>>>
>>>                                       +-----------------+
>>>                                       |                 |
>>>                                       |   ath12k.ko     |
>>>                                       |    (common)     |
>>>     +---------------+                 |                 |
>>>     |               |                 +-----------------+
>>>     |   ath12k.ko   | ===========>
>>>     |               |                 +------------------+
>>>     +---------------+                 |                  |
>>>                                       | ath12k_wifi7.ko  |
>>>                                       | (wifi7 family)   |
>>>                                       |                  |
>>>                                       +------------------+
>>>
>>> The ath12k.ko module will serve as the common component, while ath12k_wifi7.ko
>>> will be the architecture-specific module for WiFi-7 devices.
>>>
>>> After this modular separation, adding support for a new device will
>>> primarily involve implementing device-specific code, while reusing the
>>> majority of the shared common components.
>>>
>>> ---
>>> Kiran Venkatappa (13):
>>>       wifi: ath12k: Restructure PCI code to common and Wi-Fi 7 specific logic
>>>       wifi: ath12k: Move Copy Engine configuration to Wi-Fi 7 specific file
>>>       wifi: ath12k: Move Wi-Fi 7 WMI configuration to dedicated file
>>>       wifi: ath12k: Move Wi-Fi 7 MHI configuration to dedicated file
>>>       wifi: ath12k: Rename hw.c to Wi-Fi 7 specific implementation file
>>>       wifi: ath12k: Rename ahb_hif_ops to reflect generic usage
>>>       wifi: ath12k: Restructure ahb.c into common and Wi-Fi 7 specific modules
>>>       wifi: ath12k: Move Wi-Fi 7 specific init routines to dedicated file
>>>       wifi: ath12k: Move hw_init invocation to target-specific probe
>>>       wifi: ath12k: Modularize driver into common and Wi-Fi 7 specific components
>>>       wifi: ath12k: Rename ath12k_* symbols to ath12k_wifi7_* for clarity
>>>       wifi: ath12k: Remove HAL defines from shared PCI code
>>>       wifi: ath12k: Remove HAL define dependencies from shared AHB code
>>>  
>>>  drivers/net/wireless/ath/ath12k/Makefile         |   4 +-
>>>  drivers/net/wireless/ath/ath12k/ahb.c            | 139 ++--
>>>  drivers/net/wireless/ath/ath12k/ahb.h            |  27 +-
>>>  drivers/net/wireless/ath/ath12k/ce.c             | 301 -------
>>>  drivers/net/wireless/ath/ath12k/ce.h             |   5 +-
>>>  drivers/net/wireless/ath/ath12k/core.c           |  38 +-
>>>  drivers/net/wireless/ath/ath12k/core.h           |   7 +
>>>  drivers/net/wireless/ath/ath12k/debug.c          |   4 +
>>>  drivers/net/wireless/ath/ath12k/dp_rx.c          |   3 +
>>>  drivers/net/wireless/ath/ath12k/hal.c            |   4 +
>>>  drivers/net/wireless/ath/ath12k/htc.c            |   2 +
>>>  drivers/net/wireless/ath/ath12k/hw.h             |   2 -
>>>  drivers/net/wireless/ath/ath12k/mhi.c            | 130 ---
>>>  drivers/net/wireless/ath/ath12k/mhi.h            |   4 +-
>>>  drivers/net/wireless/ath/ath12k/pci.c            | 215 ++---
>>>  drivers/net/wireless/ath/ath12k/pci.h            |  28 +-
>>>  drivers/net/wireless/ath/ath12k/peer.c           |   2 +
>>>  drivers/net/wireless/ath/ath12k/wifi7/Makefile   |  10 +
>>>  drivers/net/wireless/ath/ath12k/wifi7/ahb.c      |  71 ++
>>>  drivers/net/wireless/ath/ath12k/wifi7/ahb.h      |  20 +
>>>  drivers/net/wireless/ath/ath12k/wifi7/ce.c       | 973 +++++++++++++++++++++++
>>>  drivers/net/wireless/ath/ath12k/wifi7/ce.h       |  22 +
>>>  drivers/net/wireless/ath/ath12k/wifi7/core.c     |  44 +
>>>  drivers/net/wireless/ath/ath12k/{ => wifi7}/hw.c | 798 +++----------------
>>>  drivers/net/wireless/ath/ath12k/wifi7/hw.h       |  13 +
>>>  drivers/net/wireless/ath/ath12k/wifi7/mhi.c      | 138 ++++
>>>  drivers/net/wireless/ath/ath12k/wifi7/mhi.h      |  11 +
>>>  drivers/net/wireless/ath/ath12k/wifi7/pci.c      | 188 +++++
>>>  drivers/net/wireless/ath/ath12k/wifi7/pci.h      |  12 +
>>>  drivers/net/wireless/ath/ath12k/wifi7/wmi.c      | 105 +++
>>>  drivers/net/wireless/ath/ath12k/wifi7/wmi.h      |  15 +
>>>  drivers/net/wireless/ath/ath12k/wmi.c            |  97 ---
>>>  drivers/net/wireless/ath/ath12k/wmi.h            |   4 -
>>>  33 files changed, 1956 insertions(+), 1480 deletions(-)
>>> ---
>>> base-commit: d9104cec3e8fe4b458b74709853231385779001f
>>> change-id: 20250812-ath12k-mod-bd00156df202
>>>
>>
>> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>>
> 
> I dropped the extra ">" when applying to the patches in 'pending'

My bad! Didn't notice that, Thanks!

> 
> /jeff


