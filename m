Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD5765ADE1
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jan 2023 09:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjABIJu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Jan 2023 03:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABIJs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Jan 2023 03:09:48 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBE725DD
        for <linux-wireless@vger.kernel.org>; Mon,  2 Jan 2023 00:09:46 -0800 (PST)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pCFtA-0004Td-9z; Mon, 02 Jan 2023 09:09:44 +0100
Message-ID: <4d3afaf9-1511-5eb0-0c84-7897c0beca4e@leemhuis.info>
Date:   Mon, 2 Jan 2023 09:09:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5] wifi: mac80211: fix initialization of rx->link and
 rx->link_sta
Content-Language: en-US, de-DE
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, quic_srirrama@quicinc.com,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <20221230200747.19040-1-nbd@nbd.name>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20221230200747.19040-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1672646986;27fc92db;
X-HE-SMSGID: 1pCFtA-0004Td-9z
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

On 30.12.22 21:07, Felix Fietkau wrote:
> There are some codepaths that do not initialize rx->link_sta properly. This
> causes a crash in places which assume that rx->link_sta is valid if rx->sta
> is valid.
> One known instance is triggered by __ieee80211_rx_h_amsdu being called from
> fast-rx. It results in a crash like this one:

Many thx for working on this.

> [...]
> Fixes: ccdde7c74ffd ("wifi: mac80211: properly implement MLO key handling")
> Fixes: b320d6c456ff ("wifi: mac80211: use correct rx link_sta instead of default")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Shouldn't this have a Cc: stable@vger.kernel.org to ensure it's
backported (no, Fixes: tags are not enough for that, as Greg
occasionally clarified).

And also a few link and reported-by tags to all the bug reports that
apparently are fixed by this change? These are the ones I'm aware of,
there might be more:

https://lore.kernel.org/linux-wireless/CAFktD2fRnSbNgWRRoGbQzG5_Mw7=zFJKTVBHS_3D+mNUYcv9hQ@mail.gmail.com/
https://bugzilla.kernel.org/show_bug.cgi?id=216839
https://bugzilla.kernel.org/show_bug.cgi?id=216844

This indicates that quite a few users are hit by problems this patch
fixes, hence from my point of view it obviously would be ideal if this
patch could make it to mainline quickly.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr

Did I miss something or do something stupid? Then reply and tell me:
https://linux-regtracking.leemhuis.info/about/#stupid

#regzbot ^backmonitor: https://bugzilla.kernel.org/show_bug.cgi?id=216844
