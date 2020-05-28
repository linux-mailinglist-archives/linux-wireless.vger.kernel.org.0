Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452A11E6712
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 18:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404750AbgE1QGJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 12:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404688AbgE1QGI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 12:06:08 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CCDC08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 09:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=kpKMFRFo0kfvMFe1e9DoqgtX5zjWtCWyJkn9QbzFAHA=; b=MWwrtJrEUUTeLKl/pM8OmFhBm+
        feqzMBxFG66sgSs5UFojC2Cb6yiI2YejH2UyNeRJrFyRulPsAZ52LYxYRc4H1jUQb9I3KfkDGL90y
        B+zxKaH+5xeyAVjVXZmjI0q1tbDaV8kZURDNJ8OSJltnLgT3xDaSQVe+qtcDfbtxcWEc=;
Received: from p4ff13c20.dip0.t-ipconnect.de ([79.241.60.32] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jeL2j-0006CE-QX; Thu, 28 May 2020 18:06:05 +0200
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2019-05-22
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
Message-ID: <d0de94c9-f367-0f57-950b-c76e1808bdcb@nbd.name>
Date:   Thu, 28 May 2020 18:06:05 +0200
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

here's another pull request for 5.8, replacing the previous one.

- Felix

The following changes since commit 50ce4c099bebf56be86c9448f7f4bcd34f33663c:

  sctp: fix typo sctp_ulpevent_nofity_peer_addr_change (2020-05-27 15:08:02 -0700)

are available in the Git repository at:

  https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-05-28

for you to fetch changes up to d9045b18cd445e0d0a53903ffd5d79793d9df59e:

  mt76: mt7915: remove set but not used variable 'msta' (2020-05-28 17:57:25 +0200)

----------------------------------------------------------------
mt76 patches for 5.8

* fixes for sparse warnings
* DBDC fixes
* mt7663 remain-on-channel support
* mt7915 spatial reuse support
* mt7915 radiotap fix
* station wcid allocation fix
* mt7663 powersave fix
* mt7663 scan fix
* mt7611n support
* cleanup

----------------------------------------------------------------
Colin Ian King (1):
      mt76: mt7915: fix a handful of spelling mistakes

DENG Qingfang (1):
      mt76: mt7615: add support for MT7611N

Felix Fietkau (3):
      mt76: fix per-driver wcid range checks after wcid array size bump
      mt76: fix wcid allocation issues
      mt76: only iterate over initialized rx queues

Lorenzo Bianconi (5):
      mt76: mt7615: introduce remain_on_channel support
      mt76: mt76x02: remove check in mt76x02_mcu_msg_send
      mt76: mt7615: fix NULL pointer deref in mt7615_register_ext_phy
      mt76: mt7615: switch to per-vif power_save support
      mt76: mt7915: fix possible NULL pointer dereference in mt7915_register_ext_phy

Ryder Lee (5):
      mt76: mt7915: add spatial reuse support
      mt76: mt7915: fix some sparse warnings
      mt76: mt7915: fix sparse warnings: incorrect type initializer
      mt76: mt7915: fix decoded radiotap HE flags
      mt76: mt7915: fix some sparse warnings

Sean Wang (1):
      mt76: mt7615: fix hw_scan with ssid_type for specified SSID only

YueHaibing (2):
      mt76: mt7615: Use kmemdup in mt7615_queue_key_update()
      mt76: mt7915: remove set but not used variable 'msta'

 drivers/net/wireless/mediatek/mt76/debugfs.c        |   2 +-
 drivers/net/wireless/mediatek/mt76/dma.c            |   4 +--
 drivers/net/wireless/mediatek/mt76/mt76.h           |  10 +++++---
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c     |   7 ++---
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c  |   7 +++++
 drivers/net/wireless/mediatek/mt76/mt7615/init.c    |  22 +++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c     |  17 +++++++++----
 drivers/net/wireless/mediatek/mt76/mt7615/main.c    | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c     |  66 +++++++++++++++++++++++++++++++++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h     |  25 ++++++++++++++++--
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h  |  19 +++++++++++---
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c     |   9 ++++---
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c     |   3 ++-
 drivers/net/wireless/mediatek/mt76/mt76x02.h        |   3 ++-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c   |   5 ++--
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c |   6 ++---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c    |   3 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c     |  58 +++++++++++++++++++++++-------------------
 drivers/net/wireless/mediatek/mt76/mt7915/main.c    |   9 +++++--
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c     |  41 ++++++++++++++++++++++--------
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h     |   1 +
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h  |   2 ++
 drivers/net/wireless/mediatek/mt76/util.c           |  12 ++++-----
 drivers/net/wireless/mediatek/mt76/util.h           |  14 +++++-----
 27 files changed, 335 insertions(+), 124 deletions(-)
