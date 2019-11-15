Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3652FE0D0
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 16:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfKOPFv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 10:05:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:59162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbfKOPFv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 10:05:51 -0500
Received: from localhost.localdomain.com (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60B9420674;
        Fri, 15 Nov 2019 15:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573830350;
        bh=YiJHNZUKki+A0+m/hHfk+lzxUXa0acAi6MIvtheJJ90=;
        h=From:To:Cc:Subject:Date:From;
        b=E+iHQIAJ82Fmh3hCbDGCfNk86257w/oeVZWsrEVTCF8ZmgNY5uIdVyQ6y8Q3Dnsqw
         4N0bHwDMXSJwNwhHy91rBSCIyukl6uJ3lvNNVG/2/8pBXd/FOLQjVODAOeyrl2/0xs
         GU2XN2mCNuawFu2m+vaLZvu/vui5a5GKbN5+XzjE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 0/3] add set_coverage support to mt7615 driver
Date:   Fri, 15 Nov 2019 17:05:23 +0200
Message-Id: <cover.1573828743.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add the capability to configure ack timeout and slottime to mt7615 driver.
Move coverage_class and slottime fields to mt76_dev structure.
Fix coverage_class definition in mt76x02 driver

Lorenzo Bianconi (3):
  mt76: mt76x02: fix coverage_class type
  mt76: move coverage_class and slottime in mt76_dev
  mt76: mt7615: add set_coverage class support

 drivers/net/wireless/mediatek/mt76/mt76.h     |  3 ++
 .../net/wireless/mediatek/mt76/mt7603/init.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  6 +--
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  6 +--
 .../wireless/mediatek/mt76/mt7603/mt7603.h    |  3 --
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 41 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 20 +++++++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  4 ++
 .../net/wireless/mediatek/mt76/mt7615/regs.h  | 21 ++++++++++
 drivers/net/wireless/mediatek/mt76/mt76x02.h  |  3 --
 .../net/wireless/mediatek/mt76/mt76x02_util.c | 10 ++---
 12 files changed, 102 insertions(+), 18 deletions(-)

-- 
2.21.0

