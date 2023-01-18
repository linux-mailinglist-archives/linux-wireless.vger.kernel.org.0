Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64CC672896
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 20:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjARTjX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 14:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjARTjW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 14:39:22 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981865411B
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 11:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=oXvhyYl4MWwSzj4WsHRkYb/PJM9PdmmBsPzDxIIT0OM=;
        t=1674070760; x=1675280360; b=h5jaesnFwv+Q2amNbWq61MBuQ+5JnYaOnAkoue3G4nVSrwm
        XuqaDI1khH8pMXRUcQCCTe3wkM8zassNRb/tbrAyfjwLzKh3YtwKHQiSAYiJnv6I8jZWAYDkSDlVo
        3tW5+zv3HAhzPF3tKMK/civKKAdln0Pp/iADAM8AScKTOljbWGtwL2f72IA1xSrSN+57Mo53MdX/K
        Qu7UX2S2Y9TZBkxd90vdWLYlcY0bvorXErsdlZ2bEdMlnSeYSI14ECKoaR5NV35bAT/GPHI76gdui
        hbhmAis7w/GEXNe9wqtnDy1vRSn8RqWc7jX7BvDH7gv9pw6094x15Uixd6/vXv3A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pIEHG-005kKO-1D;
        Wed, 18 Jan 2023 20:39:18 +0100
Message-ID: <77b5ae11927cc31ec7cb5e8680973e63e3593ac9.camel@sipsolutions.net>
Subject: Re: [PATCH 0/1] Fix __ieee80211_disconnect when not associated
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 18 Jan 2023 20:39:16 +0100
In-Reply-To: <0594be9d5415b215926d40a2f92390d056057811.camel@gmail.com>
References: <20221025203443.410121-1-prestwoj@gmail.com>
         <6b963cb79064fb70eeba7fdcc6ff5abb25348144.camel@sipsolutions.net>
         <52746d84e1961ee6cb896a8f23d6857774945014.camel@gmail.com>
         <bf0193b9d8546c9712e0cb0fcaf4c90913098771.camel@sipsolutions.net>
         <0594be9d5415b215926d40a2f92390d056057811.camel@gmail.com>
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

On Wed, 2023-01-18 at 10:39 -0800, James Prestwood wrote:
>=20
> iwlwifi 0000:00:14.3: Not associated and the session protection is over
> already...
>=20
> So _something_ happens in the driver/firmware causing this event to be
> generated, thats all I'm saying.
>=20

Yes. But that's also irrelevant.

> But yes, it really doesn't matter why
> but rather how mac80211 handles it.

No, it doesn't matter how mac80211 handles it. The fact that the driver
even tells mac80211 about it by calling the disconnect API is already a
bug - just one that doesn't matter now because mac80211 ignores it.

> > So I think you're just looking in the wrong place - the real question
> > is
> > why the association sequence in net/wireless/sme.c doesn't continue
> > (or
> > abort) at this point?
>=20
> I think I narrowed down this "why" pretty well.

No, you haven't.

>  A connection loss event
> happens between a successful authentication but before association.

But it doesn't!

There's no "connection loss" event, it's just the driver being confused.

The flow is something like this:

 * authenticate
   -> driver prepare for authentication
   -> send auth frame
   -> get auth response
 * firmware waits for association but that never happens
 * driver prints a message and calls API

but since there was never even an *attempt* to associate, that whole end
of the "time event" and the message is irrelevant

If there was an attempt to associate it wouldn't even matter if it was
before or after the end of the time event, because if it already ended
the driver would just create a new one.

In fact, the whole reason we don't abort the time event after successful
authentication and schedule a new one on association is just an
optimisation - it's nicer to the firmware to just have one, and normally
we finish auth + assoc within a few hundred ms.


> Since __ieee80211_disconnect does not take this state into account the
> kernel haults the reassociation and never informs userspace.

No no - there's no "the kernel halts the reassociation" in this case.
You're confusing cause and effect. The *reason* we get this message and
the pointless/buggy/... call to __ieee80211_disconnect() is that there's
never an attempt to associate. It's not *causing* the lack thereof.

> Maybe my solution/fix is incorrect, but its at least a starting point.

I don't see it that way - something is clearly broken in that there's no
association attempt, but I still don't know what. All you've done is
created a special iwlwifi fallback path to let userspace recover from
it, not actually addressed the bug.

> > No, you can't expect that, you could be authenticated with the AP for
> > an
> > indefinite amount of time, or never hear the deauth frame (if it ever
> > sends one).
>=20
> Ok, so at least a CMD_CONNECT event right?
>=20
> Maybe I'm giving nl80211 too much credit, but the
> CMD_AUTH/ASSOC/CONNECT APIs have always seemed symmetric in terms of
> events, in that if you issue one of these commands you will get an
> event in return. So I would expect CMD_CONNECT to generate a
> CMD_CONNECT event.
>=20

Yes, I would also expect a CMD_CONNECT event, via
nl80211_send_connect_result() / __cfg80211_connect_result().

But something is going wrong. I think we need to look into probably
cfg80211_sme_rx_auth() - why is that not continuing the state machine?
Surely wdev->conn didn't go away, so maybe for some reason in this case
we already have wdev->conn->state =3D=3D CFG80211_CONN_CONNECTED? But even
in case of reassoc, wdev->conn is freshly allocated and should be
zeroed, at least initially. But maybe some of the events mac80211
generates during the disconnect messes with the state?

The other cases in cfg80211_sme_rx_auth() seem to generate an event
already one way or the other.

johannes
