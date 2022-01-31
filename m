Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576C24A4370
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Jan 2022 12:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359560AbiAaLVb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jan 2022 06:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378396AbiAaLUH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jan 2022 06:20:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830A8C061BB1
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jan 2022 03:12:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2279961163
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jan 2022 11:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25D1C340F0;
        Mon, 31 Jan 2022 11:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643627545;
        bh=28XhqNZ4h8E2oF0vewrAUlz2+wb1r1CBdxyN+U4Zyj4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=MPxvQKJgdGXH/R3hH0M84IJyAENhAU1ukbPLutpuDAQWxFsfXyUUXAuyltPE6ikj5
         O/patSfFcW+JszhA45Mw2dv6sjfPeVnzOJI3a54LJldtQM4xyvEb2cqsAF8VmelFCK
         PcEDo9cYn2EsbslVwtG1ctx9Hk4Ex7K/C6NAZEuRMC0GP33CBVy/0fDoKBovbphh7c
         VWlWbUEgtTB7jA8XdBGnV9o0ftIZSw8DffPOEVy88pwkd8TwlR1bz9iOW/TjoDRhOx
         +aAZRuMXBOihkDH8pGMZWvu3HcW54L+Od+ZCa2v5B6rV75isqueQe7/YIcWId25V83
         R2nziK6irCkrg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Luca Coelho <luca@coelho.fi>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH for v5.17 1/2] iwlwifi: remove deprecated broadcast filtering feature
References: <20220128124851.538580-1-luca@coelho.fi>
        <iwlwifi.20220128144623.9241e049f13e.Ia4f282813ca2ddd24c13427823519113f2bbebf2@changeid>
        <b784b942-6346-7005-b71a-5682cf0452b1@leemhuis.info>
Date:   Mon, 31 Jan 2022 13:12:20 +0200
In-Reply-To: <b784b942-6346-7005-b71a-5682cf0452b1@leemhuis.info> (Thorsten
        Leemhuis's message of "Mon, 31 Jan 2022 09:08:00 +0100")
Message-ID: <87a6fccg6j.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thorsten Leemhuis <regressions@leemhuis.info> writes:

> Hi, this is your Linux kernel regression tracker speaking.
>
> On 28.01.22 13:48, Luca Coelho wrote:
>> From: Luca Coelho <luciano.coelho@intel.com>
>> 
>> This feature has been deprecated and should not be used anymore.  With
>> newer firmwares, namely *-67.ucode and above, trying to use it causes an
>> assertion failure in the FW, similar to this:
>> 
>> [Tue Jan 11 20:05:24 2022] iwlwifi 0000:04:00.0: 0x00001062 | ADVANCED_SYSASSERT
>> 
>> In order to prevent this feature from being used, remove it entirely
>> and get rid of the Kconfig option that
>> enables it (IWLWIFI_BCAST_FILTERING).
>> 
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215488
>
> FWIW there was another report about it afaics:
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215550

If it's the same issue, it should be marked as a duplicate.

> That makes me hope that this is reviewed and merged to mainline relative
> quickly, otherwise more users will be bothered by this.
>
>> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>> Fixes: cbaa6aeedee5 ("iwlwifi: bump FW API to 67 for AX devices")
>> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>
> Shouldn't this also have:
>
> Cc: stable@vger.kernel.org # 5.16.x

I can add that.

BTW, please trim your quotes. You left a really long (and unnecessary)
quote, which makes use of patchwork much harder for us maintainers.
Unfortunately patchwork is not able to trim them automatically:

https://patchwork.kernel.org/project/linux-wireless/patch/iwlwifi.20220128144623.9241e049f13e.Ia4f282813ca2ddd24c13427823519113f2bbebf2@changeid/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
