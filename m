Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAB94D72C9
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Mar 2022 06:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiCMF0I (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Mar 2022 00:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiCMF0H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Mar 2022 00:26:07 -0500
X-Greylist: delayed 69125 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Mar 2022 21:24:59 PST
Received: from mail.longlandclan.id.au (virtatomos.longlandclan.id.au [IPv6:2001:44b8:21ac:70f9::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AEA93BA7F
        for <linux-wireless@vger.kernel.org>; Sat, 12 Mar 2022 21:24:58 -0800 (PST)
Received: from mail.longlandclan.id.au (localhost [127.0.0.1])
        by mail.longlandclan.id.au (Postfix) with ESMTP id 0F043808F65;
        Sun, 13 Mar 2022 15:24:55 +1000 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=longlandclan.id.au; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=
        virtatomos; bh=BuJIudgaq5viM2s+RZ37hYDpWXw=; b=nWziI6gH/kLZBmzV2
        Z/d2zR7P/3+pXLeuDR2MKnvJ6W76z0zw6+53EcvPw3OUPq09B4FSt8P4yAlsmv7I
        He9euEEVQy6eUhQ4gvdvyFjv23CgJiH3sgqa8pImHNuMT4pxkFh0p8fwT2J+N4ui
        NIzIRHT6ku7YYKZA4oT7fAlH1bf/FfsWw3d3vUjhQ18+D1/1NEKWGqWn7b9cLGoG
        sT4sWHdC+elqYzWcjC5WetIACy+EU2xkabnSf5X1t38Yar6ybJ51t9grDytY6K8J
        K05cOA51Ohht6kx6pRR0DPPlRfBYsLutaqKU8oY0jQGQefPsFTC+PaV9Zbkn/pM8
        SHVxx06D8KZ4Gm5QkRkfp8t+94/q8J5/SUZURxlzTpQ5nFr/nAMOOWHPpVNYnWbf
        oy+Iu4pPQWMLbcMkNb5VstVvskaMPpwRnN68GntWV1gpd+l1lsZv3Z6pzLBz3AWV
        ZgkcSNa1cmMmtImF83X6pxGNLfC+ycCnz3m7Y+OMZ9KumjtDeRLMJODKF/DNcpcy
        pi4aPoiJ7zsgGH/VXU8w2rqu5K2q318grvchEbxaOO1HxwyDdGlK7HDdYaAbbJsF
        VhGScXK6gywf+INycOom0bpn0DJaC2KgCSnkYjgEy4UHTWEbMqeWHQCdpwO7hZ8U
        6RmNaGIr44iBI7wPFbuiTCnsro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=longlandclan.id.au; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; q=dns; s=
        virtatomos; b=YNrLRyyOk8S8U5wDU3X20Se9WbW0Nd4rLXr+vqSKxiYqhhVU8/
        diCQRkSm9w655Msi5meeuB7+iD7+NQzk6aHgbh+1U6P91pAFi+E5MkXkt479fT+Z
        ubEJWEftcPsfNhu25NDnjPg77nCyJQrcxL/5h/rdvuwWgva6HV9xsHtS8NbrE7Cl
        jpxpWIwyBvVvjICKaNbNvkRouJRlBqlnKoi5M6zXt8np34Pxgd0jqHVV4D3VR7te
        GrNU1j8iy8De/wHwBnA+NgWEl7RKRI1XaK0guREcmIHyU2E9B3VaXCblHT9pSL+e
        MMW2EQcS7OUV8yF7warD7VOjb5+q5ulgB9DkQr4p7sRBqUzb1FOgIdbvYHXhq6eG
        94ikJiNOoPMhdggoA1WavgZkFtp0l45tnZfgB0A75zWyj0dKw+93ObyxdBZn5YGF
        kMoHLXknGo9BSVljeYN5YZXa2GOSu1loMdIJa0uzPM2LToO3hPRk/EeOGeRUNhlx
        wdZ+i/sxrdgML/pgS19N4U5wCHyA8WMc+WIuE4eAH0UvUAnXggwpAaJGFTKTnsI2
        tjuFIu+OX1ifBwKCzjNEDxdmpNVe1NSXx5Q523l0BY35FQyNuUnQh0C1biF8INWD
        aWe8PSDHV9pcCp5cBnAmP4PaqMQ8PcKQ3YQY5kQduV5FEx1JUmCK3quNI=
Received: from localhost (unknown [IPv6:2001:44b8:21ac:7053:a64e:31ff:fe53:99cc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.longlandclan.id.au (Postfix) with ESMTPSA id C41A4808F64;
        Sun, 13 Mar 2022 15:24:53 +1000 (EST)
Date:   Sun, 13 Mar 2022 15:24:51 +1000
From:   Stuart Longland <stuartl@longlandclan.id.au>
To:     Pkshih <pkshih@realtek.com>
Cc:     Bogdan Nicolae <bogdan.nicolae@acm.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: No support for Realtek 8821CE RFE Type 6
Message-ID: <20220313152451.692c1508@longlandclan.id.au>
In-Reply-To: <20220313140141.6c736d8a@longlandclan.id.au>
References: <CA+ORkNR97EvqPzHu-CoJXwKGH-HQ4B++57RE88MEF-mG=D=Jeg@mail.gmail.com>
        <46a80ab50f594ec1af1016ca272e82fd@realtek.com>
        <CA+ORkNQ_shEZGYQUmRT-_uSp3xkFA2fvfUbyGXzGkP6AmqXf6Q@mail.gmail.com>
        <e57352ddd0644463b398d6dc0a6e6a86@realtek.com>
        <CA+ORkNSzju=Oj4wy8s258exeWOSLEHRAfCoS+ViF-rprdtEr6g@mail.gmail.com>
        <3f5e2f6eac344316b5dd518ebfea2f95@realtek.com>
        <20220313140141.6c736d8a@longlandclan.id.au>
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

On Sun, 13 Mar 2022 14:01:41 +1000
Stuart Longland <stuartl@longlandclan.id.au> wrote:

> On Mon, 8 Nov 2021 03:28:07 +0000
> Pkshih <pkshih@realtek.com> wrote:
>=20
> > > > 2. If you boot this system into Windows 10, does the 8821CE work pr=
operly?
> > > >    If so, please give me its VID/PID of PCI.

> =E2=80=A6 now to try that patch.

The patch as given does not apply, but I managed to hand-fiddle it:

--- rtw8821c.c.orig     2022-03-13 15:13:34.406747572 +1000
+++ rtw8821c.c  2022-03-13 15:14:20.292573052 +1000
@@ -1498,6 +1498,7 @@
 static const struct rtw_rfe_def rtw8821c_rfe_defs[] =3D {
        [0] =3D RTW_DEF_RFE(8821c, 0, 0),
        [2] =3D RTW_DEF_RFE_EXT(8821c, 0, 0, 2),
+       [6] =3D RTW_DEF_RFE(8821c, 0, 0),
 };
=20
 static struct rtw_hw_reg rtw8821c_dig[] =3D {

This indeed fixes the problem:
http://static.vk4msl.id.au/2022/03/13-rtl8821ce/patched-dmesg.txt

[    4.166495] rtw_8821ce 0000:03:00.0: enabling device (0000 -> 0003)
[    4.173911] Loading firmware: rtw88/rtw8821c_fw.bin
[    4.185625] rtw_8821ce 0000:03:00.0: Firmware version 24.8.0, H2C versio=
n 12
[    4.273629] rtw_8821ce 0000:03:00.0 wlp3s0: renamed from wlan0
[    7.186954] rtw_8821ce 0000:03:00.0: start vif 0c:cf:89:ac:ac:be on port=
 0
[   16.074249] wlp3s0: authenticate with 7a:45:58:c8:b4:33
[   16.692213] wlp3s0: send auth to 7a:45:58:c8:b4:33 (try 1/3)
[   16.693038] wlp3s0: authenticated
[   16.711971] wlp3s0: associate with 7a:45:58:c8:b4:33 (try 1/3)
[   16.713480] wlp3s0: RX AssocResp from 7a:45:58:c8:b4:33 (capab=3D0x1111 =
status=3D0 aid=3D15)
[   16.713526] rtw_8821ce 0000:03:00.0: sta 7a:45:58:c8:b4:33 joined with m=
acid 0
[   16.713795] wlp3s0: associated
[   16.832337] IPv6: ADDRCONF(NETDEV_CHANGE): wlp3s0: link becomes ready
[   17.241966] rtw_8821ce 0000:03:00.0: failed to get tx report from firmwa=
re
--=20
Stuart Longland (aka Redhatter, VK4MSL)

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
