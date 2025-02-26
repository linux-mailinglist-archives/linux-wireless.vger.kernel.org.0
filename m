Return-Path: <linux-wireless+bounces-19448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45517A45279
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 02:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435FF176BE7
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 01:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BF3383A5;
	Wed, 26 Feb 2025 01:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ejyXS7gx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBFAEBE;
	Wed, 26 Feb 2025 01:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535003; cv=none; b=j17t3YL+1DZoyyANz0cll2A5ndXCmta0DX2hTU5huZ1GFvjlw6/5wY0HqdhIEeW6UYNz2gMBwyX650ezhKflnKOPlI9ar/ixudcXdXh2f3lCzji8zbhkHDF8RiNzDpGWWCaTDNXNkLRFdWxUnfmeUF/QrvZLIgKhmLWSkwiXjb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535003; c=relaxed/simple;
	bh=RSeGTVc9uBDKd744DoAdIrG+MrqAx8bj6Fr4Q3FGl+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NDVJyXLOW+Z7Y8H3MUtJiwc2k+Y+LKjNZHCWJJApnzbklwt/SDPQLpu5BO2lbhhoZsXua9GM52MfesIYDTxgaNXlVY1bcOIrrGebD3ZpyLZXXyIMnAviicghLv1UA37Zw8S6/vxHxpRm72ob2zC67Ge8BeqnX+2BFbtaLOn3Re4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ejyXS7gx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMWsHa007454;
	Wed, 26 Feb 2025 01:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nkdabU7qyv7CkhotreBergtJRVj196HcN164i5DlU2Y=; b=ejyXS7gx//NQ4YlP
	9Cb0QEg2ijEMzP6lez9JUGuR1RJ0QTvk6lppYWmzwKlHUPaY6gjlgGxlYvtLM00K
	Jg80ixPGJJS16w/NunOjQcW9ZjVyTyUziSU7PexqjjxU+Xh9DzKWtmjjbdo6H86F
	z8GshDInsbHY4EVsBhULi6rw1bGzh1OPOmwxMDOvrocrVC9E2pXnjSAD07pcNkuT
	eYpNS9QIS2e9M5imf2C+KGWW4ry9I8L30+ddF74/p1u0hapql2E71uOS5gPjdtVB
	BCoikG+4YH2JAoAWG8XUUv1G93V3640eIpAi47h55L5KL5Wx2EMVSINE773qYdIV
	NXeNlQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prmrbyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 01:56:36 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51Q1uaG6030767
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 01:56:36 GMT
Received: from [10.231.195.67] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Feb
 2025 17:56:34 -0800
Message-ID: <8579334b-7b95-4b2a-b022-b121422cc48b@quicinc.com>
Date: Wed, 26 Feb 2025 09:56:30 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] wifi: ath11k: Clear affinity hint before calling
 ath11k_pcic_free_irq() in error path
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ath11k@lists.infradead.org>
References: <20250225053447.16824-1-manivannan.sadhasivam@linaro.org>
 <20250225053447.16824-2-manivannan.sadhasivam@linaro.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250225053447.16824-2-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2VlwqJ6MmK0YVPmeXe0ZPEaz9OPJk6NG
X-Proofpoint-ORIG-GUID: 2VlwqJ6MmK0YVPmeXe0ZPEaz9OPJk6NG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502260012



On 2/25/2025 1:34 PM, Manivannan Sadhasivam wrote:
> If a shared IRQ is used by the driver due to platform limitation, then the
> IRQ affinity hint is set right after the allocation of IRQ vectors in
> ath11k_pci_alloc_msi(). This does no harm unless one of the functions
> requesting the IRQ fails and attempt to free the IRQ. This results in the
> below warning:
> 
> WARNING: CPU: 7 PID: 349 at kernel/irq/manage.c:1929 free_irq+0x278/0x29c
> Call trace:
>  free_irq+0x278/0x29c
>  ath11k_pcic_free_irq+0x70/0x10c [ath11k]
>  ath11k_pci_probe+0x800/0x820 [ath11k_pci]
>  local_pci_probe+0x40/0xbc
> 
> The warning is due to not clearing the affinity hint before freeing the
> IRQs.
> 
> So to fix this issue, clear the IRQ affinity hint before calling
> ath11k_pcic_free_irq() in the error path. The affinity will be cleared once
> again further down the error path due to code organization, but that does
> no harm.
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-05266-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Cc: Baochen Qiang <quic_bqiang@quicinc.com>
> Fixes: 39564b475ac5 ("wifi: ath11k: fix boot failure with one MSI vector")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/net/wireless/ath/ath11k/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
> index b93f04973ad7..eaac9eabcc70 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> @@ -939,6 +939,8 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
>  	return 0;
>  
>  err_free_irq:
> +	/* __free_irq() expects the caller to have cleared the affinity hint */
> +	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
>  	ath11k_pcic_free_irq(ab);
>  
>  err_ce_free:

Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>


