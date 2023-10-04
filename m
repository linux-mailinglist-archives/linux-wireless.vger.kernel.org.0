Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A597B803B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 15:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjJDNJw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 09:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjJDNJw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 09:09:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5C398
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 06:09:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644F6C433C7;
        Wed,  4 Oct 2023 13:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696424987;
        bh=1KMiCQ4GF1yebZeJQUOFvoggMENRJNEp1ySztWeeoaQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hfGPaZ9IiJjxWKrNkLefmfTSa/1Xf8u/qGfr/neXnOAmEFeODqpOdrTaj4gNb7jiJ
         GmvJ2MLJciwNIqLfxWWOv2JdXJocQ3ByPWfE8rSnjD5WTQ1k5u5rRhIlgfZIiFKAWA
         ZESrdVSVfxFzthyxqwhir0mXIpRv5VJgqOdGkDWxzQT+37DIFA//hnUhNX2mJ/sey/
         Lu3AhzCr2GEZJAPb7Lohp7TQGRJ7Ux96wf2ufvvHbZV0/XfdTnCQcJbJ14s7phbmlR
         ehBe4BCWNSFEENLj49hV0NKNMALV7hjkKsHBZrFGbLeauKOtQwoihxR/QzL/sKPLp7
         RpavAPBjKTtvw==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Peer, Ilan" <ilan.peer@intel.com>,
        "anarcat@debian.org" <anarcat@debian.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: Microcode SW error since Linux 6.5
References: <87ttrncuc8.fsf@angela.anarc.at>
        <60e2c052f3cedc5c80964e4be90c50cdaa899a87.camel@sipsolutions.net>
        <87jzsf9dme.fsf@angela.anarc.at>
        <0190dde1170bd1ee810e99b9799678f4f5b8f30e.camel@sipsolutions.net>
        <8734z29jx7.fsf@angela.anarc.at>
        <7bd483fd0d004aed37931561a7faa2e176ca3fac.camel@sipsolutions.net>
        <5d0904a4-bc0d-42dd-aae8-6b50e5c567ba@leemhuis.info>
        <42e000913e3af714c77fb7a55dd898733e271be0.camel@intel.com>
        <0c07b6bf-a9cc-4dc0-b71c-a2257e501e5f@leemhuis.info>
Date:   Wed, 04 Oct 2023 16:12:03 +0300
In-Reply-To: <0c07b6bf-a9cc-4dc0-b71c-a2257e501e5f@leemhuis.info> (Linux
        regression tracking's message of "Wed, 4 Oct 2023 10:35:54 +0200")
Message-ID: <87h6n6h6qk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Linux regression tracking (Thorsten Leemhuis)"
<regressions@leemhuis.info> writes:
>> The patch in [1] should solve the issue. The problem was that wrong version
>> of Firmware API was used for some older versions.
>> 
>> [1]
>> https://patchwork.kernel.org/project/linux-wireless/patch/20230926165546.086e635fbbe6.Ia660f35ca0b1079f2c2ea92fd8d14d8101a89d03@changeid/
>
> Ahh, great, many thx for the reply. Two things then:
>
> (1) I wanted to ask why this patch is not in mainline or -net yet, but
> then noticed the fix is among the patches of a one week old pull request
> that afaics was not handled yet:
> https://lore.kernel.org/all/20230927095835.25803-2-johannes@sipsolutions.net/
>
> Guess that one fell through the cracks due to the Netconf 2023 workshop?
> Maybe this msg gets things rolling again.

At least on Monday there were something 500 patches in netdev patchwork
and today I see still 340 patches. Understandably it takes time to
process all that, let's just wait patiently and let the maintainers do
their job in peace.

I see our pull request is in active state in patchwork so I don't think
it has fell through the cracks:

https://patchwork.kernel.org/project/netdevbpf/patch/20230927095835.25803-2-johannes@sipsolutions.net/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
