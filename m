Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F0858116
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 13:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfF0LDD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jun 2019 07:03:03 -0400
Received: from nbd.name ([46.4.11.11]:49268 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfF0LDC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jun 2019 07:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xLODMZ2MHfGpuTtowUhK85eiGAIpmAMs679qsh/im80=; b=Mc+roeXCJxZ8j4zfZgNt4kD0F4
        Q7UME5QaF2amrSojZhubmAY+mHsSFiXMhfmODJU2P4QRnJx38udbTcUg7kBdenSC33cFNSW20EgJ7
        Lv+V1pYpxAZFZNEpHlu6OqCHa+40g2pedJCGYt8/aUVJxL39ODToIPFd+s4HwVw6w6r4=;
Received: from p54ae90fe.dip0.t-ipconnect.de ([84.174.144.254] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hgSBB-0007Dk-9W; Thu, 27 Jun 2019 13:03:01 +0200
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2019-06-27
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
Message-ID: <a0e08791-e4e0-6772-751c-be05a4d25d8c@nbd.name>
Date:   Thu, 27 Jun 2019 13:03:00 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's my first pull request for 5.3

- Felix

The following changes since commit e5db0ad7563c38b7b329504836c9a64ae025a47a:

  airo: switch to skcipher interface (2019-06-25 08:12:20 +0300)

are available in the Git repository at:

  https://github.com/nbd168/wireless tags/mt76-for-kvalo-2019-06-27

for you to fetch changes up to 676fabd1d2f089f9fb8bece3476c2ab5584b4a1a:

  mt76: mt7603: fix sparse warnings: warning: incorrect type in assignment (different base types) (2019-06-27 12:59:07 +0200)

----------------------------------------------------------------
mt76 patches for 5.3

* use NAPI polling for tx cleanup on mt7603/mt7615
* various fixes for mt7615
* unify some code between mt7603 and mt7615
* fix locking issues on mt76x02
* add support for toggling edcca on mt7603
* fix reading target tx power with ext PA on mt7603/mt7615
* fix initalizing channel maximum power
* fix rate control / tx status reporting issues on mt76x02/mt7603
* add support for eeprom calibration data from mtd on mt7615
* support configuring tx power on mt7615
* fix external PA support on mt76x0
* per-chain signal reporting on mt7615
* rx/tx buffer fixes for USB devices

----------------------------------------------------------------
Dan Carpenter (2):
      mt76: Fix a signedness bug in mt7615_add_interface()
      mt76: mt7615: Use after free in mt7615_mcu_set_bcn()

Felix Fietkau (7):
      mt76: mt7603: fix reading target tx power from eeprom
      mt76: fix setting chan->max_power
      mt76: mt76x02: fix tx status reporting issues
      mt76: mt76x02: fix tx reordering on rate control probing without a-mpdu
      mt76: mt76x0: fix RF frontend initialization for external PA
      mt76: mt7603: rework and fix tx status reporting
      mt76: mt7603: improve hardware rate switching configuration

Lorenzo Bianconi (53):
      mt76: mt76x02: remove useless return in mt76x02_resync_beacon_timer
      mt76: move tx_napi in mt76_dev
      mt76: mt7603: use napi polling for tx cleanup
      mt76: mt7615: use napi polling for tx cleanup
      mt76: move netif_napi_del in mt76_dma_cleanup
      mt7615: mcu: simplify __mt7615_mcu_set_wtbl
      mt7615: mcu: simplify __mt7615_mcu_set_sta_rec
      mt7615: mcu: remove bss_info_convert_vif_type routine
      mt7615: mcu: use proper msg size in mt7615_mcu_add_wtbl_bmc
      mt7615: mcu: use proper msg size in mt7615_mcu_add_wtbl
      mt7615: mcu: unify mt7615_mcu_add_wtbl_bmc and mt7615_mcu_del_wtbl_bmc
      mt7615: mcu: remove unused parameter in mt7615_mcu_del_wtbl
      mt7615: remove query from mt7615_mcu_msg_send signature
      mt7615: remove dest from mt7615_mcu_msg_send signature
      mt7615: mcu: remove skb_ret from mt7615_mcu_msg_send
      mt7615: mcu: unify __mt7615_mcu_set_dev_info and mt7615_mcu_set_dev_info
      mt7615: mcu: do not use function pointers whenever possible
      mt7615: mcu: remove unused structure in mcu.h
      mt7615: mcu: use standard signature for mt7615_mcu_msg_send
      mt7615: initialize mt76_mcu_ops data structure
      mt7615: mcu: init mcu_restart function pointer
      mt7615: mcu: run __mt76_mcu_send_msg in mt7615_mcu_send_firmware
      mt76: mt7603: stop mac80211 queues before setting the channel
      mt76: mt7615: rearrange cleanup operations in mt7615_unregister_device
      mt76: mt7615: add static qualifier to mt7615_rx_poll_complete
      mt76: mt76x02: remove enable from mt76x02_edcca_init signature
      mt76: mt76x2u: remove mt76x02_edcca_init in mt76x2u_set_channel
      mt76: mt76x2: move mutex_lock inside mt76x2_set_channel
      mt76: mt76x02: run mt76x02_edcca_init atomically in mt76_edcca_set
      mt76: mt7603: add debugfs knob to enable/disable edcca
      mt76: mt76x02: fix edcca file permission
      mt76: mt7615: do not process rx packets if the device is not initialized
      mt76: move mt76_insert_ccmp_hdr in mt76-module
      mt76: mt7615: add support for mtd eeprom parsing
      mt76: mt7615: select wifi band according to eeprom
      mt76: generalize mt76_get_txpower for 4x4:4 devices
      mt76: mt7615: add the capability to configure tx power
      mt76: mt7615: init get_txpower mac80211 callback
      mt76: mt7615: rearrange locking in mt7615_config
      mt76: move mt76_get_rate in mt76-module
      mt76: mt7615: remove unused variable in mt7615_mcu_set_bcn
      mt76: mt7615: remove key check in mt7615_mcu_set_wtbl_key
      mt76: mt7615: simplify mt7615_mcu_set_sta_rec routine
      mt76: mt7615: init per-channel target power
      mt76: mt7615: take into account extPA when configuring tx power
      mt76: mt76x02u: fix sparse warnings: should it be static?
      mt76: mt76u: reduce rx memory footprint
      mt76: mt7615: remove cfg80211_chan_def from mt7615_set_channel signature
      mt76: move nl80211_dfs_regions in mt76_dev data structure
      mt76: mt76u: get rid of {out,in}_max_packet
      mt76: mt7615: fix sparse warnings: incorrect type in assignment (different base types)
      mt76: mt7615: fix sparse warnings: warning: cast from restricted __le16
      mt76: mt7603: fix sparse warnings: warning: incorrect type in assignment (different base types)

Ryder Lee (5):
      mt76: mt7615: enable support for mesh
      mt76: mt7615: fix slow performance when enable encryption
      mt76: mt7615: add support for per-chain signal strength reporting
      mt76: mt7615: fix incorrect settings in mesh mode
      mt76: mt7615: update peer's bssid when state transition occurs

YueHaibing (2):
      mt76: mt7615: Make mt7615_irq_handler static
      mt76: Remove set but not used variables 'pid' and 'final_mpdu'

 drivers/net/wireless/mediatek/mt76/dma.c              |    1 +
 drivers/net/wireless/mediatek/mt76/mac80211.c         |   62 ++++-
 drivers/net/wireless/mediatek/mt76/mt76.h             |   23 +-
 drivers/net/wireless/mediatek/mt76/mt7603/core.c      |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c   |   30 +++
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c       |   29 ++-
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h    |    2 +
 drivers/net/wireless/mediatek/mt76/mt7603/init.c      |   26 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c       |  191 ++++++++-------
 drivers/net/wireless/mediatek/mt76/mt7603/main.c      |    8 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.c       |    2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h    |   15 +-
 drivers/net/wireless/mediatek/mt76/mt7603/regs.h      |    6 +
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c       |   23 +-
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c    |   97 +++++++-
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h    |   61 +++++
 drivers/net/wireless/mediatek/mt76/mt7615/init.c      |   77 +++++-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c       |   85 +++----
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h       |    5 +
 drivers/net/wireless/mediatek/mt76/mt7615/main.c      |   52 ++--
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c       | 1265 ++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h       |   56 ++---
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h    |   16 +-
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c       |    7 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/init.c      |    5 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/main.c      |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c       |   13 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c       |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02.h          |    1 -
 drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c   |    4 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c  |   10 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c      |   18 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_dfs.h      |    2 -
 drivers/net/wireless/mediatek/mt76/mt76x02_eeprom.h   |    1 +
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c      |  106 ++++++--
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.h      |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c     |   18 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_regs.h     |    3 +
 drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c     |    9 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c |   11 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/init.c      |    9 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c  |   16 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c   |    8 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c  |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c  |   23 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c   |    7 +-
 drivers/net/wireless/mediatek/mt76/usb.c              |   20 +-
 47 files changed, 1422 insertions(+), 1011 deletions(-)
