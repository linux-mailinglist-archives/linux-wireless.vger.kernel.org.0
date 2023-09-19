Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7957A6340
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 14:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjISMk1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 08:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjISMkZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 08:40:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA8AF4;
        Tue, 19 Sep 2023 05:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=mOGRvYwxKMHed8VrE8Mnm0IpPNV6zpDFKam1bvpR6ms=;
        t=1695127218; x=1696336818; b=aNKj1yiyCEtc5rYyRrzx1jM4aCZxqtPJTiYjwJ/cjmkLrlN
        aRAWYMxw/+zLVSArysRSHB/1SzwrNWWuV1asI0Qk4s39/NymgBs9FXfj5J9rIYDFJkLkJyywrL/2b
        HlrhSmVuCDtA1tz6oiHzkY2HVY5GhhwmdiBly8vAdVZQ/UlY46NKpGJ3sgWA/F/jDeSZrmYhJAvEx
        VrSUzpsiQXCJlaU6lQoh32ytuSVHTX+TBzMh1CCG9D/3Zy7mGos2W6W4JXhEYVFl/rNQ/hhET5nx7
        dtT6g2RVgnYkUzynYgPHNwpk4hswJpf/AIcjHip132UyjhEDYAyFLJXC29Es4UMw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qia1X-009GU6-14;
        Tue, 19 Sep 2023 14:40:15 +0200
Message-ID: <69556ed82116df7bb66c7f6c4b7b1f7afb0ef3a8.camel@sipsolutions.net>
Subject: Re: netif_carrier_on() race
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Date:   Tue, 19 Sep 2023 14:40:14 +0200
In-Reply-To: <a0734a8e-5681-4fd1-8cf0-bcb63a43f897@lunn.ch>
References: <346b21d87c69f817ea3c37caceb34f1f56255884.camel@sipsolutions.net>
         <a0734a8e-5681-4fd1-8cf0-bcb63a43f897@lunn.ch>
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

On Tue, 2023-09-19 at 14:36 +0200, Andrew Lunn wrote:
> > All of this makes sense since you need to hold RTNL for all those state
> > changes/notifier chains, but it does lead to the first race/consistency
> > problem: if you query at just the right time you can see carrier being
> > on, however, if the carrier is actually removed again and the linkwatch
> > work didn't run yet, there might never be an event for the carrier on,
> > iow, you might have:
> >=20
> > =C2=A0netif_carrier_on()
> > =C2=A0query from userspace and see carrier on
> > =C2=A0netif_carrier_off()
> > =C2=A0linkwatch work runs and sends only carrier off event
> >=20
> > This is at least a bit confusing, but not really my main problem here,
> > though it did in fact happen to me as well, in a fashion.
>=20
> That is interesting. Copper Ethernet PHYs might have the opposite
> problem. The status bit about link is latching low. This means that if
> the link is lost and then very quickly comes back again, you always
> get to see the lost and then restored link. So maybe we have:
>=20
> =C2=A0=C2=A0netif_carrier_off()
> =C2=A0=C2=A0query from userspace and see carrier off
> =C2=A0=C2=A0netif_carrier_oon()
> =C2=A0=C2=A0linkwatch work runs and sends only carrier on event
>=20
> ???

Heh, interesting. But I agree, that looks like the same problem the
other way around.

Also in the event you actually get the counters that increased. So maybe
that still makes some sense, and we just guarantee that we send at least
one event for these cases? We do that in the code today, though it's not
really formalised IMHO.


> Maybe we want linkwatch to keep the old and the new state. If there is
> a change reported while there is still work queued, which flips a bit
> back to its old state, it needs to block until the work is actually
> done?

I think you fundamentally cannot block in netif_carrier_on/off, they're
called from all kinds of contexts.

> > Possible solution #2:
> > ---------------------
> > Another - more feasible - option might be to say OK, so the associated
> > event (and a few friends) are the problem, so we can queue those events
> > in cfg80211, and only release them on NETDEV_CHANGE notifier call.
> > That's from netdev_state_change() after dev_activate() in linkwatch
> > work. We'd want to pair it with netif_carrier_on() so we actually expec=
t
> > the event to come, and maybe give netif_carrier_on() a return value
> > indicating that it scheduled - or else check using carrier_up_count
> > perhaps?
>=20
> Probably not an issue with 802.11, but sometimes drivers do odd things
> with the carrier because of the BMC. The BMC can have a side channel
> into the hosts NIC, which allows it to share the hosts PHY and RJ45
> socket. So that the BMC can send/receive frames while the host NIC is
> admin down, the carrier might actually be up. And requests to down the
> carrier are ignored.
>=20
> As i said, probably irrelevant to 802.11, but if you try to make a
> generic solution, you might need to watch out for this.

Yay... :)


Anyway, thanks for chiming in - but honestly at this point I don't even
really know where to start addressing this.

johannes
