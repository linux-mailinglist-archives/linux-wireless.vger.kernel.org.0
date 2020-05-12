Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279CB1CFED3
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 22:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgELUC5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 16:02:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgELUC5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 16:02:57 -0400
Received: from localhost.localdomain.com (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9604F206D6;
        Tue, 12 May 2020 20:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589313776;
        bh=clfINjMJwZMYOtitD9gTt5jgrX1CRjxI2kkywm6EsF4=;
        h=From:To:Cc:Subject:Date:From;
        b=jQUBIrb0ncn3aBhgJCTWzavDoFLC3JBDJzwHp1b9YFuVmSHRMaRqtwqubT642xCF6
         45Rv61gvqhLWkfjMxRcLWQyRg/txBAqqxnMqxYFoqhjqrcc+RZ1tX5DarvBl42wqIi
         VU97s18n7kaoxm/IwtpA8UJqA48XQfo4v+WrQIrY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 0/4] add p2p support to mt76 driver
Date:   Tue, 12 May 2020 22:02:46 +0200
Message-Id: <cover.1589313659.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce p2p support to mt76 driver. Supported modes:
- p2p-go
- p2p-gc
Improve mt7615 hw frequency scanning

Lorenzo Bianconi (3):
  mt76: mt7615: do not report scan_complete twice to mac80211
  mt76: mt7615: reduce hw scan timeout
  mt76: enable p2p support

Sean Wang (1):
  mt76: mt7615: configure bss info adding the interface

 drivers/net/wireless/mediatek/mt76/mac80211.c |   2 +
 .../net/wireless/mediatek/mt76/mt7603/init.c  |   2 +
 .../net/wireless/mediatek/mt76/mt7615/init.c  |   6 +-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  16 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 175 +++++++++++++-----
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   |  27 +++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   2 +
 .../net/wireless/mediatek/mt76/mt76x02_util.c |   4 +
 8 files changed, 176 insertions(+), 58 deletions(-)

-- 
2.26.2

