Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2ABE4DB94C
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Mar 2022 21:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348168AbiCPU0b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Mar 2022 16:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239396AbiCPU0a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Mar 2022 16:26:30 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E5E49C81
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 13:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=J5Xk979R1V7aV3gxdWbYSenTQ1306KuGCwxIVdWaVHY=; b=EwrjkmkE5gXsskHSnJ8kTr/kOn
        vMxCTm3uHu7pAQbPu4xxTL/D/rrtCZjPcyf+rFeedKKfycgBUGpixCg6eU+20/VTeozk8OYbGGJGm
        ghgYnWsGKRhEU1sOi+hDIV89/aL+PaFJZEGhQSim2byju04P/km+/DUkxOuVaFCh3MAU=;
Received: from p200300daa7204f00592052c3a684cf4a.dip0.t-ipconnect.de ([2003:da:a720:4f00:5920:52c3:a684:cf4a] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nUaCm-0001VD-Gn; Wed, 16 Mar 2022 21:25:12 +0100
Message-ID: <de917732-79c6-4ced-2761-f372ff5dea71@nbd.name>
Date:   Wed, 16 Mar 2022 21:25:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2022-03-18
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's a new last-minute pull request for 3.18

- Felix

The following changes since commit d179c1f1c3703d1a6f7a6f2ad08383220673240c:

    rtw89: fix uninitialized variable of rtw89_append_probe_req_ie() (2022-03-16 17:49:04 +0200)

are available in the Git repository at:

    https://github.com/nbd168/wireless tags/mt76-for-kvalo-2022-03-16

for you to fetch changes up to 24e69f6bc3ca4a1696158b68a6fbf14252a8bd28:

    mt76: fix monitor rx FCS error in DFS channel (2022-03-16 21:18:06 +0100)

----------------------------------------------------------------
mt76 patches for 5.18

- bugfixes
- mbssid support for mt7915
- 6 GHz support for mt7915
- mt7921u driver

----------------------------------------------------------------
Colin Ian King (1):
        mt76: connac: make read-only array ba_range static const

Dan Carpenter (1):
        mt76: mt7915: check for devm_pinctrl_get() failure

Deren Wu (4):
        mt76: fix monitor mode crash with sdio driver
        mt76: fix invalid rssi report
        mt76: fix wrong HE data rate in sniffer tool
        mt76: fix monitor rx FCS error in DFS channel

Evelyn Tsai (1):
        mt76: mt7915: fix DFS no radar detection event

Julia Lawall (1):
        mt76: mt7915: fix typos in comments

Lorenzo Bianconi (17):
        mt76: mt7615: honor ret from mt7615_mcu_restart in mt7663u_mcu_init
        mt76: mt7663u: introduce mt7663u_mcu_power_on routine
        mt76: mt7921: make mt7921_init_tx_queues static
        mt76: mt7921: fix xmit-queue dump for usb and sdio
        mt76: mt7921: fix mt7921_queues_acq implementation
        mt76: mt7921: get rid of mt7921_wait_for_mcu_init declaration
        mt76: usb: add req_type to ___mt76u_rr signature
        mt76: usb: add req_type to ___mt76u_wr signature
        mt76: usb: introduce __mt76u_init utility routine
        mt76: mt7921: disable runtime pm for usb
        mt76: mt7921: update mt7921_skb_add_usb_sdio_hdr to support usb
        mt76: mt7921: move mt7921_usb_sdio_tx_prepare_skb in common mac code
        mt76: mt7921: move mt7921_usb_sdio_tx_complete_skb in common mac code.
        mt76: mt7921: move mt7921_usb_sdio_tx_status_data in mac common code.
        mt76: mt7921: add mt7921u driver
        mt76: mt7921: move mt7921_init_hw in a dedicated work
        mt76: mt7915: introduce 802.11ax multi-bss support

MeiChia Chiu (3):
        mt76: split single ldpc cap bit into bits
        mt76: connac: add 6 GHz support for wtbl and starec configuration
        mt76: mt7915: add 6 GHz support

Peter Chiu (1):
        mt76: mt7915: fix phy cap in mt7915_set_stream_he_txbf_caps()

Ryder Lee (2):
        mt76: mt7915: allow beaconing on all chains
        mt76: use le32/16_get_bits() whenever possible

Sean Wang (3):
        mt76: mt7921: fix up the monitor mode
        mt76: mt7921: use mt76_hw instead of open coding it
        mt76: mt7921: don't enable beacon filter when IEEE80211_CONF_CHANGE_MONITOR is set

Shayne Chen (4):
        mt76: mt7915: fix eeprom fields of txpower init values
        mt76: mt7915: add txpower init for 6GHz
        mt76: mt7915: set band1 TGID field in tx descriptor
        mt76: mt7915: fix beamforming mib stats

   drivers/net/wireless/mediatek/mt76/mac80211.c        |   5 ++-
   drivers/net/wireless/mediatek/mt76/mt76.h            |  14 +++++--
   drivers/net/wireless/mediatek/mt76/mt7603/dma.c      |   2 +-
   drivers/net/wireless/mediatek/mt76/mt7603/mac.c      |   9 ++---
   drivers/net/wireless/mediatek/mt76/mt7615/mac.c      |  20 +++++-----
   drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      |   5 ++-
   drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h   |   1 +
   drivers/net/wireless/mediatek/mt76/mt7615/usb.c      |  90 +++++++++++++++++++++++++++++++++++---------
   drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c  |  36 ++++++++++++------
   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c |  54 +++++++++++++++++++--------
   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |   3 +-
   drivers/net/wireless/mediatek/mt76/mt76x0/usb.c      |   2 +-
   drivers/net/wireless/mediatek/mt76/mt76x2/usb.c      |   2 +-
   drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c   |  82 +++++++++++++++++++++++++---------------
   drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h   |  32 +++++++++++++++-
   drivers/net/wireless/mediatek/mt76/mt7915/init.c     |  59 +++++++++++++++++++++++++----
   drivers/net/wireless/mediatek/mt76/mt7915/mac.c      | 147 +++++++++++++++++++++++++++++++++++++++++++-----------------------------
   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      | 105 +++++++++++++++++++++++++++++++++++++++++++++-------
   drivers/net/wireless/mediatek/mt76/mt7915/mmio.c     |   2 +
   drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h   |   6 ++-
   drivers/net/wireless/mediatek/mt76/mt7915/regs.h     |  28 ++++++++++----
   drivers/net/wireless/mediatek/mt76/mt7915/soc.c      |   2 +
   drivers/net/wireless/mediatek/mt76/mt7915/testmode.c |   4 ++
   drivers/net/wireless/mediatek/mt76/mt7921/Kconfig    |  11 ++++++
   drivers/net/wireless/mediatek/mt76/mt7921/Makefile   |   2 +
   drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c  |  28 +++++++++-----
   drivers/net/wireless/mediatek/mt76/mt7921/dma.c      |   2 +-
   drivers/net/wireless/mediatek/mt76/mt7921/init.c     |  74 +++++++++++++++++++++++++------------
   drivers/net/wireless/mediatek/mt76/mt7921/mac.c      | 128 +++++++++++++++++++++++++++++++++++++++++++++++++++++----------
   drivers/net/wireless/mediatek/mt76/mt7921/mac.h      |   1 +
   drivers/net/wireless/mediatek/mt76/mt7921/main.c     |  38 ++++++++++++-------
   drivers/net/wireless/mediatek/mt76/mt7921/mcu.c      |  33 ++++++++++++++++-
   drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h   |  42 +++++++++++++++------
   drivers/net/wireless/mediatek/mt76/mt7921/pci.c      |   1 +
   drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c  |  13 +++----
   drivers/net/wireless/mediatek/mt76/mt7921/regs.h     |  61 ++++++++++++++++++++++++++----
   drivers/net/wireless/mediatek/mt76/mt7921/sdio.c     |   7 ++--
   drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c |  83 -----------------------------------------
   drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c |   2 +-
   drivers/net/wireless/mediatek/mt76/mt7921/usb.c      | 306 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c  | 252 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   drivers/net/wireless/mediatek/mt76/sdio_txrx.c       |   2 +-
   drivers/net/wireless/mediatek/mt76/usb.c             | 125 +++++++++++++++++++------------------------------------------
   43 files changed, 1460 insertions(+), 461 deletions(-)
   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/usb.c
   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c

