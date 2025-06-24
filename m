Return-Path: <linux-wireless+bounces-24443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DF0AE6D74
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 19:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57AE189F2CB
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 17:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B392222D2;
	Tue, 24 Jun 2025 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iLjDCPE8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A6E1F4199
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750785977; cv=none; b=p8sw+BnQPd7NQujgErG9BwJ89P5XuSSgP4t2Rpk4pbYl/fUDrZXYFfa4h83f9qiR3NsM/eI+TolAE1McoOcNMrHM9n617aBP9+JQxGLr7oSwK3CtYHsKNhWwGD1wQAwUa3ykvz9HUk2FZMnGh5HN0U8HBnyKOHgoQHwwh9PI8Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750785977; c=relaxed/simple;
	bh=OuzUpKf0jEo1QiwviLnVFkr8fHoEwTvbFsE5gG3FI3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T0/toS8wQImFc6QdTK3AQwPvKlaVwlotTz2uKTJIghUedDFyiHlwmqep8xY0P8MY4JUwXM7wokDD99DAh2pkmXDM1AOl/4vbXYBuC6naIrFj3sT8YkxKtp7I6fU1vlm6JRrbqhO0oFYvWSyc10BHPw+IBxvxq0RsTx6gYirwY3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iLjDCPE8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OGiWRu015564
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 17:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H81KJDxnvk8MLP9fd6usStsOVCgvFGkQ9vXSXSAgBOc=; b=iLjDCPE85hZUmA0J
	uGmXfPria38knNTGYg4X6sGKJzcjyXpCjaDcMZCwXjAx756NH8ArLfjIh+bVZS++
	gxOqL1j24TinnuPCJr+rcmQqoO0B/2ueIXgfsR2d1JgnRbY4eY5Z1UOzhKwhYwDk
	mOyyPVoI/oq/mRqU4GUCbvBjGM6FgQ0zwbB6mQ3vRYywG+h3uuLXr+CN6VmKwfrG
	u3qXRxyLo0KOIdO68v0xgUvA6u+pvWC5O8aRnTttAqEwJ3aO8unUG4MV/yYniAUq
	qbYHlpUkonFdAaO7C7wbsM3uFERuo2nnd3kOqaKezGQa+OCy9c4tHxy5wToLUyLa
	euFvQQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fbhqkkgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 17:26:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31202bbaafaso5669911a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 10:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750785972; x=1751390772;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H81KJDxnvk8MLP9fd6usStsOVCgvFGkQ9vXSXSAgBOc=;
        b=f1A5P7bDTdMJi4k2wtL7QgOh5byelVjhPC4HdVFbDXUxfY+vgF3ZVkIqRPpL77BXjd
         WF3SjxPTktF5eQTQXD6vlWHvV12KrMFHbwoICvHhRJGkCRxK8CtdZDCZ95pDwQRQQUAm
         pf7dps4yjWEjvju++e5Eqv6UAuYwbDjbVmfh7bib5J91X8mp+atDBZG5asKXnTdpj555
         5nQASYxXKvGGhaeIwMbt+tsI4Wpl0o4abCpfkoGdS6s79onaWLFr+6/4z7Wa33fM00Hy
         zfCzJWKtyekCE8snhP1+EGCbiXwbPE5gOhscvapseHNTv4sPaOhFZAx6cNX6AishN/3O
         /t2Q==
X-Gm-Message-State: AOJu0YyUf5keeQedPeig1YnlVevmjGSyMk1kwCOXPA5Hh6swACnx6Ag0
	XWmRm0hl2TJYVVWeycjbiK7mqrFXgW9SoCP/pVQLjA4U3CFl1koArYUsjE6GGixkiHQCEvuNx7Z
	Ycv55hPxIfuuf3h9vJl//EWaCpjY6bvm+TfBeXqsugWFR8AQQCIwlbATZgaD+GHnsf028LTRryU
	Ch+A==
X-Gm-Gg: ASbGnctgZfzFdBbzoBQrUkYpvn8IYKc2A2QUVJKjvEa/MvNtrjRSJcS9HJ9r8M2nKmQ
	On7m551rqmyP7NH7kRvYuLay9ztCiSQtgWyTW3MjJ9qeVCMPj8fC391e6L7BGyyEsrD1DIS90jA
	93wY7WMMbuPSEuJ3wa0sbBRmpSmD32BjVsgQaMjTK7TPaoGadspX/eGlGwNVUu7a/QPcTQ+V27z
	WtklP14ttUBpIAz4Rj9rmqbNDu3qDGt8SRr4A0JfJf2+asJTm3C3mxtJpagIbfo8v3aCsrAe4wr
	NGnTcivKfDHNllADXGwg62s0Tr6ESXUSn4iqPDHF65/LD4Ke1u/7ED/mgTHlE8CHUa0YnNVlv/D
	fc7OxfyNqlJ42/QQ=
X-Received: by 2002:a17:90b:1d8d:b0:312:1ae9:153a with SMTP id 98e67ed59e1d1-3159d8d6852mr24567639a91.25.1750785971905;
        Tue, 24 Jun 2025 10:26:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETairooMDzC3XVhPtfXlzqNuXuLeX56ohzqzwK4jWFu2BzVK3o1ztV+39tfeed69Z0UQeInQ==
X-Received: by 2002:a17:90b:1d8d:b0:312:1ae9:153a with SMTP id 98e67ed59e1d1-3159d8d6852mr24567607a91.25.1750785971401;
        Tue, 24 Jun 2025 10:26:11 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a331983sm13248029a91.47.2025.06.24.10.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 10:26:11 -0700 (PDT)
Message-ID: <58fa9f69-2525-4c6a-acc8-571b20a4646f@oss.qualcomm.com>
Date: Tue, 24 Jun 2025 10:26:10 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath12k: add module param to control MSI mode and address
 width
To: Govind Singh <govind.sk85@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250624165031.58616-1-govind.sk85@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250624165031.58616-1-govind.sk85@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bflKLFau0d9AuXpkK44c6WgYRcgmJQfg
X-Authority-Analysis: v=2.4 cv=Id+HWXqa c=1 sm=1 tr=0 ts=685adfb5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=usLT_vtIx6HESW-Kn04A:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: bflKLFau0d9AuXpkK44c6WgYRcgmJQfg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE0NCBTYWx0ZWRfX0pz7U+O/LEQK
 h5CTPUHXDPUU6Rbyb7vIgTsvFmx8OYHE5KMDX6MN/Xk+3odqIPcwRFDeN8uVlJRWfxmhY+Q5ppj
 h5HLyI7C6tj8BlJmiZ4xkY5xcOp0ToTwHshLtDXx7qrL1qy7B00ONXRPUazph1nG6Bv9z4pwK9h
 jZDky1h/VZdB7T3tSKdaq4yLNnLZo/05azPxAIt54GvHwFjtbJ35gbT5PEmw+beGO4Xd/ah8Lmi
 BqPJOo2VdJw+GxA06hSa8CXFaKtWyON7BfZnP3Z6zj1p8jTuyi6hgaFo5OTvsS5DIwJdtea+75v
 D1UgqLwYO/hs2wfvSBFJTDYBa3I2HAdBeucxQIobm2XpufNEqfotkeiWERvWKGIoO2+MSwp4p8L
 jNWdJNFembGBlhoGi71yuTPmLm2eFyk6FNesQgxR+4fUPnZLqWHgSwj/457mgEJDSm6maoP5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240144

On 6/24/2025 9:50 AM, Govind Singh wrote:
> This patch adds two module parameters to the ath12k PCI driver.

Please use imperative voice.
And it is preferential to first describe the problem, and then describe the
proposed solution.

> 
>  - ath12k_msi_mode: Allows selecting the MSI allocation mode.
>    * 0 = multi-vector MSI (default)
>    * 1 = single-vector MSI
> 
>  - ath12k_32bit_msi: Forces the use of 32-bit MSI addressing
>    by setting pdev->no_64bit_msi = 1 before IRQ vector allocation.
> 
> These options are useful for working around hardware or platform
> limitations(ex:  i.MX 8M Plus) where 64-bit MSI or multi-vector MSI
> allocations fails or cause stability issues.

So there is no way to detect this?

> 
> The original MSI allocation logic remains unchanged unless the
> parameters are explicitly set via modprobe or kernel boot options.
> 
> Tested-on: QCN9274 hw2.0 WLAN.WBE.1.4.1-00103-QCAHKSWPL_SILICONZ-1 with
>            i.MX 8M Plus SOC

Don't split tags, and need a blank line after Tested-on since it is an
ath-only tag, not an upstream tag

> Signed-off-by: Govind Singh <govind.sk85@gmail.com>
> ---
>  drivers/net/wireless/ath/ath12k/pci.c | 25 +++++++++++++++++++++----
>  drivers/net/wireless/ath/ath12k/pci.h |  5 +++++
>  2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
> index 1f3cfd9b89fd..4f58cb1e03f6 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c
> @@ -45,6 +45,14 @@
>  #define DOMAIN_NUMBER_MASK		GENMASK(7, 4)
>  #define BUS_NUMBER_MASK			GENMASK(3, 0)
>  
> +int ath12k_msi_mode;

should be static, make W=1 reports:
drivers/net/wireless/ath/ath12k/pci.c:48:5: warning: symbol 'ath12k_msi_mode'
was not declared. Should it be static?

> +module_param(ath12k_msi_mode, int, 0644);

why is this writable via sysfs?

> +MODULE_PARM_DESC(ath12k_msi_mode, "MSI mode: 0 = multi-vector (default), 1 = single-vector");
> +
> +bool ath12k_32bit_msi;

should be static, make W=1 reports:
drivers/net/wireless/ath/ath12k/pci.c:52:6: warning: symbol 'ath12k_32bit_msi'
was not declared. Should it be static?

> +module_param(ath12k_32bit_msi, bool, 0644);

why is this writable via sysfs?

> +MODULE_PARM_DESC(ath12k_32bit_msi, "Force 32-bit MSI addressing");
> +
>  static const struct pci_device_id ath12k_pci_id_table[] = {
>  	{ PCI_VDEVICE(QCOM, QCN9274_DEVICE_ID) },
>  	{ PCI_VDEVICE(QCOM, WCN7850_DEVICE_ID) },
> @@ -773,10 +781,19 @@ static int ath12k_pci_msi_alloc(struct ath12k_pci *ab_pci)
>  	int num_vectors;
>  	int ret;
>  
> -	num_vectors = pci_alloc_irq_vectors(ab_pci->pdev,
> -					    msi_config->total_vectors,
> -					    msi_config->total_vectors,
> -					    PCI_IRQ_MSI);
> +	/* Set 32-bit MSI flag early if requested */
> +	if (ath12k_32bit_msi)
> +		ab_pci->pdev->no_64bit_msi = 1;
> +
> +	/* Force single MSI mode if requested */
> +	if (ath12k_msi_mode == ATH12K_MSI_VEC_SINGLE) {
> +		num_vectors = -EINVAL; /* Force fallback path */
> +	} else {
> +		num_vectors = pci_alloc_irq_vectors(ab_pci->pdev,
> +						    msi_config->total_vectors,
> +						    msi_config->total_vectors,
> +						    PCI_IRQ_MSI);
> +	}
>  
>  	if (num_vectors == msi_config->total_vectors) {
>  		set_bit(ATH12K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags);
> diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
> index d1ec8aad7f6c..4fa8bb619cd9 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.h
> +++ b/drivers/net/wireless/ath/ath12k/pci.h
> @@ -92,6 +92,11 @@ enum ath12k_pci_flags {
>  	ATH12K_PCI_FLAG_MULTI_MSI_VECTORS,
>  };
>  
> +enum ath12k_msi_mode {
> +	ATH12K_MSI_VEC_AUTO = 0,
> +	ATH12K_MSI_VEC_SINGLE = 1,
> +};

I'd put this in pci.c since this is not part of an external driver interface
to pci.c

> +
>  struct ath12k_pci_ops {
>  	int (*wakeup)(struct ath12k_base *ab);
>  	void (*release)(struct ath12k_base *ab);


