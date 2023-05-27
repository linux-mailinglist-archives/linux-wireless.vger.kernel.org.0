Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C1E7132E3
	for <lists+linux-wireless@lfdr.de>; Sat, 27 May 2023 09:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjE0HPs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 May 2023 03:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE0HPs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 May 2023 03:15:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6146D125
        for <linux-wireless@vger.kernel.org>; Sat, 27 May 2023 00:15:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBF2060F4E
        for <linux-wireless@vger.kernel.org>; Sat, 27 May 2023 07:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FAADC433EF;
        Sat, 27 May 2023 07:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685171745;
        bh=hOVuHP2CY5L91+kUBLaAQXme4GjPrkKMZjhE9sZaDa4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=cQiNW1wHfEyLPKmx9j6vCpY6I6DX7psiph8nxuJD0Au9dFE0VL7xTUGnDk+3R+eX/
         EA2Wh5nskw5ZBFO7gtI4zmuCQBSkvwHkURov9LeYfvq1ouZBPFgfnWTQI/6uE3+huN
         nIEKrRbe/f6YYVBtuOqMnyA6J+/fGfIy+oWauQDuqGAfkQw7EbKcfkr1N36Zur7oTD
         35+JmrSqDL9dW3NO1yKNr98V5iklWJQQgJZXOuwV+O/RkuVeC0SaLExexdzAWvBsOu
         K1XYIFKQg5ZgmXdF77+fiw3yPgdivBMiawb4XyAucfnlFros84mAlKT5atPDoQyPly
         bnIY7nf5n38Ng==
From:   Kalle Valo <kvalo@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: rtw88: Problem with sdio.c
References: <1027342a-97dd-83cd-f363-43cff49967e2@lwfinger.net>
        <2681990.mvXUDI8C0e@jernej-laptop>
        <547524c3-bfb4-8132-b309-6eb9e648881e@lwfinger.net>
Date:   Sat, 27 May 2023 10:15:41 +0300
In-Reply-To: <547524c3-bfb4-8132-b309-6eb9e648881e@lwfinger.net> (Larry
        Finger's message of "Wed, 24 May 2023 15:31:55 -0500")
Message-ID: <875y8ekzxe.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> On 5/24/23 14:18, Jernej =C5=A0krabec wrote:
>>
>> This was fixed in:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3Dcb0ddaaa5db09d7d216fcbf0e68779be223a1128
>
> That fix is in the kernel mainline source, but not in wireless-next,
> where I got my source. I hope it gets resolved correctly.

The fix should come to wireless-next after the next (no pun intended)
net-next pull request. One way to avoid this problem of not having all
the fixes is to use the wireless-testing tree:

https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-testing.g=
it/

In that tree Bob Copeland periodically pulls both wireless and
wireless-next to the latest -rc releases and that way you can easily get
all the latest wireless code from one tree. For example I use
wireless-testing as the baseline for all my ath1*k drivers testing. But
do note that the tree is rebased so the history is not stable.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
