Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19A6C1A372
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2019 21:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfEJTkz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 May 2019 15:40:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33291 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfEJTkz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 May 2019 15:40:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so1980622wme.0
        for <linux-wireless@vger.kernel.org>; Fri, 10 May 2019 12:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=b7CNSrJCC6jDkKxuON1hgz7BdbZu47CyI5hQf5tuyjY=;
        b=BlpTPD1AF/484jhDB7tBJ11stdfaRWyZEcc08YrbQEt2fQp8Id0u/3L7qq+ZiP9Nfx
         +xNZa3bmx7upb4n0u+/2nTxgS9hK2R393ljqjOfKewkx62Zm55HwO5ejV8QuvLiOfK+y
         k9HwxaZ08cqufHVZGflCjW2xekQDslyxXO5xmmWF8jD6heMV2lCq6xHi6nZnmEO4ecOf
         OthsCWkeQtzmxvK/UVMD3D3Epp0vbzTdltfRIAMBWJFH8jzgU8vRjBcGjO74B/NIvNUf
         oBliej1JM5qJX+krY2QgZ9R253+CtaJW1GnzujxPzHrijjutG9g4k1Fx9Zm994t7+HRl
         xDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=b7CNSrJCC6jDkKxuON1hgz7BdbZu47CyI5hQf5tuyjY=;
        b=H3/JgYAEHLJHbqtoTehV8ZFTHBl6KSyEWeVR2T/xQiaxj/VSjBTfr+ZZQ/i2AMJhf9
         9HDIkHYaA0MU/Nn5sWbabGwrJMD0xCYET9llExz1jb7biMozPlqLDQAgUYMg7nhLVbnK
         DIAc8+s4p9JteFnj3PC5oUMDMnwVPe+4iT3iC26GI9RYorYUWQhrCGmK7OkBZzlBrFmU
         NvXPFzzHVQ/P2oOlDM4MBbj6PaAo2dG5RiVvDD0VDhfdCdmp7jVC9Oykpawy9wmz4ZRd
         e6Nf9ijlLANDn02/fskZILkVD9m6hJ8WSLN6dre/nBO+oeNBoHMuo3alXOya3phsHroT
         qYJw==
X-Gm-Message-State: APjAAAW0BE1DvD5CcMEOKTYa4y7qmNeqKMjRf3wG+Tih3t97p2wKXQx7
        nMt4QdPUMuyzcfNZERcMntWQT9uptmwzaJTwg1oob6wx2iI=
X-Google-Smtp-Source: APXvYqxtmH2f5hAmohpUcsmcGKa800sPMjnAjRnyaUvtYVbx2RMlIrzBKWkAYcsZU6MxMr5wcrxZ6lkJGYgh/uBGlsE=
X-Received: by 2002:a1c:dd44:: with SMTP id u65mr8160906wmg.109.1557517252999;
 Fri, 10 May 2019 12:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUX+VNtk00YQnNYCnDeeH2Onq6s1vbdzYrv-OHf7q186Ww@mail.gmail.com>
 <154e3e74-38b5-850b-5993-295f9db8fe3c@intel.com>
In-Reply-To: <154e3e74-38b5-850b-5993-295f9db8fe3c@intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 10 May 2019 21:40:37 +0200
Message-ID: <CA+icZUWhBeup95PTP_k58xs8Lf2Ofqb0S_gkdBfbuc0-wdpF-w@mail.gmail.com>
Subject: Re: [linux-nfc] ThinkPad T470 and NXP PN5xx (PN547 or PN548)
To:     Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Cc:     Samuel Ortiz <sameo@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, May 10, 2019 at 8:56 PM Oleg Zhurakivskyy
<oleg.zhurakivskyy@intel.com> wrote:
>
>
> Hi Sedat,
>
> I would like to help you, but at the same time not to mislead, as it=E2=
=80=99s been a time since I touched that.
>
> So take everything with a grain of salt and correct me where I might be w=
rong/forgot.
>
> > I am not sure if I need to load the PN544 (I2C) driver?
>
> Yes, the driver is needed, for PN547 it=E2=80=99s NXP NPC100, the driver =
is drivers/nfc/nxp-nci.
>
> > Do I need these firmware files installed?
>
> To start with, i.e. for a simple signal through like reading a tag, most =
likely not (the chip is usually provisioned with some FW).
>

Hi Oleg,

thanks for all the informations...

# modprobe -v nxp-nci_i2c

...gives me...

# lsmod | egrep 'nfc|rfkill|pn544|i2c|gpio|mei|nxp|nci' | sort
i2c_algo_bit           24576  1 i915
i2c_dev                24576  0
i2c_i801               32768  0
mei                   118784  1 mei_me
mei_me                 36864  0
nci                    77824  2 nxp_nci,nxp_nci_i2c
nfc                   122880  2 nci,nxp_nci
nxp_nci                16384  1 nxp_nci_i2c
nxp_nci_i2c            16384  0
rfkill                 32768  10 nfc,bluetooth,thinkpad_acpi,cfg80211

What userspace do I need?

I tried...

# rfkill list
0: tpacpi_bluetooth_sw: Bluetooth
        Soft blocked: no
        Hard blocked: no
1: phy0: Wireless LAN
        Soft blocked: no
        Hard blocked: no
2: hci0: Bluetooth
        Soft blocked: no
        Hard blocked: no

# nfc-list
nfc-list uses libnfc 1.7.1
No NFC device found.

# nfc-scan-device
nfc-scan-device uses libnfc 1.7.1
No NFC device found.

> To start with, i.e. for a simple signal through like reading a tag, most =
likely not (the chip is usually provisioned with some FW).

Can you guide me how to do that?

Thanks!

Regards,
- Sedat -
