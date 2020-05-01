Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9271C10E2
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2020 12:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgEAKg1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 May 2020 06:36:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbgEAKg0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 May 2020 06:36:26 -0400
Received: from lore-desk.lan (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20737206B8;
        Fri,  1 May 2020 10:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588329386;
        bh=fw5xGVqqd2tprPzJsl0T/zAt2VuNqlVmoDfWPZLmlKI=;
        h=From:To:Cc:Subject:Date:From;
        b=17EgoLvUjeytXWPV60EHMWV9rFVCc3oMLPXi4RtFN/9NrHplAbKy53bYb6pEMLukq
         jR332/i40UnCrJakVsRoDJo1hjkqoV74EAjgAs7NAAQzvWqwk1j/OTZazkW2QXVHTu
         7dM/Z5mEvNfBppYJXSbFj5BNvaF7RFfBCSSNG+Xw=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org,
        soul.huang@mediatek.com
Subject: [PATCH 0/7] Introduce WoW support to mt7663 driver
Date:   Fri,  1 May 2020 12:36:10 +0200
Message-Id: <cover.1588329170.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce PM and WoW support to mt7615 driver if it is
running offload firmware

Lorenzo Bianconi (5):
  mt76: mt7615: introduce support for hardware beacon filter
  mt76: mt7615: add WoW support
  mt76: mt7615: introduce PM support
  mt76: mt7615: add gtk rekey offload support
  mt76: mt7615: introduce beacon_loss mcu event

Sean Wang (2):
  mt76: mt7615: introduce mt7615_mcu_set_hif_suspend mcu command
  mt76: mt7663u: introduce suspend/resume to mt7663u

 drivers/net/wireless/mediatek/mt76/mt76.h     |   2 +
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |  37 ++
 .../net/wireless/mediatek/mt76/mt7615/init.c  |   1 +
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |   4 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  87 +++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 353 +++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   | 101 +++++
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |   4 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  12 +
 .../net/wireless/mediatek/mt76/mt7615/pci.c   | 107 ++++++
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  28 +-
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |  43 ++-
 12 files changed, 766 insertions(+), 13 deletions(-)

-- 
2.25.4

