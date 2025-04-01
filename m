Return-Path: <linux-wireless+bounces-21010-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E84DEA7723C
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 03:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964D616B466
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 01:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685F03595D;
	Tue,  1 Apr 2025 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A+qk9vhy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF9813C9C4
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 01:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743469806; cv=none; b=WkH3vK/pVSKxf221ur3R6sSsSXJLOpuErFsoa2wSNZnmqiDzVCmxi3+48hx6fvdLF11Z+G3G8zs/bAxs7yCOHkBjN9FGlz6IEbw++7QWtKoMuHXHs+jFX3lw66MWcO091/5QmJemIFuIuswulRNY+y4iUtiX4MDu+FhtgDRQuF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743469806; c=relaxed/simple;
	bh=TvHBbn/1Z1t1hMU1NVuElifu42kGrFoak5lYVhVnU+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFrD8+euweYYyJaX/NixJpczf+ZLVjtGKxV0SaUfcNny/zLKmzzIZI1UTdNhKsgEHT1EaWajGgEXztE12aBpyFH2kF9OFBBVdkmBvtwiUrOOjjSzt0I0RvUErFVnZN0+Xhe311VmlmC+CGnwvkuKy38Pt1zsgauJpKMG6R2Foc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A+qk9vhy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VKGmSo008580
	for <linux-wireless@vger.kernel.org>; Tue, 1 Apr 2025 01:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TDimoZo2P8VTxqz540h+sEpytFpZLIuPSm9TIjGfcG4=; b=A+qk9vhylXZ1gzmg
	qWcxBJ98aWtlhgypR694U3Ill/9B5Gq1GezO9AXqBcMZnRG/cSOU6oss+VhqRgqy
	QHcL+wzGwP3twXwI0K2UPmK12c/c2dnekbOVRzRoi9WbcEpG2Awk+Qv0MbZInEIk
	Ah/m7rsKR6Z+fwN/UxtDSlb7uHs0ik2NDm7SgAG3B8lkPJbtNNPm78h5Wd/lPccH
	P+g61VNS1b3V1nBTTQ3SZqrN4vB1kZUWOecK2jO4SndoJFS+DB1LdVNFpsPAMZYm
	a5S1To3NUaTBXI+yjbcwQt8xOBy2gRXB98A1zeHafT/I7UL7lRsDFcpjB76AlyK2
	scda9Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45r1xngh0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 01 Apr 2025 01:10:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff62f96b10so9350479a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 18:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743469801; x=1744074601;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDimoZo2P8VTxqz540h+sEpytFpZLIuPSm9TIjGfcG4=;
        b=dUWBod1JSmVNaBlLUnYhGnk/dK+E/ro3OoStg6nnMnZD+wVtnVZ9Yhj6KNEYrQHOPK
         JPzDIFOaIJw/3MrAlK0l2zXtBBPkECd+2CmUd6NVbFYOaSog45Cbx5HybSJHhslr9EhY
         7XzVjuuwOuEBwkBHsp55mNyHpw3EjokYJcXs2Up7DOugplRLjVzHUTt21fEa+2442fWA
         rgVrNnx4rsV2UAghj4iyDp40yhboujCyszrLOV2lUjpof+D9oqrTtdf6CV3lWkKXjJAU
         2sGx+LpH9Lt0AeZp4muXWfAUanpZNwmq8nHYxjlkA3Sa5GU40q8NU7i5q9mDABKa9WqP
         2zOA==
X-Gm-Message-State: AOJu0Yx7cbCdelMLzuoa6lhoms93eto1q09gnRDTHMZkn/7KT9GkJkyV
	ZswoFxFNkNiiMHbMD5xR5OmmBZHKEqRxncJWJSyOYGev+g9knLkDigdt16nzSNOZrmForvinGkF
	cZhS7lXxpU4Mu9qqPJvKuLZFQjiH3HPG1vAzuyDr50kULKq5r8Jlne2azSSyUjQZiA5N3My0Z/w
	==
X-Gm-Gg: ASbGncuH1Ml09sOeDG5MwXlppfCawtBb+YQyQhYu/Fbw42ZENLKDJl5EyI2DObDBaI8
	hHlNpXnO4rL/zT8r9ljNzdtjHN9gslW028PKJ85QwSUdI3BfHVEGiZbg0MVq5ggiEy1NRiE7nZo
	GjrhnRQ1sKtEO6KnxI62YKITQlkIE+TfZK5Ek2DUlUyIitXWoVq63qu0ZpBNyGRq/2kFrAW1/XW
	OX324yGUXlHtxXxKe+v4qFZsuEm+6S24LkT2iAcoyhYxGhsfy7JsENRzY41kJM96BTZOWuudIvV
	MJRosiP0EkVuWuaMiYI2FQqiPELRaiIriGT+isaTt8M0w4FBlyRxTHfu9NUL00MvR7lY+52IuHc
	pVq8FQPo4
X-Received: by 2002:a05:6a20:9f44:b0:1f2:f1a8:70ca with SMTP id adf61e73a8af0-1feb5bab130mr22933179637.5.1743469801191;
        Mon, 31 Mar 2025 18:10:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNu+DeS/1piz9ZEhssl3P21WFLNtbVOHc7sE2xwL9HKaCDg3GuAyZ8Ge15Gm05dotzWpb9Cw==
X-Received: by 2002:a05:6a20:9f44:b0:1f2:f1a8:70ca with SMTP id adf61e73a8af0-1feb5bab130mr22933137637.5.1743469800684;
        Mon, 31 Mar 2025 18:10:00 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93b69f6f2sm5848712a12.30.2025.03.31.18.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 18:10:00 -0700 (PDT)
Message-ID: <d4ed05c7-41a3-4f99-89f5-72d2f8050b24@oss.qualcomm.com>
Date: Mon, 31 Mar 2025 18:09:59 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V11 0/9] wifi: ath12k: add MU-MIMO and 160 MHz bandwidth
 support
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250220213025.2722206-1-quic_pradeepc@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250220213025.2722206-1-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: b5XSBC1STX8tDW2SaR6d4GFp3lMcSl2X
X-Proofpoint-ORIG-GUID: b5XSBC1STX8tDW2SaR6d4GFp3lMcSl2X
X-Authority-Analysis: v=2.4 cv=Qv1e3Uyd c=1 sm=1 tr=0 ts=67eb3ceb cx=c_pps a=0uOsjrqzRL749jD1oC5vDA==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=TUzAd_iuidMRmLO4f4QA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_11,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504010006

On 2/20/2025 1:30 PM, Pradeep Kumar Chitrapu wrote:
> Add support for
> 1. enabling MU-MIMO in HE and EHT modes from hardware
> 2. setting fixed HE rate/GI/LTF
> 3. 160 MHz bandwidth in HE mode
> 4. extended NSS bandwidth support
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
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
>  drivers/net/wireless/ath/ath12k/wmi.c  |   24 +-
>  drivers/net/wireless/ath/ath12k/wmi.h  |  107 ++-
>  5 files changed, 1069 insertions(+), 222 deletions(-)
> 
> 
> base-commit: f22471c17f5849b2f20e2c56ec9fcd9dd8d5bf28

Sorry, this has been stuck in my backlog, and now it no longer applies.
Please rebase.

Applying: wifi: ath12k: push HE MU-MIMO params to hardware
Using index info to reconstruct a base tree...
M       drivers/net/wireless/ath/ath12k/mac.c
M       drivers/net/wireless/ath/ath12k/mac.h
M       drivers/net/wireless/ath/ath12k/wmi.h
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/ath/ath12k/wmi.h
Auto-merging drivers/net/wireless/ath/ath12k/mac.h
Auto-merging drivers/net/wireless/ath/ath12k/mac.c
CONFLICT (content): Merge conflict in drivers/net/wireless/ath/ath12k/mac.c
Recorded preimage for 'drivers/net/wireless/ath/ath12k/mac.c'
error: Failed to merge in the changes.
Patch failed at 0001 wifi: ath12k: push HE MU-MIMO params to hardware


