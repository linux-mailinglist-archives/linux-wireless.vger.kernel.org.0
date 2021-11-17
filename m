Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C08454D65
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Nov 2021 19:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbhKQSug (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Nov 2021 13:50:36 -0500
Received: from mail-0301.mail-europe.com ([188.165.51.139]:58741 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240232AbhKQSuf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Nov 2021 13:50:35 -0500
Date:   Wed, 17 Nov 2021 18:47:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1637174852;
        bh=HD/W+gyfJb37tDHDN2YwJ63ZhnnBg7Q8KnNp/DVt9Kc=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:From;
        b=G5Q68xGf1Vw+3Em/QTxeWnm44UNewgNhK3/23SaaFQEP8ba5oElcj08GZlynIkNY8
         Zzeqr8ga7DS7m9TtjxsJVNF2bbJ0Z0EeSOnoWyVTarIVImxCfIIaupSN44Sdr+fvp4
         RsYrqs1b6zaYSIoD7X3l2ElG5+OXnthz4FErgLuM=
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>
Reply-To: rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>
Subject: Re: rtw88: Guaranteed system freeze with RTL8821CE with RFE 2 type
Message-ID: <9y_PDr3Fwwe-Tlg_OW2NgajfltnUS0Zflhoi19wd0p3OmpkAnqGqxuszx6ySZG9nBMg2JRGwnEgg59X1c0TFf6iqt951g3yqzSZ7CNDuXVQ=@protonmail.com>
In-Reply-To: <Gm8GBswaSIZmUcurR4ygkbaFYfBiC8pIiBV5Ovz2GIorPykklbSraab7Z00LIX5pnfCJyWlI1-jUqnkl8NmxSuqfr-k_gYNhvWDg3kIkPkY=@protonmail.com>
References: <vWuRjLpNOkVGXHNeCL6phN5YDcd6Oljm1WgEMO4vA9aufK8MxzN5itvDnRjPBWHZN0geAbRLAzgIj36kAiNtdHh5vg2RjUH_TzuqZ7WSYeE=@protonmail.com> <65c86fe7-f1f1-445f-40c2-25ceaa4e4fb6@lwfinger.net> <1jmF9EMZn2ywrHSGrNCzOUSAzllw9ox-Da2zfbSTnTULlX8Ha8F211TfKuxITBBtkfxiU_R0w7zUeFLdtDj4ejp6qPnCIhFj2U-rsCVNlMg=@protonmail.com> <Qg7Ae-IznoeEC_X2m_4XXKRlM-yT3O7dzdbZ0egHTsdEaA0uILKZ0uBymFMrN7aI38rz-ZTKSxTDUAU4tKJPIntXELdx9Rd0MIU5sSG_VCI=@protonmail.com> <ZJknGMd-LYMAOQNAoIsR9G59_Wlt9uYUPzzJ_v2p3W8kCQ_gIQ_ymF09TV83SN0h5Md0tyzlpIxTjCMkK88gXOkSI5UA_knH6RGUd4ITHrA=@protonmail.com> <d65a162e-9d0c-fff9-65e3-4553a1981ad3@lwfinger.net> <hXlLGR-ccu9ozKXl1rsCyt7jWfmH0ufgepYDXU9dkZUYJWDmwjflabUNuxh-XWDeey4GQRjaSmtSIEqFsY5mieunEOMCTawMpyFzW9dbA0A=@protonmail.com> <37f988a9-8966-3482-f0ad-812a8cecce00@lwfinger.net> <Gm8GBswaSIZmUcurR4ygkbaFYfBiC8pIiBV5Ovz2GIorPykklbSraab7Z00LIX5pnfCJyWlI1-jUqnkl8NmxSuqfr-k_gYNhvWDg3kIkPkY=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.7 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Monday, June 7th, 2021 at 12:29 PM, rtl8821cerfe2 <rtl8821cerfe2@protonm=
ail.com> wrote:

> On Monday, June 7, 2021 5:40 AM, Larry Finger Larry.Finger@lwfinger.net w=
rote:
>
> > I just push a patch from Realtek with the following commit message:
> > 8821CE with ASPM cannot work properly on Protempo Ltd L116HTN6SPW. Add =
a
> > quirk to disable the cap.
> > The reporter describes the symptom is that this module (driver) causes
> > frequent freezes, randomly but usually within a few minutes of running
> > (thus very soon after boot): screen display remains frozen, no response
> > to either keyboard or mouse input. All I can do is to hold the power
> > button to power off, then reboot.
> > Please do a 'git pull' and try the new code. If you still have the prob=
lem, the
> > quirk may need to be extended for your system. Please run the command:
> > sudo dmidecode > dmidecode.txt
> > Then post that .txt file.
> > Larry
>
> That patch seems to do the same thing as the rtw_pci option disable_aspm=
=3D1. I tried that option, with and without disable_msi=3D1, and it didn't =
help.
>
> I'm attaching dmidecode.txt.


Recently I saw the instructions from Ping-Ke Shih in this Ubuntu bug report=
:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1927808
and realised I never powered off the laptop when I tested disable_aspm=3D1.
I always rebooted.

So I added again "options rtw88_pci disable_aspm=3D1" in a file in /etc/mod=
probe.d/
and powered off the laptop. It seems to work. It's been 11 days with no fre=
eze now.

Here is my information for dmidecode again:
System Information
=09Manufacturer: HP
=09Product Name: HP 250 G7 Notebook PC
