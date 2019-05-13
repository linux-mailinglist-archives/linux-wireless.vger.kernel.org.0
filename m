Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 753EA1B4F0
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 13:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfEMLbv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 07:31:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36003 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbfEMLbv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 07:31:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id j187so13339157wmj.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 May 2019 04:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=CkD7KwbrPUQx6UPSLwTwjUPT3LnQL1y1uwk7ETe3QYY=;
        b=E4pGpjrT+9MpyISgYYuoHrIFTgXLvRlaZL2rjAhhmyYLs/Qe6RSvfrfCbO/DBXaeku
         8CWk9f/amLPsrRFYPVeP857I241eP7uSqQg1fu7m7ZZIjBwzRD+uhMUB0sfEpskSjXzp
         qpWwi7ZO4BCq43PX0RwLoOkDUcMYzPwF6Yby8dsSxEVKVotEWkWkhrVue2+3p6agYawL
         NXq1gxP7wJ+TsVecCHBs0ZaVMu0z+imQ2dzhUO19WNfrzmic3AILNdKK0RSUMmO0WoCY
         MioqUB32OXVaUxvEwTqUJt01tzua+CKka2lRL2VVCEoFISYHVwJpxCDFxQ5xzlMZ/YH7
         SrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=CkD7KwbrPUQx6UPSLwTwjUPT3LnQL1y1uwk7ETe3QYY=;
        b=tJR1Ea5r4MEGi/qTgS30itbSmfDzxnK16r4wRTmq2GMZQHDeQsKvXlMEwLbGkfOjkR
         2fAfUyKH4mXUMz0xPPWEo5Eie1mr33cLkTDTW4ltuBWA+ZUTzaPOhminqyCsfeAXmlTe
         GnWAtc4yHXMvcqOFMC+omrZ9h+MmoqvSVBDHv6w+3EmpJSCB0HGg5v6n7Mzx4rJ+QyAX
         l/IjK7R2c8GDxjhAE4a4fMinzxovC/PYo2zFBomWoelpluiul0YASuaOc1A1rBAb1I5+
         Tilbbmw4DLqB4PkweNM9JspPjmEgF5Pd0wb6CHYIInm73brIbCKY5o7FAuGTEfaDeyWn
         ATmQ==
X-Gm-Message-State: APjAAAXzCZ1tngy4b8fHdBWzU/L609aKVTkhqImprCT7JxtFUBoOEOaz
        jJcaxCuQCwGEiH33mE5Y+zoGU1NqnAu8XjQ97Xk=
X-Google-Smtp-Source: APXvYqzGmN2+fJUSF+bDR92Rc2UOKHFPHGHAz8SnfLuX8TIF9/7I6cVmEFWdHz4aNCYXeGRTGtcA/e0BDZVZY1Q0jPw=
X-Received: by 2002:a7b:cb85:: with SMTP id m5mr2249534wmi.85.1557747108648;
 Mon, 13 May 2019 04:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUX+VNtk00YQnNYCnDeeH2Onq6s1vbdzYrv-OHf7q186Ww@mail.gmail.com>
 <154e3e74-38b5-850b-5993-295f9db8fe3c@intel.com> <CA+icZUWhBeup95PTP_k58xs8Lf2Ofqb0S_gkdBfbuc0-wdpF-w@mail.gmail.com>
 <06fbacb5-7739-1ca1-3bf4-8049a3ef019b@intel.com> <CA+icZUWJ0kZSqogg18LdP2YkNXk=_SNnT7-ufkd_Xp1ak7uchg@mail.gmail.com>
 <2b1bd56f-8797-fb90-e2af-218edaedd089@intel.com> <CA+icZUVMjCWwuC-ee1-+EPU6+mYqFZ7w4ai4t4EJcrsvZ2_BYg@mail.gmail.com>
 <3b7065a2-694f-63bf-fba3-a1641a03ea76@intel.com>
In-Reply-To: <3b7065a2-694f-63bf-fba3-a1641a03ea76@intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 13 May 2019 13:31:37 +0200
Message-ID: <CA+icZUUJYOYXmXRYyerY4QmiYoktT3_+kqQMpxyGFdb-8bfsuA@mail.gmail.com>
Subject: Re: [linux-nfc] ThinkPad T470 and NXP PN5xx (PN547 or PN548)
To:     Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org, linux-nfc@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 13, 2019 at 1:28 PM Oleg Zhurakivskyy
<oleg.zhurakivskyy@intel.com> wrote:
>
>
> Hi Sedat, Andy,
>
> Andy, thanks a lot for extending and cleaning that up.
>
> > Unsure, why the pn544_i2c NFC driver shipped with the Linux v5.1.1
> does not work.
>
> I briefly looked into drivers/nfc/pn544, that seems like an HCI based chi=
p (as opposed to NCI based PN547).
>
> It might be that changes that Andy posted are already sufficient for PN54=
7 to just work with neard (if I am not missing anything).
>
> # sudo apt-get install neard neard-tools
> # man nfctool
>

Away with NXP's libnfc-nci...

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
          Tags: [ ]
          Devices: [ ]
          Protocols: [ Felica MIFARE Jewel ISO-DEP NFC-DEP ]
          Powered: No
          RF Mode: None
          lto: 150
          rw: 15
          miux: 2047

Putting my YubiKey on the T470...

root@iniza:~# nfctool --poll -d nfc0
Start polling on nfc0 as initiator

Targets found for nfc0
  Tags: [ tag0 ]
  Devices: [ ]

Can I get a detailed view on the polling?

- Sedat -
