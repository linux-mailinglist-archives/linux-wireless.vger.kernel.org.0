Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1416696B3
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jan 2023 13:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241096AbjAMMOJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Jan 2023 07:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241117AbjAMMNV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Jan 2023 07:13:21 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A42AAE7A
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 04:07:56 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pGIqh-0007Sr-8b; Fri, 13 Jan 2023 13:07:55 +0100
Message-ID: <ce9a1141-810a-491a-1293-67beb46efb1f@leemhuis.info>
Date:   Fri, 13 Jan 2023 13:07:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH wireless 3/3] wifi: mt76: dma: fix a regression in adding
 rx buffers
Content-Language: en-US, de-DE
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230113105848.34642-1-nbd@nbd.name>
 <20230113105848.34642-3-nbd@nbd.name>
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230113105848.34642-3-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673611680;7f227252;
X-HE-SMSGID: 1pGIqh-0007Sr-8b
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 13.01.23 11:58, Felix Fietkau wrote:
> When adding WED support, mt76_dma_add_buf was accidentally changed to set
> the skip_buf0 flag for tx buffers on the wrong queue descriptor entry.
> Additionally, there is a rxwi leak when rx buffer allocation fails.

thx for working on this

> Fix this and make the code more readable by adding a separate function for
> adding rx buffers.
> 
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

Many thx for taking care of this. There is one small thing to improve,
please add the following tags here to make things easier for future code
archaeologists and give proper credit:

Link:
https://lore.kernel.org/r/CABXGCsMEnQd=gYKTd1knRsWuxCb=Etv5nAre%2BXJS_s5FgVteYA@mail.gmail.com/
Reported-by: Mike Lothian <mike@fireburn.co.uk>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216829
Reported-by: AngeloGioacchino Del Regno
Link:
https://lore.kernel.org/lkml/20230112171706.294550-1-angelogioacchino.delregno@collabora.com/

To explain: Linus[1] and others considered proper link tags important in
cases like this, as they allow anyone to look into the backstory of a
fix weeks or years later. That's nothing new, the documentation[2] for
some time says to place such tags in cases like this. I care personally
(and made it a bit more explicit in the docs a while ago), because these
tags make my regression tracking efforts a whole lot easier, as they
allow my tracking bot 'regzbot' to automatically connect reports with
patches posted or committed to fix tracked regressions.

Apropos regzbot, let me tell regzbot to monitor this thread:

#regzbot ^backmonitor:
https://lore.kernel.org/r/CABXGCsMEnQd=gYKTd1knRsWuxCb=Etv5nAre%2BXJS_s5FgVteYA@mail.gmail.com/

> [...]

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

[1] for details, see:
https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/

[2] see Documentation/process/submitting-patches.rst
(http://docs.kernel.org/process/submitting-patches.html) and
Documentation/process/5.Posting.rst
(https://docs.kernel.org/process/5.Posting.html)

--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
