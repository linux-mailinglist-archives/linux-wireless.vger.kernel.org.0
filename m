Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A8D48FCCC
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jan 2022 13:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbiAPMn5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jan 2022 07:43:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58660 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiAPMn4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jan 2022 07:43:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81A17B80CBB
        for <linux-wireless@vger.kernel.org>; Sun, 16 Jan 2022 12:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC40AC36AE7;
        Sun, 16 Jan 2022 12:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642337034;
        bh=XV3paZK+vmYKFf8PhlZXcQzH4kxxf2UM4nZbmgChfC0=;
        h=From:To:Cc:Subject:Date:From;
        b=VQ743kjkhKvszxPXRBs9ykByZGrO9u+WesYMqOYDp4IMcrnmKUh9387hStr8pSl4d
         W2J8WTp17gvKYF89u1VFnb8u7mDUHj5mmieZApxKwiwN6S0c3iz5XiqxwmARyrSRMQ
         cGHF+sP69aUNgUD85vrNPKm30FQcgm2m/OqrYjk7x8wGy0IaYHICM2+/HWftwV2Jdb
         /CSO5DamcVZMCzzbwa9AFYGGgpuIabqN35jXid0YrIOVSQzFU12rdk1g7kt5JMvcXu
         x+uc99mgoGWLTSZXjyXJhHQf7s24ePHtC3uWrNIEia4vaXEycu4OdJ1bOZnPuXI915
         Nb7a0Dzj9hmxA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 0/5] move shared mac code in mt76_connac module
Date:   Sun, 16 Jan 2022 13:43:13 +0100
Message-Id: <cover.1642336806.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mac code shared between mt7921 and mt7915 drivers in
mt76_connac_mac.c and remove duplicated code.

Lorenzo Bianconi (5):
  mt76: connac: move mt76_connac_lmac_mapping in mt76-connac module
  mt76: connac: move common mac defs in mt76_connac_mac.h
  mt76: connac: move mt76_connac_reverse_frag0_hdr_trans in common
    module
  mt76: connac: move he radiotap parsing in connac module
  mt76: connac: move mt76_connac_mac_write_txwi in connac module

 .../net/wireless/mediatek/mt76/mt76_connac.h  |  14 +
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 362 ++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mac.h  | 296 +++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 396 +----------------
 .../net/wireless/mediatek/mt76/mt7915/mac.h   | 279 +-----------
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   3 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |   6 -
 .../wireless/mediatek/mt76/mt7915/testmode.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 398 +-----------------
 .../net/wireless/mediatek/mt76/mt7921/mac.h   | 293 +------------
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   3 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   6 -
 12 files changed, 717 insertions(+), 1341 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.h

-- 
2.34.1

