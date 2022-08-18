Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D6E5981A8
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Aug 2022 12:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244170AbiHRKts (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Aug 2022 06:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244125AbiHRKtq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Aug 2022 06:49:46 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFC586053
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 03:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Cxh+pX2nwTETQjm5J+NETFUMm39MsJUeCFIoGI8bqZE=;
        t=1660819784; x=1662029384; b=XO2lISUDD6+HuaokA434xa3btDgMhOFTGgu0yhRRzejayUh
        ttaUW61ptsbcfcv4v3y8fno52xzMK3DaIqMi72q4qwzZ2XTwRiZO+PRDcWVnqtCLKbpYw/A7uPzLJ
        9Ia+YqEFGN1m3/Ng1em+/wiilIobIXTnBH25Z+icWTkdSCkYgq8F7zMm//HylhPKD6qCrZPG22Gi8
        dxvTX+JQSiefZGZSnCer6xMl7pvlRVSyvQOEwO6yUCf5/IDtOwmYY76F4A/XxKarS/h0vZ4GhUrvT
        ZhI9sI3rzjv75GQgOphvHFQp0VBnzRUhs+UrzWwMa5uRW7wlMn3+bnGxZNir9k4A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oOd5a-00BCG2-2y;
        Thu, 18 Aug 2022 12:49:27 +0200
Message-ID: <dc45daf23fc8084596f1da8cb41afb422b24160d.camel@sipsolutions.net>
Subject: Re: [PATCH 1/9] wifi: mac80211: allow enabling chanctx until hw
 registration
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sean Wang <sean.wang@kernel.org>
Cc:     Sean Wang =?UTF-8?Q?=28=E7=8E=8B=E5=BF=97=E4=BA=98=29?= 
        <sean.wang@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren Wu <Deren.Wu@mediatek.com>,
        km.lin@mediatek.com, jenhao.yang@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        kuabhs@google.com, druth@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 18 Aug 2022 12:49:25 +0200
In-Reply-To: <CAGp9Lzrag1b3G+QfW0RCQPGLnR_WzGSg4k+Zdx4zi4b_oeunRQ@mail.gmail.com>
References: <cover.1660606893.git.objelf@gmail.com>
         <473fc7b169f288b7815a7736cf33ac0ec1599a09.1660606893.git.objelf@gmail.com>
         <edd45a1e732a0eef1894b9f6eda2d4e3c692359b.camel@sipsolutions.net>
         <CAGp9LzrqYsXAPsbZvTy-_3Tnu23oc11KHdxNs9WvYfe0JHQaDg@mail.gmail.com>
         <5b24421363048bff1a9f03174cb0223b3e226bf9.camel@sipsolutions.net>
         <CAGp9Lzrag1b3G+QfW0RCQPGLnR_WzGSg4k+Zdx4zi4b_oeunRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Sean,

> It could be changed but it would break the consistency of the current
> mt76 driver.

I'm not really convinced ...

> mt76 driver does the things in the following order
> - ieee80211_alloc_hw (where an instance of "struct mt76_dev *" would be c=
reated)
> - register bus operation into mt76 core (depending on struct mt76_dev
> to provide an abstraction layer for mt76 core to access bus)
> - read chip identifier (depending on bus operation)
> - load the firmware capabilities (depending on chip identifier)
> - initialize the hardware
> ....
> -ieee80211_register_hw
>=20
> If firmware capability is needed to load before ieee80211_alloc_hw, we
> need to create kind of similar functions to read chip identifiers and
> load firmware.
> I know It may not a strong reason not to change, but if we can support
> read firmware capabilities after alloc_hw, it provides flexibility to
> the vendor driver
> and helps mt7921 look more consistent and save a few changes across
> different mt7921 bus drivers (mt7921 now supports SDIO, USB, PCIe type
> driver).

But you're loading _firmware_, so to determine the capabilities all you
should need is the actual file, no? I mean, you don't even have to load
it into the device. Like iwlwifi, you could have an indication (or many
flags, or TLVs, or whatnot) in the file that says what it's capable of.

> I kmemdup the const ops and ieee80211_alloc_hw with the duplicated ops
> the duplicated ops would be updated by the actual firmware
> capabilities before ieee80211_register_hw.

Well ... yeah ok that works, but it's pretty wasteful, and also makes
this a nice security attack target - there's a reason ops structs are
supposed to be const, that's because they can then be really read-only
and you can't have function pointer changes. Some of the CFI stuff is
meant to help avoid that, but still ...

So anyway. I'm not really sure I buy this - even you while doing this
already kind of introduced a bug because you didn't change this code:

        if (!use_chanctx || ops->remain_on_channel)
                wiphy->flags |=3D WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL;

I guess you didn't notice because you have remain_on_channel in the
first place, but that's not the only code there assuming that we have
the ops in place and they don't change.

If we really, really need to allow changing the ops, then we should
probably make a much larger change to not even pass the ops until
register, though I'm not really sure it's worth it just to have mt7921
avoid loading the firmware from disk before allocation?

johannes
