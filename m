Return-Path: <linux-wireless+bounces-26482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2F5B2E70A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 22:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84100A257F4
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 20:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2B6296BA7;
	Wed, 20 Aug 2025 20:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RAkiQxje"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E31287266
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 20:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723442; cv=none; b=jYvD4IKEdDuYXMx/sBuzk7UZnUZ5VvjGxrXvNYVDxuxR2E/jcH0JkT+PmbWc5MnI+eMrUu2zEqQFUH4ZHD4izNWJHPNsCa6I7A/HGVqpNsBQBk/3qfR3BOTdt6NSnMYP/MPwWme5Iu7nzw4eVF1ei0osQTxTPOZiXwbirh7Aazw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723442; c=relaxed/simple;
	bh=DTeJEZ7x0t72AA0KBk7bvergalGHRptUQ6dkMs34hIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dsjMTk+H4ztNhcPTWwEiTJTvmOVvQeDkEIltIN1Qx80PGThfnkaH91gciTIZ8CFQfmcLWbw71cxzyIw9lFDRHbFKKY2yX/vFBnK2R+wA56I2BIQY7Ra7JMSjasWnYj1EIw8qAIdYIM2EarNNhtrNKXbK+FFh73pWPfKDikgVcPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RAkiQxje; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KFCvxr021483
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 20:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1fDC6r2SIInT6VaiKM7NcqOe2r1gA2B4tJ4sn4+Dqg8=; b=RAkiQxjeECYseapk
	QKu+nkFzrtDgubC6kB7S5zhQ3jQk96SVFNy0j5G9m7zS6E9aWtZwCz3W+GRzZ5hC
	HqierVDqiwOiVwxR8EblvKr5tPD+7egu5AuFxUvMO3BAc2yFvydDAdPLkL8b/Cms
	hXx/1oWYcTD9iWqwgYU1T14s6uWEuuCAswpJRRyzCgSe0HnNaANy/MvCFKVw5FiP
	UtHZWTa8pvWGx7wdoiYgcrWREAKv2/4CtYA3jkB+ToZK4TGMwdYDwE4GwHhmjIvc
	Os5Lw5jF0fuSEJlNcd65ON8BuiIWMteMbccWXZ0EpscWT8oda0KHECu4c90aMcrT
	CyOgWQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngtdgxbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 20:57:19 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e92b3dde9so320704b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 13:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755723439; x=1756328239;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fDC6r2SIInT6VaiKM7NcqOe2r1gA2B4tJ4sn4+Dqg8=;
        b=qNZCBm4WY4Kgyf+tmFD7X2Omhjyb71BjmAfbAmt8LhoxLJ+/TY/4xkn3Mr/Dw4LkXP
         EQjz4AyI9t1ipXiFEDjW+W9LdzcCNmbqiPi/tjnMWQkLmPtAo/peCJUMooZZbA2bxuh6
         vVyJE2vCWLWR8tAbBCJ4V1NBeq4aAzXGRqoBeTkTYpv+16UKO53z3quQdiBkgOEE9mmp
         1rXZji1npyWgexYO4KcBZcT0//zQaUVlFy1aL/Uy5eBrfi0Eqai++0f4XRBKO7baOZHm
         1mrQJmCLWzOPPKzb+XwmkRg2rwx4xfBz9tivZUbETlP5Fl5VkZ81h+nkujBgeuY3LV8B
         6CLQ==
X-Gm-Message-State: AOJu0YyL9LBa/adJJV4Bb7iXtBg3qzBF8uR+osn505WGx04DJwkQC0Fh
	2+PJssjvJXYALeGAgGS1cWrU3VEH1BolWq9aVL1yYhTd13sVDx+FD9lPiuA6oPdYS8qutPSupT2
	bOW4ievhnj6XYksNcb8JrBITOsL9Gjb7zvhGBG4fa+72oIFdmVviFdLi+DGYo8RnbwAqwVg==
X-Gm-Gg: ASbGncud1nDSH69Rl+ygyCqkb//Mj0roicUQMbo1A89PlPz7GQhWgqg9sVvQpWZ2YEp
	RuHEkInOMlysznE3NusFgonnUQLdZmPhHL9MMh4hqEL1mDbUweVw2N4QroZDgp2JSKmqRSfjdha
	0/s9+zhSyd9vIPrKyc6ozS4qK2eEmShcipUyJVA2K5RXBhCiMxa1fI5BZR8oYeft1TKWUGIxG2F
	Jd1bj9LJqEcdYdnloKBzf3vf2Cc3styWtR4SpY54Jrillb7KSPSvbumWG7bPTDYJuWWIGxAjvxk
	yIQE2NeLiCN3V+LowIrcy0hU7sQR3Tn3Vl4+bsbtCuo8gPEkd5H3YwR9w2HkWoUpqjqwRXfNdSM
	TRxP1WIWzxjwxjRfThcGTwOOEpSv0uZS0
X-Received: by 2002:a05:6a00:464f:b0:748:e9e4:d970 with SMTP id d2e1a72fcca58-76e8db9d13cmr5495754b3a.1.1755723438698;
        Wed, 20 Aug 2025 13:57:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtN6JIMaLshcAWm/1Oml6qOXlbk10d0Pi6SBn9RnM2kXQfE6UL8bQFfRjqNG90FjwuNlOo0Q==
X-Received: by 2002:a05:6a00:464f:b0:748:e9e4:d970 with SMTP id d2e1a72fcca58-76e8db9d13cmr5495735b3a.1.1755723438159;
        Wed, 20 Aug 2025 13:57:18 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f7818sm6270394b3a.73.2025.08.20.13.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 13:57:17 -0700 (PDT)
Message-ID: <02584bb9-364e-4391-957f-7833d6bc0f79@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 13:57:16 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath12k-ng 00/13] wifi: ath12k: Ath12k modularization
 changes
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Kiran Venkatappa <quic_kiranv@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250812-ath12k-mod-v1-0-8c9b0eb9335d@quicinc.com>
 <110b6e64-7a9c-4a8f-9b1c-830251d6c733@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <110b6e64-7a9c-4a8f-9b1c-830251d6c733@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LexlKjfi c=1 sm=1 tr=0 ts=68a636af cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=PvsNls7aUaJVk6CwgFkA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: uOa-ZnRGW_IqFoUyJQBrQUQwMqwqZdSF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNSBTYWx0ZWRfXz1ihTRv8NpwZ
 Rb6yzKhgS3fmefAP+bg/Fh27GIrswRmF1HjGAIra1Yw4htRoVutl7FaYG2rKiKhwimPZfifyvHJ
 O3oE3MEV57/MX8e1Rhtf4vthwZo+ZZHhX0YlKcDC+nMR0oUer33AnslHL6ffZ9XGZ1RNbuETzM0
 gmZ6ZwdrA2J2MCklNbhlDN7BXtZQ07SNklzTdHpG9E+e6f37yNNAbiIMMw3M2GJBdzbrXJKmi55
 0J0+gZlOWXfC40fTqPsetjx0X2uzI3NH0ia3ZX1HNzqz7OUr3eUEvONFGfT8mMu65e8oUNCojXG
 SDYudTo74hhIpPbF2SBKGmlaSVRFdEwUTvjWo2YkgqWzLQarUNfU5lkKSkXL6l1skLpLUM9eejx
 +ArimVtw5cHnFaSiwHDPSKQPAPBenQ==
X-Proofpoint-ORIG-GUID: uOa-ZnRGW_IqFoUyJQBrQUQwMqwqZdSF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200135

On 8/20/2025 12:11 AM, Baochen Qiang wrote:
> 
> 
> On 8/13/2025 1:09 AM, Kiran Venkatappa wrote:
>> Current ath drivers have separate implementations for different
>> classes of devices. For example, ath11k supports WiFi-6 devices,
>> while ath12k supports Wi-Fi 7 devices. However, there is significant
>> common functionality across these generations due to shared firmware
>> and hardware architecture. In the existing driver code, this leverage
>> is achieved through code duplication. As a result, when a new driver
>> is introduced, many features are missed, and new additions require
>> porting across different generation drivers.
>>
>> To improve reuse and maintainability, ath12k should be split into common
>> and device-specific modules. Common code can be shared across multiple
>> architectures, enabling better leverage for future hardware generations.
>> generation drivers.
>>
>> Firmware interfaces and core initialization sequences are typically common
>> across different device families. In contrast, hardware register offsets, copy
>> engine mappings, and HAL configurations are usually hardware-specific.
>>
>> Common components include:
>>       - mac80211 interface: Control path operations are mostly common across
>>         different ATH hardware and will be shared as much as possible.
>>       - Firmware interface (WMI, HTT, HTC, QMI): Firmware messaging and
>>         sequences are common and maintained with backward/forward compatibility
>>         using TLVs.
>>       - Datapath: Data path files are also separated similarly. More information
>>         will be provided in later patches.
>>       - Core initialization, reset, and recovery sequences: These will be part
>>         of the shared code.
>>
>> Device-specific code includes:
>>       - Hardware capabilities, configurations, HAL, and other
>>         architecture-specific logic.
>>
>> The original ath12k.ko is split into these two modules as depicted below.
>>
>>                                       +-----------------+
>>                                       |                 |
>>                                       |   ath12k.ko     |
>>                                       |    (common)     |
>>     +---------------+                 |                 |
>>     |               |                 +-----------------+
>>     |   ath12k.ko   | ===========>
>>     |               |                 +------------------+
>>     +---------------+                 |                  |
>>                                       | ath12k_wifi7.ko  |
>>                                       | (wifi7 family)   |
>>                                       |                  |
>>                                       +------------------+
>>
>> The ath12k.ko module will serve as the common component, while ath12k_wifi7.ko
>> will be the architecture-specific module for WiFi-7 devices.
>>
>> After this modular separation, adding support for a new device will
>> primarily involve implementing device-specific code, while reusing the
>> majority of the shared common components.
>>
>> ---
>> Kiran Venkatappa (13):
>>       wifi: ath12k: Restructure PCI code to common and Wi-Fi 7 specific logic
>>       wifi: ath12k: Move Copy Engine configuration to Wi-Fi 7 specific file
>>       wifi: ath12k: Move Wi-Fi 7 WMI configuration to dedicated file
>>       wifi: ath12k: Move Wi-Fi 7 MHI configuration to dedicated file
>>       wifi: ath12k: Rename hw.c to Wi-Fi 7 specific implementation file
>>       wifi: ath12k: Rename ahb_hif_ops to reflect generic usage
>>       wifi: ath12k: Restructure ahb.c into common and Wi-Fi 7 specific modules
>>       wifi: ath12k: Move Wi-Fi 7 specific init routines to dedicated file
>>       wifi: ath12k: Move hw_init invocation to target-specific probe
>>       wifi: ath12k: Modularize driver into common and Wi-Fi 7 specific components
>>       wifi: ath12k: Rename ath12k_* symbols to ath12k_wifi7_* for clarity
>>       wifi: ath12k: Remove HAL defines from shared PCI code
>>       wifi: ath12k: Remove HAL define dependencies from shared AHB code
>>  
>>  drivers/net/wireless/ath/ath12k/Makefile         |   4 +-
>>  drivers/net/wireless/ath/ath12k/ahb.c            | 139 ++--
>>  drivers/net/wireless/ath/ath12k/ahb.h            |  27 +-
>>  drivers/net/wireless/ath/ath12k/ce.c             | 301 -------
>>  drivers/net/wireless/ath/ath12k/ce.h             |   5 +-
>>  drivers/net/wireless/ath/ath12k/core.c           |  38 +-
>>  drivers/net/wireless/ath/ath12k/core.h           |   7 +
>>  drivers/net/wireless/ath/ath12k/debug.c          |   4 +
>>  drivers/net/wireless/ath/ath12k/dp_rx.c          |   3 +
>>  drivers/net/wireless/ath/ath12k/hal.c            |   4 +
>>  drivers/net/wireless/ath/ath12k/htc.c            |   2 +
>>  drivers/net/wireless/ath/ath12k/hw.h             |   2 -
>>  drivers/net/wireless/ath/ath12k/mhi.c            | 130 ---
>>  drivers/net/wireless/ath/ath12k/mhi.h            |   4 +-
>>  drivers/net/wireless/ath/ath12k/pci.c            | 215 ++---
>>  drivers/net/wireless/ath/ath12k/pci.h            |  28 +-
>>  drivers/net/wireless/ath/ath12k/peer.c           |   2 +
>>  drivers/net/wireless/ath/ath12k/wifi7/Makefile   |  10 +
>>  drivers/net/wireless/ath/ath12k/wifi7/ahb.c      |  71 ++
>>  drivers/net/wireless/ath/ath12k/wifi7/ahb.h      |  20 +
>>  drivers/net/wireless/ath/ath12k/wifi7/ce.c       | 973 +++++++++++++++++++++++
>>  drivers/net/wireless/ath/ath12k/wifi7/ce.h       |  22 +
>>  drivers/net/wireless/ath/ath12k/wifi7/core.c     |  44 +
>>  drivers/net/wireless/ath/ath12k/{ => wifi7}/hw.c | 798 +++----------------
>>  drivers/net/wireless/ath/ath12k/wifi7/hw.h       |  13 +
>>  drivers/net/wireless/ath/ath12k/wifi7/mhi.c      | 138 ++++
>>  drivers/net/wireless/ath/ath12k/wifi7/mhi.h      |  11 +
>>  drivers/net/wireless/ath/ath12k/wifi7/pci.c      | 188 +++++
>>  drivers/net/wireless/ath/ath12k/wifi7/pci.h      |  12 +
>>  drivers/net/wireless/ath/ath12k/wifi7/wmi.c      | 105 +++
>>  drivers/net/wireless/ath/ath12k/wifi7/wmi.h      |  15 +
>>  drivers/net/wireless/ath/ath12k/wmi.c            |  97 ---
>>  drivers/net/wireless/ath/ath12k/wmi.h            |   4 -
>>  33 files changed, 1956 insertions(+), 1480 deletions(-)
>> ---
>> base-commit: d9104cec3e8fe4b458b74709853231385779001f
>> change-id: 20250812-ath12k-mod-bd00156df202
>>
> 
> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>>

I dropped the extra ">" when applying to the patches in 'pending'

/jeff

