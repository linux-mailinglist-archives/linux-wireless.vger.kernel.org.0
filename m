Return-Path: <linux-wireless+bounces-22148-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2CBA9F586
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 18:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E013E188C306
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BB2279359;
	Mon, 28 Apr 2025 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IIC/b9VT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E658C10785
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857261; cv=none; b=fyFhpHOViYPRnDLj78tvPUpCqQc1MPA+jPdeOuT71PjW73NySbnCdFyHQ2qFDT5rWAXvFHSrj+bJols6VKtDUnNtRYuCZpsmk6PIYTgy5d0f9GiBvNlsTWImPYo10pO64TRvE4eZErSW4ah4ME3eIAodhvvt1wAJyvizV+/noKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857261; c=relaxed/simple;
	bh=CwDBMcnzsTE/Ut2HWOd2h/qCvHtfnP6UGhIi19X8jP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=De+atFv/bm5vu1A/9U+GytQTDI1VDMas/qVlU2LrYCNVeWhgBn4/KCJEpvto1inK706hInR9FqGa7fK3UUH3N5Jl2lM6q0+zni6FetdW+FFIcGwMkAv/QE/kyZjVBvN4TMercifxgBNOGfo6eGy2ZwvVZof2AYeVL0McNT7h3ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IIC/b9VT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SAB9OM021150
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 16:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XnYeSE/q+Y6YrD0IVK9UjbuuteBPD5AdeP67yGNbmUU=; b=IIC/b9VT5sC+RdCA
	V1myzr6p2AddK2ejJF36vB123B7lbienbEdzASOSAnMiqRVlnSPLCjga3gjHZmdE
	4EoE1VFM+GDYG6zTVVAy1Y/bimIuHNPsv5l97P/gJWUwOiIxtIaAnJsa6Cry5wCR
	Ul1H/YXKkcMrKzHws5mhS/P2GODOE1xJ/xrsZQ4n9/DWGId2YCAd9kTZubKat6MQ
	dDr3N//sxD5I/jJTlBAvdicZHcfyDEwED8VH0DSjtv9JmTzgzCLktAck25R4zdjK
	R0Dp9BcH5kDqNKBShNasctxgNfGBfW4fO3uuzo84jBTuvdYFENNTBPT0C2TuvkCV
	N55VAg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468ptmhr44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 16:20:58 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-af9564001cbso3020227a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 09:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745857257; x=1746462057;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XnYeSE/q+Y6YrD0IVK9UjbuuteBPD5AdeP67yGNbmUU=;
        b=lY5C9Y3CAbRYM8+Hju7EywXRYmfxLe3p8Tj/eYnNUgs1roBrEbQVH3eiQNg0RbFMAn
         jmtKYXluaCDct6SP911jMSD74NefZY1j7iFqrUbm8CfPWJPpRVWn2fnIDeeSrVy+segs
         hyCGPs53B+Sr4Z3TRmcQht1lJxXGwWHvXG8jD/mz/jozZtqTU/xcPwL/kCO6SiY/FYT9
         7b7wkqXiJYT4seQR2/yf7pgT8yncg9VIVl5+PlkQAjTU56Zq4+uRN9yUP7MTguHF/bJ2
         rPh76ka41lpAeanXO62Nw1B4piXY8HNFnIWP3d6xzYjzxpG3uE5Y8hHythgkKmUE79ju
         xLoQ==
X-Gm-Message-State: AOJu0Ywd+cS+Fjg06eTj4yVTJgEDE+mboug8T8/j+4fceggJs4ea7KVQ
	+nmRs1dp35+xXczCNFBkJss7+oOdk9CV79wNkd36IbBx2asvr1EdqwdZiKcx96+qlUkrh1jJ2wO
	JqwXJahmTxfJRMcBMvH2yRTED+FGCBvWhHM7AwW6B2Fi0j3uDCL91zn3F5ajh2/PZTg==
X-Gm-Gg: ASbGnctzNs412q0mDOLIhwgWNHsROzIHx9s/DKeHUXq5X1/98xi5QXZph5bzWvaIXhf
	Fc3Yw88VY9MBr+/19JRMtnk1enKCKgR0oW1a3JcVg0zGnlyh3gyOsj+ve+Y8qw3jJ5S9FLnEppB
	SHk9AW08piBqyl5H4sNYHGVoF6TuDlzZ5bcT9gh2oQSf7iibzD/BcpDypNpOaX7bn40PTwq4j1F
	blDFjBOAZoQ2ep33Z0cGVATyJuRU9n2ZdrseW1dzQe9E7pkcQ5Ogg3gxIsxv6ZCj3kKq8rHuKAC
	ByFtUs9v1ABogiBFvzgXqAcWCD4HR8VGRO0WvZfijKtST2UvfuDQSR+yr3Mo
X-Received: by 2002:a05:6a21:338b:b0:1f5:8605:9530 with SMTP id adf61e73a8af0-2093e7241a7mr118081637.28.1745857257125;
        Mon, 28 Apr 2025 09:20:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlIi9uzFadx2FXvf2TXjYbAFvq297GPuwWm5m/Xe5j9oz8gB/6YKGlt9K0f+FWvwAy+Fp8FA==
X-Received: by 2002:a05:6a21:338b:b0:1f5:8605:9530 with SMTP id adf61e73a8af0-2093e7241a7mr118040637.28.1745857256658;
        Mon, 28 Apr 2025 09:20:56 -0700 (PDT)
Received: from [192.168.225.142] ([157.51.192.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25aca292sm8142742b3a.168.2025.04.28.09.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 09:20:56 -0700 (PDT)
Message-ID: <c407bb06-19a6-2dd0-c42f-24725b7873b6@oss.qualcomm.com>
Date: Mon, 28 Apr 2025 21:50:53 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V13 0/9] wifi: ath12k: add MU-MIMO and 160 MHz bandwidth
 support
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250418174818.3336510-1-quic_pradeepc@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250418174818.3336510-1-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SEHsKT93dXtdlp5LVpE_0IQb_FxTs0za
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEzNCBTYWx0ZWRfX/BFCLfGeXXpH g0jilqqila7AC7NdSVGPWjN/aO+2+oMTukzMaqchte7SSdKijp0z/AXME4IZ/aal9j1cY1lfv3A JZC6bhHECJnu91rkv3Kdiv9ELui0iueXPPyqXHuyLG9uj2uLNGAjeaXq8NdZJvZsPnS9Tw1orzz
 VK8jFBm8S6pKcfKgkpqf4rfzmLXc59S3TBNxWj7deuW4l1AcBR+uCP5sPHS63GOG87U20EQaZjs JUpCVGGR3zvLBgsAY8lOK+kd3cRx/Chpd9xj3ozPOs7d2jQkfN3bF498xVrL0a0fOO3ciZyj1ms MN8VBUPUH3FzSbN/BJsrn5gYsgyRRenfMfrY2FkVQxSMma5JPykSeQBrcQfCgoMazhOPjsnO5hp
 xJPPfmXae752IGtU8mqo3rlQ3HdqNm6+wNrwBL2SJ5FzHhxKgWt2kRcfm+EU1muTvMd/R9yS
X-Proofpoint-GUID: SEHsKT93dXtdlp5LVpE_0IQb_FxTs0za
X-Authority-Analysis: v=2.4 cv=DKWP4zNb c=1 sm=1 tr=0 ts=680faaea cx=c_pps a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=XJI/iaC0GbrNbCf3OOiYRw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=PJRSDOuFSj8v0qVA-6MA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280134



On 4/18/2025 11:18 PM, Pradeep Kumar Chitrapu wrote:
> Add support for
> 1. enabling MU-MIMO in HE and EHT modes from hardware
> 2. setting fixed HE rate/GI/LTF
> 3. 160 MHz bandwidth in HE mode
> 4. extended NSS bandwidth support
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> changes in v13:
>   - rebase
> 
> changes in v12:
>   - rebase
> 
> changes in v11:
>   patch 1/9:
>    - fix return values in ath12k_mac_set_he_txbf_conf() and
>      ath12k_mac_vif_recalc_sta_he_txbf()
>   patch 6/9:
>    - fix missing he_mcs initialization in ath12k_mac_init_arvif()
> 
> changes in v10:
>   patch 6/9:
>    - use ath12k_ahsta_to_sta()
>    - fix rcu_dereference warning in ath12k_mac_set_bitrate_mask_iter()
>    - change return type for ath12k_mac_validate_fixed_rate_settings()
>    - improve readability by adhering to nl80211 definitions of GI
>      NL80211_TXRATE_DEFAULT_GI. Introduce ath12k_mac_nlgi_to_wmigi()
>      for conversion.
>   patch 7/9:
>    - do not change default MODE_11AC_VHT160 in
>      ath12k_mac_get_phymode_vht() as it breaks clients which do not
>      set VHT_CAP_SUPP_CHAN_WIDTH_160MHZ.
>   patch 8/9:
>    - Use IEEE80211_VHT_CAP_EXT_NSS_BW_MASK along with
>      IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ for determining VHT160
>      phymode.
> 
> changes in v9: rebase on top of master branch with mlo changes
>   patch 1/9 and 2/9:
>    - fetch link_conf using ath12k_mac_get_link_bss_conf()
>      instead of arvif->vif->bss_conf before mlo
>   patch 6/9
>    - fetch mcs/nss values from sta->link[] instead of sta->deflink
>    - fix spelling of 'incompatibility'
>   patch 8/9
>    - replace sta->deflink.addr with arsta->addr in
>      ath12k_peer_assoc_h_vht
>   patch 9/9
>    - replace sta->deflink.rx_nss with link_sta->rx_nss
> 
> changes in v8:
>   - rebase and resolve KASAN warnings reported by Jeff in v7, in patch 6/9.
> 
> Pradeep Kumar Chitrapu (9):
>    wifi: ath12k: push HE MU-MIMO params to hardware
>    wifi: ath12k: push EHT MU-MIMO params to hardware
>    wifi: ath12k: move HE MCS mapper to a separate function
>    wifi: ath12k: generate rx and tx mcs maps for supported HE mcs
>    wifi: ath12k: fix TX and RX MCS rate configurations in HE mode
>    wifi: ath12k: add support for setting fixed HE rate/GI/LTF
>    wifi: ath12k: clean up 80P80 support
>    wifi: ath12k: add support for 160 MHz bandwidth
>    wifi: ath12k: add extended NSS bandwidth support for 160 MHz
> 
>   drivers/net/wireless/ath/ath12k/core.h |    2 +
>   drivers/net/wireless/ath/ath12k/mac.c  | 1141 ++++++++++++++++++++----
>   drivers/net/wireless/ath/ath12k/mac.h  |   17 +
>   drivers/net/wireless/ath/ath12k/wmi.c  |   13 +-
>   drivers/net/wireless/ath/ath12k/wmi.h  |  107 ++-
>   5 files changed, 1058 insertions(+), 222 deletions(-)

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

