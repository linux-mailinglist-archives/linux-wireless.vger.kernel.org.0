Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC081DA6CF
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2020 02:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgETAyW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 May 2020 20:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgETAyW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 May 2020 20:54:22 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7F0C061A0E
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2020 17:54:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z6so1662533ljm.13
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2020 17:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ATl/YyNFGir4smvEUTlq/KkR2CgcH9y6IS3q99jhLs=;
        b=Q53CpEuCe5BAQWGjzWeuXrHorlioHrVowYwDVRiGCloTfuif1brMeniDptNuvB9yzj
         upKasxGIWWovsRAyO3Aoi8vYxGFsUQ9jjjFsAarCnLT0J/MA13Q/+JAiZnrbUHX6YGm9
         vltH82MgNYHuhHxgfK179xa5qdoWmv0z6EaCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ATl/YyNFGir4smvEUTlq/KkR2CgcH9y6IS3q99jhLs=;
        b=t/Cw0OVdToFxItn9g3dnuBbr1YHbIM4reZVvlu5BWL7MYPWbFxzpWnlzyt+KbbSjZp
         FessQZTMl8AA5xhu9OlwumY82/surgeQWuhiTlzlDCnMf+EK6SgZJkhh1Jn5+dI/wHNS
         RyDQECkjSTbEbg9hZo9q1o5x7EambzUUMIbcRKKtQ67xviiyHHyt3QzRsK7Te+8R9l/S
         UYxgFxN7X8snjKWYCNabphf2u1JwBfziFa0/IrT242wjB2445mmKP9D2e34czwfIkTup
         AcM+fCa8pa6J2n3b+/VgsFxO5HBz03MCzpq/5LhesX+GjReulUjScijRh1nnP/4HVQBt
         GgvQ==
X-Gm-Message-State: AOAM5332s6jyI5xY4/YEljcVcwWkEXWSmM+NlsYoVCrVvMy28lBYhYok
        lWoMxAuqovfx8LusNHW2dJLjY6iG3wo=
X-Google-Smtp-Source: ABdhPJx9oossR5IIAjRsAh+Gxhwr71E1WbKFQ8w4noQ3H1aLfxmXgGAAdOiuJ96boIx4UWs6P4sCgA==
X-Received: by 2002:a2e:780a:: with SMTP id t10mr1158301ljc.247.1589936057583;
        Tue, 19 May 2020 17:54:17 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id v4sm523282ljj.104.2020.05.19.17.54.17
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 17:54:17 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id h188so1097766lfd.7
        for <linux-wireless@vger.kernel.org>; Tue, 19 May 2020 17:54:17 -0700 (PDT)
X-Received: by 2002:ac2:4113:: with SMTP id b19mr930771lfi.143.1589935643824;
 Tue, 19 May 2020 17:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200515212846.1347-1-mcgrof@kernel.org> <20200515212846.1347-13-mcgrof@kernel.org>
 <2b74a35c726e451b2fab2b5d0d301e80d1f4cdc7.camel@sipsolutions.net>
 <7306323c35e6f44d7c569e689b48f380f80da5e5.camel@sipsolutions.net>
 <CA+ASDXOg9oKeMJP1Mf42oCMMM3sVe0jniaWowbXVuaYZ=ZpDjQ@mail.gmail.com> <20200519140212.GT11244@42.do-not-panic.com>
In-Reply-To: <20200519140212.GT11244@42.do-not-panic.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 19 May 2020 17:47:12 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMUHOcvJ_7UWgyANMxSz15Ji7TcLDXVCtSPa+fOr=+FGA@mail.gmail.com>
Message-ID: <CA+ASDXMUHOcvJ_7UWgyANMxSz15Ji7TcLDXVCtSPa+fOr=+FGA@mail.gmail.com>
Subject: Re: [PATCH v2 12/15] ath10k: use new module_firmware_crashed()
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        aquini@redhat.com, peterz@infradead.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        mchehab+samsung@kernel.org, will@kernel.org, bhe@redhat.com,
        ath10k@lists.infradead.org, Takashi Iwai <tiwai@suse.de>,
        mingo@redhat.com, dyoung@redhat.com, pmladek@suse.com,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, gpiccoli@canonical.com,
        Steven Rostedt <rostedt@goodmis.org>, cai@lca.pw,
        tglx@linutronix.de,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        schlad@suse.de, Linux Kernel <linux-kernel@vger.kernel.org>,
        jeyu@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Luis,

On Tue, May 19, 2020 at 7:02 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> On Mon, May 18, 2020 at 06:23:33PM -0700, Brian Norris wrote:
> > On Sat, May 16, 2020 at 6:51 AM Johannes Berg <johannes@sipsolutions.net> wrote:
> > > In addition, look what we have in iwl_trans_pcie_removal_wk(). If we
> > > detect that the device is really wedged enough that the only way we can
> > > still try to recover is by completely unbinding the driver from it, then
> > > we give userspace a uevent for that. I don't remember exactly how and
> > > where that gets used (ChromeOS) though, but it'd be nice to have that
> > > sort of thing as part of the infrastructure, in a sort of two-level
> > > notification?
> >
> > <slight side track>
> > We use this on certain devices where we know the underlying hardware
> > has design issues that may lead to device failure
>
> Ah, after reading below I see you meant for iwlwifi.

Sorry, I was replying to Johannes, who I believe had his "we"="Intel"
hat (as iwlwifi maintainer) on, and was pointing at
iwl_trans_pcie_removal_wk().

> If userspace can indeed grow to support this, that would be fantastic.

Well, Chrome OS tailors its user space a bit more to the hardware (and
kernel/drivers in use) than the average distro might. We already do
this (for some values of "this") today. Is that "fantastic" to you? :D

> > -- then when we see
> > this sort of unrecoverable "firmware-death", we remove the
> > device[*]+driver, force-reset the PCI device (SBR), and try to
> > reload/reattach the driver. This all happens by way of a udev rule.
>
> So you've sprikled your own udev event here as part of your kernel delta?

No kernel delta -- the event is there already:
iwl_trans_pcie_removal_wk()
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wireless/intel/iwlwifi/pcie/trans.c?h=v5.6#n2027

And you can see our udev rules and scripts, in all their ugly details
here, if you really care:
https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/master/net-wireless/iwlwifi_rescan/files/

> > We
> > also log this sort of stuff (and metrics around it) for bug reports
> > and health statistics, since we really hope to not see this happen
> > often.
>
> Assuming perfection is ideal but silly. So, what infrastructure do you
> use for this sort of issue?

We don't yet log firmware crashes generally, but for all our current
crash reports (including WARN()), they go through this:
https://chromium.googlesource.com/chromiumos/platform2/+/master/crash-reporter/README.md

For example, look for "cut here" in:
https://chromium.googlesource.com/chromiumos/platform2/+/master/crash-reporter/anomaly_detector.cc

For other specific metrics (like counting "EVENT=INACCESSIBLE"), we
use the Chrome UMA system:
https://chromium.googlesource.com/chromiumos/platform2/+/master/metrics/README.md

I don't imagine the "infrastructure" side of any of that would be
useful to you, but maybe the client-side gathering can at least show
you what we do.

> > [*] "We" (user space) don't actually do this...it happens via the
> > 'remove_when_gone' module parameter abomination found in iwlwifi.
>
> BTW is this likely a place on iwlwifi where the firmware likely crashed?

iwl_trans_pcie_removal_wk() is triggered because HW accesses timed out
in a way that is likely due to a dead PCIe endpoint. It's not directly
a firmware crash, although there may be firmware crashes reported
around the same time.

Intel folks can probably give a more nuanced answer, but their
firmware crashes usually land in something like iwl_mvm_nic_error() ->
iwl_mvm_dump_nic_error_log() + iwl_mvm_nic_restart(). If you can make
your proposal less punishing (e.g., removing the "taint" as Johannes
requested), maybe iwlwifi would be another good candidate for
$subject. iwlwifi generally expects to recover seamlessly, but it's
also good to know if you've seen a hundred of these in a row.

> > A uevent
> > would suit us very well I think, although it would be nice if drivers
> > could also supply some small amount of informative text along with it
>
> A follow up to this series was to add a uevent to add_taint(), however
> since a *count* is not considered I think it is correct to seek
> alternatives at this point. The leaner the solution the better though.
>
> Do you have a pointer to what guys use so I can read?

Hopefully the above pointers are useful to you. We don't yet have
firmware-crash parsing implemented, so I don't have pointers for that
piece yet.

> > (e.g., a sort of "reason code", in case we can possibly aggregate
> > certain failure types). We already do this sort of thing for WARN()
> > and friends (not via uevent, but via log parsing; at least it has nice
> > "cut here" markers!).
>
> Indeed, similar things can indeed be argued about WARN*()... this
> however can be non-device specific. With panic-on-warn becoming a
> "thing", the more important it becomes to really tally exactly *why*
> these WARN*()s may trigger.

panic-on-warn? Yikes. I guess such folks don't run mac80211... I'm
probably not supposed to publicize information related to how many
Chromebooks are out there, but we regularly see a scary number of
non-fatal warnings (WARN(), WARN_ON(), etc.) logged by Chrome OS users
every day, and a scary number of those are in WiFi drivers...

> > Perhaps
>
> Note below.

(My use of "perhaps" is only because I'm not familiar with devlink at all.)

> > devlink (as proposed down-thread) would also fit the bill. I
> > don't think sysfs alone would fit our needs, as we'd like to process
> > these things as they happen, not only when a user submits a bug
> > report.
>
> I think we've reached a point where using "*Perhaps*" does not suffice,
> and if there is already a *user* of similar desired infrastructure I
> think we should jump on the opportunity to replace what you have with
> something which could be used by other devices / subsystems which
> require firmware. And indeed, also even consider in the abstract sense,
> the possibility to leverage something like this for WARN*()s later too.

To precisely lay out what Chrome OS does today:

* WARN() and similar: implemented, see anomaly_detector.cc above. It's
just log parsing, and that handy "cut here" stuff -- I'm nearly
certain there are other distros using this already? A uevent would
probably be nice, but log parsing is good enough for us today.
* EVENT=INACCESSIBLE: iwlwifi-specific, but reference code is linked
above. It's a uevent, and we handle it via udev. Code is linked above.
* Other firmware crashes: not yet implemented here, but we're looking
at it. Currently, we plan to do something similar to WARN(), but it
will be ugly and non-generic. A uevent would be a lovely replacement,
if it has some basic metadata with it. Stats in sysfs might be icing
on the cake, but mostly redundant for us, if we can grab it on the fly
via uevent.

HTH,
Brian
