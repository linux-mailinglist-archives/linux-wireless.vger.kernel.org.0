Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68903438374
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Oct 2021 13:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhJWLaa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Oct 2021 07:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhJWLaa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Oct 2021 07:30:30 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE21C061764
        for <linux-wireless@vger.kernel.org>; Sat, 23 Oct 2021 04:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Xw4XNtzZEEQCI6zgj6R3NYmBbvB/vSHwWhpMA26xtAM=; b=cld0q0aiJH9St7K3vul+5QyESj
        oPoezaBD1UNfB9OifPHJ6nRIZEI/yFnR+IPxZtQZ0my7Zs/fm39f3Iu8MRekzyqAuZ6J/Lr15DOQC
        fnvXWKcZmf1/F2YKMAHzKpsjsh34Om9nxKKMHYQbSkV/8cwsqiBl/15dLV7T+S0QRqEo=;
Received: from p4ff1322b.dip0.t-ipconnect.de ([79.241.50.43] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1meFC5-0007p8-J4; Sat, 23 Oct 2021 13:28:09 +0200
Message-ID: <6d896d65-235c-41b8-89bd-8349f031dd53@nbd.name>
Date:   Sat, 23 Oct 2021 13:28:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
From:   Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76 2021-10-23
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

here's a pull request with some follow-up fixes for 5.16

- Felix

The following changes since commit 753453afacc0243bd45de45e34218a8d17493e8f:

   mt76: mt7615: mt7622: fix ibss and meshpoint (2021-10-23 10:29:39 +0300)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2021-10-23

for you to fetch changes up to 52a99a13cb880845cd77f1da7136d689347489ef:

   mt76: connac: fix unresolved symbols when CONFIG_PM is unset (2021-10-23 13:23:45 +0200)

----------------------------------------------------------------
mt76 patches for 5.16

* fix a compile error with !CONFIG_PM
* cleanups
* MT7915 DBDC fixes
* endian warning fixes

----------------------------------------------------------------
Cai Huoqing (1):
       mt76: Make use of the helper macro kthread_run()

Felix Fietkau (1):
       mt76: connac: fix unresolved symbols when CONFIG_PM is unset

Hauke Mehrtens (1):
       mt76: Print error message when reading EEPROM from mtd failed

Lorenzo Bianconi (2):
       mt76: mt7915: fix endiannes warning mt7915_mcu_beacon_check_caps
       mt76: mt7921: disable 4addr capability

Ryder Lee (4):
       mt76: mt7615: apply cached RF data for DBDC
       mt76: mt7915: remove mt7915_mcu_add_he()
       mt76: mt7915: rework .set_bitrate_mask() to support more options
       mt76: mt7915: rework debugfs fixed-rate knob

Shayne Chen (2):
       mt76: mt7915: add WA firmware log support
       mt76: mt7915: add debugfs knobs for MCU utilization

  drivers/net/wireless/mediatek/mt76/eeprom.c          |   5 ++-
  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      |  22 ++++++++++-
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c |   2 +-
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |   1 +
  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c  | 167 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------
  drivers/net/wireless/mediatek/mt76/mt7915/mac.c      |   8 ++--
  drivers/net/wireless/mediatek/mt76/mt7915/main.c     |  34 +++++++++--------
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      | 204 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.h      |  23 ++++++++---
  drivers/net/wireless/mediatek/mt76/mt7915/mmio.c     |   3 ++
  drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h   |  17 +++++----
  drivers/net/wireless/mediatek/mt76/mt7915/regs.h     |  17 +++++++++
  drivers/net/wireless/mediatek/mt76/mt7921/init.c     |   3 +-
  drivers/net/wireless/mediatek/mt76/util.h            |  10 ++---
  14 files changed, 415 insertions(+), 101 deletions(-)
