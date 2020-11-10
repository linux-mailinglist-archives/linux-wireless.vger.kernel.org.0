Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B1F2ACA9B
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 02:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgKJBme (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 20:42:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42615 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbgKJBmd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 20:42:33 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1kcIg3-00011F-5w
        for linux-wireless@vger.kernel.org; Tue, 10 Nov 2020 01:42:31 +0000
Received: by mail-il1-f198.google.com with SMTP id q5so8063678ilc.13
        for <linux-wireless@vger.kernel.org>; Mon, 09 Nov 2020 17:42:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+R8H+LRx4iZIaZ5oZVZMi0sukbFe8SA2wgM0zDYFRc4=;
        b=JFfgL6bsxzdk8UbVSc1anoxwoteFT43i1FUOjV6s6sCYuIrr6JT0M6zKfbsBzGCKwX
         9wQwlkRlI/dNSJ27MqA2DS37GO26SMl28EWYM1O67q0xjewU84qQqSNV57woWQW7pwuE
         FxgjX9seDhjwl2YXKgfuvpsU11G3gnnMmQQtrmacL1tufPCJbdBkaDF0YAL/NI8lf+rD
         FcsXOHjiAMnwE7X6JQ0sW3iI2nB/T+lkymFAmVF9PjKwQ6TwpOb3nMZiCdbZ/ESm+6fM
         AqfpNxN6Fa47+8W4gpV6i0RKJb0OSlVMAdVFVA2Te8qjHNJpWNiY2vUDiWqgPQ9YV2eT
         BeRw==
X-Gm-Message-State: AOAM533/GpjPwMFLBbkUBhoOEbyyb0ZEdosKSJOI6BTJ/6LQIprBhdKB
        m5fjUoOkWiOnGgj0/+PUzlkSqQ6T2nPPJhrRsuDjwju9V2gg12Gm57IsGLZ4MTZvLY6WQV55YuA
        NnYdLh3WXfbisjJeQdwDwRGlcXRgq34QiUHpcUFGN4Iwf
X-Received: by 2002:a92:aa53:: with SMTP id j80mr6305990ili.88.1604972550213;
        Mon, 09 Nov 2020 17:42:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmKL1iJDSiWlPOlKcqXKHV9Fm2RXfn/WFAFG8Ry2az/KqFWpyL5jPyNdx8LzOYbHLQudCT5w==
X-Received: by 2002:a92:aa53:: with SMTP id j80mr6305981ili.88.1604972549997;
        Mon, 09 Nov 2020 17:42:29 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:89a:1dd3:9ddb:b24d])
        by smtp.gmail.com with ESMTPSA id d142sm6666293iof.43.2020.11.09.17.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 17:42:29 -0800 (PST)
Date:   Mon, 9 Nov 2020 19:42:28 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     bkil <b.K.il.h.u+tigbuh@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless-regdb: restore channel 12 & 13 limitation in
 the US
Message-ID: <20201110014228.GJ6125@ubuntu-x1>
References: <840438bf70c72d2ab933aee9ae5aa6985b6c1531.1601902881.git.b.K.il.h.u+tigbuh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <840438bf70c72d2ab933aee9ae5aa6985b6c1531.1601902881.git.b.K.il.h.u+tigbuh@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Oct 05, 2020 at 03:01:22PM +0200, bkil wrote:
> The precisely allowed transmission power on channel 12 & 13 is not clear.
> 
> I did some fact checking and document reviews in the past, but still
> failed to come up with an exact reference or calculation regarding what TX
> power should be allowed in general to reduce interference in the
> neighboring restricted band 2483.5-2500 MHz and whether indoor vs. outdoor
> and b/g/n modulation would make a difference (probably yes).
> 
> Existing documents that discuss this are vague and pretty much out of date:
> https://en.wikipedia.org/wiki/List_of_WLAN_channels#endnote_B
> 
> Following these guidelines, I failed to come up with an approximate
> formula that would prohibit usage of channel 12 & 13, but still allow
> usage of channel 11 with full power, hence at least part of the argument
> for prohibiting channel 12 & 13 needs to be refined.
> 
> Until further research, just to stay safe, I propose that we restore the
> previous limitation of disabling channel 12 & 13 as before. We should
> work towards finding a safe transmission power to use on both and specify
> that (like 50mW on channel 13 and 100mW on channel 12?).
> 
> I've also started a discussion for investigation on Wikipedia:
> https://en.wikipedia.org/wiki/Talk:List_of_WLAN_channels#Should_the_2.4GHz_channel_12_and_13_in_the_USA_need_updating?
> 
> Signed-off-by: bkil <b.K.il.h.u+tigbuh@gmail.com>

I tried doing a little research, and it does appear that use of channels
12 and 13 is more complicated than it might seem on the surface. I
cannot find any clear guidance on power limits and lack the background
to determine appropriate limits from the information I did find, so it
does seem prudent to restore the previous limitation.

Applied, thanks!

> ---
>  db.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/db.txt b/db.txt
> index ac32483..68613cf 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1568,8 +1568,12 @@ country UG: DFS-FCC
>  
>  # https://www.ecfr.gov/cgi-bin/text-idx?SID=eed706a2c49fd9271106c3228b0615f3&mc=true&node=pt47.1.15&rgn=div5
>  # Title 47 Part 15 - Radio Frequency Devices, April 2, 2020
> +# Channels 12 and 13 are not forbidden, but are not normally used with full
> +# power in order to avoid any potential interference in the adjacent restricted
> +# frequency band, 2,483.5–2,500 MHz which is subject to strict emission limits
> +# set out in 47 CFR § 15.205. TODO: reenable and specify a safe TX power here.
>  country US: DFS-FCC
> -	(2400 - 2483.5 @ 40), (30)
> +	(2400 - 2472 @ 40), (30)
>  	# 5.15 ~ 5.25 GHz: 30 dBm for master mode, 23 dBm for clients
>  	(5150 - 5250 @ 80), (23), AUTO-BW
>  	(5250 - 5350 @ 80), (23), DFS, AUTO-BW
