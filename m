Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791C63D56E2
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jul 2021 11:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhGZJNb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Jul 2021 05:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbhGZJNb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Jul 2021 05:13:31 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850C5C061757
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jul 2021 02:53:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f18so14360496lfu.10
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jul 2021 02:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OiX3w7SGEmf89ZnPLPLfkWiVuRSZ9+n7IB/TlS12A1s=;
        b=sHqpAe5sP87trHU35SbMwGZkMQTXs/0uQXIhl/xFGhhrL9DwRaI3+EsW3HlCn7KcOQ
         yiqoH9ih+1qWZNSkHWddQHFsiYbgS85WwEuFI97Scy+PNfPAGTWJ5NskdKLvyixfg40M
         HTTZiI2DeOAPFlbupFUwxFce/+46CLULBd9xN9drT9LQPt5Baf16bF/2W+Z7duwbmAYY
         BHd5B7U90dq3Rq5BBJ4twJX4+ZQJ3Cd/die2rWIV9bq7+wtrx0J3UJg4vDOda+Gebtp7
         SUpBCFdin3kufP0IJQLquGKJJM1BesFSHRRYCWU9z5xbLeRJCoy43oB5hLDqy38NGoe1
         tMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OiX3w7SGEmf89ZnPLPLfkWiVuRSZ9+n7IB/TlS12A1s=;
        b=d6EkQmHrYVi4UCE1ktwEdecvFQ7WRJGQPkbQafwo23wdcY2XjhhnngCDjJ64DMXAUy
         uPVl18K4J5c8mtXDP7AgDJKnXEifV45jQnt2tyx6y2shTDgDUNvMKomLkQqlOljA+u7n
         M04XSVt8fDyJnFrLuPvHylw/kc6ogEWJfxh5982iL4LH3ORCG+fV2jzw2RnNbZdgby2+
         DEjLkwfxY3iAaZn4IJ3a7wQlAxPdO0pCZaszo9YVU6fULzrQ705NKByTkbzp0rnONg6v
         yP8SOTPPLLYD1NsqWXF5193+mFNwcVNPN5aaN/AUOQHOt8/qXnNKqzUtxW/9UUb8SfHp
         fiqA==
X-Gm-Message-State: AOAM53213+EurtIWE8tHC0m+UAT2SDbobhmXX12y0H3JXeXWCq/KDr6+
        k0dXOHi1tp47zSbkrohLipg=
X-Google-Smtp-Source: ABdhPJys/fDEIj7ufi3Ot5uZGvaogP2SAIId+NaTWfPZnagiyAOb1naHt+JXxHr+smYOGhocyXlanw==
X-Received: by 2002:a05:6512:3d89:: with SMTP id k9mr12024269lfv.574.1627293235931;
        Mon, 26 Jul 2021 02:53:55 -0700 (PDT)
Received: from smtpclient.apple (84-10-202-70.dynamic.chello.pl. [84.10.202.70])
        by smtp.gmail.com with ESMTPSA id v5sm1872267lfa.143.2021.07.26.02.53.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jul 2021 02:53:55 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: Current mainline brcmfmac reports error on supposedly supported
 ap6256 chip
From:   Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <3da7f271-0c5c-50de-375a-a8c67ca127f5@broadcom.com>
Date:   Mon, 26 Jul 2021 11:53:51 +0200
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ondrej Jirman <megous@megous.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1CB17353-D253-4133-8D56-304B4B652AE5@gmail.com>
References: <CB0AA0D2-A8F3-4217-A3C1-E14D7E9FF11E@gmail.com>
 <17ad94781a0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <6F6333F3-0BDB-48AF-B445-723958ABA8C9@gmail.com>
 <be6c2b7f-2c85-59fb-3013-d0590c487c51@broadcom.com>
 <53E7119F-D158-4EF0-940C-D0AA59C23CF6@gmail.com>
 <3da7f271-0c5c-50de-375a-a8c67ca127f5@broadcom.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend,

pls find dmesg with extra prints you proposed:

[  144.634234] brcmfmac: brcmfmac_module_init No platform data =
available.
[  144.638974] brcmfmac: brcmf_sdio_probe Enter
[  144.643057] brcmfmac: F1 signature read @0x18000000=3D0x15294345
[  144.648718] brcmfmac: brcmf_chip_recognition found AXI chip: =
BCM4345/9
[  144.656662] brcmfmac: brcmf_chip_cores_check  [1 ] core 0x800:51 base =
0x18000000 wrap 0x18100000
[  144.663690] brcmfmac: brcmf_chip_cores_check  [2 ] core 0x812:54 base =
0x18001000 wrap 0x18101000
[  144.672346] brcmfmac: brcmf_chip_cores_check  [3 ] core 0x83e:9  base =
0x18002000 wrap 0x18102000
[  144.681031] brcmfmac: brcmf_chip_cores_check  [4 ] core 0x83c:14 base =
0x18003000 wrap 0x18103000
[  144.689683] brcmfmac: brcmf_chip_cores_check  [5 ] core 0x829:21 base =
0x18004000 wrap 0x18104000
[  144.698365] brcmfmac: brcmf_chip_cores_check  [6 ] core 0x135:0  base =
0x00000000 wrap 0x18107000
[  144.707019] brcmfmac: brcmf_chip_cores_check  [7 ] core 0x240:0  base =
0x00000000 wrap 0x00000000
[  144.715678] brcmfmac: brcmf_chip_set_passive Enter
[  144.722499] brcmfmac: brcmf_chip_tcm_ramsize: up 0 corecap 0 nab 0 =
nbb 0
[  144.727030] brcmfmac: brcmf_chip_get_raminfo RAM: base=3D0x198000 =
size=3D0 (0x0) sr=3D0 (0x0)
[  144.734989] brcmfmac: brcmf_chip_get_raminfo: RAM size is =
undetermined
[  144.741450] brcmfmac: brcmf_sdio_probe_attach: brcmf_chip_attach =
failed!
[  144.748099] brcmfmac: brcmf_sdio_probe: brcmf_sdio_probe_attach =
failed
[  144.754610] brcmfmac: brcmf_sdio_remove Enter
[  144.758869] brcmfmac: brcmf_detach Enter
[  144.762804] brcmfmac: brcmf_sdio_remove Disconnected
[  144.767760] brcmfmac: brcmf_ops_sdio_probe: F2 error, probe failed =
-19...
[  144.774615] usbcore: registered new interface driver brcmfmac


DT i'm using: https://pastebin.com/yHAb6gn3



> Wiadomo=C5=9B=C4=87 napisana przez Arend van Spriel =
<arend.vanspriel@broadcom.com> w dniu 26.07.2021, o godz. 09:54:
>=20
> + linux-wireless, + Ondrej (who added support for 4345 rev 9)
>=20
> On 7/25/2021 12:16 AM, Piotr Oniszczuk wrote:
>>> Wiadomo=C5=9B=C4=87 napisana przez Arend van Spriel =
<arend.vanspriel@broadcom.com> w dniu 24.07.2021, o godz. 23:20:
>>>=20
>>>=20
>>> I am not so sure what is going on so maybe you can apply the patch =
below and see what comes out.
>>>=20
>>> Regards,
>>> Arend
>>>=20
>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c =
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
>>> index 4faab0170ffa..71fb34753528 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
>>> @@ -691,9 +691,11 @@ static u32 brcmf_chip_tcm_ramsize(struct =
brcmf_core_priv *cr4)
>>>        nbb =3D (corecap & ARMCR4_TCBBNB_MASK) >> =
ARMCR4_TCBBNB_SHIFT;
>>>        totb =3D nab + nbb;
>>>=20
>>> +       brcmf_err("corecap %x nab %u nbb %u\n", corecap, nab, nbb);
>>>        for (idx =3D 0; idx < totb; idx++) {
>>>                brcmf_chip_core_write32(cr4, ARMCR4_BANKIDX, idx);
>>>                bxinfo =3D brcmf_chip_core_read32(cr4, =
ARMCR4_BANKINFO);
>>> +               brcmf_err("[%3u] %08x\n", idx, bxinfo);
>>>                memsize +=3D ((bxinfo & ARMCR4_BSZ_MASK) + 1) * =
ARMCR4_BSZ_MULT;
>>>        }
>>>=20
>>>=20
>> Arend
>> Pls find dmesg output with patch:
>> [  121.226458] brcmfmac: brcmfmac_module_init No platform data =
available.
>> [  121.227955] brcmfmac: brcmf_sdio_probe Enter
>> [  121.232119] brcmfmac: F1 signature read @0x18000000=3D0x15294345
>> [  121.237659] brcmfmac: brcmf_chip_recognition found AXI chip: =
BCM4345/9
>> [  121.245832] brcmfmac: brcmf_chip_cores_check  [1 ] core 0x800:51 =
base 0x18000000 wrap 0x18100000
>> [  121.252695] brcmfmac: brcmf_chip_cores_check  [2 ] core 0x812:54 =
base 0x18001000 wrap 0x18101000
>> [  121.261363] brcmfmac: brcmf_chip_cores_check  [3 ] core 0x83e:9  =
base 0x18002000 wrap 0x18102000
>> [  121.270071] brcmfmac: brcmf_chip_cores_check  [4 ] core 0x83c:14 =
base 0x18003000 wrap 0x18103000
>> [  121.278783] brcmfmac: brcmf_chip_cores_check  [5 ] core 0x829:21 =
base 0x18004000 wrap 0x18104000
>> [  121.287508] brcmfmac: brcmf_chip_cores_check  [6 ] core 0x135:0  =
base 0x00000000 wrap 0x18107000
>> [  121.296206] brcmfmac: brcmf_chip_cores_check  [7 ] core 0x240:0  =
base 0x00000000 wrap 0x00000000
>> [  121.304917] brcmfmac: brcmf_chip_set_passive Enter
>> [  121.312079] brcmfmac: brcmf_chip_tcm_ramsize: corecap 0 nab 0 nbb =
0
>=20
> Well. That explains the fact that RAM size ends up being zero. I want =
to be sure the ARM CR4 core is up so can you retry using the patch =
below. It is just getting bit more info, no fix.
>=20
> Regards,
> Arend
>=20
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c =
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
> index 4faab0170ffa..b829ad2f3865 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/chip.c
> @@ -691,9 +691,12 @@ static u32 brcmf_chip_tcm_ramsize(struct =
brcmf_core_priv *cr4)
>        nbb =3D (corecap & ARMCR4_TCBBNB_MASK) >> ARMCR4_TCBBNB_SHIFT;
>        totb =3D nab + nbb;
>=20
> +       brcmf_err("up %d corecap %x nab %u nbb %u\n",
> +               brcmf_chip_iscoreup(&cr4->pub), corecap, nab, nbb);
>        for (idx =3D 0; idx < totb; idx++) {
>                brcmf_chip_core_write32(cr4, ARMCR4_BANKIDX, idx);
>                bxinfo =3D brcmf_chip_core_read32(cr4, =
ARMCR4_BANKINFO);
> +               brcmf_err("[%3u] %08x\n", idx, bxinfo);
>                memsize +=3D ((bxinfo & ARMCR4_BSZ_MASK) + 1) * =
ARMCR4_BSZ_MULT;
>        }
>=20

