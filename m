Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1079D35DAA7
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 11:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245036AbhDMJJP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 05:09:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240336AbhDMJJL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 05:09:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 382B4613B2;
        Tue, 13 Apr 2021 09:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618304931;
        bh=BtCfkdC846kD68VrDOZHRC7r5jMMmytCeBdRZ72xq1Q=;
        h=From:To:Cc:Subject:Date:From;
        b=o7SN17H0viIn6WodTi9Zmk5Rgn/8nITgHL49tTVFOU+HJHurIgj7ZtVvIxDatxv07
         Ps76fM6sgb5+AlC0lPMtvN/Uzs/1KwBM3JOPEZRYX8WAR6D5A9lBtsg1ASABeoEWLc
         LvG4+knSl35X1qUe53xqhHAoMoLS9NathcgIFfGh1iydIcfRnlFUFPwzF7Fd8Fhf9V
         CvkAy+PW4pwFr82Aip8cYBH+6vtgUWCIobyvZgLy5OHsIv6Nh9B+THTMK4eun9AS2s
         wAoK5PPUgJYVtJRsUYo1K0gJbDBzAjIt/gDt4hAkYJJFp2UDNZv8d7CyJzBHGuOkbz
         bQmaMlbq9CKZA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: [PATCH v3 0/7] introduce single-sku support for mt7663/mt7921 drivers
Date:   Tue, 13 Apr 2021 11:08:34 +0200
Message-Id: <cover.1618304559.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add per-rate power limitations for 802.11n/802.11ac/802.11ax rates to
mt7663/mt7921 drivers.
Introduce per-rate power limit dts parsing/binding.

Changes since v2:
- add missing properties in mt76 dts schema

Changes since v1:
- drop patch 1/8 and move regdomain property in mt76.yaml
- various power-limits property fixes in mt76.yaml

Felix Fietkau (2):
  mt76: add functions for parsing rate power limits from DT
  mt76: mt7615: implement support for using DT rate power limits

Lorenzo Bianconi (3):
  dt-bindings:net:wireless:mediatek,mt76: introduce power-limits node
  mt76: mt7615: do not use mt7615 single-sku values for mt7663
  mt76: introduce single-sku support for mt7663/mt7921

Sean Wang (1):
  mt76: mt7921: add dumping Tx power table

Shayne Chen (1):
  mt76: extend DT rate power limits to support 11ax devices

 .../bindings/net/wireless/mediatek,mt76.yaml  | 107 +++++++++
 drivers/net/wireless/mediatek/mt76/eeprom.c   | 220 ++++++++++++++++++
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
 14 files changed, 735 insertions(+), 3 deletions(-)

-- 
2.30.2

