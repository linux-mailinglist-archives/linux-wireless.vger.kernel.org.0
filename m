Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA4811F7AF
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Dec 2019 13:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfLOM0b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 Dec 2019 07:26:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:54076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfLOM0a (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 Dec 2019 07:26:30 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA3AA20866
        for <linux-wireless@vger.kernel.org>; Sun, 15 Dec 2019 12:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576412790;
        bh=cyvcrZzccpsg9EdaJIsx4czj2xAYHq0o6kJ1Pv/iiQk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yYPaWlfpL143795Pasn0fztsbLlgubAx1oCvhBMDdvB0j0Y1KVzUQ6bFdlajUG5yi
         A2qCAwJnPQt6ShXE6WNUZELEkHHCpGGX4uMb+K3dh4/qBjh6l5AHqhj3yZ4CBsznat
         Oc+f8WPrl17cwY55RFTMK1vJOOYV/sPdnZsEfG38=
Received: by mail-qk1-f169.google.com with SMTP id r14so2544021qke.13
        for <linux-wireless@vger.kernel.org>; Sun, 15 Dec 2019 04:26:29 -0800 (PST)
X-Gm-Message-State: APjAAAWwiVmEeaUqnuJ+GOgeyWZ+Ei/tHJ34Xdd9NIIs2QxP5dakNDfo
        T8bAeUGPyh0srBxouokdguldsH3liWvr1yR5whQ=
X-Google-Smtp-Source: APXvYqwWqK8qO/O6Bl4fu9jfwC+6djB0U5quKOVR3MzHG0uXCpmLxBQ5VreOuFIVIM8O1y2wx1JN4FlKIlIWjaNxk3M=
X-Received: by 2002:a05:620a:139b:: with SMTP id k27mr22320830qki.112.1576412789066;
 Sun, 15 Dec 2019 04:26:29 -0800 (PST)
MIME-Version: 1.0
References: <b34e62bb-d217-d583-67c9-72ae7fe7b589@gmail.com>
In-Reply-To: <b34e62bb-d217-d583-67c9-72ae7fe7b589@gmail.com>
From:   Josh Boyer <jwboyer@kernel.org>
Date:   Sun, 15 Dec 2019 07:26:17 -0500
X-Gmail-Original-Message-ID: <CA+5PVA5dH7-dyczG3RHNaoPgD31mG+Dm0kVskxvnEH2YiuMNQQ@mail.gmail.com>
Message-ID: <CA+5PVA5dH7-dyczG3RHNaoPgD31mG+Dm0kVskxvnEH2YiuMNQQ@mail.gmail.com>
Subject: Re: [GIT PULL] Add NVRAM files for bcm43455 found on RPi4
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        serge@raspberrypi.org, Phil Elwell <phil@raspberrypi.org>,
        Arend van Spriel <arend@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Takashi Iwai <tiwai@suse.de>,
        Guillaume Gardet <Guillaume.Gardet@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Nov 27, 2019 at 11:23 AM Matthias Brugger
<matthias.bgg@gmail.com> wrote:
>
> Hi Josh,
> Hi all,
>
> This pull request adds the NVRAM config file for BCM43455 as needed by Raspberry
> Pi 4. The only difference to the file for RPi3 is the value of boardflags3.
>
> Please have a look and drop me a line, if you have any issues.
>
> Regards,
> Matthias
>
> ---
> The following changes since commit e8a0f4c9314754d8b2cbe9840357d88a861c438a:
>
>   rtl_nic: add firmware rtl8168fp-3 (2019-11-18 16:16:01 -0500)
>
> are available in the Git repository at:
>
>
> https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux-firmware.git
> rpi4-fw
>
> for you to fetch changes up to f93c7a18dbb3705aa1899318c3bf5d3819cd7781:
>
>   brcm: Add BCM43455 NVRAM for Raspberry Pi 4 B (2019-11-27 17:12:39 +0100)
>
> ----------------------------------------------------------------
> Matthias Brugger (1):
>       brcm: Add BCM43455 NVRAM for Raspberry Pi 4 B
>
>  brcm/brcmfmac43455-sdio.raspberrypi,4-model-b.txt | 82 +++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 brcm/brcmfmac43455-sdio.raspberrypi,4-model-b.txt

Pulled and pushed out.  You didn't update WHENCE, so I added a commit
to correct that.

josh
