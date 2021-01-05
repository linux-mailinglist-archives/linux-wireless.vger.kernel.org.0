Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA312EA8F9
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 11:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbhAEKkW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 05:40:22 -0500
Received: from relay.smtp-ext.broadcom.com ([192.19.232.172]:44040 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728812AbhAEKkW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 05:40:22 -0500
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jan 2021 05:40:22 EST
Received: from bld-lvn-bcawlan-34.lvn.broadcom.net (bld-lvn-bcawlan-34.lvn.broadcom.net [10.75.138.137])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 5B79024ABB;
        Tue,  5 Jan 2021 02:29:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 5B79024ABB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1609842590;
        bh=H2UwM2SbyRdHqzJPNfTkY9fvKRgu+oHyOjSassNG0Wg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gfy+47UQqhy8EI5jzWXKk7ijfE2wOkysnkOZoQOhrb75d/58YfimyF4c4G8+xf96p
         tkN18SiIv5CRUJjvkHeQ5YxGYjFUdCt2Bx1wcgGBgmYowITctuXkEGiw7XYt7qjx+S
         ZOCejmgmXgpakpWfpxFrQdJTOSmU6vuWtyFdDIkc=
Received: from [10.230.40.141] (unknown [10.230.40.141])
        by bld-lvn-bcawlan-34.lvn.broadcom.net (Postfix) with ESMTPSA id 92247187289;
        Tue,  5 Jan 2021 02:29:49 -0800 (PST)
Subject: Re: [PATCH] cfg80211: add VHT rate entries for MCS-10 and MCS-11
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <20210105102250.3473-1-arend.vanspriel@broadcom.com>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <a79e0486-4d44-1446-5ae2-455cc75496c9@broadcom.com>
Date:   Tue, 5 Jan 2021 11:29:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210105102250.3473-1-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ Johannes (corrected email address)

On 1/5/2021 11:22 AM, Arend van Spriel wrote:
> Observed the warning in cfg80211_calculate_bitrate_vht() using an
> 11ac chip reporting MCS-11. Since devices reporting non-standard
> MCS-9 is already supported add similar entries for MCS-10 and MCS-11.
> 
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
>   net/wireless/util.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/wireless/util.c b/net/wireless/util.c
> index b4acc805114b..19fd4db6d32f 100644
> --- a/net/wireless/util.c
> +++ b/net/wireless/util.c
> @@ -1236,6 +1236,8 @@ static u32 cfg80211_calculate_bitrate_vht(struct rate_info *rate)
>   		   78000000,
>   		/* not in the spec, but some devices use this: */
>   		   86500000,
> +		   97500000,
> +		  108300000,
>   		},
>   		{  13500000,
>   		   27000000,
> @@ -1247,6 +1249,8 @@ static u32 cfg80211_calculate_bitrate_vht(struct rate_info *rate)
>   		  135000000,
>   		  162000000,
>   		  180000000,
> +		  202500000,
> +		  225000000,
>   		},
>   		{  29300000,
>   		   58500000,
> @@ -1258,6 +1262,8 @@ static u32 cfg80211_calculate_bitrate_vht(struct rate_info *rate)
>   		  292500000,
>   		  351000000,
>   		  390000000,
> +		  438800000,
> +		  487500000,
>   		},
>   		{  58500000,
>   		  117000000,
> @@ -1269,12 +1275,14 @@ static u32 cfg80211_calculate_bitrate_vht(struct rate_info *rate)
>   		  585000000,
>   		  702000000,
>   		  780000000,
> +		  877500000,
> +		  975000000,
>   		},
>   	};
>   	u32 bitrate;
>   	int idx;
>   
> -	if (rate->mcs > 9)
> +	if (rate->mcs > 11)
>   		goto warn;
>   
>   	switch (rate->bw) {
> 
