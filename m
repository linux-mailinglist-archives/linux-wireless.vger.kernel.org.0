Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BC578D30E
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 07:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbjH3FzI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 01:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236134AbjH3Fy4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 01:54:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254321A6
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 22:54:54 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U5DKZa004167;
        Wed, 30 Aug 2023 05:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Tr2kQL3A0sK5eKz2dvL/1IHT5LYq1UvdjCs6ssqj0kg=;
 b=gKMI3zyZibMYydxc/V45A25bXxKV4MrZF/KcL3ueQQppXjhuEWRBYfR5USPUzF48FDkU
 G1CmK8Bq+inftSRTuPXhaOXaXzqdoXs0puJfQgSmtDawYKlQpUEfGAwFsuFDCgCAyHDL
 W7lvMyCl6yh7cr+2CZDrJi78Ezm5n3LKvb59Tfn9a6OgNlAVagxOjW+nr/Io2h/dxfZ8
 O6ibXboc/VMdv2HJtLMNAdm0YWyO+rndrc59YaTRr+8oxkyu55eqqZ8uJ7kmWXceUGs0
 bFyXGBHeN7pjWrPqAWwLPI2Efn1obcdqTWsxv/A0RUlBUYMVF9bRI1CxkvO0fku6vJ+w 5A== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ssv008e62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 05:54:47 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37U5ZHH9017472
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 05:35:17 GMT
Received: from [10.111.178.80] (10.49.16.6) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 29 Aug
 2023 22:35:17 -0700
Message-ID: <55a839a3-bfbd-43fc-b968-70d2a5bdee44@quicinc.com>
Date:   Tue, 29 Aug 2023 22:35:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix DMA unmap warning on NULL DMA address
Content-Language: en-US
To:     Baochen Qiang <quic_bqiang@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230830021131.5610-1-quic_bqiang@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230830021131.5610-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: J2hzwA-ng9Z0Ewv1G_aqq8gGrHNSASBS
X-Proofpoint-GUID: J2hzwA-ng9Z0Ewv1G_aqq8gGrHNSASBS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 mlxlogscore=845 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300055
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/29/2023 7:11 PM, Baochen Qiang wrote:
> In ath12k_dp_tx(), if we reach fail_dma_unmap due to some errors,
> current code does DMA unmap unconditionally on skb_cb->paddr_ext_desc.
> However, skb_cb->paddr_ext_desc may be NULL and thus we get below
> warning:
> 
> kernel: [ 8887.076212] WARNING: CPU: 3 PID: 0 at drivers/iommu/dma-iommu.c:1077 iommu_dma_unmap_page+0x79/0x90
> 
> Fix it by checking skb_cb->paddr_ext_desc before unmap it.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/ath12k/dp_tx.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
> index 8874c815d7fa..c0ae2fd443cc 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
> @@ -330,8 +330,10 @@ int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
>   
>   fail_unmap_dma:
>   	dma_unmap_single(ab->dev, ti.paddr, ti.data_len, DMA_TO_DEVICE);
> -	dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
> -			 sizeof(struct hal_tx_msdu_ext_desc), DMA_TO_DEVICE);
> +	if (skb_cb->paddr_ext_desc)
> +		dma_unmap_single(ab->dev, skb_cb->paddr_ext_desc,
> +				 sizeof(struct hal_tx_msdu_ext_desc),
> +				 DMA_TO_DEVICE);
>   
>   fail_remove_tx_buf:
>   	ath12k_dp_tx_release_txbuf(dp, tx_desc, pool_id);
> 
> base-commit: a62b0aeb556839fb6abb9835874443b08fe95598

