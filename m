Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1B7681B05
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jan 2023 21:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbjA3UBB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Jan 2023 15:01:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbjA3UBA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Jan 2023 15:01:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01EB46732
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 12:00:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CBC361242
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jan 2023 20:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3094C433D2;
        Mon, 30 Jan 2023 20:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675108857;
        bh=v+QlseagKWlkWVyOe9U4TBpmBYCYpxMnEfZkR0muANk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bmnPyBA1zYC0DPeOnmxnjmNHLpGQuZS3iM8SCtLb7yAk1UCnFyn3du7P4X0xWRCuN
         DNVzoSUKDiC68BFhvKjmK+zMXWetPvlRgDymd/3S5fYGnbWdxBVGpGVcMlWjcz9V8c
         mstwRrPRjXYsPgfZseXu+qFLk85c+yJmz/DMxND3F/fjnyagt+TDaiNj7xmMRe0/n6
         3KL8WcF3B7x5eE+kM1V4lpDsy2PcCCbzBGc59NjbW3A6tnpbd/Kqh86qH85n0mloyo
         3vo3CJGI3bSEnNNFF38NiB1/pABUrMd7ygboyv0a5SI/J8amOwyjM+Ve4MWO0A4r0Q
         ijztgPcgPuq3A==
Date:   Mon, 30 Jan 2023 14:00:55 -0600
From:   Seth Forshee <sforshee@kernel.org>
To:     Eugene Konev <uejikov@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] Update regulatory info for Russia (RU) on 5GHz
Message-ID: <Y9gh95UAejRxQ4Oy@do-x1extreme>
References: <CAO7DJoAXrB8e+q2uHD6Cq6A2UV5pN0=6ieAVV+yJp0ht1bPhyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO7DJoAXrB8e+q2uHD6Cq6A2UV5pN0=6ieAVV+yJp0ht1bPhyg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Jan 30, 2023 at 09:05:30PM +0700, Eugene Konev wrote:
> Update regulatory info for Russia on 5GHz in accordance with
> current regulatory rules.
> 
> Source: https://docs.cntd.ru/document/902048009?section=text
> 
> Signed-off-by: Eugene Konev <uejikov@gmail.com>
> ---
>  db.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/db.txt b/db.txt
> index 3f74194..9bc2c1c 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1500,10 +1500,11 @@ country RS: DFS-ETSI
>         # 60 GHz band channels 1-4, ref: Etsi En 302 567
>         (57000 - 66000 @ 2160), (40)
> 
> -country RU:
> +# Source: https://docs.cntd.ru/document/902048009?section=text
> +country RU: DFS-ETSI
>         (2400 - 2483.5 @ 40), (20)
> -       (5150 - 5350 @ 160), (20), NO-OUTDOOR
> -       (5650 - 5850 @ 160), (20), NO-OUTDOOR
> +       (5150 - 5350 @ 160), (200 mW), NO-OUTDOOR, DFS
> +       (5650 - 5850 @ 160), (200 mW), NO-OUTDOOR, DFS

Based on your earlier mail these ranges require TPC. Linux does not
support TPC, so we have to cut power limits in half in the regdb. So
these need to remain at 100 mW.

Thanks,
Seth
