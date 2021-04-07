Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B60635689F
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Apr 2021 12:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350479AbhDGKA7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Apr 2021 06:00:59 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:25484 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350459AbhDGKAy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Apr 2021 06:00:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210407100043euoutp028a07eb2e4b0dfaf3bc4e9ee5263d9ef9~zixwDgpae2609626096euoutp02B
        for <linux-wireless@vger.kernel.org>; Wed,  7 Apr 2021 10:00:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210407100043euoutp028a07eb2e4b0dfaf3bc4e9ee5263d9ef9~zixwDgpae2609626096euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617789643;
        bh=PvT6cFmmP71AswJ7SDiyOkDSI0jObzmpj0ySUIejIgE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=C29U8Opq84BDBs+TegIiPxs0vouXmeQIORBWeo5ABPyJO1wLOhY7eqLpV8Vdkm8rt
         uHFSznRhT8N3ypCELGJvOq5ujjxE6hKr8C5EOfrs1DGxXSX22Ke80WgjbntKg/2w0h
         a54C8SYVDeUxCT8omOVuibyGMwl5KbipO0a3+DYk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210407100043eucas1p24a9f2cb2f22b1d256c3ae53542ed4a7e~zixviJsXr1645816458eucas1p2t;
        Wed,  7 Apr 2021 10:00:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 09.8C.09444.AC28D606; Wed,  7
        Apr 2021 11:00:42 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210407100042eucas1p1cacccace69bca24675145a8652fd0dcc~zixuxtiAi3200232002eucas1p1F;
        Wed,  7 Apr 2021 10:00:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210407100042eusmtrp190966ed7536afe7ed7dd569ea461115d~zixuwwNxv0934909349eusmtrp1c;
        Wed,  7 Apr 2021 10:00:42 +0000 (GMT)
X-AuditID: cbfec7f4-dd5ff700000024e4-58-606d82ca9b58
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 92.D7.08696.AC28D606; Wed,  7
        Apr 2021 11:00:42 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210407100041eusmtip103c552285d38f6d684c4428a5b0b2405~zixt8ywco3087030870eusmtip15;
        Wed,  7 Apr 2021 10:00:41 +0000 (GMT)
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
Message-ID: <b03a1ae1-2e61-a8cc-ce52-a3bc1613f2bb@samsung.com>
Date:   Wed, 7 Apr 2021 12:00:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <aa920eb6-788d-b0b8-c99a-839d73a8c748@baylibre.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsWy7djP87qnmnITDNbNt7T4v/YWi8XGGetZ
        LT63tDFZLFn3gtniza/1jBY/Fr1gs/jx6AaLxaL3M1gtes71MFssmM1tceR/P6PFmxV32C2O
        LTrJYnGoL9riwr57bA78Hu9vtLJ7zLp/ls1j56y77B5PJ0xm95i9axKLx+Yl9R59W1Yxenze
        JBfAEcVlk5Kak1mWWqRvl8CV8eHHJ5aCDquK319/sTQwXjDsYuTkkBAwkbhz4jdbFyMXh5DA
        CkaJzyvesEA4Xxgl1r1fB+V8ZpT4+WoeM0zLtjuHGEFsIYHljBLP/glB2B8ZJaY2xYPYwgL2
        Eovb/rKD2CIClxkllv+qARnELLCVWeLluldgzWwChhJdb7vYQGxeATuJDT2zmEBsFgEViUdd
        U8GWiQokSSx99I8RokZQ4uTMJywgNqeAg8TeI/PBepkF5CWat85mhrDFJW49mc8EcehqTom7
        sxO6GDmAbBeJm7cLIcLCEq+Ob2GHsGUkTk/uAXtSQqCZUeLhubXsEE4Po8TlphmMEFXWEnfO
        /WIDGcQsoCmxfpc+RNhRYsfLrUwQ8/kkbrwVhDiBT2LStunMEGFeiY42IYhqNYlZx9fBrT14
        4RLzBEalWUgem4XkmVlInpmFsHcBI8sqRvHU0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwER3
        +t/xLzsYl7/6qHeIkYmD8RCjBAezkgjvjt7sBCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8SVvW
        xAsJpCeWpGanphakFsFkmTg4pRqYlAq+zjlka15gsXXLoceulju2Zx2a2JArdahNycd6qfKx
        D2EFN6Im7jtYYMM+7aNT05q0R1y2UyKvNDt+0jr+J6zR9+qF3/tfC4tUP698HxLTberzyyrm
        Fxenx4te6d1z/s/bc3zxREV9t7Zlqd9O/lKPj5fx/mCp+HWXWJLNrmXteq/EatguHVU5lRHO
        4XwtZlsO1wzm+jcfDZzCHkvPvhbTt/3LlsM2j5+l5M7Y7CUflL+2cc7qj5s+rPCt+GCbY5Yb
        Xx7KsX2LoPUFIeOKL801nIx6BiEt9wWSrNQlewT9nTSnWN+NTzhx+TfP2Q1mtdLmi6+HTlAu
        /XI7cm3K4liVvZ7/z24NM9Pl4A1SYinOSDTUYi4qTgQAAjWgSuMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsVy+t/xu7qnmnITDC41s1v8X3uLxWLjjPWs
        Fp9b2pgslqx7wWzx5td6Rosfi16wWfx4dIPFYtH7GawWPed6mC0WzOa2OPK/n9HizYo77BbH
        Fp1ksTjUF21xYd89Ngd+j/c3Wtk9Zt0/y+axc9Zddo+nEyaze8zeNYnFY/OSeo++LasYPT5v
        kgvgiNKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DL
        +PDjE0tBh1XF76+/WBoYLxh2MXJySAiYSGy7c4ixi5GLQ0hgKaPE//ZJzBAJGYmT0xpYIWxh
        iT/Xutggit4zSqz7d4sdJCEsYC+xuO0vO0hCROAio0TD08OsIA6zwHZmif6NP6BaXjJJPN20
        mQmkhU3AUKLrLcgsTg5eATuJDT2zwOIsAioSj7qmgu0WFUiSaNs9kx2iRlDi5MwnLCA2p4CD
        xN4j88F6mQXMJOZtfsgMYctLNG+dDWWLS9x6Mp9pAqPQLCTts5C0zELSMgtJywJGllWMIqml
        xbnpucVGesWJucWleel6yfm5mxiBMb7t2M8tOxhXvvqod4iRiYPxEKMEB7OSCO+O3uwEId6U
        xMqq1KL8+KLSnNTiQ4ymQP9MZJYSTc4HJpm8knhDMwNTQxMzSwNTSzNjJXFekyNr4oUE0hNL
        UrNTUwtSi2D6mDg4pRqYWHiOn0pYkLlz9vFJxzruv2lYf7Td2d1FusxYRMwg6YDQS++kg29C
        bLcolp979oD7ujjPTR+med3XF3zzDUmfWFO9y8WoLO/BkpnBL76EVCks5J9n0bdn9YuEaa8/
        2vALit1tV1x+ZtKJMPWNlap/r93gemP979hVreVuE7d6iqVzy0wSYpnRyKwf+OGIi+cqVSc3
        OZefuX5K1w7N9xHV71h1Xy7XXNbqpi5Ll8a1jsqoRdvd6t9Pv2cY+fhf5drG9/FhfEsvd4lz
        5efyqxjnsX73+2vkfpbLp+RSwd+WBpY7YgqSYo//dByVXPtr8t0v6375SFd0ayx4WeShckDO
        c5lem43CgnBWndxvlo1KLMUZiYZazEXFiQCS828NegMAAA==
X-CMS-MailID: 20210407100042eucas1p1cacccace69bca24675145a8652fd0dcc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210209124819eucas1p29c9b481ef524a753ce79aa6ab580d0a7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210209124819eucas1p29c9b481ef524a753ce79aa6ab580d0a7
References: <CGME20210209124819eucas1p29c9b481ef524a753ce79aa6ab580d0a7@eucas1p2.samsung.com>
        <967b6bfe-a612-707f-583e-c45d61acffe0@samsung.com>
        <ab81cc00-049f-67a5-bc97-417d7cd2fa44@baylibre.com>
        <1e55e4cf-3ed6-0506-2e17-b94ca8043008@samsung.com>
        <459fb404-7370-190f-379d-751956e887df@baylibre.com>
        <aa920eb6-788d-b0b8-c99a-839d73a8c748@baylibre.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Neil,

On 07.04.2021 10:45, Neil Armstrong wrote:
> On 10/02/2021 09:52, Neil Armstrong wrote:
>> On 10/02/2021 09:45, Marek Szyprowski wrote:
>>> On 10.02.2021 09:17, Neil Armstrong wrote:
>>>> On 09/02/2021 13:48, Marek Szyprowski wrote:
>>>>> I've noticed that the Broadcom Wifi chip performs unaligned SDIO access
>>>>> during the station scan on Khadas VIM3l board. This issue went unnoticed
>>>>> so far, because there was a workaround in the meson MMC driver, which
>>>>> has been recently disabled by commit e085b51c74cc ("mmc: meson-gx: check
>>>>> for scatterlist size alignment in block mode") from current linux-next.
>>>>>
>>>>> I can easily reproduce this issue with the following commands:
>>>>>
>>>>> # dmesg | grep brcm
>>>>> [   11.659351] Bluetooth: hci0: BCM4359C0 'brcm/BCM4359C0.hcd' Patch
>>>>> [   13.079767] brcmfmac: brcmf_fw_alloc_request: using
>>>>> brcm/brcmfmac4359-sdio for chip BCM4359/9
>>>>> [   13.527363] brcmfmac: brcmf_fw_alloc_request: using
>>>>> brcm/brcmfmac4359-sdio for chip BCM4359/9
>>>>> [   13.601269] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available
>>>>> (err=-11), device may have limited channels available
>>>>> [   13.619414] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4359/9 wl0:
>>>>> Mar  6 2017 10:16:06 version 9.87.51.7 (r686312) FWID 01-4dcc75d9
>>>>> # ifconfig wlan0 up
>>>>> [  208.052058] ieee80211 phy0: brcmf_dongle_roam: WLC_SET_ROAM_TRIGGER
>>>>> error (-52)
>>>>> # iw wlan0 scan >/dev/null
>>>>> [  218.148345] ------------[ cut here ]------------
>>>>> [  218.148501] unaligned sg len 504 blksize 256
>>>>> [  218.153712] WARNING: CPU: 1 PID: 75 at
>>>>> drivers/mmc/host/meson-gx-mmc.c:251
>>>>> meson_mmc_get_transfer_mode.isra.10+0xf8/0x130
>>>>> [  218.162616] Modules linked in: ipv6 brcmfmac brcmutil cfg80211
>>>>> dw_hdmi_cec dw_hdmi_i2s_audio hci_uart btqca btbcm bluetooth
>>>>> ecdh_generic ecc crct10dif_ce rfkill panfrost
>>>>> snd_soc_meson_axg_sound_card snd_soc_meson_card_utils gpu_sched
>>>>> meson_gxbb_wdt rtc_hym8563 pwm_meson meson_gxl rtc_meson_vrtc rc_khadas
>>>>> meson_ir reset_meson_audio_arb realtek snd_soc_meson_g12a_tohdmitx
>>>>> snd_soc_meson_codec_glue snd_soc_meson_axg_tdmout
>>>>> snd_soc_meson_axg_frddr snd_soc_meson_axg_fifo axg_audio sclk_div
>>>>> clk_phase mdio_mux_meson_g12a meson_dw_hdmi meson_drm meson_rng
>>>>> dwmac_generic snd_soc_meson_axg_tdm_interface meson_canvas rng_core
>>>>> dw_hdmi snd_soc_meson_axg_tdm_formatter dwmac_meson8b stmmac_platform
>>>>> stmmac display_connector adc_keys pcs_xpcs nvmem_meson_efuse
>>>>> [  218.228329] CPU: 1 PID: 75 Comm: kworker/u8:2 Not tainted
>>>>> 5.11.0-rc6-next-20210208 #2492
>>>>> [  218.236343] Hardware name: Khadas VIM3L (DT)
>>>>> [  218.240579] Workqueue: brcmf_wq/mmc2:0001:1 brcmf_sdio_dataworker
>>>>> [brcmfmac]
>>>>> [  218.247559] pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=--)
>>>>> [  218.253506] pc : meson_mmc_get_transfer_mode.isra.10+0xf8/0x130
>>>>> [  218.259372] lr : meson_mmc_get_transfer_mode.isra.10+0xf8/0x130
>>>>> [  218.265237] sp : ffff80001327b870
>>>>> [  218.268514] x29: ffff80001327b870 x28: 0000000000000003
>>>>> [  218.273776] x27: 0000000000000218 x26: 0000000000000600
>>>>> [  218.279036] x25: ffff000003a17678 x24: 0000000000000000
>>>>> [  218.284296] x23: ffff8000121cfae8 x22: ffff800011b54000
>>>>> [  218.289559] x21: ffff80001327bb18 x20: ffff00000277d000
>>>>> [  218.294819] x19: ffff80001327ba40 x18: 00000002faf07f80
>>>>> [  218.300081] x17: 0000000000004000 x16: 0000000000000000
>>>>> [  218.305341] x15: 0000000000000380 x14: 0000000000000000
>>>>> [  218.310603] x13: 0000000000000080 x12: 0000000000000000
>>>>> [  218.315865] x11: 0000000000000000 x10: 0000000000001370
>>>>> [  218.321125] x9 : ffff00006f995258 x8 : 000000009e0e7ca7
>>>>> [  218.326387] x7 : ffff80001327b4a0 x6 : 0000000000000001
>>>>> [  218.331648] x5 : 0000000000000001 x4 : 0000000000000000
>>>>> [  218.336912] x3 : 0000000000000002 x2 : ffff8000121f4768
>>>>> [  218.342171] x1 : 42fe1bd05e5eaa00 x0 : 0000000000000000
>>>>> [  218.347435] Call trace:
>>>>> [  218.349854]  meson_mmc_get_transfer_mode.isra.10+0xf8/0x130
>>>>> [  218.355368]  meson_mmc_request+0x74/0xb0
>>>>> [  218.359250]  __mmc_start_request+0xa4/0x2b0
>>>>> [  218.363390]  mmc_start_request+0x80/0xa8
>>>>> [  218.367272]  mmc_wait_for_req+0x68/0xd8
>>>>> [  218.371066]  mmc_submit_one.isra.17+0x78/0x148 [brcmfmac]
>>>>> [  218.376416]  brcmf_sdiod_sglist_rw+0x324/0x4a8 [brcmfmac]
>>>>> [  218.381762]  brcmf_sdiod_recv_chain+0x70/0x140 [brcmfmac]
>>>>> [  218.387110]  brcmf_sdio_dataworker+0x614/0x17d0 [brcmfmac]
>>>>> [  218.392545]  process_one_work+0x2a8/0x728
>>>>> [  218.396510]  worker_thread+0x48/0x460
>>>>> [  218.400132]  kthread+0x134/0x160
>>>>> [  218.403323]  ret_from_fork+0x10/0x18
>>>>> [  218.406862] irq event stamp: 15834
>>>>> [  218.410222] hardirqs last  enabled at (15833): [<ffff800010f95804>]
>>>>> _raw_spin_unlock_irq+0x3c/0x80
>>>>> [  218.419107] hardirqs last disabled at (15834): [<ffff800010f895ac>]
>>>>> el1_dbg+0x24/0x50
>>>>> [  218.426869] softirqs last  enabled at (15828): [<ffff800010010508>]
>>>>> _stext+0x508/0x638
>>>>> [  218.434717] softirqs last disabled at (15823): [<ffff8000100952ec>]
>>>>> irq_exit+0x19c/0x1a8
>>>>> [  218.442739] ---[ end trace dfc38bb4458b4c37 ]---
>>>>> #
>>>>>
>>>>> Surprisingly the same commands executed on the Khadas VIM3 board with
>>>>> the same kernel don't trigger the warning.
>>>> This may be because the VIM3 (G12A & G12B) has a broken SDIO controller using
>>>> an internal SRAM as bounce buffer instead of the scatter/gather DMA, cf amlogic,dram-access-quirk.
>>> Good to know, this explains why it works without an issue on VIM3.
>>>>> Let me know if I can help debugging this issue.
>>>> Simply remove the WARN_ONCE()...
>>> Well, that WARN is not a big issue for me. I just wanted to help fixing
>>> the real issue. If I understand right, the brcmfmac driver queues
>>> incorrectly prepared sd list for the given transfer mode, what should be
>>> fixed there.
>> I think the issue comes from brcmfmac that should not provide unaligned data,
>> but I think it's a global issue where these kind of details aren't specified/enforced.
>>
>>> On the other hand, if this is just a limitation of the meson mmc
>>> controller on SM1/VIM3l, then imho there should not be a WARN there and
>>> maybe the mentioned 'amlogic,dram-access-quirk' could be used to fix the
>>> issue on VIM3l too. I've checked and it indeed 'fixes' the issue on that
>>> board.
>> This fix severely limits the performance so it's not a good fix here,
>> the only fix I see here is to remove the WARN because the fact is that the DMA cannot handle
>> unaligned data, and the SDIO device drivers should be fixed in order to achieve max
>> performance on SDIO host drivers with DMA (it's usual to not support unaligned data
>> when dealing with a DMA).
> Do you plan to remove the warning ? I can push a quick patch if not.

Feel free to send such 'fix'. I thought I would have some spare time to 
dig in the brcmfmac driver to fix the real source of the problem, but it 
turned out opposite...

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

