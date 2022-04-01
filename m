Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471154EE61D
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 04:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244162AbiDACjp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Mar 2022 22:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244119AbiDACjp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Mar 2022 22:39:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC3D25A48B
        for <linux-wireless@vger.kernel.org>; Thu, 31 Mar 2022 19:37:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF036B8224A
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 02:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EC7C340ED;
        Fri,  1 Apr 2022 02:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648780673;
        bh=WlXoR074PAMbYjq1sF9KT4K76XJkp0FZ5uP8AdoG8uA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fui1IRjEXq0GmL4kKTgchTi5yC9RnVx9OvC9SZXnBKpzT2XFnFBqodB5SaGnFavyq
         Atjg0k25moCzTnnrA7750jj1YHwaVAr5El1KhUTmBLGlJlNAB40hSflEYwbjx/3+eM
         MzAd7EA8FrtcL8kcTBuwZeH+HNd7CFy+7DmWZ0aGYEmqGdPxvQPoU/cDRjHW9+uB5O
         feyjr4Xvv8UCvC0gP/Nq63BItPX8W+wFEfYPApKUTDZyQhjSJU2ebnNYilk8v7gyTJ
         owwbyHfcIm1ntwUP2U2Kn0rShvSnQyj+T0z7+WGiHZ+gUcUymIesXqcgLbg4SdmRcJ
         qn2XZNtIjRITA==
Date:   Thu, 31 Mar 2022 21:37:52 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Richard Huynh <voxlympha@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Australia
 (AU)
Message-ID: <YkZlgEfVfiR9EDjl@ubuntu-x1>
References: <20220328062250.15903-1-voxlympha@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328062250.15903-1-voxlympha@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Mar 28, 2022 at 05:22:51PM +1100, Richard Huynh wrote:
> Changes allowing lower portion of WiFi 6E spectrum. (5925-6425)
> 
> Amendment: https://www.legislation.gov.au/Details/F2022L00249
> Full text: https://www.legislation.gov.au/Details/F2022C00281
> 
> Allows for both 250mW EIRP indoors or 25mW outdoors.
> However, only the former limit is defined in this commit.
> 
> Signed-off-by: Richard Huynh <voxlympha@gmail.com>
> ---
>  db.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/db.txt b/db.txt
> index e887c73..15de29f 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -121,7 +121,7 @@ country AT: DFS-ETSI
>  	(57000 - 66000 @ 2160), (40)
>  
>  # Source:
> -# https://www.legislation.gov.au/Details/F2016C00432
> +# https://www.legislation.gov.au/Details/F2022C00281
>  # Both DFS-ETSI and DFS-FCC are acceptable per AS/NZS 4268 Appendix B.
>  # The EIRP for DFS bands can be increased by 3dB if TPC is implemented.
>  # In order to allow 80MHz operation between 5650-5730MHz the upper boundary
> @@ -133,6 +133,7 @@ country AU: DFS-ETSI
>  	(5470 - 5600 @ 80), (27), DFS
>  	(5650 - 5730 @ 80), (27), DFS
>  	(5730 - 5850 @ 80), (36)
> +	(5925 - 6425 @ 160), (24), NO-OUTDOOR, AUTO-BW
>  	(57000 - 66000 @ 2160), (43), NO-OUTDOOR

Thanks for the patch. One small issue though. AUTO-BW doesn't really
make sense here since the range isn't adjacent to any other ranges.
Otherwise it looks fine.

Thanks,
Seth
