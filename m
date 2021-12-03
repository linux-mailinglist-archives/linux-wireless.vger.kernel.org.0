Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6724674B4
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Dec 2021 11:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351494AbhLCK0a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Dec 2021 05:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243470AbhLCK03 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Dec 2021 05:26:29 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3144C06173E
        for <linux-wireless@vger.kernel.org>; Fri,  3 Dec 2021 02:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ia2VQ9mea0yFqpv8zBkhlhhSTTylHwkk487eajdevyU=; b=K+RYy3HSe1emGLyYiC0HYdjnVL
        Lheu5t5x7k1r6RnhyIpeAMJet0gxJzk2GJ9C3PnHWorMYVTYGyhEiKmU1YWmVIGAN5OuQ3346cLPS
        gyGf9IIoW9JtyjK6uM43f3nWSKFPHHQLRESb3/V8Hyes8DW1BGxbnZ+XSzmTeIkBBMnw=;
Received: from p54ae943f.dip0.t-ipconnect.de ([84.174.148.63] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mt5ia-0001oV-5X; Fri, 03 Dec 2021 11:23:04 +0100
Message-ID: <0f6dab1f-e892-7780-0c9b-545da9b8c04d@nbd.name>
Date:   Fri, 3 Dec 2021 11:23:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2021-12-03
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's my first pull request for 5.17

- Felix

The following changes since commit 69831173fcbbfebb7aa2d76523deaf0b87b8eddd:

   rtlwifi: rtl8192de: Style clean-ups (2021-11-29 12:47:07 +0200)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-12-03

for you to fetch changes up to ba106bebc7429957ea9125639a4715ddd1b23171:

   mt76: mt7663: disable 4addr capability (2021-12-03 11:15:21 +0100)

----------------------------------------------------------------
mt76 patches for 5.17

* decap offload fixes
* mt7915 fixes
* mt7921 fixes
* eeprom fixes
* powersave handling fixes
* SAR support

----------------------------------------------------------------
Bo Jiao (1):
       mt76: fix the wiphy's available antennas to the correct value

Changcheng Deng (1):
       mt76: mt7921: fix boolreturn.cocci warning

Daniel Golle (1):
       mt76: eeprom: tolerate corrected bit-flips

Deren Wu (3):
       mt76: mt7921: add support for PCIe ID 0x0608/0x0616
       mt76: mt7921: introduce 160 MHz channel bandwidth support
       mt76: mt7921s: fix bus hang with wrong privilege

Felix Fietkau (7):
       mt76: mt7915: fix decap offload corner case with 4-addr VLAN frames
       mt76: mt7615: fix decap offload corner case with 4-addr VLAN frames
       mt76: mt7615: improve wmm index allocation
       mt76: mt7915: improve wmm index allocation
       mt76: clear sta powersave flag after notifying driver
       mt76: mt7603: improve reliability of tx powersave filtering
       mt76: mt7615: clear mcu error interrupt status on mt7663

Lorenzo Bianconi (15):
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

MeiChia Chiu (1):
       mt76: mt7915: fix the wrong SMPS mode

Peter Chiu (1):
       mt76: mt7615: fix possible deadlock while mt7615_register_ext_phy()

Ryder Lee (3):
       mt76: mt7915: fix SMPS operation fail
       mt76: only set rx radiotap flag from within decoder functions
       mt76: only access ieee80211_hdr after mt76_insert_ccmp_hdr

Sean Wang (5):
       mt76: mt7921: drop offload_flags overwritten
       mt76: mt7921: fix MT7921E reset failure
       mt76: mt7921: move mt76_connac_mcu_set_hif_suspend to bus-related files
       mt76: mt7921s: fix the device cannot sleep deeply in suspend
       mt76: mt7921s: fix possible kernel crash due to invalid Rx count

Shayne Chen (5):
       mt76: mt7915: fix return condition in mt7915_tm_reg_backup_restore()
       mt76: mt7915: add default calibrated data support
       mt76: testmode: add support to set MAC
       mt76: mt7615: fix unused tx antenna mask in testmode
       mt76: mt7921: use correct iftype data on 6GHz cap init

Xing Song (2):
       mt76: reverse the first fragmented frame to 802.11
       mt76: do not pass the received frame with decryption error

  drivers/net/wireless/mediatek/mt76/debugfs.c         |   2 +-
  drivers/net/wireless/mediatek/mt76/eeprom.c          |   2 ++
  drivers/net/wireless/mediatek/mt76/mac80211.c        |  90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
  drivers/net/wireless/mediatek/mt76/mt76.h            |   8 +++++++-
  drivers/net/wireless/mediatek/mt76/mt7603/mac.c      |   9 +++++++--
  drivers/net/wireless/mediatek/mt76/mt7603/main.c     |  31 +++++++++++++++++++++++------
  drivers/net/wireless/mediatek/mt76/mt7603/mcu.c      |   4 ++--
  drivers/net/wireless/mediatek/mt76/mt7615/init.c     |   1 +
  drivers/net/wireless/mediatek/mt76/mt7615/mac.c      | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
  drivers/net/wireless/mediatek/mt76/mt7615/mac.h      |   2 ++
  drivers/net/wireless/mediatek/mt76/mt7615/main.c     |  11 +++--------
  drivers/net/wireless/mediatek/mt76/mt7615/mmio.c     |   1 +
  drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c |   8 ++++++--
  drivers/net/wireless/mediatek/mt76/mt7615/testmode.c |  21 ++++++++++----------
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c |  51 +++++++++++------------------------------------
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |   3 ++-
  drivers/net/wireless/mediatek/mt76/mt76x0/init.c     |   5 ++++-
  drivers/net/wireless/mediatek/mt76/mt76x0/main.c     |  34 ++++++++++++++++++++++++++++++--
  drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h   |   2 ++
  drivers/net/wireless/mediatek/mt76/mt76x0/pci.c      |   1 +
  drivers/net/wireless/mediatek/mt76/mt76x0/usb.c      |   1 +
  drivers/net/wireless/mediatek/mt76/mt76x02.h         |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76x02_util.c    |   4 +++-
  drivers/net/wireless/mediatek/mt76/mt76x2/init.c     |  29 +++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h   |   2 ++
  drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c |   5 +++--
  drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c |   7 ++++++-
  drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c |   4 +++-
  drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c |   9 +++++++--
  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c   |  83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
  drivers/net/wireless/mediatek/mt76/mt7915/mac.c      | 163 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------
  drivers/net/wireless/mediatek/mt76/mt7915/main.c     |  31 ++++++++++++++++++++++++-----
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      | 160 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h      |   9 +++++++++
  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h   |   4 ++++
  drivers/net/wireless/mediatek/mt76/mt7915/testmode.c |  17 ++++++++--------
  drivers/net/wireless/mediatek/mt76/mt7921/init.c     |  12 ++++-------
  drivers/net/wireless/mediatek/mt76/mt7921/mac.c      | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------
  drivers/net/wireless/mediatek/mt76/mt7921/main.c     |  74 +++++++++++++++++++++++++-------------------------------------------
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c      |  11 +++++++++++
  drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h   |   1 +
  drivers/net/wireless/mediatek/mt76/mt7921/pci.c      |  20 +++++++------------
  drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c  |   4 ++++
  drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c  |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c     |  48 ++++++++++++++++++++++++--------------------
  drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c |   2 +-
  drivers/net/wireless/mediatek/mt76/sdio.c            |   3 ++-
  drivers/net/wireless/mediatek/mt76/sdio_txrx.c       |   3 ++-
  drivers/net/wireless/mediatek/mt76/testmode.c        |  36 ++++++++++++++++++++++++++++++---
  drivers/net/wireless/mediatek/mt76/testmode.h        |   4 ++++
  50 files changed, 929 insertions(+), 362 deletions(-)
