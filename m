Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70ED47A0EC
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 15:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhLSO1f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 09:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhLSO1f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 09:27:35 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B46AC061574
        for <linux-wireless@vger.kernel.org>; Sun, 19 Dec 2021 06:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=YqcFy6A1ILHTTJLo5zEWV6+CbzzKOy76N9JBhOdmB8M=; b=egM1OAICFXv2czM5JIjG4RCndV
        F+l7XbGJ8l8Fx8LGrL9nfvSPev7ZiGfmIys9GL6Dva3fJ/qzjJqhPwZSItnQxYbZmgkmekQdHOYdL
        GTrrM8ursbaKeD4GzqeAZ8dOiWzV5C7cU8+FEsNL07qo6dABmsdchSdEDSyuVWJxW6gk=;
Received: from p54ae911a.dip0.t-ipconnect.de ([84.174.145.26] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1myx9w-0005El-UL; Sun, 19 Dec 2021 15:27:33 +0100
Message-ID: <de06ccae-1983-33bf-7cb2-908aee6b2412@nbd.name>
Date:   Sun, 19 Dec 2021 15:27:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2021-12-18 v2
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's my updated pull request for 5.17 with a compile fix for rebase issue

- Felix

The following changes since commit f75c1d55ecbadce027fd650d3ca79e357afae0d9:

   Merge tag 'wireless-drivers-next-2021-12-17' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next (2021-12-17 07:30:07 -0800)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-12-18

for you to fetch changes up to b1460bb4eadf4b0bf5afe79fb4d25b9d985f2879:

   mt76: mt7921s: fix cmd timeout in throughput test (2021-12-19 15:24:05 +0100)

----------------------------------------------------------------
mt76 patches for 5.17

* decap offload fixes
* mt7915 fixes
* mt7921 fixes
* eeprom fixes
* powersave handling fixes
* SAR support
* code cleanups

----------------------------------------------------------------
Bo Jiao (1):
       mt76: fix the wiphy's available antennas to the correct value

Changcheng Deng (1):
       mt76: mt7921: fix boolreturn.cocci warning

Daniel Golle (1):
       mt76: eeprom: tolerate corrected bit-flips

Deren Wu (5):
       mt76: mt7921: add support for PCIe ID 0x0608/0x0616
       mt76: mt7921: introduce 160 MHz channel bandwidth support
       mt76: mt7921s: fix bus hang with wrong privilege
       mt76: mt7921: fix network buffer leak by txs missing
       mt76: mt7921s: fix cmd timeout in throughput test

Felix Fietkau (10):
       mt76: mt7915: fix decap offload corner case with 4-addr VLAN frames
       mt76: mt7615: fix decap offload corner case with 4-addr VLAN frames
       mt76: mt7615: improve wmm index allocation
       mt76: mt7915: improve wmm index allocation
       mt76: clear sta powersave flag after notifying driver
       mt76: mt7603: improve reliability of tx powersave filtering
       mt76: mt7615: clear mcu error interrupt status on mt7663
       mt76: allow drivers to drop rx packets early
       mt76: mt7915: process txfree and txstatus without allocating skbs
       mt76: mt7615: in debugfs queue stats, skip wmm index 3 on mt7663

Lorenzo Bianconi (25):
       mt76: mt7915: get rid of mt7915_mcu_set_fixed_rate routine
       mt76: debugfs: fix queue reporting for mt76-usb
       mt76: fix possible OOB issue in mt76_calculate_default_rate
       mt76: mt7921: fix possible NULL pointer dereference in mt7921_mac_write_txwi
       mt76: connac: fix a theoretical NULL pointer dereference in mt76_connac_get_phy_mode
       mt76: mt7615: remove dead code in get_omac_idx
       mt76: connac: remove PHY_MODE_AX_6G configuration in mt76_connac_get_phy_mode
       mt76: mt7921: honor mt76_connac_mcu_set_rate_txpower return value in mt7921_config
       mt76: move sar utilities to mt76-core module
       mt76: mt76x02: introduce SAR support
       mt76: mt7603: introduce SAR support
       mt76: mt7915: introduce SAR support
       mt76: connac: fix last_chan configuration in mt76_connac_mcu_rate_txpower_band
       mt76: move sar_capa configuration in common code
       mt76: mt7663: disable 4addr capability
       mt76: connac: introduce MCU_EXT macros
       mt76: connac: align MCU_EXT definitions with 7915 driver
       mt76: connac: remove MCU_FW_PREFIX bit
       mt76: connac: introduce MCU_UNI_CMD macro
       mt76: connac: introduce MCU_CE_CMD macro
       mt76: connac: rely on MCU_CMD macro
       mt76: mt7915: rely on mt76_connac definitions
       mt76: mt7915: introduce mt76_vif in mt7915_vif
       mt76: mt7921: remove dead definitions
       mt76: connac: rely on le16_add_cpu in mt76_connac_mcu_add_nested_tlv

MeiChia Chiu (1):
       mt76: mt7915: add mu-mimo and ofdma debugfs knobs

Peter Chiu (1):
       mt76: mt7615: fix possible deadlock while mt7615_register_ext_phy()

Ryder Lee (3):
       mt76: mt7915: fix SMPS operation fail
       mt76: only set rx radiotap flag from within decoder functions
       mt76: only access ieee80211_hdr after mt76_insert_ccmp_hdr

Sean Wang (9):
       mt76: mt7921: drop offload_flags overwritten
       mt76: mt7921: fix MT7921E reset failure
       mt76: mt7921: move mt76_connac_mcu_set_hif_suspend to bus-related files
       mt76: mt7921s: fix the device cannot sleep deeply in suspend
       mt76: mt7921s: fix possible kernel crash due to invalid Rx count
       mt76: mt7921: clear pm->suspended in mt7921_mac_reset_work
       mt76: mt7921: fix possible resume failure
       mt76: mt7921s: make pm->suspended usage consistent
       mt76: mt7921s: fix suspend error with enlarging mcu timeout value

Shayne Chen (5):
       mt76: mt7915: fix return condition in mt7915_tm_reg_backup_restore()
       mt76: mt7915: add default calibrated data support
       mt76: testmode: add support to set MAC
       mt76: mt7615: fix unused tx antenna mask in testmode
       mt76: mt7921: use correct iftype data on 6GHz cap init

Tzung-Bi Shih (1):
       mt76: mt7921: reduce log severity levels for informative messages

Xing Song (2):
       mt76: reverse the first fragmented frame to 802.11
       mt76: do not pass the received frame with decryption error

  drivers/net/wireless/mediatek/mt76/debugfs.c         |   5 +-
  drivers/net/wireless/mediatek/mt76/dma.c             |  19 ++--
  drivers/net/wireless/mediatek/mt76/eeprom.c          |   2 +
  drivers/net/wireless/mediatek/mt76/mac80211.c        |  90 ++++++++++++++--
  drivers/net/wireless/mediatek/mt76/mt76.h            |  12 ++-
  drivers/net/wireless/mediatek/mt76/mt7603/mac.c      |   9 +-
  drivers/net/wireless/mediatek/mt76/mt7603/main.c     |  31 ++++--
  drivers/net/wireless/mediatek/mt76/mt7603/mcu.c      |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c  |   3 +
  drivers/net/wireless/mediatek/mt76/mt7615/init.c     |   1 +
  drivers/net/wireless/mediatek/mt76/mt7615/mac.c      | 122 ++++++++++++++++++++--
  drivers/net/wireless/mediatek/mt76/mt7615/mac.h      |   2 +
  drivers/net/wireless/mediatek/mt76/mt7615/main.c     |  15 +--
  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      | 200 ++++++++++++++++--------------------
  drivers/net/wireless/mediatek/mt76/mt7615/mcu.h      | 127 -----------------------
  drivers/net/wireless/mediatek/mt76/mt7615/mmio.c     |   1 +
  drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c |   8 +-
  drivers/net/wireless/mediatek/mt76/mt7615/testmode.c |  25 +++--
  drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 169 +++++++++++++-----------------
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 521 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
  drivers/net/wireless/mediatek/mt76/mt76x0/init.c     |   5 +-
  drivers/net/wireless/mediatek/mt76/mt76x0/main.c     |  34 ++++++-
  drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h   |   2 +
  drivers/net/wireless/mediatek/mt76/mt76x0/pci.c      |   1 +
  drivers/net/wireless/mediatek/mt76/mt76x0/usb.c      |   1 +
  drivers/net/wireless/mediatek/mt76/mt76x02.h         |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_util.c    |   4 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/init.c     |  29 ++++++
  drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h   |   2 +
  drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c |   5 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c |   7 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c |   4 +-
  drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c |   9 +-
  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c  | 227 ++++++++++++++++++++++++++++++++++++++++-
  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c   |  83 +++++++++++----
  drivers/net/wireless/mediatek/mt76/mt7915/mac.c      | 205 ++++++++++++++++++++++++++++++-------
  drivers/net/wireless/mediatek/mt76/mt7915/main.c     |  70 ++++++++-----
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      | 267 ++++++++++++++++++++++++++++--------------------
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h      | 841 ++++++++++--------------------------------------------------------------------------------------------------------------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h   |  27 ++---
  drivers/net/wireless/mediatek/mt76/mt7915/pci.c      |   1 +
  drivers/net/wireless/mediatek/mt76/mt7915/testmode.c |  17 ++--
  drivers/net/wireless/mediatek/mt76/mt7921/init.c     |  12 +--
  drivers/net/wireless/mediatek/mt76/mt7921/mac.c      | 136 ++++++++++++++++++++-----
  drivers/net/wireless/mediatek/mt76/mt7921/main.c     |  80 ++++++---------
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c      | 160 ++++++++++++++---------------
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.h      | 153 +++++-----------------------
  drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h   |   2 +
  drivers/net/wireless/mediatek/mt76/mt7921/pci.c      |  25 +++--
  drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c  |   4 +
  drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c  |   4 +-
  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c     |  51 ++++++----
  drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/testmode.c |   4 +-
  drivers/net/wireless/mediatek/mt76/sdio.c            |  11 +-
  drivers/net/wireless/mediatek/mt76/sdio_txrx.c       |   3 +-
  drivers/net/wireless/mediatek/mt76/testmode.c        |  36 ++++++-
  drivers/net/wireless/mediatek/mt76/testmode.h        |   4 +
  60 files changed, 2095 insertions(+), 1805 deletions(-)
