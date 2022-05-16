Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A96D528191
	for <lists+linux-wireless@lfdr.de>; Mon, 16 May 2022 12:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239046AbiEPKNM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 May 2022 06:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239637AbiEPKNI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 May 2022 06:13:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920F8B7DB
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 03:13:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49FD9B80F1A
        for <linux-wireless@vger.kernel.org>; Mon, 16 May 2022 10:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843AEC385B8;
        Mon, 16 May 2022 10:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652695985;
        bh=7d/mBvbk4wCQW84b5nNbCvMGXKzWMZcTUt3eQv83+vE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=SuzalFGL0VglVVGfip/hkUk192vfsQCV+QmSahB1+b75TLVfJjBTdMtMYCiyNBij9
         /SodjCely2r8hXV55mCXqgR2iLKJGB/wJHpErZ+ZGXEgaldz8DZbwJhMt8D0wcHYg3
         B8vEQlWbrdgPE5kDgLjEXwnOfCZKOvtC/Z75XZlB6SNrBd8s7vIu2QULeX9Z3oPIIC
         WT4+lG5bWo86r41Q0BAhFmFhZ57MdBnBELGstw9AGN9TU+YhDIAljN9pEopXC2/lDa
         HNH/WJ0eT2mM/COYbp/3QMPdeoz8ll7XYEcOJbq9HXTrv/jpt5Nk8BSvLL/e83AqlN
         YET8VzbuAAe/g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull request: mt76 2022-05-12 v2
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <72b762b5-c13a-ec81-2a0f-279c3d99f518@nbd.name>
References: <72b762b5-c13a-ec81-2a0f-279c3d99f518@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165269596863.7302.8651877356375321603.kvalo@kernel.org>
Date:   Mon, 16 May 2022 10:13:04 +0000 (UTC)
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> here's a new version of my first pull request for 5.19
> 
> - Felix
> 
> The following changes since commit ad732da434a2936128769216eddaece3b1af4588:
> 
>    rtlwifi: Use pr_warn instead of WARN_ONCE (2022-05-13 09:19:44 +0300)
> 
> are available in the Git repository at:
> 
>    https://github.com/nbd168/wireless tags/mt76-for-kvalo-2022-05-12
> 
> for you to fetch changes up to 5fc201aa8cf39d8e313b22c97abea73849cf1edb:
> 
>    mt76: mt7921: add ipv6 NS offload support (2022-05-13 09:39:35 +0200)
> 
> ----------------------------------------------------------------
> mt76 patches for 5.19
> 
> - tx locking improvements
> - wireless ethernet dispatch support for flow offload
> - non-standard VHT MCS10-11 support
> - fixes
> - runtime PM improvements
> - mt7921 AP mode support
> - mt7921 ipv6 NS offload support
> 
> ----------------------------------------------------------------
> Bo Jiao (2):
>        mt76: mt7915: disable RX_HDR_TRANS_SHORT
>        mt76: mt7615/mt7915: do reset_work with mt76's work queue
> 
> Christophe JAILLET (1):
>        mt76: mt7921: Fix the error handling path of mt7921_pci_probe()
> 
> Colin Ian King (2):
>        mt76: mt7915: make read-only array ppet16_ppet8_ru3_ru0 static const
>        mt76: mt7921: make read-only array ppet16_ppet8_ru3_ru0 static const
> 
> Deren Wu (2):
>        mt76: fix antenna config missing in 6G cap
>        mt76: mt7921: add ipv6 NS offload support
> 
> Evelyn Tsai (1):
>        mt76: fix MBSS index condition in DBDC mode
> 
> Felix Fietkau (15):
>        mt76: mt7915: fix DBDC default band selection on MT7915D
>        mt76: mt7915: rework hardware/phy initialization
>        mt76: reduce tx queue lock hold time
>        mt76: dma: use kzalloc instead of devm_kzalloc for txwi
>        mt76: mt7915: accept rx frames with non-standard VHT MCS10-11
>        mt76: mt7921: accept rx frames with non-standard VHT MCS10-11
>        mt76: fix use-after-free by removing a non-RCU wcid pointer
>        mt76: fix rx reordering with non explicit / psmp ack policy
>        mt76: do not attempt to reorder received 802.3 packets without agg session
>        mt76: fix encap offload ethernet type check
>        mt76: fix tx status related use-after-free race on station removal
>        mt76: dma: add wrapper macro for accessing queue registers
>        mt76: add support for overriding the device used for DMA mapping
>        mt76: make number of tokens configurable dynamically
>        mt76: mt7915: add Wireless Ethernet Dispatch support
> 
> Lorenzo Bianconi (11):
>        mt76: mt7921u: add suspend/resume support
>        mt76: mt7921: rely on mt76_dev rxfilter in mt7921_configure_filter
>        mt76: mt7921: honor pm user configuration in mt7921_sniffer_interface_iter
>        mt76: mt7915: fix unbounded shift in mt7915_mcu_beacon_mbss
>        mt76: mt7915: fix possible uninitialized pointer dereference in mt7986_wmac_gpio_setup
>        mt76: mt7915: fix possible NULL pointer dereference in mt7915_mac_fill_rx_vector
>        mt76: mt7915: do not pass data pointer to mt7915_mcu_muru_debug_set
>        mt76: mt7915: report rx mode value in mt7915_mac_fill_rx_rate
>        mt76: mt7915: use 0xff to initialize bitrate_mask in mt7915_init_bitrate_mask
>        mt76: mt7915: configure soc clocks in mt7986_wmac_init
>        mt76: add gfp to mt76_mcu_msg_alloc signature
> 
> MeiChia Chiu (1):
>        mt76: mt7915: add support for 6G in-band discovery
> 
> Peter Chiu (4):
>        mt76: mt7915: update mt7986 patch in mt7986_wmac_adie_patch_7976()
>        mt76: mt7915: fix twt table_mask to u16 in mt7915_dev
>        mt76: mt7915: reject duplicated twt flows
>        mt76: mt7915: limit minimum twt duration
> 
> Ryder Lee (7):
>        mt76: mt7915: always call mt7915_wfsys_reset() during init
>        mt76: mt7915: remove SCS feature
>        mt76: mt7915: rework SER debugfs knob
>        mt76: mt7915: introduce mt7915_mac_severe_check()
>        mt76: mt7915: move MT_INT_MASK_CSR to init.c
>        mt76: mt7915: improve error handling for fw_debug knobs
>        mt76: mt7915: add more statistics from fw_util debugfs knobs
> 
> Sean Wang (3):
>        mt76: mt7921: Add AP mode support
>        mt76: mt7921: fix kernel crash at mt7921_pci_remove
>        mt76: connac: use skb_put_data instead of open coding
> 
> Shayne Chen (1):
>        mt76: mt7915: add debugfs knob for RF registers read/write
> 
> Yunbo Yu (1):
>        mt76: mt7603: move spin_lock_bh() to spin_lock()
> 
>   drivers/net/wireless/mediatek/mt76/agg-rx.c          |   8 ++---
>   drivers/net/wireless/mediatek/mt76/dma.c             | 215 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------
>   drivers/net/wireless/mediatek/mt76/mac80211.c        |  14 ++++++---
>   drivers/net/wireless/mediatek/mt76/mcu.c             |   8 ++---
>   drivers/net/wireless/mediatek/mt76/mmio.c            |   9 ++++--
>   drivers/net/wireless/mediatek/mt76/mt76.h            |  50 ++++++++++++++++++++++++------
>   drivers/net/wireless/mediatek/mt76/mt7603/beacon.c   |   8 ++---
>   drivers/net/wireless/mediatek/mt76/mt7603/dma.c      |   8 ++---
>   drivers/net/wireless/mediatek/mt76/mt7603/main.c     |   8 ++---
>   drivers/net/wireless/mediatek/mt76/mt7615/dma.c      |   6 ++--
>   drivers/net/wireless/mediatek/mt76/mt7615/main.c     |   8 ++---
>   drivers/net/wireless/mediatek/mt76/mt7615/mmio.c     |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c |   7 ++---
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |   1 -
>   drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c    |   4 +--
>   drivers/net/wireless/mediatek/mt76/mt76x02_util.c    |  10 +++---
>   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c  | 201 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------
>   drivers/net/wireless/mediatek/mt76/mt7915/dma.c      |  57 ++++++++++++++++++++++++++++++-----
>   drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c   |   2 ++
>   drivers/net/wireless/mediatek/mt76/mt7915/init.c     | 129 +++++++++++++++++++++++++++++++++++++++++++++---------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7915/mac.c      | 249 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------
>   drivers/net/wireless/mediatek/mt76/mt7915/mac.h      |   2 ++
>   drivers/net/wireless/mediatek/mt76/mt7915/main.c     |  72 +++++++++++++++++++++++++++++++-------------
>   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      | 148 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------
>   drivers/net/wireless/mediatek/mt76/mt7915/mcu.h      |  39 +++++++++++++++++-------
>   drivers/net/wireless/mediatek/mt76/mt7915/mmio.c     |  39 ++++++++++++++++--------
>   drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h   |  26 ++++++++++------
>   drivers/net/wireless/mediatek/mt76/mt7915/pci.c      |  99 ++++++++++++++++++++++++++++++++++++++++++++++++++++++------
>   drivers/net/wireless/mediatek/mt76/mt7915/regs.h     |  61 ++++++++++++++++++++++++++++++++-----
>   drivers/net/wireless/mediatek/mt76/mt7915/soc.c      |  41 ++++++++++++++++++++++---
>   drivers/net/wireless/mediatek/mt76/mt7921/dma.c      |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/init.c     |  15 ++++++++-
>   drivers/net/wireless/mediatek/mt76/mt7921/mac.c      |  41 +++++++++++++++++++++++--
>   drivers/net/wireless/mediatek/mt76/mt7921/main.c     | 155 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
>   drivers/net/wireless/mediatek/mt76/mt7921/mcu.c      | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h   |  15 +++++++--
>   drivers/net/wireless/mediatek/mt76/mt7921/pci.c      |  10 +++---
>   drivers/net/wireless/mediatek/mt76/mt7921/regs.h     |   5 +++
>   drivers/net/wireless/mediatek/mt76/mt7921/usb.c      |  62 +++++++++++++++++++++++++++++++++++++-
>   drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c  |   7 +++--
>   drivers/net/wireless/mediatek/mt76/tx.c              |  48 ++++++++++++++++++-----------
>   41 files changed, 1598 insertions(+), 415 deletions(-)

Pulled, thanks.

e99a2d6bcdb0 Merge tag 'mt76-for-kvalo-2022-05-12' of https://github.com/nbd168/wireless

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/72b762b5-c13a-ec81-2a0f-279c3d99f518@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

