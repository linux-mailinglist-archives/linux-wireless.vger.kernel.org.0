Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFA424828A
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Aug 2020 12:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHRKGv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Aug 2020 06:06:51 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:42158 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgHRKGu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Aug 2020 06:06:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597745210; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=g8scnZ99emGWW5FUbY1IqB77/PNnPh6KWmeHR03TRIM=;
 b=LkVURK84aowWESnR1k2FrPA+QJ0SKiyxiL7hTd20upF+r234mKUBBE5z/bibqzUR5Czvh4nR
 +1zjNF8tQeDHWwzvhfxjdPwvqc2bCa2pXvf1DK1NrHqnxP6w0JDo2hKX2psfDBzBf80DMI/n
 bflOm7pndQ7clkUxADK8CuC9SoE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f3ba82f1e4d3989d420164c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 Aug 2020 10:06:39
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6A715C433CA; Tue, 18 Aug 2020 10:06:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DB6B4C433C6;
        Tue, 18 Aug 2020 10:06:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 18 Aug 2020 15:36:38 +0530
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCHv2 3/4] ath10k: Add new api to support TID specific
 configuration
In-Reply-To: <20200817141934.733A0C433CB@smtp.codeaurora.org>
References: <1593875614-5683-4-git-send-email-tamizhr@codeaurora.org>
 <20200817141934.733A0C433CB@smtp.codeaurora.org>
Message-ID: <942a13405902460498184ef799f30581@codeaurora.org>
X-Sender: tamizhr@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

> 
>> This patch add ops for set_tid_config to support TID
>> specific configuration. Station specific TID configuration
>> will have more priority than vif specific TID configuration.
>> WMI_SERVICE_PEER_TID_CONFIGS_SUPPORT service flag introduced
>> to notify host for TID config support. And RTS_CTS extended tid
>> configuration support advertised through the service flag
>> WMI_10_4_SERVICE_EXT_PEER_TID_CONFIGS_SUPPORT.
>> 
>> TID specific noack configuration requires
>> aggregation should be disabled and rate for the data TID packets
>> should be basic rates. So, if the TID already configured
>> with noack policy then driver will ignore the aggregation
>> or TX rate related configuration for the same data TID.
>> 
>> In TX rate configuration should be applied with highest
>> preamble configuration(HT rates should not be applied
>> for the station which supports vht rates).
>> 
>> Tested-on: QCA9984 hw1.0 PCI 10.4-3.9.0.2-00021
>> 
>> Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> 
> There few checkpatch warnings which I fixed and also I did some 
> whitespace
> changes to improve readability. Others were trivial but please check 
> carefully
> this change and let me know if it's ok:
> 
Thanks for the cleanup. Change looks good to me.

> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -7089,6 +7089,7 @@ static void ath10k_sta_tid_cfg_wk(struct 
> work_struct *wk)
>         bool config_apply;
>         int ret, i;
>         u32 changed;
> +       u8 nss;
> 
>         arsta = container_of(wk, struct ath10k_sta, tid_config_wk);
>         sta = container_of((void *)arsta, struct ieee80211_sta, 
> drv_priv);
> @@ -7138,9 +7139,12 @@ static void ath10k_sta_tid_cfg_wk(struct 
> work_struct *wk)
> 
>                 if (changed & (BIT(NL80211_TID_CONFIG_ATTR_TX_RATE) |
>                     BIT(NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE))) {
> -                       if (arvif->rate_ctrl[i] >
> WMI_TID_CONFIG_RATE_CONTROL_AUTO &&
> -                           ath10k_mac_validate_rate_mask(ar, sta,
> arvif->rate_code[i],
> -
> ATH10K_HW_NSS(arvif->rate_code[i]))) {
> +                       nss = ATH10K_HW_NSS(arvif->rate_code[i]);
> +                       ret = ath10k_mac_validate_rate_mask(ar, sta,
> +                                                           
> arvif->rate_code[i],
> +                                                           nss);
> +                       if (ret &&
> +                           arvif->rate_ctrl[i] >
> WMI_TID_CONFIG_RATE_CONTROL_AUTO) {
>                                 arg.rate_ctrl = 0;
>                                 arg.rcode_flags = 0;
>                         }

Tamizh.
