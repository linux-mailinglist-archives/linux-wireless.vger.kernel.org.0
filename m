Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3A29AAB2
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2019 10:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391054AbfHWIwW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Aug 2019 04:52:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732355AbfHWIwV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Aug 2019 04:52:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6E2710576EA;
        Fri, 23 Aug 2019 08:52:21 +0000 (UTC)
Received: from localhost (unknown [10.43.2.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 415FA17B46;
        Fri, 23 Aug 2019 08:52:19 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: [PATCH 0/3] mt76: channel switch related cleanups
Date:   Fri, 23 Aug 2019 10:52:14 +0200
Message-Id: <1566550337-6287-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Fri, 23 Aug 2019 08:52:21 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka (3):
  mt76: remove redundant mt76_txq_schedule_all
  mt76: mt76x0: remove redundant chandef copy
  mt76: mt76x0: remove unneeded return value on set channel

 drivers/net/wireless/mediatek/mt76/mt7603/mac.c      |  1 -
 drivers/net/wireless/mediatek/mt76/mt7603/main.c     |  2 --
 drivers/net/wireless/mediatek/mt76/mt7615/main.c     |  1 -
 drivers/net/wireless/mediatek/mt76/mt76x0/main.c     | 15 ++++-----------
 drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h   |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c      |  9 +++------
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c    |  1 -
 drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c |  2 --
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c |  1 -
 9 files changed, 9 insertions(+), 27 deletions(-)

-- 
1.9.3

