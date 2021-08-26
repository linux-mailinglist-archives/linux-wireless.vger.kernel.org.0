Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAEF3F8A26
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 16:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242843AbhHZOdW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 10:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242708AbhHZOdV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 10:33:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D000360FC1;
        Thu, 26 Aug 2021 14:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629988354;
        bh=+OvWSAv6eT2o2f8090dQ6SlXbDQ2R+xHr4AY/G7zmcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CRfyvN4w42pUmfauqzgOQgfSvbPTEWKVp+ZPpaQcqiDqdIvzP3qGr7flvgaKCDhFQ
         9uDQ214uDl94npSSewfc2ARnbxhmuZJYAmJXMXmX7kytkwGkKht8KhN0kp2t8QdDl2
         RMrX/wA+KY1dqV/xgLc21pr/FRgcUne2AYfarPHN38a5VhRNc5lTifhXa7FLC+rB1R
         UmAonIe6eFGWUS8WXjXW5yJ75R1+vqupB7U1Qf1jVP7BT2PEOWnPo0lq19d0T3nDMP
         wqhcrAJBD4oTRbV9SmGYX/UeNVApCQa6sIRo9/KPoou8imqlhceNhQy3J0+PwbZe7U
         efzfytpx3K7Xg==
Date:   Thu, 26 Aug 2021 09:32:32 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Victor Bayas <victorsbayas@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] Update regulatory rules for Ecuador (EC)
Message-ID: <YSemAGfADr2WTey8@ubuntu-x1>
References: <20210825031409.10552-1-victorsbayas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825031409.10552-1-victorsbayas@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Aug 24, 2021 at 10:14:09PM -0500, Victor Bayas wrote:
> Update the frequency ranges and power limits according to the current Ecuadorian norm [1],
> corrected 5GHz maximum bandwidth since there are no legal restrictions in this subject.
> 
> Note: 60GHz channels 1 to 3 are allowed without license for Point-to-Point links but
> they aren't for Point-to-Multipoint links so they were omitted in this patch.
> 
> [1] https://www.arcotel.gob.ec/wp-content/uploads/2018/04/NORMA-ESPECTRO-DE-USO-LIBRE-Y-ESPECTRO-PARA-USO-DETERMINADO-EN-BANDAS-LIBRES.pdf
> 
> Signed-off-by: Victor Bayas <victorsbayas@gmail.com>

Thanks for the patch! A few comments below.

> ---
>  db.txt | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/db.txt b/db.txt
> index e7b11cf..4630854 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -504,12 +504,14 @@ country DZ: DFS-JP
>  	(5250.000 - 5330.000 @ 80.000), (23.00), DFS, AUTO-BW
>  	(5490.000 - 5670.000 @ 160.000), (23.00), DFS
>  
> +# Source:
> +# https://www.arcotel.gob.ec/wp-content/uploads/2018/04/NORMA-ESPECTRO-DE-USO-LIBRE-Y-ESPECTRO-PARA-USO-DETERMINADO-EN-BANDAS-LIBRES.pdf
>  country EC: DFS-FCC
> -	(2402 - 2482 @ 40), (20)
> -	(5170 - 5250 @ 20), (17)
> -	(5250 - 5330 @ 20), (24), DFS
> -	(5490 - 5730 @ 20), (24), DFS
> -	(5735 - 5835 @ 20), (30)
> +	(2400 - 2483.5 @ 40), (1000 mW)
> +	(5150 - 5250 @ 80), (50 mW), AUTO-BW

It looks like 5150-5250 MHz also requires DFS.

> +	(5250 - 5350 @ 80), (250 mW), AUTO-BW, DFS
> +	(5470 - 5725 @ 160), (250 mW), DFS

5250-5350 and 5470-5725 MHz require TPC. Since Linux does not support
TPC the power limits need to be reduced by 3 dBm, which puts them at 125
mW.

I also don't see any DFS requirement for 5470-5725 MHz.

Thanks,
Seth
