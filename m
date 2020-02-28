Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC09173851
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Feb 2020 14:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgB1N3d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Feb 2020 08:29:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:42608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgB1N3d (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Feb 2020 08:29:33 -0500
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2B0C2469D;
        Fri, 28 Feb 2020 13:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582896572;
        bh=N1HhoA5niFLImEUJkIA/UpKV9/jr/Pc4uSm3pIi4Vq0=;
        h=From:To:Cc:Subject:Date:From;
        b=a8PY1A9PEVT2dTRCDFQcw/Dvpy2OJR/4ET5XrDd4e0dJyv+EF9zWxSUhQX8AbELrH
         hHA8R7+8fPGUPUVPunY367J4NsyBafXDgnNMzwo4d9BAbfrFXqqPLLyoL5ujCq2hjC
         7p4IbKTpjbusJpMhprenc3HoPdTpntyXjn+qKuR8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com
Subject: [PATCH 0/6] mt7663u preparation series
Date:   Fri, 28 Feb 2020 14:29:21 +0100
Message-Id: <cover.1582893136.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is the first series to rework mt7615 code for mt7663u
driver integration.
This series is based on "Introduce mt7663e support to mt7615 driver"
https://patchwork.kernel.org/cover/11395095/

Lorenzo Bianconi (6):
  mt76: mt7615: introduce mt7663u support to mt7615_write_txwi
  mt76: mt7615: introduce mt7615_mcu_fill_msg
  mt76: mt7615: introduce mt7615_mcu_wait_response
  mt76: mt7615: cleanup fw queue just for mmio devices
  mt76: mt7615: introduce mt7615_init_device routine
  mt76: mt7615: move mt7615_mac_wtbl_addr in mac.h

 .../net/wireless/mediatek/mt76/mt7615/init.c  | 27 ++++----
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 17 +++--
 .../net/wireless/mediatek/mt76/mt7615/mac.h   |  6 ++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 62 ++++++++++++-------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  3 +
 5 files changed, 72 insertions(+), 43 deletions(-)

-- 
2.24.1

