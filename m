Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B8D1C812B
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 06:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725905AbgEGEwL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 May 2020 00:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725601AbgEGEwK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 May 2020 00:52:10 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BD5C061A41
        for <linux-wireless@vger.kernel.org>; Wed,  6 May 2020 21:52:09 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t7so1585606plr.0
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2020 21:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FYkaUuQ0Hcijpg8fXzFbNqstsBym+T1ZVc+9xfGMFXI=;
        b=rjy+p4PWdreHUZMb3DXmAQFd1efDM9tlKf0HJE+/ybAFXUpRwsj+qLj6/nikE0BrxH
         8O4xAdkgqHHyoUiPY4fxdQZXZRJVRnPo0gfhbhNGMu188qw/TZR/WlWbskfmuVqcNzH0
         wTxY4fLXM3RIVF9eomTo8zVDKmZ0lwZajSMe5zSjFw4Et7KM2etVYhzFwE1Zxg9XQ2U5
         X2EbBuxDl0qfzMxhUKJEv0yipky959uomgqO1+rGozNrnVogJcutrSYylnKL8UzwcUP9
         uFTxX7kyHHCdM4VWNP8xRM1SiAJvDVE6JuyTCj8G8ZJFb1ed3LiXCIShV0wh7XdxZNaE
         6vZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FYkaUuQ0Hcijpg8fXzFbNqstsBym+T1ZVc+9xfGMFXI=;
        b=LMUD8ug/qGamio9FjkbZUlAhRmkcHvNpF+YrSeoD0I5CubWr6F4hH1KBKi4tz9GjUU
         +RuNjQNTSv3AyeaJVeCspA7GkV84GntigDIzmjo5Fh2ivOG9Ovn/TLTVg6eddaxyMsmC
         B/RzXKCqd5q9P5zvdFVtQxVRigErK1HIdTgpoeH7d74O6XWpJKamdWYUaggDgU3FF4tL
         zI9SBf5LlB4ZdxxDdCCn0L/f/+S/V5xeRx0eTX+wJJ22vrzexZmtbGOK2+dx0nxCYtvN
         FqVbZcMQJoWh+hQoDjZgIt68VV5/+WIOq+Mm5eMRd+UQKHhEcfwJlbOjognAlrSKG+AW
         yNsA==
X-Gm-Message-State: AGi0PuZvQkz4f6GuW++PNWXD8OEZv9gW5LJTTO2LLKRENEUWWMBmeLVP
        mqe07xho3WG/yPc4ICMwqzef9A==
X-Google-Smtp-Source: APiQypJeThSOJg6sXA6qEy1XEL6FUsr6CHGbZUU7u6C7pBB/gU3FNKMkjcI6fPvCUeZkEcANxv0tsg==
X-Received: by 2002:a17:90a:8d12:: with SMTP id c18mr13335798pjo.144.1588827128685;
        Wed, 06 May 2020 21:52:08 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id i128sm3501379pfc.149.2020.05.06.21.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 21:52:08 -0700 (PDT)
Date:   Wed, 6 May 2020 21:52:55 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     kvalo@codeaurora.org, davem@davemloft.net, marcel@holtmann.org,
        andy.gross@linaro.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] wcn36xx: Fix error handling path in 'wcn36xx_probe()'
Message-ID: <20200507045255.GB3236072@builder.lan>
References: <20200507043619.200051-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507043619.200051-1-christophe.jaillet@wanadoo.fr>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed 06 May 21:36 PDT 2020, Christophe JAILLET wrote:

> In case of error, 'qcom_wcnss_open_channel()' must be undone by a call to
> 'rpmsg_destroy_ept()', as already done in the remove function.
> 
> Fixes: 5052de8deff5 ("soc: qcom: smd: Transition client drivers from smd to rpmsg")

It seems I introduced this bug in f303a9311065 ("wcn36xx: Transition
driver to SMD client"), but your patch should should apply back to your
Fixes, so I think it's good.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Not 100% sure of the commit for Fixes, but it is consistent with the
> analysis in efad8396e906 where the same call has been added in the remove
> function.
> ---
>  drivers/net/wireless/ath/wcn36xx/main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
> index e49c306e0eef..1acdc13a74fc 100644
> --- a/drivers/net/wireless/ath/wcn36xx/main.c
> +++ b/drivers/net/wireless/ath/wcn36xx/main.c
> @@ -1339,7 +1339,7 @@ static int wcn36xx_probe(struct platform_device *pdev)
>  	if (addr && ret != ETH_ALEN) {
>  		wcn36xx_err("invalid local-mac-address\n");
>  		ret = -EINVAL;
> -		goto out_wq;
> +		goto out_channel;
>  	} else if (addr) {
>  		wcn36xx_info("mac address: %pM\n", addr);
>  		SET_IEEE80211_PERM_ADDR(wcn->hw, addr);
> @@ -1347,7 +1347,7 @@ static int wcn36xx_probe(struct platform_device *pdev)
>  
>  	ret = wcn36xx_platform_get_resources(wcn, pdev);
>  	if (ret)
> -		goto out_wq;
> +		goto out_channel;
>  
>  	wcn36xx_init_ieee80211(wcn);
>  	ret = ieee80211_register_hw(wcn->hw);
> @@ -1359,6 +1359,8 @@ static int wcn36xx_probe(struct platform_device *pdev)
>  out_unmap:
>  	iounmap(wcn->ccu_base);
>  	iounmap(wcn->dxe_base);
> +out_channel:
> +	rpmsg_destroy_ept(wcn->smd_channel);
>  out_wq:
>  	ieee80211_free_hw(hw);
>  out_err:
> -- 
> 2.25.1
> 
