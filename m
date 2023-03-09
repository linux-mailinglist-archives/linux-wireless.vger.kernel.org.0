Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9D96B1A42
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Mar 2023 05:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCIECm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 23:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCIECk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 23:02:40 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7336A046
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 20:02:38 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3293ZAFu029768;
        Thu, 9 Mar 2023 04:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JpsEkGIDIUXNRuynNTMJBdMb7l3qhUxc9N+yeE3K9ys=;
 b=bMOkDC/7/b1u1k72RQIZM+m6Vrf0g+9sd/pkuILFrN4uJhFl4V6uHoYEfVrGd2e+Ho5z
 FlDkTgb5EkMCNhrAEdtCwiXI/qYb4+/oLI4kYzSke/y1YGTioeW+NDWftujyFdTClX2o
 W87pCSu2OPbfzCUNyHoE2UWSdNkWU7AZo3D8DQgksrlxe0CGVadn1jegkXOFWwsT25Dm
 6WQ5FIIgSkvzz+gGg7D4Kh3EUSVbSm8UxiBMZhb9hIFaviuyaDfnCzii0gaktbx95z66
 yNEKVsuLYyR7n5/uIroaou3aONUQif5xcI/wmF14aRi/nSRH5nLVyxMntNk9+FA+7sC+ bQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6wcmhhcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 04:02:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32942WYi007011
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Mar 2023 04:02:32 GMT
Received: from [10.216.31.114] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 8 Mar 2023
 20:02:31 -0800
Message-ID: <57eeadc0-487a-5503-1312-ff90899b0eb5@quicinc.com>
Date:   Thu, 9 Mar 2023 09:32:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] wifi: ath11k: fix null ptr dereference when tx
 offload is enabled
Content-Language: en-US
To:     Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20230308174703.12270-1-quic_pradeepc@quicinc.com>
 <20230308174703.12270-2-quic_pradeepc@quicinc.com>
From:   Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20230308174703.12270-2-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cWoV0g-qwK5IyjgxgsD_8iiHVZiASrbX
X-Proofpoint-ORIG-GUID: cWoV0g-qwK5IyjgxgsD_8iiHVZiASrbX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_01,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090030
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 3/8/2023 11:17 PM, Pradeep Kumar Chitrapu wrote:
> When tx offload is enabled, info->band from skb cb is 0. This
> causes null pointer access at mac80211 when sband is accessed.
> 

More specifically tx encap offload instead of tx offload will be clearer.


> In offload case, ndo_hard_start will bypass mac80211 tx and no
> function will set info->band in skb cb to correct value.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01725-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath11k/dp_tx.c | 26 ++++++++++++++++++++++---
>   1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
> index 8afbba236935..0f3a32434970 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
> @@ -320,6 +320,8 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
>   	struct ieee80211_tx_info *info;
>   	struct ath11k_skb_cb *skb_cb;
>   	struct ath11k *ar;
> +	struct ieee80211_vif *vif;
> +	u8 flags = 0;

Is this initialization needed with the way flags is assigned below?

>   
>   	spin_lock(&tx_ring->tx_idr_lock);
>   	msdu = idr_remove(&tx_ring->txbuf_idr, ts->msdu_id);
> @@ -341,6 +343,14 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
>   
>   	dma_unmap_single(ab->dev, skb_cb->paddr, msdu->len, DMA_TO_DEVICE);
>   
> +	if (!skb_cb->vif) {
> +		dev_kfree_skb_any(msdu);
> +		return;
> +	}
> +
> +	flags = skb_cb->flags;
> +	vif = skb_cb->vif;
> +
>   	memset(&info->status, 0, sizeof(info->status));
>   
>   	if (ts->acked) {
> @@ -354,8 +364,10 @@ ath11k_dp_tx_htt_tx_complete_buf(struct ath11k_base *ab,
>   			info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
>   		}
>   	}
> -
> -	ieee80211_tx_status(ar->hw, msdu);
> +	if (flags & ATH11K_SKB_HW_80211_ENCAP)
> +		ieee80211_tx_status_8023(ar->hw, vif, msdu);
> +	else
> +		ieee80211_tx_status(ar->hw, msdu);
>   }
>   
>   static void
> @@ -524,6 +536,8 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
>   	struct ath11k_peer *peer;
>   	struct ath11k_sta *arsta;
>   	struct rate_info rate;
> +	struct ieee80211_vif *vif;
> +	u8 flags = 0;
>   

Same here on the initialization part.

>   	if (WARN_ON_ONCE(ts->buf_rel_source != HAL_WBM_REL_SRC_MODULE_TQM)) {
>   		/* Must not happen */
> @@ -544,6 +558,9 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
>   		return;
>   	}
>   
> +	flags = skb_cb->flags;
> +	vif = skb_cb->vif;
> +
>   	info = IEEE80211_SKB_CB(msdu);
>   	memset(&info->status, 0, sizeof(info->status));
>   
> @@ -610,7 +627,10 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
>   
>   	spin_unlock_bh(&ab->base_lock);
>   
> -	ieee80211_tx_status_ext(ar->hw, &status);
> +	if (flags & ATH11K_SKB_HW_80211_ENCAP)
> +		ieee80211_tx_status_8023(ar->hw, vif, msdu);
> +	else
> +		ieee80211_tx_status_ext(ar->hw, &status);
>   }
>   
>   static inline void ath11k_dp_tx_status_parse(struct ath11k_base *ab,


Vasanth
