Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BAE3160C3
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 09:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbhBJISS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 03:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbhBJISQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 03:18:16 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E23C061756
        for <linux-wireless@vger.kernel.org>; Wed, 10 Feb 2021 00:17:36 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b3so1434520wrj.5
        for <linux-wireless@vger.kernel.org>; Wed, 10 Feb 2021 00:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xUSMbo8DN8lxVA7sy/ugigRxnZYqVwKNoYAuB03/fJ8=;
        b=UPB/s9GsZyS5QgBUeiWZTOKpfskz2xy3L+SkhJ1L/hOhf6QPBoeZa5nToP5t60gnSD
         oBZuvzAU2qXUaCxVQOUbF6VhpgSxZiCGCpZBOp+M1Fhl+HeicMsIUoW62OG7claWxtgt
         EkU69yqMqw78UE5wZOWpXsnVDMNE4+nbkJX89ysF7skIRqjsRm28RqG+K4ZFnu9eAxbG
         aPX1u+VDGc61+KBma3HG/P2gIVdohA8wL//msrhzUQMN3qkfVsqaOsGimvHWq9FYL5OQ
         SNVYepqyCQEj9PjRsJiuxUq+OZGXRSW1Kkho3tsXFK+FEjhKfBH+CQxq6bfVdIajgBV/
         lRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xUSMbo8DN8lxVA7sy/ugigRxnZYqVwKNoYAuB03/fJ8=;
        b=TX31rhkFeYRzp3Y4SwRafYC2jRl1zTAtxoHL3YmtH9xXfTFsw+wnW0GMkxbaGsVP4C
         o5r/850vwsS87OybetUd4AIQKe202zKl0B2VNusR8jUYEw0UAgG1Xw9i+pvgAFrVFsDK
         hr3h9KRIvZHDL6D4uO0bei9asbWsPk/kqph/koHIe54mu6z7BESHnv6bGL64MSOcIsGG
         /8ucCwv5DKShgcf8g6fiw8Z0Mg4IaXLr7beNRTt2S4mR+zOYzynfJz2Yz4OjoLR0zr5v
         Z1zjzVi1JWH1xb6fH2NVt/KbsKGEM0DpBUdXDSXH2yKenH28TN7jnegIZyaCr7UlK9Hu
         4ZWQ==
X-Gm-Message-State: AOAM532XJ1HKaJaQLOKcC1m4prM1eGaeIZNyA4ELwHliUOhhz4qi3hw8
        4XM2F5j94Cgusl8sIpu4JKgOxA==
X-Google-Smtp-Source: ABdhPJxipEJlcg6V6l0SLw6gV9NtTxqTuZ4HqXVz4f7HVurBYnAyY3OhKfD1e4ta6q6wQziN+MEq0A==
X-Received: by 2002:a5d:55c6:: with SMTP id i6mr2310763wrw.145.1612945054881;
        Wed, 10 Feb 2021 00:17:34 -0800 (PST)
Received: from ?IPv6:2a01:e0a:90c:e290:d403:f5fa:8912:cba5? ([2a01:e0a:90c:e290:d403:f5fa:8912:cba5])
        by smtp.gmail.com with ESMTPSA id w4sm1764582wrt.69.2021.02.10.00.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 00:17:34 -0800 (PST)
Subject: Re: brcmfmac and unaligned sdio access on Khadas VIM3L
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
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <ab81cc00-049f-67a5-bc97-417d7cd2fa44@baylibre.com>
Date:   Wed, 10 Feb 2021 09:17:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <967b6bfe-a612-707f-583e-c45d61acffe0@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On 09/02/2021 13:48, Marek Szyprowski wrote:
> Hi
> 
> I've noticed that the Broadcom Wifi chip performs unaligned SDIO access 
> during the station scan on Khadas VIM3l board. This issue went unnoticed 
> so far, because there was a workaround in the meson MMC driver, which 
> has been recently disabled by commit e085b51c74cc ("mmc: meson-gx: check 
> for scatterlist size alignment in block mode") from current linux-next.
> 
> I can easily reproduce this issue with the following commands:
> 
> # dmesg | grep brcm
> [   11.659351] Bluetooth: hci0: BCM4359C0 'brcm/BCM4359C0.hcd' Patch
> [   13.079767] brcmfmac: brcmf_fw_alloc_request: using 
> brcm/brcmfmac4359-sdio for chip BCM4359/9
> [   13.527363] brcmfmac: brcmf_fw_alloc_request: using 
> brcm/brcmfmac4359-sdio for chip BCM4359/9
> [   13.601269] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available 
> (err=-11), device may have limited channels available
> [   13.619414] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4359/9 wl0: 
> Mar  6 2017 10:16:06 version 9.87.51.7 (r686312) FWID 01-4dcc75d9
> # ifconfig wlan0 up
> [  208.052058] ieee80211 phy0: brcmf_dongle_roam: WLC_SET_ROAM_TRIGGER 
> error (-52)
> # iw wlan0 scan >/dev/null
> [  218.148345] ------------[ cut here ]------------
> [  218.148501] unaligned sg len 504 blksize 256
> [  218.153712] WARNING: CPU: 1 PID: 75 at 
> drivers/mmc/host/meson-gx-mmc.c:251 
> meson_mmc_get_transfer_mode.isra.10+0xf8/0x130
> [  218.162616] Modules linked in: ipv6 brcmfmac brcmutil cfg80211 
> dw_hdmi_cec dw_hdmi_i2s_audio hci_uart btqca btbcm bluetooth 
> ecdh_generic ecc crct10dif_ce rfkill panfrost 
> snd_soc_meson_axg_sound_card snd_soc_meson_card_utils gpu_sched 
> meson_gxbb_wdt rtc_hym8563 pwm_meson meson_gxl rtc_meson_vrtc rc_khadas 
> meson_ir reset_meson_audio_arb realtek snd_soc_meson_g12a_tohdmitx 
> snd_soc_meson_codec_glue snd_soc_meson_axg_tdmout 
> snd_soc_meson_axg_frddr snd_soc_meson_axg_fifo axg_audio sclk_div 
> clk_phase mdio_mux_meson_g12a meson_dw_hdmi meson_drm meson_rng 
> dwmac_generic snd_soc_meson_axg_tdm_interface meson_canvas rng_core 
> dw_hdmi snd_soc_meson_axg_tdm_formatter dwmac_meson8b stmmac_platform 
> stmmac display_connector adc_keys pcs_xpcs nvmem_meson_efuse
> [  218.228329] CPU: 1 PID: 75 Comm: kworker/u8:2 Not tainted 
> 5.11.0-rc6-next-20210208 #2492
> [  218.236343] Hardware name: Khadas VIM3L (DT)
> [  218.240579] Workqueue: brcmf_wq/mmc2:0001:1 brcmf_sdio_dataworker 
> [brcmfmac]
> [  218.247559] pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=--)
> [  218.253506] pc : meson_mmc_get_transfer_mode.isra.10+0xf8/0x130
> [  218.259372] lr : meson_mmc_get_transfer_mode.isra.10+0xf8/0x130
> [  218.265237] sp : ffff80001327b870
> [  218.268514] x29: ffff80001327b870 x28: 0000000000000003
> [  218.273776] x27: 0000000000000218 x26: 0000000000000600
> [  218.279036] x25: ffff000003a17678 x24: 0000000000000000
> [  218.284296] x23: ffff8000121cfae8 x22: ffff800011b54000
> [  218.289559] x21: ffff80001327bb18 x20: ffff00000277d000
> [  218.294819] x19: ffff80001327ba40 x18: 00000002faf07f80
> [  218.300081] x17: 0000000000004000 x16: 0000000000000000
> [  218.305341] x15: 0000000000000380 x14: 0000000000000000
> [  218.310603] x13: 0000000000000080 x12: 0000000000000000
> [  218.315865] x11: 0000000000000000 x10: 0000000000001370
> [  218.321125] x9 : ffff00006f995258 x8 : 000000009e0e7ca7
> [  218.326387] x7 : ffff80001327b4a0 x6 : 0000000000000001
> [  218.331648] x5 : 0000000000000001 x4 : 0000000000000000
> [  218.336912] x3 : 0000000000000002 x2 : ffff8000121f4768
> [  218.342171] x1 : 42fe1bd05e5eaa00 x0 : 0000000000000000
> [  218.347435] Call trace:
> [  218.349854]  meson_mmc_get_transfer_mode.isra.10+0xf8/0x130
> [  218.355368]  meson_mmc_request+0x74/0xb0
> [  218.359250]  __mmc_start_request+0xa4/0x2b0
> [  218.363390]  mmc_start_request+0x80/0xa8
> [  218.367272]  mmc_wait_for_req+0x68/0xd8
> [  218.371066]  mmc_submit_one.isra.17+0x78/0x148 [brcmfmac]
> [  218.376416]  brcmf_sdiod_sglist_rw+0x324/0x4a8 [brcmfmac]
> [  218.381762]  brcmf_sdiod_recv_chain+0x70/0x140 [brcmfmac]
> [  218.387110]  brcmf_sdio_dataworker+0x614/0x17d0 [brcmfmac]
> [  218.392545]  process_one_work+0x2a8/0x728
> [  218.396510]  worker_thread+0x48/0x460
> [  218.400132]  kthread+0x134/0x160
> [  218.403323]  ret_from_fork+0x10/0x18
> [  218.406862] irq event stamp: 15834
> [  218.410222] hardirqs last  enabled at (15833): [<ffff800010f95804>] 
> _raw_spin_unlock_irq+0x3c/0x80
> [  218.419107] hardirqs last disabled at (15834): [<ffff800010f895ac>] 
> el1_dbg+0x24/0x50
> [  218.426869] softirqs last  enabled at (15828): [<ffff800010010508>] 
> _stext+0x508/0x638
> [  218.434717] softirqs last disabled at (15823): [<ffff8000100952ec>] 
> irq_exit+0x19c/0x1a8
> [  218.442739] ---[ end trace dfc38bb4458b4c37 ]---
> #
> 
> Surprisingly the same commands executed on the Khadas VIM3 board with 
> the same kernel don't trigger the warning.

This may be because the VIM3 (G12A & G12B) has a broken SDIO controller using
an internal SRAM as bounce buffer instead of the scatter/gather DMA, cf amlogic,dram-access-quirk.

> 
> Let me know if I can help debugging this issue.

Simply remove the WARN_ONCE()...

> 
> Best regards
> 

Thanks for the report,
Neil
