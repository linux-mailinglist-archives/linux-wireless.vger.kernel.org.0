Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEBD210AE2B
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 11:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfK0Ksd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 05:48:33 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32961 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfK0Ksd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 05:48:33 -0500
Received: by mail-lj1-f195.google.com with SMTP id t5so23943230ljk.0
        for <linux-wireless@vger.kernel.org>; Wed, 27 Nov 2019 02:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ejLcXZey/Bimb1BLRYgUHAXgcKifURx/dXUaSJ2JWiw=;
        b=a1TbFcKej0/60ZlJ+iTHw3LjHE+g7zKcombg1hDjtVxzDtrLZ2iSzaDYH+3xz6z/D+
         Jxy+pofRIMp9vnPO1qXXQgNXFTznsmLzSOSwDoxS/jhBRNQibmVED+rtoq3UXM4h5bmH
         ELme4exDgCLbYC7jCq72c3RRwV937XhMEuH0B2WAhvaSzU+nHc+jS+3rIn0n6iK6uKe7
         K+XQyB4cC5S4DElp0+Ki53VrudLLe0U8VO/45QHFHhWUpYw/kN5qu7NyYflkO8RJkiYD
         IrRgAdd9Oixos3/bBYFWe+DAJaA2klytgo0IXj4gn/3EsXM6RYchxn9lnyGqzfdmTInh
         asTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ejLcXZey/Bimb1BLRYgUHAXgcKifURx/dXUaSJ2JWiw=;
        b=sRbN5LqCvuMGRfwxxeKkSr8a0BN6boepyNS7lp0Ge2uUDMMOdz5HDLziymDF2sGN7q
         M7yOJy+aakxd66OJo+3sug8Nk6pNrwG5kM0R/I+amBJCZ7tWsZPezQnXVaa0U0G2suMP
         BP4EINnVBzOhVF9TDMGCZL6f4Pyd5thR3akJ+CbsIch8Y8dIaFF/d0U1PUE9rggTAmS5
         nv5PWDAzdwj4sxBCkL75WK3rKRgq/xJwmEM1kd+KtCNA0Mp1iSHvpp8O345TzWBd40WQ
         krRqUbgVVZ8y4Xnkq7l7R+lOziHZyNi1X29Awe2gt4ZDa1VCPOPamWJb8SB0mIWUHfHG
         wS3A==
X-Gm-Message-State: APjAAAUxOfBz/YoCJ6fH1dC+nCWyKVV1JU5PdPIZy2lcXomrnUyH/y7+
        nXX3GoJBe8HE5y5r0M0bgYTXdA==
X-Google-Smtp-Source: APXvYqwxpxnwSAlnk2iJLxy0y26FLLAGQ9K0vqjWJGBYNC1Z20dZRBq+cekc04hlNg8TIHTT7rIcFg==
X-Received: by 2002:a05:651c:1066:: with SMTP id y6mr31004234ljm.96.1574851709571;
        Wed, 27 Nov 2019 02:48:29 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:4237:c73d:3077:a4da:e919:17fe? ([2a00:1fa0:4237:c73d:3077:a4da:e919:17fe])
        by smtp.gmail.com with ESMTPSA id t16sm6839233ljc.106.2019.11.27.02.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 02:48:28 -0800 (PST)
Subject: Re: [PATCH] brcmsmac: Remove always false 'channel < 0' statement
To:     Austin Kim <austindh.kim@gmail.com>, arend.vanspriel@broadcom.com,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        chi-hsien.lin@cypress.com, wright.feng@cypress.com,
        kvalo@codeaurora.org, davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191127054358.GA59549@LGEARND20B15>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <46dfe877-4f32-b763-429f-7af3a83828f0@cogentembedded.com>
Date:   Wed, 27 Nov 2019 13:48:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191127054358.GA59549@LGEARND20B15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 27.11.2019 8:43, Austin Kim wrote:

> As 'channel' is declared as u16, the following statement is always false.
>     channel < 0
> 
> So we can remove unnecessary 'always false' statement.

    It's an expression, not a statement.

> Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
> index 3f09d89..7f2c15c 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/main.c
> @@ -5408,7 +5408,7 @@ int brcms_c_set_channel(struct brcms_c_info *wlc, u16 channel)
>   {
>   	u16 chspec = ch20mhz_chspec(channel);
>   
> -	if (channel < 0 || channel > MAXCHANNEL)
> +	if (channel > MAXCHANNEL)
>   		return -EINVAL;
>   
>   	if (!brcms_c_valid_chanspec_db(wlc->cmi, chspec))

MBR, Sergei

