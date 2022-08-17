Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902A6596B5D
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Aug 2022 10:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiHQIaw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Aug 2022 04:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiHQIau (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Aug 2022 04:30:50 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5866B7C766
        for <linux-wireless@vger.kernel.org>; Wed, 17 Aug 2022 01:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=pUXMUJa82Y4IMLdzC18iKA2e80pkPuOgUxS/S3ws7QQ=;
        t=1660725048; x=1661934648; b=UJvVUAFScSCwwhat/wV2fRdQirLD+DMxkuoZ1YNUgX+9fBG
        hNrRfUyp5HsuR9sNeGjPB+zDWubQpOv2RhZlCxo8OevePj6JlE3OjyBXOU3XXLeYMD639B5cItgTB
        9+Qf+bTn/mNQZtM5W92SyAXiIj98dwyj7tHoX1mL6i3zitOSBkDK//Dxv4VZzlum0VmAkBlNW7CmO
        MTOaGIHtV39Y4nLFNEVoGF7Dn1AlStPfjqRlFRfx8kMXg3KLQPhH8N+Bzi2pLANXOy9kbImsQ6w8h
        JbIyEv/fT4sJ5WcjhS+6mTGMzA+n+34aYxbcHZTZrAnkGa2YcWfzCvMfV/e1C7tw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oOERb-00AIBn-2i;
        Wed, 17 Aug 2022 10:30:32 +0200
Message-ID: <5b24421363048bff1a9f03174cb0223b3e226bf9.camel@sipsolutions.net>
Subject: Re: [PATCH 1/9] wifi: mac80211: allow enabling chanctx until hw
 registration
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sean Wang <sean.wang@kernel.org>
Cc:     Sean Wang =?UTF-8?Q?=28=E7=8E=8B=E5=BF=97=E4=BA=98=29?= 
        <sean.wang@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, jenhao.yang@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        kuabhs@google.com, druth@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Date:   Wed, 17 Aug 2022 10:30:30 +0200
In-Reply-To: <CAGp9LzrqYsXAPsbZvTy-_3Tnu23oc11KHdxNs9WvYfe0JHQaDg@mail.gmail.com>
References: <cover.1660606893.git.objelf@gmail.com>
         <473fc7b169f288b7815a7736cf33ac0ec1599a09.1660606893.git.objelf@gmail.com>
         <edd45a1e732a0eef1894b9f6eda2d4e3c692359b.camel@sipsolutions.net>
         <CAGp9LzrqYsXAPsbZvTy-_3Tnu23oc11KHdxNs9WvYfe0JHQaDg@mail.gmail.com>
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

On Wed, 2022-08-17 at 01:28 -0700, Sean Wang wrote:
> Based on mt76 driver logic, alloc_hw would be needed before loading firmw=
are
> because alloc_hw creates an instance of "struct mt76_dev*" the
> firmware loading relies on,
> and so the firmware capabilities cannot be decided before we alloc_hw
> in mt76 driver.
>=20

I don't really see why you couldn't change that though? There's no
fundamental reason you need to load the firmware before registering with
mac80211?

And fundamentally, I'm not even sure how you are achieving a change of
the ops - you're meant to point those to a *const* ops, so you need two
versions of the ops, one with and one without chanctx, and point to the
correct one at allocation ...

johannes
