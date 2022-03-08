Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BA14D2528
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Mar 2022 02:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiCIBCA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Mar 2022 20:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCIBB7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Mar 2022 20:01:59 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA79265B59
        for <linux-wireless@vger.kernel.org>; Tue,  8 Mar 2022 16:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646786408; x=1678322408;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IEoS/jK3zy7gICSRHWJHcM1+R5lqEcfGSNouRgrKCgk=;
  b=CSXdGHysCKA+a0Pvw3bswhzbJ5gbp3tVeJ+3ma8pLx3EeQ1OqCiTnXuR
   ajKj+OE6S38+gfIQSzkbKl7H/BnPuV5cWih8GEpo/4bCJT1HQLuiIUnz6
   Z0d6D7gQfzyeUpw2CZq76OkwWkX7c8eet/oUk9xNXOmogNRA8y1N2fO+g
   E=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 08 Mar 2022 15:59:06 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 15:59:06 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 8 Mar 2022 15:59:05 -0800
Received: from [10.111.182.121] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Tue, 8 Mar 2022
 15:59:04 -0800
Message-ID: <f1ee04ce-3ac4-f68d-193a-25b09bd6cf41@quicinc.com>
Date:   Tue, 8 Mar 2022 15:59:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] mac80211: correct legacy rates check in
 ieee80211_calc_rx_airtime
Content-Language: en-US
To:     MeiChia Chiu <MeiChia.Chiu@mediatek.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
References: <20220308021645.16272-1-MeiChia.Chiu@mediatek.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220308021645.16272-1-MeiChia.Chiu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
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

On 3/7/2022 6:16 PM, MeiChia Chiu wrote:
> There are no legacy rates on 60GHz or sub-1Ghz band, so modify the check.

nit: s/Ghz/GHz/ here and in the code comment

> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
> ---
>   net/mac80211/airtime.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
> index 26d2f8ba7029..c0e58eb7c7fb 100644
> --- a/net/mac80211/airtime.c
> +++ b/net/mac80211/airtime.c
> @@ -477,7 +477,9 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
>   		bool sp = status->enc_flags & RX_ENC_FLAG_SHORTPRE;
>   		bool cck;
>   
> -		if (WARN_ON_ONCE(status->band > NL80211_BAND_5GHZ))
> +		/* on 60GHz or sub-1Ghz band, there are no legacy rates */
> +		if (WARN_ON_ONCE(status->band == NL80211_BAND_60GHZ ||
> +				 status->band == NL80211_BAND_S1GHZ))
>   			return 0;
>   
>   		sband = hw->wiphy->bands[status->band];

