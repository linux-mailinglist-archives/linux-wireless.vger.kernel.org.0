Return-Path: <linux-wireless+bounces-25505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF5BB06C06
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 05:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F92169727
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 03:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11123275118;
	Wed, 16 Jul 2025 03:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g7YYe9l0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE4B17A317
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635427; cv=none; b=eqOtKNtw8nwpdOXG+Z/GHMFujv4sNbG9o9ewUwzzZG6O68YsPQGjsSBObJpxA8VA1GFsvUyyaqLSiFqujIhsKTT0neHuXpQZLaVn2Ko3Dl9unm7DHSIbqQ4rp4+RpsuQcDDLNzRlXuRGULRtrZqKNhJSK9TKY9tIMUnfn1z7ll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635427; c=relaxed/simple;
	bh=+bE5/H9chYJq1Hq5l46H2XlpTKa0n+OuaZqkgbSrK4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8ol6Imt2S8qk6H77PFmD3cj+ezQdMD/tFJryZ8QapajOh/YDvFShep3PZtC8sy6qgXiCJqu/R8jrNXoyjPlLguC3V/Moujt5ijNdGnDGnwakJ9Bi+qP2dyE5cLm28Kt+UjoF9KKeMAQ5HEp+t+I1lNuWJKjs9bpanGk93d60zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g7YYe9l0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDIiq025956
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 03:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R1NecSqh/K6FXbaYkgId4IAbjQh5zLHrJiU/Yh9hchg=; b=g7YYe9l020tJCFHM
	Kl+x+DKnpjysRbOWcWVs2tVAuyktWwyyuP5gVJkaqeTZ7Ln1Mr/Hrq4meXgmnTCA
	kiYVJmaP9/guUMfyo82hHkOdmn/iDlKnOEgnzMRLA918j93ZubHEN+MVLLmjgF+O
	lei3xGovsyCaQEFCiPcWJC/+s7my2SvXybNGqGUaUPnwNcowho8viXhhy6buNDIk
	9WdH146m/Gj5USCWPHAWDkyeDFb73JMd7ZYauDXws4gAqGEyKq5zt/r8jq7RZ2gW
	Ds4vGgiuFyVgYrfjLH6AINGgyLV9jLuSqMlSEPYZ0W8KCMRsdgJuD8tfqxGoXBoP
	Lg7Wsw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsy22qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 03:10:25 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b3beafa8d60so3958325a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 15 Jul 2025 20:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752635424; x=1753240224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1NecSqh/K6FXbaYkgId4IAbjQh5zLHrJiU/Yh9hchg=;
        b=powZKqieMR/DKQrWY0UgIchYaGVdK84qGXtWxW5jMBPjPjyXxfuPATSNGObaxLaQZm
         3Ga4kd/6BilR7dG4nn1Wfca9+zwmwwZAZnS67vQsvNCgawcV7+qy4haNSJK0o5Mi1vXX
         oooIHRSCMuzoXuzu0GV9L65TMgqDM14NgzU/tlD1NPfcaP6GaywukJzU7FTMZIR5E4az
         l6/tBgV9bluyODcIvVSCXIErmI67HsRtNXLdbBBPSiGTlRD6Qorl1ZZCOXXWd8jt89G2
         KvZ8kKe2M5SZTrETyz5svdp4JSJt0phhzXEz9XKzOynTQiOcwU+lMz+IkSfXrYabsptf
         JIMw==
X-Forwarded-Encrypted: i=1; AJvYcCWi6gJFcgO6Y+shIvIGduFfYOzTTYv40IP5/GFcuczJAHe97rOe7VbTu01pM1ArT0zRwJqfD1zQrFAZFcPljw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Y47ckdPzV3N6aVELCN153k5/CE/FrAoiik/t85Y4PZ76kqC8
	ktKwdz41p5gHxMXxrbEnNDalExHgm7kwu6IiGqhV00oYDIiJsqDm4TMO3nC6eECmiyhO75phuSw
	mo4GbbA9oNDnvnI5CKQnrK8XXbpw2K4igxG3DDIaQ+AWtzAY4e7lnONfTZpc/ldqGN/igTQ==
X-Gm-Gg: ASbGncvxhAm9UI7AC6XWyWF7cPXJFxrdoKprEcIwUiBsqo21zWxP1wsqRcKWF7u8r8y
	OvSzVcs6tD5jhTyX/Xjf6U+NPlivvB3qGi2j2+vcW9+6IzWke/0hdLO0hj/GaE8q3Djko/l+S2Y
	tdmWryv7yxwEQKCfATQK4zh+5lUYrQibwnBlGxyikrFykh3wDKhWRmFzShrac8tb9AJRMdJVqoU
	Yzw9VZT5PwO2PIp/zg6weI2/ruktkWfsdpswyCQYBZplqbL6wKRYJHG2yOChfEGmGShm+0Oa0Gg
	sz00vkY4xwPgbVzyqQOcDbVd2b4M749tQQi+TZtxEvixGzv2s06s4Wv1yl4qNc3r34m4OLL73yW
	c9TdhBbKLjg3RBXBgonEXGV2fuKL2iZNr
X-Received: by 2002:a05:6a21:1508:b0:220:94b1:f1b8 with SMTP id adf61e73a8af0-2380db8e8d7mr1249313637.0.1752635424549;
        Tue, 15 Jul 2025 20:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiGRFaDVgMVw/6S2T7ToRpEE2QAahqPlEgNa4QLbCX9jXVhoF1n7FVrczoZKBOg8MHlEG5KA==
X-Received: by 2002:a05:6a21:1508:b0:220:94b1:f1b8 with SMTP id adf61e73a8af0-2380db8e8d7mr1249278637.0.1752635424071;
        Tue, 15 Jul 2025 20:10:24 -0700 (PDT)
Received: from [10.133.33.219] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4c989sm13514936b3a.130.2025.07.15.20.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 20:10:23 -0700 (PDT)
Message-ID: <7ecc1cfc-5033-4d74-9303-9ac58527113c@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 11:10:19 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: HAL SRNG: don't deinitialize and
 re-initialize again
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jeff Johnson <jjohnson@kernel.org>, kbuild test robot <lkp@intel.com>,
        Ganesh Sesetti <gseset@codeaurora.org>,
        Maharaja Kennadyrajan <quic_mkenna@quicinc.com>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc: kernel@collabora.com, stable@vger.kernel.org,
        Sriram R <quic_srirrama@quicinc.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        Bhagavathi Perumal S <bperumal@codeaurora.org>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20250715132351.2641289-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <20250715132351.2641289-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDAyNyBTYWx0ZWRfXzNS3xOitFvGL
 xGG0t3C6gcRJzn62rfbZkYAmuEaHJBLgtXoVSZyqhrL+erQ6sbDkm646mpmADQbIy9yYO44pkCS
 GxlAylVkPlseoB2j7fEWNh0YT1IVQ0f6vedcZYYmuvGN//sYu46oXLV2+lajChmj8pzuaQlCK/q
 ZzmEUr7ONsl2RSVpMdgNs5EwR4U4yMBMnyogWJI4ykNg0PvKFO+8Ib30iL3EjpNPtjGUuC4jVm/
 M7ec5IMT7Hpy0daXf4zdQNUrf/WMK7b3SRyuqWB5WiaDEfxow3Jq31IrhXNW04sHBT0sGx3/lvc
 tOUaoxbTkqGICX+j9T1mJdCMv+WbTfO0CGL0/OMcEbEQ2hBfiuffTyI9yuxnAZjp9qtWuM5Ea/j
 LSHhSmjShwhOLmtyIDkUkPo9nAe09ajKnbWjwNlaf5mNDdvw1Uto8FDGEjVsO7uTMpYNaZRp
X-Proofpoint-GUID: 9k3JwmMBhT_Vsgj5PG0Lx9zyQhf6g5vQ
X-Proofpoint-ORIG-GUID: 9k3JwmMBhT_Vsgj5PG0Lx9zyQhf6g5vQ
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=68771821 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=QX4gbG5DAAAA:8 a=FO1u493g7a1ack9Z5SAA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160027



On 7/15/2025 9:23 PM, Muhammad Usama Anjum wrote:
> Don't deinitialize and reinitialize the HAL helpers. The dma memory is
> deallocated and there is high possibility that we'll not be able to get
> the same memory allocated from dma when there is high memory pressure.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Cc: stable@vger.kernel.org
> Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Cc stable and fix tested on tag
> - Clear essential fields as they may have stale data
> ---
>  drivers/net/wireless/ath/ath11k/core.c |  6 +-----
>  drivers/net/wireless/ath/ath11k/hal.c  | 12 ++++++++++++
>  drivers/net/wireless/ath/ath11k/hal.h  |  1 +
>  3 files changed, 14 insertions(+), 5 deletions(-)
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
> index b32de563d453a..dafa9bdbb3d32 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -1359,6 +1359,18 @@ void ath11k_hal_srng_deinit(struct ath11k_base *ab)
>  }
>  EXPORT_SYMBOL(ath11k_hal_srng_deinit);
>  
> +void ath11k_hal_srng_clear(struct ath11k_base *ab)
> +{
> +	memset(ab->hal.srng_list, 0,
> +	       sizeof(ab->hal.srng_list));
> +	memset(ab->hal.shadow_reg_addr, 0,
> +	       sizeof(ab->hal.shadow_reg_addr));

nit: I would add comment here that no need to memset rdp and wrp memory since each
individual segment would get cleared when

ath11k_hal_srng_src_hw_init()
	*srng->u.src_ring.tp_addr = 0;

and
ath11k_hal_srng_dst_hw_init()
	*srng->u.dst_ring.hp_addr = 0;

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

other than the nit:

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

