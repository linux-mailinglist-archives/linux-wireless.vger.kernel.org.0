Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5D36114C22
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2019 06:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfLFFqi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Dec 2019 00:46:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:34608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfLFFqi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Dec 2019 00:46:38 -0500
Received: from localhost.localdomain (unknown [37.26.146.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E746E2245C;
        Fri,  6 Dec 2019 05:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575611197;
        bh=DNXeHOrOy9aL8mc35oSKgWfNzUi9ZxBVnoL9HQBRdZY=;
        h=From:To:Cc:Subject:Date:From;
        b=pDOB8C5JNYzJNpPFfBl9mt8sBzfH10JDGbXqWsUmy1QM4ozW07AlI0pBGoPJJKUra
         8yhC0xRdkcwB+Pa5PKR2Zs7uM6pgmfvuy3JAexDHZBLF62yRxhb11AIlOuDRKBOjTL
         f6YyEhXxLSg4cjr2YX5+aZo4oi+6c8nF/skHbRUo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH v3 0/3] add set_coverage support to mt7615 driver
Date:   Fri,  6 Dec 2019 07:46:22 +0200
Message-Id: <cover.1575609821.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add the capability to configure ack timeout and slottime to mt7615 driver.
Fix coverage_class definition in mt76x02 driver.
Set 0 as minimum configurable value for coverage_class since mt76 does
not support dynack.

Changes since v2:
- rebase on top of mt7615D support (DBDC)
- add DBDC support to mt7615_mac_set_timing

Changes since v1:
- drop patch 2/3 'mt76: move coverage_class and slottime in mt76_dev'
- set 0 as minimum configurable value for coverage_class

Lorenzo Bianconi (3):
  mt76: mt76x02: fix coverage_class type
  mt76: mt7603: set 0 as min coverage_class value
  mt76: mt7615: add set_coverage class support

 .../net/wireless/mediatek/mt76/mt7603/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 61 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 21 +++++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  7 +++
 .../net/wireless/mediatek/mt76/mt7615/regs.h  | 21 +++++++
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  2 +-
 8 files changed, 114 insertions(+), 3 deletions(-)

-- 
2.21.0

