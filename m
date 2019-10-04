Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 653D3CB756
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2019 11:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbfJDJ3m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Oct 2019 05:29:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56052 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfJDJ3m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Oct 2019 05:29:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id a6so5030945wma.5
        for <linux-wireless@vger.kernel.org>; Fri, 04 Oct 2019 02:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3b9dm8x0Jh8iQo7fmt4Dy37C+YPlVMEn7554RkWRJ5s=;
        b=Z97ZpGaomlgJfOvX2bbvDfi9rli5F566fxOmNYir6qNoeUp+7+U6uYROuYygLlTEu7
         kDRtikKwMnxHOfX7QIKwjJjeQLnnZFDjeVod6eVjIgVnafHJGP3ct9DfGpGlpDoaL5wM
         azyGxkhzIB20Y04lC7teXl8v+jgClUNnBWj2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3b9dm8x0Jh8iQo7fmt4Dy37C+YPlVMEn7554RkWRJ5s=;
        b=FRgKOPBPP7pbD7kVlxW5QTnZVaCf48EFw3IcIMxH8ULodt2460xwylG+MOBY9LJ84Y
         JlM3tkyfzrk55IoEH0boUosR45v73//Vehta9hXz68N4MLfmZ8NhOzE40UZLsk+H2lLa
         7quGHaeKf30HzSbvP+TiITkibC9tYUjc8WT4+WgVmhPBCp7sKxgUxs5mFB4t3Xe5fMVO
         aTb1EvXetQWfOJEZIbqKiBnCNsZM/uGvohs5JGVwjWK3PiwrdiXVvpbT0tuaUhIpU71N
         gfA3orba4k2QXf5aXSKKq4IyIg9GIwtGIqnl5yWjPhUEQlXvvTHGcOobrwf6+3j/fjQM
         Q73w==
X-Gm-Message-State: APjAAAUekvVT6IcbEoko2vu7RvCV/EyaiQi5sqv3O4IUkQMwbvoX6/JI
        9nsHdBlUAnUTTuRghciHMU8QPLi9zi3mya89
X-Google-Smtp-Source: APXvYqzxtiv+FwM3n25jHsC27HAr/Yfj/39qOCzdf6e5b/g9XEeCnUyC3oN0fiX+yqRADS100jtSAA==
X-Received: by 2002:a7b:cd08:: with SMTP id f8mr9311226wmj.87.1570181379759;
        Fri, 04 Oct 2019 02:29:39 -0700 (PDT)
Received: from [10.230.33.15] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id x5sm9877162wrg.69.2019.10.04.02.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 02:29:39 -0700 (PDT)
Subject: Re: [PATCH 5.4 regression fix] brcmfmac: Fix
 brcmf_cfg80211_get_channel returning uninitialized fields
To:     Hans de Goede <hdegoede@redhat.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
References: <20191003200821.819594-1-hdegoede@redhat.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <e5681bdc-3cac-36dd-d02a-e22536ec6f9b@broadcom.com>
Date:   Fri, 4 Oct 2019 11:29:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191003200821.819594-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/3/2019 10:08 PM, Hans de Goede wrote:
> With the new edmg support struct cfg80211_chan_def has been extended
> with a number of new members. brcmf_cfg80211_get_channel() was not setting
> (clearing) these causing the cfg80211_edmg_chandef_valid() check in
> cfg80211_chandef_valid() to fail. Triggering a WARN_ON and, worse, causing
> brcmfmac based wifi cards to not work.
> 
> This commit fixes this by clearing the entire passed struct to 0 before
> setting the members used by the brcmfmac code. This solution also makes
> sure that this problem will not repeat itself in the future if further
> members are added to the struct.

Guess this warrants a Fixes: tag and ...

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index e3ebb7abbdae..480c05f66ebd 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -5041,10 +5041,10 @@ static int brcmf_cfg80211_get_channel(struct wiphy *wiphy,
>   	}
>   
>   	freq = ieee80211_channel_to_frequency(ch.control_ch_num, band);
> +	memset(chandef, 0, sizeof(*chandef));
>   	chandef->chan = ieee80211_get_channel(wiphy, freq);
>   	chandef->width = width;
>   	chandef->center_freq1 = ieee80211_channel_to_frequency(ch.chnum, band);
> -	chandef->center_freq2 = 0;
>   
>   	return 0;
>   }
> 
