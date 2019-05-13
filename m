Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B27051B2D5
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 11:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfEMJ1V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 05:27:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36508 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfEMJ1V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 05:27:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id o4so14403311wra.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 May 2019 02:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=9bk6EauoZZs35rRixLFtmrIOLz8P6rskznTT13qGWUE=;
        b=rE1MPjn8y2XTA+LFJ+qVbOEtR9+6U8H+FbjzLeKlUmgomJxh85cFdFaA0FNZO90NdM
         7OI8o/zRCY51M8I4MFPCzcvdm/AhHU1n6BKBPebVCKJG3HCU2XN+1LV0MvvA36uGm+jl
         MUUU0Jx5Tt+qhTF675136mDp0o3VM3kVGeRYYlghq0i8uuIfh69foGefuXYJNap/zKf2
         0RPlz5bZZ2d1Rs6StBjIzLvzyE6ArMDSck5tTqjrl/4rH5ZsXB+jEmy3h11gJXtMbI+6
         XumKjpC1n52t0nDV+/raCav2qSC86/FjKb8n0zYKY4QOY9JhjJvmyiD9DC18ewzgBwSN
         t+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=9bk6EauoZZs35rRixLFtmrIOLz8P6rskznTT13qGWUE=;
        b=Xs7SVNVMrQXNPfGq63wJ0+jig2YCfa8xbMdjEZgSjxcchihQetTxTR5FIJjpEd3dH1
         Felz1ovluLuYQ1FLfugHgxDNC5aL423KDeourvmD4WwjwaNHpeElLq+USul+FK9nGxnz
         HSvwkkeFTifRtd0U1NHr/kL0nt/gn64hirZJb7Qwpt8Cec2NUOq57+sP4vKyJPRd1vp+
         GkTIOPInpXP9wePmveh9e9tE5CoWNIp9S7cw7ND0XKr5hYPN8JqNJZwFMp7kxGR3R3Ge
         0mlVc95cyNq1jI1yE5x173viLP/SGxL4LIM5d0SvblwZCpP0JcMwB0Q45ZfaAThpbqI4
         d8YQ==
X-Gm-Message-State: APjAAAUywVudnG7D+HJcouRDfq/8luFnXEl0etR0fiuGBJmubcHTg8rD
        MP2mdtS8rRCoT14iX90R9komyZDI8dvn5lkXnxQWTn4PPFg=
X-Google-Smtp-Source: APXvYqzwG/66abezFY+5is0yn7ttbCPQ0RRnaohq1EV0D0+92NLiqI4SvZ+iMS2nzrjaTAKaaxLFKmH9M3FcmeOfrh0=
X-Received: by 2002:adf:dd0d:: with SMTP id a13mr11257110wrm.153.1557739639328;
 Mon, 13 May 2019 02:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUX+VNtk00YQnNYCnDeeH2Onq6s1vbdzYrv-OHf7q186Ww@mail.gmail.com>
 <154e3e74-38b5-850b-5993-295f9db8fe3c@intel.com> <CA+icZUWhBeup95PTP_k58xs8Lf2Ofqb0S_gkdBfbuc0-wdpF-w@mail.gmail.com>
 <06fbacb5-7739-1ca1-3bf4-8049a3ef019b@intel.com>
In-Reply-To: <06fbacb5-7739-1ca1-3bf4-8049a3ef019b@intel.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 13 May 2019 11:27:07 +0200
Message-ID: <CA+icZUWJ0kZSqogg18LdP2YkNXk=_SNnT7-ufkd_Xp1ak7uchg@mail.gmail.com>
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

On Sat, May 11, 2019 at 3:28 PM Oleg Zhurakivskyy
<oleg.zhurakivskyy@intel.com> wrote:
>
>
> Hi Sedat,
>
> On 5/10/19 10:40 PM, Sedat Dilek wrote:
>
> > Can you guide me how to do that?
>
> I try and then decide whether this is help or not.
>
> If I remember correctly, support for PN547 was done by multiple parties f=
or some Broadwell based designs through the upstream, both on the kernel an=
d neard side.
>
> Assuming the integration details of PN547 didn=E2=80=99t deviate much, th=
is might be:
>
> - From relatively simple, i.e. getting the relevant data from ACPI and hi=
nting the kernel/driver with a minimally sufficient changes. Most likely, o=
nce you sort the basic details (i2c, gpio, etc), everything would just work=
.
>
> - To more laborious and would require a working and ideally open source r=
eference. An option here might be Broadwell based Chromebooks with PN547 (j=
ust not sure whether plain or OEMs).
>

By cloning the driver from [1] which enhances the original driver [1]
with ACPI support and auto-detecting/auto-configuring the "NXP 1001"
device (see [1] and [2])...

...and using NXP's libnfc-nci...

configure-line: PREFIX=3D"/opt/libnfc-nci" ; ./configure
--prefix=3D"$PREFIX" --enable-i2c --enable-debug

...and enabling all available debug options in the provided *.conf
files in /usr/local/etc/...

...en plus I have activated all sort of I2C and GPIO debug kernel options..=
.

...I was able to run the demo-app...

# /opt/libnfc-nci/sbin/nfcDemoApp poll 2>&1 | tee /tmp/nfcDemoApp-poll.txt

While in polling mode, I threw my YubiKey on the NFC device on my
Lenovo ThinkPad T470 and see...

NxpTml:     PN54X - I2C Read successful.....

NxpNciR:     len =3D  44 >
61052901020400FF010C4400072700000092D3490120000000121178B384008073C021C0575=
97562694B6579
NxpTml:     PN54X - Posting read message.....

NxpHal:     read successful status =3D 0x0
NxpHal:     NxpNci: RF Interface =3D ISO-DEP
NxpHal:     NxpNci: Protocol =3D ISO-DEP
NxpHal:     NxpNci: Mode =3D A Passive Poll
NxpFunc:    NfcAdaptation::HalDeviceContextDataCallback: len=3D44
NxpFunc:    NxpTml:     PN54X - Read requested.....

Then I checked what the value...

HEX: 61052901020400FF010C4400072700000092D3490120000000121178B384008073C021=
C057597562694B6579

...means in ASCII...

$ cut -c 11- HEX.txt | xxd -r -p
=EF=BF=BD
 D'=EF=BF=BD=EF=BF=BDI x=EF=BF=BD=EF=BF=BD=EF=BF=BDs=EF=BF=BD!=EF=BF=BDWYub=
iKey

So, this seems to work.

I still have no glue how to use this experience in Linux to use NFC
and especially my YubiKey.

The binaries provided by Debian's libnfc-bin do not work.

Sorry to say, I still have not get all correlations...

- Sedat -

[0] https://github.com/nfc-tools/libnfc/issues/455
[1] https://github.com/NXPNFCLinux/nxp-pn5xx
[2] https://github.com/jr64/nxp-pn5xx
[3] https://github.com/NXPNFCLinux/nxp-pn5xx/issues/20
[4] https://github.com/NXPNFCLinux/linux_libnfc-nci
[5] https://www.rapidtables.com/convert/number/hex-to-ascii.html
[6] https://superuser.com/questions/244025/tool-to-convert-a-file-of-hex-to=
-ascii-character-set
