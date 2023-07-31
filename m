Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D631769121
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Jul 2023 11:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjGaJKo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jul 2023 05:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGaJKn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jul 2023 05:10:43 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCB0EE
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 02:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=f9bE52vuNyerC+2XLcxOpQMrax+osIjHD548ob2+DAM=; b=nBEciLjVSXGzJNoRf1oO4Y7jlS
        rmpaDBiLU7mNlxIJUK5YJumbS2afPLeZpytXGikal5aogt1lp54TRKPKLYr2GpPYkmGYz9vV+fC8x
        OMJq8KxPQvehTuLf8Ak5qIgKml7NurmJM3JLGLewWvJ7KAHDcpD4kD95P8BGs1p9i/3E=;
Received: from [217.114.218.24] (helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1qQOvG-003i0p-Jo; Mon, 31 Jul 2023 11:10:38 +0200
Message-ID: <7b752ccb-42b0-94ca-5492-f3892a14f6b3@nbd.name>
Date:   Mon, 31 Jul 2023 11:10:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2023-07-31
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=nbd@nbd.name; keydata=
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
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's my first request for 6.6

- Felix

The following changes since commit b2090d93d4b6f1c72a9793d5a171806b8468b7cb:

   wifi: brcmsmac: remove unused data type (2023-07-25 18:16:03 +0300)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2023-07-31

for you to fetch changes up to 6c0570bc21ec2073890aa252c8420ca7bec402e4:

   wifi: mt76: mt7915: fix power-limits while chan_switch (2023-07-31 10:56:28 +0200)

----------------------------------------------------------------
mt76 patches for 6.6

* fixes
* preparation for mt7925 support
* mt7981 support

----------------------------------------------------------------
Alexander Couzens (1):
       wifi: mt76: mt7915: add support for MT7981

Ben Greear (1):
       wifi: mt76: mt7921: Support temp sensor

Bo Jiao (2):
       wifi: mt76: mt7915: disable WFDMA Tx/Rx during SER recovery
       wifi: mt76: mt7996: disable WFDMA Tx/Rx during SER recovery

Christian Marangi (2):
       wifi: mt76: split get_of_eeprom in subfunction
       wifi: mt76: add support for providing eeprom in nvmem cells

Daniel Golle (1):
       dt-bindings: net: wireless: mt76: add bindings for MT7981

Deren Wu (3):
       wifi: mt76: mt7921: do not support one stream on secondary antenna only
       wifi: mt76: mt7921e: report tx retries/failed counts in tx free event
       wifi: mt76: mt7921: fix skb leak by txs missing in AMSDU

Felix Fietkau (4):
       wifi: mt76: mt7915: fix capabilities in non-AP mode
       wifi: mt76: mt7915: remove VHT160 capability on MT7915
       wifi: mt76: mt7603: fix beacon interval after disabling a single vif
       wifi: mt76: mt7603: fix tx filter/flush function

Howard Hsu (1):
       wifi: mt76: mt7996: increase tx token size

Lin Ma (1):
       wifi: mt76: testmode: add nla_policy for MT76_TM_ATTR_TX_LENGTH

Lorenzo Bianconi (49):
       wifi: mt76: mt7921: remove macro duplication in regs.h
       wifi: mt76: mt7915: move mib_stats structure in mt76.h
       wifi: mt76: mt7996: rely on mib_stats shared definition
       wifi: mt76: mt7921: rely on mib_stats shared definition
       wifi: mt76: mt7921: make mt7921_mac_sta_poll static
       mt76: mt7996: rely on mt76_sta_stats in mt76_wcid
       wifi: mt76: mt7921: get rid of MT7921_RESET_TIMEOUT marco
       wifi: mt76: mt7915: move sta_poll_list and sta_poll_lock in mt76_dev
       wifi: mt76: mt7603: rely on shared sta_poll_list and sta_poll_lock
       wifi: mt76: mt7615: rely on shared sta_poll_list and sta_poll_lock
       wifi: mt76: mt7996: rely on shared sta_poll_list and sta_poll_lock
       wifi: mt76: mt7921: rely on shared sta_poll_list and sta_poll_lock
       wifi: mt76: mt7915: move poll_list in mt76_wcid
       wifi: mt76: mt7603: rely on shared poll_list field
       wifi: mt76: mt7615: rely on shared poll_list field
       wifi: mt76: mt7996: rely on shared poll_list field
       wifi: mt76: mt7921: rely on shared poll_list field
       wifi: mt76: move ampdu_state in mt76_wcid
       mt76: connac: move more mt7921/mt7915 mac shared code in connac lib
       wifi: mt76: move rate info in mt76_vif
       wifi: mt76: connac: move connac3 definitions in mt76_connac3_mac.h
       wifi: mt76: connac: add connac3 mac library
       wifi: mt76: mt7921: move common register definition in mt792x_regs.h
       wifi: mt76: mt7921: convert acpisar and clc pointers to void
       wifi: mt76: mt7921: rename mt7921_vif in mt792x_vif
       wifi: mt76: mt7921: rename mt7921_sta in mt792x_sta
       wifi: mt76: mt7921: rename mt7921_phy in mt792x_phy
       wifi: mt76: mt7921: rename mt7921_dev in mt792x_dev
       wifi: mt76: mt7921: rename mt7921_hif_ops in mt792x_hif_ops
       wifi: mt76: mt792x: move shared structure definition in mt792x.h
       wifi: mt76: mt7921: move mt792x_mutex_{acquire/release} in mt792x.h
       wifi: mt76: mt7921: move mt792x_hw_dev in mt792x.h
       wifi: mt76: mt792x: introduce mt792x-lib module
       wifi: mt76: mt7921: move mac shared code in mt792x-lib module
       wifi: mt76: mt7921: move dma shared code in mt792x-lib module
       wifi: mt76: mt7921: move debugfs shared code in mt792x-lib module
       wifi: mt76: mt7921: move init shared code in mt792x-lib module
       wifi: mt76: mt792x: introduce mt792x_irq_map
       wifi: mt76: mt792x: move more dma shared code in mt792x_dma
       wifi: mt76: mt7921: move hif_ops macro in mt792x.h
       wifi: mt76: mt7921: move shared runtime-pm code on mt792x-lib
       wifi: mt76: mt7921: move runtime-pm pci code in mt792x-lib
       wifi: mt76: mt7921: move acpi_sar code in mt792x-lib module
       wifi: mt76: mt792x: introduce mt792x-usb module
       wifi: mt76: mt792x: move mt7921_load_firmware in mt792x-lib module
       wifi: mt76: mt76_connac3: move lmac queue enumeration in mt76_connac3_mac.h
       wifi: mt76: mt792x: move MT7921_PM_TIMEOUT and MT7921_HW_SCAN_TIMEOUT in common code
       wifi: mt76: mt7921: move mt7921_dma_init in pci.c
       wifi: mt76: mt7921: move mt7921u_disconnect mt792x-lib

Matt Whitlock (1):
       mt76: mt7921: don't assume adequate headroom for SDIO headers

MeiChia Chiu (1):
       wifi: mt76: mt7996: add muru support

Ming Yen Hsieh (1):
       wifi: mt76: mt7921: fix non-PSC channel scan fail

Peter Chiu (7):
       wifi: mt76: mt7915: rework tx packets counting when WED is active
       wifi: mt76: mt7915: rework tx bytes counting when WED is active
       wifi: mt76: report non-binding skb tx rate when WED is active
       wifi: mt76: connac: add support for dsp firmware download
       wifi: mt76: mt7996: fix bss wlan_idx when sending bss_info command
       wifi: mt76: mt7996: enable VHT extended NSS BW feature
       wifi: mt76: connac: add support to set ifs time by mcu command

Rafał Miłecki (1):
       dt-bindings: mt76: support pointing to EEPROM using NVMEM cell

Rany Hany (1):
       wifi: mt76: mt7915: fix command timeout in AP stop period

Ryder Lee (11):
       wifi: mt76: mt7996: fix header translation logic
       wifi: mt76: mt7996: enable BSS_CHANGED_MU_GROUPS support
       wifi: mt76: mt7615: enable BSS_CHANGED_MU_GROUPS support
       wifi: mt76: enable UNII-4 channel 177 support
       wifi: mt76: mt7915: report tx retries/failed counts for non-WED path
       wifi: mt76: mt7915: drop return in mt7915_sta_statistics
       wifi: mt76: mt7996: drop return in mt7996_sta_statistics
       wifi: mt76: add tx_nss histogram to ethtool stats
       wifi: mt76: mt7915: accumulate mu-mimo ofdma muru stats
       wifi: mt76: mt7915: fix tlv length of mt7915_mcu_get_chan_mib_info
       wifi: mt76: mt7915: fix power-limits while chan_switch

Shayne Chen (1):
       wifi: mt76: mt7996: move radio ctrl commands to proper functions

StanleyYP Wang (3):
       wifi: mt76: mt7915: fix background radar event being blocked
       wifi: mt76: mt7996: use correct phy for background radar event
       wifi: mt76: mt7996: fix WA event ring size

Yuanjun Gong (1):
       wifi: mt76: mt76x02: fix return value check in mt76x02_mac_process_rx

  Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml            |  13 +-
  drivers/net/wireless/mediatek/mt76/Kconfig                                   |   8 ++
  drivers/net/wireless/mediatek/mt76/Makefile                                  |  10 +-
  drivers/net/wireless/mediatek/mt76/dma.c                                     |   6 +
  drivers/net/wireless/mediatek/mt76/eeprom.c                                  |  87 ++++++++++---
  drivers/net/wireless/mediatek/mt76/mac80211.c                                |   6 +
  drivers/net/wireless/mediatek/mt76/mt76.h                                    | 106 ++++++++++++++-
  drivers/net/wireless/mediatek/mt76/mt7603/beacon.c                           |   3 +-
  drivers/net/wireless/mediatek/mt76/mt7603/init.c                             |   2 -
  drivers/net/wireless/mediatek/mt76/mt7603/mac.c                              |  43 ++++---
  drivers/net/wireless/mediatek/mt76/mt7603/main.c                             |  25 ++--
  drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h                           |   6 +-
  drivers/net/wireless/mediatek/mt76/mt7603/regs.h                             |   7 +
  drivers/net/wireless/mediatek/mt76/mt7615/init.c                             |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7615/mac.c                              |  31 ++---
  drivers/net/wireless/mediatek/mt76/mt7615/main.c                             |  49 +++++--
  drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h                           |   4 -
  drivers/net/wireless/mediatek/mt76/mt7615/regs.h                             |   9 ++
  drivers/net/wireless/mediatek/mt76/mt76_connac.h                             |  20 ++-
  drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h                        |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c                        | 182 ++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h                        | 339 ++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c                         | 106 +++++++++++++--
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h                         |   6 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                             |   3 +-
  drivers/net/wireless/mediatek/mt76/mt7915/Kconfig                            |   6 +-
  drivers/net/wireless/mediatek/mt76/mt7915/Makefile                           |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7915/coredump.c                         |   7 +-
  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c                          | 128 +++++++++---------
  drivers/net/wireless/mediatek/mt76/mt7915/dma.c                              | 152 ++++++++++++----------
  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c                           |   7 +-
  drivers/net/wireless/mediatek/mt76/mt7915/init.c                             |  19 ++-
  drivers/net/wireless/mediatek/mt76/mt7915/mac.c                              | 194 +++++++++++-----------------
  drivers/net/wireless/mediatek/mt76/mt7915/mac.h                              |   7 +-
  drivers/net/wireless/mediatek/mt76/mt7915/main.c                             | 233 +++++++++++++++++++++++++--------
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                              | 151 ++++++++++++++++++----
  drivers/net/wireless/mediatek/mt76/mt7915/mmio.c                             |  47 ++-----
  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                           | 100 ++++----------
  drivers/net/wireless/mediatek/mt76/mt7915/regs.h                             |  16 ++-
  drivers/net/wireless/mediatek/mt76/mt7915/soc.c                              | 162 ++++++++++++++++-------
  drivers/net/wireless/mediatek/mt76/mt7921/Kconfig                            |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7921/Makefile                           |   9 +-
  drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h                         | 105 ---------------
  drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c                          | 228 +++++---------------------------
  drivers/net/wireless/mediatek/mt76/mt7921/init.c                             | 343 +++++++++++-------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7921/mac.c                              | 554 +++++++++++-------------------------------------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7921/main.c                             | 806 +++++++++++++++++++++++++----------------------------------------------------------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                              | 230 +++++++++++----------------------
  drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                           | 359 +++++++--------------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7921/pci.c                              | 225 ++++++++++++++++----------------
  drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c                          |  34 ++---
  drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c                          |  71 +---------
  drivers/net/wireless/mediatek/mt76/mt7921/regs.h                             | 465 +-----------------------------------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c                             |  32 ++---
  drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c                         |   6 +-
  drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c                         |  14 +-
  drivers/net/wireless/mediatek/mt76/mt7921/testmode.c                         |  10 +-
  drivers/net/wireless/mediatek/mt76/mt7921/trace.c                            |  12 --
  drivers/net/wireless/mediatek/mt76/mt7921/usb.c                              | 205 ++++++++++++-----------------
  drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c                          | 255 ------------------------------------
  drivers/net/wireless/mediatek/mt76/mt792x.h                                  | 367 ++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/{mt7921/acpi_sar.c => mt792x_acpi_sar.c}  | 128 +++++++++---------
  drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h                         | 105 +++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt792x_core.c                             | 844 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt792x_debugfs.c                          | 168 ++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/{mt7921/dma.c => mt792x_dma.c}            | 336 +++++++++++++++++++++++++----------------------
  drivers/net/wireless/mediatek/mt76/mt792x_mac.c                              | 385 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt792x_regs.h                             | 479 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt792x_trace.c                            |  14 ++
  drivers/net/wireless/mediatek/mt76/{mt7921/mt7921_trace.h => mt792x_trace.h} |  16 +--
  drivers/net/wireless/mediatek/mt76/mt792x_usb.c                              | 309 ++++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c                          |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7996/dma.c                              |  83 +++++++-----
  drivers/net/wireless/mediatek/mt76/mt7996/init.c                             |   5 +-
  drivers/net/wireless/mediatek/mt76/mt7996/mac.c                              | 300 ++++++++----------------------------------
  drivers/net/wireless/mediatek/mt76/mt7996/mac.h                              | 315 +--------------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7996/main.c                             | 114 +++++++++-------
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c                              | 182 ++++++++++++++++++++------
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.h                              |  17 +++
  drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h                           |  94 ++------------
  drivers/net/wireless/mediatek/mt76/mt7996/pci.c                              |   1 +
  drivers/net/wireless/mediatek/mt76/mt7996/regs.h                             |  21 ++-
  drivers/net/wireless/mediatek/mt76/testmode.c                                |   1 +
  drivers/net/wireless/mediatek/mt76/tx.c                                      |  16 ++-
  84 files changed, 5752 insertions(+), 4827 deletions(-)
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.h
  delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h
  delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/trace.c
  delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x.h
  rename drivers/net/wireless/mediatek/mt76/{mt7921/acpi_sar.c => mt792x_acpi_sar.c} (64%)
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_core.c
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_debugfs.c
  rename drivers/net/wireless/mediatek/mt76/{mt7921/dma.c => mt792x_dma.c} (55%)
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_mac.c
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_regs.h
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_trace.c
  rename drivers/net/wireless/mediatek/mt76/{mt7921/mt7921_trace.h => mt792x_trace.h} (68%)
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_usb.c
