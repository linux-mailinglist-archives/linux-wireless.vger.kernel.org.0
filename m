Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5805316175
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 09:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhBJIsi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 03:48:38 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51035 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhBJIq7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 03:46:59 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210210084559euoutp010c2648cb52d844385f836e0168678412~iVogigjgl2107421074euoutp01n
        for <linux-wireless@vger.kernel.org>; Wed, 10 Feb 2021 08:45:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210210084559euoutp010c2648cb52d844385f836e0168678412~iVogigjgl2107421074euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612946759;
        bh=4uJSGa1TfdOfEhSXCqgziPI+ALzIxcEebiXthFYP30g=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=beCKnnTn77zBFU2VyDmhc2PCQqM8SRrXj3cPIyiJdF7bgxUk7VDyqxkEhewg1SeW1
         TysGjFaGukvik4ouUYMqWsiaOIBffAWqLD4bfkh4jesfLQDlhafnWigqp9BwnOz6W+
         7HYek5ML8pB6/lQFsXZrAuwW/wNeABTO3Yyy6QzY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210210084558eucas1p21f436aa920071ec3b19186036fa4d66a~iVogGLhN-1462614626eucas1p2f;
        Wed, 10 Feb 2021 08:45:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 24.B9.27958.64D93206; Wed, 10
        Feb 2021 08:45:58 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210210084558eucas1p1df3f5c4520e5dd609d18390d3e2b8150~iVofqNw-R1410214102eucas1p1-;
        Wed, 10 Feb 2021 08:45:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210210084558eusmtrp2432414728e0516ef5600d96d282018df~iVofpcX0P1807318073eusmtrp2Y;
        Wed, 10 Feb 2021 08:45:58 +0000 (GMT)
X-AuditID: cbfec7f2-efdff70000006d36-68-60239d4637d9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B5.F2.21957.64D93206; Wed, 10
        Feb 2021 08:45:58 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210210084557eusmtip26d8be496f08288b1035b44c322e1fd94~iVoeyaa6s1352113521eusmtip2W;
        Wed, 10 Feb 2021 08:45:57 +0000 (GMT)
Subject: Re: brcmfmac and unaligned sdio access on Khadas VIM3L
To:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        linux-amlogic@lists.infradead.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        martin.blumenstingl@googlemail.com,
        Dmitry Lebed <lebed.dmitry@gmail.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <1e55e4cf-3ed6-0506-2e17-b94ca8043008@samsung.com>
Date:   Wed, 10 Feb 2021 09:45:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <ab81cc00-049f-67a5-bc97-417d7cd2fa44@baylibre.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djPc7puc5UTDPa3q1n8X3uLxWLjjPWs
        Fp9b2pgslqx7wWzx5td6Rosfi16wWfx4dIPFYtH7GawWPed6mC0WzOa2OPK/n9HizYo77BbH
        Fp1ksTjUF21xYd89Ngd+j/c3Wtk9Zt0/y+axc9Zddo+nEyaze8zeNYnFY/OSeo++LasYPT5v
        kgvgiOKySUnNySxLLdK3S+DKeLuokbFgtkHFkUftjA2MizS7GDk5JARMJOZf2szexcjFISSw
        glGicctmVgjnC6PEhLmNbBDOZ0aJN/OOsMO0dOx/xgKRWM4o8a53PiNIQkjgI6PEsoXmILaw
        gL3E4ra/YA0iApcZJZb/qgFpYBbYyizxct0rsAY2AUOJrrddbCA2r4CdxKen75lBbBYBVYmJ
        /YvBbFGBJInlN/8wQdQISpyc+YQFxOYUcJCYc+U7mM0sIC/RvHU2M4QtLnHryXwmkGUSAqs5
        JZb1tQJdwQHkuEhM+KsA8YGwxKvjW6C+kZH4vxOmvplR4uG5tewQTg+jxOWmGYwQVdYSd879
        YgMZxCygKbF+lz5E2FFix8utTBDz+SRuvBWEuIFPYtK26cwQYV6JjjYhiGo1iVnH18GtPXjh
        EvMERqVZSD6bheSbWUi+mYWwdwEjyypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzAZHf6
        3/FPOxjnvvqod4iRiYPxEKMEB7OSCK/zTKUEId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryrZq+J
        FxJITyxJzU5NLUgtgskycXBKNTDlJi49EGJruXixEesDiwPigeopx2bd/O8ZviPkG3PPgY/e
        Vw+/Yfz85PPrgunXLRk0gz/+ua/LYvdLvHfCmwhp33X8fYnBq2/zC0r9U4u2PTpZNXuViPg3
        a9O1/T2chps8ukx4L/hOy633c33OvVJPOjh3U5LItR1v9RR8j5jxC3Ae2q+2c7W9sOjJzatz
        Pr+If1ZcqlY89Ya7T97xeqH+LAuFzInxXus23Ft64+aOCaW3X2by7dj/PKrc3WpR47uFwStz
        NdsztrN80fix2nZ19s2lIrs+Tj1VOueQRH5BY0r6lMy7Kzcd65r5ym7bXLlm7VVrmGf+TF1d
        9eLI935u8b9r3Uys5XuZIi4+8eFVYinOSDTUYi4qTgQALA5l4eUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsVy+t/xe7puc5UTDKZN4rD4v/YWi8XGGetZ
        LT63tDFZLFn3gtniza/1jBY/Fr1gs/jx6AaLxaL3M1gtes71MFssmM1tceR/P6PFmxV32C2O
        LTrJYnGoL9riwr57bA78Hu9vtLJ7zLp/ls1j56y77B5PJ0xm95i9axKLx+Yl9R59W1Yxenze
        JBfAEaVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX
        8XZRI2PBbIOKI4/aGRsYF2l2MXJySAiYSHTsf8bSxcjFISSwlFHi1+GdzBAJGYmT0xpYIWxh
        iT/Xutggit4zSvxZtZ8RJCEsYC+xuO0vO0hCROAio0TD08OsIA6zwHZmif6NP9hAqoQETjBK
        3NoeCWKzCRhKdL3tAovzCthJfHr6Hmwdi4CqxMT+xWC2qECSxONb95kgagQlTs58wgJicwo4
        SMy58h3MZhYwk5i3+SEzhC0v0bx1NpQtLnHryXymCYxCs5C0z0LSMgtJyywkLQsYWVYxiqSW
        Fuem5xYb6hUn5haX5qXrJefnbmIERvi2Yz8372Cc9+qj3iFGJg7GQ4wSHMxKIrzOM5UShHhT
        EiurUovy44tKc1KLDzGaAv0zkVlKNDkfmGLySuINzQxMDU3MLA1MLc2MlcR5t85dEy8kkJ5Y
        kpqdmlqQWgTTx8TBKdXAxBG0Ws0n07zuwsyvlT1LuHgSV6eHHT2owd3jLmX3cNsvHYnjikFL
        v3+6fn+v063rOTIui9+dXxoQcTJImJVfl/mYTc0xmV93Wi7Odj9yRmeJhI+hnsF8wUWS9bap
        ZZ1PIlxPBN00nLbDdGfXZRfniutLNR88clfJj126bu/XzIfTe6T7OBssl0+5s731UEFox9+U
        3wf2vLFYdn2huf5Jth+BCjtW23849z20r2kik7A9X11WddyfIO9PPa8v6W6Mt5qpfNGYeXNX
        WVj+2lOCsdb51tMnJhTlufL9WP/XPNtp+s7rK7VOiiVWvX300rji84NnP+L0j03+kyJXs3Tr
        Mcdm1eSt25ezrrt1LfdKsRJLcUaioRZzUXEiAIKdApd5AwAA
X-CMS-MailID: 20210210084558eucas1p1df3f5c4520e5dd609d18390d3e2b8150
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210209124819eucas1p29c9b481ef524a753ce79aa6ab580d0a7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210209124819eucas1p29c9b481ef524a753ce79aa6ab580d0a7
References: <CGME20210209124819eucas1p29c9b481ef524a753ce79aa6ab580d0a7@eucas1p2.samsung.com>
        <967b6bfe-a612-707f-583e-c45d61acffe0@samsung.com>
        <ab81cc00-049f-67a5-bc97-417d7cd2fa44@baylibre.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Neil,

On 10.02.2021 09:17, Neil Armstrong wrote:
> On 09/02/2021 13:48, Marek Szyprowski wrote:
>> I've noticed that the Broadcom Wifi chip performs unaligned SDIO access
>> during the station scan on Khadas VIM3l board. This issue went unnoticed
>> so far, because there was a workaround in the meson MMC driver, which
>> has been recently disabled by commit e085b51c74cc ("mmc: meson-gx: check
>> for scatterlist size alignment in block mode") from current linux-next.
>>
>> I can easily reproduce this issue with the following commands:
>>
>> # dmesg | grep brcm
>> [   11.659351] Bluetooth: hci0: BCM4359C0 'brcm/BCM4359C0.hcd' Patch
>> [   13.079767] brcmfmac: brcmf_fw_alloc_request: using
>> brcm/brcmfmac4359-sdio for chip BCM4359/9
>> [   13.527363] brcmfmac: brcmf_fw_alloc_request: using
>> brcm/brcmfmac4359-sdio for chip BCM4359/9
>> [   13.601269] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available
>> (err=-11), device may have limited channels available
>> [   13.619414] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4359/9 wl0:
>> Mar  6 2017 10:16:06 version 9.87.51.7 (r686312) FWID 01-4dcc75d9
>> # ifconfig wlan0 up
>> [  208.052058] ieee80211 phy0: brcmf_dongle_roam: WLC_SET_ROAM_TRIGGER
>> error (-52)
>> # iw wlan0 scan >/dev/null
>> [  218.148345] ------------[ cut here ]------------
>> [  218.148501] unaligned sg len 504 blksize 256
>> [  218.153712] WARNING: CPU: 1 PID: 75 at
>> drivers/mmc/host/meson-gx-mmc.c:251
>> meson_mmc_get_transfer_mode.isra.10+0xf8/0x130
>> [  218.162616] Modules linked in: ipv6 brcmfmac brcmutil cfg80211
>> dw_hdmi_cec dw_hdmi_i2s_audio hci_uart btqca btbcm bluetooth
>> ecdh_generic ecc crct10dif_ce rfkill panfrost
>> snd_soc_meson_axg_sound_card snd_soc_meson_card_utils gpu_sched
>> meson_gxbb_wdt rtc_hym8563 pwm_meson meson_gxl rtc_meson_vrtc rc_khadas
>> meson_ir reset_meson_audio_arb realtek snd_soc_meson_g12a_tohdmitx
>> snd_soc_meson_codec_glue snd_soc_meson_axg_tdmout
>> snd_soc_meson_axg_frddr snd_soc_meson_axg_fifo axg_audio sclk_div
>> clk_phase mdio_mux_meson_g12a meson_dw_hdmi meson_drm meson_rng
>> dwmac_generic snd_soc_meson_axg_tdm_interface meson_canvas rng_core
>> dw_hdmi snd_soc_meson_axg_tdm_formatter dwmac_meson8b stmmac_platform
>> stmmac display_connector adc_keys pcs_xpcs nvmem_meson_efuse
>> [  218.228329] CPU: 1 PID: 75 Comm: kworker/u8:2 Not tainted
>> 5.11.0-rc6-next-20210208 #2492
>> [  218.236343] Hardware name: Khadas VIM3L (DT)
>> [  218.240579] Workqueue: brcmf_wq/mmc2:0001:1 brcmf_sdio_dataworker
>> [brcmfmac]
>> [  218.247559] pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=--)
>> [  218.253506] pc : meson_mmc_get_transfer_mode.isra.10+0xf8/0x130
>> [  218.259372] lr : meson_mmc_get_transfer_mode.isra.10+0xf8/0x130
>> [  218.265237] sp : ffff80001327b870
>> [  218.268514] x29: ffff80001327b870 x28: 0000000000000003
>> [  218.273776] x27: 0000000000000218 x26: 0000000000000600
>> [  218.279036] x25: ffff000003a17678 x24: 0000000000000000
>> [  218.284296] x23: ffff8000121cfae8 x22: ffff800011b54000
>> [  218.289559] x21: ffff80001327bb18 x20: ffff00000277d000
>> [  218.294819] x19: ffff80001327ba40 x18: 00000002faf07f80
>> [  218.300081] x17: 0000000000004000 x16: 0000000000000000
>> [  218.305341] x15: 0000000000000380 x14: 0000000000000000
>> [  218.310603] x13: 0000000000000080 x12: 0000000000000000
>> [  218.315865] x11: 0000000000000000 x10: 0000000000001370
>> [  218.321125] x9 : ffff00006f995258 x8 : 000000009e0e7ca7
>> [  218.326387] x7 : ffff80001327b4a0 x6 : 0000000000000001
>> [  218.331648] x5 : 0000000000000001 x4 : 0000000000000000
>> [  218.336912] x3 : 0000000000000002 x2 : ffff8000121f4768
>> [  218.342171] x1 : 42fe1bd05e5eaa00 x0 : 0000000000000000
>> [  218.347435] Call trace:
>> [  218.349854]  meson_mmc_get_transfer_mode.isra.10+0xf8/0x130
>> [  218.355368]  meson_mmc_request+0x74/0xb0
>> [  218.359250]  __mmc_start_request+0xa4/0x2b0
>> [  218.363390]  mmc_start_request+0x80/0xa8
>> [  218.367272]  mmc_wait_for_req+0x68/0xd8
>> [  218.371066]  mmc_submit_one.isra.17+0x78/0x148 [brcmfmac]
>> [  218.376416]  brcmf_sdiod_sglist_rw+0x324/0x4a8 [brcmfmac]
>> [  218.381762]  brcmf_sdiod_recv_chain+0x70/0x140 [brcmfmac]
>> [  218.387110]  brcmf_sdio_dataworker+0x614/0x17d0 [brcmfmac]
>> [  218.392545]  process_one_work+0x2a8/0x728
>> [  218.396510]  worker_thread+0x48/0x460
>> [  218.400132]  kthread+0x134/0x160
>> [  218.403323]  ret_from_fork+0x10/0x18
>> [  218.406862] irq event stamp: 15834
>> [  218.410222] hardirqs last  enabled at (15833): [<ffff800010f95804>]
>> _raw_spin_unlock_irq+0x3c/0x80
>> [  218.419107] hardirqs last disabled at (15834): [<ffff800010f895ac>]
>> el1_dbg+0x24/0x50
>> [  218.426869] softirqs last  enabled at (15828): [<ffff800010010508>]
>> _stext+0x508/0x638
>> [  218.434717] softirqs last disabled at (15823): [<ffff8000100952ec>]
>> irq_exit+0x19c/0x1a8
>> [  218.442739] ---[ end trace dfc38bb4458b4c37 ]---
>> #
>>
>> Surprisingly the same commands executed on the Khadas VIM3 board with
>> the same kernel don't trigger the warning.
> This may be because the VIM3 (G12A & G12B) has a broken SDIO controller using
> an internal SRAM as bounce buffer instead of the scatter/gather DMA, cf amlogic,dram-access-quirk.
Good to know, this explains why it works without an issue on VIM3.
>> Let me know if I can help debugging this issue.
> Simply remove the WARN_ONCE()...

Well, that WARN is not a big issue for me. I just wanted to help fixing 
the real issue. If I understand right, the brcmfmac driver queues 
incorrectly prepared sd list for the given transfer mode, what should be 
fixed there.

On the other hand, if this is just a limitation of the meson mmc 
controller on SM1/VIM3l, then imho there should not be a WARN there and 
maybe the mentioned 'amlogic,dram-access-quirk' could be used to fix the 
issue on VIM3l too. I've checked and it indeed 'fixes' the issue on that 
board.

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

