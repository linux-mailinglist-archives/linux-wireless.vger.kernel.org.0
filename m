Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F423D5959
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jul 2021 14:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhGZLky (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Jul 2021 07:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbhGZLkw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Jul 2021 07:40:52 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1B4C061757
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jul 2021 05:21:20 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g13so15022068lfj.12
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jul 2021 05:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tHdu2jb51/4H/FJCFUKY3zs0KeeJaysn0FNTsgYNYUw=;
        b=sTpG0cUz7jcNDvFHpIT8T/B6ecJsol4s1UL7t9px5pOShNEiGlfDTROVPQn6uownpJ
         KyOmJ5x5a8ugbDZdBfzW8msla2b6pVqiSMDlKDaTYXg2e0fZOzRcSfvYghCFkcrTJ3IC
         BXuSX0aSJdgdgszHoIrdyzKH38JoJVNTSJHO6opggxt5gsC++xty9iM7P4duhgISi4Jb
         CQx0W7a5fTyduOexn98Q8hi5wNFmPTGSdy523Uo9N4z5WzbHkOHj/cZIBLXSmDyn7L3b
         tsPFn4v66xJdbr1vURMvzBAW0u9Fwy7fxtS+uaG9eihw3Akl+jBinA3WdvWUCM03JKkH
         YmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tHdu2jb51/4H/FJCFUKY3zs0KeeJaysn0FNTsgYNYUw=;
        b=qOP5Ww6BrngIjLwl0RWr5iofQpu3FIgVuDV55IAbzsWtCaYzE1Wz9PCGOGAfLD8xlc
         yEVq7ihzBswgSj2gYnONazCbT+PPnkhR9dytILLkn6+KWC7FSDRaKlNTdBOKn+jA6ga6
         HLpESopLR3N3ueVc92RvX5DVe6UjjI8wWGTLCy2TV5eAxMaRcM5l3hdHrc2C3tvkFaT2
         KFLz4nRefF+d9xM4x8sQZo3C0G/JGYiWEhE74BSLcoxhB3zHprF0fh81QTtHsAcxYKyr
         zgX1Jb1JvPDbxFRcgtq9j+yNg6MQJKp+fmmr8xuFnBee07KBdvtNAe6h18Q+fUSaw2g3
         EcoA==
X-Gm-Message-State: AOAM530ECLNeA7fmrs4Sytgy+wju2fd7uH7HfTmFIALTRQJNEy3rGY4E
        uGGcFxdD4CROrizShHTgUo8=
X-Google-Smtp-Source: ABdhPJwaMhLJkVaq2Eliq8VABRsWwGYK63T33dKM2PZ9JvjQoaN5RodNydF20tF8zjRKPA3bCCmCSA==
X-Received: by 2002:a05:6512:1697:: with SMTP id bu23mr1055347lfb.576.1627302078952;
        Mon, 26 Jul 2021 05:21:18 -0700 (PDT)
Received: from smtpclient.apple (84-10-202-70.dynamic.chello.pl. [84.10.202.70])
        by smtp.gmail.com with ESMTPSA id t7sm3662108ljc.81.2021.07.26.05.21.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jul 2021 05:21:18 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: Current mainline brcmfmac reports error on supposedly supported
 ap6256 chip
From:   Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <28fdbe0c-023d-82a3-877b-7b158b109e52@broadcom.com>
Date:   Mon, 26 Jul 2021 14:21:17 +0200
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ondrej Jirman <megous@megous.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A76C51D0-C73B-43B0-9AE3-ABB4AED6AB86@gmail.com>
References: <CB0AA0D2-A8F3-4217-A3C1-E14D7E9FF11E@gmail.com>
 <17ad94781a0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <6F6333F3-0BDB-48AF-B445-723958ABA8C9@gmail.com>
 <be6c2b7f-2c85-59fb-3013-d0590c487c51@broadcom.com>
 <53E7119F-D158-4EF0-940C-D0AA59C23CF6@gmail.com>
 <3da7f271-0c5c-50de-375a-a8c67ca127f5@broadcom.com>
 <286E2774-FAA5-47E3-A1FC-FDB09EB37FDC@gmail.com>
 <1a5588e2-38fc-1ec2-580a-30ae03ee73e1@broadcom.com>
 <28fdbe0c-023d-82a3-877b-7b158b109e52@broadcom.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend,

Neil Armstrong hinted me issue might be related to usage of memcpy() =
to/from an iomem mapping.
arm64 memcpy update (285133040e6c ("arm64: Import latest =
memcpy()/memmove() implementation")) triggers a memory abort when =
dram-access-quirk
is used on the G12A/G12B platforms.

I reverted =
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/dr=
ivers/mmc/host/meson-gx-mmc.c?h=3Dv5.13.4&id=3D103a5348c22c3fca8b96c735a9e=
353b8a0801842

and got nicely working wifi.

So it looks root cause is amlogic specific - not brcmfmac.

Sorry for false report and many many thx for Your head-up!
 =20
br

> Wiadomo=C5=9B=C4=87 napisana przez Arend van Spriel =
<arend.vanspriel@broadcom.com> w dniu 26.07.2021, o godz. 11:39:
>=20
> On 7/26/2021 11:37 AM, Arend van Spriel wrote:
>> + linux-wireless, + Ondrej
>> Hoi Piotr,
>> Please reply to all. This might interest others with a similar =
device.
>> On 7/26/2021 11:31 AM, Piotr Oniszczuk wrote:
>>> Arend,
>>>=20
>>> pls find dmesg with extra prints you proposed:
>>>=20
>>> [  144.634234] brcmfmac: brcmfmac_module_init No platform data =
available.
>>> [  144.638974] brcmfmac: brcmf_sdio_probe Enter
>>> [  144.643057] brcmfmac: F1 signature read @0x18000000=3D0x15294345
>>> [  144.648718] brcmfmac: brcmf_chip_recognition found AXI chip: =
BCM4345/9
>>> [  144.656662] brcmfmac: brcmf_chip_cores_check  [1 ] core 0x800:51 =
base 0x18000000 wrap 0x18100000
>>> [  144.663690] brcmfmac: brcmf_chip_cores_check  [2 ] core 0x812:54 =
base 0x18001000 wrap 0x18101000
>>> [  144.672346] brcmfmac: brcmf_chip_cores_check  [3 ] core 0x83e:9  =
base 0x18002000 wrap 0x18102000
>>> [  144.681031] brcmfmac: brcmf_chip_cores_check  [4 ] core 0x83c:14 =
base 0x18003000 wrap 0x18103000
>>> [  144.689683] brcmfmac: brcmf_chip_cores_check  [5 ] core 0x829:21 =
base 0x18004000 wrap 0x18104000
>>> [  144.698365] brcmfmac: brcmf_chip_cores_check  [6 ] core 0x135:0  =
base 0x00000000 wrap 0x18107000
>>> [  144.707019] brcmfmac: brcmf_chip_cores_check  [7 ] core 0x240:0  =
base 0x00000000 wrap 0x00000000
>>> [  144.715678] brcmfmac: brcmf_chip_set_passive Enter
>>> [  144.722499] brcmfmac: brcmf_chip_tcm_ramsize: up 0 corecap 0 nab =
0 nbb 0
>> I see. That helps. Let me come up with a patch for this.
>> [...]
>>> btw:
>>> to be sure about is my DT correct i done following tests:
>>> 1.boot my distro binary on other board with ap6256 (radxa-rockpi4b). =
works ok
>>> 2.selective disable wifi pwrseq and clock dt fragments. disabling =
stops chip detection so indirectly concluding my dt fragments seems to =
be ok
>> The fact that the wifi device is probed is enough proof. There may be =
some additional clocks needed, but for now it looks like SDIO bus is =
properly functioning to access the device.
>=20
> ...but feel free to share the DT source so I can have a look.
>=20
> Regards,
> Arend

