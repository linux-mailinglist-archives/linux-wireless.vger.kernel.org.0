Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A903682A6
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Apr 2021 16:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbhDVOqA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Apr 2021 10:46:00 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:36946 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236305AbhDVOp6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Apr 2021 10:45:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619102724; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=rWw67brabaP65Aw44jjDUMpkDeSHC79rpE2/enpTG9U=;
 b=Av/VHbk6gxmsMZB4WSbpiLL6nEUAO70SRKixc1ec3aNKZd4YgUUS0co14tiOxmUogYKNVvLw
 cDa3h5OJzZ2RxS+CLh7YJGs10t9Xxrj8qYdON6oEY6ClYX14C1XDjbCBErf3zBd9zW+YDpjQ
 THg4njdj5ILy25IkPQz4f5RknEk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60818bf82cc44d3aeab20fd4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 22 Apr 2021 14:45:12
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9AC56C433F1; Thu, 22 Apr 2021 14:45:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 07391C433F1;
        Thu, 22 Apr 2021 14:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 07391C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull request: mt76 2021-04-21
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <c5410ff3-8341-f8fe-d9cf-a12df54ca8c0@nbd.name>
References: <c5410ff3-8341-f8fe-d9cf-a12df54ca8c0@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210422144512.9AC56C433F1@smtp.codeaurora.org>
Date:   Thu, 22 Apr 2021 14:45:12 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> here's an updated request for 5.13 with mostly bugfixes. It replaces the
> one from 2021-04-17
> 
> - Felix
> 
> The following changes since commit afda33499bea154dc792338c5c51a2038a206785:
> 
>   rtlwifi: implement set_tim by update beacon content (2021-04-21 12:39:33 +0300)
> 
> are available in the Git repository at:
> 
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-04-21
> 
> for you to fetch changes up to 3df932141e4fa3a39f8e0839af9ee7bdedb1da0c:
> 
>   mt76: mt7921: reinit wpdma during drv_own if necessary (2021-04-21 20:55:56 +0200)
> 
> ----------------------------------------------------------------
> mt76 patches for 5.13
> 
> * testmode improvements
> * bugfixes
> * device tree power limits support for 7615 and newer
> * hardware recovery fixes
> * mt7663 reset/init fixes
> * mt7915 flash pre-calibration support
> * mt7921/mt7663 runtime power management fixes
> 
> ----------------------------------------------------------------
> Colin Ian King (1):
>       mt76: mt7615: Fix a dereference of pointer sta before it is null checked
> 
> Dan Carpenter (3):
>       mt76: mt7615: fix a precision vs width bug in printk
>       mt76: mt7915: fix a precision vs width bug in printk
>       mt76: mt7921: fix a precision vs width bug in printk
> 
> Felix Fietkau (6):
>       mt76: flush tx status queue on DMA reset
>       mt76: add functions for parsing rate power limits from DT
>       mt76: mt7615: implement support for using DT rate power limits
>       mt76: mt7615: fix hardware error recovery for mt7663
>       mt76: mt7615: fix entering driver-own state on mt7663
>       mt76: mt7615: load ROM patch before checking patch semaphore status
> 
> Lorenzo Bianconi (43):
>       mt76: mt7921: add mt7921_dma_cleanup in mt7921_unregister_device
>       dt-bindings:net:wireless:mediatek,mt76: introduce power-limits node
>       mt76: mt7615: do not use mt7615 single-sku values for mt7663
>       mt76: introduce single-sku support for mt7663/mt7921
>       mt76: mt7921: move hw configuration in mt7921_register_device
>       mt76: improve mcu error logging
>       mt76: mt7921: run mt7921_mcu_fw_log_2_host holding mt76 mutex
>       mt76: mt7921: do not use 0 as NULL pointer
>       mt76: connac: move mcu_update_arp_filter in mt76_connac module
>       mt76: mt7921: remove leftover function declaration
>       mt76: mt7921: fix a race between mt7921_mcu_drv_pmctrl and mt7921_mcu_fw_pmctrl
>       mt76: mt7663: fix a race between mt7615_mcu_drv_pmctrl and mt7615_mcu_fw_pmctrl
>       mt76: connac: introduce wake counter for fw_pmctrl synchronization
>       mt76: mt7921: rely on mt76_connac_pm_ref/mt76_connac_pm_unref in tx path
>       mt76: mt7663: rely on mt76_connac_pm_ref/mt76_connac_pm_unref in tx path
>       mt76: dma: add the capability to define a custom rx napi poll routine
>       mt76: mt7921: rely on mt76_connac_pm_ref/mt76_connac_pm_unref in tx/rx napi
>       mt76: mt7663: rely on mt76_connac_pm_ref/mt76_connac_pm_unref in tx/rx napi
>       mt76: connac: unschedule ps_work in mt76_connac_pm_wake
>       mt76: connac: check wake refcount in mcu_fw_pmctrl
>       mt76: connac: remove MT76_STATE_PM in mac_tx_free
>       mt76: mt7921: get rid of useless MT76_STATE_PM in mt7921_mac_work
>       mt76: connac: alaways wake the device before scanning
>       mt76: mt7615: rely on pm refcounting in mt7615_led_set_config
>       mt76: connac: do not run mt76_txq_schedule_all directly
>       mt76: connac: use waitqueue for runtime-pm
>       mt76: remove MT76_STATE_PM in tx path
>       mt76: mt7921: add awake and doze time accounting
>       mt76: mt7921: enable sw interrupts
>       mt76: mt7921: move mt7921_dma_reset in dma.c
>       mt76: mt7921: introduce mt7921_wpdma_reset utility routine
>       mt76: mt7921: introduce mt7921_dma_{enable,disable} utilities
>       mt76: mt7921: introduce mt7921_wpdma_reinit_cond utility routine
>       mt76: move token_lock, token and token_count in mt76_dev
>       mt76: move token utilities in mt76 common module
>       mt76: mt7921: get rid of mcu_reset function pointer
>       mt76: mt7921: improve doze opportunity
>       mt76: mt7663: add awake and doze time accounting
>       mt76: connac: unschedule mac_work before going to sleep
>       mt76: mt7921: introduce mt7921_mcu_sta_add routine
>       mt76: debugfs: introduce napi_threaded node
>       mt76: move mt76_token_init in mt76_alloc_device
>       mt76: mt7921: reinit wpdma during drv_own if necessary
> 
> Ryder Lee (6):
>       mt76: mt7615: fix memleak when mt7615_unregister_device()
>       mt76: mt7915: fix memleak when mt7915_unregister_device()
>       mt76: mt7915: only free skbs after mt7915_dma_reset() when reset happens
>       mt76: mt7615: only free skbs after mt7615_dma_reset() when reset happens
>       mt76: mt7615: use ieee80211_free_txskb() in mt7615_tx_token_put()
>       mt76: mt7915: add support for applying pre-calibration data
> 
> Sean Wang (7):
>       mt76: mt7921: add dumping Tx power table
>       mt76: mt7921: add wifisys reset support in debugfs
>       mt76: mt7921: abort uncompleted scan by wifi reset
>       mt76: connac: introduce mt76_connac_mcu_set_deep_sleep utility
>       mt76: mt7921: enable deep sleep when the device suspends
>       mt76: mt7921: fix possible invalid register access
>       mt76: mt7921: mt7921_stop should put device in fw_own state
> 
> Shayne Chen (8):
>       mt76: testmode: add support to send larger packet
>       mt76: mt7915: rework mt7915_tm_set_tx_len()
>       mt76: mt7915: fix rate setting of tx descriptor in testmode
>       mt76: extend DT rate power limits to support 11ax devices
>       mt76: mt7915: add support for DT rate power limits
>       mt76: mt7915: rework the flow of txpower setting
>       mt76: mt7915: directly read per-rate tx power from registers
>       mt76: mt7915: do not read rf value from efuse in flash mode
> 
>  Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml | 107 ++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/mediatek/mt76/debugfs.c                      |  28 ++++++++++
>  drivers/net/wireless/mediatek/mt76/dma.c                          |  10 ++--
>  drivers/net/wireless/mediatek/mt76/dma.h                          |   1 +
>  drivers/net/wireless/mediatek/mt76/eeprom.c                       | 231 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  drivers/net/wireless/mediatek/mt76/mac80211.c                     |   3 ++
>  drivers/net/wireless/mediatek/mt76/mcu.c                          |   4 --
>  drivers/net/wireless/mediatek/mt76/mt76.h                         |  77 +++++++++++++++++++++++----
>  drivers/net/wireless/mediatek/mt76/mt7603/dma.c                   |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt7603/mac.c                   |   2 +
>  drivers/net/wireless/mediatek/mt76/mt7603/mcu.c                   |   5 +-
>  drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c               |  32 +++++++++++-
>  drivers/net/wireless/mediatek/mt76/mt7615/dma.c                   |  47 ++++++++++++++---
>  drivers/net/wireless/mediatek/mt76/mt7615/init.c                  |  22 ++++++--
>  drivers/net/wireless/mediatek/mt76/mt7615/mac.c                   |  44 +++++++++-------
>  drivers/net/wireless/mediatek/mt76/mt7615/main.c                  |  43 ++++++++-------
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                   | 198 +++++++++++++++++++++++++++++++++++++++++++--------------------------
>  drivers/net/wireless/mediatek/mt76/mt7615/mmio.c                  |  24 ++++++---
>  drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h                |   7 +--
>  drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c              |  16 +++---
>  drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c               |  23 ++++----
>  drivers/net/wireless/mediatek/mt76/mt7615/regs.h                  |  11 ++++
>  drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c              |   3 +-
>  drivers/net/wireless/mediatek/mt76/mt76_connac.h                  |  54 ++++++++++++++++++-
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c              |  23 ++++----
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c              | 197 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h              |  37 +++++++++++++
>  drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c                  |   5 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c                 |   4 +-
>  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c               |  78 +++++++++++++++------------
>  drivers/net/wireless/mediatek/mt76/mt7915/dma.c                   |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c                | 165 ++++++++++++++++++----------------------------------------
>  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h                |  51 ++++++------------
>  drivers/net/wireless/mediatek/mt76/mt7915/init.c                  |  85 ++++++++++++++++--------------
>  drivers/net/wireless/mediatek/mt76/mt7915/mac.c                   |  95 ++++++++++++---------------------
>  drivers/net/wireless/mediatek/mt76/mt7915/main.c                  |   8 ++-
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                   | 185 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h                   |   2 +
>  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                |  19 +++----
>  drivers/net/wireless/mediatek/mt76/mt7915/pci.c                   |  26 +--------
>  drivers/net/wireless/mediatek/mt76/mt7915/regs.h                  |   5 ++
>  drivers/net/wireless/mediatek/mt76/mt7915/testmode.c              |  22 ++------
>  drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c               | 144 ++++++++++++++++++++++++++++++++++++++++++++++----
>  drivers/net/wireless/mediatek/mt76/mt7921/dma.c                   | 240 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------
>  drivers/net/wireless/mediatek/mt76/mt7921/init.c                  |  36 ++++++-------
>  drivers/net/wireless/mediatek/mt76/mt7921/mac.c                   | 193 ++++++++++++++-----------------------------------------------------
>  drivers/net/wireless/mediatek/mt76/mt7921/main.c                  |  62 +++++++++-------------
>  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                   | 126 ++++++++++++++++++++++++++------------------
>  drivers/net/wireless/mediatek/mt76/mt7921/mcu.h                   |  17 ++++++
>  drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                |  60 +++++++++++++++------
>  drivers/net/wireless/mediatek/mt76/mt7921/pci.c                   |  30 ++++++++++-
>  drivers/net/wireless/mediatek/mt76/mt7921/regs.h                  |  17 +++---
>  drivers/net/wireless/mediatek/mt76/testmode.c                     | 159 +++++++++++++++++++++++++++++++++++++++++++------------
>  drivers/net/wireless/mediatek/mt76/testmode.h                     |   2 +-
>  drivers/net/wireless/mediatek/mt76/tx.c                           |  81 ++++++++++++++++++++++++++---
>  55 files changed, 2224 insertions(+), 946 deletions(-)

Pulled, thanks.

9382531ec63f Merge tag 'mt76-for-kvalo-2021-04-21' of https://github.com/nbd168/wireless

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/c5410ff3-8341-f8fe-d9cf-a12df54ca8c0@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

