Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 039EA1B52D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 13:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfEMLn1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 07:43:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33996 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfEMLn0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 07:43:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id j187so402506wma.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 May 2019 04:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=jBnXIJbh7NFIE0CW1juN9BEF5ZfWY5UAkAynwvc79Mc=;
        b=SgN3XpO16dCVYtzzr+c5xdMgKiyLJW6yVdrLk7gUvVzOKYlCHsvmq6qE35LkjC8NMw
         4A0otp3W7nAn+w8Nta7A831eaPYH/OH+gNMIKksEtYSDI/QOBoELrCCziT2HnWCq0DUk
         fE8elZkmFDdc9WVNEBewy9w1s1m8GpVJH6BNZJQ50lhMGEEsYLdT9DMNQ2gzGTAUjpI6
         cx3we1VHajPxg/L1kwTX8a8+PIc7qNPR4zqy/tosd2pA4tLreD3Q5+D7o28XVYKbmIsl
         LI9Gia4Tb03mSctxP7XDnWoTTrVR/zBzQhgYETVtf8fWNKwqU5TUNTPH5QiPb7jEwF8U
         8o/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=jBnXIJbh7NFIE0CW1juN9BEF5ZfWY5UAkAynwvc79Mc=;
        b=MBmfzb/Cv//I2LvdyV+N5P/RNM+UhebEvy2y88B8k5CU1sY0tWwbpKftoHVFFESy+z
         aAL83wt3VQJkMltu5vLRxRup1L7A5QEeNPv/YNT7ObsBvklY1qFAp0cAC2loiP4UaPpT
         8LPgWtlvxKa9WcLRF0QLPGhuO5rA+VDxIunoZU4LVscohiUKfHG/hZrI+pj/djxKzqYU
         fAv7b4FZMYaFOuV9JpcfoQiFqLL0JfHE58xvyRacgCAioXndAPSmLgWvk/0A42DMkaRX
         FUf6vVFgDxwLFP4o4GGUw02TCTN1w3VGm5VzAn74XpHNFO3h4Kzoeqc7gwQjfV0fASqe
         mMxA==
X-Gm-Message-State: APjAAAUKanVQIT9oftsnSVUmxgFtqpfNL+whbP5lQSm1Ya1uSlNYuFjX
        fXB5x/nB/zp0mftE7zfhsHuM80NpZDJPKpMJbl4=
X-Google-Smtp-Source: APXvYqwWppIet+TirB4JygYWMuc8/XwOZc4yuCzbHl/GsSTS/iXVEahwcyk1EwfwKfViSsWrjoS3awjQvmP97K4C3fA=
X-Received: by 2002:a1c:385:: with SMTP id 127mr4312238wmd.109.1557747803988;
 Mon, 13 May 2019 04:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 13 May 2019 13:43:12 +0200
Message-ID: <CA+icZUUu6NmQoKS-2x32Fz388Q_ahXyYzLLf5JNm=mZR+r-0kQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] NFC: nxp-nci: clean up and support new ID
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     =?UTF-8?Q?Cl=C3=A9ment_Perrochaud?= 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org,
        Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 13, 2019 at 12:44 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It has been reported that some laptops, equipped with NXP NFC300, have
> different ID then mentioned in the driver.
>
> While at it, I found that the driver has a lot of duplication and redunda=
nt
> platform data. The rest of the series (11 out of 12 patches) is dedicated=
 to
> clean the driver up.
>
> Sedat, would be nice if you can compile kernel with this patch series app=
lied
> and test on your laptop.
>

Hi Andy, Hi Oleg,

I have tested Andy's v2 series on my ThinkPad T470 successfully with
Linux v5.1.1.

Additionally, I had the NFC patch "NFC: fix attrs checks in netlink
interface" from Andrey Konovalov (see [1]).

sdi@iniza:~/src/linux-kernel/linux$ git log --oneline v5.1.1..
729d291510c2 (HEAD -> 5.1.1-1-amd64-gcc8-ldbfd) Merge branch
'for-5.1/nfc-nxp-nci' into 5.1.1-1-amd64-gcc8-ldbfd
f083f056830c (for-5.1/nfc-nxp-nci-v2) NFC: nxp-nci: Convert to SPDX license=
 tags
132b5681e074 NFC: nxp-nci: Remove 'default n' for tests
840b1df28cab NFC: nxp-nci: Remove unused macro pr_fmt()
5b55e26db0c2 NFC: nxp-nci: Drop comma in terminator lines
0a1edd5ce3bb NFC: nxp-nci: Drop of_match_ptr() use
acae10451393 NFC: nxp-nci: Constify acpi_device_id
07648528dae3 NFC: nxp-nci: Get rid of useless label
38b8c38f2187 NFC: nxp-nci: Get rid of code duplication in ->probe()
446f5aef4522 NFC: nxp-nci: Add GPIO ACPI mapping table
813d4243c563 NFC: nxp-nci: Convert to use GPIO descriptor
1e5187ddb944 NFC: nxp-nci: Get rid of platform data
775a4fa8fb68 NFC: nxp-nci: Add NXP1001 to the ACPI ID table
db79db400c5b Merge branch 'for-5.1/nfc' into 5.1.1-1-amd64-cbl-asmgoto
e1c37435140f (for-5.1/nfc) NFC: fix attrs checks in netlink interface

With neard (daemon) and neard-tools packages from Debian/buster AMD64
I am able to access, list and poll from my NFC (nfc0) device.

root@iniza:~# systemctl status neard.service
=E2=97=8F neard.service - LSB: NFC daemon
   Loaded: loaded (/etc/init.d/neard; generated)
   Active: active (running) since Mon 2019-05-13 13:14:12 CEST; 16min ago
     Docs: man:systemd-sysv-generator(8)
  Process: 810 ExecStart=3D/etc/init.d/neard start (code=3Dexited, status=
=3D0/SUCCESS)
    Tasks: 1 (limit: 4915)
   Memory: 1.6M
   CGroup: /system.slice/neard.service
           =E2=94=94=E2=94=80885 /usr/lib/neard/neard

Mai 13 13:14:12 iniza systemd[1]: Starting LSB: NFC daemon...
Mai 13 13:14:12 iniza neard[877]: NEAR daemon version 0.16
Mai 13 13:14:12 iniza neard[810]: Starting NFC daemon: neard.
Mai 13 13:14:12 iniza systemd[1]: Started LSB: NFC daemon.

root@iniza:~# nfctool --list
nfc0:
          Tags: [ tag0 ]
          Devices: [ ]
          Protocols: [ Felica MIFARE Jewel ISO-DEP NFC-DEP ]
          Powered: Yes
          RF Mode: Initiator
          lto: 150
          rw: 15
          miux: 2047

root@iniza:~# nfctool --poll -d nfc0
Start polling on nfc0 as initiator

Targets found for nfc0
  Tags: [ tag1 ]
  Devices: [ ]

Thanks to all involved people.

Please, feel free to add any credits you think are appropriate.

A big Thank you from North-West Germany.

Regards,
- Sedat -

[1] https://patchwork.kernel.org/patch/10339089/

> In v2:
> - added new ID patch
> - added new clean up patch
> - Cc'ed to linux-wireless@ as well, since linux-nfc@ bounces my mails
> - Cc'ed to the reported of the problem with T470 laptop
>
> Andy Shevchenko (12):
>   NFC: nxp-nci: Add NXP1001 to the ACPI ID table
>   NFC: nxp-nci: Get rid of platform data
>   NFC: nxp-nci: Convert to use GPIO descriptor
>   NFC: nxp-nci: Add GPIO ACPI mapping table
>   NFC: nxp-nci: Get rid of code duplication in ->probe()
>   NFC: nxp-nci: Get rid of useless label
>   NFC: nxp-nci: Constify acpi_device_id
>   NFC: nxp-nci: Drop of_match_ptr() use
>   NFC: nxp-nci: Drop comma in terminator lines
>   NFC: nxp-nci: Remove unused macro pr_fmt()
>   NFC: nxp-nci: Remove 'default n' for tests
>   NFC: nxp-nci: Convert to SPDX license tags
>
>  MAINTAINERS                           |   1 -
>  drivers/nfc/nxp-nci/Kconfig           |   1 -
>  drivers/nfc/nxp-nci/core.c            |  15 +--
>  drivers/nfc/nxp-nci/firmware.c        |  13 +--
>  drivers/nfc/nxp-nci/i2c.c             | 147 ++++++--------------------
>  drivers/nfc/nxp-nci/nxp-nci.h         |   1 -
>  include/linux/platform_data/nxp-nci.h |  27 -----
>  7 files changed, 37 insertions(+), 168 deletions(-)
>  delete mode 100644 include/linux/platform_data/nxp-nci.h
>
> --
> 2.20.1
>
