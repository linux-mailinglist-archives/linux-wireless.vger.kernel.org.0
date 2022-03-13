Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484AA4D7261
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Mar 2022 05:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiCMEDC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Mar 2022 23:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiCMEDB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Mar 2022 23:03:01 -0500
Received: from mail.longlandclan.id.au (eth2015.qld.adsl.internode.on.net [150.101.176.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DCEC6350E
        for <linux-wireless@vger.kernel.org>; Sat, 12 Mar 2022 20:01:51 -0800 (PST)
Received: from mail.longlandclan.id.au (localhost [127.0.0.1])
        by mail.longlandclan.id.au (Postfix) with ESMTP id C7275808F44;
        Sun, 13 Mar 2022 14:01:49 +1000 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=longlandclan.id.au; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=
        virtatomos; bh=yD3mIoC4KSV9AoRIV5aPUFR9jic=; b=x24LnD+aG6oYLEm8/
        9tylN/AIFuLYQ+lg65gXIrdM8cm9JkGP7MvHfkfJkAI1rGiJVvqA+fYEHuVXaE7R
        gXpi003PDgOKBmfbURQmzj7/kpdb8mzq2nJzW7F1PvsR685wea2sAL9n3GoUJZnw
        Om0Y/o+ddAg0x/5ZqCMxnPvtmHh6ZXnCy46am4bK9KtUo05aGnYnTOHk4FoJncbv
        8AkAQlimytCPXEffigUxjAqGMA2bV9sLQlblVYk8WBOLeIxNWAe8qPpkHfqe3+09
        gb0glUI5eq7vszNjw847Lb23WTGR+3DlVTlyYV/MrCvSgskriU4nBWEj6MQ7iPwy
        ZKeBp+UqAd0Euub49MiiRTf7uxKex31aPvLswO1rpFVgdgIudJrd3xr3YYx1wt6A
        /hffne7sizO+h2c2aYiFGArE8sW5SA6AC/4bC8vf11zNRtqlYxLswTvNd7Lh/aJA
        CTGXfCFkOsGL3gvOgZRH7iiWzWaoydCIxzNCBrIkcjVTnG0bXWyaQQTpR2sIiy97
        7szEGWJUGQ/MoVYX/b2jf7P2GxgjPbLxYwoncENdjTF0BK34JtiRHPbnyqDVOFLQ
        TTUBIlxpX/cPaCE8dcUMLkdgcz37ETnn2TdPJu9u71RcuYW8fpywOeLeAmlqDqdH
        KX2ROdA9/PqNj1Fu+/RxpfPv9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=longlandclan.id.au; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; q=dns; s=
        virtatomos; b=DzgAr6ynVECboyI5PVeJP88rvntZP19fBzkfZVDwLXcnJgtgYo
        He4qodf5R2ahPmIZ7QSGNt9d3KGKcSdvw/74DqgsKGGoeXTzzFOYONqezrZJMD2K
        fiyvEjOG2T0Hzk4pAu4q+aUG6DDFwVAKMmzrCXncLOhNEDZ95IJzO3T+66hgjN3D
        siJhXi9fwJc+bRkOXVT+cxndpvoKBsrhIsQ2OLFtOJjNW7hD6I8pnPEDDxctJQwN
        oRuZjEenvQvPRXWEDo59qvvhVx12nBJfaw4xrbUB3wpTwOIHnrGvdQ+XJysIKxUT
        /+DlQ9EX6UawKDKLeJ+OWbiJsjwqTcE39qpq/6B7OPxNmMbrTT5SGS1g8JrUtNsx
        sIU30TDW66ZJVrV3LTm+mYLl8Royl2Lj5Pwgr3k2QbvrT/crOFBxBQEo81AyiqdB
        Hq66QZl+tYSRQNq4YCsLruZU9eWTjOHgJBc4okfOp/ZSwJo8w9bqpvt1q8AFYSIQ
        KI4v//dYc4l5f17+6ysBE+NNtMzJzJUCd721Cxse406J1QBaudAhlYH8Fd7i2ctI
        g2TeZLyD0b0v8HU/w8zOlMNl2P1pFT2eP7S2vMaIZs/gQO1kk01yfryhAYqO5hPd
        W9zYmMNvzKizO0dmyLlwYZOTvkj8qqtVv29Z0gX+SwP6p6+mi9FwuSqas=
Received: from localhost (unknown [IPv6:2001:44b8:21ac:7053:a64e:31ff:fe53:99cc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.longlandclan.id.au (Postfix) with ESMTPSA id 908E9808F43;
        Sun, 13 Mar 2022 14:01:46 +1000 (EST)
Date:   Sun, 13 Mar 2022 14:01:41 +1000
From:   Stuart Longland <stuartl@longlandclan.id.au>
To:     Pkshih <pkshih@realtek.com>
Cc:     Bogdan Nicolae <bogdan.nicolae@acm.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: No support for Realtek 8821CE RFE Type 6
Message-ID: <20220313140141.6c736d8a@longlandclan.id.au>
In-Reply-To: <3f5e2f6eac344316b5dd518ebfea2f95@realtek.com>
References: <CA+ORkNR97EvqPzHu-CoJXwKGH-HQ4B++57RE88MEF-mG=D=Jeg@mail.gmail.com>
        <46a80ab50f594ec1af1016ca272e82fd@realtek.com>
        <CA+ORkNQ_shEZGYQUmRT-_uSp3xkFA2fvfUbyGXzGkP6AmqXf6Q@mail.gmail.com>
        <e57352ddd0644463b398d6dc0a6e6a86@realtek.com>
        <CA+ORkNSzju=Oj4wy8s258exeWOSLEHRAfCoS+ViF-rprdtEr6g@mail.gmail.com>
        <3f5e2f6eac344316b5dd518ebfea2f95@realtek.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 8 Nov 2021 03:28:07 +0000
Pkshih <pkshih@realtek.com> wrote:

> > > 2. If you boot this system into Windows 10, does the 8821CE work prop=
erly?
> > >    If so, please give me its VID/PID of PCI.

Found a second specimen that does the same thing.  Yes, the WiFi
adaptor works under Windows 10.  (Felt dirty booting that crummy OS up,
but it was done for "science".)

Windows device detail: http://static.vk4msl.id.au/2022/03/13-rtl8821ce/wifi=
-detail.png
Linux `lspci`: http://static.vk4msl.id.au/2022/03/13-rtl8821ce/lspci.txt

The `dmesg` from SysRescueCD 9.01 (AMD64):
http://static.vk4msl.id.au/2022/03/13-rtl8821ce/dmesg-sysrescuecd-9.01-amd6=
4.txt

The Bluetooth part is detected:
[   29.648630] Bluetooth: hci0: RTL: examining hci_ver=3D08 hci_rev=3D000c =
lmp_ver=3D08 lmp_subver=3D8821
[   29.664180] Bluetooth: hci0: RTL: rom_version status=3D0 version=3D1
[   29.664185] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_fw.bin
[   29.680954] Bluetooth: hci0: RTL: loading rtl_bt/rtl8821c_config.bin
[   29.683629] Bluetooth: hci0: RTL: cfg_sz 10, total sz 31990

The WiFi part reports this error:
[   30.754716] rtw_8821ce 0000:03:00.0: enabling device (0000 -> 0003)
[   30.772302] rtw_8821ce 0000:03:00.0: Firmware version 24.8.0, H2C versio=
n 12
[   30.790815] rtw_8821ce 0000:03:00.0: rfe 6 isn't supported
[   30.790927] rtw_8821ce 0000:03:00.0: failed to setup chip efuse info
[   30.790930] rtw_8821ce 0000:03:00.0: failed to setup chip information

=E2=80=A6 now to try that patch.
--=20
Stuart Longland (aka Redhatter, VK4MSL)

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
