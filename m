Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF794662E6B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jan 2023 19:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbjAISNC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Jan 2023 13:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbjAISMd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Jan 2023 13:12:33 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC4C58818
        for <linux-wireless@vger.kernel.org>; Mon,  9 Jan 2023 10:10:09 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pEwb1-0003wQ-2Q; Mon, 09 Jan 2023 19:10:07 +0100
Message-ID: <45db74d9-0f5f-2948-3d51-a10dc34be593@leemhuis.info>
Date:   Mon, 9 Jan 2023 19:10:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Regression in brcmfmac for 6.1/6.2-rc1 for SDIO devices
Content-Language: en-US, de-DE
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com, regressions@lists.linux.dev,
        "Justin M. Forbes" <jforbes@fedoraproject.org>
References: <CALeDE9O1+qgn_9z=zTVKbWx3FphEa4y8Dn9f5ORoQgW_gL1dqg@mail.gmail.com>
 <7bbfd1b7-4615-0766-76e4-086861f68a08@leemhuis.info>
 <877cxvixok.fsf@kernel.org>
From:   "Linux kernel regression tracking (#update)" 
        <regressions@leemhuis.info>
In-Reply-To: <877cxvixok.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673287809;e4986b6f;
X-HE-SMSGID: 1pEwb1-0003wQ-2Q
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 09.01.23 15:34, Kalle Valo wrote:
> "Linux kernel regression tracking (#info)" <regressions@leemhuis.info>
> writes:
> 
>> [TLDR: I'm adding this report to the list of tracked Linux kernel
>> regressions; all text you find below is based on a few templates
>> paragraphs you might have encountered already already in similar form.]
>>
>> On 31.12.22 02:00, Peter Robinson wrote:
>>>
>>> I'm seeing a regression in the brcmfmac driver which appeared in the
>>> 6.1 dev cycle, I didn't pick it up until around rc8 but with deadlines
>>> and travel I've not had a chance to bisect it but wanted to report it
>>> to make people aware. I've seen in on a number of devices with
>>> brcmfmac wifi over SDIO including at least the Raspberry Pi (zero2w,
>>> rpi4, rpi400, rpi3B+) and other devices like  the Rock960, Pinebook
>>> Pro etc.
>>> [...]
>>
>> Thanks for the report. To be sure the issue doesn't fall through the
>> cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
>> tracking bot:
>>
>> #regzbot introduced v6.0..v6.1 ^
>> https://bugzilla.suse.com/show_bug.cgi?id=1206697
>> #regzbot title net: wifi: brcmfmac over SDIO broken on various Raspberry Pi
>> #regzbot ignore-activity
> 
> This commit should fix the issue:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=a5a36720c3f650f859f5e9535dd62d06f13f4f3b

Great, thx for letting me know!

#regzbot fix: a5a36720c3f65

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.



