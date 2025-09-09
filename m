Return-Path: <linux-wireless+bounces-27136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01950B4A024
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 05:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1E04E5CF0
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 03:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4759442A8C;
	Tue,  9 Sep 2025 03:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UnWzsqRB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561585223
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 03:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389348; cv=none; b=OUtwJHZ9HkonBreWeT2VfyamjgEjdjfH4kIA2p4SFaqsZUkuuR0gydUeub8v+EDhaYHaZ4yR3H2Fff5iUTsuPUSEZhk602bnRpD+hJyCxgbbr+jOkbrzBwyy47610jJgcEtsh7lsjKwd4lRLPFmOAqbPZCFOtsU0JREWFP8X3Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389348; c=relaxed/simple;
	bh=Kr+Affrn2AlXizC3vXBbP1QR9GeRARaEaQq67jKY0cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHwa+0/aH+hnkNb0gBH0LX/QlFabXVFz3jPbGND05GlBxyD/pKV3snYS6SrZLmy9rHXlB6y0u/avgbYRxR0i/PIAQFG+pt3XdWv4+RuIUVHTUsnl0K+JHuv3s5kgxuvmR6Fk3TkfJ6RigDgZ3RC2BKKStmP4Tfx12UML7oBUVzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UnWzsqRB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5892EbcT024160
	for <linux-wireless@vger.kernel.org>; Tue, 9 Sep 2025 03:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rqKGj80V87H4h/5IP86Ryu05cZ9/7FbAEtZKSpmwubo=; b=UnWzsqRBC1PbHpRP
	4pyL23y69z9Raeu4c39IDh46+hrqW4DZXi4pW6OSDqJV27rGsQ6N56UCk3de8kC+
	b4IagsBTllqOQyKWWaUY1Wq35eUQM4qEuAe3gg4xbqtkvWIv+B3YiSIyaHhin5OT
	wmu/JRDkBj2YszRJlHCQjxCvKm3ZUrFLd+gpqO86zSxXkDhsOiPfrOuPohUeF4bl
	E7D/sw9Tu58pZeKNkc6s5fIAY5OFasHEOQO1g4xpVzMwZA47py98aQwnLa3gsI9g
	YUAC8JR5xz4tTDl5W/sLN2PrXmTQFWm74G5b9dBl8YgjgWdOLJl3MMmGwFp4j99J
	pQ/rvA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapf1uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 09 Sep 2025 03:42:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2490768ee5fso41022425ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 08 Sep 2025 20:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757389344; x=1757994144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rqKGj80V87H4h/5IP86Ryu05cZ9/7FbAEtZKSpmwubo=;
        b=Z4ZA5inrPYyFudOFcPigvhsCfUmwduINqVDyjvtIitUBY9DSrtBtRaGGzmlOQ3rlbu
         kCS/3Geia48Gk7YW16aSvcdgc8ooNKiY9H6O6RTOoULO7AeKaYiW/ZOL9R/XeVkXEomp
         BbqnQCN7cvycX5ONi+gZDX2MaTlGP/vzTea8iJ1tbpnqG0loJYSdmPVNMALvI60PRRi6
         O5W7J/+xEp+TLFbEyDuvJU3EQ7UJqQZZMWBG15Q2LAYN0nqJO810eOxnvOLgy3znYIgl
         OzyYF0zidKLeQRnp7gDhmnhW/DRl1JLb/loV695gLVPnF6beQ96h52PD+IYwt8MK5xk0
         eELg==
X-Gm-Message-State: AOJu0YyNX1nKDtvPtnyFNIfoTfN3lEYXMYF4G0clQFAWxvhz1I08WnpO
	pPJfA8mrykn6gz+1C/2Bm/69OjRJYRbjzPj8xUAIlDxSAkJpP2XRfN/3S09B1+ltC1aqR+lewuD
	93bddNoxzMJZZ79E9nJOpqQKFOc6bOF50wveMvDhfBAMDJHOjQqK6iQdQvwlA4Wx4/gS/DQ==
X-Gm-Gg: ASbGncujB02jP/+t5rB4ld22oY4me4cTR8IFRgwgDYSBsnP/aSQVu7Kkl2PxEO9y1AB
	FgKmOxpoVlqwJVPuqEseXmJn4yhzRKKwwJilsJvY2jRGGPcLjpMBmXinYxqnyWSrjWxWPFVqD/O
	Y267ff6Z3Sq+hGWhd+W5jkE57Yz6uvxjRTQhplHWdGFaKQrMNAB47p2CIg1Pp6lUNpAG+8rAWM0
	JI0+167sDQANMMdUO6EUoM8SUFo4X/nd1iu8MDZCLgjZAMHz9cPlgfd7fkMocLuaIWCgrFFydpj
	+dOJlC+zKdJbMeQ+zOzNA1uK8zqjsz/YE62KBtPBzcbV1531GRsUtX/aeHGosympu0lRBWS+AOq
	S0RGwL1yU8LzblvqWrSDKPJ6U9Rmfy94P5nTfvA==
X-Received: by 2002:a17:903:1446:b0:24c:7b94:2f87 with SMTP id d9443c01a7336-2516d81652amr122994155ad.14.1757389343561;
        Mon, 08 Sep 2025 20:42:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBVdncCJ5WkXyxiuknUnAWiuhgmUiboCPFE/MCBu3e51IrOlxhIQAeL2A7kYTrGD/KbLiaiQ==
X-Received: by 2002:a17:903:1446:b0:24c:7b94:2f87 with SMTP id d9443c01a7336-2516d81652amr122993945ad.14.1757389342990;
        Mon, 08 Sep 2025 20:42:22 -0700 (PDT)
Received: from [10.133.33.112] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25549ac1e1dsm50443855ad.24.2025.09.08.20.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 20:42:22 -0700 (PDT)
Message-ID: <1e8be82e-6abe-4764-939e-fede6c4368ea@oss.qualcomm.com>
Date: Tue, 9 Sep 2025 11:42:17 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath12k-ng 7/8] wifi: ath12k: Remove hal_rx_ops and merge
 into hal_ops
To: Ripan Deuri <quic_rdeuri@quicinc.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250908162757.2938849-1-quic_rdeuri@quicinc.com>
 <20250908162757.2938849-8-quic_rdeuri@quicinc.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <20250908162757.2938849-8-quic_rdeuri@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68bfa221 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=IqzYBjT-D9p1eT2bAm0A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: RoJlk9syz-4EdCJDPcJVgh-Ts2OMZW8v
X-Proofpoint-ORIG-GUID: RoJlk9syz-4EdCJDPcJVgh-Ts2OMZW8v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfXyW9Y2nLl6ATB
 QXIWMwcptUV64urDXajH208W5aylIG63io3Ufb+/5F6YP5rqH/2LZPBTsfTKwOxVc0Cimj18n5Y
 BxvnBcjNItxOEx00KIpSUHqn7I3dAvgUtXD+VqmYFU/PZpTIvfgnef+jHS1MBihoTppM1lZTVDY
 XGOuOQU2Ls4UGMPQ7ZK1LcPphpl2fy6McMCZLUUFbTGN5pAV/Dhbd4lJarUm6cntLZiCekErqQw
 HqQgUZx8JQGI1p1GWl0pMO9AUokHDihKGOZOizN8/GkpjZOUCaAiHU6GLnSHNj4ZSKuy9ebkGvL
 gU0MhhjEcVbjhczpsz9Xq7nMqyz5iWoxszCbv8IYLfRZA8T2zyho5IxbnDyoYH0+lVSbf4zttk4
 nfNEjkGF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000



On 9/9/2025 12:27 AM, Ripan Deuri wrote:
> Move following ops from hal_rx_ops to hal_ops to simplify the HAL interface.
> 
> rx_desc_get_l3_pad_bytes
> rx_desc_get_mpdu_start_tag
> rx_desc_get_mpdu_ppdu_id
> rx_desc_get_msdu_payload
> 
> Remove the compact_ops as they become unused with this change.

Are you intending to say hal_rx_ops?

> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Ripan Deuri <quic_rdeuri@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/core.h      |  2 --
>  drivers/net/wireless/ath/ath12k/dp_mon.c    |  2 +-
>  drivers/net/wireless/ath/ath12k/dp_rx.h     |  6 +++---
>  drivers/net/wireless/ath/ath12k/hal.c       | 22 +++++++--------------
>  drivers/net/wireless/ath/ath12k/hal.h       | 14 ++++---------
>  drivers/net/wireless/ath/ath12k/wifi7/pci.c |  2 --
>  6 files changed, 15 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index b68f063283fe..9ae98556dd94 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -1196,8 +1196,6 @@ struct ath12k_base {
>  		bool fw_features_valid;
>  	} fw;
>  
> -	const struct hal_rx_ops *hal_rx_ops;
> -
>  	struct completion restart_completed;
>  
>  #ifdef CONFIG_ACPI
> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
> index 0ae500ec3463..3315a9e3d40a 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
> @@ -2046,7 +2046,7 @@ ath12k_dp_mon_rx_merg_msdus(struct ath12k *ar,
>  
>  		rx_desc = (struct hal_rx_desc *)head_msdu->data;
>  		hdr_desc =
> -			ab->hal_rx_ops->rx_desc_get_msdu_payload(rx_desc);
> +			ab->hw_params->hal_ops->rx_desc_get_msdu_payload(rx_desc);
>  
>  		/* Base size */
>  		wh = (struct ieee80211_hdr_3addr *)hdr_desc;
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
> index 432707d60fca..ff214bff389b 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.h
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
> @@ -109,7 +109,7 @@ static inline u16 ath12k_dp_rx_h_frag_no(struct ath12k_base *ab,
>  static inline u8 ath12k_dp_rx_h_l3pad(struct ath12k_base *ab,
>  				      struct hal_rx_desc *desc)
>  {
> -	return ab->hal_rx_ops->rx_desc_get_l3_pad_bytes(desc);
> +	return ab->hw_params->hal_ops->rx_desc_get_l3_pad_bytes(desc);
>  }
>  
>  static inline void ath12k_dp_rx_desc_end_tlv_copy(struct ath12k_base *ab,
> @@ -129,7 +129,7 @@ static inline void ath12k_dp_rxdesc_set_msdu_len(struct ath12k_base *ab,
>  static inline u32 ath12k_dp_rxdesc_get_ppduid(struct ath12k_base *ab,
>  					      struct hal_rx_desc *rx_desc)
>  {
> -	return ab->hal_rx_ops->rx_desc_get_mpdu_ppdu_id(rx_desc);
> +	return ab->hw_params->hal_ops->rx_desc_get_mpdu_ppdu_id(rx_desc);
>  }
>  
>  static inline bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
> @@ -137,7 +137,7 @@ static inline bool ath12k_dp_rxdesc_mpdu_valid(struct ath12k_base *ab,
>  {
>  	u32 tlv_tag;
>  
> -	tlv_tag = ab->hal_rx_ops->rx_desc_get_mpdu_start_tag(rx_desc);
> +	tlv_tag = ab->hw_params->hal_ops->rx_desc_get_mpdu_start_tag(rx_desc);
>  
>  	return tlv_tag == HAL_RX_MPDU_START;
>  }
> diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
> index db6294ba6771..a14a7d8dc69f 100644
> --- a/drivers/net/wireless/ath/ath12k/hal.c
> +++ b/drivers/net/wireless/ath/ath12k/hal.c
> @@ -406,13 +406,6 @@ static int ath12k_hal_srng_create_config_qcn9274(struct ath12k_base *ab)
>  	return 0;
>  }
>  
> -const struct hal_rx_ops hal_rx_qcn9274_compact_ops = {
> -	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_qcn9274,
> -	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_qcn9274,
> -	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_qcn9274,
> -};
> -EXPORT_SYMBOL(hal_rx_qcn9274_compact_ops);
> -
>  const struct hal_ops hal_qcn9274_ops = {
>  	.create_srng_config = ath12k_hal_srng_create_config_qcn9274,
>  	.tcl_to_wbm_rbm_map = ath12k_hal_qcn9274_tcl_to_wbm_rbm_map,
> @@ -423,6 +416,9 @@ const struct hal_ops hal_qcn9274_ops = {
>  	.rx_desc_get_msdu_src_link_id = ath12k_hal_rx_desc_get_msdu_src_link_qcn9274,
>  	.extract_rx_desc_data = ath12k_hal_extract_rx_desc_data_qcn9274,
>  	.rx_desc_get_desc_size = ath12k_hal_get_rx_desc_size_qcn9274,
> +	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_qcn9274,
> +	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_qcn9274,
> +	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_qcn9274,
>  };
>  EXPORT_SYMBOL(hal_qcn9274_ops);
>  
> @@ -550,14 +546,6 @@ static int ath12k_hal_srng_create_config_wcn7850(struct ath12k_base *ab)
>  	return 0;
>  }
>  
> -const struct hal_rx_ops hal_rx_wcn7850_ops = {
> -	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_wcn7850,
> -	.rx_desc_get_mpdu_start_tag = ath12k_hal_rx_desc_get_mpdu_start_tag_wcn7850,
> -	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_wcn7850,
> -	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_wcn7850,
> -};
> -EXPORT_SYMBOL(hal_rx_wcn7850_ops);
> -
>  const struct hal_ops hal_wcn7850_ops = {
>  	.create_srng_config = ath12k_hal_srng_create_config_wcn7850,
>  	.tcl_to_wbm_rbm_map = ath12k_hal_wcn7850_tcl_to_wbm_rbm_map,
> @@ -568,6 +556,10 @@ const struct hal_ops hal_wcn7850_ops = {
>  	.rx_desc_get_msdu_src_link_id = ath12k_hal_rx_desc_get_msdu_src_link_wcn7850,
>  	.extract_rx_desc_data = ath12k_hal_extract_rx_desc_data_wcn7850,
>  	.rx_desc_get_desc_size = ath12k_hal_get_rx_desc_size_wcn7850,
> +	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_wcn7850,
> +	.rx_desc_get_mpdu_start_tag = ath12k_hal_rx_desc_get_mpdu_start_tag_wcn7850,
> +	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_wcn7850,
> +	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_wcn7850,
>  };
>  EXPORT_SYMBOL(hal_wcn7850_ops);
>  
> diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
> index 37593bb7953b..692d495d01c9 100644
> --- a/drivers/net/wireless/ath/ath12k/hal.h
> +++ b/drivers/net/wireless/ath/ath12k/hal.h
> @@ -1578,13 +1578,6 @@ enum nl80211_he_ru_alloc ath12k_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
>  	return ret;
>  }
>  
> -struct hal_rx_ops {
> -	u8 (*rx_desc_get_l3_pad_bytes)(struct hal_rx_desc *desc);
> -	u32 (*rx_desc_get_mpdu_start_tag)(struct hal_rx_desc *desc);
> -	u32 (*rx_desc_get_mpdu_ppdu_id)(struct hal_rx_desc *desc);
> -	u8 *(*rx_desc_get_msdu_payload)(struct hal_rx_desc *desc);
> -};
> -
>  struct hal_ops {
>  	int (*create_srng_config)(struct ath12k_base *ab);
>  	const struct ath12k_hal_tcl_to_wbm_rbm_map *tcl_to_wbm_rbm_map;
> @@ -1601,14 +1594,15 @@ struct hal_ops {
>  				     struct hal_rx_desc *rx_desc,
>  				     struct hal_rx_desc *ldesc);
>  	u32 (*rx_desc_get_desc_size)(void);
> +	u32 (*rx_desc_get_mpdu_start_tag)(struct hal_rx_desc *desc);
> +	u32 (*rx_desc_get_mpdu_ppdu_id)(struct hal_rx_desc *desc);
> +	u8 (*rx_desc_get_l3_pad_bytes)(struct hal_rx_desc *desc);
> +	u8 *(*rx_desc_get_msdu_payload)(struct hal_rx_desc *desc);
>  };
>  
>  extern const struct hal_ops hal_qcn9274_ops;
>  extern const struct hal_ops hal_wcn7850_ops;
>  
> -extern const struct hal_rx_ops hal_rx_qcn9274_compact_ops;
> -extern const struct hal_rx_ops hal_rx_wcn7850_ops;
> -
>  u32 ath12k_hal_reo_qdesc_size(u32 ba_window_size, u8 tid);
>  void ath12k_hal_reo_qdesc_setup(struct hal_rx_reo_queue *qdesc,
>  				int tid, u32 ba_window_size,
> diff --git a/drivers/net/wireless/ath/ath12k/wifi7/pci.c b/drivers/net/wireless/ath/ath12k/wifi7/pci.c
> index abdb3b8ff658..ba8c19c24ae6 100644
> --- a/drivers/net/wireless/ath/ath12k/wifi7/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/wifi7/pci.c
> @@ -101,7 +101,6 @@ static int ath12k_wifi7_pci_probe(struct pci_dev *pdev,
>  		ab_pci->msi_config = &ath12k_wifi7_msi_config[0];
>  		ab->static_window_map = true;
>  		ab_pci->pci_ops = &ath12k_wifi7_pci_ops_qcn9274;
> -		ab->hal_rx_ops = &hal_rx_qcn9274_compact_ops;
>  		ath12k_wifi7_pci_read_hw_version(ab, &soc_hw_version_major,
>  						 &soc_hw_version_minor);
>  		ab->target_mem_mode = ath12k_core_get_memory_mode(ab);
> @@ -124,7 +123,6 @@ static int ath12k_wifi7_pci_probe(struct pci_dev *pdev,
>  		ab_pci->msi_config = &ath12k_wifi7_msi_config[0];
>  		ab->static_window_map = false;
>  		ab_pci->pci_ops = &ath12k_wifi7_pci_ops_wcn7850;
> -		ab->hal_rx_ops = &hal_rx_wcn7850_ops;
>  		ath12k_wifi7_pci_read_hw_version(ab, &soc_hw_version_major,
>  						 &soc_hw_version_minor);
>  		ab->target_mem_mode = ATH12K_QMI_MEMORY_MODE_DEFAULT;


