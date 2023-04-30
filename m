Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1BA6F2872
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Apr 2023 12:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjD3Kao (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Apr 2023 06:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjD3Kan (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Apr 2023 06:30:43 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA20710F7
        for <linux-wireless@vger.kernel.org>; Sun, 30 Apr 2023 03:30:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3010889c6ebso816370f8f.2
        for <linux-wireless@vger.kernel.org>; Sun, 30 Apr 2023 03:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682850640; x=1685442640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4G8UhnbxhsYM0Xf5ZW26+QRa14/9Q4I0bIU7lceQC8=;
        b=Y1bg7Sk97eX4154YzIMDWJDnSTfrtmZwPaId8BdCQVoiL8jJVz/62Pl0jWBoaHRgpK
         kct8pQMwHxN/3TJAXiaWUFjl4JYf4D1M74kcOieVrd383yZbvBxtehiunvEZS8fFqpmR
         hhEpes7I729eSi89jBHUJTxpivMrBrHWXGaJ6WVfDA1w/4Wi9Pif1E5OxeuaYDKJbXIj
         xeA1+2bp+nwt20XRZqbkKE2FLt3dtS4G/VuuO9SVdDorunKa9EJNADTHgfOiVAVgiR6Z
         s13xeqTpDhrqktLOymOWAQVRRDM1eVTtdrWg7wAnckGoA4xhDld0x8rpUQR+WKsSxyJJ
         ocMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682850640; x=1685442640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4G8UhnbxhsYM0Xf5ZW26+QRa14/9Q4I0bIU7lceQC8=;
        b=bd3pyP17HK4TxeettSInhtkhsFWTFEJwDBg2kifRV3dPWVLmOrYcEK2pko+vaGkmKy
         LtL3trKVRTgsIJWOWbI7A+xkqfgXHWsqhcEiVZzHtEvzwu1OQ1jE8RxHN2SJqXFIog/3
         Mxl62bJPN/H5dQIoWT+iezChewOY7usXc4PkTzc+fltUe7N6ucWXmJSK9idmgvv5Hv0C
         cHlwCTWjEh893NgrcJklkTYOqsBg70QoKnw1ILrPdxwX66rMoub4i+6eQMajk799rMhE
         XQSf+Rb48Ax6Uj2R1gonkq4qyM2QQShDazrvWm1N/+hwiAD9adsBy3vYRu1vHNcjXN8I
         h7XQ==
X-Gm-Message-State: AC+VfDwzOVSBEwyWjh+jAySbdNQap3XwT7bAru651gGYIsZnsg5GwTtU
        EPIcyGjaqfxYkS5wjUbwB71zJFmRiA9iH3kv2llhza9VdKs=
X-Google-Smtp-Source: ACHHUZ7NmrtGutpRfHrjMGJM7zbhe2+lvZfdsjeOiVQh2k5l6U5l+Kl7E9iKWewPbLLBkvLy8aPewzbAMJ9FQuqyAWY=
X-Received: by 2002:a5d:4408:0:b0:304:89f0:3e65 with SMTP id
 z8-20020a5d4408000000b0030489f03e65mr7525409wrq.36.1682850639943; Sun, 30 Apr
 2023 03:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAD9ZU8BcYM_zZqFzTBFDQOoF0Jd3vNj4OWODOy+UZbWXCUwA7A@mail.gmail.com>
 <0529ba07-db97-fe95-4ab8-aba47b8b0bc4@lwfinger.net>
In-Reply-To: <0529ba07-db97-fe95-4ab8-aba47b8b0bc4@lwfinger.net>
From:   Gabriel Tisan <gabriel.tisan@gmail.com>
Date:   Sun, 30 Apr 2023 12:30:28 +0200
Message-ID: <CAD9ZU8Ati86h0kzxuoSM0js31-rqShv7UNFZSVGE6jcykKsZvQ@mail.gmail.com>
Subject: Re: rtw88: 8822cu (LM842) --> LOWER_UP link messages
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Actually the connection is not dropped. That is the problem : the
message LOWER_UP is coming although the connection is not dropped.

I suppose that LOWER_UP notification is send wrong by the driver.

In the log nothing comes.
I tried to increase log level, but I didn't find any /proc/rtw88.
I have debug activated:
CONFIG_RTW88_DEBUG=3Dy
CONFIG_RTW88_DEBUGFS=3Dy

On Fri, Apr 28, 2023 at 9:28=E2=80=AFPM Larry Finger <Larry.Finger@lwfinger=
.net> wrote:
>
> On 4/28/23 08:56, Gabriel Tisan wrote:
> > Hi !
> >
> > I use a LM842 wifi stick on a Linux kernel 5.15 with last patches for
> > rtw88 from linux-next applied.
> > Firmware version is 9.9.15
> >
> > When I connect LM842 as a station to an AP, after the link is up first
> > time, it comes from time to time more LOWER_UP message.
> > The stick is plugged and the connection to AP is still valid.
> >
> > # ip -oneline -family inet monitor link
> >
> > 5: wlan0: <BROADCAST,MULTICAST> mtu 1500 qdisc noqueue state DOWN
> > group default \    link/ether 34:c9:f0:99:b6:a1 brd ff:ff:ff:ff:ff:ff
> >
> > 5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue
> > state DOWN group default \    link/ether 34:c9:f0:99:b6:a1 brd
> > ff:ff:ff:ff:ff:ff
> >
> > 5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue
> > state DOWN group default \    link/ether 34:c9:f0:99:b6:a1 brd
> > ff:ff:ff:ff:ff:ff
> >
> > 5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP> \    link/ether
> >
> > 5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
> > noqueue state DORMANT group default \    link/ether 34:c9:f0:99:b6:a1
> > brd ff:ff:ff:ff:ff:ff
> >
> > 5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
> >
> > 5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
> >
> > 5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
> >
> > 5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
> > state UP group default \    link/ether 34:c9:f0:99:b6:a1 brd
> > ff:ff:ff:ff:ff:ff
> >
> >
> >
> > 5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
> >
> > 5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
> >
> > 5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
> >
> > 5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
> >
> > 5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
> >
> > 5: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
> >
> >
> >
> >
> >
> > Any idea what I can do ?
> >
> > Did someone also reproduce that problem ?
>
> No, I do not see that problem. When I run your command, I get
>
> finger@localhost:~/rtw88>ip -oneline -family inet monitor link
> 12: wlp0s20u6i2: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
> 12: wlp0s20u6i2: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
> 12: wlp0s20u6i2: <BROADCAST,MULTICAST,UP,LOWER_UP> \    link/ether
>
> My connection is very stable; however, my device is an 8822BU, not an 882=
2CU.
>
> When the connection is dropped, what is logged? You can see that with a '=
sudo
> dmesg | less' command.
>
> Larry
>
>
