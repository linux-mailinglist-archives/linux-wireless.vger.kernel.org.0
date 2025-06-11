Return-Path: <linux-wireless+bounces-23990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACFAAD585F
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 16:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8709D188D78E
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 14:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BA322D9E0;
	Wed, 11 Jun 2025 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D5rR6Lo4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0245265608
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651393; cv=none; b=IbSiu9NG+JK1Fr+NKwbi17KM5I/aBXfeDnEG4OHrx6hgWIuhqehYMh5srBMrLG4OM0bjHIqI9oNpcFG4YYOLr69D3nmDXPP511eJngSS/Fl0A7RKYx+cTLLw1K4hFo32IoCjXdlnGoOpaHRvvoeRTgQmZfgpwfn+ebewHhnjQjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651393; c=relaxed/simple;
	bh=ZWLEGREBjhktf3CMN4MbGJXPcv3J7DZmDbpCX/bsjK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APWvJl+4VLWRdFY98oJa0PbX5KhIt8O6j4zdZiThaNy0MBwx0OQm4hwQFprbsKOdLUyrwiLyWXdKM5yHgo427ahFHLMLpRYOv7j9wl2VncQughyPdil7s2byo4u0cLVNDtTsDKh7YKovF2kJYno8U0ekL4PuzC1nlSWnQcf8O/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D5rR6Lo4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9DLch011142
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 14:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BCiQlCAClBfUESlnnsuDq8Amr/xanXzE4AY+Htc7RGo=; b=D5rR6Lo4tH82NjFO
	zo93parf46fMAkn3Ef8nfSo4pkKB1jWec2eL2rAceQayQMoPmusaAAPCXOOVphka
	NO4HWsiBQkmWXKsttGjMsPl8s0y1NczDz3vGOWrFbLKGiFH5kBaPrPq+8rpaXPdh
	5pTLsLgNlZu3JxrkkKKLh/5YfS1zHwCuTE40BXqW+vt22TqKeatk4Uv4gjUrRRHC
	uCYpxNlh6QvhfkoSMf37xr7grzMuWsFp5WLtd+ka4h0g5buP/1ZNr6P1hb3qpVvg
	7ZM++kv1T8HFahGUXWlSolJTUycLX5LoHVc/7qTylJKFHCtLtU5DsmsT91S9UNzK
	qXAWSQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474ekpvwb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 14:16:30 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23632fd6248so22491885ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 07:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749651390; x=1750256190;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BCiQlCAClBfUESlnnsuDq8Amr/xanXzE4AY+Htc7RGo=;
        b=wZTP9dEx1LH++J1caTEipFBlZxy6GMg1Hk09fepWtfPLZs3MJVJtgbFbcyEiC9zdXO
         EE+fZLMgRqpcAMdmhMsiZEbxpRHNEFNULmVxcdsIxbhjKLoAbysp4UxMoYfKnZLgaVL3
         3WfVFuC5dninEMVFT6lmjaFIeAduLrTcPGVm7oely6tWGwL8WdFf5yuIy01OuDMFar0c
         +rn1vgtssjFP1Hx/V3dNMAVdS20bZlq4zBP4nOm5YSPZQlE9sgg+McOEvPJZSPtJ2u+F
         b9dysltfSsm2D0WHgtyR9zS0RFP2KZ+dmPvQ2GXq9IChEhkjQYZXkjM9oK5zSi0Vmccl
         T42g==
X-Gm-Message-State: AOJu0YzsR5sP4PwFWjq3khidEvnJPOAuNqerB35QvnuIvGZt/OMBnUk7
	Xs96gb6YnDtZZ3KcofwRN9nJqJhIBtAQGvgUgJrzQjD7ynmY8BwJc1H4NHPlxx5k/M62GNfpLpp
	KxIZtV8RYVeHId3YPyOoEC5Bu1TejA1LrYQRw9XGsTAPOiEI6dPylDTAxs/X36BoSe8AsnvWlBC
	bWKQ==
X-Gm-Gg: ASbGncuo2SSs4aB9Z5gDOmqmUWmdKCNH9EdfxHqYJvcHNUKSYDi0NpRAH+LlkdKhHzL
	Fc6c7z8BaOj4jf3FYeZFWzsYTAgFztY427TyBIBzmA9EbsgVSoo4ZkXVscgbb1odgieMJRTQ5nS
	vn+2MjeEFTAQiou8rUetI66ryHIK7Pqex1K0uv5/19ObwGarUCwxXH6vmGU5Sivo7By9bqQf0a5
	k7ZEtkryk+DQNxNE+/BktAm5qA2qn5OlPXD+nxJAHoLV+6SVd7gYFsAo46R2pQQr+MDGUxCGK1Z
	/LHzUS57Z7NLvkERiUr0vx11p+gvUM4YCllV/MAC+9yZCn7ts9wMfFiQSUUJnLXtHZfaq9odJnu
	XHQ==
X-Received: by 2002:a17:902:d592:b0:234:c2e7:a103 with SMTP id d9443c01a7336-23642683e35mr36093415ad.33.1749651389468;
        Wed, 11 Jun 2025 07:16:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2uDBQ8igKkYBTsTg0Ikh+u0ovDEWJVCVLhqrSErAiNGtYCfNi9+9t1iCO2ygTczxCDh5jCQ==
X-Received: by 2002:a17:902:d592:b0:234:c2e7:a103 with SMTP id d9443c01a7336-23642683e35mr36092995ad.33.1749651389013;
        Wed, 11 Jun 2025 07:16:29 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603410b4csm88301575ad.212.2025.06.11.07.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 07:16:28 -0700 (PDT)
Message-ID: <2ecbedb6-401e-4023-9eff-8123e2c90c45@oss.qualcomm.com>
Date: Wed, 11 Jun 2025 07:16:27 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull-request: ath-current-20250608
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
References: <6574640b-a383-4c16-bbd2-710f362ed644@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6574640b-a383-4c16-bbd2-710f362ed644@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=JcO8rVKV c=1 sm=1 tr=0 ts=68498fbe cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=mf2Hrz4NSIj861Bm59oA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDExOSBTYWx0ZWRfXzBwCqEEr9/n1
 mQjF0IUoE/S/+jpzXC6qZQi5s/bD+SYrOAK8rz1mpzKAmd0fW/Czt6NZo7/BQPY+8iAwVntdQPx
 MMwogOBsAhtkwUQc6W4qz0rPFWd7jAv/aBqfufJtGEhTDHlnX+CUQflt51vSIbwLjHG4lOc/7Ii
 EZB6ch+hMd3taF+tNJ+ns0huZaJ+hfp12pwWwYwspxgDHFogxrBUB8b9gOX02g1P4eur47zXtQx
 H2yG3BUxfRXqyh6poELSzr+zWTbfVzwuPlVt2aXrHQNue+QmI0eewzM3QB/oxmd2Ww8qeVQjfRe
 15pR01h9TapR8TWi/WCmJT0O1swdqvtOvAnDE0tpeMd+2kVDoBqHQnZuQkYgCIbWImW5Ho1mO37
 UBLfvUtd0omk1OOTx8yvMx8EIDLcpCtoJiByvKdjJPbD30GklA0TPWtJClB5Jp35O3knXvA4
X-Proofpoint-GUID: rMpevCB_ppcForzfLs3zn06yU_V6OwtW
X-Proofpoint-ORIG-GUID: rMpevCB_ppcForzfLs3zn06yU_V6OwtW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110119

On 6/8/2025 10:07 AM, Jeff Johnson wrote:
> The following changes since commit 1b98f357dadd6ea613a435fbaef1a5dd7b35fd21:
> 
>   Merge tag 'net-next-6.16' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2025-05-28 15:24:36 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20250608
> 
> for you to fetch changes up to f3fe49dbddd73f0155a8935af47cb63693069dbe:
> 
>   wifi: ath12k: fix uaf in ath12k_core_init() (2025-06-07 07:41:50 -0700)
> 
> ----------------------------------------------------------------
> ath.git updates for v6.16-rc2
> 
> Fix a handful of both build and stability issues across multiple drivers.
> 
> ----------------------------------------------------------------
> Baochen Qiang (8):
>       wifi: ath11k: avoid burning CPU in ath11k_debugfs_fw_stats_request()
>       wifi: ath11k: don't use static variables in ath11k_debugfs_fw_stats_process()
>       wifi: ath11k: don't wait when there is no vdev started
>       wifi: ath11k: move some firmware stats related functions outside of debugfs
>       wifi: ath11k: adjust unlock sequence in ath11k_update_stats_event()
>       wifi: ath11k: move locking outside of ath11k_mac_get_fw_stats()
>       wifi: ath11k: consistently use ath11k_mac_get_fw_stats()
>       wifi: ath12k: fix GCC_GCC_PCIE_HOT_RST definition for WCN7850
> 
> Caleb Connolly (1):
>       ath10k: snoc: fix unbalanced IRQ enable in crash recovery
> 
> Jeff Johnson (1):
>       wifi: ath12k: Fix hal_reo_cmd_status kernel-doc
> 
> Loic Poulain (1):
>       wifi: ath10k: Avoid vdev delete timeout when firmware is already down
> 
> Miaoqing Pan (1):
>       wifi: ath12k: fix uaf in ath12k_core_init()
> 
> Rodrigo Gobbi (1):
>       wifi: ath11k: validate ath11k_crypto_mode on top of ath11k_core_qmi_firmware_ready
> 
> Sebastian Gottschall (1):
>       wil6210: fix support for sparrow chipsets
> 
>  drivers/net/wireless/ath/ath10k/mac.c        |  33 ++++--
>  drivers/net/wireless/ath/ath10k/snoc.c       |   4 +-
>  drivers/net/wireless/ath/ath11k/core.c       |  29 +++---
>  drivers/net/wireless/ath/ath11k/core.h       |   4 +-
>  drivers/net/wireless/ath/ath11k/debugfs.c    | 148 +++------------------------
>  drivers/net/wireless/ath/ath11k/debugfs.h    |  10 +-
>  drivers/net/wireless/ath/ath11k/mac.c        | 127 +++++++++++++++--------
>  drivers/net/wireless/ath/ath11k/mac.h        |   4 +-
>  drivers/net/wireless/ath/ath11k/wmi.c        |  49 +++++++--
>  drivers/net/wireless/ath/ath12k/core.c       |  10 +-
>  drivers/net/wireless/ath/ath12k/hal.h        |   3 +-
>  drivers/net/wireless/ath/ath12k/hw.c         |   6 ++
>  drivers/net/wireless/ath/ath12k/hw.h         |   2 +
>  drivers/net/wireless/ath/ath12k/pci.c        |   6 +-
>  drivers/net/wireless/ath/ath12k/pci.h        |   4 +-
>  drivers/net/wireless/ath/wil6210/interrupt.c |  26 +++--
>  16 files changed, 228 insertions(+), 237 deletions(-)

Johannes,
I'm accumulating some more patches for "current". It would be nice to get this
first set pulled so that I can cleanly fast-forward and apply the next set.

Thanks!
/jeff

