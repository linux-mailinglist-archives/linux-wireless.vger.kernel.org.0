Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A55E4316C3
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 13:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhJRLGO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 07:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhJRLGN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 07:06:13 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907B5C06161C
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 04:04:02 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id q13so2838747uaq.2
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 04:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WcH6DWYdn2sJzGb6MkUmDQKzCUHDpEA0eKg6cbB/TYo=;
        b=nHqy8kwoWS05KDPo+mQB3OdfJOyfvld/UHW26vH3gjgyBYbF8QMDcK4oQao5uZPOC/
         eb3Qu7N5QWPHPR3vba29h/BNPm0MrEpl/MIQPhUglW9rmFKvJTomFBrFQS6avzV0ZRQK
         YvQkNg/EUXN0qHtquh746ODnU/LhvpzNvDm7CsgqI6VGPQhwTTTdk/KfwjP49lowzdf1
         reJcKnHZzcSu2u14qqw/L6YoU1EXJ3K5ZyF6HBXuYwc7uT2JqLWLzOUkzt799LnpG1Bh
         e1XwoC1kzgzqJfSGzXE+j2WvT6s1W6EqSrl0+sAeNPAAeLsdnWFwzUrNJrHe95LXtALV
         cqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WcH6DWYdn2sJzGb6MkUmDQKzCUHDpEA0eKg6cbB/TYo=;
        b=uo3xBXixK2sM5YJ9ctmZUlFBaJC4x0jABHIB8gOC/YLPggtXUfnPHwaptZWdvD0nV0
         AIuLz4lqc+IciTgzyYRUV9f0SEio4DTiBbCt6JJJZ3/BW7gNK8bEZMVQ7+/6zqjsm31o
         2/4ROHf3atJryWIpt4e5Q0ieeOHylqFX5WNGNisfuKtvOHsHJgIn1cTqlPu6EPjwl9Am
         5cg487+/2nzQmKZvq0mG4Mrtw5LY0aFIDoy9Ea/Msio0MlrVwo3HrwATFZyminlsm9+T
         3fm568JpALhQ4R4TogwX2rcIcbzrG66gFss90nXyYC3fPrESJucjQ16jtA8V2QodwqTh
         pjEA==
X-Gm-Message-State: AOAM530oWgBLLFrbNssv2HCB0rz40YmWvfsOQkD2ZwwBbUT+mZy5R8eq
        T5rA0df8KFJD3573q4XLYbUvHSkE0DucPuuh6Rc=
X-Google-Smtp-Source: ABdhPJzSmSMy7TGs3evX3zTbcr6WvJcEMa2Fa1i07sum7l+Vq1UMhnw3+ppWqTq08+aiqZIQfdlRORO8lUpMceXJwbw=
X-Received: by 2002:ab0:58c1:: with SMTP id r1mr24249949uac.89.1634555041656;
 Mon, 18 Oct 2021 04:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210811105541.43426-1-emmanuel.grumbach@intel.com>
 <20210811105541.43426-2-emmanuel.grumbach@intel.com> <87tuhevbx2.fsf@codeaurora.org>
In-Reply-To: <87tuhevbx2.fsf@codeaurora.org>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Mon, 18 Oct 2021 14:03:50 +0300
Message-ID: <CANUX_P2e80pVMJJRUuyPGoXZtYGMM9pJWqd5Ut6rW3aDRmr7cQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] iwlwifi: mei: add the driver to allow cooperation
 with CSME
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Oct 18, 2021 at 1:58 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:
>
> > CSME in two words
> > -----------------
> > CSME stands for Converged Security and Management Engine. It is
> > a CPU on the chipset and runs a dedicated firmware.
> > AMT (Active Management Technology) is one of the applications
> > that run on that CPU. AMT allows to control the platform remotely.
> > Here is a partial list of the use cases:
> > * View the screen of the plaform, with keyboard and mouse (KVM)
> > * Attach a remote IDE device
> > * Have a serial console to the device
> > * Query the state of the platform
> > * Reset / shut down / boot the platform
>
> [...]
>
> > --- a/drivers/net/wireless/intel/iwlwifi/Kconfig
> > +++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
> > @@ -92,6 +92,23 @@ config IWLWIFI_BCAST_FILTERING
> >         If unsure, don't enable this option, as some programs might
> >         expect incoming broadcasts for their normal operations.
> >
> > +config IWLMEI
> > +     tristate "Intel Management Engine communication over WLAN"
> > +     depends on INTEL_MEI
> > +     depends on PM
> > +     depends on IWLMVM
> > +     help
> > +       Enables the iwlmei kernel module. This allows to communicate with
> > +       the Intel Management Engine over Wifi. This is supported starting
> > +       from Tiger Lake platforms and has been tested on 9260 devices only.
> > +       Enabling this option on a platform that has a different device and
> > +       has Wireless enabled on AMT can prevent WiFi from working correctly.
>
> I don't understand the last sentence, please elaborate. Are you saying
> that enabling CONFIG_IWLMEI will break wi-fi in some cases?

Since we don't support all the devices (yet), and we haven't integrated it
with all our devices, then yes, it shouldn't be enabled unless you know
exactly what platform this kernel runs on. This is basically a warning for
distros not to enable this kernel option (just as many others that are specific
to a certain use case). The plan is to add support for more and more devices
so that we will be able to remove this comment and be confident that it can
be enabled on generic platforms as well.

>
> > +       For more information see
> > +       <https://software.intel.com/en-us/manageability/>
> > +
> > +       If unsure, say N.
>
> IMHO the help text still contains too much Intel jargon to be really
> understandable by everyone. I think the commit log pretty well
> summarises what this is all about:
>
>   "CSME stands for Converged Security and Management Engine. It is a CPU
>    on the chipset and runs a dedicated firmware. AMT (Active Management
>    Technology) is one of the applications that run on that CPU. AMT
>    allows to control the platform remotely."
>
> Somehow including that information to the Kconfig help text would be
> very helpful to everyone.

I'll try.

Thanks!

>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
