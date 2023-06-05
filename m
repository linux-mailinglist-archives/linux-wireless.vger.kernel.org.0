Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFD2722511
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 14:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjFEMAU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 08:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjFEMAQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 08:00:16 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B87114
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 05:00:13 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f624daccd1so1612607e87.0
        for <linux-wireless@vger.kernel.org>; Mon, 05 Jun 2023 05:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google; t=1685966412; x=1688558412;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=thzSH8V+nZGLdDe/+tQbOyX8rabWsuWIkl957hX7v7Q=;
        b=RUa4tbD/sPD6sWa3AdagabOEWCHU6V/CtzVoJOCo2sGOvsG30PMX7PLhTIGKOuTIyo
         XxfBAHXXoFGTlaYi6QUY80VJOnuhFraFASG7j75K79ZrkALR1xiI9JrtwKkuRsBveqXG
         /TuwuzgKu+ef1U+eBw3T0lcRpZ+taPBziEjLtXdV1gjigdL6zqg74hNLLv2H2PoQLVwz
         4ls2nwGepYtah2YXZhlgeAjQt/tGF7g5uBbZGFLXZZW/uGV1pUeyGngRkBFG6eZMRpPu
         4xuKACGw0ns/y+puCfW+ms/zrjfKCGg5BweaS2bJAggEyLa03T/UiK+qrQ6/hZtJHxGq
         ZSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685966412; x=1688558412;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thzSH8V+nZGLdDe/+tQbOyX8rabWsuWIkl957hX7v7Q=;
        b=EAtuP77iIAv5zM9qbTSddp4kaRSfJgFvAYD3CX7ZFBbKOhUnythQ8ZcC/IpGTeTwCH
         T6fXU2PiwcsZV8optCXX9DIfeAJC2IogEj7s2VJQa/llHG8RQINsihT0XgVwpwPRh0zL
         qCYcmktmKlw+4LNA7mXTjZdKVwYJTZvPbfB5+vh/FXz7+gTDlnodHFEbbf3JmvOQGtxr
         uMVMtMg2/L2AtuelvMehTiby5VUjRAZZIdjTK9xN/Sbzp39WB8senaVXv/41yL7nBXpk
         hRKs/IwD3o/J3g0LKB3/F0+RUxEPT1zDzJq6/CbMgrheiPNvK4un0+5wlcQMTyq2v7WQ
         SXaA==
X-Gm-Message-State: AC+VfDxVwwSgI/Ra+1XT7shrKZ7dwYxvqbtjyRCrRUdNsBwO1H6AfsHy
        fSvhTcrupyRDcJ9cRVMfozsvRjdiAENepnnxAXmkeg==
X-Google-Smtp-Source: ACHHUZ7MSFXuPm9koNZLkoYBZda/IAEnTR32LE4oAkc+Uxi5KLrzWrxz8SP1xYmUtdUlzgzEDuPLfxFtyWlpO9O4NVg=
X-Received: by 2002:a2e:8746:0:b0:2ac:8486:e318 with SMTP id
 q6-20020a2e8746000000b002ac8486e318mr3802494ljj.35.1685966411960; Mon, 05 Jun
 2023 05:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <1675433281-6132-1-git-send-email-ganapathi.kondraju@silabs.com>
 <87lekj1jx2.fsf@kernel.org> <8eb3f1fc-0dee-3e5d-b309-e62349820be8@denx.de>
 <112376890.nniJfEyVGO@pc-42> <dd9a86af-e41a-3450-5e52-6473561a3e18@denx.de>
In-Reply-To: <dd9a86af-e41a-3450-5e52-6473561a3e18@denx.de>
Reply-To: martin.fuzzey@flowbird.group
From:   "Fuzzey, Martin" <martin.fuzzey@flowbird.group>
Date:   Mon, 5 Jun 2023 14:00:00 +0200
Message-ID: <CANh8Qzzzg775T87UvoTywj-ByuP4=_9KpHkCgP4TqZW5CBY=pg@mail.gmail.com>
Subject: Re: [PATCH v3] MAINTAINERS: Add new maintainers to Redpine driver
To:     Marek Vasut <marex@denx.de>
Cc:     =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>,
        Kalle Valo <kvalo@kernel.org>,
        Ganapathi Kondraju <ganapathi.kondraju@silabs.com>,
        linux-wireless@vger.kernel.org,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Amol Hanwate <amol.hanwate@silabs.com>,
        Angus Ainslie <angus@akkea.ca>,
        Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Martin Kepplinger <martink@posteo.de>,
        Narasimha Anumolu <narasimha.anumolu@silabs.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Shivanadam Gude <shivanadam.gude@silabs.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        Srinivas Chappidi <srinivas.chappidi@silabs.com>,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 5 Jun 2023 at 11:59, Marek Vasut <marex@denx.de> wrote:
> I have to admit, the aforementioned paragraph is quite disturbing,
> considering that this patch adds 6 maintainers, is already in V3, and so
> far it is not even clear to silabs how much effort it would be to
> maintain driver for their own hardware, worse, silabs didn't even check.
> What is the point of adding those maintainers then ?
>
Totally agree.

IMHO (very humble, I'm not a maintainer, just a guy who has submitted
and had merged a few patches to this driver) people shouldn't be added
to MAINTAINERS
*just* because they work for the company making the hardware and have
been assigned to do driver work for it.
Rather I think they should demonstrate, over a couple of development
cycles, their ability and availability, preferably both submitting
patches themselves and reviewing other patches.
(This is not in any way a judgement of the proposed maintainers as I
have seen nothing from them).

And starting with one or two people doing that part time would be a
way for Silabs to get a better idea of the effort needed.

> This driver is basically unusable and I am tempted to send a patch to
> move it to staging and possibly remove it altogether.
>
I do think this is a little harsh though. It certainly still has bugs
but I think it is usable, at least for some use cases.

>
> Multiple people tried to fix at least a couple of basic problems, so the
> driver can be used at all, but there is no documentation and getting
> support regarding anything from RSI is a total waste of time. Sadly, the
> only reference material I could find and work with is some downstream
> goo, which is released in enormous single-commit code dumps with +/-
> thousands of lines of changes and with zero explanation what each change
> means.
>
Yes absolutely and this is a huge problem for this type of driver.

For simpler hardware (like most I2C, SPI chips) anyone who has
reasonable knowledge of the Linux kernel and the hardware datasheet
can write a driver.
Here the hardware datasheet isn't enough you really need the firmware
interface documentation (which isn't available publicly) because
the actual *hardware* isn't that important from a driver perspective.
The driver is an interface between the Kernel 802.11 stack and the
*firmware*.

Actually I would rather have public interface documentation than
official maintainers working for the vendor (though both would be
great).

Martin
