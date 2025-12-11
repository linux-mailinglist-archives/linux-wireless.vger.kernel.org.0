Return-Path: <linux-wireless+bounces-29641-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36679CB471E
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 02:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B47723005193
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 01:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303E92153D8;
	Thu, 11 Dec 2025 01:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PL9mXFQp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SmO+zji0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8356C230BCB
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 01:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765417130; cv=none; b=cRdqeoDpbKMNF/EKrDRC9/ArCEzcHYEjJHaSSaaiQS5t4wTJN/XQglSuwu9DK4XFBQEp7VunegpzgSFaOaDLIXHyJcwXNo3hxrZJXdzq2kTz4pPFv6ZR035L7DDRgXi/Bw4ktocHBvPTAhK9dirQbiK6ccwA38+lPOj4qrfcWaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765417130; c=relaxed/simple;
	bh=Xl6t5Wo/bcg5rQUL8cL5aaf+rzI7yQcRiZs4UFZHr7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8UvuFRPvXhKVIdHjLGSXXSGw8o6LTyKFDr2CrSIb7/6HHWANwjDB4FriuyRwMD/3H1k/AOc1eJt1NPFXC6JlxnFtfrlGbt5i+fi195IkHSlhQt8OfeiftTJ5/+J7z/xx8Uq24INakzLeWqihGy1t2a/3Coq0POAeBhRLPHpNBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PL9mXFQp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SmO+zji0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BALSuQS216579
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 01:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GN++ADGzM627PAx9EVYDzZ1p5toEqhe0ETwpTHidCps=; b=PL9mXFQpWSUJNrgp
	WmBsV68Ph1mf7McN5yeMpTjJmp0LNEqi+fqIMpoEAenx3+ue6YcfVZbEqzvRpUHq
	mlFZAqwH23+R0ZnKw8i2YIIUYyRxg0dVYWykkA10z+NRTO5TbUWRd3YPhbeXkr1r
	jhIDnBLgHKTX9fuT8yIISnPoymO8hjEbUdmRH8zYckWZBopd9GKfwqUpLn+cE0iU
	aZCD5nk950X1xsGlZm0HY/yclNtM0CBuYQcVbnO86wbXlFJ8HeNAwjp2Z61Csid9
	KW+1tR8Sfb3QZbxqNcZyj2EIrvotEzaqajhtOPM/LnvJrjLjLO8oVcFZh3dwNH1n
	HWeZgQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aygr88j16-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 01:38:47 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7c1df71b076so822470b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 10 Dec 2025 17:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765417126; x=1766021926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GN++ADGzM627PAx9EVYDzZ1p5toEqhe0ETwpTHidCps=;
        b=SmO+zji0/B9i48IxSpbDTSobyfjMBfA/pGIHJZ2hrORFOy15iskSsEyOes2z1Topcg
         h6GAVzRy2/rzTcTNYxpXIloFYYt7nZJzKHvw0dIaJ3m1rhClBn8FUOURM+4oSvuSp/T2
         ptH76FNLHyM/zxMRYOHkBqBbajLP/Uh5qAvd+TqsrQ4Jc1bNZh97Lzc/MqbGypyp9v6O
         bSfKxMnm5fXlhyy29aUhMtbYvXjx6JdGLtzXGmN0Wl2JJqPMl6qKUkxrCeYzTgQPLjDN
         3OhYQTMphUX0W80My8oyay05fXzupKhGzpzSmzjlK5D8yPEfeHZPuEqzYoK/GswXtk0v
         9SVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765417126; x=1766021926;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GN++ADGzM627PAx9EVYDzZ1p5toEqhe0ETwpTHidCps=;
        b=c+sx15MYkDsgNyZlcEj7LAcIzcxHH4mgIMUC0JoH3LvGYWt+MWT1BQGhu9FuIcNsSX
         7MI6UknBEGishCWZMo5q6LopvCZwb0G0hZsvlQRAtqekPpva4vZsX+0z2kYi3hXfh4sM
         2t8g2Liij0tR/ABuQAO/orgcarqG+bs/lGY6ctNv4mA0MwjW/bXzdaD+9p0hRiMo1E6f
         e5aWLR07iB2eludKDd0mNjggOcSW4ijy4kk1ttc7sdScLDKTOTVDN5niXbfizbwMd8xU
         0uZGYuJYnXSFmEHjixgjOHCa329WjJf9HXES1oUHWcDOq0Es3C3YCfdI8v+2yPu4Nssh
         yDEg==
X-Forwarded-Encrypted: i=1; AJvYcCXR3d2k+4T5uyRsQulD0nVoQFSAssXQbu3vdePZ9dN1gPurVgq7vGCmZPCzlZPmKTYUD79haLwukzEhFR09eA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9BXT7BE2dmkOAH/AkPGX2YK4jjykiLn61A3ad5XGUTZJj5cch
	K2tEbNpLJfDs+IIk8b+bVvZ6uFim5caVcr4GXulevy6/kChJ/1T89kyP8gQs0E6bOF61eEFof7D
	TJYkpopEedYVkoztjtkeJM6AsIV7LjeRdDsgNsHfc+350tV2k3Uw2GCheeHfwJ0ZHAlnWsg==
X-Gm-Gg: AY/fxX6MNO458aMNAqhy4nNQoC2ql8bGQZAa5l/6VdIhyMWMTMHoDVL09tLwuNOgkEX
	nhMRImdEOvA6XQgQ53RUXJZXQqm1rjvUHH0kC9exQ0K6f/iqWS1SCxIt8zRadx0OiF4E9Db1xNK
	6RKD/0b1S76rUEnCidRoKKCvizd507oE1evunBJqkeGeQys1cWf7i7BCDX5FEgSfddCddxBhi73
	BjzIN26e4u+jYC1NXG82yR7kHthmXHcMZ85ZynM3YeSWqiG+dF/V/u4c2O8jWDKFeBs+xaA/n+q
	8+FRCmCKH2hqQ4VFZO0rGQ7hmEtK8sl2qjVgVvfK6xmNeXo0Y6g/pP2D27OWJ39QTUfA3uVn+/3
	VFP4LXUwilIosjQ6fzcpzNeEDHIITbi2k8lvYgI24yD+unZ+Tv+CZLx1+wfA9Ob/7qr8L/unskd
	Qz5f33seM=
X-Received: by 2002:a05:6a00:198d:b0:7e8:4433:8fb2 with SMTP id d2e1a72fcca58-7f2301c1149mr4259212b3a.58.1765417126244;
        Wed, 10 Dec 2025 17:38:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENC8HecPgiesBQXDwASJPfBe30YPLdltG2S8NA3lisGTdaJnNZvdAyMo1l59vYSLD75Dcyyw==
X-Received: by 2002:a05:6a00:198d:b0:7e8:4433:8fb2 with SMTP id d2e1a72fcca58-7f2301c1149mr4259191b3a.58.1765417125751;
        Wed, 10 Dec 2025 17:38:45 -0800 (PST)
Received: from [10.133.33.160] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c5093a56sm709545b3a.47.2025.12.10.17.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 17:38:45 -0800 (PST)
Message-ID: <af4e1f59-afa8-45ce-ba6f-5800dbfa9486@oss.qualcomm.com>
Date: Thu, 11 Dec 2025 09:38:39 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current 1/2] wifi: ath11k: add usecase firmware
 handling based on device compatible
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>, jjohnson@kernel.org,
        johannes@sipsolutions.net, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251204071100.970518-1-miaoqing.pan@oss.qualcomm.com>
 <20251204071100.970518-2-miaoqing.pan@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251204071100.970518-2-miaoqing.pan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Fr0IPmrq c=1 sm=1 tr=0 ts=693a20a7 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=qPzGLdPRDFbHXEUNeP8A:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjExMDAwOSBTYWx0ZWRfX8h92IITDCgA4
 t6mCoYmfwL+rGhzsocqq7sT/Fxvz4GSLLn9zr9mkp+GKRslT1YDoB5n875W12aI82EOoThs9zbe
 tx3lZg+KFFhDxzTav2PyTPbQnLN4aEg4fJ/0fZ64yjypNWDq3cBxfAEFzKCz7+cT3DdhC61CIqj
 cMhHr53eGTb2eEte0xDNUMAOsSkH4aOySJfHMZ8a8zEK7s6zV8L/NdZInRly2PAcu8m8+Bz9kH1
 6Gj0rYeEDVT5aoAKWC8eliGDHpg0+fSWyzv223D6mE0o4Xssd8K8j/RjGSph83S34Rb3MamXUdU
 5KW4y6hbmRXZq8ZEQv6Pk9+LuLkSG71/R3LUU0qWvBg3zFKSog/44tLk4kVdawoW0K7d13thAWv
 pMRIf0RB/pH22+EHVeP9s2eHR5e1cQ==
X-Proofpoint-ORIG-GUID: ZoDd4d9gCGC2kYrfeKIX4CfN80O9u-It
X-Proofpoint-GUID: ZoDd4d9gCGC2kYrfeKIX4CfN80O9u-It
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-10_03,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512110009



On 12/4/2025 3:10 PM, Miaoqing Pan wrote:
> For M.2 WLAN chips, there is no suitable DTS node to specify the
> firmware-name property. In addition, assigning firmware for the
> M.2 PCIe interface causes chips that do not use usecase specific
> firmware to fail. Therefore, abandoning the approach of specifying
> firmware in DTS. As an alternative, propose a static lookup table
> mapping device compatible to firmware names. Currently, only WCN6855
> HW2.1 requires this.
> 
> For details on usecase specific firmware, see:
> https://lore.kernel.org/all/20250522013444.1301330-3-miaoqing.pan@oss.qualcomm.com/.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1
> 
> Fixes: edbbc647c4f3 ("wifi: ath11k: support usercase-specific firmware overrides")
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 37 +++++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath11k/core.h |  7 +++--
>  2 files changed, 39 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 812686173ac8..a4a3a65c7752 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -1,7 +1,6 @@
>  // SPDX-License-Identifier: BSD-3-Clause-Clear
>  /*
>   * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
>   * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>   */
>  
> @@ -997,6 +996,42 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
>  	{}
>  };
>  
> +static const struct __ath11k_core_usecase_firmware_table {
> +	u32 hw_rev;
> +	const char *compatible;
> +	const char *firmware_name;
> +} ath11k_core_usecase_firmware_table[] = {
> +	{ ATH11K_HW_WCN6855_HW21, "qcom,lemans-evk", "nfa765"},
> +	{ ATH11K_HW_WCN6855_HW21, "qcom,monaco-evk", "nfa765"},
> +	{ ATH11K_HW_WCN6855_HW21, "qcom,hamoa-iot-evk", "nfa765"},
> +	{ /* Sentinel */ }
> +};
> +
> +const char *ath11k_core_get_usecase_firmware(struct ath11k_base *ab)
> +{
> +	struct device_node *root __free(device_node) = of_find_node_by_path("/");
> +	const struct __ath11k_core_usecase_firmware_table *entry = NULL;
> +	int i, count = of_property_count_strings(root, "compatible");
> +	const char *compatible = NULL;
> +
> +	for (i = 0; i < count; i++) {
> +		if (of_property_read_string_index(root, "compatible", i,
> +						  &compatible) < 0)
> +			continue;
> +
> +		entry = ath11k_core_usecase_firmware_table;
> +		while (entry->compatible) {
> +			if (ab->hw_rev == entry->hw_rev &&
> +			    !strcmp(entry->compatible, compatible))
> +				return entry->firmware_name;
> +			entry++;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL(ath11k_core_get_usecase_firmware);
> +
>  void ath11k_fw_stats_pdevs_free(struct list_head *head)
>  {
>  	struct ath11k_fw_stats_pdev *i, *tmp;
> diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
> index e8780b05ce11..f8fcd897ebd2 100644
> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -1,7 +1,7 @@
>  /* SPDX-License-Identifier: BSD-3-Clause-Clear */
>  /*
>   * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>   */
>  
>  #ifndef ATH11K_CORE_H
> @@ -1275,6 +1275,7 @@ bool ath11k_core_coldboot_cal_support(struct ath11k_base *ab);
>  
>  const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
>  						    const char *filename);
> +const char *ath11k_core_get_usecase_firmware(struct ath11k_base *ab);
>  
>  static inline const char *ath11k_scan_state_str(enum ath11k_scan_state state)
>  {
> @@ -1325,9 +1326,7 @@ static inline void ath11k_core_create_firmware_path(struct ath11k_base *ab,
>  						    const char *filename,
>  						    void *buf, size_t buf_len)
>  {
> -	const char *fw_name = NULL;
> -
> -	of_property_read_string(ab->dev->of_node, "firmware-name", &fw_name);
> +	const char *fw_name = ath11k_core_get_usecase_firmware(ab);
>  
>  	if (fw_name && strncmp(filename, "board", 5))
>  		snprintf(buf, buf_len, "%s/%s/%s/%s", ATH11K_FW_DIR,

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>



