Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4E65293AC
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 00:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbiEPWfr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 May 2022 18:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349686AbiEPWfm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 May 2022 18:35:42 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4F1111B
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 15:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652740541; x=1684276541;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NnmRvzGtSGsyKNBcTXKfWISWjiUoKXMH88ebcwW8HVk=;
  b=vf3HL5IaQoGMZDT/id2+FQC3fWYlXPzNLspCMhq/HGIJvWQVXIyFc2LG
   ZUlXYzcLT51WQPI3R28BgigkQiV/Ecp24fyCR7eEkrx7fLfIkaiajXDRm
   Kq1pxM4MICpcSeTBGfQZtxaQOx0qF52vw5D5y5qpiV8qpby1bK1WuveN0
   c=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 May 2022 15:35:40 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 15:35:40 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 16 May 2022 15:35:40 -0700
Received: from [10.110.66.23] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 16 May
 2022 15:35:39 -0700
Message-ID: <25c05c43-fae5-8d25-8f8a-73e6cb0c36a7@quicinc.com>
Date:   Mon, 16 May 2022 15:35:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC][PATCH] mac80211: fix VHT 160Mhz bandwidth when using
 extended NSS on PHY with NSS ratio
Content-Language: en-US
To:     <mbizon@freebox.fr>, Johannes Berg <johannes@sipsolutions.net>
CC:     linux-wireless <linux-wireless@vger.kernel.org>
References: <19cbe5dd1d7f0e194ed40c8db2cf2beffa3ae167.camel@freebox.fr>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <19cbe5dd1d7f0e194ed40c8db2cf2beffa3ae167.camel@freebox.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/16/2022 1:39 AM, Maxime Bizon wrote:
> 
> A PHY supporting 160Mhz with a reduced number of NSS may not have any

note correct abbreviation is: MHz
and it is suggested to use a space to separate the value from the units

> of the IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK bits set.
> 
> For exemple, the QCA9984 is 4x4, but can only do 2x2 VHT160 or

s/exemple/example/

> 80+80. The corresponding VHT capabilities should be:
>   - IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK == 0
>   - Extended NSS BW == 2
> 
> If we use that hardware in AP mode, and a 160Mhz 2x2 STA without NSS
> restriction connects to it, then that STA will set
> IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK to 1.
> 
> The usual logic of using bitwise-and with our own capabilities does
> not work here, the current code clears the SUPP_CHAN_WIDTH bits and
> resolve STA bandwidth to 80Mhz instead of 160Mhz, fix this.
> 
> Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
> ---
>   net/mac80211/vht.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
> index e856f9092137..7ef93adc4f24 100644
> --- a/net/mac80211/vht.c
> +++ b/net/mac80211/vht.c
> @@ -230,9 +230,11 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
>   	       sizeof(struct ieee80211_vht_mcs_info));
>   
>   	/* copy EXT_NSS_BW Support value or remove the capability */
> -	if (ieee80211_hw_check(&sdata->local->hw, SUPPORTS_VHT_EXT_NSS_BW))
> +	if (ieee80211_hw_check(&sdata->local->hw, SUPPORTS_VHT_EXT_NSS_BW)) {
> +		vht_cap->cap |= cap_info &
> +			IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
>   		vht_cap->cap |= (cap_info & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK);
> -	else
> +	} else

per the coding style when you use braces on any leg of if/else, use them 
on all legs

>   		vht_cap->vht_mcs.tx_highest &=
>   			~cpu_to_le16(IEEE80211_VHT_EXT_NSS_BW_CAPABLE);
>   

