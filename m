Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A63596B52
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Aug 2022 10:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbiHQI3A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Aug 2022 04:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbiHQI26 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Aug 2022 04:28:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5613E5300B
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 01:28:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4490B81C6A
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 08:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA447C433D6
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 08:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660724933;
        bh=NfEazfKiz9tI/UbDx3opYeVqOgRtBHkrOLzzgPvvlDk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Aoee0nFAD14JUtrcxjDv+8GaUMtR/sFDljKGtoffd0UECDzgBV8HzHjicD3spWydg
         ng5RP/nj5aUm6zJEy86cQ17sHOdtmtr93NYCkREuoaZxvqGELikidckMyc0u8pjSnu
         DvZcCKVNpG9/H0wVmx9LXFQMxWbJh2WdOXY74G6Bw2fBuu6azlQa+PFvn38rFPAJhf
         j0VfCyoor5Cbs+d2AT0ROz87XrDJpSgfG2KSg6xX1IOcgKWqHjCBX6RAMvKvAg32+K
         tmBcxVXhFx9ZKQx4AtYbyUB7fMAXmJaYwKf6JOLL5gDyAwVCFhdwU6t2fN+cbnFq9F
         0k5upY5WbwQ7A==
Received: by mail-wr1-f51.google.com with SMTP id f8so1654912wru.13
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 01:28:53 -0700 (PDT)
X-Gm-Message-State: ACgBeo1IuV8NAnq46rSOokFZmcOeI+/HpZdzc+8VjIFXeDHzptiHWxqD
        DgrxEzD+GeAJ3rCi/bnsvJHA9fJ9thR9/xuV4sw=
X-Google-Smtp-Source: AA6agR61OJZM3fGBROkiHMMfY4la7OjXFAkjkIbBDYUIDGf4lVRcQp70H5v+gHqzg10DvAWVU3T3Lwh66vReUrCVhhc=
X-Received: by 2002:a5d:6f08:0:b0:21e:cfc7:bfd1 with SMTP id
 ay8-20020a5d6f08000000b0021ecfc7bfd1mr13862153wrb.329.1660724931945; Wed, 17
 Aug 2022 01:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660606893.git.objelf@gmail.com> <473fc7b169f288b7815a7736cf33ac0ec1599a09.1660606893.git.objelf@gmail.com>
 <edd45a1e732a0eef1894b9f6eda2d4e3c692359b.camel@sipsolutions.net>
In-Reply-To: <edd45a1e732a0eef1894b9f6eda2d4e3c692359b.camel@sipsolutions.net>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Wed, 17 Aug 2022 01:28:37 -0700
X-Gmail-Original-Message-ID: <CAGp9LzrqYsXAPsbZvTy-_3Tnu23oc11KHdxNs9WvYfe0JHQaDg@mail.gmail.com>
Message-ID: <CAGp9LzrqYsXAPsbZvTy-_3Tnu23oc11KHdxNs9WvYfe0JHQaDg@mail.gmail.com>
Subject: Re: [PATCH 1/9] wifi: mac80211: allow enabling chanctx until hw registration
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     =?UTF-8?B?U2VhbiBXYW5nICjnjovlv5fkupgp?= <sean.wang@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, lorenzo.bianconi@redhat.com,
        Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        jenhao.yang@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        kuabhs@google.com, druth@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
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

On Tue, Aug 16, 2022 at 3:22 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2022-08-16 at 08:03 +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> >
> > MT7921 device can be supported with the channel context depending on
> > the newer firmware so that we need a way to enable the chanctx related
> > methods until hw is being registered.
> >
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  net/mac80211/main.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> > index 5b1c47ed0cc0..98d05ed1a081 100644
> > --- a/net/mac80211/main.c
> > +++ b/net/mac80211/main.c
> > @@ -1011,6 +1011,14 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
> >               return -EINVAL;
> >  #endif
> >
> > +     /* check all or no channel context operations exist */
> > +     i = !!local->ops->add_chanctx + !!local->ops->remove_chanctx +
> > +         !!local->ops->change_chanctx + !!local->ops->assign_vif_chanctx +
> > +         !!local->ops->unassign_vif_chanctx;
> > +     if (WARN_ON(i != 0 && i != 5))
> > +             return -EINVAL;
> > +     local->use_chanctx = i == 5;
> > +
>
> Not sure I understand this - this just *adds* code, based on the
> description I would've expected you to *move* code?

It can be done and looks better by *move* code instead of *adds* code.
I will change it in the next version. Thanks for your input.

>
> In any case, I'm not sure I see how this makes sense - ops is supposed
> to be const, and you're supposed to pass it to alloc_hw already, so how
> would it change?!
>
> Also, conceptually, I'm not sure why it's needed to alloc_hw before
> loading firmware, we also have a lot of things depend on the firmware
> capabilities in iwlwifi/mvm, and so we alloc/register HW after loading
> firmware.
>

Based on mt76 driver logic, alloc_hw would be needed before loading firmware
because alloc_hw creates an instance of "struct mt76_dev*" the
firmware loading relies on,
and so the firmware capabilities cannot be decided before we alloc_hw
in mt76 driver.

    sean

> johannes
>
