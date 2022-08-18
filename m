Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E294359914A
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Aug 2022 01:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243925AbiHRXlM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Aug 2022 19:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240276AbiHRXlL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Aug 2022 19:41:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708F3DDB54
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 16:41:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D6AF61762
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 23:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F5BC433D6
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 23:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660866069;
        bh=4/ee5rBqbhthSFfgx0AiAmy1Qrru12HILchShtOcxxE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PGZc0ZZuDKI2e7yhIoCCNA+EjMy5Gqjw76eWfTVFJRPd1z7vb3FGb8+CmM+qd2CYt
         xhFj2kCt4Naay/kzSAaqbA437zIo1JJh63HBq7I7+h2ETTG2bOshoiONlysoyIifvG
         J98+V9pSjXFJpYtFv79RC7bLRWXBkRyNC2m5TE5gCyE32NeXqa4L0UXDLOob1XA0xb
         lz6lI93M7V6kaOlSatrk1R1BVgg+GbkU/OlH6z+4rOLyN/2F6Vosl/xA4UAe+/mJ84
         48Th56rPkuIGk9m/Kt2kMKFvtP0ALFx4ye5F3ZyCQOJcc30p2xr2xzgp8upUQvg+Jd
         wm9ca4YXwgUmw==
Received: by mail-wr1-f53.google.com with SMTP id ba1so3369874wrb.5
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 16:41:09 -0700 (PDT)
X-Gm-Message-State: ACgBeo1uPXtNupENRI3zEJvyLVcgWXQCnSrr+/UxvgD7a+oCzSRECJli
        bFAgj1k63CEsRtXqwhYU/NNySs0jZeDSwAbly9Y=
X-Google-Smtp-Source: AA6agR5ZJ6gxUVqKmNxkae+ip9TV++y1z/ialgt2eVNcbJFbYVoS3eSGEcSkdmBf40A//TgWbFV9Gr8ZGglYARFpSDU=
X-Received: by 2002:a05:6000:1547:b0:221:7a23:ab67 with SMTP id
 7-20020a056000154700b002217a23ab67mr2756819wry.515.1660866067658; Thu, 18 Aug
 2022 16:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660606893.git.objelf@gmail.com> <473fc7b169f288b7815a7736cf33ac0ec1599a09.1660606893.git.objelf@gmail.com>
 <edd45a1e732a0eef1894b9f6eda2d4e3c692359b.camel@sipsolutions.net>
 <CAGp9LzrqYsXAPsbZvTy-_3Tnu23oc11KHdxNs9WvYfe0JHQaDg@mail.gmail.com>
 <5b24421363048bff1a9f03174cb0223b3e226bf9.camel@sipsolutions.net>
 <CAGp9Lzrag1b3G+QfW0RCQPGLnR_WzGSg4k+Zdx4zi4b_oeunRQ@mail.gmail.com> <dc45daf23fc8084596f1da8cb41afb422b24160d.camel@sipsolutions.net>
In-Reply-To: <dc45daf23fc8084596f1da8cb41afb422b24160d.camel@sipsolutions.net>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Thu, 18 Aug 2022 16:40:55 -0700
X-Gmail-Original-Message-ID: <CAGp9LzqmFKs8wp-g7WsJ=uUj_OqucQskdMDwM6yf2dZyuP0ABA@mail.gmail.com>
Message-ID: <CAGp9LzqmFKs8wp-g7WsJ=uUj_OqucQskdMDwM6yf2dZyuP0ABA@mail.gmail.com>
Subject: Re: [PATCH 1/9] wifi: mac80211: allow enabling chanctx until hw registration
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     =?UTF-8?B?U2VhbiBXYW5nICjnjovlv5fkupgp?= <sean.wang@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, lorenzo.bianconi@redhat.com,
        Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren Wu <Deren.Wu@mediatek.com>, km.lin@mediatek.com,
        jenhao.yang@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        kuabhs@google.com, druth@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On Thu, Aug 18, 2022 at 3:49 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Hi Sean,
>
> > It could be changed but it would break the consistency of the current
> > mt76 driver.
>
> I'm not really convinced ...
>
> > mt76 driver does the things in the following order
> > - ieee80211_alloc_hw (where an instance of "struct mt76_dev *" would be created)
> > - register bus operation into mt76 core (depending on struct mt76_dev
> > to provide an abstraction layer for mt76 core to access bus)
> > - read chip identifier (depending on bus operation)
> > - load the firmware capabilities (depending on chip identifier)
> > - initialize the hardware
> > ....
> > -ieee80211_register_hw
> >
> > If firmware capability is needed to load before ieee80211_alloc_hw, we
> > need to create kind of similar functions to read chip identifiers and
> > load firmware.
> > I know It may not a strong reason not to change, but if we can support
> > read firmware capabilities after alloc_hw, it provides flexibility to
> > the vendor driver
> > and helps mt7921 look more consistent and save a few changes across
> > different mt7921 bus drivers (mt7921 now supports SDIO, USB, PCIe type
> > driver).
>
> But you're loading _firmware_, so to determine the capabilities all you
> should need is the actual file, no? I mean, you don't even have to load
> it into the device. Like iwlwifi, you could have an indication (or many
> flags, or TLVs, or whatnot) in the file that says what it's capable of.
>
> > I kmemdup the const ops and ieee80211_alloc_hw with the duplicated ops
> > the duplicated ops would be updated by the actual firmware
> > capabilities before ieee80211_register_hw.
>
> Well ... yeah ok that works, but it's pretty wasteful, and also makes
> this a nice security attack target - there's a reason ops structs are
> supposed to be const, that's because they can then be really read-only
> and you can't have function pointer changes. Some of the CFI stuff is
> meant to help avoid that, but still ...
>
> So anyway. I'm not really sure I buy this - even you while doing this
> already kind of introduced a bug because you didn't change this code:
>
>         if (!use_chanctx || ops->remain_on_channel)
>                 wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;
>
> I guess you didn't notice because you have remain_on_channel in the
> first place, but that's not the only code there assuming that we have
> the ops in place and they don't change.
>
> If we really, really need to allow changing the ops, then we should
> probably make a much larger change to not even pass the ops until
> register, though I'm not really sure it's worth it just to have mt7921
> avoid loading the firmware from disk before allocation?
>
> johannes

Thanks for your input. I thought I'd try to write a patch to follow up
on the idea you mentioned here.
    sean
