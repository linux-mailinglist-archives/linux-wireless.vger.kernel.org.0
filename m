Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3539943D045
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 20:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238439AbhJ0SJE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 14:09:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230495AbhJ0SJE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 14:09:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 696E361040;
        Wed, 27 Oct 2021 18:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635357998;
        bh=9C4WXZSWSm8i+UevIYDwWe94/MoAul2XY6bUhMhBEaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SL3rtRB6EVXMfxVVq77pIKnOKLw3j1/7bZLV8e9I6y+MrCQUBL64EjlwQNH15XQXk
         zf4Fr66csbkoug8P8RQqB8GGCRWWmAwzReYA29RRz2UOa73pkHtQqL4gsFODm6mtze
         /PLMYmshXw6lMLnRylqLbthCSY32pVnGLBin04QdNpNJzH1JZadmrRnAlvhAgwL8P3
         WboQfeLOF555rGYTXrhcZGzx2ZGq6dttITzoDFfhy/50t34LUvLc+w9wrB4WaDBFPP
         73ffivc0GUuCsFC/9HS3kmnaTVhsYIcNKUgsTUx9H1iwek9mWb5+MnTPUt3He9BUfY
         7jVLjG0xfhXTQ==
Date:   Wed, 27 Oct 2021 13:06:37 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Sungbo Eo <mans0n@gorani.run>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory rules for South
 Korea (KR)
Message-ID: <YXmVLUzVEgrAMLwL@ubuntu-x1>
References: <20210929172728.7512-1-mans0n@gorani.run>
 <20211024113821.51538-1-mans0n@gorani.run>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211024113821.51538-1-mans0n@gorani.run>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Oct 24, 2021 at 08:38:21PM +0900, Sungbo Eo wrote:
> This patch is based on MSIT Public Notification 2020-113 ("Unlicensed Radio
> Equipment Established Without Notice"), officially announced on 2021-01-06.
> 
> The PSD must not exceed 2.5 mW/MHz if the frequency range includes all or
> part of 5230-5250 MHz and the bandwidth is equal to or less than 40 MHz.
> This leads to the following:
> * 5230-5250 @ 20 -> 17 dBm
> * 5210-5250 @ 40 -> 20 dBm
> Here the power limits for 80/160 MHz bandwidth are also lowered to 17 dBm,
> as it's not possible to set different power limits for different bandwidths
> at the moment.
> 
> Extend the last 5 GHz frequency range to 5850 MHz.
> 
> WiFi 6E is now allowed with the following restrictions:
> * Indoor: the full 1.2 GHz range, up to 160 MHz bandwidth and 250mW EIRP
> * Outdoor: the lower 500 MHz range, up to 160 MHz bandwidth and 25mW EIRP
> Here only the former entry is added.
> 
> And also update the regulatory source links.
> 
> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
> ---
> v2:
> * split 5150-5250 MHz band rule to accommodate the PSD limit
> * remove AUTO-BW flag from 6 GHz band rule
> ---
>  db.txt | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/db.txt b/db.txt
> index 6e8dbef..387ac93 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -862,15 +862,22 @@ country KP: DFS-JP
>  	(5490 - 5630 @ 20), (30), DFS
>  	(5735 - 5815 @ 20), (30)
>  
> +# Source:
> +# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000196972
> +# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000196973
> +# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000196974
>  country KR: DFS-JP
> -	# ref: https://www.rra.go.kr
>  	(2400 - 2483.5 @ 40), (23)
> -	(5150 - 5250 @ 80), (23), AUTO-BW
> +	(5150 - 5210 @ 40), (23), AUTO-BW
> +	# max. PSD 2.5 mW/MHz in 5230-5250 MHz frequency range
> +	(5210 - 5230 @ 20), (20), AUTO-BW
> +	(5230 - 5250 @ 20), (17), AUTO-BW

Even with 5210-5230 split out like this, 5210-5250 @ 40 still gets
limited to 17 dBm by the 5230-5250 rule. So why do we need to split out
5210-5230 separate from 5150-5210?

Thanks,
Seth

>  	(5250 - 5350 @ 80), (20), DFS, AUTO-BW
>  	(5470 - 5725 @ 160), (20), DFS
> -	(5725 - 5835 @ 80), (23)
> -	# 60 GHz band channels 1-4,
> -	# ref: http://www.law.go.kr/%ED%96%89%EC%A0%95%EA%B7%9C%EC%B9%99/%EB%AC%B4%EC%84%A0%EC%84%A4%EB%B9%84%EA%B7%9C%EC%B9%99
> +	(5725 - 5850 @ 80), (23)
> +	# 6 GHz band
> +	(5925 - 7125 @ 160), (24), NO-OUTDOOR
> +	# 60 GHz band channels 1-4
>  	(57000 - 66000 @ 2160), (43)
>  
>  country KW: DFS-ETSI
> -- 
> 2.33.1
> 
