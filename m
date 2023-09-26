Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE557AE764
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 10:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjIZIHW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 04:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjIZIHV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 04:07:21 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B0DFB;
        Tue, 26 Sep 2023 01:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=eg4t+n3zm3o8ChFzdnYGpONlsKgP9BOQ3n+qZ2QhXVw=;
        t=1695715634; x=1696925234; b=O1nmQbY7T0Yhum1VfhyxTGecEAemp0d41xVXYxrn/IDmptw
        Y+IMifUAD+6of0vNUdIJvbV1xkxT1x02P6o+ipfDQrZxVa1lYTI2LUEMy2rnpcICYkAqcYlUHMcec
        wp1ro2JDq24onZQRwOL6ZRSFSWr9VTEGFDw8TQx5+1Eiz4zdsTEBxPimlOwHoeOhiSFaTUxqdv0RB
        f69roSvZaWDL2sq+E4Z82pLaknMGMzRZd7arjwKaIXyLm/MzUb+Hs8SF8sg9ZHzytjJwRBL6Wx9/1
        foj2I5AsmLl3hKwx9JjF21Q3TeHSWdrG1cf3Q0Ni13VZKTElHYIme1r7XDZNOgyw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ql368-005LDu-0Z;
        Tue, 26 Sep 2023 10:07:12 +0200
Message-ID: <790f9d0914e2baba66c394f4e21ef118e44d9775.camel@sipsolutions.net>
Subject: Re: netif_carrier_on() race
From:   Johannes Berg <johannes@sipsolutions.net>
To:     netdev@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 26 Sep 2023 10:07:11 +0200
In-Reply-To: <346b21d87c69f817ea3c37caceb34f1f56255884.camel@sipsolutions.net>
References: <346b21d87c69f817ea3c37caceb34f1f56255884.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

Focusing on this part for a moment, because it affects not just
wireless:

> Then, in netif_carrier_on(), we immediately set the carrier on bit, so
> that you can actually immediately see this from userspace if you ask
> rtnetlink, however, it's not actually immediately _functional_ - it
> still needs to schedule and run the linkwatch work first, to call
> dev_activate() to change the (TX queue) qdisc(s) away from noop.
>=20
> Also, even though you can already query the carrier state and see it on,
> the actual rtnetlink _event_ for this only happens from the linkwatch
> work as well, via netdev_state_change().
>=20
> All of this makes sense since you need to hold RTNL for all those state
> changes/notifier chains, but it does lead to the first race/consistency
> problem: if you query at just the right time you can see carrier being
> on, however, if the carrier is actually removed again and the linkwatch
> work didn't run yet, there might never be an event for the carrier on,
> iow, you might have:
>=20
>  netif_carrier_on()
>  query from userspace and see carrier on
>  netif_carrier_off()
>  linkwatch work runs and sends only carrier off event

and also because, as Andrew mentioned, you can have the exact opposite
problem...

It can actually happen that something _else_ sends an event, so even if
userspace does't query but waits for a carrier on event, you could end
up with:

* netif_carrier_on()

* something else triggers netdev_state_change(),
  even userspace setting link alias

  netdev_state_change()
   -> sends an rtnetlink event saying carrier is on

* userspace transmits but frames are dropped

* linkwatch work runs and enables qdiscs only now



To address this issue, we could introduce a new state, say
__LINK_STATE_CARRIER_COMPLETE or something like that, which is used when
communicating carrier state to userspace, and only set/cleared in
dev_activate()/dev_deactivate(). That way, any events to userspace (or
userspace querying) wouldn't show the carrier state until it's actually
fully reflected in software (qdiscs) too.

This doesn't fully solve _my_ (wifi) problem, but perhaps lets me work
around it in userspace by querying for the carrier state, if it's
reflected correctly ("fully ready to transmit") then we can do that.
Right now, we can't even do that.

But would it break something else? There's also a way to query it via
ethtool, which perhaps should _not_ be converted to _COMPLETE since you
could argue the ethtool link state is about the physical link, and with
this change the carrier becomes about the logical link in a fashion?


johannes
