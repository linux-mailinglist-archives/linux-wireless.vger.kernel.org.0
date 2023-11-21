Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD897F223E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 01:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjKUAj0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 19:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjKUAjZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 19:39:25 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2386BE8
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 16:39:22 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AL0dIas025161;
        Tue, 21 Nov 2023 00:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UYQHJO+9MzRizXqGXRZYBR3tTonbEuTa3FsvgHofFgU=;
 b=IyckkaAukG8EjG85w4La1KiVJ2Qr9gueatb9XvuC9x2IxiraALMFZgCsvDzWT3P8Sp1Q
 B+MHlouSTtGzW4P1nVDm4QCu18/AnMlYquQtFp7Rc4/1eWbljJredTYjnJT4pWN0wh/5
 384IWuqHJyRz36IzUpguYpckmO/yPJwpe3l0J0iI5HForObozEdmlaqsIqmBu2yhUCmb
 tccHSONXTtqN59xvT4essprQg7NFQIEMcXUvWzHoneNaYY5wj243NocFtz7iEyJ+YIT0
 kdyWgHP9TWewJFLeM69MF0Pi623YupgHu0zSDQLqVI81qGsAhIA9QbvUZPm/2/v5diSu GA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ug26ttcym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 00:39:18 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AL0dHrr002921
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 00:39:17 GMT
Received: from [10.110.116.223] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 Nov
 2023 16:39:16 -0800
Message-ID: <66edb53d-edd8-4bdc-8573-2f7cf2f31c53@quicinc.com>
Date:   Mon, 20 Nov 2023 16:39:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] wifi: ath12k: add support one MSI vector
Content-Language: en-US
To:     Kang Yang <quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20231120101543.4369-1-quic_kangyang@quicinc.com>
 <20231120101543.4369-6-quic_kangyang@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231120101543.4369-6-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: v2pfS5GII4uWAllpcYGBZuNQRFREYn9k
X-Proofpoint-GUID: v2pfS5GII4uWAllpcYGBZuNQRFREYn9k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210001
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/20/2023 2:15 AM, Kang Yang wrote:
> On some platforms it's not possible to allocate 32 MSI vectors for
> various reasons, maybe kernel configuration, VT-d disabled, buggy BIOS
> etc. So ath12k was not able to use WCN7850 PCI devices on those
> platforms. Add support for one MSI vector to solve that.
> 
> In case of one MSI vector, interrupt migration needs to be disabled.
> This is because when interrupt migration happens, the msi_data may
> change. However, msi_data is already programmed to rings during initial
> phase and ath12k has no way to know that msi_data is changed during run
> time and reprogram again.
> 
> In case of one MSI vector, MHI subsystem should not use IRQF_NO_SUSPEND
> as WCN7850 doesn't set this flag too. Ath12k doesn't need to leave IRQ
> enabled in suspend state.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/mhi.c | 16 +++++++--
>  drivers/net/wireless/ath/ath12k/pci.c | 51 ++++++++++++++++++++-------
>  2 files changed, 52 insertions(+), 15 deletions(-)

...

> diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
> index 3bb2d622dc52..4484bac18f4e 100644
> --- a/drivers/net/wireless/ath/ath12k/pci.c
> +++ b/drivers/net/wireless/ath/ath12k/pci.c

...

> @@ -713,18 +731,26 @@ static int ath12k_pci_msi_alloc(struct ath12k_pci *ab_pci)
>  					    msi_config->total_vectors,
>  					    msi_config->total_vectors,
>  					    PCI_IRQ_MSI);
> -	if (num_vectors != msi_config->total_vectors) {
> -		ath12k_err(ab, "failed to get %d MSI vectors, only %d available",
> -			   msi_config->total_vectors, num_vectors);
>  
> -		if (num_vectors >= 0)
> -			return -EINVAL;
> -		else
> -			return num_vectors;
> -	} else {
> +	if (num_vectors == msi_config->total_vectors) {
>  		set_bit(ATH12K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags);
>  		ab_pci->irq_flags = IRQF_SHARED;
> +	} else {
> +		num_vectors = pci_alloc_irq_vectors(ab_pci->pdev,
> +						    1,
> +						    1,
> +						    PCI_IRQ_MSI);
> +		if (num_vectors < 0) {
> +			ret = -EINVAL;
> +			goto reset_msi_config;
> +		}
> +		clear_bit(ATH12K_PCI_FLAG_MULTI_MSI_VECTORS, &ab_pci->flags);
> +		ab_pci->msi_config = &msi_config_one_msi;
> +		ab_pci->irq_flags = IRQF_SHARED | IRQF_NOBALANCING;
> +		ath12k_dbg(ab, ATH12K_DBG_PCI, "request MSI one vector\n");
> +

ath12k-check is flagging this:
drivers/net/wireless/ath/ath12k/pci.c:761: Blank lines aren't necessary
before a close brace '}'
<
>  	}
> +	ath12k_info(ab, "MSI vectors: %d\n", num_vectors);
>  
>  	ath12k_pci_msi_disable(ab_pci);
>  

