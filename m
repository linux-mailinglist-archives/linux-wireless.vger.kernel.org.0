Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F435AA9F4
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 10:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbiIBI2r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 04:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbiIBI2f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 04:28:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFF5C00FE
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 01:28:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29F9C62111
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 08:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5622C433C1;
        Fri,  2 Sep 2022 08:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662107310;
        bh=iyPl95zyt6Ik5pvFuXMmU1EYffOEtu6ZUJ6UFA6tESc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Htf2F3H/kUxee0QS6LvzHj5KSz1ylrZNeDZxTxLyMT73Gdv5UY9eRhVkoVBklFMVD
         YKPREZ9xTQR5DurBLMB1WMAU0zbHTpqLQr7VogBpyBkQlJQv9Gh1ZLOEeDAU66jUoS
         JdrM3oma7wOt5m9Mk7NaVWUGnXThcmJUbhRE/zCi8tlGQSB7j493mlI8hR6ESwWSvc
         X/LyrdrMizJ9blu7CNKEwMld1+ypDlcZpODw9bQkZNpmtotWFqYFSBCyf6T3sycDEq
         PN68WJKrLQ4o8RDSjnVVpUMfE1JraZDY8+hWcaG1A5JipBHkIOqj7HH4hryvhJKI6d
         01DxASPBA7Kpg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Kevin Yang" <kevin_yang@realtek.com>
Subject: Re: [PATCH 13/13] rtw89: prohibit mac80211 chanctx ops without HW scan
References: <20220617084954.61261-1-pkshih@realtek.com>
        <20220617084954.61261-14-pkshih@realtek.com>
        <877d5bprxn.fsf@kernel.org>
        <027f1de5f6ed0da21754c17154cc09411f2c5aa5.camel@realtek.com>
        <6f6682f8d8c7aec02d113330c87484cbcab14ff3.camel@realtek.com>
        <b8f7720937e05c6fd7fde14b8ea57065879928a8.camel@realtek.com>
Date:   Fri, 02 Sep 2022 11:28:26 +0300
In-Reply-To: <b8f7720937e05c6fd7fde14b8ea57065879928a8.camel@realtek.com>
        (Ping-Ke Shih's message of "Tue, 9 Aug 2022 11:00:12 +0000")
Message-ID: <87ler2b2ol.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
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

Ping-Ke Shih <pkshih@realtek.com> writes:

>> > > So if the user has not update the firmware a kernel upgrade will break
>> > > their internet? That's not good, we should not break existing setups. So
>> > > what firmware version is required?
>> > > 
>> > 
>> > Firmware version 0.13.35.0 is required. The firmware has been in
>> > linux-firmware repository on 2022-02-18. I think people being able
>> > to update kernel can update firmware as well.
>> > 
>> > The alternative ways could be
>> > 1. add a module parameter, like no_channel_context. We can add a
>> >    prompt to note people can set it to 1 for old firmware.
>> > 
>> > 2. wait version of request_firmware() as first step of pci probe.
>> >    The probe could cost longer time, because currently we use
>> >    request_firmware_nowait() and continue to initialize in parallel.
>> >    More, hw->priv isn't allocated at that moment, so it could be not
>> >    so straightforward.
>> > 
>> 
>> To prevent break users' existing setups, modified approach 1 is adopted
>> by patchset v2. We add a module parameter rtw89_use_chanctx, and disable
>> it by default. So, users' setups with old firmware can still work.
>> 
>> If a user wants channel context to support concurrency, he can set
>> rtw89_use_chanctx=1 and upgrade firmware. 
>> 
>> I think this could be a better user experience of kernel.
>> 
>
> We have a better idea that load firmware header and parse firmware
> features when probing before ieee80211_register_hw(). If firmware
> doesn't support hw_scan, it still can work as original. So, users
> don't need to update firmware or set module parameters.
>
> I have sent v3 with this idea that is friendly to users.

Sorry for the delay, I was not able to look at this in detail earlier.

Indeed v3 is much better approach and actually what we prefer in
upstream. iwlwifi, ath10k and ath11k do something similar. Forcing users
to update the firmware or fiddling with module parameters when updating
the kernel is bad from user's point of view.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
