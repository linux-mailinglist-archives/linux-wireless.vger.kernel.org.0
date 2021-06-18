Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393B73AC5BE
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 10:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhFRIKn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 04:10:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhFRIKn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 04:10:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E5926120D;
        Fri, 18 Jun 2021 08:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624003714;
        bh=uDM5pmRmbdddcumyPMvp1aR8ZTnwPsc0cL21GPgoKvY=;
        h=From:To:Cc:Subject:Date:From;
        b=E6Tahn1/uI+wm3djWaQumxtY7I9OCCs2WMh5IDSaBqTZDyyk5AXyJOw3PRgq84RR6
         rluTgEruBCpXCT2BSZKtieNppK+KXUOYOSAObRA/VThduM9gI8V9BdGKFsw0TjzWdT
         oQl1HAPFZDgj9oMBWRir5FM27M2nYaJtFgv9mM9cqOyZ50feOtMz5VOqONeSCaD2c4
         3rItIsoBuq3lEOVEuEsLJYB2FZvhcq1L6QA65Yr38O8p12PBZV3E0sjwgOsQvSb19E
         28GznZ+ZmXNxp5J8+WMQjuev+BrYJ6QMUH2UFly2sWHsGklsRVpfiSy9DS2Rg7Ep/n
         w+OpfNQg2p0ZQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH v2 0/5] mt7663s: enable runtime-pm support
Date:   Fri, 18 Jun 2021 10:08:19 +0200
Message-Id: <cover.1624003282.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As already done for mt7663e, introduce runtime-pm support for mt7663s

Changes since v1:
- rebase ontop of wireless-driver-next

Lorenzo Bianconi (5):
  mt76: sdio: do not run mt76_txq_schedule directly
  mt76: mt7663s: rely on pm reference counting
  mt76: mt7663s: rely on mt76_connac_pm_ref/mt76_connac_pm_unref in tx
    path
  mt76: mt7663s: enable runtime-pm
  mt76: mt7615: set macwork timeout according to runtime-pm

 .../wireless/mediatek/mt76/mt7615/debugfs.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 29 ++++++++++----
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 18 +++++----
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  7 +++-
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   |  7 ++--
 .../wireless/mediatek/mt76/mt7615/sdio_mcu.c  | 39 +++++++++++++------
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c | 16 ++++++--
 .../wireless/mediatek/mt76/mt76_connac_mac.c  |  4 +-
 drivers/net/wireless/mediatek/mt76/sdio.c     | 16 +++++---
 9 files changed, 95 insertions(+), 43 deletions(-)

-- 
2.31.1

