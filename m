Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24041404220
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Sep 2021 02:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244457AbhIIAO5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Sep 2021 20:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241998AbhIIAO4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Sep 2021 20:14:56 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB909C061575
        for <linux-wireless@vger.kernel.org>; Wed,  8 Sep 2021 17:13:47 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 17so4115pgp.4
        for <linux-wireless@vger.kernel.org>; Wed, 08 Sep 2021 17:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vUUGUB8wZRHoH4SgIuayENReTrwgu7B0VDsfiX/HdF0=;
        b=YMs9Bx0kzIMWVZ9oH3oAGkK39WL/7503eObnL3BfgxJ/pPowq3CKfssXzZhYDvzcik
         qsO3WyXJtJ15tVy+KaJpLZEKDJC3bDee7tDfUVTT+hlzl/kuCiUehiDWKQn0y4Mjq6QQ
         joaLQCwydXE9zgH1f/lTApAJflKyXUps/7EkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vUUGUB8wZRHoH4SgIuayENReTrwgu7B0VDsfiX/HdF0=;
        b=Xn7Chy0PtaDGpfl41ZGGoSTjrBVMZMcCPzCFfrAlHPEY43IlPn8i78YSUtGXZFPlgj
         J9EMVFRx8Kh4jGZBnM/P26s4FE/IprbtHsql7J4wvwWqe6yQ2hxXtgyUVvFpV2+vJuiI
         aKI+La4tAj38rUleH0HZ6Jf8vrQz8vvAKG3j2ipEbrnOp9TfbnnoHDyfWUWvQJJOpIBj
         GzW+7TzrxVYfki2LZovBJerOOXWPRSEtLvk8VvKTgF9SvgBY5EuDC16z5Yi5Q4wqzDtO
         yKLgWtgxmX0QBGXRWXurQWDN0tsADwwZsr/bLf/FS+F6huP7ydG5saJC6UXTJKukEjBZ
         UXhg==
X-Gm-Message-State: AOAM531XJbU+5CBLBA5wL8hKdXPV9VISaVJIyRngP0kN674rebL0DOUn
        icXYA8Pm0Du4NLQewXwYgTwh9lxzP6mxTg==
X-Google-Smtp-Source: ABdhPJxk11iMRX/L/0f74glHsYXmnFjTePAVGdC25/7VCiaoPVCnx2gtpY1UHYgmfXmqiSp/4lJRGA==
X-Received: by 2002:a62:d104:0:b0:3ee:46b:d4ed with SMTP id z4-20020a62d104000000b003ee046bd4edmr337614pfg.38.1631146426945;
        Wed, 08 Sep 2021 17:13:46 -0700 (PDT)
Received: from benl-m5lvdt.local ([2600:6c50:4d00:2376:c1a7:174b:ee10:7091])
        by smtp.gmail.com with ESMTPSA id m18sm24139pjq.32.2021.09.08.17.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 17:13:46 -0700 (PDT)
Subject: Re: [PATCH 1/2] wcn36xx: Fix Antenna Diversity Switching
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org
References: <20210908133019.2408092-1-bryan.odonoghue@linaro.org>
 <20210908133019.2408092-2-bryan.odonoghue@linaro.org>
From:   Benjamin Li <benl@squareup.com>
Message-ID: <8d991c9d-083a-2ad0-0ce3-d214639dfbdd@squareup.com>
Date:   Wed, 8 Sep 2021 17:13:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210908133019.2408092-2-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/8/21 6:30 AM, Bryan O'Donoghue wrote:
> We have been tracking a strange bug with Antenna Diversity Switching (ADS)
> on wcn3680b for a while.
> 
> ADS is configured like this:
>    A. Via a firmware configuration table baked into the firmware binary.

in the NV, not the firmware binary

>        1. Defines if ADS is enabled.
>        2. Defines which GPIOs are connected to which antenna enable pin.
>        3. Defines which antenna/GPIO is primary and which is secondary.
> 
>    B. WCN36XX_CFG_VAL(ANTENNA_DIVERSITY, N)
>       N is a bitmask of available antenna.
> 
>       Setting N to 3 indicates a bitmask of enabled antenna (1 | 2).
> 
>       Obviously then we can set N to 1 or N to 2 to fix to a particular
>       antenna and disable antenna diversity.
> 
>    C. WCN36XX_CFG_VAL(ASD_PROBE_INTERVAL, XX)
>       XX is the number of beacons between each antenna RSSI check.
>       Setting this value to 50 means, every 50 received beacons, run the
>       ADS algorithm.
> 
>    D. WCN36XX_CFG_VAL(ASD_TRIGGER_THRESHOLD, YY)
>       YY is a two's complement integer which specifies the RSSI decibel
>       threshold below which ADS will run.
>       We default to -60db here, meaning a measured RSSI <= -60db will
>       trigger an ADS probe.
> 
>    E. WCN36XX_CFG_VAL(ASD_RTT_RSSI_HYST_THRESHOLD, Z)
>       Z is a hysteresis value, indicating a delta which the RSSI must
>       exceed for the antenna switch to be valid.
> 
>       For example if HYST_THRESHOLD == 3 AntennaId1-RSSI == -60db and
>       AntennaId-2-RSSI == -58db then firmware will not switch antenna.
>       The threshold needs to be -57db or better to satisfy the criteria.

Maybe also worth mentioning there's a feat_cap for
ANTENNA_DIVERSITY_SELECTION, although from what we saw FW doesn't actually
check it.

> 
> ADS works like this:
> 
>     A. Every XX beacons the firmware switches to or remains on the primary
>        antenna.
> 
>     B. The firmware then sends a Request-To-Send (RTS) packet to the AP.
> 
>     C. The firmware waits for a Clear-To-Send (CTS) response from the AP.
> 
>     D. The firmware then notes the received RSSI on the CTS packet.
> 
>     E. The firmware then repeats steps A-D on the secondary antenna.
> 
>     F. Subsequently if the measured RSSI on the primary or secondary
>        antenna is better than ASD_TRIGGER_THRESHOLD +

better than the active antenna's RSSI +

>        ASD_RTT_RSSI_HYST_THRESHOLD then that antenna becomes the active
>        antenna.
> 
>     G. If RSSI rises past ASD_TRIGGER_THRESHOLD then ADS doesn't run at
>        all even if there is a substantially better RSSI on the other
>        antenna.
> 
> What we have been observing is that the RTS packet is being sent but the
> MAC address is a byte-swapped version of the target MAC. The ADS/RTS MAC is
> corrupted only when the link is encrypted, if the AP is open the RTS MAC is
> correct. Similarly if we configure the firmware to an RTS/CTS sequence for
> regular data - the transmitted RTS MAC is correctly formatted.
> 
> Internally the wcn36xx firmware uses the indexes in the SMD commands to
> populate and extract data from specific entries in an STA lookup table. The
> AP's MAC appears a number of times in different indexes within this lookup
> table, so the MAC address extracted for the data-transmit RTS and the MAC
> address extracted for the ADS/RTS packet are not the same STA table index.
> 
> Our analysis indicates the relevant firmware STA table index is
> "bssSelfStaIdx".
> 
> There is an STA populate function responsible for formatting the MAC
> address of the bssSelfStaIdx including byte-swapping the MAC address.
> 
> Its clear then that the required STA populate command did not run for
> bssSelfStaIdx.
> 
> So taking a look at the sequence of SMD commands sent to the firmware we
> see the following downstream when moving from an unencrypted to encrypted
> BSS setup.
> 
> - WLAN_HAL_CONFIG_BSS_REQ
> - WLAN_HAL_CONFIG_STA_REQ
> - WLAN_HAL_SET_STAKEY_REQ
> 
> Upstream in wcn36xx we have
> 
> - WLAN_HAL_CONFIG_BSS_REQ
> - WLAN_HAL_SET_STAKEY_REQ
> 
> The solution then is to add the missing WLAN_HAL_CONFIG_STA_REQ between
> WLAN_HAL_CONFIG_BSS_REQ and WLAN_HAL_SET_STAKEY_REQ.
> 
> No surprise WLAN_HAL_CONFIG_STA_REQ is the routine responsible for
> populating the STA lookup table in the firmware and once done the MAC sent
> by the ADS routine is in the correct byte-order.
> 
> This bug is apparent with ADS but it is also the case that any other
> firmware routine that depends on the "bssSelfStaIdx" would retrieve
> malformed data on an encrypted link.
> 
> Fixes: 3e977c5c523d ("wcn36xx: Define wcn3680 specific firmware parameters")
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/net/wireless/ath/wcn36xx/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
> index 2ccf7a8924a0..60cf0516e1bc 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -567,12 +567,14 @@ static int wcn36xx_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
>  		if (IEEE80211_KEY_FLAG_PAIRWISE & key_conf->flags) {
>  			sta_priv->is_data_encrypted = true;
>  			/* Reconfigure bss with encrypt_type */
> -			if (NL80211_IFTYPE_STATION == vif->type)
> +			if (NL80211_IFTYPE_STATION == vif->type) {
>  				wcn36xx_smd_config_bss(wcn,
>  						       vif,
>  						       sta,
>  						       sta->addr,
>  						       true);
> +				wcn36xx_smd_config_sta(wcn, vif, sta);
> +			}
>  
>  			wcn36xx_smd_set_stakey(wcn,
>  				vif_priv->encrypt_type,
> 
Nice write-up!

Tested-by: Benjamin Li <benl@squareup.com>
on Square Terminal (2018) with FW-side workaround reverted
