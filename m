Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3BF55A77
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2019 00:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfFYWBl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 18:01:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfFYWBk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 18:01:40 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.61.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C9332080C;
        Tue, 25 Jun 2019 22:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561500100;
        bh=tOzgUk1RBOCQTpHAYWbEhXQf5usxs50Ef2LiyQqBHHY=;
        h=From:To:Cc:Subject:Date:From;
        b=hnjnEqhtULKt8jtbJG4Jtq72n0hJAe2PVPUfEWGuzD+Fbc4gg1FLTpUg2Dt10SYAu
         tZBc9oNXBkM5Jb+sIp6sLexeBwoUXKII8B13iS0HWYJ4McDuS7TcpPyJnC6E4bruK/
         gITnxR644CGeSdlzVVSujUhGeRnpjPiQXEnMRzJE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com, yf.luo@mediatek.com
Subject: [RFC 0/5] add hw dfs pattern detector support to mt7615 driver
Date:   Wed, 26 Jun 2019 00:01:21 +0200
Message-Id: <cover.1561499275.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce radar pattern detection support to mt7615 driver. Please note I have
tested this series just through the radar pattern test knob added to debugfs
and not through I real radar signal generator.
CSA is currently missing (I am currently working on it).
This series is based on 'mt76: move nl80211_dfs_regions in mt76_dev data
structure' https://patchwork.kernel.org/patch/11010723/

Lorenzo Bianconi (5):
  mt76: mt7615: introduce mt7615_regd_notifier
  mt76: mt7615: add hw dfs pattern detector support
  mt76: mt7615: do not perform txcalibration before cac is complited
  mt76: mt7615: unlock dfs bands
  mt76: mt7615: add radar pattern test knob to debugfs

 .../wireless/mediatek/mt76/mt7615/Makefile    |   3 +-
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |  38 ++++++
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  43 +++++--
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  88 +++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   6 +
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 121 ++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  23 ++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  55 ++++++++
 9 files changed, 356 insertions(+), 23 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c

-- 
2.21.0

