Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE36D103A98
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 14:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfKTNB4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 08:01:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbfKTNB4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 08:01:56 -0500
Received: from localhost.localdomain.com (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DB432251D;
        Wed, 20 Nov 2019 13:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574254916;
        bh=HD8Qe46FYzeK9en5e1Dd9pM6EMPoYnCCJ/7VyiYkcVs=;
        h=From:To:Cc:Subject:Date:From;
        b=GjInVtSadAVx8JQE5gN8HLbQLpJE5q32VL036/9xdtku8aRMScGZQufcAqFtvrb/G
         fLeZ5McEZZtJBEmwN5Wjkwf43cM9fMn1cDdo7V6Lj2T3DeB+NFTg7I2rLUgDMR330r
         vOQe5S1Trl3JsKb6tr5AeadQB3QSERxWA0H6QPwk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH v2 0/3] add set_coverage support to mt7615 driver
Date:   Wed, 20 Nov 2019 15:01:42 +0200
Message-Id: <cover.1574253996.git.lorenzo@kernel.org>
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

Changes since v1:
- drop patch 2/3 'mt76: move coverage_class and slottime in mt76_dev'
- set 0 as minimum configurable value for coverage_class

Lorenzo Bianconi (3):
  mt76: mt76x02: fix coverage_class type
  mt76: mt7603: set 0 as min coverage_class value
  mt76: mt7615: add set_coverage class support

 .../net/wireless/mediatek/mt76/mt7603/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 41 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 20 +++++++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  7 ++++
 .../net/wireless/mediatek/mt76/mt7615/regs.h  | 21 ++++++++++
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  2 +-
 8 files changed, 93 insertions(+), 3 deletions(-)

-- 
2.21.0

