Return-Path: <linux-wireless+bounces-19410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1EDA4360C
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 08:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948743ADF5D
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 07:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800E523BD00;
	Tue, 25 Feb 2025 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U21nOR8x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10AC18A6BA;
	Tue, 25 Feb 2025 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740468201; cv=none; b=ZUvbrySWOayLUKZaTRfUonlXOjxBU6KTObZ1hTCub06/tGSSSygt6XOVryskHI6uBIDIcrz2qt8lSQmXowa0GIE7ik01AAOe2InCC0Bcc7jV0IaODw6a6NY67KYDGLNgDy6G8kydmFEOVqnF9OlLa9Ju7zMvM21yAjTmjBt64Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740468201; c=relaxed/simple;
	bh=h4bia+mYMyIlaxguzLk4TmwyvzKI/fME2tnOPYbHvqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dDTopnyyWCbN/varYS9WM3DlZzzE8b7FYWEruGPm2VQJp3pkpw+/MqivyQ7EvccKW8DxIYhythkSivYi2Uz8B+xgnCgZu0BaNjqJBmLQj2NgCGvIBcKwSKpNPjvSJxwHfxuKQ9TQEUSp5h4qfy5mmtNBdwzbLaDjbN/eQhyufRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U21nOR8x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OKOlvO014309;
	Tue, 25 Feb 2025 07:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N9GZ15BBI9v3KLlPyeqhB3Cuz7Tplf+rh37APLGCQ7c=; b=U21nOR8xwfoy5B+V
	Akntuznn5TNQCvlFLBhOSBChVateXLB+KGMyTnQYch69OkXPKfaVwLaQ6eV3GfjT
	18s1ufQcKrJVZs+6Ftgz5zJ5parwmbeI/F9zyujBw9JltIW1AW6gJna7LWvOPgVL
	aSucI3ITrZaSGXDyAf063iqPnOLQEdqLif3EW9+sqj9Jcd/3Zfh+gYXueHfC7Z4I
	vc5ffEs+hGc01cphla8yxqH8tyN+XYIFDbwdAg0swSqyY668qR3Nil9f5+Ea/uOl
	JNaLNdWozgPX+WcCHxq9lsRP30Cv4EubvuJ+OYiBd1C/eDBHkXw5Q35plIazq72O
	PRh4zQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y5wgr0xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 07:23:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51P7N9C9008828
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 07:23:09 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Feb
 2025 23:23:08 -0800
Message-ID: <4dc9e860-7417-480f-ba89-439498138d3f@quicinc.com>
Date: Tue, 25 Feb 2025 15:23:04 +0800
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
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3fDWGSD2xZucQUa23DR48OgTFkKynFOK
X-Proofpoint-ORIG-GUID: 3fDWGSD2xZucQUa23DR48OgTFkKynFOK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_02,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 adultscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250048



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

LGTM



