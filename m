Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB347432762
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 21:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhJRTTp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 15:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhJRTTp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 15:19:45 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F78EC06161C
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 12:17:33 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id r17so3448858uaf.8
        for <linux-wireless@vger.kernel.org>; Mon, 18 Oct 2021 12:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T/RSixTz+/RerBxKYGwrAm/L5qHkd/rSEBMpEbBiXRk=;
        b=cipeCcJQRwYI3oXbj6uqHZNJJFHFgdRDnCVLrDnRQHFeEB2IYVqbdykxitJ6biXmtB
         yvykrLDLBmLDiZ2cScbmYsjXGP5jHPNCEOn8SDlnc29z9lt8Wh75zsWakGz9V5dovEf8
         /atP6j1NTmALXTu6BGGgGWNKvcMyGOigJKQ1SSd8LVHrx5UB1q7j5KV+kCytpveRnZJZ
         NEVyEviJPOwVrcMDXl+L1YNfW91FdUzb8wd5fbYGJYGLiC7YTcCxfApaqooAT8J5LOIf
         t8gwKxWdIt0//oMEFpWsdcoJMHlvkpODX7q9wDaMsgCxL01oGiqk/XwNowqco09jF/A/
         YOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T/RSixTz+/RerBxKYGwrAm/L5qHkd/rSEBMpEbBiXRk=;
        b=MnMY3BA4/HU4rW8Iq/oT0P4XYCEAWdsRVkmJFv5MoE8TiTxOeWFs3vu6vqKxNE73uP
         3ociSS0b07GbP1qQe8S6AdlU8aoBl9D8l4hEjbTtjEVW5/4pQu9DO65Ty1uXumRF7hQl
         CZXQfkeRLau74wmE+3qUC633lWdo/D9S6Vj7lMNL5Q8F779CLQWEyYzOOE/1fNBdTNSe
         NWtwdsCNc7K8tuWv/4g2BqBN6q0mv4RyDhZTjCUINPLm2R3bpQSRTiXIfgA3i4AJgFDN
         mHL6DBDgNT44DqSlTy7iUItDIoEh1+mQktbdi2V2POaEbl3dWtA+xrhpe/ttWSpjDa4N
         yFAQ==
X-Gm-Message-State: AOAM530UPr7xAuq1I8zSbNgnK+9SxzPsYQ29GWPuXsM6KZ1+wZefuZMi
        6HGcKeCNpHv8fnbe6yYqJENUDgDzySlYanKGtpJ4/OWL
X-Google-Smtp-Source: ABdhPJzPTOmR0SRp95KM3TO/gywlIhp3wZtPLie74fZp/NM9RUWQvP769PPGsxPSp0fZwRlLn5yCyzs4Dw/J9kCsagM=
X-Received: by 2002:a05:6102:c0f:: with SMTP id x15mr30483821vss.57.1634584652361;
 Mon, 18 Oct 2021 12:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210811105541.43426-1-emmanuel.grumbach@intel.com>
 <20210811105541.43426-2-emmanuel.grumbach@intel.com> <87lf2qvbg2.fsf@codeaurora.org>
In-Reply-To: <87lf2qvbg2.fsf@codeaurora.org>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Mon, 18 Oct 2021 22:17:21 +0300
Message-ID: <CANUX_P3F_fJK1wWRJPw+9SFeB0dfP0rUOA_gSPruuSnrtzmQ_g@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] iwlwifi: mei: add the driver to allow cooperation
 with CSME
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Oct 18, 2021 at 2:08 PM Kalle Valo <kvalo@codeaurora.org> wrote:
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
> >
> > Networking in CSME
> > ------------------
> > For those uses cases, CSME's firmware has an embedded network
> > stack and is able to use the network devices of the system: LAN
> > and WLAN. This is thanks to the CSME's firmware WLAN driver.
> >
> > One can add a profile (SSID / key / certificate) to the CSME's OS
> > and CSME will connect to that profile. Then, one can use the WLAN
> > link to access the applications that run on CSME (AMT is one of
> > them). Note that CSME is active during power state and power state
> > transitions. For example, it is possible to have a KVM session
> > open to the system while the system is rebooting and actually
> > configure the BIOS remotely over WLAN thanks to AMT.
> >
> > How all this is related to Linux
> > --------------------------------
> > In Linux, there is a driver that allows the OS to talk to the
> > CSME firmware, this driver is drivers/misc/mei. This driver
> > advertises a bus that allows other kernel drivers or even user
> > space) to talk to components inside the CSME firmware.
> > In practice, the system advertises a PCI device that allows
> > to send / receive data to / from the CSME firmware. The mei
> > bus drivers in drivers/misc/mei is an abstration on top of
> > this PCI device.
> > The driver being added here is called iwlmei and talks to the
> > WLAN driver inside the CSME firmware through the mei bus driver.
> > Note that the mei bus driver only gives bus services, it doesn't
> > define the content of the communication.
> >
> > Why do we need this driver?
> > --------------------------
> > CSME uses the same WLAN device that the OS is expecting to see
> > hence we need an arbitration mechanism. This is what iwlmei is
> > in charge of. iwlmei maintains the communication with the CSME
> > firmware's WLAN driver. The language / protocol that is used
> > between the CSME's firmware WLAN driver and iwlmei is OS agnostic
> > and is called SAP which stands for Software Abritration Protocol.
> > With SAP, iwlmei will be able to tell the CSME firmware's WLAN
> > driver:
> > 1) Please give me the device.
> > 2) Please note that the SW/HW rfkill state change.
> > 3) Please note that I am now associated to X.
> > 4) Please note that I received this packet.
> > etc...
> >
> > There are messages that go the opposite direction as well:
> > 1) Please note that AMT is en/disable.
> > 2) Please note that I believe the OS is broken and hence I'll take
> >    the device *now*, whether you like it or not, to make sure that
> >    connectivity is preserved.
> > 3) Please note that I am willing to give the device if the OS
> >    needs it.
> > 4) Please give me any packet that is sent on UDP / TCP on IP address
> >    XX.XX.XX.XX and an port ZZ.
> > 5) Please send this packet.
> > etc...
> >
> > Please check drivers/net/wireless/intel/iwlwifi/mei/sap.h for the
> > full protocol specification.
> >
> > Arbitration is not the only purpose of iwlmei and SAP. SAP also
> > allows to maintain the AMT's functionality even when the OS owns
> > the device. To connect to AMT, one needs to initiate an HTTP
> > connection to port 16992. iwlmei will listen to the Rx path and
> > forward (through SAP) to the CSME firmware the data it got. Then,
> > the embedded HTTP server in the chipset will reply to the request
> > and send a SAP notification to ask iwlmei to send the reply.
> > This way, AMT running on the CSME can still work.
> >
> > In practice this means that all the use cases quoted above (KVM,
> > remote IDE device, etc...) will work even when the OS uses the
> > WLAN device.
> >
> > How to disable all this?
> > ---------------------------
> > iwlmei won't be able to do anything if the CSME's networking stack
> > is not enabled. By default, CSME's networking stack is disabled (this
> > is a BIOS setting).
> > In case the CSME's networking stack is disabled, iwlwifi will just
> > get access to the device because there is no contention with any other
> > actor and, hence, no arbitration is needed.
> >
> > In this patch, I only add the iwlmei driver. Integration with
> > iwlwifi will be implemented in the next one.
> >
> > Co-Developed-by: Ayala Beker <ayala.beker@intel.com>
> > Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
>
> s-o-b missing from Ayala, same problem also in other patches in this
> patchset.
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
>

I fixed all the comments and pushed to a branch in our tree to get a
0-day run on it.
One question though: there is currently a (small) diff between
iwlwifi-next and wireless-driver-next that makes this series conflict.
This is because of a fix that was applied on wireless-drivers-next
directly and Luca hasn't merged your tree back to his yet.
I can send v7 on either code base you like.
I think 0-day tests iwlwifi patches against iwlwifi-next but I am not sure.
Luca is on vacation until next week.

Any option you'll choose will be fine by me. Just let me know.
