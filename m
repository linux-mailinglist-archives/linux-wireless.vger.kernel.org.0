Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5C410A9C7
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 06:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfK0FFv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 00:05:51 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33641 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfK0FFu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 00:05:50 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so1598125pjb.0
        for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2019 21:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=13/NKjR0qdfO/pQgZRQFa4jmq4Pfl5v/EazWoqNxEPA=;
        b=FcHGXfZhwh5Muccpn8O+GeakJh++aAf3w1540pjXJP8iO/snlCJMq10wSKFeDeleVm
         eftiC6f9zkvkDQzyUAE89w3NzdmT6h462IJN0Va6n1ZbsGddk+j2XCMd4rbAiCA4S2Yp
         a/lR1uAWvdpOaWkt0rr6Q+zf3Acvi+XyaOnhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=13/NKjR0qdfO/pQgZRQFa4jmq4Pfl5v/EazWoqNxEPA=;
        b=b0wI0NI3MeEoI28FoQfj6Exkv76NmcHWpkcNKkHvy1i7Z0j9KMMIXkLIBkzHUaSRlw
         qzUw420MN//bbk/zxzdsmzFeqwQD6k6KznBBrmm4XWvbgxsRAl9X+dirbAoiYZSxQ+0q
         JY5gIl2A4v6E3jw2Uwbzt7Xt5aMaKDo4oMT8R80NEGuRwnn9vyZBcWLcYFQ0mMX4GNzx
         EKUvUjuJS1x2I5obiBii3jWrqbtjYiHfJFITF9UK5v4/2tH9itWIjj2Z2uzhSTqb0DbC
         T+C3taNsYTdnyIeAnemOcSCBUpgJEAv7aL+2VulX/zXyBXbB9n0/K7AvQWyCtNJ97Xus
         um5A==
X-Gm-Message-State: APjAAAUPeBNgdIjJSdTsVrQl+jyRE/YS872q8qXkkG/iNep5+IaBgLag
        AjCk/6CQv6hl76Hfka3dYJNcag==
X-Google-Smtp-Source: APXvYqwU8f5T80QIyp/yNb/Rj5j0aziV3JLwnG6PelN0cmfmQPJtZskDuK2cXjIFgy6Y6G//SNT5pg==
X-Received: by 2002:a17:902:a581:: with SMTP id az1mr2125365plb.23.1574831149823;
        Tue, 26 Nov 2019 21:05:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s130sm4351138pgc.82.2019.11.26.21.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 21:05:48 -0800 (PST)
Date:   Tue, 26 Nov 2019 21:05:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     Larry.Finger@lwfinger.net, jakub.kicinski@netronome.com,
        kvalo@codeaurora.org, Wright.Feng@cypress.com,
        arend.vanspriel@broadcom.com, davem@davemloft.net,
        emmanuel.grumbach@intel.com, franky.lin@broadcom.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, luciano.coelho@intel.com,
        netdev@vger.kernel.org, p.figiel@camlintechnologies.com,
        pieter-paul.giesberts@broadcom.com, pkshih@realtek.com,
        rafal@milecki.pl, sara.sharon@intel.com,
        shahar.s.matityahu@intel.com, yhchuang@realtek.com,
        yuehaibing@huawei.com
Subject: Re: [Patch v2 3/4] iwlegacy: Fix -Wcast-function-type
Message-ID: <201911262105.E50C54F@keescook>
References: <20191125150215.29263-1-tranmanphong@gmail.com>
 <20191126175529.10909-1-tranmanphong@gmail.com>
 <20191126175529.10909-4-tranmanphong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126175529.10909-4-tranmanphong@gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Nov 27, 2019 at 12:55:28AM +0700, Phong Tran wrote:
> correct usage prototype of callback in tasklet_init().
> Report by https://github.com/KSPP/linux/issues/20
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/net/wireless/intel/iwlegacy/3945-mac.c | 5 +++--
>  drivers/net/wireless/intel/iwlegacy/4965-mac.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> index 4fbcc7fba3cc..e2e9c3e8fff5 100644
> --- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> +++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
> @@ -1376,8 +1376,9 @@ il3945_dump_nic_error_log(struct il_priv *il)
>  }
>  
>  static void
> -il3945_irq_tasklet(struct il_priv *il)
> +il3945_irq_tasklet(unsigned long data)
>  {
> +	struct il_priv *il = (struct il_priv *)data;
>  	u32 inta, handled = 0;
>  	u32 inta_fh;
>  	unsigned long flags;
> @@ -3403,7 +3404,7 @@ il3945_setup_deferred_work(struct il_priv *il)
>  	timer_setup(&il->watchdog, il_bg_watchdog, 0);
>  
>  	tasklet_init(&il->irq_tasklet,
> -		     (void (*)(unsigned long))il3945_irq_tasklet,
> +		     il3945_irq_tasklet,
>  		     (unsigned long)il);
>  }
>  
> diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> index ffb705b18fb1..5fe17039a337 100644
> --- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> +++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
> @@ -4344,8 +4344,9 @@ il4965_synchronize_irq(struct il_priv *il)
>  }
>  
>  static void
> -il4965_irq_tasklet(struct il_priv *il)
> +il4965_irq_tasklet(unsigned long data)
>  {
> +	struct il_priv *il = (struct il_priv *)data;
>  	u32 inta, handled = 0;
>  	u32 inta_fh;
>  	unsigned long flags;
> @@ -6238,7 +6239,7 @@ il4965_setup_deferred_work(struct il_priv *il)
>  	timer_setup(&il->watchdog, il_bg_watchdog, 0);
>  
>  	tasklet_init(&il->irq_tasklet,
> -		     (void (*)(unsigned long))il4965_irq_tasklet,
> +		     il4965_irq_tasklet,
>  		     (unsigned long)il);
>  }
>  
> -- 
> 2.20.1
> 

-- 
Kees Cook
