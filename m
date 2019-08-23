Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D279B691
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2019 21:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390543AbfHWTAY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Aug 2019 15:00:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55582 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731649AbfHWTAY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Aug 2019 15:00:24 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1i1EnO-0002d8-Jd
        for linux-wireless@vger.kernel.org; Fri, 23 Aug 2019 19:00:22 +0000
Received: by mail-io1-f69.google.com with SMTP id f5so7543405ioo.11
        for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2019 12:00:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2xCDWtAOuGhTwQGtHSgHEJpr3T3/qJC9U+gjSN6qdjg=;
        b=sVXqd53Odq4mpVG871+G2B89fAMcpOlDXpYKyysZ49P5dt3U4XOa67/+lbgADbnnYS
         Ig3wgwUWfQ5HeQ2qpbw7Y8Gk/BbUa5x3bqwM06ZxemcflwqMFBSuVRv5iKcwL54Vqqnn
         oV7bJ+ytLuGp2+SEsXF/YoYMZaHJaMAxjLaMmuJrFouaMrmxVPnUUKoXidQMXg4S/Lh2
         nD726xRHMeDYauT4hXbI4niw1qwLumUTryGoYRxxGyKK5UHLijMLd5uSJdhfFTiBsJiM
         lBt1huZZUe8a/VjVlk3xLo7vVaQywgFf+dFBrDe3Gq97qp4l2jx+U90TteHSPS47+F3J
         lq/w==
X-Gm-Message-State: APjAAAWWplcumXMEudjOluoZ9vU5XXtmCbN6d3uJ10E4SG7Lv/rq5l0F
        2Uc46NAwh6633YR8PQdJrCy4E7mTxetA7VwAzQN8HeAU9GxoNvHJVPUjn12E7mdYGtVc+FNw58M
        NqsfsgHnhyqp/aUi3HQKJWAi+LdKYczrAmY+1DQaEWQFE
X-Received: by 2002:a5d:9e06:: with SMTP id h6mr4653765ioh.207.1566586821600;
        Fri, 23 Aug 2019 12:00:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz0QPgbNdg/FceUezQ8NM338KngpOm425+qTXwEgJ0M6XHVWWFmkzzUL/9lgMcJ84pEjSCUZw==
X-Received: by 2002:a5d:9e06:: with SMTP id h6mr4653708ioh.207.1566586821006;
        Fri, 23 Aug 2019 12:00:21 -0700 (PDT)
Received: from localhost ([2605:a601:ac3:9720:284b:e6e0:ec2a:c9ef])
        by smtp.gmail.com with ESMTPSA id y5sm4284234ioc.86.2019.08.23.12.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 12:00:20 -0700 (PDT)
Date:   Fri, 23 Aug 2019 14:00:19 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Dmitry Tunin <hanipouspilot@gmail.com>
Cc:     wireless-regdb@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wireless-regdb: update regulatory rules for Russia
 (RU) on 5GHz
Message-ID: <20190823190019.GZ3071@ubuntu-xps13>
References: <1564427246-25592-1-git-send-email-hanipouspilot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1564427246-25592-1-git-send-email-hanipouspilot@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jul 29, 2019 at 10:07:26PM +0300, Dmitry Tunin wrote:
> Russian entry is incorrect. According to the last regulations document of Feb 29, 2016,
> 160 MHz channels and 802.11ad are allowed.
> 
> http://rfs-rf.ru/upload/medialibrary/c1a/prilozhenie-1-k-resheniyu-gkrch-_-16_36_03.pdf
> 
> Note that there was never a DFS requirement in Russia, but always was
> NO-OUTDOOR on 5GHz.
> Maximum power is 200mW that is ~23dBm on all 5GHz channels.
> Also Russia has never been regulated by ETSI.
> 
> Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
> ---
>  db.txt | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/db.txt b/db.txt
> index 37393e6..d95ed5e 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1097,14 +1097,12 @@ country RS: DFS-ETSI
>  	# 60 GHz band channels 1-4, ref: Etsi En 302 567
>  	(57000 - 66000 @ 2160), (40)
>  
> -country RU: DFS-ETSI
> +country RU:
>  	(2402 - 2482 @ 40), (20)
> -	(5170 - 5250 @ 80), (20), AUTO-BW
> -	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
> -	(5650 - 5730 @ 80), (30), DFS
> -	(5735 - 5835 @ 80), (30)
> +	(5170 - 5350 @ 160), (23), NO-OUTDOOR
> +	(5650 - 5850 @ 160), (23), NO-OUTDOOR

Based on the translation I've read of the document you've linked to as
well as a couple of others, it sounds like the use of these ranges
requires TPC. Since TPC is not supported in Linux, we need to reduce the
max EIRP for these ranges to 20 dBm.

While modifying them, let's also update the 5170-5350 range to 5150-5350
to match the regulations.

Thanks,
Seth

>  	# 60 GHz band channels 1-4, ref: Changes to NLA 124_Order №129_22042015.pdf
> -	(57000 - 66000 @ 2160), (40)
> +	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
>  
>  country RW: DFS-FCC
>  	(2402 - 2482 @ 40), (20)
> -- 
> 2.7.4
> 
