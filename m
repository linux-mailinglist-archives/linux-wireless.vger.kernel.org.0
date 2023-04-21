Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD956EA8E5
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 13:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjDULNV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Apr 2023 07:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjDULNU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Apr 2023 07:13:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15622AD34
        for <linux-wireless@vger.kernel.org>; Fri, 21 Apr 2023 04:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=meGFQsc0Ln5X4HJTCCic6xvk87/m4lytcoOamEpIQ4I=;
        t=1682075599; x=1683285199; b=fG/BEE89KlFj2jMHevXaxC/YTogPAk7VL/3ZEw34igqTQWu
        fLUIAiQSemAZ8QwApTjzmGi0XusCzazjUOCi1VKhhpJ0ons3+r4mJ9c3rxFo1t8k0pPUjVrAQqcaU
        YlsTnUh4pr/THVMKxiCpR/PjYVDcnrjx5Py/IX2K0HxwAMxtNa9n8HyurhbEUrK9Y3fk6OGpvb8gG
        RsSQcb5lJjKur3HGqieCOnfAdyfasgB07ymnEf683wkixbgVW22I3NxJ5C8GL3UDbbW5ruyR/8RM6
        UJffa9EmSEEnQ/gmXdjpZs0xb6MJZKW2mTE76WVpPF1vi0K7AuTYq6Rbqz/XbTmA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ppohS-004PJj-17;
        Fri, 21 Apr 2023 13:13:10 +0200
Message-ID: <5e9323647bfc25cf4e09f107348a4e79e9d5c371.camel@sipsolutions.net>
Subject: Re: [PATCH v1] wifi: mac80211: Initialize EWMA fail avg to 1
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>,
        Felix Fietkau <nbd@nbd.name>
Cc:     Karthik M <quic_karm@quicinc.com>, linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Date:   Fri, 21 Apr 2023 13:13:09 +0200
In-Reply-To: <f562b221-b702-21ac-eedf-3a428e29844d@uni-rostock.de>
References: <4f0efc62-0ca5-fe85-fdd8-9beca7ff94d7@uni-rostock.de>
         <04A41274-08B2-4473-AFD0-7D91D3850F4B@nbd.name>
         <ad5febda1c32c0d84aa8ac509fefc5b31a8b7ed4.camel@sipsolutions.net>
         <c22ecc12-6841-e20b-0ee8-eec2e6d6e3e6@nbd.name>
         <f562b221-b702-21ac-eedf-3a428e29844d@uni-rostock.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
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

On Fri, 2023-04-21 at 12:34 +0200, Benjamin Beichler wrote:
> > >=20
> > > So then let's say we want to fix the existing code. I can think of th=
ese
> > > possible ways:
> > >=20
> > > =C2=A0 * splitting off a bit for initialized from the unsigned long
> > > =C2=A0=C2=A0=C2=A0 (which at least for 64-bit should be OK since pres=
umably most code
> > > =C2=A0=C2=A0=C2=A0=C2=A0 using this will run on 32-bit systems too)
> > > =C2=A0 * adding another value for it, e.g. making it u32 and adding a=
 bool=20
> > > for
> > > =C2=A0=C2=A0=C2=A0 "first value"
> > > =C2=A0 * biasing the value, like Felix proposes, could be by 1 or -1 =
for
> > > =C2=A0=C2=A0=C2=A0 example
> You forgot the possibility to introduce a separate init function, which=
=20
> boils down to a shift with an assignment statement for code, and no=20
> further data memory cost. Even simply extending the current init=20
> function (which simply always set 0) would be enough.

Sort of. Yeah I should've mentioned it, but that means you actually have
to know the first value, and track "first time usage" separately in the
user code.

Or you init to something useful at the first value, e.g. saying for
signal strength "let's assume -45dBm average if we don't know". That
doesn't seem very practical?

The behaviour of "first value inserted will init" seems sensible.

> > > As for biasing the value, couldn't that lead to a similar problem? It=
's
> > > clearly less likely that the end of the range is reached rather than
> > > zero, but still?
> > I don't see how it can reduce the range in any way, since the bias is
> > added to the fractional part. A range reduction would seem to imply
> > having an average value that's bigger than the maximum allowed shifted
> > input (top bits cut off), and I don't think that's possible.
> >=20
> It does not reduce the range, but it does not matter whether your=20
> internal state is 0 or 2^(-precision), the non-intuitive behavior stays=
=20
> the same.

OK I was sort of handwaving ... :-)

To have a problem, basically the +1 has to overflow the value, so that
we think that the next time around we should init, rather than add.

That means the existing average has to be 0xffff'ffff (let's take 32
bits, its easier to type). Clearly that can't happen on the first time
since then the precision bits are all 0.

But I think Felix is right (thought not sure about the reasoning) and
that cannot happen, because the add calculation does a ">>weight_rcp"
shift at the end, so there are always some top bits that are non-zero,
and _weight_rcp has to be a power of two. Now, 1 is a power of two, but
that'd be really stupid, and nobody is using it ... So I think if we
prohibit 1 for that, we're fine?

Btw, Felix, shouldn't your patch have said "bool init =3D !internal"?

johannes
