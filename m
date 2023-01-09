Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147C86628A1
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 15:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjAIOer (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 09:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjAIOeo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 09:34:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C08CF46
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 06:34:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 040E46114E
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 14:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9409FC433EF;
        Mon,  9 Jan 2023 14:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673274882;
        bh=BJcHCo83jVVTdhI6xriR4zoiOU5qvHX/2q0lajpMG6M=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=he06DkeHWKEGsnGFvMLhtl+ZG+YQtRLVXkppKeR4Ns4WSB2yrOHK7yWKRapTeLCFj
         VYxftI36Z11pZgnaCO3bnClWM5jgtpF0S1WUcr4ZyxVbVzQ/4eZVW/OU0uj/jyO51r
         Krb3BFxuM/w3WGJvx8wbD860YZd/dAwYcfPSgacLU6V6+enWnNsDaabNYWjH1u75IM
         Uni/SeYp9LJPfBkW2Dq/F0FNFpeImMJn/8ZxgynICsaGMzfdhLKjePKM2jBoaKYY3M
         FLjEIq2d3KoUhTM9S4CpfC2XjIUeH61rbY0Bg9rOciPYBbh2amKcWxWd1zc7WpKSc4
         5XoIo3qxS0MxQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Linux kernel regression tracking \(#info\)" 
        <regressions@leemhuis.info>
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, regressions@lists.linux.dev,
        "Justin M. Forbes" <jforbes@fedoraproject.org>
Subject: Re: Regression in brcmfmac for 6.1/6.2-rc1 for SDIO devices
References: <CALeDE9O1+qgn_9z=zTVKbWx3FphEa4y8Dn9f5ORoQgW_gL1dqg@mail.gmail.com>
        <7bbfd1b7-4615-0766-76e4-086861f68a08@leemhuis.info>
Date:   Mon, 09 Jan 2023 16:34:35 +0200
In-Reply-To: <7bbfd1b7-4615-0766-76e4-086861f68a08@leemhuis.info> (Linux
        kernel regression tracking's message of "Sat, 31 Dec 2022 15:20:11
        +0100")
Message-ID: <877cxvixok.fsf@kernel.org>
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

"Linux kernel regression tracking (#info)" <regressions@leemhuis.info>
writes:

> [TLDR: I'm adding this report to the list of tracked Linux kernel
> regressions; all text you find below is based on a few templates
> paragraphs you might have encountered already already in similar form.]
>
> On 31.12.22 02:00, Peter Robinson wrote:
>> 
>> I'm seeing a regression in the brcmfmac driver which appeared in the
>> 6.1 dev cycle, I didn't pick it up until around rc8 but with deadlines
>> and travel I've not had a chance to bisect it but wanted to report it
>> to make people aware. I've seen in on a number of devices with
>> brcmfmac wifi over SDIO including at least the Raspberry Pi (zero2w,
>> rpi4, rpi400, rpi3B+) and other devices like  the Rock960, Pinebook
>> Pro etc.
>> [...]
>
> Thanks for the report. To be sure the issue doesn't fall through the
> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
> tracking bot:
>
> #regzbot introduced v6.0..v6.1 ^
> https://bugzilla.suse.com/show_bug.cgi?id=1206697
> #regzbot title net: wifi: brcmfmac over SDIO broken on various Raspberry Pi
> #regzbot ignore-activity

This commit should fix the issue:

https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=a5a36720c3f650f859f5e9535dd62d06f13f4f3b

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
