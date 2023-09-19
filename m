Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03B47A5BA4
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Sep 2023 09:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjISHwd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Sep 2023 03:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjISHwc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Sep 2023 03:52:32 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5C5100;
        Tue, 19 Sep 2023 00:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=61LMeMG8Fdc8X6upURl6tGGGWt+uYS8B4337BEBUMYo=; t=1695109946; x=1696319546; 
        b=sKn8/EIA13Q/Nri7DEydeQBSh9F5vECwtk8dMHaMPj6veOKi6+8DOtKR39CSNxx0w3sQy4QLMJ0
        1mmdtZ1zcELIcIc8KfTvK96PQEV7COVR/JVOa/3wzxg+5g7y0UNqNlSC9HOtdCNiEQpDZya7RcZRQ
        8nme+Xe+f6mlPIfMy5DGjcpi2yp0+PfsoAdwizNbO5u+4bUMmV9Ms68aFQw24ztupPArXTrcU3g9Y
        JNYBcguIvN/ED+3bQH6qhoJdL6KmM79M6tXdh2T8CNQlMBGmLf86EsK9TqXBQEFdOnxMsfGhdH0wr
        57evv5g3Y4P+u7bj13LZ65YojHyKybDuYyBQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qiVWx-008yb3-1P;
        Tue, 19 Sep 2023 09:52:23 +0200
Message-ID: <346b21d87c69f817ea3c37caceb34f1f56255884.camel@sipsolutions.net>
Subject: netif_carrier_on() race
From:   Johannes Berg <johannes@sipsolutions.net>
To:     netdev@vger.kernel.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 19 Sep 2023 09:52:22 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

So I've been spending a few days debug this issue, and I don't have a
really good solution, hence this question/description.

I'll note that a lot of this is written in the context of ARCH=3Dum and
time-travel=3Dinfcpu mode, and that apparently between 6.4 and 6.6-rc some
scheduler and/or workqueue changes were made that seem to have made this
problem worse. However, I don't think there's actually anything that
_cannot_ happen in real systems (perhaps more likely in single-threaded
ones), even if it may be unlikely.


As background, in mac80211, we set the carrier on if we have a
connection that can actually start passing data, since that seemed like
the best equivalent at the time. This obviously happens by calling
netif_carrier_on(). Maybe we can revisit this, but it seems reasonable -
why pretend to have a carrier before you can start passing data.

Then, in netif_carrier_on(), we immediately set the carrier on bit, so
that you can actually immediately see this from userspace if you ask
rtnetlink, however, it's not actually immediately _functional_ - it
still needs to schedule and run the linkwatch work first, to call
dev_activate() to change the (TX queue) qdisc(s) away from noop.

Also, even though you can already query the carrier state and see it on,
the actual rtnetlink _event_ for this only happens from the linkwatch
work as well, via netdev_state_change().

All of this makes sense since you need to hold RTNL for all those state
changes/notifier chains, but it does lead to the first race/consistency
problem: if you query at just the right time you can see carrier being
on, however, if the carrier is actually removed again and the linkwatch
work didn't run yet, there might never be an event for the carrier on,
iow, you might have:

 netif_carrier_on()
 query from userspace and see carrier on
 netif_carrier_off()
 linkwatch work runs and sends only carrier off event

This is at least a bit confusing, but not really my main problem here,
though it did in fact happen to me as well, in a fashion.


Now going back to wifi, in mac80211 we also send an event (via nl80211)
that says "I'm associated now", and userspace may take that event as a
signal that it can send the first frame on the connection, which kind of
makes sense - however, given the async nature of the linkwatch work, if
userspace is fast enough those such a frame will actually get dropped.
This is the biggest problem I have now with all this.


Now can I fix this?

Possible solution #1:
---------------------
In theory at least dev_activate() is exported, so I could call it from
mac80211? However, that seems ... odd, and also it doesn't work because
I'd need to hold the RTNL and the locking means that's really awkward to
do, to the point where I'd need to defer to another async work for doing
it.

Haven't attempted this.

Possible solution #2:
---------------------
Another - more feasible - option might be to say OK, so the associated
event (and a few friends) are the problem, so we can queue those events
in cfg80211, and only release them on NETDEV_CHANGE notifier call.
That's from netdev_state_change() after dev_activate() in linkwatch
work. We'd want to pair it with netif_carrier_on() so we actually expect
the event to come, and maybe give netif_carrier_on() a return value
indicating that it scheduled - or else check using carrier_up_count
perhaps? We'd have to queue more events that come afterwards so they're
not sent to userspace out of order, but even that can be done.

I haven't tried this yet but I think it would work, but it does feel a
bit strange, and arguably just makes the consistency problem worse -
because again userspace could actually query and see the new state
before the event for said new state.


Possible solution #3:
---------------------

Try to intercept the events from userspace. I've tried this, but it
feels subject to races; we don't know that we will even get an event
with carrier=3D1, since if the kernel does netif_carrier_on() followed
quickly by netif_carrier_off(), there won't be a carrier=3D1 event. And
honestly, at that point, it feels like it's within the rights of the
kernel to not send any event at all - it's just an implementation
artifact that it doesn't stop the linkwatch work again when it's already
pending, so it sends a no-op event, which also feels a bit odd anyway.

Maybe there could be something done here with the carrier_up_count as
well, but I'm not sure this makes a lot of sense. At least that should
increase somewhere there, so I could query it before even trying to
associate, and then wait until at least it incremented? But ... there
might not be an event, again, unless we really decide, document (and not
change in the future) that there _must_ be at least one event for any
sequence of carrier on/off changes, even if that sequence ends with no
effective change in the carrier.


Possible solution #4:
---------------------

Maybe we could set the carrier on earlier in the wireless stack, but
then what if e.g. some DHCP client is just looking for that event? That
seems therefore also problematic - not attempted.


Possible solution #5:
---------------------

Change the wireless stack to hold RTNL _more_, so that we can call
dev_activate(). I feel pretty good about not holding the RTNL for almost
all of the wireless stack now, so wouldn't really want to do that. Also
feels like a step in the wrong direction, after all, RTNL is almost like
the new BKL.


Possible solution #6:
---------------------

Change the locking to not necessarily require RTNL, so the wireless
stack can more easily call dev_activate(). Pretty much infeasible, IMHO,
as much as I'd want to do/see locking improvements in general.


---------------------


So now I'm not really sure what to do. I'm tempted to implement #2 so at
least it's all visible in kernel space, or try to play with #3, but I'm
not so happy with #3 unless we guarantee that linkwatch will run even
for a sequence of events that results in no eventual changes. We do that
today, but it feels brittle.


(Oh, and yes, I also tried just sleeping a little bit in userspace but
that results in other issues...)


Anyone have thoughts on this?

johannes
