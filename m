Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1072598F8D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Aug 2022 23:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243240AbiHRVbZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Aug 2022 17:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242000AbiHRVbX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Aug 2022 17:31:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659A1DD7
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 14:31:22 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IIYlPR029930;
        Thu, 18 Aug 2022 21:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UtpiCFcIG1LuHFj6d8UH6ONFJENGvTVbFYkQtu8I7V8=;
 b=Gpx+YozSMV+FXKuFWW9WNMtAVClRQjGqKdATEp8+R5T1bjMDCaUWd7cjj1nqa/XCo1do
 S2BF0gN9TZw+pRVWILViDLUaQ1R6at8Nku+d7JTJJsUSUUuY6uUBOrVoUlWS43pCiz5r
 YQOp6VEBoC0noD+DyB0jHtrVqTvkex3tnI9IEFcohomIiIWI5M1AqZ5OaT/9Zbih+mcw
 Es513b1SC4hwh2DnEhGSrQX8Zat4CYj1aiRfpoLwULxLNwqYJGC3DgC/w740o3TjiDuA
 HQA/LLhtqEacJhY5V0NeevtxrYG2TpSLgx9ONr3DBvS0uBGWdcR5KqTojE8sRu6bb5ug UA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j1ttq8e6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 21:31:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27ILVHSc026966
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 21:31:17 GMT
Received: from [10.110.11.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 18 Aug
 2022 14:31:16 -0700
Message-ID: <5babeb15-801d-b280-b8fc-c87ba980c9ff@quicinc.com>
Date:   Thu, 18 Aug 2022 14:31:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 29/50] wifi: ath12k: add hw.c
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC:     <ath12k@lists.infradead.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-30-kvalo@kernel.org>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220812161003.27279-30-kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9gGJIOCWoERf7AQbVQPAhRvxuiwYYul_
X-Proofpoint-ORIG-GUID: 9gGJIOCWoERf7AQbVQPAhRvxuiwYYul_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_16,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180077
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/12/2022 9:09 AM, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> (Patches split into one patch per file for easier review, but the final
> commit will be one big patch. See the cover letter for more info.)
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/hw.c | 961 +++++++++++++++++++++++++++++++++++
>   1 file changed, 961 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c

snip

> +static const struct ath12k_hw_ring_mask ath12k_hw_ring_mask_qcn9274 = {
> +	.tx  = {
> +		ATH12K_TX_RING_MASK_0,
> +		ATH12K_TX_RING_MASK_1,
> +		ATH12K_TX_RING_MASK_2,
> +		ATH12K_TX_RING_MASK_3,
> +	},
> +	.rx_mon_dest = {
> +		0, 0, 0,
> +		ATH12K_RX_MON_RING_MASK_0,
> +		ATH12K_RX_MON_RING_MASK_1,
> +		ATH12K_RX_MON_RING_MASK_2,
> +	},
> +	.rx = {
> +		0, 0, 0, 0,
> +		ATH12K_RX_RING_MASK_0,
> +		ATH12K_RX_RING_MASK_1,
> +		ATH12K_RX_RING_MASK_2,
> +		ATH12K_RX_RING_MASK_3,
> +	},
> +	.rx_err = {
> +		0, 0, 0,
> +		ATH12K_RX_ERR_RING_MASK_0,
> +	},
> +	.rx_wbm_rel = {
> +		0, 0, 0,
> +		ATH12K_RX_WBM_REL_RING_MASK_0,
> +	},
> +	.reo_status = {
> +		0, 0, 0,
> +		ATH12K_REO_STATUS_RING_MASK_0,
> +	},
> +	.host2rxdma = {
> +		0, 0, 0,
> +		ATH12K_HOST2RXDMA_RING_MASK_0,
> +	},
> +	.tx_mon_dest = {
> +		ATH12K_TX_MON_RING_MASK_0,
> +		ATH12K_TX_MON_RING_MASK_1,
> +		0, 0, 0, 0, 0, 0

nit: trailing 0s do not need to be specified
(none of the other initializers have them)


> +	},
> +};
> +
> +static const struct ath12k_hw_ring_mask ath12k_hw_ring_mask_wcn7850 = {
> +	.tx  = {
> +		ATH12K_TX_RING_MASK_0,
> +		ATH12K_TX_RING_MASK_2,
> +		ATH12K_TX_RING_MASK_4,
> +	},
> +
> +	.rx = {
> +		0, 0, 0,
> +		ATH12K_RX_RING_MASK_0,
> +		ATH12K_RX_RING_MASK_1,
> +		ATH12K_RX_RING_MASK_2,
> +		ATH12K_RX_RING_MASK_3,
> +	},
> +	.rx_err = {
> +		ATH12K_RX_ERR_RING_MASK_0,
> +	},
> +	.rx_wbm_rel = {
> +		ATH12K_RX_WBM_REL_RING_MASK_0,
> +	},
> +	.reo_status = {
> +		ATH12K_REO_STATUS_RING_MASK_0,
> +	},
> +
> +	.host2rxdma = {
> +	},

nit: add empty .rx_mon_dest & .tx_mon_dest initializers?

> +};
> +

snip
