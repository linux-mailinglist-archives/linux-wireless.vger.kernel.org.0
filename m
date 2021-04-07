Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C0C35672D
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Apr 2021 10:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349660AbhDGIrP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Apr 2021 04:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349648AbhDGIqZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Apr 2021 04:46:25 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8F1C06174A
        for <linux-wireless@vger.kernel.org>; Wed,  7 Apr 2021 01:45:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id p19so8608883wmq.1
        for <linux-wireless@vger.kernel.org>; Wed, 07 Apr 2021 01:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qxDdi7+Pa9mI4uigqB3W47xkaolm+nq86ZXwnoIyQRM=;
        b=mS5HUd6HTMn7Fr3mXLNbOMZh208zPqvzzD278g7XVsd5VK36R6VAIdXkrPMdCnZ4qX
         43U0SyUPlE1xJLVidhagnCRm9euCFfjqA2TmxzEZy5sZdBbUNSOrCIihuDyOcxaVy1He
         RQQSF5NmLquSbLaXuJ7Dr1wgyeDsdiCrp6B67gm0Vkt9xCRC4VNviMHQLATdras4ECTv
         u3atG7Gkkq820VoM5C4feUm6ab37LnRdwJFScEC84UW+b2JIQiZrtPeWCyK37Pfwxiyi
         OItS8dWUdt19lzr84Pfuzlaeo6pS+vRwWgFNg/htvxItUHC449M7S0zHdvErWBNiCBhO
         BGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qxDdi7+Pa9mI4uigqB3W47xkaolm+nq86ZXwnoIyQRM=;
        b=pN1uvhU8GnnNHqyD9kneUk4MsRAXLk4YjRB22nZY1MB8IglbY6PtP8ZrBPghb4hrTe
         p1J6MhuG4zZ9BS75xFLgBGTo57f/if7Q/ktHFRt2nyo8G2id5O/wNWZpuSvaiM5tmFJR
         kSUHx4Ei9Zx5kApWg9ECACpqGm7NB8MqEEj1ugQHv9melIYr20RTHmh2wKM0meu1bEM8
         IKzhwx33dAWct5aH9XLU3Zq1AEUYbG92Cw8TG3BMbo2NE1DjSaEEd0RCVAsTQ11Qdgtn
         KS1/yLfgiVYBqOqaOAcuuudky6c3oyO7FgCKD6TBGuUHS5zf/6wkqI/t9o+1JujWf97+
         5Qtw==
X-Gm-Message-State: AOAM533I83ynPKhAiYSyWGChBkRKVjp0mGdl6+7ZMhzznrQM7dj1pcgp
        t20Sfth2AwrwDZ7IV4UHa+SZ+g==
X-Google-Smtp-Source: ABdhPJwcJ5uKyBrMz5SrcTpL/fHDZaB+rje4huK8/j3jT5LSRRnBYyGPpLjbOF18aLrBL5PwqPt2CA==
X-Received: by 2002:a05:600c:4f94:: with SMTP id n20mr2018474wmq.18.1617785123299;
        Wed, 07 Apr 2021 01:45:23 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:1202:4b29:31f6:551c? ([2a01:e0a:90c:e290:1202:4b29:31f6:551c])
        by smtp.gmail.com with ESMTPSA id u9sm6936551wmc.38.2021.04.07.01.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 01:45:22 -0700 (PDT)
Subject: Re: brcmfmac and unaligned sdio access on Khadas VIM3L
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
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
References: <CGME20210209124819eucas1p29c9b481ef524a753ce79aa6ab580d0a7@eucas1p2.samsung.com>
 <967b6bfe-a612-707f-583e-c45d61acffe0@samsung.com>
 <ab81cc00-049f-67a5-bc97-417d7cd2fa44@baylibre.com>
 <1e55e4cf-3ed6-0506-2e17-b94ca8043008@samsung.com>
 <459fb404-7370-190f-379d-751956e887df@baylibre.com>
Organization: Baylibre
Message-ID: <aa920eb6-788d-b0b8-c99a-839d73a8c748@baylibre.com>
Date:   Wed, 7 Apr 2021 10:45:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <459fb404-7370-190f-379d-751956e887df@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Hi Marek,
On 10/02/2021 09:52, Neil Armstrong wrote:
> On 10/02/2021 09:45, Marek Szyprowski wrote:
>> Hi Neil,
>>
>> On 10.02.2021 09:17, Neil Armstrong wrote:
>>> On 09/02/2021 13:48, Marek Szyprowski wrote:
>>>> I've noticed that the Broadcom Wifi chip performs unaligned SDIO access
>>>> during the station scan on Khadas VIM3l board. This issue went unnoticed
>>>> so far, because there was a workaround in the meson MMC driver, which
>>>> has been recently disabled by commit e085b51c74cc ("mmc: meson-gx: check
>>>> for scatterlist size alignment in block mode") from current linux-next.
>>>>
>>>> I can easily reproduce this issue with the following commands:
>>>>
>>>> # dmesg | grep brcm
>>>> [   11.659351] Bluetooth: hci0: BCM4359C0 'brcm/BCM4359C0.hcd' Patch
>>>> [   13.079767] brcmfmac: brcmf_fw_alloc_request: using
>>>> brcm/brcmfmac4359-sdio for chip BCM4359/9
>>>> [   13.527363] brcmfmac: brcmf_fw_alloc_request: using
>>>> brcm/brcmfmac4359-sdio for chip BCM4359/9
>>>> [   13.601269] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available
>>>> (err=-11), device may have limited channels available
>>>> [   13.619414] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4359/9 wl0:
>>>> Mar  6 2017 10:16:06 version 9.87.51.7 (r686312) FWID 01-4dcc75d9
>>>> # ifconfig wlan0 up
>>>> [  208.052058] ieee80211 phy0: brcmf_dongle_roam: WLC_SET_ROAM_TRIGGER
>>>> error (-52)
>>>> # iw wlan0 scan >/dev/null
>>>> [  218.148345] ------------[ cut here ]------------
>>>> [  218.148501] unaligned sg len 504 blksize 256
>>>> [  218.153712] WARNING: CPU: 1 PID: 75 at
>>>> drivers/mmc/host/meson-gx-mmc.c:251
>>>> meson_mmc_get_transfer_mode.isra.10+0xf8/0x130
>>>> [  218.162616] Modules linked in: ipv6 brcmfmac brcmutil cfg80211
>>>> dw_hdmi_cec dw_hdmi_i2s_audio hci_uart btqca btbcm bluetooth
>>>> ecdh_generic ecc crct10dif_ce rfkill panfrost
>>>> snd_soc_meson_axg_sound_card snd_soc_meson_card_utils gpu_sched
>>>> meson_gxbb_wdt rtc_hym8563 pwm_meson meson_gxl rtc_meson_vrtc rc_khadas
>>>> meson_ir reset_meson_audio_arb realtek snd_soc_meson_g12a_tohdmitx
>>>> snd_soc_meson_codec_glue snd_soc_meson_axg_tdmout
>>>> snd_soc_meson_axg_frddr snd_soc_meson_axg_fifo axg_audio sclk_div
>>>> clk_phase mdio_mux_meson_g12a meson_dw_hdmi meson_drm meson_rng
>>>> dwmac_generic snd_soc_meson_axg_tdm_interface meson_canvas rng_core
>>>> dw_hdmi snd_soc_meson_axg_tdm_formatter dwmac_meson8b stmmac_platform
>>>> stmmac display_connector adc_keys pcs_xpcs nvmem_meson_efuse
>>>> [  218.228329] CPU: 1 PID: 75 Comm: kworker/u8:2 Not tainted
>>>> 5.11.0-rc6-next-20210208 #2492
>>>> [  218.236343] Hardware name: Khadas VIM3L (DT)
>>>> [  218.240579] Workqueue: brcmf_wq/mmc2:0001:1 brcmf_sdio_dataworker
>>>> [brcmfmac]
>>>> [  218.247559] pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=--)
>>>> [  218.253506] pc : meson_mmc_get_transfer_mode.isra.10+0xf8/0x130
>>>> [  218.259372] lr : meson_mmc_get_transfer_mode.isra.10+0xf8/0x130
>>>> [  218.265237] sp : ffff80001327b870
>>>> [  218.268514] x29: ffff80001327b870 x28: 0000000000000003
>>>> [  218.273776] x27: 0000000000000218 x26: 0000000000000600
>>>> [  218.279036] x25: ffff000003a17678 x24: 0000000000000000
>>>> [  218.284296] x23: ffff8000121cfae8 x22: ffff800011b54000
>>>> [  218.289559] x21: ffff80001327bb18 x20: ffff00000277d000
>>>> [  218.294819] x19: ffff80001327ba40 x18: 00000002faf07f80
>>>> [  218.300081] x17: 0000000000004000 x16: 0000000000000000
>>>> [  218.305341] x15: 0000000000000380 x14: 0000000000000000
>>>> [  218.310603] x13: 0000000000000080 x12: 0000000000000000
>>>> [  218.315865] x11: 0000000000000000 x10: 0000000000001370
>>>> [  218.321125] x9 : ffff00006f995258 x8 : 000000009e0e7ca7
>>>> [  218.326387] x7 : ffff80001327b4a0 x6 : 0000000000000001
>>>> [  218.331648] x5 : 0000000000000001 x4 : 0000000000000000
>>>> [  218.336912] x3 : 0000000000000002 x2 : ffff8000121f4768
>>>> [  218.342171] x1 : 42fe1bd05e5eaa00 x0 : 0000000000000000
>>>> [  218.347435] Call trace:
>>>> [  218.349854]  meson_mmc_get_transfer_mode.isra.10+0xf8/0x130
>>>> [  218.355368]  meson_mmc_request+0x74/0xb0
>>>> [  218.359250]  __mmc_start_request+0xa4/0x2b0
>>>> [  218.363390]  mmc_start_request+0x80/0xa8
>>>> [  218.367272]  mmc_wait_for_req+0x68/0xd8
>>>> [  218.371066]  mmc_submit_one.isra.17+0x78/0x148 [brcmfmac]
>>>> [  218.376416]  brcmf_sdiod_sglist_rw+0x324/0x4a8 [brcmfmac]
>>>> [  218.381762]  brcmf_sdiod_recv_chain+0x70/0x140 [brcmfmac]
>>>> [  218.387110]  brcmf_sdio_dataworker+0x614/0x17d0 [brcmfmac]
>>>> [  218.392545]  process_one_work+0x2a8/0x728
>>>> [  218.396510]  worker_thread+0x48/0x460
>>>> [  218.400132]  kthread+0x134/0x160
>>>> [  218.403323]  ret_from_fork+0x10/0x18
>>>> [  218.406862] irq event stamp: 15834
>>>> [  218.410222] hardirqs last  enabled at (15833): [<ffff800010f95804>]
>>>> _raw_spin_unlock_irq+0x3c/0x80
>>>> [  218.419107] hardirqs last disabled at (15834): [<ffff800010f895ac>]
>>>> el1_dbg+0x24/0x50
>>>> [  218.426869] softirqs last  enabled at (15828): [<ffff800010010508>]
>>>> _stext+0x508/0x638
>>>> [  218.434717] softirqs last disabled at (15823): [<ffff8000100952ec>]
>>>> irq_exit+0x19c/0x1a8
>>>> [  218.442739] ---[ end trace dfc38bb4458b4c37 ]---
>>>> #
>>>>
>>>> Surprisingly the same commands executed on the Khadas VIM3 board with
>>>> the same kernel don't trigger the warning.
>>> This may be because the VIM3 (G12A & G12B) has a broken SDIO controller using
>>> an internal SRAM as bounce buffer instead of the scatter/gather DMA, cf amlogic,dram-access-quirk.
>> Good to know, this explains why it works without an issue on VIM3.
>>>> Let me know if I can help debugging this issue.
>>> Simply remove the WARN_ONCE()...
>>
>> Well, that WARN is not a big issue for me. I just wanted to help fixing 
>> the real issue. If I understand right, the brcmfmac driver queues 
>> incorrectly prepared sd list for the given transfer mode, what should be 
>> fixed there.
> 
> I think the issue comes from brcmfmac that should not provide unaligned data,
> but I think it's a global issue where these kind of details aren't specified/enforced.
> 
>>
>> On the other hand, if this is just a limitation of the meson mmc 
>> controller on SM1/VIM3l, then imho there should not be a WARN there and 
>> maybe the mentioned 'amlogic,dram-access-quirk' could be used to fix the 
>> issue on VIM3l too. I've checked and it indeed 'fixes' the issue on that 
>> board.
> 
> This fix severely limits the performance so it's not a good fix here,
> the only fix I see here is to remove the WARN because the fact is that the DMA cannot handle
> unaligned data, and the SDIO device drivers should be fixed in order to achieve max
> performance on SDIO host drivers with DMA (it's usual to not support unaligned data
> when dealing with a DMA).

Do you plan to remove the warning ? I can push a quick patch if not.

> 
> Neil
> 
>>
>> Best regards
>>
> 

