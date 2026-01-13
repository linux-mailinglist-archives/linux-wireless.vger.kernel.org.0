Return-Path: <linux-wireless+bounces-30730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6C0D16DA6
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 07:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBF0030102BA
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 06:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578D81DFD8B;
	Tue, 13 Jan 2026 06:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="puHPHwjb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FPthKKUy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0471F03D2
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 06:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768286000; cv=none; b=rQW5VbWhVzmo2Y6bADmFadwTjuqpXpwOvR5q/Iy4/i55gXJmxuhEhPKfZL4BlsRIoiMoh16CKf6wLsJ8FcmIvTg880ZoMP0j/RaMW96KhByCjuQAs0pJclizkyt1JpTN/5uifoH+4iHnB975JO02Js4jL/C9xiikM+dj3pfvWe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768286000; c=relaxed/simple;
	bh=afFHuhGDuNDvCd8pR04e0Q7N9ZnE6fqgHsxx4igTQWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZGYOMKmA//o/Cx/5fnliPCnr9diuULhbZMLKCrIZ5zvOsnQRB4rn0I5meN3/QD6HJCGN8PFLIvU8ZxF8ELiNEOop/KPwtviG8tZBbfkgmvGb+AZM7V8LC8NpfHZtfyALGZn0noZ+U7hI/SZxlyyMFzSdtfluANqN3OjQkMTtfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=puHPHwjb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FPthKKUy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D1tTKx2751275
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 06:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MI8oiTkOeCtcOQFZJtHObjl2m0kFB8JOO95rG6suu88=; b=puHPHwjbN5nyApyR
	tQUHmpnH0BEkQ6VXOvDq++JQBMIMvkwp3VjxA+uDKokis8fgYrztqBPPENHl15KX
	om65OI7UDr3dt3GqlQtiNGwU34MkkqMlk/uUB5rfBtMnmQRv4QUlhNj3wskuDVNX
	PxVLkd7UvxBE7291sdc/knwZvPRNVuQExg+RDP9/J4J91Z4w/4pW3BJDQhkG02kw
	UicK1IwzBZdAufttYFi6Fimn2dxV6De8qFvEQ1iC6qcTwMvmiQLe77Da7JDFUrkz
	rOMiVr/SVc0X5eBST1HaS3JqXiOIp/NodW9EssgtV4n9jkI2/M48NOLRyX5x49CP
	eJTFTQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnctjrnwu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 06:33:17 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81eef665b49so6148379b3a.0
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jan 2026 22:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768285996; x=1768890796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MI8oiTkOeCtcOQFZJtHObjl2m0kFB8JOO95rG6suu88=;
        b=FPthKKUyUdByRdJxgsfh9qISw5Kpkat/ouDfEbHMA9uYwOI4agW/4B0AQ4BWFh1RdJ
         8+Ph0BUUmjEWsOfzy57tkt6dAfW3IhEJCOer/20xclVGzj/vJHEybAulSV8ZQop873Gr
         sDz0bHcWiPA43B3FNEQtZU644nBROeznBsjP5/JqumvwXeNGZXRx4keK4ACCXF+7tDjM
         sGa6R+BK5vkfLRnDoYWQtI+9GXwG4PiF6uh7Am8I2s5TQxkGIEReL0qnfoi3Vcn0MEE4
         0/ZmKz+SJ3nNKkpzvbB5tF5tmq2tNVRbjIlmvDSBYWzpNm44eKSnbL79QPX5jLuLwFYU
         MLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768285996; x=1768890796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MI8oiTkOeCtcOQFZJtHObjl2m0kFB8JOO95rG6suu88=;
        b=aB4I9MRuXGKFAV6h4F8hdsJICfx8YnMpKcrKnnPvfz9mzBaFiQMBKwojghTXLTllin
         9H3yKqORwuP18uRxAo66LvPjQeR3+j0+dCSbUSy41PXaxLGvD4KeOaPX8LMWyfxETD4s
         xp3vfuuwffAUPvrYdKDnyrh8lr/1B1bLvZjmz03Pq6TCp4Oc8/hMc03myBXFWmc/+osH
         NlxOyY6pstwWVQ4D19lZpjAxmV1Mewnk1xb7MFYczW453uN0h4Nx+ot1+EFBS95R0pRl
         tFLXq4mYAkadZippm6OBaze5M0vx6R6dC9XZtrTxTlM1dC42OrsQnbET1oT1DF7dLA4E
         hQMA==
X-Gm-Message-State: AOJu0YztQK/IoI2eVqIge85nup3+tHVAqfnpE2cBG5/nxTM8QJyPAilL
	iHRUbi9Rm5YGhmT67/COQWMEyJotGw0CyfAWujeepW5qbuZszLMCUfImhkmQmg1lLlJ4DzETO/c
	4LuYPw9EH3O9TK4A8fgDSAQ4yn2di1T1Q9MXUrt7TszbkTP+cZPF30QngFK3tFUKan423/ML5N1
	cz2g==
X-Gm-Gg: AY/fxX7vGp4z4FmvpDcDX7UeEGjj+f+fyJLbHLbPvmd/jYe1w1k9ezj9EkriIaLP+Vq
	dk4DIslDJ2iMrFLhtNTlknQX+U0jIlo3nGFQ9rHSbYYmJxqIhoiVDL+8IqEGmqHw8m+sytRsBuY
	59wSX9iGe0RiQb5a8e+ciX/p769ckTaoL6eAhEhvFOBtV90WaY1CeaDdKSGgdpQVAU2WZRhkjAW
	xt3maU3EGjLMNAg4PZH7MPRhn3mhwsEqq0jy+QsBLQQZOnxf//LOfsKUqQL/mEnZ3EAvTOZh+dj
	k/nmWojbkDpgw+Ydbwh9+gdWZDAtJLb/ynYYYKARFAaEHhpuMyT+WuD4Q7G1vzQs5XSmB+HsOJk
	+N6WLTtMYh4wDH4f/2R12Uc4jyAccat4VxuFWTsaTlFrYkIl6npFf72Y=
X-Received: by 2002:a05:6a00:1d13:b0:81d:a1b1:7324 with SMTP id d2e1a72fcca58-81da1c0bae6mr13647238b3a.58.1768285996284;
        Mon, 12 Jan 2026 22:33:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkCRf1fYLzHMkPy5u68wdnPGufOS/ZTPw1Fbjpf4BI11YJ0COBi+ayPIqXzVymTDC61kmw0A==
X-Received: by 2002:a05:6a00:1d13:b0:81d:a1b1:7324 with SMTP id d2e1a72fcca58-81da1c0bae6mr13647220b3a.58.1768285995812;
        Mon, 12 Jan 2026 22:33:15 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81d7d2cb2b5sm12194810b3a.43.2026.01.12.22.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 22:33:15 -0800 (PST)
Message-ID: <5a474fb8-95ad-4b98-9ed3-99f80dc41529@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 12:03:12 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2 00/18] wifi: ath12k: add support for QCC2072
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
References: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA1MiBTYWx0ZWRfXx2gxP3qDMzC+
 fCAbBRbYk7Dc5cPNW5Yobq7+WRmefiJEwNNQ61IY5afj1ieqtEO9nsTXTPZezHq9fLp3yGrnXnd
 KjPZCd/qFghir2XjhF2ZFeV9bR+k8ropq/Mr/J0RRoN20uBdhZWP5tlYtc54sfRHyYVITquVu9f
 R6VoGSpuAM7U1cO+8rQWtxiOdaR1mBUJwW5nJ0iqUVDHB0qKBYjhgvXecGihVtCt+52I5T0HNgG
 O7BSJAsPSF5kQQgy3EbnkMvC9hO1/wO3kvm/ZI/DcfCo/JN7mZPHO2ugYyYgg95wTsLmcO60hmW
 dukkVk5uLZy6Mc5XINzj0klfg115UWSDHgumbhx7G00vGK6sx8rqd7auvzUP1DlH38dGxyBGXWa
 eC8ehWOcklM108G4WDdd4kqeMfamyLP51nNCt295sCadQNUSSR67QDSYNw8GayVSEEZuE5puTm/
 K8zLItjOn2H+xIBmZ+Q==
X-Authority-Analysis: v=2.4 cv=Ls2fC3dc c=1 sm=1 tr=0 ts=6965e72d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=4yKLGjra7TlDbw-xlBwA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: RinQqihKjSCGJjMxJbH5Sr0wDjE4KO48
X-Proofpoint-GUID: RinQqihKjSCGJjMxJbH5Sr0wDjE4KO48
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_01,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130052



On 1/12/2026 1:06 PM, Baochen Qiang wrote:
> QCC2072 is a PCI based device that is very much like WCN7850, the major
> difference is that QCC2072 has only one phy hence does not support DBS.
> Due to such similarity, lots of existing WCN7850 code can be leveraged.
> While to handle the difference, separate operation is added, necessary
> configuration is changed.
> 
> Overview:
> - The first 6 patches refactor/fix current code base to prepare for QCC2072
>    support.
> - Patches [7,8/18] add hardware registers and parameters for QCC2072.
> - Patches [9,10/18] add support for new QMI memory type, new firmware
>    download etc, these are specific to QCC2072 hence necessary configs are
>    added to make sure other chips are not affected.
> - Patches [11,12/18] add new callbacks for QCC2072. These callbacks are
>    actually taken from WCN7850, with modifications due to the different
>    HAL descriptors.
> - Patches [13,14/18] add 32 bits variants for QCC2072 REO CMD/status ring
>    handling, as existing 64 bits functions don't work with QCC2072.
> - Patches [15,16/18] contains changes required by QCC2072, but those
>    changes are made common to all chips. They are not expected to cause
>    any regression.
> - Patch [17/18] add QRTR node id register such that QCC2072 can work when
>    firmware-2.bin image is used.
> - The last patch enables QCC2072 support.
> 
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> ---
> Changes in v2:
> - drop MHI dependency as it is not needed any more.
> - drop '[PATCH ath-next 09/19] wifi: ath12k: advertise standard ELF image format for QCC2072' as
>    current MHI implementation supports detecting firmware format by itself.
> - Link to v1: https://lore.kernel.org/r/20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com
> 
> ---
> Baochen Qiang (17):
>        wifi: ath12k: refactor PCI window register access
>        wifi: ath12k: refactor REO CMD ring handling
>        wifi: ath12k: refactor REO status ring handling
>        wifi: ath12k: fix preferred hardware mode calculation
>        wifi: ath12k: refactor 320 MHz bandwidth support parsing
>        wifi: ath12k: fix mac phy capability parsing
>        wifi: ath12k: add hardware registers for QCC2072
>        wifi: ath12k: add hardware parameters for QCC2072
>        wifi: ath12k: support LPASS_SHARED target memory type
>        wifi: ath12k: support downloading auxiliary ucode image for QCC2072
>        wifi: ath12k: add HAL descriptor and ops for QCC2072
>        wifi: ath12k: add hardware ops support for QCC2072
>        wifi: ath12k: handle REO CMD ring for QCC2072
>        wifi: ath12k: handle REO status ring for QCC2072
>        wifi: ath12k: limit number of channels per WMI command
>        wifi: ath12k: send peer meta data version to firmware
>        wifi: ath12k: enable QCC2072 support
> 
> Miaoqing Pan (1):
>        wifi: ath12k: fix PCIE_LOCAL_REG_QRTR_NODE_ID definition for QCC2072
> 
>   drivers/net/wireless/ath/ath12k/core.h             |   3 +
>   drivers/net/wireless/ath/ath12k/fw.c               |  10 +-
>   drivers/net/wireless/ath/ath12k/fw.h               |   3 +-
>   drivers/net/wireless/ath/ath12k/hal.c              |  46 ++
>   drivers/net/wireless/ath/ath12k/hal.h              |  34 ++
>   drivers/net/wireless/ath/ath12k/hw.h               |   2 +
>   drivers/net/wireless/ath/ath12k/pci.c              |  17 +-
>   drivers/net/wireless/ath/ath12k/pci.h              |   7 +
>   drivers/net/wireless/ath/ath12k/qmi.c              | 180 +++++++-
>   drivers/net/wireless/ath/ath12k/qmi.h              |  16 +
>   drivers/net/wireless/ath/ath12k/wifi7/Makefile     |   3 +-
>   drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c      |  62 ++-
>   drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h      |   1 +
>   drivers/net/wireless/ath/ath12k/wifi7/hal.c        |   8 +
>   drivers/net/wireless/ath/ath12k/wifi7/hal.h        |   3 -
>   drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h   |  33 +-
>   .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.c    | 503 +++++++++++++++++++++
>   .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.h    |  13 +
>   .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    |   8 +-
>   drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c     |  97 ++--
>   drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h     |  30 +-
>   .../net/wireless/ath/ath12k/wifi7/hal_rx_desc.h    |  17 +
>   .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.c    |   8 +-
>   .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.h    |   1 +
>   drivers/net/wireless/ath/ath12k/wifi7/hw.c         | 101 +++++
>   drivers/net/wireless/ath/ath12k/wifi7/pci.c        |  26 +-
>   drivers/net/wireless/ath/ath12k/wifi7/wmi.c        |   5 +
>   drivers/net/wireless/ath/ath12k/wmi.c              |  54 ++-
>   drivers/net/wireless/ath/ath12k/wmi.h              |   7 +
>   29 files changed, 1162 insertions(+), 136 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

