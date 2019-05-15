Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA881F4FD
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 15:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfEONDq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 09:03:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43572 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbfEONDp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 09:03:45 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1hQtZO-0006S2-Hn
        for linux-wireless@vger.kernel.org; Wed, 15 May 2019 13:03:42 +0000
Received: by mail-it1-f199.google.com with SMTP id u131so2244715itc.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 May 2019 06:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1WSg3T7/u7RgCKA63lghqekZFO/UGgRJHPX+75ylk4w=;
        b=qUHpcM5Zp6p90DvyPUqHastTLH13pS1AOCXf4A/gs2h5vRP5wFBw78n/XWzy0Idzk9
         uG5kfRM/HQR7skA7jOIkEvNGBS2Qq1kfEiS+sIBp5epRdpLo3ldTTCpM+z+3vJNPsNkv
         yXzNHh07eSdEbhsTxCEjYAzdo7YikV/oQmRDMapSfwlbWfRxTxoGaZ9odUyCujRB+E8m
         3w122SV1IuuLUhpTJPCe3yLuXH0cfgHnEaflRZQ0XsDkoo37O7Uc0Ju7Dy/0cyHslmLQ
         OMCTR9F6h+iJX/Dy9qxJHeqk9+YZFzL4D3un7jTu/EeCrzxmEj5eVMTdgqQntz5p2c/3
         p1MQ==
X-Gm-Message-State: APjAAAV5pftVUsddUJI27GAywO+vqzvhkaMuBF5+TLyW70HoE3TSFEn6
        Uz6ewr9Q/xyrEPSffXUM2UepLAION7JST/aZ5GHJJsYyq+Qv9xOSzTRNu7FJlBe0522A6drx582
        U6MkGCxCgDmt0cOTJeHEwKCSy8ISTwJNigvmgCk9ihMTq
X-Received: by 2002:a24:108b:: with SMTP id 133mr7917782ity.15.1557925421134;
        Wed, 15 May 2019 06:03:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzQ0UDQmitbngayAjBZklqAqLQfsyWQt/SNP9NgB5pJnVmI78dstPZgXC8LAHRWFPiOFcWjQg==
X-Received: by 2002:a24:108b:: with SMTP id 133mr7917755ity.15.1557925420813;
        Wed, 15 May 2019 06:03:40 -0700 (PDT)
Received: from localhost ([2605:a601:ac2:fb20:4dea:9e3c:35e:c3dc])
        by smtp.gmail.com with ESMTPSA id 139sm99244itv.38.2019.05.15.06.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 06:03:40 -0700 (PDT)
Date:   Wed, 15 May 2019 08:03:39 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Peter Oh <peter.oh@bowerswilkins.com>
Cc:     "wireless-regdb@lists.infradead.org" 
        <wireless-regdb@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [wireless-regdb] [PATCH v2] wireless-regdb: Update regulatory
 rules for South Korea
Message-ID: <20190515130339.GY4357@ubuntu-xps13>
References: <1556314283-17842-1-git-send-email-peter.oh@bowerswilkins.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556314283-17842-1-git-send-email-peter.oh@bowerswilkins.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Apr 26, 2019 at 09:31:31PM +0000, Peter Oh wrote:
> From: Peter Oh <peter.oh@bowerswilkins.com>
> 
> Update power limit as documented in:
> http://www.law.go.kr/%ED%96%89%EC%A0%95%EA%B7%9C%EC%B9%99/
> %EC%8B%A0%EA%B3%A0%ED%95%98%EC%A7%80%EC%95%84%EB%8B%88%ED
> %95%98%EA%B3%A0%EA%B0%9C%EC%84%A4%ED%95%A0%EC%88%98%EC%9E
> %88%EB%8A%94%EB%AC%B4%EC%84%A0%EA%B5%AD%EC%9A%A9%EB%AC%B4
> %EC%84%A0%EA%B8%B0%EA%B8%B0/(2018-89,20181227)
> which revised on December 27, 2018.
> 
> Signed-off-by: Peter Oh <peter.oh@bowerswilkins.com>
> ---
>  db.txt | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/db.txt b/db.txt
> index 4fb1948..8d24305 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -695,11 +695,12 @@ country KP: DFS-JP
>  	(5735 - 5815 @ 20), (30)
>  
>  country KR: DFS-JP
> -	(2402 - 2482 @ 40), (13)
> -	(5170 - 5250 @ 80), (20), AUTO-BW
> -	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
> -	(5490 - 5710 @ 160), (30), DFS
> -	(5735 - 5835 @ 80), (30)
> +	# ref: https://www.rra.go.kr
> +	(2402 - 2482 @ 40), (23)
> +	(5170 - 5250 @ 80), (23), AUTO-BW
> +	(5250 - 5330 @ 80), (23), DFS, AUTO-BW
> +	(5490 - 5710 @ 160), (23), DFS
> +	(5735 - 5835 @ 80), (23)

Is there any mention of transmit power control in the document? The fact
that some of the old limits are exactly half of they values you've given
makes me wonder if they weren't set lower for TPC, especially for
5250-5350 MHz where TPC is common.

Since you're changing these rules, I'd also like to see the frequency
ranges changed to match the documented ranges, i.e.:

 2400 - 2483.5
 5150 - 5250
 5250 - 5350
 5470 - 5710
 5735 - 5850

I left the gap in the 5470-5850 MHz range since I can't tell exactly
where the DFS requirement ends. Usually it seems to be 5725 MHz, but
that is not universal. If you can determine where the break is those
ranges could also be expanded.

Thanks,
Seth
