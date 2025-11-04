Return-Path: <linux-wireless+bounces-28518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACE3C2F3F5
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 05:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C170189CA86
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 04:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8208E23F429;
	Tue,  4 Nov 2025 04:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gx37LChm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yb6Y//1C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFAA1D7E5C
	for <linux-wireless@vger.kernel.org>; Tue,  4 Nov 2025 04:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762229158; cv=none; b=P38BuVNrZVL5Yy4stznFyt2eqbt3yrHazzb7bzHIqGTkBt6c5rn7vHlQHEaKcZ+SlVICFW4gXakc865sH3c5Gmpx5SVQt5UuBe9IWAb0UcDMQ2sXyDJL+LyZksG9U5FpD8A8oMYsT8CMD88MU6wtdQpRvwc2ulz3A/aBbWRWna0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762229158; c=relaxed/simple;
	bh=5Cyvg11LMlU4L196Wj5pKQmdFXVqjTWfLXWIPzSgOc0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PZMJVxxBTz7FBiZNbdTcYIARo+plspBm2rdzoLvYEq5qvM3I+EA14sujSqJ/yOyJ6a/3ZwUn7DOP09oqu19p09/zhiiUUlI4N5ukdVBsD9NNVHK+ZRgVm+8PJ5EtwORm87atHaeTJLjZMHf8guKvjnkzxVki1r39MKc081KpbHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gx37LChm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yb6Y//1C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A43NOAY3693862
	for <linux-wireless@vger.kernel.org>; Tue, 4 Nov 2025 04:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BL2d5x3uwCB1K4kXp0gbCO+q7Vzhg7R2fgTZtVLAHR4=; b=gx37LChmNjrB3C+2
	8Zq4UV4h+CvKinB+QWS1JYi3x1RebFp+LyhYM5k9lADiK6RZtZ3gwYxho0d/7+QI
	9xUSEacQYUAGHSKMGthKVLOEClpmtGujGnHXit8dn28IArwbOvjKFskkDXmpjg2C
	jEaVaR7twOEfFibxK7CMPqtOk6TBq/nJAeXvkQNbYPTZxuiEfa+enAQtKbo2OSX2
	BSSBmW16UHooezMf8wnnFOJVJT1Qn6FqgygfUI8aE4cZFZ7jL20Rwi2HFtDYtJRX
	KZ7e/SgdjBZaT0jXmLQgD1k8pBb5rUa5qIGKjGYRmq9CJUkkeatZ79Iern3wI3WV
	OjOKzw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6u8b2hj4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Nov 2025 04:05:55 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b8f8e1f1044so8131686a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 03 Nov 2025 20:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762229154; x=1762833954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BL2d5x3uwCB1K4kXp0gbCO+q7Vzhg7R2fgTZtVLAHR4=;
        b=Yb6Y//1CNElRbDWj5OIMooKoSOHxdN5vBGFRe6ebBwAI2tx4Zy8PU7klXZxnKm9fy3
         Gv3xGrbCBV9oihld88SRUFJnJ92AZLcfL5P2nWNoz+ij2+NpiHid3RhfPLedPZw4BEVh
         rLHc9stVbWQCN4BajyhN1ZGMTH/6s7rvQhdAMqTGF4zWLy88I7oZT9ojVuBZpWw2UbDV
         Nz/XqV2disGW2kuJ2HueqM6/7dHo7+kEH1cbWK26ztzYYWvUnPQbEfZ8z6LshxpfJOK8
         VkPiTfCafh6Ao/fQnyyi7nYhbfelU80+rKD3D/Q8yrfRCGCBTv6O56yZDix2tCNTRoFQ
         Yt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762229154; x=1762833954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:cc:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BL2d5x3uwCB1K4kXp0gbCO+q7Vzhg7R2fgTZtVLAHR4=;
        b=HqSwVdtZysjRvJ+PGl+fuWKy0dFKIJ8RSFZZ9fF96Kmp1Rp1VI1pSMOHyhr21dGFAu
         9nzRJa0vTyw5IU2LPaF8FTt8HDlCcvcq6p1l0+L5NtsHAMtZk3k4aXFwQC7OwsjtOEp3
         peNi5hQbLrgnk4A0jmzaXhs2d5gCaL6eez7oh24FjiWmKBRtO3T0L5UrxNoRhNhyZAJY
         qRPDMfN+e8dezudypyG0J2e+neC7pKYbreHHLYB77sPBIfkHOg1fmVW/8fZrd65VTWck
         VcJQvwWG+Qt0vzx0H1NjHvKUU2o5sYm7huTMm5wzCB+mx4vyFka3aQrwY9p93VFVPDSb
         iUyg==
X-Forwarded-Encrypted: i=1; AJvYcCUz1RZ5rJACzckb+lLI5Ong/RVwAGFQTwCrsw4OFXz3vGot16vCfMbm0PxI+2GXizMosOheSXS3QHR3Qmu4bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwER+GfX9s/PDyfGJX3FeXdnL18gENDOaU5J2io6uFZdG4xd5xJ
	BZsByYznXnOY20MhnNBKPM1qQkR0NaRi97+NfTQLPcxX17jem2rVc0wK1p2UixqoXsCBYOh/K8K
	8p17lNpoQPxPr2xlX7H8i86Rr2NRoa7c1gTOvMwpI1I2MK6qXp5QFa4pb/AO5BXvk+k0Vvl7Lue
	vgmg==
X-Gm-Gg: ASbGncvd1icUt6Wnjl6oHspWG7BpaUU9+TbQaaiREaHfd3djFa+ruaR55TyGaZ1adNw
	J8fBKF6tItsHwQcLhuM1ZV5LPA+J9RoNLuSHpLb+VtzIHsx0gbyrVTxTRFFwi4m1WoaOjpaSxIm
	iB6ii7BYYOAEjzxJ5xCXvrA1/rZai2Qu9bHG9bxrTqCjB7EOFpnRIN477AKzGsnDXbGwkRAeXJA
	VMoinWFqESb0S+Am9lWKjxQKf8P3c1VoxX+VtPWKPVjXRbdBOMVHFDdZR2AjScdCKQab/CXTfAp
	WbZkASKYTZix0F6GpajvoXxHgXiqYM3DNAPYyaHiqCksMvmK1WoUFWKej2aDIuwaEGOXfLePhku
	TdSRW19rrelcGIZGRTGMnhsTNkOKXmBOU2U8/hjugHQ==
X-Received: by 2002:a17:902:db08:b0:295:3584:1bb7 with SMTP id d9443c01a7336-295358424d4mr181307005ad.46.1762229154219;
        Mon, 03 Nov 2025 20:05:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4YVEHXOAzj7SeTUZ2folwDlwFxBPLDCcuDidgcQss5nKgWUBBORCEfpMQZixU1p5sK2X/+Q==
X-Received: by 2002:a17:902:db08:b0:295:3584:1bb7 with SMTP id d9443c01a7336-295358424d4mr181306555ad.46.1762229153657;
        Mon, 03 Nov 2025 20:05:53 -0800 (PST)
Received: from [10.151.40.197] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2960199832asm8657085ad.26.2025.11.03.20.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 20:05:53 -0800 (PST)
Message-ID: <b7828ed4-17e2-d811-7ab1-ccf438485d97@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 09:35:50 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: karthikeyan.periyasamy@oss.qualcomm.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH ath12k-ng 00/12] wifi: ath12k: Modularize Wi-Fi 7
 components and refactor data path structures
To: Ripan Deuri <quic_rdeuri@quicinc.com>, ath12k@lists.infradead.org
References: <20251103112111.2260639-1-quic_rdeuri@quicinc.com>
Content-Language: en-US
From: Karthikeyan Periyasamy <karthikeyan.periyasamy@oss.qualcomm.com>
In-Reply-To: <20251103112111.2260639-1-quic_rdeuri@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDAzMCBTYWx0ZWRfX9KqT082dUnA7
 dF4ehwVD5HlMioVmDAsdNorq4Badj/W8JWrAHqA40aqal4cbWXX2uhEmRg+u/hLE9yeaWws1erV
 6yw4so+0XCHI4aoGd+NoYQHn8ebDZGAkCUdeoaAT7YlAhKZHZZCEj/Sq44k/6oWKnUoC+kb4DsV
 75zsY+OaubreW6oiryeDdSIPOKEvwP/d/piZxkvu3XeWMsx4q0DHHC+REmNQFIgq887P49uwqFV
 KFcblqU4qbKf/D7VGHsIIdpUxxmYjDAtp3IPVRQn/9JhTIrBP3TR1sSA+O11kct+fy7KVQGgw1m
 To18wx600mN89X5Dwh/Zan6LPAafFtIijPXeSYzopEuXeyTKho+S7C7n+UIYauCJgU+IH3CewT7
 7s/6jbi88NVfKVMuTnKZA4Y1Ra4oEQ==
X-Proofpoint-GUID: A-wZu3ID4f_Fb6XXibmKqC2lccfXUxtm
X-Authority-Analysis: v=2.4 cv=Ha8ZjyE8 c=1 sm=1 tr=0 ts=69097ba3 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=sRM0s-ADGhWGS2TRvpMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: A-wZu3ID4f_Fb6XXibmKqC2lccfXUxtm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040030



On 11/3/2025 4:50 PM, Ripan Deuri wrote:
> This patch series introduces a comprehensive set of changes aimed at enhancing
> the modularity and maintainability of the ath12k driver, in the context of
> Wi-Fi 7 support. The key updates include:
> 
> * Callback Integration for Wi-Fi 7 RX APIs:
> 
>     Introduces callbacks in arch_ops for RX-related APIs defined in the Wi-Fi 7
>     module. Adds wrapper functions to invoke these callbacks from the common
>     code. Enables seamless interaction between ath12k.ko and ath12k_wifi7.ko by
>     leveraging the ops mechanism.
> 
> * Data Path Modularization:
> 
>     Macro Refactoring: Moves shared macro definitions from dp.h to cmn_defs.h to
>     improve code organization.
> 
>     Device Stats Consolidation: Relocates device stats from ath12k_base to
>     ath12k_dp, centralizing all SOC-level stats within the data path module.
> 
>     Peer Stats Modularization: Relocates data path stats from ath12_link_sta to
>     ath12k_dp_link_peer, aligning with the modular peer architecture and
>     improving maintainability.
> 
> * Wi-Fi 7 Specific File Reorganization:
> 
>     Moves the following files to be built as part of ath12k_wifi7.ko:
> 
>     wifi7/hal_tx.c
>     wifi7/hal_rx.c
>     wifi7/dp_rx.c
>     wifi7/dp_tx.c
>     wifi7/dp.c
>     wifi7/hal.c
>     wifi7/hal_qcn9274.c
>     wifi7/hal_wcn7850.c
> 
>     Adds necessary symbol exports to support this modularization.
> 
> * Optimization in Data Path:
> 
>    Refactors TX and RX data paths to utilize DP-specific objects, reducing
>    pointer indirection and enhancing cache efficiency. Removes Wi-Fi 7-specific
>    headers from common code, with exceptions for dp_mon.c which will be addressed
>    in a subsequent patch series.
> 
> These changes collectively improve the modular structure of the driver
> by separating common and architecture specific modules and further optimize
> performance-critical paths.
> ---
> Harsh Kumar Bijlani (1):
>    wifi: ath12k: Move DP specific link stats to DP link peer
> 
> Pavankumar Nandeshwar (9):
>    wifi: ath12k: Add callbacks in arch_ops for rx APIs
>    wifi: ath12k: Move DP device stats to ath12k_dp
>    wifi: ath12k: Add helper to free DP link peer
>    wifi: ath12k: Remove the wifi7 header inclusions in common code
>    wifi: ath12k: Move ath12k_dp_rx_frags_cleanup API to Wi-Fi 7
>    wifi: ath12k: Move ath12k_dp_rx_get_peer_id API to Wi-Fi 7
>    wifi: ath12k: Remove arch-specific HAL dependencies from common DP
>    wifi: ath12k: Build all the files in wifi7 directory into
>      ath12k_wifi7.ko
>    wifi: ath12k: Use dp objects in performance critical paths
> 
> Ripan Deuri (2):
>    wifi: ath12k: Move ieee80211_ops callback to the arch specific module
>    wifi: ath12k: Replace lock/unlock with guard()
> 
>   drivers/net/wireless/ath/ath12k/Makefile      |   9 -
>   drivers/net/wireless/ath/ath12k/ahb.c         |   1 -
>   drivers/net/wireless/ath/ath12k/core.c        |   3 +-
>   drivers/net/wireless/ath/ath12k/core.h        |  86 -----
>   drivers/net/wireless/ath/ath12k/debug.c       |   4 +-
>   drivers/net/wireless/ath/ath12k/debugfs.c     |   3 +-
>   drivers/net/wireless/ath/ath12k/debugfs_sta.c |  59 ++-
>   drivers/net/wireless/ath/ath12k/dp.c          |  35 +-
>   drivers/net/wireless/ath/ath12k/dp.h          | 143 ++++++-
>   drivers/net/wireless/ath/ath12k/dp_cmn.h      |  12 +
>   drivers/net/wireless/ath/ath12k/dp_htt.c      |  64 ++--
>   drivers/net/wireless/ath/ath12k/dp_mon.c      | 102 +++--
>   drivers/net/wireless/ath/ath12k/dp_mon.h      |   2 +-
>   drivers/net/wireless/ath/ath12k/dp_peer.c     |  69 +++-
>   drivers/net/wireless/ath/ath12k/dp_peer.h     |  57 +++
>   drivers/net/wireless/ath/ath12k/dp_rx.c       | 146 +++----
>   drivers/net/wireless/ath/ath12k/dp_rx.h       |  53 +--
>   drivers/net/wireless/ath/ath12k/dp_tx.c       |  33 +-
>   drivers/net/wireless/ath/ath12k/dp_tx.h       |   5 +-
>   drivers/net/wireless/ath/ath12k/hal.c         |  26 ++
>   drivers/net/wireless/ath/ath12k/hal.h         |  75 +++-
>   drivers/net/wireless/ath/ath12k/mac.c         | 357 ++++--------------
>   drivers/net/wireless/ath/ath12k/mac.h         |  15 +-
>   drivers/net/wireless/ath/ath12k/peer.c        |   4 +-
>   .../net/wireless/ath/ath12k/wifi7/Makefile    |  10 +-
>   drivers/net/wireless/ath/ath12k/wifi7/dp.c    |  80 ++--
>   drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 266 +++++++------
>   drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |  20 +-
>   drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c | 158 ++++----
>   drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |   2 +-
>   drivers/net/wireless/ath/ath12k/wifi7/hal.c   |   2 +-
>   .../net/wireless/ath/ath12k/wifi7/hal_desc.h  |  50 ---
>   .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |   3 +-
>   .../net/wireless/ath/ath12k/wifi7/hal_rx.c    |  35 +-
>   .../net/wireless/ath/ath12k/wifi7/hal_rx.h    |  22 +-
>   .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |   3 +-
>   drivers/net/wireless/ath/ath12k/wifi7/hw.c    | 208 +++++++++-
>   37 files changed, 1234 insertions(+), 988 deletions(-)
> 
> 
> base-commit: 6633dca572d8f599b0a1ead0f145a52049ec7709

Reviewed-by: Karthikeyan Periyasamy 
<karthikeyan.periyasamy@oss.qualcomm.com>


-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

