Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF487C4C2C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 09:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjJKHoK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 03:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJKHoJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 03:44:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE139E
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 00:44:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0557C433C7;
        Wed, 11 Oct 2023 07:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697010247;
        bh=789j1lY3ehj4vw1zEu7cFtV/uiImj5COh22qDE7vinM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=PF/wwyHBsF2vEaN0yetiWmNAB8hKn4VqJNRP7upJU5Q4nFB6Yhd39T8Yp7Bz1tCpu
         dYJ2P/1cAssRMvMx4D/KyDxBRK8t372d580aFUoLwXsR479gGXT/U5njD9ocLsdZBO
         4BCSnY1mOiiMv3+tff9II48rSPaUxk8+tLUVO7IljU+peatpiuIS2ncHYbCXz/FF7x
         +99T1WOYN0aAn5p+JshtFB6jpYa9hV6NUIVQE0lSmJzJ5lGs5CTkP2TPLhOv8oq/Zp
         rk46oqHJkWbjklmgc9Sd6k4rSW/X33z1AT/YS/ZcHm8YQl2kNWjd0jQzE1+ohZU3h7
         sU6PPpiIluh5g==
From:   Kalle Valo <kvalo@kernel.org>
To:     Arend Van Spriel <aspriel@gmail.com>
Cc:     Julian Calaby <julian.calaby@gmail.com>,
        Dmitry Antipov <dmantipov@yandex.ru>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Hector Martin <marcan@marcan.st>,
        SHA-cyfmac-dev-list@infineon.com,
        brcm80211-dev-list.pdl@broadcom.com
Subject: Re: On brcm80211 maintenance and support
References: <6f78e624-62ee-3ae5-1db4-a0411566def8@yandex.ru>
        <CAGRGNgU7aySyUny9aG_+wXiKJ7j1weosa-rZDY4_WAXbq-3ABg@mail.gmail.com>
        <87ttr454bh.fsf@kernel.org>
        <cd9e71c8-2884-427a-a394-756f62ab09ba@gmail.com>
Date:   Wed, 11 Oct 2023 10:46:36 +0300
In-Reply-To: <cd9e71c8-2884-427a-a394-756f62ab09ba@gmail.com> (Arend Van
        Spriel's message of "Mon, 9 Oct 2023 22:22:23 +0200")
Message-ID: <87mswpfvoj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend Van Spriel <aspriel@gmail.com> writes:

>>> I think it's pretty safe to say that this driver is nearly
>>> unmaintained by Broadcom, definitely unmaintained by Cypress /
>>> Infineon and Arend is unable to answer questions relating to anything
>>> beyond the code as-written.
>>>
>>> Kalle, should this driver get orphaned?
>> We definitely need to consider that but let's first wait for Arend
>> to
>> comment.
>
> Using my personal email account to comment. Broadcom has pulled away
> most resources from the brcm80211 drivers as there is no business
> interest for it and it turned into a one-fifth man show as I was
> granted to work one day a week on brcm80211. Nice theory but in
> practice other work always takes priority.

Sorry to hear that. I know big corporations well enough that it doesn't
work like that in reality :/

> So "nearly unmaintained" is no exaggeration. I probably can not meet
> the expectations some people in the community have regarding driver
> maintainers, but I can still review patch submissions although I
> should keep a better eye on the list to do that. It would not be my
> choice to abandon brcm80211, but if my contributions are considered
> insufficient than I will accept that fact.

I definitely would want you to continue maintaining brcm80211! I know
how difficult it can be between a rock and a hard place so I value your
contributions, and understand sometimes you are not able to react
quickly (or at all).

What about Franky and Hante? I wonder if we should remove them? Or
convert them to reviewers?

Also I'm thinking should we change the driver status to Odd Fixes:

          Odd Fixes:   It has a maintainer but they don't have time to do
                        much other than throw the odd patch in. See below..

Of course there's no practical difference what the driver status is but
I nowadays try to keep the maintainers file up-to-date.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
