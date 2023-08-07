Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF7C7732FE
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 00:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjHGWgE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Aug 2023 18:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHGWgD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Aug 2023 18:36:03 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A12F0
        for <linux-wireless@vger.kernel.org>; Mon,  7 Aug 2023 15:36:01 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-4478ea3ac05so1837007137.2
        for <linux-wireless@vger.kernel.org>; Mon, 07 Aug 2023 15:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691447760; x=1692052560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrkZLbwMEsiMyHggZNNGPGBh2UjA0ySatyGZIeNS1sM=;
        b=Op2FeBRXjHa6FSuDq0si48+1vtT37NV01zzV7l/0EOKETJ/My8l+1LO7PF5rJLMeAR
         Ue7yCZvZyxgpzSkBQP8swxCRNwaEbZYQViYud8sGKuKl1G6PxfZYDrnUZdeC2HDxEkdz
         SoLp1dk4aH5lzhqg5AmfTKFHFJ4ZvpbJAkFH1Pv34yjkHFGdARt6feWeVj7I/KACeggz
         R7IFd2hLzc03lk7TXi4ixeNmmXV5/Lk+K41L7slFqekPoJ9f+9SvFyGnTPFXfC7D8ZAS
         55rhJhgXKgmuHqj1ocRXMIl50vAiDbm/l1juULDtYLY/yZ5dpf93XBMIbONi5E8UZ3QC
         jsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691447760; x=1692052560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrkZLbwMEsiMyHggZNNGPGBh2UjA0ySatyGZIeNS1sM=;
        b=VbhKC66XbcvEQjigHJs6PYSTRvGAgNW8lo+e6Ogdurp1FGj9ZZbkC8aZ6ap7lENbf5
         dfwnLbTpXG7jjS4u+fbc3lckO+3oT1+bNkMser+PXdxj5eS+k43tsvmD9OSVApE8h1eT
         w2X/1fvyJ40wkORUpeWq6ShpqvS9YArubnTRY/4uNWqtFH2FlQONahpcqNeN2r3DQ9YU
         W5M9V4uwKHqcXHQ4s9TWXYCt4oLn+VzTHceCmG8ZCyxOx2zylb8JzhWKXr3NnjD7kJJU
         CVTB/LtDXNcvZgzS7Z5XLt5+ytt5sq0j6JyyfMH+TUzlBot6urpwNHR03nM2W8amLN7j
         X7pA==
X-Gm-Message-State: AOJu0Yy31wE1JAdcBjufiYlNmzGOEXyk8ku3SvpQBvYZeLWnHjz+GBnW
        RCCGLA4jT6ZkklJeDmXGIWpNYP/lvCcriuaTO/hsxrkhXNg+/3z1B6+cZw==
X-Google-Smtp-Source: AGHT+IFC6exEDcPPQehegwkbnwVgTgmU0TRkysp+hCanq2hWYPtZrHcrNEecMY89kOmE5XDzneHjPXRmZaEjgTNUALw=
X-Received: by 2002:a05:6102:3bcb:b0:447:6848:980a with SMTP id
 a11-20020a0561023bcb00b004476848980amr5509420vsv.19.1691447760569; Mon, 07
 Aug 2023 15:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230602225751.164525-1-kglund@google.com> <20230602225751.164525-2-kglund@google.com>
 <ZMxSg1SmALzTSyGD@google.com>
In-Reply-To: <ZMxSg1SmALzTSyGD@google.com>
From:   Kevin Lund <kglund@google.com>
Date:   Mon, 7 Aug 2023 16:35:49 -0600
Message-ID: <CADgzm_nCL45PkOAUe6rGG2B-htZQui-5ekGoDL-nc4_bEYVmmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] wifi: mwifiex: Stop rejecting connection attempts
 while connected
To:     Brian Norris <briannorris@chromium.org>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hey Brian, thanks for the response. I'm revising the patch now to
better illustrate the context and purpose for the patch, but I'll also
respond to your comments here so there is a clear chain.

> But, did you attempt any background work on this, to determine why it
> exists, or what other mitigations are in place?

Yes, I'll share some of my background checks here:

The check was initially added in the following patch:

https://github.com/torvalds/linux/commit/71954f24c93fd569314985e9a7319b68e0=
b918e6

Before this patch, the driver would explicitly deauthenticate
from its current AP whenever a new connection was requested.
Apparently this was racy, so the deauthentication was removed.
The commit message states that they want to  "Avoid
re-association while the device is already associated to a
network." My assertion is that this is invalid, since
re-associating while connect is a valid action, and it happens
during BSS-transitions.

I cross checked this behavior with the userspace SME side
and looked into a driver with userspace SME, and I could
not find any indication that the driver rejects association
attempts while connected.

> For example, I see that
> sme.c's cfg80211_connect() makes a similar check, but only rejects
> things if the SSID is different. So with that understanding, it's a
> reasonable guess to say that mwifiex would be OK with just relying on
> the existing cfg80211 checks instead.

> In other words, I think this patch may be OK, but probably could use a
> bit more explanation.

Yes, sme.c's cfg80211_connect() is a very useful point of
reference, and I do believe that it makes sufficient checks
such that the Marvell driver can rely on them, and is a part of
what drove me to make this patch in the first place. The
function makes two checks that basically carve out the exact
re-association functionality that I'm enabling in the Marvell driver.

These checks are commented as such:

 /*
* If we have an ssid_len, we're trying to connect or are
* already connected, so reject a new SSID unless it's the
* same (which is the case for re-association.)
*/

and

 /*
* If connected, reject (re-)association unless prev_bssid
* matches the current BSSID.
*/

The first condition asserts that if we're connected,
then the only network we should be trying to
connect to should be the network which we're
currently connected to. Basically, re-association
is only valid within the same ESS.

The second condition says that if we are currently
connected, then

1. We must have a prev_bssid value. This is the BSSID
that we were connected to previously, and it's presence
is the indication that we are requesting a re-association
rather than a normal association. Basically, if we're
connected, then we must be re-associating, not
normal associating.

2. prev_bssid must be the same as our current bssid.
All this is saying is that the previous BSSID which was
supplied by the caller must match the BSSID which the
driver thinks it is connected to. Basically, "the caller is
saying we should move from A to B, let's make sure
we're actually connected to A".

So, based on these checks it is abundantly clear that
cfg80211 absolutely intends it to be a normal flow to
request a connection while currently connected, and
it makes deliberate checks to ensure we're in a good
state when that happens.

> Also, how does "BSS Transitioning" (in your description) fit in here?
> IIUC, cfg80211_connect() doesn't support that, as it only allows
> reassociation to the same BSSID.

This is covered above, but cfg80211_connect()
doesn't actually assert that we're re-associating to
the same BSSID. It only asserts that the BSSID the
caller thinks we're transitioning from is the same
BSSID that the driver thinks we are currently
connected to.

Thanks,
Kevin


On Thu, Aug 3, 2023 at 7:21=E2=80=AFPM Brian Norris <briannorris@chromium.o=
rg> wrote:
>
> On Fri, Jun 02, 2023 at 04:57:51PM -0600, Kevin Lund wrote:
> > Currently, the Marvell WiFi driver rejects any connection attmept while
> > we are currently connected. This is poor logic, since there are several
> > legitimate use-cases for initiating a connection attempt while
> > connected, including re-association and BSS Transitioning. This logic
> > means that it's impossible for userspace to request the driver to
> > connect to a different BSS on the same ESS without explicitly requestin=
g
> > a disconnect first.
> >
> > Remove the check from the driver so that we can complete BSS transition=
s
> > on the first attempt.
> >
> > Testing on Chrome OS has shown that this change resolves some issues
> > with failed BSS transitions.
> >
> > Signed-off-by: Kevin Lund <kglund@google.com>
> > ---
> >  drivers/net/wireless/marvell/mwifiex/cfg80211.c | 6 ------
> >  1 file changed, 6 deletions(-)
>
> I've been told this one might need an extra look, but first off, it's
> marked Rejected, likely due to feedback on patch 1, so probably needs a
> resubmit if it needs consideration:
>
> https://patchwork.kernel.org/project/linux-wireless/patch/20230602225751.=
164525-2-kglund@google.com/
>
> But, did you attempt any background work on this, to determine why it
> exists, or what other mitigations are in place? For example, I see that
> sme.c's cfg80211_connect() makes a similar check, but only rejects
> things if the SSID is different. So with that understanding, it's a
> reasonable guess to say that mwifiex would be OK with just relying on
> the existing cfg80211 checks instead.
>
> In other words, I think this patch may be OK, but probably could use a
> bit more explanation.
>
> Also, how does "BSS Transitioning" (in your description) fit in here?
> IIUC, cfg80211_connect() doesn't support that, as it only allows
> reassociation to the same BSSID.
> (Or, I might be confused here.)
>
> Brian
