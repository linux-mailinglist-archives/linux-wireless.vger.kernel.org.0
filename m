Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7B81D2C3B
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2020 12:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgENKMX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 May 2020 06:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgENKMX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 May 2020 06:12:23 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC5BC061A0C
        for <linux-wireless@vger.kernel.org>; Thu, 14 May 2020 03:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=LKE7WsA/5u1ORgtnDfho5pbAK26odGriTgcy4XDGuNQ=; b=Olel4QuplHUWEtjhdDzEymOUUs
        FQPskseoQ+JXSR9lujbaL8zbmyjW69Ptao+0lm4kbPYOl/F6T3Et5O6surTql0RgVDp/1sk0bysCH
        5B4+GA7ZPJFWTwNenMtaAPW2MXFuQzHfJqHXL13qXRuwt74gKp7OFbRR40o9A9fHQRtg=;
Received: from [80.255.7.101] (helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jZAqh-0001NU-Uz; Thu, 14 May 2020 12:12:20 +0200
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2019-05-14
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
Message-ID: <f49dab4e-5dfc-a8fd-db7e-de22ff01ded1@nbd.name>
Date:   Thu, 14 May 2020 12:12:19 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's my first pull request for 5.8.

- Felix

The following changes since commit 5bb4e125815aa769a7d2ab7dc203593925bba0ba:

  ipw2x00: Fix comment for CLOCK_BOOTTIME constant (2020-05-12 11:57:26 +0300)

are available in the Git repository at:

  https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-05-14

for you to fetch changes up to 12a87174accd29ff943d4c5fb735e1541b92630b:

  mt76: mt7615: fix typo defining ps work (2020-05-14 11:08:19 +0200)

----------------------------------------------------------------
mt76 patches for 5.8

* new devices for mt76x0/mt76x2
* mt7615 fixes
* mt7663 fixes
* support for non-offload firmware on mt7663
* hw/sched scan support for mt7663
* mt7615/mt7663 MSI support
* TDLS support
* mt7603/mt7615 rate control fixes
* new driver for mt7915
* wowlan support for mt7663
* suspend/resume support for mt7663

----------------------------------------------------------------
Dejin Zheng (1):
      mt76: mt7603: remove duplicate error message

Felix Fietkau (21):
      mt76: mt76x02: fix handling MCU timeouts during hw restart
      dt-bindings: net: wireless: mt76: document mediatek,eeprom-merge-otp property
      mt76: mt7615: disable merge of OTP ROM data by default
      mt76: mt7615: add support for applying DC offset calibration from EEPROM
      mt76: mt7615: add support for applying tx DPD calibration from EEPROM
      mt76: mt7603: disable merge of OTP ROM data by default
      mt76: mt76x2: disable merge of OTP ROM data by default
      mt76: mt7615: disable hw/sched scan ops for non-offload firmware
      mt76: mt7615: set hw scan limits only for firmware with offload support
      mt76: mt7615: rework IRQ handling to prepare for MSI support
      mt76: mt7615: fix sta ampdu factor for VHT
      mt76: fix A-MPDU density handling
      mt76: mt7615: use larger rx buffers if VHT is supported
      mt76: mt7615: never use an 802.11b CF-End rate on 5GHz
      mt76: mt7603: never use an 802.11b CF-End rate on 5GHz
      mt76: mt7615: adjust timing in mt7615_mac_set_timing to match fw/hw values
      mt76: mt7615: do not adjust MAC timings if the device is not running
      mt76: mt7615: fix tx status rate index calculation
      mt76: mt7603: fix tx status rate index calculation
      mt76: mt7615: set spatial extension index
      mt76: mt7615: fix getting maximum tx power from eeprom

Jules Irenge (1):
      mt76: remove unnecessary annotations

Lorenzo Bianconi (71):
      mt76: mt76x2u: introduce Mercury UD13 support
      mt76: mt7663: fix mt7615_mac_cca_stats_reset routine
      mt76: mt7663: enable nf estimation
      mt76: mt7615: make scs configurable per phy
      mt76: mt7663: disable RDD commands
      mt76: mt7615: add ethool support to mt7663 driver
      mt76: mt7615: introduce mt7615_mcu_set_channel_domain mcu command
      mt76: mt7615: introduce hw scan support
      mt76: mt7615: introduce scheduled scan support
      mt76: mt7615: introduce rlm tlv in bss_info mcu command
      mt76: add headroom and tailroom to mt76_mcu_ops data structure
      mt76: mt7615: introduce mt7663u support to mt7615_write_txwi
      mt76: mt7615: introduce mt7615_mac_update_rate_desc routine
      mt76: mt7615: introduce __mt7663_load_firmware routine
      mt76: mt7615: move mt7615_mac_wtbl_addr in mac.h
      mt76: mt76u: rely on mt7622 queue scheme for mt7663u
      mt76: mt7615: rework wtbl key configuration
      mt76: mt7615: introduce mt7615_wtbl_desc data structure
      mt76: mt7615: add address parameter to mt7615_eeprom_init
      mt76: mt7615: do not always reset the dfs state setting the channel
      mt76: mt7615: fix possible division by 0 in mt7615_mac_update_mib_stats
      mt76: mt7663: fix aggr range entry in debugfs
      mt76: mt7622: fix DMA unmap length
      mt76: mt7663: fix DMA unmap length
      mt76: mt7615: enable MSI by default
      mt76: mt7615: fix possible deadlock in mt7615_stop
      mt76: mt7615: move core shared code in mt7615-common module
      mt76: mt7615: introduce mt7663u support
      mt76: mt7615: enable scs for mt7663 driver
      mt76: mt7615: disable aspm by default
      mt76: mt7615: provide aid info to the mcu
      mt76: remove PS_NULLFUNC_STACK capability
      mt76: mt7663: introduce 802.11 PS support in sta mode
      mt76: add rx queues info to mt76 debugfs
      mt76: mt7615: parse mcu return code for unified commands
      mt76: mt7615: fix mt7615_firmware_own for mt7663e
      mt76: mt7615: fix max wtbl size for 7663
      mt76: mt7615: fix mt7615_driver_own routine
      mt76: mt7615: fix aid configuration in mt7615_mcu_wtbl_generic_tlv
      mt76: mt7615: rework mt7615_mac_sta_poll for usb code
      mt76: mt7663u: enable AirTimeFairness
      mt76: mt7615: move mcu bss upload before creating the sta
      mt76: enable TDLS support
      mt76: mt7615: add sta pointer to mt7615_mcu_add_bss_info signature
      mt76: mt7615: fix event report in mt7615_mcu_bss_event
      mt76: mt76x0: enable MCS 8 and MCS9
      mt76: mt7663: add the possibility to load firmware v2
      mt76: mt7663: remove check in mt7663_load_n9
      mt76: mt7615: fix ssid configuration in mt7615_mcu_hw_scan
      mt76: mt7615: introduce mt7615_check_offload_capability routine
      mt76: mt7615: do not mark sched_scan disabled in mt7615_scan_work
      mt76: mt7615: add passive mode for hw scan
      mt76: mt7615: free pci_vector if mt7615_pci_probe fails
      mt76: mt7615: introduce support for hardware beacon filter
      mt76: mt7615: add WoW support
      mt76: mt7615: introduce PM support
      mt76: mt7615: add gtk rekey offload support
      mt76: mt7615: introduce beacon_loss mcu event
      mt76: mt7663: read tx streams from eeprom
      mt76: mt7615: check return value of mt7615_eeprom_get_power_index
      mt76: mt7615: fix ibss mode for mt7663
      mt76: mt7663: fix target power parsing
      mt76: mt7615: fix delta tx power for mt7663
      mt76: mt7615: scan all channels if not specified
      mt76: mt7663u: copy key pointer in mt7663u_mac_write_txwi
      mt76: mt7663u: add missing register definitions
      mt76: mt7615: usb: cancel ps work stopping the vif
      mt76: mt7615: do not report scan_complete twice to mac80211
      mt76: mt7615: reduce hw scan timeout
      mt76: enable p2p support
      mt76: mt7615: fix typo defining ps work

Markus Elfring (1):
      mt76: mt7615: Delete an error message in mt7622_wmac_probe()

Matthew Garrett (1):
      mt76: mt76x02u: Add support for newer versions of the XBox One wifi adapter

Pawel Dembicki (1):
      mt76: mt76x0: pci: add mt7610 PCI ID

Ryder Lee (29):
      mt76: mt7615: modify mt7615_ampdu_stat_read for each phy
      mt76: mt7615: enable aggr_stats for both phy
      mt76: mt7615: cleanup mib related defines and structs
      mt76: mt7615: add more useful Tx mib counters
      mt76: avoid rx reorder buffer overflow
      mt76: add support for HE RX rate reporting
      mt76: add Rx stats support for radiotap
      mt76: adjust wcid size to support new 802.11ax generation
      mt76: add HE phy modes and hardware queue
      mt76: add mac80211 driver for MT7915 PCIe-based chipsets
      mt76: mt7915: enable Rx HE rate reporting
      mt76: mt7915: implement HE per-rate tx power support
      mt76: mt7915: register per-phy HE capabilities for each interface
      mt76: mt7915: add HE bss_conf support for interfaces
      mt76: mt7915: add HE capabilities support for peers
      mt76: mt7915: add Rx radiotap header support
      mt76: mt7915: add .sta_add_debugfs support
      mt76: mt7915: add .sta_statistics support
      mt76: mt7915: set peer Tx fixed rate through debugfs
      mt76: mt7915: add tsf related callbacks
      mt76: mt7915: enable firmware module debug support
      mt76: set runtime stream caps by mt76_phy
      mt76: mt7915: introduce mt7915_get_he_phy_cap
      mt76: mt7915: add Tx beamformer support
      mt76: mt7915: add Tx beamformee support
      mt76: mt7915: add TxBF capabilities
      mt76: mt7915: add debugfs to track TxBF status
      mt76: mt7915: allocate proper size for tlv tags
      mt76: mt7915: fix possible deadlock in mt7915_stop

Sean Wang (12):
      mt76: mt7663: keep Rx filters as the default
      mt76: mt7615: introduce BSS absence event
      mt76: mt7615: remove unnecessary register operations
      mt76: mt7663: correct the name of the rom patch
      mt76: mt7615: make Kconfig entry obvious for MT7663E
      mt76: mt7663: fix up BMC entry indicated to unicmd firmware
      mt76: mt7615: introduce mt7615_mcu_set_hif_suspend mcu command
      mt76: mt7663u: introduce suspend/resume to mt7663u
      mt76: mt7663: introduce WoW with net detect support
      mt76: mt7663: add support to sched scan with randomise addr
      mt76: mt7663: fix the usage WoW with net detect support
      mt76: mt7615: configure bss info adding the interface

 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt |    3 +
 drivers/net/wireless/mediatek/mt76/Kconfig                       |    1 +
 drivers/net/wireless/mediatek/mt76/Makefile                      |    3 +-
 drivers/net/wireless/mediatek/mt76/agg-rx.c                      |   12 +-
 drivers/net/wireless/mediatek/mt76/debugfs.c                     |   21 +
 drivers/net/wireless/mediatek/mt76/mac80211.c                    |   33 +-
 drivers/net/wireless/mediatek/mt76/mcu.c                         |    9 +-
 drivers/net/wireless/mediatek/mt76/mmio.c                        |    3 +-
 drivers/net/wireless/mediatek/mt76/mt76.h                        |   60 +-
 drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c              |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c               |    5 +
 drivers/net/wireless/mediatek/mt76/mt7603/init.c                 |    2 +
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c                  |   12 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.c                  |    3 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.h                  |    7 -
 drivers/net/wireless/mediatek/mt76/mt7603/soc.c                  |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7615/Kconfig                |   20 +-
 drivers/net/wireless/mediatek/mt76/mt7615/Makefile               |   10 +-
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c              |   47 +-
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c                  |   87 +--
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c               |   87 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h               |   33 +-
 drivers/net/wireless/mediatek/mt76/mt7615/init.c                 |  283 +++-----
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c                  |  752 ++++++++++----------
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h                  |   39 ++
 drivers/net/wireless/mediatek/mt76/mt7615/main.c                 |  331 +++++++--
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                  | 1527 ++++++++++++++++++++++++++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h                  |  293 +++++++-
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c                 |   73 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h               |  177 ++++-
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c                  |  132 +++-
 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c             |  174 +++++
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c              |  184 +++++
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h                 |  108 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/soc.c                  |    4 +-
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c                  |  446 ++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/usb_init.c             |  145 ++++
 drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c              |   93 +++
 drivers/net/wireless/mediatek/mt76/mt76x0/init.c                 |   26 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c                  |    3 +
 drivers/net/wireless/mediatek/mt76/mt76x02.h                     |    3 +
 drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c             |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                 |    7 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c                 |    5 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.h                 |    6 -
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c                |   16 +
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c             |    4 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c                |    4 +
 drivers/net/wireless/mediatek/mt76/mt76x2/eeprom.c               |    5 +
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c             |    1 +
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c             |   21 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c                  |    2 +
 drivers/net/wireless/mediatek/mt76/mt7915/Kconfig                |   13 +
 drivers/net/wireless/mediatek/mt76/mt7915/Makefile               |    6 +
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c              |  463 +++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c                  |  285 ++++++++
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c               |  243 +++++++
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h               |  125 ++++
 drivers/net/wireless/mediatek/mt76/mt7915/init.c                 |  701 +++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c                  | 1471 +++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7915/mac.h                  |  346 ++++++++++
 drivers/net/wireless/mediatek/mt76/mt7915/main.c                 |  833 ++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                  | 3161 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h                  | 1033 ++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h               |  467 +++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c                  |  191 ++++++
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h                 |  375 ++++++++++
 drivers/net/wireless/mediatek/mt76/tx.c                          |    4 +-
 drivers/net/wireless/mediatek/mt76/usb.c                         |   15 +-
 drivers/net/wireless/mediatek/mt76/util.c                        |    2 +-
 70 files changed, 14046 insertions(+), 1018 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/usb.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/usb_init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/Makefile
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/dma.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/mac.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/main.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/pci.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/regs.h
