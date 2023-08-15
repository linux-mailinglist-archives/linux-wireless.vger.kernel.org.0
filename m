Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE71377C461
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Aug 2023 02:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjHOAVj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Aug 2023 20:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbjHOAVc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Aug 2023 20:21:32 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747721715
        for <linux-wireless@vger.kernel.org>; Mon, 14 Aug 2023 17:21:30 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-56546b45f30so3780055a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 14 Aug 2023 17:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692058890; x=1692663690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zpcNXRErI9RZyXifjZHp9rCFAD40K9mPQxWGHvp4L/4=;
        b=Gt+E8GWie2QCDVJUZizGSYW+cTltFUkqLWtVlVQjMiNbu7AkE0NNRhzPxcbq/c3aaE
         Vstq35Fe1yQoHmELX8DU+zI+d2O7KxjtbUVaOLpo9YbNmA1FvS75JVb1adifBD2QZ5kA
         MIwKtsAkU+UKwwU+Ok6MjSHmSB+qnX5ueYPSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692058890; x=1692663690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpcNXRErI9RZyXifjZHp9rCFAD40K9mPQxWGHvp4L/4=;
        b=eDj0Ebg61zp8Hy4/f4qFNCe3Ru1DgLHdFJyyig4UBgzlCZvwoAKjrutfWTHKv6wKzF
         yPizF+zX70hoXPKjTmossOw3F5G6QarTYuFKYI+br3Gd3pJs1U6creRHgbiUjPdZxkGV
         ecYASFTDN+7uuJjPpYEUGhiVPex1oF2MjcNBikVzrG6whQc0ZidS+QxS6WPtVc4//AC4
         CusjTRFKDL3yT1q17bLuK7CtzUuFOkzFQDiTkIUCUCOV6x1bo/t+4vlGO7U/TGpidVOc
         ZQBynYk28bZYydXZKz7xGvG0li3lAtUmODv0/5aTCkkJXGNfJjrLuxV4jJwdfJzP4iZ5
         G/gQ==
X-Gm-Message-State: AOJu0YyIHuWPt/YROo/IBt9OvezYzBjz/4ZzeJ9DN29R0jxL0yQKbFQA
        DbPZE9rxY16sAE1p4/2WcIrlg4CCM9khT/K/wKc=
X-Google-Smtp-Source: AGHT+IHqpJEeVvvUn61Gl4BCp3R59q46oNk7EJKbGIf1uw2jnQK8KaflRwj+wNRz0K9uXCNRp/n2xw==
X-Received: by 2002:a17:903:1249:b0:1bc:2bd:852a with SMTP id u9-20020a170903124900b001bc02bd852amr17150705plh.42.1692058889808;
        Mon, 14 Aug 2023 17:21:29 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:7122:2a16:dda1:2feb])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902ea8300b001b672af624esm5893267plb.164.2023.08.14.17.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 17:21:28 -0700 (PDT)
Date:   Mon, 14 Aug 2023 17:21:27 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Kevin Lund <kglund@google.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        David Lin <yu-hao.lin@nxp.com>
Subject: Re: [PATCH 2/2] wifi: mwifiex: Stop rejecting connection attempts
 while connected
Message-ID: <ZNrFB8LKEfj5REVg@google.com>
References: <20230602225751.164525-1-kglund@google.com>
 <20230602225751.164525-2-kglund@google.com>
 <ZMxSg1SmALzTSyGD@google.com>
 <CADgzm_nCL45PkOAUe6rGG2B-htZQui-5ekGoDL-nc4_bEYVmmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADgzm_nCL45PkOAUe6rGG2B-htZQui-5ekGoDL-nc4_bEYVmmg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 07, 2023 at 04:35:49PM -0600, Kevin Lund wrote:
> Hey Brian, thanks for the response. I'm revising the patch now to
> better illustrate the context and purpose for the patch, but I'll also
> respond to your comments here so there is a clear chain.

Yes, good idea :)

> > But, did you attempt any background work on this, to determine why it
> > exists, or what other mitigations are in place?
> 
> Yes, I'll share some of my background checks here:
> 
> The check was initially added in the following patch:
> 
> https://github.com/torvalds/linux/commit/71954f24c93fd569314985e9a7319b68e0b918e6

Ah, good context. I didn't notice that part, and instead assumed that
the quirk (like so many quirks in this driver) existed since its
introduction.

Definitely note this in your followup patch, and while you're at it,
maybe avoid linking github and instead use the preferred commit format.
I think think checkpatch.pl would tell you that's something like:
commit 71954f24c93f ("mwifiex: do not re-associate when already
connected")

And you'll want to explain how you account for the original problem
being solved, or else explain that the problem doesn't apply.

> Before this patch, the driver would explicitly deauthenticate
> from its current AP whenever a new connection was requested.
> Apparently this was racy, so the deauthentication was removed.
> The commit message states that they want to  "Avoid
> re-association while the device is already associated to a
> network." My assertion is that this is invalid, since
> re-associating while connect is a valid action, and it happens
> during BSS-transitions.

Actually, I believe that commit was primarily addressing a particular
WARN()/WARN_ON() issue seen when doing this kind of reassociation,
because of how mwifiex was doing an internal deassociation, and losing
the context of the SSID that it was going to report back to cfg80211
upon (re)association.

So you'd need to show that you don't hit that warning again. (I doubt
you will, because the aforementioned commit also dropped the internal
deauthentication call.)

But I think you'd also need to explain why (or even better,
explain+test) the internal deauthentication was present in the first
place. The previous commit removed the internal deauthentication, and
instead just rejected the request. The former is OK to do, but only(?)
because we did the latter.

So, you'd have to help me remove that question mark: why is it OK for
mwifiex to run its connect (HostCmd_CMD_802_11_ASSOCIATE) flow without
an intervening disconnect? It's not clear to me that the firmware
protocol actually supports this, or that it's been vetted very much, given
how the original mwifiex used to behave (with a full disconnect and
reconnect).

Maybe David Lin @ NXP (CC'd) would be able to help here, as this starts
to ask questions we can only answer by either inspecting the firmware
(i.e., ask NXP) or by testing.

Regarding testing: what kind of testing has been done? On your multi-BSS
setup, have you ensured we're really sending appropriate 802.11 level
frames with this patch? e.g., do mwifiex clients end up sending a proper
REASSOCIATION REQUEST frame, or just ASSOCIATION REQUEST? It doesn't
look like mwifiex actually pushes the required "Current AP Address" down
into the association command, but it's always possible the firmware just
memorizes this and rewrites it...
...or alternatively, maybe mwifiex doesn't actually do Reassociation at
all here, and it just kinda happens to work OK when sending a regular
Association. I'm not sure if that makes this a good patch, or if we'll
end up with interop problems where cfg80211 thinks we're reassociating,
but the AP thinks we're associating, and eventually things break down.

Sorry if that's just a bunch of "unknowns" here, but that's life when
trying to retrofit things into an old full-MAC driver with no support
from the owners of the proprietary firmware. Maybe 802.11 protocol dumps
would make us happy enough though.

> I cross checked this behavior with the userspace SME side
> and looked into a driver with userspace SME, and I could
> not find any indication that the driver rejects association
> attempts while connected.

I don't think comparison with other drivers gives much evidence here.
It's a question of whether the firmware is properly tracking
"reassociation" (to the same or different BSS), or whether it really
needs a DEAUTH in between.

> > For example, I see that
> > sme.c's cfg80211_connect() makes a similar check, but only rejects
> > things if the SSID is different. So with that understanding, it's a
> > reasonable guess to say that mwifiex would be OK with just relying on
> > the existing cfg80211 checks instead.
> 
> > In other words, I think this patch may be OK, but probably could use a
> > bit more explanation.
> 
[...]
> The second condition says that if we are currently
> connected, then
> 
> 1. We must have a prev_bssid value. This is the BSSID
> that we were connected to previously, and it's presence
> is the indication that we are requesting a re-association
> rather than a normal association. Basically, if we're
> connected, then we must be re-associating, not
> normal associating.
> 
> 2. prev_bssid must be the same as our current bssid.
> All this is saying is that the previous BSSID which was
> supplied by the caller must match the BSSID which the
> driver thinks it is connected to. Basically, "the caller is
> saying we should move from A to B, let's make sure
> we're actually connected to A".

I misread what cfg80211_connect() was looking for -- thanks for the
additional explanation.

> So, based on these checks it is abundantly clear that
> cfg80211 absolutely intends it to be a normal flow to
> request a connection while currently connected, and
> it makes deliberate checks to ensure we're in a good
> state when that happens.

Right, thanks, I misunderstood cfg80211 for a bit. So I agree on the
cfg80211 expectation, but that still doesn't tell us how the mwifiex
firmware really behaves. I guess I retain some confusion (per above) of
why mwifiex would have forcibly DEAUTH'd on each reassociation request
in the past, if it wasn't necessary.

Brian
