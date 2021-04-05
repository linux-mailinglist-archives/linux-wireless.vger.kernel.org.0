Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FCD354211
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Apr 2021 14:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbhDEMks (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Apr 2021 08:40:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235289AbhDEMkr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Apr 2021 08:40:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 430126138A;
        Mon,  5 Apr 2021 12:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617626441;
        bh=VGwKEMRXscHQF4KuqMR3R4gFsUkrKP1ak8FE4OoKZUc=;
        h=From:To:Cc:Subject:Date:From;
        b=fDbYnkoepUhsjxGFvpnTC1Nhxna+OSSNCiNNXnJ+dnGvz9r5JnuakqUSOOjeA0MUk
         HomfxNi/fMPnioWbMruHCHTJMvZHzyn7ZaYLErvKr8cZc17XhXXzzjOHytMXWje7rT
         /uRoQalwYUXDNS3ElMt3U48IFBsCQmbfxBdEsdiUT5dhhH0YRN9+5EyIjQsjHooT6+
         vt/O6FVWbvwbMs//A8Ns47Fpbh+R4GQha/HHOP/+NpNaMP793TPcHBKVWZCBVFPhCc
         Muhwfljm1A/8dYIc6Kq/rObMhNs4d1wIH1VekAxSjRWpICGKR1snHHzWTbgU1t0uMU
         FhjUksjvjjvTw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: [PATCH 0/8] introduce single-sku support for mt7663/mt7921 drivers
Date:   Mon,  5 Apr 2021 14:40:24 +0200
Message-Id: <cover.1617625912.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add per-rate power limitations for 802.11n/802.11ac/802.11ax rates to
mt7663/mt7921 drivers.
Introduce per-rate power limit dts parsing/binding.

Felix Fietkau (2):
  mt76: add functions for parsing rate power limits from DT
  mt76: mt7615: implement support for using DT rate power limits

Lorenzo Bianconi (4):
  dt-bindings:net:wireless:ieee80211: introduce regdomain property
  dt-bindings:net:wireless:mediatek,mt76: introduce power-limits node
  mt76: mt7615: do not use mt7615 single-sku values for mt7663
  mt76: introduce single-sku support for mt7663/mt7921

Sean Wang (1):
  mt76: mt7921: add dumping Tx power table

Shayne Chen (1):
  mt76: extend DT rate power limits to support 11ax devices

 .../bindings/net/wireless/ieee80211.yaml      |   9 +
 .../bindings/net/wireless/mediatek,mt76.yaml  |  79 +++++++
 drivers/net/wireless/mediatek/mt76/eeprom.c   | 219 ++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  13 ++
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  15 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   4 +
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  66 +++++-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 133 +++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  24 ++
 .../wireless/mediatek/mt76/mt7921/debugfs.c   |  79 +++++++
 .../net/wireless/mediatek/mt76/mt7921/init.c  |   2 +
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   4 +
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  23 ++
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  17 ++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  31 +++
 15 files changed, 715 insertions(+), 3 deletions(-)

-- 
2.30.2

