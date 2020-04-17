Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295D51ADBE9
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 13:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgDQLK1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 07:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729980AbgDQLK0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 07:10:26 -0400
Received: from lore-desk.lan (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4F4521D95;
        Fri, 17 Apr 2020 11:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587121826;
        bh=4936VAXG2ihnvrFd3w/Jj8vJA1l/7HTejQkxrR8U5rg=;
        h=From:To:Cc:Subject:Date:From;
        b=RHv6VAP3GA7e+iBaiaQkQiKctIKqB65S2P5vsb8ljaYdnTcFiSPAP4qWg7msSb8b3
         EAU6dt9iviDa/qEiT4tfw/KxpxBR5XBNjNNAjq6nwm8ZO6/GXhaXXHcyTLKanYsYAW
         koOwdBApeRGAu/S2QzZFhYVqPNGTnCHFsTjAMMmo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 0/3] add 802.11 ps support to mt7663 driver
Date:   Fri, 17 Apr 2020 13:10:03 +0200
Message-Id: <cover.1587121517.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce 802.11 power-save support for mt7663 station mode
enabling ps firmware support

Lorenzo Bianconi (3):
  mt76: mt7615: provide aid info to the mcu
  mt76: remove PS_NULLFUNC_STACK capability
  mt76: mt7663: introduce 802.11 PS support in sta mode

 drivers/net/wireless/mediatek/mt76/mac80211.c |  1 -
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  4 +++
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  7 ++++--
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 23 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 25 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  1 +
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  4 +++
 .../wireless/mediatek/mt76/mt7615/pci_init.c  |  8 ++++--
 .../wireless/mediatek/mt76/mt7615/usb_init.c  |  3 +++
 10 files changed, 71 insertions(+), 6 deletions(-)

-- 
2.25.2

