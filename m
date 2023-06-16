Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F3F732B78
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 11:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244305AbjFPJ1U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 05:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245552AbjFPJ1D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 05:27:03 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DDF3C3B
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 02:26:01 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qA5iO-0004gy-Pm; Fri, 16 Jun 2023 11:25:56 +0200
Message-ID: <50f7f64c-fe32-4362-fd4e-89ee99c4f581@leemhuis.info>
Date:   Fri, 16 Jun 2023 11:25:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [regression] STP on 80211s is broken in 6.4-rc4
Content-Language: en-US, de-DE
To:     Nicolas Escande <nico.escande@gmail.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>, nbd@nbd.name,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
References: <CT5GNZSK28AI.2K6M69OXM9RW5@syracuse> <ZIQbs0wqdRh7c0Kx@debian.me>
 <a9d02800-2cd6-a27b-7998-4c97cf2eb692@leemhuis.info>
 <CTDWJJDKSYYD.XBG1CAZB3A5W@syracuse>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CTDWJJDKSYYD.XBG1CAZB3A5W@syracuse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1686907561;69e21317;
X-HE-SMSGID: 1qA5iO-0004gy-Pm
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 16.06.23 09:45, Nicolas Escande wrote:
> On Thu Jun 15, 2023 at 2:54 PM CEST, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 10.06.23 08:44, Bagas Sanjaya wrote:
>>> On Tue, Jun 06, 2023 at 12:55:57PM +0200, Nicolas Escande wrote:

>> Hmmm, Felix did not reply. But let's ignore that for now.
> I haven't seen mails from felix on the list for a few days, I'm guessing he's
> unavailable for now but I'll hapilly wait.

Okay.

>> Nicolas, I noticed there are a few patches in next that refer to the
>> culprit. Might be worth giving this series a try:
>> https://lore.kernel.org/all/20230314095956.62085-1-nbd@nbd.name/
> Well this series already landed in 6.4 and that is the version I did my initial
> testing with. So no luck there.

What? Ohh, sorry for the noise, I had missed that they were in mainline
already.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
