Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5631C373
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 08:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfENGw3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 02:52:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55198 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfENGw3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 02:52:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id i3so1535328wml.4
        for <linux-wireless@vger.kernel.org>; Mon, 13 May 2019 23:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=14dzsudd7sUG7BDz0u24Ld3Jw0VzpoPG2X+vAzwuqFI=;
        b=KfIqLBxaLtPT3uoPIWV4yFjvWn2nHfOMnS2JRrh6NXsh9oQr71hQwzo4v/Hd9qdRsE
         qkrdP1zeE4iaFvo9BQjvlQLA7JwfBWYDSEMO9/GbbF9P58xD0cHgx4+ZsoFG5MMl/bVh
         sQ4bAch7wosDZcDou6pKhVL0cSFmcUPc4PgCYNaL7LkB23dAJS0ZX/ydGl+8wtkdLM7e
         sGOW4UvGvAr7nMA1LJOQymPjPEClwd/O+ERXZIbymrtTAaAxiCmYEsu68x20m/YBs0vY
         DB8wgEjRZOYOxuInS6lVmxWZmLG0Gc2yiH3QugFiVfRO56m2v9AzHDeiNKiRauDGLmnv
         kY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=14dzsudd7sUG7BDz0u24Ld3Jw0VzpoPG2X+vAzwuqFI=;
        b=hndSa+pmeUI9ln5FJIU3PNItP9hUWTrYAiVbQPL0FVI44WBMwC0n48bI+6zM4tIvtJ
         eH8LWbyWGfO2VpT+1hcyiSH7VFpsNrTe/RaQlFwD7MHam/wmAD2AnonrqW7OYMMA4iyc
         K+Nx0kSrizjNpIcXv9/QqEJy6ClijIYH3/fiXc3rFNUe6K/e7cc+MxULM7rWwguzoh2i
         iIqhndqjT3OGg9Cm3o6nxOQD14ZdecByd0a6wj4u8c+9Q7Zh+O6XM3AEnG96m/l7vvP1
         zpCA1zpqswotPqHj3xMY3R19FlE0eR66f9q6rIWC8FlKTlVj5+4ABNmYymUOyHYVu87i
         z33w==
X-Gm-Message-State: APjAAAVuhYW/PudmdLinBUkxc+xl6R+KG4c9MwGCVmQE/9gzmq82i6oq
        C4O9NNl4N1LChy5DKV9smJLebClNcyGUaCtlXhE=
X-Google-Smtp-Source: APXvYqzKAhLbEREeLmH4GBlgzj6nhFtkF9oWCbxqjCodtODNXMWteVag4NDMVuacRs8icydo+xZwvtpRHMOosnthjZ4=
X-Received: by 2002:a1c:385:: with SMTP id 127mr6999044wmd.109.1557816746990;
 Mon, 13 May 2019 23:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <c2d0d19f-d814-8f41-4860-77b9cc7f9d26@linaro.org>
 <CA+icZUVz7sB6hv4fhL_rqhR_D8RePBJFXk1PaUy5tMw2z4xC_Q@mail.gmail.com> <5ae87449-83a1-ecce-c72c-b4742c507497@linaro.org>
In-Reply-To: <5ae87449-83a1-ecce-c72c-b4742c507497@linaro.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 May 2019 08:52:15 +0200
Message-ID: <CA+icZUWLBjTtcFS0Fo8M5gSb90GbEUpetUgwr3fy=NxGAVqCyw@mail.gmail.com>
Subject: Re: NXP NFC version and ACPI
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org,
        robert.dolca@intel.com, oleg.zhurakivskyy@intel.com,
        clement.perrochaud@effinnov.com, charles.gorand@effinnov.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, May 14, 2019 at 8:43 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 13/05/2019 22:15, Sedat Dilek wrote:
> > On Wed, Dec 5, 2018 at 8:38 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >>
> >> Hi,
> >>
> >> the discussion reference is on github [1].
> >>
> >> I acquired a Lenovo x280 with a NFC chip. It is unclear what chip is it
> >> really, it is called NXP NPC300 which could be a PN7xxx chip range.
> >>
> >> A hacked version of an old deprecated out-of-tree module made the PN5xxx
> >> to work with my laptop but I suspect it brought some subtle instability
> >> on my system.
> >>
> >> Now it would be nice to have this correctly supported upstream.
> >>
> >> I dumped the ACPI DSDT table and got the id NXP1001. This one is not
> >> listed in the match table of the nxp-nci driver.
> >>
> >>  - is the driver missing for the so called NXP NPC300 ?
> >>  - should the NXP1001 matching string to be added to nxp-nci?
> >>  - is my firmware sending me garbage ?
> >>
> >> Thanks in advance for any input
> >>
> >
> > [ CC Andy ]
> >
> > Hi Daniel,
> >
> > I was able to get a NXP NPC300 NFC device run on Lenovo ThinkPad T470.
> >
> > Look at the patchset "[PATCH v2 00/12] NFC: nxp-nci: clean up and
> > support new ID".
> > I have tested on top of Linux v5.1.1.
>
> Hi Sedat,
>
> yes, I have them see. Thanks for letting me know.
>
> > Here I have set...
> >
> > scripts/config -m NFC_NCI -m NFC_NXP_NCI -m NFC_NXP_NCI_I2C -e
> > PINCTRL_SUNRISEPOINT
> >
> > Please give this a try and report.
>
> My laptop is the first one I have with a NFC reader, so I'm not used to
> test this as it was not working yet.
>
> I booted the machine with a 5.1.1, the series applied on top, and the
> config options set as mentioned above.
>
> The nxp-nci kernel module is loaded and neard is installed.
>
> I used the sniffing tool with the command libnfc -d nfc0 -n but when
> passing my NFC devices on the laptop's NFC mark, nothing happens.
>
> Is that correct?
>

Hi Daniel,

I am new to the topic Linux NFC.

I have installed neard (daemon) v0.16 and neard-tools from Debian/buster AMD64.

root@iniza:~# systemctl is-active neard.service
active

root@iniza:~# nfctool --list
nfc0:
          Tags: [ ]
          Devices: [ ]
          Protocols: [ Felica MIFARE Jewel ISO-DEP NFC-DEP ]
          Powered: No
          RF Mode: None
          lto: 150
          rw: 15
          miux: 2047

root@iniza:~# nfctool --poll -d nfc0
Start polling on nfc0 as initiator

...

Throwing my YubiKey Neo-5 NFC on my ThinkPad T470 NFC sticker shows me...

Targets found for nfc0
  Tags: [ tag0 ]
  Devices: [ ]

Hope that helps.

Regards,
- Sedat -
