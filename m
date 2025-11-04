Return-Path: <linux-wireless+bounces-28514-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E01C2EDEF
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 02:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D77B54E3B20
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 01:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE4A21ABBB;
	Tue,  4 Nov 2025 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dlDIJUMe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PrAlWonj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8644F72614
	for <linux-wireless@vger.kernel.org>; Tue,  4 Nov 2025 01:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762220880; cv=none; b=f8jR8SY1B+hQUcOEKLKnuaUbBXI3vMs8dUNfWDmw40g3vDpIP+YsamP9T4Vp07FT+XLfJCStmEm1JxsOhU0sFHbZrEPr7xemEE6J1/pP8ih430vN67EZ8WMuST8lQN3lDq/JY9U0TMWdJCKswazw22lX+vLnIDPg/0OphxePZf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762220880; c=relaxed/simple;
	bh=R84tTMfqdhNjCLf23M/zIAMhH12EfAsMXDTVVEQ9k2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EtDaW5ZWWf0cm9AfvL4YW8KPwNVwm9K8tmqThRyPpF7qeoMJc9sxRtXeCNeBZbYn/lMlfuRNUI+dW+9O6IG4FG9/eDrSQdPxOMTTR0Pr7kFQof5wSD1t75ScRgHA60Gg+VrJzv1DVXEQ/+idaS+/8wejKsLWC0pbdj5dYaeGwms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dlDIJUMe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PrAlWonj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3H3G8V3595521
	for <linux-wireless@vger.kernel.org>; Tue, 4 Nov 2025 01:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ss2s0SQUEfRdHrtOvT0d01xdStXCTvP1hYs31LtuIcI=; b=dlDIJUMe1DdaECgD
	ncn3cEzCIUBrVyLq8IyXNQRbUqceE3Onm9yQgTOT7se282UgizHI3bxHGuuXkhhP
	jc9kEivrvY1OjNuEa6Ve+Az8aMAGCLit8RoF4T1gc2LMYAI2QP+GXZSufwdc+Qpy
	ofcRj+MkZuVCTyKBf9tcbFsNZqkIuT1+RUocZGSLJbTIT8uStiT3hYnZiAZY0c9u
	arIdwFOv/MP4U5zRtl0J4OywIBLPbJ8t4lK2ieUZ0jBs9QAUsyx9nhztid/rn2D1
	VzHBRjelgGtwkrCJEye5NoCMrwO+oyEix2Q3Cj5FNSHVXdwDUDBZ65YEcnquVgxk
	HxdXLA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70exh8h1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 04 Nov 2025 01:47:57 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340299cc2ecso5741802a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 03 Nov 2025 17:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762220877; x=1762825677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ss2s0SQUEfRdHrtOvT0d01xdStXCTvP1hYs31LtuIcI=;
        b=PrAlWonjRQguV+xR8zJxNpCABjczS4lLOQwCiZ7PlJ29UhaLzA8qZUYLLGp2oywO+I
         TgLVpuBSPpWLKWFNDU3u2qtBtwIPbmtpnDq2//y3EhUEmjhgkbprqcHer5iLnQJKWt83
         SYju2XvBbueWAy+HphXJn34Ckfc+w4paEZ/Jlv8ukvM7vaStl5CvZeDLdSHBkPcgSF/8
         TdCoSI9EsiR8f3t1JKHHPGPtyUlL5UTPOjZpkKZvZCATA+wAAaQPQFaMvHmjY4orl9Ak
         H1hjcdTKlSTjjtCHPsE/RtALOUTMLKX/2qwUF7Lh4eH3XyWD3ArVEe6MZ4AJv2MBkTa1
         NSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762220877; x=1762825677;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ss2s0SQUEfRdHrtOvT0d01xdStXCTvP1hYs31LtuIcI=;
        b=mqM3XRfx3j5i0xSRsOJtgV0WwAU/cuv1cCA738/p77Jz6mPtUpjraQ9PUs/xfM6GW0
         7IGFyo+flii+Qh4EGFUSW3ApWHRdiT/uwxjl6Z5r/9VUikFGlJC16d0sWZgQDpLvdjGS
         uc7PBbNtKohr58/M5nR0/9BjoYk36Fr6Q6DlKvfctATgHJd0to3YLuMlb92BKje1oIz1
         hPEhgpmxfF29gyYzrAQqW7U8OCRGxFEDa/r9gpznGj2QoW34TB5Qzqcvh5YYVlXErnhm
         BJLFl+RCdxY2BT1Tsr5/hrjLZdWB8GM4lA0NHRyxXP89NScsbmHYSaXMd5b8Jn5xzqfc
         docw==
X-Gm-Message-State: AOJu0YwS3iQvj/35WI7/fPqag1ss38BWwKQ54dnM4JVZrLMRt6FFZdT4
	RvlKTv/obvS+iiS224XwMuetepOmEUX0rZ8PtcZY6j9yYC8PNBKHSKOudTB8VSUhWmD+LFn10j9
	BnzaZKERjHd5Ej8WMQPw7c4gAMDh6D2FvvQtRRoIaZeQhXfw3nzcpzc+3WXbDQOKSWfmaOA==
X-Gm-Gg: ASbGncvG3qY6oQpo0r0cpYJZ4aKwf752CArt9GE+wcVHa9ETaLhP860Qdeoamk9LVeq
	jkoWUJetE/6tvZF15l7gYihIRw9jhNt8RYbTPiFDW2f1WC6EM67Mk1iaciWkkP5I+E2IHyxgkde
	eSx+fVxO7hlnBe5px3Xql3t8SIqQJ0dtviIIO98X3foYGjNam6RhO6UFc2geE8mb8GfAws82FUU
	pJvsmVkbmWbAgnVP63k9PKisf56xquRKDQi0If4oujzSHCDquDzrNyngOIz1Y3WzBpB8Y58+0J0
	FTyfa5GnDbI4CDX8pW1hYhcABeuvrOgW7ddsGYGQ51KwecpD9MFjFskkpkUoFm+vYVdMf9NMWXj
	PSb10X538hfEFCsy6gyOuaTtlTGNk3hCYJGJpkz6g/jEWuouAX+e4DnfBpNA5lxjOF3yFE2Y=
X-Received: by 2002:a17:90b:3c12:b0:340:f05a:3ece with SMTP id 98e67ed59e1d1-34171892c55mr1778683a91.9.1762220876848;
        Mon, 03 Nov 2025 17:47:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmWd3zXVI8Ds/jn9S5qUDaqyu7FUq5QO010Bi1KzeyVALDHU0a2yaQ+EY72c8KFAOCAiVcUw==
X-Received: by 2002:a17:90b:3c12:b0:340:f05a:3ece with SMTP id 98e67ed59e1d1-34171892c55mr1778641a91.9.1762220876134;
        Mon, 03 Nov 2025 17:47:56 -0800 (PST)
Received: from [10.133.33.42] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a15b6fsm2509419a91.18.2025.11.03.17.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 17:47:55 -0800 (PST)
Message-ID: <998a4cfc-aa03-4012-aeef-d2d939055cf5@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 09:47:50 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath12k-ng 00/12] wifi: ath12k: Modularize Wi-Fi 7
 components and refactor data path structures
To: Ripan Deuri <quic_rdeuri@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251103112111.2260639-1-quic_rdeuri@quicinc.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251103112111.2260639-1-quic_rdeuri@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=APHuRV3Y c=1 sm=1 tr=0 ts=69095b4d cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=TaeUBvNaWf7mcxGDrIQA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 0cQfG3wrHGlJXC3AevmuJ5QeC4jn26hu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDAxMyBTYWx0ZWRfX19sofo9TYwOD
 r0bFLaqEB5jeaDfF6W8q5H5Qlq/LkG4YvevUgD8+3ku2a2g4KyV8lTdxwJEs8cXq1N1em8sSXBC
 chJKgED7YyAbKNAzQXanG/aJu6qTRLvNYxnAsp6wkR6SNCNYm+P+1fKmaF/0ne5BGa+CWRWDv8Q
 /yXKCpn3XATBzRtrMkSlU2wL8RKkAm2wRG5/VC6QiIqZuYx0JloFeXe7EcaWGG9cm0xFTGNPMBU
 OreeLrZDJnhCCgTO4GDtBUvtc3Lsa6FjuBNG6wpX4TH1N2hr9UJXKL1eGPiTNfIdXH4VT8XniqU
 MwvsScqH41ZgV1OQiSlhIzvZpMBECkCZJzcPz9EKn75w+GahEQyXQyT9GpWN3D2ALm5eBFbqe/r
 akbrEgKyEhwOY84Sc1ya8JVyuu5fGg==
X-Proofpoint-ORIG-GUID: 0cQfG3wrHGlJXC3AevmuJ5QeC4jn26hu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040013



On 11/3/2025 7:20 PM, Ripan Deuri wrote:
> This patch series introduces a comprehensive set of changes aimed at enhancing
> the modularity and maintainability of the ath12k driver, in the context of
> Wi-Fi 7 support. The key updates include:
> 
> * Callback Integration for Wi-Fi 7 RX APIs:
> 
>    Introduces callbacks in arch_ops for RX-related APIs defined in the Wi-Fi 7
>    module. Adds wrapper functions to invoke these callbacks from the common
>    code. Enables seamless interaction between ath12k.ko and ath12k_wifi7.ko by
>    leveraging the ops mechanism.
> 
> * Data Path Modularization:
> 
>    Macro Refactoring: Moves shared macro definitions from dp.h to cmn_defs.h to
>    improve code organization.
> 
>    Device Stats Consolidation: Relocates device stats from ath12k_base to
>    ath12k_dp, centralizing all SOC-level stats within the data path module.
> 
>    Peer Stats Modularization: Relocates data path stats from ath12_link_sta to
>    ath12k_dp_link_peer, aligning with the modular peer architecture and
>    improving maintainability.
> 
> * Wi-Fi 7 Specific File Reorganization:
> 
>    Moves the following files to be built as part of ath12k_wifi7.ko:
> 
>    wifi7/hal_tx.c
>    wifi7/hal_rx.c
>    wifi7/dp_rx.c
>    wifi7/dp_tx.c
>    wifi7/dp.c
>    wifi7/hal.c
>    wifi7/hal_qcn9274.c
>    wifi7/hal_wcn7850.c
> 
>    Adds necessary symbol exports to support this modularization.
> 
> * Optimization in Data Path:
> 
>   Refactors TX and RX data paths to utilize DP-specific objects, reducing
>   pointer indirection and enhancing cache efficiency. Removes Wi-Fi 7-specific
>   headers from common code, with exceptions for dp_mon.c which will be addressed
>   in a subsequent patch series.
> 
> These changes collectively improve the modular structure of the driver
> by separating common and architecture specific modules and further optimize
> performance-critical paths.
> ---
> Harsh Kumar Bijlani (1):
>   wifi: ath12k: Move DP specific link stats to DP link peer
> 
> Pavankumar Nandeshwar (9):
>   wifi: ath12k: Add callbacks in arch_ops for rx APIs
>   wifi: ath12k: Move DP device stats to ath12k_dp
>   wifi: ath12k: Add helper to free DP link peer
>   wifi: ath12k: Remove the wifi7 header inclusions in common code
>   wifi: ath12k: Move ath12k_dp_rx_frags_cleanup API to Wi-Fi 7
>   wifi: ath12k: Move ath12k_dp_rx_get_peer_id API to Wi-Fi 7
>   wifi: ath12k: Remove arch-specific HAL dependencies from common DP
>   wifi: ath12k: Build all the files in wifi7 directory into
>     ath12k_wifi7.ko
>   wifi: ath12k: Use dp objects in performance critical paths
> 
> Ripan Deuri (2):
>   wifi: ath12k: Move ieee80211_ops callback to the arch specific module
>   wifi: ath12k: Replace lock/unlock with guard()
> 
>  drivers/net/wireless/ath/ath12k/Makefile      |   9 -
>  drivers/net/wireless/ath/ath12k/ahb.c         |   1 -
>  drivers/net/wireless/ath/ath12k/core.c        |   3 +-
>  drivers/net/wireless/ath/ath12k/core.h        |  86 -----
>  drivers/net/wireless/ath/ath12k/debug.c       |   4 +-
>  drivers/net/wireless/ath/ath12k/debugfs.c     |   3 +-
>  drivers/net/wireless/ath/ath12k/debugfs_sta.c |  59 ++-
>  drivers/net/wireless/ath/ath12k/dp.c          |  35 +-
>  drivers/net/wireless/ath/ath12k/dp.h          | 143 ++++++-
>  drivers/net/wireless/ath/ath12k/dp_cmn.h      |  12 +
>  drivers/net/wireless/ath/ath12k/dp_htt.c      |  64 ++--
>  drivers/net/wireless/ath/ath12k/dp_mon.c      | 102 +++--
>  drivers/net/wireless/ath/ath12k/dp_mon.h      |   2 +-
>  drivers/net/wireless/ath/ath12k/dp_peer.c     |  69 +++-
>  drivers/net/wireless/ath/ath12k/dp_peer.h     |  57 +++
>  drivers/net/wireless/ath/ath12k/dp_rx.c       | 146 +++----
>  drivers/net/wireless/ath/ath12k/dp_rx.h       |  53 +--
>  drivers/net/wireless/ath/ath12k/dp_tx.c       |  33 +-
>  drivers/net/wireless/ath/ath12k/dp_tx.h       |   5 +-
>  drivers/net/wireless/ath/ath12k/hal.c         |  26 ++
>  drivers/net/wireless/ath/ath12k/hal.h         |  75 +++-
>  drivers/net/wireless/ath/ath12k/mac.c         | 357 ++++--------------
>  drivers/net/wireless/ath/ath12k/mac.h         |  15 +-
>  drivers/net/wireless/ath/ath12k/peer.c        |   4 +-
>  .../net/wireless/ath/ath12k/wifi7/Makefile    |  10 +-
>  drivers/net/wireless/ath/ath12k/wifi7/dp.c    |  80 ++--
>  drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 266 +++++++------
>  drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |  20 +-
>  drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c | 158 ++++----
>  drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |   2 +-
>  drivers/net/wireless/ath/ath12k/wifi7/hal.c   |   2 +-
>  .../net/wireless/ath/ath12k/wifi7/hal_desc.h  |  50 ---
>  .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |   3 +-
>  .../net/wireless/ath/ath12k/wifi7/hal_rx.c    |  35 +-
>  .../net/wireless/ath/ath12k/wifi7/hal_rx.h    |  22 +-
>  .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |   3 +-
>  drivers/net/wireless/ath/ath12k/wifi7/hw.c    | 208 +++++++++-
>  37 files changed, 1234 insertions(+), 988 deletions(-)
> 
> 
> base-commit: 6633dca572d8f599b0a1ead0f145a52049ec7709

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


