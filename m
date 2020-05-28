Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B768A1E5CCE
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 12:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387751AbgE1KOp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 06:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387745AbgE1KOj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 06:14:39 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EBAC08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 03:14:38 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id t23so1904243vkt.5
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 03:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CX+u123nVjVuRZW6zRvLQzHDlGFq6dyKso1AdFfB1VU=;
        b=ylyyWluJV1udCPHKbUpBa9gzteEE9rpam5yb+9Qo5ZwIaIvYSKHGX3rwW8Qu1yRVbs
         s71Mhpbn4QTKCa9jPCBH3htvR2tWok5/1SRIeN1hxVVWT5gP564EBK2f09DGMHTsm88k
         E/1/Mm9s9RRLFrSj/olPzuvMcy35QUUaEA3viA62YTJSswW4ihcjUcj0j3CqjQk1t0Tw
         fOD6/+BDIpMYgME2I6zR07nY/c/eQBKM+cPSdHE+aeP51ba14fhxbL0ogMP3G7O7Ngvi
         MEJknki2sFvjerUF1dfNz5OXK1ad6hNSCiQ1ajt5pWLA71kvbSH7LxLetwkAl3aAifv+
         ZtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CX+u123nVjVuRZW6zRvLQzHDlGFq6dyKso1AdFfB1VU=;
        b=lAAOP+9kn6XCMSvnSJKOzDTyWI1PD8i+wftsY5KeP88nR3e86ypoPgfJWnPcCcTPiY
         Zwj8iet2cdhZobBbTwLKoTlkFXpiUZkk+bjebOwl1ienfERJAauup545F1g5I1pnbwJA
         LFslwXoQoUXA7UX5m7MJKyYRO52L/nhHOCEhK0g9cQkBSXum+lJFBwX48zxmMZUHJPi/
         XCHtvD9wQ3Kgbpp9PXRsa5H6LEgAd7tn6u1/0TmF62hfxpvogyfjbRzire1fnUnLoi7s
         z0hYXcCiQxpqZaxN3bygPWtSED03wE/kmDS9k74ejhxJNu2YZOx13kC+hKFhoORnlp5J
         hUhw==
X-Gm-Message-State: AOAM530cdolbau6oXyNuiwUkMHTD9qF7JvnmNl2dLELZPLfHtlwQpDTF
        lq+p2+DL90BzINe5iYyChud3xRtJu3Cpj30cuMaDpw==
X-Google-Smtp-Source: ABdhPJzK0sB7xaJ5Xvcd9jk++euAwMqH3Mxp+8vmK46elIBGi117Z0Erqx3b1G/MIRgbK/NHLsfYjW544ZgBjhty6p4=
X-Received: by 2002:a1f:fc06:: with SMTP id a6mr1441822vki.101.1590660877077;
 Thu, 28 May 2020 03:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200522144412.19712-1-pali@kernel.org> <CAPDyKFqwrtJy2Ss0_KcBtpGP78d_BePTGJp01KtfuOaQqiwiHg@mail.gmail.com>
In-Reply-To: <CAPDyKFqwrtJy2Ss0_KcBtpGP78d_BePTGJp01KtfuOaQqiwiHg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 May 2020 12:13:59 +0200
Message-ID: <CAPDyKFrT0bp+HHPZemFEVjhNXbWB_P2NWQxVU43rexzdYB3reg@mail.gmail.com>
Subject: Re: [PATCH 00/11] mmc: sdio: Move SDIO IDs from drivers to common
 include file
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ath10k@lists.infradead.org, b43-dev@lists.infradead.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        libertas-dev@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 25 May 2020 at 09:15, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 22 May 2020 at 16:45, Pali Roh=C3=A1r <pali@kernel.org> wrote:
> >
> > Most SDIO IDs are defined in the common include file linux/mmc/sdio_ids=
.h.
> > But some drivers define IDs locally or do not use existing macros from =
the
> > common include file.
> >
> > This patch series fixes above inconsistency. It defines missing macro n=
ames
> > and moves all remaining SDIO IDs from drivers to the common include fil=
e.
> > Also some macro names are changed to follow existing naming conventions=
.
>
> Thanks - a nice cleanup!
>
> I guess this is best queued via my mmc tree, unless bluetooth/wireless
> maintainers think there are some problems with that. I will wait for
> an ack from them before applying.

It's getting late for v5.8, so I decided to queue this up as it's
rather trivial changes. If anyone has an objection, please let me
know.

Thanks!

Kind regards
Uffe


>
> Kind regards
> Uffe
>
> >
> > Pali Roh=C3=A1r (11):
> >   mmc: sdio: Fix macro name for Marvell device with ID 0x9134
> >   mmc: sdio: Change macro names for Marvell 8688 modules
> >   mmc: sdio: Move SDIO IDs from mwifiex driver to common include file
> >   mmc: sdio: Move SDIO IDs from btmrvl driver to common include file
> >   mmc: sdio: Move SDIO IDs from btmtksdio driver to common include file
> >   mmc: sdio: Move SDIO IDs from smssdio driver to common include file
> >   mmc: sdio: Move SDIO IDs from ath6kl driver to common include file
> >   mmc: sdio: Move SDIO IDs from ath10k driver to common include file
> >   mmc: sdio: Move SDIO IDs from b43-sdio driver to common include file
> >   mmc: sdio: Fix Cypress SDIO IDs macros in common include file
> >   mmc: sdio: Sort all SDIO IDs in common include file
> >
> >  drivers/bluetooth/btmrvl_sdio.c               | 18 ++--
> >  drivers/bluetooth/btmtksdio.c                 |  4 +-
> >  drivers/media/mmc/siano/smssdio.c             | 10 +-
> >  drivers/mmc/core/quirks.h                     |  2 +-
> >  drivers/net/wireless/ath/ath10k/sdio.c        | 25 ++---
> >  drivers/net/wireless/ath/ath10k/sdio.h        |  8 --
> >  drivers/net/wireless/ath/ath6kl/hif.h         |  6 --
> >  drivers/net/wireless/ath/ath6kl/sdio.c        | 17 ++--
> >  drivers/net/wireless/broadcom/b43/sdio.c      |  4 +-
> >  .../broadcom/brcm80211/brcmfmac/bcmsdh.c      |  6 +-
> >  .../broadcom/brcm80211/brcmfmac/sdio.c        |  4 +-
> >  .../net/wireless/marvell/libertas/if_sdio.c   |  2 +-
> >  drivers/net/wireless/marvell/mwifiex/sdio.c   | 38 ++------
> >  include/linux/mmc/sdio_ids.h                  | 94 ++++++++++++++-----
> >  14 files changed, 120 insertions(+), 118 deletions(-)
> >
> > --
> > 2.20.1
> >
