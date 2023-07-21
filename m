Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784FD75BF66
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jul 2023 09:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjGUHPd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jul 2023 03:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGUHPb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jul 2023 03:15:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6849F2710
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jul 2023 00:15:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01171612DC
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jul 2023 07:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D55CC433C7;
        Fri, 21 Jul 2023 07:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689923729;
        bh=QEnVXPDd1w8ZnvW9mwKWg0xdidc7ub7DMRXSk6sEHLs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AAhHxnyI2x5ZVttIirTVB8ikAV4Dw+sNZ+xq+lnwfC9uxmyTw+MaBNktOxtmt2urc
         M4VButYjX2se/4CsKzn8X3/bkRasWjd0or6Hxyaumdo0wZIV5SWDuLCCRDws0otuzs
         Xe2yx9jtvAx7CMs9AWW466PkAOyWrLFTS457DOxrqi+8Ajz0rawsTkThjXYQi653/b
         Dej4BCBXLotviei7Y+XVozS9vbpJRYRVbMuK7e1bjTmVqykzdSYaLjwCcKDUT6ZJl+
         cKmioUUe3VYaiYv6glKfR1nTNPkN24kdAzerJSZlCYepWi9Zmd8ySCJ+iCeQ/MRzQU
         z3S9yDRORuRHA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Pink Perfect <pinkperfect2021@gmail.com>, amitkarwar@gmail.com,
        ganapathi017@gmail.com, sharvari.harisangam@nxp.com,
        huxinming820@gmail.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3] wifi: mwifiex: Fix OOB and integer underflow when rx
 packets
References: <20230713023731.2518507-1-pinkperfect2021@gmail.com>
        <CAKNAPeOvG1MVD0y5xuZpN8mSEzvrzcvRhdyrTJhju-_Z1nGV0g@mail.gmail.com>
        <20230713105644.49444826@kernel.org> <87sf9j3wd1.fsf@kernel.org>
        <ZLlrd4dDz+kA5l18@google.com>
Date:   Fri, 21 Jul 2023 10:15:25 +0300
In-Reply-To: <ZLlrd4dDz+kA5l18@google.com> (Brian Norris's message of "Thu, 20
        Jul 2023 10:14:31 -0700")
Message-ID: <87tttx3fci.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> On Thu, Jul 20, 2023 at 09:55:38AM +0300, Kalle Valo wrote:
>> We have four maintainers for mwifiex and total silence:
>> 
>> MARVELL MWIFIEX WIRELESS DRIVER
>> M:      Amitkumar Karwar <amitkarwar@gmail.com>
>> M:      Ganapathi Bhat <ganapathi017@gmail.com>
>> M:      Sharvari Harisangam <sharvari.harisangam@nxp.com>
>> M:      Xinming Hu <huxinming820@gmail.com>
>> L:      linux-wireless@vger.kernel.org
>> S:      Maintained
>> F:      drivers/net/wireless/marvell/mwifiex/
>> 
>> I'm very close of marking this driver as orphan unless anyone steps up.
>> This is not how to maintain a driver.
>
> I'd be fully on board with removing these maintainers, as I don't recall
> hearing from any of them in years. (In fact, some of these addresses
> don't have a single mail logged on lore.kernel.org/all/...) I just
> didn't want to be the one to say it.
>
> On the other hand, I regularly look at pretty much anything for mwifiex,
> as long as the submitter is in relatively good faith. So I wouldn't mind
> being a Reviewer (or Maintainer? what's the difference, when Kalle
> does the committing anyway?).

Heh, that's a good question. I don't know what was the original intent
for a reviewer role but in my view ideally a driver should 1-2
maintainers, no more, and if there are more people involved they should
be reviewers. And maintainers should use Acked-by, Reviewers should use
Reviewed-by. And if I see an Acked-by from a maintainer I usually don't
review the patch so closely and just take it directly (of there are
exceptions, as always). In this case I would prefer you being the
maintainer, even if you wouldn't have much time for mwifiex.

But I don't know how others see it. Jakub has been writing documentation
about maintainership which is also a good read:

https://lore.kernel.org/all/20230719183225.1827100-1-kuba@kernel.org/

> And that might qualify as "Odd Fixes", as
> I don't plan on doing much more than keeping the lights on.
>
> I'll submit the MAINTAINERS patch if you'd like.

Sounds very good to me, thank you! Please submit the patch if you can.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
