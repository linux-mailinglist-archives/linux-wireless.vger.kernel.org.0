Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2984D597A84
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Aug 2022 02:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbiHRAL7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Aug 2022 20:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbiHRAL6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Aug 2022 20:11:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754F9A2859
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 17:11:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E46ECB81FF4
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 00:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C22FC433C1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 00:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660781514;
        bh=Ku7R+2tnT1/PcWq+UB/v9DdP1lt1rkcxhef05o0ooII=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HR1nx7iqPCnyMVmkN3PP/0lGjh1kAJFRWmTF7SZakyggGSK6tCJGiUYmVkdCiCGjN
         mJw/yLX9vKXxZ8xA2VkZYloqY6VbXlhOLMD0ne5FEgEXjYnkMc0pNQJ7Y0MYxTvvpl
         j6odjTYic92jT24bXJtUq9zaU+kTKukV/eCQz2jQvs4vwNORYE4Lp4Jd7Hv2f3ejdg
         BhxcWsGKrjPDTtqIsM7rJwxxTpWtmeS5BU+6sTIA6TT8qyt7pU7ThyPsoMJWxI3JfC
         0p3PCvzKTBWakeir3E68CrZ8WuD869ZtaUuIzYxL3bd68hL7EJ6oIzedZ7a4bqRm1t
         mcLFpwTRJchAg==
Received: by mail-wr1-f50.google.com with SMTP id h24so3819616wrb.8
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 17:11:54 -0700 (PDT)
X-Gm-Message-State: ACgBeo2mYlJWjfYGrTC8rz8icuiOtDRg+VjepiNH/HY93TbkL/gK2NAz
        X0xXxUggaFlvEjpj60fC9eMtusDlqwAWv9l5GdI=
X-Google-Smtp-Source: AA6agR6CsWfdjBKQD5ZqOtuIcydzYKdrcHHF/JH7gTE5dMbJs3tEciW5hJZKUau/Qn+2TPBnkGasGScaW6I+D+vYrGo=
X-Received: by 2002:adf:d238:0:b0:21e:c972:7505 with SMTP id
 k24-20020adfd238000000b0021ec9727505mr193529wrh.536.1660781512698; Wed, 17
 Aug 2022 17:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660606893.git.objelf@gmail.com> <473fc7b169f288b7815a7736cf33ac0ec1599a09.1660606893.git.objelf@gmail.com>
 <edd45a1e732a0eef1894b9f6eda2d4e3c692359b.camel@sipsolutions.net>
 <CAGp9LzrqYsXAPsbZvTy-_3Tnu23oc11KHdxNs9WvYfe0JHQaDg@mail.gmail.com> <5b24421363048bff1a9f03174cb0223b3e226bf9.camel@sipsolutions.net>
In-Reply-To: <5b24421363048bff1a9f03174cb0223b3e226bf9.camel@sipsolutions.net>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Wed, 17 Aug 2022 17:11:39 -0700
X-Gmail-Original-Message-ID: <CAGp9Lzrag1b3G+QfW0RCQPGLnR_WzGSg4k+Zdx4zi4b_oeunRQ@mail.gmail.com>
Message-ID: <CAGp9Lzrag1b3G+QfW0RCQPGLnR_WzGSg4k+Zdx4zi4b_oeunRQ@mail.gmail.com>
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

On Wed, Aug 17, 2022 at 1:30 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Wed, 2022-08-17 at 01:28 -0700, Sean Wang wrote:
> > Based on mt76 driver logic, alloc_hw would be needed before loading firmware
> > because alloc_hw creates an instance of "struct mt76_dev*" the
> > firmware loading relies on,
> > and so the firmware capabilities cannot be decided before we alloc_hw
> > in mt76 driver.
> >
>
> I don't really see why you couldn't change that though? There's no
> fundamental reason you need to load the firmware before registering with
> mac80211?
>

It could be changed but it would break the consistency of the current
mt76 driver.

mt76 driver does the things in the following order
- ieee80211_alloc_hw (where an instance of "struct mt76_dev *" would be created)
- register bus operation into mt76 core (depending on struct mt76_dev
to provide an abstraction layer for mt76 core to access bus)
- read chip identifier (depending on bus operation)
- load the firmware capabilities (depending on chip identifier)
- initialize the hardware
....
-ieee80211_register_hw

If firmware capability is needed to load before ieee80211_alloc_hw, we
need to create kind of similar functions to read chip identifiers and
load firmware.
I know It may not a strong reason not to change, but if we can support
read firmware capabilities after alloc_hw, it provides flexibility to
the vendor driver
and helps mt7921 look more consistent and save a few changes across
different mt7921 bus drivers (mt7921 now supports SDIO, USB, PCIe type
driver).

> And fundamentally, I'm not even sure how you are achieving a change of

I kmemdup the const ops and ieee80211_alloc_hw with the duplicated ops
the duplicated ops would be updated by the actual firmware
capabilities before ieee80211_register_hw.

> the ops - you're meant to point those to a *const* ops, so you need two
> versions of the ops, one with and one without chanctx, and point to the
> correct one at allocation ...
>

If you don't like the reason and the way I proposed in the patch,
please let me know. I still can move on to the way you suggested here.

> johannes
