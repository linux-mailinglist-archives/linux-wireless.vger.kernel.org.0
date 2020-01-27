Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76D5914A9BE
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 19:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgA0SWI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jan 2020 13:22:08 -0500
Received: from nbd.name ([46.4.11.11]:48468 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgA0SWI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jan 2020 13:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vhC+ghUwvyovTtu5CMpTEUkusUViWlBM8xPqId5QqOM=; b=BaxHVWuZdX0OSNx3rlNQVsB6D6
        Pp/r95CgjeZj+EYNzvFxHTYg5huzz6niDvJ/rD1ihQB0U2WtT18FrTuVG9bOXQF5pqAa1cOFEB623
        s69R30spm6F7LLKw616sFevnY+U4bKaJCuhh4+tDblLcEGhwAbl2n3wlPKZg9kw3I82c=;
Received: from [178.162.209.132] (helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iw91S-00080G-Fy; Mon, 27 Jan 2020 19:22:06 +0100
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2019-01-27
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Autocrypt: addr=nbd@nbd.name; prefer-encrypt=mutual; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCfTKx80VvCR/PvsUlrvdOLsIgeRGAAn1ee
 RjMaxwtSdaCKMw3j33ZbsWS4
Message-ID: <ec25181f-3a2e-0374-a30e-2744e247aea6@nbd.name>
Date:   Mon, 27 Jan 2020 19:22:06 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's my pull request for 5.6

- Felix

The following changes since commit 2a13513f99e735184fd6f889d78da6424fda80a1:

  Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git (2020-01-26 17:54:46 +0200)

are available in the Git repository at:

  https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-01-27

for you to fetch changes up to bc6ea8c1cf22ef97d8ece12c433138af2f6e7573:

  mt76: enable Airtime Queue Limit support (2020-01-27 19:17:16 +0100)

----------------------------------------------------------------
mt76 patches for 5.6

* dual-band concurrent support for MT7615
* fixes for rx path race conditions
* EEPROM fixes
* MAC address handling fixes
* coverage class support for MT7615
* beacon fixes for USB devices
* MT7615 LED support
* minor cleanups/fixes for all drivers
* set_antenna support for MT7615
* tracing improvements
* preparation for supporting new USB devices

----------------------------------------------------------------
Felix Fietkau (42):
      mt76: move initialization of some struct members to mt76_alloc_device
      mt76: introduce struct mt76_phy
      mt76: add support for an extra wiphy in the rx path
      mt76: add support for an extra wiphy in the main tx path
      mt76: add support for an extra wiphy in the tx status path
      mt76: add support for an extra wiphy in mt76_sta_state()
      mt76: move channel state to struct mt76_phy
      mt76: keep a set of software tx queues per phy
      mt76: move state from struct mt76_dev to mt76_phy
      mt76: move chainmask back to driver specific structs
      mt76: move txpower_conf back to driver specific structs
      mt76: move txpower and antenna mask to struct mt76_phy
      mt76: add multiple wiphy support to mt76_get_min_avg_rssi
      mt76: add priv pointer to struct mt76_phy
      mt76: add function for allocating an extra wiphy
      mt76: add ext_phy field to struct mt76_wcid
      mt76: move ampdu_ref from mt76_dev to driver struct
      mt76: mt7615: add dual-phy support for mac80211 ops
      mt76: mt7615: add multiple wiphy support for smart carrier sense
      mt76: mt7615: add missing register init for dual-wiphy support
      mt76: mt7615: remove useless MT_HW_RDD0/1 enum
      mt76: mt7615: add multiple wiphy support to the dfs support code
      mt76: mt7615: rework chainmask handling
      mt76: mt7615: add multiple wiphy support to the rx path
      mt76: mt7615: initialize dbdc settings on interface add
      mt76: mt7615: move radio/mac initialization to .start/stop callbacks
      mt76: mt7615: select the correct tx queue for frames sent to the second phy
      mt76: mt7615: add support for registering a second wiphy via debugfs
      mt76: mt7615: update beacon contents on BSS_CHANGED_BEACON
      mt76: mt7615: defer mcu initialization via workqueue
      mt7615: replace sta_state callback with sta_add/sta_remove
      mt76: fix rx dma ring descriptor state on reset
      mt76: disable bh in mt76_dma_rx_poll
      mt76: mt7615: measure channel noise and report it via survey
      mt76: mt7615: increase MCU command timeout
      mt76: mt7603: fix input validation issues for powersave-filtered frames
      mt76: clear skb pointers from rx aggregation reorder buffer during cleanup
      mt76: set dma-done flag for flushed descriptors
      mt76: fix handling full tx queues in mt76_dma_tx_queue_skb_raw
      mt76: dma: do not write cpu_idx on rx queue reset until after refill
      mt76: mt7603: increase dma mcu rx ring size
      mt76: enable Airtime Queue Limit support

Lorenzo Bianconi (38):
      mt76: mt7603: reset STA_CCA counter setting the channel
      mt76: eeprom: add support for big endian eeprom partition
      dt-bindings: net: wireless: mt76: introduce big-endian property
      mt76: mt7615: report firmware version using ethtool
      mt76: mt76x02: fix coverage_class type
      mt76: mt7603: set 0 as min coverage_class value
      mt76: mt7615: add set_coverage class support
      mt76: mt7615: introduce LED support
      mt76: mt76x02: simplify led reg definitions
      mt76: mt7603: simplify led reg definitions
      mt76: fix compilation warning in mt76_eeprom_override()
      mt76: move dev_irq tracepoint in mt76 module
      mt76: move mac_txdone tracepoint in mt76 module
      mt76: mt7615: add tracing support
      mt76: mt76x2: get rid of leftover target
      mt76: mt7615: initialize radar specs from host driver
      mt76: move WIPHY_FLAG_HAS_CHANNEL_SWITCH in mt76_phy_init
      mt76: mt7615: remove leftover routine declaration
      mt76: rely on mac80211 utility routines to compute airtime
      mt76: mt76x02u: avoid overwrite max_tx_fragments
      mt76: mt76u: check tx_status_data pointer in mt76u_tx_tasklet
      mt76: mt76u: add mt76u_process_rx_queue utility routine
      mt76: mt76u: add mt76_queue to mt76u_get_next_rx_entry signature
      mt76: mt76u: add mt76_queue to mt76u_refill_rx signature
      mt76: mt76u: use mt76_queue as mt76u_complete_rx context
      mt76: mt76u: add queue id parameter to mt76u_submit_rx_buffers
      mt76: mt76u: move mcu buffer allocation in mt76x02u drivers
      mt76: mt76u: introduce mt76u_free_rx_queue utility routine
      mt76: mt76u: stop/free all possible rx queues
      mt76: mt76u: add mt76u_alloc_rx_queue utility routine
      mt76: mt76u: add queue parameter to mt76u_rx_urb_alloc
      mt76: mt76u: resume all rx queue in mt76u_resume_rx
      mt76: mt76u: introduce mt76u_alloc_mcu_queue utility routine
      mt76: mt76u: add {read/write}_extended utility routines
      mt76: mt76u: take into account different queue mapping for 7663
      mt76: mt76u: introduce mt76u_skb_dma_info routine
      mt76: mt76u: add endpoint to mt76u_bulk_msg signature
      mt76: mt76u: introduce MT_DRV_RX_DMA_HDR flag

Markus Theil (7):
      mt76: use AC specific reorder timeout
      mt76: mt76x02: omit beacon slot clearing
      mt76: mt76x02: split beaconing
      mt76: mt76x02: add check for invalid vif idx
      mt76: mt76x02: remove a copy call for usb speedup
      mt76: speed up usb bulk copy
      mt76: mt76x02: add channel switch support for usb interfaces

Pablo Greco (1):
      mt76: mt7615: Fix build with older compilers

Ryder Lee (8):
      mt76: mt7615: fix MT7615_CFEND_RATE_DEFAULT value
      mt76: mt7615: add missing settings for simultaneous dual-band support
      mt76: mt7615: rework set_channel function
      mt76: mt7615: add set_antenna callback
      mt76: mt7615: report TSF information
      mt76: mt7615: add per-phy mib statistics
      mt76: mt7615: add a get_stats() callback
      mt76: mt7615: fix endianness in mt7615_mcu_set_eeprom

Shayne Chen (2):
      mt76: do not overwrite max_tx_fragments if it has been set
      mt76: fix possible undetected invalid MAC address

Stanislaw Gruszka (3):
      mt76: usb: use max packet length for m76u_copy
      mt76: mt76x02u: do not set NULL beacons
      mt76: mt76x02: minor mt76x02_mac_set_beacon optimization

 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt |   3 +
 drivers/net/wireless/mediatek/mt76/Makefile                      |   2 +-
 drivers/net/wireless/mediatek/mt76/agg-rx.c                      |  17 ++-
 drivers/net/wireless/mediatek/mt76/airtime.c                     | 326 ----------------------------------------------
 drivers/net/wireless/mediatek/mt76/debugfs.c                     |   2 +-
 drivers/net/wireless/mediatek/mt76/dma.c                         |  49 +++++--
 drivers/net/wireless/mediatek/mt76/eeprom.c                      |  20 ++-
 drivers/net/wireless/mediatek/mt76/mac80211.c                    | 355 ++++++++++++++++++++++++++++++++++----------------
 drivers/net/wireless/mediatek/mt76/mt76.h                        | 130 ++++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7603/core.c                 |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c                  |  21 ++-
 drivers/net/wireless/mediatek/mt76/mt7603/init.c                 |  21 ++-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c                  |  39 +++---
 drivers/net/wireless/mediatek/mt76/mt7603/main.c                 |  24 ++--
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.c                  |  12 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h               |   7 +-
 drivers/net/wireless/mediatek/mt76/mt7603/regs.h                 |  15 +--
 drivers/net/wireless/mediatek/mt76/mt7615/Makefile               |   4 +-
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c              |  60 ++++++++-
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c               |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7615/init.c                 | 318 ++++++++++++++++++++++++++++++++++-----------
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c                  | 606 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h                  |  36 +++++
 drivers/net/wireless/mediatek/mt76/mt7615/main.c                 | 329 +++++++++++++++++++++++++++++++++++-----------
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                  | 204 ++++++++++++++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h                  |  60 +++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h               | 145 +++++++++++++++------
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615_trace.h         |  56 ++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c                  |  10 +-
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h                 | 108 ++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7615/trace.c                |  12 ++
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c               |   4 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/init.c                 |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/main.c                 |   8 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c                  |   8 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci_mcu.c              |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c                  |  32 ++---
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c                  |  30 +++--
 drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c              |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h                     |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c              |  91 ++++---------
 drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c                 |  14 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                 |  43 +++---
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.h                 |   5 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c                |  25 ++--
 drivers/net/wireless/mediatek/mt76/mt76x02_phy.c                 |   4 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_phy.h                 |   4 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_regs.h                |  12 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_trace.h               |  46 -------
 drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c                |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c            |  61 ++++-----
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c             |  11 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c                |  27 ++--
 drivers/net/wireless/mediatek/mt76/mt76x2/Makefile               |   2 -
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c               |   4 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.h               |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c                  |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h               |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c             |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c             |  24 ++--
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c              |   8 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/phy.c                  |  26 ++--
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c                  |   4 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c             |  20 +--
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c              |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c             |  18 +--
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c              |   6 +-
 drivers/net/wireless/mediatek/mt76/trace.c                       |   3 +
 drivers/net/wireless/mediatek/mt76/trace.h                       |  54 +++++++-
 drivers/net/wireless/mediatek/mt76/tx.c                          |  85 +++++++-----
 drivers/net/wireless/mediatek/mt76/usb.c                         | 446 +++++++++++++++++++++++++++++++++++++++++++++-----------------
 drivers/net/wireless/mediatek/mt76/util.c                        |   8 +-
 drivers/net/wireless/mediatek/mt76/util.h                        |  14 +-
 73 files changed, 2712 insertions(+), 1479 deletions(-)
 delete mode 100644 drivers/net/wireless/mediatek/mt76/airtime.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/mt7615_trace.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/trace.c
