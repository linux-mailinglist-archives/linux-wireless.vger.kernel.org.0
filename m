Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2809D6EE75F
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Apr 2023 20:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbjDYSKp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 14:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234284AbjDYSKo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 14:10:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED52416F37
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 11:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8WDyJaxFekm0flawIK7Jo6njRDp9sqqJqK5A8A+0xJ4=;
        t=1682446240; x=1683655840; b=xwRqnABAzlHwg1ihb0LKlAwhqymWi4a5HQzzo5g5alBTJQR
        ZEe8VZBEjL+JHEKbLMTTKacUPjFm5EmyvpJ5mMEDoQqIKL6w4rwBAa8JfammkoZzquapfrgIfG+eU
        kU4syOSDbyOqwWcDoqLONgOR5cMCNwKdsKLwdjLkClteTvZeRHBTkeZC9sg5Cr8YYy8IpGDNzG9eM
        RAOvT+M9wfh1La3huRkJZPsbaG+jj6Ajw7DpNHtYeV07YoHua5AmfhgynxBI3B/VEds39Xh2GCP2r
        SR8KJfcMD8Lt2VH1zNHzh06adeFxHRa/MuDhCscSKntjB576J9FJUl8mWSU1H6qA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1prN7d-008J3A-20;
        Tue, 25 Apr 2023 20:10:37 +0200
Message-ID: <f0383c934075f90d50af6e91aa3307057f6188f8.camel@sipsolutions.net>
Subject: Re: CMD_REMAIN_ON_CHANNEL vs CMD_FRAME (offchannel)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 25 Apr 2023 20:10:36 +0200
In-Reply-To: <98f53583-400d-665f-d264-92e9f3e67280@gmail.com>
References: <6d3869e9-6d8f-f7cf-2fe9-b8188a02d086@gmail.com>
         <9b4b6d3e-8840-f37a-52ec-6ea391fa67db@gmail.com>
         <f5d14ce0b5053e4a99529677614d6d6aa797ac81.camel@sipsolutions.net>
         <98f53583-400d-665f-d264-92e9f3e67280@gmail.com>
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

Hi,

> > I can't tell with the information you gave - depends on the waiting
> > period for a response frame you ask for, I guess? With HW ROC (if you'r=
e
> > using iwlwifi) we cannot extend the previous period, see
> > ieee80211_coalesce_hw_started_roc().
>=20
> This is purely virtual at the moment, but in my case its looking like it=
=20
> cannot be extended either since the CMD_FRAME just queues a separate=20
> request.

Hm. Not sure then? I guess then you'd be falling into the max duration
or so?

                if (!local->ops->remain_on_channel) {
                        /* If there's no hardware remain-on-channel, and
                         * doing so won't push us over the maximum r-o-c
                         * we allow, then we can just add the new one to
                         * the list and mark it as having started now.
                         * If it would push over the limit, don't try to
                         * combine with other started ones (that haven't
                         * been running as long) but potentially sort it
                         * with others that had the same fate.
                         */
                        unsigned long now =3D jiffies;
                        u32 elapsed =3D jiffies_to_msecs(now - tmp->start_t=
ime);
                        struct wiphy *wiphy =3D local->hw.wiphy;
                        u32 max_roc =3D wiphy->max_remain_on_channel_durati=
on;

                        if (elapsed + roc->duration > max_roc) {
                                combine_started =3D false;
                                continue;
                        }

Or maybe that logic here is broken somewhat ...

> > Not sure I understand this part. ROC is fine mostly for the "wait for
> > some frame and send a response", but not so much suited for "send a
> > frame and wait for a response" part. So 3-way-handshakes are iffy with
> > it...
>=20
> Yeah, and it actually has worked great for the entire DPP procedure=20
> using the same channel (presence -> auth request -> auth response ->=20
> auth confirm) assuming both sides respond in a timely fashion.
>=20
> The comes when changing the channel after the auth request. The auth=20
> request gets queued separately, which then delays the ROC and we=20
> can't/shouldn't send anything until ROC starts. The only strange thing=
=20
> is we actually receive the auth response on the new channel before the=
=20
> ROC for that new channel even starts. Its like the hardware and driver=
=20
> aren't quite in sync.

Did you say hwsim? That'd be weird. Though in hwsim I think you have an
additional quirk - it never really *leaves* the original channel it's
connected on, it kind of sticks around on *both* which isn't real but
some kind of simplification there. We might want to fix that eventually.
But not sure it's connected already in this case?

> But anyways I think its best to use ROC for presence (waiting for=20
> announcements) but then use CMD_FRAME for the rest of the protocol.

Right, that's pretty much the intent for this kind of thing. Similar in
P2P where we designed all this, really.

johannes
