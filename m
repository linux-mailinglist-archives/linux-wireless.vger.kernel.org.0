Return-Path: <linux-wireless+bounces-28747-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11166C46112
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 11:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24CF3A27F6
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 10:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A22305E08;
	Mon, 10 Nov 2025 10:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AKNEoOtA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MbLkjMw0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E72302CC7
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 10:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772034; cv=none; b=jT1BZ40bq5Ht6dd9TqRGw7pX/wE0pl3rvCRPoyi843T6M51B06A1cS48xfuXJIqHsDF9NAFHwO7PID+aUs4Mb3vMAVtTvoJvxy09Mhl/Eg/BYmv+dIVJSZ7UxcTJzuAp/CV8ObJSOV92MLNJzeK+HpizaTxujNkOvSoPAlez8KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772034; c=relaxed/simple;
	bh=T6KY6MMDyIfST7Xy2oIhKhUHHKCQGsmltM24obMkLhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdYFzr5IyQ4ZI4FTfsd7YF+F0XC9u4OBvacFnImynPFHFOXuXrGi8MpNedXhXIrzmFUjBRFcIPy9trGALOOw4IdzdZHiBsPvAC1BukzhLAZG3183uW5j3RsI1v3UIzPyn8gL3a8EKClNxwg86g+i0fnT1uLuusU2sFiMRwpkQgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AKNEoOtA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MbLkjMw0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA9FJYk2993839
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 10:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FGIVKCtkd5+TgO2EOjyLvoZSKjjlSH4n+OgZIdUeauY=; b=AKNEoOtAx5N8ZnBA
	pYinSGfmGLnXzzNgX+o+tbFs7CcVhYIsixXsaf0tSU+cKcpiIPh42FQLFxAK9czB
	2j7s0/3AbprdlF4O/2THSZJA5+g5CSwYG85cdBvBXebVf3iDFbC/3PmEgT102oFE
	DdyiF6qas/shx+8l3+NAbFtLcaPF05LPkBxmWmRGDbv0Fs84s8JX2Gs9kDvlGNO3
	G9L7HusOvJwpqGOMq3h+Q/bMbmuQ11kzKD3xN8cnQcLut6YUAmR9GpANy3AbZiKX
	lyA1vRLgBq7KlWOvq5c/1IphD+LcvcNBuNRpOcXA+CNVKcptZgn9xq8PW+8KI/yV
	n4dgPw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abd88r9qa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 10:53:52 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-78105c10afdso3295521b3a.1
        for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 02:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762772031; x=1763376831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FGIVKCtkd5+TgO2EOjyLvoZSKjjlSH4n+OgZIdUeauY=;
        b=MbLkjMw0kmMifclpIh8l2C8vuXsvAR3ClTefrFPeS2iZIjcFZOT2PcSSpVt+LucEb2
         /83OKdZr5/hWjo5whdcLkCQOO7X7LTrLP51+v0Lb5PvndLrcTS87Sjq92hcrxU7xV6xw
         oj0Eps8eM/RPpoGDHjk0cB4+wjZO3OSQIW0+HjEXizw1BzUXmgjOCG8OmdllaVXN7hjQ
         3mZy2ngiCzY5Iq9VeG6B/o80BBUI06i0niz1AbdoxesHNoiS02r6kFcHMqeiZ/G9ElOF
         OTnMJschsTwzvfSiuU4Wn0rp3ha7IPkNjp07q5yV65GtQm1x1wd73LPPbbVB9xJ85ZY5
         K/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762772031; x=1763376831;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGIVKCtkd5+TgO2EOjyLvoZSKjjlSH4n+OgZIdUeauY=;
        b=SY4x/1gCPFUDVkQTVm3Rkft/38y6HOV4zu/HNYsbdnOW2OkCKdOLxV0o8kRpWgFk2g
         CnRsUZEkPl3hruiuP/0IyWypenXb8ofr0AJXWr2r2UGPwYPVeKOvIrzg0+FwwLNPkCZf
         OHahg3R4+4rbvzWuyfI65eSRHYpP2GSuMbQONX0KbBEHkIICNWvmn5OQKqXCVCoBF6wg
         Gw+DDB8sVKiSIYblvfAeY3Uf2BC//f0NIhGRwnXN4MWLB6L43FvJq7Gey/Lifr+PIfyD
         1oQx8n7EpRs4Y0/5ynA1150aph5hRQgPCaC7TJEpmuFbdkoWfQmBbanHqAg60dpoWzSv
         tXVA==
X-Gm-Message-State: AOJu0YxxHHkUdTPkKJrUEV5dZcN2OMiHfbMWt91Za8uCyu6GgU1BcN2c
	7HbVORu5l9C10G5wKzopsRPQ2kl43e+TOGb4HqT0RHbL28Zl72eO/UliMmYvps6OsYabBRfplay
	mjT7loVJwIoFpKhreUzNeZRxX9qr5Sjv/GDFJlFvsmmodHW+ShvozWZZBdBtGlhGfaqPjGo6BR/
	bCqsGj
X-Gm-Gg: ASbGncsac8oW0fZH3hHR5oFSVWMgxZVgCVQ1FaYFN2KltBKt/TuKFOMckUhO5NqoLr4
	7qviwKpAX4FKTKRnhE0euuyAVrKVge0BciZ9C3yrMTR3KR2PEGHLmVxbRtoCw82BQ/0PKsURJS2
	Vr4VGYhBmhQLEKacPYL5y+/gxg36S6S0HOKvq/EQWFbhtk87RcbA0tp1XHfVnFDhuz+cltuTDa9
	5c9Hxdq3MtM5lNWotdyUUXw+ROwFgduRTp+3WnX9va29scx+9t/JKJeTiSxvNLt3Kne/LbTG/4D
	p3wGBaFnXwD9cVtGkihImBb7oqM/CtOprjUce3zeNfI8vCwxjnJb74y6UuzPBKTXPMomnGDI5Uc
	C/DM3sUSlSdRpkqpv3DFkY8H/YB69WrAUPTB2Kw1Wdi+aZW84Nylgh3EEv7PWcQXTN415z7qU
X-Received: by 2002:a05:6a20:e212:b0:348:9a99:6253 with SMTP id adf61e73a8af0-353a4889417mr11462891637.57.1762772031275;
        Mon, 10 Nov 2025 02:53:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEa2+pH+Rh26j1XxO3SdWrVYTIgR1EIaeW3dBI7YcjikfVT8b3au1DzplTC0IVSxKeysCmVJA==
X-Received: by 2002:a05:6a20:e212:b0:348:9a99:6253 with SMTP id adf61e73a8af0-353a4889417mr11462865637.57.1762772030805;
        Mon, 10 Nov 2025 02:53:50 -0800 (PST)
Received: from [10.133.33.216] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f8d7ee8bsm12229893a12.8.2025.11.10.02.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 02:53:50 -0800 (PST)
Message-ID: <300a2ebf-21e1-4b34-9ddb-bbf1f8e288e7@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 18:53:45 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath12k-ng 00/12] wifi: ath12k: Remove the Wi-Fi 7 header
 inclusions in common code
To: Alok Singh <quic_aloksing@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251110103713.3484779-1-quic_aloksing@quicinc.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251110103713.3484779-1-quic_aloksing@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7M7JAOYjebOOKPzYiWwHReeJZRKIv69c
X-Authority-Analysis: v=2.4 cv=PL4COPqC c=1 sm=1 tr=0 ts=6911c440 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=rApeeKJKgo9SdP4gWbgA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5NSBTYWx0ZWRfX5eVnyDYkhFfn
 +DY1tTfbQclS0ZQBQ2oioAB8920G8KKaf1zrZsMYOjUtquW8cMDzKC3gZKHshRmH84YfZGLkk95
 lL0ARmZ8vNTQpOY5HLBNrKoq+SaDM+qzBt5USCbk7ysY7ZgfrhlCqWudV1iLK9kalwYfWOCOFDo
 UPMeD0G+50f93BLCrp8tfcFB4c20lnVWrXYAZ16HQcmOBp1xNBy/BtgNmlb2wkQifFHyujTG6Tg
 p7wMWJQdpWmiHcSEYgh1mnM+uGBQR3X+sNwqm19ppk6dYbKVRxeof/LjF0hp/HXr/+gfaFW760T
 NWsgjL4OWyLWuCzjdNLMoXSck/VyNTkq0dLT3IKHv2eGf3wkIeMmfvhLM+h/Tben1rmx/ceMCDl
 RZqvlPX3oIHH49+4XtaZ7HBM099tIQ==
X-Proofpoint-ORIG-GUID: 7M7JAOYjebOOKPzYiWwHReeJZRKIv69c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100095



On 11/10/2025 6:37 PM, Alok Singh wrote:
> Idea here is to Remove the Wi-Fi 7 header inclusions in common code
> As a precursor to the movement of Wi-Fi 7 specific .c files to
> ath12k_wifi7.ko module, Remove all Wi-Fi 7 header inclusions (`wifi7/*.h`)
> from the common `drivers/net/wireless/ath/ath12k/dp_mon.c`.
> The common monitor functions now compile solely against the core
> ath12k headers and remain part of the `ath12k.ko` module.
> Move Wi-Fi 7 specific monitor implementations to a new
> `drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c`.
> This file is built into the `ath12k_wifi7.ko` module.
> 
> This patch series refactors the ath12k monitor functionalities
> into common and Wi-Fi 7 specific code.
> 
> The series includes the following changes:
> 
> - Patches 1-11 move various monitor mode processing functions from the
>   common ath12k driver to the Wi-Fi 7.
> 
> - Patch 12 removes the Wi-Fi 7 header dependencies from the main driver,
>   completing the separation of concerns.
> 
> Alok Singh (12):
>   wifi: ath12k: Move monitor ring processing to Wi-Fi 7 module
>   wifi: ath12k: Move monitor status processing to Wi-Fi 7 module
>   wifi: ath12k: Move MPDU pop functionality to Wi-Fi 7 module
>   wifi: ath12k: Move RX status TLV parsing to Wi-Fi 7 module
>   wifi: ath12k: Move TX monitor functionality to Wi-Fi 7 module
>   wifi: ath12k: Move HT/VHT SIG processing to Wi-Fi 7 module
>   wifi: ath12k: Move HE SIG processing to Wi-Fi 7 module
>   wifi: ath12k: Move EHT SIG processing to Wi-Fi 7 module
>   wifi: ath12k: Move remaining SIG TLV parsing to Wi-Fi 7 module
>   wifi: ath12k: Move MU user processing to Wi-Fi 7 module
>   wifi: ath12k: Move MSDU END TLV processing to Wi-Fi 7 module
>   wifi: ath12k: Remove Wi-Fi 7 header dependencies from common ath12k
>     module
> 
>  drivers/net/wireless/ath/ath12k/dp_mon.c      | 3474 +----------------
>  drivers/net/wireless/ath/ath12k/dp_mon.h      |   62 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.h       |    9 +
>  drivers/net/wireless/ath/ath12k/hal.c         |    2 +
>  drivers/net/wireless/ath/ath12k/hal.h         |   33 +
>  .../net/wireless/ath/ath12k/wifi7/Makefile    |    1 +
>  drivers/net/wireless/ath/ath12k/wifi7/dp.c    |   16 +-
>  drivers/net/wireless/ath/ath12k/wifi7/dp.h    |    1 +
>  .../net/wireless/ath/ath12k/wifi7/dp_mon.c    | 3354 ++++++++++++++++
>  .../net/wireless/ath/ath12k/wifi7/dp_mon.h    |   23 +
>  drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c |   19 +-
>  drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h |   11 +-
>  .../net/wireless/ath/ath12k/wifi7/hal_desc.h  |   19 -
>  .../net/wireless/ath/ath12k/wifi7/hal_rx.h    |   15 -
>  14 files changed, 3570 insertions(+), 3469 deletions(-)
>  create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.c
>  create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/dp_mon.h
> 
> 
> base-commit: f87034a7576f918f2e60a14f17185b492e91580d

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

