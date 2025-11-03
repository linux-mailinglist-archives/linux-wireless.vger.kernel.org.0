Return-Path: <linux-wireless+bounces-28483-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE96C2A0CC
	for <lists+linux-wireless@lfdr.de>; Mon, 03 Nov 2025 06:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D6300348268
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Nov 2025 05:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30612239E9D;
	Mon,  3 Nov 2025 05:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hn6tpSqr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vjs/359D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8596F234963
	for <linux-wireless@vger.kernel.org>; Mon,  3 Nov 2025 05:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762147193; cv=none; b=GnMk34fIxo+pjEfIgD+6xmuNk9jrOjS/3lEzIzbg7EjsEV2odyA7bkvXOCgYKR+RYxlTLIsHDU1eujuAEMw9j+2EhpmWJMfp0kiCdvO6kh5dCQKj0qOmZdaxhd1YQVSzarTJo9Le8+XAGuus3A+pyPmxbcSu50RA4So16uSqxWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762147193; c=relaxed/simple;
	bh=x/bzBoGko7L8fG+8lWZaJdUBF8uJtfFO7vBsK4ovkiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qGQ61y2rwnIC3dmO1hrekncy0nweoc/L6Jl7lp1g9/uTwONJYXrMFMA1a/AJj/6kAIRyxUTeEioIhRwYwMFl2VxaxQyITN4eIlpzS6G+VyJjMhN0yxMy2lVhtEpopPtimLBrCwMd/3S+3FhLUeJhnf6H6dlnKPRqtSQyiXQkB6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hn6tpSqr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vjs/359D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A2LQ1IP1173646
	for <linux-wireless@vger.kernel.org>; Mon, 3 Nov 2025 05:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mTckRdKzMidJ2PygL42jLXJLkVdQ3oHXT1MYLdik7IQ=; b=hn6tpSqr9bzXpmW5
	Jk90rcIb4bsFS/eEKCLwtwamTtbkvGoG9Xw1PN/zTsYug/3BRKcf//fcA8FXL7wK
	jVUOBPHqYvPmPOAMAQ+X7FONacD+iQ7+pCo7SsHAAQ/G/5Hol0uyVugSP+k0Oap+
	UKgAU6o56aN3rmwcDdd8gVSifWExcOuYhv5b5Uu2XIqS+gZcTWmwBkndmZm/mNCO
	ZFDQt8S26LaMOaWr1JzYzH4+HI3N9bAWLbrHscAqMGAe+ululVtz5DaxXkDTXxz/
	vaNJnlf7iPoXlz50bsJQNCZ8p6A+uAJhDJ3ofXNnyGvpun0vrQqQ7uzjMnHsrvSJ
	ATuB2A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5bg9k9by-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Nov 2025 05:19:50 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a43210187cso3696040b3a.3
        for <linux-wireless@vger.kernel.org>; Sun, 02 Nov 2025 21:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762147190; x=1762751990; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mTckRdKzMidJ2PygL42jLXJLkVdQ3oHXT1MYLdik7IQ=;
        b=Vjs/359DNPgxuj1cJXRNR4Zeiyvy9DCL2cKRPTNyc2U4MP6gWvFHmBhQ+wBTNYC7KY
         ZbOjrt6wJkFBn0k8Tl3m0TF1D3/2eQgHr5f5040XDIUcMWkFkxjUJdSDLUv410HIyaIA
         CgVjMLFSpWzIpGGGUUiJZotUNVSXkYMZoZz1MzFPc7tWyDFeyIXqne+v92Q1WrHFMsWS
         T/ehbX7DpWYqAfChgfMh9ZoXFzwDcuInFBORA+NpncyE9cheSGNB2uI+lLwV5BJ8t9J0
         RVh38mKKwOup5uizboxosoyuwDI0amESDY0Djittcs27Md8Ve0ascffwVukdqsoabV0p
         tsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762147190; x=1762751990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mTckRdKzMidJ2PygL42jLXJLkVdQ3oHXT1MYLdik7IQ=;
        b=TLqy1AGnnffw/S5ZNtWjL2L8U7gqTuPRoOrVGHcQ5eF9BkYxW0NOKpSW452DN7gD6b
         Bp94isu2qFMOqKZhERD5hzd8c6BuxROZ0pBOAv36pdEdLoyMt0CU900/b96ePxhteOBg
         +Y3cs2gqFpfi51+HQ0oLdAPDv0PRhJ9em32yoHyZoRyrTqcrU9VpxEjp0fhu+fYEXVL9
         nANZg2LUwDLMjr0ypCuLcRd45TCa70whBsaFwRvZNcpoAM5eXUnN4cAP+Pg3LM1GHKgW
         sBBTFVrduYEgeouqxhPe38mfNtTAvF+/QULgssBVhfCWc2Suwb1a9E2HE4zaglCAQ4LV
         z7Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVTb9uYW3907Xf8IrS/yuKyIye2jGl1oRokS2px6vBL13gy3t/07FoVlKiz7kB7hKQEsF/b4Iqsr6GB1yKvWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXp6x1XhtRq0cILfHOj7yeywfNUmpGSnbIQrvvWGPSJQyWM5HE
	C6GI1rfStCF/JMI7d5K9gTFXDyvCxf3XrOfOX1keGD8DRehvhLjMQxi9FsFkkpGE7Q8cosRcGFT
	wI0f+kSqdWigcjgvtMg8+dj1p3n1EPh9Z9gNczEkQ3AQz+J8iThIX8SS1wdKqsmcdx2PiYQ==
X-Gm-Gg: ASbGncvE4MDVemT+vjxpV/txNKXH2W+2gIYtPbTE8trs/oTHyBu8q5xCxjsiM7mVgsw
	aAh969QQqVD1IGnCNuNB886+qY6H+NZ5X2tqLmZEu+FMQ98DrqBrWx78Z8+krIRsikgjEPHzYWk
	1CIwe0bFvwkKYDasTlmvq337MjAUnmZXIDFnGZHyJNi5Vz1eGHn9rD9NaixHPLlgyy9OOYxRdO4
	NKc7iusu4Lx52GrOEIoXNaBHe2XcqWb5WHOjociAsvWw8lSIfVPYBfF+971dwjo7kBg2yxc8Jtk
	hClmUaz0ngQDYR3pHfIwKoK0/5Z+lSMDG1/WKOwwizYcYLHc4wYttYlUuw5IgMSr4RSjPsgVbCO
	ERiHMK8Yz/NiQw9z337jG1QAdehmBsL+pmkVqtFGkBjoa
X-Received: by 2002:aa7:874c:0:b0:7a9:c21a:5599 with SMTP id d2e1a72fcca58-7a9c21a57e1mr4637688b3a.4.1762147189814;
        Sun, 02 Nov 2025 21:19:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHY6CK7+3qnqtgym8dPplUFumkBERSWgzc9iw1hh13q+kTrQoOQdgsQ/U1226mL1FUfV348Rw==
X-Received: by 2002:aa7:874c:0:b0:7a9:c21a:5599 with SMTP id d2e1a72fcca58-7a9c21a57e1mr4637669b3a.4.1762147189328;
        Sun, 02 Nov 2025 21:19:49 -0800 (PST)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a9ea1159e1sm4418212b3a.23.2025.11.02.21.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 21:19:49 -0800 (PST)
Message-ID: <f66b58d5-a952-62a7-fa2b-0b15484f2bb8@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 10:49:46 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: ath11k: question about memory-region
Content-Language: en-US
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <aLf825sx7W2S4Hlx@FUE-ALEWI-WINX>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <aLf825sx7W2S4Hlx@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TPaBsqvqvVeKg7QaO4rK_s0bxo62WasU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA0NyBTYWx0ZWRfX67Gt16U4D/pm
 m+e3nN5r94FT136M6IKpTAWNHSVpbgJmarIuYNZ5Qu6iPg35KPOvzmxn0EWGnfNjNa/sDd4PIUs
 VsYRJgFkhormddqU8C1MlIkOdw3F2ArjJoFnEbITf0eJTZeER8OhWncUGj6mHijr8W57N4Jt8Xo
 j3B8+/+O9JEgTMvoQ1dcT4d2qzJztNsonTVhnko1iL+LaMQMogCWJw4/LxR16/YOtgwIory98Ed
 pzbiFgQAVMNoSjDLvs5l/0sgY9UxLCowIegBE2e9L8rAI1B5FUEcbIFJXS26KP0f8DxMGY5dBEk
 TiquPaM3lRcguINikkH4SR8zVG/YQBYUjVmRpXF/eEY4j7eYUXZspT+R2cn8YOxBRkFYokOlXvt
 3slPgR/tFl0AmZtr2TEeqk6c65b+Ig==
X-Proofpoint-GUID: TPaBsqvqvVeKg7QaO4rK_s0bxo62WasU
X-Authority-Analysis: v=2.4 cv=TaKbdBQh c=1 sm=1 tr=0 ts=69083b76 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=TdGNnazd7jbYejwxrHYA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030047



On 9/3/2025 2:01 PM, Alexander Wilhelm wrote:
> Hello devs,
> 
> I have a question regarding the use of memory-region on a platform without CMA
> support. Since CMA is not available, the driver allocates many smaller memory
> chunks instead.
> 
> To evaluate an alternative, I defined a node within reserved-memory in the
> device tree. However, this led to a firmware crash:
> 
>      ath11k_pci 0001:01:00.0: BAR 0: assigned [mem 0xc00000000-0xc001fffff 64bit]
>      ath11k_pci 0001:01:00.0: boot pci_mem 0x10b272d0
>      ath11k_pci 0001:01:00.0: boot pci probe 17cb:1104 17cb:1104
>      ath11k_pci 0001:01:00.0: pci request one msi vector
>      ath11k_pci 0001:01:00.0: MSI vectors: 1
>      ath11k_pci 0001:01:00.0: pci msi base data is 0
>      ath11k_pci 0001:01:00.0: qcn9074 hw1.0
>      ath11k_pci 0001:01:00.0: FW memory mode: 0
>      ath11k_pci 0001:01:00.0: boot failed to load firmware-2.bin: -2
>      ath11k_pci 0001:01:00.0: boot using fw api 1
>      ath11k_pci 0001:01:00.0: pci msi assignment MHI num_vectors 3 user_base_data 0 base_vector 0
>      ath11k_pci 0001:01:00.0: pci num_vectors 3 base_vector 0
>      ath11k_pci 0001:01:00.0: pci msi assignment CE num_vectors 1 user_base_data 0 base_vector 0
>      ath11k_pci 0001:01:00.0: pci msi assignment DP num_vectors 1 user_base_data 0 base_vector 0
>      ath11k_pci 0001:01:00.0: pci irq 18 group 0
>      ath11k_pci 0001:01:00.0: pci irq 18 group 1
>      ath11k_pci 0001:01:00.0: pci irq 18 group 2
>      ath11k_pci 0001:01:00.0: pci irq 18 group 3
>      ath11k_pci 0001:01:00.0: pci irq 18 group 4
>      ath11k_pci 0001:01:00.0: pci irq 18 group 5
>      ath11k_pci 0001:01:00.0: pci irq 18 group 6
>      ath11k_pci 0001:01:00.0: pci irq 18 group 7
>      ath11k_pci 0001:01:00.0: pci after request_irq msi_ep_base_data 0
>      ath11k_pci 0001:01:00.0: pci ltssm 0x111
>      ath11k_pci 0001:01:00.0: pci pcie_hot_rst 0x11
>      ath11k_pci 0001:01:00.0: pci pcie_q6_cookie_addr 0x0
>      ath11k_pci 0001:01:00.0: pci wlaon_warm_sw_entry 0x0
>      ath11k_pci 0001:01:00.0: pci wlaon_warm_sw_entry 0x0
>      ath11k_pci 0001:01:00.0: pci soc reset cause 0
>      ath11k_pci 0001:01:00.0: pci mhistatus 0xff04
>      ath11k_pci 0001:01:00.0: pci link_ctl 0x0000 L0s 0 L1 0
>      ath11k_pci 0001:01:00.0: pci pci reg 0x3164 instance_id 0x11 read val 0x11
>      ath11k_pci 0001:01:00.0: boot notify status reason UNKNOWN
>      ath11k_pci 0001:01:00.0: boot notify status reason MHI_CB_EE_MISSION_MODE
>      ath11k_pci 0001:01:00.0: qmi wifi fw qmi service connected
>      ath11k_pci 0001:01:00.0: qmi indication register request
>      ath11k_pci 0001:01:00.0: qmi host cap request
>      ath11k_pci 0001:01:00.0: qmi firmware request memory request
>      ath11k_pci 0001:01:00.0: qmi mem seg type 1 size 36700160
>      ath11k_pci 0001:01:00.0: qmi mem seg type 4 size 3784704
>      ath11k_pci 0001:01:00.0: qmi mem seg type 3 size 1048576
>      ath11k_pci 0001:01:00.0: qmi mem seg type 9 size 8388608
>      ath11k_pci 0001:01:00.0: qmi mem seg type 10 size 8192
>      ath11k_pci 0001:01:00.0: qmi ignore invalid mem req type 3
>      ath11k_pci 0001:01:00.0: qmi ignore invalid mem req type 9
>      ath11k_pci 0001:01:00.0: qmi ignore invalid mem req type 10
>      ath11k_pci 0001:01:00.0: qmi req mem_seg[0] 0x0000000040000000 36700160 1
>      ath11k_pci 0001:01:00.0: qmi req mem_seg[1] 0x0000000000000000 3784704 4
>      ath11k_pci 0001:01:00.0: qmi respond memory request delayed 0
>      ath11k_pci 0001:01:00.0: boot notify status reason MHI_CB_EE_RDDM
>      ath11k_pci 0001:01:00.0: firmware crashed: MHI_CB_EE_RDDM
>      ath11k_pci 0001:01:00.0: ignore reset dev flags 0x2000
>      ath11k_pci 0001:01:00.0: failed to wait qmi memory request: -110
>      ath11k_pci 0001:01:00.0: qmi failed to respond fw mem req: -110
> 
> Why is `CALDB_MEM_REGION_TYPE` always set to physical address 0?

Coldboot cal is disabled for qcn9074.

> Could the crash be caused by platform-specific constraints and not the firmware/driver?

Hard to say. At least from WLAN side there is no known issues when using reserved-memory. 
Can you share your reserved memory node?

> Does it make sense at all to use reserved-memory instead of small memory chunks, for
> example in terms of performance?

There will not be any visible performance differences between reserved-memory and
small memory chunks.

Vasanth

