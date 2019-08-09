Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60C9D88444
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2019 22:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfHIUuc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Aug 2019 16:50:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42950 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfHIUub (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Aug 2019 16:50:31 -0400
Received: from mail-ot1-f72.google.com ([209.85.210.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1hwBqH-0005sy-Rc
        for linux-wireless@vger.kernel.org; Fri, 09 Aug 2019 20:50:30 +0000
Received: by mail-ot1-f72.google.com with SMTP id h12so71116754otn.18
        for <linux-wireless@vger.kernel.org>; Fri, 09 Aug 2019 13:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HN+Atl3J/PkbjEtlQO6XuHyRHVWcLmhJrqULjHr2RjI=;
        b=i/U3o8LF4F1L+QTjdIguPES+HRZeKE3hR1J3+lWthUDhGA+/aI0OD4iyuKS5lS8DrF
         xdrnoq/8/V7Gx/9/TlxbTeb4OMah//vwvcpney15avamO2d4dgPv8jKb0hpS5m/PeNmr
         T70XAsTt/jcIIHxnNyHBjwWaaRM7aYbdzh5FvAhAZFfFnFFCoLpCIH0fJjyrILgmCfJP
         3dFRASMdiXWnOCDGwEqzpPs/AK5slqZ8Fx3Q7Qp8/VRIE6K+Hu4pkw6eXrg3jjlOA3F8
         ndZRHEaBukcFve2Pu/rOutOPHUFxH8MRJ2pm+0bFywkR1JRC3Kpm9F3I0Sw/3ZEjkP/R
         H9Bg==
X-Gm-Message-State: APjAAAXUHl7h1SjET3ZXCQLie71/1PijJL3srSUXgrpLbXjxMkUM9Kou
        f4j7dAHvMBbU9qS+j3xrx9xzWw/JTyj2YgVO+5Ggvh22W+zdw4uMSIzW1xMdognksyHgu7rxGQS
        cEzyZikZ94E2xYy5gJaQtbELjF97oHALPuGRBZ5BdzSLs
X-Received: by 2002:a5e:d80d:: with SMTP id l13mr10860227iok.292.1565383828595;
        Fri, 09 Aug 2019 13:50:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxI1SP9OuDkUg/OXsKk070GlKuxTSKEH3aaxKSXWLs4BdgzEVHKjGr6MVXq/3ynn+VAePh2gQ==
X-Received: by 2002:a5e:d80d:: with SMTP id l13mr10860199iok.292.1565383828326;
        Fri, 09 Aug 2019 13:50:28 -0700 (PDT)
Received: from localhost ([2605:a601:ac3:c900:b0ef:bef9:a961:4eba])
        by smtp.gmail.com with ESMTPSA id q8sm6502315iob.3.2019.08.09.13.50.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 13:50:26 -0700 (PDT)
Date:   Fri, 9 Aug 2019 15:50:25 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, wireless-regdb@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless-regdb: Extend 5470-5725 MHz range to 5730 MHz
 for Taiwan (TW)
Message-ID: <20190809205025.GP10402@ubuntu-xps13>
References: <20190726030538.16784-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726030538.16784-1-wens@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Jul 26, 2019 at 11:05:38AM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> This range ends at 5725 MHz, but channel 144 extends to 5730 MHz.
> The Linux kernel however does not seem capable of considering them
> most restrictive subset of multiple rules.
> 
> Since 5725 ~ 5730 MHz belongs to the next range which has looser
> requirements, we can do this manually and extend the range by 5 MHz
> to make the kernel happy and be able to use channel 144.
> 
> Also, looking at the US regulations, which the TW ones are based on,
> The DFS range ends at 5730 MHz, while the next range starts at 5735
> MHz. This doesn't match the actual regulations, but is skewed to meet
> wireless channel boundaries. I prefer the database match the law,
> and be adjuested only if necessary.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> I have a vague impression that you asked about the range boundaries
> when I first updated the rules for Taiwan. And here we are again.

I don't recall, but I too prefer that we keep the boundaries mostly in
line with the regulations, not the wireless channel boundaries. Here it
does seem appropriate though to borrow the extra 5MHz into a more
rescrictive rule.

I wasn't sure about having rules with overlapping ranges. I've been
looking at the code though, and I don't see that it will be an issue. I
may give a few more days though to see if anyone else knows some reason
I missed that it could be a problem.

Thanks,
Seth

> 
> ---
>  db.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/db.txt b/db.txt
> index 37393e6..2e149b6 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1249,7 +1249,11 @@ country TW: DFS-FCC
>  	# 5.15 ~ 5.25 GHz: 30 dBm for master mode, 23 dBm for clients
>  	(5150 - 5250 @ 80), (23), AUTO-BW
>  	(5250 - 5350 @ 80), (23), DFS, AUTO-BW
> -	(5470 - 5725 @ 160), (23), DFS
> +	# This range ends at 5725 MHz, but channel 144 extends to 5730 MHz.
> +	# Since 5725 ~ 5730 MHz belongs to the next range which has looser
> +	# requirements, we can extend the range by 5 MHz to make the kernel
> +	# happy and be able to use channel 144.
> +	(5470 - 5730 @ 160), (23), DFS
>  	(5725 - 5850 @ 80), (30)
>  	# 60g band, LP0002 section 3.13.1.1 (3)(C), EIRP=40dBm(43dBm peak)
>  	(57000 - 66000 @ 2160), (40)
> -- 
> 2.20.1
> 
