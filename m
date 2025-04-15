Return-Path: <linux-wireless+bounces-21560-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA11A8A5F2
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 19:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06B63A55C4
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Apr 2025 17:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E1E22170B;
	Tue, 15 Apr 2025 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jdDb9Nkf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7643221549
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744739184; cv=none; b=jMyrDzpkxbjv31/u+fR0xh3MQA7CxX2QV/D+ApKNi/HDG0Uwto8pyRxa55B9e9FejjknvYbqKLZl6wyeAI+gL2kFMsDzx5uhqdA/ZixVJk7lUCg6z65JXSY/ijiA5IiMmEzAfP6gwXqpme7Ioc29jEAUDzdpInk6kYTVGX/M6hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744739184; c=relaxed/simple;
	bh=K3vtbJEwt2mv2/xFrCsmC1k9kgUgP7kBUY2Q0jA0y/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sH5d4bJQbpGmOyPz0FUWkKTvFePTurjxbuc8NGKhrQwTc1n5p/8SpcFIOtTgnpx6BkDvsuzqrdDUmH3OMYd5HAUjP/w1AjqIM9eyQEOkTmkIqJoKonKmapX+4zVALZOZOfd/3YemR90cOqi+Vna685d69bINr0zmOK+yytk8DbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jdDb9Nkf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8tN2A002462
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 17:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WmopbRSr1BMuUIsQ83eBA4mll4c1c++hcr0bvXHjetQ=; b=jdDb9Nkf6fFC3J74
	NcIGVY7vNeCe+ybOpFp2aZMJQmQpPnjKpbFtmrbtK26kkDLzsvWuTSEuW74+hN5d
	fDGniTgCENRzWYwXuyVOHvcm5PuNfkXEgrhhxlPEzWJEm2SDHLxQDM/7XN+6cQmb
	+K8wZnCK7Md/H6bdkoI47/gQHnhzBEnRRKOXDFHZyLfS4+KFhQgSL46AxDdLJo8k
	zE44PdJoHqp9NKMK2TILh1oPas91z1q+2YOsmYs0rbDSxUDYz8nkpZ6mW4WfHHoc
	tXUEkV6zrWmGilP/kob/fs3Uiu4VrC0qh0r4l+MTFXkIJsVGTS4YYWoCuglzN0XT
	JRo1/Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygxk0uk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 17:46:21 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2242ce15cc3so45502245ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 15 Apr 2025 10:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744739180; x=1745343980;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmopbRSr1BMuUIsQ83eBA4mll4c1c++hcr0bvXHjetQ=;
        b=m91iK5PvEZOziRJb3M5wxQjrwqMOR/xIiqhOt6zuOxodJNYkmx0rZ9e56nv5Ja6UBn
         4a2VvBwpsrYvgX27SJcKlvkEu75M98K6Gwwnd7zkjc2JZoBQ+yoa0hbVzabZiMZ51qPK
         x2OqPR+qQz3ELGta0W9zImeyu3uhqyA9OSFsKkUH7a0J4BIx846GOvCaSdu6te+EvK4j
         mT9iEIvnFtZvq4/UeXYsRsO13F0B6d9skUUw6f49xXRBuoye2I9tZKKpsJ3eZ38Fgm5G
         fwI90JLPI8EUb2S2XfXovTxj5SMOCe1ZRTrmB1kVf8Cfe+f4fNn6wdT4onXULrrViXNj
         ZZZw==
X-Gm-Message-State: AOJu0Yxhe+fCO4lJ8aqHUO+HS2C5j6iGJz1P8AzKG/RPNxYTkR8eFGhT
	f21Kpf+q/t8uJ6SPhLoYNMqkd67iRL6MfwlqM06+4JkGcQEiOmBbH/MGKKwIdnbkbT5i08K64z7
	TyV7nSxQpLOkKwA1jaBzUMzrdYiJbR7EacaxELAqGhEU78xCpgSBBpSvkSqfS8oCVE9qYeoDuwQ
	==
X-Gm-Gg: ASbGnctjjg9Qvke1bsXOrIAFcfllZEYtpF7yu8kaRiwkvJJRE9DPU4GtW+a/OZIjbN5
	Zk3ZPNp4S/pT6xquCa0OvRLyuE87NQ4b9yhL7y9QoO9SCPwdvyjLRLUj4IwQmir72ECRYKHp9nY
	kKr0ZDBenPVKZdeQYcU98CakChMkMYt3uz/+jK6EQd42EMBDLLpE4u/jY3hh94GjlWye955orSs
	0cdKPOZl+MTnpTZP3qstpyf9Pl3Ntf4h3CL1PN/CqF3jteb2Mam7JwIFgrsfw8ek69pIfuE45Kn
	BzumhZWwCESrKd08/3kmfWvUrnvmRWUn67matrLCTrRejeg+ZPgLa3mT2bAU7+SYbHU=
X-Received: by 2002:a17:902:ce89:b0:223:44c5:4eb8 with SMTP id d9443c01a7336-22c31ace41amr122605ad.32.1744739180362;
        Tue, 15 Apr 2025 10:46:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpxgKBEeHRzhsR+/KI+ZeJc2xPeAIkHTjIeWtXWs3CpMsBYr+ieCwWVlDOHbfXlup3IoaA3A==
X-Received: by 2002:a17:902:ce89:b0:223:44c5:4eb8 with SMTP id d9443c01a7336-22c31ace41amr122115ad.32.1744739179859;
        Tue, 15 Apr 2025 10:46:19 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb6825sm120476665ad.193.2025.04.15.10.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 10:46:19 -0700 (PDT)
Message-ID: <c8236051-4341-4d49-a6d8-283320aff2f6@oss.qualcomm.com>
Date: Tue, 15 Apr 2025 10:46:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V12 0/9] wifi: ath12k: add MU-MIMO and 160 MHz bandwidth
 support
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250408010132.3699967-1-quic_pradeepc@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250408010132.3699967-1-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=67fe9b6d cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=fskyjysVZrdRFQ4nWXgA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: ykXkT7YHuw88l2g5LzfB7jv3EmEK2PFj
X-Proofpoint-ORIG-GUID: ykXkT7YHuw88l2g5LzfB7jv3EmEK2PFj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_07,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150124

On 4/7/2025 6:01 PM, Pradeep Kumar Chitrapu wrote:
> Add support for
> 1. enabling MU-MIMO in HE and EHT modes from hardware
> 2. setting fixed HE rate/GI/LTF
> 3. 160 MHz bandwidth in HE mode
> 4. extended NSS bandwidth support
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> changes in v12:
>  - rebase
> 
> changes in v11:
>  patch 1/9:
>   - fix return values in ath12k_mac_set_he_txbf_conf() and
>     ath12k_mac_vif_recalc_sta_he_txbf()
>  patch 6/9:
>   - fix missing he_mcs initialization in ath12k_mac_init_arvif()
> 
> changes in v10:
>  patch 6/9:
>   - use ath12k_ahsta_to_sta()
>   - fix rcu_dereference warning in ath12k_mac_set_bitrate_mask_iter()
>   - change return type for ath12k_mac_validate_fixed_rate_settings()
>   - improve readability by adhering to nl80211 definitions of GI
>     NL80211_TXRATE_DEFAULT_GI. Introduce ath12k_mac_nlgi_to_wmigi()
>     for conversion.
>  patch 7/9:
>   - do not change default MODE_11AC_VHT160 in
>     ath12k_mac_get_phymode_vht() as it breaks clients which do not
>     set VHT_CAP_SUPP_CHAN_WIDTH_160MHZ.
>  patch 8/9:
>   - Use IEEE80211_VHT_CAP_EXT_NSS_BW_MASK along with
>     IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ for determining VHT160
>     phymode.
> 
> changes in v9: rebase on top of master branch with mlo changes
>  patch 1/9 and 2/9:
>   - fetch link_conf using ath12k_mac_get_link_bss_conf()
>     instead of arvif->vif->bss_conf before mlo
>  patch 6/9
>   - fetch mcs/nss values from sta->link[] instead of sta->deflink
>   - fix spelling of 'incompatibility'
>  patch 8/9
>   - replace sta->deflink.addr with arsta->addr in
>     ath12k_peer_assoc_h_vht
>  patch 9/9
>   - replace sta->deflink.rx_nss with link_sta->rx_nss
> 
> changes in v8:
>  - rebase and resolve KASAN warnings reported by Jeff in v7, in patch 6/9.
> 
> Pradeep Kumar Chitrapu (9):
>   wifi: ath12k: push HE MU-MIMO params to hardware
>   wifi: ath12k: push EHT MU-MIMO params to hardware
>   wifi: ath12k: move HE MCS mapper to a separate function
>   wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
>   wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
>   wifi: ath12k: add support for setting fixed HE rate/GI/LTF
>   wifi: ath12k: clean up 80P80 support
>   wifi: ath12k: add support for 160 MHz bandwidth
>   wifi: ath12k: add extended NSS bandwidth support for 160 MHz
> 
>  drivers/net/wireless/ath/ath12k/core.h |    2 +
>  drivers/net/wireless/ath/ath12k/mac.c  | 1141 ++++++++++++++++++++----
>  drivers/net/wireless/ath/ath12k/mac.h  |   17 +
>  drivers/net/wireless/ath/ath12k/wmi.c  |   13 +-
>  drivers/net/wireless/ath/ath12k/wmi.h  |  107 ++-
>  5 files changed, 1058 insertions(+), 222 deletions(-)
> 
> 
> base-commit: ac17b1211841c98a9b4c2900ba2a7f457c80cf90

Sorry, this needs to be rebased again:

Applying: wifi: ath12k: push HE MU-MIMO params to hardware
Applying: wifi: ath12k: push EHT MU-MIMO params to hardware
Applying: wifi: ath12k: move HE MCS mapper to a separate function
Applying: wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
Applying: wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
Applying: wifi: ath12k: add support for setting fixed HE rate/GI/LTF
Applying: wifi: ath12k: clean up 80P80 support
Applying: wifi: ath12k: add support for 160 MHz bandwidth
Using index info to reconstruct a base tree...
M       drivers/net/wireless/ath/ath12k/core.h
M       drivers/net/wireless/ath/ath12k/mac.c
M       drivers/net/wireless/ath/ath12k/wmi.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath12k/wmi.c
Auto-merging drivers/net/wireless/ath/ath12k/mac.c
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/mac.c
Auto-merging drivers/net/wireless/ath/ath12k/core.h
Recorded preimage for 'drivers/net/wireless/ath/ath12k/mac.c'
error: Failed to merge in the changes.
Patch failed at 0008 wifi: ath12k: add support for 160 MHz bandwidth


