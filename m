Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1350F4A9991
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 13:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243402AbiBDM5U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 07:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbiBDM5T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 07:57:19 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E758C061714
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 04:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bNFvuCP+/z41zkoCpDlmbS+Gp9fE3c3M7koN7sp5jug=; b=kWYmR8oZGKpgGJ5S0QVYK9++8T
        ZrjHYKPuyIajeWS/BFbsDl1F+p3LLy+S0Bi1KbwmoksVfCWTKoxoQTNaNZiX8cxbxRTPr9khbcwvH
        S35TNZcUqWWtz6ki+SfMTvEtXuFk6qurp6893P1CGUzP6YF3LyjaYgKRs0KYfMcaVJqE=;
Received: from p200300daa71e0b00adf7d32f3eb78dba.dip0.t-ipconnect.de ([2003:da:a71e:b00:adf7:d32f:3eb7:8dba] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nFy9N-0006Ju-F8; Fri, 04 Feb 2022 13:57:17 +0100
Message-ID: <9dc9c187-c86d-1a43-655f-00d1c4d10205@nbd.name>
Date:   Fri, 4 Feb 2022 13:57:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2022-02-04
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's my first pull request for 5.18

- Felix

The following changes since commit b4bb8469e90ec75c0ce81fcf6a9c3abd2f18e005:

   brcmfmac: pcie: Read the console on init and shutdown (2022-02-01 14:27:08 +0200)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2022-02-04

for you to fetch changes up to b3ad9d6a1d66712fb08cd59ae3e03cbdb9f80e7b:

   mt76: redefine mt76_for_each_q_rx to adapt mt7986 changes (2022-02-04 11:28:36 +0100)

----------------------------------------------------------------
mt76 patches for 5.18

- mt7915 mcu code cleanup
- mt7916 support
- fixes for SDIO support
- fixes for DFS
- power management fixes
- stability improvements
- background radar detection support

----------------------------------------------------------------
Ben Greear (1):
       mt76: mt7921: fix crash when startup fails.

Bo Jiao (14):
       mt76: mt7915: add mt7915_mmio_probe() as a common probing function
       mt76: mt7915: refine register definition
       mt76: add MT_RXQ_MAIN_WA for mt7916
       mt76: mt7915: rework dma.c to adapt mt7916 changes
       mt76: mt7915: add firmware support for mt7916
       mt76: mt7915: rework eeprom.c to adapt mt7916 changes
       mt76: mt7915: enlarge wcid size to 544
       mt76: mt7915: add txfree event v3
       mt76: mt7915: update rx rate reporting for mt7916
       mt76: mt7915: update mt7915_chan_mib_offs for mt7916
       mt76: mt7915: add mt7916 calibrated data support
       mt76: set wlan_idx_hi on mt7916
       mt76: mt7915: add device id for mt7916
       mt76: redefine mt76_for_each_q_rx to adapt mt7986 changes

Felix Fietkau (11):
       mt76: mt7915: fix polling firmware-own status
       mt76: mt7915: move pci specific code back to pci.c
       mt76: connac: add support for passing the cipher field in bss_info
       mt76: mt7615: update bss_info with cipher after setting the group key
       mt76: mt7915: update bss_info with cipher after setting the group key
       mt76: mt7915: add support for passing chip/firmware debug data to user space
       mt76x02: improve mac error check/reset reliability
       mt76: mt76x02: improve tx hang detection
       mt76: mt7915: fix/rewrite the dfs state handling logic
       mt76: mt7615: fix/rewrite the dfs state handling logic
       mt76: mt76x02: use mt76_phy_dfs_state to determine radar detector state

Leon Yen (1):
       mt76: mt7921s: fix mt7921s_mcu_[fw|drv]_pmctrl

Lorenzo Bianconi (59):
       mt76: connac: fix sta_rec_wtbl tag len
       mt76: mt7915: rely on mt76_connac_mcu_alloc_sta_req
       mt76: mt7915: rely on mt76_connac_mcu_alloc_wtbl_req
       mt76: mt7915: rely on mt76_connac_mcu_add_tlv routine
       mt76: connac: move mt76_connac_mcu_get_cipher in common code
       mt76: connac: move mt76_connac_chan_bw in common code
       mt76: mt7915: rely on mt76_connac_get_phy utilities
       mt76: connac: move mt76_connac_mcu_add_key in connac module
       mt76: make mt76_sar_capa static
       mt76: mt7915: use proper aid value in mt7915_mcu_wtbl_generic_tlv in sta mode
       mt76: mt7915: use proper aid value in mt7915_mcu_sta_basic_tlv
       mt76: mt7915: remove duplicated defs in mcu.h
       mt76: connac: move mt76_connac_mcu_bss_omac_tlv in connac module
       mt76: connac: move mt76_connac_mcu_bss_ext_tlv in connac module
       mt76: connac: move mt76_connac_mcu_bss_basic_tlv in connac module
       mt76: mt7915: rely on mt76_connac_mcu_sta_ba_tlv
       mt76: mt7915: rely on mt76_connac_mcu_wtbl_ba_tlv
       mt76: mt7915: rely on mt76_connac_mcu_sta_ba
       mt76: mt7915: rely on mt76_connac_mcu_wtbl_generic_tlv
       mt76: mt7915: rely on mt76_connac_mcu_sta_basic_tlv
       mt76: mt7915: rely on mt76_connac_mcu_sta_uapsd
       mt76: mt7915: rely on mt76_connac_mcu_wtbl_smps_tlv
       mt76: mt7915: rely on mt76_connac_mcu_wtbl_ht_tlv
       mt76: mt7915: rely on mt76_connac_mcu_wtbl_hdr_trans_tlv
       mt76: connac: move mt76_connac_mcu_wtbl_update_hdr_trans in connac module
       mt76: connac: introduce is_connac_v1 utility routine
       mt76: connac: move mt76_connac_mcu_set_pm in connac module
       mt76: mt7921: get rid of mt7921_mcu_get_eeprom
       mt76: mt7915: rely on mt76_connac_mcu_start_firmware
       mt76: connac: move mt76_connac_mcu_restart in common module
       mt76: mt7915: rely on mt76_connac_mcu_patch_sem_ctrl/mt76_connac_mcu_start_patch
       mt76: mt7915: rely on mt76_connac_mcu_init_download
       mt76: connac: move mt76_connac_mcu_gen_dl_mode in mt76-connac module
       mt76: mt7915: rely on mt76_connac_mcu_set_rts_thresh
       mt76: connac: move mt76_connac_mcu_rdd_cmd in mt76-connac module
       mt76: mt7615: fix a possible race enabling/disabling runtime-pm
       mt76: mt7921e: process txfree and txstatus without allocating skbs
       mt76: mt7615e: process txfree and txstatus without allocating skbs
       mt76: mt7921: do not always disable fw runtime-pm
       mt76: mt7921: fix a leftover race in runtime-pm
       mt76: mt7615: fix a leftover race in runtime-pm
       mt76: mt7921: fix endianness issues in mt7921_mcu_set_tx()
       mt76: mt7921: toggle runtime-pm adding a monitor vif
       mt76: mt7915: introduce mt7915_set_radar_background routine
       mt76: mt7915: enable radar trigger on rdd2
       mt76: mt7915: introduce rdd_monitor debugfs node
       mt76: mt7915: report radar pattern if detected by rdd2
       mt76: mt7915: enable radar background detection
       dt-bindings:net:wireless:mediatek,mt76: add disable-radar-offchan
       mt76: connac: move mt76_connac_lmac_mapping in mt76-connac module
       mt76: mt7915: add missing DATA4_TB_SPTL_REUSE1 to mt7915_mac_decode_he_radiotap
       mt76: mt7921: remove duplicated code in mt7921_mac_decode_he_radiotap
       mt76: mt7663s: flush runtime-pm queue after waking up the device
       mt76: mt7603: check sta_rates pointer in mt7603_sta_rate_tbl_update
       mt76: mt7615: check sta_rates pointer in mt7615_sta_rate_tbl_update
       mt76: mt7915: fix possible memory leak in mt7915_mcu_add_sta
       mt76: mt7921s: fix a possible memory leak in mt7921_load_patch
       mt76: do not always copy ethhdr in reverse_frag0_hdr_trans
       mt76: dma: initialize skip_unmap in mt76_dma_rx_fill

MeiChia Chiu (1):
       mt76: mt7915: fix the nss setting in bitrates

Peter Chiu (4):
       mt76: mt7915: fix ht mcs in mt7915_mac_add_txs_skb()
       mt76: mt7921: fix ht mcs in mt7921_mac_add_txs_skb()
       mt76: mt7915: fix mcs_map in mt7915_mcu_set_sta_he_mcs()
       mt76: mt7915: update max_mpdu_size in mt7915_mcu_sta_amsdu_tlv()

Piotr Dymacz (1):
       mt76: mt7615: add support for LG LGSBWAC02 (MT7663BUN)

Sean Wang (9):
       mt76: sdio: lock sdio when it is needed
       mt76: mt7921s: clear MT76_STATE_MCU_RUNNING immediately after reset
       mt76: mt7921e: make dev->fw_assert usage consistent
       mt76: mt76_connac: fix MCU_CE_CMD_SET_ROC definition error
       mt76: mt7921: set EDCA parameters with the MCU CE command
       mt76: mt7921e: fix possible probe failure after reboot
       mt76: sdio: disable interrupt in mt76s_sdio_irq
       mt76: sdio: honor the largest Tx buffer the hardware can support
       mt76: mt7921s: run sleep mode by default

Shayne Chen (1):
       mt76: mt7915: set bssinfo/starec command when adding interface

Xing Song (1):
       mt76: stop the radar detector after leaving dfs channel

YN Chen (2):
       mt76: mt7921s: update mt7921s_wfsys_reset sequence
       mt76: mt7921: forbid the doze mode when coredump is in progress

  Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml |    9 +
  drivers/net/wireless/mediatek/mt76/dma.c                          |   14 +-
  drivers/net/wireless/mediatek/mt76/mac80211.c                     |   30 +++-
  drivers/net/wireless/mediatek/mt76/mt76.h                         |   22 ++-
  drivers/net/wireless/mediatek/mt76/mt7603/main.c                  |    3 +
  drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c               |   15 +-
  drivers/net/wireless/mediatek/mt76/mt7615/init.c                  |    1 -
  drivers/net/wireless/mediatek/mt76/mt7615/mac.c                   |  136 +++++++++-----
  drivers/net/wireless/mediatek/mt76/mt7615/main.c                  |   12 +-
  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c                   |  220 ++---------------------
  drivers/net/wireless/mediatek/mt76/mt7615/mmio.c                  |    1 +
  drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h                |   22 +--
  drivers/net/wireless/mediatek/mt76/mt7615/sdio.c                  |   15 +-
  drivers/net/wireless/mediatek/mt76/mt7615/usb.c                   |    1 +
  drivers/net/wireless/mediatek/mt76/mt76_connac.h                  |   71 +++++++-
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c              |  378 +++++++++++++++++++++++++++++++++++----
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h              |  117 +++++++++++-
  drivers/net/wireless/mediatek/mt76/mt76x02.h                      |    3 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c                  |    5 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_mac.c                  |   25 ++-
  drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c                 |   30 ++--
  drivers/net/wireless/mediatek/mt76/mt76x02_regs.h                 |    2 +
  drivers/net/wireless/mediatek/mt76/mt7915/Kconfig                 |    3 +-
  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c               |  217 +++++++++++++++++++++--
  drivers/net/wireless/mediatek/mt76/mt7915/dma.c                   |  454 +++++++++++++++++++++++++++++++++--------------
  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c                |   87 ++++++---
  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h                |    9 +-
  drivers/net/wireless/mediatek/mt76/mt7915/init.c                  |  156 ++++++++++------
  drivers/net/wireless/mediatek/mt76/mt7915/mac.c                   |  437 ++++++++++++++++++++++++++++-----------------
  drivers/net/wireless/mediatek/mt76/mt7915/mac.h                   |   15 +-
  drivers/net/wireless/mediatek/mt76/mt7915/main.c                  |  131 ++++++++++----
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c                   | 1323 ++++++++++++++++++++++++++++++++--------------------------------------------------------------------------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h                   |   54 +++---
  drivers/net/wireless/mediatek/mt76/mt7915/mmio.c                  |  577 ++++++++++++++++++++++++++++++++++++++++++++++++++++-------
  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h                |   87 ++++++---
  drivers/net/wireless/mediatek/mt76/mt7915/pci.c                   |  259 ++++++---------------------
  drivers/net/wireless/mediatek/mt76/mt7915/regs.h                  |  586 ++++++++++++++++++++++++++++++++++++++----------------------
  drivers/net/wireless/mediatek/mt76/mt7915/testmode.c              |   61 ++++---
  drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c               |   37 ++--
  drivers/net/wireless/mediatek/mt76/mt7921/dma.c                   |  119 -------------
  drivers/net/wireless/mediatek/mt76/mt7921/init.c                  |   10 +-
  drivers/net/wireless/mediatek/mt76/mt7921/mac.c                   |   37 ++--
  drivers/net/wireless/mediatek/mt76/mt7921/main.c                  |   36 +++-
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c                   |  274 +++-------------------------
  drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h                |   21 +--
  drivers/net/wireless/mediatek/mt76/mt7921/pci.c                   |  125 +++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c               |   37 +++-
  drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c               |   20 ++-
  drivers/net/wireless/mediatek/mt76/mt7921/regs.h                  |    3 +
  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c                  |   15 +-
  drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c              |    6 +-
  drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c              |   38 ++++
  drivers/net/wireless/mediatek/mt76/sdio.c                         |   14 +-
  drivers/net/wireless/mediatek/mt76/sdio.h                         |    2 +
  drivers/net/wireless/mediatek/mt76/sdio_txrx.c                    |   26 +--
  55 files changed, 3570 insertions(+), 2838 deletions(-)
