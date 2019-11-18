Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0723100463
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 12:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfKRLj4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 06:39:56 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:37312 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfKRLj4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 06:39:56 -0500
Received: from localhost.localdomain (unknown [141.24.212.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 96088580073;
        Mon, 18 Nov 2019 12:39:54 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v2 0/4] mt76: channel switch support for USB devices
Date:   Mon, 18 Nov 2019 12:39:03 +0100
Message-Id: <20191118113907.9862-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch series adds channel switch support for mt76 usb interfaces.
When testing, I noticed that between 5 or 7 consecutive beacons had the
identical channel switch count set. After some debugging I found out,
that beacon copying over usb took far too long (up to 700ms for one call
of mt76x02u_pre_tbtt_work).

Therefore the first three patches speed up beacon copying and the last
patch enables channel switch support also for usb interfaces.

v2 (thanks for the comments Lorenzo):
* correctly track beacon data mask
* clean-ups
* make channel switch fn static (reported by kbuild test robot)

Markus Theil (4):
  mt76: mt76x02: ommit beacon slot clearing
  mt76: mt76x02: split beaconing
  mt76: speed up usb bulk copy
  mt76: mt76x02: add channel switch support for usb interfaces

 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +-
 .../wireless/mediatek/mt76/mt76x02_beacon.c   | 53 ++++++-------------
 .../net/wireless/mediatek/mt76/mt76x02_mac.h  |  1 +
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  5 ++
 .../wireless/mediatek/mt76/mt76x02_usb_core.c | 12 +++++
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  2 +-
 .../wireless/mediatek/mt76/mt76x2/usb_main.c  |  5 ++
 drivers/net/wireless/mediatek/mt76/usb.c      | 17 +++---
 8 files changed, 52 insertions(+), 45 deletions(-)

--
2.24.0

