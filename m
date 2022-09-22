Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5E95E5B27
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 08:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiIVGOU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 02:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiIVGOT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 02:14:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0147298D39
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 23:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99D0C633BD
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 06:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B94C433D6;
        Thu, 22 Sep 2022 06:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663827257;
        bh=a4tzuC9zJIbCEsAhP9h7j2oic3fP3N/XKtl2mojOv1c=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=NYgoN3mW/N2IGCxQd+U/7zo9XnQLKZ2b0i+vkrO1Dk5GcQwcgW2Ib7IoNnVvwe+7y
         v1w3vblqQKOk00cCNTc97fLglmzOHuKyyQcsE1Oo/Y/2MWlzXV669KPcjQkoSPYc5C
         iQsdSicKDIA+X81OoKzyxSfEdl2Yq/xumj90o2KfpEiSRzBci+ivBAY/rMBFyscZDl
         qyYRPiJ0wfXWydeD4NsYv/JHLwUzzmzw1Yqw0XFL7MNgixSbGIr74W/OQojO99UHNS
         Yw2dB9jW46ub1iols1wEFxOE08ciVOeTfsiOSbwYrFoB3xX2fAmwrsisxrzD/v9UqW
         tQDqlaz5dpMjw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull request: mt76 2022-09-15
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <77c2969a-90fe-5b04-f580-3ff807a7ac3d@nbd.name>
References: <77c2969a-90fe-5b04-f580-3ff807a7ac3d@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166382725412.9021.16702578098517576654.kvalo@kernel.org>
Date:   Thu, 22 Sep 2022 06:14:16 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> here's my first pull request for 6.1
> 
> - Felix
> 
> The following changes since commit d5350756c03cdf18696295c6b11d7acc4dbf825c:
> 
>    wifi: rtl8xxxu: Remove copy-paste leftover in gen2_update_rate_mask (2022-09-12 14:57:54 +0300)
> 
> are available in the Git repository at:
> 
>    https://github.com/nbd168/wireless tags/mt76-for-kvalo-2022-09-15
> 
> for you to fetch changes up to cb74c8f8dbb10c0c8dc42c8693e238fd0ab98517:
> 
>    wifi: mt76: mt7921s: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr() (2022-09-15 13:21:39 +0200)
> 
> ----------------------------------------------------------------
> mt76 patches for 6.1
> 
> - fixes
> - suspend/resume improvements
> - tx status reporting improvements
> 
> ----------------------------------------------------------------
> Dan Carpenter (3):
>        wifi: mt76: mt7915: fix an uninitialized variable bug
>        wifi: mt76: mt7921: fix use after free in mt7921_acpi_read()
>        wifi: mt76: mt7921: delete stray if statement
> 
> Deren Wu (4):
>        wifi: mt76: mt7921e: fix rmmod crash in driver reload test
>        wifi: mt76: mt7921e: fix random fw download fail
>        wifi: mt76: mt7663s: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
>        wifi: mt76: mt7921s: Switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
> 
> Gergo Koteles (1):
>        wifi: mt76: mt76_usb.mt76u_mcu.burst is always false remove related code
> 
> Howard Hsu (2):
>        wifi: mt76: mt7915: fix mcs value in ht mode
>        wifi: mt76: mt7915: do not check state before configuring implicit beamform
> 
> Lorenzo Bianconi (9):
>        wifi: mt76: connac: introduce mt76_connac_reg_map structure
>        wifi: mt76: add rx_check callback for usb devices
>        wifi: mt76: mt7921: move mt7921_rx_check and mt7921_queue_rx_skb in mac.c
>        wifi: mt76: sdio: add rx_check callback for sdio devices
>        wifi: mt76: mt7615: add mt7615_mutex_acquire/release in mt7615_sta_set_decap_offload
>        wifi: mt76: mt7915: fix possible unaligned access in mt7915_mac_add_twt_setup
>        wifi: mt76: connac: fix possible unaligned access in mt76_connac_mcu_add_nested_tlv
>        wifi: mt76: mt7663s: add rx_check callback
>        wifi: mt76: fix uninitialized pointer in mt7921_mac_fill_rx
> 
> Ming Yen Hsieh (1):
>        wifi: mt76: mt7921: introduce Country Location Control support
> 
> Ruffalo Lavoisier (1):
>        wifi: mt76: connac: fix in comment
> 
> Ryder Lee (2):
>        wifi: mt76: move move mt76_sta_stats to mt76_wcid
>        wifi: mt76: add PPDU based TxS support for WED device
> 
> Sean Wang (11):
>        wifi: mt76: mt7921e: fix race issue between reset and suspend/resume
>        wifi: mt76: mt7921s: fix race issue between reset and suspend/resume
>        wifi: mt76: mt7921u: fix race issue between reset and suspend/resume
>        wifi: mt76: mt7921u: remove unnecessary MT76_STATE_SUSPEND
>        wifi: mt76: sdio: fix the deadlock caused by sdio->stat_work
>        wifi: mt76: sdio: poll sta stat when device transmits data
>        wifi: mt76: mt7921: add mt7921_mutex_acquire at mt7921_[start, stop]_ap
>        wifi: mt76: mt7921: add mt7921_mutex_acquire at mt7921_sta_set_decap_offload
>        wifi: mt76: mt7921: fix the firmware version report
>        wifi: mt76: mt7921: get rid of the false positive reset
>        wifi: mt76: mt7921: reset msta->airtime_ac while clearing up hw value
> 
> Shayne Chen (1):
>        wifi: mt76: testmode: use random payload for tx packets
> 
> YN Chen (1):
>        wifi: mt76: sdio: fix transmitting packet hangs
> 
>   drivers/net/wireless/mediatek/mt76/mt76.h             |  50 ++++++++++++++++-------------
>   drivers/net/wireless/mediatek/mt76/mt7615/main.c      |   4 +++
>   drivers/net/wireless/mediatek/mt76/mt7615/sdio.c      |  16 +++-------
>   drivers/net/wireless/mediatek/mt76/mt7615/usb.c       |   1 +
>   drivers/net/wireless/mediatek/mt76/mt76_connac.h      |  11 +++++--
>   drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h |   8 +++++
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c  |  76 ++++++++++++++++++++++++++++----------------
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c  |  12 +++++--
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h  |  11 ++++++-
>   drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c  |  30 +++++-------------
>   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c   |   6 ++--
>   drivers/net/wireless/mediatek/mt76/mt7915/mac.c       |  27 +++++++++-------
>   drivers/net/wireless/mediatek/mt76/mt7915/main.c      |  19 ++++++++++-
>   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c       |  10 +++---
>   drivers/net/wireless/mediatek/mt76/mt7915/mmio.c      | 256 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h    |   2 --
>   drivers/net/wireless/mediatek/mt76/mt7915/pci.c       |  21 +++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7915/regs.h      |  12 +++----
>   drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c  |   5 ++-
>   drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h    |   5 ++-
>   drivers/net/wireless/mediatek/mt76/mt7921/init.c      |   1 +
>   drivers/net/wireless/mediatek/mt76/mt7921/mac.c       | 147 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>   drivers/net/wireless/mediatek/mt76/mt7921/main.c      |  28 +++++++++++++----
>   drivers/net/wireless/mediatek/mt76/mt7921/mcu.c       | 198 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7921/mcu.h       |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h    |  39 ++++++++++++++++++++---
>   drivers/net/wireless/mediatek/mt76/mt7921/pci.c       |  99 +++++++++++++++++++++++++++++-----------------------------
>   drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c   | 148 --------------------------------------------------------------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c   |   9 ++----
>   drivers/net/wireless/mediatek/mt76/mt7921/regs.h      |   2 ++
>   drivers/net/wireless/mediatek/mt76/mt7921/sdio.c      |  29 ++++++++---------
>   drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c  |   7 +----
>   drivers/net/wireless/mediatek/mt76/mt7921/usb.c       |  40 +++++++++++++++---------
>   drivers/net/wireless/mediatek/mt76/sdio.c             |   8 ++---
>   drivers/net/wireless/mediatek/mt76/sdio_txrx.c        |  23 +++++++++-----
>   drivers/net/wireless/mediatek/mt76/testmode.c         |   8 +++--
>   drivers/net/wireless/mediatek/mt76/usb.c              |   5 +++
>   37 files changed, 859 insertions(+), 516 deletions(-)

Pulled, thanks.

5f606b3e1125 Merge tag 'mt76-for-kvalo-2022-09-15' of https://github.com/nbd168/wireless

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/77c2969a-90fe-5b04-f580-3ff807a7ac3d@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

