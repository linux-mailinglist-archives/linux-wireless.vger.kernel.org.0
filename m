Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D74623025
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 17:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbiKIQ1S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Nov 2022 11:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiKIQ1R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Nov 2022 11:27:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22BC1A048
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 08:27:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 453ED61BB8
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 16:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796EAC433C1;
        Wed,  9 Nov 2022 16:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668011234;
        bh=Kf1Uav0Jvf3kL1HMfC7BCUlGrQ5MIRxDnA+H66XQ/5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TjTCYw+/Wyumyf0w26Wt7kXnhlh1kW5HbGJv1r8KFJc57mq3910Qbi+GHJ0FDgoKB
         wCiKuxJZsKxna1qxv+dIA0jlAkV5C7hsXQL1c7Ynflo/UeG/JoeFc1VkwETxt1Xwtb
         bcfXyS+7EE5odUQy2PiKJ92UVq/y6uZG9dygROwEINrS/fOE9ZzF+WlxCDSdQLvEof
         1kbSxE+r4Qkdr1PZgG2V3eTj4n8xJQjRWDbpv+SOcxJx6PZYUd2ch9iDn3U/punK7Z
         qTDFBLSIqDt2pdQLAo+2QzR+w9VMDU9GBZx++TO0nkZ4G8PRYPxXD1ca3mIZzfY8Uj
         sEwyqTTEkr40A==
Date:   Wed, 9 Nov 2022 10:27:13 -0600
From:   Seth Forshee <sforshee@kernel.org>
To:     CaffeeLake <pascalcoffeelake@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: wireless-regdb: Update regulatory rules for Japan (JP) on 6GHz
Message-ID: <Y2vU4YAs5wmibcGF@ubuntu-x1>
References: <20221030110510.752996-1-PascalCoffeeLake@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030110510.752996-1-PascalCoffeeLake@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Oct 30, 2022 at 08:05:10PM +0900, CaffeeLake wrote:
> Support 6GHz for JP Region.
> 
> The Ministry of Internal Affairs and Communications has approved 6GHz (5925 - 6425 MHz) in Japan.
> 
> Source: https://www.soumu.go.jp/main_content/000833682.pdf
> 
> Signed-off-by: CaffeeLake <PascalCoffeeLake@gmail.com>

Sorry for the slow response on your patches.

This patch conflicts with the other patch you sent for 5 GHz. I can
easily reconcile the conflict in the rules, but I cannot read the linked
documents (and machine translations is not proving very helpful). I
can't tell if the link in this patch supersedes the link from the other
patch, or if they are complimentary and should both be kept in the
database. Can you clarify, or else resend both as a series with the
second patch based off of the modifications from the first?

Thanks,
Seth

> ---
>  db.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/db.txt b/db.txt
> index 012824f..96527c9 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -907,6 +907,8 @@ country JO: DFS-JP
>  	(5170 - 5250 @ 80), (23)
>  	(5735 - 5835 @ 80), (23)
> 
> +# Source:
> +# https://www.soumu.go.jp/main_content/000833682.pdf
>  country JP: DFS-JP
>  	(2402 - 2482 @ 40), (20)
>  	(2474 - 2494 @ 20), (20), NO-OFDM
> @@ -914,6 +916,7 @@ country JP: DFS-JP
>  	(5170 - 5250 @ 80), (20), AUTO-BW
>  	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
>  	(5490 - 5710 @ 160), (23), DFS
> +	(5925 - 6425 @ 160), (200 mW), NO-OUTDOOR
>  	# 60 GHz band channels 2-4 at 10mW,
>  	# ref: http://www.arib.or.jp/english/html/overview/doc/1-STD-T74v1_1.pdf
>  	(57000 - 66000 @ 2160), (10 mW)
> --
> 2.37.3
> 
