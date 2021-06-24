Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098033B378D
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 22:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhFXUH3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 16:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbhFXUH2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 16:07:28 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D5DC061574
        for <linux-wireless@vger.kernel.org>; Thu, 24 Jun 2021 13:05:08 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id 68so4168380vsu.6
        for <linux-wireless@vger.kernel.org>; Thu, 24 Jun 2021 13:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2NfpVQgKPmAbmOc4HtttemGX30jb3rSKXp4kqtJyhWY=;
        b=YIZfXtguUjk5a/F8ZKvMzsoVxoHzhswAPqVXhnwS/WgzihF5Qc5cQ+Q9I385tt//mf
         sg1aVXZCOExKc16cxVH7dU1tKQwg0qRj9BPeqijE3HmMMawHABnh3UQkGZHNFDz6DZKk
         W1qp82ulZux1K+zufkHDhinBPXLzfaLcknanyAUxqY6r6E79G4XdgsN+Ir8+EacEcImR
         MV3mclpSrYAsvnY03rdiE7DPXvaSkr/MpzMdbJ3yaXYAoMBRItt4ODkE/hYQp41XFsqi
         gbkLf7r8eyZEPFXi1GqvvfzITXA9KocNhXpBoCrg0tz4j7cdHVWxFJybdRmvxzqQzMlS
         JukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2NfpVQgKPmAbmOc4HtttemGX30jb3rSKXp4kqtJyhWY=;
        b=PIMEtYBp330FOqLddzkYLWkTBPq1UwuKySzNKv0sBNwr0mm39eHdEkGNlPtxIgc/QH
         jCDB3ZJXLhx/ZCp/mBYas3jkG1y0IBbcLDxs+VxQ7CDytfrZZHU6Qs+TjFOavFo3wc8g
         Yi9XonljG2rKTrPmLF/QtfyQWOwgXxn/OyQl+BI5Jzo1EdffFE+nQ3Mk+/8IQnpx2Xv7
         JNZiVGtQPy596ppftog8dvExnPiPQHiAXXdoPb+iVWu3w/sZYl5OSIRJwhaaRllTPqAB
         aT0eWDA8LxZeInqVMD+xLzOUE/dVsBgLMRetCvtGu2waU9Wtvk3y3Zaf6G1XAkBW7T5E
         Esyw==
X-Gm-Message-State: AOAM532SwAZYG3OXR4m00uJiabHq4W8Wy9bG7RNASOISI5kI6BCaYava
        yZSyevIJ2WTR5ShVzQyS8zcIEKjRcyNWnX3qjas=
X-Google-Smtp-Source: ABdhPJxAfQXEZ9o8NeG9MpdCrhtaK0SacGliKEVYbqWCobgRh3rOrN9FjOA4pxPQVVdbwUhFwyBpx04hmMB4qv40c24=
X-Received: by 2002:a67:ee84:: with SMTP id n4mr5481416vsp.24.1624565107892;
 Thu, 24 Jun 2021 13:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210623141033.27475-1-emmanuel.grumbach@intel.com> <87bl7vi3o1.fsf@codeaurora.org>
In-Reply-To: <87bl7vi3o1.fsf@codeaurora.org>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Thu, 24 Jun 2021 23:04:56 +0300
Message-ID: <CANUX_P3QE9xNnQLT=mHNDp4VCv37Bcjuvn9O1wQ4Btejjkbrvg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] iwlwifi: mei: add the driver to allow cooperation
 with CSME
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ayala Beker <ayala.beker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Jun 24, 2021 at 8:18 PM Kalle Valo <kvalo@codeaurora.org> wrote:
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
> > Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> > ---
> > v2: fix a few warnings raised by the different bots
> > v3: rewrite the commit message
>
> Thank you for the great commit log, now I understand what this is about.
> I'm not able to do thorough review but my first quick comments.

Glad it helped.

>
>
> [...]
>
> > +     BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_OPEN !=
> > +                  (u32)SAP_WIFI_AUTH_TYPE_OPEN);
> > +     BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_RSNA !=
> > +                  (u32)SAP_WIFI_AUTH_TYPE_RSNA);
> > +     BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_RSNA_PSK !=
> > +                  (u32)SAP_WIFI_AUTH_TYPE_RSNA_PSK);
> > +     BUILD_BUG_ON((u32)IWL_MEI_AKM_AUTH_SAE !=
> > +                  (u32)SAP_WIFI_AUTH_TYPE_SAE);
> > +
> > +     BUILD_BUG_ON((u32)IWL_MEI_CIPHER_NONE !=
> > +                  (u32)SAP_WIFI_CIPHER_ALG_NONE);
> > +     BUILD_BUG_ON((u32)IWL_MEI_CIPHER_CCMP !=
> > +                  (u32)SAP_WIFI_CIPHER_ALG_CCMP);
> > +     BUILD_BUG_ON((u32)IWL_MEI_CIPHER_GCMP !=
> > +                  (u32)SAP_WIFI_CIPHER_ALG_GCMP);
> > +     BUILD_BUG_ON((u32)IWL_MEI_CIPHER_GCMP_256 !=
> > +                  (u32)SAP_WIFI_CIPHER_ALG_GCMP_256);
>
> These look just weird, and suspicious. You are using two different enums
> but they have to be same values, or what?

Exactly. I don't want the userspace to have to include all the SAP
protocol header file. OTOH, I don't want to have to translate between
vendor commands attributes values and the SAP values. So I want them
to be exactly the same. Note that the SAP values are not contiguous:
enum iwl_sap_wifi_cipher_alg {
        SAP_WIFI_CIPHER_ALG_NONE        = 0,
        SAP_WIFI_CIPHER_ALG_CCMP        = 4,
        SAP_WIFI_CIPHER_ALG_GCMP        = 8,
        SAP_WIFI_CIPHER_ALG_GCMP_256    = 9,
};

Hint, hint, there are ciphers that we don't want to support, like...
WEP, TKIP and alike. There are also values here that are really
surprising, but I didn't write the API... It is the CSME firmware's.
Making sure that the vendor commands attributes values and the SAP
values are the same here allows me to externalize only the vendor
command attribute enumeratoin to the userspace and be safe that we
won't need to translate any value before sending those through SAP.

>
> > +static void iwl_mei_dbgfs_register(struct iwl_mei *mei)
> > +{
> > +     mei->dbgfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
> > +
> > +     if (!mei->dbgfs_dir)
> > +             return;
> > +
> > +     init_waitqueue_head(&mei->debugfs_wq);
> > +
> > +     debugfs_create_ulong("status", S_IRUSR,
> > +                          mei->dbgfs_dir, &iwl_mei_status);
> > +     debugfs_create_file("send_start_message", S_IWUSR, mei->dbgfs_dir,
> > +                         mei, &iwl_mei_dbgfs_send_start_message_ops);
> > +     debugfs_create_file("req_ownserhip", S_IWUSR, mei->dbgfs_dir,
> > +                         mei, &iwl_mei_dbgfs_req_ownership_ops);
> > +}
>
> The commit log mentions nothing about debugfs interface. I recommend
> moving them to a separate patch for easier review and explaining what
> these do.

Doable I guess.
Next week.
