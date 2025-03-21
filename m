Return-Path: <linux-wireless+bounces-20677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E78A6BFD9
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 17:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627AB3AE53C
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 16:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639711E3774;
	Fri, 21 Mar 2025 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oasAynND"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1481D79BE
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574263; cv=none; b=eNqHY3vEl79+Y15Tq0nhAgkyST9hdx8MBC85qzrD+WrGOJsB0n2C624CFJmaCn139cEwizqiqGU8VS9cRWz0hNsy/5ruu2BN2xnLvfMt8XTS67c2AbWZ7jvU9kjau2miubBttyBbAUA1KWPXo4BuI7aviRgmThxz/CFL7gOvkBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574263; c=relaxed/simple;
	bh=YsJQeM2tMyPpLiwttYxSTfXeKJvWcm5wgcqPGu+wNSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyov7wi0GwiumEfpUNIEVL6iaSPqlXrH25vF9IWQlWrpDkBEaRVl1lzj9V3oqEFbIuaZCiLf8EahqZ3EeN296Tc91cL6VHDMaLuYz/aXaopdVIqGH2ibRbwu3H0QYxgAb9Yn7X/gxml6TJfOQ58sOLuZ0m9mOSq669YiSKh2n0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oasAynND; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LATDcD015037
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 16:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2d5DvgyokFiqCNcz1zJsWxkP1xiNt8Du6XvPWTVYw2Y=; b=oasAynND7/YT+HYf
	2j88kbkZD99S7pb/fSWAoJdNltOkoY3o9Vf8tdq8wz3rbw3NzvlXkqg3O0IqAAJK
	CYtra/zzAPDlPRW4wg4tmWh4gDuTrOg+i01gU/uxMnXk6lWNCp7nPqVC5NpAte6G
	7+sInkduiKlSdpNO8nR7JoB/JazI1UJSCgQxRZZwSfFLZ5KNXVINnQvVVVro9vLA
	TpvqoF/mGmArbQ3GsFE+LQ5gq8Ng7pb+M7xdMIjqWVBJ+ez+W7gNBwBsjjfWEVOL
	cz8HJIdsbo1c3vXKef5wlHd1p58FAOy5scoonPBLWGYsU5cbggZLQMReVyji9sqO
	oh5qIg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45gbngnk22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 16:24:20 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-224191d9228so42832965ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 09:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742574260; x=1743179060;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2d5DvgyokFiqCNcz1zJsWxkP1xiNt8Du6XvPWTVYw2Y=;
        b=nbFAKWO6ULMv56MST4B/j8gnKdSEP283GPf9zAinNjdf0wsQeSR8b/C9MusTMdo1e2
         fLLwdgw0AMNYQBF4IjiWWObGrFAvaitbhHqsoJgLl5RyxprPXHvau++4ZvQ9E7B49B1K
         Suuns3HfOzKpc2gQsnazx0K//h9FoLzEv68XN0r8Gwn7BvcRjOAgr4ueRC12zw5O/qyJ
         /xQlCkv5oriIM88/z5nPKMbnUEVgzmgsZZWcGtWNGihGPIPltpp0+i27amQJFciycMsn
         u+LwH3plit4r+LZCn/JR3v/RHxInnkcHyeghOrTCu5EbNJjVZh62BbgAkCBAMQJ5M/aB
         f4Gg==
X-Gm-Message-State: AOJu0YyjcP0TKwJQihdkRRgv7oIdmZ14J+gfSzoctJlWuBzoePPhqsoQ
	zYCIDjFBkMRYzZ4mFG0rPrVc8vT9LIMRxAoc/9UDhdJOFoOdTDBxpuFiwymVNrOVjH/KOBV5hNQ
	2I6DwBWjSbRUr75VosNneS4ytXwvUm8yGaknqnwsAfQcN3IQ4M/Fxjk/24dLoRaYcCQ==
X-Gm-Gg: ASbGncvaQ0InuPv7X6tAB09iUa23PdXlut/oNxaLzm4pCUnSnOYwtgi+Bjg9CLQX2+G
	KjJgX5pWGsso+DqkU7rokal1dc48LwkoKAecuRMBelps2x2SQiRClnFYYc448++3nLgZnQjDI7A
	onunyjdLj7a39pPE83814voJw11VrKa1tkIVlkpsKjYLUNkyabbngqn7hNhaeHsGoM2fL2hNY3v
	KHTRW0abelntMggUK+QInieDF94ZDtcG1SQi5r3iFNiqXKwKtVoNJmzX97hY7zNaQ+OjZH/Z0or
	/SX5V5VR5KKSz0B5CPeISdV2cV+gGrxdW3jSG6fNdsSyG0QX15c2gicf4yThUysZAgN43c8H/6L
	fmtSj4yMs
X-Received: by 2002:a17:902:d2d1:b0:224:24d5:f20a with SMTP id d9443c01a7336-22780e231a1mr71159295ad.48.1742574259979;
        Fri, 21 Mar 2025 09:24:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt2eaavmZmR9HVJNc3FxbeTqHpXoHvG7fdrQvJYFASMN5Kh6hmiQwNOs32h5LYePkevZ6ItQ==
X-Received: by 2002:a17:902:d2d1:b0:224:24d5:f20a with SMTP id d9443c01a7336-22780e231a1mr71158845ad.48.1742574259557;
        Fri, 21 Mar 2025 09:24:19 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811f651asm18842265ad.209.2025.03.21.09.24.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 09:24:19 -0700 (PDT)
Message-ID: <2fbf299a-b596-4a61-becd-07e66f7be29f@oss.qualcomm.com>
Date: Fri, 21 Mar 2025 09:24:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 1/5] wifi: ath11k: determine PM policy based on
 machine model
To: Baochen Qiang <quic_bqiang@quicinc.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250320023003.65028-1-quic_bqiang@quicinc.com>
 <20250320023003.65028-2-quic_bqiang@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250320023003.65028-2-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: AlPVdGojWij74EdVcL0Azg6yHenISYB2
X-Authority-Analysis: v=2.4 cv=MJ5gmNZl c=1 sm=1 tr=0 ts=67dd92b4 cx=c_pps a=IZJwPbhc+fLeJZngyXXI0A==:117 a=e70TP3dOR9hTogukJ0528Q==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=stGd1_jjPkh5WPs-QC8A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: AlPVdGojWij74EdVcL0Azg6yHenISYB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 spamscore=0 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503210120

On 3/19/2025 7:29 PM, Baochen Qiang wrote:
> To handle the Lenovo unexpected wakeup issue [1], previously we revert
> commit 166a490f59ac ("wifi: ath11k: support hibernation"). So currently
> WLAN target is put into WoWLAN mode during suspend. This is a temporary
> solution as it does not work on machines where WLAN power is cut off.
> 
> The thought here is that we do WoWLAN suspend on Lenovo machines while
> do non-WoWLAN suspend (which is done in the reverted commit) on other
> machines. This requires us to identify Lenovo machines from others.
> For that purpose, read board vendor and product name from DMI interface,
> match it against all known affected machines. If there is a match, choose
> WoWLAN suspend mode, else choose non-WoWLAN mode. Save the mode in ab
> for later reference.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=219196
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 55 ++++++++++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/core.h |  7 ++++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 3d39ff85ba94..8657e735bf16 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -907,6 +907,52 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  	},
>  };
>  
> +static const struct dmi_system_id ath11k_pm_quirk_table[] = {
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21J4"),
> +		},
> +	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21K4"),
> +		},
> +	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21K6"),
> +		},
> +	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21K8"),
> +		},
> +	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21KA"),
> +		},
> +	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21F9"),
> +		},
> +	},
> +	{}
> +};
> +
>  static inline struct ath11k_pdev *ath11k_core_get_single_pdev(struct ath11k_base *ab)
>  {
>  	WARN_ON(!ab->hw_params.single_pdev_only);
> @@ -2327,8 +2373,17 @@ EXPORT_SYMBOL(ath11k_core_pre_init);
>  
>  int ath11k_core_init(struct ath11k_base *ab)
>  {
> +	const struct dmi_system_id *dmi_id;
>  	int ret;
>  
> +	dmi_id = dmi_first_match(ath11k_pm_quirk_table);
> +	if (dmi_id)
> +		ab->pm_policy = (enum ath11k_pm_policy)dmi_id->driver_data;

Cast via (kernel_ulong_t) to address the kernel test robot issue

> +	else
> +		ab->pm_policy = ATH11K_PM_DEFAULT;
> +
> +	ath11k_dbg(ab, ATH11K_DBG_BOOT, "pm policy %u\n", ab->pm_policy);
> +
>  	ret = ath11k_core_soc_create(ab);
>  	if (ret) {
>  		ath11k_err(ab, "failed to create soc core: %d\n", ret);
> diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
> index 1a3d0de4afde..df2b0cb2f0b5 100644
> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -892,6 +892,11 @@ struct ath11k_msi_config {
>  	u16 hw_rev;
>  };
>  
> +enum ath11k_pm_policy {
> +	ATH11K_PM_DEFAULT,
> +	ATH11K_PM_WOW,
> +};
> +
>  /* Master structure to hold the hw data which may be used in core module */
>  struct ath11k_base {
>  	enum ath11k_hw_rev hw_rev;
> @@ -1058,6 +1063,8 @@ struct ath11k_base {
>  	} testmode;
>  #endif
>  
> +	enum ath11k_pm_policy pm_policy;
> +
>  	/* must be last */
>  	u8 drv_priv[] __aligned(sizeof(void *));
>  };


