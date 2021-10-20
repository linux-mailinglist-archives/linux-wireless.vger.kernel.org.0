Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14886434489
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Oct 2021 07:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhJTFMp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Oct 2021 01:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhJTFMo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Oct 2021 01:12:44 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9F6C06161C
        for <linux-wireless@vger.kernel.org>; Tue, 19 Oct 2021 22:10:30 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id i22so4296789ual.10
        for <linux-wireless@vger.kernel.org>; Tue, 19 Oct 2021 22:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cA9skDxHOwT77QivBMmI5FcshyLPFpwMdp/YnfuvIgU=;
        b=nEYcMhI4VYqnlOVIRGiDw6tEx7dwdm9t8ObNfHd1zxslld86gXAX03q5EP3BDDfvjS
         +AdVtRzQwQTFVn+PQmO3MZ6whz3N6keKUH6pmMt9KmDZnEbbN4dNhD9tr9CCrIKVJW39
         mLz2jgi0CE/P0kc8oGr4BwAvRgEx52f1Ltu/ZDxUJWJeN7EZLAcXzFZSRaifD17zoVUC
         fVRQkOy8kvVdxmXC+SnoPOJU6Ttcmd/L0kRzxM41Yzz5XFXPwrJdlZcu4j8eHJXHFt6r
         chTSgAbqgve/upesbR6lnZ1Uicjmux/uLLqyrbt7rmN40Asfvk/c0tLNb3UN2/vheYjb
         8+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cA9skDxHOwT77QivBMmI5FcshyLPFpwMdp/YnfuvIgU=;
        b=a+N9u6RPxjtEysixJA7CegmgjDCVnQE2+hIQet9z1pcPQvX9oMCq1KwL4As7weQRMz
         129/XanI568LsPQElx9Bd8M3beM0r+Zbxs035ketDszXAsMAR1w0oY20qZDZQKpSq36b
         D0Ga3IjSdhwwN3fTw62zT8nvcYZD2YQx5D2hZ4Jivcrl5zFpzbgSLbTti2esyaO5OBjd
         tPfrcVSSgl2yPfSpROGwffNHciSxMSjTxYl8kF89VgFi2qXLQtjt9JhgONj/Ex6GlUy7
         JQn6RkSv59V4O/vcWawcPvcx8KZmTqA1sRliZDiCVMVX4zhGYUy5Iwat9DTiixNHQ9iG
         6PgA==
X-Gm-Message-State: AOAM533nCTci4qbJjqKYKZyG4XKP6NsEtAx9VU0hklqgrZwGsRKmD8dm
        jicm/6Sx2w2Uw+6aJoBSyGEvlMRHjJ1wU40ApP5k9sks
X-Google-Smtp-Source: ABdhPJxZHHOSI3rR2MmiKqXqfOOF3H4kxxK8iIuJW8+cfrL+C7n6IAKcsF+ADE/XAiPRIg2Cp4Al9S0V4gGZUu6Cvwc=
X-Received: by 2002:ab0:58c1:: with SMTP id r1mr4914344uac.89.1634706629671;
 Tue, 19 Oct 2021 22:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210811105541.43426-1-emmanuel.grumbach@intel.com>
 <20210811105541.43426-2-emmanuel.grumbach@intel.com> <87lf2qvbg2.fsf@codeaurora.org>
 <CANUX_P3F_fJK1wWRJPw+9SFeB0dfP0rUOA_gSPruuSnrtzmQ_g@mail.gmail.com>
In-Reply-To: <CANUX_P3F_fJK1wWRJPw+9SFeB0dfP0rUOA_gSPruuSnrtzmQ_g@mail.gmail.com>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Wed, 20 Oct 2021 08:10:18 +0300
Message-ID: <CANUX_P1akom-cbxS1aP14HEhFyb0ZPa=Vr5ZbwUK5hRx-LZfPA@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] iwlwifi: mei: add the driver to allow cooperation
 with CSME
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Oct 18, 2021 at 10:17 PM Emmanuel Grumbach <egrumbach@gmail.com> wrote:
>
> On Mon, Oct 18, 2021 at 2:08 PM Kalle Valo <kvalo@codeaurora.org> wrote:
> >
> > Emmanuel Grumbach <emmanuel.grumbach@intel.com> writes:
> >
> > > CSME in two words
> > > -----------------
> > > CSME stands for Converged Security and Management Engine. It is
> > > a CPU on the chipset and runs a dedicated firmware.
> > > AMT (Active Management Technology) is one of the applications
> > > that run on that CPU. AMT allows to control the platform remotely.
> > > Here is a partial list of the use cases:
> > > * View the screen of the plaform, with keyboard and mouse (KVM)
> > > * Attach a remote IDE device
> > > * Have a serial console to the device
> > > * Query the state of the platform
> > > * Reset / shut down / boot the platform
> > >
> > > Networking in CSME
> > > ------------------
> > > For those uses cases, CSME's firmware has an embedded network
> > > stack and is able to use the network devices of the system: LAN
> > > and WLAN. This is thanks to the CSME's firmware WLAN driver.
> > >
> > > One can add a profile (SSID / key / certificate) to the CSME's OS
> > > and CSME will connect to that profile. Then, one can use the WLAN
> > > link to access the applications that run on CSME (AMT is one of
> > > them). Note that CSME is active during power state and power state
> > > transitions. For example, it is possible to have a KVM session
> > > open to the system while the system is rebooting and actually
> > > configure the BIOS remotely over WLAN thanks to AMT.
> > >
> > > How all this is related to Linux
> > > --------------------------------
> > > In Linux, there is a driver that allows the OS to talk to the
> > > CSME firmware, this driver is drivers/misc/mei. This driver
> > > advertises a bus that allows other kernel drivers or even user
> > > space) to talk to components inside the CSME firmware.
> > > In practice, the system advertises a PCI device that allows
> > > to send / receive data to / from the CSME firmware. The mei
> > > bus drivers in drivers/misc/mei is an abstration on top of
> > > this PCI device.
> > > The driver being added here is called iwlmei and talks to the
> > > WLAN driver inside the CSME firmware through the mei bus driver.
> > > Note that the mei bus driver only gives bus services, it doesn't
> > > define the content of the communication.
> > >
> > > Why do we need this driver?
> > > --------------------------
> > > CSME uses the same WLAN device that the OS is expecting to see
> > > hence we need an arbitration mechanism. This is what iwlmei is
> > > in charge of. iwlmei maintains the communication with the CSME
> > > firmware's WLAN driver. The language / protocol that is used
> > > between the CSME's firmware WLAN driver and iwlmei is OS agnostic
> > > and is called SAP which stands for Software Abritration Protocol.
> > > With SAP, iwlmei will be able to tell the CSME firmware's WLAN
> > > driver:
> > > 1) Please give me the device.
> > > 2) Please note that the SW/HW rfkill state change.
> > > 3) Please note that I am now associated to X.
> > > 4) Please note that I received this packet.
> > > etc...
> > >
> > > There are messages that go the opposite direction as well:
> > > 1) Please note that AMT is en/disable.
> > > 2) Please note that I believe the OS is broken and hence I'll take
> > >    the device *now*, whether you like it or not, to make sure that
> > >    connectivity is preserved.
> > > 3) Please note that I am willing to give the device if the OS
> > >    needs it.
> > > 4) Please give me any packet that is sent on UDP / TCP on IP address
> > >    XX.XX.XX.XX and an port ZZ.
> > > 5) Please send this packet.
> > > etc...
> > >
> > > Please check drivers/net/wireless/intel/iwlwifi/mei/sap.h for the
> > > full protocol specification.
> > >
> > > Arbitration is not the only purpose of iwlmei and SAP. SAP also
> > > allows to maintain the AMT's functionality even when the OS owns
> > > the device. To connect to AMT, one needs to initiate an HTTP
> > > connection to port 16992. iwlmei will listen to the Rx path and
> > > forward (through SAP) to the CSME firmware the data it got. Then,
> > > the embedded HTTP server in the chipset will reply to the request
> > > and send a SAP notification to ask iwlmei to send the reply.
> > > This way, AMT running on the CSME can still work.
> > >
> > > In practice this means that all the use cases quoted above (KVM,
> > > remote IDE device, etc...) will work even when the OS uses the
> > > WLAN device.
> > >
> > > How to disable all this?
> > > ---------------------------
> > > iwlmei won't be able to do anything if the CSME's networking stack
> > > is not enabled. By default, CSME's networking stack is disabled (this
> > > is a BIOS setting).
> > > In case the CSME's networking stack is disabled, iwlwifi will just
> > > get access to the device because there is no contention with any other
> > > actor and, hence, no arbitration is needed.
> > >
> > > In this patch, I only add the iwlmei driver. Integration with
> > > iwlwifi will be implemented in the next one.
> > >
> > > Co-Developed-by: Ayala Beker <ayala.beker@intel.com>
> > > Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> >
> > s-o-b missing from Ayala, same problem also in other patches in this
> > patchset.
> >
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
> >
>
> I fixed all the comments and pushed to a branch in our tree to get a
> 0-day run on it.
> One question though: there is currently a (small) diff between
> iwlwifi-next and wireless-driver-next that makes this series conflict.
> This is because of a fix that was applied on wireless-drivers-next
> directly and Luca hasn't merged your tree back to his yet.
> I can send v7 on either code base you like.
> I think 0-day tests iwlwifi patches against iwlwifi-next but I am not sure.
> Luca is on vacation until next week.
>
> Any option you'll choose will be fine by me. Just let me know.

The build was successful and I tested the changes, they work.
Did you plan to apply this before the merge window?
If yes, I'll rebase on top of your -next tree and send v7.
