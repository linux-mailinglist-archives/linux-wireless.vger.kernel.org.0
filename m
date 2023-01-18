Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20794672659
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 19:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjARSKL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 13:10:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjARSJ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 13:09:29 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F1F5A360
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 10:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=6yo5uDRXZObQgdR1UYMEVi699rT0IOSxbVKZzjhBQvk=;
        t=1674065340; x=1675274940; b=hVJ4Y3YPzTvvgw34U3y0ldqa9vcKd10b6tva+nT/W+bNm/s
        KQMcO6gDLMEGBUtJeOcM9yb0HkIbD0ISajtJr9cIl8wYewXkHJ+k4wCq4vwjjeekO2OeX6KIJlX9I
        ecqyjGKYTtYJuD/PL5A6lsd/geOOBCFw9N1gKBzJ6yuqXHnZOzbe5hIustTVllMiftlyx5DUeFuUw
        s+KDHgEcC0vxakcLK4PLOqCIy6UgNW37UVYaUL3pkjmqNYJb+m7h8lzOcCoSc5yXG3rpZE5+iuYo8
        q1MD37W9n5z/TzR44UDBBmrF5Iazha/6wCmDfHbFoIKHN1KA256OquMkBCFrRrkA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pICrq-005iYZ-2z;
        Wed, 18 Jan 2023 19:08:59 +0100
Message-ID: <bf0193b9d8546c9712e0cb0fcaf4c90913098771.camel@sipsolutions.net>
Subject: Re: [PATCH 0/1] Fix __ieee80211_disconnect when not associated
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 18 Jan 2023 19:08:57 +0100
In-Reply-To: <52746d84e1961ee6cb896a8f23d6857774945014.camel@gmail.com>
References: <20221025203443.410121-1-prestwoj@gmail.com>
         <6b963cb79064fb70eeba7fdcc6ff5abb25348144.camel@sipsolutions.net>
         <52746d84e1961ee6cb896a8f23d6857774945014.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-01-18 at 09:54 -0800, James Prestwood wrote:
> >=20
> > Basically I don't understand why userspace expects some event. It
> > asked
> > for authentication, and you got it. That's all. I don't see userspace
> > asking for association, or anything else, so what would it be waiting
> > for?
>=20
> I should have explained this better. I dug up the old thread from the
> original report and IIRC this is the sequence of events:
>=20
> 1. Begin reassociation to new BSS via CMD_CONNECT.
>=20

Oh, CMD_CONNECT, OK.

>  This results in the
> kernel sending many events to remove the current BSS in favor of the
> new one:
>=20
> 2. Receive DEL_STATION, DEAUTHENTICATE, DISCONNECT, NEW_STATION

So far, so good.

> 3. Then a CMD_AUTHENTICATE, with a success status.

Sure, that's what we see.

> 4. At this point the firmware decides its not gonna continue and calls
> __ieee80211_disconnect which is a no-op when not associated.
>=20

This is also completely irrelevant to the state. The firmware doesn't
"decide not to continue". Something else already decided it doesn't want
to continue. This is entirely driven from the top - be it the
net/wireless/sme.c for CMD_CONNECT, or userspace for CMD_AUTHENTICATE
and CMD_ASSOCIATE.

> We assumed
> either CMD_ASSOCIATE or CMD_CONNECT will come after CMD_AUTHENTICATE,
> or a CMD_DEAUTH if there was a problem.

Yeah for CMD_CONNECT I guess that's reasonable. In fact you really
shouldn't even look at the authenticate/associate even in these cases
since they're not guaranteed (e.g. if you have a fullmac device), they
only happen as a consequence of the mac80211 implementation, not by
design.

So I think you're just looking in the wrong place - the real question is
why the association sequence in net/wireless/sme.c doesn't continue (or
abort) at this point?

The whole "firmware event" thing is completely incidental and an
implementation detail. The firmware decides nothing. All that happens
here is that the firmware decided to no longer wait for the association
to happen (but that wasn't even started), and a driver bug that
basically just prints the wrong message - it says it's expecting to be
associated but it can't actually expect that since we never even
transmitted an association request.

> I will say, we do see a CMD_DEL_STATION event here which we never
> processed in this case.

And you probably shouldn't anyway, again more of an implementation
detail, not really by design.

> But again, I would expect a CMD_DEAUTHENTICATE
> since we successfully authenticated, right?

No, you can't expect that, you could be authenticated with the AP for an
indefinite amount of time, or never hear the deauth frame (if it ever
sends one).

johannes
