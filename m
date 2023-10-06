Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C907BB77B
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Oct 2023 14:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjJFMWB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Oct 2023 08:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjJFMWA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Oct 2023 08:22:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B17ACA
        for <linux-wireless@vger.kernel.org>; Fri,  6 Oct 2023 05:21:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91D2C433C7;
        Fri,  6 Oct 2023 12:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696594919;
        bh=O9WIz0wKW84YgqoCVsyMw+N5LTvDV1mzG7gMzBO8rHE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=S1ySHGJDbf2+24R5jw/YL8CJQt/y/hbkQPhE6PATtuXX6JG7ziNK/I+YDY2dTFfT8
         RwBisnO5iZFLpg6dDm+XDMI1n3wGNbjOIWzlHj/CizpOTK+x6KLXWfT/h1+dYy4O/M
         5eO9NlQhbIX+DSAvXSmzYutU5Oupqzsx0A0U+VD3RWncg5mBcCB5H4S/BGDnKMRBE6
         YQfl/huF4+8E+E0swRJzjP5T41J9sVhiPF/FAM73RBqOCBvfpRFOrsb0PeOfP2ABed
         QyTTbSEkQBOnDio2tGlcvqvHtf85i+d+4/H+cLhNd7IoFBFllRgkCl2SDCcMqGdFuw
         i3HA4ozu4XEFA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Julian Calaby <julian.calaby@gmail.com>
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Hector Martin <marcan@marcan.st>,
        SHA-cyfmac-dev-list@infineon.com,
        brcm80211-dev-list.pdl@broadcom.com
Subject: Re: On brcm80211 maintenance and support
References: <6f78e624-62ee-3ae5-1db4-a0411566def8@yandex.ru>
        <CAGRGNgU7aySyUny9aG_+wXiKJ7j1weosa-rZDY4_WAXbq-3ABg@mail.gmail.com>
Date:   Fri, 06 Oct 2023 15:21:54 +0300
In-Reply-To: <CAGRGNgU7aySyUny9aG_+wXiKJ7j1weosa-rZDY4_WAXbq-3ABg@mail.gmail.com>
        (Julian Calaby's message of "Fri, 6 Oct 2023 21:44:05 +1100")
Message-ID: <87ttr454bh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Julian Calaby <julian.calaby@gmail.com> writes:

> Hi Dmitry,
>
> (relevant people and lists CC'd)
>
> On Fri, Oct 6, 2023 at 3:16=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.r=
u> wrote:
>>
>> Kalle,
>>
>> what's an actual status of brcm80211 driver? It seems
>> that the relevant MAINTAINERS entries are no longer
>> useful, and [1] states that Broadcom is just "disappeared".
>
> Arend hasn't posted since February:
> https://lore.kernel.org/linux-wireless/63f72045-e51d-d9a4-a0ed-c221bcdcee=
03@gmail.com/
>
> Franky is still reviewing things as of early August:
> https://lore.kernel.org/linux-wireless/CA+8PC_evb-6Y3dKnAN4BN=3DODEVxY5-c=
Db6Lc72u0j1WBtx7p1A@mail.gmail.com/
>
> Hante hasn't posted since 2018:
> https://lore.kernel.org/linux-wireless/4f6223b8083ed69432493a37d4f45b69@m=
ail.gmail.com/
>
> Hector Martin has a bunch of Apple-specific patches downstream in the
> Asahi Linux kernel and has been looking for guidance on how to
> upstream it without any real answers:
> https://lore.kernel.org/linux-wireless/181af6e9-799d-b730-dc14-ee2de2541f=
35@marcan.st/
>
> There's also speculation that the Raspberry Pi people have downstream
> patches too, but I haven't been able to find anything concrete in a
> very brief search.

Thanks for the research, that is helpful.

> Finally, the Cypress / Infineon people appear to be uninterested in
> discussing the driver.
>
> I think it's pretty safe to say that this driver is nearly
> unmaintained by Broadcom, definitely unmaintained by Cypress /
> Infineon and Arend is unable to answer questions relating to anything
> beyond the code as-written.
>
> Kalle, should this driver get orphaned?

We definitely need to consider that but let's first wait for Arend to
comment.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
