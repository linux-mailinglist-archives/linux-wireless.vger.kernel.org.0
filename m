Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B107A47344D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 19:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241991AbhLMSrg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 13:47:36 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34902 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241994AbhLMSrf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 13:47:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53EACB8123D
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 18:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479FDC34602;
        Mon, 13 Dec 2021 18:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639421253;
        bh=AsT36GPIZexpgzXCgFzRZvV3iI9jKwbgGPjcJyiTbQo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Q7dkFVTVJorrZiJxQtb5tGSZvzD4d4PSnOHxHe+HXZ5PYFX2oOKe4pwfkkNc7H+02
         nRaCWFKG0FGwhtZquZGDvmTEzAuvT1gPFjxVrT7omBulGvuqXnj8+wLtTh4zASawxe
         I0Ll56YDjLhNi6f2A1pIda35Bi8W0bx+ryvhEQV2IQfKM6d10EIZ/h9tGDqONA/ZUn
         jNuEtmvWqBgmDw+eq5tqDQVWiSVRgeaDSaM+2A5YekrAFHtDzazionFbpXXO0OTL39
         6MVucBveipm0OoqaDrhrS5wGq/HvpXSfg5WHdYz3hIlfyUdd8osq/7ktxY/IwANOCB
         czlASjYBs9g4w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: pull request: mt76 2021-12-03
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <0f6dab1f-e892-7780-0c9b-545da9b8c04d@nbd.name>
References: <0f6dab1f-e892-7780-0c9b-545da9b8c04d@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <163942124954.6700.786144074860823802.kvalo@kernel.org>
Date:   Mon, 13 Dec 2021 18:47:32 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> Hi Kalle,
> 
> here's my first pull request for 5.17
> 
> - Felix
> 
> The following changes since commit 69831173fcbbfebb7aa2d76523deaf0b87b8eddd:
> 
>    rtlwifi: rtl8192de: Style clean-ups (2021-11-29 12:47:07 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-12-03
> 
> for you to fetch changes up to ba106bebc7429957ea9125639a4715ddd1b23171:
> 
>    mt76: mt7663: disable 4addr capability (2021-12-03 11:15:21 +0100)
> 
> ----------------------------------------------------------------
> mt76 patches for 5.17
> 
> * decap offload fixes
> * mt7915 fixes
> * mt7921 fixes
> * eeprom fixes
> * powersave handling fixes
> * SAR support
> 
> ----------------------------------------------------------------
> Bo Jiao (1):
>        mt76: fix the wiphy's available antennas to the correct value
> 
> Changcheng Deng (1):
>        mt76: mt7921: fix boolreturn.cocci warning
> 
> Daniel Golle (1):
>        mt76: eeprom: tolerate corrected bit-flips
> 
> Deren Wu (3):
>        mt76: mt7921: add support for PCIe ID 0x0608/0x0616
>        mt76: mt7921: introduce 160 MHz channel bandwidth support
>        mt76: mt7921s: fix bus hang with wrong privilege
> 
> Felix Fietkau (7):
>        mt76: mt7915: fix decap offload corner case with 4-addr VLAN frames
>        mt76: mt7615: fix decap offload corner case with 4-addr VLAN frames
>        mt76: mt7615: improve wmm index allocation
>        mt76: mt7915: improve wmm index allocation
>        mt76: clear sta powersave flag after notifying driver
>        mt76: mt7603: improve reliability of tx powersave filtering
>        mt76: mt7615: clear mcu error interrupt status on mt7663
> 
> Lorenzo Bianconi (15):
>        mt76: mt7915: get rid of mt7915_mcu_set_fixed_rate routine
>        mt76: debugfs: fix queue reporting for mt76-usb
>        mt76: fix possible OOB issue in mt76_calculate_default_rate
>        mt76: mt7921: fix possible NULL pointer dereference in mt7921_mac_write_txwi
>        mt76: connac: fix a theoretical NULL pointer dereference in mt76_connac_get_phy_mode
>        mt76: mt7615: remove dead code in get_omac_idx
>        mt76: connac: remove PHY_MODE_AX_6G configuration in mt76_connac_get_phy_mode
>        mt76: mt7921: honor mt76_connac_mcu_set_rate_txpower return value in mt7921_config
>        mt76: move sar utilities to mt76-core module
>        mt76: mt76x02: introduce SAR support
>        mt76: mt7603: introduce SAR support
>        mt76: mt7915: introduce SAR support
>        mt76: connac: fix last_chan configuration in mt76_connac_mcu_rate_txpower_band
>        mt76: move sar_capa configuration in common code
>        mt76: mt7663: disable 4addr capability
> 
> MeiChia Chiu (1):
>        mt76: mt7915: fix the wrong SMPS mode
> 
> Peter Chiu (1):
>        mt76: mt7615: fix possible deadlock while mt7615_register_ext_phy()
> 
> Ryder Lee (3):
>        mt76: mt7915: fix SMPS operation fail
>        mt76: only set rx radiotap flag from within decoder functions
>        mt76: only access ieee80211_hdr after mt76_insert_ccmp_hdr
> 
> Sean Wang (5):
>        mt76: mt7921: drop offload_flags overwritten
>        mt76: mt7921: fix MT7921E reset failure
>        mt76: mt7921: move mt76_connac_mcu_set_hif_suspend to bus-related files
>        mt76: mt7921s: fix the device cannot sleep deeply in suspend
>        mt76: mt7921s: fix possible kernel crash due to invalid Rx count
> 
> Shayne Chen (5):
>        mt76: mt7915: fix return condition in mt7915_tm_reg_backup_restore()
>        mt76: mt7915: add default calibrated data support
>        mt76: testmode: add support to set MAC
>        mt76: mt7615: fix unused tx antenna mask in testmode
>        mt76: mt7921: use correct iftype data on 6GHz cap init
> 
> Xing Song (2):
>        mt76: reverse the first fragmented frame to 802.11
>        mt76: do not pass the received frame with decryption error
> 
>   drivers/net/wireless/mediatek/mt76/debugfs.c         |   2 +-
>   drivers/net/wireless/mediatek/mt76/eeprom.c          |   2 ++
>   drivers/net/wireless/mediatek/mt76/mac80211.c        |  90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
>   drivers/net/wireless/mediatek/mt76/mt76.h            |   8 +++++++-
>   drivers/net/wireless/mediatek/mt76/mt7603/mac.c      |   9 +++++++--
>   drivers/net/wireless/mediatek/mt76/mt7603/main.c     |  31 +++++++++++++++++++++++------
>   drivers/net/wireless/mediatek/mt76/mt7603/mcu.c      |   4 ++--
>   drivers/net/wireless/mediatek/mt76/mt7615/init.c     |   1 +
>   drivers/net/wireless/mediatek/mt76/mt7615/mac.c      | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
>   drivers/net/wireless/mediatek/mt76/mt7615/mac.h      |   2 ++
>   drivers/net/wireless/mediatek/mt76/mt7615/main.c     |  11 +++--------
>   drivers/net/wireless/mediatek/mt76/mt7615/mmio.c     |   1 +
>   drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c |   8 ++++++--
>   drivers/net/wireless/mediatek/mt76/mt7615/testmode.c |  21 ++++++++++----------
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c |  51 +++++++++++------------------------------------
>   drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |   3 ++-
>   drivers/net/wireless/mediatek/mt76/mt76x0/init.c     |   5 ++++-
>   drivers/net/wireless/mediatek/mt76/mt76x0/main.c     |  34 ++++++++++++++++++++++++++++++--
>   drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h   |   2 ++
>   drivers/net/wireless/mediatek/mt76/mt76x0/pci.c      |   1 +
>   drivers/net/wireless/mediatek/mt76/mt76x0/usb.c      |   1 +
>   drivers/net/wireless/mediatek/mt76/mt76x02.h         |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt76x02_util.c    |   4 +++-
>   drivers/net/wireless/mediatek/mt76/mt76x2/init.c     |  29 +++++++++++++++++++++++++++
>   drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h   |   2 ++
>   drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c |   5 +++--
>   drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c |   7 ++++++-
>   drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c |   4 +++-
>   drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c |   9 +++++++--
>   drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c   |  83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
>   drivers/net/wireless/mediatek/mt76/mt7915/mac.c      | 163 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------
>   drivers/net/wireless/mediatek/mt76/mt7915/main.c     |  31 ++++++++++++++++++++++++-----
>   drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      | 160 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7915/mcu.h      |   9 +++++++++
>   drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h   |   4 ++++
>   drivers/net/wireless/mediatek/mt76/mt7915/testmode.c |  17 ++++++++--------
>   drivers/net/wireless/mediatek/mt76/mt7921/init.c     |  12 ++++-------
>   drivers/net/wireless/mediatek/mt76/mt7921/mac.c      | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------
>   drivers/net/wireless/mediatek/mt76/mt7921/main.c     |  74 +++++++++++++++++++++++++-------------------------------------------
>   drivers/net/wireless/mediatek/mt76/mt7921/mcu.c      |  11 +++++++++++
>   drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h   |   1 +
>   drivers/net/wireless/mediatek/mt76/mt7921/pci.c      |  20 +++++++------------
>   drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c  |   4 ++++
>   drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c  |   2 +-
>   drivers/net/wireless/mediatek/mt76/mt7921/sdio.c     |  48 ++++++++++++++++++++++++--------------------
>   drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c |   2 +-
>   drivers/net/wireless/mediatek/mt76/sdio.c            |   3 ++-
>   drivers/net/wireless/mediatek/mt76/sdio_txrx.c       |   3 ++-
>   drivers/net/wireless/mediatek/mt76/testmode.c        |  36 ++++++++++++++++++++++++++++++---
>   drivers/net/wireless/mediatek/mt76/testmode.h        |   4 ++++
>   50 files changed, 929 insertions(+), 362 deletions(-)

Fixes tag problems:

In commit

  0edfc0255b0b ("mt76: mt7915: fix the wrong SMPS mode")

Fixes tag

  Fixes: 427b09cd6bfa ("mt76: mt7915: fix SMPS operation fail")

has these problem(s):

  - Target SHA1 does not exist

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/0f6dab1f-e892-7780-0c9b-545da9b8c04d@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

