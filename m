Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3173C4AE4FE
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Feb 2022 23:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiBHWxa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Feb 2022 17:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiBHWxJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Feb 2022 17:53:09 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F48C03C197
        for <linux-wireless@vger.kernel.org>; Tue,  8 Feb 2022 14:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644360377; x=1675896377;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qU1qz6roUZ7ozAy8ytwES+oh4BUikPDwHHJ8uQBq/sk=;
  b=cF1xq0NodXk4J7+jt0yNXMRzp1oCIAkNh8P072WPjp5VWiqJZkADzdCm
   8jpr2YBXObqq5X9tSQAn0+5CIJJ9tNohT9bhKkGK5Smy/ZVdAmuFLm8Df
   1yvJI6SV7yDfcjMPObnNK9yPG7017yvVfQ8eMmB3qWayz+K93nFBpmvEK
   8=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 08 Feb 2022 14:46:17 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 14:46:17 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 14:45:36 -0800
Received: from [10.48.246.62] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 8 Feb 2022
 14:45:36 -0800
Message-ID: <536bba7d-38f6-18ae-e09d-dfcd30f73f9d@quicinc.com>
Date:   Tue, 8 Feb 2022 14:45:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 09/14] mac80211: mlme: add documentation from spec to code
Content-Language: en-US
To:     Luca Coelho <luca@coelho.fi>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
References: <20220202084947.370289-1-luca@coelho.fi>
 <iwlwifi.20220202104617.f1bafd0861b7.I566612d99bca5245dc06cbcc70369b94a525389c@changeid>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <iwlwifi.20220202104617.f1bafd0861b7.I566612d99bca5245dc06cbcc70369b94a525389c@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
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

On 2/2/2022 12:49 AM, Luca Coelho wrote:
> From: Mordechay Goodstein <mordechay.goodstein@intel.com>
> 
> Reference the spec why we decline HE support in
> case STA don't support all HE basic rates recurred by AP.
> 
> Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>   net/mac80211/mlme.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index 291226a1599d..bf777943cacd 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -5052,7 +5052,15 @@ ieee80211_verify_sta_he_mcs_support(struct ieee80211_sub_if_data *sdata,
>   
>   			/*
>   			 * Make sure the HE AP doesn't require MCSs that aren't
> -			 * supported by the client
> +			 * supported by the client as required by spec
> +			 *
> +			 * P802.11-REVme/D0.3

curious why you reference a draft spec instead of referencing the 
approved IEEE Std 802.11ax™-2021

> +			 * 26.17.1 Basic HE BSS operation
> +			 *
> +			 * An HE STA shall not attempt to join * (MLME-JOIN.request primitive)
> +			 * a BSS, unless it supports (i.e., is able to both transmit and
> +			 * receive using) all of the <HE-MCS, NSS> tuples in the basic
> +			 * HE-MCS and NSS set.
>   			 */
>   			if (sta_rx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
>   			    sta_tx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||

