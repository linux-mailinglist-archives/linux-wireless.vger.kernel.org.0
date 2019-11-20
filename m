Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEE9103A18
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 13:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfKTMb6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 07:31:58 -0500
Received: from nbd.name ([46.4.11.11]:56268 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727845AbfKTMb6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 07:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hFz8o7x6gLGI5H6Df+Qjjqgmz2txoCFeeMD8Zr+PyGc=; b=U8JClzjq3t/Gvnlizswh1LZLwo
        0ci28p3jb9mJpwyg455TTWLhbnv74h9wuD8u6PWZtiUz2L7Q+icR8jL/KGKTiGqOOVXyprodu493n
        Dkzy0JT9IQEuhx2pQkbN4+HRjVAD8zlRMCsJ+aufo6KxZa9x8Cenb16dDdTbHK7IP+Eo=;
Received: from p4ff13fe7.dip0.t-ipconnect.de ([79.241.63.231] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iXP9G-00017i-Rv; Wed, 20 Nov 2019 13:31:55 +0100
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2019-11-20
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
Message-ID: <0a95938f-78d4-03a5-9d38-0e3502b7a965@nbd.name>
Date:   Wed, 20 Nov 2019 13:31:54 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's my first pull request for 5.5

- Felix

The following changes since commit eac08515d7bd665d306cefa2ae9f3de56e875d6d:

  rtl8xxxu: Remove set but not used variable 'vif','dev','len' (2019-11-20 09:47:19 +0200)

are available in the Git repository at:

  https://github.com/nbd168/wireless tags/mt76-for-kvalo-2019-11-20

for you to fetch changes up to 23cb16d2ccb5f819d7acff602e5a153157bf2884:

  mt76: mt76u: fix endpoint definition order (2019-11-20 13:23:51 +0100)

----------------------------------------------------------------
mt76 patches for 5.5

* monitor mode fix for mt7615
* fixes for rx aggregation race conditions
* cleanups
* mt7615 smart carrier sense support
* code unification / deduplication
* mt7615 debugfs improvements
* debugfs aggregation statistics
* airtime fairness support
* mt76x0 OF mac address support
* locking fixes
* usb support improvements
* rate control fixes

----------------------------------------------------------------
Colin Ian King (1):
      mt76: mt76x0e: make array mt76x0_chan_map static const, makes object smaller

Felix Fietkau (22):
      mt76: mt7615: fix control frame rx in monitor mode
      mt76: remove aggr_work field from struct mt76_wcid
      mt76: use cancel_delayed_work_sync in mt76_rx_aggr_shutdown
      mt76: mt7603: remove q_rx field from struct mt7603_dev
      mt76: report rx a-mpdu subframe status
      mt76: rename mt76_driver_ops txwi_flags to drv_flags and include tx aligned4
      mt76: store current channel survey_state in struct mt76_dev
      mt76: track rx airtime for airtime fairness and survey
      mt76: mt7603: track tx airtime for airtime fairness and survey
      mt76: mt7603: switch to a different counter for survey busy time
      mt76: unify channel survey update code
      mt76: mt76x02: move MT_CH_TIME_CFG init to mt76x02_mac_cc_reset
      mt76: mt76x02: track approximate tx airtime for airtime fairness and survey
      mt76: mt7615: fix survey channel busy time
      mt76: enable airtime fairness
      mt76: do not use devm API for led classdev
      mt76: add missing locking around ampdu action
      mt76: drop rcu read lock in mt76_rx_aggr_stop
      mt76: fix aggregation stop issue
      mt76: avoid enabling interrupt if NAPI poll is still pending
      mt76: add sanity check for a-mpdu rx wcid index
      mt76: remove obsolete .add_buf() from struct mt76_queue_ops

Lorenzo Bianconi (29):
      mt76: remove empty flag in mt76_txq_schedule_list
      mt76: usb: add lockdep_assert_held in __mt76u_vendor_request
      mt76: mt7615: enable SCS by default
      mt76: mt76x02: move mac_reset_counter in mt76x02_lib module
      mt76: mt76x2: move mt76x02_mac_reset_counters in mt76x02_mac_start
      mt76: mt76x0u: reset counter starting the device
      mt76: mt76x02u: move mt76x02u_mac_start in mt76x02-usb module
      mt76: move queue debugfs entry to driver specific code
      mt76: mt7615: add queue entry in debugfs
      mt76: move aggr_stats array in mt76_dev
      mt76: mt7615: collect aggregation stats
      mt76: mt7603: collect aggregation stats
      mt76: mt7615: report tx_time, bss_rx and busy time to mac80211
      mt76: mt7615: introduce mt7615_mac_wtbl_update routine
      mt76: mt7615: track tx/rx airtime for airtime fairness
      mt76: refactor cc_lock locking scheme
      mt76: mt76x02u: update ewma pkt len in mt76x02u_tx_prepare_skb
      mt76: mt76x0: remove 350ms delay in mt76x0_phy_calibrate
      mt76: mt76u: rely on usb_interface instead of usb_dev
      mt76: mt76u: rely on a dedicated stats workqueue
      mt76: use mt76_dev in mt76_is_{mmio,usb}
      mt76: move SUPPORTS_REORDERING_BUFFER hw property in mt76_register_device
      mt76: mt7615: add ibss support
      mt76: move interface_modes definition in mt76_core module
      mt76: mt7615: disable radar pattern detector during scanning
      mt76: fix possible out-of-bound access in mt7615_fill_txs/mt7603_fill_txs
      mt76: move mt76_get_antenna in mt76_core module
      mt76: mt7615: read {tx,rx} mask from eeprom
      mt76: mt76u: fix endpoint definition order

Pawel Dembicki (1):
      mt76: mt76x0: eeprom: add support for MAC address from OF

Stanislaw Gruszka (1):
      Revert "mt76: mt76x0e: don't use hw encryption for MT7630E"

YueHaibing (1):
      mt76: mt7615: remove unneeded semicolon

zhengbin (1):
      mt76: Remove set but not used variable 'idx'

 drivers/net/wireless/mediatek/mt76/Makefile           |   2 +-
 drivers/net/wireless/mediatek/mt76/agg-rx.c           |  20 +++---
 drivers/net/wireless/mediatek/mt76/airtime.c          | 326 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/debugfs.c          |   5 +-
 drivers/net/wireless/mediatek/mt76/dma.c              |  11 ++--
 drivers/net/wireless/mediatek/mt76/mac80211.c         | 194 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt76.h             | 113 ++++++++++++++++++---------------
 drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c   |  38 +++++++++++
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c       |   2 +
 drivers/net/wireless/mediatek/mt76/mt7603/init.c      |  14 ++--
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c       | 141 ++++++++++++++++++++++++++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7603/main.c      |  19 +++++-
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h    |  11 +++-
 drivers/net/wireless/mediatek/mt76/mt7603/regs.h      |   5 ++
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c   | 100 +++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c       |   2 +
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c    |  18 ++++++
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h    |   3 +
 drivers/net/wireless/mediatek/mt76/mt7615/init.c      |  43 +++++++++----
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c       | 187 +++++++++++++++++++++++++++++++++++++++++++++++-------
 drivers/net/wireless/mediatek/mt76/mt7615/main.c      |  46 ++++++++++++--
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c       |  16 ++++-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h    |  11 ++++
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c       |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h      |  57 ++++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c    |   3 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/init.c      |  27 --------
 drivers/net/wireless/mediatek/mt76/mt76x0/main.c      |   9 +--
 drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h    |   3 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c       |  29 ++-------
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c       |  13 ++--
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c       |  16 ++---
 drivers/net/wireless/mediatek/mt76/mt76x02.h          |   3 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c  |   5 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c      | 119 +++++++++++++++++++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.h      |   8 +++
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c      |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c     |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c     |  10 ++-
 drivers/net/wireless/mediatek/mt76/mt76x02_usb.h      |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c |  31 ++++++++-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c     |  18 ++----
 drivers/net/wireless/mediatek/mt76/mt76x2/mac.h       |   1 -
 drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2u.h   |   1 -
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c       |   4 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c  |  30 +--------
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c  |  26 ++------
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c       |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c  |   7 --
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c   |  27 --------
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c  |   9 ++-
 drivers/net/wireless/mediatek/mt76/tx.c               |  23 ++-----
 drivers/net/wireless/mediatek/mt76/usb.c              |  44 ++++++++-----
 53 files changed, 1466 insertions(+), 399 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/airtime.c
