Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059026437AF
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Dec 2022 23:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiLEWIV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 17:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiLEWIU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 17:08:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F55C558F
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 14:08:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D655461477
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 22:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB43C433D6;
        Mon,  5 Dec 2022 22:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670278095;
        bh=gHqtxLNinWHlwCLy2Fxuy4wHAPCR+sLgYbAsrBrnwNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c9Gn9u0XRw4YZzhpJ2snv19QxiKCQca0JVqEPJiL70BcZzaxs9RV1OG9tqtUvR7Kq
         yJeEjCcKSrTpoRL9bSMOsIIB8HmK4VqrqPBhLwyrSdj2CpQVN0A8YI6e3x+ujG5yF/
         M52q2+QUW75E2GZn4aGZueRntodSkrelTxlL0srZyzmNkHau0ON1TKBqANkf6QDU4I
         LdnSwl96+792l2Wt3rBG3ZuSj3bmh7XVAVhgfPxc7fFkMtnGFcAI3sZlvI59yAJIQs
         4+ATOeGwRqLF3/z1d6QnvsAHIjhVwiOjG81ayCZHnpVtgnbIoOvtJX2/0rF9h1Txn4
         WMMEnC4zlntZA==
Date:   Mon, 5 Dec 2022 16:08:13 -0600
From:   Seth Forshee <sforshee@kernel.org>
To:     JUN-KYU SHIN <jk.shin@newratek.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless-regdb: add support for KR S1G channels
Message-ID: <Y45rzTlZvlFrqao/@ubuntu-x1>
References: <20221122024550.11415-1-jk.shin@newratek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221122024550.11415-1-jk.shin@newratek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Nov 22, 2022 at 11:45:52AM +0900, JUN-KYU SHIN wrote:
> The 917-923.5MHz band is KR USN 1 band, so follows
> the emmision limists described in part 8.4.4
> 
> The 925-931MHz band is KR USN 5 band, so follows
> the emmision limists described in part 8.8.1
> 
> Signed-off-by: JUN-KYU SHIN <jk.shin@newratek.com>

Thanks for the patch. I have some questions and comments, below.

> ---
>  db.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/db.txt b/db.txt
> index 012824f..1b4fe11 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -950,7 +950,14 @@ country KP: DFS-JP
>  # https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000205195
>  # https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000205187
>  # https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000206568
> +# https://www.law.go.kr/LSW//admRulLsInfoP.do?chrClsCd=&admRulSeq=2100000211335
>  country KR: DFS-JP
> +	# S1G Channel USN 1 (917 - 923.5)
> +	(920.5 - 921.5 @ 1), (10)
> +	(921.5 – 922.5 @ 1), (14)

I don't know anything about S1G channels in Korea so I'm curious -- are
these the only 2 channels defined in the 917-923.5 range?

> +	# S1G Channel USN 5 (925 - 931)
> +	(926 - 930 @ 1), (17)
> +	(926 - 930 @ 2), (20)

This unfortunately doesn't work. While it's possible to have both rules
in the database, to the best of my recollection the kernel only ends up
using the one with the larger bandwidth to set the power limit. So then
the higher power limit would also be used for 1MHz channels.

Thanks,
Seth

