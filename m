Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF44314F77
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Feb 2021 13:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhBIMuB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Feb 2021 07:50:01 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44130 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhBIMtD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Feb 2021 07:49:03 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210209124819euoutp0184b79262a3e7b124a2881f67b37d7bbc~iFS0ZTKii0973009730euoutp01W
        for <linux-wireless@vger.kernel.org>; Tue,  9 Feb 2021 12:48:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210209124819euoutp0184b79262a3e7b124a2881f67b37d7bbc~iFS0ZTKii0973009730euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612874900;
        bh=WADn8AnZ90v/RRrY6lvRpiPwVJJcfXSCBiVTe+a3jl4=;
        h=From:Subject:To:Cc:Date:References:From;
        b=HcWkEGkuz3iHEAlZcpRqSlZ746wl6Y1FbUoByZYh13ljoxymEKqf5Nf+ZnqU8w88/
         /hyojEdBjJl7pqHpyJOguStQRUyWA1qguhhPkp0W1tdjU7qFUpVjOq/M54BbMthZXp
         h3PAWF+mfH4lHm8nJSigfdGDPzsXFQtDLNfNpAGU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210209124819eucas1p17a56eafa0daf9af55aed9de54c4aa6fb~iFS0D_3Gl0112001120eucas1p1t;
        Tue,  9 Feb 2021 12:48:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 68.33.44805.39482206; Tue,  9
        Feb 2021 12:48:19 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210209124819eucas1p29c9b481ef524a753ce79aa6ab580d0a7~iFSzo4_cX2601126011eucas1p2d;
        Tue,  9 Feb 2021 12:48:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210209124819eusmtrp15c9b332e4200ed090cb8169abc1a2609~iFSzoKbB-1894918949eusmtrp1W;
        Tue,  9 Feb 2021 12:48:19 +0000 (GMT)
X-AuditID: cbfec7f4-b37ff7000000af05-22-6022849303ce
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 54.99.21957.29482206; Tue,  9
        Feb 2021 12:48:19 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210209124818eusmtip2d19833cb01bf712c2a449b17afd7356d~iFSy3CZwt0114701147eusmtip2c;
        Tue,  9 Feb 2021 12:48:18 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: brcmfmac and unaligned sdio access on Khadas VIM3L
To:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        linux-amlogic@lists.infradead.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc:     Dmitry Lebed <lebed.dmitry@gmail.com>,
        martin.blumenstingl@googlemail.com,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-ID: <967b6bfe-a612-707f-583e-c45d61acffe0@samsung.com>
Date:   Tue, 9 Feb 2021 13:48:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djP87qTW5QSDObfVbD4v/YWi8XGGetZ
        LT63tDFZLFn3gtniza/1jBY/Fr1gs/jx6AaLxaL3M1gtes71MFssmM1tceR/P6PFmxV32C2O
        LTrJYnFh3z02Bz6PWffPsnnsnHWX3ePphMnsHrN3TWLx2Lyk3qNvyypGj8+b5ALYo7hsUlJz
        MstSi/TtErgyVq+6zlowQb1ix6H4BsYOpS5GTg4JAROJg/9fMXYxcnEICaxglPj/bQM7hPOF
        UeLAzxtsEM5nRomeVaeZYVoWndsN1bKcUeL3rk1QVR8ZJRY8X8ECUsUmYCjR9baLDcQWFrCW
        mP31HFi3CEjH+znpIA3MAluZJZZff88EkuAVsJP4/HseI4jNIqAi0fBpJ5gtKpAksfzmH6ga
        QYmTM5+ALWAWkJdo3jqbGcIWl7j1ZD4TyFAJgWZOiQkvTwAlOIAcF4mJHVIQZwtLvDq+hR3C
        lpE4PbmHBaqeUeLhubXsEE4Po8TlphmMEFXWEnfO/WIDGcQsoCmxfpc+RNhRYsfLrUwQ8/kk
        brwVhLiBT2LStulQa3klOtqEIKrVJGYdXwe39uCFS9BQ9JCY9OII4wRGxVlIPpuF5LNZSD6b
        hXDDAkaWVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIGp7fS/4192MC5/9VHvECMTB+Mh
        RgkOZiUR3vA6pQQh3pTEyqrUovz4otKc1OJDjNIcLErivElb1sQLCaQnlqRmp6YWpBbBZJk4
        OKUamIROTmWsPZ5WMl9xnrGA1onI8+aT57HHcq1eZRuqeOzR3adRTAwX/P4dWaR0o8n68cpT
        G4RiV3ee4NuQ1rds3n+mdWnHtm9Pu8Ih5PjOesmvH9P3cfAZLNqrn2S6WtmjPuBY1B3G31uq
        bhxqqd497dXJjI8nb3SL3tWdsGCn/ftbCxiKt383+OA+MbbS9P4xNd68g9OiFWKPFOumPa/e
        mak47aPe0QV/mpdGZ/+q8/CbdmWPwZXCR9s9//83CLMzVfO5ti3O4s3dJXrLjIRnGbfvvXKn
        cPpH7QkhBlYRqxbd6w8+ahilpLZWQ8zQ6b50jHKI+nSLMvbXp3/M37Lt9c503Y/neXKdQ71O
        lfN1PdulxFKckWioxVxUnAgAE+XKuNwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xe7qTW5QSDDZOZrL4v/YWi8XGGetZ
        LT63tDFZLFn3gtniza/1jBY/Fr1gs/jx6AaLxaL3M1gtes71MFssmM1tceR/P6PFmxV32C2O
        LTrJYnFh3z02Bz6PWffPsnnsnHWX3ePphMnsHrN3TWLx2Lyk3qNvyypGj8+b5ALYo/RsivJL
        S1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyVq+6zlowQb1i
        x6H4BsYOpS5GTg4JAROJRed2M3YxcnEICSxllFi6o4MZIiEjcXJaAyuELSzx51oXG0TRe0aJ
        7TcngiXYBAwlut6CJDg5hAWsJWZ/PccMUiQisJxR4tLvdewgDrPAdmaJs41nwDp4BewkPv+e
        xwhiswioSDR82glmiwokSTy+dZ8JokZQ4uTMJywgNrOAmcS8zQ+ZIWx5ieats6FscYlbT+Yz
        TWAUmIWkZRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYUK84Mbe4NC9dLzk/dxMjMDq3Hfu5eQfj
        vFcf9Q4xMnEwHmKU4GBWEuENr1NKEOJNSaysSi3Kjy8qzUktPsRoCvTDRGYp0eR8YHrIK4k3
        NDMwNTQxszQwtTQzVhLn3Tp3TbyQQHpiSWp2ampBahFMHxMHp1QDU6TO3uVzP3nrOkcd93i8
        UGUy70T2RZG2b6b17mBddOJmpjb/G9Zjr7/7ai9rf/9PJy9vzsn6LL6oWV/1FLvF4hXyJ4ur
        36r9nydr6P7R4Who5+lH8yzEcv5qC9/Tb/pSMGvmN2nh9vBZn21ePW5ybV/ZsI/H9sGa/FcG
        vpXfby9XOvKsvrR9k8lJowIhkbKg5b1Gd585vWDlF+WtKwlk/fLxWP6yPImTvzdp/pb78uLt
        u4QITgWumLqVMfJFi3g1Te08s5sedNmumnbyUXlRa/0Rrpq64CMnNLdVcN9Y2x92b+Nip3Ir
        77y246fm+L8vYhBdM/mxhEvn6gt1lftnNPm8DFxxpcayusQ58MJHJZbijERDLeai4kQAC1dK
        HlcDAAA=
X-CMS-MailID: 20210209124819eucas1p29c9b481ef524a753ce79aa6ab580d0a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210209124819eucas1p29c9b481ef524a753ce79aa6ab580d0a7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210209124819eucas1p29c9b481ef524a753ce79aa6ab580d0a7
References: <CGME20210209124819eucas1p29c9b481ef524a753ce79aa6ab580d0a7@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

I've noticed that the Broadcom Wifi chip performs unaligned SDIO access 
during the station scan on Khadas VIM3l board. This issue went unnoticed 
so far, because there was a workaround in the meson MMC driver, which 
has been recently disabled by commit e085b51c74cc ("mmc: meson-gx: check 
for scatterlist size alignment in block mode") from current linux-next.

I can easily reproduce this issue with the following commands:

# dmesg | grep brcm
[   11.659351] Bluetooth: hci0: BCM4359C0 'brcm/BCM4359C0.hcd' Patch
[   13.079767] brcmfmac: brcmf_fw_alloc_request: using 
brcm/brcmfmac4359-sdio for chip BCM4359/9
[   13.527363] brcmfmac: brcmf_fw_alloc_request: using 
brcm/brcmfmac4359-sdio for chip BCM4359/9
[   13.601269] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available 
(err=-11), device may have limited channels available
[   13.619414] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4359/9 wl0: 
Mar  6 2017 10:16:06 version 9.87.51.7 (r686312) FWID 01-4dcc75d9
# ifconfig wlan0 up
[  208.052058] ieee80211 phy0: brcmf_dongle_roam: WLC_SET_ROAM_TRIGGER 
error (-52)
# iw wlan0 scan >/dev/null
[  218.148345] ------------[ cut here ]------------
[  218.148501] unaligned sg len 504 blksize 256
[  218.153712] WARNING: CPU: 1 PID: 75 at 
drivers/mmc/host/meson-gx-mmc.c:251 
meson_mmc_get_transfer_mode.isra.10+0xf8/0x130
[  218.162616] Modules linked in: ipv6 brcmfmac brcmutil cfg80211 
dw_hdmi_cec dw_hdmi_i2s_audio hci_uart btqca btbcm bluetooth 
ecdh_generic ecc crct10dif_ce rfkill panfrost 
snd_soc_meson_axg_sound_card snd_soc_meson_card_utils gpu_sched 
meson_gxbb_wdt rtc_hym8563 pwm_meson meson_gxl rtc_meson_vrtc rc_khadas 
meson_ir reset_meson_audio_arb realtek snd_soc_meson_g12a_tohdmitx 
snd_soc_meson_codec_glue snd_soc_meson_axg_tdmout 
snd_soc_meson_axg_frddr snd_soc_meson_axg_fifo axg_audio sclk_div 
clk_phase mdio_mux_meson_g12a meson_dw_hdmi meson_drm meson_rng 
dwmac_generic snd_soc_meson_axg_tdm_interface meson_canvas rng_core 
dw_hdmi snd_soc_meson_axg_tdm_formatter dwmac_meson8b stmmac_platform 
stmmac display_connector adc_keys pcs_xpcs nvmem_meson_efuse
[  218.228329] CPU: 1 PID: 75 Comm: kworker/u8:2 Not tainted 
5.11.0-rc6-next-20210208 #2492
[  218.236343] Hardware name: Khadas VIM3L (DT)
[  218.240579] Workqueue: brcmf_wq/mmc2:0001:1 brcmf_sdio_dataworker 
[brcmfmac]
[  218.247559] pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=--)
[  218.253506] pc : meson_mmc_get_transfer_mode.isra.10+0xf8/0x130
[  218.259372] lr : meson_mmc_get_transfer_mode.isra.10+0xf8/0x130
[  218.265237] sp : ffff80001327b870
[  218.268514] x29: ffff80001327b870 x28: 0000000000000003
[  218.273776] x27: 0000000000000218 x26: 0000000000000600
[  218.279036] x25: ffff000003a17678 x24: 0000000000000000
[  218.284296] x23: ffff8000121cfae8 x22: ffff800011b54000
[  218.289559] x21: ffff80001327bb18 x20: ffff00000277d000
[  218.294819] x19: ffff80001327ba40 x18: 00000002faf07f80
[  218.300081] x17: 0000000000004000 x16: 0000000000000000
[  218.305341] x15: 0000000000000380 x14: 0000000000000000
[  218.310603] x13: 0000000000000080 x12: 0000000000000000
[  218.315865] x11: 0000000000000000 x10: 0000000000001370
[  218.321125] x9 : ffff00006f995258 x8 : 000000009e0e7ca7
[  218.326387] x7 : ffff80001327b4a0 x6 : 0000000000000001
[  218.331648] x5 : 0000000000000001 x4 : 0000000000000000
[  218.336912] x3 : 0000000000000002 x2 : ffff8000121f4768
[  218.342171] x1 : 42fe1bd05e5eaa00 x0 : 0000000000000000
[  218.347435] Call trace:
[  218.349854]  meson_mmc_get_transfer_mode.isra.10+0xf8/0x130
[  218.355368]  meson_mmc_request+0x74/0xb0
[  218.359250]  __mmc_start_request+0xa4/0x2b0
[  218.363390]  mmc_start_request+0x80/0xa8
[  218.367272]  mmc_wait_for_req+0x68/0xd8
[  218.371066]  mmc_submit_one.isra.17+0x78/0x148 [brcmfmac]
[  218.376416]  brcmf_sdiod_sglist_rw+0x324/0x4a8 [brcmfmac]
[  218.381762]  brcmf_sdiod_recv_chain+0x70/0x140 [brcmfmac]
[  218.387110]  brcmf_sdio_dataworker+0x614/0x17d0 [brcmfmac]
[  218.392545]  process_one_work+0x2a8/0x728
[  218.396510]  worker_thread+0x48/0x460
[  218.400132]  kthread+0x134/0x160
[  218.403323]  ret_from_fork+0x10/0x18
[  218.406862] irq event stamp: 15834
[  218.410222] hardirqs last  enabled at (15833): [<ffff800010f95804>] 
_raw_spin_unlock_irq+0x3c/0x80
[  218.419107] hardirqs last disabled at (15834): [<ffff800010f895ac>] 
el1_dbg+0x24/0x50
[  218.426869] softirqs last  enabled at (15828): [<ffff800010010508>] 
_stext+0x508/0x638
[  218.434717] softirqs last disabled at (15823): [<ffff8000100952ec>] 
irq_exit+0x19c/0x1a8
[  218.442739] ---[ end trace dfc38bb4458b4c37 ]---
#

Surprisingly the same commands executed on the Khadas VIM3 board with 
the same kernel don't trigger the warning.

Let me know if I can help debugging this issue.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

