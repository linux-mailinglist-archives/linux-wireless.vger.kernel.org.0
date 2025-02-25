Return-Path: <linux-wireless+bounces-19411-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E66FA43614
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 08:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F9F19C08E3
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2025 07:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A964C2566F1;
	Tue, 25 Feb 2025 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eNAu+RSu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1728023BD00;
	Tue, 25 Feb 2025 07:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740468283; cv=none; b=SSDex8nDZnhuOWPFUh5jvaF0IyURMaNI4+kuR6JBLD254vZZq/lrx2Q/tRok86ERVI94KkwZ+qqz5lx7U4idFv5Rg/wXXZAsH1A8GVtLOFLRCgTMTSIA45M0VAxbXW1UILwJsBZ9KnKODMLDtTOU7gtUUnQeUDDTFHgGgpt4E24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740468283; c=relaxed/simple;
	bh=xPTkrVD14GqbMw5CMiJ0/sUoOZEkb6f8OEG1R53w9PA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QjfEQOYI4ieP4bYez7kGwSdQrNaLYuG+iW/QNl2h8c9zEwdr/Rm9CqTunVunbtZbMwO+ndjSP8X56o83wr6IcmHTeOpHFKbXlc97cZNK0lc33Vmumf1DfIU/b+yaUp4F5r498kFKM8dpfzE+rojqn5h5+/JeGAz6rlOui1OuRkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eNAu+RSu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OKPD77018335;
	Tue, 25 Feb 2025 07:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tebw6SLuVv3C61Eg9fgpUebniUyjM/XHOUWR++DqaVs=; b=eNAu+RSudSuvybyG
	UytM6DbkEr9BzogQKb/Lw0g/cMxcaZUD3O0B3xZ0uoRiWOhpqFuiHLu1ySbRLp0M
	wgeNlgOwfNRp1xYSMGKplFfayxCUJ7jP8CmNGGyH1gB8ubnSlZw564hfPVi1I62o
	hrtBC3/T18NCWz2litO9RWdL76K3cc8JZuuohUOwV4+/T+aNjpHvtBSksucpFe0g
	wXjNsm10Nf89FpWC/crp5R1Km9kcaLIGgnv+EuJ2p0QfR3P6fciHlvTi2GIyCtcp
	0I42IEtDb68ZSPESR8lNzfWKR1BOSyaUky1aVpdTdM+3iFbGNUXtr8sAHhn4M77t
	vXzO6w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y5k682df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 07:24:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51P7OZPJ030329
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 07:24:35 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 24 Feb
 2025 23:24:33 -0800
Message-ID: <660b8c20-6ab5-4ce5-b1bb-43e78da96d72@quicinc.com>
Date: Tue, 25 Feb 2025 15:24:31 +0800
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZMA9E_kv7r_4Sr4cT_a0uZe1F9L8ceoH
X-Proofpoint-GUID: ZMA9E_kv7r_4Sr4cT_a0uZe1F9L8ceoH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_02,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250048



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

LGTM



