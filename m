Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 274831051FE
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 13:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfKUMBS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 07:01:18 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45383 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfKUMBR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 07:01:17 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so2380495lfa.12
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 04:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=boWKTeB6khEOwIl0I5RdVGlTHJHiqXsdPQsdomvNhDE=;
        b=YV8wPmVE/opkzmpjYXix18jGhim0Ae6450LxXKlDJec44OOOR9SzTEGJiAgZKccQD4
         liYCuC4L2SYRlYt1ESFEi2DFQtaFBc/gabh5ImRvZfnP3t7SXvjNZSOnE1m/mq6if1dh
         njRJqDIENNvtyQ4VEs7b7F+oaY0twKfl4SZ01cCVakJA7SCEPkl/zPeYiiV2zbHlHM9d
         427WyGomupQgKcI7lbPomHhzucx5q1UfXbV/bI5hpwbg9F47itXq2Cm6CG529qiJ79Xm
         V5o46ns8Jl3Ljt9E7cMnQJkwBtvY/jyItUEMwKV2n6a45YZUmGBjU2djEAWvsQZJmet5
         l2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=boWKTeB6khEOwIl0I5RdVGlTHJHiqXsdPQsdomvNhDE=;
        b=MUZO1g+GxdY2jWyiWjOofujos+eORcnqylFHx3RWpf3ku9Bh8qH6KPR9rTNIeMl0Qh
         Xhc2p4wefQ6+ZQFQsU9GIYpGCiKg6M3E+LhzH9ieD7HSC+OHE3lF0PGLlMX+MoUu9eqn
         Fk/BjBxoWiwL2AqO5bjML6u0L6h7cDqyJGqLOWAC8yZO+XWtb+ijOW32eKCZfpTy7306
         Fgf5nCv2dzUKdupkNkqsXeqnBh/DE3TOwms4DH/l/jEJGwcW7lLqD+bZZZ0cJjKjstO6
         eT5JB0smeiwot1FFshIcNMm2YkA1XRoOnJDgH/oUsTF6wxBj3SUlh+G3Stn8jGQUWtv7
         R2fA==
X-Gm-Message-State: APjAAAVOGv2/xZ48kmNc1IPoBEpj68KFf1qMBC8iejGfzYxVz+zg1o/S
        7P3H2hqzEH91ys6JPjHdvMA=
X-Google-Smtp-Source: APXvYqxd9o5tFfANhBp3yYMHMv6tv5kEY9tlkk1gK4eMNAvXBwzIMgnJvI7vZG6LbPC4y1rQTNS0pA==
X-Received: by 2002:ac2:52b3:: with SMTP id r19mr7015390lfm.109.1574337674448;
        Thu, 21 Nov 2019 04:01:14 -0800 (PST)
Received: from [172.28.50.205] ([5.195.225.226])
        by smtp.gmail.com with ESMTPSA id r7sm1142058ljc.74.2019.11.21.04.01.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 04:01:13 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RESEND] brcmfmac support for BCM4359 sdio on arm64 ??
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <cf2d4640-21b0-dc95-6f67-8c3639e6d8b3@broadcom.com>
Date:   Thu, 21 Nov 2019 16:01:09 +0400
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, Wright.Feng@cypress.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <25DA691B-1804-4801-9A3E-1F29B1AC4D13@gmail.com>
References: <F5C2858A-498E-4AD3-859D-FA9D14BF6B37@gmail.com>
 <37d2964d-1c2b-51bd-ac98-2cc171aa0c9c@broadcom.com>
 <30516339-BAD7-40F4-980B-D30CDF504A08@gmail.com>
 <db1e6182-d8fe-a68a-e769-b6460c68fab0@broadcom.com>
 <8CDC4B4E-D131-4590-9A63-DDD87FAE1D79@gmail.com>
 <cf2d4640-21b0-dc95-6f67-8c3639e6d8b3@broadcom.com>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> On 21 Nov 2019, at 1:00 pm, Arend Van Spriel =
<arend.vanspriel@broadcom.com> wrote:
>=20
> On 11/21/2019 4:52 AM, Christian Hewitt wrote:
>>> On 24 Jun 2019, at 11:04 pm, Arend Van Spriel =
<arend.vanspriel@broadcom.com> wrote:
>>>=20
>>> Hi Christian,
>>>=20
>>> Here it is. Hopefully unmangled this time.
>>>=20
>>> Regards,
>>> Arend
>>> ---
>>> diff --git =
a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c =
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>> index ec129864cc9c..7be8064c6dc7 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>> @@ -785,7 +785,8 @@ void brcmf_sdiod_sgtable_alloc(struct =
brcmf_sdio_dev *sdiodev)
>>>                      sdiodev->settings->bus.sdio.txglomsz);
>>>        nents +=3D (nents >> 4) + 1;
>>>=20
>>> -       WARN_ON(nents > sdiodev->max_segment_count);
>>> +       WARN(nents > sdiodev->max_segment_count, "max_seg_cnt=3D%u, =
host_max_seg=3D%u, nents=3D%u\n",
>>> +                sdiodev->max_segment_count, host->max_segs, nents);
>>>=20
>>>        brcmf_dbg(TRACE, "nents=3D%d\n", nents);
>>>        err =3D sg_alloc_table(&sdiodev->sgtable, nents, GFP_KERNEL);
>> Hello Arend,
>> I=E2=80=99ve resumed testing on 5.4-rc8 with ^ this patch and =
https://github.com/chewitt/linux/commit/07fd0f25ceb72b15aa8c3fbd149aa41cbc=
55d035 applied and brcmfmac.debug=3D30 in boot params. Here is more =
extended output:
>> [    6.115132] brcmfmac: brcmfmac_module_init No platform data =
available.
>> [    6.116841] brcmfmac: brcmf_sdio_probe Enter
>> [    6.118695] brcmfmac: F1 signature read @0x18000000=3D0x17294359
>> [    6.118910] brcmfmac: brcmf_chip_recognition found AXI chip: =
BCM4359/9
>> [    6.120687] brcmfmac: brcmf_chip_cores_check  [1 ] core 0x800:52 =
base 0x18000000 wrap 0x18100000
>> [    6.120692] brcmfmac: brcmf_chip_cores_check  [2 ] core 0x812:59 =
base 0x18001000 wrap 0x18101000
>> [    6.120695] brcmfmac: brcmf_chip_cores_check  [3 ] core 0x83e:8  =
base 0x18002000 wrap 0x18102000
>> [    6.120697] brcmfmac: brcmf_chip_cores_check  [4 ] core 0x83c:21 =
base 0x18003000 wrap 0x18103000
>> [    6.120698] brcmfmac: brcmf_chip_cores_check  [5 ] core 0x812:59 =
base 0x18004000 wrap 0x18104000
>> [    6.120700] brcmfmac: brcmf_chip_cores_check  [6 ] core 0x829:22 =
base 0x18005000 wrap 0x18105000
>> [    6.120702] brcmfmac: brcmf_chip_cores_check  [7 ] core 0x840:5  =
base 0x1800a000 wrap 0x00000000
>> [    6.120703] brcmfmac: brcmf_chip_cores_check  [8 ] core 0x135:0  =
base 0x00000000 wrap 0x18109000
>> [    6.120704] brcmfmac: brcmf_chip_cores_check  [9 ] core 0x240:0  =
base 0x00000000 wrap 0x00000000
>> [    6.120706] brcmfmac: brcmf_chip_set_passive Enter
>> [    6.121378] brcmfmac: brcmf_chip_get_raminfo RAM: base=3D0x180000 =
size=3D917504 (0xe0000) sr=3D0 (0x0)
>> [    6.121438] brcmfmac: brcmf_chip_setup ccrev=3D52, pmurev=3D26, =
pmucaps=3D0x3a0c3f1a
>> [    6.121441] brcmfmac: brcmf_get_module_param Enter, bus=3D0, =
chip=3D17241, rev=3D9
>> [    6.121618] brcmfmac: brcmf_sdiod_sgtable_alloc nents=3D35
>> [    6.121621] brcmfmac: brcmf_sdio_kso_init Enter
>> [    6.121635] brcmfmac: brcmf_sdio_drivestrengthinit No SDIO driver =
strength init needed for chip BCM4359/9 rev 9 pmurev 26
>> [    6.121998] brcmfmac: brcmf_sdio_probe completed!!
>> [    6.122003] brcmfmac: brcmf_fw_alloc_request: using =
brcm/brcmfmac4359-sdio for chip BCM4359/9
>> [    6.122008] brcmfmac: brcmf_fw_get_firmwares enter: =
dev=3Dmmc0:0001:1
>> [    6.293561] brcmfmac: brcmf_fw_complete_request firmware =
brcm/brcmfmac4359-sdio.bin found
>> [    6.309769] brcmfmac: brcmf_fw_complete_request firmware =
brcm/brcmfmac4359-sdio.txt found
>> [    6.309772] brcmfmac: brcmf_fw_request_nvram_done enter: =
dev=3Dmmc0:0001:1
>> [    6.309840] brcmfmac: brcmf_fw_request_nvram_done nvram =
000000007040259b len 3564
>> [    6.309843] brcmfmac: brcmf_sdio_firmware_callback Enter: =
dev=3Dmmc0:0001:1, err=3D0
>> [    8.206959] brcmfmac: brcmf_sdio_download_code_file Enter
>> [    8.272184] brcmfmac: brcmf_sdio_verifymemory Compare RAM dl & ul =
at 0x00180000; size=3D636647
>> [    8.354229] brcmfmac: brcmf_sdio_download_nvram Enter
>> [    8.359730] brcmfmac: brcmf_sdio_verifymemory Compare RAM dl & ul =
at 0x0025f214; size=3D3564
>> [    8.367550] brcmfmac: brcmf_sdiod_ramrw: membytes transfer failed
>> [    8.373550] brcmfmac: brcmf_sdio_verifymemory: error -84 on =
reading 2048 membytes at 0x0025f214
>> [    8.382188] brcmfmac: brcmf_sdio_download_firmware: dongle nvram =
file download failed
>> [    8.389982] brcmfmac: brcmf_sdio_firmware_callback failed: =
dev=3Dmmc0:0001:1, err=3D-5
>> [    8.397514] brcmfmac: brcmf_sdio_remove Enter
>> [    8.402641] brcmfmac: brcmf_detach Enter
>> [    8.434899] brcmfmac: brcmf_chip_set_passive Enter
>> [    8.458772] brcmfmac: brcmf_sdio_remove Disconnected
>> I=E2=80=99m using renamed nvram.txt and fw_bcm4359c0_ag_apsta.bin =
from the bcmdhd.1.579.77.41.x driver =
(https://github.com/chewitt/bcmdhd/). In the full dmesg: =
https://pastebin.com/raw/DUUGSjWw there is some kernel splat starting =
6.121488 that appears to be from probing. FWIW, the BT side of the =
device appears to be working fine.
>> Any suggestions?
>=20
> This is a differing issue, right? Sorry it has been a while back and I =
did not search for your earlier emails.
>=20
> The error -84 is -EILSEQ which we get from SDIO layer. I think this is =
returned when CRC errors occur on the SDIO bus. It would trigger a =
retune in the host controller.
>=20
> Were you seeing similar issues on earlier kernel?

BCM4359 has mainline support for some time as a PCIe device. I=E2=80=99m =
attempting SDIO support by patching ID=E2=80=99s to the usual places.

I=E2=80=99ve seen the probing kernel splat on probing on all kernels =
I=E2=80=99ve attempted to use. I=E2=80=99ve been attempting since ~4.19.

I=E2=80=99m testing with a selection of Amlogic boards/boxes covering =
Amlogic=E2=80=99s GXM, G12A, G12B and SM1 platforms. The G12*/SM1 boards =
are based on the OEM vendor reference design with relatively minor =
variations between them. I have G12B boxes (same base platform) that =
work fine with other Ampak modules. I have devices of all varieties that =
have the same Ampak ap6398s module. In all cases the BT side works fine, =
but the WiFi shows the errors ^ above.

I don=E2=80=99t see any special handling for the BCM4359 in the bcmdhd =
code, but it appears to be grouped alongside 4349/4355 chips:

=
https://github.com/chewitt/bcmdhd/blob/f7009015df77fdeb35f9c7d6925f83861ac=
c54f3/include/sbchipc.h#L3989

None of those chips appear in current mainline code under the SDIO path =
(4355 shows under PCIe) so my guess is that it=E2=80=99s not CRC errors, =
but these chips need a slightly different firmware loading process. I =
don=E2=80=99t see any special ifdef/handling for BCM4359 in the bcmdhd =
code, but then I=E2=80=99m not a coding developer so my ability to read =
and understand the code is limited.

Recent-ish bcmdhd code is known/working on the same hardware with minor =
nip/tuck changes:

=
https://gitlab.com/baylibre/amlogic/atv/linux/commits/narmstrong/v5.1/aml/=
integ-5.1-bcmdhd

Christian











