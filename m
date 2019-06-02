Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4600432381
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jun 2019 16:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfFBOMG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jun 2019 10:12:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46246 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfFBOMF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jun 2019 10:12:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id e5so4174561pls.13
        for <linux-wireless@vger.kernel.org>; Sun, 02 Jun 2019 07:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QZRXFE1+uRrqvCBy0d9oZalKQzI9WInvtLiTT0qk4mk=;
        b=D9afwyTjYj2pbSUZSpPb96s0KT0v6R+oaKfH45LU0jZqfgzaFsUBPyZgh73m7iVGv9
         tH5kWs2Yilwp9IIn26R3qXpeKhOi4lLqLqiIR1xRcrJEDkX/WfaFEPJu+yuW1+OtzSA4
         OXW3rF3FZhFQps3Q6ShNqIxbSvMsS7XotCLQOEcXfllG1x0zUJfpXS0nHvtjx299pqZN
         cF3dNpRfVzv9TjbC4rWuauLFvxxyL7RtFQvIvUWGNg4RkFZM7sk22lni/+V2JqJ/WPrm
         tSNYPyP2QMw4yr7EhWlSSCFJOx/HZOtbptPFU6tet4b5V14EAQ+hSdMoBGgeKV9vaeth
         OFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZRXFE1+uRrqvCBy0d9oZalKQzI9WInvtLiTT0qk4mk=;
        b=ZIUOoht7ltJ0j2ks0lCW8oUdK2dvEhPcPxmEEmExAOcQu17QReN5c3AgzPocd6qRoL
         /krlf3+bvVKw0A0IrgWszfVTbOEKnpzOIyTHiFwXpSqClCuQBFnuu0sahr32l5OIayr5
         5eJQPs20JEL2sxrEP7GK0pSEdlOmH/zIn43XkI3lQ+4VdLeR2DZmreIpyhqfrU7xnHpN
         m3YG/o8PdKsD+okUO3KwBlmCIyQ/oegKNDBTksJEw8Wtj6ntpcTfEoVIVEwEQKSaM1l2
         e7+45DXK0i8trhUs1HesCAtfvHIf6oyEq2vwQQU+AN5tJTTUrlAxtHGBnohRMzU82GMT
         nitw==
X-Gm-Message-State: APjAAAUXP5UhpnMpnFj2cDTXYudZJ9a9XLsAaoB/FbtDObzxOwASy80f
        e/I53AkRlTaQMQjQgNBdZ2R+Y/+PKojTO02hlHk0ZTj0
X-Google-Smtp-Source: APXvYqwkwm1CTjG62dcB89sodXxExoYMjhmV+Hojd5dzk72XHzSwgwg9PTv1eBC9CSk7Zh2k2DauET5pYcQrUsZYm6s=
X-Received: by 2002:a17:902:7891:: with SMTP id q17mr23912578pll.236.1559484724583;
 Sun, 02 Jun 2019 07:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190602102144.17360-1-chunkeey@gmail.com> <CAGRGNgXqB=5oi1Nq4ZNSk3csOEr4A6WgN8QymKMriTcevnKUQw@mail.gmail.com>
 <2349614.IEgcWBM518@debian64>
In-Reply-To: <2349614.IEgcWBM518@debian64>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Mon, 3 Jun 2019 00:11:52 +1000
Message-ID: <CAGRGNgWCZX-62o9nSRVHdiADDbjrHP_RvyP7m-3JnFPpQDSF+w@mail.gmail.com>
Subject: Re: [RFC PATCH] ath9k: integrate AR92XX pci fixup code
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        linux-wireless@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Christian,

On Sun, Jun 2, 2019 at 11:14 PM Christian Lamparter <chunkeey@gmail.com> wrote:
>
> Hello Julian,
>
> On Sunday, June 2, 2019 1:43:52 PM CEST Julian Calaby wrote:
> > On Sun, Jun 2, 2019 at 8:24 PM Christian Lamparter <chunkeey@gmail.com> wrote:
> > >
> > > Some devices (like the Cisco Meraki Z1 Cloud Managed Teleworker Gateway)
> > > need to be able to initialize the PCIe wifi device. Normally, this is done
> > > during the early stages of booting linux, because the necessary init code
> > > is read from the memory mapped SPI and passed to pci_enable_ath9k_fixup.
> > > However, this isn't possible for devices which have the init code for the
> > > Atheros chip stored on NAND in an UBI volume. Hence, this module can be
> > > used to initialize the chip when the user-space is ready to extract the
> > > init code.
> > >
> > > Martin Blumenstingl prodived the following fixes:
> > > owl-loader: add support for OWL emulation PCI devices
> > > owl-loader: don't re-scan the bus when ath9k_pci_fixup failed
> > > owl-loader: use dev_* instead of pr_* logging functions
> > > owl-loader: auto-generate the eeprom filename as fallback
> > > owl-loader: add a debug message when swapping the eeprom data
> > > owl-loader: add missing newlines in log messages
> > >
> > > Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >
> > Two questions:
> >
> > 1. This seems complicated enough that the functions introduced should
> > probably go into a separate .c file, maybe "noeeprom.c", with a header
> > file with all the ifdef / config magic in it.
>
> In openwrt we called it owl-loader.c and it's a separate module there.
> But I don't think that noeeprom.c is that great since ath9k also supports
> AHB and htc_usb, so from this perspective it would mean:
> pci_init_noeeprom.c ? (As AR5008, AR9160 and AR92XX seem to be affected).

Fair enough, I hadn't thought of the other buses.

> > 2. This smells almost like a completely separate PCI(e) driver for
> > cards in a "weird" state.
> It's in the Datasheet that the device initializes into this state. See
> AR9280 6.1.2 DEVICE_ID. "... if the EEPROM content is not valid, a
> value of 0XFF1C returns when read from the register". This would also
> mean that this routine can be used to resurrect aging AR9280 cards
> that have a failed eeprom or are from APPLE, see this thread:
>
> <https://www.mail-archive.com/ath9k-devel@lists.ath9k.org/msg03918.html>
>
> "does anyone know whether 168c:ff1c can be supported by the current ath9k
> driver? It isn't listed with the PCI IDs in the source. I bought it off
> eBay as "Apple" AR5008. It is a PCI Express card with 3 Antenna
> connectors and lots of Apple stampings on it. lspci says:"

I'm asking because (I think) Ath3k Bluetooth devices initialise with
one device ID when they don't have firmware, then initialise with a
different one once they do. These two states are handled using
different drivers. This seems like almost identical behaviour and
looks like it could be handled the same way. The code here looks like
it's just using the common boilerplate pci device initialisation code
from ath9k before doing it's own completely separate thing including
having PCI driver data in a different format to the rest of the ath9k
driver.

> > Is there anything you're using from ath9k
> > other than the eeprom file naming? and is that really useful? Won't
> > the eeprom files be device specific and therefore could always use the
> > device name fallback?
> Please take a look at the commit message. Unfortunately the Z1 stores
> its calibration data in a ubi volume, these can't be easily read
> without interfacing with either ubi or the vfs. In the future, simpler
> devices that have it on SPI-NOR in a mtd partition can setup a nvmem
> provider and the code can have a nvmem-consumer. (see attached patch).

Fair enough, I was reading the code as-is, not looking forward to
other possibilities.

> Note: There are also devices with mutliple ath9k pci(e) chips
> (usually one 2.4Ghz and one 5GHz), so a generic "ath9k" name is too
> short and the pciids of both are the same. That's why the pci-bus
> location is currently used for the eeprom name identifier.

I've finally worked out what was bothering me about the code: you look
at the platform data expecting it to be in the ath9k_platform_data
structure, however as far as I can tell, the platform data is only
ever set by reading the eeprom, which doesn't happen when there isn't
one, therefore the eeprom name retrieval will always fall back to
dev_name(). I'm assuming that dev_name() returns something
sufficiently unique to identify multiple different cards in a system.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
