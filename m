Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3819357292B
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 00:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiGLWSz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Jul 2022 18:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiGLWSx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Jul 2022 18:18:53 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B8412D2F
        for <linux-wireless@vger.kernel.org>; Tue, 12 Jul 2022 15:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657664331; x=1689200331;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FVMK9AygpjQcLx4ESIo2P8KeYQjM+Y0zo7lAGOzDOhE=;
  b=r4XoJBLVn9REuH7lqOxaAnzs4CbzUkuFEoMd0qGH7fntiR2cEiKNqn3Q
   2ygWBtYpTkf/MMdFOhejk20qAP6HKC6C1xXS23iZ/NjnXwUkNbK0S8uO0
   xTwZeXCNNOWPWYVtI6qr9t/NUyTm514ec7wHygulXmbIjHMqi2/bNjUa4
   w=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 12 Jul 2022 15:18:50 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 15:18:50 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Jul 2022 15:18:50 -0700
Received: from [10.110.97.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 12 Jul
 2022 15:18:49 -0700
Message-ID: <d7951be2-30b4-c180-464d-4699fc153efa@quicinc.com>
Date:   Tue, 12 Jul 2022 15:18:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 06/12] mac80211: support ieee80211_ext format
Content-Language: en-US
To:     Kieran Frewen <kieran.frewen@morsemicro.com>,
        <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Bassem Dawood <bassem@morsemicro.com>
References: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
 <20220711010816.45927-7-kieran.frewen@morsemicro.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220711010816.45927-7-kieran.frewen@morsemicro.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/10/2022 6:08 PM, Kieran Frewen wrote:
> Ensure S1G beacons use the new ieee80211_ext format when required.
> 
> Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
> Signed-off-by: Bassem Dawood <bassem@morsemicro.com>
> ---
>   net/mac80211/rx.c | 24 +++++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
> index d017ad14d7db..feab1d58e932 100644
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> @@ -4772,6 +4772,7 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
>   	struct ieee80211_local *local = hw_to_local(hw);
>   	struct ieee80211_sub_if_data *sdata;
>   	struct ieee80211_hdr *hdr;
> +	struct ieee80211_ext *ext_hdr;
>   	__le16 fc;
>   	struct ieee80211_rx_data rx;
>   	struct ieee80211_sub_if_data *prev;
> @@ -4787,7 +4788,7 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
>   	if (ieee80211_is_data(fc) || ieee80211_is_mgmt(fc))
>   		I802_DEBUG_INC(local->dot11ReceivedFragmentCount);
>   
> -	if (ieee80211_is_mgmt(fc)) {
> +	if (ieee80211_is_mgmt(fc) || ieee80211_is_s1g_beacon(fc)) {
>   		/* drop frame if too short for header */
>   		if (skb->len < ieee80211_hdrlen(fc))
>   			err = -ENOBUFS;
> @@ -4802,13 +4803,16 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
>   		return;
>   	}
>   
> -	hdr = (struct ieee80211_hdr *)skb->data;
> +	if (ieee80211_is_s1g_beacon(fc))
> +		ext_hdr = (struct ieee80211_ext *)skb->data;
> +	else
> +		hdr = (struct ieee80211_hdr *)skb->data;

consider extracting the SA here instead of having conditional code in 
two places later?

>   	ieee80211_parse_qos(&rx);
>   	ieee80211_verify_alignment(&rx);
>   
> -	if (unlikely(ieee80211_is_probe_resp(hdr->frame_control) ||
> -		     ieee80211_is_beacon(hdr->frame_control) ||
> -		     ieee80211_is_s1g_beacon(hdr->frame_control)))
> +	if (unlikely(ieee80211_is_probe_resp(fc) ||
> +		     ieee80211_is_beacon(fc) ||
> +		     ieee80211_is_s1g_beacon(fc)))
>   		ieee80211_scan_rx(local, skb);
>   
>   	if (ieee80211_is_data(fc)) {
> @@ -4868,7 +4872,10 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
>   			continue;
>   		}
>   
> -		rx.sta = sta_info_get_bss(prev, hdr->addr2);
> +		if (ieee80211_is_s1g_beacon(fc))
> +			rx.sta = sta_info_get_bss(prev, ext_hdr->u.s1g_beacon.sa);
> +		else
> +			rx.sta = sta_info_get_bss(prev, hdr->addr2);
>   		rx.sdata = prev;
>   		ieee80211_prepare_and_rx_handle(&rx, skb, false);
>   
> @@ -4876,7 +4883,10 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
>   	}
>   
>   	if (prev) {
> -		rx.sta = sta_info_get_bss(prev, hdr->addr2);
> +		if (ieee80211_is_s1g_beacon(fc))
> +			rx.sta = sta_info_get_bss(prev, ext_hdr->u.s1g_beacon.sa);
> +		else
> +			rx.sta = sta_info_get_bss(prev, hdr->addr2);
>   		rx.sdata = prev;
>   
>   		if (ieee80211_prepare_and_rx_handle(&rx, skb, true))

