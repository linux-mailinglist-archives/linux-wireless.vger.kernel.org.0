Return-Path: <linux-wireless+bounces-24739-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F4BAF016A
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 19:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FA93AB27B
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 17:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D2927CCE4;
	Tue,  1 Jul 2025 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BvDhCxyc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90BE125D6
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389893; cv=none; b=tm9qTjJZC9hGINTuXtBJFmujhJH4L0csxFLZn/YFi6s8rAdQX1kcY87Cv8psQHeOzUiX6kN8ZX9DiIl0H8CbkNet0HwnoYHz0OS2Pkw3nvWBqD43MajELm/qRrbhE11exCK5NLeSpYV4vNqA/8TljT04vOotbKVU8vh8IBL6GWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389893; c=relaxed/simple;
	bh=A6BKh/+n8bI9/9Ur6tRJJAOVNRUbgLnCido7flEyJNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odf39dtUVsxPFHMRvNHwcNRQct+W0VyT9pFcTPrP+wkv/vODms7n+MEEpbBD7EdvT9/jcujFTgRJerx5YqeQOXdFzmf1zmJjjCDl8csZ8TTrrTLhD5ggiFnX4Awn0ERFL8FjI8rSY/rocMaEY456Z945qS/xWzkSzeINpJ5cTm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BvDhCxyc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561GVbG2007345
	for <linux-wireless@vger.kernel.org>; Tue, 1 Jul 2025 17:11:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mLKwVrPy8P5xsiw/HOitfvrBYE0u4Z+NAYr1E1YeUXg=; b=BvDhCxycOvs406Hg
	XKSEt+OM/Xz7LknUhbQI5bZ4r+eL4AwoFQpnQuSL3z+2ploryyB1qjSHXxwE4Yxm
	xbu05lxB1sVqj9vbKM7pcnrxkqEBKMhVhEKaTcTt4gRtyo1U4TMdPglAJYMakgMQ
	hnt4Xnq1EC8a4NRRUljZAmmPIcpjB4UO1CBK8WdYe6YE+BI9YP55V2y5iuEAaev/
	KZ+FuAPcvOGPbSgrRDcBDY+mnInUtyalJWS0DSAZB3lvxQCFV7GqbnFDD6ZPfy42
	LBwTaT4dyWM6k7VHJWj8vXLQVTB6IwHwvpM2DNTpgKNdUX4sCuk6q057Pw2NOi2S
	vkYx3g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47kn5je3em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 17:11:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235e1d70d67so25501745ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 10:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751389889; x=1751994689;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLKwVrPy8P5xsiw/HOitfvrBYE0u4Z+NAYr1E1YeUXg=;
        b=j2aegRkEaLiFMo+Yo/OGHV3u3qrni0snhNp6ZoMJU4+Drwfu6ap4gd9IvTeWoMNWBe
         RmX7ttBbCt4qzC2EasXiM/KbA1oWdcEGIjCxAMUf7Pi5B3b1JrQPnO8H1Oa9Y72loE7H
         MzpUud2OFi6BtCRSiYBUukfQuHtl6akovn3DLjEeBIDd7MVr/Vxc/XQI9ohHZ0bU5FM3
         KVA5ZrK/lrbGNpYRTQ2jtB/JI4Y7j+IvO9qVMlTnM/cIiITtgflm4mTkshlvA4fZhkRk
         r2IIiNXATECqhK8LN4I73SgSuCPDidHoZmrh5PGY3/ic9lR3h8//Wg6S1U8LXo5yisLz
         2w/Q==
X-Gm-Message-State: AOJu0YykhgaF0hZaOHf9yQW4nf5X9hD4EqJQULwmxyCXxJg0iJTwPbkH
	82uFsdiApocJdMkLK/Uc+f5PpjOKkK8RAzpqWdilSWeY5Zc0GFWhs8Ofy9G911EvoK0IHg3nPYO
	fLLMjBKPFv3I0O9UVKXnuo1ov4Gq0Gth4hnWJoHZQkRctMLhzDH0/o3vZpbKQSoG+ecpmUg==
X-Gm-Gg: ASbGncsvygZye925sVfRc6NDvQESj432i+oPqSz/TfWDSSJYQkFIgvR6PG5sYdSUA91
	6pJ9+dvbzXF1QlBLShbH0PgbWOBtgHfv2BC6q7Lld5qsRL47SbaoxKVKqRXG/kZmqC4wHAIIUvc
	b/9NxYzSEcySGFXJPl3i+BSgyLYaNsj6fUabFelvoPTrhWDMBC42kTXPPWzbm+kuvKSABC/oigd
	kQySFiUFJQqM+Ll4XY3+i4QfO4nleaKzsgs4771aJA3i52Mv4emw9dl6A65RWMUmSFufD1muBOU
	BgWwQJAUqAFUxCwMDbOUo7eFsy7vyGKzhAYRH9strnLWpgpdvuS3wRAZUIaQ+9yNRpnFo5wc9U7
	p2gxkgKfjsvzW38I=
X-Received: by 2002:a17:903:284:b0:22d:b243:2fee with SMTP id d9443c01a7336-23ac43d3211mr254109305ad.13.1751389888955;
        Tue, 01 Jul 2025 10:11:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1X6qVKPWmnadI+fNItnBMIaARjs/GLjlFIwWamaa1inE9HiS3RpXyTjkCNyG2A8IQ9wooCw==
X-Received: by 2002:a17:903:284:b0:22d:b243:2fee with SMTP id d9443c01a7336-23ac43d3211mr254108685ad.13.1751389888273;
        Tue, 01 Jul 2025 10:11:28 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3ce960sm110348185ad.250.2025.07.01.10.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 10:11:27 -0700 (PDT)
Message-ID: <a6e82fa5-8094-4ae2-b6f1-53b6e6c13e4e@oss.qualcomm.com>
Date: Tue, 1 Jul 2025 10:11:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next V15 0/9] wifi: ath12k: add MU-MIMO and 160 MHz
 bandwidth support
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250701010408.1257201-1-quic_pradeepc@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250701010408.1257201-1-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KtJN2XWN c=1 sm=1 tr=0 ts=686416c2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=MeVQk6Yvlubu_z84HK4A:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 2jI6Q9hSzABES9K-Ktd9zxv_wyhVVksO
X-Proofpoint-GUID: 2jI6Q9hSzABES9K-Ktd9zxv_wyhVVksO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDExNyBTYWx0ZWRfX7v+bIQ01rPHy
 yrUqJAzvfXkQdpopGaK4i0e05X7s2gWn3O9EKC1H9gAgYeY73tdPlwHEhkKTIA0xAi4T4s4HXtV
 TyU0rGVFQHp/ywQejEsljeZlbFiYIAIX3W93mW1C7dazNBte61NNgb93B67RfeeOF9e+/UgZ3as
 joXNR6V89a/QkuxqtQD1F+giYlcGRJ1rESReClnHQ3GvBiA0GIlNre5tC+TILFiSbLvzHC6WlZO
 +Fua63DGOU7XSLFlTYrUl8O8w09ohBp4JTZa2AOHBVCYIYoDEsL5R4q6TTxOHGreE9vmDr9sVF5
 JajZelikbm6ReyvO5qj6l2iBLi5+M55/b23CBkwvA/lS2tU7tFuXsn24vlu9tR233xbJ6ovGai0
 9hjvEFSH6jW0CizekG/jBAzacDK7r35kh84fKhcD3WYoLFNhXpWuEJknwiDM6XPrNB+xtlwl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010117

On 6/30/2025 6:03 PM, Pradeep Kumar Chitrapu wrote:
>   Add support for
> 1. enabling MU-MIMO in HE and EHT modes from hardware
> 2. setting fixed HE rate/GI/LTF
> 3. 160 MHz bandwidth in HE mode
> 4. extended NSS bandwidth support
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> changes in v15:
>  - rebased the series after merge conflicts reported
>  patch 4/9:
>  - change the fix to apply for all modes except STA mode as
>    WCN7850 expect it same as before.
> 
> changes in v14:
>  patch 6/9:
>  - cap max_nss using ar->num_tx_chains to fix interop issue caused due
>    to sending nss value 4 when firmware only supports nss value 2.
>  patch 8/9:
>  - Set the default return value to MODE_11AC_VHT160 for 160 MHz
>    to allow STA to connect to the AP even if it does not
>    explicitly indicate 160 MHz bandwidth support.
> 
> changes in v13:
>  - rebase
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
>  drivers/net/wireless/ath/ath12k/mac.c  | 1144 ++++++++++++++++++++----
>  drivers/net/wireless/ath/ath12k/mac.h  |   17 +
>  drivers/net/wireless/ath/ath12k/wmi.c  |   28 +-
>  drivers/net/wireless/ath/ath12k/wmi.h  |  100 ++-
>  5 files changed, 1069 insertions(+), 222 deletions(-)
> 
> 
> base-commit: c256a94d1b1b15109740306f7f2a7c2173e12072

Since there are lingering questions about the 5/9 patch I plan to take 1-4,6-9

Given that there is ongoing discussion about the 5/9 patch logic in the
context of the ath11k driver, this patch can be posted again separately when
the discussions have concluded and the correct interpretation by firmware is
clear across all chipsets and interface types.

/jeff


