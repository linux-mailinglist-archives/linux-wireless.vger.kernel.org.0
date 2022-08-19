Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DFB59A4D7
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Aug 2022 20:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354841AbiHSRtL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Aug 2022 13:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354825AbiHSRsU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Aug 2022 13:48:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5201E10E94C
        for <linux-wireless@vger.kernel.org>; Fri, 19 Aug 2022 10:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=H/4mvViWUl57A1az6fHnkvC2V1VDyS0ZsWKbuu9P7NM=;
        t=1660929433; x=1662139033; b=gFF0rdPwpEwLx5pPq6vyyzoApoQ3LYcvsdrf8a3byGe/Rua
        sW+s+N7t3jrFmwvGRtMVvgkmtRhk63JboLOS+izn4FLjGQEYuhOGFIGeOrCX+HSe2gofoUV9HA1UB
        NIorbY2eycBw5kslXkHL/Ntm+Do387AoDiSfNGwx7zv3c4WGcFxWLBhCj8RluP4/BKUvBz3wI8O+N
        OZNSbKYVvHlQZK8/he7u++paAwEGIJfz8P87H2YnpK7DwBosaTGoJw5C5WuPwFKpoIE0ffjoIfuyX
        4BWxbqtBlZQ5v6GsuR8F9HGqnfAnXphUlhxhAqS0QjELEViDrWIzwCfXR0VYgPlQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oP5cB-00C6oW-2V;
        Fri, 19 Aug 2022 19:16:59 +0200
Message-ID: <096c975e7287cbe22fd355bcfd4b3889c890bdc7.camel@sipsolutions.net>
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
Date:   Fri, 19 Aug 2022 19:16:58 +0200
In-Reply-To: <CAGp9LzqmFKs8wp-g7WsJ=uUj_OqucQskdMDwM6yf2dZyuP0ABA@mail.gmail.com>
References: <cover.1660606893.git.objelf@gmail.com>
         <473fc7b169f288b7815a7736cf33ac0ec1599a09.1660606893.git.objelf@gmail.com>
         <edd45a1e732a0eef1894b9f6eda2d4e3c692359b.camel@sipsolutions.net>
         <CAGp9LzrqYsXAPsbZvTy-_3Tnu23oc11KHdxNs9WvYfe0JHQaDg@mail.gmail.com>
         <5b24421363048bff1a9f03174cb0223b3e226bf9.camel@sipsolutions.net>
         <CAGp9Lzrag1b3G+QfW0RCQPGLnR_WzGSg4k+Zdx4zi4b_oeunRQ@mail.gmail.com>
         <dc45daf23fc8084596f1da8cb41afb422b24160d.camel@sipsolutions.net>
         <CAGp9LzqmFKs8wp-g7WsJ=uUj_OqucQskdMDwM6yf2dZyuP0ABA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Sean,

> > If we really, really need to allow changing the ops, then we should
> > probably make a much larger change to not even pass the ops until
> > register, though I'm not really sure it's worth it just to have mt7921
> > avoid loading the firmware from disk before allocation?

> Thanks for your input. I thought I'd try to write a patch to follow up
> on the idea you mentioned here.
>=20

I think you will introduce a bug into mt7921 when you do this, and I'm
curious if you will find it ;-)

Seriously though, this approach also seems fragile, and I don't even
know if other bugs would be introduced. And splitting into three
functions (alloc -> set_ops -> register) also feels a bit awkward.


Is there really no chance you could add bits to the firmware _file_
format so you can query the capabilities before you actually _run_ the
firmware? I guess you could even validate it at runtime again (and just
fail is somebody messed up the file), but it would make things a lot
simpler, I'm sure.

johannes
