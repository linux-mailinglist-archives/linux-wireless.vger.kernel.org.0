Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7A57F1D9A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Nov 2023 20:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjKTT4O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 14:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjKTT4E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 14:56:04 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91C391
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 11:56:00 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a00c200782dso79192166b.1
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 11:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1700510159; x=1701114959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYgI9NHxU2UdmbEZcwd7bhTYCKdrR+WItSKkzQt3ufY=;
        b=NNw99bzZkNgG1n8fhKw+HTPJiT3seKenPnFvF3CGz9jLJLQpUUkrwbhSGt1VCRXACQ
         MhRV/3teB804mAthBBn7G9J91L7Zqhvw/UmZdF7q++JfQQLaVPCsZUjAWKiHITPdInI1
         i/MyB5gOg//5KvY0x1PG7XnHOvtjCblJ1xXqSE6F1nCIsHCkZYPjkmlDc9fwpBfq42wd
         8Sr8+Vja6TF2v6IEsRYYk8DnCwTiTDFFOkrWzVSzAcKTahHlDm3i1Ke6UZLgKfcu2FVa
         hXBpdBUPieaUsDjvbIkUAdlq0tDeIMivoLGQt/VHcgLBZtB5/SGkLvG8nxGsHMI8t1/A
         Q72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700510159; x=1701114959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYgI9NHxU2UdmbEZcwd7bhTYCKdrR+WItSKkzQt3ufY=;
        b=WadW87rFyzYUUrrYmOqZo3JsIaU1hlLZ2qisbTiim9xDRQoif/YydmkymNHQIdaxYK
         AsOI64wnI8R/LLJafnkT9/HmDrfNkG5GjHNQXd3A4HjGUD07FEP6pr1Toa3dkDItjF8p
         SboZ190H854wsLxbXXfXGAvStwtjuOVr8jxe66PUGI2xddQQDYiFsdCJTUb0X+FJzWzS
         tJjWEbEPi8qcGMW696Vrv7uqWLA+UV8GXbMApjT4ExAg5MXJ1M2kCMQRaYGSmKq8xwCJ
         V1pvsm+Hu8ckrDvRnNdbwR3/c9V0beIS/VcmWGTKfhtSFSF6PU+dg4eL+LtRwZ41/eHZ
         irKg==
X-Gm-Message-State: AOJu0YyaXpdG9ALI3ZEzPEfPrJ4/vODCrFhlvr3NOCSfZx4K3n/ZlMbn
        SW0sop8q0VZUYvsVAfqnuycOOsDZQ5RcUgJZabqmJLIJL/U=
X-Google-Smtp-Source: AGHT+IEsh5Tv9SjhFHl5iz7cqct4FFX0r8V0bnkaECzOhiwg0c4n8ejAyAAl9le7j/SORtZoJgTbftJ1dDlPUB8N57M=
X-Received: by 2002:a17:906:2b10:b0:9bd:e017:370e with SMTP id
 a16-20020a1709062b1000b009bde017370emr4812309ejg.54.1700510159090; Mon, 20
 Nov 2023 11:55:59 -0800 (PST)
MIME-Version: 1.0
References: <f3505110-b76b-4152-8375-37fa3184d3c1@lwfinger.net> <748b045e7aaa43eb9a7fb83ad924614f@realtek.com>
In-Reply-To: <748b045e7aaa43eb9a7fb83ad924614f@realtek.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 Nov 2023 20:55:48 +0100
Message-ID: <CAFBinCD=iLbyfWWTqQjLQ5CiqOn08r4UaVqyKHve8AoW_xeFEw@mail.gmail.com>
Subject: Re: EFUSE in RTW8723DS
To:     Ping-Ke Shih <pkshih@realtek.com>,
        Larry Finger <larry.finger@lwfinger.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Larry and Ping-Ke,

On Tue, Nov 14, 2023 at 1:52=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
>
>
> > -----Original Message-----
> > From: Larry Finger <larry.finger@gmail.com> On Behalf Of Larry Finger
> > Sent: Saturday, November 11, 2023 4:26 AM
> > To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > Cc: linux-wireless <linux-wireless@vger.kernel.org>
> > Subject: EFUSE in RTW8723DS
> >
> > Martin,
> >
> > The commit 9be20a822327 ("wifi: rtw88: rtw8723d: Implement RTL8723DS (S=
DIO)
> > efuse parsing") indicates that no additional information is extracted f=
rom the
> > EFUSE? Is that true, or did I misread the code?
>
> I think the commit is only to read MAC address that is programmed in diff=
erent
> location from PCI interface, and no more information.
Ping-Ke is right: the eFuse is split into two sections:
1. common (RF calibration, EEPROM version, antenna information,
country code, ...) which is independent of the HCI (host controller
interface)
2. HCI specific bits (PCI vendor/device IDs, USB vendor/device IDs,
SDIO specifics)

#1 has already existed for a long time and I didn't have to touch it
since it's the same for the PCIe, USB and SDIO variant of a wireless
chip.

For #2 there are no (known to me) SDIO specific bits other than the
MAC address. That's why I only added the MAC address for SDIO. If
there's more it can still be added.
Note that the MAC address has different offsets depending on whether
the HCI is PCIe, USB or SDIO.

> >
> > One problem we are having is that some devices come with zero programmi=
ng in the
> > EFUSE, and even with supplying a valid MAC address, the performance is =
poor.
>
> One or two years ago, people reported efuse of RTL8192DE (IIRC) isn't pro=
grammed
> in OpenWRT platform originally. That kind of product, calibration values =
are stored
> in external files instead, and chip is soldered on main board instead of =
a
> separated hardware module such M.2.
I have worked on this (also as part of getting devices supported in
OpenWrt :-)) for the ath9k driver.
Things have evolved (for the better) over time and now ath9k has
nvmem-cell support, see
Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
We can implement something similar for rtw88 if we have a board that
requires it and with someone who can help test things on the rtw88
side (don't forget: there will also be board specific .dts bits where
I could help, but someone has to be willing to do some work on this
end on their own).

> Maybe, we can read calibration values programmed in efuse as _default_ va=
lues
> from another module. This can't yield the best performance, but at least =
better
> than nothing.
I'm not an expert in this field but I *thought* that from a legal
standpoint it's mandatory to have the RF calibration data (to ensure
that the device is running within the country's regulatory rules and
never exceeds them).


Best regards,
Martin
