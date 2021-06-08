Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0CE39FB29
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jun 2021 17:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhFHPtX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Jun 2021 11:49:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39040 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhFHPtX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Jun 2021 11:49:23 -0400
Received: from mail-ot1-f69.google.com ([209.85.210.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth.forshee@canonical.com>)
        id 1lqdwv-0007Sq-M9
        for linux-wireless@vger.kernel.org; Tue, 08 Jun 2021 15:47:29 +0000
Received: by mail-ot1-f69.google.com with SMTP id i25-20020a9d4a990000b0290304f00e3e3aso14188663otf.15
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jun 2021 08:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TyScfg/oM8iD/sV5qeKxAbaE4446/B55bTHzQgvx9H4=;
        b=PfELmBONavFcHXdB9HrXXpG2ofxAQ+PYU1QJ1JzQblJ0rqty2MQ7OwZoQ+ie9nmKR9
         o4YwUZk4c/naWun3k4+9AiW2yBbpQyiHd4GPEMv4eRRYs5QW2OZcimy3n4eURB694h/Q
         w1MSeGxbYavQIFXh0rLQnePdCaPtjV6fJ2DBNjerFn+MigSqNRUnTikD4mKQltscAPcP
         f/73ZhxpVUBb80pyCgzSocdv/Yjz5DDHdjvM7V0oLQL15Cw4jvzePOe0s7n1Xvu89rpx
         vIMZNZ+FCsGlQGjf6oSq5Zzkg9D3wrwVEEta8IU8aos08qK6HymCoDuQs3S4SEAT9/Vy
         0Skw==
X-Gm-Message-State: AOAM531SkEEyjCauE0N9uxnTZvFuBILEtMZ6nfXljSuklOjKN2DWBJIZ
        L2ny5sJkMWm3UfR0qKRDDeKy6Lc4enzdHKPcyZbEF/AqwrW+3sMVbCEAVegglmmulIcJoBGF9hF
        dAe/lHrkV9MCd2vht87XxsU1zm14NXi1jfvR5vyzm+Vng
X-Received: by 2002:a05:6830:17c8:: with SMTP id p8mr3068452ota.167.1623167248667;
        Tue, 08 Jun 2021 08:47:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy08Y1s6n+YPatayBwJ6ghi+3uSsIqqc7hnXTW4ATJiB07Mh1fPFO1IwK1BUY8owR7MTKafOg==
X-Received: by 2002:a05:6830:17c8:: with SMTP id p8mr3068431ota.167.1623167248366;
        Tue, 08 Jun 2021 08:47:28 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:7771:da70:ed55:6011])
        by smtp.gmail.com with ESMTPSA id f7sm2885816oot.36.2021.06.08.08.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 08:47:27 -0700 (PDT)
Date:   Tue, 8 Jun 2021 10:47:26 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     bkil <b.K.il.h.u+tigbuh@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless-regdb: recent FCC report and order allows
 5850-5895 immediately
Message-ID: <YL+RDtGatz/ybG+M@ubuntu-x1>
References: <a79286b90cdfdee3a83397008c0f7b6d67bc7f69.1607035229.git.b.K.il.h.u+tigbuh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a79286b90cdfdee3a83397008c0f7b6d67bc7f69.1607035229.git.b.K.il.h.u+tigbuh@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Dec 03, 2020 at 11:40:30PM +0100, bkil wrote:
> The new band is called U-NII-4.
> 
> The report recommends combining it with 5725-5895 to allow 160 MHz
> bandwidth, but that's technically not that easy with regdb due to the
> differing restrictions of the two parts. Marking the line for U-NII-3
> NO-OUTDOOR and PTMP-ONLY along with extending its range would be a
> possible workaround, but this needs to be discussed.
> 
> I don't see a requirement for TPC, hence reducing EIRP by 3dB is not
> needed. I've marked it 33dBm (minus 6dB for clients) to cope with 20MHz,
> but the band can support higher power, though the logic is complicated.
> 
> The upper subband (5895-5925 MHz) of the new band is reserved for ITS.
> 
> "We limit unlicensed use to indoor operations in recognition of the
> potential that ITS licensees may currently be operating"
> 
> "We also proposed that U-NII-4 devices be permitted to operate at the same
> power levels as U-NII-3 devices."
> 
> "For the U-NII-4 band, indoor access point EIRP will be limited to
> 33 dBm/20 MHz and 36 dBm/40 MHz. When combined with U-NII-3 band spectrum,
> indoor access point EIRP can scale to 36 dBm for 80 and 160 megahertz
> channels."
> 
> "Client devices would be limited to power levels 6 dB below the power
> limits for access points."
> 
> "the First Report and Order prohibit U-NII-4 client-to-client
> communications to protect co-channel incumbent ITS"
> 
> Signed-off-by: bkil <b.K.il.h.u+tigbuh@gmail.com>

I'm not sure why this was delayed, but it looks like it has finally gone
into effect as of June 2:

https://www.federalregister.gov/documents/2021/05/03/2021-08802/use-of-the-5850-5925-ghz-band

We discussed some of the details before. I'm reading over it again to
refresh my memory, so let's revisit the changes I think are required,
below.

> ---
>  db.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/db.txt b/db.txt
> index c71a03a..e6dd063 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1587,7 +1587,10 @@ country US: DFS-FCC
>  	# requirements, we can extend the range by 5 MHz to make the kernel
>  	# happy and be able to use channel 144.
>  	(5470 - 5730 @ 160), (23), DFS
> -	(5730 - 5850 @ 80), (30)
> +	(5730 - 5850 @ 80), (30), AUTO-BW
> +	# https://www.fcc.gov/document/fcc-modernizes-59-ghz-band-improve-wi-fi-and-automotive-safety-0
> +	# max. 33 dBm AP @ 20MHz, 36 dBm AP @ 40Mhz+, 6 dB less for clients
> +	(5850 - 5895 @ 40), (27), NO-OUTDOOR, PTMP-ONLY, AUTO-BW

I think we concluded previously that both 5730-5850 and 5850-5895 should
have a max bandwidth of 160 MHz to permit use of 160 MHz across these
channels.

We also discussed using NO-IR for 5850-5895. The regulations forbid
active scans, and PMTP-ONLY does not prevent them. NO-IR appears to be
the only option which conforms to this restriction, though that will
also block running an AP in this range.

I also read the max EIRP for clients as 30 dBm without any TPC
requirement. Did I overlook something which limits the EIRP to 27 dBm?

Thanks,
Seth
