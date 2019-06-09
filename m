Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB5F3A5EA
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2019 15:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbfFIN3G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Jun 2019 09:29:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52714 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfFIN3G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Jun 2019 09:29:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so6083657wms.2
        for <linux-wireless@vger.kernel.org>; Sun, 09 Jun 2019 06:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NNU5NfcRwFmjSQDPSqcnbF989yjW4THtyaQsaHDsW3M=;
        b=mBHXJW4smXmT+jI8QIXE/LE2AQ50/owrxp2Mo6KfvXeoxHADAu1U0uOpDXZcpSEyJX
         ArPdKZNJo/zaNR4ai8hDeKPMOBMBBFDkV1r0/FRgO7LQmJTVVGlqOLEJDOSj9tDh/1tE
         oSw4QqVRG6D8SrdHlJCzUztQKDunii1spuclSEYGFvPjMY14MaWPc0TG+H61QU2YrtN8
         /Vqk9AgU5YpYDCOdcQ4haDwZ2Vz+ZXGltaHP4fMKwiPNf+IvbIRTPnNf5CZXcLEF0Wzv
         n53AW+ceTRi7JKc+veyj5oCDt/aiscK/RqgJcjDYhQFi8Ywo4fLm8KMlNBAyVCStJkfR
         ed4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NNU5NfcRwFmjSQDPSqcnbF989yjW4THtyaQsaHDsW3M=;
        b=tSgWI179xNhQ3ZhI1NWyTcCAplVNMf/WrfwuwRlw4AEmZctft63bmsVxm2IUnUPulb
         +S+a7mTfPUbvlDoxW5HbvWi9nouX2U+Tx0MpMTFiDGZ5UhZVguVgADH5do+HQgBjTL5q
         Zut+yNrYA0gc27CF5NC+5bY8gfJ07X52MRzedhfsQ03bxCSzPSJXEol1xHtyRxUwQvpG
         QQsvUq/792l6Z7Fagn8FrYpsCVFI9cRBFLp3DVUsZv153iLKk0ftLuFzina2f2cqUKd7
         RsL0bDJb2uS7Wcc55CleL/0B8JmlDAUq1Nq6X5Khyuwz0Os6//BVRGN/BXizD9gRR4Bd
         y7GA==
X-Gm-Message-State: APjAAAUTd9ePnQVqiSWY51fmE4TBH7O1185u78eWQHJaLdL6/MbCshMX
        sEFyyIGiQlJGIysy/+D+TKQd7a0sgJK73khQWwM=
X-Google-Smtp-Source: APXvYqzSa36hyn8dwtJbjaEHN0vwBZJy+JcCSvPZ69xVk9mOMezrt4o0Ajjt50s+FWiu9Qu2Xawh0L3Lx/NVApVYMEs=
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr9707840wma.107.1560086944218;
 Sun, 09 Jun 2019 06:29:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190608144947.744-1-chunkeey@gmail.com> <20190608144947.744-2-chunkeey@gmail.com>
In-Reply-To: <20190608144947.744-2-chunkeey@gmail.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Sun, 9 Jun 2019 23:28:53 +1000
Message-ID: <CAGRGNgXNQK_cHL1pcjyjc-7h+a49zXtTjcv48EDatHSdaSc+2w@mail.gmail.com>
Subject: Re: [RFC PATCH v2] ath9k: add loader for AR92XX (and older) pci(e)
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

On Sun, Jun 9, 2019 at 12:49 AM Christian Lamparter <chunkeey@gmail.com> wrote:
>
> Atheros cards with a AR92XX generation (and older) chip usually
> store their pci(e) initialization vectors on an external eeprom chip.
> However these chips technically don't need the eeprom chip attached,
> the AR9280 Datasheet in section "6.1.2 DEVICE_ID" describes that
> "... if the EEPROM content is not valid, a value of 0XFF1C returns
> when read from the register". So the embedded devices like routers
> and accesspoint usually have the pci(e) initialization vectors
> stored on the system's FLASH, which is out of reach of the ath9k
> chip.
>
> Furthermore, Some devices (like the Cisco Meraki Z1 Cloud Managed
> Teleworker Gateway) need to be able to initialize the PCIe wifi device.
> Normally, this should be done as a pci quirk during the early stages of
> booting linux. However, this isn't possible for devices which have the
> init code for the Atheros chip stored on NAND in an UBI volume.
> Hence, this module can be used to initialize the chip when the
> user-space is ready to extract the init code.
>
> Martin Blumenstingl prodived the following fixes:
> owl-loader: add support for OWL emulation PCI devices
> owl-loader: don't re-scan the bus when ath9k_pci_fixup failed
> owl-loader: use dev_* instead of pr_* logging functions
> owl-loader: auto-generate the eeprom filename as fallback
> owl-loader: add a debug message when swapping the eeprom data
> owl-loader: add missing newlines in log messages
>
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> v2: address Julian Calaby's comments:
>     - make it a separate driver again (much like OpenWrt)
>     - remove ar71xx leftovers (pdata)

This looks sane to me. Thanks for splitting it out.

Reviewed-by: Julian Calaby <julian.calaby@gmail.com>

> ---
>  drivers/net/wireless/ath/ath9k/Kconfig        |  16 ++
>  drivers/net/wireless/ath/ath9k/Makefile       |   2 +
>  .../wireless/ath/ath9k/ath9k_pci_owl_loader.c | 215 ++++++++++++++++++
>  3 files changed, 233 insertions(+)
>  create mode 100644 drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
>
> diff --git a/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
> new file mode 100644
> index 000000000000..7ed495a9f1fe
> --- /dev/null
> +++ b/drivers/net/wireless/ath/ath9k/ath9k_pci_owl_loader.c
> @@ -0,0 +1,215 @@
> +module_pci_driver(owl_driver);
> +MODULE_AUTHOR("Christian Lamparter <chunkeey@gmail.com>");
> +MODULE_DESCRIPTION("Initializes Atheros' Owl Emulation devices");

Tiniest nit: something like "External EEPROM data loader for Atheros
AR500X to AR92XX" would make more sense to someone who isn't familiar
with the hardware.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
