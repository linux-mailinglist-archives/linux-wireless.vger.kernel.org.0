Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A02C2E0FF5
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Dec 2020 22:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgLVVxZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Dec 2020 16:53:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:41968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbgLVVxY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Dec 2020 16:53:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF40222AAE;
        Tue, 22 Dec 2020 21:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608673963;
        bh=7kowbfjL5OoqD1iAtdFJlBQkMFagAj3Nmikv0ji2jc4=;
        h=From:To:Cc:Subject:Date:From;
        b=kxtF5LwlRnNni5VHVHA1vZs8OfEPmi094SieZcYgsYYTa3FiV92Pr668PAVsHC+Y5
         uuPC/cSByhJyUFOm7pD+Fnk02MZB9W5l9vE0Yfiq5MGJzYqXSckDZBWGU8M0tn0yDc
         kEvil4Xc0l/yS9dJehe2+v3vTjEbdMxRmlB6WZZRejIOn+lxCpWqt22fMHl0NFzec6
         JQ5MErDaQFY5WOZgdZaknupX05Pz4sfKWIb1Ws9N02X8lPPihDs7VUPxmI+FiH9gqH
         WqqKwUo3Sxm1V+6uUMP6YQ/xtRuhZ/fFVXmb9S2Z1u1CyzNavrMjYYoftkUhn5U1Vt
         CXckUeUndMgGA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7915: fix endianness warning in mt7915_mcu_set_radar_th
Date:   Tue, 22 Dec 2020 22:52:36 +0100
Message-Id: <8a4f5f1c5e9e02418a4652f08194378d4dca1655.1608673792.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following sparse warning in mt7915_mcu_set_radar_th routine:

drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:3154:17: warning: incorrect type in initializer (different base types)
drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:3154:17:    expected unsigned int [usertype] min_pri
drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:3154:17:    got restricted __le32 [usertype]
drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:3155:17: warning: incorrect type in initializer (different base types)
drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:3155:17:    expected unsigned int [usertype] max_pri
drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:3155:17:    got restricted __le32 [usertype]
drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:3162:17: warning: incorrect type in initializer (different base types)
drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:3162:17:    expected unsigned int [usertype] min_stgpr_diff
drivers/net/wireless/mediatek/mt76/mt7915/mcu.c:3162:17:    got restricted __le32 [usertype]

Fixes: cee236e1489ec ("mt76: mt7915: fix endian issues")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 5fdd1a6d32ee..6665a4dc1e98 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3129,8 +3129,8 @@ int mt7915_mcu_set_radar_th(struct mt7915_dev *dev, int index,
 		u8 max_crpn;
 		u8 min_crpr;
 		u8 min_pw;
-		u32 min_pri;
-		u32 max_pri;
+		__le32 min_pri;
+		__le32 max_pri;
 		u8 max_pw;
 		u8 min_crbn;
 		u8 max_crbn;
@@ -3138,7 +3138,7 @@ int mt7915_mcu_set_radar_th(struct mt7915_dev *dev, int index,
 		u8 max_stgpn;
 		u8 min_stgpr;
 		u8 rsv[2];
-		u32 min_stgpr_diff;
+		__le32 min_stgpr_diff;
 	} __packed req = {
 		.tag = cpu_to_le32(0x2),
 		.radar_type = cpu_to_le16(index),
-- 
2.29.2

