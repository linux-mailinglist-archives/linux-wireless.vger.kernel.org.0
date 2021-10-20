Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CFF434820
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Oct 2021 11:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhJTJqc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Oct 2021 05:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJTJqc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Oct 2021 05:46:32 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12FDC06161C
        for <linux-wireless@vger.kernel.org>; Wed, 20 Oct 2021 02:44:17 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id r22so5347134uat.11
        for <linux-wireless@vger.kernel.org>; Wed, 20 Oct 2021 02:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iyc8w2ErCROpQtEM3K/B0XODloXaDYH08+Vf/+/pBWc=;
        b=Ue5GYild5G94zE9mLx+5Dt9dv4LkdNAoT2GBT2w9X6mTWVfftmR7PDSmO4PcmQeFen
         UNu9zpSUVXqvBK+IdvMPq7/uDrW9wNuy4aZmrKp3nGCV+12xWUWne6pp6hQ8nu/1AOU/
         E0IPapNSnwhEDpF/VScP8oFfG9VwM8QKKv+2UzMMAiBZY46GslQ6HFD6sFUKzB36ipvb
         kfg7zj/DtsbqLpwvz+vH0TFv5nPUf5R7ocjxd0dPzO+9Z3JvOFz38UrtlTm8gdc3kCKE
         iErTjokxhnPJQ48Qe0pp2usKpbbnbHsXekwU32Rf7d3bWpZYQJau0YPl2nxGHIenwMRM
         tx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyc8w2ErCROpQtEM3K/B0XODloXaDYH08+Vf/+/pBWc=;
        b=wfuNm0wZOjIZsP9CF2XZd3K0hAjTeeBYIs3FYarr9NRKWvEUm34rzjlBb0Nl314zay
         mQskLJW1VBr4a1g9GGooFC+9Cv7otOejTEUm7saty/aSDrd01GxRBmclCCvaihZL+fxP
         PvHLbB43ARJ6tGMTBvbdkKpkOjeZ0jSOZnBvQwxmLaC6gnaXN/jypmw4KYes2oSwHx9x
         jxeaU6J5maoAM+SLwKP9dTlURFD98wdsvstsqcZccWOsrYYNUvnxWk+rg339pSFfMEeM
         fTuwnCZL+rKTyeXqDZCzBkLx9qPM1QtD6n+6eIc28/BC0uhhwUMkEVMi6Qkz+1tu4Ekf
         pAOA==
X-Gm-Message-State: AOAM533gOv1mi6J/9obUgpp5XUbX3m0Uaqae3FZPpTHRQAP46ow09vPX
        P3Y1emhfLc5oaPr4jxKQ3PBdmLUlIAEuQaJgq3jIbtGo
X-Google-Smtp-Source: ABdhPJx2hoN8ZXfYsNlf67f2dr9UBD/USuN1AzfOtZJs52oOykRyp7L1SrTRoZyR+H1G5GnSHlBphzm3ZDGjuTeQNj0=
X-Received: by 2002:ab0:58c1:: with SMTP id r1mr5630431uac.89.1634723056870;
 Wed, 20 Oct 2021 02:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210811105541.43426-1-emmanuel.grumbach@intel.com>
 <20210811105541.43426-2-emmanuel.grumbach@intel.com> <87tuhevbx2.fsf@codeaurora.org>
 <CANUX_P2e80pVMJJRUuyPGoXZtYGMM9pJWqd5Ut6rW3aDRmr7cQ@mail.gmail.com> <87lf2of69j.fsf@codeaurora.org>
In-Reply-To: <87lf2of69j.fsf@codeaurora.org>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Wed, 20 Oct 2021 12:44:05 +0300
Message-ID: <CANUX_P1h3rL8i7K_V5VKtO3A=6voL_GR8C+6u0kBosGDmU_vBg@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] iwlwifi: mei: add the driver to allow cooperation
 with CSME
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> Emmanuel Grumbach <egrumbach@gmail.com> writes:
>
> > On Mon, Oct 18, 2021 at 1:58 PM Kalle Valo <kvalo@codeaurora.org> wrote:
> >>
> >> Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:
> >>
> >> > CSME in two words
> >> > -----------------
> >> > CSME stands for Converged Security and Management Engine. It is
> >> > a CPU on the chipset and runs a dedicated firmware.
> >> > AMT (Active Management Technology) is one of the applications
> >> > that run on that CPU. AMT allows to control the platform remotely.
> >> > Here is a partial list of the use cases:
> >> > * View the screen of the plaform, with keyboard and mouse (KVM)
> >> > * Attach a remote IDE device
> >> > * Have a serial console to the device
> >> > * Query the state of the platform
> >> > * Reset / shut down / boot the platform
> >>
> >> [...]
> >>
> >> > --- a/drivers/net/wireless/intel/iwlwifi/Kconfig
> >> > +++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
> >> > @@ -92,6 +92,23 @@ config IWLWIFI_BCAST_FILTERING
> >> >         If unsure, don't enable this option, as some programs might
> >> >         expect incoming broadcasts for their normal operations.
> >> >
> >> > +config IWLMEI
> >> > +     tristate "Intel Management Engine communication over WLAN"
> >> > +     depends on INTEL_MEI
> >> > +     depends on PM
> >> > +     depends on IWLMVM
> >> > +     help
> >> > +       Enables the iwlmei kernel module. This allows to communicate with
> >> > +       the Intel Management Engine over Wifi. This is supported starting
> >> > +       from Tiger Lake platforms and has been tested on 9260 devices only.
> >> > +       Enabling this option on a platform that has a different device and
> >> > +       has Wireless enabled on AMT can prevent WiFi from working correctly.
> >>
> >> I don't understand the last sentence, please elaborate. Are you saying
> >> that enabling CONFIG_IWLMEI will break wi-fi in some cases?
> >
> > Since we don't support all the devices (yet), and we haven't integrated it
> > with all our devices, then yes, it shouldn't be enabled unless you know
> > exactly what platform this kernel runs on.
>
> So if I'm understanding correctly, enabling CONFIG_IWLMEI will break
> existing iwlwifi setups? Or am I missing something?

Ok, I'll share more details.
The coexistence between iwlwifi and CSME has never really been taken care
of. CSME is a feature meant for enterprise and those systems typically run
Windows which is why the Windows driver has had this feature for years
but not Linux.
iwlmei will not do anything if you don't have CSME configured to use the
WLAN device. Someone needs to actively configure CSME to use WLAN for
this to happen. Very few systems have this configuration.

Now the question is what happens today (without iwlmei) when CSME is
configured to use WLAN compared to what happens with iwlmei, or in other
words, do we have a "regression"?

Today: there is some mechanism that allows iwlwifi to tell CSME not to touch
the device. This mechanism is not very well tested because only Linux uses it
and the assumption in Linux has almost always been that CSME is not
configured on systems that run Linux.

with iwlmei: we will be using the same interface as windows towards CSME which
is a well tested interface and we will be able to use the features
that CSME provides

Why the warning then?
The integration with CSME has been done on 9260 only and not on newer devices.
We do have plans to add support for more devices but the current code
doesn't support
them.

What will happen if a user enables iwlmei on a system that has a
post-9260 device and
CSME configured to use WLAN?
Most probably, it'll work, but this has not been tested yet

This configuration is far from the default and considered illegal by
Intel at this point
I know that a user can always do something stupid, but he can likewise
disable mac80211
and complain that his wifi doesn't work.

My suggestion is to add a WARNING (or an dev_err print) in iwlwifi if
we detect this situation
so that it'll be very easy to catch this problem in the configuration.

The only way to prevent this situation would be to know what device
the user has from iwlmei
in the mei bus enumeration but this is unfortunately not possible.

I hope that made things clearer.
I know all this is confusing, many pieces of details that I hoped I wouldn't
have to bore you with :)

>
> If that's the case when we have a major problem as that would be a
> regression. A kconfig option is not a free pass to do all sort of crazy
> stuff, and especially it cannot break already working hardware. That
> would be considered as a regression and we have a strong rule for
> regressions.


>
> > This is basically a warning for distros not to enable this kernel
> > option (just as many others that are specific to a certain use case).
> > The plan is to add support for more and more devices so that we will
> > be able to remove this comment and be confident that it can be enabled
> > on generic platforms as well.
>
> I barely missed the warning and I consider myself as an extra careful
> person, I can only imagine how many regular users will enable this
> option without thinking twice. And people can use allmodconfig etc as
> well.
>
