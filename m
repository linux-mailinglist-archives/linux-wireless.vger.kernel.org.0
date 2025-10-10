Return-Path: <linux-wireless+bounces-27927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEABBCB819
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Oct 2025 05:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3063A03CD
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Oct 2025 03:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D2523A58B;
	Fri, 10 Oct 2025 03:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gOiTOJVv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8559F156237
	for <linux-wireless@vger.kernel.org>; Fri, 10 Oct 2025 03:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760066721; cv=none; b=YpeCQg3Ca2zNdEzloTtReqMU7HCfRSIra6C66+XTaLf4AJ3TMmczW0Oj00c2fzuN5y091TRoAu94kI8FFvHhi0C79lrK/+xcz3gQ+Lm5EQJ1oonSM+cQpKx/OWvN2B4wSpJdY10iCIhBj+vrECiSEHOWGsr7R/mEXQlJfuwp/Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760066721; c=relaxed/simple;
	bh=npA4fLB2+sGHlaBPfIAhUzNBf2HaiFCEgTVbmuo9EkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUYqJJTsqsjlQQCPdj+VXzvW0BuXYkK8XWwgZUhD4aIVTRiTBII3n56AmE65M6khWrg0OA9vYeIXC0QeFkdddoN5YMn4YWcDkE5M/6eZrziRW/w7bnVEJKZJbb0tDIibE3rVpl9oKLURNRDndSLEy+bzXO1k44s8CeWMjAqSvQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gOiTOJVv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599NLmha011037
	for <linux-wireless@vger.kernel.org>; Fri, 10 Oct 2025 03:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jjnRP2v3BiYbEeMbTq/UCfeFdb8g+UuGKL4qxyxvlr0=; b=gOiTOJVvBz9E+VQh
	RjvoI5amfeAo9W2+5ADyipDs+LQ/AOBS/ZdUtL4swuc5JqKohc2fRamop1EyjDuS
	Gk1pneGczxCDhYLFvmYOwJjU1RIbKm3utKOJ5np+sxwLXhTr+20Br0PSjPCQOVkv
	JoG9B0uZJCdeo7EB3u5UTECiNvd3XIHzoAmr3LZzmTNP9Z1AahSem/sVYKL8c3S0
	/qMXmTt5mNqssmsClzq87pAWqzv/vCBMv3Nn+mjGx6fiqQnlYtbNX+jG7AVgjzr1
	83oWoDk2F4WSgPuuzmoJMsq0ZSt8RKGRSP862yBhijjzM5kHvFYRCWGs8nURhshM
	poLqSA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4j50hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Oct 2025 03:25:18 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-269939bfccbso31931125ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Oct 2025 20:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760066718; x=1760671518;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjnRP2v3BiYbEeMbTq/UCfeFdb8g+UuGKL4qxyxvlr0=;
        b=idVOL1HLOuVYZEW7hTqW1sn1NoyNUbWl4ZVkKbsC0eZMyLWP9lR00wDjucCDuxkDzV
         5AHtsbpYA6L4wpOi0vOya+WfVdwTY6lWWHYE4x7Usvq410M9dn168Mfd2TxeZacK41JL
         fb8cd+S4Teu8wrRg4jmVsF7E11/UwP6sTvkn/V0IRdsiFyAPSsgS1ven3JgEb9OSMsFn
         tBK3BVijh3YasXqmvHeWF/XBQ/kTMDJ9e8OEUjnAG25l1WnBuwVlDgNte0bcgyxCCewU
         yroXuLHFy1PWmON+ZBtdKKvEOl5xIhoD8HWpuGzyRAs8Wr60cpAuT2nKOag7dr2ADEzJ
         cY0Q==
X-Gm-Message-State: AOJu0Yxd1mRphlicSDtY9+l6fO3KGqTqQiuNSj8wZ7I7kkbG+wXOxt4F
	eFRWGPm99o/7PFYqPTfxo0Gu/xpJ8a3ykhxYAyNyjQ0cwNtGhZTeVPscdwALc8v47ZESJ+HNYmo
	giYniyq+r0QOMsw8OtzobHUsImMX/vkGm/fn+BpIoh1yLwZfP6qYtTPmLSzqzx8ZvvLDS1w==
X-Gm-Gg: ASbGncvsWGCNY13Vj8ZlAi0YGKDoXEIyuqj0n1EqNO5ZNWABm4VbroO2NOy7NzXD1GR
	n2l+1nOXqEGMMBwtPuCtlQTv9vqCF4jdu0ShA586GmkJPOq6q/ZZ5aaSrdPZMU68rTUi4cyE9Oc
	GeG9YqzF7bEPxTJeJ4HKBt7UFtOpfz+iIQhZBePpii/MEt//M5JaBqjCo/UUadWOVJeP8iXGpdz
	KA/sWPDNqZFEvbmc6Rj6B7C7o0Dhx/JfVtlW6T8MRV+T7kkKlrvlPgF7boO3+W+UN346t+ad10F
	v5QGNsWtqnW0YKE8U2V5Q6Nag8OuH6aIxCYgt9tQS3vDlkNP3TwZL7ENWzOdsA3WRhvcc8D2QhG
	Vc4oQNjKeqy82tAtmi9LjEr/hWMMvfYbN68HzTA==
X-Received: by 2002:a17:902:e943:b0:267:a230:c657 with SMTP id d9443c01a7336-2902739a8fdmr139668655ad.24.1760066716991;
        Thu, 09 Oct 2025 20:25:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi0k/lBjaJ7gf3tNWOmXPObyFYvcCE86FFZuXJTMOyvqHgOjBPYCnSbsc1NeqhNdlW8QzGEw==
X-Received: by 2002:a17:902:e943:b0:267:a230:c657 with SMTP id d9443c01a7336-2902739a8fdmr139668325ad.24.1760066716415;
        Thu, 09 Oct 2025 20:25:16 -0700 (PDT)
Received: from [10.133.33.228] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626e94aasm1050256a91.24.2025.10.09.20.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 20:25:15 -0700 (PDT)
Message-ID: <036bcbb0-49d2-48b7-a1d4-1b23f823c276@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 11:25:12 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath12k-ng 00/18] wifi: ath12k: HAL changes for Next
 Generation Driver
To: Ripan Deuri <quic_rdeuri@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Ni5k3XoBg0vB-knj4objiFnn99-GirV1
X-Proofpoint-ORIG-GUID: Ni5k3XoBg0vB-knj4objiFnn99-GirV1
X-Authority-Analysis: v=2.4 cv=f91FxeyM c=1 sm=1 tr=0 ts=68e87c9e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=wDS-lHI4qrE1dolQj4MA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX00GStauNnCwm
 QOEXyfz84g8HZQz4LfSfM0e2/94n/CE1uVrEe1Ic7YIkEB/yv/oKcQtqbPK+Jf7EyadWPqe1bHJ
 A+x9LPb3RXjOCIbv7qo95KioqkS54dpeh+Kx5+LKsB1KrrA20ByHK13eJtGLr+15Zq+TdtBc4LZ
 GmozCFsTo0zfgv34YO+WrkcIFgQzlAsqY4uiT0kZkzM8D5gLVMWexLucDvNyhWvSV15uIvQYW9e
 6T2EpbQS5HLJNejgE3Q1q08DM6gfIzCK5xlsky5WDNvAdblePsa2J1RT7Msj1+ywx5rkiELJ1Es
 7jHskLsOs+u2OpMbanVxlxFscGqw+6GvtKDqJa4tJquedKsntJm+FPCwAZtjxsmLNC0MpODNy5c
 pHwxNDi/eAJVgB3eJr6XP8rBn3kALw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121



On 10/9/2025 7:10 PM, Ripan Deuri wrote:
> The primary objective of this set is to modify the HAL layer
> to suit the multi-KO model. The HAL APIs will be implemented
> differently as required by different chipsets and these
> implementations will be abstracted using an ops mechanism
> (by registering function pointer callbacks). The hw specific
> implementations will be registered as callbacks in the hal_ops.
> 
> 			common hal API
> 				|
> 				|
> 				|
> 				|
> 	=============================================
> 			     hal_ops
> 	=============================================
> 	 _______________              _______________
> 	|       |       |            |       |       |
> 	|       |       |            |       |       |
> 	| qcn   | wcn   |            | qcn   | wcn   |
> 	| device| device|            | device| device|
> 	|_______|_______|            |_______|_______|
> 
> 	  ath12k_wifi7.ko             ath12k_wifi8.ko
> 
> Also, the hal structures that are specific to HW (wifi7) are
> kept within hal headers in wifi7 directory and the structures
> that are common are placed in the headers present in the ath12k
> directory.
> ---
> Pavankumar Nandeshwar (16):
>   wifi: ath12k: Move srng config and hal_ops to hw specific hal files
>   wifi: ath12k: Initialize desc_size through hal_init
>   wifi: ath12k: Initialize hal_ops through hal_init
>   wifi: ath12k: Move wbm_rbm_map to hw specific hal files
>   wifi: ath12k: Move hal_params and regs to hal from hw
>   wifi: ath12k: Add direct HAL pointer in ath12k_dp
>   wifi: ath12k: Use hal handle instead of ab handle
>   wifi: ath12k: Move HAL CE setup and SRNG related APIs to wifi7
>     directory
>   wifi: ath12k: Move HAL SRNG shadow config and get ring id APIs to
>     wifi7 directory
>   wifi: ath12k: Move HAL CE desc related APIs to wifi7 directory
>   wifi: ath12k: Move HAL CE status and set link desc addr APIs to wifi7
>     directory
>   wifi: ath12k: Move HAL Tx, REO and link idle setup related APIs to
>     wifi7 directory
>   wifi: ath12k: Move HAL REO and Rx buf related APIs to wifi7 directory
>   wifi: ath12k: Move HAL Cookie Conversion and RBM related APIs to wifi7
>     directory
>   wifi: ath12k: Segregate the common and wifi7 specific structures
>   wifi: ath12k: Remove the unused ring inits in wcn
> 
> Ripan Deuri (2):
>   wifi: ath12k: Rename hal_ops to ops
>   wifi: ath12k: Drop hal_ prefix from hardware register names
> 
>  drivers/net/wireless/ath/ath12k/Makefile      |    1 +
>  drivers/net/wireless/ath/ath12k/ahb.c         |    4 +-
>  drivers/net/wireless/ath/ath12k/ce.c          |   25 +-
>  drivers/net/wireless/ath/ath12k/cmn_defs.h    |    1 +
>  drivers/net/wireless/ath/ath12k/core.c        |    4 +-
>  drivers/net/wireless/ath/ath12k/core.h        |    2 +-
>  drivers/net/wireless/ath/ath12k/dbring.c      |    5 +-
>  drivers/net/wireless/ath/ath12k/debugfs.c     |    2 +-
>  drivers/net/wireless/ath/ath12k/dp.c          |  178 +--
>  drivers/net/wireless/ath/ath12k/dp.h          |   17 +-
>  drivers/net/wireless/ath/ath12k/dp_mon.c      |    6 +-
>  drivers/net/wireless/ath/ath12k/dp_mon.h      |    1 +
>  drivers/net/wireless/ath/ath12k/dp_rx.c       |    7 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.h       |   17 +-
>  drivers/net/wireless/ath/ath12k/dp_tx.h       |    1 -
>  drivers/net/wireless/ath/ath12k/hal.c         | 1114 ++---------------
>  drivers/net/wireless/ath/ath12k/hal.h         |  804 ++++--------
>  drivers/net/wireless/ath/ath12k/hw.h          |   92 +-
>  drivers/net/wireless/ath/ath12k/pci.c         |    2 +-
>  drivers/net/wireless/ath/ath12k/pci.h         |   10 +-
>  drivers/net/wireless/ath/ath12k/wifi7/dp.c    |    3 +
>  drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |    2 +-
>  drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |    5 +-
>  drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |   54 +-
>  drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |    2 +
>  drivers/net/wireless/ath/ath12k/wifi7/hal.c   |  705 +++++++++++
>  drivers/net/wireless/ath/ath12k/wifi7/hal.h   |  563 +++++++++
>  .../net/wireless/ath/ath12k/wifi7/hal_desc.h  |   80 --
>  .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |  661 ++++++++++
>  .../wireless/ath/ath12k/wifi7/hal_qcn9274.h   |   10 +
>  .../net/wireless/ath/ath12k/wifi7/hal_rx.c    |   22 +-
>  .../net/wireless/ath/ath12k/wifi7/hal_rx.h    |   10 +
>  .../net/wireless/ath/ath12k/wifi7/hal_tx.c    |   10 +-
>  .../net/wireless/ath/ath12k/wifi7/hal_tx.h    |    7 +-
>  .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |  439 +++++++
>  .../wireless/ath/ath12k/wifi7/hal_wcn7850.h   |    7 +
>  drivers/net/wireless/ath/ath12k/wifi7/hw.c    |  404 +-----
>  drivers/net/wireless/ath/ath12k/wifi7/pci.c   |    1 +
>  38 files changed, 2949 insertions(+), 2329 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal.h
> 
> 
> base-commit: c57176c0dad91a00bd20feb5f6dc4e8d575f4628

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


