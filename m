Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86DBD104972
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 04:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfKUDwr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 22:52:47 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37441 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKUDwr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 22:52:47 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so1378419lfp.4
        for <linux-wireless@vger.kernel.org>; Wed, 20 Nov 2019 19:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nD1tqekK7jGCJ092l88MQqyQtjp/BERcKf1sy8U541k=;
        b=nBgyuofQscFz37P5OserOpazD80c0HXBi0VceI19pmTpQclZ8CnWxadWlyKG76yNdp
         DJG5uQAT6yLyynHsD2OBwqP8njJIkIOeC6K32dTfgRloU7BEfd58ApwOqrdK7A5YYpaB
         BxiSyxXOjZVj9iH6H9HzQf+yODI6ENzOyB8/8HeX14jjZvuac3kNgfrAVQpFI9VUitwo
         K0Kud28kVh9QJMCLrY9UiiXVSF1BW6+0NzSxREv98xS7pzW/MsJOJ/gdBE5SD7wTBkPY
         UF7PDKYhglkumdsxEEMzHjqW9GbgywbFnfSVtIqtl9WtGLz4f6+GtwAKp2QX1zXVpycm
         w/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nD1tqekK7jGCJ092l88MQqyQtjp/BERcKf1sy8U541k=;
        b=FmdQYqnLYH1/ZyRTty0uwoxGk3hVrVhgCs++EPFku5lReC9PMclcWqAA5i/rf9UhLz
         Ep+/b/kfxM1Ud4S4Ge3P38RAQbcqAEmIWHWheMEqMmYaN4RNk1HC6Qbz6NcYY0c7Ikpu
         n1q+vjOsv68GtF81rDfUd8tvqIKCSWLVC2onr7cnkNj7lrXeTWtATWM86izPi23r6BU4
         Sv2S1o1ePax4fW6GGJRlA097dKKnH1/bGxKe1jzPtvF3OFUy+CZsosNubZ/avfDe5KMw
         SFcIi6HhS0pvGhZ1SsqBUnadS25LBIplaEgIClN42zreZW3Xu2QErgDAdgnvYNL81PLi
         PQkQ==
X-Gm-Message-State: APjAAAU8etfSf3vsnWY01IRNBiQ0LNKkeqivcq/0TPStDP4T7MwjkWUY
        5l9AMaQMRuy7ZA9p+Yj/diA=
X-Google-Smtp-Source: APXvYqz+rb5p3HOB2QsMKMY7WlC0Pbq9XLjUxAPAL2kpL7W3BMmbZHyPcnrgniW4erzqnTg4UN/wjA==
X-Received: by 2002:ac2:5222:: with SMTP id i2mr5512653lfl.138.1574308363018;
        Wed, 20 Nov 2019 19:52:43 -0800 (PST)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 190sm503086ljj.72.2019.11.20.19.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 19:52:42 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RESEND] brcmfmac support for BCM4359 sdio on arm64 ??
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <db1e6182-d8fe-a68a-e769-b6460c68fab0@broadcom.com>
Date:   Thu, 21 Nov 2019 07:52:37 +0400
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, Wright.Feng@cypress.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8CDC4B4E-D131-4590-9A63-DDD87FAE1D79@gmail.com>
References: <F5C2858A-498E-4AD3-859D-FA9D14BF6B37@gmail.com>
 <37d2964d-1c2b-51bd-ac98-2cc171aa0c9c@broadcom.com>
 <30516339-BAD7-40F4-980B-D30CDF504A08@gmail.com>
 <db1e6182-d8fe-a68a-e769-b6460c68fab0@broadcom.com>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> On 24 Jun 2019, at 11:04 pm, Arend Van Spriel =
<arend.vanspriel@broadcom.com> wrote:
>=20
> Hi Christian,
>=20
> Here it is. Hopefully unmangled this time.
>=20
> Regards,
> Arend
> ---
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c =
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> index ec129864cc9c..7be8064c6dc7 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> @@ -785,7 +785,8 @@ void brcmf_sdiod_sgtable_alloc(struct =
brcmf_sdio_dev *sdiodev)
>                      sdiodev->settings->bus.sdio.txglomsz);
>        nents +=3D (nents >> 4) + 1;
>=20
> -       WARN_ON(nents > sdiodev->max_segment_count);
> +       WARN(nents > sdiodev->max_segment_count, "max_seg_cnt=3D%u, =
host_max_seg=3D%u, nents=3D%u\n",
> +                sdiodev->max_segment_count, host->max_segs, nents);
>=20
>        brcmf_dbg(TRACE, "nents=3D%d\n", nents);
>        err =3D sg_alloc_table(&sdiodev->sgtable, nents, GFP_KERNEL);

Hello Arend,

I=E2=80=99ve resumed testing on 5.4-rc8 with ^ this patch and =
https://github.com/chewitt/linux/commit/07fd0f25ceb72b15aa8c3fbd149aa41cbc=
55d035 applied and brcmfmac.debug=3D30 in boot params. Here is more =
extended output:

[    6.115132] brcmfmac: brcmfmac_module_init No platform data =
available.
[    6.116841] brcmfmac: brcmf_sdio_probe Enter
[    6.118695] brcmfmac: F1 signature read @0x18000000=3D0x17294359
[    6.118910] brcmfmac: brcmf_chip_recognition found AXI chip: =
BCM4359/9
[    6.120687] brcmfmac: brcmf_chip_cores_check  [1 ] core 0x800:52 base =
0x18000000 wrap 0x18100000
[    6.120692] brcmfmac: brcmf_chip_cores_check  [2 ] core 0x812:59 base =
0x18001000 wrap 0x18101000
[    6.120695] brcmfmac: brcmf_chip_cores_check  [3 ] core 0x83e:8  base =
0x18002000 wrap 0x18102000
[    6.120697] brcmfmac: brcmf_chip_cores_check  [4 ] core 0x83c:21 base =
0x18003000 wrap 0x18103000
[    6.120698] brcmfmac: brcmf_chip_cores_check  [5 ] core 0x812:59 base =
0x18004000 wrap 0x18104000
[    6.120700] brcmfmac: brcmf_chip_cores_check  [6 ] core 0x829:22 base =
0x18005000 wrap 0x18105000
[    6.120702] brcmfmac: brcmf_chip_cores_check  [7 ] core 0x840:5  base =
0x1800a000 wrap 0x00000000
[    6.120703] brcmfmac: brcmf_chip_cores_check  [8 ] core 0x135:0  base =
0x00000000 wrap 0x18109000
[    6.120704] brcmfmac: brcmf_chip_cores_check  [9 ] core 0x240:0  base =
0x00000000 wrap 0x00000000
[    6.120706] brcmfmac: brcmf_chip_set_passive Enter
[    6.121378] brcmfmac: brcmf_chip_get_raminfo RAM: base=3D0x180000 =
size=3D917504 (0xe0000) sr=3D0 (0x0)
[    6.121438] brcmfmac: brcmf_chip_setup ccrev=3D52, pmurev=3D26, =
pmucaps=3D0x3a0c3f1a
[    6.121441] brcmfmac: brcmf_get_module_param Enter, bus=3D0, =
chip=3D17241, rev=3D9
[    6.121618] brcmfmac: brcmf_sdiod_sgtable_alloc nents=3D35
[    6.121621] brcmfmac: brcmf_sdio_kso_init Enter
[    6.121635] brcmfmac: brcmf_sdio_drivestrengthinit No SDIO driver =
strength init needed for chip BCM4359/9 rev 9 pmurev 26
[    6.121998] brcmfmac: brcmf_sdio_probe completed!!
[    6.122003] brcmfmac: brcmf_fw_alloc_request: using =
brcm/brcmfmac4359-sdio for chip BCM4359/9
[    6.122008] brcmfmac: brcmf_fw_get_firmwares enter: dev=3Dmmc0:0001:1
[    6.293561] brcmfmac: brcmf_fw_complete_request firmware =
brcm/brcmfmac4359-sdio.bin found
[    6.309769] brcmfmac: brcmf_fw_complete_request firmware =
brcm/brcmfmac4359-sdio.txt found
[    6.309772] brcmfmac: brcmf_fw_request_nvram_done enter: =
dev=3Dmmc0:0001:1
[    6.309840] brcmfmac: brcmf_fw_request_nvram_done nvram =
000000007040259b len 3564
[    6.309843] brcmfmac: brcmf_sdio_firmware_callback Enter: =
dev=3Dmmc0:0001:1, err=3D0
[    8.206959] brcmfmac: brcmf_sdio_download_code_file Enter
[    8.272184] brcmfmac: brcmf_sdio_verifymemory Compare RAM dl & ul at =
0x00180000; size=3D636647
[    8.354229] brcmfmac: brcmf_sdio_download_nvram Enter
[    8.359730] brcmfmac: brcmf_sdio_verifymemory Compare RAM dl & ul at =
0x0025f214; size=3D3564
[    8.367550] brcmfmac: brcmf_sdiod_ramrw: membytes transfer failed
[    8.373550] brcmfmac: brcmf_sdio_verifymemory: error -84 on reading =
2048 membytes at 0x0025f214
[    8.382188] brcmfmac: brcmf_sdio_download_firmware: dongle nvram file =
download failed
[    8.389982] brcmfmac: brcmf_sdio_firmware_callback failed: =
dev=3Dmmc0:0001:1, err=3D-5
[    8.397514] brcmfmac: brcmf_sdio_remove Enter
[    8.402641] brcmfmac: brcmf_detach Enter
[    8.434899] brcmfmac: brcmf_chip_set_passive Enter
[    8.458772] brcmfmac: brcmf_sdio_remove Disconnected

I=E2=80=99m using renamed nvram.txt and fw_bcm4359c0_ag_apsta.bin from =
the bcmdhd.1.579.77.41.x driver (https://github.com/chewitt/bcmdhd/). In =
the full dmesg: https://pastebin.com/raw/DUUGSjWw there is some kernel =
splat starting 6.121488 that appears to be from probing. FWIW, the BT =
side of the device appears to be working fine.

Any suggestions?

Christian

