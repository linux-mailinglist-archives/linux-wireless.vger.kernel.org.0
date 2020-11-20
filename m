Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB50E2BB1D0
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Nov 2020 18:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgKTRyx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Nov 2020 12:54:53 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56199 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgKTRyx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Nov 2020 12:54:53 -0500
Received: from mail-oi1-f199.google.com ([209.85.167.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1kgAcT-0004SX-OL
        for linux-wireless@vger.kernel.org; Fri, 20 Nov 2020 17:54:49 +0000
Received: by mail-oi1-f199.google.com with SMTP id q126so3053868oig.17
        for <linux-wireless@vger.kernel.org>; Fri, 20 Nov 2020 09:54:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=E3uR7jMaBu/7ePN/eyfqVzGQGpue9X6zvkz4/9wsWZ4=;
        b=YUU6vgZ5K5JV3/OJOaz7YgxCKSH07rNFQaD4e7zacahvfYcNG3Y1K00xN9UqAraSoI
         fsHzOqsrRUtw0VjoyzfuzcmUCslxRlZUjGCZQnKjo0HXGj2KVWv/bz+Ll4YgXMfLBUEP
         izy3lBTbPTN5QunYp0zDj2H661LsimHR10S090V/HN/5StDR0mQmVYi4ZEoSK9JGTOG9
         JPllt9NmcvjnOKskL9NV9N3XTJDN7JvxaEJg+t1mIzYzeecL0MDUhKwvAEkLyG6mp8vZ
         3epWfeiu1wbsagMJ2YLp64JUv4UXxMmwzO1rJmKWEHnBwo2Hb/w28wUhoKAc5C+9Go8A
         vrwQ==
X-Gm-Message-State: AOAM533kiCMKQDvRg3rdgTqxPkfJVXtvvQWakhQkPoXjlx80Vj7FZ0SL
        X2Xg7CiA3bDUdZK+Zb6IhkLgEYw2xkYtRfUpfYTm2WBv/W/pHnYd03e+KaMOD2N/GtAxzvKZYUz
        W3wujpVKVXVuxHkhUFF7dbzPfDH7ZM3J6plCQXkxoM9H9
X-Received: by 2002:a05:6830:1c76:: with SMTP id s22mr3662869otg.233.1605894887170;
        Fri, 20 Nov 2020 09:54:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuseog+gX9gFl9wTxEgj51eiuni+uLgBATZU1KHdm8UtGNs2ugFakLLrOmyE1Oupr0I9MAfQ==
X-Received: by 2002:a05:6830:1c76:: with SMTP id s22mr3662805otg.233.1605894885417;
        Fri, 20 Nov 2020 09:54:45 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:1158:e034:1c89:296f])
        by smtp.gmail.com with ESMTPSA id u130sm1974356oib.53.2020.11.20.09.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 09:54:44 -0800 (PST)
Date:   Fri, 20 Nov 2020 11:54:44 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Ed W <lists@wildgooses.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] Correction of wireless-regdb for GB
Message-ID: <20201120175444.GN5439@ubuntu-x1>
References: <4d07581c-a3be-a3c6-bf32-7007eb45d541@wildgooses.com>
 <20201106214446.GG6125@ubuntu-x1>
 <2a710032-f2ec-d55b-5da4-d881089fe0cd@wildgooses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a710032-f2ec-d55b-5da4-d881089fe0cd@wildgooses.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Nov 13, 2020 at 06:49:40PM +0000, Ed W wrote:
> Hi Seth
> 
> Thanks for patching this. Can I also bring a later patch that I posted to your attention, the actual
> patch is now out of date, but I'm posting verbatim since I think there is a 25Mhz discrepancy (?)
> and also my patch is almost certainly wrong, so I'm after your guidance!! :-)
> 
> Essentially there has been a recent result of a consultation in the UK (GB) to expand wifi into 6Ghz
> *AND* to NOT require DFS on high 5Ghz channels.

I've looked through the 6 GHz statement. One thing I'm not clear on is
whether the decision is effective immediately or only once the relevant
regulatory documents have been ammended (as noted in section 6.3). I did
not find an updated IR 2030 at least, so I wonder if these changes
should wait for that.

> So in summary, the change you just made (sorry) can now be set to *NOT* need DFS in the high
> channels around 5.7Ghz. More details in the links below.

The document only seems to state that the DFS requirement is removed for
indoor use up to 200 mW EIRP. So this range may also need to have
NO-OUTDOOR added if DFS is removed. Hopefully when IR 2030 is updated
the restrictions will be clear.

> In particular one of the additional frequency ranges (6Ghz) has an intended use of indoor where it
> has large power outputs (and encouraged to use larger powers by request of Intel), but it is *ALSO*
> allowed to be used outdoor with very low power requirements (possibly it will later fall under the
> UK's allowance to use higher output power if you buy a £50 licence?). I've marked it as INDOOR-ONLY
> since that seems safest - I'm unclear how to mark something for dual use?

I don't think that's something we've ever done. The regdb can contain
two entries for the same range in a given country, I'm not sure how that
will be handled by the kernel though. I'll have to look at the code.

> These changes significantly expand the available 5Ghz space in the UK, so would be nice to get
> upstream for general use
> 
> 
> Notes:
> 
> https://www.ofcom.org.uk/__data/assets/pdf_file/0036/198927/6ghz-statement.pdf
> 
> https://www.ofcom.org.uk/__data/assets/pdf_file/0028/84970/ir-2030.pdf
> 
> Thanks if you might make this second change!
> 
> Ed W
> 
> 
> On 06/11/2020 21:44, Seth Forshee wrote:
> > Sorry for not responding sooner. I had started to look into this when
> > you sent the message, but I had to set it aside and then forgot to pick
> > it back up.
> 

> From ee0aad4566b206f313e92ab4ae98f786767892cd Mon Sep 17 00:00:00 2001
> From: root <root@twocubed.nippynetworks.lan>

Can this be changed so that the patch author is the same as the
information in the sign-off?

> Date: Thu, 17 Sep 2020 13:31:18 +0000
> Subject: [PATCH] Update regulatory rules for UK (GB)
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> The IR-2030 document on p47 clarifies a difference for the UK on
> 5725-5850Mhz from the rest of the UK. Power levels are higher and it's
> possible to raise these further by purchasing a 50 GBP radio licence.
> 
> Since Jan 2020 Ofcom has solicited comments on further deregulating this
> band to bring it into global alignment. DFS requirements have been
> removed and a new band in the 6Ghz space has been made available with
> 250mW power levels (indoor, 25mW outdoor), also with no DFS requirement.
> 
> Signed-off-by: Ed Wildgoose <lists@wildgooses.com>
> ---
>  db.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/db.txt b/db.txt
> index ac32483..cc5ffd0 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -588,13 +588,16 @@ country FR: DFS-ETSI
>  # GB: https://www.ofcom.org.uk/__data/assets/pdf_file/0019/136009/Ofcom-Information-Sheet-5-GHz-RLANs.pdf
>  # GB: https://www.ofcom.org.uk/__data/assets/pdf_file/0028/84970/ir-2030.pdf
>  # GB: https://www.ofcom.org.uk/__data/assets/pdf_file/0013/126121/Statement_Implementing-Ofcoms-decision-on-the-57-71GHz-band.pdf
> +# GB: https://www.ofcom.org.uk/__data/assets/pdf_file/0036/198927/6ghz-statement.pdf
>  country GB: DFS-ETSI
>  	(2400 - 2483.5 @ 40), (100 mW)
>  	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
>  	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
> -	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
> +	(5470 - 5730 @ 160), (500 mW), DFS, wmmrule=ETSI

This looks okay to me.

>  	# short range devices (ETSI EN 300 440-1)
> -	(5725 - 5875 @ 80), (25 mW)
> +	# See UK specific notes in ir-2030.pdf, p47
> +	(5725 - 5850 @ 80), (200 mW), AUTO-BW, wmmrule=ETSI

To echo what I said above, I'm unclear whether this change is in effect
yet, and based what I've seen so far I think it would need to include
NO-OUTDOOR.

> +	(5925 - 6425 @ 160), (250 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI

I'm also unclear on whether this change is in effect yet.

Thanks,
Seth

>  	# 60 GHz band channels 1-6
>  	(57000 - 71000 @ 2160), (40)
>  
> -- 
> 2.26.2
> 

