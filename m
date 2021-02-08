Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20045312F08
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 11:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhBHKbE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 05:31:04 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:59468 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232021AbhBHK2l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 05:28:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612780094; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=6iG3FNaeFFQ8ZUQeyNLEovZY4+uAoTW9je4Q7a0ISg8=;
 b=F0SyNG5MO5NF1K50WFKX8xdivnIeq0VdGRD9DH2/sPYCEre5cManuypH71k7O5fYKdY2ZHhZ
 FxwFhnWangc0hyNAhMNtsWznKnrxVMKXtDYfvt4hi9k2eVwJCyLEzCnaoxTXM6RcvXX0Kwq4
 bTKKseE2mCHmLG5IC2dK6gAAzO8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60211211f112b7872c203e7a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Feb 2021 10:27:29
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BBBE3C433CA; Mon,  8 Feb 2021 10:27:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F3B59C433ED;
        Mon,  8 Feb 2021 10:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3B59C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull request: mt76 2021-01-29
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <3eba5570-7cff-f51e-4050-aa0054f98f81@nbd.name>
References: <3eba5570-7cff-f51e-4050-aa0054f98f81@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210208102728.BBBE3C433CA@smtp.codeaurora.org>
Date:   Mon,  8 Feb 2021 10:27:28 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> here's my first pull request for 5.12.
> 
> The following changes since commit 4832bb371c4175ffb506a96accbb08ef2b2466e7:
> 
>   iwl4965: do not process non-QOS frames on txq->sched_retry path (2021-01-25 16:43:27 +0200)
> 
> are available in the Git repository at:
> 
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-01-29
> 
> for you to fetch changes up to d2bf7959d9c0f631ef860edaf834d55773fdedff:
> 
>   mt76: mt7663: introduce coredump support (2021-01-29 18:10:02 +0100)
> 
> ----------------------------------------------------------------
> mt76 patches for 5.12
> 
> * add new mt7921e driver
> * factor out common code shared between 7615/7663 and 7921
> * performance optimizations
> * 7915 dbdc fixes
> * 802.11 encap offload support
> * support for multiple pcie gen1 host interfaces on 7915
> * 7915 testmode support
> * bugfixes
> * testmode support enhancements
> * endian fixes
> * 7915 txbf support
> 
> ----------------------------------------------------------------
> Felix Fietkau (15):
>       mt76: mt7603: fix ED/CCA monitoring with single-stream devices
>       mt76: mt7915: ensure that init work completes before starting the device
>       mt76: mt7915: do not set DRR group for stations
>       mt76: mt7915: rework mcu API
>       mt76: mt7915: disable RED support in the WA firmware
>       mt76: mt7915: fix eeprom parsing for DBDC
>       mt76: mt7915: fix eeprom DBDC band selection
>       mt76: mt7615: unify init work
>       mt76: mt7915: bring up the WA event rx queue for band1
>       mt76: fix crash on tearing down ext phy
>       mt76: mt7915: add support for using a secondary PCIe link for gen1
>       mt76: mt7915: make vif index per adapter instead of per band
>       mt76: move vif_mask back from mt76_phy to mt76_dev
>       mt76: reduce q->lock hold time
>       mt76: mt7615: reduce VHT maximum MPDU length
> 
> Lorenzo Bianconi (19):
>       mt76: mt7915: run mt7915_configure_filter holding mt76 mutex
>       mt76: mt7915: fix endianness warning in mt7915_mcu_set_radar_th
>       mt76: mt7915: simplify mt7915_mcu_send_message routine
>       mt76: move mac_work in mt76_core module
>       mt76: move chainmask in mt76_phy
>       mt76: mt7615: set mcu country code in mt7615_mcu_set_channel_domain()
>       mt76: usb: process URBs with status EPROTO properly
>       mt76: introduce mt76_vif data structure
>       mt76: mt76_connac: create mcu library
>       mt76: mt76_connac: move hw_scan and sched_scan routine in mt76_connac_mcu module
>       mt76: mt76_connac: move WoW and suspend code in mt76_connac_mcu module
>       mt76: mt76_connac: move pm data struct in mt76_connac.h
>       mt76: mt76_connac: move pm utility routines in mt76_connac_lib module
>       mt76: mt7921: rely on mt76_connac_mcu common library
>       mt76: mt7921: rely on mt76_connac_mcu module for sched_scan and hw_scan
>       mt76: mt7921: rely on mt76_connac_mcu module for suspend and WoW support
>       mt76: mt7921: introduce regdomain notifier support
>       mt76: mt7921: enable MSI interrupts
>       mt76: mt7663: introduce coredump support
> 
> Ryder Lee (9):
>       mt76: mt7915: add vif check in mt7915_update_vif_beacon()
>       mt76: mt7615: add vif check in mt7615_update_vif_beacon()
>       mt76: mt7915: fix MT_CIPHER_BIP_CMAC_128 setkey
>       mt76: mt7915: reset token when mac_reset happens
>       mt76: mt7615: reset token when mac_reset happens
>       mt76: mt7915: drop zero-length packet to avoid Tx hang
>       mt76: mt7915: simplify peer's TxBF capability check
>       mt76: mt7915: add implicit Tx beamforming support
>       mt76: mt7915: support TxBF for DBDC
> 
> Sean Wang (14):
>       mt76: mt7921: add MAC support
>       mt76: mt7921: add MCU support
>       mt76: mt7921: add DMA support
>       mt76: mt7921: add EEPROM support
>       mt76: mt7921: add ieee80211_ops
>       mt76: mt7921: introduce mt7921e support
>       mt76: mt7921: add debugfs support
>       mt76: mt7921: introduce schedule scan support
>       mt76: mt7921: introduce 802.11 PS support in sta mode
>       mt76: mt7921: introduce support for hardware beacon filter
>       mt76: mt7921: introduce beacon_loss mcu event
>       mt76: mt7921: introduce PM support
>       mt76: mt7921: introduce Runtime PM support
>       mt76: mt7921: add coredump support
> 
> Shayne Chen (18):
>       mt76: mt7915: add support for flash mode
>       mt76: mt7915: add partial add_bss_info command on testmode init
>       mt76: testmode: introduce dbdc support
>       mt76: testmode: move mtd part to mt76_dev
>       mt76: mt7915: move testmode data from dev to phy
>       mt76: mt7615: move testmode data from dev to phy
>       mt76: mt7915: force ldpc for bw larger than 20MHz in testmode
>       mt76: testmode: add support to set user-defined spe index
>       mt76: testmode: add attributes for ipg related parameters
>       mt76: testmode: make tx queued limit adjustable
>       mt76: mt7915: split edca update function
>       mt76: mt7915: add support for ipg in testmode
>       mt76: mt7915: calculate new packet length when tx_time is set in testmode
>       mt76: mt7915: clean hw queue before starting new testmode tx
>       mt76: testmode: add a new state for continuous tx
>       mt76: mt7915: rework set state part in testmode
>       mt76: mt7915: add support for continuous tx in testmode
>       mt76: mt7615: mt7915: disable txpower sku when testmode enabled
> 
> Xu Wang (1):
>       mt76: mt7915: Remove unneeded semicolon
> 
> Zheng Yongjun (2):
>       mt76: mt7615: convert comma to semicolon
>       mt76: mt7915: convert comma to semicolon
> 
>  drivers/net/wireless/mediatek/mt76/Kconfig           |    5 +
>  drivers/net/wireless/mediatek/mt76/Makefile          |    4 +
>  drivers/net/wireless/mediatek/mt76/dma.c             |    8 +-
>  drivers/net/wireless/mediatek/mt76/eeprom.c          |    4 +-
>  drivers/net/wireless/mediatek/mt76/mac80211.c        |    8 +-
>  drivers/net/wireless/mediatek/mt76/mt76.h            |   75 +++-
>  drivers/net/wireless/mediatek/mt76/mt7603/init.c     |    2 +-
>  drivers/net/wireless/mediatek/mt76/mt7603/mac.c      |   24 +-
>  drivers/net/wireless/mediatek/mt76/mt7603/main.c     |   16 +-
>  drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h   |    2 -
>  drivers/net/wireless/mediatek/mt76/mt7615/Kconfig    |    3 +-
>  drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c  |   17 +
>  drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c   |    2 +-
>  drivers/net/wireless/mediatek/mt76/mt7615/init.c     |   64 ++--
>  drivers/net/wireless/mediatek/mt76/mt7615/mac.c      |  210 ++++++-----
>  drivers/net/wireless/mediatek/mt76/mt7615/main.c     |  192 +++++-----
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      | 1617 ++++++++--------------------------------------------------------------------------
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.h      |  683 +----------------------------------
>  drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h   |  132 ++-----
>  drivers/net/wireless/mediatek/mt76/mt7615/pci.c      |    9 +-
>  drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c |   23 +-
>  drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c  |    2 +-
>  drivers/net/wireless/mediatek/mt76/mt7615/sdio.c     |   11 +-
>  drivers/net/wireless/mediatek/mt76/mt7615/testmode.c |  101 +++---
>  drivers/net/wireless/mediatek/mt76/mt7615/usb.c      |   12 +-
>  drivers/net/wireless/mediatek/mt76/mt76_connac.h     |  105 ++++++
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c |  119 +++++++
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 1842 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |  979 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/mediatek/mt76/mt76x0/pci.c      |    4 +-
>  drivers/net/wireless/mediatek/mt76/mt76x0/usb.c      |    4 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02.h         |    2 -
>  drivers/net/wireless/mediatek/mt76/mt76x02_mac.c     |   10 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c    |    2 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02_phy.c     |    4 +-
>  drivers/net/wireless/mediatek/mt76/mt76x02_util.c    |   14 +-
>  drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c      |    2 +-
>  drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c |    2 +-
>  drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c |    4 +-
>  drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c |    2 +-
>  drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c |    2 +-
>  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c  |   28 ++
>  drivers/net/wireless/mediatek/mt76/mt7915/dma.c      |  102 ++++--
>  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c   |   42 ++-
>  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h   |   25 +-
>  drivers/net/wireless/mediatek/mt76/mt7915/init.c     |   48 +--
>  drivers/net/wireless/mediatek/mt76/mt7915/mac.c      |  129 +++++--
>  drivers/net/wireless/mediatek/mt76/mt7915/mac.h      |    2 +
>  drivers/net/wireless/mediatek/mt76/mt7915/main.c     |   46 +--
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      |  542 +++++++++++++++-------------
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h      |   63 ++++
>  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h   |   69 ++--
>  drivers/net/wireless/mediatek/mt76/mt7915/pci.c      |  177 ++++++++-
>  drivers/net/wireless/mediatek/mt76/mt7915/regs.h     |   29 +-
>  drivers/net/wireless/mediatek/mt76/mt7915/testmode.c |  528 +++++++++++++++++++++++----
>  drivers/net/wireless/mediatek/mt76/mt7915/testmode.h |   59 +++
>  drivers/net/wireless/mediatek/mt76/mt7921/Kconfig    |   11 +
>  drivers/net/wireless/mediatek/mt76/mt7921/Makefile   |    5 +
>  drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c  |  250 +++++++++++++
>  drivers/net/wireless/mediatek/mt76/mt7921/dma.c      |  356 ++++++++++++++++++
>  drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c   |  100 ++++++
>  drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h   |   27 ++
>  drivers/net/wireless/mediatek/mt76/mt7921/init.c     |  282 +++++++++++++++
>  drivers/net/wireless/mediatek/mt76/mt7921/mac.c      | 1516 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/mediatek/mt76/mt7921/mac.h      |  333 +++++++++++++++++
>  drivers/net/wireless/mediatek/mt76/mt7921/main.c     | 1161 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c      | 1308 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/wireless/mediatek/mt76/mt7921/mcu.h      |  434 ++++++++++++++++++++++
>  drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h   |  342 ++++++++++++++++++
>  drivers/net/wireless/mediatek/mt76/mt7921/pci.c      |  292 +++++++++++++++
>  drivers/net/wireless/mediatek/mt76/mt7921/regs.h     |  419 ++++++++++++++++++++++
>  drivers/net/wireless/mediatek/mt76/testmode.c        |  124 ++++---
>  drivers/net/wireless/mediatek/mt76/testmode.h        |   17 +
>  drivers/net/wireless/mediatek/mt76/tx.c              |   39 +-
>  drivers/net/wireless/mediatek/mt76/usb.c             |    1 +
>  75 files changed, 12019 insertions(+), 3210 deletions(-)
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac.h
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/Kconfig
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/Makefile
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/dma.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/init.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mac.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mac.h
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/main.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci.c
>  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/regs.h

This had conflicts:

$ git pull https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-01-29
>From https://github.com/nbd168/wireless
 * tag                         mt76-for-kvalo-2021-01-29 -> FETCH_HEAD
Auto-merging drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
CONFLICT (content): Merge conflict in drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
Auto-merging drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
Automatic merge failed; fix conflicts and then commit the result.

With this commit from w-d:

b7c568752ef3 mt76: Fix queue ID variable types after mcu queue split

And these commits from your tag:

b8135057988e mt76: mt7915: simplify mt7915_mcu_send_message routine
c203dd621780 mt76: mt7915: rework mcu API

This was not easy to fix. Felix & Lorenzo, please carefully check my resolution
in the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?h=pending&id=dfe85c17c7c7183e1d409b948fae9d8e545cb25d

This is the diff output of my resolution:

diff --cc drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index e211a2bd4d3c,0296f2aa7997..000000000000
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@@ -255,10 -248,10 +248,10 @@@ mt7915_mcu_send_message(struct mt76_de
  {
        struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
        struct mt7915_mcu_txd *mcu_txd;
-       u8 seq, pkt_fmt, qidx;
 -      enum mt76_txq_id txq;
 +      enum mt76_mcuq_id qid;
        __le32 *txd;
        u32 val;
+       u8 seq;
  
        /* TODO: make dynamic based on msg type */
        mdev->mcu.timeout = 20 * HZ;
@@@ -267,22 -260,16 +260,16 @@@
        if (!seq)
                seq = ++dev->mt76.mcu.msg_seq & 0xf;
  
-       if (cmd == -MCU_CMD_FW_SCATTER) {
 -      if (cmd == MCU_CMD(FW_SCATTER)) {
 -              txq = MT_MCUQ_FWDL;
++      if (cmd == MCU_CMD_FW_SCATTER) {
 +              qid = MT_MCUQ_FWDL;
                goto exit;
        }
  
        mcu_txd = (struct mt7915_mcu_txd *)skb_push(skb, sizeof(*mcu_txd));
- 
-       if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state)) {
+       if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state))
 -              txq = MT_MCUQ_WA;
 +              qid = MT_MCUQ_WA;
-               qidx = MT_TX_MCU_PORT_RX_Q0;
-               pkt_fmt = MT_TX_TYPE_CMD;
-       } else {
+       else
 -              txq = MT_MCUQ_WM;
 +              qid = MT_MCUQ_WM;
-               qidx = MT_TX_MCU_PORT_RX_Q0;
-               pkt_fmt = MT_TX_TYPE_CMD;
-       }
  
        txd = mcu_txd->txd;

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/3eba5570-7cff-f51e-4050-aa0054f98f81@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

