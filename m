Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884F31F0C60
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Jun 2020 17:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgFGP2f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 Jun 2020 11:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgFGP2f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 Jun 2020 11:28:35 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659FBC08C5C3
        for <linux-wireless@vger.kernel.org>; Sun,  7 Jun 2020 08:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Cc:To:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=z1raFWjk5fg/mgkBo8SFuwEMYQxEFAJKND9K03R79PY=; b=ZANeKR2sBY/EEMNu86wshPR08t
        S6SMMVV/9u2qsuWcgOuxnJ+MsmmyQWcUqPDeoafvXVf4cHjypfsRDHkiz1omtKxo80gFba9mN4tXC
        JUdvIp+u3Uk0yUc+0oUMfpIgbakTkq1MZMmTd9nwoguaqc5KXYi1FQap+P50scsfeEHA=;
Received: from p4ff13772.dip0.t-ipconnect.de ([79.241.55.114] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jhxDq-0002Rb-EM; Sun, 07 Jun 2020 17:28:30 +0200
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
Message-ID: <8af947fd-8d23-ce5c-eee5-1107d6af9d22@nbd.name>
Date:   Sun, 7 Jun 2020 17:28:29 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's another pull request for 5.8 with a few fixes

- Felix

The following changes since commit 1806c13dc2532090d742ce03847b22367fb20ad6:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2020-05-31 17:48:46 -0700)

are available in the Git repository at:

  https://github.com/nbd168/wireless tags/mt76-for-kvalo-2020-06-07

for you to fetch changes up to 7f88314321e20744114bc596b6528bb9d57ff46f:

  mt76: overwrite qid for non-bufferable mgmt frames (2020-06-07 16:59:40 +0200)

----------------------------------------------------------------
mt76 patches for 5.8

* tx queueing fixes for mt7615/22/63
* locking fix

----------------------------------------------------------------
Lorenzo Bianconi (4):
      mt76: add missing lock configuring coverage class
      mt76: mt7615: fix lmac queue debugsfs entry
      mt76: mt7615: fix hw queue mapping
      mt76: overwrite qid for non-bufferable mgmt frames

 drivers/net/wireless/mediatek/mt76/mt76.h           |  1 +
 drivers/net/wireless/mediatek/mt76/mt7603/main.c    |  2 ++
 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c |  9 +++++----
 drivers/net/wireless/mediatek/mt76/mt7615/dma.c     |  9 +++++----
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c     | 20 +++++++-------------
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h     | 15 ---------------
 drivers/net/wireless/mediatek/mt76/mt7615/main.c    |  4 ++++
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c    |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h  | 30 ++++++++++++++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7615/usb.c     |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/main.c    |  3 +++
 drivers/net/wireless/mediatek/mt76/tx.c             |  7 +++++++
 drivers/net/wireless/mediatek/mt76/usb.c            | 17 +++++++++--------
 13 files changed, 75 insertions(+), 46 deletions(-)
