Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D746C2FB6
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Mar 2023 12:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjCULCi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Mar 2023 07:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjCULCh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Mar 2023 07:02:37 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE433A864
        for <linux-wireless@vger.kernel.org>; Tue, 21 Mar 2023 04:02:36 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id jl13so9600614qvb.10
        for <linux-wireless@vger.kernel.org>; Tue, 21 Mar 2023 04:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679396555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CdOUmxR6ho8e+EWFVY8aNeVK3NivniE8JCOyFUKutM=;
        b=qCPUzsH5Nf52tDg7UPq1Z2ipMAxosr/X28p4e7plBMrvPARdHoTlzGVMIZoNBbBhwI
         gxHohLuPgO9UbWx0Y6l5/U1ttu3rCcJZOuU3gnPGUm70Z4Qv+mdM5rA8ZY+8BoxST2Sq
         O76w9lH4na3BtaHP9fU8mzE/ykeNAkAr8XC6KOh6MuZzqyeWsTqj8XAtFg43afxI1V87
         og3gNQ+JpWoqbABbbfIyjYauanRZMpGS4jHBTwuLvqd9kqHjoTu/xxugNYyhRf3dtBSD
         jE+W/u9z/DixsFO4TIy1XGAt6bSvLQ/2992IhHLZ0hjdJXgZ+XxlVBaujd6I+NCS+eiN
         AaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679396555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CdOUmxR6ho8e+EWFVY8aNeVK3NivniE8JCOyFUKutM=;
        b=2tIAEtT+uQNEhXovN10Tjrqg9mpf3oFirYcBfXu/RMVjfe39UucIFH5qNwSvmrSnOu
         keIXzFs0QZrlmVW4ot/NX76qFV/vYHsUDQiU7arKq+JEtUdtlVwf2qZXF9ztwqcpYlk4
         Lqt6gMYFr2doSlrm5GCQ+hyvtHwAA3GeKyOiP6cJif9712JbaC3uMbSrNtDwAkkO13t0
         6DDNPayJl3XPt/9GtH61NRNgT4h0ObxhkXcgNNjYb/C1Sik4jDYofxqtVT1XsCnjxo5h
         /8Q4T4k4cRyZCqqJMZS2Rv5wqdwiuB/ICvBnhhPU3+y18OBZk444/3DkuooOMBFTjaay
         YoSg==
X-Gm-Message-State: AO0yUKUDRh+hZEsH7YG+V24EC7WbmhrAzehv1dU5N6m2rgenEuXlPsF4
        LenOCwMxwxJgJzp7oEQnZgb9a/WMcDibvHaJ+2o=
X-Google-Smtp-Source: AK7set/xnWTQPl8FKppPxhnB9PkZj6bCPtuSFWStpwjlGuRbsD+QHLZEJW6NFZGOU7/RTJSjojeG8rjXPFTajDiumUs=
X-Received: by 2002:ad4:5a46:0:b0:56b:fe74:d652 with SMTP id
 ej6-20020ad45a46000000b0056bfe74d652mr375984qvb.7.1679396555074; Tue, 21 Mar
 2023 04:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <mOgCviHEICGnhcs-E4-bjujNqa-zCiAgIi5y0m52zJVaibD44ThQI3p4Minav8Tn1ENtVQt18DONTovuxdUJk6O68q0QRNIUwD582gRwxns=@protonmail.com>
In-Reply-To: <mOgCviHEICGnhcs-E4-bjujNqa-zCiAgIi5y0m52zJVaibD44ThQI3p4Minav8Tn1ENtVQt18DONTovuxdUJk6O68q0QRNIUwD582gRwxns=@protonmail.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Tue, 21 Mar 2023 22:02:22 +1100
Message-ID: <CAGRGNgUh0uWbrGBB2twvxDFdxxfVWURak7eoyF6GOhOr1oyerg@mail.gmail.com>
Subject: Re: [UPDATE 1] My TP-Link EX510 AX3000 Dual-Band Gigabit Wi-Fi 6
 Router has a paper notice on GNU General Public License
To:     Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Tue, Mar 21, 2023 at 8:43=E2=80=AFPM Turritopsis Dohrnii Teo En Ming
<teo.en.ming@protonmail.com> wrote:
>
> Subject: [UPDATE 1] My TP-Link EX510 AX3000 Dual-Band Gigabit Wi-Fi 6 Rou=
ter has a paper notice on GNU General Public License

[personal information removed]

> My [snip] ISP has also given me a *FREE* TP-Link EX510 AX3000 Dual-Band G=
igabit Wi-Fi 6 Router [snip] Inside the packaging box there is a paper noti=
ce on GNU General Public License.
>
> I believe my tp-link Wi-Fi 6 wireless router is most likely running on an=
 open source Linux operating system.

Most likely, almost all of them do these days.

> How can I find out what version of the Linux Kernel it is running on? I t=
hink only Linux kernel 6.x support Wi-Fi 6. Am I right?

Your device will be running a vendor kernel and drivers so it could be
running just about any version of the kernel. The companies that
develop the chipsets and SoCs in WiFi routers generally provide their
own version of the Linux kernel with custom or proprietary drivers for
the hardware in the device. These kernels are frequently outdated so
there's no guarantee that it's a 6.x kernel.

What are your goals for this device? Are you planning to just use it
as-is or do you want to modify or replace the software in some way?

If you're interested in what software is running on it, contact
TP-Link: they should have a way for you to get the source code of the
GPL licensed parts of the software on the device.

If you're interested in installing a different operating system on it,
I'd recommend taking this question to the OpenWRT forums.

Finally, this isn't really the right forum for this discussion: this
mailing list is specifically about the development of open source
Linux drivers for WiFi hardware, e.g. PCI or USB devices and it's
unlikely that your device is running those drivers. This is a question
that is much better answered by forums which specifically discuss WiFi
routers and embedded devices, for example the OpenWRT forums.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
