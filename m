Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB087DC3B5
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Oct 2023 01:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjJaAxc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 20:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjJaAxb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 20:53:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445D29C
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 17:53:29 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V0rOEX007852;
        Tue, 31 Oct 2023 00:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ERnmZZ+kbWTaRb4YrpvfOxOvNs5gASi7E3aCS8f7YKw=;
 b=OHlDAzPviRVmIMaRjK0BA0cajIEiAYSxs/Kkb3+cnuy5R7Z7NfkZD/dLwWeNslyGfnpq
 shHNP0CEtIY3WFMdgPLCzZ2rBqXgIAkDk9Tt1zawh5GUQdTguqAGlxu6Ryet/UCxTqvZ
 UA2uvDoll8Ne7/Z79u1hDrqX6AXoJ5JvPV/cPMpw3TaMIV/nW9k0OeOfgvcxOvRh3oe9
 cl80V/EpAv50Ph+1ImB2RSUWh09YaO5KokPwhM33R+CTJoR5+ojxO8wW1w0giv0/NxwF
 DO1aWdozi8jm4o8sN0nKjJLdp5wLdMdXQ+4gxjtppEYrSM4vbAfTkKga0NZlgvkw7CGn Ag== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2dey1dpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 00:53:24 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39V0rNkV027292
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 00:53:23 GMT
Received: from [10.48.245.206] (10.49.16.6) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 17:53:23 -0700
Message-ID: <b0ac4a51-9a24-443a-8155-6100d5e6b00f@quicinc.com>
Date:   Mon, 30 Oct 2023 17:53:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] wifi: ath12k: subscribe required word mask from rx
 tlv
Content-Language: en-US
To:     Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>,
        <ath12k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
References: <20231030222700.18914-1-quic_rajkbhag@quicinc.com>
 <20231030222700.18914-11-quic_rajkbhag@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231030222700.18914-11-quic_rajkbhag@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -1jOxPAobsV73W0WVC0eLadAxDxR7raE
X-Proofpoint-GUID: -1jOxPAobsV73W0WVC0eLadAxDxR7raE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2310240000 definitions=main-2310310006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/30/2023 3:26 PM, Raj Kumar Bhagat wrote:
> From: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> 
> Most of the RX descriptors fields are currently not used in the
> ath12k driver. Hence add support to selectively subscribe to the
> required quad words (64 bits) within msdu_end and mpdu_start of
> rx_desc.
> 
> Add compact rx_desc structures and configure the bit mask for Rx TLVs
> (msdu_end, mpdu_start, mpdu_end) via registers. With these registers
> SW can configure to DMA the partial TLV struct to Rx buffer.
> 
> Each TLV type has its own register to configure the mask value.
> The mask value configured in register will indicate if a particular
> QWORD has to be written to rx buffer or not i.e., if Nth bit is enabled
> in the mask Nth QWORD will be written and it will not be written if the
> bit is disabled in mask. While 0th bit indicates whether TLV tag will be
> written or not.
> 
> Advantages of Qword subscription of TLVs
> - Avoid multiple cache-line misses as the all the required fields
> of the TLV are within 128 bytes.
> - Memory optimization as TLVs + DATA + SHINFO can fit in 2k buffer
> even for 64 bit kernel.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Co-developed-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/dp.c      |   9 +
>   drivers/net/wireless/ath/ath12k/dp.h      |  13 +
>   drivers/net/wireless/ath/ath12k/dp_rx.c   |  16 +-
>   drivers/net/wireless/ath/ath12k/dp_tx.c   |  20 ++
>   drivers/net/wireless/ath/ath12k/hal.c     | 352 ++++++++++++++++++++++
>   drivers/net/wireless/ath/ath12k/hal.h     |   3 +
>   drivers/net/wireless/ath/ath12k/rx_desc.h | 112 ++++++-
>   drivers/net/wireless/ath/ath12k/wmi.h     |   2 +
>   8 files changed, 519 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
> index 80d7ce44d..faeef965e 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.c
> +++ b/drivers/net/wireless/ath/ath12k/dp.c
> @@ -1001,6 +1001,15 @@ void ath12k_dp_pdev_pre_alloc(struct ath12k_base *ab)
>   
>   void ath12k_dp_hal_rx_desc_init(struct ath12k_base *ab)
>   {
> +	if (test_bit(WMI_TLV_SERVICE_WMSK_COMPACTION_RX_TLVS, ab->wmi_ab.svc_map) &&
> +	    ab->hw_params->hal_ops->rxdma_ring_wmask_rx_mpdu_start &&
> +	    ab->hw_params->hal_ops->rxdma_ring_wmask_rx_msdu_end) {
> +		/* RX TLVS compaction is supported, hence change the hal_rx_ops
> +		 * based on device.
> +		 */
> +		if (ab->hal_rx_ops == &hal_rx_qcn9274_ops)
> +			ab->hal_rx_ops = &hal_rx_qcn9274_compact_ops;

I only have one comment on this patch.

in order to avoid chipset-specific logic here suggest that there should 
be an abstraction.

several ideas come to mind:
1) have a hal_ops callback to retrieve it
2) have a pointer to the compact ops in the hw_params

since we are already using hal_ops to get the masks, suggest that is 
where we should get the pointer to the compact ops

> +	}
>   	ab->hal.hal_desc_sz =
>   		ab->hal_rx_ops->rx_desc_get_desc_size();
>   }

