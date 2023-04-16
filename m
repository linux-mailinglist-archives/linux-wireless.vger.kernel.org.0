Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493276E34B0
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Apr 2023 04:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjDPCEG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Apr 2023 22:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDPCEF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Apr 2023 22:04:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F612D40
        for <linux-wireless@vger.kernel.org>; Sat, 15 Apr 2023 19:04:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 827B161456
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 02:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CA4C433EF;
        Sun, 16 Apr 2023 02:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681610641;
        bh=q1FTlBqay/1717eiEnGsLCQSlHrD3nGHP9zmYGzR5qg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YLRbiitkc29RL3ivVLjHcFRY6n/vQ0cv1czgWcqUaV1Tg7gc8AQ2P8a6P89y6BLf7
         RDzuaScBSlAUl/3vLRfloRYyJhqEPIscVnZ4TUT2HDPy8UDfqzgWA+NzHafzgqO7U4
         FpV6vfyxE7+ZX5j+q+xPofOrkRTVCXPO4gZqkQk5hHJYxUNgpC4q9qtu/BWiKRC0zT
         g2EcykeM+CEgsPvacC6sbPcxgOaKf8rkdMcKJJcSFspelXj+TIvLbW0y677abHoSTy
         tqOKHlhLcSsnGN/Nhila38F0r5GzaWbnxaOKHV8p/9XPWjOjQUcEWF5bLF0a6fC8cq
         98lzIKOvqCqqA==
Date:   Sat, 15 Apr 2023 21:04:00 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Kirill <me@16depo.xyz>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [wireless-regdb] [PATCH] Update regulatory info for Russia (RU)
 on 6GHz
Message-ID: <ZDtXkCWhUQnYlNMm@ubuntu-x1>
References: <411a77cb-47f1-2f97-76c6-939c024654b4@16depo.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <411a77cb-47f1-2f97-76c6-939c024654b4@16depo.xyz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, Mar 25, 2023 at 04:04:37AM +0300, Kirill wrote:
> Update regulatory info for Russia on 6GHz in
>  accordance with current regulatory rules.
> 
> Source: https://docs.cntd.ru/document/1300597464?section=text
> 
> Signed-off-by: Kirill Matvienko <me@16depo.xyz>

Thanks for the patch.

Based on the document I think the rule is right. My only question is
whether or not this change is in effect yet. I ask because when I look
at [1], which is the document amended by the document you linked to, I
don't see this change. I'm not familiar with the process in Russia, so I
just want to confirm that the change is in effect before we update the
database.

Thanks,
Seth

[1] https://docs.cntd.ru/document/902048009

> ---
>  db.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/db.txt b/db.txt
> index 915a3b9..7f338b2 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1500,11 +1500,12 @@ country RS: DFS-ETSI
>  	# 60 GHz band channels 1-4, ref: Etsi En 302 567
>  	(57000 - 66000 @ 2160), (40)
> 
> -# Source: https://docs.cntd.ru/document/902048009?section=text
> +# Source: https://docs.cntd.ru/document/1300597464?section=text
>  country RU: DFS-ETSI
>  	(2400 - 2483.5 @ 40), (20)
>  	(5150 - 5350 @ 160), (100 mW), NO-OUTDOOR, DFS
>  	(5650 - 5850 @ 160), (100 mW), NO-OUTDOOR, DFS
> +	(5925 - 6425 @ 160), (100 mW), NO-OUTDOOR
>  	# 60 GHz band channels 1-4, ref: Changes to NLA 124_Order
> №129_22042015.pdf
>  	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
> 
> -- 
> 2.34.1
