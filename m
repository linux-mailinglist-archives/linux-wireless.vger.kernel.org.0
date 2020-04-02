Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9AD919C1A5
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 15:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388386AbgDBNHU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 09:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388174AbgDBNHU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 09:07:20 -0400
Received: from localhost.localdomain.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A48DA20678;
        Thu,  2 Apr 2020 13:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585832840;
        bh=XwkzWyQAHMPvEqxV6v3rSr8+Yfh2Z51AJtPO4jEazP4=;
        h=From:To:Cc:Subject:Date:From;
        b=2mbtA3ZPBQeR+CQisUDPvIUOmQEQzECgZX63i6x7bYsPhjaH1I2OjgPUUniRN6rzv
         CM6N0B5Zp5Ov+4VUkGONqAOq+xMOi0vsQzmeVwKWClMSwUD35Exaaj8WgIrjP9g0wc
         KYXpWu5lCENUuRBk9uiXCrpMfzGDHH+sjgZQ+f78=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 00/12] mt7663 driver update
Date:   Thu,  2 Apr 2020 15:06:30 +0200
Message-Id: <cover.1585832458.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series add the following new features to mt7663e driver:
- hw scan
- scheduled scan
- noise floor estimation

Moreover it fixes some hw configuration issues

Lorenzo Bianconi (9):
  mt76: mt7663: fix mt7615_mac_cca_stats_reset routine
  mt76: mt7663: enable nf estimation
  mt76: mt7615: make scs configurable per chain
  mt76: mt7663: disable RDD commands
  mt76: mt7615: add ethool support to mt7663 driver
  mt76: mt7615: introduce mt7615_mcu_set_channel_domain mcu command
  mt76: mt7615: introduce hw scan support
  mt76: mt7615: introduce scheduled scan support
  mt76: mt7615: introduce rlm tlv in bss_info mcu command

Sean Wang (3):
  mt76: mt7663: keep Rx filters as the default
  mt76: mt7615: introduce BSS absence event
  mt76: mt7615: removing unnecessary register operations

 drivers/net/wireless/mediatek/mt76/mt76.h     |   2 +
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |   8 +-
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  45 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  76 +--
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  86 +++-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 434 +++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   | 143 +++++-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  36 +-
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |   3 +
 9 files changed, 767 insertions(+), 66 deletions(-)

-- 
2.25.1

