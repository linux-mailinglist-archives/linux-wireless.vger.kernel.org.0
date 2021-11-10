Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B1944BE17
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Nov 2021 10:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhKJJyx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 04:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhKJJyu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 04:54:50 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA09C061764
        for <linux-wireless@vger.kernel.org>; Wed, 10 Nov 2021 01:52:03 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id l8so1861081ilv.3
        for <linux-wireless@vger.kernel.org>; Wed, 10 Nov 2021 01:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t+lAFOyVdIksr8MunKT6lqiTF4RHOll8lIho7t9j0UU=;
        b=ZSkEFvMWsebMRWDTvQdaFGQfVPqfk9hpsk5WiUuwGG+zMvGRVwl1HWf0YeeOlCG0mC
         XoF146LDjHw866DB3TiOYROumcMyIhn0Hy+VV1wMAnYkFn8SE7kEUNPplJLXhdoThty9
         6Cru9/IDIaLgCP6d9UGR5VMBI8cZVtruHVChKWm2+PWYsrI4HbexXcvDpOeGo0GEvsVm
         /8/whhZ28dJdohtvr56LFdoBxzmICQTBVle2d9MbflYaL1zCpqg5hJu4SQz+KNWLOUS6
         Bo640MB+rdDEDs4PGa4euaowMxvTosB2s3KOxiZo0/4FkZYSGmtQhoVvOSlAtGi61x8C
         Prmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+lAFOyVdIksr8MunKT6lqiTF4RHOll8lIho7t9j0UU=;
        b=udUp1yqB1WDIznefVjub6pel28Q4A/R7wNS1BirmlZUGyas0K859SQdjsEKM9A2Y1V
         T1A52LV03aTEjrir4Kl7WDiMtSnlTvbNKo0tJcCwJf2xmUZViEV6kEqYziSYUIRxG7nU
         zAgUl1aPtAA638JDuYMa3kNKosdjRgwMbUNqHVsZkvoUI3LsYKo5hIc+x61hCdxj//kG
         aiEErx4G/IhNP4gN+Xsy75rlBwlgOv29d70/4txHxMAvYiZ81iIk+bJevIyGru+TiQ3g
         YZ5l0pGhEOcsIQFb6H7tiHtFwzsAi5SCcUh53tUB6VNCsKVfQjloYngms0zBKHbM0MG1
         FCKQ==
X-Gm-Message-State: AOAM532FCRnRKZBHj6nHbMmW0YprzLOK0bXXZ73aqfraaJ7lSeZduGpg
        1DjYF/lvrTMkUxJimdKivRsFHAYTKvNneZBd9ndJK29U
X-Google-Smtp-Source: ABdhPJw/6FA0lZl9WBftCnyZEIF0CXvPqrmEZrxJBeljOsrbgG5XKlwXUIPjKhHjGkT3Ueq+Y9zjo+K00GuOPwDiTOg=
X-Received: by 2002:a92:c562:: with SMTP id b2mr10234100ilj.30.1636537922719;
 Wed, 10 Nov 2021 01:52:02 -0800 (PST)
MIME-Version: 1.0
References: <20210811105541.43426-1-emmanuel.grumbach@intel.com>
 <20210811105541.43426-2-emmanuel.grumbach@intel.com> <87tuhevbx2.fsf@codeaurora.org>
 <CANUX_P2e80pVMJJRUuyPGoXZtYGMM9pJWqd5Ut6rW3aDRmr7cQ@mail.gmail.com>
 <87lf2of69j.fsf@codeaurora.org> <CANUX_P1h3rL8i7K_V5VKtO3A=6voL_GR8C+6u0kBosGDmU_vBg@mail.gmail.com>
 <87pmr8nyb7.fsf@codeaurora.org>
In-Reply-To: <87pmr8nyb7.fsf@codeaurora.org>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Wed, 10 Nov 2021 11:51:51 +0200
Message-ID: <CANUX_P137LnjGus5oO2JYyau-kMsAUOPZPx5JP_UW1jAjUC0ig@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] iwlwifi: mei: add the driver to allow cooperation
 with CSME
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Nov 10, 2021 at 11:40 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Emmanuel Grumbach <egrumbach@gmail.com> writes:
>
> >>
> >> Emmanuel Grumbach <egrumbach@gmail.com> writes:
> >>
> >> > On Mon, Oct 18, 2021 at 1:58 PM Kalle Valo <kvalo@codeaurora.org> wrote:
> >> >>
> >> >> Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:
> >> >>
> >> >> > CSME in two words
> >> >> > -----------------
> >> >> > CSME stands for Converged Security and Management Engine. It is
> >> >> > a CPU on the chipset and runs a dedicated firmware.
> >> >> > AMT (Active Management Technology) is one of the applications
> >> >> > that run on that CPU. AMT allows to control the platform remotely.
> >> >> > Here is a partial list of the use cases:
> >> >> > * View the screen of the plaform, with keyboard and mouse (KVM)
> >> >> > * Attach a remote IDE device
> >> >> > * Have a serial console to the device
> >> >> > * Query the state of the platform
> >> >> > * Reset / shut down / boot the platform
> >> >>
> >> >> [...]
> >> >>
> >> >> > --- a/drivers/net/wireless/intel/iwlwifi/Kconfig
> >> >> > +++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
> >> >> > @@ -92,6 +92,23 @@ config IWLWIFI_BCAST_FILTERING
> >> >> >         If unsure, don't enable this option, as some programs might
> >> >> >         expect incoming broadcasts for their normal operations.
> >> >> >
> >> >> > +config IWLMEI
> >> >> > +     tristate "Intel Management Engine communication over WLAN"
> >> >> > +     depends on INTEL_MEI
> >> >> > +     depends on PM
> >> >> > +     depends on IWLMVM
> >> >> > +     help
> >> >> > +       Enables the iwlmei kernel module. This allows to communicate with
> >> >> > +       the Intel Management Engine over Wifi. This is supported starting
> >> >> > +       from Tiger Lake platforms and has been tested on 9260 devices only.
> >> >> > +       Enabling this option on a platform that has a different device and
> >> >> > +       has Wireless enabled on AMT can prevent WiFi from working correctly.
> >> >>
> >> >> I don't understand the last sentence, please elaborate. Are you saying
> >> >> that enabling CONFIG_IWLMEI will break wi-fi in some cases?
> >> >
> >> > Since we don't support all the devices (yet), and we haven't integrated it
> >> > with all our devices, then yes, it shouldn't be enabled unless you know
> >> > exactly what platform this kernel runs on.
> >>
> >> So if I'm understanding correctly, enabling CONFIG_IWLMEI will break
> >> existing iwlwifi setups? Or am I missing something?
> >
> > Ok, I'll share more details.
> > The coexistence between iwlwifi and CSME has never really been taken care
> > of. CSME is a feature meant for enterprise and those systems typically run
> > Windows which is why the Windows driver has had this feature for years
> > but not Linux.
> > iwlmei will not do anything if you don't have CSME configured to use the
> > WLAN device. Someone needs to actively configure CSME to use WLAN for
> > this to happen. Very few systems have this configuration.
>
> So in a case when CSME/AMT WLAN (or whatever the feature under
> discussion is called) is disabled in the BIOS and CONFIG_IWLMEI is
> enabled in the kernel build, iwlwifi will work as before? This is the
> most important part for me, we must not break people's network access
> when they upgrade the kernel.

Yes.
We need another fix that is not in v7 for a bug we found in our testing, but
when the user doesn't use AMT, nothing will happen even if IWLMEI is compiled.

>
> > Now the question is what happens today (without iwlmei) when CSME is
> > configured to use WLAN compared to what happens with iwlmei, or in other
> > words, do we have a "regression"?
> >
> > Today: there is some mechanism that allows iwlwifi to tell CSME not to touch
> > the device. This mechanism is not very well tested because only Linux uses it
> > and the assumption in Linux has almost always been that CSME is not
> > configured on systems that run Linux.
> >
> > with iwlmei: we will be using the same interface as windows towards CSME which
> > is a well tested interface and we will be able to use the features
> > that CSME provides
> >
> > Why the warning then? The integration with CSME has been done on 9260
> > only and not on newer devices. We do have plans to add support for
> > more devices but the current code doesn't support them.
> >
> > What will happen if a user enables iwlmei on a system that has a
> > post-9260 device and CSME configured to use WLAN? Most probably, it'll
> > work, but this has not been tested yet
>
> I hope you are printing an understandable info message when CSME is
> enabled so that the situation is easy to notice and debug.
>
> > This configuration is far from the default and considered illegal by
> > Intel at this point I know that a user can always do something stupid,
> > but he can likewise disable mac80211 and complain that his wifi
> > doesn't work.
>
> A user cannot compile iwlwifi unless mac80211 is enabled and likewise
> iwlwifi module won't load unless mac80211 is loaded first. So we do have
> checks for a lot of stuff.
>
> > My suggestion is to add a WARNING (or an dev_err print) in iwlwifi if
> > we detect this situation so that it'll be very easy to catch this
> > problem in the configuration.
>
> Heh, exactly what I was thinking above.

No problem. I'll do that.
Our testing teams are right now working on testing more devices.

>
> > The only way to prevent this situation would be to know what device
> > the user has from iwlmei in the mei bus enumeration but this is
> > unfortunately not possible.
> >
> > I hope that made things clearer. I know all this is confusing, many
> > pieces of details that I hoped I wouldn't have to bore you with :)
>
> It would have been a lot easier and faster to mention all this in the
> commit logs from the beginning. Dumping me patches without commit logs
> and no clear explanation is not really building confidence for me.
>

I understand. There are loads of details and I didn't really want to bother you
with all of them, I guess I now know that you are the type of person who want
the details and I'll be clearer the next time.

Practically speaking, I owe you a v8 with the WARNING I mentioned plus
the bugfix
I talked about.

Do you want it now or you want me to wait for more comments?
