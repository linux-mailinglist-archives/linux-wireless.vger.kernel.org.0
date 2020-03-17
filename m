Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3ED188BEC
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 18:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgCQRUi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 13:20:38 -0400
Received: from nbd.name ([46.4.11.11]:52742 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbgCQRUh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 13:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Axt+LF5uRDFNOuO9M0clK5cXzDKiJBiejywP0XXxozQ=; b=CeUXQfqQckr6HONadvoU9s7ji2
        NKb/pDFNn2kPCjcEM857UW/fVLzpnmheylBkuTqQmYoSGH+0X/K7kjmbHcwwFBba2CCnAcZjy/Vbk
        xS3AGzhReccgnJHHK7P/y+xYDXOdB8r2WsZO7sxCy/xGdS1PYucTSVJY85tWipRfeDMk=;
Received: from [80.255.7.109] (helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jEFtL-0000ny-Ln; Tue, 17 Mar 2020 18:20:35 +0100
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2019-03-17
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
Message-ID: <91c846f1-8cd1-d460-663b-add7a439028f@nbd.name>
Date:   Tue, 17 Mar 2020 18:20:34 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's my second pull request for 5.7.

- Felix

The following changes since commit 377c0a94ad1cf005c47d7a502d1f8e46fbcf747a:

  Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git (2020-03-16 07:29:55 +0200)

are available in the Git repository at:

  https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-03-17

for you to fetch changes up to f40ac0f3d3c0e2b17185e1707a3b4552e5187dd5:

  mt76: mt7615: introduce mt7663e support (2020-03-17 17:48:00 +0100)

----------------------------------------------------------------
mt76 patches for 5.7

* MT7663 support for the MT7615 driver
* USB fixes
* DBDC fixes for MT7615
* MT76x02 watchdog fixes
* Injection fix for MT7615
* Sensitivity fix for MT7615
* MCU support code cleanup

----------------------------------------------------------------
Chen Wandun (1):
      mt76: remove variable 'val' set but not used

Dan Carpenter (1):
      mt76: mt7615: remove a stray if statement

Felix Fietkau (5):
      mt76: mt7615: fix antenna mask initialization in DBDC mode
      mt76: mt7603: add upper limit for dynamic sensitivity minimum receive power
      mt76: mt7603: make dynamic sensitivity adjustment configurable via debugfs
      mt76: mt7615: fix monitor injection of beacon frames
      mt76: mt76x02: reset MCU timeout counter earlier in watchdog reset

Lorenzo Bianconi (27):
      mt76: mt76u: loop over all possible rx queues in mt76u_rx_tasklet
      mt76: mt76u: fix a possible memory leak in mt76u_init
      mt76: mt76u: rely only on data buffer for usb control messagges
      mt76: mt7615: introduce mt7615_mcu_fill_msg
      mt76: mt7615: introduce mt7615_mcu_wait_response
      mt76: mt7615: cleanup fw queue just for mmio devices
      mt76: mt7615: introduce mt7615_init_device routine
      mt76: always init to 0 mcu messages
      mt76: mt7615: introduce mt7615_mcu_send_message routine
      mt76: mt7615: add mt7615_mcu_ops data structure
      mt76: mt7615: move mt7615_mcu_set_bmc to mt7615_mcu_ops
      mt76: mt7615: move mt7615_mcu_set_sta in mt7615_mcu_ops
      mt76: mt7615: rely on skb API for mt7615_mcu_set_eeprom
      mt76: mt7615: rework mt7615_mcu_set_bss_info using skb APIs
      mt76: mt7615: move more mcu commands in mt7615_mcu_ops data structure
      mt76: mt7615: introduce MCU_FW_PREFIX for fw mcu commands
      mt76: mt7615: introduce mt7615_register_map
      mt76: mt7615: add mt7663e support to mt7615_reg_map
      mt76: mt7615: add mt7663e support to mt7615_{driver,firmware}_own
      mt76: mt7615: add mt7663e support to mt7615_mcu_set_eeprom
      mt76: mt7615: introduce mt7615_eeprom_parse_hw_band_cap routine
      mt76: mt7615: introduce mt7615_init_mac_chain routine
      mt76: mt7615: introduce uni cmd command types
      mt76: mt7615: introduce set_bmc and st_sta for uni commands
      mt76: mt7615: introduce set_ba uni command
      mt76: mt7615: get rid of sta_rec_wtbl data structure
      mt76: mt7615: introduce mt7663e support

Sean Wang (1):
      mt76: mt7615: add more uni mcu commands

 drivers/net/wireless/mediatek/mt76/mcu.c            |    6 +-
 drivers/net/wireless/mediatek/mt76/mt76.h           |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c |    4 +
 drivers/net/wireless/mediatek/mt76/mt7603/init.c    |    2 +
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c     |    6 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mcu.c     |    1 -
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h  |    2 +
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c     |   50 +-
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c  |   66 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h  |    2 +
 drivers/net/wireless/mediatek/mt76/mt7615/init.c    |  161 +++---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c     |   30 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h     |   11 +-
 drivers/net/wireless/mediatek/mt76/mt7615/main.c    |   44 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c     | 2761 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h     |  144 +++++-
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c    |   67 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h  |   65 ++-
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c     |    8 +-
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h    |   87 +++-
 drivers/net/wireless/mediatek/mt76/mt7615/soc.c     |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c     |    3 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c   |    5 +-
 drivers/net/wireless/mediatek/mt76/usb.c            |   36 +-
 24 files changed, 2252 insertions(+), 1316 deletions(-)
