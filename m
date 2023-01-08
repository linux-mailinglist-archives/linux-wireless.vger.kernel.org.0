Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0122B66199C
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Jan 2023 21:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjAHU66 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Jan 2023 15:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjAHU64 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Jan 2023 15:58:56 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387FFA191
        for <linux-wireless@vger.kernel.org>; Sun,  8 Jan 2023 12:58:55 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pEckl-0001i9-92; Sun, 08 Jan 2023 21:58:51 +0100
Message-ID: <ac023262-c6cb-01ad-aeee-2dbf379f4c37@leemhuis.info>
Date:   Sun, 8 Jan 2023 21:58:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: Commit b320d6c4 broke mt76
Content-Language: en-US, de-DE
To:     "Alexander E. Patrakov" <patrakov@gmail.com>,
        Benjamin Berg <benjamin.berg@intel.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <CAN_LGv2FLLKxsbruJ0u_Gh3+_nTGaVGd4154DXQ7Tz+BnFt3EQ@mail.gmail.com>
From:   "Linux kernel regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAN_LGv2FLLKxsbruJ0u_Gh3+_nTGaVGd4154DXQ7Tz+BnFt3EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1673211535;5f3b4acf;
X-HE-SMSGID: 1pEckl-0001i9-92
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 08.01.23 20:46, Alexander E. Patrakov wrote:
> Hello Benjamin,
> 
> I have this hardware, which is supported by the mt76x2e driver:
> 
> 04:00.0 Network controller [0280]: MEDIATEK Corp. MT7612E 802.11acbgn
> PCI Express Wireless Network Adapter [14c3:7612]
> 
> Since Linux 6.1, the mt76 driver panics the kernel due to null
> dereference shortly after authenticating to the AP, as follows:

Thx for your report.

> [...]
>
> On Reddit, there is a similar thread with a USB adapter:
> https://www.reddit.com/r/archlinux/comments/zufy3n/linuxzen_611zen11_crashes_while_trying_to_use_usb/
> 
> I have checked with the nearly latest git revisions of both the kernel
> (9b43a525db125799df81e6fbef712a2ae50bfc5d) and the mt76 driver from
> https://github.com/openwrt/mt76 (679254c). The issue still exists.
> 
> I have bisected this, and the first bad commit is yours:
> 
> b320d6c456ff2aa43491654407d448bcfa58ac9f is the first bad commit
> commit b320d6c456ff2aa43491654407d448bcfa58ac9f
> Author: Benjamin Berg <benjamin.berg@intel.com>
> Date:   Fri Sep 2 16:12:40 2022 +0200

Not my area of expertise, but I guess it's fixed by this patch:

https://lore.kernel.org/all/20221230200747.19040-1-nbd@nbd.name/

Earlier reports:

https://lore.kernel.org/linux-wireless/CAFktD2fRnSbNgWRRoGbQzG5_Mw7=zFJKTVBHS_3D+mNUYcv9hQ@mail.gmail.com/
https://bugzilla.kernel.org/show_bug.cgi?id=216839
https://bugzilla.kernel.org/show_bug.cgi?id=216844

Hopefully everyone is back from vacation tomorrow so that we can finally
get this fixed in mainline soon.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
