Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E32B1DE72B
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 14:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgEVMv4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 08:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgEVMv4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 08:51:56 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FDCC061A0E
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2020 05:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=D8cEf+flfdUFTN6zCex2Rpb9ZKTlbyySSATnRwcmeis=; b=RvQGZhaiNaL+RIeLz/Jep7Wh4u
        7XyyxYoJyUKPfZuj1m6JIJG5ntbLnAXPZxmy4uAlug5+5rrKzZIDVd70hE13qMddVH4t16hXosafJ
        zPM3s/zt06QcMIPc0eOeVksjaqj/y9H6WIrxXUVvjVuXpGMHwkE/1JSTet3ExPTF6AJA=;
Received: from [91.32.108.59] (helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jc79V-0003tn-Nl; Fri, 22 May 2020 14:51:53 +0200
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
Message-ID: <5dab331b-9dd9-ecf8-12c8-31b7eb7ca8c3@nbd.name>
Date:   Fri, 22 May 2020 14:51:25 +0200
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

here's my second pull request for 5.8.

- Felix

The following changes since commit 472f0a240250df443ffc4f39835e829916193ca1:

  mt76: mt7915: Fix build error (2020-05-22 15:39:40 +0300)

are available in the Git repository at:

  https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-05-22

for you to fetch changes up to 35f296f6ba77d903fe8f55ed2713cfc2cc0389eb:

  mt76: mt7915: fix possible NULL pointer dereference in mt7915_register_ext_phy (2020-05-22 14:44:32 +0200)

----------------------------------------------------------------
mt76 patches for 5.8

* fixes for sparse warnings
* DBDC fixes
* mt7663 remain-on-channel support
* mt7915 spatial reuse support
* mt7915 radiotap fix
* station wcid allocation fix

----------------------------------------------------------------
Colin Ian King (1):
      mt76: mt7915: fix a handful of spelling mistakes

Felix Fietkau (1):
      mt76: fix per-driver wcid range checks after wcid array size bump

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

 drivers/net/wireless/mediatek/mt76/mt76.h           |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c     |   4 ++--
 drivers/net/wireless/mediatek/mt76/mt7615/init.c    |  22 ++++++++++++++-------
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c     |  14 +++++++++----
 drivers/net/wireless/mediatek/mt76/mt7615/main.c    | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c     |  66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h     |  25 ++++++++++++++++++++++--
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h  |  12 +++++++++---
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c     |   3 ++-
 drivers/net/wireless/mediatek/mt76/mt76x02.h        |   3 ++-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c |   6 +++---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c    |   3 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c     |  55 +++++++++++++++++++++++++++------------------------
 drivers/net/wireless/mediatek/mt76/mt7915/main.c    |   9 +++++++--
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c     |  38 +++++++++++++++++++++++++++++-------
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.h     |   1 +
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h  |   2 ++
 21 files changed, 285 insertions(+), 93 deletions(-)
