Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129FC6437B8
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Dec 2022 23:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiLEWJ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 17:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbiLEWJ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 17:09:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D2EBE00
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 14:09:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53B0861484
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 22:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA9DC433C1;
        Mon,  5 Dec 2022 22:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670278165;
        bh=60NlLFX+EDU05h3PfVBbqUOSwhIMzkLYZPYAqEyh4c8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6+AE79FTTV5QgHBExtZ2Gr78p+6x9Z7eFIp9i8sNGedsVe/WbOcbsj+TjtYFa2ND
         K2rlVvRinpFt2oVQM5/VyYkmjNjYpPzTHzd/oPpaLR79GlQmEADFTbH3QgKrA2sgqh
         ATKRbhWK0rscpaLQy6oy8fkxMmy1dmUVM9xBj30qn2pJlG77XAX6CszZcd4zjYE4HP
         JbT0888aI9YdwDbyKFJm16w8I4FkMXTZ8nsPDwilSlXFMC8CaDPGOSj81Pzpat3tOv
         z3YPGldZeislAGh1hY5Mq/+uMHCGb7UMRfspdIEq8XMdXLtwaSak56PmK3eqQY4JgD
         ffcL5oGcHDh8Q==
Date:   Mon, 5 Dec 2022 16:09:24 -0600
From:   Seth Forshee <sforshee@kernel.org>
To:     CaffeeLake <pascalcoffeelake@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: wireless-regdb: Update regulatory rules for Japan (JP) on 5GHz
Message-ID: <Y45sFNcWYpISRYXa@ubuntu-x1>
References: <20221017025204.1370004-1-PascalCoffeeLake@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017025204.1370004-1-PascalCoffeeLake@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Oct 17, 2022 at 11:52:04AM +0900, CaffeeLake wrote:
> Support 144ch for JP Region.
> 
> The Ministry of Internal Affairs and Communications has approved 144ch in Japan.
> 
> Source: https://www.soumu.go.jp/main_content/000635492.pdf
> 
> Signed-off-by: CaffeeLake <PascalCoffeeLake@gmail.com>

Applied, thanks!

> ---
>  db.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/db.txt b/db.txt
> index 012824f..8b3827a 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -907,13 +907,15 @@ country JO: DFS-JP
>  	(5170 - 5250 @ 80), (23)
>  	(5735 - 5835 @ 80), (23)
> 
> +# Source:
> +# https://www.soumu.go.jp/main_content/000635492.pdf
>  country JP: DFS-JP
>  	(2402 - 2482 @ 40), (20)
>  	(2474 - 2494 @ 20), (20), NO-OFDM
>  	(4910 - 4990 @ 40), (23)
>  	(5170 - 5250 @ 80), (20), AUTO-BW
>  	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
> -	(5490 - 5710 @ 160), (23), DFS
> +	(5490 - 5730 @ 160), (23), DFS
>  	# 60 GHz band channels 2-4 at 10mW,
>  	# ref: http://www.arib.or.jp/english/html/overview/doc/1-STD-T74v1_1.pdf
>  	(57000 - 66000 @ 2160), (10 mW)
> --
> 2.37.3
> 
