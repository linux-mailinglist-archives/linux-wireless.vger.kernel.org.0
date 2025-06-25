Return-Path: <linux-wireless+bounces-24455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510AFAE750B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 05:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C01083A6FB2
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 03:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B748F2AF0A;
	Wed, 25 Jun 2025 03:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gv0Luwcx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41C53074BF
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 03:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750820426; cv=none; b=hT3MmwIe6OkLq7HAhvUOMDfDBaZY7q/hFUqX/bmrVnd7UKAOJ7bi2MneZ7I48svhUrMCP/3+12WVi/ZDJbxhij3kP1APpPtpzt0l64HpindMCMGTzaKkeOQ+bHd/amfbHFxVWtuIE8kmDB+66FeTcB0S83yvoM7O1mDTPVBd+I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750820426; c=relaxed/simple;
	bh=tM8MWnmDPPBqkFkeHMmbgUWe5nT6VAJDCExImx/twMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZhPrvbX49e3DBg9WCZ96t4z6vsvf9M7o9VTPvh90OGcmNb0kX4P6kUJ2QnnTrmd5wZyjbeTsYo4WcNtJ5CdSPRGNCR1+AxWCICMz9wME0cboWhzUN3u/Hnkmcoe4f+c1c1uKYbJBidn/kUzAsfyfKfMTMvRcq8hW3Y/5wH5Wgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gv0Luwcx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OGAVBM014579
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 03:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/rGKfn836zR6g1TaHMmCprsxDY1nI2yMAFBUTp8Nr74=; b=gv0Luwcx2bM7oMD1
	8Bq72bU8TA/cvxEDGB2FEr8iqIenGWSES4PC3ax4OMVwIjsnAvRBQ2piQowLjdVy
	M6pq5EPe36mvX95yY9g2xoDrlyuVFsWbJQ1jh01H6JL/u3Q17D2qwPpoj8sZUiR4
	YppFbJjImj21c3V8Blcfw07yCCFNyYJdiAptmebDqFmze7ORj0VRDL7EkUwxWWyL
	ig4g3Eu7fGa/g68XnPBSvZUOiy1ZI45WiippnbmLq5d3+uDX89VRC96DbfL55VlN
	RrxpyZHy3OJ8corl28ePdtN4GV13LV32Xs8BsK7YVO1vM3ce4FupIARnZ4xpJa+w
	BJ2+/w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f2rpxhqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 03:00:23 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7394772635dso766646b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 20:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750820406; x=1751425206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rGKfn836zR6g1TaHMmCprsxDY1nI2yMAFBUTp8Nr74=;
        b=eDMgn8lTynTd8/xAZD4XskSAnyw6dqwBp9uDzI0qIQosdHScOV+CSvDaPsx60bbog/
         mLUvyh9fbMQZ+08c6NHv2DIVvhTTRBLSZX++qOJB2oL9uMaYt2tBUtnmlGcBy7nDUebC
         /+us3s5enqXX3+b2kd5V3Na4MtX0pcq2cEDWSrk9SEss7sMNzMNuAPIRlEnA7xHkw523
         mo8GdnQ8iNzh/etczUZgxeDcaEaUSLbKqjnNaJzAZlKgNX3UEq/l0Pyoj6yYJX8jFMex
         nkHJ/bDF/Ydbjn7u2uSy3iAZi+uApKe2U47JK0lzi3dkYQeNScNG3mSa7UzqvrihCnKQ
         LO4g==
X-Gm-Message-State: AOJu0Yw0mHhelBR/m6ap+KPbmbE0T9lNfWrduTkva4gZHBEl5+ID5qpg
	j/VhLbvjusWsgc6/CvPBi7z2nour4oNQDRy5fLTYHk2/3iCcQ8WGfkhGZ/VCnIlK9aK4qdqBkQD
	aAuZ0qFXZjA1QuUeiTgV7HUkEblTJ3OzwEnad9o5k+MIv6WfhVx3rpfC4P+fPZm7MnneiGgWu/G
	tJ43GT
X-Gm-Gg: ASbGncv22SLDMPY7xImv3WVPAQZlCWOEDOJTRjowWXEa67XkCVgcKL4OI7tpOBZoGc3
	U5ymDpyJspcQ8MzGoW1IpO+rGMfAPvJUfvUNm4sRZNV0G8io8E8zH954AA7JBVet1NPLNpnOYQR
	xeP9o2OMUAiaPAq2+cMVBLR2FAVZrQwhiX8XR98vOq9BMt98HyRxwoTpAdcwsUZxjxXCnk2U7Bl
	QMwPcINO1wWlu4L4ojZ4pPk5Lk2/Fo/rE+8dMvFxD5kEC6UQcHBi3CdmB4EHIHztvLNVyaIKzhz
	XW3eJt/03neRsiFmiEgt335taoWvNOBkxICbH9FPRHZfJE6smYJaM1EB3qamFqWCqfFLQlqyBUD
	gDJ1t66FHrFnKvg==
X-Received: by 2002:a05:6a00:4fc7:b0:736:3ea8:4805 with SMTP id d2e1a72fcca58-74ad44928aamr2199202b3a.7.1750820406579;
        Tue, 24 Jun 2025 20:00:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8k9nP5GC32oX80A92Zdm8o3QK+RIi2Isd9EdppCplGvcDb/h43dIjvxGmnkQdLJqMew/JfA==
X-Received: by 2002:a05:6a00:4fc7:b0:736:3ea8:4805 with SMTP id d2e1a72fcca58-74ad44928aamr2199167b3a.7.1750820406118;
        Tue, 24 Jun 2025 20:00:06 -0700 (PDT)
Received: from [10.133.33.71] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749c889113bsm3282794b3a.179.2025.06.24.20.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 20:00:05 -0700 (PDT)
Message-ID: <944ecdbe-d532-4871-8678-3cc44663d69a@oss.qualcomm.com>
Date: Wed, 25 Jun 2025 11:00:03 +0800
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
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <20250624165031.58616-1-govind.sk85@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=NdDm13D4 c=1 sm=1 tr=0 ts=685b6647 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=pGLkceISAAAA:8 a=vB2BEDJm9S744fNV2K8A:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAyMyBTYWx0ZWRfX8nRfMI99iUB7
 HDIkiF9y6QGDs4HZr44ppvfdNrxg0gjGVRZqOook4JWQ0U1iBXd8WgBTVhh7gVUfHo6QtACeokj
 qpv0iITjdftRzs8r800BNF8Y/eOGJxLb7WjKQRMkQPpDnuWNP9xNWZG2ywoXoyZe+pu2XUmCvDH
 qp/lVzRaxkUMyAIYloSwrejeDtoBv0S6DFSwdEbInXJMh509Qlow778fkQlfz+/YaFYNxBHEZh0
 tVFfwM0V7+A35ueTMB5gTBxcfPleJBGGPgwrzn+03/Y9X/atA02c2yFfb6btAlE3fIK3yprlTDV
 k4N/HmzQBclqsdsmv75FluRAp7/PhS6xED4d2sypKA9Y3KI9yUHUqytuwLR2molmtASj8HOqOHt
 nihpKiSjZSCMS40hAjdt55ojWv81bOR2aBwwJrITVePno6ob59hcyrUSE38fVSH3eHnnwQ5y
X-Proofpoint-ORIG-GUID: KUyHlaKLONwu41d85_CJcq34m9tLacdn
X-Proofpoint-GUID: KUyHlaKLONwu41d85_CJcq34m9tLacdn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 adultscore=0
 clxscore=1011 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250023



On 6/25/2025 12:50 AM, Govind Singh wrote:
> This patch adds two module parameters to the ath12k PCI driver.
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
> 
> The original MSI allocation logic remains unchanged unless the
> parameters are explicitly set via modprobe or kernel boot options.
> 
> Tested-on: QCN9274 hw2.0 WLAN.WBE.1.4.1-00103-QCAHKSWPL_SILICONZ-1 with
>            i.MX 8M Plus SOC
> Signed-off-by: Govind Singh <govind.sk85@gmail.com>

Like I commented in the Bugzilla, this is not a ath12k issue. Fix/workarounds need to go
to the PCIe controller driver, not its users.

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
> +module_param(ath12k_msi_mode, int, 0644);
> +MODULE_PARM_DESC(ath12k_msi_mode, "MSI mode: 0 = multi-vector (default), 1 = single-vector");
> +
> +bool ath12k_32bit_msi;
> +module_param(ath12k_32bit_msi, bool, 0644);
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
> +
>  struct ath12k_pci_ops {
>  	int (*wakeup)(struct ath12k_base *ab);
>  	void (*release)(struct ath12k_base *ab);


