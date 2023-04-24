Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCC96ED1D2
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 17:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjDXPzm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Apr 2023 11:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjDXPze (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Apr 2023 11:55:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCE7A246
        for <linux-wireless@vger.kernel.org>; Mon, 24 Apr 2023 08:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=g/1mjGCfIMb4t/rbKxT9ddITJFCqtTNLvrrm2VBAcpU=;
        t=1682351718; x=1683561318; b=nPvoV1mY9ApoHa95gGUqRbtLa20zWaXI6nB4755ZAoijMx+
        MCvwHa3/BvGyKjs9lcwaq2MOXzi+z4EhNw9fGbHAOE2Hb4s5npK3ivgNwALmNGZnXdKNzakY0xp0D
        gRrLL7ztYLIq+LrAytoa8HQFwT6RnYX9lZF2hmjB4ExsxS/0/qYi5eUtH7W2ZFUQX0dFEHWjCuIQy
        k0KrUb9n+sSAJe4H6b9Blx9geBX2CW/VASmgwsNVJcnY1ksAgechK1PuTgk1I61ENUsVOVCpXJwpb
        NJUX6YH0ezEvD2qrgS2rXRgvKpAA0fi7opb6YytFq7gyjNzoHzSvszJ5s7UtfV1w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pqyX4-007Iho-1u;
        Mon, 24 Apr 2023 17:55:14 +0200
Message-ID: <bf641b6343baf9a810df41a5d68e0c073a059548.camel@sipsolutions.net>
Subject: Re: [RFC v2] average: rewrite for clearity
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>, nbd@nbd.name,
        linux-wireless@vger.kernel.org
Date:   Mon, 24 Apr 2023 17:55:13 +0200
In-Reply-To: <bea043c3-1cee-e2a6-ca4b-83e80404358c@uni-rostock.de>
References: <20230421134604.211128-1-benjamin.beichler@uni-rostock.de>
         <3f505aba559d4ce068ef6d2fd7743045e0d93b9f.camel@sipsolutions.net>
         <bea043c3-1cee-e2a6-ca4b-83e80404358c@uni-rostock.de>
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

On Fri, 2023-04-21 at 17:16 +0200, Benjamin Beichler wrote:
> >=20
> > So then we could say we'll just fix them, but what value actually makes
> > sense to init with? You don't necessarily know, right? Initially biasin=
g
> > towards the first value makes a lot more sense than initially biasing
> > towards zero, no? And then if you want to achieve that, now you have to
> > either use _add_or_init(), which is probably what people will do, but
> > that continues having the problem ...
>=20
> I left out the the individual fixes for users, but for the samples I=20
> looked into, either start values were given, or they were semantically=
=20
> extractable.
>=20
> e.g. virtios pkt_len=C2=A0 ewma is clamped anyways, so using the clamp bo=
rder=20
> or in between will be safe.
>=20
> Most others are signals-strengths, many of them also only for=20
> statistics, where a slow convergence is okay in my opinion.

Yeah I guess that's the thing, we can accept slower convergence in many
cases, and "safe" start values mean that mostly. But why accept it when
we don't have to?

> IMHO the net improvement is, that if you do not use the convenience=20
> add_or_init function, it simply resembles the ewma filter of a math or=
=20
> CS-textbook.=C2=A0

Not sure I see that as a good argument. The practical engineering side
tends to always be more complex than the theory, and that's not really
unexpected. We can comment why it's different :-)

> The original problem was, that the ewma had a surprising=20
> output in a special situation.

Right, but that's an implementation issue, because we thought 0 =3D=3D
uninit was clever, without realizing the corner case.

> But while writing the commit, I recognized, that the current ewma=20
> implementation is only for unsigned values, which means the problem=20
> really only happens for many consecutive 0 values. I try to think over,=
=20
> what this means for the proposal of Felix, but I'm not able to think=20
> about unsigned C-arithmetics today :-D

Not much really, I think? It eases thinking about it though :)

> If we use that fix, then we should have an additional compile time=20
> check, that the precision has at least 2 or 4 bits, to really avoid the=
=20
> problem, shouldn't we?

Yes. I think 1 bit is enough, but yes, it can't be 0 bits.

johannes
