Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3484C65A4CB
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Dec 2022 15:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiLaOUQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Dec 2022 09:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLaOUP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Dec 2022 09:20:15 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D485ABE2D
        for <linux-wireless@vger.kernel.org>; Sat, 31 Dec 2022 06:20:13 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pBciZ-0000Sl-R6; Sat, 31 Dec 2022 15:20:11 +0100
Message-ID: <7bbfd1b7-4615-0766-76e4-086861f68a08@leemhuis.info>
Date:   Sat, 31 Dec 2022 15:20:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Regression in brcmfmac for 6.1/6.2-rc1 for SDIO devices
Content-Language: en-US, de-DE
To:     Peter Robinson <pbrobinson@gmail.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, regressions@lists.linux.dev,
        "Justin M. Forbes" <jforbes@fedoraproject.org>
References: <CALeDE9O1+qgn_9z=zTVKbWx3FphEa4y8Dn9f5ORoQgW_gL1dqg@mail.gmail.com>
From:   "Linux kernel regression tracking (#info)" 
        <regressions@leemhuis.info>
Reply-To: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CALeDE9O1+qgn_9z=zTVKbWx3FphEa4y8Dn9f5ORoQgW_gL1dqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672496413;2ee7caaa;
X-HE-SMSGID: 1pBciZ-0000Sl-R6
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; all text you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

On 31.12.22 02:00, Peter Robinson wrote:
> 
> I'm seeing a regression in the brcmfmac driver which appeared in the
> 6.1 dev cycle, I didn't pick it up until around rc8 but with deadlines
> and travel I've not had a chance to bisect it but wanted to report it
> to make people aware. I've seen in on a number of devices with
> brcmfmac wifi over SDIO including at least the Raspberry Pi (zero2w,
> rpi4, rpi400, rpi3B+) and other devices like  the Rock960, Pinebook
> Pro etc.
> [...]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot introduced v6.0..v6.1 ^
https://bugzilla.suse.com/show_bug.cgi?id=1206697
#regzbot title net: wifi: brcmfmac over SDIO broken on various Raspberry Pi
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (see page linked in footer for details).

Ciao, Thorsten
-- 
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr

Annoyed by mails like this? Feel free to send them to /dev/null:
https://linux-regtracking.leemhuis.info/about/#infomails
