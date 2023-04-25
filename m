Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA466EE824
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Apr 2023 21:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbjDYTXR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 15:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbjDYTXK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 15:23:10 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0645815475
        for <linux-wireless@vger.kernel.org>; Tue, 25 Apr 2023 12:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=tXmdq5XOFRa9sj6/LJ8l7ncOyk0p7lP7vfMtOjf4/a8=;
        t=1682450588; x=1683660188; b=DMPMHYA86z+UF/gSQld8rEvbiHEXptWCvlTdvGJwIUgv/4U
        nXR/x7ceWV+/kZ/0G4pz+KNfJU960FYUiQOv259zku/yNiF7OglGoUWtOhvfwRY//37ktK12fGYgI
        tC9S3SNa0f/IO/+0CP4F3qf8bM5HBKg2VAFdT/u1K/fFkeuG38EO+7Om+t0JImv/euwB72OyHCM4w
        8g/34sVgrlS98vxSUVqLkVn16gH3uAwjszcy3ZecSXsfc2LXGm06jIw1V07SBa+T4jV9OvpRDVSPm
        dEqHQ2jHQ4OYT+YG/iRtydcRbHI54SuN/SgziVUGJMjm6HyArmz4nH0kBeEavL1Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1prOFl-008KXD-17;
        Tue, 25 Apr 2023 21:23:05 +0200
Message-ID: <98befe45dbd85eefda62165dae58395456ec9982.camel@sipsolutions.net>
Subject: Re: CMD_REMAIN_ON_CHANNEL vs CMD_FRAME (offchannel)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Tue, 25 Apr 2023 21:23:04 +0200
In-Reply-To: <9c298074-9ae1-e053-d7da-85ca3063058c@gmail.com>
References: <6d3869e9-6d8f-f7cf-2fe9-b8188a02d086@gmail.com>
         <9b4b6d3e-8840-f37a-52ec-6ea391fa67db@gmail.com>
         <f5d14ce0b5053e4a99529677614d6d6aa797ac81.camel@sipsolutions.net>
         <98f53583-400d-665f-d264-92e9f3e67280@gmail.com>
         <f0383c934075f90d50af6e91aa3307057f6188f8.camel@sipsolutions.net>
         <9c298074-9ae1-e053-d7da-85ca3063058c@gmail.com>
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

> I guess my assumption was if ROC is currently active then a CMD_FRAME=20
> (on the same channel) should just go out immediately, not be queued, and=
=20
> not even bother checking the duration. (and in this case I'm not even=20
> setting a duration for CMD_FRAME).

Hm, yeah, I'd think so too? There's probably some logic to make sure it
can still go out, so it doesn't come in just at the end of the ROC, but
seems that should work?

I mean, that's also exactly what should happen for a response frame,
right? When you are using ROC to listen to requests, and then send a
response. That'd be without setting a duration, normally.

Even the code says:

        /* This will handle all kinds of coalescing and immediate TX */
        ret =3D ieee80211_start_roc_work(local, sdata, params->chan,
                                       params->wait, cookie, skb,
                                       IEEE80211_ROC_TYPE_MGMT_TX);


And then seems you should get into

...

        /* otherwise handle queueing */

        list_for_each_entry(tmp, &local->roc_list, list) {
                if (tmp->chan !=3D channel || tmp->sdata !=3D sdata)
                        continue;

...
                if (!local->ops->remain_on_channel) {
...
                        ieee80211_handle_roc_started(roc, now);

which does

static void ieee80211_handle_roc_started(struct ieee80211_roc_work *roc,
                                         unsigned long start_time)
{
        if (WARN_ON(roc->notified))
                return;

        roc->start_time =3D start_time;
        roc->started =3D true;

        if (roc->mgmt_tx_cookie) {
                if (!WARN_ON(!roc->frame)) {
                        ieee80211_tx_skb_tid_band(roc->sdata, roc->frame, 7=
,
                                                  roc->chan->band);


Not sure why that wouldn't work?


> Does the OFFCHANNEL_TX_OK flag have any bearing on this? I found that I=
=20
> have to set it even if ROC is ongoing, maybe thats another topic of=20
> discussion.

I think you have to just always set that flag unless you're transmitting
on the operating channel.

johannes

