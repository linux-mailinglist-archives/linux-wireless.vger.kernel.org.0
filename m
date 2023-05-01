Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6847D6F3ABB
	for <lists+linux-wireless@lfdr.de>; Tue,  2 May 2023 00:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjEAWyG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 May 2023 18:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEAWyF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 May 2023 18:54:05 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6897A212E
        for <linux-wireless@vger.kernel.org>; Mon,  1 May 2023 15:54:03 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341MqTRj021720
        for <linux-wireless@vger.kernel.org>; Mon, 1 May 2023 22:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1UD66VyOF7nEK4oDTH4oTq+AFXRZR4aF9DT16TIhgh0=;
 b=XYHEP+Yt5gwYxORYS8gir1SW5BVvS9vo2NpnosV7+YLjiQNCqQ6n5svm2JEZWW1/liDT
 aMFzF/ejmF0YCNg63NDuH8lKB9v97iffzhr7Ik/tvfZjLuCx2xqWUyYoKeny1CUHXJNq
 ixnh79DiVBCbhcyYKp50Oz7/9T5GoH7W8HAwSJUlP7SL6xoaAQC7mWGl5f/0zXY2Odpo
 6F75THhzWh5OA0lc7FYG60Tj+5IiLdb8JKJxv0PL6tHmA1YURA+ehGFJ4Sx1JZ6APK2B
 eGicqqxqmhwxvmw+sbvanMwDhVjqQ2WL6MEthjuHc6pD7MsZpP+c00Vnt8mhE7mCc598 BQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qaj3wgfmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 01 May 2023 22:54:02 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 341Ms1f8001110
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 1 May 2023 22:54:01 GMT
Received: from [10.48.241.223] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 1 May 2023
 15:53:59 -0700
Message-ID: <46871606-2240-be4d-6e9c-0d432adde843@quicinc.com>
Date:   Mon, 1 May 2023 15:53:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] ath11k: Add mac80211 based AQL support in ath11k
Content-Language: en-US
To:     Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
        <ath11k-review.external@qti.qualcomm.com>
CC:     <linux-wireless@vger.kernel.org>
References: <20230501130725.7171-1-quic_tamizhr@quicinc.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20230501130725.7171-1-quic_tamizhr@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j9Ft_YP_2U7XIKb-1yeTTIKP6MRCWwhj
X-Proofpoint-ORIG-GUID: j9Ft_YP_2U7XIKb-1yeTTIKP6MRCWwhj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_14,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305010184
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/1/2023 6:07 AM, Tamizh Chelvam Raja wrote:
> Add wake_tx_queue mac op to support AQL and support
> txq dequeueing from mac80211. Also implement a
> simple scheduler for pulling all skbs from txqs
> of all AC's at the end of tx completion NAPI.
> 

#1 rule of commit text: describe why

be sure describe any measured benefit


> Tested-on: IPQ5018 hw1.0 AHB WLAN.HK.2.6.0.1-00861-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath11k/dp_tx.c | 11 ++++
>   drivers/net/wireless/ath/ath11k/mac.c   | 70 ++++++++++++++++++++++---
>   drivers/net/wireless/ath/ath11k/mac.h   |  1 +
>   3 files changed, 76 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
> index 08a28464eb7a..bb1fed197707 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
> @@ -681,12 +681,14 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
>   	struct ath11k_dp *dp = &ab->dp;
>   	int hal_ring_id = dp->tx_ring[ring_id].tcl_comp_ring.ring_id;
>   	struct hal_srng *status_ring = &ab->hal.srng_list[hal_ring_id];
> +	bool mac_id_scheduled[MAX_RADIOS];
>   	struct sk_buff *msdu;
>   	struct hal_tx_status ts = { 0 };
>   	struct dp_tx_ring *tx_ring = &dp->tx_ring[ring_id];
>   	u32 *desc;
>   	u32 msdu_id;
>   	u8 mac_id;
> +	int i;
>   
>   	spin_lock_bh(&status_ring->lock);
>   
> @@ -751,6 +753,15 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
>   			wake_up(&ar->dp.tx_empty_waitq);
>   
>   		ath11k_dp_tx_complete_msdu(ar, msdu, &ts);
> +		mac_id_scheduled[mac_id] = true;
> +	}
> +
> +	/* Schedule remaining Tx packets for the radio */
> +	for (i = 0; i <  MAX_RADIOS; i++) {
> +		if (!mac_id_scheduled[i])
> +			continue;
> +		ar = ab->pdevs[i].ar;
> +		ath11k_mac_tx_push_pending(ar);
>   	}
>   }
>   
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index 1c93f1afccc5..4dc76b5ba77f 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -5907,9 +5907,9 @@ static int ath11k_mac_mgmt_tx(struct ath11k *ar, struct sk_buff *skb,
>   	return 0;
>   }
>   
> -static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
> -			     struct ieee80211_tx_control *control,
> -			     struct sk_buff *skb)
> +static void ath11k_mac_tx(struct ieee80211_hw *hw,
> +			  struct ieee80211_sta *sta,
> +			  struct sk_buff *skb)
>   {
>   	struct ath11k_skb_cb *skb_cb = ATH11K_SKB_CB(skb);
>   	struct ath11k *ar = hw->priv;
> @@ -5944,8 +5944,8 @@ static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
>   		return;
>   	}
>   
> -	if (control->sta)
> -		arsta = (struct ath11k_sta *)control->sta->drv_priv;
> +	if (sta)
> +		arsta = (struct ath11k_sta *)sta->drv_priv;
>   
>   	ret = ath11k_dp_tx(ar, arvif, arsta, skb);
>   	if (unlikely(ret)) {
> @@ -5954,6 +5954,62 @@ static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
>   	}
>   }
>   
> +static void ath11k_mac_schedule_txq(struct ieee80211_hw *hw, u32 ac)
> +{
> +	struct ieee80211_txq *txq;
> +	struct sk_buff *skb;
> +
> +	ieee80211_txq_schedule_start(hw, ac);
> +	while ((txq = ieee80211_next_txq(hw, ac))) {
> +		while ((skb = ieee80211_tx_dequeue_ni(hw, txq)))
> +			ath11k_mac_tx(hw, txq->sta, skb);
> +
> +		ieee80211_return_txq(hw, txq, false);
> +	}
> +	ieee80211_txq_schedule_end(hw, ac);
> +}
> +
> +void ath11k_mac_tx_push_pending(struct ath11k *ar)
> +{
> +	struct ieee80211_hw *hw = ar->hw;
> +	u32 ac;
> +
> +	rcu_read_lock();
> +	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
> +		ath11k_mac_schedule_txq(hw, ac);
> +
> +	rcu_read_unlock();
> +}
> +
> +static void ath11k_mac_op_wake_tx_queue(struct ieee80211_hw *hw,
> +					struct ieee80211_txq *txq)
> +{
> +	u8 ac;
> +	struct sk_buff *skb;
> +
> +	ac = txq->ac;
> +	ieee80211_txq_schedule_start(hw, ac);
> +	txq = ieee80211_next_txq(hw, ac);
> +
> +	if (!txq)
> +		goto out;
> +
> +	while ((skb = ieee80211_tx_dequeue_ni(hw, txq)))
> +		ath11k_mac_tx(hw, txq->sta, skb);
> +
> +	ieee80211_return_txq(hw, txq, false);
> +
> +out:
> +	ieee80211_txq_schedule_end(hw, ac);
> +}
> +
> +static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
> +			     struct ieee80211_tx_control *control,
> +			     struct sk_buff *skb)
> +{
> +	ath11k_mac_tx(hw, control->sta, skb);
> +}
> +
>   void ath11k_mac_drain_tx(struct ath11k *ar)
>   {
>   	/* make sure rcu-protected mac80211 tx path itself is drained */
> @@ -8763,7 +8819,7 @@ static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
>   
>   static const struct ieee80211_ops ath11k_ops = {
>   	.tx				= ath11k_mac_op_tx,
> -	.wake_tx_queue			= ieee80211_handle_wake_tx_queue,
> +	.wake_tx_queue			= ath11k_mac_op_wake_tx_queue,
>   	.start                          = ath11k_mac_op_start,
>   	.stop                           = ath11k_mac_op_stop,
>   	.reconfig_complete              = ath11k_mac_op_reconfig_complete,
> @@ -9263,6 +9319,8 @@ static int __ath11k_mac_register(struct ath11k *ar)
>   	    ab->hw_params.bios_sar_capa)
>   		ar->hw->wiphy->sar_capa = ab->hw_params.bios_sar_capa;
>   
> +	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_AQL);
> +
>   	ret = ieee80211_register_hw(ar->hw);
>   	if (ret) {
>   		ath11k_err(ar->ab, "ieee80211 registration failed: %d\n", ret);
> diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
> index 0231783ad754..15517e9a3408 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.h
> +++ b/drivers/net/wireless/ath/ath11k/mac.h
> @@ -175,4 +175,5 @@ int ath11k_mac_wait_tx_complete(struct ath11k *ar);
>   int ath11k_mac_vif_set_keepalive(struct ath11k_vif *arvif,
>   				 enum wmi_sta_keepalive_method method,
>   				 u32 interval);
> +void ath11k_mac_tx_push_pending(struct ath11k *ar);
>   #endif
> 
> base-commit: 12f167f02a1abe2c8817496a902de00758285b92

actual code change LGTM
