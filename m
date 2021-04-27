Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1027D36C611
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Apr 2021 14:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236104AbhD0MaT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Apr 2021 08:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbhD0MaS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Apr 2021 08:30:18 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7491C061574;
        Tue, 27 Apr 2021 05:29:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id b23so10851190lfv.8;
        Tue, 27 Apr 2021 05:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVhMyoiGHi0m8O7Bex0/VLWtA8zeTyFALcdFUVsrYs8=;
        b=BsSETqLbw+lAmr3hkQUZFEaT5F9HW8OyOUuFwS3NwAIZd9V/ELBDc1lSKZPWxB8pJG
         ntWyye6fCODfylXpHYsJb5KjI5J4pQ3UCcec3wyc/usiLXUuFxvXKe7owMiLlZO9p6Cj
         boskQysjJMWeX/Led9HroEADuOWmv6JboKV8k0fnJHHy+8m9qtAEfafaasXEiuOjcr3R
         Q7iMmc7/yWPx/w//G8zepLZR4wZ+MDJFZRNSfjI7AGOgI37kETQLhizaOBjUdcBBrroH
         EuI4nhL4hFk+g4bl0MAvikggxFltYcx+oniIvTBTSlp+ei9RYrcuS4QG+Wpd49SH3c46
         pYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVhMyoiGHi0m8O7Bex0/VLWtA8zeTyFALcdFUVsrYs8=;
        b=AvB/a48kQ7dkVkuVJIrkC7zRCVGafXO0fsaCcM23vfWY5pmL7Qh2aYSuRUq3daSIzK
         HLxiUWqJxGWbELPsGlABQFoGtPo6pEGgUyKAwyz3xe7teHh9+LXLFHXV5vD95ZAy+A8C
         gJ5+aj098YizAWbbcFHXG1+BUtkxwCuiU0J9G7g20x5yQgp9CHzwoAF2GbC6EUPBa2g6
         Mlg7cmNJvT2sY18kNakl6idSuvnIPa7Bs/r6baYNAx96wjp204/pm9Id70VBKNQWLIDZ
         l4Hk7H7NLqa1llNGiVyIZbPvLyrvpqJ266uhkuJhgv+f02y7aR0BkugrBMBwX6Dl1qlP
         P2EQ==
X-Gm-Message-State: AOAM531c3Hz0n0B90JWxGn7U3WADlNTpLlV0Oa4Dyw/T+O0G4wPOLBx1
        CQ8uCAUd6qELFu5MTNiHk4gMvOgucwxFwIZd
X-Google-Smtp-Source: ABdhPJyHEr4xHgky19MhfllBd+i+2MNeOZfv8b3rIl9Y4MowugXJmf+izT4nGYj/+urQgeMdWO3QcA==
X-Received: by 2002:a19:c50d:: with SMTP id w13mr16318878lfe.316.1619526570887;
        Tue, 27 Apr 2021 05:29:30 -0700 (PDT)
Received: from localhost.localdomain ([94.103.229.147])
        by smtp.gmail.com with ESMTPSA id r28sm387493ljd.56.2021.04.27.05.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 05:29:30 -0700 (PDT)
Date:   Tue, 27 Apr 2021 15:29:28 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Atul Gopinathan <atulgopinathan@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     brookebasile@gmail.com, ath9k-devel@qca.qualcomm.com,
        davem@davemloft.net, kuba@kernel.org, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        syzbot+89bd486af9427a9fc605@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: Memory leak in ath9k_hif_usb_dealloc_tx_urbs()
Message-ID: <20210427152928.0871e17a@gmail.com>
In-Reply-To: <ec48c7d118a3093289907dc43f8dfb79d4879f7d.camel@gmail.com>
References: <20200911071427.32354-1-brookebasile@gmail.com>
        <20210330193652.10642-1-paskripkin@gmail.com>
        <YGQWf1lP4ZOUFiG5@kroah.com>
        <20210427113559.GA7527@atulu-nitro>
        <ec48c7d118a3093289907dc43f8dfb79d4879f7d.camel@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 27 Apr 2021 15:04:29 +0300
Pavel Skripkin <paskripkin@gmail.com> wrote:

> Hi!
>=20
> On Tue, 2021-04-27 at 17:05 +0530, Atul Gopinathan wrote:
> > On Wed, Mar 31, 2021 at 08:28:15AM +0200, Greg KH wrote:
> > > On Tue, Mar 30, 2021 at 10:36:52PM +0300, Pavel Skripkin wrote:
> > > > Hi!
> > > >=20
> > > > I did some debugging on this
> > > > https://syzkaller.appspot.com/bug?id=3D3ea507fb3c47426497b52bd82b8e=
f0dd5b6cc7ee
> > > > and, I believe, I recognized the problem. The problem appears in
> > > > case of
> > > > ath9k_htc_hw_init() fail. In case of this fail all tx_buf->urb
> > > > krefs will be
> > > > initialized to 1, but in free function:
> > > >=20
> > > > static void ath9k_hif_usb_dealloc_tx_urbs(struct hif_device_usb
> > > > *hif_dev)
> > > >=20
> > > > ....
> > > >=20
> > > > static void ath9k_hif_usb_dealloc_tx_urbs(struct hif_device_usb
> > > > *hif_dev)
> > > > {
> > > > =C2=A0=C2=A0=C2=A0 ...
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0list_for_each_entry=
_safe(tx_buf, tx_buf_tmp,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &hif_dev->tx.tx_buf, li=
st) {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0usb_get_urb(tx_buf->urb);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0...
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0usb_free_urb(tx_buf->urb);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0...
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > >=20
> > > > Krefs are incremented and then decremented, that means urbs
> > > > won't be freed.
> > > > I found your patch and I can't properly understand why You added
> > > > usb_get_urb(tx_buf->urb).
> > > > Can You explain please, I believe this will help me or somebody
> > > > to fix this ussue :)
> > >=20
> > > I think almost everyone who has looked into this has given up due
> > > to the
> > > mess of twisty-passages here with almost no real-world benefits
> > > for unwinding them :)
> >=20
> > Just wanted to confirm, what is the status of this bug then, as in
> > is it
> > invalid (not sure if that's the correct word)? I happened to stumble
> > across the same syzkaller bug report Pavel posted above, in the
> > morning.
> > Saw that there has been no patch tests/fixes on this yet according
> > to syzkaller. Spent a couple of hours going through it before
> > sending a test patch to syzbot which returned an "OK" (and the
> > patch is exactly what Pavel pointed out, I simply removed the
> > `usb_get_urb()`). Before sending anything to the mailing list, I
> > made sure to search all the relavant networking lists to see if
> > this topic had been brought up (learnt
> > to do this from my preious mistakes of sending already accepted
> > patches) and
> > luckily I found this.
> >=20
> > Syzbot has had 380 crashes caused by this bug, with the latest being
> > today. So I wanted to confirm what should be done be about this
> > bug.=20
> >=20
>=20
> I saw on dashboard, that Dmitry tested latest upstream commit and
> syzbot returned "OK", but usb_get_urb(tx_buf->urb); is still there.
>=20

I am sorry, I clicked wrong link on dashboard :( My bad.

I believe, You can test your patch on this
https://syzkaller.appspot.com/bug?id=3Dcabffad18eb74197f84871802fd2c5117b61=
febf.

usb_get_urb(tx_buf->urb) was introduced in patch related to this bug

> I think, this usb_get_urb prevents race condition, but I'm not sure
> about it, that's why I sent an email to patch author. As You can see,
> he has not responded yet :)
>=20
> > Thank you!
> > Atul
>=20
> With regards,
> Pavel Skripkin
>=20
>=20



With regards,
Pavel Skripkin
