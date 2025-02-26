Return-Path: <linux-wireless+bounces-19449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99073A4528F
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 03:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1723A847F
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 01:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170E51A3150;
	Wed, 26 Feb 2025 01:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TR+Tplih"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4871019D081;
	Wed, 26 Feb 2025 01:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740535073; cv=none; b=LZwHOIMSZ5b0D42BRJ6zJwWen/gHUm4JVrKgQc6V7Nz0Ainue5D47rfEYuaE5maDdBGz8hv75BH1w1UGMzqtzWzPtzjb67eFRkmvc+MnGG54he9MjembTAomNJ/qzZFvk8tVUIElqCGLlLoieDU08cZfGHlULSSUbu8VnBPQNHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740535073; c=relaxed/simple;
	bh=QtPU3mcSJOWlTG5Pe7QWi4x4IEqPC/66/sfpTQTshJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ND7m00XOYzEZCcEzNXw3KeQNxL970W4XtM8qRHAru6cwzqaoVFMSV2pnEsFVtFCd+p7uFlIYahaOC33II6frCfbAfVu+aPlf03dVR+O0rz0T0UrEqK6vB9SPrqLxP6zucVdUMWny1CYEXkGYh/2MokH2Wg9rsTyyxDP5qi0f30A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TR+Tplih; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMX45T017692;
	Wed, 26 Feb 2025 01:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QAzt4AuPUvHXPA4JKMQmOna6qgcM/nN1LwMKvZwiKUM=; b=TR+TplihGFbKZXYB
	0+H1RIiLcPgjb/Ed1gGABdhWud4EKCUzwg9vEmqFDT0NQdB/NKhCfF95ugrKULMy
	fBoi8Mzo5cfT/e71ncLpe3Wk41stk4WuqzZaUzhS8ltZz4zAZl+mb6oaxBNqTxTy
	7lh9uOELh2234wbe2KlXEXR9Gj8h7rF5Bggu/gwHR42UrSW3wRgZrVuPl8x2AY6N
	S32BeDxOS6BsYvazIMp3Jqk1wmFhwZxnM1zwujqz1h0NXzjTvEVTpM7kmk81PyYT
	ZVngIwRDu9RdjMpelJFRDT/zYfzD2CnhTEyqbZX8iKRYs3PMPfyyW+e72FUU2jMs
	U3+6Sg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prn0c60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 01:57:44 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51Q1vbr3032160
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 01:57:37 GMT
Received: from [10.231.195.67] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Feb
 2025 17:57:35 -0800
Message-ID: <bff06390-08ce-4dac-87a9-4b4d142e78a4@quicinc.com>
Date: Wed, 26 Feb 2025 09:57:32 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] wifi: ath12k: Clear affinity hint before calling
 ath12k_pci_free_irq() in error path
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ath11k@lists.infradead.org>
References: <20250225053447.16824-1-manivannan.sadhasivam@linaro.org>
 <20250225053447.16824-3-manivannan.sadhasivam@linaro.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250225053447.16824-3-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9mUfSnrrBmFnZpA1aKGMDpmLKruxm2kA
X-Proofpoint-GUID: 9mUfSnrrBmFnZpA1aKGMDpmLKruxm2kA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260013



On 2/25/2025 1:34 PM, Manivannan Sadhasivam wrote:
> If a shared IRQ is used by the driver due to platform limitation, then the
> IRQ affinity hint is set right after the allocation of IRQ vectors in
> ath12k_pci_msi_alloc(). This does no harm unless one of the functions
> requesting the IRQ fails and attempt to free the IRQ.
> 
> This may end up with a warning from the IRQ core that is expecting the
> affinity hint to be cleared before freeing the IRQ:
> 
> kernel/irq/manage.c:
> 
> 	/* make sure affinity_hint is cleaned up */
> 	if (WARN_ON_ONCE(desc->affinity_hint))
> 		desc->affinity_hint = NULL;
> 
> So to fix this issue, clear the IRQ affinity hint before calling
> ath12k_pci_free_irq() in the error path. The affinity will be cleared once
> again further down the error path due to code organization, but that does
> no harm.
> 
> Fixes: a3012f206d07 ("wifi: ath12k: set IRQ affinity to CPU0 in case of one MSI vector")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/net/wireless/ath/ath12k/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
> index 06cff3849ab8..2851f6944b86 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c
> @@ -1689,6 +1689,8 @@ static int ath12k_pci_probe(struct pci_dev *pdev,
>  	return 0;
>  
>  err_free_irq:
> +	/* __free_irq() expects the caller to have cleared the affinity hint */
> +	ath12k_pci_set_irq_affinity_hint(ab_pci, NULL);
>  	ath12k_pci_free_irq(ab);
>  
>  err_ce_free:

Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>


