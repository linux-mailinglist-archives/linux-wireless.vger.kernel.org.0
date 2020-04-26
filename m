Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2211B8ED9
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2020 12:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgDZKcz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Apr 2020 06:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726117AbgDZKcz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Apr 2020 06:32:55 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4830C061A0C
        for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2020 03:32:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 188so16218891wmc.2
        for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2020 03:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jMTXVyLGCZW2j8wD7NIybOg05eUFuAEGECIFhZ5oe0Y=;
        b=ryYi8IlSVu3smwkm4NYE8kXM6m6ZpJ0CBcbhOducnk/vFKWsRxhKnthg/tb509OQCH
         Te6Y/uxV5ZirSL4a8Xv9sb/XSv0E25/XKuzSS8ZtLaRB28hitxOvtL7KyujjyrkqN4y6
         mgVfdjteVBOxtV70ZlfpdLJVNVJ3t2gOeu9RWHR0IcLLckNkAbTda8WZmiLzAb5duxvx
         XUhjWnOfuI2s+ATebzXRulXCg/rs/pYEfELAr0MTdHQamQjz6qEoO0ZZ4pCKBxZTwPGk
         SdCfsvcQ3YNZMqniErDKZ7eYRsMQ4c4Y+cu5lQWUaNfi1y4pEOaxQEHI9rpKp4Ya1SVg
         RZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jMTXVyLGCZW2j8wD7NIybOg05eUFuAEGECIFhZ5oe0Y=;
        b=pd9UIU4H3aXfkfDGf5mTbCPeiaB7zwfziMEAZ+xt0d7ngIHNVrtzCBAcPmi4jG7pME
         tEvKKTkIvGk4dunVFBU4XO6VN8Yz1B1aX7zsf5teM9JGKsL+n8fDv9OT8RMQIN7bttn1
         Se6THWIbcqqdnb1ggR30R1uVmekYyGybd8Uow01hKJ8cMu65M2ZdNeW9Yl6HvvmB/Dor
         ui7XJg047lSM/Xp3TvTi5OMYAGsUMRB6b0vwcJwKn5CSmVD9TZfQB/Von+uJOKSHO7qJ
         kU+Q37mtm8VjQV2OWO/WCkLeuE1SvahDQjcqNJTPIUzo4VG5QmAZX4bxouiOR4Nsb2p8
         /I5w==
X-Gm-Message-State: AGi0PuZHirCITcKFSC/zN/SrLzzQc44TL9r9gB4D4z2Kpuyja5l6TwHT
        DXCcFGdv/mFSIg==
X-Google-Smtp-Source: APiQypIugUiwiKBZFUTGMk5wHtozJbfDRU3ACJhSA2vPh2MgNY09ebKufhAmRbuFWPbF0GcXXF0OkA==
X-Received: by 2002:a1c:bb08:: with SMTP id l8mr22198098wmf.168.1587897173446;
        Sun, 26 Apr 2020 03:32:53 -0700 (PDT)
Received: from [192.168.25.100] (ip-176-198-220-157.hsi05.unitymediagroup.de. [176.198.220.157])
        by smtp.googlemail.com with ESMTPSA id y18sm12164596wmc.45.2020.04.26.03.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2020 03:32:52 -0700 (PDT)
Subject: Re: [PATCH] carl9170: remove P2P_GO support
To:     Christian Lamparter <chunkeey@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>
References: <20200425092811.9494-1-chunkeey@gmail.com>
From:   =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>
Message-ID: <5ebf8e6d-d34b-aa92-d166-d8a5ca0b2c18@googlemail.com>
Date:   Sun, 26 Apr 2020 12:33:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200425092811.9494-1-chunkeey@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Christian,

Am 25.04.20 um 11:28 schrieb Christian Lamparter:
> This patch follows up on a bug-report by Frank Schäfer that
> discovered P2P GO wasn't working with wpa_supplicant.
> This patch removes part of the broken P2P GO support but
> keeps the vif switchover code in place.
Hmm... no way to fix it ?
P2P-GO seems to work fine with p2p_no_group_iface=1, so do you really 
think it's a good idea / required to remove the whole thing ?

> Cc: <stable@vger.kernel.org>
Are you sure about that ?
People might be using it...

Regards,
Frank

> Link: <https://lkml.kernel.org/r/3a9d86b6-744f-e670-8792-9167257edef8@googlemail.com>
> Reported-by: Frank Schäfer <fschaefer.oss@googlemail.com>
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> ---
>   drivers/net/wireless/ath/carl9170/fw.c   |  4 +---
>   drivers/net/wireless/ath/carl9170/main.c | 21 ++++-----------------
>   2 files changed, 5 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/carl9170/fw.c b/drivers/net/wireless/ath/carl9170/fw.c
> index 51934d191f33..1ab09e1c9ec5 100644
> --- a/drivers/net/wireless/ath/carl9170/fw.c
> +++ b/drivers/net/wireless/ath/carl9170/fw.c
> @@ -338,9 +338,7 @@ static int carl9170_fw(struct ar9170 *ar, const __u8 *data, size_t len)
>   		ar->hw->wiphy->interface_modes |= BIT(NL80211_IFTYPE_ADHOC);
>   
>   		if (SUPP(CARL9170FW_WLANTX_CAB)) {
> -			if_comb_types |=
> -				BIT(NL80211_IFTYPE_AP) |
> -				BIT(NL80211_IFTYPE_P2P_GO);
> +			if_comb_types |= BIT(NL80211_IFTYPE_AP);
>   
>   #ifdef CONFIG_MAC80211_MESH
>   			if_comb_types |=
> diff --git a/drivers/net/wireless/ath/carl9170/main.c b/drivers/net/wireless/ath/carl9170/main.c
> index 5914926a5c5b..816929fb5b14 100644
> --- a/drivers/net/wireless/ath/carl9170/main.c
> +++ b/drivers/net/wireless/ath/carl9170/main.c
> @@ -582,11 +582,10 @@ static int carl9170_init_interface(struct ar9170 *ar,
>   	ar->disable_offload |= ((vif->type != NL80211_IFTYPE_STATION) &&
>   	    (vif->type != NL80211_IFTYPE_AP));
>   
> -	/* While the driver supports HW offload in a single
> -	 * P2P client configuration, it doesn't support HW
> -	 * offload in the favourit, concurrent P2P GO+CLIENT
> -	 * configuration. Hence, HW offload will always be
> -	 * disabled for P2P.
> +	/* The driver used to have P2P GO+CLIENT support,
> +	 * but since this was dropped and we don't know if
> +	 * there are any gremlins lurking in the shadows,
> +	 * so best we keep HW offload disabled for P2P.
>   	 */
>   	ar->disable_offload |= vif->p2p;
>   
> @@ -639,18 +638,6 @@ static int carl9170_op_add_interface(struct ieee80211_hw *hw,
>   			if (vif->type == NL80211_IFTYPE_STATION)
>   				break;
>   
> -			/* P2P GO [master] use-case
> -			 * Because the P2P GO station is selected dynamically
> -			 * by all participating peers of a WIFI Direct network,
> -			 * the driver has be able to change the main interface
> -			 * operating mode on the fly.
> -			 */
> -			if (main_vif->p2p && vif->p2p &&
> -			    vif->type == NL80211_IFTYPE_AP) {
> -				old_main = main_vif;
> -				break;
> -			}
> -
>   			err = -EBUSY;
>   			rcu_read_unlock();

