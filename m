Return-Path: <linux-wireless+bounces-26887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02297B3D8A9
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 07:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B3EC7A15B0
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Sep 2025 05:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E21220F24;
	Mon,  1 Sep 2025 05:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sri48Gr/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC04515E90
	for <linux-wireless@vger.kernel.org>; Mon,  1 Sep 2025 05:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756704217; cv=none; b=MvqJvgpl1uP8lwtVfJyaB7t0O3z8z06oUDCbsmenG2ZKr4+2swXcZXjzTd1VfVctkX5SomHJ3VHJX5nd0xlQVQSx4dx6HmaOXICK6uYnOY/vwjU27zvuBCfjBFAiouSoxfpKBpOcgb1nBNMnNKUdDA8oJp3au2eF4iXlY0yTGoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756704217; c=relaxed/simple;
	bh=ZC/I6yBwRtT1DVKCP6A7Q6dLRZAPAT7FIhh7SRPofBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBambg2H+TDhJlEX1F/BHcnN1rQD/1bJGQs7jLoC4CX+fwDXN8YyN+t2zVSNO5hp8X5aZoSSKUP1jcabLjUV56vKR5Ge+t8cwp/swIV6LJPuCFqKJrz49qrnVq/ZUiRyeAV5UFz9VqGfIDyAlYimPyM1PW5ewHQAe1P/IrX2tDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sri48Gr/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57VKw4Fc005313
	for <linux-wireless@vger.kernel.org>; Mon, 1 Sep 2025 05:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D8+Z495oqBiTc0wahdk/+1xEayYUpFgX1Ia0/rITxCs=; b=Sri48Gr/w1fAmofn
	im4LEkItz4YhbEVjurO3074Spcsu/N0KcJubhmBq30CE4XLbl8dmUjfuXNsR8W9i
	zg2U1NVGwQ/fktCy+znqTA8VsOQtqubqioRPj9kdb3vFro6KES77AF4DmEUYHNJJ
	jOi0dIK/hz96pv+he3cjxe9GwrMUeYyS+Yju5DLe+kzrdfajqSUD9NjzuydS3okw
	K9OVR3dEGZIV4ytG9K41rjIStU6wKReukhxqx4O3Erl3ZpbXaUhNmPA7maJtwLnM
	lHVz/6/pgpqKg5va61jDbfi5iFRLJDAN4l1/6nkW9rDT4VRRCfmebgVCOP9e5ovW
	tDjodQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuubau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Sep 2025 05:23:34 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e6e71f7c6so3654598b3a.0
        for <linux-wireless@vger.kernel.org>; Sun, 31 Aug 2025 22:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756704213; x=1757309013;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8+Z495oqBiTc0wahdk/+1xEayYUpFgX1Ia0/rITxCs=;
        b=FaAAb5P3oAVhGHymw6pkQRiKE+OnR8eCOTNNPgaZhI8tfrZiXBhVBPcJe4Q2W94A16
         X1RVt9hxbzZoTBdrJDeTLElh7khlsEBQkMWLGKdK+pBGSWHeCwPvre+LH25At8s9/TZP
         9yIunGb5yE5zoyqO+XTX+rn4yfu+5uY9lgQmwtvRpMpoGMFGV7ESQuYbzzDPxR3HEIbo
         31RN5My8QX4eRrymu+X8OR2suGNfZMSr0BrXIjSm2E9MUjcbdylRxd3aTPsVzapu9urY
         cxMta6f/UeBaeVXVwouGN7QV++IXyqrA2YXvK+TbhrWIdhOoJRgZSPTz74UdqFLvVfOA
         TYvQ==
X-Gm-Message-State: AOJu0Yxa+achi4CetzaY/e4/arfDi1ngv60A3O0S+AdN9JsZqE/GpSL8
	+SNae643H8AA5X8tbt2tHcEBjMQJ4RbjOtcfWng7BU/Zsa89IfnJZODXTwF2xU7PYHLX28ERwPe
	86CIz/leTAeNZSl85sYSKVKnnAiOC/aTrAT44ETzQdosfhAEGgPuDvHE5GKClRDYPLcNwCg==
X-Gm-Gg: ASbGnctO0R1mX1U0ifKOr6hxPB/Ruqitny7yBNmEtBVrVy/IOs+SA6mjP+Myu55NShW
	2GpZCoIES7FaNdhPkclskfyt3/hdkZVay0/3ITDJ+ymMzzozn9EqRyNdI4OqyBYUjguHS5Zu5vK
	NGMa46BbZn16Qc3V3DE9lSqerXzqmhVrsoj7BLhro+Mnxdd/1ThRoIfACi+b82y5QwCAIW1a0V9
	HlpG97ahxfru73RUHjADYZ9VOMx+Q0gv0XhIVPY6jo8U9TW6G+jtFIxsNSG/TVwCksg03VKk4lQ
	gfoL9MYnbTY4G1VcTu4uD//P0RfUNU8/NNTdk+lNlxwYW7tPVfuGjWLN9+RrkUouy1axqwh1vXU
	QEyjlVcvNxu69YPEbcbo6/iRFSRV86GdIPW0ENg==
X-Received: by 2002:a05:6a00:1406:b0:772:57ee:fd6c with SMTP id d2e1a72fcca58-77257ef02e5mr3467864b3a.2.1756704213346;
        Sun, 31 Aug 2025 22:23:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHis1QZo4o4wxpJY/7XCl0AFcl2fPXRBXZrV34INgUuVjLDwLlJrPnENWnG6e/8wwGlPN1zPA==
X-Received: by 2002:a05:6a00:1406:b0:772:57ee:fd6c with SMTP id d2e1a72fcca58-77257ef02e5mr3467840b3a.2.1756704212872;
        Sun, 31 Aug 2025 22:23:32 -0700 (PDT)
Received: from [10.133.33.244] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26a1b9sm9175124b3a.7.2025.08.31.22.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Aug 2025 22:23:32 -0700 (PDT)
Message-ID: <786b9049-3542-4447-9263-a51c7074d8c5@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 13:23:28 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath12k-ng 00/20] wifi: ath12k: ath12k file re-organization
To: Ripan Deuri <quic_rdeuri@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <20250828173553.3341351-1-quic_rdeuri@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfXwpDLFtkXYr81
 YzZ0Q3+YNOTNcZYTzdWg1s2txJsJrxicfj4uHbXQVY7vfbJY6biulAYrs7cdR6hO57uZ8vo7SeL
 GfvQntT7bLX5Z2w4uB2gMCMdMbcYiITkD+KrOthYeGWdwq0lKPo2RYFZtX7DMi2nVBdCwHxnuxI
 80KqiXld9SuunxhEKcjis1AChr+2RlOZ1sGdUKYHXqlAF2phXCf+lZDvCXw7H714QakK1NwTRRG
 wh0iix07CfpPvckFAwjZ4IKmL6g2jhxbM1t50pYsKRR/jz70kRt+0K4DSgoXiK25r9VxyyQelMc
 XkT04g+YlPZhb0Q7Lhrp5LMN/dC54fGCNNm0enjKedUNahcRZkxDy/x7X9gFg1ZTtixiUjJQXO9
 s2P4MNPV
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b52dd6 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=oTiaGnL0ubTkpw5IOr4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: _dY7zEAbDghYxxon6ytr9wgMNjGWGBcE
X-Proofpoint-GUID: _dY7zEAbDghYxxon6ytr9wgMNjGWGBcE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031



On 8/29/2025 1:35 AM, Ripan Deuri wrote:
> This patch series continues the modularization work described in the
> https://lore.kernel.org/linux-wireless/20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com
> ("wifi: ath12k: Ath12k modularization changes") series, which established
> the foundation for the Next Generation (NG) ath12k driver framework.
> That series introduced the foundational split of the original ath12k.ko
> into two distinct modules: a common module (ath12k.ko) and an architecture-
> specific module (ath12k_wifi7.ko) for Wi-Fi 7 devices as depicted below.
> 
>                                      +-----------------+
>                                      |                 |
>                                      |   ath12k.ko     |
>                                      |    (common)     |
>    +---------------+                 |                 |
>    |               |                 +-----------------+
>    |   ath12k.ko   |  ===========>
>    |               |                 +------------------+
>    +---------------+                 |                  |
>                                      | ath12k_wifi7.ko  |
>                                      | (wifi7 family)   |
>                                      |                  |
>                                      +------------------+
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
>                           │   ├── dp_rx.h
>                           │   ├── dp_tx.c
>                           │   ├── dp_tx.h
>                           │   ├── hal_desc.h
>                           │   ├── hal_qcn9274.c
>                           │   ├── hal_qcn9274.h
>                           │   ├── hal_rx.c
>                           │   ├── hal_rx.h
>                           │   ├── hal_tx.c
>                           │   ├── hal_tx.h
>                           │   ├── hal_wcn7850.c
>                           │   ├── hal_wcn7850.h
>                           │   ├── rx_desc.h
> 
> 
> Note: While common files are not intended to include architecture-specific
> headers, a few Wi-Fi 7 headers are temporarily included in common files
> across patches to simplify patch splitting. This will be resolved in a
> later series.
> 
> ---
> Harsh Kumar Bijlani (4):
>   wifi: ath12k: Move HTT code in dp.h to newly introduced files
>   wifi: ath12k: Move HTT Rx specific code to newly introduced files
>   wifi: ath12k: Move HTT Tx specific code to newly introduced files
>   wifi: ath12k: Move HTT specific code from dp.c to newly introduced
>     files
> 
> Pavankumar Nandeshwar (16):
>   wifi: ath12k: Move hal_tx and hal_rx to wifi7 directory
>   wifi: ath12k: Move hal_tx.h file to wifi7 directory
>   wifi: ath12k: Move hal_rx.h file to wifi7 directory
>   wifi: ath12k: Move HAL Rx wrapper APIs to dp_rx.h
>   wifi: ath12k: Move Rx error related functions to wifi7 directory
>   wifi: ath12k: Move hal_desc.h file to wifi7 directory
>   wifi: ath12k: Move rx_desc.h file to wifi7 directory
>   wifi: ath12k: Move rxdma ring config functions to wifi7 directory
>   wifi: ath12k: Move rx error and defrag functions to wifi7 directory
>   wifi: ath12k: Move regular msdu processing functions to wifi7
>     directory
>   wifi: ath12k: Move srng processing to wifi7 directory
>   wifi: ath12k: Separate arch specific part of RX APIs
>   wifi: ath12k: Move arch specific REO functions to wifi7 directory
>   wifi: ath12k: Move arch specific rx tid and related functions to wifi7
>     directory
>   wifi: ath12k: Move arch specific tx APIs to wifi7 directory
>   wifi: ath12k: Move ath12k_dp_tx and related APIs to wifi7 directory
> 
>  drivers/net/wireless/ath/ath12k/Makefile      |    9 +-
>  drivers/net/wireless/ath/ath12k/ahb.c         |    3 +-
>  drivers/net/wireless/ath/ath12k/core.h        |    4 +-
>  .../wireless/ath/ath12k/debugfs_htt_stats.h   |    4 +-
>  drivers/net/wireless/ath/ath12k/dp.c          |  159 +-
>  drivers/net/wireless/ath/ath12k/dp.h          | 1518 +-------
>  drivers/net/wireless/ath/ath12k/dp_htt.c      | 1354 ++++++++
>  drivers/net/wireless/ath/ath12k/dp_htt.h      | 1546 +++++++++
>  drivers/net/wireless/ath/ath12k/dp_mon.c      |    4 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.c       | 3056 +----------------
>  drivers/net/wireless/ath/ath12k/dp_rx.h       |  297 +-
>  drivers/net/wireless/ath/ath12k/dp_tx.c       | 1609 +--------
>  drivers/net/wireless/ath/ath12k/dp_tx.h       |   41 +-
>  drivers/net/wireless/ath/ath12k/hal.c         |    8 +-
>  drivers/net/wireless/ath/ath12k/hal.h         |  501 ++-
>  drivers/net/wireless/ath/ath12k/mac.c         |    3 +-
>  drivers/net/wireless/ath/ath12k/pci.c         |    3 +-
>  drivers/net/wireless/ath/ath12k/wifi7/dp.c    |  137 +
>  drivers/net/wireless/ath/ath12k/wifi7/dp.h    |   15 +
>  drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c | 2043 +++++++++++
>  drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |   47 +
>  drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |  908 +++++
>  drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |   14 +
>  .../ath/ath12k/{ => wifi7}/hal_desc.h         |  149 +-
>  .../wireless/ath/ath12k/{ => wifi7}/hal_rx.c  |    8 +-
>  .../wireless/ath/ath12k/{ => wifi7}/hal_rx.h  |  299 +-
>  .../ath12k/{rx_desc.h => wifi7/hal_rx_desc.h} |   48 +-
>  .../wireless/ath/ath12k/{ => wifi7}/hal_tx.c  |    6 +-
>  .../wireless/ath/ath12k/{ => wifi7}/hal_tx.h  |   11 +-
>  drivers/net/wireless/ath/ath12k/wifi7/hw.c    |    4 +-
>  30 files changed, 6993 insertions(+), 6815 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath12k/dp_htt.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/dp_htt.h
>  create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp.h
>  create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h
>  create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h
>  rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_desc.h (95%)
>  rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_rx.c (99%)
>  rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_rx.h (83%)
>  rename drivers/net/wireless/ath/ath12k/{rx_desc.h => wifi7/hal_rx_desc.h} (97%)
>  rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_tx.c (97%)
>  rename drivers/net/wireless/ath/ath12k/{ => wifi7}/hal_tx.h (96%)
> 
> 
> base-commit: 0e487f03c6e5d8dd5b076b8b061e50e736ab2196

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>



