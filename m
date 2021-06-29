Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9BA3B7309
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Jun 2021 15:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhF2NRc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Jun 2021 09:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbhF2NRc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Jun 2021 09:17:32 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF89C061760
        for <linux-wireless@vger.kernel.org>; Tue, 29 Jun 2021 06:15:04 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id s72so4744089vkb.8
        for <linux-wireless@vger.kernel.org>; Tue, 29 Jun 2021 06:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gMItzUaxhe6fdttuo4IyGPs0+qWXqPORLlw9PPcbKD4=;
        b=nq2ObkS/7TM/4+Hbv46d6tO4eJBu/6psprzTNtEL34FRvylmaMS3dDzFM6AxBsL7KR
         Nl2sBJNQYbAaqUJThEMWvvBWG4l9T4s0FpGsl7oVfQYrLhhIwGJckGRJZEG1vyd8xtm/
         3ZGN/jMev26iRC7Xxh+lLaV+2uKNe23uCnZA5rD4QurJ9K8xrE/8C7gFKgxYyq5rfFas
         p4mPZZrVL/PLZUffOKKynePl4kRS9Eg6J0ajXv3zsIUoRAzhhE0NcZk3nVzHPAZexL9w
         HOEVKKYn3DCZj7t7lAR1d+OHyxZJYGd2zLpmqdhmCCo3lAhaWPKbSJdfeDgT6meHC7gX
         b6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gMItzUaxhe6fdttuo4IyGPs0+qWXqPORLlw9PPcbKD4=;
        b=LoKiwgCtwehW8tPEJkSszT0cBSQ954nckvgXJpzNUGIS+EAYVM8MDipEjHPcqaXZom
         t/vFKRKAMXnjKA3mI1H0CKRUne5CED0Jd5kdSccNHmRfcYgwSoyCGuwxg7yZkICXWetR
         0ay9vToFMz2xO8M703c+BIC6wcKffl9lINUO+lFSVaLWrQ561sLPJSnriGJy7lzjCkvE
         O2rdxqi3WFsD3VdSI8MWRjqwuB2eWWxF/CjKrJJHxezhnT37utSQq8zuIzV8IAa70fgd
         8QcCxlY38HsPdIREVhWBMK/L/CKrbcRPYiWI11LBR8gmyNUxYtJgjGh82eCZ8tHfQdd2
         sVaw==
X-Gm-Message-State: AOAM531+ey66vHDHXk6tP01TpXbtrzwPCPRxKE8w8vPUyyNgpgwOyU31
        xvzxJ+fujqzXyhsohdAxCfwMhfpONAAPuXLxJI4=
X-Google-Smtp-Source: ABdhPJzA09jp2CZMB4GG/AkyLuh3oprHY1SFTHmW007c6ZZirOIufL7m+P5yWylMpdQz640bceN58GQzHUO2RmPivPU=
X-Received: by 2002:a1f:a482:: with SMTP id n124mr8456168vke.15.1624972502160;
 Tue, 29 Jun 2021 06:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210625081717.7680-1-emmanuel.grumbach@intel.com>
In-Reply-To: <20210625081717.7680-1-emmanuel.grumbach@intel.com>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Tue, 29 Jun 2021 16:14:51 +0300
Message-ID: <CANUX_P2sw2bzhUrUC_QTZY1+YA+EyoZn3QeoQvv6=e3L4WHvuw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] iwlwifi: mei: add the driver to allow cooperation
 with CSME
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     "Coelho, Luciano" <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ayala Beker <ayala.beker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

>
> CSME in two words
> -----------------
> CSME stands for Converged Security and Management Engine. It is
> a CPU on the chipset and runs a dedicated firmware.
> AMT (Active Management Technology) is one of the applications
> that run on that CPU. AMT allows to control the platform remotely.
> Here is a partial list of the use cases:
> * View the screen of the plaform, with keyboard and mouse (KVM)
> * Attach a remote IDE device
> * Have a serial console to the device
> * Query the state of the platform
> * Reset / shut down / boot the platform
>
> Networking in CSME
> ------------------
> For those uses cases, CSME's firmware has an embedded network
> stack and is able to use the network devices of the system: LAN
> and WLAN. This is thanks to the CSME's firmware WLAN driver.
>
> One can add a profile (SSID / key / certificate) to the CSME's OS
> and CSME will connect to that profile. Then, one can use the WLAN
> link to access the applications that run on CSME (AMT is one of
> them). Note that CSME is active during power state and power state
> transitions. For example, it is possible to have a KVM session
> open to the system while the system is rebooting and actually
> configure the BIOS remotely over WLAN thanks to AMT.
>
> How all this is related to Linux
> --------------------------------
> In Linux, there is a driver that allows the OS to talk to the
> CSME firmware, this driver is drivers/misc/mei. This driver
> advertises a bus that allows other kernel drivers or even user
> space) to talk to components inside the CSME firmware.
> In practice, the system advertises a PCI device that allows
> to send / receive data to / from the CSME firmware. The mei
> bus drivers in drivers/misc/mei is an abstration on top of
> this PCI device.
> The driver being added here is called iwlmei and talks to the
> WLAN driver inside the CSME firmware through the mei bus driver.
> Note that the mei bus driver only gives bus services, it doesn't
> define the content of the communication.
>
> Why do we need this driver?
> --------------------------
> CSME uses the same WLAN device that the OS is expecting to see
> hence we need an arbitration mechanism. This is what iwlmei is
> in charge of. iwlmei maintains the communication with the CSME
> firmware's WLAN driver. The language / protocol that is used
> between the CSME's firmware WLAN driver and iwlmei is OS agnostic
> and is called SAP which stands for Software Abritration Protocol.
> With SAP, iwlmei will be able to tell the CSME firmware's WLAN
> driver:
> 1) Please give me the device.
> 2) Please note that the SW/HW rfkill state change.
> 3) Please note that I am now associated to X.
> 4) Please note that I received this packet.
> etc...
>
> There are messages that go the opposite direction as well:
> 1) Please note that AMT is en/disable.
> 2) Please note that I believe the OS is broken and hence I'll take
>    the device *now*, whether you like it or not, to make sure that
>    connectivity is preserved.
> 3) Please note that I am willing to give the device if the OS
>    needs it.
> 4) Please give me any packet that is sent on UDP / TCP on IP address
>    XX.XX.XX.XX and an port ZZ.
> 5) Please send this packet.
> etc...
>
> Please check drivers/net/wireless/intel/iwlwifi/mei/sap.h for the
> full protocol specification.
>
> Arbitration is not the only purpose of iwlmei and SAP. SAP also
> allows to maintain the AMT's functionality even when the OS owns
> the device. To connect to AMT, one needs to initiate an HTTP
> connection to port 16992. iwlmei will listen to the Rx path and
> forward (through SAP) to the CSME firmware the data it got. Then,
> the embedded HTTP server in the chipset will reply to the request
> and send a SAP notification to ask iwlmei to send the reply.
> This way, AMT running on the CSME can still work.
>
> In practice this means that all the use cases quoted above (KVM,
> remote IDE device, etc...) will work even when the OS uses the
> WLAN device.
>
> How to disable all this?
> ---------------------------
> iwlmei won't be able to do anything if the CSME's networking stack
> is not enabled. By default, CSME's networking stack is disabled (this
> is a BIOS setting).
> In case the CSME's networking stack is disabled, iwlwifi will just
> get access to the device because there is no contention with any other
> actor and, hence, no arbitration is needed.
>
> In this patch, I only add the iwlmei driver. Integration with
> iwlwifi will be implemented in the next one.
>
> Co-Developed-by: Ayala Beker <ayala.beker@intel.com>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> ---
> v2: fix a few warnings raised by the different bots
> v3: rewrite the commit message
> v4: put the debugfs content in a different patch
> ---

I think I did all you wanted, I can understand if this series doesn't
get merged for 5.14, but I really would like to make sure that we are
ready to apply this after the merge window.
If you're happy with this, great. If not, let me know so that I can
fix what you want to see fixed.
FYI - there is also the patch for mei that I don't send for review
because it's already ACK'ed by Greg, and there is another patch that I
haven't sent yet because it relies on a cfg80211 patch that is now in
net-next: 358ae88881adc3ac1544104272eb7e9408f80b39
If you merge net-next, I'll be able to rebase and send this one as well.

Thanks.
