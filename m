Return-Path: <linux-wireless+bounces-30514-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D4AD00949
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 02:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C2B7300288A
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 01:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A670D19E97F;
	Thu,  8 Jan 2026 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dBTs1j4o";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UNRNsML8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF407262E
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767836873; cv=none; b=NKlwaHjddTEZ4BzHxjpccAi8vDstFSQTpPvDE2+75gq/IQ/sjfhtVmPkTWlM5YmFI3ixnuPY55lwgPF7/GH2rJ0OOV/yuNpwND6F7MEQbCkgbgtEtIWJpjDo2BE+JkkkLpoP7eeBWcrcwnYlt9iYvkWC2tFSKu/EFWmoc/9mlmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767836873; c=relaxed/simple;
	bh=qroz32WBLwVzXQR+aXYRauo/5s+sf5BK2tzGylyzNLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cu6m1j6ocSO1UjLUPX07t/CFSQSydFJtYyeGWI5vljJ5hpvLDzvmFsHI10Q9s2odE4mWbDKGt5R6Qg9T0F9N6/vI/gIZRn9tvuNF9zQ+xJGZsMbIt/E3rm+i7TBgAmILgfxd5cZS/3uMFCi4Uiun76q4cs5QKjSZKxQ/18yThck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dBTs1j4o; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UNRNsML8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607H3PkF2453918
	for <linux-wireless@vger.kernel.org>; Thu, 8 Jan 2026 01:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H5EaLq7l4r9Qv+eRKXCITAG5O5aPUa+9jzfjApZuprY=; b=dBTs1j4oCONG0IzE
	GYhCHCcnnpOUKccuxKEIeVXBwdkxCR/POQu6aq6kZSwJyeQBpwjCyc+HDuPqwaiN
	Kt8DFFZu4ggQ2fNYwBcdKV+nYuV4T0o6zVV1akckOTeW3tPMN+FmRzN1i1llOKAW
	rmNq/1zzcX6doA4wxbvmQgPUX3mGAdkGqpF7WhYEewDxsKUQdPDzbDFR+KWzMh3f
	/WDlMn4F/V/lJvOhProAZE1wIlbkW3KfjNgi8FVC3ukCsDhgkdF1QHrCzaYxgS71
	Ytc1rPPcp4RAZfKjkJGOLyVyfmVioFoZauYXrJw2VQ1HQBC9Rt9loN1KAsMKE0CE
	frAvCw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhmnbjtt5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 08 Jan 2026 01:47:51 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34c43f8ef9bso1227557a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 07 Jan 2026 17:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767836870; x=1768441670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H5EaLq7l4r9Qv+eRKXCITAG5O5aPUa+9jzfjApZuprY=;
        b=UNRNsML83ToMMn6SzIvDaUCYADxeMStvzEfGDlEjaIE/HOCaTvOhBiXh6KdZpmX691
         kQ3Rk02B0myRfkjR+p2jd+mLtfO1MjdqmidSVI2DybvPuUfWPphrR1+6azEllyFt814T
         83OLMB1rLBGLgzfhrcKap3fV95gPDTi7vxE0Fko7AuhXlkwotVoLjpejw3Z1Bgl2v1mP
         4hBdwOLo1xnbGF5fd+97nDsN8uAo0SdIFe89cqkZRseBbwfnA9E715hLGxuiA4nK5L96
         x8TXNWrxURfJGEMar32aihAAl53aEp2n2H7LHLEk8W85eOl75Z5GFpAx9g3eCBnDs/X7
         ifwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767836870; x=1768441670;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H5EaLq7l4r9Qv+eRKXCITAG5O5aPUa+9jzfjApZuprY=;
        b=MIUKNxpEjWO30UDwsDXfsjuKRe8X87MxtFofKzAdXO7pl/Mm6wX61QsX5RtZQcB+i8
         A3CM2b9K9KxUVB3cq14gVZaHDTxgVMOmxng47xFSg95DurQihsw+wOhoE0psbYjEzTOp
         g++5/5Y63eaIvjcfLuc6wFMoaXELojkZdomO2X6jAdKvm2/Fh8iwiUZ4rsaIDjiOQza7
         jN/WCrb4rMK/XoVlOMBiybzBqMJ6rNyZAahEF12Z0UcMxV7wVD6bzoXqQm+SHBTn5kIo
         w4nbOeGy+zVJOcwi6y0SvH7oTMeyVZndJKFrs3/Cco8qgyn/+tbWpCmsLBLHDk9AwfWI
         XJfg==
X-Forwarded-Encrypted: i=1; AJvYcCVJnZBXlZD7kC5zm2BkE4uq0L//a3HEJIYAh2PrlXDEOlxipU4Iq/sQQjumi1swOXuq8gxEf3HzbWNvDCQkkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5jEqCPRVkfxCnwVQJZ3QYb8HfHhaP6ep96ba6ztaEg2gccu67
	/xgwLWY1QgFWGDZUDcK9erSeJfO5YCpXY78+dksNuZkSibxbYkQl+XSZrTfPR17drzWYTHaimcJ
	O43p609RZUIaJ+Qn6AZIjhEWqfcS9l6mxqg0D8nd23L5nasAwB4gTeTr9KhAX8yiufZLv+A==
X-Gm-Gg: AY/fxX4R2hz78PgzdHbGwMcesLcvKqZ1ZRKFsNvmmBcb9u7FCP04KfXkz274Xl2HnGj
	x3NtSLFaxs9+vhhgj8IB4FnIcg7QVM8/T9SXNtF0GCEjiyZqM4Ig1WE7f2OOhFLShx0Q1XnxvMo
	osr4GILsinmT+TjKRQ0qTcmNlAUodkg4CiJOVnVVFXQnHSlBb9qLqnAnGj2kIT7oVGWFT9+SGzB
	OAAcEFBuZdlnJnThDyDRDDIOIXAtgnMkiuSt1jMxRM5yvddt0N8a+9XaVpV12haTu/Jyk3kKobn
	Es8Y+V0KzlZ9YtG/pMe0jMX7/wq3NTpXwxq/6txMGW+NgJuqTchLNtwsD4NO4m2qs7mBv29yuR8
	NuADJdKTejS2aBwitFPD+AV8Q2ZCccerpkmd6iMGz47SNoXxYCxjrD7LLVAOanAXUCJYAS7CDRT
	BYhuz7FYw=
X-Received: by 2002:a05:6a20:12c9:b0:35d:d477:a7f9 with SMTP id adf61e73a8af0-3898e9e80d5mr4609683637.12.1767836870287;
        Wed, 07 Jan 2026 17:47:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3YWCfADrOOCR6wSpPCnOFTVPAXH2Gn5pZYUOzeQCeUu3TbqA5IghAJc48TLXd813ZABX+Ng==
X-Received: by 2002:a05:6a20:12c9:b0:35d:d477:a7f9 with SMTP id adf61e73a8af0-3898e9e80d5mr4609662637.12.1767836869808;
        Wed, 07 Jan 2026 17:47:49 -0800 (PST)
Received: from [10.133.33.194] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bb4c8186sm6034787b3a.29.2026.01.07.17.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 17:47:49 -0800 (PST)
Message-ID: <6268b094-5a40-40d8-8461-9c9b0f9e1ae3@oss.qualcomm.com>
Date: Thu, 8 Jan 2026 09:47:43 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: add pm quirk for Thinkpad Z13/Z16 Gen1
To: Ross Vandegrift <ross@kallisti.us>, Jeff Johnson <jjohnson@kernel.org>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <wj7o2kmb7g54stdjvxp2hjqrnutnq3jbf4s2uh4ctvmlxdq7tf@nbkj2ebakhrd>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <wj7o2kmb7g54stdjvxp2hjqrnutnq3jbf4s2uh4ctvmlxdq7tf@nbkj2ebakhrd>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDAxMSBTYWx0ZWRfXz266EZ/l1wQa
 6YPubhBzPU31S+MJN4zObDA+MrgJAweszNgBnBmp003AQzrFCj/7uW4GK292TlqGqWZ5H8rYBAQ
 ZeYutT42LkIOYCR74htuSRpGsKpVoNdfLUQTPn0hfv8USV8ZfngvY2CRBEucWbeIw9muX2NNhvz
 FGhUCDWZkWXDYpsNmrXZjd3PnsW9FeYI1kL5+Fp8N4A679YLYryTvDff/J/0KEJvAKPBqwqsx1K
 EPdUiMf2v13NhuEbdAfHiIB+OAk5GM7grfjYAZwsVCwc8ddWI7pUlUuq/JPoFA6Gxk+iD2Wt58U
 8pGWN+X3v5z22Ogjd32QtbBWCl+ZBM70D5JXIkHMg0mgAgMES/SWCXmsB+++u3Vq0gozVMVXss4
 Cw8+iMk7ODgNZXIVjpLjjJsLSI7jNdqM+XoAYyB9jMPrV8XYkAw+iQdiTbDT+wa/0SKXZeqtk/4
 FcCU/PfiLmM/AoP/7Zw==
X-Proofpoint-GUID: 1_A8nUYyreK_trXVLhZk8gTQIxtUy9GQ
X-Authority-Analysis: v=2.4 cv=eIkeTXp1 c=1 sm=1 tr=0 ts=695f0cc7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=aNK6nAb2l6YIsMJANWAA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 1_A8nUYyreK_trXVLhZk8gTQIxtUy9GQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_05,2026-01-07_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601080011



On 1/4/2026 9:00 AM, Ross Vandegrift wrote:
> Z16 Gen1 has the wakeup-from-suspend issues from [1] but was never added
> to the appropriate quirk list.  I've tested this patch on top of 6.18.2,
> it fixes the issue for me on 21D4
> 
> Mark Pearson provided the other product IDs covering the second Z16 Gen1
> and both Z13 Gen1 identifiers.  They share the same firmware, and folks
> in the bugzilla report do indeed see the problem on Z13.
> 
> [1] - https://bugzilla.kernel.org/show_bug.cgi?id=219196
> 
> Signed-off-by: Ross Vandegrift <ross@kallisti.us>
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 28 ++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 812686173ac8..03dddc1cd003 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -994,6 +994,34 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "21F9"),
>  		},
>  	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /* Z13 G1 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21D2"),
> +		},
> +	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /* Z13 G1 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21D3"),
> +		},
> +	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /* Z16 G1 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21D4"),
> +		},
> +	},
> +	{
> +		.driver_data = (void *)ATH11K_PM_WOW,
> +		.matches = { /* Z16 G1 */
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21D5"),
> +		},
> +	},
>  	{}
>  };
>  

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


