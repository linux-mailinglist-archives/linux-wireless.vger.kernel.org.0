Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E32010757
	for <lists+linux-wireless@lfdr.de>; Wed,  1 May 2019 13:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfEALFL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 May 2019 07:05:11 -0400
Received: from nbd.name ([46.4.11.11]:52866 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbfEALFL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 May 2019 07:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3rZUdODZvb6bZWNe/3XUUdy0BUgAtPxrUMAG1KwSYaA=; b=lPzlIkDpuz36Ab+QHiSeyk/Wiz
        GwTckOBdinhFCUcbtRHoiDLXVdFrElhDtuQFHkse0zBRHN1adojOl8ZXy2hJ2Bo3hiL5+8SFiJeS3
        kmbrLz/AeO5odgocMlU24nI+I6j1kW4LqDogP+Vg/qkyu7K/7dYl2rMjZbjuhQqFMqE8=;
Received: from p4ff135f1.dip0.t-ipconnect.de ([79.241.53.241] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hLn2z-0003Tb-Km; Wed, 01 May 2019 13:05:09 +0200
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2019-05-01
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Openpgp: preference=signencrypt
Autocrypt: addr=nbd@nbd.name; prefer-encrypt=mutual; keydata=
 mQGiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwbQcRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPohgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQuQINBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabiEkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCfTKx80VvCR/PvsUlrvdOLsIgeRGAAn1ee
 RjMaxwtSdaCKMw3j33ZbsWS4
Message-ID: <6ec922a9-1ed9-9ef2-0043-65fcd242b1fd@nbd.name>
Date:   Wed, 1 May 2019 13:05:09 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's my first pull request for 5.2

- Felix

The following changes since commit e3037485c68ec1a299ff41160d8fedbd4abc29b9:

  rtw88: new Realtek 802.11ac driver (2019-04-30 19:43:37 +0300)

are available in the Git repository at:

  https://github.com/nbd168/wireless tags/mt76-for-kvalo-2019-05-01

for you to fetch changes up to 4d2a6f7b4e17ede86be46013d114d58adaca5631:

  mt76: mt7603: dynamically alloc mcu req in mt7603_mcu_set_eeprom (2019-05-01 13:04:00 +0200)

----------------------------------------------------------------
mt76 patches for 5.2

* share more code across drivers
* new driver for MT7615 chipsets
* rework DMA API
* tx/rx performance optimizations
* use NAPI for tx cleanup on mt76x02
* AP mode support for USB devices
* USB stability fixes
* tx power handling fixes for 76x2
* endian fixes

----------------------------------------------------------------
Felix Fietkau (11):
      mt76: fix tx power issues
      mt76: use readl/writel instead of ioread32/iowrite32
      mt76: use mac80211 txq scheduling
      mt76: reduce locking in mt76_dma_tx_cleanup
      mt76: store wcid tx rate info in one u32 reduce locking
      mt76: move tx tasklet to struct mt76_dev
      mt76: only schedule txqs from the tx tasklet
      mt76: mt76x02: use napi polling for tx cleanup
      mt76: mt76x02: remove irqsave/restore in locking for tx status fifo
      mt76: mt7603: fix initialization of max rx length
      mt76: mt7615: use sizeof instead of sizeof_field

Lorenzo Bianconi (35):
      mt76: mmio: move mt76x02_set_irq_mask in mt76 module
      mt76: dma: move mt76x02_init_{tx,rx}_queue in mt76 module
      mt76: remove mt76_queue dependency from tx_queue_skb function pointer
      mt76: remove mt76_queue dependency from tx_prepare_skb function pointer
      mt76: remove mt76_queue dependency from tx_complete_skb function pointer
      mt76: introduce mt76_sw_queue data structure
      mt76: introduce mt76_txq_id field in mt76_queue_entry
      mt76: move mt76x02_insert_hdr_pad in mt76-core module
      mt76: mmio: move mt76_insert_hdr_pad in mt76_dma_tx_queue_skb
      mt76: move skb dma mapping before running tx_prepare_skb
      mt76: introduce mt76_tx_info data structure
      mt76: dma: add static qualifier to mt76_dma_tx_queue_skb
      mt7603: remove mt7603_mcu_init routine
      mt7603: core: do not use magic numbers in mt7603_reg_map
      mt76: usb: reduce code indentation in mt76u_alloc_tx
      mt76: introduce mt76_free_device routine
      mt76: move mac_work in mt76_dev
      mt76: usb: reduce locking in mt76u_tx_tasklet
      mt76: set txwi_size according to the driver value
      mt76: add skb pointer to mt76_tx_info
      mt76: dma: introduce skb field in mt76_txwi_cache
      mt76: dma: add skb check for dummy pointer
      mt76: mt7603: remove query from mt7603_mcu_msg_send signature
      mt76: mt7603: use standard signature for mt7603_mcu_msg_send
      mt76: mt7603: initialize mt76_mcu_ops data structure
      mt76: introduce mt76_mcu_restart macro
      mt76: mt7603: init mcu_restart function pointer
      mt76: mt7603: run __mt76_mcu_send_msg in mt7603_mcu_send_firmware
      mt76: mt7603: report firmware version using ethtool
      mt76: move beacon_int in mt76_dev
      mt76: move beacon_mask in mt76_dev
      mt76: move pre_tbtt_tasklet in mt76_dev
      mt76: mt7603: enable/disable pre_tbtt_tasklet in mt7603_set_channel
      mt76: do not enable/disable pre_tbtt_tasklet in scan_start/scan_complete
      mt76: mt7603: dynamically alloc mcu req in mt7603_mcu_set_eeprom

Ryder Lee (6):
      mt76: add mac80211 driver for MT7615 PCIe-based chipsets
      mt76: add unlikely() for dma_mapping_error() check
      mt76: use macro for sn and seq_ctrl conversion
      MAINTAINERS: update entry for mt76 wireless driver
      mt76: fix endianness sparse warnings
      mt76: add TX/RX antenna pattern capabilities

Stanislaw Gruszka (28):
      mt76x02: introduce mt76x02_beacon.c
      mt76x02: add hrtimer for pre TBTT for USB
      mt76x02: introduce beacon_ops
      mt76x02u: implement beacon_ops
      mt76x02: generalize some mmio beaconing functions
      mt76x02u: add sta_ps
      mt76x02: disable HW encryption for group frames
      mt76x02u: implement pre TBTT work for USB
      mt76x02: make beacon slots bigger for USB
      mt76x02u: add mt76_release_buffered_frames
      mt76: unify set_tim
      mt76x02: enable AP mode for USB
      mt76usb: change mt76u_submit_buf
      mt76: remove rx_page_lock
      mt76usb: change mt76u_fill_rx_sg arguments
      mt76usb: use usb_dev private data
      mt76usb: remove mt76u_buf redundant fileds
      mt76usb: move mt76u_buf->done to queue entry
      mt76usb: remove mt76u_buf and use urb directly
      mt76usb: remove MT_RXQ_MAIN queue from mt76u_urb_alloc
      mt76usb: resue mt76u_urb_alloc for tx
      mt76usb: remove unneded sg_init_table
      mt76usb: allocate urb and sg as linear data
      mt76usb: remove queue variable from rx_tasklet
      mt76: mt76x02u: remove bogus stop on suspend
      mt76usb: fix tx/rx stop
      mt76: mt76x02: remove bogus mutex usage
      mt76: usb: use EP max packet aligned buffer sizes for rx

kbuild test robot (1):
      mt76: mt76x02: mt76x02_poll_tx() can be static

 MAINTAINERS                                           |    2 +
 drivers/net/wireless/mediatek/mt76/Kconfig            |    1 +
 drivers/net/wireless/mediatek/mt76/Makefile           |    3 +-
 drivers/net/wireless/mediatek/mt76/agg-rx.c           |    2 +-
 drivers/net/wireless/mediatek/mt76/debugfs.c          |    7 +-
 drivers/net/wireless/mediatek/mt76/dma.c              |  164 +++++-----
 drivers/net/wireless/mediatek/mt76/dma.h              |    2 +
 drivers/net/wireless/mediatek/mt76/mac80211.c         |   41 ++-
 drivers/net/wireless/mediatek/mt76/mmio.c             |   17 +-
 drivers/net/wireless/mediatek/mt76/mt76.h             |  119 ++++---
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c    |   35 +-
 drivers/net/wireless/mediatek/mt76/mt7603/core.c      |   19 +-
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c       |   39 +--
 drivers/net/wireless/mediatek/mt76/mt7603/init.c      |   12 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c       |   54 ++--
 drivers/net/wireless/mediatek/mt76/mt7603/main.c      |   34 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.c       |  116 ++++---
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h    |   23 +-
 drivers/net/wireless/mediatek/mt76/mt7603/regs.h      |    4 +
 drivers/net/wireless/mediatek/mt76/mt7615/Kconfig     |    7 +
 drivers/net/wireless/mediatek/mt76/mt7615/Makefile    |    5 +
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c       |  205 ++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c    |   98 ++++++
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h    |   18 ++
 drivers/net/wireless/mediatek/mt76/mt7615/init.c      |  229 ++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c       |  775 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h       |  300 ++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/main.c      |  499 +++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c       | 1655 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h       |  520 ++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h    |  195 ++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c       |  150 +++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h      |  203 ++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76x0/init.c      |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/main.c      |    8 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c       |   26 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c       |   49 +--
 drivers/net/wireless/mediatek/mt76/mt76x02.h          |   44 ++-
 drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c   |  286 +++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c      |  185 ++---------
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.h      |    4 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c     |  266 +++++++---------
 drivers/net/wireless/mediatek/mt76/mt76x02_regs.h     |    5 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c     |   29 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_usb.h      |   12 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c |  188 ++++++++++-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c     |  107 +------
 drivers/net/wireless/mediatek/mt76/mt76x2/init.c      |   12 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c       |    3 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c  |    6 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c  |   27 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/phy.c       |    6 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c       |   14 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c  |    5 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c  |   19 +-
 drivers/net/wireless/mediatek/mt76/tx.c               |  148 ++++-----
 drivers/net/wireless/mediatek/mt76/usb.c              |  379 ++++++++++++----------
 57 files changed, 6283 insertions(+), 1100 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/Makefile
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/dma.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/mac.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/main.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/pci.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/regs.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
