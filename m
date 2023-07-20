Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E3775B1A6
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jul 2023 16:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjGTOu1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jul 2023 10:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjGTOuX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jul 2023 10:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF1B2707
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 07:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 672AD61B1C
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jul 2023 14:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FFCC433C8;
        Thu, 20 Jul 2023 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689864618;
        bh=TG6z5dRQwCt/sYCGe95SPZS568gTDayz1xvikEEkloE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WI9ddpFayIhRbod+iKt2pUJmpght+8YzGJq4egJ7HvSZ7LNMu+/ttSzJ2ovE4fsuN
         ChYqVQMR3FNyhCXMCiLxw1e7Y6iJM8JP1JBty5kbmCHMg3NHcodk/Uypbv4z1ok2vx
         QfSKnuBlg7ULYL2Nsk8dcw0p6LZBqPzHjP2y1W1AJQue+md5xeI7P2H1uEes8aaaTB
         rOrP91zsCyfldLJhhZfd0DdKBltR91tghtjNeg3Sj6mO8//5h+we/itsh2GZ13Gtlk
         8i7icauBiLy97QCDTFiIvp5bh4zBqLZyhrBcEuFouZgDalCRf3J0/aw9TT3fK59b+Y
         Iwzk13XoSh/LQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <kuba@kernel.org>, <linux-wireless@vger.kernel.org>,
        <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>
Subject: Re: [PATCH] wifi: wilc1000: change firmware path from 'atmel' to
 'microchip/wilc'
References: <20230630012136.1330784-1-ajay.kathat@microchip.com>
        <20230705140338.77896d11@kernel.org>
        <5500a007-4e52-f8dc-2535-3baa7decfe52@microchip.com>
        <20230705172754.61ca21ae@kernel.org> <87cz0o2nm4.fsf@kernel.org>
        <4aef9340-7b03-43af-f211-c8e45f749e73@microchip.com>
Date:   Thu, 20 Jul 2023 17:50:15 +0300
In-Reply-To: <4aef9340-7b03-43af-f211-c8e45f749e73@microchip.com> (Ajay
        Kathat's message of "Wed, 19 Jul 2023 16:20:57 +0000")
Message-ID: <877cqu4oyg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> writes:

> On 7/19/23 03:37, Kalle Valo wrote:
>
>> Jakub Kicinski <kuba@kernel.org> writes:
>> 
>>>> In order to address scenario#1, a fallback method that loads the FW from
>>>> the older path(/atmel) can be added in the driver. I think that change
>>>> will make it compatible for scenario#1.
>>>> Please suggest, if there is a generic/recommended approach to handle
>>>> backward compatibility for FW path change.
>>>
>>> I'm afraid you need to request from both new and old patch for some
>>> time. Push the change to linux-firmware, but make driver be compatible
>>> with both for maybe three full releases? Then the risk of someone still
>>> having stale linux-firmware goes down quite a bit.
>> 
>> I would say at least minimum of two years, preferably more to make it
>> possible to upgrade kernel on LTS distro releases.
>> 
>>> TBH renaming FW paths, much like renaming drivers is usually more risk
>>> than reward.
>> 
>> I agree, it's just extra work without no actually benefit. Maybe an
>> exception here is iwlwifi, that should be fixed as that clutters the top
>> level firmware directory with dozens of files:
>> 
>
> Definitely, this change will not have any functionality improvements. It
> will just help to organize the wilc firmware directory structure.
>
> Currently, only wilc1000 firmwares are present in linux-firmware but the
> work to support wilc3000 and wilc's next-gen device is in progress. The
> existing wilc driver will be extended and the new firmware files needs
> to be added to linux-firmware. After this change, the all firmware's can
> organized under same root directory since adding a new device firmware's
> under 'atmel' folder may not make sense.

'atmel' is only a name, I wouldn't worry about that too much. For
example we still have drivers/net/wireless/ath even though Atheros is
long gone.

> Alternatively, the new device firmware(e.g wilc3000) can be added to
> '/microchip/wilc' without changing wilc1000 firmware path. Is this
> approach okay.

I haven't seen the actual patches but in principle having a new
directory 'microchip/wilc/ in linux-firmare sounds like a good idea to
me. But better to wait for comments from others for a while before
submitting anything.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
