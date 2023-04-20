Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6846F6E9039
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 12:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjDTKaP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 06:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbjDTK3b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 06:29:31 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747CC1A1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 03:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=W1LTOz9vjlQ8X0a4H/eS1OWTX5K2ecZO4ZMmv75gdHM=;
        t=1681986436; x=1683196036; b=Ua6AhrUSUXtcXpnVxzNmAag1p0LwjC2QeTgYNTjxFiPRDwW
        DjMpD9wj1Z3f7qFFM1brGm80OQ/9hAB8FZdOmf4Y4p6fZNdfsI/eC6Z/3LHAJb35nFg/Iv3w6YYS2
        3nmQdLLjUp15JfrOePSxUEl1x51yDbmhelU87/th839WlCL9nka0ji4F4g85WkOmXAWDDmjgRInnm
        OPBuENtvvLpIr0w2LYGLkqemD76LdWclOLuEAvFY6IrZrC1wGAbl0rIsDykqYN358WluE+5sMaObJ
        o4O9qlR5d520SVmnBi0ZZf04Tjq9SZZDxT9THNIstaDNUi4h5VPljf3WcTB6CFpQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ppRVR-003R2E-0V;
        Thu, 20 Apr 2023 12:27:13 +0200
Message-ID: <e4dd26fa53ad2535f5a20be63a4b294d99306ffb.camel@sipsolutions.net>
Subject: Re: [PATCH v1] wifi: mac80211: Initialize EWMA fail avg to 1
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>,
        Karthik M <quic_karm@quicinc.com>
Cc:     linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Date:   Thu, 20 Apr 2023 12:27:11 +0200
In-Reply-To: <50a76761-5be3-8ea7-c2f3-a14c158aa039@uni-rostock.de>
References: <20230417100258.22965-1-quic_karm@quicinc.com>
         <bc1903aa09391667262aeadf1859600579f0a9f1.camel@sipsolutions.net>
         <50a76761-5be3-8ea7-c2f3-a14c158aa039@uni-rostock.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
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

On Thu, 2023-04-20 at 11:30 +0200, Benjamin Beichler wrote:
> > To me, basically, I see two ways to solve this:
> >=20
> > 1) we have DECLARE_EWMA_ZERO_VALID() or something like that which
> >     *doesn't* treat 0 as an uninitialized value, and either has a
> >     separate "not initialized yet" bit (but that's iffy storage wise),
> >     or simply has another argument to _init() for the initial value or
> >     so.
> >=20
> > 2) you don't just don't use 0 and 100 but say 1 and 100, that results i=
n
> >     basically the same behaviour, but avoids the special 0.
> >=20
> > johannes
>=20
> I also ran into that problem in the past, and reviewing it again with a=
=20
> college, I think, this is a real bug in the EWMA implementation. I try=
=20
> to provide a proper patch in the next days, but actually the EWMA=20
> handles the internal value zero, always like in the initialization,=20
> which is wrong, e.g., for positive/negative averaged values.

Yes, it's always wrong as long as you feed it something zero, or values
with different sign.

For a lot of use cases, however, that doesn't matter. Originally, it was
used e.g. for signal strength averaging, average packet lengths, etc.
where it really doesn't matter since you can never use 0 or values that
have different sign.

> A quick research shows, this bug is since the first implementation of=20
> the ewma in the code ...
>=20

Yeah, I'm aware of that, I was around for it ;-)

But see above, I'm not sure I'd even call it a bug, at least not
originally with the users that we had intended.

Hence I don't know if it's really good to fix this in general - for many
of these cases zero can still be treated specially (and like I mentioned
in my previous email, we can even here avoid 0), and then we don't spend
an extra byte (or likely 4) to hold a "first time" flag.

Dunno. Maybe it's not worth thinking about the extra memory space vs.
the extra maintenance cost. But maybe at least on 64-bit we could steal
a bit from the unsigned long? Not sure what all the users are...

johannes
