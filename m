Return-Path: <linux-wireless+bounces-27922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16116BCA633
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Oct 2025 19:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F346019E7087
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Oct 2025 17:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CF523B605;
	Thu,  9 Oct 2025 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dzUprbe4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3E154654
	for <linux-wireless@vger.kernel.org>; Thu,  9 Oct 2025 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031311; cv=none; b=ioIN0FHk+v1fVcPRUr6Gt/qK42LHWyAiA3NgJqj0iPz4FMimKrAa6RNSUwP+kDutHahjYffK8XG96GLg+2fVCx+CEQ5FrLh2UHn06O02TQN/gmylo/EIaW7TPmXCKk3S7c14aGRdVvTyoxHvZ8rpKRZ75PuRCYsoP7Tjovo0WHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031311; c=relaxed/simple;
	bh=BsQ9zT7gByTbMXoooLoWNk7loA5amAgrbjgi1Wmhu8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PsLwV5XGaOtzaVZ/05cQQFMXzpIHPfFxeScl1UT0TAd9ACxN+v6E/c9I4u+NM11diRNWez4dTIcjCtkfe5eGOLznfOGqje8t7Q216ny+NAAFdoTI0ZwTygqWc6ZxR2VY16wtt+jXKTIBL1E6vl7LACvLqHH/Jj7HOvXI210PomQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dzUprbe4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599H3aWk032066
	for <linux-wireless@vger.kernel.org>; Thu, 9 Oct 2025 17:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gBAux5X4fkA96suYJ0PQrNGIPpxKGaJvqeSwCv7vx/g=; b=dzUprbe44YLM3F7B
	3n2ZSOxxi/7fK2PY/XnGQYUO0yuF6kQjQ5ZBedrxnjBXKOUyC9ps7qMmC3mAKxKj
	QJ1U3uL4hjUomwome+tiKZ0W5AULU2l1jnZQaefHoEDphKsHfw0reUseOpVZjDLO
	GNvlJPhQgf94rd8jbUDVx5BpAOX+csa3xYoVfFiIQjEiqJyQXajjG244c7b/hdVq
	yn9jOjAcnnk3LeMCi1u+iAswSZYYzpr1RAOQIaOKesQv4WDAdFqSSxxU8W+W0q3T
	NUF2cqma/jKiEy5PIGQ7jkA8NnHfKL12Fke5xXUHlBg5FS1wiY1Wbjf3ldnf54p8
	NNhC+w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49p9m0srey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 09 Oct 2025 17:35:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-269af520712so21027515ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 09 Oct 2025 10:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760031306; x=1760636106;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBAux5X4fkA96suYJ0PQrNGIPpxKGaJvqeSwCv7vx/g=;
        b=dl6FnY+wvUqRx+eh7dcU3u9HbnUU7h2QVF3Ns9iei7zszO4kGTR3hiBihLuczhhNZo
         c2ss5KOVKAsq6cmVh49Lo2ZhmxqTLCsWR3gw9TZJ8TBsQki/mjYq2cOm0c19iK4tLmYe
         KNc4NuXNcOCWYPl4hwUdxPh7kNfMrNwH5UULnQKN/kyY6HJV8ScJlzooXvFxemEMcHYf
         az739kQ8LmtShzOVv3VW4UyMWqW8o2qKifrQjVbuDphoM/HyHe+guFhKyEH0Z+Jc6li+
         Wt+qn2GcIraU+PMn0nqJgVDojKBvwwMYkkDO3URo/96S+hCTxHNPKiIpzslFGHf0G350
         rDGQ==
X-Gm-Message-State: AOJu0YzG2ff485YSzAu0P2WjUn9VWmJX3EFIGgfZx9jHkFn4dOl/7Y8W
	vJrhNL3+Ii+S7GlfMlCHS9mZeA8hEjOQiVl4QOOIhLg2rLorxaaFZ75Hb+k6KK5NA4+ceji1h4f
	X8+ZbIzX7NWj1QHgEe7sqHLxcWTiV+h2vYkTazTyyxmndFRb12b64QjNRtwlIrRP2WcAiaNKmBs
	sApQ==
X-Gm-Gg: ASbGncuD3WbOqR1ZPr3V+lQZiFTGikRJ4ZVaexRZwPxgUWF9IO7k14E5yr73ixI6fsA
	AzzGRAZEx9PMT7+RtgtUQX6nzgaaerqMnWBf234utH8nPXXn+iXObuEtV3ZOqrdubrLuDkafrRJ
	kZZ8JqCUm5qQMPa1JBIfNNlgfRmXV2sqb3D6dyxUo99Yb5bVTqU3XiwoMj6fAxVpONFmSCIHDlZ
	YJN+4kI+sav9BkZQN6kMQWtiTPtUuVpf9O/CjVH4XH/BBdSI7Ruy28yVF1yrGAxSNGgU6RM1tn6
	bPMj0zhtKDTqpdmfIpD2a4M+b5Kjz+LM8c2GdOqWk9xFgmOFCuEIwMgZNlnrEDqCNwMv8Cu4UR/
	vHkWMXzXV8BThHbb3DZqoVg==
X-Received: by 2002:a17:902:ce87:b0:250:6d0e:1e40 with SMTP id d9443c01a7336-29027356a6emr125134425ad.7.1760031306131;
        Thu, 09 Oct 2025 10:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOklSdtzdWVahhEQPwg9PEI1hPEMFk1lp6XBWWPg+HZBSs8b0nz9hA++Dd+lkTXAx+miyBGw==
X-Received: by 2002:a17:902:ce87:b0:250:6d0e:1e40 with SMTP id d9443c01a7336-29027356a6emr125133995ad.7.1760031305634;
        Thu, 09 Oct 2025 10:35:05 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.106.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f05c2dsm34277215ad.73.2025.10.09.10.35.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 10:35:05 -0700 (PDT)
Message-ID: <82c7d1b4-bd92-db46-358a-8d3e86ff571a@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 23:05:00 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath12k-ng 00/18] wifi: ath12k: HAL changes for Next
 Generation Driver
Content-Language: en-US
To: Ripan Deuri <quic_rdeuri@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20251009111045.1763001-1-quic_rdeuri@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=a/U9NESF c=1 sm=1 tr=0 ts=68e7f24b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=z6xreaRxtU16OQ9bEhv1vw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=frQrzQ4E-2FGA6FtmloA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: Ln3yaGqhV6IDlwlu1tpUTm_6eE09YJt7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDA0NyBTYWx0ZWRfX+ZX/4lrWURen
 //qYxeR7jSmWCltYBkW4s4i1zdnUtfj5g05X2FPuIro3glSFAuNxYsUPxf2RVvVhxZRI7WNOzoU
 RkbybUetw2xPxa6F/4l2mQTIrC1C3BpGkAgPKorACa8xnf5UK+5217wX/yEMGn+h0TLUCtHYaJP
 JCD3a/OLKwoMryGnWdOlKgj5ORyxW/P55kE0egmeaonwTat42cipZV5/1r9ZtdFqv8cM4ig25nt
 G4AI4mf9rnAQavCCWb7otPO/ZcNMI38xcIZ8JRBSJOptOXV549feOfdMa39KkO5kxT8KhCyheaY
 9cbnc6VgPw4ip6tXO5UtEzFfrERdNwkStCEVT26/9stwW7D70ONFaWNDe+gCcHRLQ7ZeriZG26O
 tBXvQ6LGvuvrAUSMJHOvUUhzsUo9Ww==
X-Proofpoint-ORIG-GUID: Ln3yaGqhV6IDlwlu1tpUTm_6eE09YJt7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510090047



On 10/9/2025 4:40 PM, Ripan Deuri wrote:
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
>    wifi: ath12k: Move srng config and hal_ops to hw specific hal files
>    wifi: ath12k: Initialize desc_size through hal_init
>    wifi: ath12k: Initialize hal_ops through hal_init
>    wifi: ath12k: Move wbm_rbm_map to hw specific hal files
>    wifi: ath12k: Move hal_params and regs to hal from hw
>    wifi: ath12k: Add direct HAL pointer in ath12k_dp
>    wifi: ath12k: Use hal handle instead of ab handle
>    wifi: ath12k: Move HAL CE setup and SRNG related APIs to wifi7
>      directory
>    wifi: ath12k: Move HAL SRNG shadow config and get ring id APIs to
>      wifi7 directory
>    wifi: ath12k: Move HAL CE desc related APIs to wifi7 directory
>    wifi: ath12k: Move HAL CE status and set link desc addr APIs to wifi7
>      directory
>    wifi: ath12k: Move HAL Tx, REO and link idle setup related APIs to
>      wifi7 directory
>    wifi: ath12k: Move HAL REO and Rx buf related APIs to wifi7 directory
>    wifi: ath12k: Move HAL Cookie Conversion and RBM related APIs to wifi7
>      directory
>    wifi: ath12k: Segregate the common and wifi7 specific structures
>    wifi: ath12k: Remove the unused ring inits in wcn
> 
> Ripan Deuri (2):
>    wifi: ath12k: Rename hal_ops to ops
>    wifi: ath12k: Drop hal_ prefix from hardware register names
> 
>   drivers/net/wireless/ath/ath12k/Makefile      |    1 +
>   drivers/net/wireless/ath/ath12k/ahb.c         |    4 +-
>   drivers/net/wireless/ath/ath12k/ce.c          |   25 +-
>   drivers/net/wireless/ath/ath12k/cmn_defs.h    |    1 +
>   drivers/net/wireless/ath/ath12k/core.c        |    4 +-
>   drivers/net/wireless/ath/ath12k/core.h        |    2 +-
>   drivers/net/wireless/ath/ath12k/dbring.c      |    5 +-
>   drivers/net/wireless/ath/ath12k/debugfs.c     |    2 +-
>   drivers/net/wireless/ath/ath12k/dp.c          |  178 +--
>   drivers/net/wireless/ath/ath12k/dp.h          |   17 +-
>   drivers/net/wireless/ath/ath12k/dp_mon.c      |    6 +-
>   drivers/net/wireless/ath/ath12k/dp_mon.h      |    1 +
>   drivers/net/wireless/ath/ath12k/dp_rx.c       |    7 +-
>   drivers/net/wireless/ath/ath12k/dp_rx.h       |   17 +-
>   drivers/net/wireless/ath/ath12k/dp_tx.h       |    1 -
>   drivers/net/wireless/ath/ath12k/hal.c         | 1114 ++---------------
>   drivers/net/wireless/ath/ath12k/hal.h         |  804 ++++--------
>   drivers/net/wireless/ath/ath12k/hw.h          |   92 +-
>   drivers/net/wireless/ath/ath12k/pci.c         |    2 +-
>   drivers/net/wireless/ath/ath12k/pci.h         |   10 +-
>   drivers/net/wireless/ath/ath12k/wifi7/dp.c    |    3 +
>   drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |    2 +-
>   drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |    5 +-
>   drivers/net/wireless/ath/ath12k/wifi7/dp_tx.c |   54 +-
>   drivers/net/wireless/ath/ath12k/wifi7/dp_tx.h |    2 +
>   drivers/net/wireless/ath/ath12k/wifi7/hal.c   |  705 +++++++++++
>   drivers/net/wireless/ath/ath12k/wifi7/hal.h   |  563 +++++++++
>   .../net/wireless/ath/ath12k/wifi7/hal_desc.h  |   80 --
>   .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   |  661 ++++++++++
>   .../wireless/ath/ath12k/wifi7/hal_qcn9274.h   |   10 +
>   .../net/wireless/ath/ath12k/wifi7/hal_rx.c    |   22 +-
>   .../net/wireless/ath/ath12k/wifi7/hal_rx.h    |   10 +
>   .../net/wireless/ath/ath12k/wifi7/hal_tx.c    |   10 +-
>   .../net/wireless/ath/ath12k/wifi7/hal_tx.h    |    7 +-
>   .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   |  439 +++++++
>   .../wireless/ath/ath12k/wifi7/hal_wcn7850.h   |    7 +
>   drivers/net/wireless/ath/ath12k/wifi7/hw.c    |  404 +-----
>   drivers/net/wireless/ath/ath12k/wifi7/pci.c   |    1 +
>   38 files changed, 2949 insertions(+), 2329 deletions(-)
>   create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal.c
>   create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal.h

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

