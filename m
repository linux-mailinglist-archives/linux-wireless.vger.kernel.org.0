Return-Path: <linux-wireless+bounces-24705-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EDCAEEFC3
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 09:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9381C1BC5418
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 07:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6AE19CC39;
	Tue,  1 Jul 2025 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZqInRUwg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A266190477
	for <linux-wireless@vger.kernel.org>; Tue,  1 Jul 2025 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751355139; cv=none; b=NrquNDdzpL5xlDFJYVballP/miJQSMTMesdb5QTPHHqHO89YkIgZEoTXmQzcInKn8Bp+HOgCSAGwwDuYwfztuI0HKPddELuN6HLrJvzpfrsHlihDs5D6A9YQRG4XeeiGlG9rNGRehK4kKmHnR/PTJRK5Seww33ZJaWQUG3vG0XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751355139; c=relaxed/simple;
	bh=O7Z+MpQ32UgzGplsH/s7csflLj+7cFiihw9g/Z4qerg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oc9PKVXBCQm6YOjvH/H7jcQjr7QCZgjQXWz0xZGIkbCrwLLdqO3jazDXv/u+xVtWFu7xcveYRAhNJIpSybi4U3NU0c1/lE316grzUhemrLP2DcSOiQ2/rNiMbiW+JXtDemWJZhao7VA2Z6aeJ/kXxmxcuNk60pZZ5dmtEAFcDpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZqInRUwg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5613MkBL032129
	for <linux-wireless@vger.kernel.org>; Tue, 1 Jul 2025 07:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TDOCxBpPVmbw0QEPicjZ41e6iD4nYwHdCMAbL9Ku9qQ=; b=ZqInRUwgFQ9z3QYz
	E2ySNgUlbzSBVB/NbFs798dAyNiQ58gIakQ95n9MGBkVnyL5QQQQSGV58js7AzdW
	SpsAiG8P1ciCX3ZZzieAt8q23tkSKCLtw+Y1PVW4B55arZHcdvh6U6AgeZ1aN8nm
	vOW1QvMiQ33YvXfAcLA+/ucFcN9/faAe5Z8q8zjPONJtBG6puA6AdP8kXNkeXepG
	Wm1sBhodq3HYN4MW39PUfMIEBHY3YI+DjD+0zN8pzOMycrbqbzQlqw1iCzA6apdw
	5kThZbG00co7yIihqb21qB/lYpYv9GC+HSN6+ZafEkr2/AFk2jzNDDFlxGb6D6ED
	Wj8/FA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j63k7rac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 07:32:16 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31215090074so5084046a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 00:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751355135; x=1751959935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDOCxBpPVmbw0QEPicjZ41e6iD4nYwHdCMAbL9Ku9qQ=;
        b=cg7YwbpjetXyLwxAQ01Hl9fVYv8QhsqfGCKfD3Wl7gKHhIb7+dj5L6d1MlpONIRL5s
         eHDHW5QfqXEId6/OliDtrpSpC4no/LBVWMcZuB2K9foe/FI342JqMRjZp/BItIXdTBPY
         aDd6IumdT9TJ0dFGlEnJKDZ44r8oqf0RQtta8zVhcXXkrW4mTUdmT3hsdQOyasjFvwwU
         4J6oWft9VqUw+iKKIqSciljVfjCWN+kmmg3ZGvhDJtNzFXpqbknSLsqUFZK+lULmlR1/
         Ls+9qr2VhlGYqsJ9pkj5lrZkMsAdkPsVLUNpGzrqQV9Y5GPy9YA9PZAeyP+QCrt7PCt1
         RkyQ==
X-Gm-Message-State: AOJu0YxKk7XPJkxLFAgf70F49EdAisT1iUuE9ZTuuGQFMxYG0U8NEViT
	SxIU+xCt3MZ06oc79WKeKP91iljdE3SfVYfnySmR2gTW9wc5+UB+5pNxoQkaR3sc2e3cjo4K0sH
	PNP9ELmRJsp60xahBLUYD1+W+KJOkkwr3NLODLdn+NFIs5Ggh+7CtXbmURfGbdGGDwDd5dw==
X-Gm-Gg: ASbGncuNpe5rfc9JNMBZOJE+6ndqlu4078QxY9L58wbUs0KqHwcO0kcC6HKRAoNDvEG
	XDSu65P1wrYqyzEl62RrSChglKPlg4yo6Yr7jkPUzjxpTkXQ0ST+2eOwDjCfuFtFXt+SKdMIvxk
	wt8bPejIdpMHyj6Cctdeb+CU4mmvbmAqGDjWb4h8Y8jtbd8WkIJzqJVFfwzzzx+uGTeLGHYo++5
	EoDrPxvWzcCynZ85hRt46o2Hm5mlyiQfw9ILmTDHdFRNsTzKS8fs0XhdeaAGsromMzttEypScc4
	NBBuFoWFwvRko3OPs+T9O4l/4Q8ppn+O1GWOHGWpEmcIWfQ9GNmkhznIcnmykqs6
X-Received: by 2002:a17:90b:3e8a:b0:312:eaea:afa1 with SMTP id 98e67ed59e1d1-318c92f09ecmr23522057a91.29.1751355135282;
        Tue, 01 Jul 2025 00:32:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1sJESjrU4RvtIsHlfmrSQQj88m8On/2shBq65FazB3a8VGlNdE9Uwjq35RE60fRLDMUtdwA==
X-Received: by 2002:a17:90b:3e8a:b0:312:eaea:afa1 with SMTP id 98e67ed59e1d1-318c92f09ecmr23522023a91.29.1751355134815;
        Tue, 01 Jul 2025 00:32:14 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c13a1a9esm10645153a91.13.2025.07.01.00.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 00:32:14 -0700 (PDT)
Message-ID: <6e64bd6c-c6eb-b9ac-4f82-e241a7323ddc@oss.qualcomm.com>
Date: Tue, 1 Jul 2025 13:02:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next v7 4/5] wifi: ath12k: correctly update bw for
 ofdma packets
Content-Language: en-US
To: Sarika Sharma <quic_sarishar@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250630071114.3474672-1-quic_sarishar@quicinc.com>
 <20250630071114.3474672-5-quic_sarishar@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250630071114.3474672-5-quic_sarishar@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZKfXmW7b c=1 sm=1 tr=0 ts=68638f00 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=Qn7UUWhMrg4689AsiVQA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA0MiBTYWx0ZWRfX/4uex5V/WO6y
 eKJIOGr7pJ7L1FHdJUj+iWXLRoFwGQFipVj/t9ByVy5EbQ2jZJ97bCG96NvgMJWGUKFukCcpFKX
 bDHEUsyWDZ9XQAbMthANb75G9Uz8MEF2Pt3uyBsM/9/cAvioidp5Wl5OuHBbJzGEFbz2xD1KAcL
 zIyI91Pb9pHNnCeFSQ37QWtVeGJvHbdgfDJ2dQuV52z1W9F81K3g6rZNq6Y/rL6OGwTO8shP1R3
 O7vHCRnqQRN1MfejX73VVrgF/r84TCGyWyFC3UdXVWOF8CPeVMsI2qjg4zmCWG2hCXyLI2VmfIi
 wpu7Y41raAmbQz6bK50u7SifBEqaijlqLuOXdtHEaEkjiGRsqhv7uAv7yFMc2S27c0Z1uET5UPC
 n8aIeGiDbAoeoM3Fv1AdrD39eaT4W0tkZyw+Z1vV5brDkcLmuavaTXfSAOqN0S8umIWXZBj6
X-Proofpoint-ORIG-GUID: VHO00enZASxGIwH3LUnifxPACGrOx3pk
X-Proofpoint-GUID: VHO00enZASxGIwH3LUnifxPACGrOx3pk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 mlxlogscore=830 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507010042



On 6/30/2025 12:41 PM, Sarika Sharma wrote:
> Currently, arsta->txrate.bw is filled from ath12k_mac_bw_to_mac80211_bw(bw)
> during ath12k_update_per_peer_tx_stats(). But in tx_completion path bw
> is filled differently if ppdu_type is ofdma for HE/EHT rates.
> 
> Hence, update arsta->txrate.bw correctly if packet is ofdma for HE
> and EHT rate.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/dp.h    |  2 ++
>   drivers/net/wireless/ath/ath12k/dp_rx.c | 15 ++++++++++++---
>   2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
> index a353333f83b6..0c1fece27264 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.h
> +++ b/drivers/net/wireless/ath/ath12k/dp.h
> @@ -1559,6 +1559,8 @@ enum HTT_PPDU_STATS_PPDU_TYPE {
>   #define HTT_PPDU_STATS_USER_RATE_FLAGS_DCM_M		BIT(28)
>   #define HTT_PPDU_STATS_USER_RATE_FLAGS_LDPC_M		BIT(29)
>   
> +#define HTT_USR_RATE_PPDU_TYPE(_val) \
> +		le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_INFO1_PPDU_TYPE_M)
>   #define HTT_USR_RATE_PREAMBLE(_val) \
>   		le32_get_bits(_val, HTT_PPDU_STATS_USER_RATE_FLAGS_PREAMBLE_M)
>   #define HTT_USR_RATE_BW(_val) \
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index 0f5edc81fc5d..ff92ec764ae5 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -1423,12 +1423,12 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
>   	struct htt_ppdu_user_stats *usr_stats = &ppdu_stats->user_stats[user];
>   	struct htt_ppdu_stats_common *common = &ppdu_stats->common;
>   	int ret;
> -	u8 flags, mcs, nss, bw, sgi, dcm, rate_idx = 0;
> +	u8 flags, mcs, nss, bw, sgi, dcm, ppdu_type, rate_idx = 0;
>   	u32 v, succ_bytes = 0;
>   	u16 tones, rate = 0, succ_pkts = 0;
>   	u32 tx_duration = 0;
>   	u8 tid = HTT_PPDU_STATS_NON_QOS_TID;
> -	bool is_ampdu = false;
> +	bool is_ampdu = false, is_ofdma = false;

nit: initialization of is_ofdma is unnecessary as it is unconditionally
populated below.

 >   	if (!(usr_stats->tlv_flags & BIT(HTT_PPDU_STATS_TAG_USR_RATE)))
 >   		return;
 > @@ -1457,6 +1457,10 @@ ath12k_update_per_peer_tx_stats(struct ath12k *ar,
 >   	sgi = HTT_USR_RATE_GI(user_rate->rate_flags);
 >   	dcm = HTT_USR_RATE_DCM(user_rate->rate_flags);
 >
 > +	ppdu_type = HTT_USR_RATE_PPDU_TYPE(user_rate->info1);
 > +	is_ofdma = (ppdu_type == HTT_PPDU_STATS_PPDU_TYPE_MU_OFDMA) ||
 > +		   (ppdu_type == HTT_PPDU_STATS_PPDU_TYPE_MU_MIMO_OFDMA);
 > +


Vasanth

