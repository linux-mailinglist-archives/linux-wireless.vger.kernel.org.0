Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80054669D24
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jan 2023 17:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjAMQFS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Jan 2023 11:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjAMQEu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Jan 2023 11:04:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709A282BAD
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 07:54:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20987B82179
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 15:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC11C433D2;
        Fri, 13 Jan 2023 15:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673625294;
        bh=GaMnPMMF5o9mQCCOGCpjR99NUUYdN/DNhPo8XX3bs7M=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GMTkNIjg3PERwatGvqddUv2lgblrjdazr35po1grjwDv92OmvNyLwLXVdVKclMzAq
         Bqo60nwkW45kGp9h61r4+pDdfMZCYso5zwvBM67xBjCNzCjKW8O09O0KcFX1+rCHd6
         J6dcn2E5BA/cKoqjNEYOrPdnpx4JWZAca3YAQdE+F/dJuRUfRXrArU659/kfDbvoX0
         w46lVlXJECQSF3Z/CiFkQk/yLvNxskfMlYGljPIsG3LfwOk8bBzEsTNKKXWEpVnplY
         cpwmbkN6giqfAKt1LSDtg+/M3l3/xRGDq8x/Cx5vhv/wtMw5TjgcYDvOzbngcrMyEA
         xbOjXUFzCWzGg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list.pdl@broadcom.com>,
        <SHA-cyfmac-dev-list@infineon.com>
Subject: Re: brcmfmac: Unexpected cfg80211_set_channel: set chanspec ... fail, reason -52
References: <2635fd4f-dfa0-1d87-058b-e455cee96750@i2se.com>
        <1f428e2b-f73f-64ff-02d3-eefbcd11db89@broadcom.com>
        <ee24c4eda8d389ac7197b6296944e168ccc6b602.camel@sipsolutions.net>
        <878ri6d0aw.fsf@kernel.org>
        <185abb29a58.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Date:   Fri, 13 Jan 2023 17:54:46 +0200
In-Reply-To: <185abb29a58.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
        (Arend Van Spriel's message of "Fri, 13 Jan 2023 16:14:47 +0100")
Message-ID: <87wn5qbfax.fsf@kernel.org>
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

Arend Van Spriel <arend.vanspriel@broadcom.com> writes:

> On January 13, 2023 2:35:58 PM Kalle Valo <kvalo@kernel.org> wrote:
>
>> Johannes Berg <johannes@sipsolutions.net> writes:
>>
>>>>> [  104.897615] brcmfmac: cfg80211_set_channel: set chanspec 0x100e fail,
>>>>> reason -52
>>>
>>> [...]
>>>
>>>>
>>>>> All of these 10 errors are repeated every 60 sec.
>>>>
>>>> Catching up after the holidays ;-) Above chanspec values are invalid.
>>>> 0x100e = channel 14/bw 20MHz. The 'iw list' output shows all these
>>>> channels are disabled. So who/what is trying to set these channels.
>>>> Scanning sets the channel in firmware. Is this initiated from hostapd?
>>>
>>> Yeah, what userspace is running here? Looks like cfg80211_set_channel()
>>> is only used for survey?
>>>
>>> Couple of observations on the side:
>>> * might be nice to have some "brcm" indication in that name :P
>>
>> Indeed, having a function cfg80211_set_channel() in brcmfmac/cfg80211.c
>> is VERY misleading. I first though that is a cfg80211 function and
>> didn't understand Johannes' comment until I started grepping :) Can
>> someone fix that, please?
>
> It is already on your queue for wireless-next. That was the 3rd patch
> for which you sent yourself a reminder earlier this week. You
> remember? ;-p

Heh. No, I don't even try to remember all the patches, there's just too
much of them :)

But very good that the fix is in queue, thanks!

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
