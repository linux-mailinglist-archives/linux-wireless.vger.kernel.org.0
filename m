Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A8619C8A2
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 20:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388947AbgDBSTG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 14:19:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388843AbgDBSTF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 14:19:05 -0400
Received: from localhost.localdomain.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E31D8208E0;
        Thu,  2 Apr 2020 18:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585851545;
        bh=JQNh2VJzXoZ8ONdPCKN1JW38u+QpTzmFGYv1i90IxL4=;
        h=From:To:Cc:Subject:Date:From;
        b=UH57ZKYSugJM9LfVoCYkDYrV/eMzPY3Di15TIyX6AO7Ame1mG/Mb+kC0r18yBR74x
         e+gkaaFNlzT8tcGgjegYtloXk4GB+MxbFCI6c0mc1KuVT/2O14MqRHborJnNwh0hsx
         12rXTbE4kQcNr9XDDEBqjQdilwobSFnPfXLecl0E=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/9] add preliminary usb support to mt7615 driver
Date:   Thu,  2 Apr 2020 20:18:47 +0200
Message-Id: <cover.1585851049.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is the first preliminary series to add support to mt7663u driver
This series is based on 'mt7663 driver update'
https://patchwork.kernel.org/cover/11470699/

Lorenzo Bianconi (9):
  mt76: add headroom and tailroom to mt76_mcu_ops data structure
  mt76: mt7615: introduce mt7663u support to mt7615_write_txwi
  mt76: mt7615: introduce mt7615_mac_update_rate_desc routine
  mt76: mt7615: introduce __mt7663_load_firmware routine
  mt76: mt7615: move mt7615_mac_wtbl_addr in mac.h
  mt76: mt76u: rely on mt7622 queue scheme for mt7663u
  mt76: mt7615: rework wtbl key configuration
  mt76: mt7615: introuce mt7615_wtbl_desc data structure
  mt76: mt7615: add address parameter to mt7615_eeprom_init

 drivers/net/wireless/mediatek/mt76/mcu.c      |   9 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |   7 +-
 .../net/wireless/mediatek/mt76/mt7603/mcu.c   |   3 +-
 .../net/wireless/mediatek/mt76/mt7603/mcu.h   |   7 -
 .../wireless/mediatek/mt76/mt7615/eeprom.c    |  12 +-
 .../net/wireless/mediatek/mt76/mt7615/init.c  |   3 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 187 +++++++++---------
 .../net/wireless/mediatek/mt76/mt7615/mac.h   |  33 ++++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  85 ++++----
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |   7 -
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  50 ++++-
 .../net/wireless/mediatek/mt76/mt76x02_mcu.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt76x02_mcu.h  |   6 -
 .../wireless/mediatek/mt76/mt76x02_usb_mcu.c  |   4 +-
 drivers/net/wireless/mediatek/mt76/usb.c      |  15 +-
 15 files changed, 260 insertions(+), 170 deletions(-)

-- 
2.25.1

