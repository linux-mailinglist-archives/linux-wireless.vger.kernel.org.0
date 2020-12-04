Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067E22CEEF1
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Dec 2020 14:45:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgLDNpQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Dec 2020 08:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgLDNpQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Dec 2020 08:45:16 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0C9C0613D1
        for <linux-wireless@vger.kernel.org>; Fri,  4 Dec 2020 05:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FhOhR7vSVErAOq/JqF4hSeh0msKffSuwAV3CKYP16Wc=; b=sRL1ZANmjEpcVv3f5El5l6NIWZ
        ZGcAuj2VHgOGE+snv/Q+lahMXdr2AXVsbxUF8jGlVBNsSy/A/aRjLSPrsZ9a/jYL7U3gy8vgfx05a
        g9sJ11CY6GSCnkFKHCnLnG13G/HkIyxqatAD6Ku0w6Alm9+nlLuwqKJERjz96ZcJI4rg=;
Received: from p4ff13815.dip0.t-ipconnect.de ([79.241.56.21] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1klBNy-0004YC-JZ; Fri, 04 Dec 2020 14:44:34 +0100
Subject: pull request: mt76 2020-12-04
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <7ec7cc33-ccf0-ee68-755a-9d118ced3102@nbd.name>
 <20201202191852.525E8C43461@smtp.codeaurora.org>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <85027265-15f0-6d8f-1fd5-19a88c9530d8@nbd.name>
Date:   Fri, 4 Dec 2020 14:44:33 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201202191852.525E8C43461@smtp.codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's my updated pull request for 5.11 with some newer changes.

The following changes since commit 9eb597c74483ad5c230a884449069adfb68285ea:

  Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git (2020-12-02 21:46:55 +0200)

are available in the Git repository at:

  https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-12-04

for you to fetch changes up to 01ef374d9117f199ba8abc8a284aa5929a955f6d:

  mt76: mt7615: Fix fall-through warnings for Clang (2020-12-04 14:31:16 +0100)

----------------------------------------------------------------
mt76 patches for 5.11

* mt7915 fixes
* mt7615 fixes
* support for more sta interfaces on mt7615/mt7915
* mt7915 encap offload
* performance improvements
* channel noise report on mt7915
* usb/sdio support improvements
* mt7915 testmode support
* mt7915 DBDC support
* warning fixes

----------------------------------------------------------------
Allen Pais (1):
      wireless: mt76: convert tasklets to use new tasklet_setup() API

Chuanhong Guo (1):
      mt76: mt7615: retry if mt7615_mcu_init returns -EAGAIN

David Bauer (1):
      mt76: mt7603: add additional EEPROM chip ID

Felix Fietkau (25):
      mt76: mt7915: add 802.11 encap offload support
      mt76: mt7915: add encap offload for 4-address mode stations
      mt76: use ieee80211_rx_list to pass frames to the network stack as a batch
      mt76: mt7615: add debugfs knob for setting extended local mac addresses
      mt76: do not set NEEDS_UNIQUE_STA_ADDR for 7615 and 7915
      mt76: mt7915: support 32 station interfaces
      mt76: mt7915: fix processing txfree events
      mt76: mt7915: use napi_consume_skb to bulk-free tx skbs
      mt76: mt7915: fix DRR sta bss group index
      mt76: mt7915: disable OFDMA/MU-MIMO UL
      mt76: rename __mt76_mcu_send_msg to mt76_mcu_send_msg
      mt76: rename __mt76_mcu_skb_send_msg to mt76_mcu_skb_send_msg
      mt76: implement .mcu_parse_response in struct mt76_mcu_ops
      mt76: move mcu timeout handling to .mcu_parse_response
      mt76: move waiting and locking out of mcu_ops->mcu_skb_send_msg
      mt76: make mcu_ops->mcu_send_msg optional
      mt76: mt7603: switch to .mcu_skb_send_msg
      mt76: implement functions to get the response skb for MCU calls
      mt76: mt7915: move eeprom parsing out of mt7915_mcu_parse_response
      mt76: mt7915: query station rx rate from firmware
      mt76: add back the SUPPORTS_REORDERING_BUFFER flag
      mt76: mt7915: fix endian issues
      mt76: improve tx queue stop/wake
      mt76: mt7915: stop queues when running out of tx tokens
      mt76: attempt to free up more room when filling the tx queue

Gustavo A. R. Silva (1):
      mt76: mt7615: Fix fall-through warnings for Clang

Lorenzo Bianconi (37):
      mt76: mt7663s: move tx/rx processing in the same txrx workqueue
      mt76: mt7663s: convert txrx_work to mt76_worker
      mt76: mt7663s: disable interrupt during txrx_worker processing
      mt76: sdio: convert {status/net}_work to mt76_worker
      mt76: mt7615: enable beacon filtering by default for offload fw
      mt76: mt7615: introduce quota debugfs node for mt7663s
      mt76: mt7663s: get rid of mt7663s_sta_add
      mt76: mt7663s: fix a possible ple quota underflow
      mt76: sdio: get rid of sched.lock
      mt76: dma: fix possible deadlock running mt76_dma_cleanup
      mt76: fix memory leak if device probing fails
      mt76: move mt76_mcu_send_firmware in common module
      mt76: switch to wep sw crypto for mt7615/mt7915
      mt76: fix tkip configuration for mt7615/7663 devices
      mt76: mt7615: run key configuration in mt7615_set_key for usb/sdio devices
      mt76: mt76u: rely on woker APIs for rx work
      mt76: mt76u: use dedicated thread for status work
      mt76: mt7915: make mt7915_eeprom_read static
      mt76: mt7615: refactor usb/sdio rate code
      mt76: mt7915: rely on eeprom definitions
      mt76: move mt76_init_tx_queue in common code
      mt76: sdio: introduce mt76s_alloc_tx_queue
      mt76: sdio: rely on mt76_queue in mt76s_process_tx_queue signature
      mt76: mt7663s: rely on mt76_queue in mt7663s_tx_run_queue signature
      mt76: dma: rely on mt76_queue in mt76_dma_tx_cleanup signature
      mt76: rely on mt76_queue in tx_queue_skb signature
      mt76: introduce mt76_init_mcu_queue utility routine
      mt76: rely on mt76_queue in tx_queue_skb_raw signature
      mt76: move mcu queues to mt76_dev q_mcu array
      mt76: move tx hw data queues in mt76_phy
      mt76: move band capabilities in mt76_phy
      mt76: rely on mt76_phy in mt76_init_sband_2g and mt76_init_sband_5g
      mt76: move band allocation in mt76_register_phy
      mt76: move hw mac_addr in mt76_phy
      mt76: mt7915: introduce dbdc support
      mt76: mt7915: get rid of dbdc debugfs knob
      mt76: mt7615: fix rdd mcu cmd endianness

Ryder Lee (8):
      mt76: mt7915: measure channel noise and report it via survey
      mt76: mt7915: fix VHT LDPC capability
      mt76: mt7915: update ppe threshold
      mt76: mt7915: rename mt7915_mcu_get_rate_info to mt7915_mcu_get_tx_rate
      mt76: mt7915: fix sparse warning cast from restricted __le16
      mt76: mt7915: use BIT_ULL for omac_idx
      mt76: mt7915: remove unused mt7915_mcu_bss_sync_tlv()
      mt76: mt7615: support 16 interfaces

Sean Wang (1):
      mt76: mt7663s: introduce WoW support via GPIO

Shayne Chen (12):
      mt76: testmode: switch ib and wb rssi to array type for per-antenna report
      mt76: testmode: add snr attribute in rx statistics
      mt76: testmode: add tx_rate_stbc parameter
      mt76: testmode: add support for LTF and GI combinations for HE mode
      mt76: mt7915: fix tx rate related fields in tx descriptor
      mt76: testmode: add support for HE rate modes
      mt76: mt7915: implement testmode tx support
      mt76: mt7915: implement testmode rx support
      mt76: mt7915: add support to set txpower in testmode
      mt76: mt7915: add support to set tx frequency offset in testmode
      mt76: mt7915: fix memory leak in mt7915_mcu_get_rx_rate()
      mt76: mt7915: fix ht mcs in mt7915_mcu_get_rx_rate()

Taehee Yoo (2):
      mt76: mt7915: set fops_sta_stats.owner to THIS_MODULE
      mt76: set fops_tx_stats.owner to THIS_MODULE

 drivers/net/wireless/mediatek/mt76/debugfs.c          |   4 +-
 drivers/net/wireless/mediatek/mt76/dma.c              |  37 +++--
 drivers/net/wireless/mediatek/mt76/eeprom.c           |  12 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c         | 149 +++++++++++---------
 drivers/net/wireless/mediatek/mt76/mcu.c              |  80 +++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h             | 121 ++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c    |  30 ++--
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c       |  61 ++++----
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c    |   7 +-
 drivers/net/wireless/mediatek/mt76/mt7603/init.c      |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c       |   9 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c      |  12 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.c       | 131 ++++++-----------
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/pci.c       |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c   | 139 ++++++++++++++++--
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c       |  55 +++-----
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c    |  22 +--
 drivers/net/wireless/mediatek/mt76/mt7615/init.c      |  23 +--
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c       | 199 +++++++++++++-------------
 drivers/net/wireless/mediatek/mt76/mt7615/main.c      | 122 +++++++---------
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c       | 544 +++++++++++++++++++++++++++++++++++++----------------------------------
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h       |  17 +++
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c      |   9 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h    |  92 ++++--------
 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c  |   9 +-
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h      |  11 ++
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c      |  71 +++++-----
 drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c  |  42 ++----
 drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c | 142 +++++++++----------
 drivers/net/wireless/mediatek/mt76/mt7615/testmode.c  |  28 +++-
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c       |   9 +-
 drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c   |  16 +--
 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c  |  89 +++---------
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c    |  12 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/init.c      |   4 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c       |   3 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci_mcu.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c       |   4 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c       |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c      |  10 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c   |   8 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c      |  16 +--
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c      |  55 ++++----
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.h      |   2 +
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c     |  76 +++++-----
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c  |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c     |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c    |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c       |  18 +--
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c       |   3 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c   |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c       |   1 +
 drivers/net/wireless/mediatek/mt76/mt7915/Makefile    |   2 +
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c   |  47 ++-----
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c       |  76 +++++-----
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c    |  64 +++++----
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h    |   1 +
 drivers/net/wireless/mediatek/mt76/mt7915/init.c      | 435 +++++++++++++++++++++++++++------------------------------
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c       | 539 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------
 drivers/net/wireless/mediatek/mt76/mt7915/mac.h       |  16 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c      | 133 ++++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c       | 734 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h       |  54 +++++--
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h    |  64 ++++++---
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c       |  24 +++-
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h      |  52 ++++++-
 drivers/net/wireless/mediatek/mt76/mt7915/testmode.c  | 377 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7915/testmode.h  |  40 ++++++
 drivers/net/wireless/mediatek/mt76/sdio.c             | 196 ++++++++++++++------------
 drivers/net/wireless/mediatek/mt76/testmode.c         |  41 ++++--
 drivers/net/wireless/mediatek/mt76/testmode.h         |  18 ++-
 drivers/net/wireless/mediatek/mt76/tx.c               |  63 +++++----
 drivers/net/wireless/mediatek/mt76/usb.c              |  87 ++++++++----
 76 files changed, 3447 insertions(+), 2156 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/testmode.h

