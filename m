Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD76572965
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 00:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiGLWgl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Jul 2022 18:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiGLWgi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Jul 2022 18:36:38 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FB6C3AF2
        for <linux-wireless@vger.kernel.org>; Tue, 12 Jul 2022 15:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657665397; x=1689201397;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b5StrNq0fov/MHlGL3Nu9QLzP6AFGrzs9U+UdEvMI0Y=;
  b=BLdDzFUe/+qU7nOUs2QX2xKMbRT6FqKu/8a4JTrro/b02LD1sQD5SA9h
   B2DnV5cbJ2U+BGZFEYDU8Fb82CAGgZLHDZ72kzUx0uXoH59ZE8JBAZGMP
   L0cS+irXPxkGd81k8r6G/RTNcHVXAUow0Ps49DAjAPMWChCFCYltx6Oqm
   U=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 12 Jul 2022 15:36:37 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 15:36:37 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 12 Jul 2022 15:36:36 -0700
Received: from [10.110.97.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 12 Jul
 2022 15:36:35 -0700
Message-ID: <3a4bb32d-0863-0638-b503-f2e6604c7ec4@quicinc.com>
Date:   Tue, 12 Jul 2022 15:36:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 08/12] cfg80211: S1G rate flags
Content-Language: en-US
To:     Kieran Frewen <kieran.frewen@morsemicro.com>,
        <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Bassem Dawood <bassem@morsemicro.com>
References: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
 <20220711010816.45927-9-kieran.frewen@morsemicro.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220711010816.45927-9-kieran.frewen@morsemicro.com>
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
> Increase the size of S1G rate_info flags to support S1G. Add flags for new
> S1G bandwidths and S1G MCS.
> 
> Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
> Signed-off-by: Bassem Dawood <bassem@morsemicro.com>
> ---
>   include/net/cfg80211.h | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 7859b8b11968..47f71fb5d07a 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -1608,6 +1608,7 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
>    * @RATE_INFO_FLAGS_EDMG: 60GHz MCS in EDMG mode
>    * @RATE_INFO_FLAGS_EXTENDED_SC_DMG: 60GHz extended SC MCS
>    * @RATE_INFO_FLAGS_EHT_MCS: EHT MCS information
> + * @RATE_INFO_FLAGS_S1G_MCS: mcs field filled with S1G MCS

nit: s/mcs/MCS/

>    */
>   enum rate_info_flags {
>   	RATE_INFO_FLAGS_MCS			= BIT(0),
> @@ -1618,6 +1619,7 @@ enum rate_info_flags {
>   	RATE_INFO_FLAGS_EDMG			= BIT(5),
>   	RATE_INFO_FLAGS_EXTENDED_SC_DMG		= BIT(6),
>   	RATE_INFO_FLAGS_EHT_MCS			= BIT(7),
> +	RATE_INFO_FLAGS_S1G_MCS                 = BIT(8),
>   };
>   
>   /**
> @@ -1634,6 +1636,11 @@ enum rate_info_flags {
>    * @RATE_INFO_BW_HE_RU: bandwidth determined by HE RU allocation
>    * @RATE_INFO_BW_320: 320 MHz bandwidth
>    * @RATE_INFO_BW_EHT_RU: bandwidth determined by EHT RU allocation
> + * @RATE_INFO_BW_1: 1 MHz bandwidth
> + * @RATE_INFO_BW_2: 2 MHz bandwidth
> + * @RATE_INFO_BW_4: 4 MHz bandwidth
> + * @RATE_INFO_BW_8: 8 MHz bandwidth
> + * @RATE_INFO_BW_16: 16 MHz bandwidth
>    */
>   enum rate_info_bw {
>   	RATE_INFO_BW_20 = 0,
> @@ -1645,6 +1652,11 @@ enum rate_info_bw {
>   	RATE_INFO_BW_HE_RU,
>   	RATE_INFO_BW_320,
>   	RATE_INFO_BW_EHT_RU,
> +	RATE_INFO_BW_1,
> +	RATE_INFO_BW_2,
> +	RATE_INFO_BW_4,
> +	RATE_INFO_BW_8,
> +	RATE_INFO_BW_16,
>   };
>   
>   /**
> @@ -1667,7 +1679,7 @@ enum rate_info_bw {
>    *	only valid if bw is %RATE_INFO_BW_EHT_RU)
>    */
>   struct rate_info {
> -	u8 flags;
> +	u16 flags;
>   	u8 mcs;
>   	u16 legacy;
>   	u8 nss;

should we group legacy with flags so that the two u16s are adjacent?
note unfortunately we can't avoid padding

