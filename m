Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F311546E8C4
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 14:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbhLINKV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 08:10:21 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:38960 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237546AbhLINKV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 08:10:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 56658CE2557
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 13:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BF6C004DD;
        Thu,  9 Dec 2021 13:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639055204;
        bh=vTl5qsNxQEps9jQJ9/tCRpeWgfNDTTLGGQTJciczFfQ=;
        h=From:To:Cc:Subject:Date:From;
        b=B8jCgOhsxUSistaEHWZOPhXwJKvSSt8QIGbyyeQCla00gEI67AiPb/qVLXhXGkKRs
         7Oxq3C7jyDS+6NtlZ+z+LdR4Nh0iViFWw5l+d8KDMbMJq1n2dt31Th1Cx8GAzHUmq+
         CyqAZS6fxhdrk2tJmupkvqjruXB/Eaw1zCBE5mMHE32dscHT+1Z9L4ikOtIFWFAPPJ
         O+pLidE66Vv7Oafi9DAsekK31qBEHJoeZrJ0Q4o6Smw0uEqf9eXTSZ5CVeX++HU0YF
         6i3REXBjItrcr+RuW1WDGwt2FfNCsmgqclCkfwrLu9r5krEY9uz4TRxM3Z/MjcteTn
         JjE9n8UlzBHJA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: [PATCH 0/7] rework mt76_connac_mcu definitions
Date:   Thu,  9 Dec 2021 14:06:22 +0100
Message-Id: <cover.1639054861.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary series to reuse mt76_connac module in mt7915 driver.

Lorenzo Bianconi (7):
  mt76: connac: introduce MCU_EXT macros
  mt76: connac: align MCU_EXT definitions with 7915 driver
  mt76: connac: remove MCU_FW_PREFIX bit
  mt76: connac: introduce MCU_UNI_CMD macro
  mt76: connac: introduce MCU_CE_CMD macro
  mt76: connac: rely on MCU_CMD macro
  mt76: mt7915: rely on mt76_connac definitions

 .../net/wireless/mediatek/mt76/mt7615/main.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 200 ++---
 .../net/wireless/mediatek/mt76/mt7615/mcu.h   | 127 ---
 .../wireless/mediatek/mt76/mt7615/testmode.c  |   4 +-
 .../wireless/mediatek/mt76/mt7615/usb_mcu.c   |   2 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 111 +--
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 517 +++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  17 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   | 796 +-----------------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  14 -
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   6 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 128 ++-
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   | 128 ---
 .../wireless/mediatek/mt76/mt7921/pci_mcu.c   |   2 +-
 .../wireless/mediatek/mt76/mt7921/sdio_mcu.c  |   2 +-
 .../wireless/mediatek/mt76/mt7921/testmode.c  |   4 +-
 16 files changed, 694 insertions(+), 1368 deletions(-)

-- 
2.31.1

