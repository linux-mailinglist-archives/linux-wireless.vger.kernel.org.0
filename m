Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CFD796FC6
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Sep 2023 07:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbjIGFGp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Sep 2023 01:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjIGFGo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Sep 2023 01:06:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5660ACF9
        for <linux-wireless@vger.kernel.org>; Wed,  6 Sep 2023 22:06:40 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3873ge8Z022931;
        Thu, 7 Sep 2023 05:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=HukxqxWHrUZQ7TU1b+xBA0YHyUoYCElN7dFjd/Qd59E=;
 b=PaE+3O1/kHBxRonpEnEVLdLIiVLKvfexYIgq3dOS5/w+9ong+Jyj6Dtqr+w1O+uXbquC
 hC3TtqB5v7MDoycqBufB84S8eshy2+sq2qFR+iGyjHF3H7lIFJ7eH4xXT7DYS7zy+vyw
 DZKX3dki/PLQKX0bG14f/3j5aGgKhchlB8xniWDNLatjNxMzlSWMSsfIETcRar1KakuS
 J95MNSI9zX4Zk+KYoyWor2+c6R6OJa83u3MKf4ukJtw5iwvTvJ5u4rqNl5hAhZmw6KmT
 gIlVBCjWoixbHEU8JXnWeQe71LoacigMdp7/U9kkEHZuxI7f5Z5Kt3cejBkn0YvNpLNC eQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sy4s7rc9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 05:06:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38756Y0v025067
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Sep 2023 05:06:34 GMT
Received: from [10.111.180.119] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 6 Sep
 2023 22:06:34 -0700
Message-ID: <ecdcae51-6f31-43f9-a7fd-299f20777263@quicinc.com>
Date:   Wed, 6 Sep 2023 22:06:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: fix boot failure with one MSI vector
Content-Language: en-US
To:     Baochen Qiang <quic_bqiang@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230907015606.16297-1-quic_bqiang@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230907015606.16297-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fx_K4Xtlp0hVYs9ejYuGMnC0gogXAgvv
X-Proofpoint-ORIG-GUID: fx_K4Xtlp0hVYs9ejYuGMnC0gogXAgvv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 adultscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309070043
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/6/2023 6:56 PM, Baochen Qiang wrote:
> Commit 5b32b6dd96633 ("ath11k: Remove core PCI references from
> PCI common code") breaks with one MSI vector because it moves
> affinity setting after IRQ request, see below log:
> 
> [ 1417.278835] ath11k_pci 0000:02:00.0: failed to receive control response completion, polling..
> [ 1418.302829] ath11k_pci 0000:02:00.0: Service connect timeout
> [ 1418.302833] ath11k_pci 0000:02:00.0: failed to connect to HTT: -110
> [ 1418.303669] ath11k_pci 0000:02:00.0: failed to start core: -110
> 
> The detail is, if do affinity request after IRQ activated,
> which is done in request_irq(), kernel caches that request and
> returns success directly. Later when a subsequent MHI interrupt is
> fired, kernel will do the real affinity setting work, as a result,
> changs the MSI vector. However at that time host has configured
> old vector to hardware, so host never receives CE or DP interrupts.
> 
> Fix it by setting affinity before registering MHI controller
> where host is, for the first time, doing IRQ request.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Tested-on: WCN6855 hw2.1 PCI 
WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-01160-QCAMSLSWPLZ-1

> 
> Fixes: 5b32b6dd9663 ("ath11k: Remove core PCI references from PCI common code")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
> v2:
>   rebase on latest ath.git due to v1 apply failure.
> 
>   drivers/net/wireless/ath/ath11k/pci.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
> index 9573bd959cac..aa049593f9b5 100644
> --- a/drivers/net/wireless/ath/ath11k/pci.c
> +++ b/drivers/net/wireless/ath/ath11k/pci.c
> @@ -852,10 +852,16 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
>   	if (ret)
>   		goto err_pci_disable_msi;
>   
> +	ret = ath11k_pci_set_irq_affinity_hint(ab_pci, cpumask_of(0));
> +	if (ret) {
> +		ath11k_err(ab, "failed to set irq affinity %d\n", ret);
> +		goto err_pci_disable_msi;
> +	}
> +
>   	ret = ath11k_mhi_register(ab_pci);
>   	if (ret) {
>   		ath11k_err(ab, "failed to register mhi: %d\n", ret);
> -		goto err_pci_disable_msi;
> +		goto err_irq_affinity_cleanup;
>   	}
>   
>   	ret = ath11k_hal_srng_init(ab);
> @@ -876,12 +882,6 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
>   		goto err_ce_free;
>   	}
>   
> -	ret = ath11k_pci_set_irq_affinity_hint(ab_pci, cpumask_of(0));
> -	if (ret) {
> -		ath11k_err(ab, "failed to set irq affinity %d\n", ret);
> -		goto err_free_irq;
> -	}
> -
>   	/* kernel may allocate a dummy vector before request_irq and
>   	 * then allocate a real vector when request_irq is called.
>   	 * So get msi_data here again to avoid spurious interrupt
> @@ -890,20 +890,17 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
>   	ret = ath11k_pci_config_msi_data(ab_pci);
>   	if (ret) {
>   		ath11k_err(ab, "failed to config msi_data: %d\n", ret);
> -		goto err_irq_affinity_cleanup;
> +		goto err_free_irq;
>   	}
>   
>   	ret = ath11k_core_init(ab);
>   	if (ret) {
>   		ath11k_err(ab, "failed to init core: %d\n", ret);
> -		goto err_irq_affinity_cleanup;
> +		goto err_free_irq;
>   	}
>   	ath11k_qmi_fwreset_from_cold_boot(ab);
>   	return 0;
>   
> -err_irq_affinity_cleanup:
> -	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
> -
>   err_free_irq:
>   	ath11k_pcic_free_irq(ab);
>   
> @@ -916,6 +913,9 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
>   err_mhi_unregister:
>   	ath11k_mhi_unregister(ab_pci);
>   
> +err_irq_affinity_cleanup:
> +	ath11k_pci_set_irq_affinity_hint(ab_pci, NULL);
> +
>   err_pci_disable_msi:
>   	ath11k_pci_free_msi(ab_pci);
>   
> 
> base-commit: 0263687f4441d5a5eab8074d56b4693c8f0acf85

