Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6851CAA818
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 18:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbfIEQQb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 12:16:31 -0400
Received: from nbd.name ([46.4.11.11]:40556 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbfIEQQb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 12:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0jbZL1M1nrQCzpd51I3iNOOp8bif/R+s7AgG8E7AOCM=; b=U7QjP/hU1zKLJ74Gabhrmi9981
        hgcogMpt7RtYLDnCKHgs/NH7c/MNrQToutZGzLV05VJKk4ICkdAbvVklwHLJtz+W6m3xapfCxqOA8
        Wu63Wra5PFlRJj+OB/UkjXfsy/5MiCZgDTJjOO/Z8oYlko86idFDmyvOm8XPyKVp7CU0=;
Received: from p5b206b89.dip0.t-ipconnect.de ([91.32.107.137] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1i5uQu-0000TG-VO; Thu, 05 Sep 2019 18:16:29 +0200
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2019-09-05
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
Message-ID: <9ff2d7b9-e014-ba60-5872-289765ac3a7f@nbd.name>
Date:   Thu, 5 Sep 2019 18:16:28 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's my first pull request for 5.4

- Felix

The following changes since commit 84b0b66352470e6491c06159735ac916dc69a2ef:

  zd1211rw: zd_usb: Use struct_size() helper (2019-09-03 16:45:35 +0300)

are available in the Git repository at:

  https://github.com/nbd168/wireless tags/mt76-for-kvalo-2019-09-05

for you to fetch changes up to 0e6a29e477f3905ceba37d5ec545e5927e047bc4:

  mt76: mt7615: add support to read temperature from mcu (2019-09-05 18:14:15 +0200)

----------------------------------------------------------------
mt76 patches for 5.4

* beacon tx fix for mt76x02
* sparse/checkpatch warning fixes
* DFS pattern detector for mt7615 (DFS channels not enabled yet)
* CSA support for mt7615
* mt7615 cleanup/fixes
* mt7615 rate control improvements
* usb fixes
* mt7615 powersave buffering fix
* new device support for mt76x0
* support for more ciphers in mt7615
* watchdog time fixes
* smart carrier sense on mt7615
* survey support on mt7615
* multiple interfaces on mt76x02u
* calibration data fix for mt7615
* fix for sending BAR after disassoc

----------------------------------------------------------------
Felix Fietkau (16):
      mt76: round up length on mt76_wr_copy
      mt76: mt7615: clean up FWDL TXQ during/after firmware upload
      mt76: mt7603: enable hardware rate up/down selection
      mt76: mt7615: move mt7615_mcu_set_rates to mac.c
      mt76: mt7615: reset rate index/counters on rate table update
      mt76: mt7615: sync with mt7603 rate control changes
      mt76: mt7615: fix using VHT STBC rates
      mt76: mt7615: fix PS buffering of action frames
      mt76: mt7615: fix invalid fallback rates
      mt76: mt7603: fix invalid fallback rates
      mt76: mt7615: add missing register initialization
      mt76: mt7615: apply calibration-free data from OTP
      mt76: dma: reset q->rx_head on rx reset
      mt76: stop rx aggregation on station removal
      mt76: do not send BAR frame on tx aggregation flush stop
      mt76: remove offchannel check in tx scheduling

Lorenzo Bianconi (33):
      mt76: mt7615: fix sparse warnings: warning: restricted __le16 degrades to integer
      mt76: mt7615: introduce mt7615_regd_notifier
      mt76: mt7615: add hw dfs pattern detector support
      mt76: mt7615: do not perform txcalibration before cac is complited
      mt76: mt7615: add csa support
      mt76: mt7615: add radar pattern test knob to debugfs
      mt76: mt7615: fall back to sw encryption for unsupported ciphers
      mt76: mt7615: always release sem in mt7615_load_patch
      mt76: mt7615: introduce mt7615_mcu_send_ram_firmware routine
      mt76: mt76u: fix typo in mt76u_fill_rx_sg
      mt76: mt76x0u: add support to TP-Link T2UHP
      mt76: mt7615: move mt7615_mac_get_key_info in mac.c
      mt76: mt7615: add mt7615_mac_wtbl_addr routine
      mt76: mt7615: introduce mt7615_mac_wtbl_set_key routine
      mt76: mt7615: remove wtbl_sec_key definition
      mt76: mt7615: add set_key_cmd and mt76_wcid to mt7615_mac_wtbl_set_key signature
      mt76: introduce mt76_mmio_read_copy routine
      mt76: mt7615: fix MT7615_WATCHDOG_TIME definition
      mt76: mt7603: fix watchdog rescheduling in mt7603_set_channel
      mt76: mt7615: rework locking scheme for mt7615_set_channel
      mt76: mt7615: add Smart Carrier Sense support
      mt76: mt76x02: introduce mt76x02_pre_tbtt_enable and mt76x02_beacon_enable macros
      mt76: mt76x02: do not copy beacon skb in mt76x02_mac_set_beacon_enable
      mt76: mt76x02u: enable multi-vif support
      mt76: mt76x02u: enable survey support
      mt76: mt7603: move survey_time in mt76_dev
      mt76: mt7615: enable survey support
      mt76: move mt76_tx_tasklet in mt76 module
      mt76: mt7603: remove unnecessary mcu queue initialization
      mt76: mt7615: add BIP_CMAC_128 cipher support
      mt76: add default implementation for mt76_sw_scan/mt76_sw_scan_complete
      mt76: mt7615: introduce mt7615_txwi_to_txp utility routine
      mt76: mt7615: add support to read temperature from mcu

Ryder Lee (8):
      mt76: mt7615: add 4 WMM sets support
      mt76: mt7615: update cw_min/max related settings
      mt76: Add paragraphs to describe the config symbols fully
      mt76: mt7603: fix some checkpatch warnings
      mt76: mt7615: fix some checkpatch warnings
      mt76: mt76x02: fix some checkpatch warnings
      mt76: switch to SPDX tag instead of verbose boilerplate text
      mt76: fix some checkpatch warnings

Stanislaw Gruszka (8):
      mt76: usb: fix endian in mt76u_copy
      mt76: usb: remove unneeded {put,get}_unaligned
      mt76: mt76x02: use params->ssn value directly
      mt76: mt7603: use params->ssn value directly
      mt76: mt7615: use params->ssn value directly
      mt76: make mt76_rx_convert static
      mt76: mt76x0: remove redundant chandef copy
      mt76: mt76x0: remove unneeded return value on set channel

YueHaibing (1):
      mt76: mt7603: use devm_platform_ioremap_resource() to simplify code

 drivers/net/wireless/mediatek/mt76/agg-rx.c           |  36 ++---
 drivers/net/wireless/mediatek/mt76/debugfs.c          |  13 +-
 drivers/net/wireless/mediatek/mt76/dma.c              |  21 ++-
 drivers/net/wireless/mediatek/mt76/dma.h              |  13 +-
 drivers/net/wireless/mediatek/mt76/eeprom.c           |  13 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c         |  78 ++++++-----
 drivers/net/wireless/mediatek/mt76/mcu.c              |  13 +-
 drivers/net/wireless/mediatek/mt76/mmio.c             |  28 ++--
 drivers/net/wireless/mediatek/mt76/mt76.h             |  43 +++---
 drivers/net/wireless/mediatek/mt76/mt7603/Kconfig     |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/core.c      |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c       |  17 +--
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/init.c      |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c       |  14 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c      |  41 ++----
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.c       |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h    |   1 -
 drivers/net/wireless/mediatek/mt76/mt7603/pci.c       |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c       |   5 +-
 drivers/net/wireless/mediatek/mt76/mt7615/Kconfig     |   7 +-
 drivers/net/wireless/mediatek/mt76/mt7615/Makefile    |   3 +-
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c   |  91 ++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c       |  12 +-
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c    |  38 +++++
 drivers/net/wireless/mediatek/mt76/mt7615/init.c      |  80 ++++++++---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c       | 733 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h       |  28 ++++
 drivers/net/wireless/mediatek/mt76/mt7615/main.c      | 111 +++++++++------
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c       | 474 ++++++++++++++++++++++++++++++--------------------------------
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h       |  54 ++++---
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h    |  99 +++++++++++--
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c       |   1 +
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h      |  75 ++++++++++
 drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig     |  12 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/main.c      |  17 +--
 drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c       |  15 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci_mcu.c   |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c       |  49 +++----
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.h       |  10 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c       |  28 ++--
 drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c   |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h          |  45 +++---
 drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c   |  83 ++++-------
 drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c  |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c      |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_dfs.h      |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_dma.h      |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.c   |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.h   |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c      |  29 ++--
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.h      |  15 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c      |  26 ++--
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.h      |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c     |  24 +---
 drivers/net/wireless/mediatek/mt76/mt76x02_phy.c      |  16 +--
 drivers/net/wireless/mediatek/mt76/mt76x02_phy.h      |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_regs.h     |  41 ++----
 drivers/net/wireless/mediatek/mt76/mt76x02_trace.c    |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_trace.h    |  16 +--
 drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c     |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_usb.h      |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c  |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c     |  75 +++++-----
 drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig     |  14 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c    |  23 +--
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.h    |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/init.c      |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mac.c       |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mac.h       |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c       |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mcu.h       |  16 +--
 drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h    |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2u.h   |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c       |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c  |  14 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c  |  15 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_mcu.c   |  17 +--
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c   |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/phy.c       |  18 +--
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c       |  14 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c  |  20 ++-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c   |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c  |  24 ++--
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_mcu.c   |  13 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c   |  13 +-
 drivers/net/wireless/mediatek/mt76/trace.c            |  13 +-
 drivers/net/wireless/mediatek/mt76/trace.h            |  22 +--
 drivers/net/wireless/mediatek/mt76/tx.c               |  44 +++---
 drivers/net/wireless/mediatek/mt76/usb.c              |  60 ++++----
 drivers/net/wireless/mediatek/mt76/usb_trace.c        |  13 +-
 drivers/net/wireless/mediatek/mt76/usb_trace.h        |  24 +---
 drivers/net/wireless/mediatek/mt76/util.c             |  13 +-
 drivers/net/wireless/mediatek/mt76/util.h             |   4 +-
 98 files changed, 1870 insertions(+), 1518 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
