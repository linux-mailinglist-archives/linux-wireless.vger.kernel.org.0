Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C669572A5D
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 02:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiGMAsW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Jul 2022 20:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiGMAsV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Jul 2022 20:48:21 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9B1AEF60
        for <linux-wireless@vger.kernel.org>; Tue, 12 Jul 2022 17:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657673299; x=1689209299;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2rEVIR93nuJXdLLZy1ten/rGcolAL17PKYaChVThIaw=;
  b=mrGxzHpgHRtLVUQk9b09g3QLNdGFCYicdhafME2fIBu53NbJvFsque3D
   RCreTY5A6Y1AIyS5aPDsJ1uhlxUNQz0za67JeEMM9JhdJiOMLFJ/IQZnb
   t9m4vpBPZAFWdrmBkuzF2YjQGXv/af2yufZIRX8UzQH1Fn+rpfc1RCW4B
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Jul 2022 17:48:19 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 17:48:19 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Jul 2022 17:48:18 -0700
Received: from [10.110.97.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 12 Jul
 2022 17:48:18 -0700
Message-ID: <11aa90b3-86cb-044b-1c93-8e1ef34125be@quicinc.com>
Date:   Tue, 12 Jul 2022 17:48:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 09/12] nl80211: support advertising S1G rate information
Content-Language: en-US
To:     Kieran Frewen <kieran.frewen@morsemicro.com>,
        <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Bassem Dawood <bassem@morsemicro.com>
References: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
 <20220711010816.45927-10-kieran.frewen@morsemicro.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220711010816.45927-10-kieran.frewen@morsemicro.com>
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
> Add S1G rate information to netlink STA rate message.
> 
> Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
> Signed-off-by: Bassem Dawood <bassem@morsemicro.com>
> ---
>   include/uapi/linux/nl80211.h | 14 ++++++++++++++
>   net/wireless/nl80211.c       | 23 +++++++++++++++++++++++
>   2 files changed, 37 insertions(+)
> 
> diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
> index 71074332ccc5..19cf030004e9 100644
> --- a/include/uapi/linux/nl80211.h
> +++ b/include/uapi/linux/nl80211.h
> @@ -3539,6 +3539,13 @@ enum nl80211_eht_ru_alloc {
>    *	(u8, see &enum nl80211_eht_gi)
>    * @NL80211_RATE_INFO_EHT_RU_ALLOC: EHT RU allocation, if not present then
>    *	non-OFDMA was used (u8, see &enum nl80211_eht_ru_alloc)
> + * @NL80211_RATE_INFO_S1G_MCS: S1G MCS index (u8, 0-10)
> + * @NL80211_RATE_INFO_S1G_nss: S1G NSS value (u8, 1-4)

nit: s/nss/NSS/

> + * @NL80211_RATE_INFO_1_MHZ_WIDTH: 1 MHz S1G rate
> + * @NL80211_RATE_INFO_2_MHZ_WIDTH: 2 MHz S1G rate
> + * @NL80211_RATE_INFO_4_MHZ_WIDTH: 4 MHz S1G rate
> + * @NL80211_RATE_INFO_8_MHZ_WIDTH: 8 MHz S1G rate
> + * @NL80211_RATE_INFO_16_MHZ_WIDTH: 16 MHz S1G rate
>    * @__NL80211_RATE_INFO_AFTER_LAST: internal use
>    */
>   enum nl80211_rate_info {
> @@ -3565,6 +3572,13 @@ enum nl80211_rate_info {
>   	NL80211_RATE_INFO_EHT_NSS,
>   	NL80211_RATE_INFO_EHT_GI,
>   	NL80211_RATE_INFO_EHT_RU_ALLOC,
> +	NL80211_RATE_INFO_S1G_MCS,
> +	NL80211_RATE_INFO_S1G_NSS,
> +	NL80211_RATE_INFO_1_MHZ_WIDTH,
> +	NL80211_RATE_INFO_2_MHZ_WIDTH,
> +	NL80211_RATE_INFO_4_MHZ_WIDTH,
> +	NL80211_RATE_INFO_8_MHZ_WIDTH,
> +	NL80211_RATE_INFO_16_MHZ_WIDTH,
>   
>   	/* keep last */
>   	__NL80211_RATE_INFO_AFTER_LAST,
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 077dc2938551..70efed2b5899 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -6073,6 +6073,21 @@ bool nl80211_put_sta_rate(struct sk_buff *msg, struct rate_info *info, int attr)
>   		return false;
>   
>   	switch (info->bw) {
> +	case RATE_INFO_BW_1:
> +		rate_flg = NL80211_RATE_INFO_1_MHZ_WIDTH;
> +		break;
> +	case RATE_INFO_BW_2:
> +		rate_flg = NL80211_RATE_INFO_2_MHZ_WIDTH;
> +		break;
> +	case RATE_INFO_BW_4:
> +		rate_flg = NL80211_RATE_INFO_4_MHZ_WIDTH;
> +		break;
> +	case RATE_INFO_BW_8:
> +		rate_flg = NL80211_RATE_INFO_8_MHZ_WIDTH;
> +		break;
> +	case RATE_INFO_BW_16:
> +		rate_flg = NL80211_RATE_INFO_16_MHZ_WIDTH;
> +		break;

does it make sense to order these 1 2 4 5 8 10 16 20...

>   	case RATE_INFO_BW_5:
>   		rate_flg = NL80211_RATE_INFO_5_MHZ_WIDTH;
>   		break;
> @@ -6137,6 +6152,14 @@ bool nl80211_put_sta_rate(struct sk_buff *msg, struct rate_info *info, int attr)
>   		    nla_put_u8(msg, NL80211_RATE_INFO_HE_RU_ALLOC,
>   			       info->he_ru_alloc))
>   			return false;
> +	} else if (info->flags & RATE_INFO_FLAGS_S1G_MCS) {
> +		if (nla_put_u8(msg, NL80211_RATE_INFO_S1G_MCS, info->mcs))
> +			return false;
> +		if (nla_put_u8(msg, NL80211_RATE_INFO_S1G_NSS, info->nss))
> +			return false;
> +		if (info->flags & RATE_INFO_FLAGS_SHORT_GI &&
> +		    nla_put_flag(msg, NL80211_RATE_INFO_SHORT_GI))
> +			return false;
>   	} else if (info->flags & RATE_INFO_FLAGS_EHT_MCS) {
>   		if (nla_put_u8(msg, NL80211_RATE_INFO_EHT_MCS, info->mcs))
>   			return false;

