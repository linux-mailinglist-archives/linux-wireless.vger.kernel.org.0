Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667F847930D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Dec 2021 18:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239925AbhLQRtA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Dec 2021 12:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239171AbhLQRs7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Dec 2021 12:48:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B868FC061574
        for <linux-wireless@vger.kernel.org>; Fri, 17 Dec 2021 09:48:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D8126235B
        for <linux-wireless@vger.kernel.org>; Fri, 17 Dec 2021 17:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC920C36AE7;
        Fri, 17 Dec 2021 17:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639763338;
        bh=aCjw4RU7woKuP+9sGpoVqFe+KfwXdGRojCL5BXnWneM=;
        h=From:To:Cc:Subject:Date:From;
        b=bfM7P+ZsBmS6gHs0DjjQjiAKENoAbs/2/G0j2JCCAc40V9LysmMmsCbtoq7coTR5R
         GW7cVrmGpmDJZj3cjHknuxDbzvlZXvgENsR9HnoqedW6kjBiufUZeQXA3GfDF5IZIt
         A1666unqP3bEGHjq7W2zjviyqrocE/JnQS5uhlBhg3EB5za6//cQ6IRWD99OuJ3+B5
         XCv2CIFMB4sgXLoGL1talZH2A1C/TLMLFhuMwrd6wCC/N+YtoaV6dCW1Eo1dcG61pO
         67aOzBmoBLEpxmQ/58xp/qYHGA2d9HxRcekRfLhg7KEYemMejDxFcFRlO7U7TFU1Ki
         AfktTGA3lECdw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 0/7] introduce mt76-connac dependency in mt7915 driver
Date:   Fri, 17 Dec 2021 18:48:44 +0100
Message-Id: <cover.1639763123.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt76-connac module dependency in the mt7915 driver and remove
duplicated mcu code.

Lorenzo Bianconi (7):
  mt76: mt7915: rely on mt76_connac_mcu_alloc_sta_req
  mt76: mt7915: rely on  mt76_connac_mcu_alloc_wtbl_req
  mt76: mt7915: rely on mt76_connac_mcu_add_tlv routine
  mt76: connac: move mt76_connac_mcu_get_cipher in common code
  mt76: connac: move mt76_connac_chan_bw in common code
  mt76: mt7915: rely on mt76_connac_get_phy utilities
  mt76: connac: move mt76_connac_mcu_add_key in connac module

 .../net/wireless/mediatek/mt76/mt76_connac.h  |  29 ++
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 118 ++++-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  60 ++-
 .../net/wireless/mediatek/mt76/mt7915/Kconfig |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   5 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 441 ++++--------------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  17 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   9 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 137 +-----
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  10 +-
 10 files changed, 293 insertions(+), 535 deletions(-)

-- 
2.33.1

