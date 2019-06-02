Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC8BF32329
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jun 2019 13:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfFBLoF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jun 2019 07:44:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41071 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbfFBLoF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jun 2019 07:44:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so8929101pfq.8
        for <linux-wireless@vger.kernel.org>; Sun, 02 Jun 2019 04:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZHFmU6uTiy07mtRHw1tHemTFmMEujbmzL3sESgruD9w=;
        b=DQhy5bIcF/FH7ReQ4cwZZhKhcsojgAVo1hRPoS9W2UxBbX4fpReLRstCUGamXCjxMd
         IDQhFQodM9LS9SV7IupvCk1Loq69L3A8H8cTFF3ErZvmo8ivhd3tBVOAv5sGilckKmZO
         5eTBIB1lcpsbK0JC5Niu9KWBNm8yqpEHlt2jsvggNNu38H5zyyTr5qvMsI9eVw1epckZ
         MBRDgtOMYJ5C4cXT4lcMzRwNcdurLxMGFayl9vV0Lohesh0IYVuD/UiyCZnJaP/rKkda
         QGzrwvGnGVi2LmPQxkn6Xwqb99L1zKixfmq2dVVpj6t0z/i6OHO1gyKvjH9vQUbg/P93
         UB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZHFmU6uTiy07mtRHw1tHemTFmMEujbmzL3sESgruD9w=;
        b=XHS1H9Jukc8WN26L090wtzbpN41FEus8rt/3Z3tmCUvCDVvmF+gNb5IJ1hKkhJScs/
         I2xActDpctE7MzOHdkALnNHT60kqmhD09/fv3ZrEuqnfDJ8mtylWZDzV0++BbUx8ewzT
         Twq51tzRQ2aL4FZGiqG6SEnGsmeo4pdjJBkxNphGUSmW1n9i3goY2S5Pa3jlenDkTO7u
         8CsWiUMrE4IXSj+HOZTT+p2iwZL6U6yJOlHVCoYkG96G2IoSSQ58ukMi1HvPj5JHK/TR
         ejy5NysxsiyIVxwbg7MyXceP5hxd4iNl2QSS6OVgWW5M43gK0ZZb9cORb7NIVhc9+zuI
         HqGg==
X-Gm-Message-State: APjAAAXebfkMjDvCJVS7OQm2NyQMtyW62zPSWJjoyz3jeX6wr/1mg/Nl
        S+0C78aoXfvnXQd3K89UuToSDh3rHxKqMPSmeJY=
X-Google-Smtp-Source: APXvYqxEWDCAASq8pkCIbC6iSOvk3L00tUVniVGM5uE3LcyrvijXPfOV7x2Z9KcXes0MxrOnxAJTJuHyXMTJkrk8fOs=
X-Received: by 2002:a63:5c1a:: with SMTP id q26mr22085674pgb.260.1559475844467;
 Sun, 02 Jun 2019 04:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190602102144.17360-1-chunkeey@gmail.com>
In-Reply-To: <20190602102144.17360-1-chunkeey@gmail.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Sun, 2 Jun 2019 21:43:52 +1000
Message-ID: <CAGRGNgXqB=5oi1Nq4ZNSk3csOEr4A6WgN8QymKMriTcevnKUQw@mail.gmail.com>
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

On Sun, Jun 2, 2019 at 8:24 PM Christian Lamparter <chunkeey@gmail.com> wrote:
>
> Some devices (like the Cisco Meraki Z1 Cloud Managed Teleworker Gateway)
> need to be able to initialize the PCIe wifi device. Normally, this is done
> during the early stages of booting linux, because the necessary init code
> is read from the memory mapped SPI and passed to pci_enable_ath9k_fixup.
> However, this isn't possible for devices which have the init code for the
> Atheros chip stored on NAND in an UBI volume. Hence, this module can be
> used to initialize the chip when the user-space is ready to extract the
> init code.
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

Two questions:

1. This seems complicated enough that the functions introduced should
probably go into a separate .c file, maybe "noeeprom.c", with a header
file with all the ifdef / config magic in it.
2. This smells almost like a completely separate PCI(e) driver for
cards in a "weird" state. Is there anything you're using from ath9k
other than the eeprom file naming? and is that really useful? Won't
the eeprom files be device specific and therefore could always use the
device name fallback?

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
