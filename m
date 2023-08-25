Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62832788E35
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 20:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjHYSJI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 14:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjHYSIm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 14:08:42 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7081BF1
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 11:08:40 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PCOFEh022806;
        Fri, 25 Aug 2023 18:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iHLeDC1m8DLWKuV+osfpRI9zBnwrLabWLAMJV/ih81A=;
 b=gOAPaNsuZfR1tgXelpsaNKjo4+bZwJppu5Ubb82WSkN5zV+bemkWxD0hVjM/+s9RYu0E
 /mWE8PqayRmwxY2TzwwNa2E16JKvRO9daBWPUXY9eHNlAeKwj63QD20HSVloMtJUJ8/G
 viRixrYunDknGj0JZEZM7eScrdRxLcxAWuYeWacl2N3e3f5ZuRYtDHNkEy1mX/azSc6w
 TD/6+pC83ZQNNNhA2pjtobwrNlAiuCOjcoNVu2TkW5bE1UEx32cZTlk2ktKVJHnqu6AK
 F+oloPMYZiKBZvHeM66xDjH4/6f3FQ3p41+ioYj5odhDtwPQdcw17sUgdJ++PRLxlRpx cQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3spmtxsjfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 18:08:12 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37PI8BG9011710
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 18:08:11 GMT
Received: from [10.48.247.99] (10.49.16.6) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 25 Aug
 2023 11:08:10 -0700
Message-ID: <e94f5d18-ced0-458d-8e2c-b94a4196c442@quicinc.com>
Date:   Fri, 25 Aug 2023 11:08:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] wifi: mac80211: export ieee80211_tpt_led_trig_tx/rx
 for driver
Content-Language: en-US
To:     Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Benjamin Lin <benjamin-jw.lin@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
References: <09f0cb7f314a08eddb77298411d965ad30a847bb.1692983967.git.yi-chia.hsieh@mediatek.com>
 <8d18b7ac7fc394c310c0f2730da9ee7e955a9860.1692983967.git.yi-chia.hsieh@mediatek.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <8d18b7ac7fc394c310c0f2730da9ee7e955a9860.1692983967.git.yi-chia.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ksw7ild0_Q2i6DqlOvjdeIeQm3t1iOpM
X-Proofpoint-GUID: ksw7ild0_Q2i6DqlOvjdeIeQm3t1iOpM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_16,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250162
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/25/2023 10:47 AM, Yi-Chia Hsieh wrote:
> Whenever the H/W path is enabled and traffic is in the binding state,
> mac80211 is not aware of the traffic. Consequently, the LED does not
> blink for that reason.
> 
> The ieee80211_tpt_led_trig_tx/rx functions are exported for the driver
> so that we can report the tx and rx bytes from the driver when
> the H/W path is being used.
> 
> Signed-off-by: Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
> ---
>   include/net/mac80211.h | 17 +++++++++++++++++
>   net/mac80211/led.c     | 18 ++++++++++++++++++
>   net/mac80211/led.h     | 18 ------------------
>   net/mac80211/rx.c      |  2 +-
>   net/mac80211/tx.c      |  4 ++--
>   5 files changed, 38 insertions(+), 21 deletions(-)
> 
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index 3a8a2d2c58c3..53804822dc8d 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -4729,6 +4729,8 @@ __ieee80211_create_tpt_led_trigger(struct ieee80211_hw *hw,
>   				   unsigned int flags,
>   				   const struct ieee80211_tpt_blink *blink_table,
>   				   unsigned int blink_table_len);
> +void __ieee80211_tpt_led_trig_tx(struct ieee80211_hw *hw, int bytes);
> +void __ieee80211_tpt_led_trig_rx(struct ieee80211_hw *hw, int bytes);

suggest these should be in led.h since they are local to mac80211 and 
should not be directly invoked by clients of mac80211

>   #endif
>   /**
>    * ieee80211_get_tx_led_name - get name of TX LED
> @@ -4839,6 +4841,21 @@ ieee80211_create_tpt_led_trigger(struct ieee80211_hw *hw, unsigned int flags,
>   #endif
>   }
>   
> +static inline void
> +ieee80211_tpt_led_trig_tx(struct ieee80211_hw *hw, int bytes)
> +{
> +#ifdef CPTCFG_MAC80211_LEDS

why isn't this using CONFIG_MAC80211_LEDS??

> +	__ieee80211_tpt_led_trig_tx(hw, bytes);
> +#endif
> +}
> +
> +static inline void
> +ieee80211_tpt_led_trig_rx(struct ieee80211_hw *hw, int bytes)
> +{
> +#ifdef CPTCFG_MAC80211_LEDS
> +	__ieee80211_tpt_led_trig_rx(hw, bytes);
> +#endif
> +}
>   /**
>    * ieee80211_unregister_hw - Unregister a hardware device
>    *
> diff --git a/net/mac80211/led.c b/net/mac80211/led.c
> index 2dc732147e85..af03a2ef5c6a 100644
> --- a/net/mac80211/led.c
> +++ b/net/mac80211/led.c
> @@ -319,6 +319,24 @@ __ieee80211_create_tpt_led_trigger(struct ieee80211_hw *hw,
>   }
>   EXPORT_SYMBOL(__ieee80211_create_tpt_led_trigger);
>   
> +void __ieee80211_tpt_led_trig_tx(struct ieee80211_hw *hw, int bytes)
> +{
> +	struct ieee80211_local *local = hw_to_local(hw);
> +
> +	if (atomic_read(&local->tpt_led_active))
> +		local->tpt_led_trigger->tx_bytes += bytes;
> +}
> +EXPORT_SYMBOL(__ieee80211_tpt_led_trig_tx);
> +
> +void __ieee80211_tpt_led_trig_rx(struct ieee80211_hw *hw, int bytes)
> +{
> +	struct ieee80211_local *local = hw_to_local(hw);
> +
> +	if (atomic_read(&local->tpt_led_active))
> +		local->tpt_led_trigger->rx_bytes += bytes;
> +}
> +EXPORT_SYMBOL(__ieee80211_tpt_led_trig_rx);
> +

why are you making these exported implementations instead of keeping 
them as inline in led.h?

>   static void ieee80211_start_tpt_led_trig(struct ieee80211_local *local)
>   {
>   	struct tpt_led_trigger *tpt_trig = local->tpt_led_trigger;
> diff --git a/net/mac80211/led.h b/net/mac80211/led.h
> index d25f13346b82..98db4356d0de 100644
> --- a/net/mac80211/led.h
> +++ b/net/mac80211/led.h
> @@ -66,21 +66,3 @@ static inline void ieee80211_mod_tpt_led_trig(struct ieee80211_local *local,
>   {
>   }
>   #endif
> -
> -static inline void
> -ieee80211_tpt_led_trig_tx(struct ieee80211_local *local, int bytes)
> -{
> -#ifdef CONFIG_MAC80211_LEDS
> -	if (atomic_read(&local->tpt_led_active))
> -		local->tpt_led_trigger->tx_bytes += bytes;
> -#endif
> -}
> -
> -static inline void
> -ieee80211_tpt_led_trig_rx(struct ieee80211_local *local, int bytes)
> -{
> -#ifdef CONFIG_MAC80211_LEDS
> -	if (atomic_read(&local->tpt_led_active))
> -		local->tpt_led_trigger->rx_bytes += bytes;
> -#endif
> -}
> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
> index 4f707d2a160f..5747d7dac4d7 100644
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> @@ -5375,7 +5375,7 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
>   	if (skb) {
>   		if ((status->flag & RX_FLAG_8023) ||
>   			ieee80211_is_data_present(hdr->frame_control))
> -			ieee80211_tpt_led_trig_rx(local, skb->len);
> +			ieee80211_tpt_led_trig_rx(&local->hw, skb->len);

what is the rationale for changing the signature, especially given that 
the first thing the implementations do is local = hw_to_local(hw)

>   
>   		if (status->flag & RX_FLAG_8023)
>   			__ieee80211_rx_handle_8023(hw, pubsta, skb, list);
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
> index 7fe7280e8437..234de8d3b8bb 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -4320,7 +4320,7 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
>   	len = 0;
>    out:
>   	if (len)
> -		ieee80211_tpt_led_trig_tx(local, len);
> +		ieee80211_tpt_led_trig_tx(&local->hw, len);
>   	rcu_read_unlock();
>   }
>   
> @@ -4646,7 +4646,7 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
>   	sta->deflink.tx_stats.packets[queue] += skbs;
>   	sta->deflink.tx_stats.bytes[queue] += len;
>   
> -	ieee80211_tpt_led_trig_tx(local, len);
> +	ieee80211_tpt_led_trig_tx(&local->hw, len);
>   
>   	ieee80211_tx_8023(sdata, skb, sta, false);
>   

