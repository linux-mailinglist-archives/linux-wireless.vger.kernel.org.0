Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A558669D8D
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jan 2023 17:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjAMQWR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Jan 2023 11:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjAMQVn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Jan 2023 11:21:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB4C7BCF9
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 08:15:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4100262247
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 16:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49ABEC433EF;
        Fri, 13 Jan 2023 16:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673626538;
        bh=uC51eJ/+kH/H6hel32eHVTiZmVCJh8ZVGOUEDBov2aQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ByMBMPOJavFRGDuyJIkkxrlzydxvlRrbUFwOmlAebyxxEVTpdil7DfezarDNB+3qk
         JYVpfEMmnCG/HT4dgrJjvEEpsUFWwEojA08/ceutILmUE7Vge+TT60EAHIKw2BLyaE
         E0qS7TFfzkbuSsoccbc06upW8mUHwFulJQwM1X3tIysVXZ0Uytuj4Q+UWLzRx3C5Td
         JRR08/9YxqVlDp5B/3A+ToieUdxWnnYJV09gbrihg4QNyJNl6uL9irNGt1+IcoBWzJ
         TmKymp30wEXOkwzITUfbfMhNF1IEtnbg4OgHXdaEx2TJxHYWL8fBr2lUahw7aaM1G5
         /sr0A5jI839nw==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Linux kernel regression tracking \(Thorsten Leemhuis\)" 
        <regressions@leemhuis.info>
Cc:     Bert Karwatzki <spasswolf@web.de>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 6.2-rc3] wifi: mt76: fix dma error
References: <45e57883822389266ab67f7e0b6aa737db047cdd.camel@web.de>
        <b8a3fa69-a4c2-51b5-d193-d4d933cf6627@leemhuis.info>
Date:   Fri, 13 Jan 2023 18:15:31 +0200
In-Reply-To: <b8a3fa69-a4c2-51b5-d193-d4d933cf6627@leemhuis.info> (Linux
        kernel regression tracking's message of "Wed, 11 Jan 2023 08:54:12
        +0100")
Message-ID: <87fscebecc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Linux kernel regression tracking (Thorsten Leemhuis)"
<regressions@leemhuis.info> writes:

> [CCing Felix]
>
> On 10.01.23 23:39, Bert Karwatzki wrote:
>> Since linux-6.2-rc1 the mediatek mt76 wlan driver suffers from problems
>> https://bugzilla.kernel.org/show_bug.cgi?id=216901. I bisected this to
>> commit cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae and noticed that the
>> 
>> 	if (txwi) {
>> 		q->entry[q->head].txwi = DMA_DUMMY_DATA;
>> 		q->entry[q->head].skip_buf0 = true;
>> 	}
>> 
>> part is moved from the beginning of mt76_dma_add_buf to the
>> inside of the for loop. But q->head is modified at the beginning of
>> this loop.
>
> Thx for your patch. TWIMC, a earlier (and tested) patch to address that
> regression can afaics be found here:
>
> https://lore.kernel.org/lkml/3cb53fbd-0bee-22f9-bba2-6ac4a87db521@nbd.name/
>
> Makes me wonder: Felix, btw, did you ever properly submit that patch for
> inclusion? Where? I can't find it with lore. :-/ Or will it be addressed
> by a different patch?

The patch is now in my queue:

https://patchwork.kernel.org/project/linux-wireless/patch/20230113105848.34642-3-nbd@nbd.name/

> /me really hopes we can get this resolved this week before rc4 ships, as
> it seems this regressions bothers quite a few people

If all goes well this should make it to v6.2-rc5.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
