Return-Path: <linux-wireless+bounces-25842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2F8B0D63E
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 11:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDCB6AA4332
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 09:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D2B23F28B;
	Tue, 22 Jul 2025 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bNmGnpZB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E9323C4F6
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177672; cv=none; b=QOn/9zPwwpmmJN6eUmE2D95hKPPcZpGu92DWk6ttD6olnqajzK9srpB8ggaCuIPxf8lbWICEkiT01N8WtodWfuFR7vG+7WwG5pzew5+tswAzJ33evm3GQFZ8e5wjTggk5bCzzjLpZLLlehBokbW3Jyj1DPfrNix//36mezGA1ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177672; c=relaxed/simple;
	bh=/A5bLX16piFxZp3C1uvq7w0g/FlmchWFhW3t4OYe1G4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUj9JrX0cr8AZK0z8o+TXQCFG1K0HV7JilloTC8RG0YWF3ipwFLzBpGly5ywU4fPfXQwkb3RRtUhyybpjGW3uUu+CzACYGr7tIv9HEFqxQ8U+jY4XybEuTWgE8ikMgdsNlHO1V8PvG+r8mOxaDWX14lIOfIRaBUMu2O3hy+PrfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bNmGnpZB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M3tNvA015772
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 09:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8BjM9ebfFLsQQcZe6TQ0vgUH4ajpI01hnGqNMGuQ5N4=; b=bNmGnpZBKEr/+gT+
	Gf7YHgqDyL36SAGt8rwfkfYdw1+m84Sa/N8PyIrOktbzpow0609ipmsdR8zbGoTT
	v20gVWNzdF5F8d1S5/4ZrXGo23r7sFMTaOlqcQKYZ91x58pk6XxlYQ7eDXQuwsF1
	7JKMJx8KI74TlvzC4Q5kn2Z1av2o+gkjjvgJVbFV4bfPMsXv0U39DF99xGajnJrf
	0Nq6ru8p/FDV0JMnSecEVJiSy6a2hyty7wM1416WdVdZPzOoLhxzD94KKWRXzOAo
	XXh+LF5n5HcQL6zVRZMZKqsK54dIISctG49NJF5SEfSQFKVqzbRolryju45TWIpO
	ABzC8w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 480451gthu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 09:47:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-237e6963f70so86737585ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 02:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753177669; x=1753782469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8BjM9ebfFLsQQcZe6TQ0vgUH4ajpI01hnGqNMGuQ5N4=;
        b=uGRu1DeFtgnPVqGf4N7hWUmJ07W0EMu4zFRczKgbE67O1kB2Ki+X2udbRprFDZFZhb
         zmy7q3Xuyahdy/kU9yGv/7e4sRgBA4xaYg07hxPXfAgaD43O5pwvA0nTabj683vPONOW
         u1PoMAEf1JhorHamE+Y8JVU54dzZOtE3H8eHk556ScpAswNUQ3bYJa6M26RMcd4WSU/D
         LtoSob7ait1kw4SVAABgjjjnPpHz3SqXknTu1VxbHaTQAF9jNp3/Z4s4SI+x31aMSQfW
         QcfeWsKuI/+QnDbNn0jkomHILNcms2N5bGiLumnZUbtxrvs6G/qDSqo7kvcMvBnDco4e
         yNnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsY/lMjilyqoT9DN9DhlEDx1DBHa6rAHBRw7lTNaBxFQx2zv1OvVxtPd1ltD8LVa5vSqlzbNUyO/jnptPECA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaluO15XGrGXkuvv8jMfloLiPTCN5rdUBdDj/3Etn6ffeALI2l
	bJ9GL6GA5tos9hjek5FMhQLwm9dY7peQxAJ3mPW7Ro2ufLEJh+MF/WobG9hipsApmWlHpNCPl25
	JT9N8Cu+/4ij6Uzag3t9Fe9CtF6jbH9pNCsCzezTp7WMwsIC4mVij59wT5ovqOg7OvEwmdQ==
X-Gm-Gg: ASbGncuck56xeTDK7q0oF8tbYUashyBC8JiH786/eop+hlE9R8rdT4H0RBxqPcIaiFZ
	nDNUpUQXHULXElfaDAVUqZvgnO8cSiMn5SLoUhABFKrCbpA75GHzUq9uRsDM0iuEYcKRvc3xxzC
	lXnNiCdnNL35OdgGcJLlvp+cOYo00BwQWY+Yp68M0opqR9PQXaPGaseDn8Y6kwcBsmIHwDNPChM
	vIMKwZOYStSNYJsy3cFDUcoK2j3j86gbzts+OMYXPMLKl3ZdpOmvkESCVwEAPjae65mEmAS1Ke0
	hRXtjE35rad+dJrOQT7b1DUtTJTCACS+Z5riNkVEcxL9bWr9IurCkA1O1HuNn2u3FWnYAbOXoWw
	WfFr5/kLYl/XXOr6vUKhNKzb3w8slwuI=
X-Received: by 2002:a17:903:2d2:b0:234:c5c1:9b84 with SMTP id d9443c01a7336-23e3035f2eamr249469225ad.37.1753177668777;
        Tue, 22 Jul 2025 02:47:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb4WZW5dxHh8zGqRjkvN4xW3CSAyaaR3EwQbz0e6h/H5rEz1JsDrBRAu/UMYCUGTF2EEQHYA==
X-Received: by 2002:a17:903:2d2:b0:234:c5c1:9b84 with SMTP id d9443c01a7336-23e3035f2eamr249468855ad.37.1753177668301;
        Tue, 22 Jul 2025 02:47:48 -0700 (PDT)
Received: from [10.133.33.45] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6ef9aesm72272625ad.211.2025.07.22.02.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 02:47:47 -0700 (PDT)
Message-ID: <1598d25d-e254-410e-ac5c-66d5450fd686@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 17:47:43 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath11k: HAL SRNG: don't deinitialize and
 re-initialize again
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        kbuild test robot <lkp@intel.com>, Julia Lawall <julia.lawall@lip6.fr>,
        Sven Eckelmann <sven@narfation.org>,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Cc: kernel@collabora.com, stable@vger.kernel.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Muna Sinada <quic_msinada@quicinc.com>,
        Anilkumar Kolli <quic_akolli@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>, Miles Hu <milehu@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250722053121.1145001-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <20250722053121.1145001-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EIMG00ZC c=1 sm=1 tr=0 ts=687f5e46 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=QX4gbG5DAAAA:8 a=FO1u493g7a1ack9Z5SAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: GPkwhJFDK-MvXHuatGQJZhqFOe5-cwXq
X-Proofpoint-GUID: GPkwhJFDK-MvXHuatGQJZhqFOe5-cwXq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA4MCBTYWx0ZWRfX+/RGHo2MszTe
 HlKdhvD9tCWi7LLTmdhONIAPj2sUhAYFYZCHOIp8i3QclwqIr2AIxSy5b3QY+xEtFmyvwt1K7Yw
 czsBI2fg4kbDigFe6sGG36SI73SLMI0Q00J1GdwPmLjtnN6DaLv4ESB9siaDlgpAx+EbhiqXirP
 kl4x7sfX7znMiuGCe9zjEyVvXM8FliYS5fT4InbGO2CZ6UNpBovocX8JiC9bqkQBqt96Y2zzda4
 50T1HgWVjK3FtJ2aK+BZF+rAeVOIukOWENehIQ4Q5TIy4sA1XuuCRL+R7pV/u9ZvIdpVUfZs2Hl
 RNbPirmTHsVCLfPyJPXluRGUVenXdNWNhE7jA4tYSs5ujkwrjHLhOzWLG7ruz+OS7AdrgJzqwN1
 Rwy3ePRZstVhJnOIIlxXDXO5Pvtig7uEsoIFhG+4+QlOSNlu+CMqfxKzOvb3YWBmhFAXlVtw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220080



On 7/22/2025 1:31 PM, Muhammad Usama Anjum wrote:
> Don't deinitialize and reinitialize the HAL helpers. The dma memory is
> deallocated and there is high possibility that we'll not be able to get
> the same memory allocated from dma when there is high memory pressure.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Cc: stable@vger.kernel.org
> Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Cc stable and fix tested on tag
> - Clear essential fields as they may have stale data
> 
> Changes since v2:
> - Add comment and reviewed by tag
> ---
>  drivers/net/wireless/ath/ath11k/core.c |  6 +-----
>  drivers/net/wireless/ath/ath11k/hal.c  | 16 ++++++++++++++++
>  drivers/net/wireless/ath/ath11k/hal.h  |  1 +
>  3 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 4488e4cdc5e9e..34b27711ed00f 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -2213,14 +2213,10 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
>  	mutex_unlock(&ab->core_lock);
>  
>  	ath11k_dp_free(ab);
> -	ath11k_hal_srng_deinit(ab);
> +	ath11k_hal_srng_clear(ab);
>  
>  	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
>  
> -	ret = ath11k_hal_srng_init(ab);
> -	if (ret)
> -		return ret;
> -
>  	clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
>  
>  	ret = ath11k_core_qmi_firmware_ready(ab);
> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
> index b32de563d453a..e8ebf963f195c 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -1359,6 +1359,22 @@ void ath11k_hal_srng_deinit(struct ath11k_base *ab)
>  }
>  EXPORT_SYMBOL(ath11k_hal_srng_deinit);
>  
> +void ath11k_hal_srng_clear(struct ath11k_base *ab)
> +{
> +	/* No need to memset rdp and wrp memory since each individual
> +	 * segment would get cleared ath11k_hal_srng_src_hw_init() and

nit: s/cleared /cleared in/

> +	 * ath11k_hal_srng_dst_hw_init().
> +	 */
> +	memset(ab->hal.srng_list, 0,
> +	       sizeof(ab->hal.srng_list));
> +	memset(ab->hal.shadow_reg_addr, 0,
> +	       sizeof(ab->hal.shadow_reg_addr));
> +	ab->hal.avail_blk_resource = 0;
> +	ab->hal.current_blk_index = 0;
> +	ab->hal.num_shadow_reg_configured = 0;
> +}
> +EXPORT_SYMBOL(ath11k_hal_srng_clear);
> +
>  void ath11k_hal_dump_srng_stats(struct ath11k_base *ab)
>  {
>  	struct hal_srng *srng;
> diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
> index 601542410c752..839095af9267e 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.h
> +++ b/drivers/net/wireless/ath/ath11k/hal.h
> @@ -965,6 +965,7 @@ int ath11k_hal_srng_setup(struct ath11k_base *ab, enum hal_ring_type type,
>  			  struct hal_srng_params *params);
>  int ath11k_hal_srng_init(struct ath11k_base *ath11k);
>  void ath11k_hal_srng_deinit(struct ath11k_base *ath11k);
> +void ath11k_hal_srng_clear(struct ath11k_base *ab);
>  void ath11k_hal_dump_srng_stats(struct ath11k_base *ab);
>  void ath11k_hal_srng_get_shadow_config(struct ath11k_base *ab,
>  				       u32 **cfg, u32 *len);


