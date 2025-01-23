Return-Path: <linux-wireless+bounces-17867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0ABA1A91F
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 18:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43843A57FA
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2025 17:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B3F149C57;
	Thu, 23 Jan 2025 17:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bP5wsDZU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875672AE6C
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654476; cv=none; b=R8AgxuifOmCMJpC+/WEpeRYGNG0O7E5xf1m/vP4wGmn1G7KGBDveZ8P9KeqnXGQJlgrF9bsp3S5/eRbj3kN2sMfdsEjVQ2IdDDSRTD5VSzM0ba6C2HL+rdTZdFzWXnJdwgdNdogG2pYrt0GA4yWzgCXaLKKEjT+EIvFQks8sXMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654476; c=relaxed/simple;
	bh=79JjxXzLda6kL4u4Sjk9aMmj7fsXBhL4PqdfIdegfc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZvyA24mWSsXwUwoYyeqLJWUASWYhJewYv3Qi1WLqIJgbWTHFL2EEOdKMgh4Q9Jq6bebd6c/VxHcUE6WLaDqMCD4HQJyUI153nyhYoD58oEJ8U9O5pINRSJhOdLmLyki+E8O2rPKmnnYb+1K3stDS52tIMeOkHAt94/vyzGxy3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bP5wsDZU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NA3H1h016535
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 17:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yrQFLyIdh+flfNgP74gz4jh045Jz2p5sDUGhO3KBB+E=; b=bP5wsDZUtD5K2tvV
	hGV32/mgiSEkTcbnVGrgDcWdG5AEsaa9r0SJJtpFhokusQq1yEgpM2reyYP5lV0S
	2MOrf6PvRnRv2rb62zJx5DdrkPrFc9u9KYntUJGr7tdStxvXEX2tq5STJByOgj6/
	kfi2e2CLIcKJerc8l9rSybHHbehFQPM15b0YXKv3wNlWU6UbYDFoV3n9KDk2bBnx
	fZjiChos0nselhVzZ+1Nq4REC0QTlNK7ozWQPI9zzhPOUHniLMC5BX2/7aNc8nJ4
	3MVNrwSCQsrnPFzs6q7na6p6PwNl5w6hphUu0YeCcDnIYoGadazUr6kqpwIjdM20
	ukB4pw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44bknxh34k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 17:47:53 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef9204f898so2457277a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jan 2025 09:47:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737654472; x=1738259272;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrQFLyIdh+flfNgP74gz4jh045Jz2p5sDUGhO3KBB+E=;
        b=tB2Cpx6GDh9TTkVfZRnV2XN6Y58fI+xD3cZQiaQzPNVQRsPrYBkwbNGBbmOoG1XFU5
         WPXmWQmKskHl/C5n/BonuqH98JxZ2XXk4NZzAGde7ASksWRYQgyjVo1hlHa0C9XSv9uN
         nB2o37jM3nokHztj92i+KYiv0EhMUWVvOgDa5fHlVjF7WE0DNOO/y/eyjVVUuaLJNNlI
         L/Ks5jXRHdf+35dqEDJUN9XynpaZUgQT4Ra40vBL0xy0lhyHhWx7/zwU3Z4X8rSIp7Ix
         /t2ahSsvJqir2W0TheSXkxorfC+DCV9du3bzNC6zSKefRfZfu8LisxpQA3KlXDPpF9fu
         nyng==
X-Forwarded-Encrypted: i=1; AJvYcCV7ImzQbmIFx1ZqN8XMTn25f5baCBIX1eKJuqQWUD7yxz8UnlpvwYKQcR66BWTAez4jRz/FPNdon3S8aakYpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGjzb+bERrOc5z2pLrL4/6BZdb1rO8MCqvwUFIGPI50/U8LtzE
	rygJ1S3tORagmtUStloXGjHVe76v2snQ1zDdw3k3AXdEUfen0o6fp/WXLMY+UpH816Gt6mt3GkS
	BPEltq4ZMriaqViKxuWyhXvfr2xRjrPgT/BOIl+G4BlfSfH9IpFU/pxmlW/LTBvBjLg==
X-Gm-Gg: ASbGnctwrslMmJnxGO1CxIiFZNaXO9YM0/2I98JECff92uapGzJLiXAZj2wvYcH4M15
	jbQZ8Zv1Yt30fXVMhgoNcQAVbfX65Z5JuptvD1gh5vgXo4+QEicl2hw4IaOUk6Ga+5nkVNlV5rQ
	BmC2lDiJYAxxMG+9SO/X40Lj+pusT9lJF/FqnCPLuikK1gYferBcpNFdnDDYUJrcWPedXXgSrFD
	xKlV3UZOMHDTF8naJplBFy7BweE6MxHuPGdgBtgSZ6THtG9iZa3/4/Kr9ORYIfdI59tFFTzkx2x
	0kNZYFxMbDe5jLcg0zp7yWsnR8VJzkfyk/1L3ZIqcQFsWqMhCDe2AMdUhtN9neE=
X-Received: by 2002:a05:6a00:1804:b0:725:9f02:489a with SMTP id d2e1a72fcca58-72dafa8382cmr34506756b3a.17.1737654471821;
        Thu, 23 Jan 2025 09:47:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2JhzpFubtHNvs+TS/dk2pw0IDu/um/xcIf8+0HRFPSeJMUAs3ed8/zHm4eve2Y7QP7XHFDQ==
X-Received: by 2002:a05:6a00:1804:b0:725:9f02:489a with SMTP id d2e1a72fcca58-72dafa8382cmr34506731b3a.17.1737654471423;
        Thu, 23 Jan 2025 09:47:51 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6b3f86sm215890b3a.67.2025.01.23.09.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 09:47:51 -0800 (PST)
Message-ID: <c9c9dfb7-7198-4575-a576-d5e184ba2cba@oss.qualcomm.com>
Date: Thu, 23 Jan 2025 09:47:49 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] wifi: ath12k: fixes for rmmod and recovery
 issues with hardware grouping
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo
 <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>
Cc: Kalle Valo <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250120-fix_reboot_issues_with_hw_grouping-v2-0-b7d073bb2a22@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250120-fix_reboot_issues_with_hw_grouping-v2-0-b7d073bb2a22@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3Avkv9MidKzSm58zMApiuNZygtDg5lDv
X-Proofpoint-GUID: 3Avkv9MidKzSm58zMApiuNZygtDg5lDv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230130

On 1/20/2025 1:48 AM, Aditya Kumar Singh wrote:
> With hardware grouping, there is a kernel crash with signature -
> 
> $ rmmod ath12k.ko
> Unable to handle kernel paging request at virtual address 000000000000d1a8
> [...]
> Call trace:
>  ath12k_reg_free+0x14/0x74 [ath12k] (P)
>  ath12k_core_hw_group_destroy+0x7c/0xb4 [ath12k] (L)
>  ath12k_core_hw_group_destroy+0x7c/0xb4 [ath12k]
>  ath12k_core_deinit+0xd8/0x124 [ath12k]
>  ath12k_pci_remove+0x6c/0x130 [ath12k]
>  pci_device_remove+0x44/0xe8
>  device_remove+0x4c/0x80
>  device_release_driver_internal+0x1d0/0x22c
>  driver_detach+0x50/0x98
>  bus_remove_driver+0x70/0xf4
>  driver_unregister+0x30/0x60
>  pci_unregister_driver+0x24/0x9c
>  ath12k_pci_exit+0x18/0x24 [ath12k]
>  __arm64_sys_delete_module+0x1a0/0x2a8
>  invoke_syscall+0x48/0x110
>  el0_svc_common.constprop.0+0x40/0xe0
>  do_el0_svc+0x1c/0x28
>  el0_svc+0x30/0xd0
>  el0t_64_sync_handler+0x10c/0x138
>  el0t_64_sync+0x198/0x19c
> Code: a9bd7bfd 910003fd a9025bf5 91402015 (f968d6a1)
> ---[ end trace 0000000000000000 ]---
> Segmentation fault
> 
> This series aims to fix this stability issue. With this now, 100+ iteration
> of rmmod and insmod works perfectly.
> 
> Also, firmware recovery with grouping is not working fine. Randomly, some
> NULL pointer crash or another firmware assert is seen. This series aims to
> fix that as well.
> 
> With this in place now, 100+ iteration of firmware recovery with one 3 link
> AP MLD up works fine.
> 
> ---
> Changes in v2:
> - Rebased on ToT.
> - No changes in 1-4, 6-10.
> - Removed regd_freed flag in 5.
> - Link to v1: https://lore.kernel.org/r/20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com
> 
> ---
> Aditya Kumar Singh (10):
>       wifi: ath12k: prevent race condition in ath12k_core_hw_group_destroy()
>       wifi: ath12k: add reference counting for core attachment to hardware group
>       wifi: ath12k: fix failed to set mhi state error during reboot with hardware grouping
>       wifi: ath12k: fix firmware assert during reboot with hardware grouping
>       wifi: ath12k: fix SLUB BUG - Object already free in ath12k_reg_free()
>       wifi: ath12k: fix ath12k_core_pre_reconfigure_recovery() with grouping
>       wifi: ath12k: fix ATH12K_FLAG_REGISTERED flag handling
>       wifi: ath12k: handle ath12k_core_restart() with hardware grouping
>       wifi: ath12k: handle ath12k_core_reset() with hardware grouping
>       wifi: ath12k: reset MLO global memory during recovery
> 
>  drivers/net/wireless/ath/ath12k/core.c | 115 ++++++++++++++++++++++++++++++---
>  drivers/net/wireless/ath/ath12k/core.h |  15 +----
>  drivers/net/wireless/ath/ath12k/mac.c  |   6 --
>  drivers/net/wireless/ath/ath12k/pci.c  |  28 +++++++-
>  drivers/net/wireless/ath/ath12k/qmi.c  |  24 ++++++-
>  drivers/net/wireless/ath/ath12k/qmi.h  |   4 +-
>  drivers/net/wireless/ath/ath12k/reg.c  |   4 +-
>  7 files changed, 163 insertions(+), 33 deletions(-)
> ---
> base-commit: e7ef944b3e2c31b608800925e784f67596375770
> change-id: 20241218-fix_reboot_issues_with_hw_grouping-0c2d367a587b
> 

Fails to apply to current ath/main

* Applying v2_20250120_quic_adisi_wifi_ath12k_fixes_for_rmmod_and_recovery_issues_with_hardware_grouping.mbx 
Applying: wifi: ath12k: prevent race condition in ath12k_core_hw_group_destroy()
Applying: wifi: ath12k: add reference counting for core attachment to hardware group
Using index info to reconstruct a base tree...
M       drivers/net/wireless/ath/ath12k/core.c
M       drivers/net/wireless/ath/ath12k/core.h
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath12k/core.h
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/core.h
Auto-merging drivers/net/wireless/ath/ath12k/core.c
Recorded preimage for 'drivers/net/wireless/ath/ath12k/core.h'
error: Failed to merge in the changes.
Patch failed at 0002 wifi: ath12k: add reference counting for core attachment to hardware group


