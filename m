Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FF12286B0
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jul 2020 19:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbgGURDc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jul 2020 13:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgGURC3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jul 2020 13:02:29 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C251C061794
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jul 2020 10:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QZUtgHr64ca4S+gDhd9J7UTU6Nb5HDapLuBnrxOMpkU=; b=JoV2gg202LLH+CI5kDW5yhkeR3
        mdQ/FGHJF9GelwnM92gmGirtQ2KTlHMRBS5GUjgEnMSVfGrqMDRcZm2R3aSymAMenFgWNAKHDRnXk
        aP0vxmWhtIR7uS3xY3UZkgLkiXyQh5ZpAe/0dfP/29Z82j+txQP1zZuvNkIqzSRkXx9s=;
Received: from p54ae9e66.dip0.t-ipconnect.de ([84.174.158.102] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jxves-0007YN-Bs; Tue, 21 Jul 2020 19:02:26 +0200
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2019-06-07
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
Message-ID: <8b3efa2b-f2d4-f4f8-547c-28275bbc99ba@nbd.name>
Date:   Tue, 21 Jul 2020 19:02:25 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's a mt76 pull request for 5.9

- Felix

The following changes since commit 71d4364abdc50cb1f0ff5af0f932b110278f620c:

  net: dsa: use the ETH_MIN_MTU and ETH_DATA_LEN default values (2020-07-20 18:35:04 -0700)

are available in the Git repository at:

  https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-07-21

for you to fetch changes up to 5648d1c9cadb0a6afb29dd8891159906dadf5c77:

  mt76: mt76u: add missing release on skb in __mt76x02u_mcu_send_msg (2020-07-21 19:01:19 +0200)

----------------------------------------------------------------
mt76 patches for 5.9

* locking fixes
* tx queue mapping fixes for 7615/7915
* ARP filter offload for 7663
* runtime power management for 7663
* testmode support for mfg calibration
* memory leak fixes
* support for more channels

----------------------------------------------------------------
Dan Carpenter (1):
      mt76: mt7915: potential array overflow in mt7915_mcu_tx_rate_report()

Felix Fietkau (8):
      mt76: mt7615: re-enable offloading of sequence number assignment
      mt76: mt7615: schedule tx tasklet and sta poll on mac tx free
      mt76: mt7615: add support for accessing mapped registers via bus ops
      mt76: mt7615: add support for accessing RF registers via MCU
      mt76: mt7615: use full on-chip memory address for WF_PHY registers
      mt76: vif_mask to struct mt76_phy
      mt76: add API for testmode support
      mt76: mt7615: implement testmode support

Lorenzo Bianconi (41):
      mt76: add missing lock configuring coverage class
      mt76: mt7615: fix lmac queue debugsfs entry
      mt76: mt7615: fix hw queue mapping
      mt76: overwrite qid for non-bufferable mgmt frames
      mt76: usb: rely on mt76_for_each_q_rx
      mt76: rely on register macros
      mt76: add U-APSD support on AP side
      mt76: mt76x2e: rename routines in pci.c
      mt76: mt76x2: fix pci suspend/resume on mt7612e
      mt76: mt76x2u: enable HC-M7662BU1
      mt76: mt7615: avoid polling in fw_own for mt7663
      mt76: move mt76 workqueue in common code
      mt76: mt7615: add mt7615_pm_wake utility routine
      mt76: mt7615: introduce mt7615_mutex_{acquire,release} utilities
      mt76: mt7615: wake device before accessing regmap in debugfs
      mt76: mt7615: wake device before configuring hw keys
      mt76: mt7615: introduce pm_power_save delayed work
      mt76: mt7615: wake device in mt7615_update_channel before access regmap
      mt76: mt7615: acquire driver_own before configuring device for suspend
      mt76: mt7615: wake device before performing freq scan
      mt76: mt7615: add missing lock in mt7615_regd_notifier
      mt76: mt7615: run mt7615_mcu_set_wmm holding mt76 mutex
      mt76: mt7615: run mt7615_mcu_set_roc holding mt76 mutex
      mt76: mt7615: wake device before pulling packets from mac80211 queues
      mt76: mt7615: wake device before pushing frames in mt7615_tx
      mt76: mt7615: run mt7615_pm_wake in mt7615_mac_sta_{add,remove}
      mt76: mt7615: check MT76_STATE_PM flag before accessing the device
      mt76: mt7615: do not request {driver,fw}_own if already granted
      mt76: mt7615: add runtime-pm knob in mt7615 debugfs
      mt76: mt7615: enable beacon hw filter for runtime-pm
      mt76: mt7615: add idle-timeout knob in mt7615 debugfs
      mt76: mt7615: improve mt7615_driver_own reliability
      mt76: mt7663u: sync probe sampling with rate configuration
      mt76: mt7615: avoid scheduling runtime-pm during hw scan
      mt76: mt7615: reschedule ps work according to last activity
      mt76: mt7615: take into account sdio bus configuring txwi
      mt76: mt76u: add mt76_skb_adjust_pad utility routine
      mt76: mt7615: sdio code must access rate/key regs in preocess context
      mt76: mt7615: introduce mt7663-usb-sdio-common module
      mt76: mt76s: move queue accounting in mt76s_tx_queue_skb
      mt76: mt7615: fix possible memory leak in mt7615_mcu_wtbl_sta_add

Markus Theil (2):
      mt76: allow more channels, allowed in ETSI domain
      mt76: fix include in pci.h

Navid Emamdoost (1):
      mt76: mt76u: add missing release on skb in __mt76x02u_mcu_send_msg

Ryder Lee (9):
      mt76: mt7615: add .set_tsf callback
      mt76: mt7915: add a fixed AC queue mapping
      mt76: mt7915: add MU-MIMO support
      mt76: mt7915: use ieee80211_tx_queue_params to avoid open coded
      mt76: mt7915: overwrite qid for non-bufferable mgmt frames
      mt76: mt7915: update HE capabilities
      mt76: mt7915: avoid memcpy in rxv operation
      mt76: mt7915: add missing CONFIG_MAC80211_DEBUGFS
      mt76: mt7915: fix potential memory leak in mcu message handler

Sean Wang (7):
      mt76: mt7663: introduce ARP filter offload
      mt76: mt7615: fix up typo in Kconfig for MT7663U
      mt76: mt7663u: fix memory leak in set key
      mt76: mt7663u: fix potential memory leak in mcu message handler
      mt76: mt7615: fix potential memory leak in mcu message handler
      mt76: introduce mt76_sdio module
      mt76: mt7615: introduce mt7663s support

 drivers/net/wireless/mediatek/mt76/Kconfig            |   4 +
 drivers/net/wireless/mediatek/mt76/Makefile           |   3 +
 drivers/net/wireless/mediatek/mt76/debugfs.c          |   7 +-
 drivers/net/wireless/mediatek/mt76/dma.c              |   6 ++
 drivers/net/wireless/mediatek/mt76/eeprom.c           |   5 +
 drivers/net/wireless/mediatek/mt76/mac80211.c         |  37 +++++++-
 drivers/net/wireless/mediatek/mt76/mt76.h             | 116 ++++++++++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c      |   8 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h    |   2 -
 drivers/net/wireless/mediatek/mt76/mt7615/Kconfig     |  19 +++-
 drivers/net/wireless/mediatek/mt76/mt7615/Makefile    |   7 +-
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c   | 111 +++++++++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c       |  13 +--
 drivers/net/wireless/mediatek/mt76/mt7615/init.c      |  17 +++-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c       | 330 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h       |  20 +---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c      | 332 ++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c       | 371 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h       |  54 ++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c      |  51 +++++++++-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h    | 125 +++++++++++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c       |   4 +
 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c  |   4 +
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c   |   1 -
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h      |  33 ++++++-
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c      | 478 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/sdio.h      | 115 ++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c  | 162 +++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c | 268 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/testmode.c  | 363 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c       | 248 ++++--------------------------------------------
 drivers/net/wireless/mediatek/mt76/mt7615/usb_init.c  | 145 ----------------------------
 drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c   |   7 +-
 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c  | 394 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c       |   6 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h          |   1 -
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c     |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c |   3 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c  |   7 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c     |   8 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/mt76x2.h    |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c       |  70 ++++++++++++--
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c  |  17 ++++
 drivers/net/wireless/mediatek/mt76/mt76x2/usb.c       |   8 +-
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c   |  11 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/dma.c       |  21 +++--
 drivers/net/wireless/mediatek/mt76/mt7915/init.c      |  44 +++++----
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c       |  93 +++++++++---------
 drivers/net/wireless/mediatek/mt76/mt7915/mac.h       |  17 ----
 drivers/net/wireless/mediatek/mt76/mt7915/main.c      |  16 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c       | 117 ++++++++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h       |   6 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h    |  35 +++++--
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c       |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h      |   5 +
 drivers/net/wireless/mediatek/mt76/pci.c              |   1 +
 drivers/net/wireless/mediatek/mt76/sdio.c             | 368 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/testmode.c         | 497 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/testmode.h         | 156 ++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/tx.c               |  54 +++++++++++
 drivers/net/wireless/mediatek/mt76/usb.c              | 107 +++++----------------
 drivers/net/wireless/mediatek/mt76/util.c             |   4 +-
 62 files changed, 4691 insertions(+), 846 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/sdio.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/usb_init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/sdio.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/testmode.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/testmode.h
