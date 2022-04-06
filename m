Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9DD4F6A44
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 21:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiDFTr7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 15:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbiDFTr0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 15:47:26 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50BE1B29CD
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649265522; x=1680801522;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lywqDxuFyq8jmISbZMF7nT/GLm9AppEw/b7NMOK6A8g=;
  b=A9z+VJhNJxR8VSHzzKIj8QgoHY8bIu4oBeTsNBOnUutj83E8cWIJeupq
   kgoPPtgU8+sEYjtKr/lJW4sMBuaX/DPVoPYSM85lPew9SqQknJYfAQDGh
   zemc57ao6r+ZmCvtGS8k5ok/3wWA94Ql0K/w3UU7Wxkm3gaYdNW9zbzM8
   8=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Apr 2022 10:18:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 10:18:41 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Apr 2022 10:18:41 -0700
Received: from [10.110.72.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 6 Apr 2022
 10:18:40 -0700
Message-ID: <907e5b13-ceaa-4ae3-9d61-a0a5d0eab20b@quicinc.com>
Date:   Wed, 6 Apr 2022 10:18:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/7] cfg80211: add a function for reporting TX status with
 hardware timestamps
Content-Language: en-US
To:     Luca Coelho <luca@coelho.fi>, <johannes@sipsolutions.net>,
        <kvalo@kernel.org>
CC:     <gregory.greenman@intel.com>, <linux-wireless@vger.kernel.org>
References: <20220406120924.979792-1-luca@coelho.fi>
 <iwlwifi.20220406145756.721e5cd5a682.I411bb8c79a26ffb33898bea2075f6779c7da0cb4@changeid>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <iwlwifi.20220406145756.721e5cd5a682.I411bb8c79a26ffb33898bea2075f6779c7da0cb4@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/6/2022 5:09 AM, Luca Coelho wrote:
> From: Avraham Stern <avraham.stern@intel.com>
> 
> Add a function for reporting TX status with hardware timestamps. This
> function shall be used for reporting the TX status of Timing
> measurement and Fine timing measurement action frames by devices that
> support reporting hardware timestamps.
> 
> Signed-off-by: Avraham Stern <avraham.stern@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>   include/net/cfg80211.h | 47 ++++++++++++++++++++++++++++++++++++++++--
>   net/wireless/nl80211.c | 42 ++++++++++++++++++++++++-------------
>   2 files changed, 73 insertions(+), 16 deletions(-)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 68713388b617..13c2ad88adb1 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -7574,6 +7574,38 @@ static inline bool cfg80211_rx_mgmt(struct wireless_dev *wdev, int freq,
>   				    flags);
>   }
>   
> +/**
> + * struct cfg80211_tx_status - TX status for management frame information
> + *
> + * @cookie: Cookie returned by cfg80211_ops::mgmt_tx()
> + * @tx_tstamp: hardware TX timestamp in nanoseconds
> + * @ack_tstamp: hardware ack RX timestamp in nanoseconds
> + * @buf: Management frame (header + body)
> + * @len: length of the frame data
> + * @ack: Whether frame was acknowledged
> + */
> +struct cfg80211_tx_status {
> +	u64 cookie;
> +	u64 tx_tstamp;
> +	u64 ack_tstamp;
> +	const u8 *buf;
> +	size_t len;
> +	bool ack;
> +};
> +
> +/**
> + * cfg80211_mgmt_tx_status_ext - TX status notification with extended info
> + * @wdev: wireless device receiving the frame
> + * @status: TX status data
> + * @gfp: context flags
> + *
> + * This function is called whenever a management frame was requested to be
> + * transmitted with cfg80211_ops::mgmt_tx() to report the TX status of the
> + * transmission attempt with extended info.
> + */
> +void cfg80211_mgmt_tx_status_ext(struct wireless_dev *wdev,
> +				 struct cfg80211_tx_status *status, gfp_t gfp);

can/should status be const?

snipping the rest, but consider for all cases where status is now passed 
as a struct pointer

/jeff
