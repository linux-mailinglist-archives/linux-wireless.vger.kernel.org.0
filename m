Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 626225A9A4
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jun 2019 10:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfF2IoK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jun 2019 04:44:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46827 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfF2IoJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jun 2019 04:44:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so8531752wrw.13
        for <linux-wireless@vger.kernel.org>; Sat, 29 Jun 2019 01:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VCY4/4tYQUoypuMnZS7bCWz03LqY4M06mNp/tJCwENk=;
        b=bkjKokWFZ+8IagfMF+ZYbv2ym4YZ6y5L1H1d9rZbN7S5nX1bmv5H9orzNPgk/ROwzf
         GLkIoJmf4lkuFpJnSlCFw5Ws5C9ylU8Ny6dzocOfSGvdWuGfOETRXm9m0Vmsaif9vni9
         gMwTjCXOPCGSLAd+sKzTEH3B7lYHdZ2sA1z6BE/1GBX/pBdaeQhOwMhmEEOi7mTKqerv
         WAXWMPWw8eOHrYsJ1oYBr/kud1Sfmjnzyp352voXnKSlRYA620SKIi1V3qzLseijdC71
         Oxf7pjvERmO4s78XBZ0gtWuHsKiaJexfZ2lG8UHiqp2EZl9VpkLKsPhV5Rm6jpjI/flI
         ynhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VCY4/4tYQUoypuMnZS7bCWz03LqY4M06mNp/tJCwENk=;
        b=g8oT/L6KmU2tAFwuwgE4ENNuS4NbPPzvucE57Ub3jQrAm/FgZHJ1lGjEaJSfVaO8Q2
         WOF7Sva/YWqPbYCuE3tHhgnFPO9dt7F6JOGwAiKUsKRpVUvKKZX6BfaPpWWHmVE4gD/i
         vf9Weg1NBjZaZ4CDnthTLXSwpXllqZsKlwcfW4I3bLNQa/ExJAWbYP3PnHWgyn48hMrh
         N6ZqihA0KGPvuCk9ThKawZpeHm1Y11nB5xxiKC3IUTM5BZk/brCH3hAJCR5oxxb9Hd0V
         rnllgvk/s36qKYz8H/tUxZ+pOPEpYUpBHnLfNhEOjfz3u7Atp6WrkKO35jsEuKNpiSiy
         geTQ==
X-Gm-Message-State: APjAAAWGvSIasg/iP7+AqYl3yB47dyoHgnFIiJ2eE2f7/OfyWjaLdmdx
        aPZ6A7Rlunnn3VZvFDVKIXU=
X-Google-Smtp-Source: APXvYqwOxJC8HP9ym8cJ7bjEFKDNyCBNFllrCgcfpYapbKGZrnJ79zGnH1Mi3SbICHGuQcLU7tJ9Mg==
X-Received: by 2002:a5d:6089:: with SMTP id w9mr1047146wrt.166.1561797846669;
        Sat, 29 Jun 2019 01:44:06 -0700 (PDT)
Received: from debian64.daheim (p5B0D715E.dip0.t-ipconnect.de. [91.13.113.94])
        by smtp.gmail.com with ESMTPSA id n2sm1263595wmi.38.2019.06.29.01.44.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 01:44:05 -0700 (PDT)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
        by debian64.daheim with esmtp (Exim 4.92)
        (envelope-from <chunkeey@gmail.com>)
        id 1hh8xp-00022p-2j; Sat, 29 Jun 2019 10:44:05 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        martin.blumenstingl@googlemail.com, chrisrblake93@gmail.com,
        jonas.gorski@gmail.com
Cc:     linux-wireless@vger.kernel.org,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Julian Calaby <julian.calaby@gmail.com>, dev@kresin.me,
        juhosg@openwrt.org, john@phrozen.org, hauke@hauke-m.de,
        jow@openwrt.org
Subject: Re: [PATCH v3] ath9k: add loader for AR92XX (and older) pci(e)
Date:   Sat, 29 Jun 2019 10:44:04 +0200
Message-ID: <2176615.mE3b70Bg5n@debian64>
In-Reply-To: <87tvcasxpg.fsf@purkki.adurom.net>
References: <20190609203621.13015-1-chunkeey@gmail.com> <87tvcasxpg.fsf@purkki.adurom.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

(Sorry for the delay. I only have time for dealing with this
on the weekends. Thanks!)

On Thursday, June 27, 2019 8:13:47 PM CEST Kalle Valo wrote:
> Christian Lamparter <chunkeey@gmail.com> writes:
> > Atheros cards with a AR92XX generation (and older) chip usually
> > store their pci(e) initialization vectors on an external eeprom chip.
> > However these chips technically don't need the eeprom chip attached,
> > the AR9280 Datasheet in section "6.1.2 DEVICE_ID" describes that
> > "... if the EEPROM content is not valid, a value of 0xFF1C returns
> > when read from the register". So, they will show up on the system's
> > pci bus. However in that state, ath9k can't load, since it relies
> > on having the correct pci-id, otherwise it doesn't know what chip it
> > actually is. This happens on many embedded devices like routers
> > and accesspoint since they want to keep the BOM low and store the
> > pci(e) initialization vectors together with the calibration data
> > on the system's FLASH, which is out of reach of the ath9k chip.
> >
> > Furthermore, Some devices (like the Cisco Meraki Z1 Cloud Managed
> > Teleworker Gateway) need to be able to initialize the PCIe wifi device.
> > Normally, this should be done as a pci quirk during the early stages of
> > booting linux. However, this isn't possible for devices which have the
> > init code for the Atheros chip stored on NAND in an UBI volume.
> > Hence, this module can be used to initialize the chip when the
> > user-space is ready to extract the init code.
> >
> > Martin Blumenstingl prodived the following fixes:
> > owl-loader: add support for OWL emulation PCI devices
> > owl-loader: don't re-scan the bus when ath9k_pci_fixup failed
> > owl-loader: use dev_* instead of pr_* logging functions
> > owl-loader: auto-generate the eeprom filename as fallback
> > owl-loader: add a debug message when swapping the eeprom data
> > owl-loader: add missing newlines in log messages
> >
> > Reviewed-by: Julian Calaby <julian.calaby@gmail.com>
> > Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> [...]
> 
> > --- /dev/null
> > +++ b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
> > @@ -0,0 +1,215 @@
> > +// SPDX-License-Identifier: GPL-2.0
> 
> [...]
> 
> > +MODULE_LICENSE("GPL v2");
> 
> ath9k has ISC license, is there a specific reason why you chose GPLv2
> here instead of ISC? I don't like mixing licenses within a driver,
> that's why I'm asking.

About that: The commit message hints The owl-loader was written because
Chris Blake needed it for the Cisco Meraki Z1 (Atheros based SoC) because
the existing methods in the OpenWrt project were designed to work with
straight-from-SPI-NOR. OpenWrt already had multiple different versions for
each platform (ar71xx = Atheros SoCs, lantiq, brcm63xx) of the
pci-ath9k-fixup.c which are all licensed under GPLv2 and they predated
owl-loader initiative by about 8 years.

https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/ar71xx/files/arch/mips/ath79/pci-ath9k-fixup.c
(lantiq's version has been since replaced by the owl-loader)
https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/brcm63xx/patches-4.14/416-BCM63XX-add-a-fixup-for-ath9k-devices.patch

(ar71xx has been deprecated and will be dropped in favor of the upstream
DeviceTree ath79 which relies on the owl-loader exclusivly)

So this is were the license comes from: Existing code looks similar.
And while the owl-loader was written from scratch as it needed:
 - to get the via firmware_request to make it as universal as possible
 - be able to support all platforms (no fixed pci(e) addresses)
 - separate driver as a module (and not a pci fixup)
I went for the safer "GPLv2" as it is the standard OpenWrt License:
https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=LICENSE

That said: I have no problem relicensing my code under the ISC, if it
helps with the upstreaming process. I've added Chris, Martin and
Mathias as they both were consultants, as well as the previous
authors of three targets to "let them know".

Best Regards,
Christian

(Yeah, I think this might take a while longer. So please don't delete
it just yet.)


