Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05808279A47
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Sep 2020 17:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgIZPGg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Sep 2020 11:06:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIZPGg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Sep 2020 11:06:36 -0400
Received: from localhost.localdomain (unknown [151.66.98.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B687208FE;
        Sat, 26 Sep 2020 15:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601132796;
        bh=nA+ZPf4k58HNbyI/MNZDMPL3ztDv3mRiHnvfZqXa0NE=;
        h=From:To:Cc:Subject:Date:From;
        b=GDy+pa2ApEcM8JDQhGbSAz5P6LC3z2vx1Voyt+xWchpAGt5PNHghyx6uwhKXzA5GW
         1p4yaEFAR4lDXdmVtSB34yZ0SnCYiojCvljyD4SSfLpt1iw3Kdwbdo8iHP3YaDRJ+f
         W/FXnJpRemh4bbxF4PPrPGLn5jW9hVd6qdRvEud8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 0/4] convert mt76 sdio to mt76 workers APIs
Date:   Sat, 26 Sep 2020 17:06:21 +0200
Message-Id: <cover.1601132347.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Convert mt76-sdio/mt7663s tx/rx path to mt76 worker threads APIs.
On mt8183 device, this series improves available throughput of ~60Mbps.

- mt76-sdio tx-rx workqueue: tcp ~ 390Mbps
- mt76-sdio tx-rx workers: tcp ~ 450Mbps

Lorenzo Bianconi (4):
  mt76: mt7663s: move tx/rx processing in the same txrx workqueue
  mt76: mt7663s: convert txrx_work to mt76_worker
  mt76: mt7663s: disable interrupt during txrx_worker processing
  mt76: sdio: convert {status/net}_work to mt76_worker

 drivers/net/wireless/mediatek/mt76/mt76.h     |  13 +-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  |  45 ++++--
 .../wireless/mediatek/mt76/mt7615/sdio_txrx.c | 112 +++++++--------
 drivers/net/wireless/mediatek/mt76/sdio.c     | 130 +++++++++---------
 5 files changed, 154 insertions(+), 148 deletions(-)

-- 
2.26.2

