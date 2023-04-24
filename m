Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 317246ED3A2
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 19:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjDXRg6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Apr 2023 13:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjDXRgr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Apr 2023 13:36:47 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7971D9EEA
        for <linux-wireless@vger.kernel.org>; Mon, 24 Apr 2023 10:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=XxIKj4XD68QbY3LWy0VMADgDwNmyCn3QLjRkFRxdqfc=;
        t=1682357794; x=1683567394; b=xj2KT8865LnHTI8LRmp2McVIhLWDObqTRsGWnEp8Tx+PUEI
        hXh2ybta6XY+l1JS0mt5rNTIGXLq7GgYNA6RcZwMs5YZT6Bon9yAgqToxMhtU8qAZuklOd7BqTHGs
        a2hhKFbuumqR5Zle4x7OJvO7keMOKHeusi+VEyYaQyHvQmbd8kc9fc8z4dkbcmjNqVtu5PttAJvCp
        Ewhb+/HK11xhOzMK4TZGUPgKu2xXj+6y+vkmqMwa56OFWU6TQdvejjxWlmoqCe2/Ja9dvHPTg+YKc
        Tx+BjhXQT10an1qyvSQeZqwrUMcWEZQ1FPBY2qRzBW26BHF6oTFgOeJi7vRDgVhA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pr06q-007KYe-31;
        Mon, 24 Apr 2023 19:36:17 +0200
Message-ID: <f5d14ce0b5053e4a99529677614d6d6aa797ac81.camel@sipsolutions.net>
Subject: Re: CMD_REMAIN_ON_CHANNEL vs CMD_FRAME (offchannel)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Mon, 24 Apr 2023 19:36:16 +0200
In-Reply-To: <9b4b6d3e-8840-f37a-52ec-6ea391fa67db@gmail.com>
References: <6d3869e9-6d8f-f7cf-2fe9-b8188a02d086@gmail.com>
         <9b4b6d3e-8840-f37a-52ec-6ea391fa67db@gmail.com>
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

On Mon, 2023-04-10 at 15:49 -0700, James Prestwood wrote:
> On 4/7/23 11:47 AM, James Prestwood wrote:
> > Hi,
> >=20
> > I'm having an issue with CMD_REMAIN_ON_CHANNEL taking a full second to=
=20
> > become ready versus CMD_FRAME (offchannel_ok=3D1) which is quite fast.=
=20
> > Under the hood it looks like both commands call=20
> > ieee80211_start_roc_work() so its curious why one would take so long.=
=20
> > I'm running this in UML so I shouldn't be hitting scheduling problems=
=20
> > (at least that's how I understand UML).
> >=20
> > This happens during the DPP auth exchange, I can include a full log if=
=20
> > desired, but this is the sequence:
> >=20
> > - Start ROC on 2417mhz
> > - Wait for ROC event indicating we are offchannel
> > - Receive DPP presence announcement from enrollee
> > - Send DPP auth request, request enrollee switches to 2412mhz
> > - Send Cancel ROC (and wait for confirmation)
> >=20
> > - Start ROC on 2412mhz
> > - Oddly, receive the enrollees auth response before ROC event. So the=
=20
> > driver _did_ switch channels.
> > - ROC event comes about a second later, and enrollee has timed out
> >=20
> > So the driver is in fact going offchannel to 2412 and even receiving a=
=20
> > frame. But for whatever reason it doesn't send the ROC event for a full=
=20
> > second. Any idea why the ROC event is so delayed here?
>=20
> After a lot of kernel prints I think I know whats going on, but still=20
> somewhat confused.
>=20
> It appears that sending a frame then immediately canceling the ROC=20
> request is the issue. The kernel seems to be queuing the CMD_FRAME=20
> rather than adding it to the ROC request (is this expected?).
>=20

I can't tell with the information you gave - depends on the waiting
period for a response frame you ask for, I guess? With HW ROC (if you're
using iwlwifi) we cannot extend the previous period, see
ieee80211_coalesce_hw_started_roc().
=20
> To simplify the above sequence without DPP specifics:
>=20
> ROC on 2417mhz
> ...
> Send frame on 2417mhz (queued)
> Cancel ROC request.
> ROC request on 2412mhz (queued)
>=20
> At this point the kernel waits for the first (canceled) ROC to complete,=
=20
> then processes the frame request (which requires going offchannel=20
> again). THEN its able to handle the second ROC request.

What are the durations asked for, and waiting for response or not?

> Anyways, maybe ROC is the wrong way to be doing this? It was convenient=
=20
> because its much easier to set some ultimate timeout then fire off=20
> frames as needed in that duration in addition to listening for presence=
=20
> announcements... But maybe ROC is just very limited in what can be done?=
=20
> and using CMD_FRAME + a duration is the only way the kernel can support=
=20
> this nicely?

Not sure I understand this part. ROC is fine mostly for the "wait for
some frame and send a response", but not so much suited for "send a
frame and wait for a response" part. So 3-way-handshakes are iffy with
it...

johannes
