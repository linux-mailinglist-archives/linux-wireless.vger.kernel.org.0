Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D0B2605E4
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 22:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgIGUrB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 16:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgIGUq4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 16:46:56 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A09C061573
        for <linux-wireless@vger.kernel.org>; Mon,  7 Sep 2020 13:46:55 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id e23so19656489eja.3
        for <linux-wireless@vger.kernel.org>; Mon, 07 Sep 2020 13:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=prYc+7ttMHQt/W7TskfM9n0oRkdYfOwCwchTSFOez28=;
        b=Hq7iVc8VDPbHRQuQogFSWAqW4zTvRdDrU5cuWL2eabnKRjgwT1xZZX8+XM0Ri2l/Ay
         zQTKoRpecyuLtZX7LXUqYnHPOXkPiDDEfrmCJXl9aS4AmzUe1rlWe8vTd9vLQO6eBWmm
         Gx6M33b9N/48GaEoB9qUBBPJGlOH6c8fmDXa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=prYc+7ttMHQt/W7TskfM9n0oRkdYfOwCwchTSFOez28=;
        b=s0QHCkGVHJeiF0z3qosIXr/FTpzKEjlA8POK5NDMZjn2V4tkNr2V1yr5iPEaEmPshy
         WSgF0Is5yZLG68/9CnZJI7zsPi5fX8K7AmuwA0h5isRqj1sKiYEMKKwSkeFueIGuz4k2
         B6biIg1vr8l9Gdl6rucr4uYYUuqnvEq+AvppS+cGMY2EButPD31FLNOoXWBLearPBg32
         MfoNldIAn7d1LOt6eaKGqS63sjoaZmVNwfKVvP52htv6pyu4EoR/94aKuQBvqtLRj1L2
         YHKsEL9lyllrBBfvcdDhxlxNms/LpiGrKYyei2AvQcsUb5VTRxePy/93KMU9N5eKIxng
         cfVg==
X-Gm-Message-State: AOAM530xb7/Uj7zyHVOVQjOd8ju4y5tbejVBHBxmXNYisgSN32Db4zd1
        fIzuCjy1aRlA1VfnX5jPD1XYbw==
X-Google-Smtp-Source: ABdhPJy6KkwYdGkaIy0ygpf+Q8ZtAaKvRmZ1OUNiM6+KyWHS7X/d8AFgynvdsorNA3B+8t5dITTzYQ==
X-Received: by 2002:a17:906:c0d9:: with SMTP id bn25mr15530389ejb.246.1599511613863;
        Mon, 07 Sep 2020 13:46:53 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id bm2sm13722046edb.30.2020.09.07.13.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 13:46:53 -0700 (PDT)
Subject: Re: [PATCH] brcmsmac: fix potential memory leak in
 wlc_phy_attach_lcnphy
To:     Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     takafumi@sslab.ics.keio.ac.jp,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list@cypress.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200907162245.17997-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <bad4e33a-af2f-b44f-63e5-56386c312a91@broadcom.com>
Date:   Mon, 7 Sep 2020 22:46:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907162245.17997-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 9/7/2020 6:22 PM, Keita Suzuki wrote:
> When wlc_phy_txpwr_srom_read_lcnphy fails in wlc_phy_attach_lcnphy,
> the allocated pi->u.pi_lcnphy is leaked, since struct brcms_phy will be
> freed in the caller function.
> 
> Fix this by calling wlc_phy_detach_lcnphy in the error handler of
> wlc_phy_txpwr_srom_read_lcnphy before returning.
> 
> Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
> ---
>   .../net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c    | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
> index 7ef36234a25d..6d70f51b2ddf 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
> @@ -5065,8 +5065,10 @@ bool wlc_phy_attach_lcnphy(struct brcms_phy *pi)
>   	pi->pi_fptr.radioloftget = wlc_lcnphy_get_radio_loft;
>   	pi->pi_fptr.detach = wlc_phy_detach_lcnphy;
>   
> -	if (!wlc_phy_txpwr_srom_read_lcnphy(pi))
> +	if (!wlc_phy_txpwr_srom_read_lcnphy(pi)) {
> +		wlc_phy_detach_lcnphy(pi);

Essentially the same but I prefer to simply do the kfree() call directly 
here as we also allocate in this function.

Thanks,
Arend
