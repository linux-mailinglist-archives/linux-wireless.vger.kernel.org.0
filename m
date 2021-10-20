Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983A5434FCC
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Oct 2021 18:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhJTQND (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Oct 2021 12:13:03 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:55966 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231208AbhJTQNC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Oct 2021 12:13:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634746247; h=Date: Message-ID: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=lX6rNirwj21pN/aqNOtKYd5qnV0y3cgRoyi2TvkAJN0=;
 b=RXmkliPGzEcWb6YZkG135xB+8b/sa6PyxPZjItWSnBx9rciBhEhrKIfVlLo6Eisiuoc9fdhf
 YH6C5XPnpVR3RtO0M7IkAI8404nkJlbnmwEMLA+smdN0rX8Mxu1gr4FdWbeKPpB4VCxvGBJX
 T49+9myvmMJArJ3ajPMr5hfv1UU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 61703f8559612e0100a4b874 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 Oct 2021 16:10:45
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E2E1BC43617; Wed, 20 Oct 2021 16:10:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DCEF3C43460;
        Wed, 20 Oct 2021 16:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org DCEF3C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull request: mt76 2021-10-20
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <eb34909a-4bf3-a099-dba3-a43b9e9e289e@nbd.name>
References: <eb34909a-4bf3-a099-dba3-a43b9e9e289e@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163474623768.8777.14840578214595430795.kvalo@codeaurora.org>
Date:   Wed, 20 Oct 2021 16:10:44 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> here's a new pull request for 5.16. it replaces the previous one
> 
> - Felix
> 
> The following changes since commit f7e7e440550b0b176df3d2ea3e76106bc89915d9:
> 
>    rtw89: Remove redundant check of ret after call to rtw89_mac_enable_bb_rf (2021-10-18 15:31:24 +0300)
> 
> are available in the Git repository at:
> 
>    https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-10-20
> 
> for you to fetch changes up to ff8c049891688131682ac0b7fb0ef55595b19898:
> 
>    mt76: mt7915: change max rx len limit of hw modules (2021-10-20 10:37:04 +0200)
> 
> ----------------------------------------------------------------
> mt76 patches for 5.16
> 
> * various bugfixes
> * endian fixes
> * mt7921 aspm support
> * cleanup
> * mt7921 testmode support
> * rate handling fixes
> * tx status fixes/improvements
> * mt7921 power management improvements
> * mt7915 LED support
> * DBDC fixes
> * mt7921 6GHz support
> * support for eeprom data in DT
> * mt7915 TWT support
> * mt7915 txbf + MU-MIMO improvements
> 
> ----------------------------------------------------------------
> Ben Greear (9):
>        mt76: mt7915: fix he_mcs capabilities for 160mhz
>        mt76: mt7915: fix potential NPE in TXS processing
>        mt76: mt7915: fix hwmon temp sensor mem use-after-free
>        mt76: mt7915: add ethtool stats support
>        mt76: mt7915: add tx stats gathered from tx-status callbacks
>        mt76: mt7915: add some per-station tx stats to ethtool
>        mt76: mt7915: add tx mu/su counters to mib
>        mt76: mt7915: add more MIB registers
>        mt76: mt7915: add mib counters to ethtool stats
> 
> Bo Jiao (2):
>        mt76: mt7915: fix calling mt76_wcid_alloc with incorrect parameter
>        mt76: mt7915: adapt new firmware to update BA winsize for Rx session
> 
> Christophe JAILLET (1):
>        mt76: switch from 'pci_' to 'dma_' API
> 
> Dan Carpenter (1):
>        mt76: mt7915: fix info leak in mt7915_mcu_set_pre_cal()
> 
> Daniel Golle (2):
>        mt76: support reading EEPROM data embedded in fdt
>        dt: bindings: net: mt76: add eeprom-data property
> 
> Deren Wu (4):
>        mt76: mt7921: Fix out of order process by invalid event pkt
>        mt76: mt7921: Add mt7922 support
>        mt76: mt7921: fix dma hang in rmmod
>        mt76: mt7921: add delay config for sched scan
> 
> Felix Fietkau (4):
>        mt76: mt7615: fix skb use-after-free on mac reset
>        mt76: mt7915: fix WMM index on DBDC cards
>        mt76: disable BH around napi_schedule() calls
>        mt76: do not access 802.11 header in ccmp check for 802.3 rx skbs
> 
> Leon Yen (2):
>        mt76: connac: fix mt76_connac_gtk_rekey_tlv usage
>        mt76: connac: fix GTK rekey offload failure on WPA mixed mode
> 
> Lorenzo Bianconi (64):
>        mt76: mt7921: fix endianness in mt7921_mcu_tx_done_event
>        mt76: mt7921: avoid unnecessary spin_lock/spin_unlock in mt7921_mcu_tx_done_event
>        mt76: mt7915: fix endianness warning in mt7915_mac_add_txs_skb
>        mt76: mt7921: fix endianness warning in mt7921_update_txs
>        mt76: mt7615: fix endianness warning in mt7615_mac_write_txwi
>        mt76: mt7921: fix survey-dump reporting
>        mt76: mt76x02: fix endianness warnings in mt76x02_mac.c
>        mt76: mt7921: introduce testmode support
>        mt76: mt7921: get rid of monitor_vif
>        mt76: mt7921: get rid of mt7921_mac_set_beacon_filter
>        mt76: mt7921: introduce mt7921_mcu_set_beacon_filter utility routine
>        mt76: overwrite default reg_ops if necessary
>        mt76: mt7615: move mt7615_mcu_set_p2p_oppps in mt76_connac module
>        mt76: mt7921: fix endianness warnings in mt7921_mac_decode_he_mu_radiotap
>        mt76: mt7915: introduce bss coloring support
>        mt76: mt7915: improve code readability in mt7915_mcu_sta_bfer_ht
>        mt76: mt7921: move mt7921_queue_rx_skb to mac.c
>        mt76: mt7921: always wake device if necessary in debugfs
>        mt76: mt7921: update mib counters dumping phy stats
>        mt76: mt7921: start reworking tx rate reporting
>        mt76: mt7921: add support for tx status reporting
>        mt76: mt7921: report tx rate directly from tx status
>        mt76: mt7921: remove mcu rate reporting code
>        mt76: mt7921: remove mt7921_sta_stats
>        mt76: mt7915: honor all possible error conditions in mt7915_mcu_init()
>        mt76: mt7915: fix possible infinite loop release semaphore
>        mt76: connac: set 6G phymode in mt76_connac_get_phy_mode{,v2}
>        mt76: connac: enable 6GHz band for hw scan
>        mt76: connac: add 6GHz support to mt76_connac_mcu_set_channel_domain
>        mt76: connac: set 6G phymode in single-sku support
>        mt76: connac: add 6GHz support to mt76_connac_mcu_sta_tlv
>        mt76: connac: add 6GHz support to mt76_connac_mcu_uni_add_bss
>        mt76: connac: enable hw amsdu @ 6GHz
>        mt76: add 6GHz support
>        mt76: mt7921: add 6GHz support
>        mt76: introduce packet_id idr
>        mt76: remove mt76_wcid pointer from mt76_tx_status_check signature
>        mt76: substitute sk_buff_head status_list with spinlock_t status_lock
>        mt76: schedule status timeout at dma completion
>        mt76: introduce __mt76_mcu_send_firmware routine
>        mt76: mt7915: introduce __mt7915_get_tsf routine
>        mt76: mt7915: introduce mt7915_mcu_twt_agrt_update mcu command
>        mt76: mt7915: introduce mt7915_mac_add_twt_setup routine
>        mt76: mt7915: enable twt responder capability
>        mt76: mt7915: add twt_stats knob in debugfs
>        mt76: debugfs: improve queue node readability
>        mt76: connac: fix possible NULL pointer dereference in mt76_connac_get_phy_mode_v2
>        mt76: rely on phy pointer in mt76_register_debugfs_fops routine signature
>        mt76: mt7915: introduce mt76 debugfs sub-dir for ext-phy
>        mt76: mt7915: improve code readability for xmit-queue handler
>        mt76: sdio: export mt76s_alloc_rx_queue and mt76s_alloc_tx routines
>        mt76: mt7915: remove dead code in debugfs code
>        mt76: sdio: move common code in mt76_sdio module
>        mt76: sdio: introduce parse_irq callback
>        mt76: move mt76_sta_stats in mt76.h
>        mt76: move mt76_ethtool_worker_info in mt76 module
>        mt76: mt7915: run mt7915_get_et_stats holding mt76 mutex
>        mt76: mt7915: move tx amsdu stats in mib_stats
>        mt76: do not reset MIB counters in get_stats callback
>        mt76: mt7921: add some more MIB counters
>        mt76: mt7921: introduce stats reporting through ethtool
>        mt76: mt7921: add sta stats accounting in mt7921_mac_add_txs_skb
>        mt76: mt7921: move tx amsdu stats in mib_stats
>        mt76: mt7921: add per-vif counters in ethtool
> 
> MeiChia Chiu (1):
>        mt76: mt7915: add LED support
> 
> Richard Huynh (1):
>        mt76: mt76x0: correct VHT MCS 8/9 tx power eeprom offset
> 
> Ryder Lee (22):
>        mt76: mt7915: report HE MU radiotap
>        mt76: mt7915: fix an off-by-one bound check
>        mt76: mt7915: take RCU read lock when calling ieee80211_bss_get_elem()
>        mt76: mt7915: cleanup -Wunused-but-set-variable
>        mt76: mt7915: report tx rate directly from tx status
>        mt76: mt7915: remove mt7915_sta_stats
>        mt76: mt7915: add control knobs for thermal throttling
>        mt76: mt7915: send EAPOL frames at lowest rate
>        mt76: mt7921: send EAPOL frames at lowest rate
>        mt76: add support for setting mcast rate
>        mt76: mt7915: add HE-LTF into fixed rate command
>        mt76: mt7915: update mac timing settings
>        mt76: use IEEE80211_OFFLOAD_ENCAP_ENABLED instead of MT_DRV_AMSDU_OFFLOAD
>        mt76: mt7915: rework debugfs queue info
>        mt76: mt7915: rename debugfs tx-queues
>        mt76: fill boottime_ns in Rx path
>        mt76: mt7915: enable configured beacon tx rate
>        mt76: mt7615: fix hwmon temp sensor mem use-after-free
>        mt76: mt7615: fix monitor mode tear down crash
>        mt76: mt7915: introduce mt7915_mcu_beacon_check_caps()
>        mt76: mt7915: fix txbf starec TLV issues
>        mt76: mt7915: improve starec readability of txbf
> 
> Sean Wang (27):
>        mt76: mt7921: enable aspm by default
>        mt76: fix build error implicit enumeration conversion
>        mt76: add mt76_default_basic_rate more devices can rely on
>        mt76: mt7921: fix mgmt frame using unexpected bitrate
>        mt76: mt7915: fix mgmt frame using unexpected bitrate
>        mt76: mt7921: report HE MU radiotap
>        mt76: mt7921: fix firmware usage of RA info using legacy rates
>        mt76: mt7921: fix kernel warning from cfg80211_calculate_bitrate
>        mt76: mt7921: robustify hardware initialization flow
>        mt76: mt7921: fix retrying release semaphore without end
>        mt76: drop MCU header size from buffer size in __mt76_mcu_send_firmware
>        mt76: mt7921: add MU EDCA cmd support
>        mt76: mt7921: refactor mac.c to be bus independent
>        mt76: mt7921: refactor dma.c to be pcie specific
>        mt76: mt7921: refactor mcu.c to be bus independent
>        mt76: mt7921: refactor init.c to be bus independent
>        mt76: mt7921: add MT7921_COMMON module
>        mt76: connac: move mcu reg access utility routines in mt76_connac_lib module
>        mt76: mt7663s: rely on mcu reg access utility
>        mt76: mt7921: make all event parser reusable between mt7921s and mt7921e
>        mt76: mt7921: use physical addr to unify register access
>        mt76: sdio: extend sdio module to support CONNAC2
>        mt76: connac: extend mcu_get_nic_capability
>        mt76: mt7921: rely on mcu_get_nic_capability
>        mt76: mt7921: refactor mt7921_mcu_send_message
>        mt76: mt7921: introduce mt7921s support
>        mt76: mt7921s: add reset support
> 
> Shayne Chen (12):
>        mt76: mt7915: fix potential overflow of eeprom page index
>        mt76: mt7915: switch proper tx arbiter mode in testmode
>        mt76: mt7915: fix bit fields for HT rate idx
>        mt76: mt7915: fix sta_rec_wtbl tag len
>        mt76: mt7915: rework starec TLV tags
>        mt76: mt7915: fix muar_idx in mt7915_mcu_alloc_sta_req()
>        mt76: mt7915: set VTA bit in tx descriptor
>        mt76: mt7915: set muru platform type
>        mt76: mt7915: enable HE UL MU-MIMO
>        mt76: mt7915: rework mt7915_mcu_sta_muru_tlv()
>        mt76: mt7915: fix missing HE phy cap
>        mt76: mt7915: change max rx len limit of hw modules
> 
> Xing Song (1):
>        mt76: use a separate CCMP PN receive counter for management frames
> 
> Xingbang Liu (1):
>        mt76: move spin_lock_bh to spin_lock in tasklet
> 
> YN Chen (2):
>        mt76: mt7921: add .set_sar_specs support
>        mt76: connac: add support for limiting to maximum regulatory Tx power
> 
> jing yangyang (1):
>        mt76: fix boolreturn.cocci warnings
> 
>   Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml |    5 +
>   drivers/net/wireless/mediatek/mt76/Makefile                       |    2 +-
>   drivers/net/wireless/mediatek/mt76/debugfs.c                      |   22 +-
>   drivers/net/wireless/mediatek/mt76/eeprom.c                       |   14 ++
>   drivers/net/wireless/mediatek/mt76/mac80211.c                     |  242 +++++++++++++++++--
>   drivers/net/wireless/mediatek/mt76/mcu.c                          |    8 +-
>   drivers/net/wireless/mediatek/mt76/mt76.h                         |  126 ++++++++--
>   drivers/net/wireless/mediatek/mt76/mt7603/mac.c                   |   11 +-
>   drivers/net/wireless/mediatek/mt76/mt7603/main.c                  |    3 +
>   drivers/net/wireless/mediatek/mt76/mt7603/pci.c                   |    2 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/Makefile                |    2 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c               |   29 ++-
>   drivers/net/wireless/mediatek/mt76/mt7615/init.c                  |    6 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/mac.c                   |   62 ++---
>   drivers/net/wireless/mediatek/mt76/mt7615/main.c                  |   10 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                   |   68 ++----
>   drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h                |   20 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/pci.c                   |    4 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c               |    5 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/sdio.c                  |  296 ++++--------------------
>   drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c              |   11 +-
>   drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c              |    2 +-
>   drivers/net/wireless/mediatek/mt76/mt76_connac.h                  |    7 +-
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c              |  355 +++++++++++++++++++++++++---
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h              |   37 ++-
>   drivers/net/wireless/mediatek/mt76/mt76x0/eeprom.c                |    2 +-
>   drivers/net/wireless/mediatek/mt76/mt76x0/pci.c                   |    4 +-
>   drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                  |   15 +-
>   drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c                 |   12 +-
>   drivers/net/wireless/mediatek/mt76/mt76x02_util.c                 |    3 +
>   drivers/net/wireless/mediatek/mt76/mt76x2/pci.c                   |    5 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c               |  381 ++++++++++++++++++------------
>   drivers/net/wireless/mediatek/mt76/mt7915/init.c                  |  170 ++++++++++++--
>   drivers/net/wireless/mediatek/mt76/mt7915/mac.c                   |  646 +++++++++++++++++++++++++++++++++++++++++++--------
>   drivers/net/wireless/mediatek/mt76/mt7915/mac.h                   |   11 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/main.c                  |  334 ++++++++++++++++++++++++---
>   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                   | 1046 +++++++++++++++++++++++++++++++++++++++++++----------------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7915/mcu.h                   |  105 ++++-----
>   drivers/net/wireless/mediatek/mt76/mt7915/mmio.c                  |    3 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                |  144 +++++++++---
>   drivers/net/wireless/mediatek/mt76/mt7915/pci.c                   |    5 +-
>   drivers/net/wireless/mediatek/mt76/mt7915/regs.h                  |  149 +++++++++++-
>   drivers/net/wireless/mediatek/mt76/mt7915/testmode.c              |   23 ++
>   drivers/net/wireless/mediatek/mt76/mt7915/testmode.h              |    6 +
>   drivers/net/wireless/mediatek/mt76/mt7921/Kconfig                 |   18 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/Makefile                |    7 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c               |   99 ++++++--
>   drivers/net/wireless/mediatek/mt76/mt7921/dma.c                   |   74 ++----
>   drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c                |  100 --------
>   drivers/net/wireless/mediatek/mt76/mt7921/init.c                  |   93 +++++---
>   drivers/net/wireless/mediatek/mt76/mt7921/mac.c                   |  776 +++++++++++++++++++++++++++++--------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7921/mac.h                   |   32 +++
>   drivers/net/wireless/mediatek/mt76/mt7921/main.c                  |  328 +++++++++++++++++++++-----
>   drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                   |  448 +++++++++++++++---------------------
>   drivers/net/wireless/mediatek/mt76/mt7921/mcu.h                   |   63 ++---
>   drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                |  179 ++++++++++-----
>   drivers/net/wireless/mediatek/mt76/mt7921/pci.c                   |   66 +++++-
>   drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c               |  348 ++++++++++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c               |  115 ++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7921/regs.h                  |   58 +++--
>   drivers/net/wireless/mediatek/mt76/mt7921/sdio.c                  |  317 +++++++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c              |  220 ++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c              |  135 +++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7921/testmode.c              |  197 ++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/sdio.c                         |  303 ++++++++++++++++++++++--
>   drivers/net/wireless/mediatek/mt76/{mt7615 => }/sdio.h            |   33 ++-
>   drivers/net/wireless/mediatek/mt76/{mt7615 => }/sdio_txrx.c       |  134 ++++++-----
>   drivers/net/wireless/mediatek/mt76/testmode.c                     |    4 +-
>   drivers/net/wireless/mediatek/mt76/testmode.h                     |    7 +
>   drivers/net/wireless/mediatek/mt76/tx.c                           |   84 ++++---
>   drivers/net/wireless/mediatek/mt76/usb.c                          |    2 +-
>   71 files changed, 6114 insertions(+), 2539 deletions(-)
>   delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
>   create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
>   rename drivers/net/wireless/mediatek/mt76/{mt7615 => }/sdio.h (72%)
>   rename drivers/net/wireless/mediatek/mt76/{mt7615 => }/sdio_txrx.c (67%)

Pulled, thanks.

9bc0b1aa8b7e Merge tag 'mt76-for-kvalo-2021-10-20' of https://github.com/nbd168/wireless

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/eb34909a-4bf3-a099-dba3-a43b9e9e289e@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

