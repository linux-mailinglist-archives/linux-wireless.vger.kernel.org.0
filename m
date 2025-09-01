Return-Path: <linux-wireless+bounces-26896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F42B3ED83
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 19:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB451A87E4A
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 17:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825EE2D5956;
	Mon,  1 Sep 2025 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HJedWBVK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E102747B
	for <linux-wireless@vger.kernel.org>; Mon,  1 Sep 2025 17:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756748997; cv=none; b=PeNzccAtycv3v8sfUhVTgi9KolgN4toCLUcdzuERdFsbKVyQfRyX4cUpcwdMHk7swpmoQ7lzr7gH9pe/XusMjhhpgoasfybcUA9wNdDhRybkX8wAV9OTetiXZkmPG6CeQUMdI4GC0vCgmnl17FtFMjH7QSGVSt6ED7BTTosL0oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756748997; c=relaxed/simple;
	bh=7SIamMJqabkkGtYB1lpU2mtHWYS+PwBI+SJntY4ANcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsij50aJwO/jiioTRx8TBTRDpgovAm0TiKvWyHbTLt4xqlEqJ2+CIP1uHtqpyd3+PLuZJcFat3S9JXHsDxnvyk+RUcnO7swRgF6QRUsn/5lSYCKfxVgQWk/QLqN8UdOc5BLyPRXVwBA8ie7LDmqktZZlFWoxXZe84vIxmR/jI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HJedWBVK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 581B4Eve025207
	for <linux-wireless@vger.kernel.org>; Mon, 1 Sep 2025 17:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RZ714zZjCgPT+LTO+5+/1Eh/mCjZ8QjebkWwadXAfoA=; b=HJedWBVK4EJz3Nnv
	zQt0xb2LXVFbDWcMGSDMQHepkOLIQKZU/BfL1DMmmh8JLtiNwEcsnuyiUEnUYYrR
	8E5FkEtz0w3v3xpyf6CYC0k/wCbnN5A8WtPulYAJoB/U4Z0G2VnW+PEmKw5N7CqV
	yEzw46bsRyJaJTBuyzi4ie4IhQbjpk+BrabAjhHv6O6UVa3A9rapyzfUWjkwUovc
	2mWwmGpyeGzQFzjJu+85rL5GfWy0fvoXuU7DvpuGqBwLX2afXOgKMxUdhjsm4Hrk
	KZ45DGq09iQn5olSBvRs+yrtEu/ieaZYSDLx13Kt8Nr+S+xeuhxS9JOCuzPK83H+
	XGkq/Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fdeb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Sep 2025 17:49:48 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-248fbfc35ddso66164225ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 01 Sep 2025 10:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756748988; x=1757353788;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZ714zZjCgPT+LTO+5+/1Eh/mCjZ8QjebkWwadXAfoA=;
        b=UbQL3JdrfMHv2h8drfqGMjFtpxqXuaXfqTsGZEZZaXhZz3zbaGRSiHOGE3BM9BMvV4
         w7VtEX8AOEEdiQ37wkY1lORD0MbQmUsdo/kPi8sqcBPy2AxceYbalnxfjFlsDWbzOYZ/
         IJ5/lFTF/v6WuRlV17zR36kkBgu1I+Y2eaVFRaEneHcIZRA5CRU38NPt7twCLcLM67A9
         Wx2yg1yyU7KiOf2iO+ZKJ2dMkCAykHku7Ns8Quj4oCDDBATgFejg9rON6ATjktqlh6yk
         i/XccRiVq4nq0y+UwQ835hUP6AninV4TEX7cGZ5mwww/6wIHXIo/7TSyvEf1vAW1O3eo
         rQyA==
X-Gm-Message-State: AOJu0YzpF8k0BtrWCrRAwQ1BmbFfwMB2FfR+SaLFy6xH1T1thpCZukRd
	H7OhaSQ/bc7i6b1jRjjMz/fgP2C2bCcc6bmlJrHP8Bz2udypLn/Yej5mJFvG7h+1D5N3iR5COPN
	yOuSKOLjlstzPtCoH/Y2BaoUTtmXNOkAwb3Fpi5X75gYN/vyRCQH6HSVBVKgunbn68Ctqlw==
X-Gm-Gg: ASbGncuz9KC3KjmJ6hwmdfk3+6A6i9JqxApafiUhbDY/R1VbNRM/+cLDtYOISGJXl1w
	Un3c/oAXaDuUmenDAUPUdElaDCyoZQT7ruV4oszZo+2XxRbmH5OUEOTG9TXOfI87eoeoisN3eTN
	YFpM+6+CaotCzDrk2CGEarvxLHWYnViuwEUGmWk4WqJMg7f3K1A74/qRC5sWp79ru/w0nHsN4me
	uMdIAdIGjO2Bfgn3qWHf+9C0suhn2j1idGeSSizHia+vGofp9DSqeK/CiouWHHlWauvaSO7RG36
	EEuVHBlWpW1VnblCglJvOXq3Ib/PjkuvlffZ3omNXjFvw59ZiCGt7h1OLXu4YTroLd+kSna5aQD
	q+LL/D3UvhLPe
X-Received: by 2002:a17:902:d50a:b0:249:3eec:15be with SMTP id d9443c01a7336-249448dfbe1mr100345495ad.21.1756748987703;
        Mon, 01 Sep 2025 10:49:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK2aeQcLukriSxTesG3QL3M5PBi/cU1mSHohVrewW0Ht0HVaoSAxlfmjZ5oIA5eSH/KL3Mbw==
X-Received: by 2002:a17:902:d50a:b0:249:3eec:15be with SMTP id d9443c01a7336-249448dfbe1mr100345185ad.21.1756748987024;
        Mon, 01 Sep 2025 10:49:47 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.223.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906598808sm107919325ad.116.2025.09.01.10.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 10:49:46 -0700 (PDT)
Message-ID: <353a4e7b-53c3-5dd7-ad67-79cba1d34dbd@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 23:19:43 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath12k-ng 00/20] wifi: ath12k: ath12k file re-organization
Content-Language: en-US
To: Ripan Deuri <quic_rdeuri@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX5cp+GbrmXd6A
 lKgfTw1HiDdSoi3ZuKu9z3/rR1vFlX+eLnKJaTvIF1ksBwJAXuXyWfWK7fYeam/uRKO/kNC2Quh
 sf11xjcnngZ4Fn+DDfsE4LvF4iZP/Am9cnwESsTJ2wDN1zZnH3tkSbkRjSn+BXlYdhiPccSatzF
 3zs6nvvHUtu14jpvuHgSVZeKxlH6Fl/zK9Kn41+8fqB4UdwsTIWlKqwIsKLGmHDEOJwK9Jo6TxC
 Xyb1dxbp6sN+XanTBFqUgES9nHq9Sr8+1BPxUknFsuXQpzPnIq24FSiyeqTCwjFFcmFexQXqj8a
 g0y1rY/djTk+SOD4jQyaI2dPJJ8dBVzZFfDes2+cx3hJeHiICGZnwswRmdEgnPUPgnNNfwrBllZ
 3Vc5IJ7c
X-Proofpoint-ORIG-GUID: YVBHQ30P4Vh0jRKKIfLn4jz1vuTQ4for
X-Proofpoint-GUID: YVBHQ30P4Vh0jRKKIfLn4jz1vuTQ4for
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b5dcbc cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=wqpLlJzFoOPNlw0GHb3lZQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=D2z4QRl0f1DbYJdCtzwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038



On 8/28/2025 11:05 PM, Ripan Deuri wrote:
> This patch series continues the modularization work described in the
> https://lore.kernel.org/linux-wireless/20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com
> ("wifi: ath12k: Ath12k modularization changes") series, which established
> the foundation for the Next Generation (NG) ath12k driver framework.
> That series introduced the foundational split of the original ath12k.ko
> into two distinct modules: a common module (ath12k.ko) and an architecture-
> specific module (ath12k_wifi7.ko) for Wi-Fi 7 devices as depicted below.
> 
>                                       +-----------------+
>                                       |                 |
>                                       |   ath12k.ko     |
>                                       |    (common)     |
>     +---------------+                 |                 |
>     |               |                 +-----------------+
>     |   ath12k.ko   |  ===========>
>     |               |                 +------------------+
>     +---------------+                 |                  |
>                                       | ath12k_wifi7.ko  |
>                                       | (wifi7 family)   |
>                                       |                  |
>                                       +------------------+
> 
> Building on that framework, this series focuses on modularizing the Data Path
> (DP) of the ath12k driver, allowing the common DP to be reused across different
> hardware architectures.
> 
> The patches included here support the NG framework objective by reorganizing
> DP-specific files and the directory structure as outlined below.
> 
> Existing file org             New file org
> -----------------             ------------
> ├── dp.c                  ├── dp.c
> ├── dp.h                  ├── dp.h
> ├── dp_rx.c               ├── dp_htt.c
> ├── dp_rx.h               ├── dp_htt.h
> ├── dp_tx.c               ├── dp_rx.c
> ├── dp_tx.h               ├── dp_rx.h
> ├── hal.c                 ├── dp_tx.c
> ├── hal_desc.h            ├── dp_tx.h
> ├── hal.h                 ├── hal.c
> ├── hal_rx.c              ├── hal.h
> ├── hal_rx.h              ├── wifi7
> ├── hal_tx.c              │   ├── dp.c
> ├── hal_tx.h              │   ├── dp_rx.c
>                            │   ├── dp_rx.h
>                            │   ├── dp_tx.c
>                            │   ├── dp_tx.h
>                            │   ├── hal_desc.h
>                            │   ├── hal_qcn9274.c
>                            │   ├── hal_qcn9274.h
>                            │   ├── hal_rx.c
>                            │   ├── hal_rx.h
>                            │   ├── hal_tx.c
>                            │   ├── hal_tx.h
>                            │   ├── hal_wcn7850.c
>                            │   ├── hal_wcn7850.h
>                            │   ├── rx_desc.h
> 
> 
> Note: While common files are not intended to include architecture-specific
> headers, a few Wi-Fi 7 headers are temporarily included in common files
> across patches to simplify patch splitting. This will be resolved in a
> later series.
> 
> ---
> Harsh Kumar Bijlani (4):
>    wifi: ath12k: Move HTT code in dp.h to newly introduced files
>    wifi: ath12k: Move HTT Rx specific code to newly introduced files
>    wifi: ath12k: Move HTT Tx specific code to newly introduced files
>    wifi: ath12k: Move HTT specific code from dp.c to newly introduced
>      files
> 
> Pavankumar Nandeshwar (16):
>    wifi: ath12k: Move hal_tx and hal_rx to wifi7 directory
>    wifi: ath12k: Move hal_tx.h file to wifi7 directory
>    wifi: ath12k: Move hal_rx.h file to wifi7 directory
>    wifi: ath12k: Move HAL Rx wrapper APIs to dp_rx.h
>    wifi: ath12k: Move Rx error related functions to wifi7 directory
>    wifi: ath12k: Move hal_desc.h file to wifi7 directory
>    wifi: ath12k: Move rx_desc.h file to wifi7 directory
>    wifi: ath12k: Move rxdma ring config functions to wifi7 directory
>    wifi: ath12k: Move rx error and defrag functions to wifi7 directory
>    wifi: ath12k: Move regular msdu processing functions to wifi7
>      directory
>    wifi: ath12k: Move srng processing to wifi7 directory
>    wifi: ath12k: Separate arch specific part of RX APIs
>    wifi: ath12k: Move arch specific REO functions to wifi7 directory
>    wifi: ath12k: Move arch specific rx tid and related functions to wifi7
>      directory
>    wifi: ath12k: Move arch specific tx APIs to wifi7 directory
>    wifi: ath12k: Move ath12k_dp_tx and related APIs to wifi7 directory
> 
>   drivers/net/wireless/ath/ath12k/Makefile      |    9 +-
>   drivers/net/wireless/ath/ath12k/ahb.c         |    3 +-
>   drivers/net/wireless/ath/ath12k/core.h        |    4 +-
>   .../wireless/ath/ath12k/debugfs_htt_stats.h   |    4 +-
>   drivers/net/wireless/ath/ath12k/dp.c          |  159 +-
>   drivers/net/wireless/ath/ath12k/dp.h          | 1518 +-------
>   drivers/net/wireless/ath/ath12k/dp_htt.c      | 1354 ++++++++
>   drivers/net/wireless/ath/ath12k/dp_htt.h      | 1546 +++++++++
>   drivers/net/wireless/ath/ath12k/dp_mon.c      |    4 +-
>   drivers/net/wireless/ath/ath12k/dp_rx.c       | 3056 +----------------
>   drivers/net/wireless/ath/ath12k/dp_rx.h       |  297 +-
>   drivers/net/wireless/ath/ath12k/dp_tx.c       | 1609 +--------
>   drivers/net/wireless/ath/ath12k/dp_tx.h       |   41 +-
>   drivers/net/wireless/ath/ath12k/hal.c         |    8 +-
>   drivers/net/wireless/ath/ath12k/hal.h         |  501 ++-
>   drivers/net/wireless/ath/ath12k/mac.c         |    3 +-
>   drivers/net/wireless/ath/ath12k/pci.c         |    3 +-
>   drivers/net/wireless/ath/ath12k/wifi7/dp.c    |  137 +
>   drivers/net/wireless/ath/ath12k/wifi7/dp.h    |   15 +
>   drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 2043 +++++++++++
>   drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |   47 +
>   drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |  908 +++++
>   drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |   14 +
>   .../ath/ath12k/{ => wifi7}/hal_desc.h         |  149 +-
>   .../wireless/ath/ath12k/{ => wifi7}/hal_rx.c  |    8 +-
>   .../wireless/ath/ath12k/{ => wifi7}/hal_rx.h  |  299 +-
>   .../ath12k/{rx_desc.h => wifi7/hal_rx_desc.h} |   48 +-
>   .../wireless/ath/ath12k/{ => wifi7}/hal_tx.c  |    6 +-
>   .../wireless/ath/ath12k/{ => wifi7}/hal_tx.h  |   11 +-
>   drivers/net/wireless/ath/ath12k/wifi7/hw.c    |    4 +-
>   30 files changed, 6993 insertions(+), 6815 deletions(-)
>   create mode 100644 drivers/net/wireless/ath/ath12k/dp_htt.c
>   create mode 100644 drivers/net/wireless/ath/ath12k/dp_htt.h
>   create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp.c
>   create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp.h
>   create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
>   create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
>   create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
>   create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
>   rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_desc.h (95%)
>   rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_rx.c (99%)
>   rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_rx.h (83%)
>   rename drivers/net/wireless/ath/ath12k/{rx_desc.h => wifi7/hal_rx_desc.h} (97%)
>   rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_tx.c (97%)
>   rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_tx.h (96%)
> 

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

