Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31F5F1A2078
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2020 13:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgDHL45 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Apr 2020 07:56:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35639 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgDHL44 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Apr 2020 07:56:56 -0400
Received: by mail-wm1-f66.google.com with SMTP id r26so5143571wmh.0
        for <linux-wireless@vger.kernel.org>; Wed, 08 Apr 2020 04:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncentric-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=r//OCBfZ1wHmL364/q+AoFNYsD5AU3Cd2vuzJY7eM/w=;
        b=a/95h4OL7QTsL64XciAm5H4wcV1BNhlqdKlA1QbQEHep2VCLNf7m1Pc90cCqhI5kvy
         VCR1fivOz0KleplDw9cLENU+C0H/f5mAFdJ7nnD7Qq3u9JVSC+80mQdCdL9rv7VVPE1z
         W1K2tKlKsgKxDJKuex9MbavYceM0rw+JH0t7xkWV1BpylC9et79ZhF4ISsl0u+/Rk3+Q
         eReVvztCAA13rftfLa3Z7jBGG+XBKEYTiI5ZwlX01g2OvR4KkjcL2B7hx2sSHjFNzMSa
         xvhImDUuMNqgPeaVFmo5F0Nw9Hli5GtDHXV2R14h8HuFVuC1+DL7cZROx4wFITuZBRzn
         r1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=r//OCBfZ1wHmL364/q+AoFNYsD5AU3Cd2vuzJY7eM/w=;
        b=onFCtCMGzlZr2IxK+G65EZDsbmEEpSKdo84TIEQlNoIXUyR7NGthBeJFRpz0NZeEcJ
         8dCu/mqwxOsKuvrzq4NRBbpiLmbl2kucQaZ6HYNJqsgJNTvf6Gmc7pllQa/JVYGlLgKB
         AzduVDFlo5NMIKfKbrppdEhQXQc5TZcnJxN5FApFAVbm4zm4YXnMf3ntMt4BiDbN+Sca
         UBlC8mSetrvdoAELDj1nrNxvPQVOtHXeNs7+AYBXmPGHfI/sP6WBRD1aKYeeeTdyE8yg
         ty6dFGkoNLcia57BF0bG8vzY7Y63yf+bMzREAaxuYLhPXBwqZecJjXN+F2ToqabXKLbd
         urtg==
X-Gm-Message-State: AGi0PuahNQUQMvgIncQiJoMKu/u5DfXZuDpsANx/IXdd3/sfFGSQQ50+
        +nwCgA+pHd26ln70lIJJlyoKKA==
X-Google-Smtp-Source: APiQypJPLRYhaJHu4emt8QJsikRTMFboGABsmvbTk9PFozJ/Wk44M/zxKQfkheQcmolQPbqi2PS8tw==
X-Received: by 2002:a7b:c402:: with SMTP id k2mr4474946wmi.21.1586347014269;
        Wed, 08 Apr 2020 04:56:54 -0700 (PDT)
Received: from [10.202.0.7] (d5152e8e2.static.telenet.be. [81.82.232.226])
        by smtp.gmail.com with ESMTPSA id l12sm34748847wrt.73.2020.04.08.04.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 04:56:53 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] mac80211: Allow deleting stations in ibss mode to
 reset their state
To:     Nicolas Cavallari <cavallar@lri.fr>, linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.com>
References: <20200305135754.12094-1-cavallar@lri.fr>
 <20200305135754.12094-2-cavallar@lri.fr>
From:   Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <bc2934fe-ee0b-c593-e866-692487e06d4e@ncentric.com>
Date:   Wed, 8 Apr 2020 13:56:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305135754.12094-2-cavallar@lri.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 05.03.20 14:57, Nicolas Cavallari wrote:
> From: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
>
> Set the NL80211_EXT_FEATURE_DEL_IBSS_STA if the interface support IBSS
> mode, so that stations can be reset from user space.
>
> mac80211 already deletes stations by itself, so mac80211 drivers must
> already support this.
>
> This has been successfully tested with ath9k.
>
> Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
>
> ---
> v3: spelling fixes in commit message.
> ---
>   net/mac80211/main.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index 944e86da5c65..bc7fd67dc987 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -1081,6 +1081,10 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
>   				      NL80211_EXT_FEATURE_EXT_KEY_ID);
>   	}
>   
> +	if (local->hw.wiphy->interface_modes & BIT(NL80211_IFTYPE_ADHOC))
> +		wiphy_ext_feature_set(local->hw.wiphy,
> +				      NL80211_EXT_FEATURE_DEL_IBSS_STA);
> +
>   	/*
>   	 * Calculate scan IE length -- we need this to alloc
>   	 * memory and to subtract from the driver limit. It

Hi Nicolas,


I took these patches for a thorough spin offshore (combined with your 
quick wpa_sup change)


Quick test setup overview:

- Device mounted on top of a vessel, sailing around in windfarms.
- Lots of turbines are equiped with 4x 90deg sectors
- 802.11n HT40 2x2 custom mesh over IBSS, using Dynack
- As the vessel moves around,  IBSS links are continuously dropped and 
re-added throughout the field
- Output of my app, fyi:  https://pastebin.com/raw/vtZSwHC9

I've made 2 identical builds, one containing your patches and one without.

When your patches are used:

--> On devices with multiple radio's, all radio's went deaf within a few 
minutes without any notice in logs.

--> Only a reboot solved the issue but everything goes deaf again within 
a few minutes. (after dropping/adding some links)


Any idea?


Thanks,

Koen

